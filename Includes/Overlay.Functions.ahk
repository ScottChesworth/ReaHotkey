﻿#Requires AutoHotkey v2.0

Global A_IsUnicode := True

AutoChangeOverlay(Type, Name, CompensatePluginCoordinates := False, ReportChange := False) {
    SetTimer ReaHotkey.ManageState, 0
    OverlayList := %Type%.GetOverlays(Name)
    UnknownProductCounter := 1
    For OverlayNumber, OverlayEntry In OverlayList {
        PluginControlXCoordinate := ""
        PluginControlYCoordinate := ""
        FoundX := ""
        FoundY := ""
        WinWidth := ""
        WinHeight := ""
        Try {
            WinGetPos ,, &WinWidth, &WinHeight, "A"
        }
        Catch {
            WinWidth := A_ScreenWidth
            WinHeight := A_ScreenHeight
        }
        If HasProp(OverlayEntry, "Metadata") And OverlayEntry.Metadata.Has("Product") And OverlayEntry.Metadata["Product"] != "" {
            Product := OverlayEntry.Metadata["Product"]
        }
        Else If OverlayEntry.Label != "" {
            Product := OverlayEntry.Label
        }
        Else {
            Product := "unknown product " . UnknownProductCounter
            UnknownProductCounter++
        }
        If ReaHotkey.Found%Type% Is %Type% And ReaHotkey.Found%Type%.Overlay.OverlayNumber != OverlayEntry.OverlayNumber
        If HasProp(OverlayEntry, "Metadata") And OverlayEntry.Metadata.Has("Image") And OverlayEntry.Metadata["Image"] != "" {
            If Not OverlayEntry.Metadata["Image"] Is Map
            OverlayMetadata := Map("File", OverlayEntry.Metadata["Image"])
            Else
            OverlayMetadata := OverlayEntry.Metadata["Image"].Clone()
            If Not OverlayMetadata.Has("File")
            OverlayMetadata.Set("File", OverlayEntry.Metadata["Image"])
            If Not OverlayMetadata.Has("X1Coordinate")
            OverlayMetadata.Set("X1Coordinate", 0)
            If Not OverlayMetadata.Has("Y1Coordinate")
            OverlayMetadata.Set("Y1Coordinate", 0)
            If Not OverlayMetadata.Has("X2Coordinate")
            OverlayMetadata.Set("X2Coordinate", WinWidth)
            If Not OverlayMetadata.Has("Y2Coordinate")
            OverlayMetadata.Set("Y2Coordinate", WinHeight)
            If Not OverlayMetadata["X1Coordinate"] Is Number Or OverlayMetadata["X1Coordinate"] < 0
            OverlayMetadata["X1Coordinate"] := 0
            If Not OverlayMetadata["Y1Coordinate"] Is Number Or OverlayMetadata["Y1Coordinate"] < 0
            OverlayMetadata["Y1Coordinate"] := 0
            If Not OverlayMetadata["X2Coordinate"] Is Number Or OverlayMetadata["X2Coordinate"] <= 0
            OverlayMetadata["X2Coordinate"] := WinWidth
            If Not OverlayMetadata["Y2Coordinate"] Is Number Or OverlayMetadata["Y2Coordinate"] <= 0
            OverlayMetadata["Y2Coordinate"] := WinHeight
            If Type = "Plugin" And CompensatePluginCoordinates = True {
                Try {
                    ControlGetPos &PluginControlXCoordinate, &PluginControlYCoordinate,,, ReaHotkey.GetPluginControl(), ReaHotkey.PluginWinCriteria
                }
                Catch {
                    PluginControlXCoordinate := 210
                    PluginControlYCoordinate := 53
                }
                OverlayMetadata["X1Coordinate"] := PluginControlXCoordinate + OverlayMetadata["X1Coordinate"]
                OverlayMetadata["Y1Coordinate"] := PluginControlYCoordinate + OverlayMetadata["Y1Coordinate"]
                OverlayMetadata["X2Coordinate"] := PluginControlXCoordinate + OverlayMetadata["X2Coordinate"]
                OverlayMetadata["Y2Coordinate"] := PluginControlYCoordinate + OverlayMetadata["Y2Coordinate"]
                If OverlayMetadata["X2Coordinate"] > WinWidth
                OverlayMetadata["X2Coordinate"] := WinWidth
                If OverlayMetadata["Y2Coordinate"] > WinHeight
                OverlayMetadata["Y2Coordinate"] := WinHeight
            }
            If FileExist(OverlayMetadata["File"]) {
                Try
                ImageFound := ImageSearch(&FoundX, &FoundY, OverlayMetadata["X1Coordinate"], OverlayMetadata["Y1Coordinate"], OverlayMetadata["X2Coordinate"], OverlayMetadata["Y2Coordinate"], OverlayMetadata["File"])
                Catch
                ImageFound := 0
                If ImageFound = 1
                If ReaHotkey.Found%Type%.Chooser = True {
                    OverlayHeader := ReaHotkey.Found%Type%.Overlay.ChildControls[1].Clone()
                    ReaHotkey.Found%Type%.Overlay := AccessibilityOverlay(OverlayEntry.Label)
                    ReaHotkey.Found%Type%.Overlay.OverlayNumber := OverlayNumber
                    If HasProp(OverlayEntry, "Metadata")
                    ReaHotkey.Found%Type%.Overlay.Metadata := OverlayEntry.Metadata
                    ReaHotkey.Found%Type%.Overlay.AddControl(OverlayHeader)
                    ReaHotkey.Found%Type%.Overlay.AddControl(OverlayEntry.Clone())
                    ReaHotkey.Found%Type%.Overlay.AddControl(%Type%.ChooserOverlay.Clone())
                    If ReportChange = True {
                        AccessibilityOverlay.Speak(Product . " overlay active")
                        ReaHotkey.Wait(1250)
                    }
                    ReaHotkey.Found%Type%.Overlay.FocusControl(ReaHotkey.Found%Type%.Overlay.ChildControls[2].ChildControls[2].ControlID)
                    If ReaHotkey.AutoFocus%Type%Overlay = True
                    ReaHotkey.AutoFocus%Type%Overlay := False
                    Break
                }
                Else {
                    ReaHotkey.Found%Type%.Overlay := OverlayEntry.Clone()
                    If ReportChange = True {
                        AccessibilityOverlay.Speak(Product . " overlay active")
                        ReaHotkey.Wait(1250)
                    }
                    ReaHotkey.Found%Type%.Overlay.FocusControl(ReaHotkey.Found%Type%.Overlay.ChildControls[2].ControlID)
                    If ReaHotkey.AutoFocus%Type%Overlay = True
                    ReaHotkey.AutoFocus%Type%Overlay := False
                    Break
                }
            }
        }
    }
    SetTimer ReaHotkey.ManageState, 100
}

