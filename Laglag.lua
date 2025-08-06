-- im bored so heres a script (fake lag)


local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "LagLagLagLag",
	LoadingTitle = "Fake Lag by revon",
	LoadingSubtitle = "by revon",
	ConfigurationSaving = {
		Enabled = false,
	},
	Discord = {
		Enabled = false,
	},
	KeySystem = false,
})

local MainTab = Window:CreateTab("Main", 4483362458)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local delaySeconds = 4
local moveSpeed = 0.02
local lagEnabled = false

MainTab:CreateToggle({
	Name = "Extreme Fake Lag",
	CurrentValue = false,
	Flag = "FakeLag",
	Callback = function(Value)
		lagEnabled = Value
		local character = player.Character or player.CharacterAdded:Wait()
		character:WaitForChild("HumanoidRootPart")
		character:WaitForChild("Humanoid")
		local hrp = character.HumanoidRootPart
		local humanoid = character.Humanoid
		if Value then
			local dummy = character:Clone()
			dummy.Name = "LagDummy"
			for _, v in pairs(dummy:GetDescendants()) do
				if v:IsA("BasePart") then
					v.Anchored = true
				elseif v:IsA("Script") or v:IsA("LocalScript") then
					v:Destroy()
				end
			end
			dummy.Parent = workspace
			for _, v in pairs(character:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("Decal") then
					v.Transparency = 1
				elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
					v.Enabled = false
				end
			end
			local posHistory = {}
			local teleportLoop, moveLoop
			moveLoop = RunService.RenderStepped:Connect(function()
				table.insert(posHistory, hrp.Position)
				if #posHistory > delaySeconds * 60 then
					table.remove(posHistory, 1)
				end
				local direction = hrp.CFrame.LookVector
				dummy:FindFirstChild("HumanoidRootPart").CFrame = dummy:FindFirstChild("HumanoidRootPart").CFrame + (direction * moveSpeed)
				local dummyHumanoid = dummy:FindFirstChildWhichIsA("Humanoid")
				if dummyHumanoid then
					dummyHumanoid.WalkSpeed = 16
					dummyHumanoid.HipHeight = humanoid.HipHeight
					dummyHumanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
					dummyHumanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
				end
			end)
			coroutine.wrap(function()
				while lagEnabled do
					task.wait(delaySeconds)
					if #posHistory > 0 then
						hrp.CFrame = CFrame.new(posHistory[#posHistory])
						posHistory = {}
					end
				end
			end)()
			spawn(function()
				while lagEnabled do task.wait() end
				if moveLoop then moveLoop:Disconnect() end
				if dummy then dummy:Destroy() end
				for _, v in pairs(character:GetDescendants()) do
					if v:IsA("BasePart") or v:IsA("Decal") then
						v.Transparency = 0
					elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
						v.Enabled = true
					end
				end
			end)
		end
	end,
})
