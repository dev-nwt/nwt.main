local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local SAVE_FILE = "hitbox_settings.json"

local function saveSettings(data)
	pcall(function()
		if writefile then
			writefile(SAVE_FILE, game:GetService("HttpService"):JSONEncode(data))
		end
	end)
end

local function loadSettings()
	local ok, result = pcall(function()
		if readfile and isfile and isfile(SAVE_FILE) then
			return game:GetService("HttpService"):JSONDecode(readfile(SAVE_FILE))
		end
		return nil
	end)
	if ok and result then return result end
	return nil
end

local savedData = loadSettings()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HitboxChanger"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 260, 0, 180)
mainFrame.Position = UDim2.new(0.5, -130, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(60, 60, 70)
mainStroke.Thickness = 2
mainStroke.Transparency = 0.5
mainStroke.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 12)
titleFix.Position = UDim2.new(0, 0, 1, -12)
titleFix.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
titleFix.BorderSizePixel = 0
titleFix.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -100, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Hitbox Changer & ESP"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 15
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local settingsButtonTop = Instance.new("TextButton")
settingsButtonTop.Name = "SettingsButtonTop"
settingsButtonTop.Size = UDim2.new(0, 26, 0, 26)
settingsButtonTop.Position = UDim2.new(1, -90, 0, 4)
settingsButtonTop.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
settingsButtonTop.BorderSizePixel = 0
settingsButtonTop.Text = "⚙"
settingsButtonTop.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsButtonTop.TextSize = 14
settingsButtonTop.Font = Enum.Font.GothamBold
settingsButtonTop.Parent = titleBar

local settingsTopCorner = Instance.new("UICorner")
settingsTopCorner.CornerRadius = UDim.new(0, 6)
settingsTopCorner.Parent = settingsButtonTop

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 26, 0, 26)
minimizeButton.Position = UDim2.new(1, -58, 0, 4)
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
minimizeButton.TextSize = 14
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = titleBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeButton

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 26, 0, 26)
closeButton.Position = UDim2.new(1, -28, 0, 4)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 13
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -35)
contentFrame.Position = UDim2.new(0, 0, 0, 35)
contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

local sizeLabel = Instance.new("TextLabel")
sizeLabel.Size = UDim2.new(0, 75, 0, 22)
sizeLabel.Position = UDim2.new(0, 12, 0, 8)
sizeLabel.BackgroundTransparency = 1
sizeLabel.Text = "Hitbox Size:"
sizeLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
sizeLabel.TextSize = 12
sizeLabel.Font = Enum.Font.Gotham
sizeLabel.TextXAlignment = Enum.TextXAlignment.Left
sizeLabel.Parent = contentFrame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 80, 0, 28)
textBox.Position = UDim2.new(0, 90, 0, 6)
textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
textBox.BorderSizePixel = 0
textBox.Text = "10"
textBox.PlaceholderText = "Size"
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.TextSize = 12
textBox.Font = Enum.Font.Gotham
textBox.Parent = contentFrame

local textBoxCorner = Instance.new("UICorner")
textBoxCorner.CornerRadius = UDim.new(0, 7)
textBoxCorner.Parent = textBox

local textBoxStroke = Instance.new("UIStroke")
textBoxStroke.Color = Color3.fromRGB(80, 80, 90)
textBoxStroke.Thickness = 1
textBoxStroke.Parent = textBox

local applyButton = Instance.new("TextButton")
applyButton.Size = UDim2.new(0, 50, 0, 28)
applyButton.Position = UDim2.new(0, 178, 0, 6)
applyButton.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
applyButton.BorderSizePixel = 0
applyButton.Text = "Apply"
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextSize = 12
applyButton.Font = Enum.Font.GothamBold
applyButton.Parent = contentFrame

local applyCorner = Instance.new("UICorner")
applyCorner.CornerRadius = UDim.new(0, 7)
applyCorner.Parent = applyButton

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 236, 0, 32)
toggleButton.Position = UDim2.new(0, 12, 0, 42)
toggleButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "Hitbox: OFF"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 13
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = contentFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 7)
toggleCorner.Parent = toggleButton

local espToggleButton = Instance.new("TextButton")
espToggleButton.Size = UDim2.new(0, 236, 0, 32)
espToggleButton.Position = UDim2.new(0, 12, 0, 80)
espToggleButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
espToggleButton.BorderSizePixel = 0
espToggleButton.Text = "ESP: OFF"
espToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espToggleButton.TextSize = 13
espToggleButton.Font = Enum.Font.GothamBold
espToggleButton.Parent = contentFrame

local espToggleCorner = Instance.new("UICorner")
espToggleCorner.CornerRadius = UDim.new(0, 7)
espToggleCorner.Parent = espToggleButton

local footerLabel = Instance.new("TextButton")
footerLabel.Size = UDim2.new(1, 0, 0, 25)
footerLabel.Position = UDim2.new(0, 0, 1, -25)
footerLabel.BackgroundTransparency = 1
footerLabel.Text = "By : romokaso (Modified by 144Hz)"
footerLabel.TextColor3 = Color3.fromRGB(120, 120, 130)
footerLabel.TextSize = 10
footerLabel.Font = Enum.Font.GothamBold
footerLabel.Parent = contentFrame

local footerLabelMinimized = Instance.new("TextButton")
footerLabelMinimized.Size = UDim2.new(1, 0, 0, 25)
footerLabelMinimized.Position = UDim2.new(0, 0, 0, 35)
footerLabelMinimized.BackgroundTransparency = 1
footerLabelMinimized.Text = "By : romokaso (Modified by 144Hz)"
footerLabelMinimized.TextColor3 = Color3.fromRGB(120, 120, 130)
footerLabelMinimized.TextSize = 10
footerLabelMinimized.Font = Enum.Font.GothamBold
footerLabelMinimized.Visible = false
footerLabelMinimized.Parent = mainFrame

local confirmFrame = Instance.new("Frame")
confirmFrame.Name = "ConfirmFrame"
confirmFrame.Size = UDim2.new(1, 0, 1, 0)
confirmFrame.Position = UDim2.new(0, 0, 0, 0)
confirmFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
confirmFrame.BackgroundTransparency = 1
confirmFrame.BorderSizePixel = 0
confirmFrame.Visible = false
confirmFrame.ZIndex = 10
confirmFrame.Parent = mainFrame

local confirmCorner = Instance.new("UICorner")
confirmCorner.CornerRadius = UDim.new(0, 12)
confirmCorner.Parent = confirmFrame

