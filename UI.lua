-- UI.lua - Interface moderna e rainbow
-- Criado por K9zzzzz

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

local ScreenGui, MainFrame, IsRunning, CurrentNumber, Config, Modules, I18N = nil, nil, false, 1, {}, {}, {}

-- Importar módulos
local function ImportModules()
    local modules = {}
    
    -- Importar Character
    local success1, char = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/Character.lua'))()
    end)
    
    -- Importar Extenso
    local success2, ext = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/Extenso.lua'))()
    end)
    
    -- Importar RemoteChat
    local success3, chat = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/RemoteChat.lua'))()
    end)
    
    -- Importar Request
    local success4, req = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/Request.lua'))()
    end)
    
    -- Importar Notification (da pasta principal)
    local success5, notif = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Notification.lua'))()
    end)
    
    if success1 then modules.Character = char end
    if success2 then modules.Extenso = ext end
    if success3 then modules.RemoteChat = chat end
    if success4 then modules.Request = req end
    if success5 then modules.Notification = notif end
    
    Modules = modules
    return success2 and success3 -- Extenso e RemoteChat são essenciais
end

-- Importar I18N
local function ImportI18N(language)
    local success, translations = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/I18N/' .. language .. '.lua'))()
    end)
    
    if success then
        I18N = translations
        return true
    else
        -- Fallback para pt-br
        local fallback = pcall(function()
            I18N = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/I18N/pt-br.lua'))()
        end)
        return fallback
    end
end

-- Rainbow effect
local function RainbowColor(t)
    local h = (tick() * 0.25 + t) % 1
    return Color3.fromHSV(h, 0.8, 1)
end

-- Função para criar texto estilizado
local function CreateText(parent, text, size, position, color, bold)
    local label = Instance.new("TextLabel")
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    label.Parent = parent
    return label
end

-- Função para criar input arredondado
local function CreateInput(parent, placeholder, size, position, callback)
    local input = Instance.new("TextBox")
    input.Size = size
    input.Position = position
    input.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    input.BorderSizePixel = 0
    input.PlaceholderText = placeholder
    input.Text = ""
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.TextScaled = true
    input.Font = Enum.Font.Gotham
    input.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim2.new(0, 16)
    corner.Parent = input
    
    input.Focused:Connect(function()
        TweenService:Create(input, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
    end)
    
    input.FocusLost:Connect(function()
        TweenService:Create(input, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}):Play()
        if callback then callback(input.Text) end
    end)
    
    return input
end

-- Função para criar botão rainbow arredondado
local function CreateRainbowButton(parent, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim2.new(0, 16)
    corner.Parent = button
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Parent = button
    
    -- Rainbow animation
    RunService.RenderStepped:Connect(function()
        stroke.Color = RainbowColor(0.1)
    end)
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}):Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    return button
end

-- Função para tornar frame draggable (PC e Mobile)
local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then update(input) end
    end)
end

-- Função para enviar mensagem usando módulos
local function SendMessage(numero)
    if not Modules.Extenso or not Modules.RemoteChat then 
        warn("Módulos não importados!") 
        return false 
    end
    
    local numeroExtenso = Modules.Extenso:GetNumero(numero)
    local message = numeroExtenso .. (Config.FinalPrompt or "!")
    
    return Modules.RemoteChat:SendMessage(message)
end

