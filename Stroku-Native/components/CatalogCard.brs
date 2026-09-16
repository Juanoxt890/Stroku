sub init()
    m.poster = m.top.FindNode("poster")
    m.title = m.top.FindNode("title")
    m.focusFrame = m.top.FindNode("focusFrame")
    m.focusHalo = m.top.FindNode("focusHalo")
    m.progressBarBg = m.top.FindNode("progressBarBg")
    m.progressBarFill = m.top.FindNode("progressBarFill")
    m.titleScrim = m.top.FindNode("titleScrim")
    m.lastPosterUri = ""
    ' Scale from poster center so neighbors are less clipped on focus pop.
    m.top.scaleRotateCenter = [101, 148]
end sub

sub onContentChanged()
    ' Cards are created and recycled by the RowList long after the scene has
    ' resolved its scale, so the check happens on every content binding.
    EnsureUiScale(m.top)

    content = m.top.itemContent
    if content = invalid then return

    ' Defer redundant poster reloads when RowList rebinds the same artwork.
    posterUri = content.HDPosterUrl
    if posterUri = invalid then posterUri = ""
    if posterUri <> m.lastPosterUri
        m.poster.uri = posterUri
        m.lastPosterUri = posterUri
    end if
    m.title.text = content.title
    onFocusChanged()

    if m.progressBarBg <> invalid and m.progressBarFill <> invalid
        if content.DoesExist("progress") and content.progress > 0.0 and content.progress < 1.0
            m.progressBarBg.visible = true
            m.progressBarFill.visible = true
            m.progressBarFill.width = ScaleUi(ThemePosterWidth() * content.progress)
        else
            m.progressBarBg.visible = false
            m.progressBarFill.visible = false
        end if
    end if
end sub

sub onFocusChanged()
    hasFocus = m.top.itemHasFocus
    m.focusFrame.visible = hasFocus
    if m.focusHalo <> invalid then m.focusHalo.visible = hasFocus
    if m.titleScrim <> invalid then m.titleScrim.visible = hasFocus
    if hasFocus
        m.title.color = ThemeTextPrimary()
        m.top.scale = [ThemeCatalogFocusScale(), ThemeCatalogFocusScale()]
    else
        m.title.color = ThemeTextMuted()
        m.top.scale = [1.0, 1.0]
    end if
end sub
