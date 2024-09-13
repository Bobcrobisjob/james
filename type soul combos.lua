repeat wait() until game:IsLoaded()
print("executed")

local runloop
local VirtualInputManager = Instance.new('VirtualInputManager')



print("auto rec center loaded")

local bb=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
	bb:CaptureController()bb:ClickButton2(Vector2.new())
end)

if 14269621394 ~= game.PlaceId then

	if 15297128281 == game.PlaceId then
		local args = {
            [1] = "getData",
            [2] = game:GetService("Players").LocalPlayer
        }
        
        game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Data.RF"):InvokeServer(unpack(args))
        
        local args = {
            [1] = "Change Ready Settings",
            [2] = true
        }
        
        game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Main.RE"):FireServer(unpack(args))
	end 

    --[["rec lobby shit"]]
elseif game.PlaceId == 14269621394 then


	local char = game.Players.LocalPlayer.Character

	game.Players.LocalPlayer.CharacterAdded:Connect(function(CHAR)
		char = CHAR
	end)

	local goals = {}

	local corners = {Vector3.new(-53.746,3.519,-479.379),
	Vector3.new(28.030,3.519,-363.435)}

	local goalitself
	local corner
	do
		local a = workspace:GetDescendants()

		for x = 1, #a do
			if (a[x]:IsA("MeshPart") and a[x].Name == "Rim") then
				table.insert(goals, a[x])
			end
		end
	end

	repeat task.wait() until game.Players.LocalPlayer.Team 
	
	for i,v in pairs(goals) do
		local lastChar1 = string.sub(v.Parent.Name, -1)
		local lastChar2 = string.sub(game.Players.LocalPlayer.Team.Name, -1)

		if lastChar1 == lastChar2 then
			goalitself = v
			break
		end
	end
	if goalitself.Parent.Name == "Hoop1" then
		corner = corners[1]
	else
		corner = corners[2]
	end
