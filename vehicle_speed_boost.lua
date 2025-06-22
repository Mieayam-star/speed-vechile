-- Boost manual saat NITRO ON + tombol W ditekan (by ZoroModsTzy)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local boosted = false
local keyHeld = false

-- GUI Nitro
local function createGui()
    local gui = Instance.new("ScreenGui")
    gui.Name = "ZoroBoostGui"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,120,0,50)
    btn.Position = UDim2.new(0.8,0,0.8,0)
    btn.BackgroundColor3 = Color3.fromRGB(255,80,80)
    btn.Text = "NITRO: OFF"
    btn.TextScaled = true
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.Parent = gui

    btn.MouseButton1Click:Connect(function()
        boosted = not boosted
        btn.Text = boosted and "NITRO: ON" or "NITRO: OFF"
        btn.BackgroundColor3 = boosted and Color3.fromRGB(0,200,0) or Color3.fromRGB(255,80,80)
    end)
end
createGui()

-- Fungsi Boost (dengan batas aman 249)
local function applySafeBoost(root)
    local bv = root:FindFirstChild("ZoroBoostBV") or Instance.new("BodyVelocity")
    bv.Name = "ZoroBoostBV"
    bv.MaxForce = Vector3.new(1e5, 0, 1e5)
    bv.Velocity = root.CFrame.LookVector * 249
    bv.P = 5000
    bv.Parent = root
    task.delay(0.1, function()
        if bv and bv.Parent then
            bv:Destroy()
        end
    end)
end

-- Deteksi tombol W ditekan/dilepas
UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.W then
        keyHeld = true
    end
end)

UIS.InputEnded:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.W then
        keyHeld = false
    end
end)

-- Loop Boost saat GUI ON + Tombol W ditekan
RunService.Heartbeat:Connect(function()
    if boosted and keyHeld then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            applySafeBoost(char.HumanoidRootPart)
        end
    end
end)
