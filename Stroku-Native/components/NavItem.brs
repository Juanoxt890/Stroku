' Left-rail nav row: icon + label + red accent when focused or selected.

sub init()
    m.rowBg = m.top.FindNode("rowBg")
    m.accentBar = m.top.FindNode("accentBar")
    m.icon = m.top.FindNode("icon")
    m.label = m.top.FindNode("label")
    m.observedContent = invalid
end sub

sub onContentChanged()
    EnsureUiScale(m.top)

    content = m.top.itemContent
    if content = invalid then return

    if m.observedContent <> invalid
        m.observedContent.unobserveField("selected")
    end if
    m.observedContent = content
    content.observeField("selected", "onStateChanged")

    m.label.text = content.title
    uri = content.iconUri
    if uri = invalid then uri = ""
    m.icon.uri = uri

    onStateChanged()
end sub

sub onStateChanged()
    content = m.top.itemContent
    if content = invalid then return

    focused = m.top.itemHasFocus
    selected = false
    if content.hasField("selected") then selected = content.selected

    m.accentBar.visible = focused or selected

    if focused
        m.rowBg.color = "0x3A1518FF"
        m.label.color = "0xFFFFFFFF"
        m.label.font = "font:MediumBoldSystemFont"
        m.icon.blendColor = "0xFFFFFFFF"
    else if selected
        m.rowBg.color = "0x1A1A1DFF"
        m.label.color = "0xFFFFFFFF"
        m.label.font = "font:MediumBoldSystemFont"
        m.icon.blendColor = "0xFFFFFFFF"
    else
        m.rowBg.color = "0x00000000"
        m.label.color = "0xB3B3B3FF"
        m.label.font = "font:MediumSystemFont"
        m.icon.blendColor = "0xB3B3B3FF"
    end if
end sub