AutoChangePluginOverlay(Name, CompensatePluginCoordinates := False, ReportChange := False) {
    AutoChangeOverlay("Plugin", Name, CompensatePluginCoordinates, ReportChange)
}

AutoChangeStandaloneOverlay(Name, ReportChange := False) {
    AutoChangeOverlay("Standalone", Name, False, ReportChange)
}

ChangeOverlay(Type, ItemName, ItemNumber, OverlayMenu) {
    SetTimer ReaHotkey.ManageState, 0
    OverlayList := %Type%.GetOverlays(ReaHotkey.Found%Type%.Name)
    OverlayNumber := OverlayMenu.OverlayNumbers[ItemNumber]
    If ReaHotkey.Found%Type%.Overlay.OverlayNumber != OverlayNumber
    If ReaHotkey.Found%Type%.Chooser = True {
        OverlayHeader := ReaHotkey.Found%Type%.Overlay.ChildControls[1].Clone()
        ReaHotkey.Found%Type%.Overlay := AccessibilityOverlay(ItemName)
        ReaHotkey.Found%Type%.Overlay.OverlayNumber := OverlayNumber
        If HasProp(OverlayList[OverlayNumber], "Metadata")
        ReaHotkey.Found%Type%.Overlay.Metadata := OverlayList[OverlayNumber].Metadata
        ReaHotkey.Found%Type%.Overlay.AddControl(OverlayHeader)
        ReaHotkey.Found%Type%.Overlay.AddControl(OverlayList[OverlayNumber].Clone())
        ReaHotkey.Found%Type%.Overlay.AddControl(Plugin.ChooserOverlay.Clone())
        ReaHotkey.Found%Type%.Overlay.SetCurrentControlID(ReaHotkey.Found%Type%.Overlay.ChildControls[3].ChildControls[2].ControlID)
        ReaHotkey.Found%Type%.Overlay.ChildControls[3].ChildControls[2].Focus()
    }
    Else {
        ReaHotkey.Found%Type%.Overlay := OverlayList[OverlayNumber].Clone()
        ReaHotkey.Found%Type%.Overlay.Focus()
    }
    Else
    ReaHotkey.Found%Type%.Overlay.Focus()
    SetTimer ReaHotkey.ManageState, 100
}

