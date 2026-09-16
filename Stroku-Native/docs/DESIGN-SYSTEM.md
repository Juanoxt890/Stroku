# A. Sistema de diseño TV — Stroku890

## Color
| Token | Hex | Uso |
|---|---|---|
| bg | `#0B0B0D` | Fondo app |
| surface | `#141416` | Paneles / cards |
| surface-2 | `#1A1A1D` | Chips, inputs |
| text | `#FFFFFF` | Primario |
| text-muted | `#B3B3B3` | Secundario |
| text-dim | `#808080` | Hints / IP |
| accent | `#E50914` | Foco, CTA, progreso **solo** |
| scrim | `#000000CC` | Texto sobre hero |

## Tipografía (1080p equivalentes)
- Display / hero título: LargeBold (~48–56)
- Fila / sección: MediumBold (~28–32)
- Body / sinopsis: Medium (~24–28), máx. 2 líneas
- Meta pills: SmallBold (~18–22)
- Roku system fonts (no custom TTF en canal sideload típico)

## Spacing / radii
- Grid 8 pt; márgenes safe ~5–8% (96–154 px en 1920)
- Radii visuales vía layout (SceneGraph Rectangle sin cornerRadius real en muchos builds) — simular con padding interno
- Gap posters fila: 16–22 px
- Gap filas: 16–24 px

## Focus spec
- Scale **1.08** (rango brief 1.08–1.12; no subir sin prueba en Express/Stick)
- Ring 3–4 px accent + inset oscuro (no solo color)
- Título del póster visible **solo** en foco
- Motion objetivo 150–250 ms cuando el firmware lo permita

## Elevation / motion
- Sin blur en cascada ni parallax
- Elevación = scale + ring; resto de la fila sin atenuación por-item (limitación RowList) salvo dim global futuro
