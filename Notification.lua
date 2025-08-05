-- Notification.lua
-- Sistema de notificações compacto e elegante
-- Criado por K9zzzzz

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Notification = {}

-- Função para mostrar notificação ultra compacta
function Notification:Show(title, message, type, duration)
    if not title or not message then return end
    
    duration = duration or 3
    type = type or "info"
    
    -- Cores baseadas no tipo
    local colors = {
        info = {bg = Color3.fromRGB(20, 20, 30), stroke = Color3.fromRGB(0, 150, 255)},
        success = {bg = Color3.fromRGB(20, 30, 20), stroke = Color3.fromRGB(0, 200, 100)},
        warning = {bg = Color3.fromRGB(30, 30, 20), stroke = Color3.fromRGB(255, 200, 0)},
        error = {bg = Color3.fromRGB(30, 20, 20), stroke = Color3.fromRGB(255, 100, 100)}
    }
    
    local colorScheme = colors[type] or colors.info
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NotificationGui"
    screenGui.Parent = game:GetService("CoreGui")
    
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0, 160, 0, 35)
    notificationFrame.Position = UDim2.new(1, 160, 1, -45)
    notificationFrame.BackgroundColor3 = colorScheme.bg
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim2.new(0, 4)
    corner.Parent = notificationFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = colorScheme.stroke
    stroke.Thickness = 1
    stroke.Parent = notificationFrame
    
    -- Ícone baseado no tipo
    local iconText = "ℹ"
    if type == "success" then iconText = "✓"
    elseif type == "warning" then iconText = "⚠"
    elseif type == "error" then iconText = "✗"
    end
    
    -- Ícone
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 12, 0, 12)
    iconLabel.Position = UDim2.new(0, 5, 0, 5)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = iconText
    iconLabel.TextColor3 = colorScheme.stroke
    iconLabel.TextScaled = true
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Parent = notificationFrame
    
    -- Título
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -25, 0, 12)
    titleLabel.Position = UDim2.new(0, 20, 0, 2)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = notificationFrame
    
    -- Mensagem
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -25, 0, 12)
    messageLabel.Position = UDim2.new(0, 20, 0, 17)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    messageLabel.TextScaled = true
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.Parent = notificationFrame
    
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
function Notification:Success(title, message, duration)
    self:Show(title, message, "success", duration)
end

function Notification:Warning(title, message, duration)
    self:Show(title, message, "warning", duration)
end

function Notification:Error(title, message, duration)
    self:Show(title, message, "error", duration)
end

function Notification:Info(title, message, duration)
    self:Show(title, message, "info", duration)
end

-- Função para mostrar notificação com I18N
function Notification:ShowI18N(i18n, notificationKey, duration)
    if not i18n or not i18n.Notifications or not i18n.Notifications[notificationKey] then
        return
    end
    
    local notification = i18n.Notifications[notificationKey]
    self:Show(notification.Title, notification.Message, "info", duration)
end

-- Função para mostrar notificação com I18N e substituição de variáveis
function Notification:ShowI18NWithVars(i18n, notificationKey, vars, duration)
    if not i18n or not i18n.Notifications or not i18n.Notifications[notificationKey] then
        return
    end
    
    local notification = i18n.Notifications[notificationKey]
    local title = notification.Title
    local message = notification.Message
    
    -- Substituir variáveis
    if vars then
        for key, value in pairs(vars) do
            title = title:gsub("{" .. key .. "}", tostring(value))
            message = message:gsub("{" .. key .. "}", tostring(value))
        end
    end
    
    self:Show(title, message, "info", duration)
end

return Notification 