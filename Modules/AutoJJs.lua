-- Auto JJS Melhorado - Core Module
-- Criado por K9zzzzz
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

local AutoJJs = {}
AutoJJs.__index = AutoJJs

-- Variáveis de controle
local IsRunning = false
local CurrentNumber = 1
local UIVisible = true
local Config = {}
local UI = nil
local Numbers = nil
local Notification = nil

-- Função para enviar mensagem
local function SendMessage(number)
    local language = Config.Language.Words
    local numberText = Numbers:GetNumber(language, number)
    if numberText then
        local message = numberText .. Config.FinalPrompt
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
        return true
    end
    return false
end

-- Função principal do loop
local function StartAutoJJs()
    if IsRunning then return end
    
    IsRunning = true
    CurrentNumber = Config.StartNumber or 1
    
    Notification:Show("Auto JJS", "Iniciado! Começando do " .. CurrentNumber, 2)
    UI:UpdateStatus("Executando...")
    
    spawn(function()
        while IsRunning and CurrentNumber <= (Config.EndNumber or 80) do
            if SendMessage(CurrentNumber) then
                UI:UpdateCounter(CurrentNumber)
                CurrentNumber = CurrentNumber + 1
            else
                Notification:Show("Auto JJS", "Erro ao enviar mensagem!", 2)
                break
            end
            
            -- Delay com variação anti-detecção
            local delay = Config.Tempo
            if Config.AntiDetection then
                delay = delay + (math.random() - 0.5) * 0.2
            end
            wait(delay)
        end
        
        if CurrentNumber > (Config.EndNumber or 80) then
            Notification:Show("Auto JJS", "Concluído! Chegou ao número " .. (Config.EndNumber or 80), 3)
        end
        
        IsRunning = false
        UI:UpdateStatus("Parado")
    end)
end

-- Função para parar
local function StopAutoJJs()
    IsRunning = false
    Notification:Show("Auto JJS", "Parado!", 2)
    UI:UpdateStatus("Parado")
end

-- Função para toggle
local function ToggleAutoJJs()
    if IsRunning then
        StopAutoJJs()
    else
        StartAutoJJs()
    end
end

-- Função para mostrar/esconder UI
local function ToggleUI()
    UIVisible = not UIVisible
    UI:SetVisible(UIVisible)
end

-- Input handler
local function SetupInputHandler()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Config.Keybind then
            ToggleUI()
        end
    end)
end

-- Função de inicialização
function AutoJJs:Initialize(options)
    Config = options or {}
    
    -- Configurações padrão
    Config.Keybind = Config.Keybind or Enum.KeyCode.RightControl
    Config.Tempo = Config.Tempo or 2.5
    Config.Rainbow = Config.Rainbow or false
    Config.Language = Config.Language or {UI = 'pt-br', Words = 'pt-br'}
    Config.StartNumber = Config.StartNumber or 1
    Config.EndNumber = Config.EndNumber or 80
    Config.FinalPrompt = Config.FinalPrompt or "!"
    Config.AntiDetection = Config.AntiDetection ~= false
    
    -- Inicializar módulos
    UI = UI or require(script.Parent.UI)
    Numbers = Numbers or require(script.Parent.Numbers)
    Notification = Notification or require(script.Parent.Notification)
    
    -- Configurar UI
    UI:Initialize(Config)
    
    -- Configurar input handler
    SetupInputHandler()
    
    -- Configurar callbacks da UI
    UI:SetStartCallback(StartAutoJJs)
    UI:SetStopCallback(StopAutoJJs)
    UI:SetToggleCallback(ToggleAutoJJs)
    
    -- Mostrar notificação inicial
    Notification:Show("Auto JJS Melhorado", "Pressione " .. Config.Keybind.Name .. " para mostrar/esconder a UI", 4)
    
    -- Mostrar créditos
    spawn(function()
        wait(2)
        Notification:Success("K9zzzzz", "Script criado por K9zzzzz", 5)
    end)
    
    print("Auto JJS Melhorado carregado!")
    print("Pressione " .. Config.Keybind.Name .. " para mostrar/esconder a UI")
    print("Criado por K9zzzzz")
end

-- Função para atualizar configurações
function AutoJJs:UpdateConfig(newConfig)
    for key, value in pairs(newConfig) do
        Config[key] = value
    end
    
    if UI then
        UI:UpdateConfig(Config)
    end
end

-- Função para obter status
function AutoJJs:GetStatus()
    return {
        IsRunning = IsRunning,
        CurrentNumber = CurrentNumber,
        Config = Config
    }
end

return AutoJJs 