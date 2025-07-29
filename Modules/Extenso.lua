-- Extenso.lua
-- Sistema avançado de conversão numérica
-- Criado por K9zzzzz

local Extenso = {}

-- Números básicos (1-20)
local numerosBasicos = {
    [1] = "UM", [2] = "DOIS", [3] = "TRÊS", [4] = "QUATRO", [5] = "CINCO",
    [6] = "SEIS", [7] = "SETE", [8] = "OITO", [9] = "NOVE", [10] = "DEZ",
    [11] = "ONZE", [12] = "DOZE", [13] = "TREZE", [14] = "QUATORZE", [15] = "QUINZE",
    [16] = "DEZESSEIS", [17] = "DEZESSETE", [18] = "DEZOITO", [19] = "DEZENOVE", [20] = "VINTE"
}

-- Dezenas (30, 40, 50, etc)
local dezenas = {
    [30] = "TRINTA", [40] = "QUARENTA", [50] = "CINQUENTA",
    [60] = "SESSENTA", [70] = "SETENTA", [80] = "OITENTA", [90] = "NOVENTA"
}

-- Centenas
local centenas = {
    [100] = "CEM", [200] = "DUZENTOS", [300] = "TREZENTOS", [400] = "QUATROCENTOS",
    [500] = "QUINHENTOS", [600] = "SEISCENTOS", [700] = "SETECENTOS",
    [800] = "OITOCENTOS", [900] = "NOVECENTOS"
}

-- Milhares e milhões
local milhares = {
    [1000] = "MIL", [1000000] = "MILHÃO", [1000000000] = "BILHÃO"
}

-- Função para converter número para extenso
function Extenso:Converter(numero)
    if numero <= 20 then
        return numerosBasicos[numero]
    elseif numero <= 99 then
        return self:ConverterDezenas(numero)
    elseif numero <= 999 then
        return self:ConverterCentenas(numero)
    elseif numero <= 999999 then
        return self:ConverterMilhares(numero)
    elseif numero <= 999999999 then
        return self:ConverterMilhoes(numero)
    else
        -- Para números gigantes, usar gambiarra avançada
        return self:GambiarraAvancada(numero)
    end
end

-- Converter dezenas
function Extenso:ConverterDezenas(numero)
    local dezena = math.floor(numero / 10) * 10
    local unidade = numero % 10
    
    if unidade == 0 then
        return dezenas[dezena]
    else
        return dezenas[dezena] .. " E " .. numerosBasicos[unidade]
    end
end

-- Converter centenas
function Extenso:ConverterCentenas(numero)
    local centena = math.floor(numero / 100) * 100
    local resto = numero % 100
    
    if resto == 0 then
        return centenas[centena]
    elseif resto <= 20 then
        return centenas[centena] .. " E " .. numerosBasicos[resto]
    else
        return centenas[centena] .. " E " .. self:ConverterDezenas(resto)
    end
end

-- Converter milhares
function Extenso:ConverterMilhares(numero)
    local milhar = math.floor(numero / 1000)
    local resto = numero % 1000
    
    local resultado = ""
    
    if milhar == 1 then
        resultado = "MIL"
    else
        resultado = self:Converter(milhar) .. " MIL"
    end
    
    if resto > 0 then
        if resto < 100 then
            resultado = resultado .. " E " .. self:Converter(resto)
        else
            resultado = resultado .. " " .. self:Converter(resto)
        end
    end
    
    return resultado
end

-- Converter milhões
function Extenso:ConverterMilhoes(numero)
    local milhao = math.floor(numero / 1000000)
    local resto = numero % 1000000
    
    local resultado = ""
    
    if milhao == 1 then
        resultado = "UM MILHÃO"
    else
        resultado = self:Converter(milhao) .. " MILHÕES"
    end
    
    if resto > 0 then
        resultado = resultado .. " " .. self:Converter(resto)
    end
    
    return resultado
end

-- Gambiarra avançada para números gigantes
function Extenso:GambiarraAvancada(numero)
    local numeroStr = tostring(numero)
    
    -- Se for um número muito grande, usar estratégia especial
    if #numeroStr > 15 then
        local primeirosDigitos = numeroStr:sub(1, 6)
        return "NÚMERO " .. primeirosDigitos .. "..."
    elseif #numeroStr > 10 then
        -- Para números grandes, converter em grupos
        local resultado = ""
        local grupos = {}
        
        -- Dividir em grupos de 3 dígitos
        for i = #numeroStr, 1, -3 do
            local grupo = numeroStr:sub(math.max(1, i-2), i)
            table.insert(grupos, 1, tonumber(grupo))
        end
        
        -- Converter cada grupo
        for i, grupo in ipairs(grupos) do
            if grupo > 0 then
                if i == 1 then
                    resultado = self:Converter(grupo)
                else
                    resultado = self:Converter(grupo) .. " " .. self:GetSufixoGrupo(i) .. " " .. resultado
                end
            end
        end
        
        return resultado
    else
        -- Para números normais, converter cada dígito
        local resultado = ""
        for i = 1, #numeroStr do
            local digito = tonumber(numeroStr:sub(i, i))
            if digito > 0 then
                resultado = resultado .. numerosBasicos[digito] .. " "
            end
        end
        return resultado:gsub("%s+$", "")
    end
end

-- Obter sufixo do grupo (mil, milhão, etc)
function Extenso:GetSufixoGrupo(posicao)
    local sufixos = {
        [2] = "MIL",
        [3] = "MILHÃO",
        [4] = "BILHÃO",
        [5] = "TRILHÃO"
    }
    return sufixos[posicao] or "GRUPO"
end

-- Função para obter número por extenso
function Extenso:GetNumero(numero)
    if not numero or numero <= 0 then
        return "ZERO"
    end
    
    -- Validar entrada
    if type(numero) ~= "number" then
        numero = tonumber(numero) or 0
    end
    
    if numero <= 0 then
        return "ZERO"
    end
    
    return self:Converter(numero)
end

-- Função para testar conversão
function Extenso:TestarConversao()
    local testes = {1, 10, 25, 100, 150, 1000, 1500, 1000000, 999999999}
    
    for _, numero in ipairs(testes) do
        print(numero .. " = " .. self:GetNumero(numero))
    end
end

return Extenso 