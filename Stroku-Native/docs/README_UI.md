# Stroku Native — UI capability inventory & Netflix-style map

**Phase 1 inventory + Phase 2 Home notes.** Documents product truth in `Stroku-Native/` and what Phase 2 Home Lolomo actually landed against **real** tasks/fields (no dummy JSON, no registry renames).

| Item | Value |
|---|---|
| Branch | `feature/premium-tv-ui` |
| Primary scene | `components/MainScene.xml` + `components/MainScene.brs` |
| Entry | `source/main.brs` → `MainScene` |
| Registry section | `Stroku` (exact name — do not rename) |
| Scope of this doc | Inventory + Feature→UI map + PRESERVE / DO NOT change + Home binding + gaps |

Related docs (do not replace this file): `COMPONENTS.md`, `REMOTE-MAPS.md`, `FEATURE-CHECKLIST.md`, `IMPLEMENTATION-PLAN.md`.

---

## 1. Screens / overlays / dialogs (component & group names)

### SceneGraph groups (`MainScene.xml`)

| Group / node id | Role | Driven by |
|---|---|---|
| `uiRoot` | Root chrome shell | always |
| `homeGroup` | Left rail + top bar + content column | `screenMode = "home"` |
| `heroBillboard` | Netflix-style billboard (poster, meta, title, description, CTAs) | `SetHeroBillboardVisible` / `SetHeroChromeEx` / `UpdateHeroFromItem` |
| `discoverFilterGroup` | Discover type / catalog / genre chips | `RenderDiscover` |
| `catalogList` | Board / Library / Search results RowList (`CatalogCard`) | `RebuildCatalog` |
| `discoverGrid` | Discover MarkupGrid (`CatalogCard`) | `RebuildDiscoverGrid` |
| `primaryInfoGroup` + `primaryInfoList` | Signed-out Library info actions | `RenderInfoList` |
| `calendarGroup` | Calendar list + detail panel (`CalendarCard`) | `RenderCalendar` |
| `settingsGroup` | Settings tabs + list + detail (`SettingsRow`) | `RenderSettings` |
| `addonsGroup` | Addon chips + list + detail (`AddonCard`) | `RenderAddons` |
| `episodeGroup` | Series seasons + episodes | `ShowEpisodeScreen` |
| `choiceGroup` | Generic choice / stream picker (`choiceList` / `streamList`) | `ShowChoices` |
| `noStreamsGroup` | Empty / no-playable-streams state | `ShowNoStreamsScreen` |
| `uiScaleGroup` | UI scale slider overlay | `OpenUiScaleSlider` |
| `coffeeGroup` | Support / coffee QR overlay | `OpenCoffeeSupport` |
| `statusBackdrop` / `spinner` / `statusLabel` | Loading / toast / status | `ShowStatus` / `HideStatus` |
| `setupAddress` | LAN setup IP hint (`http://IP:8324`) | `ShowSetupAddress` (`main.brs`) |
| `linkPollTimer` | Stremio link pairing poll | `BeginStremioLink` |
| `video` (`StrokuVideoPlayer`) | Fullscreen player (sibling of `uiRoot`) | `StartPlayback` |

### Overlay / dialog types (created in BRS, not XML groups)

| Dialog | Type | Function |
|---|---|---|
| Search | `KeyboardDialog` | `OpenSearch` → `onSearchButton` |
| Addon search | `KeyboardDialog` | `OpenAddonSearch` |
| Paste/configure manifest URL | `KeyboardDialog` | `OpenAddonConfiguration` |
| Discover filters | `Dialog` | `OpenDiscoverFilters` |
| Addon details (catalog) | `Dialog` | `ShowAddonDetails` |
| Installed addon details | `Dialog` | `ShowInstalledAddonDetails` |
| Share addon URL | `Dialog` | `ShareAddon` |
| Stremio link / pairing | `Dialog` | `HandleLinkCreateResponse` / `onLinkDialogButton` |
| Resume playback | `Dialog` | `PlayStream` → `onResumeDialogButton` |
| Exit video confirm | `Dialog` | `ConfirmExitVideo` |
| Exit app confirm | `Dialog` | `ConfirmExitApp` |
| Options / settings sheet | `Dialog` | `OpenSettings` / `onSettingsButton` |
| Subtitle settings sheet | `Dialog` | `OpenSubtitleSettings` |
| Settings link (support/source/terms/privacy) | `Dialog` | `OpenSettingsLink` |

