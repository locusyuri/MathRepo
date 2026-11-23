"""Flowchart of the elimination algorithm for solving a linear system.

The diagram follows the text from the augmented matrix to the solution set:
Gaussian elimination to row echelon form, the consistency test on the last
column, and the two final routes (back-substitution or Gauss-Jordan).

Run with:
    uv run "2.Algèbre/Algèbre Linéaire/scripts/elimination-flowchart.py"
"""

from __future__ import annotations

from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch, Polygon

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "img" / "elimination-flowchart.svg"
PREVIEW = ROOT / "tmp" / "elimination-flowchart.png"

INK = "#1C1C1C"
ARROW = "#5A5A5A"
BOX = {"fc": "#EEF5FA", "ec": "#337FB0"}
DECISION = {"fc": "#FDF4E7", "ec": "#DB7E2E"}
STOP = {"fc": "#FFF0F0", "ec": "#B03A3A"}
FINAL = {"fc": "#EEF7F0", "ec": "#40985F"}


def box(ax, cx, cy, w, h, text, style=BOX, fontsize=10.5):
    """Draw a rounded process box centred at (cx, cy)."""
    ax.add_patch(
        FancyBboxPatch(
            (cx - w / 2, cy - h / 2),
            w,
            h,
            boxstyle="round,pad=0.02,rounding_size=0.10",
            linewidth=1.3,
            facecolor=style["fc"],
            edgecolor=style["ec"],
            zorder=2,
        )
    )
    ax.text(
        cx,
        cy,
        text,
        ha="center",
        va="center",
        fontsize=fontsize,
        color=INK,
        linespacing=1.35,
        zorder=3,
    )


def diamond(ax, cx, cy, w, h, text, fontsize=10.5):
    """Draw a decision diamond centred at (cx, cy)."""
    ax.add_patch(
        Polygon(
            [(cx - w / 2, cy), (cx, cy + h / 2), (cx + w / 2, cy), (cx, cy - h / 2)],
            closed=True,
            linewidth=1.3,
            facecolor=DECISION["fc"],
            edgecolor=DECISION["ec"],
            zorder=2,
        )
    )
    ax.text(
        cx,
        cy,
        text,
        ha="center",
        va="center",
        fontsize=fontsize,
        color=INK,
        linespacing=1.35,
        zorder=3,
    )


def arrow(ax, start, end):
    """Draw a filled arrow from start to end."""
    ax.annotate(
        "",
        xy=end,
        xytext=start,
        arrowprops=dict(
            arrowstyle="-|>",
            mutation_scale=13,
            linewidth=1.3,
            color=ARROW,
            shrinkA=0,
            shrinkB=0,
        ),
        zorder=1,
    )


def build_figure():
    plt.rcParams.update(
        {
            "font.family": "serif",
            "font.serif": ["DejaVu Serif", "Times New Roman", "serif"],
            "mathtext.fontset": "dejavuserif",
        }
    )
    fig = plt.figure(figsize=(8.4, 8.81), facecolor="white")
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_xlim(0.35, 12.65)
    ax.set_ylim(1.95, 14.85)
    ax.set_aspect("equal")
    ax.axis("off")

    box(ax, 5, 14.2, 6.8, 1.05, "Write the augmented matrix $(A\\,|\\,b)$")
    arrow(ax, (5, 13.67), (5, 13.05))

    box(
        ax,
        5,
        12.45,
        9.0,
        1.15,
        "Apply elementary row operations to reach\n"
        "row echelon form (Gaussian elimination)",
    )
    arrow(ax, (5, 11.87), (5, 11.35))

    diamond(
        ax,
        5,
        10.2,
        7.2,
        2.2,
        "Does some row read\n$(0\\ \\cdots\\ 0\\,|\\,c)$ with $c \\neq 0$?",
    )
    ax.text(5.2, 8.72, "no", fontsize=9.5, color=ARROW, ha="left", va="center")
    ax.text(8.75, 10.45, "yes", fontsize=9.5, color=ARROW, ha="left", va="center")

    arrow(ax, (8.6, 10.2), (9.45, 10.2))
    box(ax, 11.0, 10.2, 3.0, 1.1, "No solution", style=STOP)

    arrow(ax, (5, 9.1), (5, 8.2))
    box(
        ax,
        5,
        7.55,
        9.2,
        1.25,
        "$\\mathrm{rank}(A) = \\mathrm{rank}(A\\,|\\,b) = r$;\n"
        "$r$ pivot variables and $n - r$ free variables",
    )

    ax.plot([5, 5], [6.92, 6.35], color=ARROW, lw=1.3)
    ax.plot([2.9, 7.1], [6.35, 6.35], color=ARROW, lw=1.3)
    arrow(ax, (2.9, 6.35), (2.9, 5.85))
    arrow(ax, (7.1, 6.35), (7.1, 5.85))

    box(
        ax,
        2.9,
        5.0,
        4.0,
        1.7,
        "Back-substitution:\nsolve the pivot variables\nfrom the bottom row up",
    )
    box(
        ax,
        7.1,
        5.0,
        4.0,
        1.7,
        "Gauss-Jordan:\ncontinue to RREF and\nread the solution off",
    )

    arrow(ax, (2.9, 4.15), (4.2, 3.45))
    arrow(ax, (7.1, 4.15), (5.8, 3.45))
    box(
        ax,
        5,
        2.75,
        7.0,
        1.35,
        "Solution set, with $n - r$ free parameters",
        style=FINAL,
    )

    return fig


def main():
    OUT.parent.mkdir(parents=True, exist_ok=True)
    PREVIEW.parent.mkdir(parents=True, exist_ok=True)
    fig = build_figure()
    fig.savefig(
        OUT,
        bbox_inches="tight",
        pad_inches=0.02,
        facecolor="white",
        transparent=False,
    )
    fig.savefig(
        PREVIEW,
        bbox_inches="tight",
        pad_inches=0.02,
        facecolor="white",
        transparent=False,
        dpi=160,
    )
    plt.close(fig)
    print(f"Saved: {OUT}")
    print(f"Preview: {PREVIEW}")


if __name__ == "__main__":
    main()
