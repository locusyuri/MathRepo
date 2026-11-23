"""Cobweb diagrams for the iteration x_{n+1} = phi(x_n).

Three panels, drawn in the style of the classical staircase/spiral pictures:

(a) increasing phi with slope 0 < phi' < 1  -> monotone staircase converging to
    the fixed point (phi(x) = (x + 2) / 3, fixed point x* = 1, start x_0 = 0.2);
(b) decreasing phi with -1 < phi' < 0       -> oscillating spiral converging
    (phi(x) = 2 - 0.6 x, fixed point x* = 1.25, start x_0 = 1);
(c) phi pushing points away                  -> diverging staircase
    (phi(x) = 1.5 x - 0.5, fixed point x* = 1, start x_0 = 1.1).

Each panel shows the diagonal y = x, the graph y = phi(x), and the orbit drawn
with vertical/horizontal arrows; a few iterates are labelled as in the
reference figure.

Output: img/iteration-cobweb.svg (transparent, cropped to the drawn content)
"""

from __future__ import annotations

import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import FancyArrowPatch

ROOT = Path(__file__).resolve().parents[3]
OUT = (ROOT / "1.Analyse/Analyse Mathématique/img" / "iteration-cobweb.svg")

INK = "#1f2933"
ACCENT = "#c0392b"
LW = 1.3
FS = 13
STEPS = 7


def _content_bounds(fig):
    """Fractional bounding box of the non-transparent pixels of the canvas."""
    fig.canvas.draw()
    buf = np.asarray(fig.canvas.buffer_rgba())
    alpha = buf[:, :, 3]
    ys, xs = np.nonzero(alpha > 8)
    h, w = alpha.shape
    padx, pady = 0.012 * w, 0.012 * h
    x0 = max(xs.min() - padx, 0.0) / w
    x1 = min(xs.max() + 1 + padx, w) / w
    y0 = max(ys.min() - pady, 0.0) / h
    y1 = min(ys.max() + 1 + pady, h) / h
    return x0, x1, y0, y1


def _crop_svg(path, x0, x1, y0, y1):
    """Rewrite the SVG canvas so the viewBox hugs the content bounds."""
    import re

    text = path.read_text(encoding="utf-8")
    m = re.search(
        r'width="([0-9.]+)pt" height="([0-9.]+)pt" viewBox="0 0 ([0-9.]+) ([0-9.]+)"',
        text,
    )
    wpt, hpt = float(m.group(1)), float(m.group(2))
    nx, ny = x0 * wpt, y0 * hpt
    nw, nh = (x1 - x0) * wpt, (y1 - y0) * hpt
    repl = (
        f'width="{nw:.2f}pt" height="{nh:.2f}pt" '
        f'viewBox="{nx:.2f} {ny:.2f} {nw:.2f} {nh:.2f}"'
    )
    path.write_text(text[: m.start()] + repl + text[m.end():], encoding="utf-8")


def save(fig, name):
    x0, x1, y0, y1 = _content_bounds(fig)
    svg = OUT.parent / f"{name}.svg"
    fig.savefig(svg, transparent=True)
    _crop_svg(svg, x0, x1, y0, y1)

    from PIL import Image

    jpg = ROOT / "tmp" / f"{name}-preview.jpg"
    fig.savefig(jpg, facecolor="white", dpi=150)
    im = Image.open(jpg)
    w, h = im.size
    im.crop((int(x0 * w), int(y0 * h), int(x1 * w), int(y1 * h))).save(
        jpg, quality=90
    )
    plt.close(fig)
    print(f"saved: {name}.svg")


