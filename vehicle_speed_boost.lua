-- ZoroModsTzy Universal Vehicle Boost + GUI Nitro HP Support
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local boosted = false

-- Buat GUI tombol Nitro
local function createGui()
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    gui.Name = "ZoroBoostGui"

    local button = Instance.new("TextButton", gui)
    button.Name = "BoostButton"
    button.Size = UDim2.new(0, 120, 0, 50)
    button.Position = UDim2.new(0.8, 0, 0.8, 0)
    button.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    button.Text = "NITRO: OFF"
    button.TextScaled = true
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.GothamBold
    button.BackgroundTransparency = 0.2
    button.BorderSizePixel = 2
    button.AutoButtonColor = true
    button.ClipsDescendants = true

    button.MouseButton1Click:Connect(function()
        boosted = not boosted
        button.Text = boosted and "NITRO: ON" or "NITRO: OFF"
        button.BackgroundColor3 = boosted and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 80, 80)
    end)
end

-- Boost kendaraan
local function boostVehicle(seat)
    if not seat or not seat:IsA("VehicleSeat") then return end
    pcall(function()
        seat.MaxSpeed = boosted and 600 or 300
        seat.Torque = boosted and 200000 or 100000
        seat.Throttle = 1
    end)
end

-- Shift Key (PC)
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.LeftShift then
        boosted = true
    end
end)

UIS.InputEnded:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.LeftShift then
        boosted = false
    end
end)

-- Looping booster
