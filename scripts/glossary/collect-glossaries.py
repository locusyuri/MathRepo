"""Collect every Glossary entry from the notes into a repo-wide term index.

Usage (run from the repository root):

    uv run scripts/glossary/collect-glossaries.py --stats
    uv run scripts/glossary/collect-glossaries.py --defs-only
    uv run scripts/glossary/collect-glossaries.py --write README.md

The script reads every ``*/initial.typ`` that contains a ``= Glossary`` section,
extracts ``- *#link(<prefix:label>)[Display Name]*`` entries, and groups them by
first letter.  When ``--write README.md`` is used, the existing
``# Term Index | 术语索引`` section is replaced; manually curated Chinese
translations in the old section are kept when the English term matches.
"""

from __future__ import annotations

import argparse
import re
import sys
import unicodedata
from collections import defaultdict
from pathlib import Path

ROOT = Path.cwd()

GLOSSARY_RE = re.compile(r"^= Glossary\b.*$", re.M)
HEADING_RE = re.compile(r"^= ")
LETTER_RE = re.compile(r"^==\s+([A-Z])\s*$")
ENTRY_RE = re.compile(r"^- \*#link\(<([a-z]+):[^>]+>\)\[(.*)\]\*\s*$")
README_ENTRY_RE = re.compile(r"^- \*\*(.+?)\*\*\s*\|\s*(.*)$")

MATH_WORDS = {
    "bb(R)": "R",
    "bb(N)": "N",
    "bb(Z)": "Z",
    "bb(Q)": "Q",
    "bb(C)": "C",
    "cal(L)": "L",
    "cal(B)": "B",
    "cal(S)": "S",
    "oo": "∞",
    "infty": "∞",
    "sigma": "σ",
    "Sigma": "Σ",
    "delta": "δ",
    "Delta": "Δ",
    "epsilon": "ε",
    "alpha": "α",
    "beta": "β",
    "gamma": "γ",
    "lambda": "λ",
    "Lambda": "Λ",
    "mu": "μ",
    "nu": "ν",
    "pi": "π",
    "rho": "ρ",
    "tau": "τ",
    "phi": "φ",
    "Phi": "Φ",
    "omega": "ω",
    "Omega": "Ω",
}

CYR_FIRST = {"Е": "E", "Л": "L", "М": "M", "П": "P", "С": "S", "Т": "T"}


def clean_term(term: str) -> str:
    """Turn a Typst glossary display name into readable Markdown text."""
    s = term

    def math_part(match: re.Match[str]) -> str:
        m = match.group(1)
        for src, dst in MATH_WORDS.items():
            m = m.replace(src, dst)
        m = re.sub(r"_\(([^()]*)\)", r"_\1", m)
        m = re.sub(r"\^\(([^()]*)\)", r"^\1", m)
        m = m.replace("{", "").replace("}", "")
        m = m.replace("$", "")
        m = re.sub(r"\b(quad|dot|times)\b", " ", m)
        return m

    s = re.sub(r"\$([^$]*)\$", math_part, s)
    s = s.replace("$", "")
    s = s.replace("\\", "")
    s = re.sub(r"\s+", " ", s).strip()
    return s


def term_key(term: str) -> str:
    s = clean_term(term)
    s = unicodedata.normalize("NFKD", s)
    s = "".join(c for c in s if not unicodedata.combining(c))
    s = s.lower()
    s = re.sub(r"[^a-z0-9]+", "", s)
    return s


def note_name(path: Path) -> str:
    return path.parent.name


def iter_notes() -> list[Path]:
    notes = []
    for path in ROOT.glob("*/**/initial.typ"):
        if any(part in {"tmp", "TypstTemplate", ".git"} for part in path.parts):
            continue
        if GLOSSARY_RE.search(path.read_text(encoding="utf-8")):
            notes.append(path)
    return sorted(notes)


def collect(path: Path, types: set[str]) -> tuple[list[tuple[str, str, str]], int]:
    """Return (letter, display, note) tuples and the number of skipped entries."""
    text = path.read_text(encoding="utf-8")
    lines = text.splitlines()
    m = GLOSSARY_RE.search(text)
    if not m:
        return [], 0
    start = text.count("\n", 0, m.start())
    entries = []
    skipped = 0
    letter = "#"
    for line in lines[start + 1 :]:
        if HEADING_RE.match(line):
            break
        lm = LETTER_RE.match(line)
        if lm:
            letter = lm.group(1)
            continue
        em = ENTRY_RE.match(line)
        if not em:
            continue
        prefix, display = em.group(1), em.group(2)
        if prefix not in types:
            skipped += 1
            continue
        entries.append((letter, clean_term(display), note_name(path)))
    return entries, skipped