### Item / task components

| Component | File | Used by |
|---|---|---|
| `CatalogCard` | `CatalogCard.xml/.brs` | `catalogList`, `discoverGrid` |
| `EpisodeCard` + `EpisodeContent` | `EpisodeCard.*`, `EpisodeContent.xml` | `episodeList` |
| `SeasonTab` | `SeasonTab.*` | `seasonGrid` |
| `StreamCard` | `StreamCard.*` | `streamList` |
| `AddonCard` + `AddonCardContent` | `AddonCard.*` | `addonList` |
| `CalendarCard` + `CalendarCardContent` | `CalendarCard.*` | `calendarList` |
| `SettingsRow` + `SettingsRowContent` | `SettingsRow.*` | `settingsList` |
| `HttpTask` | `HttpTask.xml/.brs` | All HTTP (catalogs, streams, library, link, addons) |
| `SubtitleTextTask` | `SubtitleTextTask.*` | External subtitle text fetch (player path) |
| `StrokuVideoPlayer` | `StrokuVideoPlayer.*` | Playback chrome |
| `Locale` / `UiScale` | `Locale.brs`, `UiScale.brs` | i18n + layout scale |

### `screenMode` values (exact)

`home` · `episodes` · `episodeLoading` · `choices` · `noStreams` · `video` · `uiScale` · `coffee`

---

## 2. Nav tabs / left rail / top bar

### Left rail (`navList`) — ids in `m.navIds` (identity, not label)

Exact ids: `board`, `discover`, `library`, `calendar`, `addons`, `settings`  
Labels: `TrText("nav." + id)` via `UpdateNavContent`  
Selection: `onNavSelected` → `SetActiveTab` → `RenderActiveTab`

| Id | Render | Content surface |
|---|---|---|
| `board` | `RenderBoard` | Hero + `catalogList` RowList |
| `discover` | `RenderDiscover` | Hero + filters + `discoverGrid` |
| `library` | `RenderLibrary` | Hero + rows **or** signed-out `primaryInfoList` |
| `calendar` | `RenderCalendar` | `calendarGroup` (list + detail) |
| `addons` | `RenderAddons` | chips + `addonList` + detail |
| `settings` | `RenderSettings` | tabs General / Interface / Player |

### Top bar (not a LabelList — focus via `m.topBarFocus`)

| Index | UI | Activate |
|---|---|---|
| 0 | `searchBar` / `searchPrompt` (“Buscar”) | `OpenSearch` |
| 1 | `supportChipBg` / `supportChipLabel` | `OpenCoffeeSupport` |

`TopBarItemCount` = 2 · `FocusTopBar` / `BlurTopBar` / `ActivateTopBarItem`

### Board row titles (`m.boardNames` — current Spanish strings)

1. Populares - Películas  
2. Populares - Series  
3. Destacadas - Películas  
4. Destacadas - Series  
5. YouTube - Canales  
6. Dominio público - Películas  

Presentation appends ` ·  ` + `TrText("board.seeAll")` on Board row titles in `RebuildCatalog`.

### Settings tabs (`m.settingsTabs`)

`General`, `Interface`, `Player` — labels via `TrText("settings.tab." + LCase(...))`

### Addon chips (`AddonChips`)

`addonFilterInstalled` · `addonFilterAll` · `addAddon` · `addonSearch` · (+ `reloadAddons` when installed filter)

### Discover filters

- Types: `movie`, `series`, `channel`  
- Catalogs: `Popular`, `Featured`, `New` → URL ids `top` / `imdbRating` / `year`  
- Genres: `None`, Action, Adventure, … Thriller  

---

## 3. Buttons / key handlers

### Global / home (`onKeyEvent` in `MainScene.brs`)

