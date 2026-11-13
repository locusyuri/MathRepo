"""Shared output configuration for figure scripts in this note.

Defines :class:`OutputSpec`, a frozen value object bundling the figure size,
format, DPI, padding and background color, together with :class:`Presets`, a
flat namespace of named configurations to pick from in each model script.

Usage in a model script::

    from _viz.output import Presets
    spec = Presets.SVG_DOC
    fig = spec.figure()
    # ... draw ...
    spec.save(fig, out_dir / "magnetic_field_loop")
"""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path

import matplotlib.pyplot as plt

__all__ = ["OutputSpec", "Presets"]


@dataclass(frozen=True)
class OutputSpec:
    """Bundle of figure/output settings for one rendering target.

    The optional ``rc_overrides`` are applied to ``matplotlib.rcParams`` inside
    :meth:`figure`, so a preset can also pin a font family or other rcParam —
    e.g. a serif/textbook style.
    """

    figsize: tuple[float, float]
    fmt: str = "svg"
    dpi: int | None = None
    pad_inches: float = 0.02
    facecolor: str = "white"
    # When True the saved file has a transparent background (PNG keeps its
    # alpha channel; SVG/PDF simply omit the background rectangle). When
    # False, `facecolor` is used as the opaque background.
    transparent: bool = True
    rc_overrides: dict = None

    def __post_init__(self) -> None:
        if self.fmt not in {"svg", "png", "pdf"}:
            raise ValueError(f"unsupported format: {self.fmt!r}")
        if self.fmt == "png" and not self.dpi:
            raise ValueError("PNG output requires a dpi")

    def figure(self, **kwargs):
        """Create a new figure sized/styled per this spec."""
        if self.rc_overrides:
            plt.rcParams.update(self.rc_overrides)
        return plt.figure(figsize=self.figsize, facecolor=self.facecolor, **kwargs)

    def save(self, fig, basepath: str | Path) -> Path:
        """Save ``fig`` to ``<basepath>.<fmt>`` and return the written path."""
        path = Path(basepath).with_suffix(f".{self.fmt}")
        extra: dict = {"dpi": self.dpi} if self.dpi else {}
        fig.savefig(
            path,
            bbox_inches="tight",
            pad_inches=self.pad_inches,
            transparent=self.transparent,
            **({"facecolor": self.facecolor} if not self.transparent else {}),
            **extra,
        )
        return path


class Presets:
    """Named, ready-to-use :class:`OutputSpec` instances.

    Pick one in a model script, e.g. ``spec = Presets.SVG_DOC``. The flat
    (non-enum) layout keeps the call site free of ``.value`` lookups while
    still giving enum-style discoverable names.
    """

    # Vector, tight padding — for embedding in documents/slides.
    SVG_DOC = OutputSpec(figsize=(9.5, 9.0), fmt="svg", pad_inches=0.02)
    # Vector with serif fonts — physics-textbook style.
    SVG_TEXTBOOK = OutputSpec(
        figsize=(12.0, 12.0),
        fmt="svg",
        pad_inches=0.05,
        rc_overrides={
            "font.family": "serif",
            "font.serif": ["DejaVu Serif", "Times New Roman", "serif"],
            "mathtext.fontset": "dejavuserif",
        },
    )
    # Transparent PNG with serif fonts — default textbook style.
    PNG_TEXTBOOK = OutputSpec(
        figsize=(14.0, 7.0),
        fmt="png",
        dpi=300,
        pad_inches=0.05,
        rc_overrides={
            "font.family": "serif",
            "font.serif": ["DejaVu Serif", "Times New Roman", "serif"],
            "mathtext.fontset": "dejavuserif",
        },
    )
    # High-resolution raster for print.
    PNG_PRINT = OutputSpec(figsize=(9.5, 9.0), fmt="png", dpi=300, pad_inches=0.02)
    # Lighter raster for web/screen.
    PNG_WEB = OutputSpec(figsize=(8.0, 8.0), fmt="png", dpi=150)
    # Wide two-panel layout for math textbook figures (sans-serif).
    PNG_MATH_PANEL = OutputSpec(
        figsize=(14.0, 6.5),
        fmt="png",
        dpi=300,
        pad_inches=0.05,
        rc_overrides={
            "font.family": "sans-serif",
            "font.sans-serif": ["DejaVu Sans", "Helvetica", "Arial", "sans-serif"],
            "mathtext.fontset": "dejavusans",
        },
    )
    # Vector, wide two-panel layout for math figures (sans-serif).
    SVG_MATH_PANEL = OutputSpec(
        figsize=(14.0, 6.5), fmt="svg", pad_inches=0.05,
        rc_overrides={
            "font.family": "sans-serif",
            "font.sans-serif": ["DejaVu Sans", "Helvetica", "Arial", "sans-serif"],
            "mathtext.fontset": "dejavusans",
        },
    )
    # Vector, square layout for single-panel math figures (sans-serif).
    SVG_MATH = OutputSpec(
        figsize=(9.5, 9.0), fmt="svg", pad_inches=0.05,
        rc_overrides={
            "font.family": "sans-serif",
            "font.sans-serif": ["DejaVu Sans", "Helvetica", "Arial", "sans-serif"],
            "mathtext.fontset": "dejavusans",
        },
    )
