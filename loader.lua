--[[
    AutoJJs Loader
    Carrega o script principal via GitHub
    Compatível com Delta, Hydrogen e Fluxus
]]

print("AutoJJs - Carregando...")

-- URL do script principal
local scriptUrl = "https://raw.githubusercontent.com/K9zzz32/Auto-JJ-s/main/scripts/jj_main.lua"

-- Função para carregar o script principal
local function loadMainScript()
    local success, result = pcall(function()
        return loadstring(game:HttpGet(scriptUrl))()
    end)
    
    if success then
        print("AutoJJs - Script carregado com sucesso!")
    else
        warn("AutoJJs - Erro ao carregar script: " .. tostring(result))
        print("Verifique se a URL está correta e se o script existe no GitHub.")
    end
end

-- Tenta carregar o script
loadMainScript() 