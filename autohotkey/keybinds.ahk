#Requires AutoHotkey v2.0

#q::Send("!{F4}")

Capslock::Send("{Esc}")

#t::{
    Run("wt.exe")

    ; Aguarda até 5 segundos pela janela
    timeout := 5000
    start := A_TickCount

    while !(WinExist("ahk_exe WindowsTerminal.exe")) {
        if (A_TickCount - start > timeout) {
            MsgBox("Erro: Janela do Windows Terminal não encontrada.")
            return
        }
        Sleep(100)
    }

    WinActivate("ahk_exe WindowsTerminal.exe")
}


#b::{
    Run("msedge.exe")

    timeout := 5000
    start := A_TickCount

    while !(WinExist("ahk_exe msedge.exe")) {
        if (A_TickCount - start > timeout) {
            MsgBox("Erro: Janela do Microsoft Edge não encontrada.")
            return
        }
        Sleep(100)
    }

    WinActivate("ahk_exe msedge.exe")
}

#m:: {
    activeID := WinGetID("A")
    status := WinGetMinMax(activeID)

    if (status == 1)
        WinRestore(activeID)
    else if (status == 0)
        WinMaximize(activeID)
}

switchToDesktop(n) {
    Loop 3 {
        Send("^#{Left}")
    }

    Loop (n - 1) {
        Send("^#{Right}")
    }
}

#1::SwitchToDesktop(1)
#2::SwitchToDesktop(2)
#3::SwitchToDesktop(3)
#4::SwitchToDesktop(4)
