-- Rayfield GUI setup
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local espObjects = {}
local noclipEnabled = false

-- Window
local Window = Rayfield:CreateWindow({
    Name = "RevonHub",
    LoadingTitle = "RevonHub",
    LoadingSubtitle = "By You",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "RevonHub",
        FileName = "Config"
    },
    Discord = {
        Enabled = false
    }
})

-- Tab
local MiscTab = Window:CreateTab("Misc")

-- ESP toggle
MiscTab:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Flag = "ESP_Toggle",
    Callback = function(state)
        if state then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "RevonHubESP"
                    highlight.Adornee = player.Character
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = player.Character
                    espObjects[player] = highlight
                end
            end
            Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function(char)
                    if Rayfield.Flags["ESP_Toggle"] then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "RevonHubESP"
                        highlight.Adornee = char
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.Parent = char
                        espObjects[player] = highlight
                    end
                end)
            end)
        else
            for player, highlight in pairs(espObjects) do
                if highlight and highlight.Parent then
                    highlight:Destroy()
                end
                espObjects[player] = nil
            end
        end
    end
})

-- NoClip toggle
MiscTab:CreateToggle({
    Name = "NoClip (Press N to toggle)",
    CurrentValue = false,
    Flag = "NoClip_Toggle",
    Callback = function(state)
        noclipEnabled = state
    end
})

-- NoClip toggle keybind handler
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.N then
        noclipEnabled = not noclipEnabled
        Rayfield:Notify({
            Title = "NoClip",
            Content = noclipEnabled and "Enabled" or "Disabled",
            Duration = 3,
            Image = 4483362458
        })
        Rayfield.Flags["NoClip_Toggle"] = noclipEnabled
    end
end)

RunService.Stepped:Connect(function()
    if noclipEnabled then
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    else
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)
