"""Typst 数学公式常见缺陷的校验与修复脚本。

默认**只检查**：列出命中片段与建议写法，不碰文件。
加 `--fix` 才写回，并且只做可机械推导的替换（paren、brace）；
`macro` 一类只能靠人判断的项始终只报告。

推荐流程：先跑检查 → 人工确认报告无误 → 再加 `--fix`。

内置检查项（可用 --check 选择）：

    paren   [_^][a-zA-Z]+(      下/上标后紧跟括号，括号会被吞进上下标
                                例：L^oo(Omega) 渲染成 L^{oo(Omega)}
                                建议：L^(oo)(Omega)          —— 可自动修
    brace   [_^]{               LaTeX 花括号残留，Typst 中会按字面渲染
                                例：a_{i j}(x) 渲染出可见的 {i j}
                                建议：a_(i j)(x)             —— 可自动修
    macro   \\left \\cdot \\int …   LaTeX 宏残留              —— 只报告，需人工改写

用法（在仓库根执行）：

    uv run scripts/check-typst-attachments.py                    # 全仓库只检查
    uv run scripts/check-typst-attachments.py 1.Analyse          # 只扫指定目录
    uv run scripts/check-typst-attachments.py --check paren      # 只跑一项
    uv run scripts/check-typst-attachments.py --summary          # 只看每文件条数
    uv run scripts/check-typst-attachments.py --include-comments # 连注释一起报
    uv run scripts/check-typst-attachments.py --fix              # 确认后写回

退出码：检查模式有命中为 1，无命中为 0；修复模式恒为 0（须用检查模式复核）。
"""

import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

SKIP_DIRS = {".git", ".venv", "node_modules", "__pycache__", "tmp"}


def plan_paren(match, line):
    """_{name}( → _(name)(，返回 (start, end, 新文本)。"""
    return match.start(), match.end(), f"{match['sig']}({match['name']})("


def plan_brace(match, line):
    """_{name} → _(name)；同一行找不到闭合花括号时返回 None（留给人工）。"""
    close = line.find("}", match.end())
    if close < 0:
        return None
    return match.start(), close + 1, f"{match['sig']}({line[match.end():close]})"


