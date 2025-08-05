-- uiSystem.lua
-- Interface Rayfield UI para o Auto JJs
-- Criado por: k9zzzzzz

local UISystem = {}

-- Função para criar a interface completa
function UISystem.CreateInterface(Rayfield, callbacks)
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
        Callback = callbacks.onStartNumberChange,
    })

    -- Textbox para número final
    local endNumberInput = AutoJJsTab:CreateInput({
        Name = "Finalizar em",
        PlaceholderText = "Ex: 10, 100...",
        RemoveTextAfterFocusLost = false,
        Callback = callbacks.onEndNumberChange,
    })

    -- Textbox para texto final
    local finalPromptInput = AutoJJsTab:CreateInput({
        Name = "Final do prompt",
        PlaceholderText = "Ex: !",
        RemoveTextAfterFocusLost = false,
        Callback = callbacks.onFinalPromptChange,
    })

    -- Slider para velocidade
    local speedSlider = AutoJJsTab:CreateSlider({
        Name = "Velocidade",
        Range = {0.1, 3},
        Increment = 0.1,
        Suffix = "s",
        CurrentValue = 1,
        Flag = "SpeedSlider",
        Callback = callbacks.onSpeedChange,
    })

    -- Toggle para pular
    local jumpToggle = AutoJJsTab:CreateToggle({
        Name = "Pular?",
        CurrentValue = false,
        Flag = "JumpToggle",
        Callback = callbacks.onJumpChange,
    })

    -- Botão Começar/Retomar
    local startButton = AutoJJsTab:CreateButton({
        Name = "Iniciar JJs",
        Callback = callbacks.onStartButton,
    })

    -- Botão Pausar
    local pauseButton = AutoJJsTab:CreateButton({
        Name = "Pausar JJs",
        Callback = callbacks.onPauseButton,
    })

    -- Botão Parar
    local stopButton = AutoJJsTab:CreateButton({
        Name = "Parar JJs",
        Callback = callbacks.onStopButton,
    })

    -- Aba Créditos (SIMPLIFICADA)
    local CreditsTab = Window:CreateTab("Créditos", 4483362458)

    CreditsTab:CreateSection("Auto JJs")

    CreditsTab:CreateLabel("Criado por: k9zzzzzz")
    CreditsTab:CreateLabel("Discord: https://discord.gg/embreve")
    CreditsTab:CreateLabel("Suporte até 21 dígitos")

    -- Retornar referências dos controles
    return {
        Window = Window,
        startButton = startButton,
        startNumberInput = startNumberInput,
        endNumberInput = endNumberInput,
        finalPromptInput = finalPromptInput,
        speedSlider = speedSlider,
        jumpToggle = jumpToggle,
        pauseButton = pauseButton,
        stopButton = stopButton
    }
end

return UISystem 