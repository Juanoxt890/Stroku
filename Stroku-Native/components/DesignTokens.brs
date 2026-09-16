' Shared Netflix/Disney+-inspired design tokens for Stroku-Native.
' XML still hardcodes hex colors (SceneGraph cannot call these), but every
' BrightScript color assignment should prefer these helpers so the palette stays
' a single source of truth across cards, chrome, and focus states.

function ThemeBg() as string
    return "0x141414FF"
end function

function ThemeBgElevated() as string
    return "0x0B0B0BFF"
end function

function ThemeSurface() as string
    return "0x1A1A1AFF"
end function

function ThemeSurfaceRaised() as string
    return "0x1F1F1FFF"
end function

function ThemeSurfaceMuted() as string
    return "0x181818FF"
end function

function ThemeSurfaceHover() as string
    return "0x2A2A2AFF"
end function

function ThemeFocusFill() as string
    return "0x3A1518FF"
end function

function ThemeAccent() as string
    return "0xE50914FF"
end function

function ThemeAccentSoft() as string
    return "0x3A1518FF"
end function

function ThemeTextPrimary() as string
    return "0xFFFFFFFF"
end function

function ThemeTextSecondary() as string
    return "0xE5E5E5FF"
end function

function ThemeTextMuted() as string
    return "0xB3B3B3FF"
end function

function ThemeTextDim() as string
    return "0x808080FF"
end function

function ThemeSuccess() as string
    return "0x46D369FF"
end function

function ThemeTrack() as string
    return "0x333333FF"
end function

function ThemeOverlay() as string
    return "0x0B0B0BF5"
end function

function ThemeStatusBackdrop() as string
    return "0x141414F2"
end function

' Catalog / poster card geometry in design space.
function ThemePosterWidth() as integer
    return 190
end function

function ThemePosterHeight() as integer
    return 284
end function

function ThemePosterFramePad() as integer
    return 6
end function

function ThemeCatalogFocusScale() as float
    return 1.08
end function