local confirmText = Instance.new("TextLabel")
confirmText.Size = UDim2.new(1, -24, 0, 40)
confirmText.Position = UDim2.new(0, 12, 0, 45)
confirmText.BackgroundTransparency = 1
confirmText.Text = "Are you sure you want\nto close the GUI?"
confirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmText.TextSize = 13
confirmText.Font = Enum.Font.GothamBold
confirmText.TextWrapped = true
confirmText.ZIndex = 11
confirmText.Parent = confirmFrame

local yesButton = Instance.new("TextButton")
yesButton.Size = UDim2.new(0, 105, 0, 32)
yesButton.Position = UDim2.new(0, 20, 0, 100)
yesButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
yesButton.BorderSizePixel = 0
yesButton.Text = "Yes"
yesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
yesButton.TextSize = 13
yesButton.Font = Enum.Font.GothamBold
yesButton.ZIndex = 11
yesButton.Parent = confirmFrame

local yesCorner = Instance.new("UICorner")
yesCorner.CornerRadius = UDim.new(0, 7)
yesCorner.Parent = yesButton

local noButton = Instance.new("TextButton")
noButton.Size = UDim2.new(0, 105, 0, 32)
noButton.Position = UDim2.new(0, 135, 0, 100)
noButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
noButton.BorderSizePixel = 0
noButton.Text = "No"
noButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noButton.TextSize = 13
noButton.Font = Enum.Font.GothamBold
noButton.ZIndex = 11
noButton.Parent = confirmFrame

local noCorner = Instance.new("UICorner")
noCorner.CornerRadius = UDim.new(0, 7)
noCorner.Parent = noButton

local settingsFrame = Instance.new("Frame")
settingsFrame.Name = "SettingsFrame"
settingsFrame.Size = UDim2.new(1, 0, 1, 0)
settingsFrame.Position = UDim2.new(1, 0, 0, 0)
settingsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
settingsFrame.BorderSizePixel = 0
settingsFrame.Visible = false
settingsFrame.ZIndex = 10
settingsFrame.Parent = mainFrame

local settingsFrameCorner = Instance.new("UICorner")
settingsFrameCorner.CornerRadius = UDim.new(0, 12)
settingsFrameCorner.Parent = settingsFrame

local settingsTitleBar = Instance.new("Frame")
settingsTitleBar.Size = UDim2.new(1, 0, 0, 35)
settingsTitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
settingsTitleBar.BorderSizePixel = 0
settingsTitleBar.ZIndex = 11
settingsTitleBar.Parent = settingsFrame

local settingsTitleCorner = Instance.new("UICorner")
settingsTitleCorner.CornerRadius = UDim.new(0, 12)
settingsTitleCorner.Parent = settingsTitleBar

local settingsTitleFix = Instance.new("Frame")
settingsTitleFix.Size = UDim2.new(1, 0, 0, 12)
settingsTitleFix.Position = UDim2.new(0, 0, 1, -12)
settingsTitleFix.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
settingsTitleFix.BorderSizePixel = 0
settingsTitleFix.ZIndex = 11
settingsTitleFix.Parent = settingsTitleBar

local settingsTitleLabel = Instance.new("TextLabel")
settingsTitleLabel.Size = UDim2.new(1, -50, 1, 0)
settingsTitleLabel.Position = UDim2.new(0, 10, 0, 0)
settingsTitleLabel.BackgroundTransparency = 1
settingsTitleLabel.Text = "Settings"
settingsTitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsTitleLabel.TextSize = 15
settingsTitleLabel.Font = Enum.Font.GothamBold
settingsTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
settingsTitleLabel.ZIndex = 11
settingsTitleLabel.Parent = settingsTitleBar

local backButton = Instance.new("TextButton")
backButton.Size = UDim2.new(0, 26, 0, 26)
backButton.Position = UDim2.new(1, -28, 0, 4)
backButton.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
backButton.BorderSizePixel = 0
backButton.Text = "←"
backButton.TextColor3 = Color3.fromRGB(255, 255, 255)
backButton.TextSize = 14
backButton.Font = Enum.Font.GothamBold
backButton.ZIndex = 11
backButton.Parent = settingsTitleBar

local backCorner = Instance.new("UICorner")
backCorner.CornerRadius = UDim.new(0, 6)
backCorner.Parent = backButton

local settingsContentFrame = Instance.new("ScrollingFrame")
settingsContentFrame.Size = UDim2.new(1, 0, 1, -35)
settingsContentFrame.Position = UDim2.new(0, 0, 0, 35)
settingsContentFrame.BackgroundTransparency = 1
settingsContentFrame.BorderSizePixel = 0
settingsContentFrame.ZIndex = 11
settingsContentFrame.ScrollBarThickness = 3
settingsContentFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 150, 255)
settingsContentFrame.CanvasSize = UDim2.new(0, 0, 0, 350)
settingsContentFrame.Parent = settingsFrame

local themeLabel = Instance.new("TextLabel")
themeLabel.Size = UDim2.new(1, -24, 0, 22)
themeLabel.Position = UDim2.new(0, 12, 0, 10)
themeLabel.BackgroundTransparency = 1
themeLabel.Text = "Theme:"
themeLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
themeLabel.TextSize = 13
themeLabel.Font = Enum.Font.GothamBold
themeLabel.TextXAlignment = Enum.TextXAlignment.Left
themeLabel.ZIndex = 11
themeLabel.Parent = settingsContentFrame

local darkButton = Instance.new("TextButton")
darkButton.Size = UDim2.new(0, 110, 0, 32)
darkButton.Position = UDim2.new(0, 12, 0, 36)
darkButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
darkButton.BorderSizePixel = 0
darkButton.Text = "Dark"
darkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
darkButton.TextSize = 13
darkButton.Font = Enum.Font.GothamBold
darkButton.ZIndex = 11
darkButton.Parent = settingsContentFrame

local darkCorner = Instance.new("UICorner")
darkCorner.CornerRadius = UDim.new(0, 7)
darkCorner.Parent = darkButton

local darkStroke = Instance.new("UIStroke")
darkStroke.Color = Color3.fromRGB(80, 150, 255)
darkStroke.Thickness = 3
darkStroke.ZIndex = 11
darkStroke.Parent = darkButton

