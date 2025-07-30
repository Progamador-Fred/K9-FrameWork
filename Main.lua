-- Auto JJS v1.0.0 - Main.lua
-- Script completo e funcional
-- Criado por K9zzzzz

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local ScreenGui, MainFrame, IsRunning, CurrentNumber, Config, Modules, I18N = nil, nil, false, 1, {}, {}, {}

-- Importar módulos
local function ImportModules()
    local modules = {}
    
    local success1, ext = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/Extenso.lua'))()
    end)
    
    local success2, chat = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/RemoteChat.lua'))()
    end)
    
    local success3, notif = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Notification.lua'))()
    end)
    
    if success1 then modules.Extenso = ext end
    if success2 then modules.RemoteChat = chat end
    if success3 then modules.Notification = notif end
    
    Modules = modules
    return success1 and success2
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
        local fallback = pcall(function()
            I18N = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/I18N/pt-br.lua'))()
        end)
        return fallback
    end
end

-- Enviar mensagem
local function SendMessage(numero)
    if not Modules.Extenso or not Modules.RemoteChat then return false end
    
    local numeroExtenso = Modules.Extenso:GetNumero(numero)
    local message = numeroExtenso .. (Config.FinalPrompt or "!")
    
    return Modules.RemoteChat:SendMessage(message)
end

-- Criar texto
local function CreateText(parent, text, size, position, color, font)
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
local function CreateInput(parent, placeholder, size, position, callback)
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
local function CreateToggle(parent, size, position, callback)
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
local function CreateButton(parent, text, size, position, callback)
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

-- Tornar draggable
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

-- Criar UI
local function CreateUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AutoJJsUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Frame principal
    MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 200, 0, 280)
    MainFrame.Position = UDim2.new(0.5, -100, 0.5, -140)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim2.new(0, 12)
    corner.Parent = MainFrame
    
    -- Título
    CreateText(MainFrame, "K9zzzzz - Auto JJs v1.0.0", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 5), Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold)
    
    -- Começar do
    CreateText(MainFrame, I18N.UI.StartFrom or "Começar do:", UDim2.new(0.4, 0, 0, 20), UDim2.new(0.05, 0, 0, 40))
    local startInput = CreateInput(MainFrame, "1", UDim2.new(0.5, 0, 0, 25), UDim2.new(0.45, 0, 0, 40), function(value)
        Config.StartNumber = tonumber(value) or 1
    end)
    startInput.Text = "1"
    
    -- Até o
    CreateText(MainFrame, I18N.UI.Until or "Até o:", UDim2.new(0.4, 0, 0, 20), UDim2.new(0.05, 0, 0, 75))
    local endInput = CreateInput(MainFrame, "10", UDim2.new(0.5, 0, 0, 25), UDim2.new(0.45, 0, 0, 75), function(value)
        Config.EndNumber = tonumber(value) or 10
    end)
    endInput.Text = "10"
    
    -- Final do Prefix
    CreateText(MainFrame, I18N.UI.FinalPrefix or "Final do Prefix:", UDim2.new(0.4, 0, 0, 20), UDim2.new(0.05, 0, 0, 110))
    local prefixInput = CreateInput(MainFrame, "!", UDim2.new(0.5, 0, 0, 25), UDim2.new(0.45, 0, 0, 110), function(value)
        Config.FinalPrompt = value or "!"
    end)
    prefixInput.Text = "!"
    
    -- Pular toggle
    CreateText(MainFrame, I18N.UI.Skip or "Pular:", UDim2.new(0.4, 0, 0, 20), UDim2.new(0.05, 0, 0, 145))
    CreateToggle(MainFrame, UDim2.new(0.5, 0, 0, 20), UDim2.new(0.45, 0, 0, 145), function(toggled)
        Config.Skip = toggled
    end)
    
    -- Botão play
    local playButton = CreateButton(MainFrame, "▶", UDim2.new(0.9, 0, 0, 50), UDim2.new(0.05, 0, 0, 180))
    
    -- Tornar draggable
    MakeDraggable(MainFrame)
    
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
    
    playButton.MouseButton1Click:Connect(ToggleAutoJJs)
    
    -- Notificação de carregamento
    if Modules.Notification then
        Modules.Notification:ShowI18N(I18N, "Loaded", 3)
    end
end

-- Função principal
local function Main(Options)
    Config = Options or {}
    Config.StartNumber = 1
    Config.EndNumber = 10
    Config.FinalPrompt = "!"
    Config.Tempo = Config.Tempo or 2.5
    Config.Language = Config.Language or "pt-br"
    
    if ImportI18N(Config.Language) and ImportModules() then
        CreateUI()
        print("Auto JJS v1.0.0 carregado!")
        print("Criado por K9zzzzz")
    else
        warn("Erro ao carregar módulos!")
    end
end

-- Executar imediatamente se não houver argumentos
if not script.Parent then
    Main()
else
    return Main
end 