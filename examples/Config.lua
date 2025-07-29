-- Configurações do Auto JJS Melhorado
-- Modifique estas configurações conforme sua necessidade

local Config = {
    -- Tecla para iniciar/parar o script
    Keybind = Enum.KeyCode.Home,
    
    -- Tempo entre cada mensagem (em segundos)
    Tempo = 2.5,
    
    -- Efeito rainbow na UI (true/false)
    Rainbow = false,
    
    -- Configurações de idioma
    Language = {
        UI = 'pt-br',     -- Idioma da interface (pt-br, en-us, es-es)
        Words = 'pt-br'   -- Idioma dos números (pt-br, en-us, es-es)
    },
    
    -- Configurações de contagem
    StartNumber = 1,      -- Número inicial
    EndNumber = 80,       -- Número final
    
    -- Final da mensagem (após o número)
    FinalPrompt = "!",
    
    -- Configurações de notificação
    Notifications = {
        Enabled = true,    -- Ativar/desativar notificações
        Duration = 2,      -- Duração das notificações (segundos)
        Position = "TopRight" -- Posição: "TopRight", "TopLeft", "BottomRight", "BottomLeft"
    },
    
    -- Configurações avançadas
    Advanced = {
        AntiDetection = true,  -- Variação no timing para evitar detecção
        RandomDelay = 0.1,    -- Variação aleatória no delay (segundos)
        MaxRetries = 3        -- Máximo de tentativas se falhar
    }
}

return Config 