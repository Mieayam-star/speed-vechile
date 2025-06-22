
-- Safe Vehicle Boost with Nitro Hold by ZoroModsTzy integrated in Venyx UI

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local nitroEnabled = false
local velocityEnabled = true
local velocityMult = 0.025
local velocityEnabledKeyCode = Enum.KeyCode.W
local nitroKey = velocityEnabledKeyCode

-- Function to get vehicle root part (HumanoidRootPart)
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

-- Integration example with Venyx UI
local function addVenyxIntegration(Venyx, vehiclePage, speedSection)
    -- Toggle Nitro Hold Mode
    speedSection:addToggle("Nitro Hold Mode", false, function(v)
        nitroEnabled = v
    end)

    -- Keybind Nitro Key
    speedSection:addKeybind("Nitro Key", nitroKey, function(key)
        nitroKey = key.KeyCode
    end)

    -- Nitro Hold Keybind behavior
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
end

-- The above function should be called after Venyx and speedSection are ready in your main script.
