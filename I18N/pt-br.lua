-- I18N/pt-br.lua
-- Traduções em português brasileiro
-- Criado por K9zzzzz

local I18N = {
    -- Interface do usuário
    UI = {
        StartFrom = "Começar do",
        Until = "Até o",
        FinalPrefix = "Final do Prefix",
        Skip = "Pular",
        StartButton = "▶ PULAR"
    },
    
    -- Notificações
    Notifications = {
        Loaded = {
            Title = "Auto JJS Carregado!",
            Message = "Criado por K9zzzzz"
        },
        Started = {
            Title = "Iniciado",
            Message = "Auto JJS iniciado - {start} até {end}"
        },
        Stopped = {
            Title = "Parado",
            Message = "Auto JJS parado"
        },
        Progress = {
            Title = "Progresso",
            Message = "Número atual: {current}"
        },
        Completed = {
            Title = "Concluído",
            Message = "Auto JJS finalizado!"
        },
        Error = {
            Title = "Erro",
            Message = "Falha ao enviar mensagem"
        }
    },
    
    -- Números em extenso
    Numbers = {
        [1] = "UM",
        [2] = "DOIS",
        [3] = "TRÊS",
        [4] = "QUATRO",
        [5] = "CINCO",
        [6] = "SEIS",
        [7] = "SETE",
        [8] = "OITO",
        [9] = "NOVE",
        [10] = "DEZ",
        [11] = "ONZE",
        [12] = "DOZE",
        [13] = "TREZE",
        [14] = "QUATORZE",
        [15] = "QUINZE",
        [16] = "DEZESSEIS",
        [17] = "DEZESSETE",
        [18] = "DEZOITO",
        [19] = "DEZENOVE",
        [20] = "VINTE",
        [30] = "TRINTA",
        [40] = "QUARENTA",
        [50] = "CINQUENTA",
        [60] = "SESSENTA",
        [70] = "SETENTA",
        [80] = "OITENTA",
        [90] = "NOVENTA",
        [100] = "CEM",
        [200] = "DUZENTOS",
        [300] = "TREZENTOS",
        [400] = "QUATROCENTOS",
        [500] = "QUINHENTOS",
        [600] = "SEISCENTOS",
        [700] = "SETECENTOS",
        [800] = "OITOCENTOS",
        [900] = "NOVECENTOS",
        [1000] = "MIL",
        [1000000] = "MILHÃO",
        [1000000000] = "BILHÃO"
    },
    
    -- Mensagens de erro
    Errors = {
        ModuleNotFound = "Módulo não encontrado",
        ChatNotAvailable = "Chat não disponível",
        InvalidNumber = "Número inválido",
        MessageTooLong = "Mensagem muito longa",
        ConnectionFailed = "Falha na conexão"
    },
    
    -- Mensagens de sucesso
    Success = {
        ModuleLoaded = "Módulo carregado com sucesso",
        MessageSent = "Mensagem enviada",
        ConnectionEstablished = "Conexão estabelecida"
    },
    
    -- Configurações
    Config = {
        DefaultStartNumber = 1,
        DefaultEndNumber = 10,
        DefaultPrefix = "!",
        DefaultDelay = 2.5
    }
}

return I18N 