-- ChatAdapter.lua
-- Sistema de chat adaptativo melhorado e robusto
-- Criado por K9zzzzz

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

local ChatAdapter = {}

-- Detectar tipo de chat de forma mais robusta
function ChatAdapter:DetectChatType()
    -- Verificar LegacyChatService
    local legacyExists = pcall(function()
        local events = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if events then
            local sayEvent = events:FindFirstChild("SayMessageRequest")
            return sayEvent ~= nil
        end
        return false
    end)
    
    -- Verificar TextChatService
    local textChatExists = pcall(function()
        local chatWindow = TextChatService:FindFirstChild("ChatWindow")
        if chatWindow then
            return chatWindow:FindFirstChild("SendAsync") ~= nil
        end
        return false
    end)
    
    if legacyExists then
        return "Legacy"
    elseif textChatExists then
        return "TextChat"
    else
        return "Unknown"
    end
end

-- Enviar mensagem com adaptação automática melhorada
function ChatAdapter:SendMessage(message)
    if not message or message == "" then
        return false
    end
    
    local success = false
    
    -- Tentar LegacyChatService primeiro (mais comum)
    local success1 = pcall(function()
        local events = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if events then
            local sayEvent = events:FindFirstChild("SayMessageRequest")
            if sayEvent then
                sayEvent:FireServer(message, "All")
                return true
            end
        end
        return false
    end)
    
    if success1 then
        success = true
    else
        -- Tentar TextChatService como fallback
        local success2 = pcall(function()
            local chatWindow = TextChatService:FindFirstChild("ChatWindow")
            if chatWindow then
                local sendAsync = chatWindow:FindFirstChild("SendAsync")
                if sendAsync then
                    sendAsync:Invoke(message)
                    return true
                end
            end
            return false
        end)
        
        if success2 then
            success = true
        end
    end
    
    return success
end

-- Enviar mensagem com retry melhorado
function ChatAdapter:SendMessageWithRetry(message, maxRetries)
    maxRetries = maxRetries or 3
    
    for i = 1, maxRetries do
        if self:SendMessage(message) then
            return true
        end
        
        -- Delay progressivo entre tentativas
        wait(0.1 * i)
    end
    
    return false
end

-- Testar conexão
function ChatAdapter:TestConnection()
    return self:SendMessage("Teste de conexão")
end

-- Obter tipo de chat atual
function ChatAdapter:GetCurrentChatType()
    return self:DetectChatType()
end

return ChatAdapter 