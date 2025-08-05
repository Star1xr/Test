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
-- Rayfield uyumlu karakter uçuş sistemi
-- Kamera yönüne göre tam 3D uçuş, mobil ve PC uyumlu
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

-- Uçuş nesneleri
local bodyVelocity = nil
local bodyGyro = nil
local bodyForce = nil
local originalAutoRotate = humanoid.AutoRotate

-- Uçuş hızı (istendiği şekilde ayarlanabilir)
local FLY_SPEED = 50

-- Kamera referansı
local camera = workspace.CurrentCamera

-- Uçuş etkin/kapalı takibi
local flying = false

-- Mobil veya joystick hareketi için tutulan değerler (isteğe bağlı)
local gamepadAxis = Vector2.new(0, 0)
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Gamepad1 then
        if input.KeyCode == Enum.KeyCode.Thumbstick1 then
            gamepadAxis = Vector2.new(input.Position.X, input.Position.Y)
        end
    end
end)

-- Uçuş döngüsü
RunService.RenderStepped:Connect(function(dt)
    -- Uçuş modu etkin değilse gerekli temizleme ve çıkış
    if not getgenv().flyEnabled then
        if flying then
            -- Uçuş kapatılırken nesneleri kaldır, animasyonları ve rotasyonu geri yükle
            if bodyVelocity then bodyVelocity:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
            if bodyForce then bodyForce:Destroy() end
            bodyVelocity = nil
            bodyGyro = nil
            bodyForce = nil

            humanoid.PlatformStand = false
            humanoid.AutoRotate = originalAutoRotate
        end
        flying = false
        return
    end

    -- Uçuş modu etkinleştiriliyorsa (ilk seferinde nesneleri oluştur)
    if not flying then
        -- Kamera karakteri takip edecek şekilde ayarla
        camera.CameraSubject = humanoid
        camera.CameraType = Enum.CameraType.Custom

        -- Yerçekimini dengelemek için BodyForce ekle
        bodyForce = Instance.new("BodyForce")
        bodyForce.Force = Vector3.new(0, workspace.Gravity * hrp:GetMass(), 0)
        bodyForce.Parent = hrp

        -- Hareket kontrolü için BodyVelocity (yön vektörleri bu nesneyle uygulanacak)
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = hrp

        -- Karakterin rotasyonunu kamera yönüne göre kilitlemek için BodyGyro
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.D = 1250
        bodyGyro.P = 3000
        bodyGyro.CFrame = hrp.CFrame
        bodyGyro.Parent = hrp

        -- Animasyonları korumak için PlatformStand kapat ve AutoRotate devre dışı bırak
        humanoid.PlatformStand = false
        originalAutoRotate = humanoid.AutoRotate
        humanoid.AutoRotate = false

        flying = true
    end

    -- Hareket girişini oku (kameraya göre yön tayini)
    local forward = 0
    local right = 0
    if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) then
        forward = forward + 1
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) then
        forward = forward - 1
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left) then
        right = right - 1
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right) then
        right = right + 1
    end
    -- Gamepad sol joystick: X = sağ-sol, Y = ileri-geri
    forward = forward + gamepadAxis.Y
    right = right + gamepadAxis.X

    local camCFrame = camera.CFrame
    local moveVector = Vector3.new(0, 0, 0)
    if forward ~= 0 or right ~= 0 then
        local lookVec = camCFrame.LookVector
        local rightVec = camCFrame.RightVector
        -- Yön vektörü
        moveVector = (lookVec * forward + rightVec * right).Unit * FLY_SPEED
    end

    -- Yatay rotasyonu karakterle hizala (BodyGyro)
    local horizontalLook = Vector3.new(camCFrame.LookVector.X, 0, camCFrame.LookVector.Z)
    if horizontalLook.Magnitude > 0 then
        bodyGyro.CFrame = CFrame.new(hrp.Position, hrp.Position + horizontalLook)
    end

    -- Uçuş hızı ataması (BodyVelocity ile)
    bodyVelocity.Velocity = Vector3.new(moveVector.X, moveVector.Y, moveVector.Z)
end)
