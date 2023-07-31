#Requires AutoHotkey v2.0

Plugin.DefaultOverlay := AccessibilityOverlay()
Plugin.DefaultOverlay.AddSpeechOutput("No overlay defined")
Plugin.ChooserOverlay := AccessibilityOverlay()
Plugin.ChooserOverlay.AddCustomButton("Choose overlay",, ChoosePluginOverlay)

Standalone.DefaultOverlay := AccessibilityOverlay()
Standalone.DefaultOverlay.AddSpeechOutput("No overlay defined")
Standalone.ChooserOverlay := AccessibilityOverlay()
Standalone.ChooserOverlay.AddCustomButton("Choose overlay",, ChooseStandaloneOverlay)

AreiaOverlay := AccessibilityOverlay("Areia")
AreiaOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Areia")
AreiaOverlay.AddHotspotButton("Classic Mix", 468, 395, CompensatePluginClick)
AreiaOverlay.AddHotspotButton("Modern Mix", 565, 395, CompensatePluginClick)
Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", AreiaOverlay)

JaegerOverlay := AccessibilityOverlay("Jaeger")
JaegerOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Jaeger")
JaegerOverlay.AddHotspotButton("Classic Mix", 468, 395, CompensatePluginClick)
JaegerOverlay.AddHotspotButton("Modern Mix", 565, 395, CompensatePluginClick)
Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", JaegerOverlay)

NucleusOverlay := AccessibilityOverlay("Nucleus")
NucleusOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Nucleus")
NucleusOverlay.AddHotspotButton("Classic Mix", 480, 349, CompensatePluginClick)
NucleusOverlay.AddHotspotButton("Modern Mix", 480, 379, CompensatePluginClick)
Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", NucleusOverlay)

TalosOverlay := AccessibilityOverlay("Talos")
TalosOverlay.Metadata := Map("Vendor", "Audio Imperia", "Product", "Talos")
TalosOverlay.AddHotspotButton("Classic Mix", 468, 395, CompensatePluginClick)
TalosOverlay.AddHotspotButton("Modern Mix", 565, 395, CompensatePluginClick)
Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", TalosOverlay)

EnginePluginOverlay := AccessibilityOverlay("Engine")
EnginePluginOverlay.Metadata := Map("Vendor", "Best Service", "Product", "Engine")
EnginePluginOverlay.AddHotspotButton("Load instrument", 110, 179, CompensatePluginClick)
EnginePluginQuickEditTab := HotspotTab("Quick edit", 364, 71, CompensatePluginClick)
EnginePluginProEditTab := HotspotTab("Pro edit", 418, 71, CompensatePluginClick)
EnginePluginBrowserTab := HotspotTab("Browser", 476, 71, CompensatePluginClick)
EnginePluginMixerTab := HotspotTab("Mixer", 534, 71, CompensatePluginClick)
EnginePluginPreferencesTab := HotspotTab("Preferences", 590, 71, CompensatePluginClick)
EnginePluginHelpTab := HotspotTab("Help", 640, 71, CompensatePluginClick)
EnginePluginOverlay.AddTabControl(, EnginePluginQuickEditTab, EnginePluginProEditTab, EnginePluginBrowserTab, EnginePluginMixerTab, EnginePluginPreferencesTab, EnginePluginHelpTab)
EnginePluginEngineTab := HotspotTab("Engine", 366, 115, CompensatePluginClick)
EnginePluginLibrariesTab := HotspotTab("Libraries", 440, 115, CompensatePluginClick)
EnginePluginAddLibraryButton := EnginePluginLibrariesTab.AddHotspotButton("Add library", 442, 151, FocusedEnginePluginAddLibraryButton)
EnginePluginUserFolderTab := HotspotTab("User folder", 506, 115, CompensatePluginClick)
EnginePluginOutputSurrTab := HotspotTab("Output/Surr", 578, 115, CompensatePluginClick)
EnginePluginMiscTab := HotspotTab("Misc.", 662, 115, CompensatePluginClick)
EnginePluginPreferencesTab.AddTabControl(, EnginePluginEngineTab, EnginePluginLibrariesTab, EnginePluginUserFolderTab, EnginePluginOutputSurrTab, EnginePluginMiscTab)
Plugin.RegisterOverlay("Engine", EnginePluginOverlay)

EngineStandaloneOverlay := AccessibilityOverlay("Engine")
EngineStandaloneOverlay.Metadata := Map("Vendor", "Best Service", "Product", "Engine")
EngineStandaloneOverlay.AddHotspotButton("Load instrument", 112, 180)
EngineStandaloneQuickEditTab := HotspotTab("Quick edit", 352, 72)
EngineStandaloneProEditTab := HotspotTab("Pro edit", 424, 72)
EngineStandaloneBrowserTab := HotspotTab("Browser", 488, 72)
EngineStandaloneMixerTab := HotspotTab("Mixer", 528, 72)
EngineStandalonePreferencesTab := HotspotTab("Preferences", 580, 72)
EngineStandaloneHelpTab := HotspotTab("Help", 600, 72)
EngineStandaloneOverlay.AddTabControl(, EngineStandaloneQuickEditTab, EngineStandaloneProEditTab, EngineStandaloneBrowserTab, EngineStandaloneMixerTab, EngineStandalonePreferencesTab, EngineStandaloneHelpTab)
EngineStandaloneEngineTab := HotspotTab("Engine", 396, 112)
EngineStandaloneLibrariesTab := HotspotTab("Libraries", 424, 112)
EngineStandaloneAddLibraryButton := EngineStandaloneLibrariesTab.AddHotspotButton("Add library", 436, 146)
EngineStandaloneUserFolderTab := HotspotTab("User folder", 488, 112)
EngineStandaloneOutputSurrTab := HotspotTab("Output/Surr", 572, 112)
EngineStandaloneMiscTab := HotspotTab("Misc.", 656, 112)
EngineStandalonePreferencesTab.AddTabControl(, EngineStandaloneEngineTab, EngineStandaloneLibrariesTab, EngineStandaloneUserFolderTab, EngineStandaloneOutputSurrTab, EngineStandaloneMiscTab)
Standalone.RegisterOverlay("Engine", EngineStandaloneOverlay)

ShreddageOverlay := AccessibilityOverlay("Shreddage Series")
ShreddageOverlay.Metadata := Map("Vendor", "Impact Soundworks", "Product", "Shreddage Series")
ShreddageOverlay.AddHotspotButton("Guitar Number 1", 842, 471, CompensatePluginClick)
ShreddageOverlay.AddHotspotButton("Guitar Number 2", 866, 471, CompensatePluginClick)
ShreddageOverlay.AddHotspotButton("Guitar Number 3", 890, 471, CompensatePluginClick)
ShreddageOverlay.AddHotspotButton("Guitar Number 4", 914, 471, CompensatePluginClick)
Plugin.RegisterOverlay("Kontakt/Komplete Kontrol", ShreddageOverlay)