CHECKS = {
    "paren": {
        "title": "下/上标后紧跟括号（括号被吞进上下标）",
        "pattern": re.compile(r"(?P<sig>[_^])(?P<name>[a-zA-Z]+)\("),
        "plan": plan_paren,
        "fixable": True,
    },
    "brace": {
        "title": "LaTeX 花括号残留（Typst 按字面渲染）",
        "pattern": re.compile(r"(?P<sig>[_^])\{"),
        "plan": plan_brace,
        "fixable": True,
    },
    "macro": {
        "title": "LaTeX 宏残留",
        "pattern": re.compile(
            r"\\(?:left|right|cdot|times|int|iint|iiint|infty|partial|nabla"
            r"|pm|mp|cdots|ldots|dots|leq|geq|neq|approx|equiv|to|mapsto)\b"
        ),
        "plan": None,
        "fixable": False,
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


def read_lines(path):
    """按原样读入行（保留各行的 CRLF/LF 结尾），失败时返回 None。"""
    try:
        with path.open(encoding="utf-8", newline="") as handle:
            return handle.read().splitlines(keepends=True)
    except (OSError, UnicodeDecodeError) as exc:
        print(f"跳过 {path}: {exc}", file=sys.stderr)
        return None


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


def analyze(path, names, include_comments):
    """返回 (行列表, 命中列表)；命中含 (行号, 列号, 检查项, 命中文本, 建议, 替换方案, 行文本, 是否注释)。"""
    lines = read_lines(path)
    if lines is None:
        return None, []

    hits = []
    for number, raw in enumerate(lines, start=1):
        body = raw.rstrip("\r\n")
        limit = comment_index(body)
        for name in names:
            for match in CHECKS[name]["pattern"].finditer(body):
                in_comment = match.start() >= limit
                if in_comment and not include_comments:
                    continue
                plan = CHECKS[name]["plan"](match, body) if CHECKS[name]["plan"] else None
                suggestion = plan[2] if plan else "需人工改写（脚本不猜）"
                hits.append((number, match.start() + 1, name, match.group(0), suggestion, plan, body, in_comment))
    return lines, hits


def report(hits, shown_path, summary):
    """打印一个文件的命中片段。"""
    if summary:
        print(f"{len(hits):5}  {shown_path}")
        return
    print(f"\n{shown_path}")
    for line_no, column, name, matched, suggestion, plan, line, in_comment in hits:
        shown, start, end = clip(line, column - 1, column - 1 + len(matched))
        tag = f" [{name}{', comment' if in_comment else ''}{', 不可自动修' if plan is None else ''}]"
        print(f"  {line_no}:{column}{tag}")
        print(f"    {shown.rstrip()}")
        print(f"    {' ' * start}{'^' * max(1, end - start)}  {matched}  →  {suggestion}")


def fix_file(path, lines, hits, shown_path):
    """把可机械推导的替换写回文件，返回 (已修条数, 人工待办条数)。"""
    edits = {}
    manual = 0
    for line_no, column, name, matched, suggestion, plan, line, in_comment in hits:
        if plan is None:
            manual += 1
            continue
        edits.setdefault(line_no, []).append((plan[0], plan[1], plan[2], name, matched))

    if not edits:
        return 0, manual

    print(f"\n{shown_path}")
    applied = 0
    for line_no, items in sorted(edits.items()):
        raw = lines[line_no - 1]
        body = raw.rstrip("\r\n")
        ending = raw[len(body):]
        # 从右往左替换，避免前面的替换移动后面命中处的下标
        for start, end, replacement, name, matched in sorted(items, reverse=True):
            body = body[:start] + replacement + body[end:]
        for start, end, replacement, name, matched in sorted(items):
            print(f"  {line_no}:{start + 1} [{name}]  {matched}  →  {replacement}")
            applied += 1
        lines[line_no - 1] = body + ending

    with path.open("w", encoding="utf-8", newline="") as handle:
        handle.write("".join(lines))
    return applied, manual


def main():
    if hasattr(sys.stdout, "reconfigure"):
        # 路径含法语重音字符，避免在非 UTF-8 控制台报编码错误
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")

    parser = argparse.ArgumentParser(
        description="校验（默认只读）或修复 .typ 中的上下标括号、LaTeX 花括号与宏残留。",
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
    parser.add_argument(
        "--fix",
        action="store_true",
        help="写回可机械推导的替换（paren、brace）；macro 仍需人工",
    )
    args = parser.parse_args()

    names = args.check or list(CHECKS)
    total = 0
    manual_total = 0
    fixed_total = 0
    failed = 0
    per_check = {name: 0 for name in names}
    touched = []

    for path in iter_typ_files(args.paths or ["."]):
        lines, hits = analyze(path, names, args.include_comments)
        if lines is None:
            failed += 1
            continue
        if not hits:
            continue
        shown_path = path.relative_to(ROOT) if path.is_relative_to(ROOT) else path
        touched.append(shown_path)
        total += len(hits)
        for name in names:
            per_check[name] += sum(1 for hit in hits if hit[2] == name)

        if args.fix:
            fixed, manual = fix_file(path, lines, hits, shown_path)
            fixed_total += fixed
            manual_total += manual
        else:
            report(hits, shown_path, args.summary)

    if args.fix:
        print(f"\n已修改 {fixed_total} 处，涉及 {len(touched)} 个文件；另有 {manual_total} 处需人工处理")
        if manual_total:
            print("需人工的部分请重跑检查并逐条阅读片段。")
        print("建议随后重新编译，再用默认（检查）模式复核一遍。")
        return 1 if failed else 0

    print()
    print(f"共 {total} 处命中，涉及 {len(touched)} 个文件")
    for name, count in per_check.items():
        print(f"  {name:6} {count:4}  {CHECKS[name]['title']}")
    if total:
        print("以上仅为报告，未修改任何文件；确认无误后可加 --fix 写回。")
    return 1 if total or failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
