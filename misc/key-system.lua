--Update 1, fixed variables

local UserInputService = game:GetService("UserInputService")

local library = {}

function library:Init(title, requiredKey, callback)
    -- Instances:
    local KeySystem = Instance.new("ScreenGui")
    local Background = Instance.new("ImageLabel")
    local UICorner = Instance.new("UICorner")
    local DropShadow = Instance.new("ImageLabel")
    local CheckFrame = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local CheckButton = Instance.new("TextButton")
    local UICorner_3 = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    local InputFrame = Instance.new("Frame")
    local UICorner_4 = Instance.new("UICorner")
    local UIGradient_2 = Instance.new("UIGradient")
    local CheckInput = Instance.new("TextBox")
    local UICorner_5 = Instance.new("UICorner")
    local TitleFrame = Instance.new("Frame")
    local UICorner_6 = Instance.new("UICorner")
    local UIGradient_3 = Instance.new("UIGradient")
    local Title = Instance.new("TextLabel")
    local UIPadding = Instance.new("UIPadding")
    local GameNameFrame = Instance.new("Frame")
    local UICorner_7 = Instance.new("UICorner")
    local UIGradient_4 = Instance.new("UIGradient")
    local GameName = Instance.new("TextLabel")

    KeySystem.Name = "KeySystem"
    KeySystem.Parent = game.CoreGui

    Background.Name = "Background"
    Background.Parent = KeySystem
    Background.AnchorPoint = Vector2.new(0.5, 0.5)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.Position = UDim2.new(0.5, 0, 0.5, 0)
    Background.Size = UDim2.new(0, 342, 0, 200)
    Background.Image = "https://www.roblox.com/asset-thumbnail/image?assetId="..game.PlaceId.."&width=768&height=432&format=png"
    Background.ImageTransparency = 0.500

    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        Background.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    Background.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Background.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Background.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    UICorner.Parent = Background

    DropShadow.Name = "DropShadow"
    DropShadow.Parent = Background
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1.000
    DropShadow.BorderSizePixel = 0
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 49, 1, 49)
    DropShadow.ZIndex = 0
    DropShadow.Image = "rbxassetid://6014261993"
    DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow.ImageTransparency = 0.400
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

    CheckFrame.Name = "CheckFrame"
    CheckFrame.Parent = Background
    CheckFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    CheckFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CheckFrame.Position = UDim2.new(0.5, 0, 0.5, 28)
    CheckFrame.Size = UDim2.new(0, 150, 0, 35)

    UICorner_2.Parent = CheckFrame

    CheckButton.Name = "CheckButton"
    CheckButton.Parent = CheckFrame
    CheckButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CheckButton.BackgroundTransparency = 1.000
    CheckButton.Size = UDim2.new(1, 0, 1, 0)
    CheckButton.Font = Enum.Font.Gotham
    CheckButton.Text = "Check Key"
    CheckButton.TextColor3 = Color3.fromRGB(245, 245, 245)
    CheckButton.TextSize = 12.000
    CheckButton.MouseButton1Click:Connect(function()
        if CheckInput.Text == requiredKey then
            pcall(callback)
            KeySystem:Destroy()
        end
    end)

    UICorner_3.Parent = CheckButton

    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(22, 22, 22)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 50, 50))}
    UIGradient.Rotation = -90
    UIGradient.Parent = CheckFrame

    InputFrame.Name = "InputFrame"
    InputFrame.Parent = Background
    InputFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    InputFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    InputFrame.Position = UDim2.new(0.5, 0, 0.5, -15)
    InputFrame.Size = UDim2.new(0, 250, 0, 35)

    UICorner_4.Parent = InputFrame

    UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(22, 22, 22)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 50, 50))}
    UIGradient_2.Rotation = -90
    UIGradient_2.Parent = InputFrame

    CheckInput.Name = "CheckInput"
    CheckInput.Parent = InputFrame
    CheckInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CheckInput.BackgroundTransparency = 1.000
    CheckInput.Size = UDim2.new(1, 0, 1, 0)
    CheckInput.ClearTextOnFocus = false
    CheckInput.Font = Enum.Font.Gotham
    CheckInput.Text = "Input Key"
    CheckInput.TextColor3 = Color3.fromRGB(245, 245, 245)
    CheckInput.TextSize = 12.000

    UICorner_5.Parent = CheckInput

    TitleFrame.Name = "TitleFrame"
    TitleFrame.Parent = Background
    TitleFrame.AnchorPoint = Vector2.new(0.5, 0)
    TitleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleFrame.Position = UDim2.new(0.5, 0, 0, -35)
    TitleFrame.Size = UDim2.new(1, 0, 0, 30)

    UICorner_6.Parent = TitleFrame

    UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(22, 22, 22)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 50, 50))}
    UIGradient_3.Rotation = -90
    UIGradient_3.Parent = TitleFrame

    Title.Name = "Title"
    Title.Parent = TitleFrame
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding.Parent = Title
    UIPadding.PaddingLeft = UDim.new(0, 4)

    GameNameFrame.Name = "GameNameFrame"
    GameNameFrame.Parent = Background
    GameNameFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    GameNameFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    GameNameFrame.Position = UDim2.new(0.5, 0, 0.5, -50)                                                        
    GameNameFrame.Size = UDim2.new(0, 250, 0, 30)

    UICorner_7.Parent = GameNameFrame

    UIGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(22, 22, 22)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 50, 50))}
    UIGradient_4.Rotation = -90
    UIGradient_4.Parent = GameNameFrame

    GameName.Name = "GameName"
    GameName.Parent = GameNameFrame
    GameName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    GameName.BackgroundTransparency = 1.000
    GameName.Size = UDim2.new(1, 0, 1, 0)
    GameName.Font = Enum.Font.Gotham
    GameName.TextColor3 = Color3.fromRGB(255, 255, 255)
    GameName.TextSize = 12.000
    GameName.Text = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end

return library
