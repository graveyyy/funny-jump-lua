local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local flying = false
local speed = 50

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local flyDirection = Vector3.new(0, 0, 0)

-- Function to toggle flying
local function toggleFly()
    flying = not flying

    if flying then
        humanoid.PlatformStand = true -- Disable character physics

        -- Fly loop
        while flying do
            -- Move the character based on flyDirection
            character:TranslateBy(flyDirection * speed * RunService.Heartbeat:Wait())
        end
        
        humanoid.PlatformStand = false -- Re-enable character physics
    end
end

-- Update flyDirection based on WASD and Space/Shift input
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.W then
            flyDirection = flyDirection + Vector3.new(0, 0, -1) -- Forward
        elseif input.KeyCode == Enum.KeyCode.S then
            flyDirection = flyDirection + Vector3.new(0, 0, 1) -- Backward
        elseif input.KeyCode == Enum.KeyCode.A then
            flyDirection = flyDirection + Vector3.new(-1, 0, 0) -- Left
        elseif input.KeyCode == Enum.KeyCode.D then
            flyDirection = flyDirection + Vector3.new(1, 0, 0) -- Right
        elseif input.KeyCode == Enum.KeyCode.Space then
            flyDirection = flyDirection + Vector3.new(0, 1, 0) -- Upward
        elseif input.KeyCode == Enum.KeyCode.LeftControl then
            flyDirection = flyDirection + Vector3.new(0, -1, 0) -- Downward
        elseif input.KeyCode == Enum.KeyCode.X then
            toggleFly() -- Toggle flying
        end
    end
end)

-- Reset flyDirection on input release
UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.W then
            flyDirection = flyDirection - Vector3.new(0, 0, -1) -- Stop moving forward
        elseif input.KeyCode == Enum.KeyCode.S then
            flyDirection = flyDirection - Vector3.new(0, 0, 1) -- Stop moving backward
        elseif input.KeyCode == Enum.KeyCode.A then
            flyDirection = flyDirection - Vector3.new(-1, 0, 0) -- Stop moving left
        elseif input.KeyCode == Enum.KeyCode.D then
            flyDirection = flyDirection - Vector3.new(1, 0, 0) -- Stop moving right
        elseif input.KeyCode == Enum.KeyCode.Space then
            flyDirection = flyDirection - Vector3.new(0, 1, 0) -- Stop moving upward
        elseif input.KeyCode == Enum.KeyCode.LeftControl then
            flyDirection = flyDirection - Vector3.new(0, -1, 0) -- Stop moving downward
        end
    end
end)

-- Optional: Stop flying when the player dies
player.CharacterAdded:Connect(function()
    flying = false
    humanoid.PlatformStand = false
end)
