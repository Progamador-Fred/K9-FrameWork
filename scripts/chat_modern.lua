--[[
    Chat Modern Module
    Funções para enviar mensagens no chat novo do Roblox
]]

local ChatModern = {}

-- Referência para o chat novo
local TextChatService = game:GetService("TextChatService")

-- Função para verificar se o chat novo está disponível
function ChatModern:IsAvailable()
    return TextChatService ~= nil and TextChatService.TextChannels ~= nil
end

-- Função para enviar mensagem no chat novo
function ChatModern:SendMessage(message)
    if not self:IsAvailable() then
        warn("Chat novo não está disponível neste jogo")
        return false
    end
    
    local success, result = pcall(function()
        local RBXGeneral = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
        if RBXGeneral then
            RBXGeneral:SendAsync(message)
            return true
        else
            warn("Canal RBXGeneral não encontrado")
            return false
        end
    end)
    
    if not success then
        warn("Erro ao enviar mensagem no chat novo: " .. tostring(result))
        return false
    end
    
    return result
end

-- Função para testar a conexão do chat novo
function ChatModern:TestConnection()
    if self:IsAvailable() then
        print("Chat novo detectado e disponível")
        return true
    else
        print("Chat novo não está disponível")
        return false
    end
end

-- Função para listar canais disponíveis (para debug)
function ChatModern:ListChannels()
    if self:IsAvailable() then
        print("Canais disponíveis:")
        for _, channel in pairs(TextChatService.TextChannels:GetChildren()) do
            print("  - " .. channel.Name)
        end
    else
        print("Chat novo não está disponível")
    end
end

return ChatModern 