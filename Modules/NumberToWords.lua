local NumberToWords = {}

local cache = {}

-- Dicionários básicos
local units = {"zero","um","dois","três","quatro","cinco","seis","sete","oito","nove"}
local teens = {"dez","onze","doze","treze","quatorze","quinze","dezesseis","dezessete","dezoito","dezenove"}
local tens = {"","dez","vinte","trinta","quarenta","cinquenta","sessenta","setenta","oitenta","noventa"}
local hundreds = {"","cem","duzentos","trezentos","quatrocentos","quinhentos","seiscentos","setecentos","oitocentos","novecentos"}

local function convertNumber(n)
    if n < 10 then return units[n+1] end
    if n < 20 then return teens[n-9] end
    if n < 100 then
        local t = math.floor(n/10)
        local u = n%10
        if u == 0 then return tens[t+1] else return tens[t+1].." e "..units[u+1] end
    end
    if n < 1000 then
        local h = math.floor(n/100)
        local rest = n%100
        if rest == 0 then return hundreds[h+1] end
        return hundreds[h+1].." e "..convertNumber(rest)
    end
    if n < 1000000 then
        local thousands = math.floor(n/1000)
        local rest = n%1000
        local str = convertNumber(thousands).." mil"
        if rest > 0 then str = str.." "..convertNumber(rest) end
        return str
    end
    if n <= 10000000 then
        local millions = math.floor(n/1000000)
        local rest = n%1000000
        local str = convertNumber(millions).." milhão"
        if millions > 1 then str = str.."es" end
        if rest > 0 then str = str.." "..convertNumber(rest) end
        return str
    end
    return tostring(n)
end

function NumberToWords:Convert(n)
    if cache[n] then return cache[n] end
    local result = convertNumber(n):upper() -- <<< AQUI FORÇA MAIÚSCULO
    cache[n] = result
    return result
end

return function(n) return NumberToWords:Convert(n) end
