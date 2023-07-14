#Requires AutoHotkey v2.0

Class Plugin {
    
    ControlClass := ""
    FocusFunction := ""
    SingleInstance := False
    Name := ""
    Overlay := AccessibilityOverlay()
    Static ChooserOverlay := AccessibilityOverlay()
    Static DefaultOverlay := AccessibilityOverlay()
    Static Instances := Array()
    Static List := Array()
    Static UnnamedPluginName := "Unnamed Plugin"
    
    __New(Name, ControlClass, FocusFunction := "", SingleInstance := False) {
        If Name == ""
        This.Name := Plugin.UnnamedPluginName
        Else
        This.Name := Name
        This.ControlClass := ControlClass
        This.FocusFunction := FocusFunction
        If SingleInstance != True And SingleInstance != False
        This.SingleInstance := False
        Overlays := Plugin.GetOverlays(Name)
        If Overlays.Length == 1 {
            This.Overlay := Overlays[1].Clone()
        }
        Else If Overlays.Length > 1 {
            This.Overlay := AccessibilityOverlay()
            This.Overlay.AddControl(Plugin.ChooserOverlay.Clone())
        }
        Else {
            This.Overlay := AccessibilityOverlay()
            This.Overlay.AddControl(Plugin.DefaultOverlay.Clone())
        }
    }
    
    Focus() {
        If This.FocusFunction != ""
    %this.FocusFunction%(This)
    }
    
    GetOverlay() {
    Return This.Overlay
    }
    
    GetOverlays() {
    Return Plugin.GetOverlays(This.Name)
    }
    
    Static FindClass(ClassName) {
    For PluginNumber, PluginEntry In Plugin.List {
    If IsObject(PluginEntry["ControlClasses"]) And PluginEntry["ControlClasses"].Length > 0
    For ControlClass In PluginEntry["ControlClasses"]
    If RegExMatch(ClassName, ControlClass)
    Return PluginNumber
    }
    Return False
    }
    
    Static FindName(PluginName) {
    For PluginNumber, PluginEntry In Plugin.List
    If PluginEntry["Name"] == PluginName
    Return PluginNumber
    Return False
    }
    
    Static GetByClass(ControlClass) {
    PluginNumber := Plugin.FindClass(ControlClass)
    If PluginNumber > 0 {
    PluginName := Plugin.List[PluginNumber]["Name"]
    SingleInstance := Plugin.List[PluginNumber]["SingleInstance"]
    If SingleInstance == True {
    For PluginInstance In Plugin.Instances
    If PluginInstance.Name == PluginName
    Return PluginInstance
    }
    Else {
    For PluginInstance In Plugin.Instances
    If PluginInstance.ControlClass == ControlClass
    Return PluginInstance
    }
    PluginInstance := Plugin(Plugin.List[PluginNumber]["Name"], ControlClass, Plugin.List[PluginNumber]["FocusFunction"])
    Plugin.Instances.Push(PluginInstance)
    Return PluginInstance
    }
    Return Plugin("", ControlClass)
    }
    
    Static GetList() {
    Return Plugin.List
    }
    
    Static GetOverlays(PluginName) {
    PluginNumber := Plugin.FindName(PluginName)
    If PluginNumber > 0
    Return Plugin.List[PluginNumber]["Overlays"]
    Return Array()
    }
    
    Static Register(PluginName, ControlClasses, FocusFunction := "", SingleInstance := False) {
    If Plugin.FindName(PluginName) == False {
    If PluginName == ""
    PluginName := Plugin.UnnamedPluginName
    If SingleInstance != True And SingleInstance != False
    SingleInstance := False
    PluginEntry := Map()
    PluginEntry["Name"] := PluginName
    PluginEntry["ControlClasses"] := ControlClasses
    PluginEntry["FocusFunction"] := FocusFunction
    PluginEntry["SingleInstance"] := SingleInstance
    PluginEntry["Overlays"] := Array()
    Plugin.List.Push(PluginEntry)
    }
    }
    
    Static RegisterOverlay(PluginName, PluginOverlay) {
    PluginNumber := Plugin.FindName(PluginName)
    If PluginNumber > 0
    Plugin.List[PluginNumber]["Overlays"].Push(PluginOverlay.Clone())
    }
    
    }
        