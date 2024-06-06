loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-MoreUNC-13110"))()

local VirtualInputManager = Instance.new('VirtualInputManager')

--[[
function Target()
	return game.Players.OatherThegoather.Character
end
]]--

function Target()
	local target = nil
	local distance = math.huge

	for i,v in next, workspace.Entities:GetChildren() do
		if game.Players:FindFirstChild(v.Name) then
			if game.Players.LocalPlayer:GetAttribute("Party") and game.Players[v.Name]:GetAttribute("Party") then
				if v and v.Name~=game.Players.LocalPlayer.Name and v:FindFirstChild("HumanoidRootPart") and math.abs(v:FindFirstChild("HumanoidRootPart").Position.Y - game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Y) <= math.huge and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health>0 and v:GetAttribute("CurrentState") ~= "Unconscious" and game.Players.LocalPlayer:GetAttribute("Party") ~= game.Players[v.Name]:GetAttribute("Party") then
					local plrdist = game.Players.LocalPlayer:DistanceFromCharacter(v:FindFirstChildOfClass('Humanoid').RootPart.CFrame.p)
					if plrdist < distance then
						target = v
						distance = plrdist
					end
				end
			else
				if v and v.Name~=game.Players.LocalPlayer.Name and v:FindFirstChild("HumanoidRootPart") and math.abs(v:FindFirstChild("HumanoidRootPart").Position.Y - game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Y) <= math.huge and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health>0 and v:GetAttribute("CurrentState") ~= "Unconscious" then
					local plrdist = game.Players.LocalPlayer:DistanceFromCharacter(v:FindFirstChildOfClass('Humanoid').RootPart.CFrame.p)
					if plrdist < distance then
						target = v
						distance = plrdist
					end
				end
			end
		else
			if v and v.Name~=game.Players.LocalPlayer.Name and not v.Name:lower():find(("FlashClone"):lower()) and not v.Name:lower():find(("Wolf"):lower()) and v:FindFirstChild("HumanoidRootPart") and math.abs(v:FindFirstChild("HumanoidRootPart").Position.Y - game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Y) <= math.huge and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health>0 and v:GetAttribute("CurrentState") ~= "Unconscious" then
				local plrdist = game.Players.LocalPlayer:DistanceFromCharacter(v:FindFirstChildOfClass('Humanoid').RootPart.CFrame.p)
				if plrdist < distance then
					target = v
					distance = plrdist
				end
			end
		end
	end

	return target
end

local function XZ(V)
	return Vector3.new(V.X, 0, V.Z)
end

local scriptOn = false
local debounce = false

local blockmove = false

local parry = false
local critical = false
local moveset = false
local movesetextended = false


local function checkAnimations(animationIds, humanoid)
	local playingTracks = humanoid:GetPlayingAnimationTracks()

	-- Use a set to store unique animation IDs
	local animationIdSet = {}
	for _, animationId in ipairs(animationIds) do
		animationIdSet[animationId] = true
	end

	for _, track in ipairs(playingTracks) do
		local currentAnimation = track.Animation
		if animationIdSet[currentAnimation.AnimationId] then
			return true
		end
	end

	return false
end


local donttrack = {}
local dodgethis = {}
local notrealmove = {}

