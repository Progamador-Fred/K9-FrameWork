-- Auto JJS Melhorado - Notification Module
-- Criado por K9zzzzz
-- Sistema de notificações avançado

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Notification = {}
Notification.__index = Notification

-- Variáveis do sistema de notificações
local Notifications = {}
local NotificationCount = 0
local MaxNotifications = 5

-- Função para criar notificação
function Notification:Show(title, text, duration, notificationType)
    notificationType = notificationType or "info"
    duration = duration or 3
    
    -- Limitar número de notificações
    if #Notifications >= MaxNotifications then
        self:RemoveOldest()
    end
    
    -- Criar ScreenGui para a notificação
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AutoJJsNotification" .. NotificationCount
    screenGui.Parent = game:GetService("CoreGui")
    
    -- Criar frame principal
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 80)
    frame.Position = UDim2.new(1, -320, 0, 20 + (#Notifications * 90))
    frame.BackgroundColor3 = self:GetColorByType(notificationType)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    -- Adicionar corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    -- Adicionar stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.8
    stroke.Thickness = 1
    stroke.Parent = frame
    
    -- Título
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = frame
    
    -- Texto
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -20, 0, 35)
    textLabel.Position = UDim2.new(0, 10, 0, 35)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.Gotham
    textLabel.Parent = frame
    
    -- Botão de fechar
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -25, 0, 5)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = frame
    
    -- Corner para o botão
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 4)
    closeCorner.Parent = closeButton
    
    -- Função para fechar notificação
    local function closeNotification()
        local exitTween = TweenService:Create(frame, TweenInfo.new(0.3), {
            Position = UDim2.new(1, 0, 0, frame.Position.Y.Offset),
            Size = UDim2.new(0, 0, 0, 80)
        })
        exitTween:Play()
        exitTween.Completed:Connect(function()
            screenGui:Destroy()
            self:RemoveFromList(screenGui)
        end)
    end
    
    -- Eventos do botão
    closeButton.MouseButton1Click:Connect(closeNotification)
    
    -- Hover effects
    closeButton.MouseEnter:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 0, 0)}):Play()
    end)
    
    closeButton.MouseLeave:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
    end)
    
    -- Animação de entrada
    frame.Position = UDim2.new(1, 0, 0, frame.Position.Y.Offset)
    frame.Size = UDim2.new(0, 0, 0, 80)
    
    local enterTween = TweenService:Create(frame, TweenInfo.new(0.3), {
        Position = UDim2.new(1, -320, 0, frame.Position.Y.Offset),
        Size = UDim2.new(0, 300, 0, 80)
    })
    enterTween:Play()
    
    -- Adicionar à lista
    table.insert(Notifications, screenGui)
    NotificationCount = NotificationCount + 1
    
    -- Auto-remover após duração
    spawn(function()
        wait(duration)
        closeNotification()
    end)
    
    return screenGui
end

-- Função para obter cor por tipo
function Notification:GetColorByType(notificationType)
    local colors = {
        info = Color3.fromRGB(45, 45, 45),
        success = Color3.fromRGB(0, 100, 0),
        warning = Color3.fromRGB(150, 100, 0),
        error = Color3.fromRGB(100, 0, 0)
    }
    
    return colors[notificationType] or colors.info
end

-- Função para remover notificação mais antiga
function Notification:RemoveOldest()
    if #Notifications > 0 then
        local oldest = table.remove(Notifications, 1)
        if oldest and oldest.Parent then
            oldest:Destroy()
        end
    end
end

-- Função para remover da lista
function Notification:RemoveFromList(notification)
    for i, notif in ipairs(Notifications) do
        if notif == notification then
            table.remove(Notifications, i)
            break
        end
    end
end

-- Função para limpar todas as notificações
function Notification:ClearAll()
    for _, notification in ipairs(Notifications) do
        if notification and notification.Parent then
            notification:Destroy()
        end
    end
    Notifications = {}
end

-- Função para mostrar notificação de sucesso
function Notification:Success(title, text, duration)
    return self:Show(title, text, duration, "success")
end

-- Função para mostrar notificação de erro
function Notification:Error(title, text, duration)
    return self:Show(title, text, duration, "error")
end

-- Função para mostrar notificação de aviso
function Notification:Warning(title, text, duration)
    return self:Show(title, text, duration, "warning")
end

-- Função para mostrar notificação de informação
function Notification:Info(title, text, duration)
    return self:Show(title, text, duration, "info")
end

return Notification 