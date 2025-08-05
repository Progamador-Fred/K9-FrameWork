-- numberConverter.lua
-- Responsável pela conversão de números para extenso em português
-- Criado por: k9zzzzzz

local NumberConverter = {}

-- Função para converter números para extenso
function NumberConverter.numberToWords(num)
    if num < 0 or num > 999999999999999999999 then
        return "NÚMERO INVÁLIDO"
    end
    
    if num == 0 then return "ZERO" end
    
    local units = {
        [0] = "", [1] = "UM", [2] = "DOIS", [3] = "TRÊS", [4] = "QUATRO", [5] = "CINCO",
        [6] = "SEIS", [7] = "SETE", [8] = "OITO", [9] = "NOVE", [10] = "DEZ",
        [11] = "ONZE", [12] = "DOZE", [13] = "TREZE", [14] = "QUATORZE", [15] = "QUINZE",
        [16] = "DEZESSEIS", [17] = "DEZESSETE", [18] = "DEZOITO", [19] = "DEZENOVE", [20] = "VINTE"
    }
    
    local tens = {
        [2] = "VINTE", [3] = "TRINTA", [4] = "QUARENTA", [5] = "CINQUENTA",
        [6] = "SESSENTA", [7] = "SETENTA", [8] = "OITENTA", [9] = "NOVENTA"
    }
    
    -- Função para converter grupos de 3 dígitos
    local function convertGroup(group, isLast)
        if group == 0 then return "" end
        
        local result = ""
        local hundreds = math.floor(group / 100)
        local remainder = group % 100
        
        -- Centenas
        if hundreds > 0 then
            if hundreds == 1 then
                result = "CENTO"
            else
                result = units[hundreds] .. "CENTOS"
            end
        end
        
        -- Dezenas e unidades
        if remainder > 0 then
            if remainder <= 20 then
                result = result .. (result ~= "" and " E " or "") .. units[remainder]
            else
                local ten = math.floor(remainder / 10)
                local unit = remainder % 10
                
                result = result .. (result ~= "" and " E " or "") .. tens[ten]
                if unit > 0 then
                    result = result .. " E " .. units[unit]
                end
            end
        end
        
        return result
    end
    
    -- Função para adicionar sufixos
    local function addSuffix(group, position)
        if group == 0 then return "" end
        
        local suffixes = {
            [1] = "", [2] = " MIL", [3] = " MILHÕES", [4] = " BILHÕES",
            [5] = " TRILHÕES", [6] = " QUATRILHÕES", [7] = " QUINTILHÕES"
        }
        
        local suffix = suffixes[position] or ""
        if group == 1 and position > 1 then
            return "UM" .. suffix
        else
            return convertGroup(group, position == 1) .. suffix
        end
    end
    
    -- Dividir o número em grupos
    local groups = {}
    local temp = num
    while temp > 0 do
        table.insert(groups, 1, temp % 1000)
        temp = math.floor(temp / 1000)
    end
    
    -- Converter cada grupo
    local result = ""
    for i, group in ipairs(groups) do
        local groupText = addSuffix(group, #groups - i + 1)
        if groupText ~= "" then
            result = result .. (result ~= "" and " " or "") .. groupText
        end
    end
    
    return result
end

return NumberConverter