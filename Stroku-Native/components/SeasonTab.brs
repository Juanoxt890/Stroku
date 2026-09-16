sub init()
    m.pill = m.top.FindNode("pill")
    m.label = m.top.FindNode("label")
end sub

sub onContentChanged()
    EnsureUiScale(m.top)

    content = m.top.itemContent
    if content = invalid then return
    m.label.text = content.title
    onStateChanged()
end sub

sub onStateChanged()
    selected = false
    content = m.top.itemContent
    if content <> invalid and content.shortDescriptionLine1 = "selected"
        selected = true
    end if

    if m.top.itemHasFocus or selected
        m.pill.color = "0xE50914FF"
        m.label.color = "0xFFFFFFFF"
    else
        m.pill.color = "0x2A2A2AFF"
        m.label.color = "0xB3B3B3FF"
    end if
end sub
