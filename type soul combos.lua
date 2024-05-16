local VirtualInputManager = Instance.new('VirtualInputManager')

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

local specialmove = false
local critical = false

local blockmove = false

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
           	game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").AutoRotate = true
			specialmove = false
			critical = false
			blockmove = false
		end
	end
end)
local elapsed = 0

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


local skillboxes = {}
local dodgethis = {}
local notrealmove = {}

local extendtheblock = {}
local extenditabit = {}

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
    if child.Name:lower():find(("Strata"):lower()) and child.ClassName == "Animation" then
        table.insert(skillboxes, child.AnimationId)
    end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
    if child.Name:lower():find(("Heavenly"):lower()) and child.ClassName == "Animation" then
        table.insert(skillboxes, child.AnimationId)
    end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
    if child.Name:lower():find(("DeathFlairA"):lower()) and child.ClassName == "Animation" then
        table.insert(skillboxes, child.AnimationId)
    end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
    if child.Name:lower():find(("NegationAir"):lower()) and child.ClassName == "Animation" then
        table.insert(skillboxes, child.AnimationId)
    end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
    if child.Name:lower():find(("HollowBite"):lower()) and child.ClassName == "Animation" then
        table.insert(skillboxes, child.AnimationId)
    end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
    if child.Name:lower():find(("Zangerin"):lower()) and child.ClassName == "Animation" then
        table.insert(dodgethis, child.AnimationId)
    end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
    if child.Name:lower():find(("Licht"):lower()) and child.ClassName == "Animation" then
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
    if child.Name:lower():find(("FEFly"):lower()) and child.ClassName == "Animation" then
        table.insert(extendtheblock, child.AnimationId)
    end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
    if child.Name:lower():find(("Fear"):lower()) and child.ClassName == "Animation" then
        table.insert(extendtheblock, child.AnimationId)
    end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
    if child.Name:lower():find(("CeroOsc"):lower()) and child.ClassName == "Animation" then
        table.insert(extendtheblock, child.AnimationId)
    end
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
    if child.Name:lower():find(("Fireflies"):lower()) and child.ClassName == "Animation" then
        table.insert(extendtheblock, child.AnimationId)
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



for _, child in ipairs(game.ReplicatedStorage.Assets.SkillAnimations.Healing:GetChildren()) do
	table.insert(notrealmove, child.AnimationId)
end

for _, child in ipairs(game.ReplicatedStorage.Assets.CombatAnimations.LetztStil:GetChildren()) do
    table.insert(dodgethis, child.AnimationId)
end

for _, child in ipairs(game.ReplicatedStorage:GetDescendants()) do
    if child.Name:lower():find(("CombatAnimations"):lower()) then
       	for i, v in ipairs(child:GetChildren()) do 
       		if v.Name == "AdvancedShunko" then
       			for p, l in (v:GetChildren()) do
       				if l.Name:lower():find(("Crit"):lower()) and l.ClassName == "Animation" then
       					table.insert(extenditabit, l.AnimationId)
       				end
       			end
       		end
       	end
    end
end

