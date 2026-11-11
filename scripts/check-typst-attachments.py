"""Typst 数学公式常见缺陷的只读校验脚本。

只报告命中的片段与建议写法，**绝不修改文件**：正则难免误伤，
是否改写由人工判断。

内置检查项（可用 --check 选择）：

    paren   [_^][a-zA-Z]+(      下/上标后紧跟括号，括号会被吞进上下标
                                例：L^oo(Omega) 渲染成 L^{oo(Omega)}
                                建议：L^(oo)(Omega)
    brace   [_^]{               LaTeX 花括号残留，Typst 中会按字面渲染
                                例：a_{i j}(x) 渲染出可见的 {i j}
                                建议：a_(i j)(x)
    macro   \\left \\cdot \\int …   LaTeX 宏残留
                                例：\\int_0^1 f 渲染成斜杠加 int

用法（在仓库根执行）：

    uv run scripts/check-typst-attachments.py                    # 全仓库 *.typ
    uv run scripts/check-typst-attachments.py 1.Analyse          # 只扫指定目录
    uv run scripts/check-typst-attachments.py --check paren      # 只跑一项
    uv run scripts/check-typst-attachments.py --include-comments # 连注释一起报

退出码：有命中为 1，无命中为 0。
"""

import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

SKIP_DIRS = {".git", ".venv", "node_modules", "__pycache__", "tmp"}

def suggest_brace(match, line):
    """把 _{n=1} 之类的 LaTeX 写法还原成 _(n=1)，缺闭合括号时只给左括号。"""
    sig = match["sig"]
    tail = line[match.end():]
    close = tail.find("}")
    if close < 0:
        return f"{sig}( … )"
    return f"{sig}({tail[:close]})"


CHECKS = {
    "paren": {
        "title": "下/上标后紧跟括号（括号被吞进上下标）",
        "pattern": re.compile(r"(?P<sig>[_^])(?P<name>[a-zA-Z]+)\("),
        "suggest": lambda match, line: f"{match['sig']}({match['name']})(",
    },
    "brace": {
        "title": "LaTeX 花括号残留（Typst 按字面渲染）",
        "pattern": re.compile(r"(?P<sig>[_^])\{"),
        "suggest": suggest_brace,
    },
    "macro": {
        "title": "LaTeX 宏残留",
        "pattern": re.compile(
            r"\\(?:left|right|cdot|times|int|iint|iiint|infty|partial|nabla"
            r"|pm|mp|cdots|ldots|dots|leq|geq|neq|approx|equiv|to|mapsto)\b"
        ),
        "suggest": lambda match, line: "改用 Typst 符号，见 violet-typst-writing-conventions",
    },
}


def iter_typ_files(targets):
    """展开命令行目标为 *.typ 文件列表，跳过 VCS/虚拟环境/临时目录。"""
    for target in targets:
        path = (ROOT / target).resolve() if not Path(target).is_absolute() else Path(target)
        if path.is_file():
            if path.suffix == ".typ":
                yield path
            continue
        for file in sorted(path.rglob("*.typ")):
            if not any(part in SKIP_DIRS for part in file.parts):
                yield file


def comment_index(line):
    """返回行内 // 注释起点（无注释返回 len(line)）。"""
    mark = line.find("//")
    return mark if mark >= 0 else len(line)


def clip(line, start, end, width=130):
    """把过长的行截成以命中处为中心的窗口。"""
    if len(line) <= width:
        return line, start, end
    left = max(0, start - width // 3)
    right = min(len(line), left + width)
    left = max(0, right - width)
    prefix = "…" if left > 0 else ""
    return prefix + line[left:right], start - left + len(prefix), end - left + len(prefix)


def scan(path, names, include_comments):
    """扫描单个文件，返回 [(line_no, column, check, matched, suggestion, line, in_comment)]。"""
    try:
        text = path.read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError) as exc:
        print(f"跳过 {path}: {exc}", file=sys.stderr)
        return []

    hits = []
    for number, line in enumerate(text.splitlines(), start=1):
        limit = comment_index(line)
        for name in names:
            for match in CHECKS[name]["pattern"].finditer(line):
                in_comment = match.start() >= limit
                if in_comment and not include_comments:
                    continue
                hits.append(
                    (
                        number,
                        match.start() + 1,
                        name,
                        match.group(0),
                        CHECKS[name]["suggest"](match, line),
                        line,
                        in_comment,
                    )
                )
    return hits


def main():
    if hasattr(sys.stdout, "reconfigure"):
        # 路径含法语重音字符，避免在非 UTF-8 控制台报编码错误
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")

    parser = argparse.ArgumentParser(
        description="只读校验 .typ 中的上下标括号、LaTeX 花括号与宏残留。",
    )
    parser.add_argument("paths", nargs="*", default=["."], help="要扫描的文件或目录，默认全仓库")
    parser.add_argument(
        "--check",
        action="append",
        choices=sorted(CHECKS),
        help="只运行指定检查项，可重复；默认全部",
    )
    parser.add_argument(
        "--include-comments",
        action="store_true",
        help="把 // 注释里的命中一并报告（默认跳过）",
    )
    parser.add_argument(
        "--summary",
        action="store_true",
        help="只输出每个文件的命中条数与汇总，不打印片段",
    )
    args = parser.parse_args()

    names = args.check or list(CHECKS)
    total = 0
    per_check = {name: 0 for name in names}
    touched = []

    for path in iter_typ_files(args.paths or ["."]):
        hits = scan(path, names, args.include_comments)
        if not hits:
            continue
        touched.append(path)
        shown_path = path.relative_to(ROOT) if path.is_relative_to(ROOT) else path
        if args.summary:
            print(f"{len(hits):5}  {shown_path}")
            total += len(hits)
            for name in names:
                per_check[name] += sum(1 for hit in hits if hit[2] == name)
            continue
        print(f"\n{shown_path}")
        for line_no, column, name, matched, suggestion, line, in_comment in hits:
            shown, start, end = clip(line, column - 1, column - 1 + len(matched))
            tag = f" [{name}{', comment' if in_comment else ''}]"
            print(f"  {line_no}:{column}{tag}")
            print(f"    {shown.rstrip()}")
            print(f"    {' ' * start}{'^' * max(1, end - start)}  {matched}  →  {suggestion}")
            total += 1
            per_check[name] += 1

    print()
    print(f"共 {total} 处命中，涉及 {len(touched)} 个文件")
    for name, count in per_check.items():
        print(f"  {name:6} {count:4}  {CHECKS[name]['title']}")
    if total:
        print("以上仅为报告，脚本不修改任何文件。")
    return 1 if total else 0


if __name__ == "__main__":
    raise SystemExit(main())