| Key | Context | Behavior |
|---|---|---|
| `options` (*) | not video | Settings / subtitle settings / discover filters / addon config / library toggle (episodes & stream choices) |
| `back` | home | other tab → board; board → `ConfirmExitApp` |
| `back` | video | `ConfirmExitVideo` |
| `back` | choices / episodes / noStreams | unwind stack |
| `left` / `right` | home | nav ↔ content; settings tabs; discover filters; addon chips; top bar |
| `up` / `down` | home | top bar / filters / chips / settings skip headers |
| `OK` | focused lists | select item / activate chip / settings row |

**Voice:** none found.

### Player (`StrokuVideoPlayer.brs`)

Keys used: `OK`, `back`, `play`, `replay`, `fastforward`, `rewind`, `left`, `right`, `up`, `down`  
Chrome buttons: `playButton`, `nextButton`, `subtitleButton`, `speedButton`, `audioButton`  
Actions emitted to MainScene (`onVideoAction`): `close`, `next`, `subtitleSyncOffset`, `subtitleSelection`

### Hero CTAs (Phase 2 wired)

`heroPrimaryLabel` = “Reproducir”, `heroSecondaryLabel` = “Más info” (`FocusHeroButtons` labels; `FocusHeroCtas` / `ActivateHeroCta` for focus+OK)  
Wired to `ActivateCatalogItem` (same path as `onCatalogSelected`). Catalog OK path unchanged. No My List stub on hero.

---

## 4. Settings keys / registry keys (exact current names)

**Section:** `roRegistrySection("Stroku")` — unchanged.

| Key | Load | Save | Purpose |
|---|---|---|---|
| `subtitleRenderMode` | `LoadSubtitlePreferences` | `SaveSubtitlePreferences` | Subtitle render mode |
| `subtitleFont` | same | same | Font |
| `subtitleTextSize` | same | same | Size |
| `subtitleTextColor` | same | same | Color |
| `subtitleBackdropOpacity` | same | same | Backdrop |
| `subtitlePosition` | same | same | Position |
| `subtitlesEnabledByDefault` | same | same | `"true"` / `"false"` |
| `interfaceLanguage` | `LoadInterfacePreferences` | `SaveInterfacePreferences` | UI language |
| `uiScalePercent` | same | same | Scale % string |
| `blurUnwatchedEpisodes` | same | same | `"true"` / `"false"` |
| `defaultSubtitleLanguage` | `LoadPlayerPreferences` | `SavePlayerPreferences` | Default sub lang |
| `subtitleDefaultMode` | same | same | Default mode |
| `lastSubtitleSelection` | same | same | Last selection |
| `subtitleOutlineColor` | same | same | Outline |
| `defaultAudioTrack` | same | same | Default audio |
| `subtitleSyncOffsets` | `LoadSubtitleSyncOffsets` | `SaveSubtitleSyncOffset` | JSON map id→offset |
| `stremioAuthKey` | `LoadStremioAccount` | link success / `DisconnectStremio` Delete | Auth |
| `addonManifestUrls` | `LoadAddonConfiguration` | `StoreAddonUrls` | JSON array of manifest URLs |

Do **not** document renames as if already applied.

---

## 5. Task nodes / request IDs / catalogs

### Tasks

| Task | Fields | Used for |
|---|---|---|
| `HttpTask` | `url`, `requestId`, `method`, `body`, `timeoutMs`, `response` | All API traffic |
| `SubtitleTextTask` | `url`, `requestId`, `response` | External subtitle bodies |

### `requestId` prefixes (pipe-separated; parsed in `onHttpResponse`)

