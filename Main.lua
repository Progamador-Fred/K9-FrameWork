-- Auto JJS Melhorado - Main.lua
-- Criado por K9zzzzz

return function(Options)
    -- Configurações padrão
    Options = Options or {}
    Options.StartNumber = Options.StartNumber or 1
    Options.EndNumber = Options.EndNumber or 2
    Options.FinalPrompt = Options.FinalPrompt or "!"
    Options.SkipMode = Options.SkipMode or false
    Options.Tempo = Options.Tempo or 2.5
    
    -- Carregar e executar o script principal
    local script = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/UI.lua'))()
    script(Options)
end 