def parse_existing(readme: Path) -> dict[str, dict]:
    """Read the current Term Index, preserving Chinese translations."""
    if not readme.exists():
        return {}
    text = readme.read_text(encoding="utf-8")
    start = text.find("# Term Index | 术语索引")
    if start < 0:
        return {}
    end = text.find("\n------", start)
    section = text[start:] if end < 0 else text[start:end]
    existing = {}
    for line in section.splitlines():
        rm = README_ENTRY_RE.match(line.strip())
        if not rm:
            continue
        label, notes = rm.group(1).strip(), rm.group(2).strip()
        chinese = None
        cm = re.match(r"^(.*?)\s*\(([^()]*)\)\s*$", label)
        if cm and re.search(r"[\u4e00-\u9fff]", cm.group(2)):
            label, chinese = cm.group(1).strip(), cm.group(2).strip()
        key = term_key(label)
        if not key:
            continue
        existing[key] = {
            "display": label,
            "chinese": chinese,
            "notes": [n.strip() for n in notes.split(",") if n.strip()],
        }
    return existing


def first_letter(display: str, fallback: str) -> str:
    s = clean_term(display)
    for ch in s:
        if ch.isalpha():
            if ch in CYR_FIRST:
                return CYR_FIRST[ch]
            normalized = unicodedata.normalize("NFKD", ch)
            base = "".join(c for c in normalized if not unicodedata.combining(c))
            if base.isascii() and base.isalpha():
                return base.upper()
            break
    return fallback


def render(entries: dict[str, dict]) -> str:
    groups: dict[str, list[tuple[str, str]]] = defaultdict(list)
    for key, item in entries.items():
        display = item["display"]
        letter = first_letter(display, item["letter"])
        groups[letter].append((key, display))

    lines = ["# Term Index | 术语索引"]
    for letter in sorted(groups):
        lines.append(f"## {letter}")
        for key, display in sorted(groups[letter], key=lambda x: x[0]):
            item = entries[key]
            notes = ", ".join(item["notes"])
            if item["chinese"]:
                label = f"{display} ({item['chinese']})"
            else:
                label = display
            if any(ch in display for ch in "_^\\"):
                label = f"`{display}`" + (f" ({item['chinese']})" if item["chinese"] else "")
            lines.append(f"- **{label}** | {notes}")
        lines.append("")
    return "\n".join(lines).rstrip() + "\n"


def update_readme(readme: Path, section: str) -> None:
    text = readme.read_text(encoding="utf-8")
    start = text.find("# Term Index | 术语索引")
    if start < 0:
        raise SystemExit("README does not contain a '# Term Index | 术语索引' section")
    end = text.find("\n------", start)
    if end < 0:
        raise SystemExit("README Term Index section has no closing '------' separator")
    readme.write_text(text[:start] + section + "\n" + text[end + 1 :], encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--types", default="def,thm,prop,lem,cor",
                        help="comma-separated label prefixes to include (default: %(default)s)")
    parser.add_argument("--defs-only", action="store_true", help="shorthand for --types def")
    parser.add_argument("--no-chinese", action="store_true",
                        help="drop Chinese translations and keep English-only terms")
    parser.add_argument("--stats", action="store_true", help="print counts instead of Markdown")
    parser.add_argument("--write", type=Path, metavar="README.md",
                        help="replace the Term Index section in this README")
    args = parser.parse_args()

    types = {"def"} if args.defs_only else {t.strip() for t in args.types.split(",") if t.strip()}
    notes = iter_notes()
    entries: dict[str, dict] = {}
    per_note = {}

    for path in notes:
        rows, skipped = collect(path, types)
        per_note[note_name(path)] = (len(rows), skipped)
        for letter, display, note in rows:
            key = term_key(display)
            if not key:
                continue
            item = entries.setdefault(key, {
                "display": display,
                "chinese": None,
                "notes": [],
                "letter": letter,
            })
            if note not in item["notes"]:
                item["notes"].append(note)

    existing = parse_existing(args.write if args.write else ROOT / "README.md")
    for key, old in existing.items():
        item = entries.setdefault(key, {
            "display": old["display"],
            "chinese": old["chinese"],
            "notes": [],
            "letter": first_letter(old["display"], "#"),
        })
        if old["chinese"] and not item["chinese"]:
            item["chinese"] = old["chinese"]
        for note in old["notes"]:
            if note not in item["notes"]:
                item["notes"].append(note)

    if args.no_chinese:
        for item in entries.values():
            item["chinese"] = None

    if args.stats:
        print(f"notes with glossary: {len(notes)}")
        print(f"included types: {', '.join(sorted(types))}")
        total = 0
        for name, (count, skipped) in sorted(per_note.items()):
            total += count
            print(f"  {name:34} {count:4} included, {skipped:4} skipped")
        print(f"total entries: {total}")
        print(f"unique terms: {len(entries)}")
        print(f"existing README terms: {len(existing)}")
        return 0

    section = render(entries)
    if args.write:
        update_readme(args.write, section)
        print(f"updated {args.write} with {len(entries)} terms")
    else:
        sys.stdout.write(section)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
