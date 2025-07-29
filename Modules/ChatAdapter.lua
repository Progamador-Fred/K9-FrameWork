-- ChatAdapter.lua
-- Sistema de adaptação automática para diferentes tipos de chat
-- Criado por K9zzzzz

local ChatAdapter = {}
ChatAdapter.__index = ChatAdapter

-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")

-- Variáveis
local ChatType = nil
local ChatEvents = {}
local Player = Players.LocalPlayer

-- Função para detectar tipo de chat
local function DetectChatType()
    -- Verificar se TextChatService está disponível (chat novo)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        return "TextChatService"
    end
    
    -- Verificar LegacyChatService (chat antigo)
    if ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
        return "LegacyChatService"
    end
    
    -- Verificar outros sistemas de chat
    if ReplicatedStorage:FindFirstChild("ChatEvents") then
        return "CustomChat"
    end
    
    return "Unknown"
end

-- Função para configurar chat novo (TextChatService)
local function SetupTextChatService()
    local success, result = pcall(function()
        local chatWindow = TextChatService.ChatWindow
        if chatWindow then
            return {
                SendMessage = function(message)
                    chatWindow:SendAsync(message)
                end,
                Type = "TextChatService"
            }
        end
    end)
    
    if success and result then
        return result
    end
    
    return nil
end

-- Função para configurar chat antigo (LegacyChatService)
local function SetupLegacyChatService()
    local success, result = pcall(function()
        local chatEvents = ReplicatedStorage.DefaultChatSystemChatEvents
        local sayMessageRequest = chatEvents:FindFirstChild("SayMessageRequest")
        
        if sayMessageRequest then
            return {
                SendMessage = function(message)
                    sayMessageRequest:FireServer(message, "All")
                end,
                Type = "LegacyChatService"
            }
        end
    end)
    
    if success and result then
        return result
    end
    
    return nil
end

-- Função para configurar chat customizado
local function SetupCustomChat()
    local success, result = pcall(function()
        local chatEvents = ReplicatedStorage.ChatEvents
        local sendMessage = chatEvents:FindFirstChild("SendMessage")
        
        if sendMessage then
            return {
                SendMessage = function(message)
                    sendMessage:FireServer(message)
                end,
                Type = "CustomChat"
            }
        end
    end)
    
    if success and result then
        return result
    end
    
    return nil
end

-- Função para configurar fallback (método alternativo)
local function SetupFallback()
    return {
        SendMessage = function(message)
            -- Tentar diferentes métodos
            local methods = {
                function()
                    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
                end,
                function()
                    TextChatService.ChatWindow:SendAsync(message)
                end,
                function()
                    -- Método via StarterGui
                    StarterGui:SetCore("ChatMakeSystemMessage", {
                        Text = message,
                        Color = Color3.fromRGB(255, 255, 255)
                    })
                end
            }
            
            for _, method in ipairs(methods) do
                local success = pcall(method)
                if success then
                    break
                end
            end
        end,
        Type = "Fallback"
    }
end

-- Função para inicializar o adaptador
function ChatAdapter:Initialize()
    ChatType = DetectChatType()
    
    print("ChatAdapter: Detectado tipo de chat:", ChatType)
    
    -- Configurar baseado no tipo detectado
    if ChatType == "TextChatService" then
        ChatEvents = SetupTextChatService()
    elseif ChatType == "LegacyChatService" then
        ChatEvents = SetupLegacyChatService()
    elseif ChatType == "CustomChat" then
        ChatEvents = SetupCustomChat()
    else
        ChatEvents = SetupFallback()
    end
    
    -- Verificar se foi configurado com sucesso
    if not ChatEvents then
        warn("ChatAdapter: Falha ao configurar chat, usando fallback")
        ChatEvents = SetupFallback()
    end
    
    print("ChatAdapter: Configurado com sucesso -", ChatEvents.Type)
end

-- Função para enviar mensagem
function ChatAdapter:SendMessage(message)
    if not ChatEvents then
        warn("ChatAdapter: Chat não inicializado")
        return false
    end
    
    local success, result = pcall(function()
        ChatEvents.SendMessage(message)
    end)
    
    if not success then
        warn("ChatAdapter: Erro ao enviar mensagem:", result)
        return false
    end
    
    return true
end

-- Função para obter tipo de chat
function ChatAdapter:GetChatType()
    return ChatType or "Unknown"
end

-- Função para verificar se está funcionando
function ChatAdapter:IsWorking()
    return ChatEvents ~= nil
end

-- Função para testar conexão
function ChatAdapter:TestConnection()
    if not ChatEvents then
        return false, "Chat não inicializado"
    end
    
    local success = pcall(function()
        ChatEvents.SendMessage("Teste de conexão")
    end)
    
    return success, success and "Conexão OK" or "Falha na conexão"
end

return ChatAdapter 