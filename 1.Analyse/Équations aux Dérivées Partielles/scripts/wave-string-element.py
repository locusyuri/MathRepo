"""Force analysis of a vibrating-string element (Ch 15 derivation).
Generates img/wave-string-element.svg: a string under tension T, with the
element [x, x+dx] highlighted, endpoint tension vectors along the tangents,
transverse external load F, and the small-slope angle theta.
Run from the repository root:  uv run "1.Analyse/Équations aux Dérivées Partielles/scripts/wave-string-element.py"
"""
from pathlib import Path
import tempfile

import matplotlib.pyplot as plt
import numpy as np

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "wave-string-element.svg"
PNG = Path(tempfile.gettempdir()) / "wave-string-element-preview.png"

# string profile: gentle single-hump arc, small slopes
X0, X1 = 0.0, 4.0
def prof(x):
    return 0.45 * np.sin(np.pi * (x - X0) / (X1 - X0))

def slope(x):
    h = 1e-4
    return (prof(x + h) - prof(x - h)) / (2 * h)

XA, XB = 1.55, 2.45          # element endpoints
T_LEN = 0.85                 # tension arrow length

def main():
    fig, ax = plt.subplots(figsize=(7.2, 3.6))
    ax.set_aspect("equal")

    # full string (light) and the element (thick)
    xs = np.linspace(X0, X1, 400)
    ax.plot(xs, prof(xs), color=GRAY, lw=1.2, alpha=0.55)
    xe = np.linspace(XA, XB, 120)
    ax.plot(xe, prof(xe), color=BLUE, lw=3.2, solid_capstyle="round")
    ax.plot([XA, XB], [prof(XA), prof(XB)], "o", color=BLUE, ms=5)

    # tension vectors: outward along the tangents at the element endpoints
    for x_end, sign in ((XA, -1.0), (XB, +1.0)):
        m = slope(x_end)
        nrm = np.hypot(1.0, m)
        dx, du = sign * T_LEN / nrm, sign * T_LEN * m / nrm
        ax.annotate("", xy=(x_end + dx, prof(x_end) + du),
                    xytext=(x_end, prof(x_end)),
                    arrowprops=dict(arrowstyle="-|>", color=RED, lw=1.8))
        ax.text(x_end + 1.16 * dx, prof(x_end) + 1.16 * du + 0.08, r"$T$",
                color=RED, fontsize=13, ha="center")

    # horizontal reference (dashed) + angle theta at both endpoints
    for x_end, ha in ((XA, "left"), (XB, "right")):
        ax.plot([x_end - 0.75, x_end + 0.75], [prof(x_end), prof(x_end)],
                ls="--", color=GRAY, lw=0.8)
        ax.text(x_end + (0.62 if ha == "right" else -0.62),
                prof(x_end) + 0.13, r"$\theta$", color=GRAY, fontsize=11,
                ha="center")

    # external transverse load F: downward arrows on the element
    fx = np.linspace(XA + 0.15, XB - 0.15, 3)
    for xf in fx:
        ax.annotate("", xy=(xf, prof(xf) - 0.42), xytext=(xf, prof(xf) - 0.06),
                    arrowprops=dict(arrowstyle="-|>", color=RED, lw=1.3))
    ax.text(float(np.mean(fx)), prof(XA) - 0.78, r"$F$", color=RED,
            fontsize=13, ha="center")

    # element mass label and dx span
    ax.text((XA + XB) / 2, prof((XA + XB) / 2) + 0.30, r"$\rho\,\Delta x$",
            color=BLUE, fontsize=12, ha="center")
    yb = -1.02
    ax.plot([XA, XA], [prof(XA), yb], color=GRAY, lw=0.7, ls=":")
    ax.plot([XB, XB], [prof(XB), yb], color=GRAY, lw=0.7, ls=":")
    ax.annotate("", xy=(XB, yb), xytext=(XA, yb),
                arrowprops=dict(arrowstyle="<->", color="black", lw=1.0))
    ax.text((XA + XB) / 2, yb - 0.20, r"$\Delta x$", fontsize=12, ha="center")

    # axes through the equilibrium line
    ax.annotate("", xy=(X1 + 0.35, 0), xytext=(X0 - 0.25, 0),
                arrowprops=dict(arrowstyle="-|>", color="black", lw=0.8))
    ax.annotate("", xy=(X0 - 0.12, 1.15), xytext=(X0 - 0.12, -1.25),
                arrowprops=dict(arrowstyle="-|>", color="black", lw=0.8))
    ax.text(X1 + 0.42, -0.05, r"$x$", fontsize=12, va="center")
    ax.text(X0 - 0.26, 1.22, r"$u$", fontsize=12, ha="center")

    ax.set_xlim(X0 - 0.75, X1 + 0.75)
    ax.set_ylim(-1.45, 1.30)
    ax.axis("off")
    fig.tight_layout()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PNG, format="png", dpi=150, bbox_inches="tight",
                facecolor="white")  # preview only; the SVG stays transparent
    print(f"saved {OUT}\npreview {PNG}")

if __name__ == "__main__":
    main()
