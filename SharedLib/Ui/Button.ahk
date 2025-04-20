#Requires AutoHotkey v2.0

CreateButton(G := Gui(), Text := '', Callback?, Width := '150') {
    btn := G.Add('Button', 'Center w' Width ' h20', Text)
    
    btn.OnEvent 'Click', Callback

    return btn
}
