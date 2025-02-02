#Requires AutoHotkey v2.0

#SuspendExempt

^+#A:: {
    ReaHotkey.ShowAboutBox()
}

^+#P:: {
    ReaHotkey.TogglePause()
    If A_IsSuspended = 1
    AccessibilityOverlay.Speak("ReaHotkey paused")
    Else
    AccessibilityOverlay.Speak("ReaHotkey unpaused")
}

^+#Q:: {
    AccessibilityOverlay.Speak("Quitting ReaHotkey")
    ReaHotkey.Quit()
}

^+#R:: {
    ReaHotkey.ViewReadme()
}

#SuspendExempt False
