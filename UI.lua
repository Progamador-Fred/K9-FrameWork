-- UI.lua - Interface básica
-- Criado por K9zzzzz

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local ScreenGui, MainFrame, IsRunning, CurrentNumber, Config, Modules, I18N = nil, nil, false, 1, {}, {}, {}

-- Importar módulos
local function ImportModules()
    local modules = {}
    
    -- Carregar módulos essenciais
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
        -- Fallback pt-br
        local fallback = pcall(function()
            I18N = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/I18N/pt-br.lua'))()
        end)
        return fallback
    end
end

-- Função para enviar mensagem
local function SendMessage(numero)
    if not Modules.Extenso or not Modules.RemoteChat then return false end
    
    local numeroExtenso = Modules.Extenso:GetNumero(numero)
    local message = numeroExtenso .. (Config.FinalPrompt or "!")
    
    return Modules.RemoteChat:SendMessage(message)
end

-- Função para criar UI
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
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "K9zzzzz - Auto JJs v1.0.0"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = MainFrame
    
    -- Começar do
    local startLabel = Instance.new("TextLabel")
    startLabel.Size = UDim2.new(0.4, 0, 0, 20)
    startLabel.Position = UDim2.new(0.05, 0, 0, 40)
    startLabel.BackgroundTransparency = 1
    startLabel.Text = I18N.UI.StartFrom or "Começar do:"
    startLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    startLabel.TextScaled = true
    startLabel.Font = Enum.Font.Gotham
    startLabel.Parent = MainFrame
    
    local startInput = Instance.new("TextBox")
    startInput.Size = UDim2.new(0.5, 0, 0, 25)
    startInput.Position = UDim2.new(0.45, 0, 0, 40)
    startInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    startInput.BorderSizePixel = 0
    startInput.Text = "1"
    startInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    startInput.TextScaled = true
    startInput.Font = Enum.Font.Gotham
    startInput.Parent = MainFrame
    
    local startCorner = Instance.new("UICorner")
    startCorner.CornerRadius = UDim2.new(0, 8)
    startCorner.Parent = startInput
    
    startInput.FocusLost:Connect(function()
        Config.StartNumber = tonumber(startInput.Text) or 1
    end)
    
    -- Até o
    local endLabel = Instance.new("TextLabel")
    endLabel.Size = UDim2.new(0.4, 0, 0, 20)
    endLabel.Position = UDim2.new(0.05, 0, 0, 75)
    endLabel.BackgroundTransparency = 1
    endLabel.Text = I18N.UI.Until or "Até o:"
    endLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    endLabel.TextScaled = true
    endLabel.Font = Enum.Font.Gotham
    endLabel.Parent = MainFrame
    
    local endInput = Instance.new("TextBox")
    endInput.Size = UDim2.new(0.5, 0, 0, 25)
    endInput.Position = UDim2.new(0.45, 0, 0, 75)
    endInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    endInput.BorderSizePixel = 0
    endInput.Text = "10"
    endInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    endInput.TextScaled = true
    endInput.Font = Enum.Font.Gotham
    endInput.Parent = MainFrame
    
    local endCorner = Instance.new("UICorner")
    endCorner.CornerRadius = UDim2.new(0, 8)
    endCorner.Parent = endInput
    
    endInput.FocusLost:Connect(function()
        Config.EndNumber = tonumber(endInput.Text) or 10
    end)
    
    -- Final do Prefix
    local prefixLabel = Instance.new("TextLabel")
    prefixLabel.Size = UDim2.new(0.4, 0, 0, 20)
    prefixLabel.Position = UDim2.new(0.05, 0, 0, 110)
    prefixLabel.BackgroundTransparency = 1
    prefixLabel.Text = I18N.UI.FinalPrefix or "Final do Prefix:"
    prefixLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    prefixLabel.TextScaled = true
    prefixLabel.Font = Enum.Font.Gotham
    prefixLabel.Parent = MainFrame
    
    local prefixInput = Instance.new("TextBox")
    prefixInput.Size = UDim2.new(0.5, 0, 0, 25)
    prefixInput.Position = UDim2.new(0.45, 0, 0, 110)
    prefixInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    prefixInput.BorderSizePixel = 0
    prefixInput.Text = "!"
    prefixInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    prefixInput.TextScaled = true
    prefixInput.Font = Enum.Font.Gotham
    prefixInput.Parent = MainFrame
    
    local prefixCorner = Instance.new("UICorner")
    prefixCorner.CornerRadius = UDim2.new(0, 8)
    prefixCorner.Parent = prefixInput
    
    prefixInput.FocusLost:Connect(function()
        Config.FinalPrompt = prefixInput.Text or "!"
    end)
    
    -- Pular toggle
    local skipLabel = Instance.new("TextLabel")
    skipLabel.Size = UDim2.new(0.4, 0, 0, 20)
    skipLabel.Position = UDim2.new(0.05, 0, 0, 145)
    skipLabel.BackgroundTransparency = 1
    skipLabel.Text = I18N.UI.Skip or "Pular:"
    skipLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    skipLabel.TextScaled = true
    skipLabel.Font = Enum.Font.Gotham
    skipLabel.Parent = MainFrame
    
    local skipToggle = Instance.new("TextButton")
    skipToggle.Size = UDim2.new(0.5, 0, 0, 20)
    skipToggle.Position = UDim2.new(0.45, 0, 0, 145)
    skipToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    skipToggle.BorderSizePixel = 0
    skipToggle.Text = ""
    skipToggle.Parent = MainFrame
    
    local skipCorner = Instance.new("UICorner")
    skipCorner.CornerRadius = UDim2.new(0, 10)
    skipCorner.Parent = skipToggle
    
    local skipButton = Instance.new("Frame")
    skipButton.Size = UDim2.new(0.4, 0, 0.8, 0)
    skipButton.Position = UDim2.new(0.05, 0, 0.1, 0)
    skipButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    skipButton.BorderSizePixel = 0
    skipButton.Parent = skipToggle
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim2.new(0, 8)
    buttonCorner.Parent = skipButton
    
    local isToggled = false
    skipToggle.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        local targetPosition = isToggled and UDim2.new(0.55, 0, 0.1, 0) or UDim2.new(0.05, 0, 0.1, 0)
        local targetColor = isToggled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(80, 80, 80)
        
        TweenService:Create(skipButton, TweenInfo.new(0.2), {Position = targetPosition}):Play()
        TweenService:Create(skipButton, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
        
        Config.Skip = isToggled
    end)
    
    -- Botão play
    local playButton = Instance.new("TextButton")
    playButton.Size = UDim2.new(0.9, 0, 0, 50)
    playButton.Position = UDim2.new(0.05, 0, 0, 180)
    playButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    playButton.BorderSizePixel = 0
    playButton.Text = "▶"
    playButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    playButton.TextScaled = true
    playButton.Font = Enum.Font.GothamBold
    playButton.Parent = MainFrame
    
    local playCorner = Instance.new("UICorner")
    playCorner.CornerRadius = UDim2.new(0, 8)
    playCorner.Parent = playButton
    
    -- Draggable
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then update(input) end
    end)
    
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

return Main 