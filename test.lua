local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Ink Game",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "RevonScripts - Ink Game",
   LoadingSubtitle = "by revon",
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

local ToggleFly = TabMisc:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        getgenv().flyEnabled = Value
    end,
})











-- tried to bypass anticheat shit for hours

-- fly and noclip??? yes rico kaboom🗣️

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

player.CharacterAdded:Connect(function(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
	hrp = char:WaitForChild("HumanoidRootPart")
	wait(1)
	setNoclip(getgenv().noclipEnabled)
	setWalkSpeed(desiredSpeed)
end)

-- Noclip function
local function setNoclip(state)
	if not character then return end
	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = not state
		end
	end
	if humanoid then
		humanoid.PlatformStand = false
		humanoid.JumpPower = 50
	end
end

-- WalkSpeed function
local desiredSpeed = 50
local function setWalkSpeed(speed)
	if not character then return end
	local hum = character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = speed
	end
end

getgenv().noclipEnabled = false

-- Toggles
local ToggleNoclip = TabMisc:CreateToggle({
	Name = "Noclip",
	CurrentValue = false,
	Flag = "NoclipToggle",
	Callback = function(Value)
		getgenv().noclipEnabled = Value
		setNoclip(Value)
	end,
})

-- Slider for walkspeed
local SliderWalkspeed = TabMisc:CreateSlider({
	Name = "WalkSpeed",
	Range = {16, 150},
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = 22, -- is default i guess (i will check later)
	Flag = "WalkSpeedSlider",
	Callback = function(Value)
		desiredSpeed = Value
		setWalkSpeed(desiredSpeed)
	end,
})

-- Update every frame
RunService.RenderStepped:Connect(function()
	setWalkSpeed(desiredSpeed)
	if getgenv().noclipEnabled then
		setNoclip(true)
	end
end)












-- fly (its here to keep the noclip and walkspeed safe🥀
--[[
Advanced Fly System for Roblox (Mobile-First, Camera-Based, Animation-Safe)
By revon, works on almost all games including ink game. Nun anticheat can detect this.
Toggle with getgenv().flyEnabled (e.g. via Rayfield UI toggle).
--]]
-- Camera-based movement
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local camera = workspace.CurrentCamera
local control = require(player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))

getgenv().flyEnabled = false

local bv, bf
local SPEED = 60

local function startFly()
	if bv then return end
	bv = Instance.new("BodyVelocity", hrp)
	bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	bv.P = 1250

	bf = Instance.new("BodyForce", hrp)
	bf.Force = Vector3.new(0, workspace.Gravity * hrp:GetMass(), 0)
end

local function stopFly()
	if bv then bv:Destroy() bv = nil end
	if bf then bf:Destroy() bf = nil end
end

RunService.Heartbeat:Connect(function()
	if getgenv().flyEnabled then
		startFly()

		local move = control:GetMoveVector()
		local camDir = camera.CFrame.LookVector
		local horizontal = Vector3.new(camDir.X, 0, camDir.Z).Unit
		local direction = (horizontal * move.Z) + (camera.CFrame.RightVector * move.X)
		local vertical = Vector3.new(0, camDir.Y * move.Z, 0)

		if direction.Magnitude > 0 then
			bv.Velocity = (direction + vertical).Unit * SPEED
		else
			bv.Velocity = Vector3.zero
		end
	else
		stopFly()
	end
end)