local lightButton = Instance.new("TextButton")
lightButton.Size = UDim2.new(0, 110, 0, 32)
lightButton.Position = UDim2.new(0, 138, 0, 36)
lightButton.BackgroundColor3 = Color3.fromRGB(240, 240, 250)
lightButton.BorderSizePixel = 0
lightButton.Text = "Light"
lightButton.TextColor3 = Color3.fromRGB(30, 30, 40)
lightButton.TextSize = 13
lightButton.Font = Enum.Font.GothamBold
lightButton.ZIndex = 11
lightButton.Parent = settingsContentFrame

local lightCorner = Instance.new("UICorner")
lightCorner.CornerRadius = UDim.new(0, 7)
lightCorner.Parent = lightButton

local transparencyLabel = Instance.new("TextLabel")
transparencyLabel.Size = UDim2.new(0, 150, 0, 22)
transparencyLabel.Position = UDim2.new(0, 12, 0, 78)
transparencyLabel.BackgroundTransparency = 1
transparencyLabel.Text = "Disable Transparency:"
transparencyLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
transparencyLabel.TextSize = 13
transparencyLabel.Font = Enum.Font.GothamBold
transparencyLabel.TextXAlignment = Enum.TextXAlignment.Left
transparencyLabel.ZIndex = 11
transparencyLabel.Parent = settingsContentFrame

local disableTransparencyButton = Instance.new("TextButton")
disableTransparencyButton.Size = UDim2.new(0, 60, 0, 28)
disableTransparencyButton.Position = UDim2.new(0, 178, 0, 76)
disableTransparencyButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
disableTransparencyButton.BorderSizePixel = 0
disableTransparencyButton.Text = "OFF"
disableTransparencyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
disableTransparencyButton.TextSize = 13
disableTransparencyButton.Font = Enum.Font.GothamBold
disableTransparencyButton.ZIndex = 11
disableTransparencyButton.Parent = settingsContentFrame

local disableTransparencyCorner = Instance.new("UICorner")
disableTransparencyCorner.CornerRadius = UDim.new(0, 7)
disableTransparencyCorner.Parent = disableTransparencyButton

local keybindSectionLabel = Instance.new("TextLabel")
keybindSectionLabel.Size = UDim2.new(1, -24, 0, 22)
keybindSectionLabel.Position = UDim2.new(0, 12, 0, 116)
keybindSectionLabel.BackgroundTransparency = 1
keybindSectionLabel.Text = "Keybinds:"
keybindSectionLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
keybindSectionLabel.TextSize = 13
keybindSectionLabel.Font = Enum.Font.GothamBold
keybindSectionLabel.TextXAlignment = Enum.TextXAlignment.Left
keybindSectionLabel.ZIndex = 11
keybindSectionLabel.Parent = settingsContentFrame

local function makeKeybindRow(labelText, yPos)
	local rowLabel = Instance.new("TextLabel")
	rowLabel.Size = UDim2.new(0, 130, 0, 28)
	rowLabel.Position = UDim2.new(0, 12, 0, yPos)
	rowLabel.BackgroundTransparency = 1
	rowLabel.Text = labelText
	rowLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
	rowLabel.TextSize = 12
	rowLabel.Font = Enum.Font.Gotham
	rowLabel.TextXAlignment = Enum.TextXAlignment.Left
	rowLabel.ZIndex = 11
	rowLabel.Parent = settingsContentFrame

	local rowButton = Instance.new("TextButton")
	rowButton.Size = UDim2.new(0, 90, 0, 28)
	rowButton.Position = UDim2.new(0, 152, 0, yPos)
	rowButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
	rowButton.BorderSizePixel = 0
	rowButton.Text = "None"
	rowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	rowButton.TextSize = 12
	rowButton.Font = Enum.Font.GothamBold
	rowButton.ZIndex = 11
	rowButton.Parent = settingsContentFrame

	local rowCorner = Instance.new("UICorner")
	rowCorner.CornerRadius = UDim.new(0, 7)
	rowCorner.Parent = rowButton

	local rowStroke = Instance.new("UIStroke")
	rowStroke.Color = Color3.fromRGB(80, 80, 100)
	rowStroke.Thickness = 1
	rowStroke.ZIndex = 11
	rowStroke.Parent = rowButton

	return rowLabel, rowButton, rowStroke
end

local keybindHitboxLabel, keybindHitboxButton, keybindHitboxStroke = makeKeybindRow("Toggle Hitbox:", 142)
local keybindEspLabel, keybindEspButton, keybindEspStroke = makeKeybindRow("Toggle ESP:", 178)
local keybindGuiLabel, keybindGuiButton, keybindGuiStroke = makeKeybindRow("Toggle GUI:", 214)
local keybindMinimizeLabel, keybindMinimizeButton, keybindMinimizeStroke = makeKeybindRow("Minimize:", 250)
local keybindApplyLabel, keybindApplyButton, keybindApplyStroke = makeKeybindRow("Apply Hitbox:", 286)

local hitboxSize = 10
local isEnabled = false
local isMinimized = false
local currentTheme = "dark"
local isDragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil
local espEnabled = false
local espData = {}
local lastAnimTime = 0
local animCooldown = 0.15
local disableTransparency = false
local characterConnections = {}
local originalData = {}
local guiVisible = true
local modifiedChars = {}

local keybinds = {
	hitbox = nil,
	esp = nil,
	gui = nil,
	minimize = nil,
	apply = nil,
}

local listeningFor = nil

local keybindButtons = {
	hitbox = keybindHitboxButton,
	esp = keybindEspButton,
	gui = keybindGuiButton,
	minimize = keybindMinimizeButton,
	apply = keybindApplyButton,
}

local keybindStrokes = {
	hitbox = keybindHitboxStroke,
	esp = keybindEspStroke,
	gui = keybindGuiStroke,
	minimize = keybindMinimizeStroke,
	apply = keybindApplyStroke,
}

local keybindLabels = {
	hitbox = keybindHitboxLabel,
	esp = keybindEspLabel,
	gui = keybindGuiLabel,
	minimize = keybindMinimizeLabel,
	apply = keybindApplyLabel,
}

local hitboxPartNames = {
	"HumanoidRootPart", "Head", "Torso",
	"Left Arm", "Right Arm", "Left Leg", "Right Leg",
	"UpperTorso", "LowerTorso",
	"LeftUpperArm", "LeftLowerArm", "LeftHand",
	"RightUpperArm", "RightLowerArm", "RightHand",
	"LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
	"RightUpperLeg", "RightLowerLeg", "RightFoot"
}

local function getKeyName(keyCode)
	if keyCode == nil then return "None" end
	return keyCode.Name
end

