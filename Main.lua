-- Auto JJS Melhorado - Main.lua
-- Criado por K9zzzzz
-- Carregamento principal do script

local function LoadScript()
    -- Carregar módulos
    local UI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/modules/UI.lua'))()
    local Numbers = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/modules/Numbers.lua'))()
    local Notification = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/modules/Notification.lua'))()
    
    -- Inicializar o script
    local AutoJJs = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/modules/AutoJJs.lua'))()
    
    -- Configurações padrão
    local Options = {
        Keybind = Enum.KeyCode.RightControl,
        Tempo = 2.5,
        Rainbow = false,
        Language = {
            UI = 'pt-br',
            Words = 'pt-br'
        }
    }
    
    -- Iniciar o script
    AutoJJs:Initialize(Options)
end

-- Executar o script
LoadScript() 