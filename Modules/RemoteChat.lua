-- RemoteChat.lua
-- Módulo para gerenciar chat
-- Criado por K9zzzzz

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

local RemoteChat = {}

-- Função para enviar mensagem
function RemoteChat:SendMessage(message)
    local success = false
    
    -- Tentar LegacyChatService primeiro
    local success1 = pcall(function()
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
    end)
    
    if success1 then
        success = true
    else
        -- Tentar TextChatService
        local success2 = pcall(function()
            TextChatService.ChatWindow:SendAsync(message)
        end)
        
        if success2 then
            success = true
        end
    end
    
    return success
end

-- Função para testar conexão
function RemoteChat:TestConnection()
    return self:SendMessage("Teste")
end

return RemoteChat 