--[[
	function PersonToFollow()
		local target = nil
		local distance = math.huge

		for i,v in next, game.Players:GetPlayers() do
			if v and v.Character and v~=game.Players.LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChildOfClass("Humanoid") and v.Character:FindFirstChildOfClass("Humanoid").Health>0 and v.Character:FindFirstChild("BallConnect") and v.Team ~= game.Players.LocalPlayer.Team and not v.Character:FindFirstChild("Currently_ShootingFreethrows") then
				local plrdist = game.Players.LocalPlayer:DistanceFromCharacter(v.Character:FindFirstChildOfClass('Humanoid').RootPart.CFrame.p)
				if plrdist < distance then
					target = v
					distance = plrdist
				end
			end
		end

		return target
	end
]]--
	function PersonToFollow()
		local target = nil
		local highestpoints = -1
		local path

		for _, child in ipairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
			if child.Name:lower():find(("Scoreboard.Ui"):lower()) then
				path = child
				break
			end
		end


		for i,b in next, path.PickupStats.Team1:GetChildren() do
			if b.Name == "Stat_Card_Template" then
				local v
				if game.Players:FindFirstChild(b:FindFirstChild("Player").Text) then
					v = game.Players[b:FindFirstChild("Player").Text]
					if v and v.Character and v~=game.Players.LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChildOfClass("Humanoid") and v.Character:FindFirstChildOfClass("Humanoid").Health>0 and v.Team ~= game.Players.LocalPlayer.Team and not v.Character:FindFirstChild("Currently_ShootingFreethrows") then
						local points = tonumber(b:FindFirstChild("PTS").Text)
						if points >= highestpoints then
							target = v
							highestpoints = points
						end
					end
				end
			end
		end

		for i,b in next, path.PickupStats.Team2:GetChildren() do
			if b.Name == "Stat_Card_Template" then
				local v
				if game.Players:FindFirstChild(b:FindFirstChild("Player").Text)  then
					v = game.Players[b:FindFirstChild("Player").Text]
					if v and v.Character and v~=game.Players.LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChildOfClass("Humanoid") and v.Character:FindFirstChildOfClass("Humanoid").Health>0 and v.Team ~= game.Players.LocalPlayer.Team and not v.Character:FindFirstChild("Currently_ShootingFreethrows") then
						local points = tonumber(b:FindFirstChild("PTS").Text)
						if points >= highestpoints then
							target = v
							highestpoints = points
						end
					end
				end
			end
		end

		return target
	end

	function Freethrow()
		for i,v in next, game.Players:GetPlayers() do
			if v and v.Character and v.Character:FindFirstChild("Currently_ShootingFreethrows") then
				return true				
			end
		end
		return false
	end

	function WhohasTheBall()
		for i,v in next, game.Players:GetPlayers() do
			if v and v.Character and v.Team == game.Players.LocalPlayer.Team and v.Character:FindFirstChild("BallConnect") and not v.Character:FindFirstChild("Currently_ShootingFreethrows") then
				return true				
			end
		end
		return false
	end

	function OtherTeam()
		for i,v in next, game.Players:GetPlayers() do
			if v and v.Character and v.Team ~= game.Players.LocalPlayer.Team and v.Character:FindFirstChild("BallConnect") and not v.Character:FindFirstChild("Currently_ShootingFreethrows") then
				return true				
			end
		end
		return false
	end

	function BallHandler()
		for i,v in next, game.Players:GetPlayers() do
			if v and v.Character and v.Team ~= game.Players.LocalPlayer.Team and v.Character:FindFirstChild("BallConnect") then
				return v		
			end
		end
		return nil
	end
	
	function ClosestIB()
		local target = nil
		local distance = math.huge

		for i,v in next, game.Workspace.TempFolder:GetChildren() do
			if v and v.Name == "IB" and v:FindFirstChild("IBCount") then
				local plrdist = game.Players.LocalPlayer:DistanceFromCharacter(v.CFrame.p)
				if plrdist < distance then
					target = v
					distance = plrdist
				end
			end
		end

		return target
	end
	
	local Left = Instance.new("Animation")
	Left.AnimationId = "rbxassetid://10048687356"--left
	local LeftAnimation = char.Humanoid:LoadAnimation(Left)
	LeftAnimation.Looped = false

	local Right = Instance.new("Animation")
	Right.AnimationId = "rbxassetid://10048696265"--right
	local RightAnimation = char.Humanoid:LoadAnimation(Right)
	RightAnimation.Looped = false

	local Forward = Instance.new("Animation")
	Forward.AnimationId = "rbxassetid://10053690711"--forward
	local ForwardAnimation = char.Humanoid:LoadAnimation(Forward)
	ForwardAnimation.Looped = false

	local Backward = Instance.new("Animation")
	Backward.AnimationId = "rbxassetid://10053509687"--backwards
	local BackwardAnimation = char.Humanoid:LoadAnimation(Backward)
	BackwardAnimation.Looped = false

	local Idle = Instance.new("Animation")
	Idle.AnimationId = "rbxassetid://10047380140"--idle
	local IdleAnimation = char.Humanoid:LoadAnimation(Idle)
	IdleAnimation.Looped = false

	local Target = game.Players.LocalPlayer

	function getMovementDirection()
		local b = Target
		if b then
			-- Get the player's position
			local playerPosition = char.HumanoidRootPart.Position
	
			-- Calculate the vector towards the target
			local targetDirection = (b.Character.HumanoidRootPart.Position - playerPosition).Unit
	
			-- Calculate the player's velocity vector
			local velocity = char.Humanoid.RootPart.Velocity
			local playerVelocity = Vector3.new(velocity.X, 0, velocity.Z).Unit
	
			-- Calculate the dot products
			local dotRight = targetDirection:Dot(Vector3.new(-playerVelocity.Z, 0, playerVelocity.X))
			local dotForward = targetDirection:Dot(playerVelocity)
	
			-- Set a threshold for negligible velocity
			local velocityThreshold = 1
	
			-- Check if the velocity is negligible
			if velocity.magnitude < velocityThreshold then
				return "None"
			end
	
			-- Determine the movement direction relative to the target
			if dotForward < -0.6 then
				return "Backward"
			elseif dotRight > 0.1 then
				return "Left"
			elseif dotRight < -0.1 then
				return "Right"
			elseif dotForward > 0.6 then
				return "Forward"
			else
				return "None"
			end
		else
			-- No target found
			return "No target"
		end
	end
	
	function movementscript()
		local movementDirection = getMovementDirection()
		if movementDirection == "Left" then
			if LeftAnimation.IsPlaying == false then
				LeftAnimation:Play()
			end
	
			RightAnimation:Stop()
			ForwardAnimation:Stop()
			BackwardAnimation:Stop()
			IdleAnimation:Stop()
		elseif movementDirection == "Right" then
			if RightAnimation.IsPlaying == false then
				RightAnimation:Play()
			end
	
			LeftAnimation:Stop()
			ForwardAnimation:Stop()
			BackwardAnimation:Stop()
			IdleAnimation:Stop()
		elseif movementDirection == "Forward" then
			if ForwardAnimation.IsPlaying == false then					
				ForwardAnimation:Play()
			end
	
			LeftAnimation:Stop()
			RightAnimation:Stop()
			BackwardAnimation:Stop()
			IdleAnimation:Stop()
		elseif movementDirection == "Backward" then
			if BackwardAnimation.IsPlaying == false then
				BackwardAnimation:Play()
			end
	
			LeftAnimation:Stop()
			RightAnimation:Stop()
			ForwardAnimation:Stop()
			IdleAnimation:Stop()
		else
			LeftAnimation:Stop()
			RightAnimation:Stop()
			ForwardAnimation:Stop()
			BackwardAnimation:Stop()
			if char.Humanoid.MoveDirection.Magnitude > 0 then
				IdleAnimation:Stop()
			else
				IdleAnimation:Play()
			end
		end
	end
	
	local function StopMovement()
		if LeftAnimation.IsPlaying or RightAnimation.IsPlaying or 
			ForwardAnimation.IsPlaying or BackwardAnimation.IsPlaying then
			for _, track in ipairs(char.Humanoid:GetPlayingAnimationTracks()) do
				local animationId = track.Animation.AnimationId
				if animationId == "rbxassetid://10047380140" then
					track:Stop()
					break
				end
			end
		end
	end	

	local function StopOverall()
		LeftAnimation:Stop() RightAnimation:Stop() ForwardAnimation:Stop() BackwardAnimation:Stop() IdleAnimation:Stop() 
	end

	local function XZ(V)
		return Vector3.new(V.X, 0, V.Z)
	end

	local function MoveTo(POS)
		local humanoid = game.Players.LocalPlayer.Character.Humanoid


		humanoid:MoveTo(POS)
	end

	local cycle = true
	local passonce = true
	local lapsed = 0 
	local eventFired = false
	runLoop = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
		lapsed = lapsed + deltaTime*1000 
		game.Players.LocalPlayer.PlayerScripts.BubbleChat.Disabled = true
		if cycle then
			cycle = false
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game)
			task.wait()
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, game)
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.D, false, game)
			task.wait()
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.D, false, game)
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.S, false, game)
			task.wait()
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.S, false, game)
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.A, false, game)
			task.wait()
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.A, false, game)
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Tab, false, game)
			task.wait(2)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Tab, false, game)
			cycle = true
		end
		if lapsed >= 500 then
			if PersonToFollow() then
				Target = PersonToFollow()
			end
			lapsed = 0
		end
		--[[
		if PersonToFollow() and (PersonToFollow().Character.HumanoidRootPart.Velocity).Magnitude>0 then
			Target = PersonToFollow()
		else
			Target = BallHandler()
		end
		]]--
		if Target and not Freethrow() and not WhohasTheBall() and not ClosestIB()  then
			local MyDistance = (char.HumanoidRootPart.Position - Target.Character.HumanoidRootPart.Position).Magnitude
			local goal = goalitself
			local HoopDistance = (goal.Position - Target.Character.HumanoidRootPart.Position).Magnitude
			local path = (XZ(goal.Position) - XZ(Target.Character.HumanoidRootPart.Position)).unit
			char.Humanoid.WalkSpeed = Target.Character.Humanoid.WalkSpeed * 0.8
			if char.Humanoid.WalkSpeed < 15 then char.Humanoid.WalkSpeed = 15 end
			if HoopDistance > 85 then
				MoveTo(goal.Position)
			else
				if OtherTeam() then
					MoveTo(Target.Character.HumanoidRootPart.Position + path*3.75)
				end
			end
			game.Players.LocalPlayer.Character.HumanoidRootPart.CustomPhysicalProperties = PhysicalProperties.new(0.5, 0.300000012, 0.5, 1, 1) 
			if MyDistance <= 15 and Target.Character:FindFirstChild("BallConnect") then

				StopMovement()
				if (Target.Character:FindFirstChild("BallConnect")) then
					movementscript()
					VirtualInputManager:SendKeyEvent(true, "G", false, game)

					local args = {
						[1] = true,
						[2] = "Defense",
						[3] = Target
					}

					game:GetService("ReplicatedStorage").PlayerEvents.Physical:FireServer(unpack(args))
				else
					StopOverall()
					VirtualInputManager:SendKeyEvent(false, "G", false, game)
				end
			else
				VirtualInputManager:SendKeyEvent(false, "G", false, game)
				StopOverall()
			end

			if Target.Backpack.ActionValues.Power.Value >= 0.001 and MyDistance < 9 then
				VirtualInputManager:SendKeyEvent(true, "Space", false, game)
				VirtualInputManager:SendKeyEvent(false, "Space", false, game)
			end

		else
			if WhohasTheBall() then
				local CornerDistance = (char.HumanoidRootPart.Position - corner).Magnitude
				if CornerDistance > 4 then
					VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game) 
					--[[
					VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.One, false, game)
					task.wait()
					VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.One, false, game)
					]]--
					
					if game:GetService("Players"):FindFirstChild("sisesination") then
						if char:FindFirstChild("BallConnect") then
							--if passonce then
							--	passonce = false
								local args5 = {
									[1] = "Pass",
									[2] = game:GetService("Players").sisesination.Character,
									[3] = "Overhead"
								}
								
								game:GetService("ReplicatedStorage").PlayerEvents.Passing:FireServer(unpack(args5))
							--end
						--else
							--passonce = true
						end
					end
					
				else

					if char:FindFirstChild("BallConnect") then
						VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game) 
						if game.Players.LocalPlayer.Backpack.ActionValues.Power.Value > 60 then
							if not eventFired then 
								local shoot = {
									[1] = false,
									[2] = "Shooting",
									[3] = "Standing Shot"
								}
								
								game:GetService("ReplicatedStorage").PlayerEvents.Shooting:FireServer(unpack(shoot))

								VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
								eventFired = true 
							end
						else
							eventFired = false
						end
					else
						eventFired = false
					end

				end
				MoveTo(corner)
			else
				MoveTo(char.HumanoidRootPart.Position)
			end
			StopOverall()
			
			if ClosestIB() then
				local goal = goalitself
				if (XZ(goal.Position) - XZ(ClosestIB().Position)).Magnitude < 85 then
					MoveTo(ClosestIB().Position)
				end
			end
			
			
		end

		

	end)
	

end


game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.Backquote then
		runLoop:Disconnect()
	end
end)