local parrylist = {}
local extendtheblock = {}
local skillboxes = {}
local normalcritical = {}

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Strata"):lower()) and child.ClassName == "Animation" then
		table.insert(skillboxes, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Strata"):lower()) and child.ClassName == "Animation" then
		table.insert(donttrack, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Reichweite"):lower())  then
		for  i, v in ipairs(child:GetChildren()) do
			if v.Name:lower():find(("crit"):lower()) then 
				table.insert(normalcritical, v.AnimationId)
			end
		end
	end
end


--[[8
for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Phage"):lower()) and child.ClassName == "Animation" then
		table.insert(donttrack, child.AnimationId)
	end
end
]]--
for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("FastFang"):lower()) and child.ClassName == "Animation" then
		table.insert(donttrack, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("TimeCut"):lower()) and child.ClassName == "Animation" then
		table.insert(donttrack, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("waterfalld"):lower()) and child.ClassName == "Animation" then
		table.insert(notrealmove, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Heavenly"):lower()) and child.ClassName == "Animation" then
		table.insert(skillboxes, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("HollowBite"):lower()) and child.ClassName == "Animation" then
		table.insert(notrealmove, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Zangerin"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Surasshu"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("RagingDemon"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("whirlwind"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Gyakko"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Licht"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("VolcanicTrail"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("GreatEruption"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("MagmaPlumes"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Kuro"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("GranRey"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Confinement"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("ReiatsuPush"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Overclock"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("StillSilver"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Danku"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Bisection"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("FlowerPass"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("ToraReach"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("VerticalDown"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("OverpoweringSlash"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("SplitGate"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("GiftBall"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("FEImpale"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("CeroOsc"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("InvertedRea"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end


for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Fireflies"):lower()) and child.ClassName == "Animation" then
		table.insert(notrealmove, child.AnimationId)
	end
end


for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Shadow"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("lShatter"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("FocalPoint"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end


for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Ice"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("ShikaiSkillImpale"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("FE"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("WindA"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("WindC"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("WindP"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Spline"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Rupturing"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Encasing"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Payday"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Corazon"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Geyser"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("FiringSquad"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("ReverseTide"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Lightning"):lower()) and child.ClassName == "Animation" then
		table.insert(extendtheblock, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Nameless"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Berserk"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("RagefulLeap"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("BalaDrive"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("OnSlaught"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("PowerThrough"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Phase"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Duplex"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Shift"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end


for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("Precedence"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("DeathFlairA"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("NegationAir"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("GrandEntrance"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name:lower():find(("CrazedBlitz"):lower()) and child.ClassName == "Animation" then
		table.insert(dodgethis, child.AnimationId)
	end
end



for _, child in ipairs(game.ReplicatedStorage.Assets.SkillAnimations.Healing:GetChildren()) do
	table.insert(notrealmove, child.AnimationId)
end

for _, child in ipairs(game.ReplicatedStorage.Assets.CombatAnimations.LetztStil:GetChildren()) do
	table.insert(dodgethis, child.AnimationId)
end

local localPlayer = game.Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local based = 0
local enemhealth = game.Players.LocalPlayer.Character.Humanoid.Health
local runloop

--[[
local hounce = false
game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.Five or input.KeyCode == Enum.KeyCode.T or input.KeyCode == Enum.KeyCode.Three then
		hounce = true
	end
end)
]]--
--[[
local hounce = false
game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.Five or input.KeyCode == Enum.KeyCode.Y then
		hounce = true
	end
end)
]]--
--[[
local hounce = false
game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.Two or input.KeyCode == Enum.KeyCode.One or input.KeyCode == Enum.KeyCode.Tab or input.KeyCode == Enum.KeyCode.X then
		hounce = true
	end
end)
]]--

game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.V or input.KeyCode == Enum.KeyCode.CapsLock or input.KeyCode == Enum.KeyCode.Two or input.KeyCode == Enum.KeyCode.Six then
		hounce = true
	end
end)

--[[

local BodyParts = {
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):FindFirstChild("Head"),
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):FindFirstChild("Torso"),
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):FindFirstChild("Left Arm"),
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):FindFirstChild("Right Arm"),
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):FindFirstChild("Left Leg"),
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):FindFirstChild("Right Leg")
}
]]--

game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.Eight then
		resetLongBlock() 
	end
end)

function resetLongBlock() 
	if blockmove == true then
		blockmove = false
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
	end
end

game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.Backquote then
		debounce = not debounce
		if debounce == true then
			scriptOn = true
			--game:GetService("Players").LocalPlayer.Character.CharacterHandler.Remotes.Shiftlocked:FireServer(true)

		elseif debounce == false then
			scriptOn = false
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
			--game:GetService("Players").LocalPlayer.Character.CharacterHandler.Remotes.Shiftlocked:FireServer(false)
			resetLongBlock() 
			game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").AutoRotate = true
			blockmove = false
			parry = false
			critical = false
			moveset = false
			movesetextended = false
		end
	end
end)

runLoop = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
	pcall(function()
		based = based + deltaTime*1000 
		--if based >= 0 then
		if based >= 3.58 then
			if scriptOn then
				if Target() then
					local Target = Target()
					if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						local MyDistance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Target.HumanoidRootPart.Position).Magnitude
						local vel = (Target.HumanoidRootPart.Velocity).Magnitude

						local EffectsFolder = workspace.Effects[game.Players.LocalPlayer.Name]

						local Attribute = Target:GetAttribute("CurrentState")

						VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)

						if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Unconscious" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "TrueStunned" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Dying" then

							--local multipler = 0
							--local multipler = 0.0133333*(Target.HumanoidRootPart.Velocity).Magnitude-0.0666667
							--if multipler < 0 or MyDistance < 50 then multipler = 0 end


							local multipler1 = 0.3
							local multipler2 = 0.3

							--[[
							if multipler1 < 0.145 or MyDistance < 15 then multipler1 = 0.145 end
							if multipler2 < 0.145 or MyDistance < 15 then multipler2 = 0.145 end
							]]--
							--[[
                            if Target.Humanoid.Health < enemhealth then
								warn("---------------")
								warn(Target.Name)
								warn("Velocity X: ",  Target.HumanoidRootPart.Velocity.X, " Mu1: ", multipler1)
							end

							if Target.Humanoid.Health < enemhealth then
								warn("Velocity Z: ",  Target.HumanoidRootPart.Velocity.Z, " Mu2: ", multipler2)
							end
							

							enemhealth = Target.Humanoid.Health
							]]--
							--[[
							if not game.Players.LocalPlayer.Character:GetAttribute("Eight") and Attribute == "Flashstep" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Skill" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "ShikaiSkill" then
								VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.P, false, game)
								VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.P, false, game)
							end
							]]--
							
							
							if hounce then
								game:GetService("TweenService"):Create(workspace.CurrentCamera, TweenInfo.new(0), {CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, Vector3.new(Target.HumanoidRootPart.Position.X + Target.HumanoidRootPart.Velocity.X * 0.14, 
								Target.HumanoidRootPart.Position.Y-0.285, Target.HumanoidRootPart.Position.Z + Target.HumanoidRootPart.Velocity.Z * 0.14)) }):Play()
								task.wait(0.15)
								if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Skill" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "ShikaiSkill" then
									hounce = false
								end
							end


							local inputVector = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").MoveDirection
							game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").AutoRotate = false 
							if not checkAnimations(donttrack, game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")) then
								game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0), {CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(Target.HumanoidRootPart.Position.X + Target.HumanoidRootPart.Velocity.X * multipler1, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y, Target.HumanoidRootPart.Position.Z + Target.HumanoidRootPart.Velocity.Z * multipler2)) }):Play()
							end
							--Humanoid:MoveTo(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RootPart.Position + inputVector * game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed)
							--game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(Target.HumanoidRootPart.Position.X + Target.HumanoidRootPart.Velocity.X * multipler, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y, Target.HumanoidRootPart.Position.Z + Target.HumanoidRootPart.Velocity.Z * multipler))
						end

						if (Attribute ~= "WeaponDrawn" and Attribute ~= "Idle" and Attribute ~= "Sprinting" and Attribute ~= "Blocking" and Attribute ~= "Dying" and Attribute ~= "Dashing" and Attribute ~= "Flashstep" and Attribute ~= "TrueStunned" and Attribute ~= "SoftStunned" and Attribute ~= "Walking" and Attribute ~= "Unconscious" and Attribute ~= "Food" and Attribute ~= "Executing" and Attribute ~= "Parrying" and Attribute ~= "Meditating" and Attribute ~= "Carrying" and Attribute ~= "ItemState") and not checkAnimations(notrealmove, Target:FindFirstChildOfClass("Humanoid"))  then
							if checkAnimations(parrylist, Target:FindFirstChildOfClass("Humanoid")) then
								critical = false
								moveset = false
								movesetextended = false
								task.wait(0.1)
								if not parry then
									parry = true
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
								end

								VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
								VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)

								VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
							elseif checkAnimations(extendtheblock, Target:FindFirstChildOfClass("Humanoid")) then
								parry = false
								critical = false
								moveset = false
								if not movesetextended then
									movesetextended = true
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
								end

								VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
								VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
								blockmove = true
							elseif checkAnimations(skillboxes, Target:FindFirstChildOfClass("Humanoid")) then	
								if MyDistance <= 10 then
									if MyDistance <= 4 then
										VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
									else
										VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
										VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
									end
								end
							elseif (Attribute == "Skill" or Attribute == "ShikaiSkill" or checkAnimations(normalcritical, Target:FindFirstChildOfClass("Humanoid"))) and not checkAnimations(dodgethis, Target:FindFirstChildOfClass("Humanoid")) then
								parry = false
								critical = false
								movesetextended = false
								if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Flashstep" and not (EffectsFolder:FindFirstChild("FlashstepClone")) and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Sprinting" then
									if not moveset then
										moveset = true
										VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
										VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
									end

									VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)

									VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
								else
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
								end	
							elseif ((Attribute == "CriticalAttacking") or checkAnimations(dodgethis, Target:FindFirstChildOfClass("Humanoid"))) then
								parry = false
								moveset = false
								movesetextended = false
								if blockmove == true then
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
									blockmove = false
								end
								if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Flashstep" and not (EffectsFolder:FindFirstChild("FlashstepClone")) and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Sprinting" then
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)

									VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
									if not critical then
										VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
										critical = true
									end

								else
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
								end
							else
								parry = false
								critical = false
								moveset = false
								movesetextended = false
								VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
								if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Flashstep" and not (EffectsFolder:FindFirstChild("FlashstepClone")) and Attribute ~= "PostureBroken" then
									if (not EffectsFolder:FindFirstChild("ParryEffect") and not EffectsFolder:FindFirstChild("BlockHitEffect")) then
										VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
									else
										VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)

										if Attribute == "Blocking" then
											if MyDistance < 10 then
												VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
												VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
											end
										else
											if MyDistance < 4.5  then
												if not (game.Players.LocalPlayer.Character:GetAttribute("LightAttackToggled") == nil) then
													VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Tab, false, game)
													VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Tab, false, game)
												end
												VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
											else
												if (game.Players.LocalPlayer.Character:GetAttribute("LightAttackToggled") == nil) then
													VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Tab, false, game)
													VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Tab, false, game)
												end
											end
													--[[
											if MyDistance < 3.5 and not game.Players.LocalPlayer.Character:GetAttribute("Nine") then
												--VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
												VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.L, false, game)
												VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.L, false, game)
											elseif MyDistance < 4.5 then
												--VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
											end
											]]--
										end

									end
								else
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
								end
							end
						else
							parry = false
							critical = false
							moveset = false
							movesetextended = false
							VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
							if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Flashstep" and not (EffectsFolder:FindFirstChild("FlashstepClone")) and Attribute ~= "PostureBroken" then
								VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)

								if Attribute == "Blocking" then
									if MyDistance < 10 then
										VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
										VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
									end
								else 
									if MyDistance < 4.5  then
										if not (game.Players.LocalPlayer.Character:GetAttribute("LightAttackToggled") == nil) then
											VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Tab, false, game)
											VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Tab, false, game)
										end
										VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
									else
										if (game.Players.LocalPlayer.Character:GetAttribute("LightAttackToggled") == nil) then
											VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Tab, false, game)
											VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Tab, false, game)
										end
									end
									--[[
									if MyDistance < 3.5 and not game.Players.LocalPlayer.Character:GetAttribute("Nine") then
										--VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
										VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.L, false, game)
										VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.L, false, game)
									elseif MyDistance < 4.5 then
										--VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
									end
									]]--
								end

							else
								VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
							end
						end

						if blockmove == true then
							VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
							if EffectsFolder:FindFirstChild("ParryEffect") or EffectsFolder:FindFirstChild("BlockHitEffect") then
								VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
								blockmove = false
							end
						end


					end
				end

			end
			based = 0
		end
	end)
end)

game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.End then
		runLoop:Disconnect()
	end
end)
