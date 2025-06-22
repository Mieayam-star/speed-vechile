local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local boosted = false

-- Tunggu PlayerGui ready
local playerGui = player:WaitForChild("PlayerGui")

-- Buat GUI tombol Nitro
local function createGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ZoroBoostGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local button = Instance.new("TextButton")
    button.Name = "BoostButton"
    button.Size = UDim2.new(0, 120, 0, 50)
    button.Position = UDim2.new(0.8, 0, 0.8, 0)
    button.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    button.Text = "NITRO: OFF"
    button.TextScaled = true
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.BackgroundTransparency = 0.2
    button.BorderSizePixel = 2
    button.AutoButtonColor = true
    button.ClipsDescendants = true
    button.Parent = screenGui

    button.MouseButton1Click:Connect(function()
        boosted = not boosted
        button.Text = boosted and "NITRO: ON" or "NITRO: OFF"
        button.BackgroundColor3 = boosted and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 80, 80)
    end)
end

-- Fungsi boost kendaraan
local function boostVehicle(seat)
    if seat and seat:IsA("VehicleSeat") then
        pcall(function()
            seat.MaxSpeed = boosted and 234 or 100
            seat.Torque = boosted and 200000 or 100000
            seat.Throttle = 1
        end)
    end
end

-- Keybind tombol W (maju)
UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.W then
        boosted = true
    end
end)

UIS.InputEnded:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.W then
        boosted = false
    end
end)

-- Inisialisasi GUI
createGui()

-- Loop boost kendaraan
RunService.Heartbeat:Connect(function()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            boostVehicle(humanoid.SeatPart)
        end
    end
end)
