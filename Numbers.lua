-- Numbers.lua
-- Sistema de números por extenso em múltiplos idiomas
-- Criado por K9zzzzz

local Numbers = {}
Numbers.__index = Numbers

-- Números por extenso em diferentes idiomas (1-80)
local NumberData = {
    ['pt-br'] = {
        [1] = "UM", [2] = "DOIS", [3] = "TRÊS", [4] = "QUATRO", [5] = "CINCO",
        [6] = "SEIS", [7] = "SETE", [8] = "OITO", [9] = "NOVE", [10] = "DEZ",
        [11] = "ONZE", [12] = "DOZE", [13] = "TREZE", [14] = "QUATORZE", [15] = "QUINZE",
        [16] = "DEZESSEIS", [17] = "DEZESSETE", [18] = "DEZOITO", [19] = "DEZENOVE", [20] = "VINTE",
        [21] = "VINTE E UM", [22] = "VINTE E DOIS", [23] = "VINTE E TRÊS", [24] = "VINTE E QUATRO", [25] = "VINTE E CINCO",
        [26] = "VINTE E SEIS", [27] = "VINTE E SETE", [28] = "VINTE E OITO", [29] = "VINTE E NOVE", [30] = "TRINTA",
        [31] = "TRINTA E UM", [32] = "TRINTA E DOIS", [33] = "TRINTA E TRÊS", [34] = "TRINTA E QUATRO", [35] = "TRINTA E CINCO",
        [36] = "TRINTA E SEIS", [37] = "TRINTA E SETE", [38] = "TRINTA E OITO", [39] = "TRINTA E NOVE", [40] = "QUARENTA",
        [41] = "QUARENTA E UM", [42] = "QUARENTA E DOIS", [43] = "QUARENTA E TRÊS", [44] = "QUARENTA E QUATRO", [45] = "QUARENTA E CINCO",
        [46] = "QUARENTA E SEIS", [47] = "QUARENTA E SETE", [48] = "QUARENTA E OITO", [49] = "QUARENTA E NOVE", [50] = "CINQUENTA",
        [51] = "CINQUENTA E UM", [52] = "CINQUENTA E DOIS", [53] = "CINQUENTA E TRÊS", [54] = "CINQUENTA E QUATRO", [55] = "CINQUENTA E CINCO",
        [56] = "CINQUENTA E SEIS", [57] = "CINQUENTA E SETE", [58] = "CINQUENTA E OITO", [59] = "CINQUENTA E NOVE", [60] = "SESSENTA",
        [61] = "SESSENTA E UM", [62] = "SESSENTA E DOIS", [63] = "SESSENTA E TRÊS", [64] = "SESSENTA E QUATRO", [65] = "SESSENTA E CINCO",
        [66] = "SESSENTA E SEIS", [67] = "SESSENTA E SETE", [68] = "SESSENTA E OITO", [69] = "SESSENTA E NOVE", [70] = "SETENTA",
        [71] = "SETENTA E UM", [72] = "SETENTA E DOIS", [73] = "SETENTA E TRÊS", [74] = "SETENTA E QUATRO", [75] = "SETENTA E CINCO",
        [76] = "SETENTA E SEIS", [77] = "SETENTA E SETE", [78] = "SETENTA E OITO", [79] = "SETENTA E NOVE", [80] = "OITENTA"
    },
    ['en-us'] = {
        [1] = "ONE", [2] = "TWO", [3] = "THREE", [4] = "FOUR", [5] = "FIVE",
        [6] = "SIX", [7] = "SEVEN", [8] = "EIGHT", [9] = "NINE", [10] = "TEN",
        [11] = "ELEVEN", [12] = "TWELVE", [13] = "THIRTEEN", [14] = "FOURTEEN", [15] = "FIFTEEN",
        [16] = "SIXTEEN", [17] = "SEVENTEEN", [18] = "EIGHTEEN", [19] = "NINETEEN", [20] = "TWENTY",
        [21] = "TWENTY-ONE", [22] = "TWENTY-TWO", [23] = "TWENTY-THREE", [24] = "TWENTY-FOUR", [25] = "TWENTY-FIVE",
        [26] = "TWENTY-SIX", [27] = "TWENTY-SEVEN", [28] = "TWENTY-EIGHT", [29] = "TWENTY-NINE", [30] = "THIRTY",
        [31] = "THIRTY-ONE", [32] = "THIRTY-TWO", [33] = "THIRTY-THREE", [34] = "THIRTY-FOUR", [35] = "THIRTY-FIVE",
        [36] = "THIRTY-SIX", [37] = "THIRTY-SEVEN", [38] = "THIRTY-EIGHT", [39] = "THIRTY-NINE", [40] = "FORTY",
        [41] = "FORTY-ONE", [42] = "FORTY-TWO", [43] = "FORTY-THREE", [44] = "FORTY-FOUR", [45] = "FORTY-FIVE",
        [46] = "FORTY-SIX", [47] = "FORTY-SEVEN", [48] = "FORTY-EIGHT", [49] = "FORTY-NINE", [50] = "FIFTY",
        [51] = "FIFTY-ONE", [52] = "FIFTY-TWO", [53] = "FIFTY-THREE", [54] = "FIFTY-FOUR", [55] = "FIFTY-FIVE",
        [56] = "FIFTY-SIX", [57] = "FIFTY-SEVEN", [58] = "FIFTY-EIGHT", [59] = "FIFTY-NINE", [60] = "SIXTY",
        [61] = "SIXTY-ONE", [62] = "SIXTY-TWO", [63] = "SIXTY-THREE", [64] = "SIXTY-FOUR", [65] = "SIXTY-FIVE",
        [66] = "SIXTY-SIX", [67] = "SIXTY-SEVEN", [68] = "SIXTY-EIGHT", [69] = "SIXTY-NINE", [70] = "SEVENTY",
        [71] = "SEVENTY-ONE", [72] = "SEVENTY-TWO", [73] = "SEVENTY-THREE", [74] = "SEVENTY-FOUR", [75] = "SEVENTY-FIVE",
        [76] = "SEVENTY-SIX", [77] = "SEVENTY-SEVEN", [78] = "SEVENTY-EIGHT", [79] = "SEVENTY-NINE", [80] = "EIGHTY"
    },
    ['es-es'] = {
        [1] = "UNO", [2] = "DOS", [3] = "TRES", [4] = "CUATRO", [5] = "CINCO",
        [6] = "SEIS", [7] = "SIETE", [8] = "OCHO", [9] = "NUEVE", [10] = "DIEZ",
        [11] = "ONCE", [12] = "DOCE", [13] = "TRECE", [14] = "CATORCE", [15] = "QUINCE",
        [16] = "DIECISÉIS", [17] = "DIECISIETE", [18] = "DIECIOCHO", [19] = "DIECINUEVE", [20] = "VEINTE",
        [21] = "VEINTIUNO", [22] = "VEINTIDÓS", [23] = "VEINTITRÉS", [24] = "VEINTICUATRO", [25] = "VEINTICINCO",
        [26] = "VEINTISÉIS", [27] = "VEINTISIETE", [28] = "VEINTIOCHO", [29] = "VEINTINUEVE", [30] = "TREINTA",
        [31] = "TREINTA Y UNO", [32] = "TREINTA Y DOS", [33] = "TREINTA Y TRES", [34] = "TREINTA Y CUATRO", [35] = "TREINTA Y CINCO",
        [36] = "TREINTA Y SEIS", [37] = "TREINTA Y SIETE", [38] = "TREINTA Y OCHO", [39] = "TREINTA Y NUEVE", [40] = "CUARENTA",
        [41] = "CUARENTA Y UNO", [42] = "CUARENTA Y DOS", [43] = "CUARENTA Y TRES", [44] = "CUARENTA Y CUATRO", [45] = "CUARENTA Y CINCO",
        [46] = "CUARENTA Y SEIS", [47] = "CUARENTA Y SIETE", [48] = "CUARENTA Y OCHO", [49] = "CUARENTA Y NUEVE", [50] = "CINCUENTA",
        [51] = "CINCUENTA Y UNO", [52] = "CINCUENTA Y DOS", [53] = "CINCUENTA Y TRES", [54] = "CINCUENTA Y CUATRO", [55] = "CINCUENTA Y CINCO",
        [56] = "CINCUENTA Y SEIS", [57] = "CINCUENTA Y SIETE", [58] = "CINCUENTA Y OCHO", [59] = "CINCUENTA Y NUEVE", [60] = "SESENTA",
        [61] = "SESENTA Y UNO", [62] = "SESENTA Y DOS", [63] = "SESENTA Y TRES", [64] = "SESENTA Y CUATRO", [65] = "SESENTA Y CINCO",
        [66] = "SESENTA Y SEIS", [67] = "SESENTA Y SIETE", [68] = "SESENTA Y OCHO", [69] = "SESENTA Y NUEVE", [70] = "SETENTA",
        [71] = "SETENTA Y UNO", [72] = "SETENTA Y DOS", [73] = "SETENTA Y TRES", [74] = "SETENTA Y CUATRO", [75] = "SETENTA Y CINCO",
        [76] = "SETENTA Y SEIS", [77] = "SETENTA Y SIETE", [78] = "SETENTA Y OCHO", [79] = "SETENTA Y NUEVE", [80] = "OCHENTA"
    }
}

