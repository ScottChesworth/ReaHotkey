﻿#Requires AutoHotkey v2.0

Class KontaktKompleteKontrol {
    
    Static Init() {
        
        Plugin.Register("Kontakt/Komplete Kontrol", "^Qt6[0-9][0-9]QWindowIcon\{[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\}1",, True)
        Standalone.Register("Komplete Kontrol", "Komplete Kontrol ahk_class NINormalWindow* ahk_exe Komplete Kontrol.exe")
        Standalone.Register("Komplete Kontrol Preferences", "Preferences ahk_class #32770 ahk_exe Komplete Kontrol.exe", ObjBindMethod(KontaktKompleteKontrol, "FocusKKStandalonePreferenceTab"))
        Standalone.Register("Kontakt", "Kontakt ahk_class NINormalWindow* ahk_exe Kontakt 7.exe")
        
        KKStandaloneHeader := AccessibilityOverlay("Komplete Kontrol")
        KKStandaloneHeader.AddHotspotButton("File", 24, 41)
        KKStandaloneHeader.AddHotspotButton("Edit", 60, 41)
        KKStandaloneHeader.AddHotspotButton("View", 91, 41)
        KKStandaloneHeader.AddHotspotButton("Controller", 146, 41)
        KKStandaloneHeader.AddHotspotButton("Help", 202, 41)
        
        KKPreferenceOverlay := AccessibilityOverlay()
        KKPreferenceTabControl := KKPreferenceOverlay.AddTabControl()
        KKPreferenceAudioTab := HotspotTab("Audio", 56, 69)
        KKPreferenceMIDITab := HotspotTab("MIDI", 56, 114)
        KKPreferenceGeneralTab := HotspotTab("General", 56, 155)
        KKPreferenceLibraryTab := HotspotTab("Library", 56, 196)
        KKPreferenceLibraryTabTabControl := KKPreferenceLibraryTab.AddTabControl()
        KKPreferenceLibraryFactoryTab := HotspotTab("Factory", 156, 76)
        KKPreferenceLibraryFactoryTab.AddHotspotButton("Rescan", 546, 417)
        KKPreferenceLibraryUserTab := HotspotTab("User", 240, 76)
        KKPreferenceLibraryUserTab.AddHotspotButton("Add Directory", 170, 420)
        KKPreferenceLibraryUserTab.AddCustomControl(ObjBindMethod(KontaktKompleteKontrol, "FocusKKStandaloneLibraryScanOption"), ObjBindMethod(KontaktKompleteKontrol, "ActivateKKStandaloneLibraryScanOption"))
        KKPreferenceLibraryUserTab.AddHotspotButton("Rescan", 546, 417)
        KKPreferenceLibraryTabTabControl.AddTabs(KKPreferenceLibraryFactoryTab, KKPreferenceLibraryUserTab)
        KKPreferencePluginTab := HotspotTab("Plug-ins", 56, 237)
        KKPreferenceTabControl.AddTabs(KKPreferenceAudioTab, KKPreferenceMIDITab, KKPreferenceGeneralTab, KKPreferenceLibraryTab, KKPreferencePluginTab)
        KKPreferenceOverlay.AddCustomButton("Close",, ObjBindMethod(KontaktKompleteKontrol, "CloseKKStandalonePreferences"))
        
        KontaktStandaloneHeader := AccessibilityOverlay("Kontakt")
        KontaktStandaloneHeader.AddCustomButton("FILE",, ObjBindMethod(KontaktKompleteKontrol, "OpenKontaktStandaloneFileMenu"))
        KontaktStandaloneHeader.AddHotspotButton("LIBRARY", 237, 70)
        KontaktStandaloneHeader.AddCustomButton("VIEW",, ObjBindMethod(KontaktKompleteKontrol, "OpenKontaktStandaloneViewMenu"))
        KontaktStandaloneHeader.AddHotspotButton("SHOP", 828, 70)
        
        NoProductOverlay := AccessibilityOverlay("None")
        NoProductOverlay.Metadata := Map("Product", "None")
        NoProductOverlay.AddAccessibilityOverlay()
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", NoProductOverlay)
        
        AreiaOverlay := AccessibilityOverlay("Areia")
        AreiaOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Areia", "Image", Map("File", "Images/KontaktKompleteKontrol/Areia.png"))
        AreiaOverlay.AddAccessibilityOverlay()
        AreiaOverlay.AddStaticText("Areia")
        AreiaOverlay.AddCustomButton("Classic Mix", ObjBindMethod(KontaktKompleteKontrol, "FocusAIPluginClassicMix"), ObjBindMethod(KontaktKompleteKontrol, "ActivateAIPluginClassicMix"))
        AreiaOverlay.AddCustomButton("Modern Mix", ObjBindMethod(KontaktKompleteKontrol, "FocusAIPluginModernMix"), ObjBindMethod(KontaktKompleteKontrol, "ActivateAIPluginModernMix"))
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", AreiaOverlay)
        
        CerberusOverlay := AccessibilityOverlay("Cerberus")
        CerberusOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Cerberus", "Image", Map("File", "Images/KontaktKompleteKontrol/Cerberus.png"))
        CerberusOverlay.AddAccessibilityOverlay()
        CerberusOverlay.AddStaticText("Cerberus")
        CerberusComboBox := CerberusOverlay.AddCustomComboBox("Patch type:", ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginCerberusPatchType"), ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginCerberusPatchType"))
        CerberusComboBox.SetOptions(["Normal", "Epic Mix"])
        CerberusOverlay.AddAccessibilityOverlay()
        CerberusOverlay.AddCustomControl(ObjBindMethod(KontaktKompleteKontrol, "RedirectAIPluginCerberusKeyPress"))
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", CerberusOverlay)
        
        ChorusOverlay := AccessibilityOverlay("Chorus")
        ChorusOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Chorus", "Image", Map("File", "Images/KontaktKompleteKontrol/Chorus.png"))
        ChorusOverlay.AddAccessibilityOverlay()
        ChorusOverlay.AddStaticText("Chorus")
        ChorusOverlay.AddCustomButton("Classic Mix", ObjBindMethod(KontaktKompleteKontrol, "FocusAIPluginClassicMix"), ObjBindMethod(KontaktKompleteKontrol, "ActivateAIPluginClassicMix"))
        ChorusOverlay.AddCustomButton("Modern Mix", ObjBindMethod(KontaktKompleteKontrol, "FocusAIPluginModernMix"), ObjBindMethod(KontaktKompleteKontrol, "ActivateAIPluginModernMix"))
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", ChorusOverlay)
        
        JaegerOverlay := AccessibilityOverlay("Jaeger")
        JaegerOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Jaeger", "Image", Map("File", "Images/KontaktKompleteKontrol/Jaeger.png"))
        JaegerOverlay.AddAccessibilityOverlay()
        JaegerOverlay.AddStaticText("Jaeger")
        JaegerOverlay.AddCustomButton("Classic Mix", ObjBindMethod(KontaktKompleteKontrol, "FocusAIPluginClassicMix"), ObjBindMethod(KontaktKompleteKontrol, "ActivateAIPluginClassicMix"))
        JaegerOverlay.AddCustomButton("Modern Mix", ObjBindMethod(KontaktKompleteKontrol, "FocusAIPluginModernMix"), ObjBindMethod(KontaktKompleteKontrol, "ActivateAIPluginModernMix"))
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", JaegerOverlay)
        
        NucleusOverlay := AccessibilityOverlay("Nucleus")
        NucleusOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Nucleus", "Image", Map("File", "Images/KontaktKompleteKontrol/Nucleus.png"))
        NucleusOverlay.AddAccessibilityOverlay()
        NucleusOverlay.AddStaticText("Nucleus")
        NucleusOverlay.AddCustomButton("Classic Mix", ObjBindMethod(KontaktKompleteKontrol, "FocusAIPluginClassicMix"), ObjBindMethod(KontaktKompleteKontrol, "ActivateAIPluginClassicMix"))
        NucleusOverlay.AddCustomButton("Modern Mix", ObjBindMethod(KontaktKompleteKontrol, "FocusAIPluginModernMix"), ObjBindMethod(KontaktKompleteKontrol, "ActivateAIPluginModernMix"))
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", NucleusOverlay)
        
        SoloOverlay := AccessibilityOverlay("Solo")
        SoloOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Solo", "Image", Map("File", "Images/KontaktKompleteKontrol/Solo.png"))
        SoloOverlay.AddAccessibilityOverlay()
        SoloOverlay.AddStaticText("Solo")
        SoloOverlay.AddCustomButton("Classic Mix", ObjBindMethod(KontaktKompleteKontrol, "FocusAIPluginClassicMix"), ObjBindMethod(KontaktKompleteKontrol, "ActivateAIPluginClassicMix"))
        SoloOverlay.AddCustomButton("Modern Mix", ObjBindMethod(KontaktKompleteKontrol, "FocusAIPluginModernMix"), ObjBindMethod(KontaktKompleteKontrol, "ActivateAIPluginModernMix"))
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", SoloOverlay)
        
        TalosOverlay := AccessibilityOverlay("Talos")
        TalosOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Talos", "Image", Map("File", "Images/KontaktKompleteKontrol/Talos.png"))
        TalosOverlay.AddAccessibilityOverlay()
        TalosOverlay.AddStaticText("Talos")
        TalosOverlay.AddCustomButton("Classic Mix", ObjBindMethod(KontaktKompleteKontrol, "FocusAIPluginClassicMix"), ObjBindMethod(KontaktKompleteKontrol, "ActivateAIPluginClassicMix"))
        TalosOverlay.AddCustomButton("Modern Mix", ObjBindMethod(KontaktKompleteKontrol, "FocusAIPluginModernMix"), ObjBindMethod(KontaktKompleteKontrol, "ActivateAIPluginModernMix"))
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", TalosOverlay)
        
        Plugin.SetTimer("Kontakt/Komplete Kontrol", ObjBindMethod(KontaktKompleteKontrol, "DetectPlugin"), 500)
        Plugin.SetTimer("Kontakt/Komplete Kontrol", ObjBindMethod(AutoChangePluginOverlay,, "Kontakt/Komplete Kontrol", True, True), 500)
        
        Standalone.RegisterOverlay("Komplete Kontrol", KKStandaloneHeader)
        Standalone.RegisterOverlay("Komplete Kontrol Preferences", KKPreferenceOverlay)
        Standalone.RegisterOverlay("Kontakt", KontaktStandaloneHeader)
        
        Standalone.SetHotkey("Komplete Kontrol Preferences", "^,", ObjBindMethod(KontaktKompleteKontrol, "ManageKKStandalonePreferenceWindow"))
        
    }
    
    Static ActivateAIPluginClassicMix(MixButton) {
        Product := ""
        ParentOverlay := MixButton.GetSuperordinateControl()
        If HasProp(ParentOverlay, "Metadata") And ParentOverlay.Metadata.Has("Product") And ParentOverlay.Metadata["Product"] != ""
        Product := ParentOverlay.Metadata["Product"]
        KontaktKompleteKontrol.MoveToOrClickAIPluginClassicMix(Product, "Click")
    }
    
    Static ActivateAIPluginModernMix(MixButton) {
        Product := ""
        ParentOverlay := MixButton.GetSuperordinateControl()
        If HasProp(ParentOverlay, "Metadata") And ParentOverlay.Metadata.Has("Product") And ParentOverlay.Metadata["Product"] != ""
        Product := ParentOverlay.Metadata["Product"]
        KontaktKompleteKontrol.MoveToOrClickAIPluginModernMix(Product, "Click")
    }
    
    Static ActivateKKStandaloneLibraryScanOption(*) {
        Click 419, 394
        Sleep 100
        CheckedColor := "0xC5C5C5"
        UncheckedColor := "0x5F5F5F"
        CurrentColor := PixelGetColor(419, 394)
        If CurrentColor = CheckedColor
        Message := "checked"
        Else If CurrentColor = UncheckedColor
        Message := "unchecked"
        Else {
            Message := "Unable to detect state."
        }
        AccessibilityOverlay.Speak(Message)
    }
    
    Static CloseKKPluginBrowser() {
        If PixelGetColor(CompensatePluginXCoordinate(1002), CompensatePluginYCoordinate(284)) = "0x97999A" {
            Click CompensatePluginXCoordinate(1002), CompensatePluginYCoordinate(284)
            Sleep 2500
            If PixelGetColor(CompensatePluginXCoordinate(1002), CompensatePluginYCoordinate(284)) != "0x181818" {
                AccessibilityOverlay.Speak("KK browser could not be closed. Some functions may not work correctly.")
                Sleep 2500
            }
            Else {
                AccessibilityOverlay.Speak("KK browser closed.")
                Sleep 2500
            }
        }
    }
    
    Static CloseKKStandalonePreferences(*) {
        WinClose("Preferences ahk_class #32770 ahk_exe Komplete Kontrol.exe")
    }
    
    Static DetectPlugin() {
        SetTimer ReaHotkey.ManageState, 0
        If FindImage("Images/KontaktKompleteKontrol/KompleteKontrol.png", GetPluginXCoordinate(), GetPluginYCoordinate()) Is Array {
            KontaktKompleteKontrol.LoadPluginHeader("Komplete Kontrol")
            KontaktKompleteKontrol.CloseKKPluginBrowser()
        }
        Else If FindImage("Images/KontaktKompleteKontrol/Kontakt.png", GetPluginXCoordinate(), GetPluginYCoordinate()) Is Array {
            KontaktKompleteKontrol.LoadPluginHeader("Kontakt")
        }
        Else {
            KontaktKompleteKontrol.LoadPluginHeader("Unknown")
        }
        SetTimer ReaHotkey.ManageState, 100
    }
    
    Static FocusAIPluginClassicMix(MixButton) {
        Product := ""
        ParentOverlay := MixButton.GetSuperordinateControl()
        If HasProp(ParentOverlay, "Metadata") And ParentOverlay.Metadata.Has("Product") And ParentOverlay.Metadata["Product"] != ""
        Product := ParentOverlay.Metadata["Product"]
        KontaktKompleteKontrol.MoveToOrClickAIPluginClassicMix(Product, "MouseMove")
    }
    
    Static FocusAIPluginModernMix(MixButton) {
        Product := ""
        ParentOverlay := MixButton.GetSuperordinateControl()
        If HasProp(ParentOverlay, "Metadata") And ParentOverlay.Metadata.Has("Product") And ParentOverlay.Metadata["Product"] != ""
        Product := ParentOverlay.Metadata["Product"]
        KontaktKompleteKontrol.MoveToOrClickAIPluginModernMix(Product, "MouseMove")
    }
    
    Static FocusKKStandaloneLibraryScanOption(*) {
        MouseMove 419, 394
        Sleep 100
        CheckedColor := "0xC5C5C5"
        UncheckedColor := "0x5F5F5F"
        CurrentColor := PixelGetColor(419, 394)
        If CurrentColor = CheckedColor
        Message := "Scan user content for changes at start-up checkbox checked"
        Else If CurrentColor = UncheckedColor
        Message := "Scan user content for changes at start-up checkbox unchecked"
        Else
        Message := "Scan user content for changes at start-up"
        AccessibilityOverlay.Speak(Message)
    }
    
    Static FocusKKStandalonePreferenceTab(KKInstance) {
        Sleep 1000
        If KKInstance.Overlay.CurrentControlID = 0
        KKInstance.Overlay.Focus()
    }
    
    Static GetPluginName() {
        If FindImage("Images/KontaktKompleteKontrol/KompleteKontrol.png", GetPluginXCoordinate(), GetPluginYCoordinate()) Is Array
        Return "Komplete Kontrol"
        Else
        If FindImage("Images/KontaktKompleteKontrol/Kontakt.png", GetPluginXCoordinate(), GetPluginYCoordinate()) Is Array
        Return "Kontakt"
        Return False
    }
    
    Static LoadPluginHeader(PluginName) {
        KKPluginHeader := AccessibilityOverlay("Komplete Kontrol")
        KKPluginHeader.AddStaticText("Komplete Kontrol")
        KKPluginHeader.AddHotspotButton("Menu", 305, 68, CompensatePluginPointCoordinates, CompensatePluginPointCoordinates)
        KontaktPluginHeader := AccessibilityOverlay("Kontakt")
        KontaktPluginHeader.AddStaticText("Kontakt")
        KontaktPluginHeader.AddCustomButton("FILE",, ObjBindMethod(KontaktKompleteKontrol, "OpenKontaktPluginFileMenu"))
        KontaktPluginHeader.AddHotspotButton("LIBRARY", 237, 70, CompensatePluginPointCoordinates, CompensatePluginPointCoordinates)
        KontaktPluginHeader.AddCustomButton("VIEW",, ObjBindMethod(KontaktKompleteKontrol, "OpenKontaktPluginViewMenu"))
        KontaktPluginHeader.AddHotspotButton("SHOP", 828, 70, CompensatePluginPointCoordinates, CompensatePluginPointCoordinates)
        UnknownPluginHeader := AccessibilityOverlay("Unknown")
        UnknownPluginHeader.AddStaticText("Kontakt/Komplete Kontrol")
        UnknownPluginHeader.AddStaticText("Warning! The exact plugin could not be detected. Some functions may not work correctly.")
        If ReaHotkey.FoundPlugin Is Plugin And Not HasProp(ReaHotkey.FoundPlugin.Overlay, "Metadata") {
            ReaHotkey.FoundPlugin.Overlay.Metadata := Map("Product", "None")
            ReaHotkey.FoundPlugin.Overlay.OverlayNumber := 1
        }
        If ReaHotkey.FoundPlugin Is Plugin And ReaHotkey.FoundPlugin.Overlay.ChildControls[1].Label != PluginName {
            If PluginName = "Komplete Kontrol"
            ReaHotkey.FoundPlugin.Overlay.ChildControls[1] := KKPluginHeader.Clone()
            Else If PluginName = "Kontakt"
            ReaHotkey.FoundPlugin.Overlay.ChildControls[1] := KontaktPluginHeader.Clone()
            Else
            ReaHotkey.FoundPlugin.Overlay.ChildControls[1] := UnknownPluginHeader.Clone()
        }
    }
    
    Static ManageKKStandalonePreferenceWindow(*) {
        If WinActive("Preferences ahk_class #32770 ahk_exe Komplete Kontrol.exe") {
            WinClose("Preferences ahk_class #32770 ahk_exe Komplete Kontrol.exe")
        }
        Else If WinActive("Komplete Kontrol ahk_class NINormalWindow* ahk_exe Komplete Kontrol.exe") And Not WinExist("Preferences ahk_class #32770 ahk_exe Komplete Kontrol.exe") {
            Hotkey "^,", "Off"
            Send "^,"
        }
        Else {
            If WinExist("Preferences ahk_class #32770 ahk_exe Komplete Kontrol.exe") And Not WinActive("Preferences ahk_class #32770 ahk_exe Komplete Kontrol.exe")
            WinActivate("Preferences ahk_class #32770 ahk_exe Komplete Kontrol.exe")
        }
    }
    
    Static MoveToOrClickAIPluginClassicMix(Product, MoveOrClick) {
        Switch(KontaktKompleteKontrol.GetPluginName()) {
            Case "Komplete Kontrol":
            Switch(Product) {
                Case "Areia":
                %MoveOrClick%(CompensatePluginXCoordinate(200), CompensatePluginYCoordinate(461))
                Case "Chorus":
                %MoveOrClick%(CompensatePluginXCoordinate(200), CompensatePluginYCoordinate(461))
                Case "Jaeger":
                %MoveOrClick%(CompensatePluginXCoordinate(200), CompensatePluginYCoordinate(461))
                Case "Nucleus":
                %MoveOrClick%(CompensatePluginXCoordinate(226), CompensatePluginYCoordinate(416))
                Case "Solo":
                %MoveOrClick%(CompensatePluginXCoordinate(200), CompensatePluginYCoordinate(461))
                Case "Talos":
                %MoveOrClick%(CompensatePluginXCoordinate(200), CompensatePluginYCoordinate(461))
            }
            Case "Kontakt":
            Switch(Product) {
                Case "Areia":
                %MoveOrClick%(CompensatePluginXCoordinate(100), CompensatePluginYCoordinate(361))
                Case "Chorus":
                %MoveOrClick%(CompensatePluginXCoordinate(100), CompensatePluginYCoordinate(361))
                Case "Jaeger":
                %MoveOrClick%(CompensatePluginXCoordinate(100), CompensatePluginYCoordinate(361))
                Case "Nucleus":
                %MoveOrClick%(CompensatePluginXCoordinate(126), CompensatePluginYCoordinate(316))
                Case "Solo":
                %MoveOrClick%(CompensatePluginXCoordinate(100), CompensatePluginYCoordinate(361))
                Case "Talos":
                %MoveOrClick%(CompensatePluginXCoordinate(100), CompensatePluginYCoordinate(361))
            }
        }
    }
    
    Static MoveToOrClickAIPluginModernMix(Product, MoveOrClick) {
        Switch(KontaktKompleteKontrol.GetPluginName()) {
            Case "Komplete Kontrol":
            Switch(Product) {
                Case "Areia":
                %MoveOrClick%(CompensatePluginXCoordinate(283), CompensatePluginYCoordinate(461))
                Case "Chorus":
                %MoveOrClick%(CompensatePluginXCoordinate(283), CompensatePluginYCoordinate(461))
                Case "Jaeger":
                %MoveOrClick%(CompensatePluginXCoordinate(283), CompensatePluginYCoordinate(461))
                Case "Nucleus":
                %MoveOrClick%(CompensatePluginXCoordinate(264), CompensatePluginYCoordinate(446))
                Case "Solo":
                %MoveOrClick%(CompensatePluginXCoordinate(283), CompensatePluginYCoordinate(461))
                Case "Talos":
                %MoveOrClick%(CompensatePluginXCoordinate(283), CompensatePluginYCoordinate(461))
            }
            Case "Kontakt":
            Switch(Product) {
                Case "Areia":
                %MoveOrClick%(CompensatePluginXCoordinate(183), CompensatePluginYCoordinate(361))
                Case "Chorus":
                %MoveOrClick%(CompensatePluginXCoordinate(183), CompensatePluginYCoordinate(361))
                Case "Jaeger":
                %MoveOrClick%(CompensatePluginXCoordinate(183), CompensatePluginYCoordinate(361))
                Case "Nucleus":
                %MoveOrClick%(CompensatePluginXCoordinate(164), CompensatePluginYCoordinate(346))
                Case "Solo":
                %MoveOrClick%(CompensatePluginXCoordinate(183), CompensatePluginYCoordinate(361))
                Case "Talos":
                %MoveOrClick%(CompensatePluginXCoordinate(183), CompensatePluginYCoordinate(361))
            }
        }
    }
    
    Static OpenKontaktMenu() {
        Loop {
            KeyCombo := KeyWaitCombo()
            If KeyCombo = "+Tab" {
                SendInput "+{Tab}"
            }
            Else If KeyCombo = "!F4" {
                SendInput "{Escape}"
                SendInput "!{F4}"
                Break
            }
            Else {
                SingleKey := KeyWaitSingle()
                If GetKeyState("Shift") And SingleKey = "Tab" {
                    SendInput "+{Tab}"
                }
                Else If GetKeyState("Alt") And SingleKey = "F4" {
                    SendInput "{Escape}"
                    SendInput "!{F4}"
                    Break
                }
                Else {
                    If SingleKey != "Left" And SingleKey != "Right" And SingleKey != "Up" And SingleKey != "Down" {
                        SendInput "{" . SingleKey . "}"
                    }
                }
                If SingleKey = "Escape"
                Break
            }
        }
    }
    
    Static OpenKontaktPluginFileMenu(*) {
        SetTimer ReaHotkey.ManageState, 0
        ReaHotkey.TurnPluginHotkeysOff()
        ReaHotkey.TurnPluginTimersOff("Kontakt/Komplete Kontrol")
        Click CompensatePluginXCoordinate(186), CompensatePluginYCoordinate(70)
        KontaktKompleteKontrol.OpenKontaktMenu()
        SetTimer ReaHotkey.ManageState, 100
    }
    
    Static OpenKontaktPluginViewMenu(*) {
        SetTimer ReaHotkey.ManageState, 0
        ReaHotkey.TurnPluginHotkeysOff()
        ReaHotkey.TurnPluginTimersOff("Kontakt/Komplete Kontrol")
        Click CompensatePluginXCoordinate(298), CompensatePluginYCoordinate(70)
        KontaktKompleteKontrol.OpenKontaktMenu()
        SetTimer ReaHotkey.ManageState, 100
    }
    
    Static OpenKontaktStandaloneFileMenu(*) {
        SetTimer ReaHotkey.ManageState, 0
        ReaHotkey.TurnStandaloneHotkeysOff()
        ReaHotkey.TurnStandaloneTimersOff("Kontakt")
        Click 186, 70
        KontaktKompleteKontrol.OpenKontaktMenu()
        SetTimer ReaHotkey.ManageState, 100
    }
    
    Static OpenKontaktStandaloneViewMenu(*) {
        SetTimer ReaHotkey.ManageState, 0
        ReaHotkey.TurnStandaloneHotkeysOff()
        ReaHotkey.TurnStandaloneTimersOff("Kontakt")
        Click 298, 70
        KontaktKompleteKontrol.OpenKontaktMenu()
        SetTimer ReaHotkey.ManageState, 100
    }
    
    Static RedirectAIPluginCerberusKeyPress(OverlayControl) {
        ParentOverlay := OverlayControl.GetSuperordinateControl()
        MasterOverlay := ParentOverlay.GetSuperordinateControl()
        If A_PriorHotkey = "+Tab" {
            TypeCombo := ParentOverlay.ChildControls[3]
            KontaktKompleteKontrol.SelectAIPluginCerberusPatchType(TypeCombo)
            MasterOverlay.FocusPreviousControl()
        }
        Else If GetKeyState("Shift") And A_PriorHotkey = "Tab" {
            TypeCombo := ParentOverlay.ChildControls[3]
            KontaktKompleteKontrol.SelectAIPluginCerberusPatchType(TypeCombo)
            MasterOverlay.FocusPreviousControl()
        }
        Else {
            If A_PriorHotkey = "Tab" {
                MasterOverlay.FocusNextControl()
            }
        }
    }
    
    Static SelectAIPluginCerberusPatchType(TypeCombo) {
        ParentOverlay := TypeCombo.GetSuperordinateControl()
        If TypeCombo.GetValue() = "Normal" {
            ChildOverlay := AccessibilityOverlay()
            If KontaktKompleteKontrol.GetPluginName() = "Komplete Kontrol" {
                ChildOverlay.AddHotspotButton("C", 326, 464, CompensatePluginPointCoordinates, CompensatePluginPointCoordinates)
                ChildOverlay.AddHotspotButton("M", 335, 464, CompensatePluginPointCoordinates, CompensatePluginPointCoordinates)
            }
            Else If KontaktKompleteKontrol.GetPluginName() = "Kontakt" {
                ChildOverlay.AddHotspotButton("C", 216, 364, CompensatePluginPointCoordinates, CompensatePluginPointCoordinates)
                ChildOverlay.AddHotspotButton("M", 235, 364, CompensatePluginPointCoordinates, CompensatePluginPointCoordinates)
            }
            Else {
                ChildOverlay.AddStaticText("Mix choices not available")
            }
            ParentOverlay.ChildControls[4] := ChildOverlay
        }
        Else If TypeCombo.GetValue() = "Epic Mix" {
            ChildOverlay := AccessibilityOverlay()
            If KontaktKompleteKontrol.GetPluginName() = "Komplete Kontrol" {
                ChildOverlay.AddHotspotButton("C", 221, 464, CompensatePluginPointCoordinates, CompensatePluginPointCoordinates)
                ChildOverlay.AddHotspotButton("F", 251, 464, CompensatePluginPointCoordinates, CompensatePluginPointCoordinates)
                ChildOverlay.AddHotspotButton("R", 281, 464, CompensatePluginPointCoordinates, CompensatePluginPointCoordinates)
            }
            Else If KontaktKompleteKontrol.GetPluginName() = "Kontakt" {
                ChildOverlay.AddHotspotButton("C", 121, 364, CompensatePluginPointCoordinates, CompensatePluginPointCoordinates)
                ChildOverlay.AddHotspotButton("F", 151, 364, CompensatePluginPointCoordinates, CompensatePluginPointCoordinates)
                ChildOverlay.AddHotspotButton("R", 181, 364, CompensatePluginPointCoordinates, CompensatePluginPointCoordinates)
            }
            Else {
                ChildOverlay.AddStaticText("Mix choices not available")
            }
            ParentOverlay.ChildControls[4] := ChildOverlay
        }
        Else {
            ChildOverlay := AccessibilityOverlay()
            ChildOverlay.AddStaticText("Invalid patch type")
            ParentOverlay.ChildControls[4] := ChildOverlay
        }
    }
    
}

KontaktKompleteKontrol.Init()
