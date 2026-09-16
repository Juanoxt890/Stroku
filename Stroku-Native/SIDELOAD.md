# Stroku ES — sideload guide

This fork (`Juanoxt890/Stroku`) ships a Netflix-style dark UI and **Spanish as the default UI language** on first launch. All original languages remain available under **Ajustes → Interfaz → Idioma**.

## Package

From `Stroku-Native/`:

```bash
# Windows (repo script)
npm run package
# → dist/stroku-native.zip

# Linux/macOS fallback (zip the channel tree)
mkdir -p dist
rm -f dist/stroku-native.zip
zip -r dist/stroku-native.zip manifest source components images -x "*.DS_Store"
```

Sideload zip path: `Stroku-Native/dist/stroku-native.zip`

## Sideload onto a Roku

1. Enable **Developer mode** on the Roku (Settings → System → Advanced system settings → Developer options).
2. Note the Roku IP and set a developer password.
3. Open `http://<ROKU_IP>` in a browser, sign in with the developer password.
4. Upload `dist/stroku-native.zip` and install.
5. The channel appears as **Stroku ES** (manifest `title` + bumped `build_version`) so it can sit beside a store Stroku install without confusion.

## Language

- **Default on this fork:** Spanish (`LocaleDefaultLanguage` + first-launch `m.interfaceLanguage`).
- Change anytime: **Ajustes (Settings) → Interfaz (Interface) → Idioma (Language)**.
- English, French, German, Italian, and Portuguese stay available.
- Stored language in the Roku registry wins on later launches after you change it once.

## Notes

- Do not remove nav tabs, settings rows, add-on flows, calendar, library, discover, search, or player options — this fork only restyles and localizes defaults.
- UiScale (Settings → Interface) still maps the 1920×1080 design space to HD/FHD.
