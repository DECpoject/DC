
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "🔥 DC PROJECT | Fish It!", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "DC_Project_FishIt"
})

getgenv().AutoFish = false
getgenv().AutoSell = false
getgenv().AutoBuyCommon = false
getgenv().AutoBuyRare = false
getgenv().InstantReel = false

-- // Tab Utama
local MainTab = Window:MakeTab({
	Name = "Automation",
	Icon = "rbxassetid://4483362458",
	PremiumOnly = false
})

MainTab:AddToggle({
	Name = "Auto Fish",
	Default = false,
	Callback = function(Value)
		getgenv().AutoFish = Value
		task.spawn(function()
			while getgenv().AutoFish do
				local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
				if tool then
					tool:Activate()
				end
				task.wait(0.5)
			end
		end)
	end    
})

MainTab:AddToggle({
	Name = "Instant Reel",
	Default = false,
	Callback = function(Value)
		getgenv().InstantReel = Value
		local reelEvent = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Reel")
		task.spawn(function()
			while getgenv().InstantReel do
				reelEvent:FireServer(100)
				task.wait(0.1)
			end
		end)
	end
})

MainTab:AddToggle({
	Name = "Auto Sell All",
	Default = false,
	Callback = function(Value)
		getgenv().AutoSell = Value
		task.spawn(function()
			while getgenv().AutoSell do
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Sell"):FireServer()
				task.wait(1)
			end
		end)
	end
})

-- // Tab Blatant
local BlatantTab = Window:MakeTab({
	Name = "Blatant",
	Icon = "rbxassetid://4483362458",
	PremiumOnly = false
})

BlatantTab:AddSlider({
	Name = "WalkSpeed",
	Min = 16,
	Max = 500,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

BlatantTab:AddSlider({
	Name = "JumpPower",
	Min = 50,
	Max = 500,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Power",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end    
})

-- // Tab Teleport
local TPTab = Window:MakeTab({
	Name = "Teleport",
	Icon = "rbxassetid://4483362458",
	PremiumOnly = false
})

local locs = {
	["Spawn"] = Vector3.new(0, 10, 0),
	["Sell Station"] = Vector3.new(10, 10, 50),
	["Ocean 1"] = Vector3.new(200, 10, 300),
	["Ocean 2"] = Vector3.new(-500, 10, -400)
}

TPTab:AddDropdown({
	Name = "Select Location",
	Default = "Spawn",
	Options = {"Spawn", "Sell Station", "Ocean 1", "Ocean 2"},
	Callback = function(Value)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(locs[Value])
	end
})

-- // Tab Credits
local CreditsTab = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://4483362458",
	PremiumOnly = false
})

CreditsTab:AddLabel("Script: DC PROJECT")
CreditsTab:AddLabel("Original Script: Chloe-X")
CreditsTab:AddLabel("Converted for Delta Executor")

OrionLib:Init()

