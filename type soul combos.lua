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

	function PersonToFollow()
		local target = nil
		local distance = math.huge

		for i,v in next, game.Players:GetPlayers() do
			if v and v.Character and v~=game.Players.LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChildOfClass("Humanoid") and v.Character:FindFirstChildOfClass("Humanoid").Health>0 then
				local plrdist = game.Players.LocalPlayer:DistanceFromCharacter(v.Character:FindFirstChildOfClass('Humanoid').RootPart.CFrame.p)
				if plrdist < distance then
					target = v
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


	local TargetToFollow = nil
	runLoop = game.RunService.RenderStepped:Connect(function(deltaTime)
		if TargetToFollow == nil then
			TargetToFollow = PersonToFollow()
		else
			if TargetToFollow then
				if TargetToFollow.Character then
					local TargetCharacter =  TargetToFollow.Character
					MoveTo(TargetCharacter.HumanoidRootPart.Position)
				end
			else
				TargetToFollow = PersonToFollow()
			end
		end
	end)
end


game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.Backquote then
		runLoop:Disconnect()
	end
end)
