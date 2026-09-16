sub init()
    m.cardBg = m.top.FindNode("cardBg")
    m.focusFrame = m.top.FindNode("focusFrame")
    m.focusAccent = m.top.FindNode("focusAccent")
    m.badgePill = m.top.FindNode("badgePill")
    m.line1 = m.top.FindNode("line1")
    m.line2 = m.top.FindNode("line2")
    m.line3 = m.top.FindNode("line3")
    m.badge = m.top.FindNode("badge")
end sub

sub onContentChanged()
    EnsureUiScale(m.top)

    content = m.top.itemContent
    if content = invalid then return

    m.line1.text = SafeText(content, "line1")
    m.line2.text = SafeText(content, "line2")
    m.line3.text = SafeText(content, "line3")
    m.badge.text = SafeText(content, "sourceBadge")

    ' Keep legacy fields readable if an older content node appears.
    if m.line1.text = ""
        quality = SafeText(content, "quality")
        sizeText = SafeText(content, "sizeText")
        m.line1.text = JoinNonEmpty([quality, sizeText], "  ·  ")
    end if
    if m.line2.text = ""
        m.line2.text = SafeText(content, "title")
    end if
    if m.line3.text = ""
        m.line3.text = JoinNonEmpty([SafeText(content, "addonName"), SafeText(content, "tracker"), SafeText(content, "seeds")], "  ·  ")
    end if

    if m.badgePill <> invalid
        m.badgePill.visible = m.badge.text <> ""
    end if
end sub

sub onFocusChanged()
    focused = m.top.itemHasFocus
    m.focusFrame.visible = focused
    m.focusAccent.visible = focused
    if focused
        m.cardBg.color = ThemeFocusFill()
        m.line1.color = ThemeTextPrimary()
        m.line2.color = ThemeTextPrimary()
        m.line3.color = ThemeTextSecondary()
        m.badge.color = ThemeTextPrimary()
        if m.badgePill <> invalid then m.badgePill.color = ThemeAccent()
    else
        m.cardBg.color = ThemeSurface()
        m.line1.color = ThemeTextPrimary()
        m.line2.color = ThemeTextSecondary()
        m.line3.color = ThemeTextMuted()
        m.badge.color = ThemeAccent()
        if m.badgePill <> invalid then m.badgePill.color = ThemeSurfaceHover()
    end if
end sub

function SafeText(content as object, key as string) as string
    if content = invalid then return ""
    if not content.DoesExist(key) then return ""
    value = content[key]
    if value = invalid then return ""
    return value.ToStr()
end function

function JoinNonEmpty(parts as object, separator as string) as string
    result = ""
    for each part in parts
        if part <> invalid and part <> ""
            if result <> "" then result = result + separator
            result = result + part
        end if
    end for
    return result
end function
