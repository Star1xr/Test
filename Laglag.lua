-- im bored so heres a script (fake lag)
-- Egor?
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "laglag",
    LoadingTitle = "i lag bro",
    ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Lag Controls", 4483362458)

local LAG_MODE = false

MainTab:CreateToggle({
    Name = "egor lag",
    CurrentValue = false,
    Callback = function(Value)
        LAG_MODE = Value
        if not Value then
            humanoid.WalkSpeed = 16
            hrp.Velocity = Vector3.zero
        else
            humanoid.WalkSpeed = 50
        end
    end
})

RunService.RenderStepped:Connect(function()
    if LAG_MODE then
        if humanoid.MoveDirection.Magnitude > 0 then
            hrp.Velocity = humanoid.MoveDirection.Unit * 2
        else
            hrp.Velocity = Vector3.zero
        end
    else
        hrp.Velocity = Vector3.zero
    end
end)

task.spawn(function()
    while true do
        task.wait(4)
        if LAG_MODE and hrp then
            local offset = Vector3.new(math.random(-6, 6), 0, math.random(6, 14))
            hrp.CFrame = hrp.CFrame + offset
        end
    end
end)
