# B / E. Wireframes de mando y foco por pantalla

## Home (Inicio)
| Tecla | Acción |
|---|---|
| Left (desde filas) | Nav |
| Right (desde nav) | Catalog RowList |
| Up | Top bar (Buscar / Apoyar) |
| Down | Siguiente fila |
| OK | Abre título (streams / episodios) |
| Back | Top bar → nav / salir diálogo |
| * | Options (Conectar Stremio, Ajustes, …) |

Foco inicial: primer póster del Board cuando hay ítems. No atrapar remoto en RowList vacío.

## Discover
| Tecla | Acción |
|---|---|
| Up (en grid) | Fila filtros Tipo / Catálogo / Género |
| Left/Right en filtros | Entre chips |
| OK en filtro | Cicla valor |
| Down | Vuelve al grid |
| Left desde grid/filtros | Nav |
| * | Diálogo filtros (mismo ciclo) |

## Detalle / Streams (`choiceGroup`)
| Tecla | Acción |
|---|---|
| Up/Down | Lista StreamCard |
| OK | Reproduce / selecciona |
| Back | Home o episodios |
| * | (desde no-streams) configurar complementos |

Priorizar HTTP/Debrid en orden de lista (lógica existente; UI etiqueta Audio/Subs).

## Episodios
| Tecla | Acción |
|---|---|
| Left/Right | SeasonTab |
| Down | EpisodeCard list |
| OK | Streams del episodio |
| Back | Home / Board |

## Player
| Tecla | Acción |
|---|---|
| OK | Play/pause o confirma menú |
| Left/Right | Seek / botones overlay |
| Up/Down | Filas de controles / listas menú |
| Back | Cierra menú o sale (confirmación) |

## Settings
Tabs Left/Right; lista Up/Down; OK cicla/acción; Back a nav.

## Add-ons
Chips Left/Right; lista Up/Down; OK install/share; Back a nav.

## Pairing
Diálogo modal Roku; OK Done; poll link.stremio.com (sin cambiar API).

## Calendar
Lista Up/Down; detail sigue foco; OK abre serie / login.
