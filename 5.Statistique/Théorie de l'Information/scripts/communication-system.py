"""The five components of a communication system.

Block diagram: source -> transmitter (encoder) -> channel -> receiver
(decoder) -> destination.  The two boxes that carry the mathematical content
of the theory are highlighted and annotated with the distributions p(x) and
p(y | x); the upper bracket marks source coding, the lower one channel coding.

Output: ../img/communication-system.svg
"""

from __future__ import annotations

import os
import sys
from dataclasses import replace
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, FancyBboxPatch

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _viz import Presets

SPEC = replace(Presets.SVG_MATH_PANEL, figsize=(8.8, 2.95))
OUT_DIR = Path(__file__).resolve().parent.parent / "img"

INK = "#1f2933"
MUTED = "#66788a"
EDGE = "#b6c2cd"
KEY = "#1f4e9b"
KEY_FILL = "#dbe8f7"
PLAIN_FILL = "#f4f6f8"

BOXES = [
    ("Source", r"$p(x)$", True, 1.15),
    ("Transmitter\n(encoder)", "", False, 1.35),
    ("Channel", r"$p(y\mid x)$", True, 1.35),
    ("Receiver\n(decoder)", "", False, 1.35),
    ("Destination", "", False, 1.15),
]
GAP = 0.62
HEIGHT = 1.0


def main():
    fig = SPEC.figure()
    ax = fig.add_axes([0.01, 0.01, 0.98, 0.98])
    ax.set_xlim(0, 10.6)
    ax.set_ylim(0, 3.5)
    ax.set_aspect("equal")
    ax.axis("off")

    total = sum(width for _, _, _, width in BOXES) + GAP * (len(BOXES) - 1)
    centres, x = [], (10.6 - total) / 2
    for _, _, _, width in BOXES:
        centres.append((x + width / 2, width))
        x += width + GAP

    mid = 1.72
    for (cx, width), (title, sub, key, _) in zip(centres, BOXES):
        ax.add_patch(FancyBboxPatch(
            (cx - width / 2, mid - HEIGHT / 2), width, HEIGHT,
            boxstyle="round,pad=0.06,rounding_size=0.12",
            facecolor=KEY_FILL if key else PLAIN_FILL,
            edgecolor=KEY if key else EDGE, lw=1.6 if key else 1.0, zorder=3))
        ax.text(cx, mid + (0.10 if sub else 0.0), title, ha="center",
                va="center", fontsize=10.5, color=INK, linespacing=1.35,
                zorder=4)
        if sub:
            ax.text(cx, mid - 0.28, sub, ha="center", va="center",
                    fontsize=10.5, color=KEY, zorder=4)

    for (x0, w0), (x1, w1) in zip(centres, centres[1:]):
        ax.add_patch(FancyArrowPatch(
            (x0 + w0 / 2 + 0.08, mid), (x1 - w1 / 2 - 0.08, mid),
            arrowstyle="-|>", mutation_scale=13, color=MUTED, lw=1.2,
            shrinkA=0, shrinkB=0, zorder=2))

    # Square brackets: source coding above, channel coding below.
    def bracket(left, right, y, label, above):
        tick = 0.12 if above else -0.12
        ax.plot([left, left, right, right], [y + tick, y, y, y + tick],
                color=KEY, lw=1.0, solid_capstyle="butt", zorder=2)
        ax.text((left + right) / 2, y + (0.10 if above else -0.10), label,
                ha="center", va="bottom" if above else "top",
                fontsize=9, color=KEY)

    bracket(centres[0][0] - centres[0][1] / 2,
            centres[1][0] + centres[1][1] / 2, 2.80,
            "source coding  (Ch 4–6)", above=True)
    bracket(centres[1][0], centres[3][0], 0.64,
            "channel coding  (Ch 7–9)", above=False)

    path = SPEC.save(fig, OUT_DIR / "communication-system")
    print(f"Saved: {path}")

    if os.environ.get("PREVIEW"):
        preview = OUT_DIR / "communication-system-preview.png"
        fig.savefig(preview, dpi=160, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")

    plt.close(fig)


if __name__ == "__main__":
    main()
