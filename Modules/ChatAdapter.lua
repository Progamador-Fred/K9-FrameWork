-- ChatAdapter.lua
-- Sistema de chat adaptativo avançado e robusto
-- Criado por K9zzzzz

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local ChatAdapter = {}

-- Cache para tipo de chat detectado
local chatTypeCache = nil
local lastDetectionTime = 0
local detectionCooldown = 5 -- 5 segundos

-- Detectar tipo de chat de forma mais robusta
function ChatAdapter:DetectChatType()
    -- Usar cache se recente
    if chatTypeCache and (tick() - lastDetectionTime) < detectionCooldown then
        return chatTypeCache
    end
    
    local detectedType = "Unknown"
    
    -- Verificar LegacyChatService
    local legacyExists = pcall(function()
        local events = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if events then
            local sayEvent = events:FindFirstChild("SayMessageRequest")
            if sayEvent and sayEvent:IsA("RemoteEvent") then
                return true
            end
        end
        return false
    end)
    
    -- Verificar TextChatService
    local textChatExists = pcall(function()
        local chatWindow = TextChatService:FindFirstChild("ChatWindow")
        if chatWindow then
            local sendAsync = chatWindow:FindFirstChild("SendAsync")
            if sendAsync and sendAsync:IsA("Function") then
                return true
            end
        end
        return false
    end)
    
    -- Determinar tipo
    if legacyExists then
        detectedType = "Legacy"
    elseif textChatExists then
        detectedType = "TextChat"
    end
    
    -- Atualizar cache
    chatTypeCache = detectedType
    lastDetectionTime = tick()
    
    return detectedType
end

-- Enviar mensagem com adaptação automática melhorada
function ChatAdapter:SendMessage(message)
    if not message or message == "" then
        return false
    end
    
    -- Validar tamanho da mensagem
    if #message > 200 then
        warn("Mensagem muito longa!")
        return false
    end
    
    local success = false
    local chatType = self:DetectChatType()
    
    if chatType == "Legacy" then
        success = self:SendLegacyMessage(message)
    elseif chatType == "TextChat" then
        success = self:SendTextChatMessage(message)
    else
        -- Tentar ambos os métodos
        success = self:SendLegacyMessage(message) or self:SendTextChatMessage(message)
    end
    
    return success
end

-- Enviar mensagem via LegacyChatService
function ChatAdapter:SendLegacyMessage(message)
    return pcall(function()
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
end

-- Enviar mensagem via TextChatService
function ChatAdapter:SendTextChatMessage(message)
    return pcall(function()
        local chatWindow = TextChatService:FindFirstChild("ChatWindow")
        if chatWindow then
            local sendAsync = chatWindow:FindFirstChild("SendAsync")
            if sendAsync and sendAsync:IsA("Function") then
                sendAsync:Invoke(message)
                return true
            end
        end
        return false
    end)
end

-- Enviar mensagem com retry avançado
function ChatAdapter:SendMessageWithRetry(message, maxRetries)
    maxRetries = maxRetries or 3
    
    for i = 1, maxRetries do
        if self:SendMessage(message) then
            return true
        end
        
        -- Delay progressivo entre tentativas
        local delay = 0.1 * i
        wait(delay)
        
        -- Limpar cache se falhar
        if i == 1 then
            chatTypeCache = nil
        end
    end
    
    return false
end

-- Testar conexão
function ChatAdapter:TestConnection()
    local testMessage = "Teste de conexão - " .. tick()
    return self:SendMessage(testMessage)
end

-- Obter tipo de chat atual
function ChatAdapter:GetCurrentChatType()
    return self:DetectChatType()
end

-- Verificar se o chat está funcionando
function ChatAdapter:IsChatWorking()
    local chatType = self:DetectChatType()
    return chatType ~= "Unknown"
end

-- Obter estatísticas do chat
function ChatAdapter:GetChatStats()
    return {
        Type = self:GetCurrentChatType(),
        Working = self:IsChatWorking(),
        LastDetection = lastDetectionTime,
        CacheValid = chatTypeCache ~= nil
    }
end

-- Limpar cache
function ChatAdapter:ClearCache()
    chatTypeCache = nil
    lastDetectionTime = 0
end

-- Monitorar mudanças no chat
function ChatAdapter:StartMonitoring()
    if self.monitoring then return end
    
    self.monitoring = true
    
    spawn(function()
        while self.monitoring do
            local currentType = self:DetectChatType()
            if currentType ~= chatTypeCache then
                warn("Tipo de chat mudou de", chatTypeCache, "para", currentType)
                chatTypeCache = currentType
            end
            wait(10) -- Verificar a cada 10 segundos
        end
    end)
end

-- Parar monitoramento
function ChatAdapter:StopMonitoring()
    self.monitoring = false
end

return ChatAdapter 