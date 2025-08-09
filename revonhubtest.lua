local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()

local Players = game:GetService("Players")
local ESP

local Window = Luna:CreateWindow({
	Name = "RevonHub Test",
	Subtitle = "RevonHub Tester Script",
	LogoID = "82795327169782",
	LoadingEnabled = true,
	LoadingTitle = "Luna Interface Suite",
	LoadingSubtitle = "Test",
	KeySystem = false,
	KeySettings = {
		Title = "Luna Example Key",
		Subtitle = "Key System",
		Note = "Best Key System Ever Also Please Use A HWID Keysystem like Pelican Luarmor etc that provide key strings based on your HWID since putting a simple string is very easy to bypass the key is 1234",
		SaveInRoot = false,
		SaveKey = true,
		Key = {"1234"},
		SecondAction = {
			Enabled = true,
			Type = "Link",
			Parameter = ""
		}
	}
})

Window:CreateHomeTab({
	SupportedExecutors = {
		"Synapse X",
		"Krnl",
		"ProtoSmasher",
		"Fluxus",
		"Script-Ware",
		"EasyExploits",
		"Electron",
		"JJSploit",
		"Calamari",
		"SirHurt",
		"Sentinel",
		"WEAREDEVS",
		"Comet",
		"Cellery",
		"Wave",
		"CODex",
		"Delta"
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

-- toggle to enable or disable the esp
local ESPToggle = Tab:CreateToggle({
	Name = "ESP Toggle",
	Description = "Toggle ESP on or off",
	CurrentValue = false,
	Callback = function(state)
		if state then
			ESP = loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-ESP-Library-9570", true))("there are cats in your walls let them out let them out let them out")

			for i, Player in next, Players:GetPlayers() do
				ESP.Object:New(ESP:GetCharacter(Player))
				ESP:CharacterAdded(Player):Connect(function(Character)
					ESP.Object:New(Character)
				end)
			end

			Players.PlayerAdded:Connect(function(Player)
				ESP.Object:New(ESP:GetCharacter(Player))
				ESP:CharacterAdded(Player):Connect(function(Character)
					ESP.Object:New(Character)
				end)
			end)

			-- notification shows when esp is enabled
			Luna:Notification({
				Title = "ESP Activated",
				Icon = "visibility",
				ImageSource = "Material",
				Content = "ESP is now active enjoy"
			})
		else
			if ESP then
				ESP:Destroy()
				ESP = nil
			end
		end
	end
}, "Toggle")

-- create other UI elements like button slider or input here if needed

local Button = Tab:CreateButton({
	Name = "Button Example",
	Callback = function()
		print("Button pressed")
	end
})
