-- script by zoro

-- Bagian Acceleration
local speedSection = vehiclePage:addSection("Acceleration")
local velocityMult = 0.025
speedSection:addSlider("Multiplier (Thousandths)", 25, 0, 50, function(v) velocityMult = v / 1000 end)
local velocityEnabledKeyCode = Enum.KeyCode.W
speedSection:addKeybind("Velocity Enabled", velocityEnabledKeyCode, function()
    if not velocityEnabled then return end
    -- … existing velocity code …
end, function(v) velocityEnabledKeyCode = v.KeyCode end)

-- Tambahan Nitro Hold
local nitroEnabled = false
local nitroKey = velocityEnabledKeyCode

speedSection:addToggle("Nitro Hold Mode", false, function(v)
    nitroEnabled = v
end)

speedSection:addKeybind("Nitro Key", nitroKey, function(key)
    nitroKey = key.KeyCode
end)

speedSection:addKeybind("Nitro Hold", nitroKey, function()
    if not velocityEnabled then return end
    while UserInputService:IsKeyDown(nitroKey) and nitroEnabled do
        task.wait(0.03)
        local Character = LocalPlayer.Character
        if Character then
            local root = Character:FindFirstChild("HumanoidRootPart")
            if root then
                applySafeBoost(root)
            end
        end
    end
end, function(newKey)
    nitroKey = newKey.KeyCode
end)

-- Body Velocity
function applySafeBoost(root)
    local bv = root:FindFirstChild("ZoroBoostBV") or Instance.new("BodyVelocity")
    bv.Name = "ZoroBoostBV"
    bv.MaxForce = Vector3.new(1e5,0,1e5)
    bv.Velocity = root.CFrame.LookVector * 249
    bv.P = 5000
    bv.Parent = root
    task.delay(0.1, function() if bv.Parent then bv:Destroy() end end)
end
