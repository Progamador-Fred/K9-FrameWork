-- Auto JJS Melhorado - Exemplos de uso
-- Este arquivo mostra diferentes formas de usar o script

-- Exemplo 1: Uso básico
print("=== Exemplo 1: Uso básico ===")
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/loadstring.lua'))()({
    Keybind = Enum.KeyCode.Home,
    Tempo = 2.5,
    Language = {
        UI = 'pt-br',
        Words = 'pt-br'
    }
})

-- Exemplo 2: Configuração avançada
print("=== Exemplo 2: Configuração avançada ===")
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/loadstring.lua'))()({
    Keybind = Enum.KeyCode.RightControl,
    Tempo = 1.5,
    Language = {
        UI = 'en-us',
        Words = 'es-es'
    },
    Rainbow = true,
    StartNumber = 10,
    EndNumber = 50,
    FinalPrompt = "!"
})

-- Exemplo 3: Configuração para velocidade
print("=== Exemplo 3: Configuração para velocidade ===")
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/loadstring.lua'))()({
    Keybind = Enum.KeyCode.F5,
    Tempo = 1.0,
    Language = {
        UI = 'pt-br',
        Words = 'en-us'
    },
    Rainbow = false,
    AntiDetection = true
})

-- Exemplo 4: Configuração minimalista
print("=== Exemplo 4: Configuração minimalista ===")
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/loadstring.lua'))()({
    Keybind = Enum.KeyCode.Insert,
    Tempo = 3.0,
    Language = {
        UI = 'pt-br',
        Words = 'pt-br'
    },
    Rainbow = false,
    StartNumber = 1,
    EndNumber = 20
})

-- Exemplo 5: Configuração para competição
print("=== Exemplo 5: Configuração para competição ===")
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/loadstring.lua'))()({
    Keybind = Enum.KeyCode.End,
    Tempo = 0.8,
    Language = {
        UI = 'en-us',
        Words = 'pt-br'
    },
    Rainbow = true,
    AntiDetection = false,
    StartNumber = 1,
    EndNumber = 100,
    FinalPrompt = "!"
})

print("Todos os exemplos foram carregados!")
print("Pressione a tecla configurada para mostrar a UI") 