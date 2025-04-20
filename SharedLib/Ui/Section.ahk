#Requires AutoHotkey v2.0

CreateSection(G := Gui(), Title := '', Width := '150', Size := '15') {
    label := G.Add('Text', 'w' Width ' h20 Left', Title)
    label.SetFont 's' Size ' bold', 'Arial'

    return label
}