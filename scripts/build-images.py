"""Regenerate every figure of the notes from the matplotlib scripts.

Each note keeps its drawing scripts in ``<subject>/<note>/scripts/*.py`` and
writes the resulting files into ``<subject>/<note>/img/``.  This tool walks the
whole repository, previews what already exists and what would be produced, and
then runs the scripts.

Modes
-----
    uv run scripts/build-images.py                  interactive
    uv run scripts/build-images.py --dry-run        preview only
    uv run scripts/build-images.py --overwrite      rebuild everything
    uv run scripts/build-images.py --skip-existing  only fill in what is missing
    uv run scripts/build-images.py --note "<subject>/<note>" [--overwrite]

Options
-------
    --note PATH     restrict to a single note
    --verbose       list every file in the preview
"""

from __future__ import annotations

import argparse
import ast
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
IMAGE_RE = re.compile(r'image\(\s*"([^"]+)"')
IMAGE_EXT = (".svg", ".png", ".pdf", ".jpg", ".jpeg")


def strings_in(node):
    values, dynamic = [], False
    for sub in ast.walk(node):
        if isinstance(sub, ast.Constant) and isinstance(sub.value, str):
            values.append(sub.value)
        elif isinstance(sub, ast.JoinedStr):
            dynamic = True
    return values, dynamic


def script_outputs(path: Path):
    """Image file names (lower case) that a script declares as output."""
    text = path.read_text(encoding="utf-8", errors="replace")
    try:
        tree = ast.parse(text)
    except SyntaxError:
        return set(), set(), text

    names, stems = set(), set()

    def record(value):
        base = Path(value).name.strip()
        if not base:
            return
        if base.lower().endswith(IMAGE_EXT):
            names.add(base.lower())
        elif "/" not in base and "\\" not in base:
            stems.add(base.lower())

    for node in ast.walk(tree):
        if isinstance(node, ast.Call):
            func = node.func
            name = getattr(func, "attr", None) or getattr(func, "id", None)
            if name in ("savefig", "save"):
                for arg in node.args:
                    for value in strings_in(arg)[0]:
                        record(value)
        elif isinstance(node, ast.Assign):
            for value in strings_in(node.value)[0]:
                record(value)
    return names, stems, text


def note_entries():
    """[(note_dir, [(script, [image names])])] for every note with scripts."""
    entries = []
    for typ in sorted(ROOT.glob("*/*/initial.typ")):
        note = typ.parent
        if not re.match(r"^\d\.", note.parent.name):
            continue
        scripts_dir = note / "scripts"
        if not scripts_dir.is_dir():
            continue

        wanted = []
        text = typ.read_text(encoding="utf-8", errors="replace")
        for m in IMAGE_RE.finditer(text):
            wanted.append(Path(m.group(1)).name.lower())

        pairs = []
        for py in sorted(scripts_dir.glob("*.py")):
            if py.name.startswith("_"):
                continue
            names, stems, source = script_outputs(py)
            produced = []
            for image in wanted:
                stem = Path(image).stem
                if image in names or stem in stems:
                    produced.append(image)
                elif not names and not stems and py.stem.replace("_", "-") == stem:
                    produced.append(image)
            if produced:
                pairs.append((py, produced, "../img" in source))
        if pairs:
            entries.append((note, pairs))
    return entries


def preview(entries, verbose):
    total_scripts = total_images = existing = 0
    for note, pairs in entries:
        have = missing = 0
        seen, lines = set(), []
        for py, images, _ in pairs:
            for image in images:
                if image in seen:
                    continue
                seen.add(image)
                if (note / "img" / image).exists():
                    have += 1
                    lines.append(f"      [exists] {image}  <- {py.name}")
                else:
                    missing += 1
                    lines.append(f"      [new   ] {image}  <- {py.name}")
        total_scripts += len(pairs)
        total_images += have + missing
        existing += have
        print(f"  {note.relative_to(ROOT).as_posix():<46} "
              f"脚本 {len(pairs):>2}  插图 {have + missing:>3} "
              f"(已存在 {have}, 缺失 {missing})")
        if verbose:
            for line in lines:
                print(line)
    print(f"\n合计：{len(entries)} 本笔记，{total_scripts} 个脚本，"
          f"{total_images} 张插图；已存在 {existing}，"
          f"缺失 {total_images - existing}")
    return total_images - existing


