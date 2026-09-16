# F. Notas SceneGraph

- Autores en 1920×1080 + `UiScale.brs`
- Preferir RowList/MarkupGrid nativos; evitar árboles profundos
- No `Group.scale` > 1.08 en items de RowList (riesgo en Express)
- No tocar HttpTask / FetchBoardCatalogs / RebuildCatalog content building al rediseñar UI
- **Ver todo:** solo append al `rowNode.title` string en Board (`TrText("board.seeAll")`) — no nodos extra
- Cachear FindNode en init; posters con placeholder sólido (color fondo)
- Hero CTAs decorativos si OK del póster ya abre el título
- Player (`StrokuVideoPlayer`) fuera de `uiRoot` — fullscreen
- Documentar límites: atenuar vecinos en RowList no es trivial sin custom row component
- Sideload zip: `stroku890-vN.zip` + `build_version=N`; incluir `docs/` y brand assets
