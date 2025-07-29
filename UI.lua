-- UI.lua - Interface minimalista e bonita
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

-- Importar módulos das outras pastas
local function ImportModules()
    local modules = {}
    
    -- Importar Extenso
    local success1, ext = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/Extenso.lua'))()
    end)
    
    -- Importar ChatAdapter
    local success2, chat = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/ChatAdapter.lua'))()
    end)
    
    -- Importar Notification
    local success3, notif = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/Notification.lua'))()
    end)
    
    if success1 then modules.Extenso = ext end
    if success2 then modules.ChatAdapter = chat end
    if success3 then modules.Notification = notif end
    
    Modules = modules
    return success1 and success2 -- Extenso e ChatAdapter são essenciais
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
    label.Font = Enum.Font.Gotham
    label.Parent = parent
    return label
end

-- Função para criar input minimalista
local function CreateInput(parent, placeholder, size, position, callback)
    local input = Instance.new("TextBox")
    input.Size = size
    input.Position = position
    input.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    input.BorderSizePixel = 0
    input.PlaceholderText = placeholder
    input.Text = ""
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.TextScaled = true
    input.Font = Enum.Font.Gotham
    input.Parent = parent
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = input
    
    -- Hover effect
    input.Focused:Connect(function()
        TweenService:Create(input, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
    end)
    
    input.FocusLost:Connect(function()
        TweenService:Create(input, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
        if callback then
            callback(input.Text)
        end
    end)
    
    return input
end

-- Função para criar toggle minimalista
local function CreateToggle(parent, size, position, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, size.X.Offset + 50, 0, size.Y.Offset)
    frame.Position = position
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 35, 0, 18)
    toggle.Position = UDim2.new(0, 0, 0, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    toggle.BorderSizePixel = 0
    toggle.Text = ""
    toggle.Parent = frame
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 9)
    corner.Parent = toggle
    
    -- Handle
    local handle = Instance.new("Frame")
    handle.Size = UDim2.new(0, 14, 0, 14)
    handle.Position = UDim2.new(0, 2, 0, 2)
    handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    handle.BorderSizePixel = 0
    handle.Parent = toggle
    
    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(0, 7)
    handleCorner.Parent = handle
    
    -- Label
    local label = CreateText(frame, "Pular:", UDim2.new(0, 45, 1, 0), UDim2.new(0, 45, 0, 0))
    
    local isOn = false
    
    toggle.MouseButton1Click:Connect(function()
        isOn = not isOn
        if isOn then
            TweenService:Create(handle, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0, 2)}):Play()
            TweenService:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
        else
            TweenService:Create(handle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2)}):Play()
            TweenService:Create(toggle, TweenService:Create(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
        end
        if callback then
            callback(isOn)
        end
    end)
    
    return toggle
end

-- Função para criar botão play minimalista
local function CreatePlayButton(parent, size, position, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.BorderSizePixel = 0
    button.Text = "▶"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.Parent = parent
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return button
end

-- Função para tornar frame draggable
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

-- Função para enviar mensagem usando módulos importados
local function SendMessage(numero)
    if not Modules.Extenso or not Modules.ChatAdapter then
        warn("Módulos não importados!")
        return false
    end
    
    local numeroExtenso = Modules.Extenso:GetNumero(numero)
    local message = numeroExtenso .. (Config.FinalPrompt or "!")
    
    return Modules.ChatAdapter:SendMessageWithRetry(message, 3)
end

-- Função para criar a UI minimalista e bonita
local function CreateUI()
    -- Criar ScreenGui
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AutoJJsUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Criar frame principal (minimalista)
    MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 280, 0, 180)
    MainFrame.Position = UDim2.new(0.5, -140, 0.5, -90)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = MainFrame
    
    -- Stroke sutil
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.9
    stroke.Thickness = 1
    stroke.Parent = MainFrame
    
    -- Título minimalista
    local titleFrame = Instance.new("Frame")
    titleFrame.Size = UDim2.new(1, 0, 0, 25)
    titleFrame.Position = UDim2.new(0, 0, 0, 0)
    titleFrame.BackgroundTransparency = 1
    titleFrame.Parent = MainFrame
    
    local k9Text = CreateText(titleFrame, "K9zzzzz", UDim2.new(0, 60, 1, 0), UDim2.new(0, 8, 0, 0), Color3.fromRGB(0, 255, 0))
    local autoText = CreateText(titleFrame, " - Auto", UDim2.new(0, 70, 1, 0), UDim2.new(0, 68, 0, 0))
    local jjsText = CreateText(titleFrame, "JJs[v1.0.5]", UDim2.new(0, 90, 1, 0), UDim2.new(0, 138, 0, 0), Color3.fromRGB(255, 0, 0))
    
    -- Começar do
    local startLabel = CreateText(MainFrame, "Começar do:", UDim2.new(0, 90, 0, 18), UDim2.new(0, 8, 0, 35))
    local startInput = CreateInput(MainFrame, "1", UDim2.new(0, 170, 0, 22), UDim2.new(0, 100, 0, 35), function(value)
        Config.StartNumber = tonumber(value) or 1
    end)
    startInput.Text = tostring(Config.StartNumber or 1)
    
    -- Até o
    local endLabel = CreateText(MainFrame, "Até o:", UDim2.new(0, 90, 0, 18), UDim2.new(0, 8, 0, 62))
    local endInput = CreateInput(MainFrame, "2", UDim2.new(0, 170, 0, 22), UDim2.new(0, 100, 0, 62), function(value)
        Config.EndNumber = tonumber(value) or 2
    end)
    endInput.Text = tostring(Config.EndNumber or 2)
    
    -- Final do Prefix
    local prefixLabel = CreateText(MainFrame, "Final do Prefix:", UDim2.new(0, 90, 0, 18), UDim2.new(0, 8, 0, 89))
    local prefixInput = CreateInput(MainFrame, "!", UDim2.new(0, 170, 0, 22), UDim2.new(0, 100, 0, 89), function(value)
        Config.FinalPrompt = value or "!"
    end)
    prefixInput.Text = Config.FinalPrompt or "!"
    
    -- Pular toggle
    local skipToggle = CreateToggle(MainFrame, UDim2.new(0, 35, 0, 18), UDim2.new(0, 8, 0, 116), function(isOn)
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
    local playButton = CreatePlayButton(MainFrame, UDim2.new(1, -16, 0, 35), UDim2.new(0, 8, 0, 140), function()
        ToggleAutoJJs()
    end)
    
    -- Tornar draggable
    MakeDraggable(MainFrame)
    
    -- Mostrar notificação de carregamento
    if Modules.Notification then
        Modules.Notification:Success("Auto JJS Carregado!", "Criado por K9zzzzz", 3)
    end
end

-- Função para iniciar/parar
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
    
    -- Importar módulos das outras pastas
    if ImportModules() then
        -- Criar UI
        CreateUI()
        
        print("Auto JJS carregado!")
        print("Criado por K9zzzzz")
        print("Gambiarra do Extenso ativa - qualquer número!")
    else
        warn("Erro ao importar módulos!")
    end
end

return Main 