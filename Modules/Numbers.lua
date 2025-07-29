-- Auto JJS Melhorado - Numbers Module
-- Criado por K9zzzzz
-- Módulo para gerenciar números por extenso em diferentes idiomas

local Numbers = {}
Numbers.__index = Numbers

-- Números por extenso em diferentes idiomas
local NumberData = {
    ['pt-br'] = {
        "UM", "DOIS", "TRÊS", "QUATRO", "CINCO", "SEIS", "SETE", "OITO", "NOVE", "DEZ",
        "ONZE", "DOZE", "TREZE", "QUATORZE", "QUINZE", "DEZESSEIS", "DEZESSETE", "DEZOITO", "DEZENOVE", "VINTE",
        "VINTE E UM", "VINTE E DOIS", "VINTE E TRÊS", "VINTE E QUATRO", "VINTE E CINCO", "VINTE E SEIS", "VINTE E SETE", "VINTE E OITO", "VINTE E NOVE", "TRINTA",
        "TRINTA E UM", "TRINTA E DOIS", "TRINTA E TRÊS", "TRINTA E QUATRO", "TRINTA E CINCO", "TRINTA E SEIS", "TRINTA E SIETE", "TRINTA E OITO", "TRINTA E NOVE", "QUARENTA",
        "QUARENTA E UM", "QUARENTA E DOIS", "QUARENTA E TRÊS", "QUARENTA E QUATRO", "QUARENTA E CINCO", "QUARENTA E SEIS", "QUARENTA E SETE", "QUARENTA E OITO", "QUARENTA E NOVE", "CINQUENTA",
        "CINQUENTA E UM", "CINQUENTA E DOIS", "CINQUENTA E TRÊS", "CINQUENTA E QUATRO", "CINQUENTA E CINCO", "CINQUENTA E SEIS", "CINQUENTA E SETE", "CINQUENTA E OITO", "CINQUENTA E NOVE", "SESSENTA",
        "SESSENTA E UM", "SESSENTA E DOIS", "SESSENTA E TRÊS", "SESSENTA E QUATRO", "SESSENTA E CINCO", "SESSENTA E SEIS", "SESSENTA E SETE", "SESSENTA E OITO", "SESSENTA E NOVE", "SETENTA",
        "SETENTA E UM", "SETENTA E DOIS", "SETENTA E TRÊS", "SETENTA E QUATRO", "SETENTA E CINCO", "SETENTA E SEIS", "SETENTA E SETE", "SETENTA E OITO", "SETENTA E NOVE", "OITENTA"
    },
    ['en-us'] = {
        "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "EIGHT", "NINE", "TEN",
        "ELEVEN", "TWELVE", "THIRTEEN", "FOURTEEN", "FIFTEEN", "SIXTEEN", "SEVENTEEN", "EIGHTEEN", "NINETEEN", "TWENTY",
        "TWENTY ONE", "TWENTY TWO", "TWENTY THREE", "TWENTY FOUR", "TWENTY FIVE", "TWENTY SIX", "TWENTY SEVEN", "TWENTY EIGHT", "TWENTY NINE", "THIRTY",
        "THIRTY ONE", "THIRTY TWO", "THIRTY THREE", "THIRTY FOUR", "THIRTY FIVE", "THIRTY SIX", "THIRTY SEVEN", "THIRTY EIGHT", "THIRTY NINE", "FORTY",
        "FORTY ONE", "FORTY TWO", "FORTY THREE", "FORTY FOUR", "FORTY FIVE", "FORTY SIX", "FORTY SEVEN", "FORTY EIGHT", "FORTY NINE", "FIFTY",
        "FIFTY ONE", "FIFTY TWO", "FIFTY THREE", "FIFTY FOUR", "FIFTY FIVE", "FIFTY SIX", "FIFTY SEVEN", "FIFTY EIGHT", "FIFTY NINE", "SIXTY",
        "SIXTY ONE", "SIXTY TWO", "SIXTY THREE", "SIXTY FOUR", "SIXTY FIVE", "SIXTY SIX", "SIXTY SEVEN", "SIXTY EIGHT", "SIXTY NINE", "SEVENTY",
        "SEVENTY ONE", "SEVENTY TWO", "SEVENTY THREE", "SEVENTY FOUR", "SEVENTY FIVE", "SEVENTY SIX", "SEVENTY SEVEN", "SEVENTY EIGHT", "SEVENTY NINE", "EIGHTY"
    },
    ['es-es'] = {
        "UNO", "DOS", "TRES", "CUATRO", "CINCO", "SEIS", "SIETE", "OCHO", "NUEVE", "DIEZ",
        "ONCE", "DOCE", "TRECE", "CATORCE", "QUINCE", "DIECISÉIS", "DIECISIETE", "DIECIOCHO", "DIECINUEVE", "VEINTE",
        "VEINTIUNO", "VEINTIDÓS", "VEINTITRÉS", "VEINTICUATRO", "VEINTICINCO", "VEINTISÉIS", "VEINTISIETE", "VEINTIOCHO", "VEINTINUEVE", "TREINTA",
        "TREINTA Y UNO", "TREINTA Y DOS", "TREINTA Y TRES", "TREINTA Y CUATRO", "TREINTA Y CINCO", "TREINTA Y SEIS", "TREINTA Y SIETE", "TREINTA Y OCHO", "TREINTA Y NUEVE", "CUARENTA",
        "CUARENTA Y UNO", "CUARENTA Y DOS", "CUARENTA Y TRES", "CUARENTA Y CUATRO", "CUARENTA Y CINCO", "CUARENTA Y SEIS", "CUARENTA Y SIETE", "CUARENTA Y OCHO", "CUARENTA Y NUEVE", "CINCUENTA",
        "CINCUENTA Y UNO", "CINCUENTA Y DOS", "CINCUENTA Y TRES", "CINCUENTA Y CUATRO", "CINCUENTA Y CINCO", "CINCUENTA Y SEIS", "CINCUENTA Y SIETE", "CINCUENTA Y OCHO", "CINCUENTA Y NUEVE", "SESENTA",
        "SESENTA Y UNO", "SESENTA Y DOS", "SESENTA Y TRES", "SESENTA Y CUATRO", "SESENTA Y CINCO", "SESENTA Y SEIS", "SESENTA Y SIETE", "SESENTA Y OCHO", "SESENTA Y NUEVE", "SETENTA",
        "SETENTA Y UNO", "SETENTA Y DOS", "SETENTA Y TRES", "SETENTA Y CUATRO", "SETENTA Y CINCO", "SETENTA Y SEIS", "SETENTA Y SIETE", "SETENTA Y OCHO", "SETENTA Y NUEVE", "OCHENTA"
    }
}

-- Função para obter número por extenso
function Numbers:GetNumber(language, number)
    if not NumberData[language] then
        language = 'pt-br' -- Fallback para português
    end
    
    if number >= 1 and number <= #NumberData[language] then
        return NumberData[language][number]
    end
    
    return nil
end

-- Função para obter lista de idiomas disponíveis
function Numbers:GetAvailableLanguages()
    local languages = {}
    for language, _ in pairs(NumberData) do
        table.insert(languages, language)
    end
    return languages
end

-- Função para obter quantidade máxima de números
function Numbers:GetMaxNumber(language)
    if not NumberData[language] then
        language = 'pt-br'
    end
    
    return #NumberData[language]
end

-- Função para validar número
function Numbers:IsValidNumber(language, number)
    return number >= 1 and number <= self:GetMaxNumber(language)
end

-- Função para obter todos os números de um idioma
function Numbers:GetAllNumbers(language)
    if not NumberData[language] then
        language = 'pt-br'
    end
    
    return NumberData[language]
end

return Numbers 