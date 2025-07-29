-- Auto JJS Melhorado - Main.lua
-- Criado por K9zzzzz
-- Sistema completo com adaptação automática de chat

return function(Options)
    -- Configurações padrão
    Options = Options or {}
    Options.Keybind = Options.Keybind or Enum.KeyCode.RightControl
    Options.Tempo = Options.Tempo or 2.5
    Options.Rainbow = Options.Rainbow or false
    Options.Language = Options.Language or {UI = 'pt-br', Words = 'pt-br'}
    Options.StartNumber = Options.StartNumber or 1
    Options.EndNumber = Options.EndNumber or 80
    Options.FinalPrompt = Options.FinalPrompt or "!"
    Options.AntiDetection = Options.AntiDetection ~= false
    
    -- Carregar módulos
    local UI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/UI.lua'))()
    local Numbers = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Numbers.lua'))()
    local Notification = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Notification.lua'))()
    local ChatAdapter = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/ChatAdapter.lua'))()
    
    -- Inicializar módulos
    UI:Initialize(Options)
    Numbers:Initialize()
    Notification:Initialize()
    ChatAdapter:Initialize()
    
    -- Inicializar sistema principal
    local AutoJJs = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/AutoJJs.lua'))()
    
    -- Passar módulos para o AutoJJs
    AutoJJs:SetModules(UI, Numbers, Notification, ChatAdapter)
    
    -- Inicializar o script
    AutoJJs:Initialize(Options)
    
    print("Auto JJS Melhorado carregado com sucesso!")
    print("Criado por K9zzzzz")
    print("Sistema de adaptação de chat ativo")
end 