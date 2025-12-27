--// DC PROJECT - Fish It
--// Single File | Basic UI | Original
if _G.__DC_PROJECT_FISHIT__ then return end
_G.__DC_PROJECT_FISHIT__ = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

--==============================
-- UI SETUP
--==============================
local CoreGui = game:GetService("CoreGui")
pcall(function()
    CoreGui:FindFirstChild("DC_Project_UI"):Destroy()
end)

local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "DC_Project_UI"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(360, 300)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

--==============================
-- LOGO TEXT
--==============================
local logo = Instance.new("TextLabel", main)
logo.Size = UDim2.new(1, 0, 0, 50)
logo.Position = UDim2.fromOffset(0, 10)
logo.BackgroundTransparency = 1
logo.Text = "DC PROJECT"
logo.Font = Enum.Font.GothamBlack
logo.TextSize = 26
logo.TextColor3 = Color3.fromRGB(90,150,255)
logo.TextStrokeTransparency = 0.85
logo.TextXAlignment = Center

local sub = Instance.new("TextLabel", main)
sub.Size = UDim2.new(1, 0, 0, 20)
sub.Position = UDim2.fromOffset(0, 52)
sub.BackgroundTransparency = 1
sub.Text = "Fish It Script"
sub.Font = Enum.Font.Gotham
sub.TextSize = 14
sub.TextColor3 = Color3.fromRGB(180,180,180)
sub.TextXAlignment = Center

-- Fade anim
logo.TextTransparency = 1
TweenService:Create(
    logo,
    TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    {TextTransparency = 0}
):Play()

--==============================
-- BUTTON HOLDER
--==============================
local holder = Instance.new("Frame", main)
holder.Position = UDim2.fromOffset(0, 85)
holder.Size = UDim2.new(1, 0, 1, -95)
holder.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", holder)
layout.Padding = UDim.new(0, 10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function Button(text, callback)
    local b = Instance.new("TextButton", holder)
    b.Size = UDim2.fromOffset(300, 42)
    b.BackgroundColor3 = Color3.fromRGB(35,35,40)
    b.BorderSizePixel = 0
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 15
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

    b.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
    return b
end

--==============================
-- FEATURES
--==============================
local AutoFish = false
local ESPEnabled = false

-- Auto Fish (generic Fish It)
RunService.Heartbeat:Connect(function()
    if AutoFish then
        -- logic sederhana (aman, generic)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            -- contoh trigger (sesuaikan nanti)
        end
    end
end)

-- ESP Player simple
local ESPFolder = Instance.new("Folder", CoreGui)
ESPFolder.Name = "DC_ESP"

local function ClearESP()
    for _,v in pairs(ESPFolder:GetChildren()) do
        v:Destroy()
    end
end

local function EnableESP()
    ClearESP()
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local h = Instance.new("Highlight", ESPFolder)
            h.Adornee = plr.Character
            h.FillColor = Color3.fromRGB(255, 80, 80)
            h.OutlineColor = Color3.new(1,1,1)
        end
    end
end

Players.PlayerAdded:Connect(function()
    if ESPEnabled then
        task.wait(1)
        EnableESP()
    end
end)

-- Anti Staff (basic)
Players.PlayerAdded:Connect(function(p)
    if p:GetRoleInGroup(0) == "Admin" or p.Name:lower():find("mod") then
        LocalPlayer:Kick("DC Project : Staff detected")
    end
end)

--==============================
-- BUTTONS
--==============================
Button("Auto Fish : OFF", function(self)
    AutoFish = not AutoFish
end)

Button("ESP Player : OFF", function()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        EnableESP()
    else
        ClearESP()
    end
end)

Button("Close UI", function()
    gui:Destroy()
end)

print("[DC PROJECT] Loaded")
