-- Loader.lua
-- Sistema para carregar módulos
-- Criado por K9zzzzz

local Loader = {}

-- Função para carregar módulo via HTTP
function Loader:LoadModule(moduleName)
    local baseUrl = "https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/"
    local url = baseUrl .. moduleName .. ".lua"
    
    local success, result = pcall(function()
        local script = game:HttpGet(url)
        return loadstring(script)()
    end)
    
    if success then
        return result
    else
        warn("Erro ao carregar módulo:", moduleName, result)
        return nil
    end
end

-- Função para carregar todos os módulos necessários
function Loader:LoadAllModules()
    local modules = {}
    
    -- Carregar módulos
    modules.Extenso = self:LoadModule("Extenso")
    modules.ChatAdapter = self:LoadModule("ChatAdapter")
    modules.Notification = self:LoadModule("Notification")
    modules.Character = self:LoadModule("Character")
    modules.Request = self:LoadModule("Request")
    
    return modules
end

-- Função para verificar se todos os módulos foram carregados
function Loader:VerifyModules(modules)
    local requiredModules = {"Extenso", "ChatAdapter", "Notification"}
    local missingModules = {}
    
    for _, moduleName in ipairs(requiredModules) do
        if not modules[moduleName] then
            table.insert(missingModules, moduleName)
        end
    end
    
    if #missingModules > 0 then
        warn("Módulos faltando:", table.concat(missingModules, ", "))
        return false
    end
    
    return true
end

return Loader 