local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Test",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by Sirius",
   ShowText = "Rayfield", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Nil"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local TabRLGL = Window:CreateTab("Greenlight", 4483362458) -- Title, Image
local TabMisc = Window:CreateTab("Misc", 4483362458) -- Title, Image

local Button = TabRLGL:CreateButton({
   Name = "Teleport RLGL",
   Callback = function()
      Rayfield:Notify({
         Title = "Teleported to the end",
         Content = "Teleported...",
         Duration = 6.5,
         Image = 4483362458,
      })
      game.Players.LocalPlayer.Character:MoveTo(Vector3.new(114, 1023, 129))
   end,
})

local Toggle = TabMisc:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
      getgenv().noclipEnabled = Value
   end,
})

local Toggle2 = TabMisc:CreateToggle({
   Name = "Fly",
   CurrentValue = false,
   Flag = "Toggle2",
   Callback = function(Value)
      getgenv().flyEnabled = Value
   end,
})

local Slider = TabGame:CreateSlider({
   Name = "Fly Speed",
   Range = {10, 150},
   Increment = 5,
   Suffix = "Speed",
   CurrentValue = 30,
   Flag = "FlySpeed",
   Callback = function(Value)
      getgenv().flySpeed = Value
   end,
})













-- Noclip motor
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

getgenv().noclipEnabled = false

RunService.Stepped:Connect(function()
	if getgenv().noclipEnabled and humanoidRootPart then
		for _, v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide == true then
				v.CanCollide = false
			end
		end
	end
end)


-- Fly motor(anticheat bypass last update)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local direction = Vector3.zero

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.W then direction += Vector3.new(0, 0, -1) end
	if input.KeyCode == Enum.KeyCode.S then direction += Vector3.new(0, 0, 1) end
	if input.KeyCode == Enum.KeyCode.A then direction += Vector3.new(-1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.D then direction += Vector3.new(1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.Space then direction += Vector3.new(0, 1, 0) end
	if input.KeyCode == Enum.KeyCode.LeftControl then direction += Vector3.new(0, -1, 0) end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.W then direction -= Vector3.new(0, 0, -1) end
	if input.KeyCode == Enum.KeyCode.S then direction -= Vector3.new(0, 0, 1) end
	if input.KeyCode == Enum.KeyCode.A then direction -= Vector3.new(-1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.D then direction -= Vector3.new(1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.Space then direction -= Vector3.new(0, 1, 0) end
	if input.KeyCode == Enum.KeyCode.LeftControl then direction -= Vector3.new(0, -1, 0) end
end)

RunService.RenderStepped:Connect(function()
	if getgenv().flyEnabled then
		humanoid.PlatformStand = true
		if direction.Magnitude > 0 then
			local camCF = workspace.CurrentCamera.CFrame
			local moveDir = camCF:VectorToWorldSpace(direction.Unit)
			humanoidRootPart.Velocity = moveDir * getgenv().flySpeed
		else
			humanoidRootPart.Velocity = Vector3.zero
		end
	else
		humanoid.PlatformStand = false
	end
end)
