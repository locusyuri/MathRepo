"""Ultraproduct construction flow.
Generates img/ultraproduct-flow.svg (single panel).  Run from the repository root:
uv run "4.Mathématiques discrètes/Logique Mathématique/scripts/ultraproduct-flow.py"

Mathematics: the ultraproduct is built in three stages — (1) the Cartesian
product of the domains M_i; (2) the equivalence relation f ~ g iff the set of
coordinates where they agree lies in the ultrafilter U; (3) the quotient
structure on the classes [f], with relations and functions defined
coordinate-wise.  Łoś's theorem transfers truth: a formula holds in the
ultraproduct iff the set of coordinates where it holds in M_i is in U.
"""
from pathlib import Path
import matplotlib.pyplot as plt

BLUE, TEAL, PURPLE, GRAY = "#3b6fb6", "#2f8f7d", "#7a4fa8", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "ultraproduct-flow.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "ultraproduct-flow-preview.png"


def main():
    fig, ax = plt.subplots(figsize=(11.0, 4.2))
    ax.set_xlim(0.0, 11.0)
    ax.set_ylim(0.0, 4.2)
    ax.axis("off")

    # --- stage 1: cartesian product (three columns of points) ---
    col_x = [0.8, 1.6, 2.4]
    for x in col_x:
        for y in (1.0, 2.0, 3.0):
            ax.plot(x, y, "o", color=BLUE, markersize=6)
    ax.text(1.6, 3.55, "1 · product", fontsize=11, color=BLUE,
            fontweight="bold", ha="center")
    ax.text(1.6, 0.45, "Π M_i (coordinates i ∈ I)", fontsize=9.5, color=GRAY,
            ha="center")

    # --- stage 2: ultrafilter equivalence (wavy merge to classes) ---
    ax.annotate("", xy=(3.0, 2.0), xytext=(2.7, 2.0),
                arrowprops=dict(arrowstyle="-|>", color=GRAY, lw=1.6))
    ax.text(3.9, 2.9, "f ~ g  iff {i : f(i) = g(i)} ∈ U", fontsize=10,
            color=PURPLE, ha="left")
    ax.plot(4.4, 3.0, "o", color=PURPLE, markersize=6)
    ax.plot(4.4, 2.0, "o", color=PURPLE, markersize=6)
    ax.plot(4.4, 1.0, "o", color=PURPLE, markersize=6)
    ax.text(4.4, 3.55, "2 · quotient", fontsize=11, color=PURPLE,
            fontweight="bold", ha="center")
    ax.text(4.4, 0.45, "classes [f] under U", fontsize=9.5, color=GRAY,
            ha="center")

    # --- stage 3: ultraproduct structure ---
    ax.annotate("", xy=(5.3, 2.0), xytext=(5.0, 2.0),
                arrowprops=dict(arrowstyle="-|>", color=GRAY, lw=1.6))
    ax.text(6.4, 3.55, "3 · ultraproduct", fontsize=11, color=TEAL,
            fontweight="bold", ha="center")
    ax.plot(6.4, 3.0, "o", color=TEAL, markersize=7)
    ax.plot(6.4, 2.0, "o", color=TEAL, markersize=7)
    ax.plot(6.4, 1.0, "o", color=TEAL, markersize=7)
    ax.text(6.4, 0.45, "∏_U M_i  (relations coordinate-wise)", fontsize=9.5,
            color=GRAY, ha="center")

    # --- Łoś transfer banner on the right ---
    ax.plot([8.0, 8.0], [0.8, 3.4], color=GRAY, lw=0.8, ls="--")
    ax.annotate("", xy=(8.3, 2.0), xytext=(8.0, 2.0),
                arrowprops=dict(arrowstyle="-|>", color=GRAY, lw=1.6))
    ax.text(8.5, 3.2, "Łoś:  ∏_U M_i ⊨ φ[f]  iff", fontsize=10.5, color="#1a2233",
            ha="left", fontweight="bold")
    ax.text(8.5, 2.4, "{ i : M_i ⊨ φ[f(i)] } ∈ U", fontsize=10.5, color="#1a2233",
            ha="left")
    ax.text(8.5, 1.2, "truth transfers coordinate-wise", fontsize=9.5,
            color=GRAY, ha="left")

    fig.tight_layout(pad=0.4)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
