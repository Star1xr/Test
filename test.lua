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

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Player and character references
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

-- Control module for movement (handles mobile joystick, keyboard, gamepad)
local controlModule = require(player:WaitForChild("PlayerScripts")
    :WaitForChild("PlayerModule"):WaitForChild("ControlModule"))

-- Ensure global toggle exists
if getgenv().flyEnabled == nil then
    getgenv().flyEnabled = false
end

-- Flight settings
local flightSpeed = 50  -- flight speed (studs per second)

-- State variables
local isFlying = false
local bodyVelocity, bodyGyro, bodyForce
local baseForce = Vector3.new(0, 0, 0)

-- Function to enable flight: create Body movers and lock camera
local function enableFlight()
    -- Lock camera to HumanoidRootPart (attach mode)
    camera.CameraType = Enum.CameraType.Attach
    camera.CameraSubject = hrp

    -- Calculate upward force to counteract gravity (hover force)
    local mass = hrp:GetMass()
    baseForce = Vector3.new(0, workspace.Gravity * mass, 0)

    -- Create BodyVelocity for flight movement
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = hrp

    -- Create BodyGyro to orient character to camera direction (yaw only)
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(0, math.huge, 0)  -- only allow yaw rotation
    bodyGyro.P = 3000  -- power of orientation correction
    bodyGyro.D = 300
    bodyGyro.Parent = hrp

    -- Create BodyForce to neutralize gravity
    bodyForce = Instance.new("BodyForce")
    bodyForce.Force = baseForce
    bodyForce.Parent = hrp

    isFlying = true
end

-- Function to disable flight: restore camera and remove Body movers
local function disableFlight()
    -- Restore default camera control
    camera.CameraType = Enum.CameraType.Custom
    camera.CameraSubject = humanoid

    -- Remove Body movers
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end
    if bodyForce then
        bodyForce:Destroy()
        bodyForce = nil
    end

    isFlying = false
end

-- Update loop: handle flight each frame
RunService.Heartbeat:Connect(function()
    if getgenv().flyEnabled then
        if not isFlying then
            enableFlight()
        end

        -- Get movement vector (joystick or keyboard relative to camera)
        local moveVec = controlModule:GetMoveVector()
        if moveVec.Magnitude > 0 then
            -- Convert to world direction relative to camera orientation
            local camCFrame = camera.CFrame
            local forward = camCFrame.LookVector
            local right = camCFrame.RightVector
            local direction = (forward * moveVec.Z) + (right * moveVec.X)

            -- Apply movement velocity
            bodyVelocity.Velocity = direction.Unit * flightSpeed

            -- Orient character to face camera's horizontal direction
            local horizontalLook = Vector3.new(forward.X, 0, forward.Z)
            if horizontalLook.Magnitude > 0 then
                bodyGyro.CFrame = CFrame.new(hrp.Position, hrp.Position + horizontalLook)
            end

            -- Vertical flight control: ascend/descend based on camera tilt
            if forward.Y < 0 and moveVec.Z > 0 then
                -- Looking down and pushing forward: descend
                bodyForce.Force = Vector3.new(0, 0, 0)
            else
                -- Hover (neutralize gravity)
                bodyForce.Force = baseForce
            end
        else
            -- No movement input: hover in place
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyForce.Force = baseForce
        end
    else
        if isFlying then
            disableFlight()
        end
    end
end)
