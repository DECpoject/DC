--==================================================
-- DC PROJECT | FISH IT
-- Single File • Basic • Original
--==================================================

if _G.__DC_FISHIT__ then return end
_G.__DC_FISHIT__ = true

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

--==================================================
-- NOTIFY
--==================================================
local function notify(txt)
    pcall(function()
        StarterGui:SetCore("SendNotification",{
            Title = "DC Project",
            Text = txt,
            Duration = 3
        })
    end)
end

notify("Fish It Loaded")

--==================================================
-- GUI
--==================================================
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "DC_Project_FishIt"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(360,300)
main.Position = UDim2.fromScale(0.5,0.5)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,45)
title.BackgroundTransparency = 1
title.Text = "DC PROJECT | FISH IT"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.new(1,1,1)

local holder = Instance.new("Frame", main)
holder.Position = UDim2.fromOffset(0,50)
holder.Size = UDim2.new(1,0,1,-50)
holder.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", holder)
layout.Padding = UDim.new(0,10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function Button(txt)
    local b = Instance.new("TextButton", holder)
    b.Size = UDim2.fromOffset(300,42)
    b.Text = txt
    b.Font = Enum.Font.GothamBold
    b.TextSize = 15
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    return b
end

--==================================================
-- ANTI STAFF
--==================================================
local AntiStaff = true
local StaffDetected = false

local STAFF_KEYWORDS = {
    "mod","admin","staff","dev","owner"
}

local function isStaff(plr)
    local n = plr.Name:lower()
    local d = (plr.DisplayName or ""):lower()
    for _,k in pairs(STAFF_KEYWORDS) do
        if n:find(k) or d:find(k) then
            return true
        end
    end
end

local function checkStaff()
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and isStaff(p) then
            return p
        end
    end
end

Players.PlayerAdded:Connect(function(p)
    if AntiStaff and isStaff(p) then
        StaffDetected = true
        notify("Staff detected: "..p.Name)
    end
end)

--==================================================
-- AUTO FISH (PERFECT TIMING STYLE)
--==================================================
local AutoFish = false
local FishDelay = 0.25 -- timing aman

task.spawn(function()
    while task.wait(FishDelay) do
        if AutoFish and not StaffDetected then
            pcall(function()
                local char = LocalPlayer.Character
                local tool = char and char:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate()
                end
            end)
        end
    end
end)

--==================================================
-- TELEPORT ALL SPOTS (GENERIC)
--==================================================
local TPIndex = 1
local FishingSpots = {
    CFrame.new(0,15,0),
    CFrame.new(50,15,50),
    CFrame.new(-50,15,-50),
    CFrame.new(100,15,-20),
}

local function TeleportNext()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        TPIndex = TPIndex + 1
        if TPIndex > #FishingSpots then TPIndex = 1 end
        root.CFrame = FishingSpots[TPIndex]
    end
end

--==================================================
-- ESP IKAN (BASIC)
--==================================================
local ESPFish = false

local function ClearESP()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BillboardGui") and v.Name == "DC_FISH_ESP" then
            v:Destroy()
        end
    end
end

local function EnableFishESP()
    ClearESP()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name:lower():find("fish") then
            local part = v:FindFirstChildWhichIsA("BasePart")
            if part then
                local esp = Instance.new("BillboardGui", part)
                esp.Name = "DC_FISH_ESP"
                esp.Size = UDim2.fromOffset(90,28)
                esp.AlwaysOnTop = true

                local txt = Instance.new("TextLabel", esp)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.Text = "FISH"
                txt.TextColor3 = Color3.fromRGB(0,255,255)
                txt.TextScaled = true
            end
        end
    end
end

--==================================================
-- BUTTONS
--==================================================
local b1 = Button("Auto Fish : OFF")
b1.MouseButton1Click:Connect(function()
    AutoFish = not AutoFish
    b1.Text = "Auto Fish : "..(AutoFish and "ON" or "OFF")
end)

local b2 = Button("Teleport Next Spot")
b2.MouseButton1Click:Connect(TeleportNext)

local b3 = Button("ESP Fish : OFF")
b3.MouseButton1Click:Connect(function()
    ESPFish = not ESPFish
    b3.Text = "ESP Fish : "..(ESPFish and "ON" or "OFF")
    if ESPFish then EnableFishESP() else ClearESP() end
end)

local b4 = Button("Anti Staff : ON")
b4.MouseButton1Click:Connect(function()
    AntiStaff = not AntiStaff
    b4.Text = "Anti Staff : "..(AntiStaff and "ON" or "OFF")
end)

local b5 = Button("Close")
b5.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

--==================================================
-- STAFF WATCH LOOP
--==================================================
task.spawn(function()
    while task.wait(2) do
        if AntiStaff and not StaffDetected then
            local p = checkStaff()
            if p then
                StaffDetected = true
                AutoFish = false
                notify("Staff nearby, Auto OFF")
            end
        end
    end
end)

print("[DC Project] Fish It Ready")