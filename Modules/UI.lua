-- Auto JJS Melhorado - UI Module
-- Criado por K9zzzzz
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local UI = {}
UI.__index = UI

-- Variáveis da UI
local ScreenGui = nil
local MainFrame = nil
local Config = {}
local Callbacks = {}

-- Textos em diferentes idiomas
local UITexts = {
    ['pt-br'] = {
        title = "Auto JJS Melhorado",
        start = "Iniciar",
        stop = "Parar",
        status = "Status:",
        counter = "Contador:",
        speed = "Velocidade:",
        language = "Idioma:",
        rainbow = "Rainbow",
        startNumber = "Início:",
        endNumber = "Fim:",
        finalPrompt = "Final:"
    },
    ['en-us'] = {
        title = "Auto JJS Improved",
        start = "Start",
        stop = "Stop",
        status = "Status:",
        counter = "Counter:",
        speed = "Speed:",
        language = "Language:",
        rainbow = "Rainbow",
        startNumber = "Start:",
        endNumber = "End:",
        finalPrompt = "Final:"
    },
    ['es-es'] = {
        title = "Auto JJS Mejorado",
        start = "Iniciar",
        stop = "Parar",
        status = "Estado:",
        counter = "Contador:",
        speed = "Velocidad:",
        language = "Idioma:",
        rainbow = "Arcoíris",
        startNumber = "Inicio:",
        endNumber = "Fin:",
        finalPrompt = "Final:"
    }
}

-- Função para criar elemento de texto
local function CreateTextLabel(parent, text, size, position, color)
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

-- Função para criar botão
local function CreateButton(parent, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.Parent = parent
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    
    -- Click effect
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return button
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
    
    input.FocusLost:Connect(function()
        if callback then
            callback(input.Text)
        end
    end)
    
    return input
end

-- Função para criar dropdown
local function CreateDropdown(parent, options, size, position, callback)
    local dropdown = Instance.new("TextButton")
    dropdown.Size = size
    dropdown.Position = position
    dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    dropdown.BorderSizePixel = 0
    dropdown.Text = options[1] or "Selecionar"
    dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdown.TextScaled = true
    dropdown.Font = Enum.Font.Gotham
    dropdown.Parent = parent
    
    local isOpen = false
    local selectedOption = options[1]
    
    dropdown.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        
        if isOpen then
            -- Criar lista de opções
            for i, option in ipairs(options) do
                local optionButton = Instance.new("TextButton")
                optionButton.Size = UDim2.new(1, 0, 0, 25)
                optionButton.Position = UDim2.new(0, 0, 0, i * 25)
                optionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                optionButton.BorderSizePixel = 0
                optionButton.Text = option
                optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                optionButton.TextScaled = true
                optionButton.Font = Enum.Font.Gotham
                optionButton.Parent = dropdown
                
                optionButton.MouseButton1Click:Connect(function()
                    selectedOption = option
                    dropdown.Text = option
                    isOpen = false
                    if callback then
                        callback(option)
                    end
                    -- Remover opções
                    for _, child in pairs(dropdown:GetChildren()) do
                        if child ~= dropdown then
                            child:Destroy()
                        end
                    end
                end)
            end
        else
            -- Remover opções
            for _, child in pairs(dropdown:GetChildren()) do
                if child ~= dropdown then
                    child:Destroy()
                end
            end
        end
    end)
    
    return dropdown
end

-- Função para criar checkbox
local function CreateCheckbox(parent, text, size, position, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, size.X.Offset + 100, 0, size.Y.Offset)
    frame.Position = position
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local checkbox = Instance.new("TextButton")
    checkbox.Size = size
    checkbox.Position = UDim2.new(0, 0, 0, 0)
    checkbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    checkbox.BorderSizePixel = 0
    checkbox.Text = ""
    checkbox.Parent = frame
    
    local label = CreateTextLabel(frame, text, UDim2.new(0, 80, 1, 0), UDim2.new(0, size.X.Offset + 10, 0, 0))
    
    local isChecked = false
    
    checkbox.MouseButton1Click:Connect(function()
        isChecked = not isChecked
        checkbox.BackgroundColor3 = isChecked and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(40, 40, 40)
        if callback then
            callback(isChecked)
        end
    end)
    
    return checkbox
end

