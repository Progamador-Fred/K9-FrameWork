--[[
    AutoJJs - Script Principal
    Script para enviar polichinelos (JJs) no chat do Roblox
    Compatível com Delta, Hydrogen e Fluxus
]]

-- Carregar módulos de chat
local ChatLegacy = loadstring(game:HttpGet("https://raw.githubusercontent.com/K9zzz32/Auto-JJ-s/main/scripts/chat_legacy.lua"))()
local ChatModern = loadstring(game:HttpGet("https://raw.githubusercontent.com/K9zzz32/Auto-JJ-s/main/scripts/chat_modern.lua"))()

-- Variáveis globais
local OrionLib = nil
local chatSystem = nil
local isRunning = false
local userDelay = 1

-- Função para converter número em texto por extenso
local function numberToText(number)
    local numbers = {
        [0] = "ZERO", [1] = "UM", [2] = "DOIS", [3] = "TRÊS", [4] = "QUATRO",
        [5] = "CINCO", [6] = "SEIS", [7] = "SETE", [8] = "OITO", [9] = "NOVE",
        [10] = "DEZ", [11] = "ONZE", [12] = "DOZE", [13] = "TREZE", [14] = "QUATORZE",
        [15] = "QUINZE", [16] = "DEZESSEIS", [17] = "DEZESSETE", [18] = "DEZOITO",
        [19] = "DEZENOVE", [20] = "VINTE", [21] = "VINTE E UM", [22] = "VINTE E DOIS",
        [23] = "VINTE E TRÊS", [24] = "VINTE E QUATRO", [25] = "VINTE E CINCO",
        [26] = "VINTE E SEIS", [27] = "VINTE E SETE", [28] = "VINTE E OITO",
        [29] = "VINTE E NOVE", [30] = "TRINTA", [31] = "TRINTA E UM", [32] = "TRINTA E DOIS",
        [33] = "TRINTA E TRÊS", [34] = "TRINTA E QUATRO", [35] = "TRINTA E CINCO",
        [36] = "TRINTA E SEIS", [37] = "TRINTA E SETE", [38] = "TRINTA E OITO",
        [39] = "TRINTA E NOVE", [40] = "QUARENTA", [41] = "QUARENTA E UM",
        [42] = "QUARENTA E DOIS", [43] = "QUARENTA E TRÊS", [44] = "QUARENTA E QUATRO",
        [45] = "QUARENTA E CINCO", [46] = "QUARENTA E SEIS", [47] = "QUARENTA E SETE",
        [48] = "QUARENTA E OITO", [49] = "QUARENTA E NOVE", [50] = "CINQUENTA",
        [51] = "CINQUENTA E UM", [52] = "CINQUENTA E DOIS", [53] = "CINQUENTA E TRÊS",
        [54] = "CINQUENTA E QUATRO", [55] = "CINQUENTA E CINCO", [56] = "CINQUENTA E SEIS",
        [57] = "CINQUENTA E SETE", [58] = "CINQUENTA E OITO", [59] = "CINQUENTA E NOVE",
        [60] = "SESSENTA", [61] = "SESSENTA E UM", [62] = "SESSENTA E DOIS",
        [63] = "SESSENTA E TRÊS", [64] = "SESSENTA E QUATRO", [65] = "SESSENTA E CINCO",
        [66] = "SESSENTA E SEIS", [67] = "SESSENTA E SETE", [68] = "SESSENTA E OITO",
        [69] = "SESSENTA E NOVE", [70] = "SETENTA", [71] = "SETENTA E UM",
        [72] = "SETENTA E DOIS", [73] = "SETENTA E TRÊS", [74] = "SETENTA E QUATRO",
        [75] = "SETENTA E CINCO", [76] = "SETENTA E SEIS", [77] = "SETENTA E SETE",
        [78] = "SETENTA E OITO", [79] = "SETENTA E NOVE", [80] = "OITENTA",
        [81] = "OITENTA E UM", [82] = "OITENTA E DOIS", [83] = "OITENTA E TRÊS",
        [84] = "OITENTA E QUATRO", [85] = "OITENTA E CINCO", [86] = "OITENTA E SEIS",
        [87] = "OITENTA E SETE", [88] = "OITENTA E OITO", [89] = "OITENTA E NOVE",
        [90] = "NOVENTA", [91] = "NOVENTA E UM", [92] = "NOVENTA E DOIS",
        [93] = "NOVENTA E TRÊS", [94] = "NOVENTA E QUATRO", [95] = "NOVENTA E CINCO",
        [96] = "NOVENTA E SEIS", [97] = "NOVENTA E SETE", [98] = "NOVENTA E OITO",
        [99] = "NOVENTA E NOVE", [100] = "CEM"
    }
    
    if numbers[number] then
        return numbers[number]
    else
        return tostring(number)
    end
end

-- Função para detectar o tipo de chat
local function detectChatSystem()
    print("Detectando sistema de chat...")
    
    if ChatModern:IsAvailable() then
        print("Chat novo detectado!")
        chatSystem = ChatModern
        return "modern"
    elseif ChatLegacy:IsAvailable() then
        print("Chat antigo detectado!")
        chatSystem = ChatLegacy
        return "legacy"
    else
        warn("Nenhum sistema de chat detectado!")
        return nil
    end
