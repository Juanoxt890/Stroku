# F. Notas SceneGraph

- Autores en 1920×1080 + `UiScale.brs`
- Preferir RowList/MarkupGrid nativos; evitar árboles profundos
- No `Group.scale` > 1.08 en items de RowList (riesgo en Express)
- No tocar HttpTask / FetchBoardCatalogs al rediseñar UI
- Cachear FindNode en init; posters con placeholder sólido (color fondo)
- Hero CTAs decorativos si OK del póster ya abre el título
- Documentar límites: atenuar vecinos en RowList no es trivial sin custom row component
