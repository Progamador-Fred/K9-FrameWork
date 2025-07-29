-- Auto JJS Melhorado - Main.lua
-- Criado por K9zzzzz
-- Carregamento principal do script

return function(Options)
    -- Configurações padrão se não fornecidas
    Options = Options or {}
    Options.Keybind = Options.Keybind or Enum.KeyCode.RightControl
    Options.Tempo = Options.Tempo or 2.5
    Options.Rainbow = Options.Rainbow or false
    Options.Language = Options.Language or {UI = 'pt-br', Words = 'pt-br'}
    Options.StartNumber = Options.StartNumber or 1
    Options.EndNumber = Options.EndNumber or 80
    Options.FinalPrompt = Options.FinalPrompt or "!"
    Options.AntiDetection = Options.AntiDetection ~= false
    
    -- Carregar e executar o script
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/loadstring.lua'))()(Options)
end 