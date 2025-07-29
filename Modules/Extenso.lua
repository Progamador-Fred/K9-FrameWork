-- Extenso.lua
-- Gambiarra melhorada para converter qualquer número para extenso
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

-- Função para converter número para extenso
function Extenso:Converter(numero)
    if numero <= 20 then
        return numerosBasicos[numero]
    elseif numero <= 99 then
        local dezena = math.floor(numero / 10) * 10
        local unidade = numero % 10
        
        if unidade == 0 then
            return dezenas[dezena]
        else
            return dezenas[dezena] .. " E " .. numerosBasicos[unidade]
        end
    else
        -- Para números maiores que 99, usar gambiarra melhorada
        return self:GambiarraMelhorada(numero)
    end
end

-- Gambiarra melhorada para números grandes
function Extenso:GambiarraMelhorada(numero)
    local numeroStr = tostring(numero)
    local resultado = ""
    
    -- Se o número for muito grande, usar estratégia diferente
    if #numeroStr > 10 then
        -- Para números gigantes, usar apenas os primeiros dígitos
        local primeirosDigitos = numeroStr:sub(1, 5)
        resultado = "NÚMERO " .. primeirosDigitos
    else
        -- Para números normais, converter cada dígito
        for i = 1, #numeroStr do
            local digito = tonumber(numeroStr:sub(i, i))
            if digito > 0 then
                resultado = resultado .. numerosBasicos[digito] .. " "
            end
        end
        
        resultado = resultado:gsub("%s+$", "") -- Remove espaços extras
    end
    
    return resultado
end

-- Função para obter número por extenso
function Extenso:GetNumero(numero)
    if not numero or numero <= 0 then
        return "ZERO"
    end
    
    return self:Converter(numero)
end

return Extenso 