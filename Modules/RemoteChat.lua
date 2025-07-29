-- RemoteChat.lua
-- Sistema de chat para LegacyChatService (chat antigo)
-- Criado por K9zzzzz

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local RemoteChat = {}

-- Verificar se o LegacyChatService está disponível
function RemoteChat:IsAvailable()
    local success = pcall(function()
        local events = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if events then
            local sayEvent = events:FindFirstChild("SayMessageRequest")
            return sayEvent and sayEvent:IsA("RemoteEvent")
        end
        return false
    end)
    
    return success
end

-- Enviar mensagem via LegacyChatService
function RemoteChat:SendMessage(message)
    if not message or message == "" then
        warn("Mensagem vazia!")
        return false
    end
    
    -- Validar tamanho da mensagem
    if #message > 200 then
        warn("Mensagem muito longa!")
        return false
    end
    
    local success = pcall(function()
        local events = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if events then
            local sayEvent = events:FindFirstChild("SayMessageRequest")
            if sayEvent and sayEvent:IsA("RemoteEvent") then
                sayEvent:FireServer(message, "All")
                return true
            end
        end
        return false
    end)
    
    return success
end

-- Enviar mensagem com retry
function RemoteChat:SendMessageWithRetry(message, maxRetries)
    maxRetries = maxRetries or 3
    
    for i = 1, maxRetries do
        if self:SendMessage(message) then
            return true
        end
        
        -- Delay progressivo entre tentativas
        local delay = 0.1 * i
        wait(delay)
    end
    
    return false
end

-- Testar conexão
function RemoteChat:TestConnection()
    local testMessage = "Teste de conexão - " .. tick()
    return self:SendMessage(testMessage)
end

-- Obter informações do chat
function RemoteChat:GetChatInfo()
    local events = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if events then
        local sayEvent = events:FindFirstChild("SayMessageRequest")
        return {
            Available = true,
            EventsFolder = events,
            SayEvent = sayEvent,
            EventType = sayEvent and sayEvent.ClassName or "Unknown"
        }
    else
        return {
            Available = false,
            EventsFolder = nil,
            SayEvent = nil,
            EventType = "Not Found"
        }
    end
end

-- Monitorar eventos do chat
function RemoteChat:MonitorChat(callback)
    local events = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if not events then return end
    
    local sayEvent = events:FindFirstChild("SayMessageRequest")
    if not sayEvent then return end
    
    -- Conectar ao evento OnClientEvent
    sayEvent.OnClientEvent:Connect(function(...)
        if callback then
            callback("MessageReceived", ...)
        end
    end)
end

-- Verificar se o jogador pode enviar mensagens
function RemoteChat:CanSendMessage()
    local player = Players.LocalPlayer
    if not player then return false end
    
    -- Verificar se o jogador não está mutado
    local success = pcall(function()
        return player:GetAttribute("ChatMuted") ~= true
    end)
    
    return success
end

-- Obter estatísticas do chat
function RemoteChat:GetStats()
    local info = self:GetChatInfo()
    return {
        Available = info.Available,
        CanSend = self:CanSendMessage(),
        Player = Players.LocalPlayer and Players.LocalPlayer.Name or "Unknown",
        ChatType = "LegacyChatService"
    }
end

-- Função para testar o módulo
function RemoteChat:Test()
    print("=== Teste do Módulo RemoteChat ===")
    print("Disponível:", self:IsAvailable())
    print("Pode enviar:", self:CanSendMessage())
    
    local info = self:GetChatInfo()
    print("EventsFolder:", info.EventsFolder and "Encontrado" or "Não encontrado")
    print("SayEvent:", info.SayEvent and "Encontrado" or "Não encontrado")
    print("EventType:", info.EventType)
    
    local stats = self:GetStats()
    print("Player:", stats.Player)
    print("ChatType:", stats.ChatType)
    print("================================")
end

return RemoteChat 