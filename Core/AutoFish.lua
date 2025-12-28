local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🔥 DC PROJECT | Fisch Edition",
   LoadingTitle = "Executing DC PROJECT...",
   LoadingSubtitle = "by DC PROJECT",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "DC_Project_Data"
   }
})

-- Notification saat berhasil load
Rayfield:Notify({
   Title = "DC PROJECT LOADED",
   Content = "Selamat menggunakan! Gunakan dengan bijak.",
   Duration = 5,
   Image = 4483362458,
})

---
-- TAB: UTAMA (AUTOMATION)
---
local MainTab = Window:CreateTab("Automation", 4483362458)

MainTab:CreateToggle({
   Name = "Auto Cast (Lempar Kail)",
   CurrentValue = false,
   Flag = "AutoCast",
   Callback = function(Value)
      _G.AutoCast = Value
      task.spawn(function()
         while _G.AutoCast do
            local character = game.Players.LocalPlayer.Character
            local tool = character:FindFirstChildOfClass("Tool")
            if tool and tool:TableFind("Cast") then -- Menyesuaikan fungsi pancing
               tool.Events.Cast:FireServer(100) -- Kekuatan lemparan maksimal
            end
            task.wait(1)
         end
      end)
   end,
})

MainTab:CreateToggle({
   Name = "Auto Shake (Otomatis Klik)",
   CurrentValue = false,
   Flag = "AutoShake",
   Callback = function(Value)
      _G.AutoShake = Value
      task.spawn(function()
         while _G.AutoShake do
            -- Mencari UI Shake dan melakukan bypass
            local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            local shakeUI = playerGui:FindFirstChild("ShakeUI") -- Sesuaikan dengan nama UI di Fisch
            if shakeUI then
                -- Logika untuk otomatis klik titik pancing
            end
            task.wait(0.1)
         end
      end)
   end,
})

---
-- TAB: BLATANT (FITUR KERAS)
---
local BlatantTab = Window:CreateTab("Blatant", 4483362458)

BlatantTab:CreateButton({
   Name = "Instant Reel (Langsung Tarik)",
   Callback = function()
      -- Mengirim sinyal ke server bahwa ikan sudah tertangkap sepenuhnya
      local args = { [1] = 100, [2] = true }
      game:GetService("ReplicatedStorage").events.reeling_event:FireServer(unpack(args))
      Rayfield:Notify({Title = "DC PROJECT", Content = "Instant Reel Berhasil!", Duration = 2})
   end,
})

BlatantTab:CreateToggle({
   Name = "WalkSpeed Hack (25)",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
      else
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
      end
   end,
})

---
-- TAB: TELEPORT (DC TRAVEL)
---
local TPTab = Window:CreateTab("Teleport", 4483362458)

local Locations = {
    ["Moosewood (Main)"] = Vector3.new(380, 18, 250),
    ["Roslit Bay"] = Vector3.new(-1500, 15, 600),
    ["Terrapin Island"] = Vector3.new(-100, 10, -1200),
    ["Sunken Ship"] = Vector3.new(2000, -100, 500)
}

TPTab:CreateDropdown({
   Name = "Pilih Lokasi Pancing",
   Options = {"Moosewood (Main)", "Roslit Bay", "Terrapin Island", "Sunken Ship"},
   CurrentOption = {"Moosewood (Main)"},
   MultipleOptions = false,
   Callback = function(Option)
      local target = Locations[Option[1]]
      if target then
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(target)
      end
   end,
})

---
-- TAB: INFO
---
local InfoTab = Window:CreateTab("Info", 4483362458)
InfoTab:CreateLabel("Script Name: DC PROJECT")
InfoTab:CreateLabel("Status: Undetected (Use Alt Account)")
InfoTab:CreateLabel("Support: Delta, Hydrogen, Fluxus")

