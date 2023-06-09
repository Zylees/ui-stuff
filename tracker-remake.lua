--Script v2.2

local Library = require(game:GetService("ReplicatedStorage"):WaitForChild("Library"))

local Tracker = Instance.new("ScreenGui")
local BG = Instance.new("Frame")
local DropShadowHolder = Instance.new("Frame")
local DropShadow = Instance.new("ImageLabel")
local UICorner = Instance.new("UICorner")
local Container = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UIPadding = Instance.new("UIPadding")
local Diamonds = Instance.new("TextLabel")
local UIPadding_2 = Instance.new("UIPadding")
local TimePassed = Instance.new("TextLabel")
local UIPadding_3 = Instance.new("UIPadding")

local StartingDiamonds = Library.Save.Get().Diamonds
local StartingTick = tick()

--Properties:

Tracker.Name = ((tick() * math.random(1, 5)) / math.random(1, 12))
Tracker.Parent = game.CoreGui
Tracker.ZIndexBehavior = Enum.ZIndexBehavior.Global

BG.Name = "BG"
BG.Parent = Tracker
BG.AnchorPoint = Vector2.new(0, 0.5)
BG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BG.Position = UDim2.new(0, 4, 0.200000003, 0)
BG.Size = UDim2.new(0, 250, 0, 100)

DropShadowHolder.Name = "DropShadowHolder"
DropShadowHolder.Parent = BG
DropShadowHolder.BackgroundTransparency = 1.000
DropShadowHolder.BorderSizePixel = 0
DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
DropShadowHolder.ZIndex = 0

DropShadow.Name = "DropShadow"
DropShadow.Parent = DropShadowHolder
DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
DropShadow.BackgroundTransparency = 1.000
DropShadow.BorderSizePixel = 0
DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
DropShadow.Size = UDim2.new(1, 47, 1, 47)
DropShadow.ZIndex = 0
DropShadow.Image = "rbxassetid://6014261993"
DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.ImageTransparency = 0.500
DropShadow.ScaleType = Enum.ScaleType.Slice
DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

UICorner.Parent = BG

Container.Name = "Container"
Container.Parent = BG
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.BackgroundTransparency = 1.000
Container.Size = UDim2.new(1, 0, 1, 0)

Title.Name = "Title"
Title.Parent = Container
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Size = UDim2.new(1, 0, 0, 15)
Title.Font = Enum.Font.GothamBold
Title.Text = "Stats Tracker"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14.000
Title.TextXAlignment = Enum.TextXAlignment.Left

UIPadding.Parent = Title
UIPadding.PaddingLeft = UDim.new(0, 6)
UIPadding.PaddingTop = UDim.new(0, 8)

Diamonds.Name = "Diamonds"
Diamonds.Parent = Container
Diamonds.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Diamonds.BackgroundTransparency = 1.000
Diamonds.Position = UDim2.new(0, 0, 0, 20)
Diamonds.Size = UDim2.new(1, 0, 0, 15)
Diamonds.Font = Enum.Font.Gotham
Diamonds.Text = "0 <b><font color=\"rgb(30, 128, 227)\">diamonds</font></b> earned"
Diamonds.TextColor3 = Color3.fromRGB(255, 255, 255)
Diamonds.TextSize = 14.000
Diamonds.TextXAlignment = Enum.TextXAlignment.Left
Diamonds.RichText = true

UIPadding_2.Parent = Diamonds
UIPadding_2.PaddingLeft = UDim.new(0, 6)
UIPadding_2.PaddingTop = UDim.new(0, 8)

TimePassed.Name = "TimePassed"
TimePassed.Parent = Container
TimePassed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TimePassed.BackgroundTransparency = 1.000
TimePassed.Position = UDim2.new(0, 0, 0, 40)
TimePassed.Size = UDim2.new(1, 0, 0, 15)
TimePassed.Font = Enum.Font.Gotham
TimePassed.Text = "0 <b><font color=\"rgb(39, 222, 35)\">seconds</font></b> elapsed"
TimePassed.TextColor3 = Color3.fromRGB(255, 255, 255)
TimePassed.TextSize = 14.000
TimePassed.TextXAlignment = Enum.TextXAlignment.Left
TimePassed.RichText = true

UIPadding_3.Parent = TimePassed
UIPadding_3.PaddingLeft = UDim.new(0, 6)
UIPadding_3.PaddingTop = UDim.new(0, 8)

task.spawn(function()
	while task.wait() do
		Diamonds.Text = Library.Functions.Commas(Library.Save.Get().Diamonds - StartingDiamonds) .. " <b><font color=\"rgb(30, 128, 227)\">diamonds</font></b> earned" 
		TimePassed.Text = tostring(math.round(tick() - StartingTick)) .. " <b><font color=\"rgb(39, 222, 35)\">seconds</font></b> elapsed"
	end
end) 
