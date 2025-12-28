local KavoLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = KavoLib.CreateLib("DC PROJECT | Fisch", "DarkTheme")

-- TAB UTAMA
local Main = Window:NewTab("Auto Farm")
local MainSection = Main:NewSection("Automation")

MainSection:NewToggle("Auto Cast", "Otomatis melempar kail", function(state)
    _G.AutoCast = state
    while _G.AutoCast do
        task.wait(1)
        local character = game.Players.LocalPlayer.Character
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("Events") and tool.Events:FindFirstChild("Cast") then
            tool.Events.Cast:FireServer(100)
        end
    end
end)

MainSection:NewToggle("Auto Shake", "Otomatis klik UI Shake", function(state)
    _G.AutoShake = state
    -- Logika bypass UI Shake Fisch
    game:GetService("RunService").RenderStepped:Connect(function()
        if _G.AutoShake then
            local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            -- Tambahkan logika spesifik UI Shake di sini jika perlu
        end
    end)
end)

-- TAB BLATANT
local Blatant = Window:NewTab("Blatant")
local BlatantSection = Blatant:NewSection("Cheat Fitur")

BlatantSection:NewButton("Instant Catch", "Langsung tarik ikan", function()
    local args = { [1] = 100, [2] = true }
    game:GetService("ReplicatedStorage").events.reeling_event:FireServer(unpack(args))
end)

BlatantSection:NewSlider("Walkspeed", "Atur kecepatan lari", 100, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

-- TAB TELEPORT
local TP = Window:NewTab("Teleport")
local TPSection = TP:NewSection("Pindah Lokasi")

TPSection:NewButton("Moosewood (Main)", "Teleport ke pulau utama", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(380, 18, 250)
end)

TPSection:NewButton("Roslit Bay", "Teleport ke Roslit", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1500, 15, 600)
end)

TPSection:NewButton("Terrapin Island", "Teleport ke Terrapin", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-100, 10, -1200)
end)

-- TAB INFO
local Info = Window:NewTab("Credits")
local InfoSection = Info:NewSection("DC PROJECT")
InfoSection:NewLabel("Developer: DC PROJECT Team")
InfoSection:NewLabel("Status: Updated for Delta")
