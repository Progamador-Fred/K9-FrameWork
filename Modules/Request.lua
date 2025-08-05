-- Request.lua
-- Módulo para gerenciar requisições HTTP e utilitários
-- Criado por K9zzzzz

local Request = {}

-- Função para fazer requisição HTTP GET
function Request:HttpGet(url)
    if not url or url == "" then
        warn("URL vazia!")
        return nil
    end
    
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

-- Função para fazer requisição HTTP POST
function Request:HttpPost(url, data)
    if not url or url == "" then
        warn("URL vazia!")
        return nil
    end
    
    local success, result = pcall(function()
        return game:HttpPost(url, data)
    end)
    
    if success then
        return result
    else
        warn("Erro ao fazer requisição HTTP POST:", result)
        return nil
    end
end

-- Função para carregar script via HTTP
function Request:LoadScript(url)
    local script = self:HttpGet(url)
    if script then
        local success, result = pcall(function()
            return loadstring(script)()
        end)
        
        if success then
            return result
        else
            warn("Erro ao executar script:", result)
            return nil
        end
    end
    return nil
end

-- Função para verificar se uma URL é válida
function Request:IsValidUrl(url)
    if not url or type(url) ~= "string" then
        return false
    end
    
    -- Verificar se começa com http:// ou https://
    return url:match("^https?://") ~= nil
end

-- Função para fazer requisição com timeout
function Request:HttpGetWithTimeout(url, timeout)
    timeout = timeout or 10 -- 10 segundos padrão
    
    local startTime = tick()
    local result = nil
    local completed = false
    
    spawn(function()
        result = self:HttpGet(url)
        completed = true
    end)
    
    -- Aguardar com timeout
    while not completed and (tick() - startTime) < timeout do
        wait(0.1)
    end
    
    if not completed then
        warn("Timeout na requisição HTTP")
        return nil
    end
    
    return result
end

-- Função para fazer múltiplas requisições
function Request:HttpGetMultiple(urls)
    if not urls or type(urls) ~= "table" then
        warn("URLs deve ser uma tabela!")
        return {}
    end
    
    local results = {}
    
    for i, url in ipairs(urls) do
        if self:IsValidUrl(url) then
            results[i] = self:HttpGet(url)
        else
            warn("URL inválida na posição", i, ":", url)
            results[i] = nil
        end
    end
    
    return results
end

-- Função para fazer requisição JSON
function Request:HttpGetJSON(url)
    local response = self:HttpGet(url)
    if response then
        local success, result = pcall(function()
            return game:GetService("HttpService"):JSONDecode(response)
        end)
        
        if success then
            return result
        else
            warn("Erro ao decodificar JSON:", result)
            return nil
        end
    end
    return nil
end

-- Função para fazer requisição POST JSON
function Request:HttpPostJSON(url, data)
    local httpService = game:GetService("HttpService")
    local jsonData = httpService:JSONEncode(data)
    
    local response = self:HttpPost(url, jsonData)
    if response then
        local success, result = pcall(function()
            return httpService:JSONDecode(response)
        end)
        
        if success then
            return result
        else
            warn("Erro ao decodificar JSON da resposta:", result)
            return nil
        end
    end
    return nil
end

-- Função para verificar conectividade
function Request:TestConnectivity()
    local testUrls = {
        "https://httpbin.org/get",
        "https://api.github.com",
        "https://jsonplaceholder.typicode.com/posts/1"
    }
    
    local results = {}
    
    for i, url in ipairs(testUrls) do
        local startTime = tick()
        local response = self:HttpGet(url)
        local endTime = tick()
        
        results[i] = {
            URL = url,
            Success = response ~= nil,
            ResponseTime = endTime - startTime,
            ResponseSize = response and #response or 0
        }
    end
    
    return results
end

-- Função para obter informações do sistema
function Request:GetSystemInfo()
    return {
        HttpEnabled = pcall(function() return game:HttpGet("https://httpbin.org/get") end),
        HttpService = game:GetService("HttpService") ~= nil,
        Platform = game:GetService("UserInputService").TouchEnabled and "Mobile" or "Desktop"
    }
end

-- Função para testar o módulo
function Request:Test()
    print("=== Teste do Módulo Request ===")
    
    local systemInfo = self:GetSystemInfo()
    print("HttpEnabled:", systemInfo.HttpEnabled)
    print("HttpService:", systemInfo.HttpService)
    print("Platform:", systemInfo.Platform)
    
    local connectivity = self:TestConnectivity()
    for i, result in ipairs(connectivity) do
        print("Teste", i, ":", result.URL, "-", result.Success, "-", string.format("%.3fs", result.ResponseTime))
    end
    
    print("================================")
end

return Request 