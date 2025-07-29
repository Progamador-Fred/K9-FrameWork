-- UI.lua - Interface igual ao zy_yz
-- Criado por K9zzzzz

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

-- Variáveis
local ScreenGui = nil
local MainFrame = nil
local IsRunning = false
local CurrentNumber = 1
local Config = {}

-- Carregar módulos
local Extenso = require(script.Parent.Modules.Extenso)
local RemoteChat = require(script.Parent.Modules.RemoteChat)

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

-- Função para criar input
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
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = input
    
    input.FocusLost:Connect(function()
        if callback then
            callback(input.Text)
        end
    end)
    
    return input
end

-- Função para criar toggle
local function CreateToggle(parent, size, position, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, size.X.Offset + 60, 0, size.Y.Offset)
    frame.Position = position
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 40, 0, 20)
    toggle.Position = UDim2.new(0, 0, 0, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggle.BorderSizePixel = 0
    toggle.Text = ""
    toggle.Parent = frame
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = toggle
    
    -- Handle
    local handle = Instance.new("Frame")
    handle.Size = UDim2.new(0, 16, 0, 16)
    handle.Position = UDim2.new(0, 2, 0, 2)
    handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    handle.BorderSizePixel = 0
    handle.Parent = toggle
    
    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(0, 8)
    handleCorner.Parent = handle
    
    -- Label
    local label = CreateText(frame, "Pular:", UDim2.new(0, 50, 1, 0), UDim2.new(0, 50, 0, 0))
    
    local isOn = false
    
    toggle.MouseButton1Click:Connect(function()
        isOn = not isOn
        if isOn then
            TweenService:Create(handle, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0, 2)}):Play()
            toggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            TweenService:Create(handle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2)}):Play()
            toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
        if callback then
            callback(isOn)
        end
    end)
    
    return toggle
end

-- Função para criar botão play
local function CreatePlayButton(parent, size, position, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
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
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return button
end

-- Função para criar a UI
local function CreateUI()
    -- Criar ScreenGui
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AutoJJsUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Criar frame principal
    MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 200)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = MainFrame
    
    -- Stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.8
    stroke.Thickness = 1
    stroke.Parent = MainFrame
    
    -- Título
    local titleFrame = Instance.new("Frame")
    titleFrame.Size = UDim2.new(1, 0, 0, 30)
    titleFrame.Position = UDim2.new(0, 0, 0, 0)
    titleFrame.BackgroundTransparency = 1
    titleFrame.Parent = MainFrame
    
    local zvText = CreateText(titleFrame, "Zv_yz", UDim2.new(0, 50, 1, 0), UDim2.new(0, 10, 0, 0), Color3.fromRGB(0, 255, 0))
    local autoText = CreateText(titleFrame, " - Auto", UDim2.new(0, 80, 1, 0), UDim2.new(0, 60, 0, 0))
    local jjsText = CreateText(titleFrame, "JJs[2.1]", UDim2.new(0, 80, 1, 0), UDim2.new(0, 140, 0, 0), Color3.fromRGB(255, 0, 0))
    
    -- Começar do
    local startLabel = CreateText(MainFrame, "Começar do:", UDim2.new(0, 100, 0, 20), UDim2.new(0, 10, 0, 40))
    local startInput = CreateInput(MainFrame, "1", UDim2.new(0, 180, 0, 25), UDim2.new(0, 110, 0, 40), function(value)
        Config.StartNumber = tonumber(value) or 1
    end)
    startInput.Text = tostring(Config.StartNumber or 1)
    
    -- Até o
    local endLabel = CreateText(MainFrame, "Até o:", UDim2.new(0, 100, 0, 20), UDim2.new(0, 10, 0, 70))
    local endInput = CreateInput(MainFrame, "2", UDim2.new(0, 180, 0, 25), UDim2.new(0, 110, 0, 70), function(value)
        Config.EndNumber = tonumber(value) or 2
    end)
    endInput.Text = tostring(Config.EndNumber or 2)
    
    -- Final do Prefix
    local prefixLabel = CreateText(MainFrame, "Final do Prefix:", UDim2.new(0, 100, 0, 20), UDim2.new(0, 10, 0, 100))
    local prefixInput = CreateInput(MainFrame, "!", UDim2.new(0, 180, 0, 25), UDim2.new(0, 110, 0, 100), function(value)
        Config.FinalPrompt = value or "!"
    end)
    prefixInput.Text = Config.FinalPrompt or "!"
    
    -- Pular toggle
    local skipToggle = CreateToggle(MainFrame, UDim2.new(0, 40, 0, 20), UDim2.new(0, 10, 0, 130), function(isOn)
        Config.SkipMode = isOn
    end)
    
    -- Botão play
    local playButton = CreatePlayButton(MainFrame, UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 160), function()
        ToggleAutoJJs()
    end)
    
    -- Tornar draggable
    MakeDraggable(MainFrame)
end

-- Função para tornar frame draggable
function MakeDraggable(frame)
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

-- Função para enviar mensagem
local function SendMessage(numero)
    -- Usar a gambiarra do Extenso para converter qualquer número
    local numeroExtenso = Extenso:GetNumero(numero)
    local message = numeroExtenso .. (Config.FinalPrompt or "!")
    
    return RemoteChat:SendMessage(message)
end

-- Função para iniciar/parar
local function ToggleAutoJJs()
    if IsRunning then
        IsRunning = false
        return
    end
    
    IsRunning = true
    CurrentNumber = Config.StartNumber or 1
    local endNumber = Config.EndNumber or 2
    
    spawn(function()
        while IsRunning and CurrentNumber <= endNumber do
            if SendMessage(CurrentNumber) then
                CurrentNumber = CurrentNumber + 1
            else
                break
            end
            
            -- Delay
            wait(Config.Tempo or 2.5)
        end
        
        IsRunning = false
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
    
    -- Criar UI
    CreateUI()
    
    print("Auto JJS carregado!")
    print("Criado por K9zzzzz")
    print("Gambiarra do Extenso ativa - qualquer número!")
end

return Main 