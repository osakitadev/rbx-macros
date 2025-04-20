#Requires AutoHotkey v2.0

CreateDropdown(G := Gui(), Options := [], &Selection := '') {
    list := G.AddDropDownList('Choose1 w120', Options)

    OnChange(*) {
        Selection := Options[list.Value]
    }
    
    list.OnEvent 'Change', OnChange
    Selection := Options[list.Value]

    return list
}