local based = 0
local enemhealth = game.Players.LocalPlayer.Character.Humanoid.Health
local runloop
runLoop = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
	--pcall(function()
		based = based + deltaTime*1000 
		if based >= 3.58 then
			if scriptOn then
				if Target() then
					local Target = Target()
					if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then

						local MyDistance = ( XZ(game.Players.LocalPlayer.Character.HumanoidRootPart.Position) - XZ(Target.HumanoidRootPart.Position) ).Magnitude
						local vel = (Target.HumanoidRootPart.Velocity).Magnitude
						
						local EffectsFolder = workspace.Effects[game.Players.LocalPlayer.Name]

						local Attribute = Target:GetAttribute("CurrentState")

						VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)

						if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Unconscious" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "TrueStunned" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Dying" then
							
							local multipler = 0.0133333*(Target.HumanoidRootPart.Velocity).Magnitude-0.0666667
							if multipler < 0 or MyDistance < 25 then multipler = 0 end

	                           --[[
                            local multipler = 0.7
                            if Target.Humanoid.Health < enemhealth then
								warn("Velocity: ",  (Target.HumanoidRootPart.Velocity).Magnitude, " Mu: ", multipler)
							end
							

							enemhealth = Target.Humanoid.Health
                            ]]--
							game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").AutoRotate = false 
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(Target.HumanoidRootPart.Position.X + Target.HumanoidRootPart.Velocity.X * multipler, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y, Target.HumanoidRootPart.Position.Z + Target.HumanoidRootPart.Velocity.Z * multipler))
						end

						if (Attribute ~= "WeaponDrawn" and Attribute ~= "Idle" and Attribute ~= "Sprinting" and Attribute ~= "Blocking" and Attribute ~= "Dying" and Attribute ~= "Dashing" and Attribute ~= "Flashstep" and Attribute ~= "TrueStunned" and Attribute ~= "SoftStunned" and Attribute ~= "Walking" and Attribute ~= "Unconscious" and Attribute ~= "Food" and Attribute ~= "Executing" and Attribute ~= "Parrying" and Attribute ~= "Meditating" and Attribute ~= "Carrying" and Attribute ~= "ItemState") and not checkAnimations(notrealmove, Target:FindFirstChildOfClass("Humanoid"))  then
							if (Attribute == "CriticalAttacking") or checkAnimations(dodgethis, Target:FindFirstChildOfClass("Humanoid")) then
	
								if blockmove == true then
									blockmove = false
									elapsed = 0
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
								end

								if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Flashstep" and not (EffectsFolder:FindFirstChild("FlashstepClone")) and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Sprinting" then
									specialmove = false
									if not critical then
										VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, game)
										VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
									end

									if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Unconscious" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "TrueStunned" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Dying" then
										--game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").AutoRotate = false 
									end
								
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
									
									VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
									VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
									if checkAnimations(extenditabit, Target:FindFirstChildOfClass("Humanoid")) then
										elapsed = -1
									end
									if not critical then
										critical = true
										VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
									end
								else
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
								end
							elseif (Attribute == "Skill" or Attribute == "ShikaiSkill") then
								if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Flashstep" and not (EffectsFolder:FindFirstChild("FlashstepClone")) and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Sprinting" then
									if not checkAnimations(skillboxes, Target:FindFirstChildOfClass("Humanoid")) then
										critical = false
										if not specialmove then
											specialmove = true
											VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
											VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, game)
										end

										if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Unconscious" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "TrueStunned" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Dying" then
											--game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").AutoRotate = false 
										end

										if checkAnimations(extendtheblock, Target:FindFirstChildOfClass("Humanoid")) then
											elapsed = -42500000
										elseif checkAnimations(extenditabit, Target:FindFirstChildOfClass("Humanoid")) then
											elapsed = -5500
										end

										VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)

										VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
										VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)

										VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
										blockmove = true
									else
										if MyDistance <= 10 then
											if blockmove == true then
												blockmove = false
												elapsed = 0
												VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
											end
											if MyDistance <= -1 then
												--VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
											else
												VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
												VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
											end
										else
											blockmove = true
										end
									end
								else
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
								end
							else
								specialmove = false
								critical = false
								
								VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)

								if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Flashstep" and not (EffectsFolder:FindFirstChild("FlashstepClone")) and Attribute ~= "PostureBroken" then
									if (not EffectsFolder:FindFirstChild("ParryEffect") and not EffectsFolder:FindFirstChild("BlockHitEffect")) then
										if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Unconscious" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "TrueStunned" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Dying" then
											--game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").AutoRotate = false 
										end
										VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
									else
										VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)

										if Attribute == "Blocking" then
											if MyDistance <= 10 then
												VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
												VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
											end
										else
											if MyDistance <= 5 then
												VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
											end
										end

									end
								else
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
								end
							end
						else
							specialmove = false
							critical = false
							if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Flashstep" and not (EffectsFolder:FindFirstChild("FlashstepClone")) and Attribute ~= "PostureBroken" then
								VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)

								if Attribute == "Blocking" then
									if MyDistance <= 10 then
										VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
										VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
									end
								else
									if MyDistance <= 5 then
										VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0)
									end
								end

							else
								VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
							end
						end

						if blockmove == true then
							VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
							if EffectsFolder:FindFirstChild("ParryEffect") or Attribute == "CriticalAttacking" or not (Attribute ~= "Sprinting" and Attribute ~= "Blocking" and Attribute ~= "Dying" and Attribute ~= "Dashing" and Attribute ~= "Flashstep" and Attribute ~= "TrueStunned" and Attribute ~= "SoftStunned" and Attribute ~= "Walking" and Attribute ~= "Unconscious" and Attribute ~= "Food" and Attribute ~= "Executing" and Attribute ~= "Parrying" and Attribute ~= "Meditating" and Attribute ~= "Carrying" and Attribute ~= "ItemState" and Attribute ~= "Attacking") then
								blockmove = false
								VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
								elapsed = 0
							elseif not (Attribute ~= "WeaponDrawn" and Attribute ~= "Idle") then
								elapsed = elapsed + deltaTime*3580
								if game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Unconscious" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "TrueStunned" and game.Players.LocalPlayer.Character:GetAttribute("CurrentState") ~= "Dying" then
									--game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").AutoRotate = false 
								end
								if elapsed >= 0 then
									blockmove = false
									VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
									elapsed = 0
								end
							end
						end


					end
				end

			end
			based = 0
		end
	--end)
end)

game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.End then
		runLoop:Disconnect()
	end
end)