local function collectAndSave()
	local data = {
		hitboxSize = hitboxSize,
		theme = currentTheme,
		disableTransparency = disableTransparency,
		keybinds = {}
	}
	for action, kc in pairs(keybinds) do
		data.keybinds[action] = kc ~= nil and kc.Name or "None"
	end
	saveSettings(data)
end

local function setListening(actionName)
	if listeningFor then
		local prevBtn = keybindButtons[listeningFor]
		local prevStroke = keybindStrokes[listeningFor]
		if prevBtn and prevBtn.Parent then
			prevBtn.Text = getKeyName(keybinds[listeningFor])
			TweenService:Create(prevStroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(80, 80, 100)}):Play()
			TweenService:Create(prevBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(40, 40, 55)}):Play()
		end
	end
	listeningFor = actionName
	if actionName then
		local btn = keybindButtons[actionName]
		local stroke = keybindStrokes[actionName]
		if btn and btn.Parent then
			btn.Text = "Press key..."
			TweenService:Create(stroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(80, 150, 255)}):Play()
			TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30, 50, 80)}):Play()
		end
	end
end

local function applyKeybind(actionName, keyCode)
	keybinds[actionName] = keyCode
	local btn = keybindButtons[actionName]
	local stroke = keybindStrokes[actionName]
	if btn and btn.Parent then
		btn.Text = getKeyName(keyCode)
		TweenService:Create(stroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(80, 80, 100)}):Play()
		TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(40, 40, 55)}):Play()
	end
	collectAndSave()
end

for actionName, btn in pairs(keybindButtons) do
	local capturedAction = actionName
	btn.MouseButton1Click:Connect(function()
		if listeningFor == capturedAction then
			setListening(nil)
		else
			setListening(capturedAction)
		end
	end)
	btn.MouseEnter:Connect(function()
		if listeningFor ~= capturedAction then
			TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(55, 55, 75)}):Play()
		end
	end)
	btn.MouseLeave:Connect(function()
		if listeningFor ~= capturedAction then
			TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(40, 40, 55)}):Play()
		end
	end)
end

local function getTeamColor(targetPlayer)
	if targetPlayer and targetPlayer.Team then
		return targetPlayer.TeamColor.Color
	end
	return Color3.fromRGB(255, 255, 255)
end

local function animateButton(button)
	local currentTime = tick()
	if currentTime - lastAnimTime < animCooldown then return end
	lastAnimTime = currentTime
	local originalSize = button.Size
	local tweenInfo = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local growTween = TweenService:Create(button, tweenInfo, {
		Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset + 4, originalSize.Y.Scale, originalSize.Y.Offset + 4)
	})
	growTween:Play()
	growTween.Completed:Connect(function()
		if button and button.Parent then
			TweenService:Create(button, tweenInfo, {Size = originalSize}):Play()
		end
	end)
end

