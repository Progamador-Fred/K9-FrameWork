-- Request.lua
-- Módulo para gerenciar requisições
-- Criado por K9zzzzz

local Request = {}

-- Função para fazer requisição HTTP
function Request:HttpGet(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success then
        return result
    else
        warn("Erro ao fazer requisição HTTP:", result)
        return nil
    end
end

-- Função para carregar script
function Request:LoadScript(url)
    local script = self:HttpGet(url)
    if script then
        return loadstring(script)()
    end
    return nil
end

return Request 