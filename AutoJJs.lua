-- Auto JJs - Script Principal (Versão Modular)
-- Criado por: k9zzzzzz
-- Uso exclusivo para testes internos

-- Carregando Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Carregando sistemas modulares
local NumberConverter = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/numberConverter.lua'))()
local ChatSystem = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/chatSystem.lua'))()
local JumpSystem = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/jumpSystem.lua'))()
local UISystem = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/UI/uiSystem.lua'))()


-- Variáveis globais
local isRunning = false
local isPaused = false
local currentNumber = 0
local startNumber = 0
local endNumber = 0
local finalPrompt = ""
local speed = 1
local shouldJump = false
local uiControls = {}

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
    
    local numberText = NumberConverter.numberToWords(currentNumber)
    local message = numberText .. finalPrompt
    
    -- Enviar mensagem com sistema universal
    local sent = ChatSystem.SendChatMessage(message)
    if not sent then
        Rayfield:Notify({
            Title = "Erro",
            Content = "Não foi possível enviar mensagem.",
            Duration = 2
        })
    end
    
    -- Pular se ativado
    if shouldJump then
        JumpSystem.makePlayerJump()
    end
    
    currentNumber = currentNumber + 1
    
    task.wait(speed)
    executeCount()
end

-- Callbacks para a interface
local callbacks = {
    onStartNumberChange = function(Text)
        local num = tonumber(Text)
        if num and num >= 0 and num <= 999999999999999999999 then
            startNumber = num
        end
    end,
    
    onEndNumberChange = function(Text)
        local num = tonumber(Text)
        if num and num >= 0 and num <= 999999999999999999999 then
            endNumber = num
        end
    end,
    
    onFinalPromptChange = function(Text)
        finalPrompt = Text
    end,
    
    onSpeedChange = function(Value)
        speed = Value
    end,
    
    onJumpChange = function(Value)
        shouldJump = Value
    end,
    
    onStartButton = function()
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
            
            uiControls.startButton:Set("Retomar JJs")
            executeCount()
        else
            if isPaused then
                isPaused = false
                Rayfield:Notify({
                    Title = "Auto JJs",
                    Content = "Retomado!",
                    Duration = 2
                })
                uiControls.startButton:Set("Retomar JJs")
                executeCount()
            end
        end
    end,
    
    onPauseButton = function()
        if isRunning and not isPaused then
            isPaused = true
            Rayfield:Notify({
                Title = "Auto JJs",
                Content = "Pausado!",
                Duration = 2
            })
            uiControls.startButton:Set("Retomar JJs")
        end
    end,
    
    onStopButton = function()
        isRunning = false
        isPaused = false
        currentNumber = 0
        uiControls.startButton:Set("Iniciar JJs")
        
        Rayfield:Notify({
            Title = "Auto JJs",
            Content = "Parado!",
            Duration = 2
        })
    end
}

-- Criar interface e obter controles
uiControls = UISystem.CreateInterface(Rayfield, callbacks)