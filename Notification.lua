-- Notification.lua
-- Sistema de notificações avançado
-- Criado por K9zzzzz

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local Notification = {}
Notification.__index = Notification

-- Variáveis
local Notifications = {}
local NotificationCount = 0
local MaxNotifications = 5

-- Cores por tipo de notificação
local NotificationColors = {
    Info = Color3.fromRGB(0, 150, 255),
    Success = Color3.fromRGB(0, 255, 0),
    Error = Color3.fromRGB(255, 0, 0),
    Warning = Color3.fromRGB(255, 255, 0)
}

-- Função para obter cor por tipo
local function GetColorByType(notificationType)
    return NotificationColors[notificationType] or NotificationColors.Info
end

-- Função para criar notificação
function Notification:Show(title, text, duration, notificationType)
    notificationType = notificationType or "Info"
    duration = duration or 3
    
    -- Limpar notificações antigas se necessário
    if #Notifications >= MaxNotifications then
        local oldestNotification = table.remove(Notifications, 1)
        if oldestNotification and oldestNotification.Frame then
            oldestNotification.Frame:Destroy()
        end
    end
    
    -- Criar ScreenGui se não existir
    local screenGui = game:GetService("CoreGui"):FindFirstChild("NotificationGui")
    if not screenGui then
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "NotificationGui"
        screenGui.Parent = game:GetService("CoreGui")
    end
    
    -- Criar frame da notificação
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0, 300, 0, 80)
    notificationFrame.Position = UDim2.new(1, -320, 0, 20 + (#Notifications * 90))
    notificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Parent = screenGui
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notificationFrame
    
    -- Stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = GetColorByType(notificationType)
    stroke.Thickness = 2
    stroke.Parent = notificationFrame
    
    -- Título
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = GetColorByType(notificationType)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = notificationFrame
    
    -- Texto
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -20, 0, 35)
    textLabel.Position = UDim2.new(0, 10, 0, 35)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.Gotham
    textLabel.Parent = notificationFrame
    
    -- Barra de progresso
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(1, 0, 0, 3)
    progressBar.Position = UDim2.new(0, 0, 1, -3)
    progressBar.BackgroundColor3 = GetColorByType(notificationType)
    progressBar.BorderSizePixel = 0
    progressBar.Parent = notificationFrame
    
    -- Corner radius para barra
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 2)
    progressCorner.Parent = progressBar
    
    -- Animação de entrada
    notificationFrame.Position = UDim2.new(1, 320, 0, 20 + (#Notifications * 90))
    local enterTween = TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -320, 0, 20 + (#Notifications * 90))
    })
    enterTween:Play()
    
    -- Adicionar à lista
    table.insert(Notifications, {
        Frame = notificationFrame,
        ProgressBar = progressBar,
        Duration = duration,
        StartTime = tick()
    })
    
    -- Animar barra de progresso
    spawn(function()
        local startTime = tick()
        while tick() - startTime < duration do
            local progress = (tick() - startTime) / duration
            progressBar.Size = UDim2.new(1 - progress, 0, 0, 3)
            wait(0.1)
        end
        
        -- Animação de saída
        local exitTween = TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 320, 0, 20 + (#Notifications * 90))
        })
        exitTween:Play()
        
        exitTween.Completed:Connect(function()
            notificationFrame:Destroy()
            -- Remover da lista
            for i, notification in ipairs(Notifications) do
                if notification.Frame == notificationFrame then
                    table.remove(Notifications, i)
                    break
                end
            end
        end)
    end)
    
    NotificationCount = NotificationCount + 1
end

-- Função para notificação de sucesso
function Notification:Success(title, text, duration)
    self:Show(title, text, duration, "Success")
end

-- Função para notificação de erro
function Notification:Error(title, text, duration)
    self:Show(title, text, duration, "Error")
end

-- Função para notificação de aviso
function Notification:Warning(title, text, duration)
    self:Show(title, text, duration, "Warning")
end

-- Função para notificação de informação
function Notification:Info(title, text, duration)
    self:Show(title, text, duration, "Info")
end

-- Função para limpar todas as notificações
function Notification:ClearAll()
    for _, notification in ipairs(Notifications) do
        if notification.Frame then
            notification.Frame:Destroy()
        end
    end
    Notifications = {}
end

-- Função para obter número de notificações ativas
function Notification:GetCount()
    return #Notifications
end

-- Função de inicialização
function Notification:Initialize()
    -- Limpar notificações antigas se existirem
    local screenGui = game:GetService("CoreGui"):FindFirstChild("NotificationGui")
    if screenGui then
        screenGui:Destroy()
    end
end

return Notification 