-- Função para converter números grandes para extenso (Português)
local function ConvertLargeNumberPT(number)
    if number <= 80 then
        return NumberData['pt-br'][number]
    end
    
    -- Para números maiores que 80, usar o número em dígitos
    return tostring(number)
end

-- Função para converter números grandes para extenso (Inglês)
local function ConvertLargeNumberEN(number)
    if number <= 80 then
        return NumberData['en-us'][number]
    end
    
    -- Para números maiores que 80, usar o número em dígitos
    return tostring(number)
end

-- Função para converter números grandes para extenso (Espanhol)
local function ConvertLargeNumberES(number)
    if number <= 80 then
        return NumberData['es-es'][number]
    end
    
    -- Para números maiores que 80, usar o número em dígitos
    return tostring(number)
end

-- Função para obter número por extenso
function Numbers:GetNumber(language, number)
    if not NumberData[language] then
        language = 'pt-br' -- Fallback para português
    end
    
    -- Verificar se temos o número pré-definido (1-80)
    if NumberData[language][number] then
        return NumberData[language][number]
    end
    
    -- Para números maiores que 80, usar conversão específica por idioma
    if language == 'pt-br' then
        return ConvertLargeNumberPT(number)
    elseif language == 'en-us' then
        return ConvertLargeNumberEN(number)
    elseif language == 'es-es' then
        return ConvertLargeNumberES(number)
    else
        -- Fallback para número simples
        return tostring(number)
    end
end

-- Função para obter lista de idiomas disponíveis
function Numbers:GetAvailableLanguages()
    local languages = {}
    for lang, _ in pairs(NumberData) do
        table.insert(languages, lang)
    end
    return languages
end

-- Função para verificar se número existe
function Numbers:HasNumber(language, number)
    return NumberData[language] and NumberData[language][number] ~= nil
end

-- Função para obter número máximo pré-definido
function Numbers:GetMaxPredefinedNumber()
    return 80
end

-- Função para verificar se número é suportado
function Numbers:IsNumberSupported(number)
    return number >= 1 and number <= 100000000 -- Suporte até 100 milhões
end

-- Função de inicialização
function Numbers:Initialize()
    -- Placeholder para inicialização se necessário
end

return Numbers 