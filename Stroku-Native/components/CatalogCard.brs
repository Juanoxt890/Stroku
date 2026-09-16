sub init()
    m.poster = m.top.FindNode("poster")
    m.title = m.top.FindNode("title")
    m.focusFrame = m.top.FindNode("focusFrame")
    m.focusInset = m.top.FindNode("focusInset")
end sub

sub onContentChanged()
    EnsureUiScale(m.top)

    content = m.top.itemContent
    if content = invalid then return

    m.poster.uri = content.HDPosterUrl
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
            progressBarFill.width = ScaleUi(168 * content.progress)
        else
            progressBarBg.visible = false
            progressBarFill.visible = false
        end if
    end if
end sub

sub onFocusChanged()
    hasFocus = m.top.itemHasFocus
    m.focusFrame.visible = hasFocus
    if m.focusInset <> invalid then m.focusInset.visible = hasFocus
    m.title.visible = hasFocus
    if hasFocus
        m.title.color = "0xFFFFFFFF"
        m.focusFrame.color = "0xE50914FF"
        m.top.scale = [1.08, 1.08]
    else
        m.top.scale = [1.0, 1.0]
    end if
end sub