| Prefix | Starter | Handler |
|---|---|---|
| `boardCatalog\|{rowIndex}` | `FetchBoardCatalogs` / `FetchCatalog` | `HandleCatalogResponse(..., "board")` |
| `discoverCatalog\|0` | `FetchDiscoverCatalog` | `HandleCatalogResponse(..., "discover")` |
| `search\|{0\|1\|2}` | `SearchCatalogs` | `HandleCatalogResponse(..., "search")` |
| `searchMeta\|{0\|1}` | IMDb id search | `HandleSearchMetaResponse` |
| `meta\|series` | `OpenSeriesEpisodes` | `HandleMetaResponse` |
| `calendarMeta\|{seriesId}` | `LoadCalendarEntries` | `HandleCalendarMetaResponse` |
| `{streamReq}\|{addonIndex}` | `FindStreams` via `StartStreamRequest` | `HandleStreamsResponse` |
| `{subReq}\|{addonIndex}` | `FindSubtitles` | `HandleSubtitlesResponse` |
| `addonLoad\|{index}` | `LoadAddonConfiguration` | `HandleLoadedAddon` |
| `addonCatalog\|all` | `FetchAddonCatalog` | `HandleAddonCatalogResponse` |
| `config\|addon` | `VerifyAddonConfiguration` | save path |
| `linkCreate\|stremio` | `BeginStremioLink` | `HandleLinkCreateResponse` |
| `linkRead\|stremio` | `onLinkPollTimer` | `HandleLinkReadResponse` |
| `libraryGet\|all` | `FetchLibrary` | `HandleLibraryResponse` |
| `libraryPut\|{id}` | `ToggleSelectedLibraryItem` | `HandleLibraryPutResponse` |
| `libraryPutSilent\|{id}` | `SavePlaybackProgress` | silent sync |

### Board catalog URLs (`FetchBoardCatalogs`)

1. `…/movie/top.json`  
2. `…/series/top.json`  
3. `…/movie/imdbRating.json`  
4. `…/series/imdbRating.json`  
5. `https://v3-channels.strem.io/catalog/channel/top.json`  
6. `https://caching.stremio.net/publicdomainmovies.now.sh/catalog/movie/publicdomainmovies.json`  

Addon streams: `{baseUrl}/stream/{type}/{id}.json`  
Subtitles: `{baseUrl}/subtitles/{type}/{id}.json`  
Collection: `https://api.strem.io/addonscollection.json`

---

## 6. Playback entry points

| Step | Function | UI |
|---|---|---|
| Movie / channel select | `OpenMovieStreams` → `FindStreams` | status → `choiceGroup` / `streamList` |
| Series select | `OpenSeriesEpisodes` → `meta\|series` → `ShowEpisodeScreen` | `episodeGroup` |
| Episode select | `onEpisodeSelected` → `FindStreams` | streams |
| Stream pick | `onChoiceSelected` → `FindSubtitles` → `PlayPendingStream` / `PlayStream` | optional resume `Dialog` |
| Start | `StartPlayback` | `StrokuVideoPlayer` visible, `screenMode=video` |
| Subtitles / audio / speed | player menus | `subtitleMenu`, `audioMenu`, `speedMenu` |
| Next episode | player `next` → `PlayNextEpisode` | same chrome |
| External URL / deep link | `PlayExternal` / `main.brs` `contentId` http | player |
| Progress sync | `SavePlaybackProgress` | library state + `libraryPutSilent` |

Stream ContentNode fields (picker): `title`, `sourceBadge`, `addonName`, `quality`, `seeds`, `sizeText`, `tracker`, `line1`, `line2`, `line3` (`BuildStreamContent`).

Playback ContentNode: `url`, `title`, optional `playStart`, `streamFormat`, `subtitleTracks`.

---

## 7. Pairing / auth / logout / setup IP

| Capability | Where |
|---|---|
| Setup LAN server `:8324` | `source/main.brs` `StartSetupServer` |
| Show setup URL | `ShowSetupAddress` → `setupAddress` label |
| POST manifest via setup | `HandleSetupHttpRequest` → `configurationUrl` → `onConfigurationUrlChanged` |
| Stremio link create/poll | `BeginStremioLink`, `link.stremio.com`, `linkPollTimer` |
| Store auth | registry `stremioAuthKey` |
| Disconnect / logout | `DisconnectStremio` (Delete key) |
| Library fetch | `FetchLibrary` when auth present |
| Signed-out Library / Calendar CTAs | `login` → `BeginStremioLink` |

---

## 8. Add-on install / remove / configure / paste manifest

| Action | Entry | Notes |
|---|---|---|
| Filter installed / all | addon chips | `DispatchAddonAction` |
| Add / paste URL | chip `addAddon` or `*` / KeyboardDialog | `OpenAddonConfiguration` |
| Search addons | chip + KeyboardDialog | `OpenAddonSearch` |
| Reload | chip | `ReloadAddons` |
| Install from catalog | card / details dialog | `VerifyAddonConfiguration` / load |
| Uninstall | installed details | `UninstallAddon` |
| Share URL | `ShareAddon` | redacts private/debrid-looking URLs |
| Search bar paste `…/manifest.json` | `SearchCatalogs` | installs |
| Search bar http(s) stream URL | `SearchCatalogs` | `PlayExternal` |
| Persist | `addonManifestUrls` JSON | `StoreAddonUrls` |