local function applyTheme(theme)
	currentTheme = theme
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	if theme == "light" then
		TweenService:Create(mainFrame, tweenInfo, {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		TweenService:Create(contentFrame, tweenInfo, {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		TweenService:Create(mainStroke, tweenInfo, {Color = Color3.fromRGB(200, 200, 210)}):Play()
		TweenService:Create(titleBar, tweenInfo, {BackgroundColor3 = Color3.fromRGB(245, 245, 250)}):Play()
		TweenService:Create(titleFix, tweenInfo, {BackgroundColor3 = Color3.fromRGB(245, 245, 250)}):Play()
		TweenService:Create(titleLabel, tweenInfo, {TextColor3 = Color3.fromRGB(30, 30, 40)}):Play()
		TweenService:Create(sizeLabel, tweenInfo, {TextColor3 = Color3.fromRGB(60, 60, 70)}):Play()
		TweenService:Create(textBox, tweenInfo, {BackgroundColor3 = Color3.fromRGB(235, 235, 245), TextColor3 = Color3.fromRGB(30, 30, 40)}):Play()
		TweenService:Create(textBoxStroke, tweenInfo, {Color = Color3.fromRGB(200, 200, 210)}):Play()
		TweenService:Create(footerLabel, tweenInfo, {TextColor3 = Color3.fromRGB(100, 100, 110)}):Play()
		TweenService:Create(footerLabelMinimized, tweenInfo, {TextColor3 = Color3.fromRGB(100, 100, 110)}):Play()
		TweenService:Create(confirmFrame, tweenInfo, {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		TweenService:Create(confirmText, tweenInfo, {TextColor3 = Color3.fromRGB(30, 30, 40)}):Play()
		TweenService:Create(settingsFrame, tweenInfo, {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		TweenService:Create(settingsTitleBar, tweenInfo, {BackgroundColor3 = Color3.fromRGB(245, 245, 250)}):Play()
		TweenService:Create(settingsTitleFix, tweenInfo, {BackgroundColor3 = Color3.fromRGB(245, 245, 250)}):Play()
		TweenService:Create(settingsTitleLabel, tweenInfo, {TextColor3 = Color3.fromRGB(30, 30, 40)}):Play()
		TweenService:Create(themeLabel, tweenInfo, {TextColor3 = Color3.fromRGB(60, 60, 70)}):Play()
		TweenService:Create(transparencyLabel, tweenInfo, {TextColor3 = Color3.fromRGB(60, 60, 70)}):Play()
		TweenService:Create(keybindSectionLabel, tweenInfo, {TextColor3 = Color3.fromRGB(60, 60, 70)}):Play()
		TweenService:Create(settingsButtonTop, tweenInfo, {BackgroundColor3 = Color3.fromRGB(200, 200, 220), TextColor3 = Color3.fromRGB(30, 30, 40)}):Play()
		TweenService:Create(darkStroke, tweenInfo, {Color = Color3.fromRGB(200, 200, 210)}):Play()
		for _, lbl in pairs(keybindLabels) do
			TweenService:Create(lbl, tweenInfo, {TextColor3 = Color3.fromRGB(80, 80, 90)}):Play()
		end
		local lightStroke = lightButton:FindFirstChild("UIStroke")
		if not lightStroke then
			lightStroke = Instance.new("UIStroke")
			lightStroke.Color = Color3.fromRGB(80, 150, 255)
			lightStroke.Thickness = 3
			lightStroke.Transparency = 1
			lightStroke.ZIndex = 11
			lightStroke.Parent = lightButton
		end
		TweenService:Create(lightStroke, tweenInfo, {Transparency = 0}):Play()
	else
		TweenService:Create(mainFrame, tweenInfo, {BackgroundColor3 = Color3.fromRGB(20, 20, 25)}):Play()
		TweenService:Create(contentFrame, tweenInfo, {BackgroundColor3 = Color3.fromRGB(20, 20, 25)}):Play()
		TweenService:Create(mainStroke, tweenInfo, {Color = Color3.fromRGB(60, 60, 70)}):Play()
		TweenService:Create(titleBar, tweenInfo, {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
		TweenService:Create(titleFix, tweenInfo, {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
		TweenService:Create(titleLabel, tweenInfo, {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		TweenService:Create(sizeLabel, tweenInfo, {TextColor3 = Color3.fromRGB(200, 200, 210)}):Play()
		TweenService:Create(textBox, tweenInfo, {BackgroundColor3 = Color3.fromRGB(40, 40, 50), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		TweenService:Create(textBoxStroke, tweenInfo, {Color = Color3.fromRGB(80, 80, 90)}):Play()
		TweenService:Create(footerLabel, tweenInfo, {TextColor3 = Color3.fromRGB(120, 120, 130)}):Play()
		TweenService:Create(footerLabelMinimized, tweenInfo, {TextColor3 = Color3.fromRGB(120, 120, 130)}):Play()
		TweenService:Create(confirmFrame, tweenInfo, {BackgroundColor3 = Color3.fromRGB(15, 15, 20)}):Play()
		TweenService:Create(confirmText, tweenInfo, {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		TweenService:Create(settingsFrame, tweenInfo, {BackgroundColor3 = Color3.fromRGB(20, 20, 25)}):Play()
		TweenService:Create(settingsTitleBar, tweenInfo, {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
		TweenService:Create(settingsTitleFix, tweenInfo, {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
		TweenService:Create(settingsTitleLabel, tweenInfo, {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		TweenService:Create(themeLabel, tweenInfo, {TextColor3 = Color3.fromRGB(200, 200, 210)}):Play()
		TweenService:Create(transparencyLabel, tweenInfo, {TextColor3 = Color3.fromRGB(200, 200, 210)}):Play()
		TweenService:Create(keybindSectionLabel, tweenInfo, {TextColor3 = Color3.fromRGB(200, 200, 210)}):Play()
		TweenService:Create(settingsButtonTop, tweenInfo, {BackgroundColor3 = Color3.fromRGB(100, 100, 120), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		for _, lbl in pairs(keybindLabels) do
			TweenService:Create(lbl, tweenInfo, {TextColor3 = Color3.fromRGB(180, 180, 190)}):Play()
		end
		local lightStroke = lightButton:FindFirstChild("UIStroke")
		if lightStroke then
			TweenService:Create(lightStroke, tweenInfo, {Transparency = 1}):Play()
			task.delay(0.15, function()
				if lightStroke and lightStroke.Parent then lightStroke:Destroy() end
			end)
		end
		TweenService:Create(darkStroke, tweenInfo, {Color = Color3.fromRGB(80, 150, 255)}):Play()
	end
	collectAndSave()
end

local function removeESP(targetPlayer)
	if espData[targetPlayer] then
		if espData[targetPlayer].gui and espData[targetPlayer].gui.Parent then
			espData[targetPlayer].gui:Destroy()
		end
		if espData[targetPlayer].highlight and espData[targetPlayer].highlight.Parent then
			espData[targetPlayer].highlight:Destroy()
		end
		espData[targetPlayer] = nil
	end
end

local function createESP(targetPlayer)
	if targetPlayer == player then return end
	removeESP(targetPlayer)
	local char = targetPlayer.Character
	if not char then return end
	local head = char:FindFirstChild("Head")
	local hrpPart = char:FindFirstChild("HumanoidRootPart")
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if not (head or hrpPart) then return end
	if humanoid and humanoid.Health <= 0 then return end
	local attachPart = head or hrpPart
	local teamColor = getTeamColor(targetPlayer)
	local hasDisplayName = string.lower(targetPlayer.DisplayName) ~= string.lower(targetPlayer.Name)
	local guiHeight = hasDisplayName and 36 or 20
	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Name = "ESP_" .. targetPlayer.Name
	billboardGui.AlwaysOnTop = true
	billboardGui.Size = UDim2.new(0, 300, 0, guiHeight)
	billboardGui.StudsOffset = Vector3.new(0, 3.2, 0)
	billboardGui.Parent = attachPart
	if hasDisplayName then
		local displayLabel = Instance.new("TextLabel")
		displayLabel.Name = "DisplayLabel"
		displayLabel.Size = UDim2.new(1, 0, 0, 16)
		displayLabel.Position = UDim2.new(0, 0, 0, 0)
		displayLabel.BackgroundTransparency = 1
		displayLabel.TextColor3 = teamColor
		displayLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		displayLabel.TextStrokeTransparency = 0.3
		displayLabel.TextSize = 14
		displayLabel.Font = Enum.Font.GothamBold
		displayLabel.Text = targetPlayer.DisplayName
		displayLabel.TextXAlignment = Enum.TextXAlignment.Center
		displayLabel.Parent = billboardGui
		local infoLabel = Instance.new("TextLabel")
		infoLabel.Name = "InfoLabel"
		infoLabel.Size = UDim2.new(1, 0, 0, 16)
		infoLabel.Position = UDim2.new(0, 0, 0, 18)
		infoLabel.BackgroundTransparency = 1
		infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
		infoLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		infoLabel.TextStrokeTransparency = 0.3
		infoLabel.TextSize = 11
		infoLabel.Font = Enum.Font.Gotham
		infoLabel.Text = ""
		infoLabel.TextXAlignment = Enum.TextXAlignment.Center
		infoLabel.Parent = billboardGui
		espData[targetPlayer] = {gui = billboardGui, displayLabel = displayLabel, infoLabel = infoLabel, highlight = nil, hasDisplayName = true}
	else
		local textLabel = Instance.new("TextLabel")
		textLabel.Name = "InfoLabel"
		textLabel.Size = UDim2.new(1, 0, 1, 0)
		textLabel.BackgroundTransparency = 1
		textLabel.TextColor3 = teamColor
		textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		textLabel.TextStrokeTransparency = 0.3
		textLabel.TextSize = 13
		textLabel.Font = Enum.Font.GothamBold
		textLabel.Text = ""
		textLabel.TextXAlignment = Enum.TextXAlignment.Center
		textLabel.Parent = billboardGui
		espData[targetPlayer] = {gui = billboardGui, displayLabel = nil, infoLabel = textLabel, highlight = nil, hasDisplayName = false}
	end
	local highlight = Instance.new("Highlight")
	highlight.Name = "ESPHighlight_" .. targetPlayer.Name
	highlight.Adornee = char
	highlight.FillColor = teamColor
	highlight.OutlineColor = teamColor
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 0
	highlight.Parent = char
	espData[targetPlayer].highlight = highlight
end

local function updateESP()
	if not espEnabled then return end
	for _, targetPlayer in pairs(Players:GetPlayers()) do
		if targetPlayer ~= player then
			local char = targetPlayer.Character
			if char and (char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")) then
				local humanoid = char:FindFirstChildOfClass("Humanoid")
				if humanoid and humanoid.Health <= 0 then
					removeESP(targetPlayer)
				else
					local needsRecreate = false
					if not espData[targetPlayer] then
						needsRecreate = true
					elseif not espData[targetPlayer].gui or not espData[targetPlayer].gui.Parent then
						needsRecreate = true
					elseif not espData[targetPlayer].highlight or not espData[targetPlayer].highlight.Parent then
						needsRecreate = true
					end
					if needsRecreate then createESP(targetPlayer) end
					local data = espData[targetPlayer]
					if data and data.infoLabel then
						local teamColor = getTeamColor(targetPlayer)
						local myHrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
						local targetHrp = char:FindFirstChild("HumanoidRootPart")
						local studsText = "?"
						if myHrp and targetHrp then
							studsText = tostring(math.floor((myHrp.Position - targetHrp.Position).Magnitude))
						end
						local hpText = ""
						if humanoid then
							hpText = math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth) .. " HP"
						end
						if data.hasDisplayName then
							if data.displayLabel then data.displayLabel.TextColor3 = teamColor end
							data.infoLabel.Text = studsText .. " studs | @" .. targetPlayer.Name .. " | " .. hpText
						else
							data.infoLabel.Text = studsText .. " studs | " .. targetPlayer.Name .. " | " .. hpText
							data.infoLabel.TextColor3 = teamColor
						end
						if data.highlight then
							data.highlight.FillColor = teamColor
							data.highlight.OutlineColor = teamColor
						end
					end
				end
			else
				removeESP(targetPlayer)
			end
		end
	end
	local toClean = {}
	for targetPlayer in pairs(espData) do
		if not targetPlayer or not targetPlayer.Parent then
			table.insert(toClean, targetPlayer)
		end
	end
	for _, targetPlayer in pairs(toClean) do
		removeESP(targetPlayer)
	end
end

local function saveOriginalData(char)
	if not char then return end
	if originalData[char] then return end
	local data = {}
	local valid = false
	for _, child in pairs(char:GetChildren()) do
		if child:IsA("BasePart") then
			data[child.Name] = {
				Size = child.Size,
				Transparency = child.Transparency,
				CanCollide = child.CanCollide,
				Color = child.Color,
				Material = child.Material,
				CastShadow = child.CastShadow,
			}
			valid = true
		end
	end
	if valid then
		originalData[char] = data
	end
end

local function restoreOriginalData(char)
	if not char or not char.Parent then return end
	local saved = originalData[char]
	if not saved then return end
	for partName, data in pairs(saved) do
		local part = char:FindFirstChild(partName)
		if part and part:IsA("BasePart") then
			part.Size = data.Size
			part.Transparency = data.Transparency
			part.CanCollide = data.CanCollide
			part.Color = data.Color
			part.Material = data.Material
			part.CastShadow = data.CastShadow
		end
	end
	originalData[char] = nil
	modifiedChars[char] = nil
end

local function forceRestoreAllHitboxes()
	for _, v in pairs(Players:GetPlayers()) do
		if v ~= player and v.Character then
			local char = v.Character
			if originalData[char] then
				restoreOriginalData(char)
			else
				for _, partName in pairs(hitboxPartNames) do
					local part = char:FindFirstChild(partName)
					if part and part:IsA("BasePart") then
						local humanoidDesc = v:FindFirstChildOfClass("HumanoidDescription")
						part.CanCollide = false
						if partName == "HumanoidRootPart" then
							part.Transparency = 1
						end
					end
				end
			end
		end
	end
	local toClean = {}
	for char in pairs(originalData) do
		table.insert(toClean, char)
	end
	for _, char in pairs(toClean) do
		originalData[char] = nil
	end
	local toClean2 = {}
	for char in pairs(modifiedChars) do
		table.insert(toClean2, char)
	end
	for _, char in pairs(toClean2) do
		modifiedChars[char] = nil
	end
end

local function updateHitboxes()
	if not isEnabled then return end
	for _, v in pairs(Players:GetPlayers()) do
		if v ~= player and v.Character then
			local char = v.Character
			if not char.Parent then continue end
			local humanoid = char:FindFirstChildOfClass("Humanoid")
			if not humanoid or humanoid.Health <= 0 then continue end
			if not originalData[char] then
				saveOriginalData(char)
			end
			if not originalData[char] then continue end
			modifiedChars[char] = v
			local teamColor = getTeamColor(v)
			for _, partName in pairs(hitboxPartNames) do
				local part = char:FindFirstChild(partName)
				if part and part:IsA("BasePart") then
					if partName == "HumanoidRootPart" then
						part.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
						part.Transparency = 1
						part.CanCollide = false
					elseif partName == "Head" then
						part.Size = Vector3.new(hitboxSize * 0.8, hitboxSize * 0.8, hitboxSize * 0.8)
						part.CanCollide = false
						part.Color = teamColor
						part.Transparency = disableTransparency and 1 or 0.3
					else
						part.Size = Vector3.new(hitboxSize * 0.7, hitboxSize * 0.7, hitboxSize * 0.7)
						part.CanCollide = false
						part.Color = teamColor
						part.Transparency = disableTransparency and 1 or 0.3
					end
				end
			end
		end
	end
	local toClean = {}
	for char in pairs(originalData) do
		if not char or not char.Parent then
			table.insert(toClean, char)
		end
	end
	for _, char in pairs(toClean) do
		originalData[char] = nil
		modifiedChars[char] = nil
	end
end

local function resetHitboxes()
	for _, v in pairs(Players:GetPlayers()) do
		if v ~= player and v.Character then
			restoreOriginalData(v.Character)
		end
	end
	local toClean = {}
	for char in pairs(originalData) do
		table.insert(toClean, char)
	end
	for _, char in pairs(toClean) do
		originalData[char] = nil
		modifiedChars[char] = nil
	end
end

local function doApplyHitbox()
	local inputValue = tonumber(textBox.Text)
	if inputValue then
		hitboxSize = math.max(1, inputValue)
		textBox.Text = tostring(hitboxSize)
		if isEnabled then
			updateHitboxes()
		end
		collectAndSave()
		animateButton(applyButton)
		TweenService:Create(applyButton, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(50, 220, 120)}):Play()
		task.delay(0.25, function()
			if applyButton and applyButton.Parent then
				TweenService:Create(applyButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(80, 150, 255)}):Play()
			end
		end)
	else
		TweenService:Create(textBoxStroke, TweenInfo.new(0.08), {Color = Color3.fromRGB(220, 50, 50)}):Play()
		task.delay(0.4, function()
			if textBoxStroke and textBoxStroke.Parent then
				local col = currentTheme == "light" and Color3.fromRGB(200, 200, 210) or Color3.fromRGB(80, 80, 90)
				TweenService:Create(textBoxStroke, TweenInfo.new(0.1), {Color = col}):Play()
			end
		end)
	end
end

local function doMinimize()
	if confirmFrame.Visible or settingsFrame.Visible then return end
	isMinimized = not isMinimized
	if isMinimized then
		TweenService:Create(mainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 260, 0, 60)}):Play()
		contentFrame.Visible = false
		footerLabel.Visible = false
		footerLabelMinimized.Visible = true
	else
		TweenService:Create(mainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 260, 0, 180)}):Play()
		contentFrame.Visible = true
		footerLabel.Visible = true
		footerLabelMinimized.Visible = false
	end
end

local function doToggleHitbox()
	isEnabled = not isEnabled
	if isEnabled then
		TweenService:Create(toggleButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(50, 200, 100)}):Play()
		toggleButton.Text = "Hitbox: ON"
		updateHitboxes()
	else
		TweenService:Create(toggleButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
		toggleButton.Text = "Hitbox: OFF"
		resetHitboxes()
	end
end

local function doToggleESP()
	espEnabled = not espEnabled
	if espEnabled then
		TweenService:Create(espToggleButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(50, 200, 100)}):Play()
		espToggleButton.Text = "ESP: ON"
		for _, v in pairs(Players:GetPlayers()) do
			if v ~= player then createESP(v) end
		end
	else
		TweenService:Create(espToggleButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
		espToggleButton.Text = "ESP: OFF"
		local playersToRemove = {}
		for targetPlayer in pairs(espData) do
			table.insert(playersToRemove, targetPlayer)
		end
		for _, targetPlayer in pairs(playersToRemove) do
			removeESP(targetPlayer)
		end
	end
end

local function doToggleGui()
	guiVisible = not guiVisible
	mainFrame.Visible = guiVisible
end

local function setupCharacterAdded(targetPlayer)
	if characterConnections[targetPlayer] then
		characterConnections[targetPlayer]:Disconnect()
		characterConnections[targetPlayer] = nil
	end
	characterConnections[targetPlayer] = targetPlayer.CharacterAdded:Connect(function(char)
		originalData[char] = nil
		modifiedChars[char] = nil
		task.wait(0.5)
		if not char or not char.Parent then return end
		if isEnabled then
			saveOriginalData(char)
			updateHitboxes()
		end
		if espEnabled then
			createESP(targetPlayer)
		end
	end)
end

local function applyLoadedSettings()
	if not savedData then return end
	if savedData.hitboxSize then
		hitboxSize = math.max(1, savedData.hitboxSize)
		textBox.Text = tostring(hitboxSize)
	end
	if savedData.disableTransparency ~= nil then
		disableTransparency = savedData.disableTransparency
		if disableTransparency then
			disableTransparencyButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
			disableTransparencyButton.Text = "ON"
		else
			disableTransparencyButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
			disableTransparencyButton.Text = "OFF"
		end
	end
	if savedData.keybinds then
		for action, keyName in pairs(savedData.keybinds) do
			if keyName and keyName ~= "None" then
				local ok, kc = pcall(function()
					return Enum.KeyCode[keyName]
				end)
				if ok and kc then
					keybinds[action] = kc
					if keybindButtons[action] then
						keybindButtons[action].Text = keyName
					end
				end
			end
		end
	end
	if savedData.theme then
		applyTheme(savedData.theme)
	end
end

for _, v in pairs(Players:GetPlayers()) do
	if v ~= player then
		setupCharacterAdded(v)
	end
end

Players.PlayerAdded:Connect(function(newPlayer)
	setupCharacterAdded(newPlayer)
	task.wait(1)
	if isEnabled then updateHitboxes() end
	if espEnabled then createESP(newPlayer) end
end)

Players.PlayerRemoving:Connect(function(removedPlayer)
	removeESP(removedPlayer)
	if characterConnections[removedPlayer] then
		characterConnections[removedPlayer]:Disconnect()
		characterConnections[removedPlayer] = nil
	end
	if removedPlayer.Character then
		originalData[removedPlayer.Character] = nil
		modifiedChars[removedPlayer.Character] = nil
	end
end)

applyButton.MouseButton1Click:Connect(function()
	doApplyHitbox()
end)

toggleButton.MouseButton1Click:Connect(function()
	animateButton(toggleButton)
	doToggleHitbox()
end)

espToggleButton.MouseButton1Click:Connect(function()
	animateButton(espToggleButton)
	doToggleESP()
end)

disableTransparencyButton.MouseButton1Click:Connect(function()
	animateButton(disableTransparencyButton)
	disableTransparency = not disableTransparency
	if disableTransparency then
		TweenService:Create(disableTransparencyButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(50, 200, 100)}):Play()
		disableTransparencyButton.Text = "ON"
	else
		TweenService:Create(disableTransparencyButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
		disableTransparencyButton.Text = "OFF"
	end
	if isEnabled then updateHitboxes() end
	collectAndSave()
end)

minimizeButton.MouseButton1Click:Connect(function()
	animateButton(minimizeButton)
	doMinimize()
end)

closeButton.MouseButton1Click:Connect(function()
	if confirmFrame.Visible or settingsFrame.Visible then return end
	animateButton(closeButton)
	if isMinimized then
		isMinimized = false
		TweenService:Create(mainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 260, 0, 180)}):Play()
		contentFrame.Visible = true
		footerLabel.Visible = true
		footerLabelMinimized.Visible = false
		task.wait(0.1)
	end
	confirmFrame.Visible = true
	TweenService:Create(confirmFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.05}):Play()
end)

yesButton.MouseButton1Click:Connect(function()
	animateButton(yesButton)
	isEnabled = false
	espEnabled = false
	forceRestoreAllHitboxes()
	local playersToRemove = {}
	for targetPlayer in pairs(espData) do
		table.insert(playersToRemove, targetPlayer)
	end
	for _, targetPlayer in pairs(playersToRemove) do
		removeESP(targetPlayer)
	end
	for _, conn in pairs(characterConnections) do
		conn:Disconnect()
	end
	characterConnections = {}
	originalData = {}
	modifiedChars = {}
	TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(
			mainFrame.Position.X.Scale,
			mainFrame.Position.X.Offset + 130,
			mainFrame.Position.Y.Scale,
			mainFrame.Position.Y.Offset + 90
		)
	}):Play()
	task.wait(0.3)
	screenGui:Destroy()
end)

noButton.MouseButton1Click:Connect(function()
	animateButton(noButton)
	TweenService:Create(confirmFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
	task.wait(0.1)
	confirmFrame.Visible = false
end)

settingsButtonTop.MouseButton1Click:Connect(function()
	if confirmFrame.Visible or settingsFrame.Visible then return end
	animateButton(settingsButtonTop)
	if isMinimized then
		isMinimized = false
		TweenService:Create(mainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 260, 0, 180)}):Play()
		contentFrame.Visible = true
		footerLabel.Visible = true
		footerLabelMinimized.Visible = false
		task.wait(0.1)
	end
	settingsFrame.Visible = true
	settingsFrame.Position = UDim2.new(1, 0, 0, 0)
	TweenService:Create(settingsFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
end)

backButton.MouseButton1Click:Connect(function()
	animateButton(backButton)
	if listeningFor then setListening(nil) end
	TweenService:Create(settingsFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 0, 0, 0)}):Play()
	task.wait(0.2)
	settingsFrame.Visible = false
end)

darkButton.MouseButton1Click:Connect(function()
	animateButton(darkButton)
	applyTheme("dark")
end)

lightButton.MouseButton1Click:Connect(function()
	animateButton(lightButton)
	applyTheme("light")
end)

footerLabel.MouseButton1Click:Connect(function()
	animateButton(footerLabel)
end)

footerLabelMinimized.MouseButton1Click:Connect(function()
	animateButton(footerLabelMinimized)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
	if listeningFor then
		if input.KeyCode == Enum.KeyCode.Escape then
			setListening(nil)
			return
		end
		applyKeybind(listeningFor, input.KeyCode)
		setListening(nil)
		return
	end
	if keybinds.hitbox and input.KeyCode == keybinds.hitbox then doToggleHitbox() end
	if keybinds.esp and input.KeyCode == keybinds.esp then doToggleESP() end
	if keybinds.gui and input.KeyCode == keybinds.gui then doToggleGui() end
	if keybinds.minimize and input.KeyCode == keybinds.minimize then doMinimize() end
	if keybinds.apply and input.KeyCode == keybinds.apply then doApplyHitbox() end
end)

RunService.Heartbeat:Connect(function()
	if isEnabled then
		updateHitboxes()
	end
	updateESP()
end)

titleBar.InputBegan:Connect(function(input)
	if not guiVisible then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				isDragging = false
			end
		end)
	end
end)

titleBar.InputChanged:Connect(function(input)
	if not guiVisible then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not guiVisible then return end
	if input == dragInput and isDragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

applyButton.MouseEnter:Connect(function()
	TweenService:Create(applyButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(100, 170, 255)}):Play()
end)
applyButton.MouseLeave:Connect(function()
	TweenService:Create(applyButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(80, 150, 255)}):Play()
end)
minimizeButton.MouseEnter:Connect(function()
	TweenService:Create(minimizeButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 220, 80)}):Play()
end)
minimizeButton.MouseLeave:Connect(function()
	TweenService:Create(minimizeButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 200, 50)}):Play()
end)
closeButton.MouseEnter:Connect(function()
	TweenService:Create(closeButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 70, 70)}):Play()
end)
closeButton.MouseLeave:Connect(function()
	TweenService:Create(closeButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
end)
settingsButtonTop.MouseEnter:Connect(function()
	if currentTheme == "dark" then
		TweenService:Create(settingsButtonTop, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(120, 120, 140)}):Play()
	else
		TweenService:Create(settingsButtonTop, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(220, 220, 240)}):Play()
	end
end)
settingsButtonTop.MouseLeave:Connect(function()
	if currentTheme == "dark" then
		TweenService:Create(settingsButtonTop, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(100, 100, 120)}):Play()
	else
		TweenService:Create(settingsButtonTop, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(200, 200, 220)}):Play()
	end
end)
yesButton.MouseEnter:Connect(function()
	TweenService:Create(yesButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(70, 220, 120)}):Play()
end)
yesButton.MouseLeave:Connect(function()
	TweenService:Create(yesButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 200, 100)}):Play()
