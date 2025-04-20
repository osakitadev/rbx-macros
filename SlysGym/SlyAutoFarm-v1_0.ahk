; ==================================== ;
;       MADE BY devosaka (In Rbx)
; ==================================== ;

; NOTE: You must move to the machines you want to train on, it won't move
; the character automatically.


#Requires AutoHotKey v2.0
#SingleInstance Force

#Include ..\SharedLib\SharedConstants.ahk
#Include ..\SharedLib\Utils\MoveCursor.ahk
#Include ..\SharedLib\Ui\Button.ahk
#Include ..\SharedLib\Ui\Section.ahk
#Include ..\SharedLib\Ui\Dropdown.ahk

global Active := true
global PullUpsButtonPositions := {
    ;         x     y    duration
    PullUp:   [915, 340, 3000],
    OneArm:   [890, 530, 5000],
    MuscleUp: [900, 435, 7000],
}
global PossibleStaminaBarColors := [
    ; Sometimes the stamina can change of color, so I did this
    0x57A4DF, 0x54D4D0, 0x55BDD9
]

InitMacro() {
    if NOT WinExist(RobloxWindowTitle) {
        MsgBox 'Please open roblox', 'Roblox not found', 'OK'
        ExitApp
    }

    WinActivate(RobloxWindowTitle)
    Sleep(50)
    WinMove(RobloxWindowDimension*)
    Sleep(300)
}

InitGui() {
    global G := Gui('+AlwaysOnTop +ToolWindow')
    global PullUpType := ''

    CreateSection G, 'Dumbbell'
    CreateButton G, 'Start Farming', HandleDumbell
    CreateSection G, 'Machines'
    CreateButton G, 'Bench and Dips', HandleDipAndBenches
    CreateButton G, 'Pull-Ups', HandlePullUps
    CreateSection G, 'Select Pull-Up Type', '140', '10'
    CreateDropdown G, ['PullUp', 'MuscleUp', 'OneArm'], &PullUpType

    ToggleMacro(*) {
        global Active := !Active
    }

    CreateButton G, 'STOP ALL', ToggleMacro
    
    G.Show 'AutoSize'
}

HandlePullUps(*) {
    FocusWindow

    while (Active) {
        KeyPress 'e', 3000

        Sleep 4000 ; Wait for buttons to appear
    
        ; Why use %%?????? I hate this syntax sometimes...
        PullUpButtonData := PullUpsButtonPositions.%PullUpType%
    
        MoveCursor PullUpButtonData[1], PullUpButtonData[2]
        Sleep 50
        Click
        Sleep 100
        FocusWindow
    
        Sleep 1000

        while (HasStamina()) {
            Click
            Sleep PullUpButtonData[3] ; Duration
        }

        ; Sleep 1000

        RegenerateStamina 5000, 1000
    }
}

HandleDumbell(*) {
    FocusWindow
    
    while (Active) {
        Send '{1}'
        Click
        Sleep 200
        Send '{2}'
        Click
        Sleep 200
    }
}

HandleDipAndBenches(*) {
    FocusWindow

    while (Active) {
        KeyPress 'e', 2000
        Sleep 3500

        while (HasStamina()) {
            Click
            Sleep 1200
        }

        Sleep 1000

        RegenerateStamina
    }
}

; ==== UTILITY FUNCTIONS ====
KeyPress(Key := '', Duration := 100) {
    Send '{' key ' down}'
    Sleep Duration
    Send '{' key ' up}'
    Sleep 50
}

FocusWindow() {
    WinActivate RobloxWindowTitle
    WinGetPos ,, &W, &H, RobloxWindowTitle

    Sleep 100

    MouseMove W/2, H/2

    Sleep 100
}

RegenerateStamina(JumpDuration := 1000, BurgerEatCooldown := 2500) {
    ; Jump off the machine
    Sleep 100
    KeyPress('Space', 200)
    Sleep JumpDuration
    KeyPress '2', 200 ; Equip burgar 🍔
    Sleep 500

    ; Eat burger 7 times (It should be 6, but I put 7 just in case)
    loop 7 {
        Click
        Sleep BurgerEatCooldown
    }
}

HasStamina() {
    for color IN PossibleStaminaBarColors {
        wasColorFound := PixelSearch(&_, &_, 0, 0, A_ScreenWidth, A_ScreenHeight, color)

        if (wasColorFound)
            return true
    }

    return false
}

InitGui
InitMacro

; Ctrl + Q to quit the macro
^q::ExitApp