ChangePluginOverlay(ItemName, ItemNumber, OverlayMenu) {
    ChangeOverlay("Plugin", ItemName, ItemNumber, OverlayMenu)
}

ChangeStandaloneOverlay(ItemName, ItemNumber, OverlayMenu) {
    ChangeOverlay("Standalone", ItemName, ItemNumber, OverlayMenu)
}

ChooseOverlay(Type) {
    OverlayMenu := CreateOverlayMenu(ReaHotkey.FoundPlugin, Type)
    OverlayMenu.Show()
}

ChoosePluginOverlay(*) {
    ChooseOverlay("Plugin")
}

ChooseStandaloneOverlay(*) {
    ChooseOverlay("Standalone")
}

CompensatePluginPointCoordinates(PluginControl) {
    If !HasProp(PluginControl, "OriginalXCoordinate")
    PluginControl.OriginalXCoordinate := PluginControl.XCoordinate
    If !HasProp(PluginControl, "OriginalYCoordinate")
    PluginControl.OriginalYCoordinate := PluginControl.YCoordinate
    Try {
        ControlGetPos &PluginControlXCoordinate, &PluginControlYCoordinate,,, ReaHotkey.GetPluginControl(), ReaHotkey.PluginWinCriteria
    }
    Catch {
        PluginControlXCoordinate := 210
        PluginControlYCoordinate := 53
    }
    PluginControl.XCoordinate := PluginControlXCoordinate + PluginControl.OriginalXCoordinate
    PluginControl.YCoordinate := PluginControlYCoordinate + PluginControl.OriginalYCoordinate
    Return PluginControl
}

CompensatePluginRegionCoordinates(PluginControl) {
    If !HasProp(PluginControl, "OriginalRegionX1Coordinate")
    PluginControl.OriginalRegionX1Coordinate := PluginControl.RegionX1Coordinate
    If !HasProp(PluginControl, "OriginalRegionY1Coordinate")
    PluginControl.OriginalRegionY1Coordinate := PluginControl.RegionY1Coordinate
    If !HasProp(PluginControl, "OriginalRegionX2Coordinate")
    PluginControl.OriginalRegionX2Coordinate := PluginControl.RegionX2Coordinate
    If !HasProp(PluginControl, "OriginalRegionY2Coordinate")
    PluginControl.OriginalRegionY2Coordinate := PluginControl.RegionY2Coordinate
    Try {
        ControlGetPos &PluginControlXCoordinate, &PluginControlYCoordinate,,, ReaHotkey.GetPluginControl(), ReaHotkey.PluginWinCriteria
    }
    Catch {
        PluginControlXCoordinate := 210
        PluginControlYCoordinate := 53
    }
    PluginControl.RegionX1Coordinate := PluginControlXCoordinate + PluginControl.OriginalRegionX1Coordinate
    PluginControl.RegionY1Coordinate := PluginControlYCoordinate + PluginControl.OriginalRegionY1Coordinate
    PluginControl.RegionX2Coordinate := PluginControlXCoordinate + PluginControl.OriginalRegionX2Coordinate
    PluginControl.RegionY2Coordinate := PluginControlYCoordinate + PluginControl.OriginalRegionY2Coordinate
    Return PluginControl
}

CompensatePluginXCoordinate(PluginXCoordinate) {
    Try {
        ControlGetPos &PluginControlXCoordinate, &PluginControlYCoordinate,,, ReaHotkey.GetPluginControl(), ReaHotkey.PluginWinCriteria
    }
    Catch {
        PluginControlXCoordinate := 210
        PluginControlYCoordinate := 53
    }
    PluginXCoordinate := PluginControlXCoordinate + PluginXCoordinate
    Return PluginXCoordinate
}

CompensatePluginYCoordinate(PluginYCoordinate) {
    Try {
        ControlGetPos &PluginControlXCoordinate, &PluginControlYCoordinate,,, ReaHotkey.GetPluginControl(), ReaHotkey.PluginWinCriteria
    }
    Catch {
        PluginControlXCoordinate := 210
        PluginControlYCoordinate := 53
    }
    PluginYCoordinate := PluginControlYCoordinate + PluginYCoordinate
    Return PluginYCoordinate
}

