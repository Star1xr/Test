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
	CurrentValue = 30,
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






-- fly (its here to keep the noclip and walkspeed safe🥀)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

-- Mobile joystick input vector
local joystickInput = Vector3.new(0, 0, 0)
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled

-- Update references on character respawn
player.CharacterAdded:Connect(function(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
	hrp = char:WaitForChild("HumanoidRootPart")
	camera = workspace.CurrentCamera
	wait(1)
	setNoclip(getgenv().noclipEnabled)
end)

-- Function to toggle noclip on/off
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

-- Track keyboard input for direction (PC)
local direction = Vector3.new(0, 0, 0)

UIS.InputBegan:Connect(function(input, gpe)
	if gpe or isMobile then return end
	if input.KeyCode == Enum.KeyCode.W then direction += Vector3.new(0, 0, -1) end
	if input.KeyCode == Enum.KeyCode.S then direction += Vector3.new(0, 0, 1) end
	if input.KeyCode == Enum.KeyCode.A then direction += Vector3.new(-1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.D then direction += Vector3.new(1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.Space then direction += Vector3.new(0, 1, 0) end
	if input.KeyCode == Enum.KeyCode.LeftControl then direction += Vector3.new(0, -1, 0) end
end)

UIS.InputEnded:Connect(function(input, gpe)
	if gpe or isMobile then return end
	if input.KeyCode == Enum.KeyCode.W then direction -= Vector3.new(0, 0, -1) end
	if input.KeyCode == Enum.KeyCode.S then direction -= Vector3.new(0, 0, 1) end
	if input.KeyCode == Enum.KeyCode.A then direction -= Vector3.new(-1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.D then direction -= Vector3.new(1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.Space then direction -= Vector3.new(0, 1, 0) end
	if input.KeyCode == Enum.KeyCode.LeftControl then direction -= Vector3.new(0, -1, 0) end
end)

-- Update joystick input for mobile (placeholder)
local function updateJoystickInput()
	-- TODO: Replace with your joystick values from Rayfield UI
	joystickInput = Vector3.new(0, 0, 0) -- im bored bro nahh
end

getgenv().noclipEnabled = false
getgenv().flyEnabled = false

-- Toggle for noclip
local ToggleNoclip = TabMisc:CreateToggle({
	Name = "Noclip",
	CurrentValue = false,
	Flag = "NoclipToggle",
	Callback = function(Value)
		getgenv().noclipEnabled = Value
		setNoclip(Value)
	end,
})

-- Toggle for fly
local ToggleFly = TabMisc:CreateToggle({
	Name = "Fly",
	CurrentValue = false,
	Flag = "FlyToggle",
	Callback = function(Value)
		getgenv().flyEnabled = Value
		-- Automatically enable noclip while flying
		if Value then
			getgenv().noclipEnabled = true
			setNoclip(true)
		else
			getgenv().noclipEnabled = false
			setNoclip(false)
		end
	end,
})

-- Fly update loop, runs every frame
RunService.RenderStepped:Connect(function()
	if getgenv().flyEnabled and humanoid and hrp then
		if isMobile then
			updateJoystickInput()
		else
			joystickInput = Vector3.new(0, 0, 0)
		end

		local inputDirection = direction + joystickInput

		if inputDirection.Magnitude > 0 then
			humanoid:ChangeState(Enum.HumanoidStateType.Physics)
			local camCF = camera.CFrame
			local moveVec = camCF:VectorToWorldSpace(inputDirection.Unit)
			hrp.Velocity = moveVec * 50
			humanoid.PlatformStand = true
		else
			if humanoid:GetState() == Enum.HumanoidStateType.Physics then
				humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
				humanoid.PlatformStand = false
				hrp.Velocity = Vector3.new(0, 0, 0)
			end
		end
	else
		if humanoid:GetState() == Enum.HumanoidStateType.Physics then
			humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			humanoid.PlatformStand = false
		end
	end
end)
