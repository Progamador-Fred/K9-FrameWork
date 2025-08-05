-- chatSystem.lua
-- Sistema universal de envio de mensagens no chat do Roblox
-- Criado por: k9zzzzzz

local ChatSystem = {}

-- Função universal para enviar mensagem no chat
function ChatSystem.SendChatMessage(message)
    local success = false
    
    -- Método 1: DefaultChatSystemChatEvents (Chat antigo)
    local chatEvent = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvent then
        local sayMessageRequest = chatEvent:FindFirstChild("SayMessageRequest")
        if sayMessageRequest then
            local success1, result1 = pcall(function()
                sayMessageRequest:FireServer(message, "All")
            end)
            if success1 then
                success = true
            end
        end
    end
    
    -- Método 2: TextChatService (Chat novo)
    if not success then
        local TextChatService = game:GetService("TextChatService")
        if TextChatService then
            local success2, result2 = pcall(function()
                TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral"):SendAsync(message)
            end)
            if success2 then
                success = true
            end
        end
    end
    
    -- Método 3: ChatService (Fallback)
    if not success then
        local ChatService = game:GetService("ChatService")
        if ChatService then
            local success3, result3 = pcall(function()
                ChatService:Chat(message)
            end)
            if success3 then
                success = true
            end
        end
    end
    
    -- Método 4: Players.LocalPlayer.Chatted (Último recurso)
    if not success then
        local player = game.Players.LocalPlayer
        if player then
            local success4, result4 = pcall(function()
                player:Chat(message)
            end)
            if success4 then
                success = true
            end
        end
    end
    
    return success
end

return ChatSystem 