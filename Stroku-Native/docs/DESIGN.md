# Stroku890 — Design system (TV / Roku Native)

Fuente de verdad del brief del usuario. Implementación **incremental** sobre la base que ya carga Board; nunca romper HTTP, catálogos ni foco del mando.

## A. Tokens

| Token | Valor |
|---|---|
| bg | `#0B0B0D` (`0x0B0B0DFF`) |
| surface | `#141416` (`0x141416FF`) |
| surface-2 | `#1A1A1D` (`0x1A1A1DFF`) |
| text | `#FFFFFF` |
| text-muted | `#B3B3B3` |
| text-dim | `#808080` |
| accent | `#E50914` (solo foco / CTA / progreso) |
| focus-scale | `1.08` (máx. en cards; no subir sin probar en device) |
| focus-ring | 3–4 px accent |
| motion | 150–250 ms (cuando SceneGraph lo permita) |
| spacing | grid 8 pt |
| safe | márgenes ~5–8% / overscan |

Tipografía: system TV sans (LargeBold títulos, Medium body, Small meta). Posters 2:3 en filas; 16:9 en continue/episodios cuando aplique.

## B. Mando (mapa base Home)

| Tecla | Comportamiento |
|---|---|
| Right desde nav | primer póster / contenido activo |
| Left desde filas | nav |
| Up desde filas | top bar (Buscar / Apoyar) o hero chrome |
| Down | siguiente fila |
| OK | abre foco (detalle / streams) |
| Back | contexto anterior |
| * | menú Options contextual |

## C–E. Pantallas

Prioridad de implementación: **Home → Streams → Player overlay → Pairing → Add-ons → resto**. Mock Home objetivo: `docs/home-target-mock.png`.

## F. SceneGraph notes

- No `Group.scale` agresivo en items de RowList (>1.08 arriesgado).
- No reconstruir ContentNode si no hace falta; no tocar HttpTask sin prueba en device.
- Hero CTAs pueden ser decorativos si OK ya abre el ítem enfocado.
- Pocos nodos; Poster + Label + Rectangle; sin blur en cascada.

## H. Checklist no perder features

- [x] Board / Discover / Library / Calendar / Add-ons / Settings
- [x] Búsqueda / pegar enlace / add-on URL
- [x] Streams + player + subtítulos
- [x] Pairing Stremio + setup `:8324`
- [x] Español por defecto
- [ ] Continue watching row (cuando haya progreso de biblioteca)
- [ ] Options sheet unificado (*)
- [ ] Onboarding 3 pasos no vinculado
