local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()
local Players = game:GetService("Players")
local ESP
local connections = {}

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

local function connectPlayerESP(Player)
	if ESP and Player.Character then
		ESP.Object:New(ESP:GetCharacter(Player))
		if not connections[Player] then
			connections[Player] = Player.CharacterAdded:Connect(function(Character)
				ESP.Object:New(Character)
			end)
		end
	end
end

local function disconnectAllESP()
	if ESP then
		ESP = nil -- Eğer ESP kütüphanesi destroy desteklemiyorsa böyle bırakabilirsin
	end
	for _, conn in pairs(connections) do
		conn:Disconnect()
	end
	connections = {}
end

local ESPToggle = Tab:CreateToggle({
	Name = "ESP Toggle",
	Description = "Toggle ESP on or off",
	CurrentValue = false,
	Callback = function(state)
		if state then
			ESP = loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-ESP-Library-9570", true))("there are cats in your walls let them out let them out let them out")

			for _, Player in pairs(Players:GetPlayers()) do
				connectPlayerESP(Player)
			end

			connections[#connections+1] = Players.PlayerAdded:Connect(function(Player)
				connectPlayerESP(Player)
			end)

			Luna:Notification({
				Title = "ESP Activated",
				Icon = "visibility",
				ImageSource = "Material",
				Content = "ESP is now active enjoy"
			})
		else
			disconnectAllESP()
		end
	end
})

local Button = Tab:CreateButton({
	Name = "Button Example",
	Callback = function()
		print("Button pressed")
	end
})
