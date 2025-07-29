-- Auto JJS Melhorado - Core Module
-- Criado por K9zzzzz
-- Sistema completo com adaptação automática

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
local ChatAdapter = nil

-- Função para enviar mensagem usando ChatAdapter
local function SendMessage(number)
    if not ChatAdapter or not ChatAdapter:IsWorking() then
        warn("AutoJJs: ChatAdapter não está funcionando")
        return false
    end
    
    local language = Config.Language.Words
    local numberText = Numbers:GetNumber(language, number)
    if numberText then
        local message = numberText .. Config.FinalPrompt
        return ChatAdapter:SendMessage(message)
    end
    return false
end

-- Função para validar configurações
local function ValidateConfig()
    local startNum = Config.StartNumber or 1
    local endNum = Config.EndNumber or 80
    
    -- Validar números
    if startNum < 1 then
        startNum = 1
        Config.StartNumber = 1
    end
    
    if endNum < startNum then
        endNum = startNum
        Config.EndNumber = startNum
    end
    
    -- Limitar número máximo para evitar spam excessivo
    if endNum > 100000000 then
        endNum = 100000000
        Config.EndNumber = 100000000
        Notification:Warning("Auto JJS", "Número final limitado a 100.000.000", 3)
    end
    
    return startNum, endNum
end

-- Função principal do loop
local function StartAutoJJs()
    if IsRunning then return end
    
    -- Validar configurações
    local startNum, endNum = ValidateConfig()
    
    IsRunning = true
    CurrentNumber = startNum
    
    local message = "Iniciado! Começando do " .. startNum
    if endNum > startNum then
        message = message .. " até " .. endNum
    end
    
    Notification:Show("Auto JJS", message, 2)
    UI:UpdateStatus("Executando...")
    
    spawn(function()
        while IsRunning and CurrentNumber <= endNum do
            if SendMessage(CurrentNumber) then
                UI:UpdateCounter(CurrentNumber)
                CurrentNumber = CurrentNumber + 1
                
                -- Mostrar progresso a cada 100 números
                if CurrentNumber % 100 == 0 then
                    local progress = math.floor((CurrentNumber - startNum) / (endNum - startNum) * 100)
                    Notification:Info("Auto JJS", "Progresso: " .. progress .. "%", 1)
                end
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
        
        if CurrentNumber > endNum then
            local finalMessage = "Concluído! Chegou ao número " .. endNum
            if endNum == startNum then
                finalMessage = "Concluído! Enviou o número " .. endNum
            end
            Notification:Show("Auto JJS", finalMessage, 3)
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

-- Função para testar chat
local function TestChat()
    local success, message = ChatAdapter:TestConnection()
    if success then
        Notification:Success("Chat Test", "Conexão OK - " .. ChatAdapter:GetChatType(), 3)
    else
        Notification:Error("Chat Test", "Falha na conexão", 3)
    end
end

-- Função para obter informações do script
local function GetScriptInfo()
    local startNum = Config.StartNumber or 1
    local endNum = Config.EndNumber or 80
    local totalNumbers = endNum - startNum + 1
    local estimatedTime = totalNumbers * (Config.Tempo or 2.5)
    
    local info = {
        StartNumber = startNum,
        EndNumber = endNum,
        TotalNumbers = totalNumbers,
        EstimatedTime = estimatedTime,
        ChatType = ChatAdapter and ChatAdapter:GetChatType() or "Unknown"
    }
    
    return info
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
    
    -- Os módulos serão passados como parâmetros externos
    -- UI, Numbers, Notification, ChatAdapter devem ser definidos antes de chamar Initialize
    
    -- Inicializar ChatAdapter primeiro
    if ChatAdapter then
        ChatAdapter:Initialize()
    end
    
    -- Configurar UI
    if UI then
        UI:Initialize(Config)
    end
    
    -- Configurar input handler
    SetupInputHandler()
    
    -- Configurar callbacks da UI
    if UI then
        UI:SetStartCallback(StartAutoJJs)
        UI:SetStopCallback(StopAutoJJs)
        UI:SetToggleCallback(ToggleAutoJJs)
        UI:SetTestCallback(TestChat)
    end
    
    -- Mostrar notificação inicial
    if Notification then
        Notification:Show("Auto JJS Melhorado", "Pressione " .. Config.Keybind.Name .. " para mostrar/esconder a UI", 4)
        
        -- Mostrar créditos
        spawn(function()
            wait(2)
            Notification:Success("K9zzzzz", "Script criado por K9zzzzz", 5)
        end)
    end
    
    -- Mostrar informações do script
    local info = GetScriptInfo()
    print("Auto JJS Melhorado carregado!")
    print("Pressione " .. Config.Keybind.Name .. " para mostrar/esconder a UI")
    print("Configuração: " .. info.StartNumber .. " até " .. info.EndNumber .. " (" .. info.TotalNumbers .. " números)")
    print("Tempo estimado: " .. math.floor(info.EstimatedTime / 60) .. " minutos")
    if ChatAdapter then
        print("Tipo de chat detectado:", ChatAdapter:GetChatType())
    end
end

-- Função para definir módulos
function AutoJJs:SetModules(ui, numbers, notification, chatAdapter)
    UI = ui
    Numbers = numbers
    Notification = notification
    ChatAdapter = chatAdapter
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
        Config = Config,
        ChatType = ChatAdapter and ChatAdapter:GetChatType() or "Unknown"
    }
end

-- Função para obter informações detalhadas
function AutoJJs:GetInfo()
    return GetScriptInfo()
end

return AutoJJs 