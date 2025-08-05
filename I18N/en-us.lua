-- I18N/en-us.lua
-- English translations
-- Created by K9zzzzz

local I18N = {
    -- User interface
    UI = {
        StartFrom = "Start from",
        Until = "Until",
        FinalPrefix = "Final Prefix",
        StartButton = "▶ START"
    },
    
    -- Notifications
    Notifications = {
        Loaded = {
            Title = "Auto JJS Loaded!",
            Message = "Created by K9zzzzz"
        },
        Started = {
            Title = "Started",
            Message = "Auto JJS started - {start} to {end}"
        },
        Stopped = {
            Title = "Stopped",
            Message = "Auto JJS stopped"
        },
        Progress = {
            Title = "Progress",
            Message = "Current number: {current}"
        },
        Completed = {
            Title = "Completed",
            Message = "Auto JJS finished!"
        },
        Error = {
            Title = "Error",
            Message = "Failed to send message"
        }
    },
    
    -- Numbers in words
    Numbers = {
        [1] = "ONE",
        [2] = "TWO",
        [3] = "THREE",
        [4] = "FOUR",
        [5] = "FIVE",
        [6] = "SIX",
        [7] = "SEVEN",
        [8] = "EIGHT",
        [9] = "NINE",
        [10] = "TEN",
        [11] = "ELEVEN",
        [12] = "TWELVE",
        [13] = "THIRTEEN",
        [14] = "FOURTEEN",
        [15] = "FIFTEEN",
        [16] = "SIXTEEN",
        [17] = "SEVENTEEN",
        [18] = "EIGHTEEN",
        [19] = "NINETEEN",
        [20] = "TWENTY",
        [30] = "THIRTY",
        [40] = "FORTY",
        [50] = "FIFTY",
        [60] = "SIXTY",
        [70] = "SEVENTY",
        [80] = "EIGHTY",
        [90] = "NINETY",
        [100] = "ONE HUNDRED",
        [200] = "TWO HUNDRED",
        [300] = "THREE HUNDRED",
        [400] = "FOUR HUNDRED",
        [500] = "FIVE HUNDRED",
        [600] = "SIX HUNDRED",
        [700] = "SEVEN HUNDRED",
        [800] = "EIGHT HUNDRED",
        [900] = "NINE HUNDRED",
        [1000] = "THOUSAND",
        [1000000] = "MILLION",
        [1000000000] = "BILLION"
    },
    
    -- Error messages
    Errors = {
        ModuleNotFound = "Module not found",
        ChatNotAvailable = "Chat not available",
        InvalidNumber = "Invalid number",
        MessageTooLong = "Message too long",
        ConnectionFailed = "Connection failed"
    },
    
    -- Success messages
    Success = {
        ModuleLoaded = "Module loaded successfully",
        MessageSent = "Message sent",
        ConnectionEstablished = "Connection established"
    },
    
    -- Configuration
    Config = {
        DefaultStartNumber = 1,
        DefaultEndNumber = 10,
        DefaultPrefix = "!",
        DefaultDelay = 2.5
    }
}

return I18N 