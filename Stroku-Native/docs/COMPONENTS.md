# D. Componentes → SceneGraph

| Componente brief | Archivo actual |
|---|---|
| PosterCard | `CatalogCard.xml/.brs` |
| Row | `MainScene` RowList `catalogList` |
| HeroBillboard | `MainScene` `heroBillboard` |
| MetaPills | `heroMeta` label (línea ·) |
| StreamRow | `StreamCard.xml/.brs` |
| PairingCode | flujos link en `MainScene.brs` + UI status |
| SubtitlePreview | `StrokuVideoPlayer` + settings subtítulos |
| OptionsSheet | menú `*` / settings rows |
| SearchKeyboard | `KeyboardDialog` Roku |
| EmptyState | `noStreamsGroup` + status |
| Toast/Banner | `statusLabel` / `statusBackdrop` |
| Season/Episode | `SeasonTab`, `EpisodeCard` |
| Addon row | `AddonCard` |
| Settings row | `SettingsRow` |
| Calendar row | `CalendarCard` |
| Locale | `Locale.brs` |
| HTTP (no UI) | `HttpTask` — **no restyle logic** |

## Groups (`MainScene.xml`)

`homeGroup`, `heroBillboard`, `discoverFilterGroup`, `primaryInfoGroup`, `calendarGroup`, `settingsGroup`, `addonsGroup`, `episodeGroup`, `choiceGroup`, `noStreamsGroup`, `uiScaleGroup`, `coffeeGroup`, `video` (sibling of `uiRoot`).
