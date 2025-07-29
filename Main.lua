-- Auto JJS v2.1 - Main.lua
-- Script principal para carregamento e bootstrap
-- Criado por K9zzzzz

-- Função principal que será executada
local function Main(Options)
    -- Configurações padrão
    Options = Options or {}
    Options.Tempo = Options.Tempo or 2.5
    Options.Language = Options.Language or "pt-br"
    
    -- Carregar e executar o script principal
    local success, result = pcall(function()
        local script = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/UI.lua'))()
        return script(Options)
    end)
    
    if not success then
        warn("Erro ao carregar Auto JJS:", result)
        return false
    end
    
    return true
end

-- Executar imediatamente se não houver argumentos
if not script.Parent then
    Main()
else
    return Main
end 