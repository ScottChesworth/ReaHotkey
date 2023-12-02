﻿#Requires AutoHotkey v2.0

Class KontaktKompleteKontrol {
    
    Static Init() {
        
        Plugin.Register("Kontakt/Komplete Kontrol", "^Qt6[0-9][0-9]QWindowIcon\{[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\}1",, True)
        Standalone.Register("Komplete Kontrol", "Komplete Kontrol ahk_class NINormalWindow* ahk_exe Komplete Kontrol.exe")
        Standalone.Register("Kontakt", "Kontakt ahk_class NINormalWindow* ahk_exe Kontakt 7.exe")
        
        KompleteKontrolStandaloneHeader := AccessibilityOverlay("Komplete Kontrol")
        KompleteKontrolStandaloneHeader.AddHotspotButton("File", 24, 41)
        KompleteKontrolStandaloneHeader.AddHotspotButton("Edit", 60, 41)
        KompleteKontrolStandaloneHeader.AddHotspotButton("View", 91, 41)
        KompleteKontrolStandaloneHeader.AddHotspotButton("Controller", 146, 41)
        KompleteKontrolStandaloneHeader.AddHotspotButton("Help", 202, 41)
        
        KontaktStandaloneHeader := AccessibilityOverlay("Kontakt")
        KontaktStandaloneHeader.AddStaticText("Kontakt")
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
        AreiaOverlay.AddCustomButton("Classic Mix",, ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginClassicMix"))
        AreiaOverlay.AddCustomButton("Modern Mix",, ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginModernMix"))
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", AreiaOverlay)
        
        CerberusOverlay := AccessibilityOverlay("Cerberus")
        CerberusOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Cerberus", "Image", Map("File", "Images/KontaktKompleteKontrol/Cerberus.png"))
        CerberusOverlay.AddAccessibilityOverlay()
        CerberusOverlay.AddStaticText("Cerberus")
        CerberusOverlay.AddCustomButton("Classic Mix",, ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginClassicMix"))
        CerberusOverlay.AddCustomButton("Modern Mix",, ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginModernMix"))
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", CerberusOverlay)
        
        ChorusOverlay := AccessibilityOverlay("Chorus")
        ChorusOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Chorus", "Image", Map("File", "Images/KontaktKompleteKontrol/Chorus.png"))
        ChorusOverlay.AddAccessibilityOverlay()
        ChorusOverlay.AddStaticText("Chorus")
        ChorusOverlay.AddCustomButton("Classic Mix",, ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginClassicMix"))
        ChorusOverlay.AddCustomButton("Modern Mix",, ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginModernMix"))
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", ChorusOverlay)
        
        JaegerOverlay := AccessibilityOverlay("Jaeger")
        JaegerOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Jaeger", "Image", Map("File", "Images/KontaktKompleteKontrol/Jaeger.png"))
        JaegerOverlay.AddAccessibilityOverlay()
        JaegerOverlay.AddStaticText("Jaeger")
        JaegerOverlay.AddCustomButton("Classic Mix",, ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginClassicMix"))
        JaegerOverlay.AddCustomButton("Modern Mix",, ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginModernMix"))
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", JaegerOverlay)
        
        NucleusOverlay := AccessibilityOverlay("Nucleus")
        NucleusOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Nucleus", "Image", Map("File", "Images/KontaktKompleteKontrol/Nucleus.png"))
        NucleusOverlay.AddAccessibilityOverlay()
        NucleusOverlay.AddStaticText("Nucleus")
        NucleusOverlay.AddCustomButton("Classic Mix",, ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginClassicMix"))
        NucleusOverlay.AddCustomButton("Modern Mix",, ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginModernMix"))
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", NucleusOverlay)
        
        SoloOverlay := AccessibilityOverlay("Solo")
        SoloOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Solo", "Image", Map("File", "Images/KontaktKompleteKontrol/Solo.png"))
        SoloOverlay.AddAccessibilityOverlay()
        SoloOverlay.AddStaticText("Solo")
        SoloOverlay.AddCustomButton("Classic Mix",, ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginClassicMix"))
        SoloOverlay.AddCustomButton("Modern Mix",, ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginModernMix"))
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", SoloOverlay)
        
        TalosOverlay := AccessibilityOverlay("Talos")
        TalosOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Talos", "Image", Map("File", "Images/KontaktKompleteKontrol/Talos.png"))
        TalosOverlay.AddAccessibilityOverlay()
        TalosOverlay.AddStaticText("Talos")
        TalosOverlay.AddCustomButton("Classic Mix",, ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginClassicMix"))
        TalosOverlay.AddCustomButton("Modern Mix",, ObjBindMethod(KontaktKompleteKontrol, "SelectAIPluginModernMix"))
        Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", TalosOverlay)
        
        Standalone.RegisterOverlay("Komplete Kontrol", KompleteKontrolStandaloneHeader)
        Standalone.RegisterOverlay("Kontakt", KontaktStandaloneHeader)
        
        Plugin.SetTimer("Kontakt/Komplete Kontrol", ObjBindMethod(AutoChangePluginOverlay,, "Kontakt/Komplete Kontrol", True, True), 500)
        Plugin.SetTimer("Kontakt/Komplete Kontrol", ObjBindMethod(KontaktKompleteKontrol, "DetectPlugin"), 500)
        
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
    
    Static LoadPluginHeader(PluginName) {
        KompleteKontrolPluginHeader := AccessibilityOverlay("Komplete Kontrol")
        KompleteKontrolPluginHeader.AddStaticText("Komplete Kontrol")
        KompleteKontrolPluginHeader.AddHotspotButton("Menu", CompensatePluginXCoordinate(305), CompensatePluginYCoordinate(68))
        KontaktPluginHeader := AccessibilityOverlay("Kontakt")
        KontaktPluginHeader.AddStaticText("Kontakt")
        KontaktPluginHeader.AddCustomButton("FILE",, ObjBindMethod(KontaktKompleteKontrol, "OpenKontaktPluginFileMenu"))
        KontaktPluginHeader.AddHotspotButton("LIBRARY", CompensatePluginXCoordinate(237), CompensatePluginYCoordinate(70))
        KontaktPluginHeader.AddCustomButton("VIEW",, ObjBindMethod(KontaktKompleteKontrol, "OpenKontaktPluginViewMenu"))
        KontaktPluginHeader.AddHotspotButton("SHOP", CompensatePluginXCoordinate(828), CompensatePluginYCoordinate(70))
        UnknownPluginHeader := AccessibilityOverlay("Unknown")
        UnknownPluginHeader.AddStaticText("Kontakt/Komplete Kontrol")
        UnknownPluginHeader.AddStaticText("Warning! The exact plugin could not be detected. Some functions may not work correctly.")
        If ReaHotkey.FoundPlugin Is Plugin And Not HasProp(ReaHotkey.FoundPlugin.Overlay, "Metadata") {
            ReaHotkey.FoundPlugin.Overlay.Metadata := Map("Product", "None")
            ReaHotkey.FoundPlugin.Overlay.OverlayNumber := 1
        }
        If ReaHotkey.FoundPlugin.Overlay.ChildControls[1].Label != PluginName {
            If PluginName = "Komplete Kontrol"
            ReaHotkey.FoundPlugin.Overlay.ChildControls[1] := KompleteKontrolPluginHeader.Clone()
            Else If PluginName = "Kontakt"
            ReaHotkey.FoundPlugin.Overlay.ChildControls[1] := KontaktPluginHeader.Clone()
            Else
            ReaHotkey.FoundPlugin.Overlay.ChildControls[1] := UnknownPluginHeader.Clone()
        }
    }
    
    Static OpenKontaktPluginFileMenu(*) {
        SetTimer ReaHotkey.ManageState, 0
        ReaHotkey.TurnPluginHotkeysOff()
        ReaHotkey.TurnPluginTimersOff("Kontakt/Komplete Kontrol")
        Click CompensatePluginXCoordinate(186), CompensatePluginYCoordinate(70)
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
        SetTimer ReaHotkey.ManageState, 100
    }
    
    Static OpenKontaktPluginViewMenu(*) {
        SetTimer ReaHotkey.ManageState, 0
        ReaHotkey.TurnPluginHotkeysOff()
        ReaHotkey.TurnPluginTimersOff("Kontakt/Komplete Kontrol")
        Click CompensatePluginXCoordinate(298), CompensatePluginYCoordinate(70)
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
        SetTimer ReaHotkey.ManageState, 100
    }
    
    Static OpenKontaktStandaloneFileMenu(*) {
        SetTimer ReaHotkey.ManageState, 0
        ReaHotkey.TurnStandaloneHotkeysOff()
        ReaHotkey.TurnStandaloneTimersOff("Kontakt")
        Click 186, 70
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
        SetTimer ReaHotkey.ManageState, 100
    }
    
    Static OpenKontaktStandaloneViewMenu(*) {
        SetTimer ReaHotkey.ManageState, 0
        ReaHotkey.TurnStandaloneHotkeysOff()
        ReaHotkey.TurnStandaloneTimersOff("Kontakt")
        Click 298, 70
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
        SetTimer ReaHotkey.ManageState, 100
    }
    
    Static ReturnPlugin() {
        If FindImage("Images/KontaktKompleteKontrol/KompleteKontrol.png", GetPluginXCoordinate(), GetPluginYCoordinate()) Is Array
        Return "Komplete Kontrol"
        Else
        If FindImage("Images/KontaktKompleteKontrol/Kontakt.png", GetPluginXCoordinate(), GetPluginYCoordinate()) Is Array
        Return "Kontakt"
        Return False
    }
    
    Static SelectAIPluginClassicMix(*) {
        Product := ""
        If ReaHotkey.FoundPlugin Is Plugin And HasProp(ReaHotkey.FoundPlugin.Overlay, "Metadata") And ReaHotkey.FoundPlugin.Overlay.Metadata.Has("Product") And ReaHotkey.FoundPlugin.Overlay.Metadata["Product"] != ""
        Product := ReaHotkey.FoundPlugin.Overlay.Metadata["Product"]
        Switch(KontaktKompleteKontrol.ReturnPlugin()) {
            Case "Komplete Kontrol":
            Switch(Product) {
                Case "Areia":
                Click CompensatePluginXCoordinate(200), CompensatePluginYCoordinate(461)
                Case "Cerberus":
                Click CompensatePluginXCoordinate(200), CompensatePluginYCoordinate(461)
                Case "Chorus":
                Click CompensatePluginXCoordinate(200), CompensatePluginYCoordinate(461)
                Case "Jaeger":
                Click CompensatePluginXCoordinate(200), CompensatePluginYCoordinate(461)
                Case "Nucleus":
                Click CompensatePluginXCoordinate(226), CompensatePluginYCoordinate(416)
                Case "Solo":
                Click CompensatePluginXCoordinate(200), CompensatePluginYCoordinate(461)
                Case "Talos":
                Click CompensatePluginXCoordinate(200), CompensatePluginYCoordinate(461)
            }
            Case "Kontakt":
            Switch(Product) {
                Case "Areia":
                Click CompensatePluginXCoordinate(100), CompensatePluginYCoordinate(361)
                Case "Cerberus":
                Click CompensatePluginXCoordinate(100), CompensatePluginYCoordinate(361)
                Case "Chorus":
                Click CompensatePluginXCoordinate(100), CompensatePluginYCoordinate(361)
                Case "Jaeger":
                Click CompensatePluginXCoordinate(100), CompensatePluginYCoordinate(361)
                Case "Nucleus":
                Click CompensatePluginXCoordinate(126), CompensatePluginYCoordinate(316)
                Case "Solo":
                Click CompensatePluginXCoordinate(100), CompensatePluginYCoordinate(361)
                Case "Talos":
                Click CompensatePluginXCoordinate(100), CompensatePluginYCoordinate(361)
            }
        }
    }
    
    Static SelectAIPluginModernMix(*) {
        Product := ""
        If ReaHotkey.FoundPlugin Is Plugin And HasProp(ReaHotkey.FoundPlugin.Overlay, "Metadata") And ReaHotkey.FoundPlugin.Overlay.Metadata.Has("Product") And ReaHotkey.FoundPlugin.Overlay.Metadata["Product"] != ""
        Product := ReaHotkey.FoundPlugin.Overlay.Metadata["Product"]
        Switch(KontaktKompleteKontrol.ReturnPlugin()) {
            Case "Komplete Kontrol":
            Switch(Product) {
                Case "Areia":
                Click CompensatePluginXCoordinate(283), CompensatePluginYCoordinate(461)
                Case "Cerberus":
                Click CompensatePluginXCoordinate(283), CompensatePluginYCoordinate(461)
                Case "Chorus":
                Click CompensatePluginXCoordinate(283), CompensatePluginYCoordinate(461)
                Case "Jaeger":
                Click CompensatePluginXCoordinate(283), CompensatePluginYCoordinate(461)
                Case "Nucleus":
                Click CompensatePluginXCoordinate(264), CompensatePluginYCoordinate(446)
                Case "Solo":
                Click CompensatePluginXCoordinate(283), CompensatePluginYCoordinate(461)
                Case "Talos":
                Click CompensatePluginXCoordinate(283), CompensatePluginYCoordinate(461)
            }
            Case "Kontakt":
            Switch(Product) {
                Case "Areia":
                Click CompensatePluginXCoordinate(183), CompensatePluginYCoordinate(361)
                Case "Cerberus":
                Click CompensatePluginXCoordinate(183), CompensatePluginYCoordinate(361)
                Case "Chorus":
                Click CompensatePluginXCoordinate(183), CompensatePluginYCoordinate(361)
                Case "Jaeger":
                Click CompensatePluginXCoordinate(183), CompensatePluginYCoordinate(361)
                Case "Nucleus":
                Click CompensatePluginXCoordinate(164), CompensatePluginYCoordinate(346)
                Case "Solo":
                Click CompensatePluginXCoordinate(183), CompensatePluginYCoordinate(361)
                Case "Talos":
                Click CompensatePluginXCoordinate(183), CompensatePluginYCoordinate(361)
            }
        }
    }
    
}

KontaktKompleteKontrol.Init()
