"""Implication diagram for the four modes of convergence of measurable functions.

Educational diagram showing:
- Left panel: implications valid on *any* measure space
    $L^p$ -> in measure (Markov's inequality)
    a.u.  -> a.e.  (trivial)
    a.u.  -> in measure (trivial)
- Right panel: *additional* implications valid only on finite measure spaces
    in measure -> a.e. along a subsequence (Riesz's theorem)
    a.e.      -> a.u. (Egorov's theorem)

Run with: uv run "1.Analyse/Analyse Reelle/scripts/convergence-implications.py"
"""

from __future__ import annotations

from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, FancyBboxPatch

# --------------------------------------------------------------------------- #
# Configuration
# --------------------------------------------------------------------------- #
OUT_DIR = Path(__file__).resolve().parent.parent / "img"
FIG_SIZE = (11.0, 4.8)

plt.rcParams.update(
    {
        "font.family": "sans-serif",
        "font.sans-serif": ["DejaVu Sans", "Helvetica", "Arial", "sans-serif"],
        "mathtext.fontset": "dejavusans",
    }
)

NODE_FC = "#f2f6fb"
NODE_EC = "#3b6ea5"
SOLID_ARROW = "#1f4e79"
DASHED_ARROW = "#b34700"

BOX_W = 2.5
BOX_H = 1.0


# --------------------------------------------------------------------------- #
# Helpers
# --------------------------------------------------------------------------- #
def edge_point(center, other, hw=BOX_W / 2, hh=BOX_H / 2):
    """Point on the boundary of the box at `center`, heading towards `other`."""
    cx, cy = center
    ox, oy = other
    dx, dy = ox - cx, oy - cy
    if dx == 0 and dy == 0:
        return cx, cy
    tx = hw / abs(dx) if dx else float("inf")
    ty = hh / abs(dy) if dy else float("inf")
    t = min(tx, ty)
    return cx + t * dx, cy + t * dy


def draw_node(ax, xy, text, fontsize=14):
    x, y = xy
    box = FancyBboxPatch(
        (x - BOX_W / 2, y - BOX_H / 2),
        BOX_W,
        BOX_H,
        boxstyle="round,pad=0.06,rounding_size=0.24",
        linewidth=1.6,
        edgecolor=NODE_EC,
        facecolor=NODE_FC,
        zorder=2,
    )
    ax.add_patch(box)
    ax.text(
        x,
        y,
        text,
        ha="center",
        va="center",
        fontsize=fontsize,
        color="#12263f",
        zorder=3,
    )


def draw_arrow(ax, src, dst, label="", dashed=False, rad=0.0,
               label_at=(0.5, 0.0), label_offset=(0.0, 0.0), fontsize=11):
    """Draw an implication arrow from node `src` to node `dst`."""
    color = DASHED_ARROW if dashed else SOLID_ARROW
    start = edge_point(src, dst)
    end = edge_point(dst, src)
    arrow = FancyArrowPatch(
        start,
        end,
        connectionstyle=f"arc3,rad={rad}",
        arrowstyle="-|>",
        mutation_scale=16,
        linewidth=1.8,
        linestyle=(0, (5, 3)) if dashed else "solid",
        color=color,
        shrinkA=0,
        shrinkB=0,
        zorder=1,
    )
    ax.add_patch(arrow)
    if label:
        mx = start[0] + (end[0] - start[0]) * label_at[0] + label_offset[0]
        my = start[1] + (end[1] - start[1]) * label_at[1] + label_offset[1]
        ax.text(
            mx,
            my,
            label,
            ha="center",
            va="center",
            fontsize=fontsize,
            color=color,
            bbox=dict(facecolor="white", edgecolor="none", pad=1.5),
            zorder=4,
        )


def panel(ax, title):
    ax.set_xlim(0, 10)
    ax.set_ylim(0, 10)
    ax.set_xticks([])
    ax.set_yticks([])
    for spine in ax.spines.values():
        spine.set_visible(False)
    ax.set_title(title, fontsize=13, color="#12263f", pad=10)


# --------------------------------------------------------------------------- #
# Build the figure
# --------------------------------------------------------------------------- #
def build_figure():
    fig = plt.figure(figsize=FIG_SIZE, facecolor="white")
    ax_a = fig.add_subplot(1, 2, 1)
    ax_b = fig.add_subplot(1, 2, 2)

    # ---------------- left panel: any measure space ----------------
    panel(ax_a, "Any measure space")

    lp = (2.4, 7.4)
    mu = (7.6, 7.4)
    au = (2.4, 2.4)
    ae = (7.6, 2.4)

    draw_node(ax_a, lp, r"$L^p$")
    draw_node(ax_a, mu, "in measure")
    draw_node(ax_a, au, "a.u.")
    draw_node(ax_a, ae, "a.e.")

    draw_arrow(ax_a, lp, mu, "Марков's inequality", label_offset=(0.0, 0.85))
    draw_arrow(ax_a, au, ae, "trivial", label_offset=(0.0, -0.85))
    draw_arrow(ax_a, au, mu, "trivial", rad=-0.16,
               label_at=(0.32, 0.32), label_offset=(-0.75, 0.0))

    # ---------------- right panel: finite measure space ----------------
    panel(ax_b, "Finite measure space: additional implications")

    mu2 = (2.4, 7.0)
    ae2 = (7.4, 7.0)
    au2 = (7.4, 2.2)

    draw_node(ax_b, mu2, "in measure")
    draw_node(ax_b, ae2, "a.e.")
    draw_node(ax_b, au2, "a.u.")

    draw_arrow(ax_b, mu2, ae2, "Riesz's theorem\n(a.e. along a subsequence)",
               dashed=True, label_offset=(0.0, 1.15))
    draw_arrow(ax_b, ae2, au2, "Его́ров's theorem",
               dashed=True, label_at=(0.5, 0.5), label_offset=(-1.85, 0.0))

    fig.tight_layout()
    return fig


def main():
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    fig = build_figure()
    svg = OUT_DIR / "convergence-implications.svg"
    fig.savefig(svg, bbox_inches="tight", pad_inches=0.04, facecolor="white")
    print(f"wrote {svg}")
    png = (Path(__file__).resolve().parent.parent.parent.parent
           / "tmp" / "convergence-implications.png")
    png.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(png, dpi=150, bbox_inches="tight", pad_inches=0.04, facecolor="white")
    print(f"wrote {png}")


if __name__ == "__main__":
    main()
