-- UI/Components.lua
-- Componentes básicos da interface
-- Criado por K9zzzzz

local TweenService = game:GetService("TweenService")

local Components = {}

-- Criar texto
function Components:CreateText(parent, text, size, position, color, font)
    local label = Instance.new("TextLabel")
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = font or Enum.Font.Gotham
    label.Parent = parent
    return label
end

-- Criar input
function Components:CreateInput(parent, placeholder, size, position, callback)
    local input = Instance.new("TextBox")
    input.Size = size
    input.Position = position
    input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    input.BorderSizePixel = 0
    input.PlaceholderText = placeholder
    input.Text = ""
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.TextScaled = true
    input.Font = Enum.Font.Gotham
    input.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim2.new(0, 8)
    corner.Parent = input
    
    input.FocusLost:Connect(function()
        if callback then callback(input.Text) end
    end)
    
    return input
end

-- Criar toggle
function Components:CreateToggle(parent, size, position, callback)
    local toggleFrame = Instance.new("TextButton")
    toggleFrame.Size = size
    toggleFrame.Position = position
    toggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Text = ""
    toggleFrame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim2.new(0, 10)
    corner.Parent = toggleFrame
    
    local toggleButton = Instance.new("Frame")
    toggleButton.Size = UDim2.new(0.4, 0, 0.8, 0)
    toggleButton.Position = UDim2.new(0.05, 0, 0.1, 0)
    toggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    toggleButton.BorderSizePixel = 0
    toggleButton.Parent = toggleFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim2.new(0, 8)
    buttonCorner.Parent = toggleButton
    
    local isToggled = false
    
    toggleFrame.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        local targetPosition = isToggled and UDim2.new(0.55, 0, 0.1, 0) or UDim2.new(0.05, 0, 0.1, 0)
        local targetColor = isToggled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(80, 80, 80)
        
        TweenService:Create(toggleButton, TweenInfo.new(0.2), {Position = targetPosition}):Play()
        TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
        
        if callback then callback(isToggled) end
    end)
    
    return toggleFrame
end

-- Criar botão
function Components:CreateButton(parent, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim2.new(0, 8)
    corner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    return button
end

return Components 