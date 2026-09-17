# Stroku890 — Implementation plan (premium TV UI)

Branch: `feature/premium-tv-ui` · Base restored from `cac7bed` + Stroku890 branding.

## Screen-by-screen status

| Screen | Status | Notes |
|---|---|---|
| Splash / icons | Done (v10+) | splash_hd, icon_hd/sd, brand_lockup |
| Home / Board | Done (v11) + polish v12 | Hero, lockup, focus titles, Buscar; v12 adds Ver todo on row titles (string only) |
| Discover filters | Restyled v12 | surface/accent chips |
| Discover grid | Restyled v12 | CatalogCard tokens |
| Library | Restyled + ES wire v12 | Locale for signed-out/in chrome; row titles |
| Calendar | Restyled v12 | panels surface |
| Settings | Restyled v12 | tabs/panels surface-2 |
| Add-ons | Restyled v12 | chips accent (no green CTA); panels |
| Stream picker | Polished v12 | StreamCard colors only |
| Episodes / seasons | Restyled v12 | EpisodeCard + SeasonTab |
| Player overlay | Restyled v12 | menus surface; progress accent |
| No-streams / empty | Restyled + ES v12 | hints via TrText |
| Pairing / link | ES short copy v12 | dialog.connect.* |
| Options (*) | Partial | labels via existing Locale; unified sheet deferred |
| Continue watching row | Deferred | progress bars exist; dedicated row later |
| Onboarding 3-step | Deferred | not in scope |

## Safety gates (must stay green)

- Board still uses `FetchBoardCatalogs` → `HttpTask` → `HandleCatalogResponse` / boardCatalog path
- No CompleteBoardCatalogRequest race reintroduced
- CatalogCard focus scale ≤ 1.08
- No DesignTokens module that breaks components
- Remote focus traps for empty RowList remain fixed

## Sideload versioning

| Zip | build_version |
|---|---|
| stroku890-v10.zip | 10 |
| stroku890-v11.zip | 11 |
| stroku890-v12.zip | 12 |

Package must include `manifest`, `source/`, `components/`, `images/`, `docs/`.

## Commit plan (v12)

1. `docs: full design package A–H`
2. `feat(ui): restyle secondary shells (discover/library/calendar/settings/addons)`
3. `feat(ui): premium stream/episode/player chrome`
4. `chore: bump build_version=12 and package stroku890-v12.zip`