---

## 9. Search, library, continue watching, deep links, empty/offline

| Feature | Behavior |
|---|---|
| Search | Top bar → KeyboardDialog → movie/series/channel catalogs or IMDb meta |
| Library saved / watched rows | `library.row.saved` / `library.row.watched` from `libraryById` |
| Continue watching | **Phase 2:** optional Board row **Continuar viendo** when `libraryById` progress in `0 < p < 0.9`; else progress only on cards |
| Resume dialog | `dialog.resume.*` before play |
| Deep link | `args.contentId` http → `PlayExternal` |
| Empty library | hero empty copy |
| No streams | `noStreamsGroup` + `*` configure addons |
| Offline / HTTP errors | `ShowStatus` / request error handlers |
| Magnet / tvdb search | status unsupported messages |

---

## 10. Real ContentNode fields — Home hero + CatalogCard

### Source meta objects (Cinemeta / library — **not** ContentNode)

Used by `UpdateHeroFromItem` / `HomeHeroMeta` / `HomeHeroDescription` / selection:

| AssocArray key | Used for |
|---|---|
| `name` | Hero title / card title source |
| `poster` | Card poster; hero fallback |
| `background` | Hero poster preferred |
| `description` | Hero description (trim 180) |
| `releaseInfo` | Hero meta year (preferred) |
| `year` | Hero meta year fallback |
| `type` | `movie` / `series` / `channel` / `action` |
| `imdbRating` | Hero meta |
| `runtime` | Hero meta |
| `id` | Streams / library / progress lookup |
| `libraryItem` | Library wrapper only |

See-all synthetic item also uses: `id` (`seeall:{n}`), `poster` `""`, `description`, `rowIndex`.

### CatalogCard ContentNode fields (`RebuildCatalog` / `RebuildDiscoverGrid` → `CatalogCard.brs`)

| ContentNode field | Source | Card usage |
|---|---|---|
| `title` | `item.name` | Label (visible when focused) |
| `HDPosterUrl` | `item.poster` | Poster |
| `SDPosterUrl` | `item.poster` | Poster fallback |
| `progress` | `AddFields` from `libraryById[id].state.timeOffset/duration` if `0 < p < 0.9` | Progress bar |

Row ContentNode: `title` = row name (+ See All suffix on Board).

**No dummy JSON.** Progress is omitted when 0 or ≥ 0.9.

### Hero billboard nodes (not ContentNode — Labels/Poster)

| Node id | Bound from |
|---|---|
| `heroTitle` | `item.name` or chrome titles |
| `heroDescription` | `description` / tab chrome |
| `heroMeta` | `HomeHeroMeta` (`releaseInfo|year`, type, `imdbRating`, `runtime`) |
| `heroPoster` | `background` else `poster` |
| `heroPrimaryLabel` / `heroSecondaryLabel` | Fixed “Reproducir” / “Más info” |

Focus path: `onCatalogFocused` / `onDiscoverGridFocused` → `UpdateHeroFromItem`.

### EpisodeContent (related; not Home)

`title`, `description`, `HDPosterUrl`, `SDPosterUrl`, `episodeLabel`, `shortDescriptionLine1`, `progress`, optional `blurThumbnail`.

---

## 11. Feature → Netflix-style UI surface map

