sub init()
    m.poster = m.top.FindNode("poster")
    m.title = m.top.FindNode("title")
    m.focusFrame = m.top.FindNode("focusFrame")
    m.seeAllBg = m.top.FindNode("seeAllBg")
    m.seeAllLabel = m.top.FindNode("seeAllLabel")
end sub

sub onContentChanged()
    EnsureUiScale(m.top)
    content = m.top.itemContent
    if content = invalid then return
    m.poster.uri = content.HDPosterUrl
    titleText = content.title
    if titleText = invalid then titleText = ""
    m.title.text = titleText
    isSeeAll = false
    if content.DoesExist("seeAll") and content.seeAll = true then isSeeAll = true
    if not isSeeAll and titleText <> ""
        lowerTitle = LCase(titleText)
        if Instr(1, lowerTitle, "ver todo") > 0 or Instr(1, lowerTitle, "see all") > 0 then isSeeAll = true
    end if
    m.isSeeAll = isSeeAll
    if m.seeAllBg <> invalid then m.seeAllBg.visible = isSeeAll
    if m.seeAllLabel <> invalid
        m.seeAllLabel.visible = isSeeAll
        if isSeeAll and titleText <> "" then m.seeAllLabel.text = titleText
    end if
    if isSeeAll and m.poster <> invalid then m.poster.visible = false
    if not isSeeAll and m.poster <> invalid then m.poster.visible = true
    onFocusChanged()
    progressBarBg = m.top.FindNode("progressBarBg")
    progressBarFill = m.top.FindNode("progressBarFill")
    if progressBarBg <> invalid and progressBarFill <> invalid
        if (not isSeeAll) and content.DoesExist("progress") and content.progress > 0.0 and content.progress < 1.0
            progressBarBg.visible = true
            progressBarFill.visible = true
            progressBarFill.width = ScaleUi(208 * content.progress)
        else
            progressBarBg.visible = false
            progressBarFill.visible = false
        end if
    end if
end sub

sub onFocusChanged()
    hasFocus = m.top.itemHasFocus
    m.focusFrame.visible = hasFocus
    if m.isSeeAll = true
        m.title.visible = false
        if m.seeAllLabel <> invalid then m.seeAllLabel.visible = true
    else
        m.title.visible = hasFocus
    end if
    if hasFocus
        m.top.scale = [1.12, 1.12]
    else
        m.top.scale = [1.0, 1.0]
    end if
end sub