CreateOverlayMenu(Found, Type) {
    CurrentOverlay := Found.Overlay
    OverlayEntries := %Type%.GetOverlays(Found.Name)
    OverlayList := ""
    OverlayMenu := Accessible%Type%Menu()
    OverlayMenu.OverlayNumbers := Array()
    UnknownProductCounter := 1
    If HasProp(CurrentOverlay, "Metadata") And CurrentOverlay.Metadata.Has("Vendor") And CurrentOverlay.Metadata["Vendor"] != ""
    CurrentVendor := CurrentOverlay.Metadata["Vendor"]
    Else
    CurrentVendor := ""
    For OverlayNumber, OverlayEntry In OverlayEntries {
        If HasProp(OverlayEntry, "Metadata") And OverlayEntry.Metadata.Has("Vendor") And OverlayEntry.Metadata["Vendor"] != "" {
            Vendor := OverlayEntry.Metadata["Vendor"]
        }
        Else {
            Vendor := ""
        }
        If HasProp(OverlayEntry, "Metadata") And OverlayEntry.Metadata.Has("Product") And OverlayEntry.Metadata["Product"] != "" {
            Product := OverlayEntry.Metadata["Product"]
        }
        Else If OverlayEntry.Label != "" {
            Product := OverlayEntry.Label
        }
        Else {
            Product := "unknown product " . UnknownProductCounter
            UnknownProductCounter++
        }
        OverlayList .= Vendor . "`t" . Product . "`t" . OverlayNumber . "`n"
        OverlayList := Sort(OverlayList)
    }
    MainMenuItems := Array()
    Submenus := Map()
    Loop parse, OverlayList, "`n" {
        OverlayEntry := StrSplit(A_LoopField, "`t")
        If OverlayEntry.Length = 3 {
            Vendor := OverlayEntry[1]
            For ElementIndex, ElementValue In OverlayEntry {
                If Vendor = "" {
                    If ElementIndex = 1
                    MainMenuItems.Push(Map("Product", "", "OverlayNumber", ""))
                    If ElementIndex = 2
                    MainMenuItems[MainMenuItems.Length]["Product"] := ElementValue
                    If ElementIndex = 3
                    MainMenuItems[MainMenuItems.Length]["OverlayNumber"] := ElementValue
                }
                Else {
                    If ElementIndex = 1 {
                        If Not Submenus.Has(Vendor)
                        Submenus.Set(Vendor, Array())
                        Submenus[Vendor].Push(Map("Product", "", "OverlayNumber", ""))
                    }
                    If ElementIndex = 2
                    Submenus[Vendor][Submenus[Vendor].Length]["Product"] := ElementValue
                    If ElementIndex = 3
                    Submenus[Vendor][Submenus[Vendor].Length]["OverlayNumber"] := ElementValue
                }
            }
        }
    }
    For Vendor, OverlayEntries In Submenus {
        Submenu := Accessible%Type%Menu()
        Submenu.OverlayNumbers := Array()
        For OverlayEntry In OverlayEntries {
            Submenu.Add(OverlayEntry["Product"], Change%Type%Overlay)
            If OverlayEntry["OverlayNumber"] = CurrentOverlay.OverlayNumber
            Submenu.Check(OverlayEntry["Product"])
            Submenu.OverlayNumbers.Push(OverlayEntry["OverlayNumber"])
        }
        Submenu.Add("")
        Submenu.OverlayNumbers.Push(0)
        OverlayMenu.Add(Vendor, Submenu)
        If Vendor = CurrentVendor
        OverlayMenu.Check(Vendor)
        OverlayMenu.OverlayNumbers.Push(0)
    }
    For OverlayEntry In MainMenuItems {
        OverlayMenu.Add(OverlayEntry["Product"], Change%Type%Overlay)
        If OverlayEntry["OverlayNumber"] = CurrentOverlay.OverlayNumber
        OverlayMenu.Check(OverlayEntry["Product"])
        OverlayMenu.OverlayNumbers.Push(OverlayEntry["OverlayNumber"])
    }
    OverlayMenu.Add("")
    OverlayMenu.OverlayNumbers.Push(0)
    Return OverlayMenu
}

InArray(Needle, Haystack) {
    For FoundIndex, FoundValue In Haystack
    If FoundValue == Needle
    Return FoundIndex
    Return False
}

