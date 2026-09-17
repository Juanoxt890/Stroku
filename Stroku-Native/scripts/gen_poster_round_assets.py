#!/usr/bin/env python3
"""Regenerate CatalogCard corner-matte / focus ring / see-all bg (no maskUri)."""
# Run: /tmp/pilvenv/bin/python scripts/gen_poster_round_assets.py
from PIL import Image, ImageDraw, ImageChops
import os
ROOT = os.path.join(os.path.dirname(__file__), "..")
OUT = os.path.join(ROOT, "images")
POSTER_W, POSTER_H, FRAME_W, FRAME_H = 208, 310, 220, 322
INSET, OVERLAP, RADIUS = 6, 2, 20
HOME_BG = (11, 11, 11, 255)  # #0B0B0B
RED, SEE_ALL, SCALE = (229, 9, 20, 255), (26, 26, 29, 255), 8

def ss_rounded_alpha(w, h, r, scale=SCALE):
    sw, sh, sr = w * scale, h * scale, max(0, int(round(r * scale)))
    im = Image.new("L", (sw, sh), 0)
    ImageDraw.Draw(im).rounded_rectangle([0, 0, sw - 1, sh - 1], radius=sr, fill=255)
    return im.resize((w, h), Image.Resampling.BOX)

def to_rgba(rgb, alpha):
    base = Image.new("RGB", alpha.size, rgb[:3])
    return Image.merge("RGBA", (*base.split(), alpha))

# Soft AA hole: opaque home-bg in corners OUTSIDE the rounded rect, transparent inside.
poster_hole = ss_rounded_alpha(POSTER_W, POSTER_H, RADIUS)
matte_a = ImageChops.invert(poster_hole)
to_rgba(HOME_BG, matte_a).save(f"{OUT}/poster_round_matte.png")

# Optional legacy mask (unused by CatalogCard); keep for tooling parity.
to_rgba((255, 255, 255), poster_hole).save(f"{OUT}/poster_mask_round.png")
to_rgba(SEE_ALL, poster_hole).save(f"{OUT}/see_all_bg_round.png")

outer_a = ss_rounded_alpha(FRAME_W, FRAME_H, RADIUS + INSET)
hole_a = ss_rounded_alpha(POSTER_W - 2 * OVERLAP, POSTER_H - 2 * OVERLAP, max(0, RADIUS - OVERLAP))
hole = Image.new("L", (FRAME_W, FRAME_H), 0)
hole.paste(hole_a, (INSET + OVERLAP, INSET + OVERLAP))
ring_a = ImageChops.multiply(outer_a, ImageChops.invert(hole))
to_rgba(RED, ring_a).save(f"{OUT}/poster_focus_ring_round.png")
print("ok matte+ring", RADIUS, INSET, OVERLAP, "bg=#0B0B0B")
