-- chatSystem.lua
-- Sistema universal de envio de mensagens no chat do Roblox
-- Criado por: k9zzzzzz

local ChatSystem = {}

-- Função universal para enviar mensagem no chat
function ChatSystem.SendChatMessage(message)
    local TextChatService = game:GetService("TextChatService")

    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        -- NOVO SISTEMA DE CHAT (Chat por canal)
        local success, result = pcall(function()
            TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral"):SendAsync(message)
        end)
        return success
    else
        -- SISTEMA ANTIGO DE CHAT
        local success, result = pcall(function()
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local DefaultChatSystemChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
            local SayMessageRequest = DefaultChatSystemChatEvents:WaitForChild("SayMessageRequest")
            
            SayMessageRequest:FireServer(message, "All")
        end)
        return success
    end
end

return ChatSystem 