#Requires AutoHotkey v2.0

MoveCursor(xTarget, yTarget, jitterAmount := 5, steps := 5, speed := 10) {
    CoordMode 'Mouse', 'Screen'

    Loop steps {
        x := xTarget + Random(-jitterAmount, jitterAmount)
        y := yTarget + Random(-jitterAmount, jitterAmount)
        MouseMove x, y, speed
        Sleep 30
    }
    
    MouseMove xTarget, yTarget, speed
    Sleep 500
}