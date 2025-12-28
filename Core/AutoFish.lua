local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "DC PROJECT | Fisch Edition", HidePremium = false, SaveConfig = true, ConfigFolder = "DCProjectConfig"})

-- TAB UTAMA
local MainTab = Window:MakeTab({
	Name = "Auto Farm",
	Icon = "rbxassetid://4483362458",
	PremiumOnly = false
})

MainTab:AddToggle({
	Name = "Auto Fish (Lempar Kail)",
	Default = false,
	Callback = function(Value)
		_G.AutoFish = Value
		while _G.AutoFish do
			task.wait(1)
			-- Logika Cast (Menyesuaikan dengan Remote Event Fisch)
			local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
			if tool then
				tool.Events.Cast:FireServer(100)
			end
		end
	end    
})

-- TAB BLATANT
local BlatantTab = Window:MakeTab({
	Name = "Blatant",
	Icon = "rbxassetid://4483362458",
	PremiumOnly = false
})

BlatantTab:AddButton({
	Name = "Instant Catch (Langsung Dapat)",
	Callback = function()
		-- Langsung memanggil event sukses pancing
		game:GetService("ReplicatedStorage").events.reeling_event:FireServer(100, true)
	end
})

BlatantTab:AddSlider({
	Name = "Speed Hack",
	Min = 16,
	Max = 100,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

-- TAB TELEPORT
local TPTab = Window:MakeTab({
	Name = "Teleport",
	Icon = "rbxassetid://4483362458",
	PremiumOnly = false
})

TPTab:AddDropdown({
	Name = "Pilih Lokasi",
	Default = "Moosewood",
	Options = {"Moosewood", "Roslit", "Terrapin"},
	Callback = function(Value)
		local locs = {
			["Moosewood"] = Vector3.new(380, 18, 250),
			["Roslit"] = Vector3.new(-1500, 15, 600),
			["Terrapin"] = Vector3.new(-100, 10, -1200)
		}
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(locs[Value])
	end
})

OrionLib:Init()

