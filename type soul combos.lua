repeat wait() until game:IsLoaded()
print("executed")
task.wait(5)
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
	task.wait(15)

	local char = game.Players.LocalPlayer.Character

	game.Players.LocalPlayer.CharacterAdded:Connect(function(CHAR)
		char = CHAR
	end)

	local goals = {}

	do
		local a = workspace:GetDescendants()

		for x = 1, #a do
			if (a[x]:IsA("MeshPart") and a[x].Name == "Rim") then
				table.insert(goals, a[x])
			end
		end
	end

	local function Goal()

		local root = game.Players.LocalPlayer.Character.HumanoidRootPart
		local D = {}
	
		for _, goal in pairs(goals) do
			table.insert(D, (root.Position - goal.Position).magnitude)
		end
	
		local closegoal = math.min(unpack(D))
	
		for _, goal in pairs(goals) do
			local d = (root.Position - goal.Position).magnitude
	
	
			if (d == closegoal) then
				return goal
			end
		end
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

	function getMovementDirection()
		local target = getclosetballhandler()
		if target then
			-- Get the player's position
			local playerPosition = char.HumanoidRootPart.Position
	
			-- Calculate the vector towards the target
			local targetDirection = (target.Character.HumanoidRootPart.Position - playerPosition).Unit
	
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
			if dotForward < -0.5 then
				return "Backward"
			elseif dotRight > 0.1 then
				return "Left"
			elseif dotRight < -0.1 then
				return "Right"
			elseif dotForward > 0.5 then
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

	function PersonToFollow()
		local target = nil
		local distance = math.huge

		for i,v in next, game.Players:GetPlayers() do
			if v and v.Character and v~=game.Players.LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChildOfClass("Humanoid") and v.Character:FindFirstChildOfClass("Humanoid").Health>0 and v.Character:FindFirstChild("BallConnect") and v.Team ~= game.Players.LocalPlayer.Team then
				local plrdist = game.Players.LocalPlayer:DistanceFromCharacter(v.Character:FindFirstChildOfClass('Humanoid').RootPart.CFrame.p)
				if plrdist < distance then
					target = v
					distance = plrdist
				end
			end
		end

		return target
	end

	local function XZ(V)
		return Vector3.new(V.X, 0, V.Z)
	end

	local function MoveTo(POS)
		local humanoid = game.Players.LocalPlayer.Character.Humanoid


		humanoid:MoveTo(POS)
	end

	local cycle = true
	runLoop = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)

		if cycle then
			cycle = false
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.One, false, game)
			task.wait()
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.One, false, game)

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
			cycle = true
		end

		if PersonToFollow() then
			local MyDistance = (char.HumanoidRootPart.Position - PersonToFollow().Character.HumanoidRootPart.Position).Magnitude
			local goal = Goal()
			local path = (XZ(goal.Position) - XZ(PersonToFollow().Character.HumanoidRootPart.Position)).unit
			MoveTo(PersonToFollow().Character.HumanoidRootPart.Position + path*5)

			local args = {
				[1] = true,
				[2] = "Defense",
				[3] = PersonToFollow()
			}

			game:GetService("ReplicatedStorage").PlayerEvents.Physical:FireServer(unpack(args))


			StopMovement()
			movementscript()
			if MyDistance <= 20 then
				VirtualInputManager:SendKeyEvent(true, "G", false, game)
			else
				VirtualInputManager:SendKeyEvent(false, "G", false, game)
			end
		end
		

	end)
	

end


game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.Backquote then
		runLoop:Disconnect()
	end
end)