end)
noButton.MouseEnter:Connect(function()
	TweenService:Create(noButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 70, 70)}):Play()
end)
noButton.MouseLeave:Connect(function()
	TweenService:Create(noButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
end)
backButton.MouseEnter:Connect(function()
	TweenService:Create(backButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(100, 100, 110)}):Play()
end)
backButton.MouseLeave:Connect(function()
	TweenService:Create(backButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(80, 80, 90)}):Play()
end)
darkButton.MouseEnter:Connect(function()
	TweenService:Create(darkButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
end)
darkButton.MouseLeave:Connect(function()
	TweenService:Create(darkButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
end)
lightButton.MouseEnter:Connect(function()
	TweenService:Create(lightButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)
lightButton.MouseLeave:Connect(function()
	TweenService:Create(lightButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(240, 240, 250)}):Play()
end)
espToggleButton.MouseEnter:Connect(function()
	if espEnabled then
		TweenService:Create(espToggleButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(70, 220, 120)}):Play()
	else
		TweenService:Create(espToggleButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 70, 70)}):Play()
	end
end)
espToggleButton.MouseLeave:Connect(function()
	if espEnabled then
		TweenService:Create(espToggleButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 200, 100)}):Play()
	else
		TweenService:Create(espToggleButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
	end
end)
disableTransparencyButton.MouseEnter:Connect(function()
	if disableTransparency then
		TweenService:Create(disableTransparencyButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(70, 220, 120)}):Play()
	else
		TweenService:Create(disableTransparencyButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 70, 70)}):Play()
	end
end)
disableTransparencyButton.MouseLeave:Connect(function()
	if disableTransparency then
		TweenService:Create(disableTransparencyButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 200, 100)}):Play()
	else
		TweenService:Create(disableTransparencyButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
	end
end)

applyLoadedSettings()
