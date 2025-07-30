-- UI.lua - Interface minimalista
-- Criado por K9zzzzz

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local ScreenGui, MainFrame, IsRunning, CurrentNumber, Config, Modules, I18N = nil, nil, false, 1, {}, {}, {}

-- Função para carregar com retry
local function LoadWithRetry(url, maxRetries)
    maxRetries = maxRetries or 3
    
    for attempt = 1, maxRetries do
        local success, result = pcall(function()
            return game:HttpGet(url, true)
        end)
        
        if success then
            return result
        else
            if attempt < maxRetries then
                wait(2) -- Esperar 2 segundos antes de tentar novamente
            end
        end
    end
    
    return nil
end

-- Função para carregar módulo com retry
local function LoadModule(url, maxRetries)
    maxRetries = maxRetries or 3
    
    for attempt = 1, maxRetries do
        local success, result = pcall(function()
            local content = LoadWithRetry(url)
            if content then
                return loadstring(content)()
            end
            return nil
        end)
        
        if success and result then
            return result
        else
            if attempt < maxRetries then
                wait(2)
            end
        end
    end
    
    return nil
end

-- Importar módulos
local function ImportModules()
    local modules = {}
    
    -- URLs dos módulos
    local moduleUrls = {
        Character = 'https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/Character.lua',
        Extenso = 'https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/Extenso.lua',
        RemoteChat = 'https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/RemoteChat.lua',
        Request = 'https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/Request.lua',
        Notification = 'https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Notification.lua'
    }
    
    -- Carregar cada módulo
    for name, url in pairs(moduleUrls) do
        local module = LoadModule(url)
        if module then
            modules[name] = module
            print("✓ Módulo " .. name .. " carregado com sucesso")
        else
            warn("✗ Falha ao carregar módulo " .. name)
        end
    end
    
    Modules = modules
    return modules.Extenso and modules.RemoteChat -- Extenso e RemoteChat são essenciais
end

-- Importar I18N
local function ImportI18N(language)
    local url = 'https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/I18N/' .. language .. '.lua'
    
    local translations = LoadModule(url)
    if translations then
        I18N = translations
        print("✓ I18N " .. language .. " carregado com sucesso")
        return true
    else
        -- Fallback para pt-br
        local fallbackUrl = 'https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/I18N/pt-br.lua'
        local fallback = LoadModule(fallbackUrl)
        if fallback then
            I18N = fallback
            print("✓ I18N pt-br (fallback) carregado com sucesso")
            return true
        else
            warn("✗ Falha ao carregar I18N")
            return false
        end
    end
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

-- Função para criar input arredondado
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

-- Função para criar toggle
local function CreateToggle(parent, size, position, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = size
    toggleFrame.Position = position
    toggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleFrame.BorderSizePixel = 0
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
    
    toggleFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isToggled = not isToggled
            
            local targetPosition = isToggled and UDim2.new(0.55, 0, 0.1, 0) or UDim2.new(0.05, 0, 0.1, 0)
            local targetColor = isToggled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(80, 80, 80)
            
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {Position = targetPosition}):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
            
            if callback then callback(isToggled) end
        end
    end)
    
    return toggleFrame
end

-- Função para criar botão play
local function CreatePlayButton(parent, size, position, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.BorderSizePixel = 0
    button.Text = "▶"
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

-- Função para tornar frame draggable
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

-- Função para criar a UI
local function CreateUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AutoJJsUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Frame principal (compacto)
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
    local title = CreateText(MainFrame, "K9zzzzz - Auto JJs v1.0.0", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 5), Color3.fromRGB(255, 255, 255))
    title.Font = Enum.Font.GothamBold
    
    -- Começar do
    local startLabel = CreateText(MainFrame, "Começar do:", UDim2.new(0.4, 0, 0, 20), UDim2.new(0.05, 0, 0, 40))
    local startInput = CreateInput(MainFrame, "1", UDim2.new(0.5, 0, 0, 25), UDim2.new(0.45, 0, 0, 40), function(value)
        Config.StartNumber = tonumber(value) or 1
    end)
    startInput.Text = tostring(Config.StartNumber or 1)
    
    -- Até o
    local endLabel = CreateText(MainFrame, "Até o:", UDim2.new(0.4, 0, 0, 20), UDim2.new(0.05, 0, 0, 75))
    local endInput = CreateInput(MainFrame, "10", UDim2.new(0.5, 0, 0, 25), UDim2.new(0.45, 0, 0, 75), function(value)
        Config.EndNumber = tonumber(value) or 10
    end)
    endInput.Text = tostring(Config.EndNumber or 10)
    
    -- Final do Prefix
    local prefixLabel = CreateText(MainFrame, "Final do Prefix:", UDim2.new(0.4, 0, 0, 20), UDim2.new(0.05, 0, 0, 110))
    local prefixInput = CreateInput(MainFrame, "!", UDim2.new(0.5, 0, 0, 25), UDim2.new(0.45, 0, 0, 110), function(value)
        Config.FinalPrompt = value or "!"
    end)
    prefixInput.Text = Config.FinalPrompt or "!"
    
    -- Pular toggle
    local skipLabel = CreateText(MainFrame, "Pular:", UDim2.new(0.4, 0, 0, 20), UDim2.new(0.05, 0, 0, 145))
    local skipToggle = CreateToggle(MainFrame, UDim2.new(0.5, 0, 0, 20), UDim2.new(0.45, 0, 0, 145), function(toggled)
        Config.Skip = toggled
    end)
    
    -- Botão play
    local playButton = CreatePlayButton(MainFrame, UDim2.new(0.9, 0, 0, 50), UDim2.new(0.05, 0, 0, 180), function()
        ToggleAutoJJs()
    end)
    
    -- Tornar draggable
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
    Config.Tempo = Config.Tempo or 2.5
    Config.Language = Config.Language or "pt-br"
    
    print("🔄 Carregando Auto JJS v1.0.0...")
    print("📡 Conectando aos módulos...")
    
    -- Importar I18N primeiro
    if ImportI18N(Config.Language) then
        -- Importar módulos
        if ImportModules() then
            -- Criar UI
            CreateUI()
            
            print("✅ Auto JJS v1.0.0 carregado com sucesso!")
            print("👨‍💻 Criado por K9zzzzz")
        else
            warn("❌ Erro ao importar módulos!")
        end
    else
        warn("❌ Erro ao importar I18N!")
    end
end

return Main 