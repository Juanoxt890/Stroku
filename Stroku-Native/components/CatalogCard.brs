sub init()
    m.poster = m.top.FindNode("poster")
    m.title = m.top.FindNode("title")
    m.focusFrame = m.top.FindNode("focusFrame")
end sub

sub onContentChanged()
    ' Cards are created and recycled by the RowList long after the scene has
    ' resolved its scale, so the check happens on every content binding.
    EnsureUiScale(m.top)

    content = m.top.itemContent
    if content = invalid then return

    ' Always assign URI. Skipping "unchanged" reloads left recycled RowList
    ' cards blank on some firmware after content swaps.
    posterUri = content.HDPosterUrl
    if posterUri = invalid then posterUri = ""
    m.poster.uri = posterUri

    titleText = content.title
    if titleText = invalid then titleText = ""
    m.title.text = titleText
    onFocusChanged()

    progressBarBg = m.top.FindNode("progressBarBg")
    progressBarFill = m.top.FindNode("progressBarFill")
    if progressBarBg <> invalid and progressBarFill <> invalid
        if content.DoesExist("progress") and content.progress > 0.0 and content.progress < 1.0
            progressBarBg.visible = true
            progressBarFill.visible = true
            progressBarFill.width = ScaleUi(158 * content.progress)
        else
            progressBarBg.visible = false
            progressBarFill.visible = false
        end if
    end if
end sub

sub onFocusChanged()
    hasFocus = m.top.itemHasFocus
    m.focusFrame.visible = hasFocus
    if hasFocus
        m.title.color = "0xFFFFFFFF"
        m.focusFrame.color = "0xE50914FF"
        ' Do not scale the RowList item Group: on several Roku builds that makes
        ' posters vanish while row labels still render.
    else
        m.title.color = "0xB3B3B3FF"
    end if
end sub
