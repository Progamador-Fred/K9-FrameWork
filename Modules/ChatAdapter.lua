-- ChatAdapter.lua
-- Sistema de chat adaptativo que funciona
-- Criado por K9zzzzz

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

local ChatAdapter = {}

-- Detectar tipo de chat
function ChatAdapter:DetectChatType()
    -- Verificar se existe LegacyChatService
    local legacyExists = pcall(function()
        return ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    end)
    
    -- Verificar se existe TextChatService
    local textChatExists = pcall(function()
        return TextChatService:FindFirstChild("ChatWindow")
    end)
    
    if legacyExists then
        return "Legacy"
    elseif textChatExists then
        return "TextChat"
    else
        return "Unknown"
    end
end

-- Enviar mensagem com adaptação automática
function ChatAdapter:SendMessage(message)
    local chatType = self:DetectChatType()
    local success = false
    
    if chatType == "Legacy" then
        -- Usar LegacyChatService
        local success1 = pcall(function()
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
        end)
        success = success1
    elseif chatType == "TextChat" then
        -- Usar TextChatService
        local success2 = pcall(function()
            TextChatService.ChatWindow:SendAsync(message)
        end)
        success = success2
    else
        -- Tentar ambos os métodos
        local success1 = pcall(function()
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
        end)
        
        if not success1 then
            local success2 = pcall(function()
                TextChatService.ChatWindow:SendAsync(message)
            end)
            success = success2
        else
            success = true
        end
    end
    
    return success
end

-- Testar conexão
function ChatAdapter:TestConnection()
    return self:SendMessage("Teste de conexão")
end

-- Enviar mensagem com retry
function ChatAdapter:SendMessageWithRetry(message, maxRetries)
    maxRetries = maxRetries or 3
    
    for i = 1, maxRetries do
        if self:SendMessage(message) then
            return true
        end
        wait(0.1) -- Pequeno delay entre tentativas
    end
    
    return false
end

return ChatAdapter 