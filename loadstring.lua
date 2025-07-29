-- Auto JJS Melhorado - Loadstring
-- Criado por K9zzzzz
-- Arquivo para uso via loadstring

local function LoadAutoJJs(options)
    options = options or {}
    
    -- Configurações padrão
    local defaultOptions = {
        Keybind = Enum.KeyCode.RightControl,
        Tempo = 2.5,
        Rainbow = false,
        Language = {
            UI = 'pt-br',
            Words = 'pt-br'
        },
        StartNumber = 1,
        EndNumber = 80,
        FinalPrompt = "!",
        AntiDetection = true
    }
    
    -- Mesclar configurações
    for key, value in pairs(options) do
        defaultOptions[key] = value
    end
    
    -- Carregar módulos
    local UI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/modules/UI.lua'))()
    local Numbers = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/modules/Numbers.lua'))()
    local Notification = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/modules/Notification.lua'))()
    
    -- Inicializar o script
    local AutoJJs = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/modules/AutoJJs.lua'))()
    
    -- Iniciar o script
    AutoJJs:Initialize(defaultOptions)
    
    return AutoJJs
end

-- Exemplo de uso:
-- loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/loadstring.lua'))()({
--     Keybind = Enum.KeyCode.Home,
--     Tempo = 2.0,
--     Language = {
--         UI = 'en-us',
--         Words = 'pt-br'
--     },
--     Rainbow = true
-- })

return LoadAutoJJs 