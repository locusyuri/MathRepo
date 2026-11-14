"""Shared helpers for the 3D figures of this note.

Textbook style: a smooth white solid, a small number of drawn generatrices and
parallels, three coordinate axes as arrows, and no matplotlib axis box.
"""

from __future__ import annotations

import numpy as np

INK = "#1f2933"
GRID = "#55606b"
GHOST = "#8b949e"
AXIS = "#8b949e"


def setup(ax, lim=1.25, elev=18, azim=-60, zoom=1.25, box=(1, 1, 1)):
    """Configure one 3D panel; manual z-order for axes over the surface."""
    ax.computed_zorder = False
    ax.set_box_aspect(box, zoom=zoom)
    ax.view_init(elev=elev, azim=azim)
    ax.set_axis_off()
    ax.set_xlim(-lim, lim)
    ax.set_ylim(-lim, lim)
    ax.set_zlim(-lim, lim)


def axes(ax, length=1.15, labels=("x", "y", "z"), origin_label=True,
         color=INK):
    """Three coordinate axes as arrows, with labels at their tips."""
    lengths = (length, length, length) if np.isscalar(length) else length
    for vec, label, size in zip(np.eye(3), labels, lengths):
        tip = vec * size
        ax.quiver(0, 0, 0, tip[0], tip[1], tip[2], color=color, linewidth=1.1,
                  arrow_length_ratio=0.10, zorder=8)
        ax.text(*(tip * 1.05), f"${label}$", color=color, fontsize=11,
                ha="center", va="center", zorder=9)
    ax.plot([0], [0], [0], "o", color=color, ms=2.5, zorder=9)
    if origin_label:
        ax.text(0.05, 0.05, -0.14, r"$O$", color=color, fontsize=11, zorder=9)


def solid(ax, X, Y, Z, color="white"):
    """Smooth opaque solid (no grid lines)."""
    ax.plot_surface(X, Y, Z, rstride=1, cstride=1, color=color, linewidth=0,
                    alpha=1.0, shade=False, antialiased=True, zorder=2)


def wire(ax, X, Y, Z, n_lat=7, n_lon=12, color=GHOST, lw=0.45):
    """A few parallels (latitudes) and generatrices (longitudes)."""
    nu, nv = X.shape
    for i in np.linspace(0, nu - 1, n_lat, dtype=int):
        ax.plot(X[i, :], Y[i, :], Z[i, :], color=color, lw=lw, zorder=3)
    for j in np.linspace(0, nv - 1, n_lon, dtype=int):
        ax.plot(X[:, j], Y[:, j], Z[:, j], color=color, lw=lw, zorder=3)


def show(ax, X, Y, Z, n_lat=7, n_lon=12, **kw):
    solid(ax, X, Y, Z)
    wire(ax, X, Y, Z, n_lat=n_lat, n_lon=n_lon, **kw)


def curve(ax, x, y, z, color=INK, lw=1.1, ls="-", zorder=5):
    ax.plot(x, y, z, color=color, lw=lw, ls=ls, solid_capstyle="round",
            zorder=zorder)


def ellipse3d(ax, rx, ry, z, color=INK, lw=1.1, ls="-", n=180, zorder=5):
    t = np.linspace(0, 2 * np.pi, n)
    ax.plot(rx * np.cos(t), ry * np.sin(t), np.full_like(t, z), color=color,
            lw=lw, ls=ls, zorder=zorder)


# --- standard quadrics ---------------------------------------------------- #

def ellipsoid(a=1.0, b=0.75, c=0.6, nu=48, nv=72):
    u = np.linspace(-np.pi / 2, np.pi / 2, nu)
    v = np.linspace(0, 2 * np.pi, nv)
    U, V = np.meshgrid(u, v, indexing="ij")
    return a * np.cos(U) * np.cos(V), b * np.cos(U) * np.sin(V), c * np.sin(U)


def one_sheet(b=0.62, c=0.9, zmax=1.1, nu=48, nv=72):
    z = np.linspace(-zmax, zmax, nu)
    t = np.linspace(0, 2 * np.pi, nv)
    Z, T = np.meshgrid(z, t, indexing="ij")
    r = b * np.sqrt(1 + Z ** 2 / c ** 2)
    return r * np.cos(T), r * np.sin(T), Z


def two_sheet(b=0.75, c=0.9, zmax=1.45, nu=36, nv=72):
    """Returns two surfaces (upper and lower sheet)."""
    def sheet(sign):
        z = np.linspace(c, zmax, nu) * sign
        t = np.linspace(0, 2 * np.pi, nv)
        Z, T = np.meshgrid(np.abs(z), t, indexing="ij")
        r = b * np.sqrt(Z ** 2 / c ** 2 - 1)
        return r * np.cos(T), r * np.sin(T), sign * Z
    return sheet(1), sheet(-1)


def paraboloid(a=1.0, b=0.75, zmax=1.1, nu=36, nv=72):
    r = np.linspace(0, 1.0, nu)
    t = np.linspace(0, 2 * np.pi, nv)
    R, T = np.meshgrid(r, t, indexing="ij")
    Z = zmax * R ** 2
    return a * R * np.cos(T), b * R * np.sin(T), Z


def saddle(a=1.1, b=0.9, c=0.7, span=1.25, nu=48, nv=48):
    x = np.linspace(-span, span, nu)
    y = np.linspace(-span, span, nv)
    X, Y = np.meshgrid(x, y, indexing="ij")
    return X, Y, c * (X ** 2 / a ** 2 - Y ** 2 / b ** 2)


def torus(R=0.85, r=0.32, nu=40, nv=72):
    u = np.linspace(0, 2 * np.pi, nu)      # around the tube
    v = np.linspace(0, 2 * np.pi, nv)      # around the axis
    U, V = np.meshgrid(u, v, indexing="ij")
    return (R + r * np.cos(U)) * np.cos(V), (R + r * np.cos(U)) * np.sin(V), r * np.sin(U)


def cylinder(kind="elliptic", height=1.2, nu=36, nv=72):
    """A quadratic cylinder with generatrices parallel to z."""
    t = np.linspace(0, 2 * np.pi, nv)
    z = np.linspace(-height, height, nu)
    Z, T = np.meshgrid(z, t, indexing="ij")
    if kind == "elliptic":
        X, Y = 0.75 * np.cos(T), 0.55 * np.sin(T)
    elif kind == "hyperbolic":
        X, Y = 0.65 * np.cosh(T * 0.9) / np.cosh(2.8), 0.65 * np.sinh(T * 0.9) / np.sinh(2.8)
    else:  # parabolic
        X = 0.9 * (T / np.pi - 1) ** 2 - 0.35
        Y = 0.9 * (T / np.pi - 1)
    return X, Y, Z


def save(fig, path, dpi=160):
    """Save the SVG (plus a PNG preview when PREVIEW is set)."""
    import os

    fig.savefig(path, transparent=True, bbox_inches="tight", pad_inches=0.05)
    print(f"Saved: {path}")
    if os.environ.get("PREVIEW"):
        preview = str(path).replace(".svg", "-preview.png")
        fig.savefig(preview, dpi=dpi, facecolor="white", bbox_inches="tight",
                    pad_inches=0.05)
        print(f"Preview: {preview}")
