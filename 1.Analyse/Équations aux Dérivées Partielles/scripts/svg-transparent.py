"""Strip opaque white backgrounds from the SVG figures of this notebook.

matplotlib writes the figure patch and the axes patch as opaque white
rectangles whenever ``savefig`` is not given ``transparent=True``.
Inside a tinted component such a patch shows up as a white block, so every
opaque white fill is turned into ``fill: none`` here.

Half-transparent white fills are left alone: they are the halos that keep an
annotation legible where it crosses a curve, not background.

The script is idempotent and works on figures that have no generating script
of their own: run it once after adding or regenerating any figure.

Run from the repository root:
    uv run "1.Analyse/Équations aux Dérivées Partielles/scripts/svg-transparent.py"
"""

import re
from pathlib import Path

IMG = Path(__file__).resolve().parent.parent / "img"

STYLE_ATTR = re.compile(r'style="([^"]*)"')
WHITE_STYLE = re.compile(r"fill:\s*#f{6}\b", re.IGNORECASE)
WHITE_ATTR = re.compile(r'fill="#f{6}"', re.IGNORECASE)


def clear_style(match):
    """Opaque white fill of a style attribute becomes none; halos are kept."""
    style = match.group(1)
    if "opacity" in style:
        return match.group(0)
    return 'style="' + WHITE_STYLE.sub("fill: none", style) + '"'


def strip_white(path: Path) -> bool:
    """Replace the opaque white fills of *path* by none; report whether it changed."""
    svg = path.read_text(encoding="utf-8")
    fixed = WHITE_ATTR.sub('fill="none"', STYLE_ATTR.sub(clear_style, svg))
    if fixed == svg:
        return False
    path.write_text(fixed, encoding="utf-8")
    return True


def main():
    changed = [p.name for p in sorted(IMG.glob("*.svg")) if strip_white(p)]
    if changed:
        print("white background removed: " + ", ".join(changed))
    else:
        print("all figures already transparent")


if __name__ == "__main__":
    main()
