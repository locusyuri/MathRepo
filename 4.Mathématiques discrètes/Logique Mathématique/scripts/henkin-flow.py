"""The four-stage Henkin construction for first-order completeness.
Generates img/henkin-flow.svg (single horizontal panel).  Run from the repository root:
uv run "4.Mathématiques discrètes/Logique Mathématique/scripts/henkin-flow.py"
Stage labels use Unicode math glyphs (Γ, ⊨, ≈, ∃, ∀, φ, ∈) supported by DejaVu Sans.
"""
from pathlib import Path
import matplotlib.pyplot as plt

BLUE, RED, GRAY = "#3b6fb6", "#c74440", "#888888"
OUT = Path(__file__).resolve().parent.parent / "img" / "henkin-flow.svg"
PREVIEW = Path(__file__).resolve().parent.parent.parent.parent / "temp" / "henkin-flow-preview.png"


def stage(ax, x, y, title, sub, color=BLUE):
    ax.text(
        x, y, title, ha="center", va="center", fontsize=14,
        bbox=dict(boxstyle="round,pad=0.55", fc="white", ec=color, lw=1.6),
    )
    ax.text(
        x, y - 0.62, sub, ha="center", va="center", fontsize=11.5,
        color="#555555",
    )


def arrow(ax, x1, x2, y):
    ax.annotate(
        "", xy=(x2, y), xytext=(x1, y),
        arrowprops=dict(arrowstyle="-|>", color=GRAY, lw=1.8),
    )


def main():
    fig, ax = plt.subplots(figsize=(12.8, 3.1))
    ax.set_xlim(0.0, 12.8)
    ax.set_ylim(0.0, 3.1)
    ax.axis("off")

    # five nodes at x = 1.4, 3.9, 6.4, 8.9, 11.4, centered on y = 1.85
    y = 1.85
    stage(ax, 1.4, y, r"Lindenbaum", r"Γ  consistent  →  Γ⁺  maximal consistent")
    stage(ax, 3.9, y, r"Henkin expansion", r"new constants  cφ   with witnesses")
    stage(ax, 6.4, y, r"Term model", r"domain  =  closed terms  /  ≈")
    stage(ax, 8.9, y, r"Truth lemma", r"M  ⊨  φ   ⟺   φ  ∈  Γ*")
    stage(ax, 11.4, y, r"Completeness", r"Γ  consistent  ⇒  Γ  has a model", color=RED)

    for x1, x2 in [(2.55, 3.15), (5.05, 5.65), (7.55, 8.15), (10.05, 10.65)]:
        arrow(ax, x1, x2, y)

    # bottom annotation
    ax.text(
        6.4, 0.35,
        "⊨  and  ⊢  coincide:  Γ ⊨ φ  ⟺  Γ ⊢ φ",
        ha="center", va="center", fontsize=12.5, color=RED,
    )

    fig.tight_layout(pad=0.4)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT, format="svg", bbox_inches="tight", transparent=True)
    fig.savefig(PREVIEW, format="png", bbox_inches="tight", transparent=True, dpi=150)


if __name__ == "__main__":
    main()
