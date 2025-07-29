-- UI.lua - Interface melhorada e funcional
-- Criado por K9zzzzz

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

-- Variáveis
local ScreenGui = nil
local MainFrame = nil
local IsRunning = false
local CurrentNumber = 1
local Config = {}
local Modules = {}

-- Carregar módulos
local function LoadModules()
    local loader = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/Loader.lua'))()
    Modules = loader:LoadAllModules()
    
    if not loader:VerifyModules(Modules) then
        warn("Alguns módulos não foram carregados!")
        return false
    end
    
    return true
end

-- Função para criar texto
local function CreateText(parent, text, size, position, color)
    local label = Instance.new("TextLabel")
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = parent
    return label
end

-- Função para criar input melhorado
local function CreateInput(parent, placeholder, size, position, callback)
    local input = Instance.new("TextBox")
    input.Size = size
    input.Position = position
    input.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    input.BorderSizePixel = 0
    input.PlaceholderText = placeholder
    input.Text = ""
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.TextScaled = true
    input.Font = Enum.Font.Gotham
    input.Parent = parent
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = input
    
    -- Stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(60, 60, 80)
    stroke.Thickness = 1
    stroke.Parent = input
    
    -- Hover effect
    input.Focused:Connect(function()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(0, 150, 255)}):Play()
    end)
    
    input.FocusLost:Connect(function()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(60, 60, 80)}):Play()
        if callback then
            callback(input.Text)
        end
    end)
    
    return input
end

-- Função para criar toggle melhorado
local function CreateToggle(parent, size, position, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, size.X.Offset + 80, 0, size.Y.Offset)
    frame.Position = position
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 50, 0, 25)
    toggle.Position = UDim2.new(0, 0, 0, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    toggle.BorderSizePixel = 0
    toggle.Text = ""
    toggle.Parent = frame
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = toggle
    
    -- Stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(60, 60, 80)
    stroke.Thickness = 1
    stroke.Parent = toggle
    
    -- Handle
    local handle = Instance.new("Frame")
    handle.Size = UDim2.new(0, 21, 0, 21)
    handle.Position = UDim2.new(0, 2, 0, 2)
    handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    handle.BorderSizePixel = 0
    handle.Parent = toggle
    
    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(0, 10)
    handleCorner.Parent = handle
    
    -- Label
    local label = CreateText(frame, "Pular:", UDim2.new(0, 60, 1, 0), UDim2.new(0, 60, 0, 0))
    
    local isOn = false
    
    toggle.MouseButton1Click:Connect(function()
        isOn = not isOn
        if isOn then
            TweenService:Create(handle, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(1, -23, 0, 2)}):Play()
            TweenService:Create(toggle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
            TweenService:Create(stroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(0, 150, 75)}):Play()
        else
            TweenService:Create(handle, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 2, 0, 2)}):Play()
            TweenService:Create(toggle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
            TweenService:Create(stroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(60, 60, 80)}):Play()
        end
        if callback then
            callback(isOn)
        end
    end)
    
    return toggle
end

-- Função para criar botão play melhorado
local function CreatePlayButton(parent, size, position, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    button.BorderSizePixel = 0
    button.Text = "▶ INICIAR"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.Parent = parent
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = button
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 180, 255)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return button
end

-- Função para tornar frame draggable melhorada
local function MakeDraggable(frame)
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Função para enviar mensagem usando módulos
local function SendMessage(numero)
    if not Modules.Extenso or not Modules.ChatAdapter then
        warn("Módulos não carregados!")
        return false
    end
    
    local numeroExtenso = Modules.Extenso:GetNumero(numero)
    local message = numeroExtenso .. (Config.FinalPrompt or "!")
    
    return Modules.ChatAdapter:SendMessageWithRetry(message, 3)
end

