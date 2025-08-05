-- Auto JJs - Script Completo
-- Criado por: k9zzzzzz
-- Uso exclusivo para testes internos

-- Carregando Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Variáveis globais
local isRunning = false
local isPaused = false
local currentNumber = 0
local startNumber = 0
local endNumber = 0
local finalPrompt = ""
local speed = 1
local shouldJump = false

-- Função para converter números para extenso
local function numberToWords(num)
    if num < 0 or num > 999999999999999999999 then
        return "NÚMERO INVÁLIDO"
    end
    
    if num == 0 then return "ZERO" end
    
    local units = {
        [0] = "", [1] = "UM", [2] = "DOIS", [3] = "TRÊS", [4] = "QUATRO", [5] = "CINCO",
        [6] = "SEIS", [7] = "SETE", [8] = "OITO", [9] = "NOVE", [10] = "DEZ",
        [11] = "ONZE", [12] = "DOZE", [13] = "TREZE", [14] = "QUATORZE", [15] = "QUINZE",
        [16] = "DEZESSEIS", [17] = "DEZESSETE", [18] = "DEZOITO", [19] = "DEZENOVE", [20] = "VINTE"
    }
    
    local tens = {
        [2] = "VINTE", [3] = "TRINTA", [4] = "QUARENTA", [5] = "CINQUENTA",
        [6] = "SESSENTA", [7] = "SETENTA", [8] = "OITENTA", [9] = "NOVENTA"
    }
    
    -- Função para converter grupos de 3 dígitos
    local function convertGroup(group, isLast)
        if group == 0 then return "" end
        
        local result = ""
        local hundreds = math.floor(group / 100)
        local remainder = group % 100
        
        -- Centenas
        if hundreds > 0 then
            if hundreds == 1 then
                result = "CENTO"
            else
                result = units[hundreds] .. "CENTOS"
            end
        end
        
        -- Dezenas e unidades
        if remainder > 0 then
            if remainder <= 20 then
                result = result .. (result ~= "" and " E " or "") .. units[remainder]
            else
                local ten = math.floor(remainder / 10)
                local unit = remainder % 10
                
                result = result .. (result ~= "" and " E " or "") .. tens[ten]
                if unit > 0 then
                    result = result .. " E " .. units[unit]
                end
            end
        end
        
        return result
    end
    
    -- Função para adicionar sufixos
    local function addSuffix(group, position)
        if group == 0 then return "" end
        
        local suffixes = {
            [1] = "", [2] = " MIL", [3] = " MILHÕES", [4] = " BILHÕES",
            [5] = " TRILHÕES", [6] = " QUATRILHÕES", [7] = " QUINTILHÕES"
        }
        
        local suffix = suffixes[position] or ""
        if group == 1 and position > 1 then
            return "UM" .. suffix
        else
            return convertGroup(group, position == 1) .. suffix
        end
    end
    
    -- Dividir o número em grupos
    local groups = {}
    local temp = num
    while temp > 0 do
        table.insert(groups, 1, temp % 1000)
        temp = math.floor(temp / 1000)
    end
    
    -- Converter cada grupo
    local result = ""
    for i, group in ipairs(groups) do
        local groupText = addSuffix(group, #groups - i + 1)
        if groupText ~= "" then
            result = result .. (result ~= "" and " " or "") .. groupText
        end
    end
    
    return result
end

-- Função para enviar mensagem no chat (MÉTODO MAIS EFICIENTE)
local function sendChatMessage(message)
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

-- Função para fazer o personagem pular (MÉTODO MAIS EFICIENTE)
local function makePlayerJump()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")

    Humanoid.Jump = true
    return true
end

-- Função principal para executar a contagem
local function executeCount()
    if not isRunning or isPaused then return end
    
    if currentNumber > endNumber then
        isRunning = false
        Rayfield:Notify({
            Title = "Auto JJs",
            Content = "Contagem finalizada.",
            Duration = 2
        })
        return
    end
    
    local success, result = pcall(function()
        local numberText = numberToWords(currentNumber)
        local message = numberText .. finalPrompt
        
        -- Enviar mensagem
        local sent = sendChatMessage(message)
        if not sent then
            Rayfield:Notify({
                Title = "Erro",
                Content = "Não foi possível enviar mensagem.",
                Duration = 2
            })
        end
        
        -- Pular DEPOIS de enviar a mensagem (se ativado)
        if shouldJump then
            task.wait(0.1) -- Pequena pausa para sincronizar
            makePlayerJump()
        end
        
        currentNumber = currentNumber + 1
        
        task.wait(speed)
        executeCount()
    end)
    
    if not success then
        print("Erro na execução:", result)
        isRunning = false
        Rayfield:Notify({
            Title = "Erro",
            Content = "Erro na execução: " .. tostring(result),
            Duration = 3
        })
    end
end

-- Criando a interface principal
local Window = Rayfield:CreateWindow({
    Name = "Auto JJs",
    LoadingTitle = "Auto JJs",
    LoadingSubtitle = "k9zzzzzz",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    }
})

