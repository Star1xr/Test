-- im bored so heres a script (fake lag)
-- Egor?
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

-- Flags
local LAGGING = false
local ZERO_GRAVITY = false
local frozen = false

-- UI Setup
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Roblox_Egor v2",
    LoadingTitle = "laglaglaglag",
    ConfigurationSaving = {
        Enabled = false
    }
})
local MainTab = Window:CreateTab("Lag Settings", 4483362458)

MainTab:CreateToggle({
    Name = "Enable Egor Lag",
    CurrentValue = false,
    Callback = function(state)
        LAGGING = state
    end
})

MainTab:CreateToggle({
    Name = "Enable Zero Gravity",
    CurrentValue = false,
    Callback = function(state)
        ZERO_GRAVITY = state
        Workspace.Gravity = state and 0 or 196.2
    end
})

-- Lag + Gravity Logic
RunService.RenderStepped:Connect(function()
    if LAGGING then
        humanoid.WalkSpeed = 1
        humanoid.JumpPower = 0

        -- Donma efekti
        if not frozen and math.random(1, 50) == 1 then
            frozen = true
            local old = hrp.Anchored
            hrp.Anchored = true
            wait(0.7)
            hrp.Anchored = old
            frozen = false
        end
    else
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end
end)

-- Lag teleportu
task.spawn(function()
    while true do
        task.wait(4)
        if LAGGING and not frozen and hrp then
            local offset = Vector3.new(math.random(-10, 10), math.random(-3, 3), math.random(10, 20))
            hrp.CFrame = hrp.CFrame + offset
        end
    end
end)