-- Função para criar a UI moderna e rainbow
local function CreateUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AutoJJsUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Frame ocupa 1/8 largura e 1/2 altura, centralizado
    MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0.125, 0, 0.5, 0)
    MainFrame.Position = UDim2.new(0.4375, 0, 0.25, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim2.new(0, 24)
    corner.Parent = MainFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 3
    stroke.Parent = MainFrame
    
    -- Rainbow border animation
    RunService.RenderStepped:Connect(function()
        stroke.Color = RainbowColor(0)
    end)
    
    -- Título rainbow
    local title = CreateText(MainFrame, "K9zzzzz - Auto JJs v2.1", UDim2.new(1, 0, 0, 40), UDim2.new(0, 0, 0, 0), Color3.fromRGB(255,255,255), true)
    RunService.RenderStepped:Connect(function()
        title.TextColor3 = RainbowColor(0.2)
    end)
    
    -- Começar do
    local startLabel = CreateText(MainFrame, I18N.UI.StartFrom or "Começar do", UDim2.new(0.8, 0, 0, 28), UDim2.new(0.1, 0, 0, 60))
    local startInput = CreateInput(MainFrame, "1", UDim2.new(0.8, 0, 0, 32), UDim2.new(0.1, 0, 0, 90), function(value)
        Config.StartNumber = tonumber(value) or 1
    end)
    startInput.Text = tostring(Config.StartNumber or 1)
    
    -- Até o
    local endLabel = CreateText(MainFrame, I18N.UI.Until or "Até o", UDim2.new(0.8, 0, 0, 28), UDim2.new(0.1, 0, 0, 140))
    local endInput = CreateInput(MainFrame, "10", UDim2.new(0.8, 0, 0, 32), UDim2.new(0.1, 0, 0, 170), function(value)
        Config.EndNumber = tonumber(value) or 10
    end)
    endInput.Text = tostring(Config.EndNumber or 10)
    
    -- Final do Prefix
    local prefixLabel = CreateText(MainFrame, I18N.UI.FinalPrefix or "Final do Prefix", UDim2.new(0.8, 0, 0, 28), UDim2.new(0.1, 0, 0, 220))
    local prefixInput = CreateInput(MainFrame, "!", UDim2.new(0.8, 0, 0, 32), UDim2.new(0.1, 0, 0, 250), function(value)
        Config.FinalPrompt = value or "!"
    end)
    prefixInput.Text = Config.FinalPrompt or "!"
    
    -- Botão de pular rainbow
    local playButton = CreateRainbowButton(MainFrame, I18N.UI.StartButton or "▶ PULAR", UDim2.new(0.8, 0, 0, 44), UDim2.new(0.1, 0, 0, 310), function()
        ToggleAutoJJs()
    end)
    
    -- Tornar draggable (PC e Mobile)
    MakeDraggable(MainFrame)
    
    -- Notificação de carregamento
    if Modules.Notification then
        Modules.Notification:ShowI18N(I18N, "Loaded", 3)
    end
end



-- Função para iniciar/parar
local function ToggleAutoJJs()
    if IsRunning then
        IsRunning = false
        if Modules.Notification then
            Modules.Notification:ShowI18N(I18N, "Stopped", 2)
        end
        return
    end
    
    IsRunning = true
    CurrentNumber = Config.StartNumber or 1
    local endNumber = Config.EndNumber or 10
    
    if Modules.Notification then
        Modules.Notification:ShowI18NWithVars(I18N, "Started", {start = CurrentNumber, end = endNumber}, 3)
    end
    
    spawn(function()
        while IsRunning and CurrentNumber <= endNumber do
            if SendMessage(CurrentNumber) then
                CurrentNumber = CurrentNumber + 1
                
                -- Mostrar progresso a cada 10 números
                if CurrentNumber % 10 == 0 and Modules.Notification then
                    Modules.Notification:ShowI18NWithVars(I18N, "Progress", {current = CurrentNumber - 1}, 1)
                end
            else
                if Modules.Notification then
                    Modules.Notification:ShowI18N(I18N, "Error", 3)
                end
                break
            end
            
            wait(Config.Tempo or 2.5)
        end
        
        IsRunning = false
        if Modules.Notification then
            Modules.Notification:ShowI18N(I18N, "Completed", 3)
        end
    end)
end

-- Função principal
local function Main(Options)
    Config = Options or {}
    
    -- Configurações padrão
    Config.StartNumber = 1
    Config.EndNumber = 10
    Config.FinalPrompt = "!"
    Config.Tempo = Config.Tempo or 2.5
    Config.Language = Config.Language or "pt-br"
    
    -- Importar I18N primeiro
    if ImportI18N(Config.Language) then
        -- Importar módulos
        if ImportModules() then
            -- Criar UI
            CreateUI()
            
            print("Auto JJS v2.1 carregado!")
            print("Criado por K9zzzzz")
            print("Gambiarra do Extenso ativa - qualquer número!")
        else
            warn("Erro ao importar módulos!")
        end
    else
        warn("Erro ao importar I18N!")
    end
end

return Main 