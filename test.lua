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












-- fly (its here to keep the noclip and walkspeed safe
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local character, humanoid, hrp, bv
local dir = Vector3.zero
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled

getgenv().flyEnabled = false

local function updateRefs()
	character = player.Character
	if not character then return end
	humanoid = character:FindFirstChildOfClass("Humanoid")
	hrp = character:FindFirstChild("HumanoidRootPart")
end

local function cleanUpCharacter()
	if humanoid then
		humanoid.AutoRotate = false
	end
	if hrp then
		hrp.RotVelocity = Vector3.zero
	end
end

player.CharacterAdded:Connect(function()
	wait(0.5)
	updateRefs()
	cleanUpCharacter()
end)

UIS.InputBegan:Connect(function(input, g)
	if g or isMobile then return end
	if input.KeyCode == Enum.KeyCode.W then dir += Vector3.new(0, 0, -1) end
	if input.KeyCode == Enum.KeyCode.S then dir += Vector3.new(0, 0, 1) end
	if input.KeyCode == Enum.KeyCode.A then dir += Vector3.new(-1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.D then dir += Vector3.new(1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.Space then dir += Vector3.new(0, 1, 0) end
	if input.KeyCode == Enum.KeyCode.LeftControl then dir += Vector3.new(0, -1, 0) end
end)

UIS.InputEnded:Connect(function(input, g)
	if g or isMobile then return end
	if input.KeyCode == Enum.KeyCode.W then dir -= Vector3.new(0, 0, -1) end
	if input.KeyCode == Enum.KeyCode.S then dir -= Vector3.new(0, 0, 1) end
	if input.KeyCode == Enum.KeyCode.A then dir -= Vector3.new(-1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.D then dir -= Vector3.new(1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.Space then dir -= Vector3.new(0, 1, 0) end
	if input.KeyCode == Enum.KeyCode.LeftControl then dir -= Vector3.new(0, -1, 0) end
end)

-- 🔘 Fly Toggle
TabMisc:CreateToggle({
	Name = "Fly",
	CurrentValue = false,
	Flag = "FlyToggle",
	Callback = function(v)
		getgenv().flyEnabled = v
		if not character or not humanoid then updateRefs() end

		if v then
			cleanUpCharacter()

			camera.CameraSubject = humanoid
			camera.CameraType = Enum.CameraType.Track

			-- 🌀 BodyVelocity ekle
			if hrp and not bv then
				bv = Instance.new("BodyVelocity")
				bv.Name = "FlyForce"
				bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
				bv.P = 12500
				bv.Velocity = Vector3.zero
				bv.Parent = hrp
			end
		else
			if bv then
				bv:Destroy()
				bv = nil
			end
			if hrp then
				hrp.Velocity = Vector3.zero
				hrp.RotVelocity = Vector3.zero
			end
			humanoid.AutoRotate = true
			camera.CameraType = Enum.CameraType.Custom
			dir = Vector3.zero
		end
	end,
})

-- 🚀 Uçuş Motoru
RunService.RenderStepped:Connect(function()
	if not getgenv().flyEnabled then return end
	if not character or not humanoid or not hrp then updateRefs() return end

	local inputVec = isMobile and humanoid.MoveDirection or dir

	if inputVec.Magnitude > 0 then
		local unitVec = inputVec.Unit
		local moveVec = isMobile and unitVec or camera.CFrame:VectorToWorldSpace(unitVec)

		if bv then
			bv.Velocity = moveVec * 60
		end
	else
		if bv then
			bv.Velocity = Vector3.zero
		end
	end
end)