def run(entries, skip_existing, verbose):
    done = skipped = 0
    failures = []
    for note, pairs in entries:
        rel = note.relative_to(ROOT).as_posix()
        for py, images, relative_img in pairs:
            if skip_existing and all((note / "img" / i).exists() for i in images):
                skipped += len(images)
                if verbose:
                    print(f"  skip  {rel}/{py.name}")
                continue
            cwd = py.parent if relative_img else ROOT
            result = subprocess.run([sys.executable, str(py)], cwd=cwd,
                                    capture_output=True, text=True)
            if result.returncode == 0:
                done += len(images)
                if verbose:
                    print(f"  ok    {rel}/{py.name}")
            else:
                tail = (result.stderr or result.stdout or "").strip().splitlines()
                failures.append((f"{rel}/{py.name}", tail[-3:]))
                print(f"  FAIL  {rel}/{py.name}")
    return done, skipped, failures


def main(argv=None):
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")

    parser = argparse.ArgumentParser(description="递归生成所有插图")
    parser.add_argument("--note", help="只处理指定笔记，如 '3.Géométrie/Géométrie Analytique'")
    parser.add_argument("--dry-run", action="store_true", help="只预览，不执行")
    group = parser.add_mutually_exclusive_group()
    group.add_argument("--overwrite", action="store_true", help="覆盖已有图片")
    group.add_argument("--skip-existing", action="store_true", help="跳过已有图片")
    parser.add_argument("--verbose", action="store_true", help="列出每张图片")
    args = parser.parse_args(argv)

    entries = note_entries()
    if args.note:
        key = args.note.replace("\\", "/").strip("/")
        entries = [(n, p) for n, p in entries
                   if n.relative_to(ROOT).as_posix() == key]
        if not entries:
            print(f"没有找到笔记：{args.note}")
            return 1

    print(f"仓库根目录：{ROOT}")
    print("扫描结果：\n")
    missing = preview(entries, args.verbose)

    if args.dry_run:
        print("\n（--dry-run：未执行任何脚本）")
        return 0

    if args.overwrite:
        skip_existing = False
        mode = "覆盖已有图片"
    elif args.skip_existing:
        skip_existing = True
        mode = "跳过已有图片"
    else:
        if missing == 0:
            print("\n所有插图都已存在。")
            answer = input("覆盖已有(o) / 跳过已有(s) / 退出(q) [s]: ").strip().lower()
        else:
            answer = input("\n开始生成(b) / 只补缺失(m) / 退出(q) [b]: ").strip().lower()
        if answer in ("q", "quit"):
            return 0
        if missing == 0:
            if answer == "o":
                skip_existing, mode = False, "覆盖已有图片"
            elif answer in ("s", ""):
                print("没有需要生成的文件。")
                return 0
            else:
                print("已取消。")
                return 0
        else:
            if answer == "m":
                skip_existing, mode = True, "跳过已有图片"
            elif answer in ("b", ""):
                skip_existing, mode = False, "覆盖已有图片"
            else:
                print("已取消。")
                return 0

    print(f"\n模式：{mode}\n")
    done, skipped, failures = run(entries, skip_existing, args.verbose)

    print(f"\n完成：生成/覆盖 {done} 张，跳过 {skipped} 张，"
          f"失败脚本 {len(failures)} 个")
    for name, tail in failures:
        print(f"  {name}")
        for line in tail:
            print(f"      {line}")
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
