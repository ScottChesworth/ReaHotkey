#Requires AutoHotkey v2.0

#MaxThreadsPerHotkey 1
#SingleInstance Force
#Warn All
CoordMode "Mouse", "Window"
CoordMode "Pixel", "Window"
InstallKeybdHook
SendMode "Input"
SetTitleMatchMode "RegEx"
SetWorkingDir A_InitialWorkingDir

#Include <AccessibilityOverlay>
#Include <AccessibleMenu>
#Include <AccessiblePluginMenu>
#Include <AccessibleStandaloneMenu>
#Include <JXON>
#Include <OCR>
#Include <Plugin>
#Include <ReaHotkey>
#Include <Standalone>

A_IconTip := "ReaHotkey"
A_TrayMenu.Delete
A_TrayMenu.Add("&Pause", ReaHotkey.TogglePause)
A_TrayMenu.Add("View &Readme", ReaHotkey.ViewReadme)
A_TrayMenu.Add("&About...", ReaHotkey.ShowAboutBox)
A_TrayMenu.Add("&Quit", ReaHotkey.Quit)
A_TrayMenu.Default := "&Pause"

AccessibilityOverlay.Speak("ReaHotkey ready")

ReaHotkey.TurnPluginHotkeysOff()
ReaHotkey.TurnStandaloneHotkeysOff()
OnError ReaHotkey.HandleError
SetTimer ReaHotkey.ManageState, 100

#Include Includes/Global.Context.ahk
#Include Includes/Plugin.Context.ahk
#Include Includes/Standalone.Context.ahk
#Include Includes/Overlay.Definitions.ahk
#Include Includes/Overlay.Functions.ahk
#Include Includes/Version.ahk
#Include *i Includes/CIVersion.ahk

;@Ahk2Exe-Let U_Version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_BuildNumber = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetFileVersion %U_Version%.%U_BuildNumber%
;@Ahk2Exe-Let U_Version = %U_Version%-b%U_BuildNumber%
;@Ahk2Exe-Let U_OrigFilename = %A_ScriptName~\.[^\.]+$~.exe%
;@Ahk2Exe-SetOrigFilename %U_OrigFilename%
;@Ahk2Exe-SetDescription ReaHotkey application
;@Ahk2Exe-SetProductName ReaHotkey
;@Ahk2Exe-SetProductVersion %U_Version%
