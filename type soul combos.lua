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
	task.wait(40)
	local TargetToFollow = nil
	function PersonToFollow()
		local target = nil
		local distance = math.huge

		for i,v in next, game.Players:GetPlayers() do
			if v and v.Character and v~=game.Players.LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChildOfClass("Humanoid") and v.Character:FindFirstChildOfClass("Humanoid").Health>0 and v.Team~=game.Players.LocalPlayer.Team and v~=TargetToFollow then
				local plrdist = game.Players.LocalPlayer:DistanceFromCharacter(v.Character:FindFirstChildOfClass('Humanoid').RootPart.CFrame.p)
				if plrdist < distance then
					target = v8
					distance = plrdist
				end
			end
		end

		return target
	end

	local function MoveTo(POS)
		local humanoid = game.Players.LocalPlayer.Character.Humanoid


		humanoid:MoveTo(POS)
	end

	local lastPosition = nil
	local lastMoveTime = tick()
	local cycle = true
	runLoop = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)

		if TargetToFollow == nil then
			TargetToFollow = PersonToFollow()
			lastPosition = TargetToFollow.Character.HumanoidRootPart.Position
		else
			if TargetToFollow and TargetToFollow.Character then
				local TargetCharacter = TargetToFollow.Character
				local currentPosition = TargetCharacter.HumanoidRootPart.Position

				-- Check if the target has moved
				if (currentPosition - lastPosition).magnitude > 0 then
					lastPosition = currentPosition
					lastMoveTime = tick() -- Reset last move time
				end

				-- Move to the target's position
				MoveTo(currentPosition)

				-- Check if 30 seconds have passed since the last movement
				if tick() - lastMoveTime > 3 then
					TargetToFollow = PersonToFollow() -- Reassign the target
					lastPosition = TargetToFollow.Character.HumanoidRootPart.Position
					lastMoveTime = tick() -- Reset last move time
				end
			else
				TargetToFollow = PersonToFollow()
			end
		end

		if cycle then
			cycle = false
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.One, false, game)
			task.wait()
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.One, false, game)

			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game)
			task.wait(5)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, game)
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.D, false, game)
			task.wait(5)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.D, false, game)
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.S, false, game)
			task.wait(5)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.S, false, game)
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.A, false, game)
			task.wait(5)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.A, false, game)
			cycle = true
		end
		
	end)
	

end


game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.Backquote then
		runLoop:Disconnect()
	end
end)