| # | Current capability | Cite | New chrome surface |
|---|---|---|---|
| 1 | Left nav tabs | `navList`, `m.navIds`, `SetActiveTab` | **Left rail** |
| 2 | Board / Home rows | `RenderBoard`, `catalogList`, `FetchBoardCatalogs` | **Rows** under Hero |
| 3 | Hero billboard | `heroBillboard`, `UpdateHeroFromItem` | **Hero** |
| 4 | Hero CTAs Reproducir / Más info | `FocusHeroCtas` / `ActivateHeroCta` → `ActivateCatalogItem` | **Hero CTA** (P2 wired) |
| 5 | Top search | `OpenSearch`, `searchBar` | **Left rail / top** Search |
| 6 | Support / coffee | `OpenCoffeeSupport`, `coffeeGroup` | **Dialog** / rail footer |
| 7 | Discover filters + grid | `RenderDiscover`, `discoverGrid` | **Row** + filter chips / Discover page |
| 8 | Library saved/watched | `RenderLibrary`, `RebuildLibraryCatalogItemsFromMap` | **Rows** (My List / Continue) |
| 9 | Library signed-out login | `RenderInfoList` + `login` | **Dialog** / rail account |
| 10 | Calendar upcoming | `RenderCalendar`, `calendarGroup` | **Gap → rail item + detail** |
| 11 | Settings General/Interface/Player | `RenderSettings`, `Build*SettingsRows` | **Settings** |
| 12 | Add-ons manage | `RenderAddons`, chips, `AddonCard` | **Gap → Settings / rail** |
| 13 | Paste manifest / setup IP | `OpenAddonConfiguration`, `setupAddress`, `:8324` | **Dialog** + setup hint |
| 14 | Stremio pair / disconnect | `BeginStremioLink`, `DisconnectStremio` | **Dialog** |
| 15 | Series episodes / seasons | `episodeGroup`, `SeasonTab`, `EpisodeCard` | **Details** |
| 16 | Stream picker | `choiceGroup`, `StreamCard`, `FindStreams` | **Details** / play sheet |
| 17 | No streams empty | `noStreamsGroup` | **Empty state** |
| 18 | Resume dialog | `PlayStream` resume `Dialog` | **Dialog** |
| 19 | Player chrome | `StrokuVideoPlayer` overlay/menus | **Player chrome** |
| 20 | Next episode | `PlayNextEpisode`, `hasNextEpisode` | **Player chrome** |
| 21 | Subtitles / audio / sync | player + registry subtitle* keys | **Player chrome** + Settings |
| 22 | Options (*) | `onKeyEvent` options | **Dialog** / options sheet |
| 23 | UI scale slider | `uiScaleGroup` | **Settings** overlay |
| 24 | Status / spinner | `ShowStatus` | **Toast** |
| 25 | Exit video / app | confirm dialogs | **Dialog** |
| 26 | Deep link external play | `main.brs` `contentId` | **Player** (no Home) |
| 27 | Progress on posters | `RebuildCatalog` `progress` | **Row** cards |
| 28 | See All board action | `OpenBoardSeeAll` | **Row** end / Discover jump |
| 29 | Locale languages | `Locale.brs`, `interfaceLanguage` | **Settings** |
| 30 | Playback progress sync | `SavePlaybackProgress` | invisible; feeds Continue |

**Mapped feature count: 30** (user-facing capabilities above).

---

## 12. PRESERVE list

- All `m.navIds` tab identities and `SetActiveTab` / `Render*` routing  
- `HttpTask` + every `requestId` prefix and URL builders (`FetchBoardCatalogs`, `DiscoverCatalogUrl`, stream/subtitle paths)  
- Registry section `Stroku` and **exact** key names listed in §4  
- Catalog → ContentNode mapping: `title`←`name`, `HDPosterUrl`/`SDPosterUrl`←`poster`, optional `progress`  
- Hero meta sources: `name`, `background`/`poster`, `description`, `releaseInfo`/`year`, `type`, `imdbRating`, `runtime`  
- Library `libraryById` / datastoreGet/Put / watched bitfield encode-decode  
- Stremio link create/read + `stremioAuthKey`  
- Addon manifest URL list + install/uninstall/share/redaction  
- Setup server port **8324** and `configurationUrl` bridge  
- `screenMode` stack and Back unwind  
- `options` key semantics per tab/mode  
- `StrokuVideoPlayer` action contract (`close`/`next`/subtitle*)  
- Resume threshold and progress bar band `0 < p < 0.9`  
- Locale/`TrText` keys; do not hard-break i18n for rail labels  
- Focus traps already fixed for empty RowList / Addons chips / settings headers  

---

## 13. DO NOT change list (Phase 1 and restyle safety)

