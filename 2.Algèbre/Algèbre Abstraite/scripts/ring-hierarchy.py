"""The lattice of ring classes: ring, commutativity, identity, domain, field.

Generates img/ring-hierarchy.svg.  Run from the repository root:

    uv run "2.Algèbre/Algèbre Abstraite/scripts/ring-hierarchy.py"

Two independent conditions are adjoined to a ring — commutativity on the left,
a multiplicative identity on the right — and their conjunction is the
commutative unital ring, from which the ladder climbs to the field through the
divisibility refinements of Divisibility Theory.  The right branch adjoins
inverses without commutativity and reaches the same field from below, so the
picture is a lattice with one terminal class rather than a chain.

Every box carries one example of its class, and each arrow names the condition
adjoined; a class is strict by the class below it that fails that condition.
"""
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, FancyBboxPatch

OUT = Path(__file__).resolve().parent.parent / "img" / "ring-hierarchy.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "ring-hierarchy-preview.png"

INK = "#22262e"
BLUE = "#3b6fb6"
RED = "#c74440"
GREEN = "#3f7d4f"
GRAY = "#6b7280"
FILL_MAIN = "#f4f7fb"
FILL_SIDE = "#fbf3f2"
FILL_ROOT = "#ffffff"

H = 1.10  # box height

# (x0, y0, width, title, condition added, example, kind)
BOXES = [
    (2.35, 0.45, 2.45, "Ring", "R1, R2, R3", r"$2\mathbb{Z}$", "root"),
    (0.10, 2.05, 2.95, "Commutative ring", r"$a b = b a$",
     r"$2\mathbb{Z}$,  $\mathbb{Z}_6$", "main"),
    (4.95, 2.05, 2.30, "Unital ring", r"a multiplicative $1$",
     r"$M_2(\mathbb{R})$", "main"),
    (1.40, 3.80, 3.90, "Commutative unital ring", r"$a b = b a$ and $1$",
     r"$\mathbb{Z}_6$,  $\mathbb{Z} \times \mathbb{Z}$", "main"),
    (1.55, 5.50, 3.60, "Integral domain", "no zero divisors",
     r"$\mathbb{Z}$,  $\mathbb{Z}[i]$", "main"),
    (2.03, 7.20, 2.65, "PID", "every ideal principal",
     r"$\mathbb{Z}$,  $k[x]$", "main"),
    (5.55, 7.20, 2.55, "ED", "division with remainder",
     r"$k[x]$,  $\mathbb{Z}[i]$", "main"),
    (9.65, 7.20, 2.25, "Field", r"$R^\times = R \setminus \{0\}$",
     r"$\mathbb{Q}$,  $\mathbb{F}_p$", "terminal"),
    (6.85, 5.50, 2.85, "Division ring", "nonzero elements invertible",
     r"$\mathbb{H}$", "side"),
]

# (start, end, label, label position, horizontal alignment, vertical alignment,
#  colour, dashed, curvature)
ARROWS = [
    ((3.00, 1.55), (1.70, 2.05), r"adjoin $a b = b a$", (1.75, 1.62), "center", "center",
     GREEN, False, 0.0),
    ((4.15, 1.55), (5.60, 2.05), r"adjoin $1$", (5.35, 1.68), "left", "center",
     GREEN, False, 0.0),
    ((1.575, 3.15), (2.00, 3.80), None, None, None, None, GREEN, False, 0.0),
    ((6.10, 3.15), (4.85, 3.80), None, None, None, None, GREEN, False, 0.0),
    ((3.35, 4.90), (3.35, 5.50), "adjoin: no zero divisors", (3.48, 5.20), "left", "center",
     GREEN, False, 0.0),
    ((3.35, 6.60), (3.35, 7.20), "adjoin: every ideal principal", (3.18, 6.90),
     "right", "center", GREEN, False, 0.0),
    ((4.55, 7.75), (5.55, 7.75), "adjoin a\nEuclidean function", (5.05, 7.10),
     "center", "top", GREEN, False, 0.0),
    ((8.10, 7.75), (9.65, 7.75), "adjoin\ninverses", (8.87, 7.62),
     "center", "top", GREEN, False, 0.0),
    ((6.70, 3.15), (7.75, 5.50), "adjoin inverses of\nnonzero elements", (8.05, 4.40),
     "left", "center", RED, True, -0.14),
    ((9.10, 6.60), (10.35, 7.20), r"adjoin $a b = b a$", (9.35, 6.95),
     "right", "center", RED, True, 0.0),
]


def box(ax, x0, y0, w, title, condition, example, kind):
    if kind == "side":
        fill, edge, dashed, lw = FILL_SIDE, RED, True, 1.5
    elif kind == "root":
        fill, edge, dashed, lw = FILL_ROOT, INK, False, 1.6
    elif kind == "terminal":
        fill, edge, dashed, lw = FILL_MAIN, INK, False, 2.0
    else:
        fill, edge, dashed, lw = FILL_MAIN, INK, False, 1.4

    ax.add_patch(
        FancyBboxPatch(
            (x0, y0), w, H,
            boxstyle="round,pad=0.02,rounding_size=0.12",
            facecolor=fill, edgecolor=edge, linewidth=lw,
            linestyle=(0, (5, 3)) if dashed else "solid",
            zorder=2,
        )
    )
    ax.text(x0 + 0.20, y0 + H - 0.28, title, fontsize=12, color=INK,
            fontweight="bold", ha="left", va="center", zorder=3)
    ax.text(x0 + 0.20, y0 + H - 0.62, condition, fontsize=8.8, color=GRAY,
            ha="left", va="center", zorder=3)
    ax.text(x0 + 0.20, y0 + 0.26, example, fontsize=10.5, color=BLUE,
            ha="left", va="center", zorder=3)


def arrow(ax, start, end, color, dashed, rad):
    ax.add_patch(
        FancyArrowPatch(
            start, end,
            connectionstyle=f"arc3,rad={rad}",
            arrowstyle="-|>", mutation_scale=13, linewidth=1.4,
            color=color, linestyle=(0, (5, 3)) if dashed else "solid",
            shrinkA=1.0, shrinkB=1.0, zorder=3,
        )
    )


def main():
    fig, ax = plt.subplots(figsize=(8.6, 6.1))
    ax.set_xlim(0, 12.1)
    ax.set_ylim(0, 8.6)
    ax.axis("off")
    ax.set_aspect("equal")

    for x0, y0, w, title, condition, example, kind in BOXES:
        box(ax, x0, y0, w, title, condition, example, kind)

    for start, end, label, pos, ha, va, colour, dashed, rad in ARROWS:
        arrow(ax, start, end, colour, dashed, rad)
        if label:
            ax.text(pos[0], pos[1], label, fontsize=8.8, color=colour,
                    ha=ha, va=va, linespacing=1.3, zorder=3)

    fig.tight_layout(pad=0.4)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    PREVIEW.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
