-- I18N/es-es.lua
-- Traducciones en español
-- Creado por K9zzzzz

local I18N = {
    -- Interfaz de usuario
    UI = {
        StartFrom = "Comenzar desde",
        Skip = "Saltar
        Until = "Hasta",
        FinalPrefix = "Prefijo Final",
        StartButton = "▶ SALTAR"
    },
    
    -- Notificaciones
    Notifications = {
        Loaded = {
            Title = "¡Auto JJS Cargado!",
            Message = "Creado por K9zzzzz"
        },
        Started = {
            Title = "Iniciado",
            Message = "Auto JJS iniciado - {start} hasta {end}"
        },
        Stopped = {
            Title = "Detenido",
            Message = "Auto JJS detenido"
        },
        Progress = {
            Title = "Progreso",
            Message = "Número actual: {current}"
        },
        Completed = {
            Title = "Completado",
            Message = "¡Auto JJS finalizado!"
        },
        Error = {
            Title = "Error",
            Message = "Error al enviar mensaje"
        }
    },
    
    -- Números en palabras
    Numbers = {
        [1] = "UNO",
        [2] = "DOS",
        [3] = "TRES",
        [4] = "CUATRO",
        [5] = "CINCO",
        [6] = "SEIS",
        [7] = "SIETE",
        [8] = "OCHO",
        [9] = "NUEVE",
        [10] = "DIEZ",
        [11] = "ONCE",
        [12] = "DOCE",
        [13] = "TRECE",
        [14] = "CATORCE",
        [15] = "QUINCE",
        [16] = "DIECISÉIS",
        [17] = "DIECISIETE",
        [18] = "DIECIOCHO",
        [19] = "DIECINUEVE",
        [20] = "VEINTE",
        [30] = "TREINTA",
        [40] = "CUARENTA",
        [50] = "CINCUENTA",
        [60] = "SESENTA",
        [70] = "SETENTA",
        [80] = "OCHENTA",
        [90] = "NOVENTA",
        [100] = "CIEN",
        [200] = "DOSCIENTOS",
        [300] = "TRESCIENTOS",
        [400] = "CUATROCIENTOS",
        [500] = "QUINIENTOS",
        [600] = "SEISCIENTOS",
        [700] = "SETECIENTOS",
        [800] = "OCHOCIENTOS",
        [900] = "NOVECIENTOS",
        [1000] = "MIL",
        [1000000] = "MILLÓN",
        [1000000000] = "BILLÓN"
    },
    
    -- Mensajes de error
    Errors = {
        ModuleNotFound = "Módulo no encontrado",
        ChatNotAvailable = "Chat no disponible",
        InvalidNumber = "Número inválido",
        MessageTooLong = "Mensaje demasiado largo",
        ConnectionFailed = "Error de conexión"
    },
    
    -- Mensajes de éxito
    Success = {
        ModuleLoaded = "Módulo cargado exitosamente",
        MessageSent = "Mensaje enviado",
        ConnectionEstablished = "Conexión establecida"
    },
    
    -- Configuración
    Config = {
        DefaultStartNumber = 1,
        DefaultEndNumber = 10,
        DefaultPrefix = "!",
        DefaultDelay = 2.5
    }
}

return I18N 