local addon, ns = ...
local Version = GetAddOnMetadata(addon, "Version")

--Cache Lua / WoW API
local format = string.format
local GetCVarBool = GetCVarBool
local ReloadUI = ReloadUI
local StopMusic = StopMusic

-- These are things we do not cache
-- GLOBALS: PluginInstallStepComplete, PluginInstallFrame

--Change this line and use a unique name for your plugin.
local MyPluginName = "|cffc41e3aOzUI|r"

--Create references to ElvUI internals
local E, L, V, P, G = unpack(ElvUI)

--Create reference to LibElvUIPlugin
local EP = LibStub("LibElvUIPlugin-1.0")

--Create a new ElvUI module so ElvUI can handle initialization when ready
local mod = E:NewModule(MyPluginName, "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0");

--This function will hold your layout settings
local function SetupLayout(layout)

E.db["databars"]["experience"]["orientation"] = "HORIZONTAL"
E.db["databars"]["experience"]["height"] = 10
E.db["databars"]["experience"]["hideAtMaxLevel"] = false
E.db["databars"]["experience"]["width"] = 152
E.db["databars"]["azerite"]["orientation"] = "HORIZONTAL"
E.db["databars"]["azerite"]["font"] = "Expressway"
E.db["databars"]["azerite"]["height"] = 10
E.db["databars"]["azerite"]["width"] = 152
E.db["databars"]["reputation"]["enable"] = true
E.db["databars"]["reputation"]["orientation"] = "HORIZONTAL"
E.db["databars"]["reputation"]["height"] = 10
E.db["databars"]["reputation"]["width"] = 152
E.db["databars"]["honor"]["orientation"] = "HORIZONTAL"
E.db["databars"]["honor"]["height"] = 10
E.db["databars"]["honor"]["width"] = 152
E.db["currentTutorial"] = 7
E.db["general"]["totems"]["enable"] = false
E.db["general"]["totems"]["growthDirection"] = "HORIZONTAL"
E.db["general"]["totems"]["size"] = 34
E.db["general"]["threat"]["enable"] = false
E.db["general"]["autoAcceptInvite"] = true
E.db["general"]["bordercolor"]["r"] = 0
E.db["general"]["bordercolor"]["g"] = 0
E.db["general"]["bordercolor"]["b"] = 0
E.db["general"]["minimap"]["size"] = 150
E.db["general"]["minimap"]["locationFont"] = "Expressway"
E.db["general"]["minimap"]["icons"]["classHall"]["scale"] = 0.6
E.db["general"]["autoRoll"] = true
E.db["general"]["font"] = "Expressway"
E.db["general"]["bottomPanel"] = false
E.db["general"]["valuecolor"]["r"] = 0.53
E.db["general"]["valuecolor"]["g"] = 0.53
E.db["general"]["valuecolor"]["b"] = 0.93
E.db["general"]["vendorGrays"] = true
E.db["general"]["talkingHeadFrameScale"] = 0.6
E.db["general"]["fontSize"] = 11
E.db["bags"]["countFontSize"] = 11
E.db["bags"]["countFont"] = "Expressway"
E.db["bags"]["itemLevelFont"] = "Expressway"
E.db["bags"]["bagSize"] = 32
E.db["bags"]["countFontOutline"] = "OUTLINE"
E.db["bags"]["bankWidth"] = 354
E.db["bags"]["itemLevelFontSize"] = 11
E.db["bags"]["itemLevelFontOutline"] = "OUTLINE"
E.db["bags"]["bankSize"] = 32
E.db["bags"]["junkIcon"] = true
E.db["bags"]["bagWidth"] = 354
E.db["hideTutorial"] = true
E.db["auras"]["font"] = "Expressway"
E.db["auras"]["fontOutline"] = "OUTLINE"
E.db["auras"]["buffs"]["horizontalSpacing"] = 1
E.db["auras"]["buffs"]["durationFontSize"] = 11
E.db["auras"]["buffs"]["maxWraps"] = 2
E.db["auras"]["buffs"]["countFontSize"] = 11
E.db["auras"]["buffs"]["wrapAfter"] = 15
E.db["auras"]["debuffs"]["horizontalSpacing"] = 1
E.db["auras"]["debuffs"]["durationFontSize"] = 11
E.db["auras"]["debuffs"]["maxWraps"] = 2
E.db["auras"]["debuffs"]["countFontSize"] = 11
E.db["auras"]["debuffs"]["wrapAfter"] = 15
E.db["layoutSet"] = "dpsCaster"
E.db["movers"]["PetAB"] = "BOTTOM,ElvUIParent,BOTTOM,-236,344"
E.db["movers"]["ElvUF_RaidMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,159"
E.db["movers"]["GMMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-32"
E.db["movers"]["BuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-156,-3"
E.db["movers"]["TargetPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,208,363"
E.db["movers"]["BossButton"] = "BOTTOM,ElvUIParent,BOTTOM,-237,433"
E.db["movers"]["LootFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,524,-244"
E.db["movers"]["SocialMenuMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,160"
E.db["movers"]["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,736"
E.db["movers"]["ElvUF_FocusMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,187"
E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,406"
E.db["movers"]["MicrobarMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,26"
E.db["movers"]["ExperienceBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-154"
E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-547,366"
E.db["movers"]["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,382"
E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,337"
E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,308"
E.db["movers"]["TalkingHeadFrameMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,37"
E.db["movers"]["ElvAB_4"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,359,4"
E.db["movers"]["ElvAB_5"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-359,4"
E.db["movers"]["AzeriteBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-74,-97"
E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,279"
E.db["movers"]["ReputationBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-163"
E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,366"
E.db["movers"]["ArenaHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-321,-320"
E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-236,366"
E.db["movers"]["ObjectiveFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-75,-279"
E.db["movers"]["BNETMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-216"
E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,248"
E.db["movers"]["SquareMinimapButtonBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-183"
E.db["movers"]["HonorBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-172"
E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,236,344"
E.db["movers"]["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-3,121"
E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,397"
E.db["movers"]["BossHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-346,-320"
E.db["movers"]["TotemBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,418,4"
E.db["movers"]["ElvUF_PetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,546,366"
E.db["movers"]["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,465,365"
E.db["movers"]["ElvAB_6"] = "BOTTOM,ElvUIParent,BOTTOM,0,4"
E.db["movers"]["DebuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-156,-57"
E.db["movers"]["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,236,366"
E.db["tooltip"]["font"] = "Expressway"
E.db["tooltip"]["healthBar"]["statusPosition"] = "TOP"
E.db["tooltip"]["healthBar"]["font"] = "Expressway"
E.db["tooltip"]["healthBar"]["text"] = false
E.db["tooltip"]["healthBar"]["height"] = 1
E.db["tooltip"]["fontSize"] = 12
E.db["unitframe"]["fontSize"] = 11
E.db["unitframe"]["colors"]["auraBarBuff"]["r"] = 0.53
E.db["unitframe"]["colors"]["auraBarBuff"]["g"] = 0.53
E.db["unitframe"]["colors"]["auraBarBuff"]["b"] = 0.93
E.db["unitframe"]["colors"]["colorhealthbyvalue"] = false
E.db["unitframe"]["colors"]["healthclass"] = true
E.db["unitframe"]["colors"]["customhealthbackdrop"] = true
E.db["unitframe"]["colors"]["health_backdrop"]["r"] = 0.070588235294118
E.db["unitframe"]["colors"]["health_backdrop"]["g"] = 0.070588235294118
E.db["unitframe"]["colors"]["health_backdrop"]["b"] = 0.070588235294118
E.db["unitframe"]["colors"]["castClassColor"] = true
E.db["unitframe"]["colors"]["power"]["MANA"]["r"] = 0
E.db["unitframe"]["colors"]["power"]["MANA"]["g"] = 0.74509803921569
E.db["unitframe"]["colors"]["power"]["MANA"]["b"] = 0.90196078431373
E.db["unitframe"]["colors"]["power"]["FOCUS"]["r"] = 0.90196078431373
E.db["unitframe"]["colors"]["power"]["FOCUS"]["g"] = 0.54901960784314
E.db["unitframe"]["colors"]["power"]["FOCUS"]["b"] = 0.23529411764706
E.db["unitframe"]["colors"]["power"]["RUNIC_POWER"]["g"] = 0.74509803921569
E.db["unitframe"]["colors"]["power"]["RUNIC_POWER"]["b"] = 0.90196078431373
E.db["unitframe"]["colors"]["power"]["ENERGY"]["r"] = 0.85882352941176
E.db["unitframe"]["colors"]["power"]["ENERGY"]["g"] = 0.81176470588235
E.db["unitframe"]["colors"]["power"]["ENERGY"]["b"] = 0.20392156862745
E.db["unitframe"]["colors"]["castColor"]["r"] = 0.8
E.db["unitframe"]["colors"]["castColor"]["g"] = 0.8
E.db["unitframe"]["colors"]["castColor"]["b"] = 0.8
E.db["unitframe"]["colors"]["disconnected"]["r"] = 0.76470588235294
E.db["unitframe"]["colors"]["disconnected"]["g"] = 0.7921568627451
E.db["unitframe"]["colors"]["disconnected"]["b"] = 0.85098039215686
E.db["unitframe"]["colors"]["castNoInterrupt"]["r"] = 1
E.db["unitframe"]["colors"]["castNoInterrupt"]["g"] = 0.13725490196078
E.db["unitframe"]["colors"]["castNoInterrupt"]["b"] = 0.19607843137255
E.db["unitframe"]["colors"]["tapped"]["r"] = 0.76470588235294
E.db["unitframe"]["colors"]["tapped"]["g"] = 0.7921568627451
E.db["unitframe"]["colors"]["tapped"]["b"] = 0.85098039215686
E.db["unitframe"]["colors"]["reaction"]["BAD"]["r"] = 1
E.db["unitframe"]["colors"]["reaction"]["BAD"]["g"] = 0.13725490196078
E.db["unitframe"]["colors"]["reaction"]["BAD"]["b"] = 0.19607843137255
E.db["unitframe"]["colors"]["reaction"]["NEUTRAL"]["r"] = 1
E.db["unitframe"]["colors"]["reaction"]["NEUTRAL"]["g"] = 0.97647058823529
E.db["unitframe"]["colors"]["reaction"]["NEUTRAL"]["b"] = 0.36862745098039
E.db["unitframe"]["colors"]["reaction"]["GOOD"]["r"] = 0.41960784313726
E.db["unitframe"]["colors"]["reaction"]["GOOD"]["g"] = 1
E.db["unitframe"]["colors"]["reaction"]["GOOD"]["b"] = 0.40392156862745
E.db["unitframe"]["colors"]["health_backdrop_dead"]["g"] = 0.011764705882353
E.db["unitframe"]["colors"]["health_backdrop_dead"]["b"] = 0.011764705882353
E.db["unitframe"]["colors"]["health"]["r"] = 0
E.db["unitframe"]["colors"]["health"]["g"] = 1
E.db["unitframe"]["colors"]["health"]["b"] = 0.070588235294118
E.db["unitframe"]["fontOutline"] = "OUTLINE"
E.db["unitframe"]["font"] = "Expressway"
E.db["unitframe"]["statusbar"] = "ElvUI Blank"
E.db["unitframe"]["units"]["tank"]["enable"] = false
E.db["unitframe"]["units"]["pet"]["castbar"]["height"] = 21
E.db["unitframe"]["units"]["pet"]["castbar"]["width"] = 85
E.db["unitframe"]["units"]["pet"]["width"] = 85
E.db["unitframe"]["units"]["pet"]["name"]["text_format"] = "[name:medium]"
E.db["unitframe"]["units"]["pet"]["height"] = 30
E.db["unitframe"]["units"]["pet"]["power"]["enable"] = false
E.db["unitframe"]["units"]["arena"]["debuffs"]["xOffset"] = 2
E.db["unitframe"]["units"]["arena"]["debuffs"]["fontSize"] = 11
E.db["unitframe"]["units"]["arena"]["debuffs"]["sizeOverride"] = 18
E.db["unitframe"]["units"]["arena"]["debuffs"]["yOffset"] = -10
E.db["unitframe"]["units"]["arena"]["power"]["text_format"] = ""
E.db["unitframe"]["units"]["arena"]["width"] = 225
E.db["unitframe"]["units"]["arena"]["name"]["text_format"] = "[name:veryshort]"
E.db["unitframe"]["units"]["arena"]["height"] = 40
E.db["unitframe"]["units"]["arena"]["buffs"]["xOffset"] = 2
E.db["unitframe"]["units"]["arena"]["buffs"]["fontSize"] = 11
E.db["unitframe"]["units"]["arena"]["buffs"]["sizeOverride"] = 18
E.db["unitframe"]["units"]["arena"]["buffs"]["yOffset"] = 10
E.db["unitframe"]["units"]["arena"]["health"]["text_format"] = "[health:current]"
E.db["unitframe"]["units"]["arena"]["castbar"]["height"] = 10
E.db["unitframe"]["units"]["arena"]["castbar"]["icon"] = false
E.db["unitframe"]["units"]["arena"]["castbar"]["spark"] = false
E.db["unitframe"]["units"]["arena"]["castbar"]["width"] = 225
E.db["unitframe"]["units"]["targettarget"]["power"]["enable"] = false
E.db["unitframe"]["units"]["targettarget"]["power"]["height"] = 10
E.db["unitframe"]["units"]["targettarget"]["width"] = 85
E.db["unitframe"]["units"]["targettarget"]["name"]["text_format"] = "[name:veryshort]"
E.db["unitframe"]["units"]["targettarget"]["height"] = 30
E.db["unitframe"]["units"]["assist"]["enable"] = false
E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 231
E.db["unitframe"]["units"]["player"]["classbar"]["height"] = 14
E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] = true
E.db["unitframe"]["units"]["player"]["aurabar"]["enable"] = false
E.db["unitframe"]["units"]["player"]["RestIcon"]["enable"] = false
E.db["unitframe"]["units"]["player"]["CombatIcon"]["enable"] = false
E.db["unitframe"]["units"]["player"]["threatStyle"] = "NONE"

if not E.db["unitframe"]["units"]["player"]["customTexts"] then E.db["unitframe"]["units"]["player"]["customTexts"] = {} end --Create customTexts table once for player
E.db["unitframe"]["units"]["player"]["customTexts"]["OzHealth"] = {} --Create table once
E.db["unitframe"]["units"]["player"]["customTexts"]["OzHealth"]["attachTextTo"] = "Health"
E.db["unitframe"]["units"]["player"]["customTexts"]["OzHealth"]["enable"] = true
E.db["unitframe"]["units"]["player"]["customTexts"]["OzHealth"]["text_format"] = "[health:current]"
E.db["unitframe"]["units"]["player"]["customTexts"]["OzHealth"]["yOffset"] = 0
E.db["unitframe"]["units"]["player"]["customTexts"]["OzHealth"]["font"] = "Expressway"
E.db["unitframe"]["units"]["player"]["customTexts"]["OzHealth"]["justifyH"] = "LEFT"
E.db["unitframe"]["units"]["player"]["customTexts"]["OzHealth"]["fontOutline"] = "OUTLINE"
E.db["unitframe"]["units"]["player"]["customTexts"]["OzHealth"]["xOffset"] = 4
E.db["unitframe"]["units"]["player"]["customTexts"]["OzHealth"]["size"] = 12
E.db["unitframe"]["units"]["player"]["castbar"]["height"] = 30
E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 231
E.db["unitframe"]["units"]["player"]["castbar"]["insideInfoPanel"] = false
E.db["unitframe"]["units"]["player"]["width"] = 183
E.db["unitframe"]["units"]["player"]["health"]["text_format"] = ""
E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] = true
E.db["unitframe"]["units"]["player"]["power"]["text_format"] = ""
E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 231
E.db["unitframe"]["units"]["player"]["height"] = 30
E.db["unitframe"]["units"]["player"]["pvp"]["text_format"] = ""
E.db["unitframe"]["units"]["raid40"]["horizontalSpacing"] = 1
E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["font"] = "Expressway"
E.db["unitframe"]["units"]["raid40"]["healPrediction"] = true
E.db["unitframe"]["units"]["raid40"]["width"] = 70
E.db["unitframe"]["units"]["raid40"]["name"]["text_format"] = "[name:short]"
E.db["unitframe"]["units"]["raid40"]["disableTargetGlow"] = true
E.db["unitframe"]["units"]["raid40"]["verticalSpacing"] = 1
E.db["unitframe"]["units"]["focus"]["debuffs"]["anchorPoint"] = "TOPLEFT"
E.db["unitframe"]["units"]["focus"]["debuffs"]["sizeOverride"] = 28
E.db["unitframe"]["units"]["focus"]["castbar"]["width"] = 224
E.db["unitframe"]["units"]["focus"]["width"] = 224
E.db["unitframe"]["units"]["focus"]["disableTargetGlow"] = true
E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = "[name:medium]"
E.db["unitframe"]["units"]["target"]["debuffs"]["anchorPoint"] = "TOPLEFT"
E.db["unitframe"]["units"]["target"]["debuffs"]["fontSize"] = 11
E.db["unitframe"]["units"]["target"]["debuffs"]["attachTo"] = "FRAME"
E.db["unitframe"]["units"]["target"]["debuffs"]["perrow"] = 10
E.db["unitframe"]["units"]["target"]["debuffs"]["sizeOverride"] = 25
E.db["unitframe"]["units"]["target"]["debuffs"]["yOffset"] = 13
E.db["unitframe"]["units"]["target"]["threatStyle"] = "NONE"
E.db["unitframe"]["units"]["target"]["power"]["height"] = 4
E.db["unitframe"]["units"]["target"]["power"]["detachedWidth"] = 183
E.db["unitframe"]["units"]["target"]["power"]["text_format"] = ""
E.db["unitframe"]["units"]["target"]["rangeCheck"] = false

if not E.db["unitframe"]["units"]["target"]["customTexts"] then E.db["unitframe"]["units"]["target"]["customTexts"] = {} end --Create customTexts table once for player
E.db["unitframe"]["units"]["target"]["customTexts"]["OzHealth"] = {} --Create table once
E.db["unitframe"]["units"]["target"]["customTexts"]["OzHealth"]["attachTextTo"] = "Health"
E.db["unitframe"]["units"]["target"]["customTexts"]["OzHealth"]["enable"] = true
E.db["unitframe"]["units"]["target"]["customTexts"]["OzHealth"]["text_format"] = "[health:current-percent]"
E.db["unitframe"]["units"]["target"]["customTexts"]["OzHealth"]["yOffset"] = 0
E.db["unitframe"]["units"]["target"]["customTexts"]["OzHealth"]["font"] = "Expressway"
E.db["unitframe"]["units"]["target"]["customTexts"]["OzHealth"]["justifyH"] = "RIGHT"
E.db["unitframe"]["units"]["target"]["customTexts"]["OzHealth"]["fontOutline"] = "OUTLINE"
E.db["unitframe"]["units"]["target"]["customTexts"]["OzHealth"]["xOffset"] = 0
E.db["unitframe"]["units"]["target"]["customTexts"]["OzHealth"]["size"] = 12

E.db["unitframe"]["units"]["target"]["customTexts"]["OzNameSmall"] = {} --Create table once
E.db["unitframe"]["units"]["target"]["customTexts"]["OzNameSmall"]["attachTextTo"] = "Health"
E.db["unitframe"]["units"]["target"]["customTexts"]["OzNameSmall"]["enable"] = true
E.db["unitframe"]["units"]["target"]["customTexts"]["OzNameSmall"]["text_format"] = "[namecolor][name:long] [difficultycolor][smartlevel] [shortclassification]"
E.db["unitframe"]["units"]["target"]["customTexts"]["OzNameSmall"]["yOffset"] = 23
E.db["unitframe"]["units"]["target"]["customTexts"]["OzNameSmall"]["font"] = "Expressway"
E.db["unitframe"]["units"]["target"]["customTexts"]["OzNameSmall"]["justifyH"] = "RIGHT"
E.db["unitframe"]["units"]["target"]["customTexts"]["OzNameSmall"]["fontOutline"] = "OUTLINE"
E.db["unitframe"]["units"]["target"]["customTexts"]["OzNameSmall"]["xOffset"] = 0
E.db["unitframe"]["units"]["target"]["customTexts"]["OzNameSmall"]["size"] = 11
E.db["unitframe"]["units"]["target"]["width"] = 183
E.db["unitframe"]["units"]["target"]["name"]["text_format"] = ""
E.db["unitframe"]["units"]["target"]["health"]["text_format"] = ""
E.db["unitframe"]["units"]["target"]["castbar"]["height"] = 21
E.db["unitframe"]["units"]["target"]["castbar"]["width"] = 183
E.db["unitframe"]["units"]["target"]["height"] = 30
E.db["unitframe"]["units"]["target"]["buffs"]["anchorPoint"] = "BOTTOMLEFT"
E.db["unitframe"]["units"]["target"]["buffs"]["sizeOverride"] = 18
E.db["unitframe"]["units"]["target"]["buffs"]["attachTo"] = "DEBUFFS"
E.db["unitframe"]["units"]["target"]["buffs"]["perrow"] = 3
E.db["unitframe"]["units"]["target"]["buffs"]["yOffset"] = 4
E.db["unitframe"]["units"]["target"]["aurabar"]["enable"] = false
E.db["unitframe"]["units"]["raid"]["horizontalSpacing"] = 1
E.db["unitframe"]["units"]["raid"]["rdebuffs"]["font"] = "Expressway"
E.db["unitframe"]["units"]["raid"]["rdebuffs"]["fontOutline"] = "OUTLINE"
E.db["unitframe"]["units"]["raid"]["rdebuffs"]["size"] = 17
E.db["unitframe"]["units"]["raid"]["growthDirection"] = "RIGHT_UP"
E.db["unitframe"]["units"]["raid"]["roleIcon"]["size"] = 10
E.db["unitframe"]["units"]["raid"]["power"]["enable"] = false
E.db["unitframe"]["units"]["raid"]["healPrediction"] = true
E.db["unitframe"]["units"]["raid"]["width"] = 70
E.db["unitframe"]["units"]["raid"]["name"]["text_format"] = "[name:short]"
E.db["unitframe"]["units"]["raid"]["name"]["position"] = "TOP"
E.db["unitframe"]["units"]["raid"]["disableTargetGlow"] = true
E.db["unitframe"]["units"]["raid"]["height"] = 30
E.db["unitframe"]["units"]["raid"]["verticalSpacing"] = 1
E.db["unitframe"]["units"]["party"]["debuffs"]["anchorPoint"] = "LEFT"
E.db["unitframe"]["units"]["party"]["debuffs"]["sizeOverride"] = 30
E.db["unitframe"]["units"]["party"]["disableTargetGlow"] = true
E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Expressway"
E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = "OUTLINE"
E.db["unitframe"]["units"]["party"]["rdebuffs"]["enable"] = true
E.db["unitframe"]["units"]["party"]["rdebuffs"]["size"] = 17
E.db["unitframe"]["units"]["party"]["roleIcon"]["size"] = 10
E.db["unitframe"]["units"]["party"]["power"]["text_format"] = ""
E.db["unitframe"]["units"]["party"]["power"]["height"] = 3
E.db["unitframe"]["units"]["party"]["width"] = 80
E.db["unitframe"]["units"]["party"]["health"]["text_format"] = ""
E.db["unitframe"]["units"]["party"]["name"]["text_format"] = "[name:veryshort]"
E.db["unitframe"]["units"]["party"]["name"]["position"] = "TOP"
E.db["unitframe"]["units"]["party"]["height"] = 30
E.db["unitframe"]["units"]["boss"]["debuffs"]["numrows"] = 1
E.db["unitframe"]["units"]["boss"]["debuffs"]["fontSize"] = 18
E.db["unitframe"]["units"]["boss"]["debuffs"]["xOffset"] = 2
E.db["unitframe"]["units"]["boss"]["debuffs"]["sizeOverride"] = 35
E.db["unitframe"]["units"]["boss"]["debuffs"]["perrow"] = 5
E.db["unitframe"]["units"]["boss"]["debuffs"]["yOffset"] = 1
E.db["unitframe"]["units"]["boss"]["width"] = 200
E.db["unitframe"]["units"]["boss"]["health"]["text_format"] = "[health:percent]"
E.db["unitframe"]["units"]["boss"]["castbar"]["width"] = 200
E.db["unitframe"]["units"]["boss"]["height"] = 40
E.db["unitframe"]["units"]["boss"]["buffs"]["numrows"] = 2
E.db["unitframe"]["units"]["boss"]["buffs"]["perrow"] = 1
E.db["unitframe"]["units"]["boss"]["buffs"]["xOffset"] = -1
E.db["unitframe"]["units"]["boss"]["buffs"]["yOffset"] = 14
E.db["unitframe"]["units"]["boss"]["name"]["text_format"] = "[name:medium]"
E.db["datatexts"]["minimapPanels"] = false
E.db["datatexts"]["font"] = "Expressway"
E.db["datatexts"]["panelTransparency"] = true
E.db["actionbar"]["bar3"]["buttonsize"] = 28
E.db["actionbar"]["bar3"]["buttons"] = 8
E.db["actionbar"]["bar3"]["buttonsPerRow"] = 8
E.db["actionbar"]["bar3"]["backdropSpacing"] = 0
E.db["actionbar"]["bar3"]["buttonspacing"] = 1
E.db["actionbar"]["bar6"]["enabled"] = true
E.db["actionbar"]["bar6"]["buttonspacing"] = 0
E.db["actionbar"]["bar6"]["mouseover"] = true
E.db["actionbar"]["bar6"]["backdropSpacing"] = 0
E.db["actionbar"]["bar6"]["buttonsize"] = 28
E.db["actionbar"]["fontOutline"] = "OUTLINE"
E.db["actionbar"]["microbar"]["enabled"] = true
E.db["actionbar"]["microbar"]["mouseover"] = true
E.db["actionbar"]["noPowerColor"]["g"] = 0.31764705882353
E.db["actionbar"]["noPowerColor"]["r"] = 0.19607843137255
E.db["actionbar"]["bar2"]["enabled"] = true
E.db["actionbar"]["bar2"]["buttons"] = 8
E.db["actionbar"]["bar2"]["buttonspacing"] = 1
E.db["actionbar"]["bar2"]["backdropSpacing"] = 0
E.db["actionbar"]["bar2"]["buttonsize"] = 28
E.db["actionbar"]["bar1"]["buttons"] = 8
E.db["actionbar"]["bar1"]["buttonspacing"] = 1
E.db["actionbar"]["bar1"]["backdropSpacing"] = 0
E.db["actionbar"]["bar1"]["buttonsize"] = 28
E.db["actionbar"]["bar5"]["buttonsize"] = 30
E.db["actionbar"]["bar5"]["point"] = "TOPLEFT"
E.db["actionbar"]["bar5"]["buttons"] = 10
E.db["actionbar"]["bar5"]["buttonspacing"] = 1
E.db["actionbar"]["bar5"]["buttonsPerRow"] = 2
E.db["actionbar"]["bar5"]["backdropSpacing"] = 1
E.db["actionbar"]["font"] = "Expressway"
E.db["actionbar"]["stanceBar"]["buttonsize"] = 28
E.db["actionbar"]["stanceBar"]["point"] = "TOP"
E.db["actionbar"]["stanceBar"]["backdropSpacing"] = 0
E.db["actionbar"]["stanceBar"]["buttonspacing"] = 0
E.db["actionbar"]["stanceBar"]["mouseover"] = true
E.db["actionbar"]["stanceBar"]["alpha"] = 0.7
E.db["actionbar"]["stanceBar"]["usePositionOverride"] = false
E.db["actionbar"]["barPet"]["point"] = "TOPLEFT"
E.db["actionbar"]["barPet"]["backdropSpacing"] = 1
E.db["actionbar"]["barPet"]["buttonspacing"] = 1
E.db["actionbar"]["barPet"]["buttonsPerRow"] = 10
E.db["actionbar"]["barPet"]["mouseover"] = true
E.db["actionbar"]["barPet"]["buttonsize"] = 17
E.db["actionbar"]["bar4"]["buttonsize"] = 30
E.db["actionbar"]["bar4"]["backdrop"] = false
E.db["actionbar"]["bar4"]["point"] = "TOPLEFT"
E.db["actionbar"]["bar4"]["buttons"] = 10
E.db["actionbar"]["bar4"]["buttonspacing"] = 1
E.db["actionbar"]["bar4"]["buttonsPerRow"] = 2
E.db["actionbar"]["bar4"]["backdropSpacing"] = 1
E.db["nameplates"]["units"]["ENEMY_PLAYER"]["healthbar"]["text"]["enable"] = true
E.db["nameplates"]["lowHealthThreshold"] = 0.2
E.db["nameplates"]["font"] = "Expressway"
E.db["nameplates"]["classbar"]["enable"] = false
E.db["chat"]["emotionIcons"] = false
E.db["chat"]["tabFont"] = "Expressway"
E.db["chat"]["tabFontSize"] = 11
E.db["chat"]["font"] = "Expressway"
E.db["chat"]["panelHeight"] = 154
E.db["chat"]["tabFontOutline"] = "OUTLINE"
E.db["chat"]["fontSize"] = 12
E.db["chat"]["tapFontSize"] = 12
E.db["chat"]["panelWidth"] = 354






		--If you want to modify the base layout according to
		-- certain conditions then this is how you could do it
		if layout == "tank" then
			--Make some changes to the layout posted above
		elseif layout == "dpsv2" then
E.db["movers"]["ExperienceBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-154"
E.db["movers"]["AzeriteBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-154"
E.db["movers"]["ReputationBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-163"
E.db["movers"]["HonorBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-172"
E.db["movers"]["GMMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-32"
E.db["movers"]["BuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-156,-3"
E.db["movers"]["TargetPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,208,363"
E.db["movers"]["LootFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,524,-244"
E.db["movers"]["SocialMenuMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,160"
E.db["movers"]["ElvUF_FocusMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,153"
E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,350"
E.db["movers"]["MicrobarMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,26"
E.db["movers"]["BossButton"] = "BOTTOM,ElvUIParent,BOTTOM,-176,375"
E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,281"
E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,252"
E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,223"
E.db["movers"]["ElvAB_4"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,359,4"
E.db["movers"]["ElvAB_5"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-359,4"
E.db["movers"]["ElvAB_6"] = "BOTTOM,ElvUIParent,BOTTOM,0,4"
E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,192"
E.db["movers"]["PetAB"] = "BOTTOM,ElvUIParent,BOTTOM,-236,288"
E.db["movers"]["TotemBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,418,4"
E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-236,310"
E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,310"
E.db["movers"]["ElvUF_PetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,546,310"
E.db["movers"]["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,236,310"
E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,236,288"
E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-547,310"
E.db["movers"]["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,465,310"
E.db["movers"]["ArenaHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-321,-320"
E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,341"
E.db["movers"]["ObjectiveFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-75,-279"
E.db["movers"]["BNETMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-216"
E.db["movers"]["SquareMinimapButtonBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-183"
E.db["movers"]["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-3,121"
E.db["movers"]["BossHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-346,-320"
E.db["movers"]["DebuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-156,-57"
E.db["movers"]["TalkingHeadFrameMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,37"
E.db["unitframe"]["units"]["raid"]["horizontalSpacing"] = 1
E.db["unitframe"]["units"]["raid"]["rdebuffs"]["font"] = "Expressway"
E.db["unitframe"]["units"]["raid"]["rdebuffs"]["fontOutline"] = "OUTLINE"
E.db["unitframe"]["units"]["raid"]["rdebuffs"]["size"] = 17
E.db["unitframe"]["units"]["raid"]["growthDirection"] = "RIGHT_UP"
E.db["unitframe"]["units"]["raid"]["roleIcon"]["size"] = 10
E.db["unitframe"]["units"]["raid"]["power"]["enable"] = false
E.db["unitframe"]["units"]["raid"]["healPrediction"] = true
E.db["unitframe"]["units"]["raid"]["width"] = 70
E.db["unitframe"]["units"]["raid"]["name"]["text_format"] = "[name:short]"
E.db["unitframe"]["units"]["raid"]["name"]["position"] = "TOP"
E.db["unitframe"]["units"]["raid"]["disableTargetGlow"] = true
E.db["unitframe"]["units"]["raid"]["height"] = 30
E.db["unitframe"]["units"]["raid"]["verticalSpacing"] = 1
E.db["unitframe"]["units"]["party"]["debuffs"]["anchorPoint"] = "LEFT"
E.db["unitframe"]["units"]["party"]["debuffs"]["sizeOverride"] = 30
E.db["unitframe"]["units"]["party"]["disableTargetGlow"] = true
E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Expressway"
E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = "OUTLINE"
E.db["unitframe"]["units"]["party"]["rdebuffs"]["enable"] = true
E.db["unitframe"]["units"]["party"]["rdebuffs"]["size"] = 17
E.db["unitframe"]["units"]["party"]["roleIcon"]["size"] = 10
E.db["unitframe"]["units"]["party"]["power"]["text_format"] = ""
E.db["unitframe"]["units"]["party"]["power"]["height"] = 3
E.db["unitframe"]["units"]["party"]["width"] = 80
E.db["unitframe"]["units"]["party"]["health"]["text_format"] = ""
E.db["unitframe"]["units"]["party"]["name"]["text_format"] = "[name:veryshort]"
E.db["unitframe"]["units"]["party"]["name"]["position"] = "TOP"
E.db["unitframe"]["units"]["party"]["height"] = 30
		elseif layout == "healer" then
E.db["movers"]["PetAB"] = "BOTTOM,ElvUIParent,BOTTOM,-236,288"
E.db["movers"]["ElvUF_RaidMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,461,385"
E.db["movers"]["GMMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-32"
E.db["movers"]["BuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-156,-3"
E.db["movers"]["TargetPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,208,363"
E.db["movers"]["BossButton"] = "BOTTOM,ElvUIParent,BOTTOM,-86,422"
E.db["movers"]["LootFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,524,-244"
E.db["movers"]["SocialMenuMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,160"
E.db["movers"]["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,736"
E.db["movers"]["ElvUF_FocusMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,153"
E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,350"
E.db["movers"]["MicrobarMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,26"
E.db["movers"]["ExperienceBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-154"
E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-547,310"
E.db["movers"]["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,382"
E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,281"
E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,252"
E.db["movers"]["ElvAB_4"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,359,4"
E.db["movers"]["TalkingHeadFrameMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,37"
E.db["movers"]["ElvAB_5"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-359,4"
E.db["movers"]["AzeriteBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-74,-97"
E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,223"
E.db["movers"]["ReputationBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-163"
E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,310"
E.db["movers"]["ArenaHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-321,-320"
E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,341"
E.db["movers"]["ObjectiveFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-75,-279"
E.db["movers"]["BNETMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-216"
E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,192"
E.db["movers"]["SquareMinimapButtonBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-183"
E.db["movers"]["HonorBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-172"
E.db["movers"]["ElvAB_6"] = "BOTTOM,ElvUIParent,BOTTOM,0,4"
E.db["movers"]["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-3,121"
E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-236,310"
E.db["movers"]["BossHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-346,-320"
E.db["movers"]["ElvUF_PetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,546,310"
E.db["movers"]["TotemBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,418,4"
E.db["movers"]["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,735,385"
E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,236,288"
E.db["movers"]["DebuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-156,-57"
E.db["movers"]["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,236,310"
E.db["unitframe"]["units"]["raid"]["horizontalSpacing"] = 1
E.db["unitframe"]["units"]["raid"]["rdebuffs"]["font"] = "Expressway"
E.db["unitframe"]["units"]["raid"]["rdebuffs"]["fontOutline"] = "OUTLINE"
E.db["unitframe"]["units"]["raid"]["rdebuffs"]["size"] = 17
E.db["unitframe"]["units"]["raid"]["growthDirection"] = "RIGHT_UP"
E.db["unitframe"]["units"]["raid"]["roleIcon"]["size"] = 10
E.db["unitframe"]["units"]["raid"]["power"]["enable"] = false
E.db["unitframe"]["units"]["raid"]["healPrediction"] = true
E.db["unitframe"]["units"]["raid"]["width"] = 70
E.db["unitframe"]["units"]["raid"]["name"]["text_format"] = "[name:short]"
E.db["unitframe"]["units"]["raid"]["name"]["position"] = "TOP"
E.db["unitframe"]["units"]["raid"]["disableTargetGlow"] = true
E.db["unitframe"]["units"]["raid"]["height"] = 40
E.db["unitframe"]["units"]["raid"]["verticalSpacing"] = 1
E.db["unitframe"]["units"]["party"]["debuffs"]["anchorPoint"] = "LEFT"
E.db["unitframe"]["units"]["party"]["debuffs"]["sizeOverride"] = 30
E.db["unitframe"]["units"]["party"]["disableTargetGlow"] = true
E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Expressway"
E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontOutline"] = "OUTLINE"
E.db["unitframe"]["units"]["party"]["rdebuffs"]["enable"] = true
E.db["unitframe"]["units"]["party"]["rdebuffs"]["size"] = 17
E.db["unitframe"]["units"]["party"]["roleIcon"]["size"] = 10
E.db["unitframe"]["units"]["party"]["power"]["text_format"] = ""
E.db["unitframe"]["units"]["party"]["power"]["height"] = 3
E.db["unitframe"]["units"]["party"]["health"]["text_format"] = ""
E.db["unitframe"]["units"]["party"]["width"] = 80
E.db["unitframe"]["units"]["party"]["name"]["text_format"] = "[name:veryshort]"
E.db["unitframe"]["units"]["party"]["name"]["position"] = "TOP"
E.db["unitframe"]["units"]["party"]["height"] = 40
E.db["unitframe"]["units"]["party"]["verticalSpacing"] = 1
		end



	--[[
	--	This section at the bottom is just to update ElvUI and display a message
	--]]
	--Update ElvUI
	E:UpdateAll(true)
	--Show message about layout being set
	PluginInstallStepComplete.message = "OzUI DPS/Tank Layout Set"
	PluginInstallStepComplete:Show()
end

--This function is executed when you press "Skip Process" or "Finished" in the installer.
local function InstallComplete()
	if GetCVarBool("Sound_EnableMusic") then
		StopMusic()
	end

	--Set a variable tracking the version of the addon when layout was installed
	E.db[MyPluginName].install_version = Version

	ReloadUI()
end

--This is the data we pass on to the ElvUI Plugin Installer.
--The Plugin Installer is reponsible for displaying the install guide for this layout.
local InstallerData = {
	Title = format("|cff4beb2c%s %s|r", MyPluginName, "Installation"),
	Name = MyPluginName,
	tutorialImage = "interface\\addons\\ElvUI_OzUI\\media\\textures\\OzUI_Install.tga", --If you have a logo you want to use, otherwise it uses the one from ElvUI
	Pages = {
		[1] = function()
			PluginInstallFrame.SubTitle:SetFormattedText("Welcome to the installation for %s.", MyPluginName)
			PluginInstallFrame.Desc1:SetText("This installation process will guide you through a few steps and apply settings to your current ElvUI profile. If you want to be able to go back to your original settings then create a new profile before going through this installation process.")
			PluginInstallFrame.Desc2:SetText("Please press the continue button if you wish to go through the installation process, otherwise click the 'Skip Process' button.")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", InstallComplete)
			PluginInstallFrame.Option1:SetText("Skip Process")
		end,
		[2] = function()
			PluginInstallFrame.SubTitle:SetText("Layouts")
			PluginInstallFrame.Desc1:SetText("These are the layouts that are available. Please click a button below to apply the layout of your choosing.")
			PluginInstallFrame.Desc2:SetText("Importance: |cff07D400High|r")
			PluginInstallFrame.Desc3:SetText("|cffc41e3aDPS/Tank Layout v1|r has more higher unitframes/actionbars & |cffc41e3aDPS/Tank Layout v2|r has lowered unitframes/actionbars similar to the healing layout.")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() SetupLayout("dps") end)
			PluginInstallFrame.Option1:SetText("|cffc41e3aDPS Layout v1|r")
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript("OnClick", function() SetupLayout("dpsv2") end)
			PluginInstallFrame.Option2:SetText("|cffc41e3aDPS Layout v2|r")
			PluginInstallFrame.Option3:Show()
			PluginInstallFrame.Option3:SetScript("OnClick", function() SetupLayout("healer") end)
			PluginInstallFrame.Option3:SetText("|cff00ff96Healer|r")
		end,
		[3] = function()
			PluginInstallFrame.SubTitle:SetText("Installation Complete")
			PluginInstallFrame.Desc1:SetText("You have completed the installation process.")
			PluginInstallFrame.Desc2:SetText("Please click the button below in order to finalize the process and automatically reload your UI.")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", InstallComplete)
			PluginInstallFrame.Option1:SetText("Finished")
		end,
	},
	StepTitles = {
		[1] = "Welcome",
		[2] = "Layouts",
		[3] = "Installation Complete",
	},
	StepTitlesColor = {1, 1, 1},
	StepTitlesColorSelected = {196/255, 31/255, 59/255},
	StepTitleWidth = 200,
	StepTitleButtonWidth = 180,
	StepTitleTextJustification = "CENTER",
}

--This function holds the options table which will be inserted into the ElvUI config
local function InsertOptions()
	E.Options.args.MyPluginName = {
		order = 100,
		type = "group",
		name = format("|cff4beb2c%s|r", MyPluginName),
		args = {
			header1 = {
				order = 1,
				type = "header",
				name = MyPluginName,
			},
			description1 = {
				order = 2,
				type = "description",
				name = format("%s is a minimalistic layout for ElvUI.", MyPluginName),
			},
			spacer1 = {
				order = 3,
				type = "description",
				name = "\n\n\n",
			},
			header2 = {
				order = 4,
				type = "header",
				name = "Installation",
			},
			description2 = {
				order = 5,
				type = "description",
				name = "The installation guide should pop up automatically after you have completed the ElvUI installation. If you wish to re-run the installation process for this layout then please click the button below.",
			},
			spacer2 = {
				order = 6,
				type = "description",
				name = "",
			},
			install = {
				order = 7,
				type = "execute",
				name = "Install",
				desc = "Run the installation process.",
				func = function() E:GetModule("PluginInstaller"):Queue(InstallerData); E:ToggleConfig(); end,
			},
			description3 = {
				order = 8,
				type = "description",
				name = "Credits: Blazeflack, Benik",
			},
		},
	}
end

--Create a unique table for our plugin
P[MyPluginName] = {}

--This function will handle initialization of the addon
function mod:Initialize()
	--Initiate installation process if ElvUI install is complete and our plugin install has not yet been run
	if E.private.install_complete and E.db[MyPluginName].install_version == nil then
		E:GetModule("PluginInstaller"):Queue(InstallerData)
	end
	
	--Insert our options table when ElvUI config is loaded
	EP:RegisterPlugin(addon, InsertOptions)
end

--This function will get called by ElvUI automatically when it is ready to initialize modules
local function CallbackInitialize()
	mod:Initialize()
end

--Register module with callback so it gets initialized when ready
E:RegisterModule(MyPluginName, CallbackInitialize)