- Do **not** rename registry keys or invent a new section  
- Do **not** replace `boardCatalog` / `discoverCatalog` / stream request id schemes  
- Do **not** feed CatalogCard dummy JSON; keep binding to live `m.boardRows` / library maps  
- Do **not** remove Calendar, Add-ons, setup IP, coffee, or pairing to “look more Netflix”  
- Do **not** delete `noStreamsGroup`, resume dialog, or exit confirms  
- Do **not** change `addonManifestUrls` JSON shape or silent library put  
- Do **not** retarget `HttpTask` / `SubtitleTextTask` interfaces casually  
- Do **not** treat hero CTA labels as already focus-navigable without wiring  
- Do **not** drop `progress` AddFields when restyling CatalogCard  
- Do **not** rewrite product code in Phase 1 beyond this doc (and optional tiny comments)  

---

## 14. Proposed Home binding (real tasks/fields only)

```
init / LoadHomeCatalogs / FetchBoardCatalogs
  → HttpTask requestId boardCatalog|{0..5}
  → HandleCatalogResponse(..., "board") fills m.boardRows
  → RebuildCatalog() builds ContentNode rows:
        row.title = m.boardNames[i] (+ See All suffix)
        item.title / HDPosterUrl / SDPosterUrl / optional progress
  → catalogList (CatalogCard) displays rows
  → onCatalogFocused → UpdateHeroFromItem(meta assoc):
        heroTitle ← name
        heroPoster ← background || poster
        heroDescription ← description
        heroMeta ← HomeHeroMeta(...)
  → onCatalogSelected → OpenMovieStreams | OpenSeriesEpisodes | OpenBoardSeeAll
```

Optional Phase 2 Continue row: filter `m.watchedItems` / `libraryById` where `state.timeOffset` yields `0 < progress < 0.9` — **same** ContentNode fields as CatalogCard; no new API.

Hero CTA Phase 2: on OK while hero focused, call same handlers as `onCatalogSelected` for `m.selectedItem` / focused catalog item — still no dummy data.

---

## 15. Gaps — no clean Netflix analogue (where they live)

| Feature | Netflix analogue? | Place in new chrome |
|---|---|---|
| Add-ons install/collection/paste manifest | No | **Settings** subsection or rail **Add-ons**; keep `addonsGroup` flows |
| Setup IP `:8324` | No | Small **Settings** / footer hint (`setupAddress`) |
| Calendar releases | Weak (Coming soon) | Left rail **Calendar** + detail panel |
| Coffee / support QR | No | Top chip or Settings help (keep `coffeeGroup`) |
| Stream quality/seeds/debrid picker | No (NF hides sources) | **Details** play sheet (`StreamCard`) before Player |
| Discover genre/catalog chips | Partial | Discover page filter row |
| UI scale % overlay | No | Settings |
| Blur unwatched episodes | No | Settings Interface |
| Share addon URL / token redaction | No | Add-ons detail dialog |
| Magnet/tvdb unsupported statuses | No | Toast (`ShowStatus`) |
| Public-domain / YouTube channel rows | Partial | Keep as Board **rows** |

---

## 16. Top risks if restyle drops features

1. **Add-on install/remove** broken → no streams/subtitles.  
2. **Registry key rename** → users lose auth, addons, subtitle prefs.  
3. **Dropping `progress`** → Continue Watching / resume UX gone.  
4. **Breaking `boardCatalog|N` ids** → empty Home.  
5. **Removing pairing / `stremioAuthKey`** → Library/Calendar/progress sync die.  
6. **Losing setup `:8324` / paste manifest** → TV-hostile addon setup.  
7. **Simplifying away stream picker metadata** → wrong source / no debrid path.  
8. **Options (*) semantics changed** → unreachable settings/filters/library toggle.  
9. **Player next/subtitle/audio chrome removed** → series binge & a11y regression.  
10. **Focus traps reintroduced** (empty RowList, addon chips, settings headers) → “dead remote”.  

---

## 17. Phase-2 Home brief (one paragraph)

