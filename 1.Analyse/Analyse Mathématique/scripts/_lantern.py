"""Shared drawing helpers for the Schwarz lantern figures.

Everything is drawn in an isometric projection with a tiny painter's algorithm:
the faces are sorted by depth and painted from back to front, and each face is
shaded by the angle between its normal and a fixed light direction.
"""

from __future__ import annotations

from math import cos, pi, sin

import numpy as np
from matplotlib.patches import Polygon

INK = "#1f2933"
RED = "#c81e1e"

TOP_COLOR = np.array([0.97, 0.86, 0.55])
SIDE_COLOR = np.array([0.46, 0.55, 0.78])

LIGHT = np.array([0.35, -0.50, 0.80])
LIGHT = LIGHT / np.linalg.norm(LIGHT)
VIEW = np.array([1.0, 1.0, 1.3])
VIEW = VIEW / np.linalg.norm(VIEW)

COS30, SIN30 = cos(pi / 6), sin(pi / 6)


def project(points):
    """Isometric projection: z stays vertical, x/y spread symmetrically."""
    points = np.asarray(points, dtype=float)
    x, y, z = points[:, 0], points[:, 1], points[:, 2]
    return np.column_stack([(x - y) * COS30, z - (x + y) * SIN30])


def normal_of(vertices):
    if len(vertices) < 3:
        return np.array([0.0, 0.0, 1.0])
    a, b, c = (np.asarray(v, dtype=float) for v in vertices[:3])
    n = np.cross(b - a, c - a)
    norm = np.linalg.norm(n)
    return n / norm if norm > 1e-12 else np.array([0.0, 0.0, 1.0])


def paint(ax, faces, linewidth=0.35):
    """Draw (vertices, kind) faces back to front."""
    entries = []
    for vertices, kind in faces:
        vertices = np.asarray(vertices, dtype=float)
        depth = float(np.mean(vertices @ VIEW))
        entries.append((depth, vertices, kind))
    entries.sort(key=lambda item: item[0])

    for depth, vertices, kind in entries:
        pts = project(vertices)
        lam = abs(float(normal_of(vertices) @ LIGHT))
        factor = (0.62 + 0.38 * lam) if linewidth else (0.84 + 0.16 * lam)
        base = TOP_COLOR if kind == "top" else SIDE_COLOR
        colour = np.clip(base * factor, 0, 1)
        if linewidth:
            edge, lw = (0.16, 0.18, 0.24, 0.5), linewidth
        else:
            # paint the seam with the face colour so no white gaps remain
            edge, lw = colour, 0.6
        ax.add_patch(Polygon(
            pts, closed=True, facecolor=colour, edgecolor=edge, lw=lw,
            joinstyle="round", antialiased=False, zorder=2 + depth))


def _front_segments(x, y, n):
    """Split a closed ring into the arcs facing the viewer."""
    keep = (x + y) >= -0.01
    index = np.where(keep)[0]
    if len(index) == 0:
        return []
    breaks = np.where(np.diff(index) != 1)[0] + 1
    return [seg for seg in np.split(index, breaks) if len(seg) > 1]


def ring(ax, z, radius=0.5, n=240, colour=RED, lw=1.0, full=False,
         zorder=6):
    t = np.linspace(0, 2 * pi, n)
    x, y = radius * np.cos(t), radius * np.sin(t)
    groups = [np.arange(n)] if full else _front_segments(x, y, n)
    for seg in groups:
        pts = np.column_stack([x[seg], y[seg], np.full(len(seg), z)])
        p2 = project(pts)
        ax.plot(p2[:, 0], p2[:, 1], color=colour, lw=lw, zorder=zorder)


def dots(ax, vertices, front_only=True, size=4.0, top_z=None):
    vertices = np.asarray(vertices, dtype=float)
    if front_only:
        keep = (vertices[:, 0] + vertices[:, 1] > -0.03)
        if top_z is not None:
            keep = keep | np.isclose(vertices[:, 2], top_z)
        vertices = vertices[keep]
    p2 = project(vertices)
    ax.plot(p2[:, 0], p2[:, 1], "o", color=RED, ms=size, mew=0, zorder=9)


def cylinder_faces(b, p, radius=0.5, height=1.0, stagger=True):
    """Triangulated lantern with b bands and p points per circle."""
    def vertex(i, j):
        offset = (pi / p) * (i % 2) if stagger else 0.0
        angle = 2 * pi * j / p + offset
        return [radius * cos(angle), radius * sin(angle), height * i / b]

    faces = []
    for i in range(b):
        for j in range(p):
            a = vertex(i, j)
            bb = vertex(i, (j + 1) % p)
            c = vertex(i + 1, j)
            d = vertex(i + 1, (j + 1) % p)
            faces.append(([a, bb, c], "side"))
            faces.append(([bb, c, d], "side"))

    faces.append(([vertex(b, j) for j in range(p)], "top"))
    return faces


def smooth_cylinder(n=160, radius=0.5, height=1.0):
    """A cylinder drawn with n thin quads plus its top disc."""
    faces = []
    for j in range(n):
        a0, a1 = 2 * pi * j / n, 2 * pi * (j + 1) / n
        p0 = [radius * cos(a0), radius * sin(a0)]
        p1 = [radius * cos(a1), radius * sin(a1)]
        faces.append(([p0 + [0.0], p1 + [0.0], p1 + [height], p0 + [height]],
                      "side"))
    top = [[radius * cos(2 * pi * j / n), radius * sin(2 * pi * j / n),
            height] for j in range(n)]
    faces.append((top, "top"))
    return faces


def finished(ax, xlim=(-0.98, 0.98), ylim=(-0.45, 1.42)):
    ax.set_xlim(*xlim)
    ax.set_ylim(*ylim)
    ax.set_aspect("equal")
    ax.axis("off")
