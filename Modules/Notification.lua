-- Notification.lua
-- Sistema de notificações ultra compacto
-- Criado por K9zzzzz

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Notification = {}

-- Função para mostrar notificação ultra compacta
function Notification:Show(title, text, duration, notificationType)
    duration = duration or 3
    notificationType = notificationType or "info"
    
    -- Cores baseadas no tipo
    local colors = {
        info = {bg = Color3.fromRGB(20, 20, 30), stroke = Color3.fromRGB(0, 150, 255), title = Color3.fromRGB(0, 150, 255)},
        success = {bg = Color3.fromRGB(20, 30, 20), stroke = Color3.fromRGB(0, 200, 100), title = Color3.fromRGB(0, 200, 100)},
        warning = {bg = Color3.fromRGB(30, 30, 20), stroke = Color3.fromRGB(255, 200, 0), title = Color3.fromRGB(255, 200, 0)},
        error = {bg = Color3.fromRGB(30, 20, 20), stroke = Color3.fromRGB(255, 100, 100), title = Color3.fromRGB(255, 100, 100)}
    }
    
    local colorScheme = colors[notificationType] or colors.info
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NotificationGui"
    screenGui.Parent = game:GetService("CoreGui")
    
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0, 160, 0, 35)
    notificationFrame.Position = UDim2.new(1, 160, 1, -45)
    notificationFrame.BackgroundColor3 = colorScheme.bg
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Parent = screenGui
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = notificationFrame
    
    -- Stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = colorScheme.stroke
    stroke.Thickness = 1
    stroke.Parent = notificationFrame
    
    -- Ícone baseado no tipo
    local iconText = "ℹ"
    if notificationType == "success" then iconText = "✓"
    elseif notificationType == "warning" then iconText = "⚠"
    elseif notificationType == "error" then iconText = "✗"
    end
    
    -- Ícone
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 12, 0, 12)
    iconLabel.Position = UDim2.new(0, 5, 0, 5)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = iconText
    iconLabel.TextColor3 = colorScheme.title
    iconLabel.TextScaled = true
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Parent = notificationFrame
    
    -- Título
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -25, 0, 12)
    titleLabel.Position = UDim2.new(0, 20, 0, 2)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = colorScheme.title
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = notificationFrame
    
    -- Texto
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -25, 0, 12)
    textLabel.Position = UDim2.new(0, 20, 0, 17)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.Gotham
    textLabel.Parent = notificationFrame
    
    -- Animação de entrada suave
    local enterTween = TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -170, 1, -45)
    })
    enterTween:Play()
    
    -- Animar saída suave
    spawn(function()
        wait(duration)
        local exitTween = TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 160, 1, -45)
        })
        exitTween:Play()
        
        exitTween.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end)
end

-- Funções de conveniência
function Notification:Success(title, text, duration)
    self:Show(title, text, duration, "success")
end

function Notification:Warning(title, text, duration)
    self:Show(title, text, duration, "warning")
end

function Notification:Error(title, text, duration)
    self:Show(title, text, duration, "error")
end

function Notification:Info(title, text, duration)
    self:Show(title, text, duration, "info")
end

return Notification 