Implement Netflix Home **only** against existing Board pipeline: keep `FetchBoardCatalogs` → `HttpTask` `boardCatalog|{i}` → `HandleCatalogResponse` → `m.boardRows` / `m.boardNames` → `RebuildCatalog` ContentNodes (`title`, `HDPosterUrl`, `SDPosterUrl`, optional `progress`) into `catalogList`/`CatalogCard`; drive `heroBillboard` exclusively via `UpdateHeroFromItem`/`HomeHeroMeta`/`HomeHeroDescription` reading live meta keys (`name`, `background`/`poster`, `description`, `releaseInfo`/`year`, `type`, `imdbRating`, `runtime`); wire Hero CTAs to the same `OpenMovieStreams`/`OpenSeriesEpisodes` path as `onCatalogSelected` without new JSON; optionally add a Continue row from `libraryById` progress using the same CatalogCard fields; preserve left rail ids, search/coffee top bar, registry keys, and all non-Home screens behind the rail.

---

## Comment map (for engineers)

```
' UI MAP (see docs/README_UI.md):
' Left rail  -> navList / m.navIds
' Hero       -> heroBillboard / UpdateHeroFromItem
' Rows       -> catalogList + CatalogCard (title, HDPosterUrl, progress)
' Details    -> episodeGroup / choiceGroup streams
' Settings   -> settingsGroup + registry Stroku.*
' Dialogs    -> KeyboardDialog/Dialog helpers + coffee/uiScale/status
' Player     -> StrokuVideoPlayer
```

---

## 18. Phase 2 — what landed (Home Lolomo / build 15)

Shipped in `feature/premium-tv-ui` as **stroku890-v15** (`build_version=15`). Home restyle + binding only; Details/Search/Settings/Player left alone except shared chrome helpers.

### Binding (unchanged pipeline)

- `FetchBoardCatalogs` → `HttpTask` `boardCatalog|{i}` → `HandleCatalogResponse(..., "board")` → `m.boardRows` / `m.boardNames`
- `SyncBoardCatalogRows()` builds `m.catalogRows` / `m.catalogNames` for Home
- `RebuildCatalog` → `catalogList` / `CatalogCard` (`title`, `HDPosterUrl`, `SDPosterUrl`, optional `progress`)
- Hero still via `UpdateHeroFromItem` / `HomeHeroMeta` / `HomeHeroDescription` on live meta (`name`, `background||poster`, `description`, `releaseInfo|year`, `type`, `imdbRating`, `runtime`)

### UI / behavior landed

| Item | Notes |
|---|---|
| Home bg | `#0B0B0B` (was `#0B0B0D` close) + accent `#E50914` |
| Left rail | Preserved ids `board/discover/library/calendar/addons/settings` |
| Hero ~55% | Existing ~580px billboard; CTAs **Reproducir** / **Más info** |
| Hero CTA wiring | `FocusHeroCtas` / `ActivateHeroCta` → `ActivateCatalogItem` → same `OpenMovieStreams` / `OpenSeriesEpisodes` / `OpenBoardSeeAll` as catalog OK |
| Hero focus path | UP from Board/Library rows → CTAs → UP again → top bar; DOWN returns to rows; OK activates |
| Hero debounce | `heroDebounceTimer` 200ms → `onHeroDebounceFire` |
| Continue row | **Only if** `libraryById` has `0 < progress < 0.9`; title **Continuar viendo**; same CatalogCard fields; prepended via `SyncBoardCatalogRows` |
| My List CTA | **Not** added (no Home library-toggle control; Options/* library toggle remains on episodes/streams) |
| CatalogCard | `drawFocusFeedback=false`, thick red ring, focus scale **1.12** |
| Search | Short **Buscar** |
| Setup IP | Remains hidden on Home chrome (`ShowSetupAddress` keeps text for Options/debug) |
| Empty catalogs | Still-loading rows omitted from RowList; failed `boardCatalog` → `MarkBoardRowEmpty` header + **Sin títulos** empty state; `FocusBoardOrNav` / `CatalogHasItems` avoid empty focus traps |
| GetCatalogItem | Maps compacted RowList row index → non-empty `m.catalogRows` |

### Explicitly untouched

Registry section `Stroku` + keys · HttpTask / addon protocol · stream URL selection · `StrokuVideoPlayer` · Details/Search/Settings rewrites · nav ids · requestId prefixes

