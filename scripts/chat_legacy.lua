--[[
    Chat Legacy Module
    Funções para enviar mensagens no chat antigo do Roblox
]]

local ChatLegacy = {}

-- Referência para o chat antigo
local DefaultChatSystemChatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")

-- Função para verificar se o chat antigo está disponível
function ChatLegacy:IsAvailable()
    return DefaultChatSystemChatEvents ~= nil
end

-- Função para enviar mensagem no chat antigo
function ChatLegacy:SendMessage(message)
    if not self:IsAvailable() then
        warn("Chat antigo não está disponível neste jogo")
        return false
    end
    
    local success, result = pcall(function()
        local SayMessageRequest = DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
        if SayMessageRequest then
            SayMessageRequest:FireServer(message, "All")
            return true
        else
            warn("SayMessageRequest não encontrado")
            return false
        end
    end)
    
    if not success then
        warn("Erro ao enviar mensagem no chat antigo: " .. tostring(result))
        return false
    end
    
    return result
end

-- Função para testar a conexão do chat antigo
function ChatLegacy:TestConnection()
    if self:IsAvailable() then
        print("Chat antigo detectado e disponível")
        return true
    else
        print("Chat antigo não está disponível")
        return false
    end
end

return ChatLegacy 