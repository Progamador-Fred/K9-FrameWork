--[[
    🔥 K9zzzzzz Script Loader 🔥
    Autor: K9zzzzzz
    Descrição: Carrega todos os módulos e inicializa a interface premium.
]]

-- URL base do seu repositório
local repoBase = "https://raw.githubusercontent.com/SEU-USUARIO/K9zzzzzz-Script/main/Modules/"

-- Função para carregar módulos do GitHub
local function loadModule(name)
    local url = repoBase .. name .. ".lua"
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success then
        return result
    else
        warn("[K9zzzzzz Script] Falha ao carregar módulo: " .. name)
        return nil
    end
end

-- Carrega os módulos
local UIManager     = loadModule("UIManager")
local AutoJJs       = loadModule("AutoJJs")
local AutoVolver    = loadModule("AutoVolver")
local Utilities     = loadModule("Utilities")
local NumberToWords = loadModule("NumberToWords")

-- Validação: só continua se tudo carregou
if UIManager and AutoJJs and AutoVolver and Utilities and NumberToWords then
    Utilities:Notify("✅ K9zzzzzz Script carregado com sucesso!")
    UIManager:Init({
        AutoJJs = AutoJJs,
        AutoVolver = AutoVolver,
        Utilities = Utilities,
        NumberToWords = NumberToWords
    })
else
    warn("[K9zzzzzz Script] Erro: Nem todos os módulos foram carregados.")
end
