
task.wait(3)

local b = settings();

local debounce = true

local runLoop

runLoop = game:GetService("RunService").RenderStepped:Connect(function(deltaTime) 
	pcall(function()


			if debounce == true then
				--game.Players.LocalPlayer.Character:FindFirstChild("Basketball")
				if game.Players.LocalPlayer.Character.HumanoidRootPart.Basketball.Part1 ~= nil then
                    delay(1.5, function()
						if game.Players.LocalPlayer.Character.HumanoidRootPart.Basketball.Part1 ~= nil then
							b.Network.IncomingReplicationLag = 0.225;
						end
					end)
                else
					b.Network.IncomingReplicationLag = 0;
                end
			end

	end)
end)

game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.End then
		runLoop:Disconnect()
        b.Network.IncomingReplicationLag = 0;
	end
end)

game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.Zero then
		debounce = false
        b.Network.IncomingReplicationLag = 0;
	end
end)

game.UserInputService.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.Nine then
		debounce = true	
	end
end)
