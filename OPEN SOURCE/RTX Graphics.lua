-- Clean Lighting Stack (Safe Version)

local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

-- prevent re-run stacking
if Lighting:FindFirstChild("CustomFX_Loaded") then return end
local tag = Instance.new("BoolValue")
tag.Name = "CustomFX_Loaded"
tag.Parent = Lighting

-- cleanup ONLY effects (not everything)
for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") then
        v:Destroy()
    end
end

-- effects
local Bloom = Instance.new("BloomEffect")
Bloom.Name = "CustomBloom"
Bloom.Intensity = 0.3
Bloom.Size = 10
Bloom.Threshold = 0.8
Bloom.Parent = Lighting

local Blur = Instance.new("BlurEffect")
Blur.Name = "CustomBlur"
Blur.Size = 5
Blur.Parent = Lighting

local ColorCor = Instance.new("ColorCorrectionEffect")
ColorCor.Name = "CustomColor"
ColorCor.Brightness = 0.1
ColorCor.Contrast = 0.5
ColorCor.Saturation = -0.3
ColorCor.TintColor = Color3.fromRGB(255, 235, 203)
ColorCor.Parent = Lighting

local SunRays = Instance.new("SunRaysEffect")
SunRays.Name = "CustomSunRays"
SunRays.Intensity = 0.075
SunRays.Spread = 0.727
SunRays.Parent = Lighting

local Sky = Instance.new("Sky")
Sky.Name = "CustomSky"
Sky.SkyboxBk = "rbxassetid://151165214"
Sky.SkyboxDn = "rbxassetid://151165197"
Sky.SkyboxFt = "rbxassetid://151165224"
Sky.SkyboxLf = "rbxassetid://151165191"
Sky.SkyboxRt = "rbxassetid://151165206"
Sky.SkyboxUp = "rbxassetid://151165227"
Sky.SunAngularSize = 10
Sky.Parent = Lighting

local Atm = Instance.new("Atmosphere")
Atm.Name = "CustomAtmosphere"
Atm.Density = 0.364
Atm.Offset = 0.556
Atm.Color = Color3.fromRGB(199, 175, 166)
Atm.Decay = Color3.fromRGB(44, 39, 33)
Atm.Glare = 0.36
Atm.Haze = 1.72
Atm.Parent = Lighting

-- lighting settings
Lighting.Ambient = Color3.fromRGB(2,2,2)
Lighting.Brightness = 2.25
Lighting.ColorShift_Bottom = Color3.fromRGB(0,0,0)
Lighting.ColorShift_Top = Color3.fromRGB(0,0,0)
Lighting.EnvironmentDiffuseScale = 0.2
Lighting.EnvironmentSpecularScale = 0.2
Lighting.GlobalShadows = true
Lighting.OutdoorAmbient = Color3.fromRGB(0,0,0)
Lighting.ShadowSoftness = 0.2
Lighting.ClockTime = 17
Lighting.GeographicLatitude = 45
Lighting.ExposureCompensation = 0.5

-- vignette (safe)
if not CoreGui:FindFirstChild("CustomVignette") then
    local Gui = Instance.new("ScreenGui")
    Gui.Name = "CustomVignette"
    Gui.IgnoreGuiInset = true
    Gui.ResetOnSpawn = false
    Gui.Parent = CoreGui

    local ShadowFrame = Instance.new("ImageLabel")
    ShadowFrame.Parent = Gui
    ShadowFrame.AnchorPoint = Vector2.new(0.5,1)
    ShadowFrame.Position = UDim2.new(0.5,0,1,0)
    ShadowFrame.Size = UDim2.new(1,0,1.05,0)
    ShadowFrame.BackgroundTransparency = 1
    ShadowFrame.Image = "rbxassetid://4576475446"
    ShadowFrame.ImageTransparency = 0.3
    ShadowFrame.ZIndex = 10
end