-- Função para criar a UI principal
local function CreateMainUI()
    -- Criar ScreenGui
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AutoJJsUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Criar frame principal
    MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Título
    local title = CreateTextLabel(MainFrame, UITexts[Config.Language.UI].title, UDim2.new(1, 0, 0, 40), UDim2.new(0, 0, 0, 10))
    
    -- Status
    local statusLabel = CreateTextLabel(MainFrame, UITexts[Config.Language.UI].status, UDim2.new(0.5, -10, 0, 20), UDim2.new(0, 10, 0, 60))
    local statusValue = CreateTextLabel(MainFrame, "Parado", UDim2.new(0.5, -10, 0, 20), UDim2.new(0.5, 0, 0, 60), Color3.fromRGB(255, 0, 0))
    
    -- Contador
    local counterLabel = CreateTextLabel(MainFrame, UITexts[Config.Language.UI].counter, UDim2.new(0.5, -10, 0, 20), UDim2.new(0, 10, 0, 90))
    local counterValue = CreateTextLabel(MainFrame, "0", UDim2.new(0.5, -10, 0, 20), UDim2.new(0.5, 0, 0, 90), Color3.fromRGB(0, 255, 0))
    
    -- Velocidade
    local speedLabel = CreateTextLabel(MainFrame, UITexts[Config.Language.UI].speed, UDim2.new(0.5, -10, 0, 20), UDim2.new(0, 10, 0, 120))
    local speedInput = CreateInput(MainFrame, "2.5", UDim2.new(0.5, -10, 0, 25), UDim2.new(0.5, 0, 0, 120), function(value)
        Config.Tempo = tonumber(value) or 2.5
    end)
    speedInput.Text = tostring(Config.Tempo)
    
    -- Idioma UI
    local uiLangLabel = CreateTextLabel(MainFrame, "UI " .. UITexts[Config.Language.UI].language, UDim2.new(0.5, -10, 0, 20), UDim2.new(0, 10, 0, 160))
    local uiLangDropdown = CreateDropdown(MainFrame, {"pt-br", "en-us", "es-es"}, UDim2.new(0.5, -10, 0, 25), UDim2.new(0.5, 0, 0, 160), function(value)
        Config.Language.UI = value
        UI:RefreshTexts()
    end)
    uiLangDropdown.Text = Config.Language.UI
    
    -- Idioma Números
    local numLangLabel = CreateTextLabel(MainFrame, "Números " .. UITexts[Config.Language.UI].language, UDim2.new(0.5, -10, 0, 20), UDim2.new(0, 10, 0, 200))
    local numLangDropdown = CreateDropdown(MainFrame, {"pt-br", "en-us", "es-es"}, UDim2.new(0.5, -10, 0, 25), UDim2.new(0.5, 0, 0, 200), function(value)
        Config.Language.Words = value
    end)
    numLangDropdown.Text = Config.Language.Words
    
    -- Rainbow
    local rainbowCheckbox = CreateCheckbox(MainFrame, UITexts[Config.Language.UI].rainbow, UDim2.new(0, 20, 0, 20), UDim2.new(0, 10, 0, 240), function(checked)
        Config.Rainbow = checked
        if checked then
            UI:StartRainbow()
        else
            UI:StopRainbow()
        end
    end)
    
    -- Botões
    local startButton = CreateButton(MainFrame, UITexts[Config.Language.UI].start, UDim2.new(0.45, 0, 0, 40), UDim2.new(0.025, 0, 0, 280), function()
        if Callbacks.Start then
            Callbacks.Start()
        end
    end)
    
    local stopButton = CreateButton(MainFrame, UITexts[Config.Language.UI].stop, UDim2.new(0.45, 0, 0, 40), UDim2.new(0.525, 0, 0, 280), function()
        if Callbacks.Stop then
            Callbacks.Stop()
        end
    end)
    
    -- Armazenar referências
    UI.Elements = {
        statusValue = statusValue,
        counterValue = counterValue,
        speedInput = speedInput,
        uiLangDropdown = uiLangDropdown,
        numLangDropdown = numLangDropdown,
        rainbowCheckbox = rainbowCheckbox,
        startButton = startButton,
        stopButton = stopButton
    }
    
    -- Tornar draggable
    UI:MakeDraggable(MainFrame)
end

-- Função para tornar frame draggable
function UI:MakeDraggable(frame)
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

-- Função para iniciar rainbow
function UI:StartRainbow()
    if not Config.Rainbow then return end
    
    spawn(function()
        local hue = 0
        while Config.Rainbow and MainFrame do
            hue = (hue + 1) % 360
            local color = Color3.fromHSV(hue/360, 0.5, 0.8)
            TweenService:Create(MainFrame, TweenInfo.new(0.1), {BackgroundColor3 = color}):Play()
            wait(0.1)
        end
    end)
end

-- Função para parar rainbow
function UI:StopRainbow()
    if MainFrame then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
    end
end

-- Função para atualizar status
function UI:UpdateStatus(status)
    if UI.Elements and UI.Elements.statusValue then
        UI.Elements.statusValue.Text = status
        if status == "Executando..." then
            UI.Elements.statusValue.TextColor3 = Color3.fromRGB(0, 255, 0)
        else
            UI.Elements.statusValue.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
    end
end

-- Função para atualizar contador
function UI:UpdateCounter(number)
    if UI.Elements and UI.Elements.counterValue then
        UI.Elements.counterValue.Text = tostring(number)
    end
end

-- Função para mostrar/esconder UI
function UI:SetVisible(visible)
    if ScreenGui then
        ScreenGui.Enabled = visible
    end
end

-- Função para configurar callbacks
function UI:SetStartCallback(callback)
    Callbacks.Start = callback
end

function UI:SetStopCallback(callback)
    Callbacks.Stop = callback
end

function UI:SetToggleCallback(callback)
    Callbacks.Toggle = callback
end

-- Função para atualizar configurações
function UI:UpdateConfig(newConfig)
    Config = newConfig
    if UI.Elements then
        UI.Elements.speedInput.Text = tostring(Config.Tempo)
        UI.Elements.uiLangDropdown.Text = Config.Language.UI
        UI.Elements.numLangDropdown.Text = Config.Language.Words
    end
end

-- Função para atualizar textos
function UI:RefreshTexts()
    -- Recriar UI com novos textos
    if ScreenGui then
        ScreenGui:Destroy()
    end
    CreateMainUI()
end

-- Função de inicialização
function UI:Initialize(config)
    Config = config or {}
    CreateMainUI()
    
    if Config.Rainbow then
        UI:StartRainbow()
    end
end

return UI 