end

-- Função para enviar mensagem
local function sendMessage(message)
    if not chatSystem then
        warn("Sistema de chat não disponível")
        return false
    end
    
    return chatSystem:SendMessage(message)
end

-- Função para solicitar delay do usuário
local function requestDelay()
    print("=" .. string.rep("=", 50))
    print("AutoJJs - Configuração de Delay")
    print("=" .. string.rep("=", 50))
    print("Digite o delay entre as mensagens (em segundos):")
    print("Exemplo: 1.5 para 1 segundo e meio")
    print("Recomendado: 1-3 segundos para evitar spam")
    
    local input = io.read()
    local delay = tonumber(input)
    
    if delay and delay > 0 then
        userDelay = delay
        print("Delay configurado: " .. delay .. " segundos")
    else
        print("Delay inválido, usando padrão: 1 segundo")
        userDelay = 1
    end
    
    print("=" .. string.rep("=", 50))
end

-- Função principal para enviar JJs
local function sendJJs(startNum, endNum, suffix, skipEven)
    if isRunning then
        warn("AutoJJs já está em execução!")
        return
    end
    
    if not chatSystem then
        warn("Sistema de chat não disponível!")
        return
    end
    
    isRunning = true
    print("AutoJJs iniciado!")
    print("Iniciando de " .. startNum .. " até " .. endNum)
    print("Sufixo: '" .. suffix .. "'")
    print("Pular pares: " .. (skipEven and "Sim" or "Não"))
    print("Delay: " .. userDelay .. " segundos")
    
    local count = 0
    for i = startNum, endNum do
        if not isRunning then
            print("AutoJJs interrompido pelo usuário!")
            break
        end
        
        -- Pular números pares se solicitado
        if skipEven and i % 2 == 0 then
            goto continue
        end
        
        local message = numberToText(i) .. suffix
        local success = sendMessage(message)
        
        if success then
            count = count + 1
            print("Enviado: " .. message)
        else
            warn("Falha ao enviar: " .. message)
        end
        
        -- Aguardar delay
        wait(userDelay)
        
        ::continue::
    end
    
    isRunning = false
    print("AutoJJs finalizado! Total enviado: " .. count .. " mensagens")
end

-- Função para parar o AutoJJs
local function stopJJs()
    if isRunning then
        isRunning = false
        print("AutoJJs interrompido!")
    end
end

-- Função para criar a UI
local function createUI()
    -- Carregar Orion UI Library
    OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
    
    -- Criar janela
    local Window = OrionLib:MakeWindow({
        Name = "K9zzzzz - Auto JJs",
        HideTopbar = false,
        SaveConfig = false,
        ConfigFolder = "AutoJJsConfig"
    })
    
    -- Tab principal
    local MainTab = Window:MakeTab({
        Name = "Principal",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })
    
    -- Variáveis da UI
    local startNumber = 1
    local endNumber = 100
    local suffix = "!"
    local skipEven = false
    
    -- Campo para número inicial
    MainTab:AddTextbox({
        Name = "Começar do:",
        Default = "1",
        TextDisappear = true,
        Callback = function(Value)
            startNumber = tonumber(Value) or 1
        end
    })
    
    -- Campo para número final
    MainTab:AddTextbox({
        Name = "Até o:",
        Default = "100",
        TextDisappear = true,
        Callback = function(Value)
            endNumber = tonumber(Value) or 100
        end
    })
    
    -- Campo para sufixo
    MainTab:AddTextbox({
        Name = "Final do Prefix:",
        Default = "!",
        TextDisappear = true,
        Callback = function(Value)
            suffix = Value or "!"
        end
    })
    
    -- Toggle para pular números pares
    MainTab:AddToggle({
        Name = "Pular números pares",
        Default = false,
        Callback = function(Value)
            skipEven = Value
        end
    })
    
    -- Botão para iniciar
    MainTab:AddButton({
        Name = "▶ Iniciar",
        Callback = function()
            if not isRunning then
                sendJJs(startNumber, endNumber, suffix, skipEven)
            else
                warn("AutoJJs já está em execução!")
            end
        end
    })
    
    -- Botão para parar
    MainTab:AddButton({
        Name = "⏹ Parar",
        Callback = function()
            stopJJs()
        end
    })
    
    -- Tab de informações
    local InfoTab = Window:MakeTab({
        Name = "Informações",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })
    
    InfoTab:AddParagraph("Status", "AutoJJs carregado com sucesso!")
    InfoTab:AddParagraph("Sistema de Chat", chatSystem and "Detectado" or "Não detectado")
    InfoTab:AddParagraph("Delay Atual", userDelay .. " segundos")
    
    -- Inicializar a UI
    OrionLib:Init()
end

-- Função principal
local function main()
    print("AutoJJs - Iniciando...")
    
    -- Solicitar delay do usuário
    requestDelay()
    
    -- Detectar sistema de chat
    local chatType = detectChatSystem()
    if not chatType then
        warn("Não foi possível detectar o sistema de chat!")
        print("O script pode não funcionar corretamente.")
    end
    
    -- Criar UI
    createUI()
end

-- Executar função principal
main() 