ConvertBase(InputBase, OutputBase, nptr)    ; Base 2 - 36
{
    static u := A_IsUnicode ? "_wcstoui64" : "_strtoui64"
    static v := A_IsUnicode ? "_i64tow"    : "_i64toa"
    s := ""
    VarSetStrCapacity(&s, 66)
    value := DllCall("msvcrt.dll\" u, "Str", nptr, "UInt", 0, "UInt", InputBase, "CDECL Int64")
    DllCall("msvcrt.dll\" v, "Int64", value, "Str", s, "UInt", OutputBase, "CDECL")
    return s
}

StrJoin(obj,delimiter:="",OmitChars:=""){
    S := obj[1]
    Loop obj.Length - 1
        S .= delimiter Trim(obj[A_Index+1],OmitChars)
    return S
}

FindImage(ImageFile, X1Coordinate := 0, Y1Coordinate := 0, X2Coordinate := 0, Y2Coordinate := 0) {
    FoundX := ""
    FoundY := ""
    WinWidth := ""
    WinHeight := ""
    Try {
        WinGetPos ,, &WinWidth, &WinHeight, "A"
    }
    Catch {
        WinWidth := A_ScreenWidth
        WinHeight := A_ScreenHeight
    }
    If Not X1Coordinate Is Number Or X1Coordinate < 0
    X1Coordinate := 0
    If Not Y1Coordinate Is Number Or Y1Coordinate < 0
    Y1Coordinate := 0
    If Not X2Coordinate Is Number Or X2Coordinate <= 0
    X2Coordinate := WinWidth
    If Not Y2Coordinate Is Number Or Y2Coordinate <= 0
    Y2Coordinate := WinHeight
    If FileExist(ImageFile) {
        Try
        ImageFound := ImageSearch(&FoundX, &FoundY, X1Coordinate, Y1Coordinate, X2Coordinate, Y2Coordinate, ImageFile)
        Catch
        ImageFound := 0
        If ImageFound = 1
        Return Array(FoundX, FoundY)
    }
    Return False
}

GetCurrentControlClass() {
    Try
    If ControlGetFocus("A") = 0
    ControlClass := False
    Else
    ControlClass := ControlGetClassNN(ControlGetFocus("A"))
    Catch
    ControlClass := False
    Return ControlClass
}

GetCurrentWindowID() {
    Try
    WindowID := WinGetID("A")
    Catch
    WindowID := False
    Return WindowID
}

GetPluginXCoordinate() {
    Try {
        ControlGetPos &PluginControlXCoordinate, &PluginControlYCoordinate,,, ReaHotkey.GetPluginControl(), ReaHotkey.PluginWinCriteria
    }
    Catch {
        PluginControlXCoordinate := 210
        PluginControlYCoordinate := 53
    }
    Return PluginControlXCoordinate
}

GetPluginYCoordinate() {
    Try {
        ControlGetPos &PluginControlXCoordinate, &PluginControlYCoordinate,,, ReaHotkey.GetPluginControl(), ReaHotkey.PluginWinCriteria
    }
    Catch {
        PluginControlXCoordinate := 210
        PluginControlYCoordinate := 53
    }
    Return PluginControlYCoordinate
}

KeyWaitCombo() {
    IH := InputHook()
    IH.VisibleNonText := True
    IH.KeyOpt("{All}", "E")
    IH.KeyOpt("{LCtrl}{RCtrl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}", "-E")
    IH.Timeout := 0.125
    IH.Start()
    IH.Wait(0.125)
    Return RegExReplace(IH.EndMods . IH.EndKey, "[<>](.)(?:>\1)?", "$1")
}

KeyWaitSingle() {
    IH := InputHook()
    IH.VisibleNonText := True
    IH.KeyOpt("{All}", "E")
    IH.Start()
    IH.Wait()
    Return IH.EndKey
}

TriggerHotkey(Type, HotkeyCommand) {
    If ReaHotkey.Found%Type% Is %Type% And ReaHotkey.Found%Type%.Overlay Is AccessibilityOverlay
    ReaHotkey.Found%Type%.Overlay.TriggerHotkey(HotkeyCommand)
}

TriggerPluginHotkey(HotkeyCommand) {
    TriggerHotkey("Plugin", HotkeyCommand)
}

TriggerStandaloneHotkey(HotkeyCommand) {
    TriggerHotkey("Standalone", HotkeyCommand)
}
