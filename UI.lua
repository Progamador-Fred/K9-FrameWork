-- UI.lua
-- Interface gráfica completa e moderna
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
        test = "Testar Chat",
        status = "Status:",
        counter = "Contador:",
        speed = "Velocidade:",
        language = "Idioma:",
        rainbow = "Rainbow",
        chatType = "Tipo de Chat:",
        startNumber = "Número Inicial:",
        endNumber = "Número Final:",
        infinite = "Infinito",
        prompt = "Prompt Final:"
    },
    ['en-us'] = {
        title = "Auto JJS Improved",
        start = "Start",
        stop = "Stop",
        test = "Test Chat",
        status = "Status:",
        counter = "Counter:",
        speed = "Speed:",
        language = "Language:",
        rainbow = "Rainbow",
        chatType = "Chat Type:",
        startNumber = "Start Number:",
        endNumber = "End Number:",
        infinite = "Infinite",
        prompt = "Final Prompt:"
    },
    ['es-es'] = {
        title = "Auto JJS Mejorado",
        start = "Iniciar",
        stop = "Parar",
        test = "Probar Chat",
        status = "Estado:",
        counter = "Contador:",
        speed = "Velocidad:",
        language = "Idioma:",
        rainbow = "Arcoíris",
        chatType = "Tipo de Chat:",
        startNumber = "Número Inicial:",
        endNumber = "Número Final:",
        infinite = "Infinito",
        prompt = "Prompt Final:"
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
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = dropdown
    
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
                        if child ~= dropdown and child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                end)
            end
        else
            -- Remover opções
            for _, child in pairs(dropdown:GetChildren()) do
                if child ~= dropdown and child:IsA("TextButton") then
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
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = checkbox
    
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
    
    -- Criar frame principal (aumentado para acomodar novos campos)
    MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 350, 0, 550)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -275)
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
    local title = CreateTextLabel(MainFrame, UITexts[Config.Language.UI].title, UDim2.new(1, 0, 0, 40), UDim2.new(0, 0, 0, 10))
    
    -- Status
    local statusLabel = CreateTextLabel(MainFrame, UITexts[Config.Language.UI].status, UDim2.new(0.5, -10, 0, 20), UDim2.new(0, 10, 0, 60))
    local statusValue = CreateTextLabel(MainFrame, "Parado", UDim2.new(0.5, -10, 0, 20), UDim2.new(0.5, 0, 0, 60), Color3.fromRGB(255, 0, 0))
    
    -- Contador
    local counterLabel = CreateTextLabel(MainFrame, UITexts[Config.Language.UI].counter, UDim2.new(0.5, -10, 0, 20), UDim2.new(0, 10, 0, 90))
    local counterValue = CreateTextLabel(MainFrame, "0", UDim2.new(0.5, -10, 0, 20), UDim2.new(0.5, 0, 0, 90), Color3.fromRGB(0, 255, 0))
    
    -- Tipo de Chat
    local chatTypeLabel = CreateTextLabel(MainFrame, UITexts[Config.Language.UI].chatType, UDim2.new(0.5, -10, 0, 20), UDim2.new(0, 10, 0, 120))
    local chatTypeValue = CreateTextLabel(MainFrame, "Detectando...", UDim2.new(0.5, -10, 0, 20), UDim2.new(0.5, 0, 0, 120), Color3.fromRGB(255, 255, 0))
    
    -- Número Inicial
    local startNumberLabel = CreateTextLabel(MainFrame, UITexts[Config.Language.UI].startNumber, UDim2.new(0.5, -10, 0, 20), UDim2.new(0, 10, 0, 150))
    local startNumberInput = CreateInput(MainFrame, "1", UDim2.new(0.5, -10, 0, 25), UDim2.new(0.5, 0, 0, 150), function(value)
        Config.StartNumber = tonumber(value) or 1
    end)
    startNumberInput.Text = tostring(Config.StartNumber or 1)
    
    -- Número Final
    local endNumberLabel = CreateTextLabel(MainFrame, UITexts[Config.Language.UI].endNumber, UDim2.new(0.5, -10, 0, 20), UDim2.new(0, 10, 0, 190))
    local endNumberInput = CreateInput(MainFrame, "80", UDim2.new(0.5, -10, 0, 25), UDim2.new(0.5, 0, 0, 190), function(value)
        Config.EndNumber = tonumber(value) or 80
    end)
    endNumberInput.Text = tostring(Config.EndNumber or 80)
    
    -- Prompt Final
    local promptLabel = CreateTextLabel(MainFrame, UITexts[Config.Language.UI].prompt, UDim2.new(0.5, -10, 0, 20), UDim2.new(0, 10, 0, 230))
    local promptInput = CreateInput(MainFrame, "!", UDim2.new(0.5, -10, 0, 25), UDim2.new(0.5, 0, 0, 230), function(value)
        Config.FinalPrompt = value or "!"
    end)
    promptInput.Text = Config.FinalPrompt or "!"
    
    -- Velocidade
    local speedLabel = CreateTextLabel(MainFrame, UITexts[Config.Language.UI].speed, UDim2.new(0.5, -10, 0, 20), UDim2.new(0, 10, 0, 270))
    local speedInput = CreateInput(MainFrame, "2.5", UDim2.new(0.5, -10, 0, 25), UDim2.new(0.5, 0, 0, 270), function(value)
        Config.Tempo = tonumber(value) or 2.5
    end)
    speedInput.Text = tostring(Config.Tempo)
    
    -- Idioma UI
    local uiLangLabel = CreateTextLabel(MainFrame, "UI " .. UITexts[Config.Language.UI].language, UDim2.new(0.5, -10, 0, 20), UDim2.new(0, 10, 0, 310))
    local uiLangDropdown = CreateDropdown(MainFrame, {"pt-br", "en-us", "es-es"}, UDim2.new(0.5, -10, 0, 25), UDim2.new(0.5, 0, 0, 310), function(value)
        Config.Language.UI = value
        UI:RefreshTexts()
    end)
    uiLangDropdown.Text = Config.Language.UI
    
    -- Idioma Números
    local numLangLabel = CreateTextLabel(MainFrame, "Números " .. UITexts[Config.Language.UI].language, UDim2.new(0.5, -10, 0, 20), UDim2.new(0, 10, 0, 350))
    local numLangDropdown = CreateDropdown(MainFrame, {"pt-br", "en-us", "es-es"}, UDim2.new(0.5, -10, 0, 25), UDim2.new(0.5, 0, 0, 350), function(value)
        Config.Language.Words = value
    end)
    numLangDropdown.Text = Config.Language.Words
    
    -- Rainbow
    local rainbowCheckbox = CreateCheckbox(MainFrame, UITexts[Config.Language.UI].rainbow, UDim2.new(0, 20, 0, 20), UDim2.new(0, 10, 0, 390), function(checked)
        Config.Rainbow = checked
        if checked then
            UI:StartRainbow()
        else
            UI:StopRainbow()
        end
    end)
    
    -- Botões
    local startButton = CreateButton(MainFrame, UITexts[Config.Language.UI].start, UDim2.new(0.3, 0, 0, 40), UDim2.new(0.025, 0, 0, 440), function()
        if Callbacks.Start then
            Callbacks.Start()
        end
    end)
    
    local stopButton = CreateButton(MainFrame, UITexts[Config.Language.UI].stop, UDim2.new(0.3, 0, 0, 40), UDim2.new(0.35, 0, 0, 440), function()
        if Callbacks.Stop then
            Callbacks.Stop()
        end
    end)
    
    local testButton = CreateButton(MainFrame, UITexts[Config.Language.UI].test, UDim2.new(0.3, 0, 0, 40), UDim2.new(0.675, 0, 0, 440), function()
        if Callbacks.Test then
            Callbacks.Test()
        end
    end)
    
    -- Armazenar referências
    UI.Elements = {
        statusValue = statusValue,
        counterValue = counterValue,
        chatTypeValue = chatTypeValue,
        startNumberInput = startNumberInput,
        endNumberInput = endNumberInput,
        promptInput = promptInput,
        speedInput = speedInput,
        uiLangDropdown = uiLangDropdown,
        numLangDropdown = numLangDropdown,
        rainbowCheckbox = rainbowCheckbox,
        startButton = startButton,
        stopButton = stopButton,
        testButton = testButton
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

-- Função para atualizar tipo de chat
function UI:UpdateChatType(chatType)
    if UI.Elements and UI.Elements.chatTypeValue then
        UI.Elements.chatTypeValue.Text = chatType
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

function UI:SetTestCallback(callback)
    Callbacks.Test = callback
end

-- Função para atualizar configurações
function UI:UpdateConfig(newConfig)
    Config = newConfig
    if UI.Elements then
        UI.Elements.speedInput.Text = tostring(Config.Tempo)
        UI.Elements.startNumberInput.Text = tostring(Config.StartNumber or 1)
        UI.Elements.endNumberInput.Text = tostring(Config.EndNumber or 80)
        UI.Elements.promptInput.Text = Config.FinalPrompt or "!"
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