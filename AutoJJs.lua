-- Auto JJs - Carregador Principal
-- Criado por: k9zzzzzz
-- Uso exclusivo para testes internos

-- Carregando Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Carregando sistemas modulares
local NumberConverter = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/numberConverter.lua'))()
local ChatSystem = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/chatSystem.lua'))()
local JumpSystem = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/jumpSystem.lua'))()

-- Variáveis globais
local isRunning = false
local isPaused = false
local currentNumber = 0
local startNumber = 0
local endNumber = 0
local finalPrompt = ""
local speed = 1
local shouldJump = false

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
        local numberText = NumberConverter.numberToWords(currentNumber)
        local message = numberText .. finalPrompt
        
        -- Enviar mensagem
        local sent = ChatSystem.SendChatMessage(message)
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
            JumpSystem.makePlayerJump()
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