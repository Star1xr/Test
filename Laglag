

-- [Rayfield Window and tab settings]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "Lag Menu",
	LoadingTitle = "Egor Lag System",
	LoadingSubtitle = "by ChatGPT",
	ConfigurationSaving = {
		Enabled = false,
	},
	Discord = {
		Enabled = false,
	},
	KeySystem = false,
})

local MainTab = Window:CreateTab("Main", 4483362458)

-- needed
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local delaySeconds = 0.5
local lagEnabled = false

-- Toggle + motor
MainTab:CreateToggle({
	Name = "Fake Lag (Egor Style)",
	CurrentValue = false,
	Flag = "FakeLagToggle",
	Callback = function(Value)
		lagEnabled = Value

		local function cloneCharacter(original)
			local clone = original:Clone()
			clone.Name = "FakeLagDummy"
			for _, part in ipairs(clone:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Anchored = true
				elseif part:IsA("Script") or part:IsA("LocalScript") then
					part:Destroy()
				end
			end
			clone.Parent = workspace
			return clone
		end

		local function makeInvisible(character)
			for _, v in pairs(character:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("Decal") then
					v.Transparency = 1
				elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
					v.Enabled = false
				end
			end
		end

		local function makeVisible(character)
			for _, v in pairs(character:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("Decal") then
					v.Transparency = 0
				elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
					v.Enabled = true
				end
			end
		end

		local character = player.Character or player.CharacterAdded:Wait()
		character:WaitForChild("HumanoidRootPart")

		if lagEnabled then
			local dummy = cloneCharacter(character)
			makeInvisible(character)

			local lastUpdate = tick()
			local rsConn = nil
			local tpLoop = true

			rsConn = RunService.RenderStepped:Connect(function()
				if tick() - lastUpdate >= delaySeconds then
					lastUpdate = tick()
					local tween = TweenService:Create(dummy:FindFirstChild("HumanoidRootPart"), TweenInfo.new(delaySeconds, Enum.EasingStyle.Linear), {
						CFrame = character.HumanoidRootPart.CFrame
					})
					tween:Play()
				end
			end)

			coroutine.wrap(function()
				while lagEnabled and tpLoop do
					task.wait(delaySeconds)
					if dummy and dummy:FindFirstChild("HumanoidRootPart") then
						character.HumanoidRootPart.CFrame = dummy.HumanoidRootPart.CFrame
					end
				end
			end)()

			-- After toggle delete dummy
			spawn(function()
				while lagEnabled do task.wait() end
				if rsConn then rsConn:Disconnect() end
				if dummy then dummy:Destroy() end
				makeVisible(character)
			end)
		end
	end,
})