def panel(ax, phi, x0, xstar, xlim, ylim, title, labels=None, steps=6):
    """Draw one cobweb panel."""
    xs = np.linspace(*xlim, 400)
    ax.plot(xs, phi(xs), color=INK, lw=LW, zorder=2, clip_on=True)
    ax.plot(xlim, xlim, color=INK, lw=1.0, zorder=1)

    # Coordinate axes with arrows.
    ax.annotate("", xy=(xlim[1], 0), xytext=(xlim[0] - 0.12, 0),
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.0))
    ax.annotate("", xy=(0, ylim[1]), xytext=(0, ylim[0] - 0.12),
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.0))
    ax.text(xlim[1] + 0.03, -0.06, r"$x$", fontsize=FS, ha="left", va="top")
    ax.text(-0.05, ylim[1] + 0.03, r"$y$", fontsize=FS, ha="right", va="bottom")
    ax.text(-0.05, -0.05, r"$O$", fontsize=FS, ha="right", va="top")

    # Orbit: vertical to the graph, horizontal back to the diagonal.
    pts = [x0]
    for _ in range(steps):
        pts.append(phi(pts[-1]))
    for n in range(steps):
        x_n, x_next = pts[n], pts[n + 1]
        ax.add_patch(FancyArrowPatch(
            (x_n, x_n), (x_n, x_next), arrowstyle="-|>", mutation_scale=9,
            color=ACCENT, lw=1.2, zorder=3, shrinkA=0, shrinkB=0))
        ax.add_patch(FancyArrowPatch(
            (x_n, x_next), (x_next, x_next), arrowstyle="-|>",
            mutation_scale=9, color=ACCENT, lw=1.2, zorder=3,
            shrinkA=0, shrinkB=0))
        ax.plot([x_n], [x_n], marker="o", ms=3.5, color=ACCENT, zorder=4)

    # Fixed point: dashed drop line (helps reading the limit).
    ax.plot([xstar, xstar], [0, xstar], color=INK, lw=0.7,
            linestyle=(0, (3, 3)), zorder=1)

    if labels:
        for xy, text, dx, dy, ha in labels:
            ax.text(xy[0] + dx, xy[1] + dy, text, fontsize=FS - 1, color=INK,
                    ha=ha, va="center")

    ax.set_xlim(xlim[0] - 0.35, xlim[1] + 0.45)
    ax.set_ylim(ylim[0] - 0.35, ylim[1] + 0.45)
    ax.set_aspect("equal")
    ax.axis("off")
    ax.set_title(title, fontsize=FS, color=INK, pad=4)


def main():
    fig, axes = plt.subplots(1, 3, figsize=(9.6, 3.4))
    fig.patch.set_alpha(0)
    fig.subplots_adjust(left=0.01, right=0.99, top=0.86, bottom=0.03,
                        wspace=0.16)

    # (a) increasing contraction: phi(x) = 0.55 x + 0.45, x* = 1, x0 = 0.05
    phi_a = lambda x: 0.55 * x + 0.45
    ax = axes[0]
    ax.patch.set_alpha(0)
    panel(ax, phi_a, 0.05, 1.0, (0.0, 1.75), (0.0, 1.75), "(a)  monotone",
          steps=5,
          labels=[((0.05, 0.05), r"$(x_0, x_0)$", -0.05, -0.14, "left"),
                  ((1.0, 1.0), r"$x^*$", 0.09, -0.16, "left")])

    # (b) decreasing contraction: phi(x) = 2.2 - 0.8 x, x* = 1.2222, x0 = 0.7
    phi_b = lambda x: 2.2 - 0.8 * x
    ax = axes[1]
    ax.patch.set_alpha(0)
    panel(ax, phi_b, 0.7, 2.2 / 1.8, (0.0, 2.15), (0.0, 2.15),
          "(b)  oscillating", steps=6,
          labels=[((0.7, 0.7), r"$(x_0, x_0)$", -0.07, -0.02, "right"),
                  ((0.7, 1.64), r"$(x_0, x_1)$", -0.07, 0.02, "right"),
                  ((2.2 / 1.8, 0.0), r"$x^*$", 0.05, 0.12, "left")])

    # (c) repelling: phi(x) = 1.4 x - 0.4, x* = 1, x0 = 1.06
    phi_c = lambda x: 1.4 * x - 0.4
    ax = axes[2]
    ax.patch.set_alpha(0)
    panel(ax, phi_c, 1.06, 1.0, (0.0, 2.3), (0.0, 2.3), "(c)  diverging",
          steps=6,
          labels=[((1.06, 1.06), r"$(x_0, x_0)$", 0.07, -0.20, "left"),
                  ((1.0, 0.0), r"$x^*$", -0.06, 0.10, "right")])

    save(fig, "iteration-cobweb")

    if os.environ.get("PREVIEW"):
        print("preview written to tmp/")


if __name__ == "__main__":
    main()
