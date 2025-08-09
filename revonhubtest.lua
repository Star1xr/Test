local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()

local Window = Luna:CreateWindow({
	Name = "RevonHub Test",
	Subtitle = "RevonHub Tester Script",
	LogoID = "82795327169782",
	LoadingEnabled = true,
	LoadingTitle = "Luna Interface Suite",
	LoadingSubtitle = "Test",
	KeySystem = false,
	KeySettings = {}
})

Window:CreateHomeTab({
	SupportedExecutors = {
		"Synapse X", "Krnl", "ProtoSmasher", "Fluxus", "Script-Ware", "EasyExploits", 
		"Electron", "JJSploit", "Calamari", "SirHurt", "Sentinel", "WEAREDEVS", 
		"Comet", "Cellery", "Wave", "CODex", "Delta"
	},
	DiscordInvite = "1234",
	Icon = 1
})

local Tab = Window:CreateTab({
	Name = "Tab Example",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
})

local Button = Tab:CreateButton({
	Name = "Button Example",
	Callback = function()
		print("Button pressed")
	end
})
