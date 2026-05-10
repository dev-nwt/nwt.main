-- Use it when you batting
-- Discord _real.840hz

_G.Hitbox = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage.RemoteEvents
local SwingBat = RemoteEvents.SwingBat


spawn(function()
	while task.wait() do
		if _G.Hitbox then
			local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
            if PlayerGui then
				local Hitting = PlayerGui:WaitForChild("HittingScreen")
                if Hitting then
					Hitting.Cursor.Size = UDim2.new(0.227, 0, 0.463, 0)
                end
            end
		end
	end
end)

local ToggleUI = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local ToggleButtonHUI = Instance.new("UICorner")

ToggleUI.Name = "ToggleUI"
ToggleUI.Parent = game.CoreGui
ToggleUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ToggleUI
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.BackgroundTransparency = 0.7  -- Make background transparent
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50) -- Size Ui
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.Text = "BROKE"  
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14.000
ToggleButton.Draggable = true

ToggleButtonHUI.Parent = ToggleButton
ToggleButtonHUI.CornerRadius = UDim.new(0, 10)  -- Adjust corner radius if needed

local BackgroundImageHUI = Instance.new("UICorner")
BackgroundImageHUI.CornerRadius = UDim.new(0, 10)  -- Same radius as ToggleButton
BackgroundImageHUI.Parent = BackgroundImage

ToggleButton.MouseButton1Click:Connect(function()
	local Broke1 = {
    	[1] = Vector3.new(-74.8189468383789, 4.751039505004883, 141.5618896484375),
    	[2] = Vector3.new(-77.7666015625, 5123106002807617, 140.12210083007812),
    	[3] = Vector3.new(0.66815185546875, -0.2606945037841797, 0.6904296278953552),
    	[4] = "Power"
	}
	SwingBat:FireServer(unpack(Broke1))
	local Broke2 = {
    	[1] = Vector3.new(-75.5702133178711, 4.751039505004883, 142.31309509277344),
    	[2] = Vector3.new(-78.93708038330078, 5.123106002807617, 139.13116455078125),
    	[3] = Vector3.new(0.66815185546875, -0.2606945037841797, 0.6904296278953552),
    	[4] = "Contact"
	}
	SwingBat:FireServer(unpack(Broke2))
end)