-- Notificação inicial simples
Rayfield:Notify({
    Title = "Auto JJs",
    Content = "Carregado com sucesso!",
    Duration = 2
})

-- Aba Auto JJs
local AutoJJsTab = Window:CreateTab("Auto JJs", 4483362458)

-- Textbox para número inicial
local startNumberInput = AutoJJsTab:CreateInput({
    Name = "Iniciar em",
    PlaceholderText = "Ex: 0, 1...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local num = tonumber(Text)
        if num and num >= 0 and num <= 999999999999999999999 then
            startNumber = num
        end
    end,
})

-- Textbox para número final
local endNumberInput = AutoJJsTab:CreateInput({
    Name = "Finalizar em",
    PlaceholderText = "Ex: 10, 100...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local num = tonumber(Text)
        if num and num >= 0 and num <= 999999999999999999999 then
            endNumber = num
        end
    end,
})

-- Textbox para texto final
local finalPromptInput = AutoJJsTab:CreateInput({
    Name = "Final do prompt",
    PlaceholderText = "Ex: !",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        finalPrompt = Text
    end,
})

-- Slider para velocidade
local speedSlider = AutoJJsTab:CreateSlider({
    Name = "Velocidade",
    Range = {0.1, 3},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = 1,
    Flag = "SpeedSlider",
    Callback = function(Value)
        speed = Value
    end,
})

-- Toggle para pular
local jumpToggle = AutoJJsTab:CreateToggle({
    Name = "Pular?",
    CurrentValue = false,
    Flag = "JumpToggle",
    Callback = function(Value)
        shouldJump = Value
    end,
})

-- Botão Começar/Retomar
local startButton = AutoJJsTab:CreateButton({
    Name = "Iniciar JJs",
    Callback = function()
        if not isRunning then
            if startNumber >= endNumber then
                Rayfield:Notify({
                    Title = "Erro",
                    Content = "Número inicial deve ser menor que o final.",
                    Duration = 2
                })
                return
            end
            
            isRunning = true
            isPaused = false
            currentNumber = startNumber
            
            Rayfield:Notify({
                Title = "Auto JJs",
                Content = "Iniciado!",
                Duration = 2
            })
            
            startButton:Set("Retomar JJs")
            executeCount()
        else
            if isPaused then
                isPaused = false
                Rayfield:Notify({
                    Title = "Auto JJs",
                    Content = "Retomado!",
                    Duration = 2
                })
                startButton:Set("Retomar JJs")
                executeCount()
            end
        end
    end,
})

-- Botão Pausar
local pauseButton = AutoJJsTab:CreateButton({
    Name = "Pausar JJs",
    Callback = function()
        if isRunning and not isPaused then
            isPaused = true
            Rayfield:Notify({
                Title = "Auto JJs",
                Content = "Pausado!",
                Duration = 2
            })
            startButton:Set("Retomar JJs")
        end
    end,
})

-- Botão Parar
local stopButton = AutoJJsTab:CreateButton({
    Name = "Parar JJs",
    Callback = function()
        isRunning = false
        isPaused = false
        currentNumber = 0
        startButton:Set("Iniciar JJs")
        
        Rayfield:Notify({
            Title = "Auto JJs",
            Content = "Parado!",
            Duration = 2
        })
    end,
})

-- Aba Créditos (SIMPLIFICADA)
local CreditsTab = Window:CreateTab("Créditos", 4483362458)

CreditsTab:CreateSection("Auto JJs")

CreditsTab:CreateLabel("Criado por: k9zzzzzz")
CreditsTab:CreateLabel("Discord: https://discord.gg/embreve")
CreditsTab:CreateLabel("Suporte até 21 dígitos") 