local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local boosted = false

-- Boost function
local function boostVehicle(seat)
    if not seat or not seat:IsA("VehicleSeat") then return end
    pcall(function()
        seat.MaxSpeed = boosted and 600 or 300
        seat.Torque = boosted and 200000 or 100000
        seat.Throttle = 1
    end)
end

-- Keybind handler PC
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftShift then
        boosted = true
    end
end)

UIS.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftShift then
        boosted = false
    end
end)

-- Main loop
while task.wait(0.2) do
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.SeatPart and humanoid.SeatPart:IsA("VehicleSeat") then
            boostVehicle(humanoid.SeatPart)
        end
    end
end