-- Função para criar a UI melhorada
local function CreateUI()
    -- Criar ScreenGui
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AutoJJsUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Criar frame principal
    MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 350, 0, 280)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -140)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = MainFrame
    
    -- Stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 150, 255)
    stroke.Thickness = 2
    stroke.Parent = MainFrame
    
    -- Título melhorado
    local titleFrame = Instance.new("Frame")
    titleFrame.Size = UDim2.new(1, 0, 0, 40)
    titleFrame.Position = UDim2.new(0, 0, 0, 0)
    titleFrame.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    titleFrame.BorderSizePixel = 0
    titleFrame.Parent = MainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 15)
    titleCorner.Parent = titleFrame
    
    local zvText = CreateText(titleFrame, "Zv_yz", UDim2.new(0, 60, 1, 0), UDim2.new(0, 15, 0, 0), Color3.fromRGB(255, 255, 255))
    local autoText = CreateText(titleFrame, " - Auto", UDim2.new(0, 80, 1, 0), UDim2.new(0, 75, 0, 0), Color3.fromRGB(255, 255, 255))
    local jjsText = CreateText(titleFrame, "JJs[2.1]", UDim2.new(0, 100, 1, 0), UDim2.new(0, 155, 0, 0), Color3.fromRGB(255, 255, 255))
    
    -- Começar do
    local startLabel = CreateText(MainFrame, "Começar do:", UDim2.new(0, 120, 0, 25), UDim2.new(0, 20, 0, 60))
    local startInput = CreateInput(MainFrame, "1", UDim2.new(0, 200, 0, 30), UDim2.new(0, 150, 0, 60), function(value)
        Config.StartNumber = tonumber(value) or 1
    end)
    startInput.Text = tostring(Config.StartNumber or 1)
    
    -- Até o
    local endLabel = CreateText(MainFrame, "Até o:", UDim2.new(0, 120, 0, 25), UDim2.new(0, 20, 0, 100))
    local endInput = CreateInput(MainFrame, "2", UDim2.new(0, 200, 0, 30), UDim2.new(0, 150, 0, 100), function(value)
        Config.EndNumber = tonumber(value) or 2
    end)
    endInput.Text = tostring(Config.EndNumber or 2)
    
    -- Final do Prefix
    local prefixLabel = CreateText(MainFrame, "Final do Prefix:", UDim2.new(0, 120, 0, 25), UDim2.new(0, 20, 0, 140))
    local prefixInput = CreateInput(MainFrame, "!", UDim2.new(0, 200, 0, 30), UDim2.new(0, 150, 0, 140), function(value)
        Config.FinalPrompt = value or "!"
    end)
    prefixInput.Text = Config.FinalPrompt or "!"
    
    -- Pular toggle
    local skipToggle = CreateToggle(MainFrame, UDim2.new(0, 50, 0, 25), UDim2.new(0, 20, 0, 180), function(isOn)
        Config.SkipMode = isOn
        if Modules.Notification then
            if isOn then
                Modules.Notification:Success("Pular Ativado", "Números serão pulados", 2)
            else
                Modules.Notification:Info("Pular Desativado", "Números não serão pulados", 2)
            end
        end
    end)
    
    -- Botão play
    local playButton = CreatePlayButton(MainFrame, UDim2.new(1, -40, 0, 50), UDim2.new(0, 20, 0, 220), function()
        ToggleAutoJJs()
    end)
    
    -- Tornar draggable
    MakeDraggable(MainFrame)
    
    -- Mostrar notificação de carregamento
    if Modules.Notification then
        Modules.Notification:Success("Auto JJS Carregado!", "Criado por K9zzzzz", 3)
    end
end

-- Função para iniciar/parar melhorada
local function ToggleAutoJJs()
    if IsRunning then
        IsRunning = false
        if Modules.Notification then
            Modules.Notification:Warning("Parado", "Auto JJS parado", 2)
        end
        return
    end
    
    IsRunning = true
    CurrentNumber = Config.StartNumber or 1
    local endNumber = Config.EndNumber or 2
    
    if Modules.Notification then
        Modules.Notification:Success("Iniciado", "Auto JJS iniciado - " .. CurrentNumber .. " até " .. endNumber, 3)
    end
    
    spawn(function()
        while IsRunning and CurrentNumber <= endNumber do
            if SendMessage(CurrentNumber) then
                CurrentNumber = CurrentNumber + 1
                
                -- Mostrar progresso a cada 10 números
                if CurrentNumber % 10 == 0 and Modules.Notification then
                    Modules.Notification:Info("Progresso", "Número atual: " .. (CurrentNumber - 1), 1)
                end
            else
                if Modules.Notification then
                    Modules.Notification:Error("Erro", "Falha ao enviar mensagem", 3)
                end
                break
            end
            
            -- Delay
            wait(Config.Tempo or 2.5)
        end
        
        IsRunning = false
        if Modules.Notification then
            Modules.Notification:Success("Concluído", "Auto JJS finalizado!", 3)
        end
    end)
end

-- Função principal
local function Main(Options)
    Config = Options or {}
    
    -- Configurações padrão
    Config.StartNumber = Config.StartNumber or 1
    Config.EndNumber = Config.EndNumber or 2
    Config.FinalPrompt = Config.FinalPrompt or "!"
    Config.SkipMode = Config.SkipMode or false
    Config.Tempo = Config.Tempo or 2.5
    
    -- Carregar módulos
    if LoadModules() then
        -- Criar UI
        CreateUI()
        
        print("Auto JJS carregado!")
        print("Criado por K9zzzzz")
        print("Gambiarra do Extenso ativa - qualquer número!")
    else
        warn("Erro ao carregar módulos!")
    end
end

return Main 