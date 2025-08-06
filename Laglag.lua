-- im bored so heres a script (fake lag)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "Lag Menu",
	LoadingTitle = "I touch you",
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
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local delaySeconds = 4
local moveSpeed = 0.02
local lagEnabled = false
local moveLoop
local teleportLoop
local dummy

local function makeInvisible(char)
	for _, v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") or v:IsA("Decal") then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Enabled = false
		end
	end
end

local function makeVisible(char)
	for _, v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") or v:IsA("Decal") then
			v.Transparency = 0
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Enabled = true
		end
	end
end

local function startLag()
	local character = player.Character or player.CharacterAdded:Wait()
	local hrp = character:WaitForChild("HumanoidRootPart")
	local humanoid = character:WaitForChild("Humanoid")

	dummy = character:Clone()
	dummy.Name = "LagDummy"
	for _, v in pairs(dummy:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Anchored = true
		elseif v:IsA("Script") or v:IsA("LocalScript") then
			v:Destroy()
		end
	end
	dummy.Parent = workspace

	makeInvisible(character)

	local posHistory = {}

	moveLoop = RunService.RenderStepped:Connect(function()
		if not lagEnabled then return end
		if hrp and dummy:FindFirstChild("HumanoidRootPart") then
			table.insert(posHistory, hrp.Position)
			if #posHistory > delaySeconds * 60 then
				table.remove(posHistory, 1)
			end
			local dir = hrp.CFrame.LookVector
			dummy:FindFirstChild("HumanoidRootPart").CFrame = dummy:FindFirstChild("HumanoidRootPart").CFrame + (dir * moveSpeed)
		end
	end)

	teleportLoop = coroutine.create(function()
		while lagEnabled do
			task.wait(delaySeconds)
			if #posHistory > 0 then
				hrp.CFrame = CFrame.new(posHistory[#posHistory])
				posHistory = {}
			end
		end
	end)
	coroutine.resume(teleportLoop)
end

local function stopLag()
	lagEnabled = false
	if moveLoop then moveLoop:Disconnect() end
	if dummy then dummy:Destroy() end
	local character = player.Character
	if character then
		makeVisible(character)
	end
end

MainTab:CreateToggle({
	Name = "Extreme Fake Lag",
	CurrentValue = false,
	Flag = "FakeLag",
	Callback = function(Value)
		lagEnabled = Value
		if Value then
			startLag()
		else
			stopLag()
		end
	end,
})
