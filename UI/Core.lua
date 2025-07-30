-- UI/Core.lua
-- Lógica principal da interface
-- Criado por K9zzzzz

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local ScreenGui, MainFrame, IsRunning, CurrentNumber, Config, Modules, I18N = nil, nil, false, 1, {}, {}, {}

-- Importar componentes
local Components = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/UI/Components.lua'))()
local Draggable = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/UI/Draggable.lua'))()

-- Importar módulos
local function ImportModules()
    local modules = {}
    
    local success1, ext = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/Extenso.lua'))()
    end)
    
    local success2, chat = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Modules/RemoteChat.lua'))()
    end)
    
    local success3, notif = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Notification.lua'))()
    end)
    
    if success1 then modules.Extenso = ext end
    if success2 then modules.RemoteChat = chat end
    if success3 then modules.Notification = notif end
    
    Modules = modules
    return success1 and success2
end

-- Importar I18N
local function ImportI18N(language)
    local success, translations = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/I18N/' .. language .. '.lua'))()
    end)
    
    if success then
        I18N = translations
        return true
    else
        local fallback = pcall(function()
            I18N = loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/I18N/pt-br.lua'))()
        end)
        return fallback
    end
end

-- Enviar mensagem
local function SendMessage(numero)
    if not Modules.Extenso or not Modules.RemoteChat then return false end
    
    local numeroExtenso = Modules.Extenso:GetNumero(numero)
    local message = numeroExtenso .. (Config.FinalPrompt or "!")
    
    return Modules.RemoteChat:SendMessage(message)
end

-- Criar UI
local function CreateUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AutoJJsUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Frame principal
    MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 200, 0, 280)
    MainFrame.Position = UDim2.new(0.5, -100, 0.5, -140)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim2.new(0, 12)
    corner.Parent = MainFrame
    
    -- Título
    Components:CreateText(MainFrame, "K9zzzzz - Auto JJs v1.0.0", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 5), Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold)
    
    -- Começar do
    Components:CreateText(MainFrame, I18N.UI.StartFrom or "Começar do:", UDim2.new(0.4, 0, 0, 20), UDim2.new(0.05, 0, 0, 40))
    local startInput = Components:CreateInput(MainFrame, "1", UDim2.new(0.5, 0, 0, 25), UDim2.new(0.45, 0, 0, 40), function(value)
        Config.StartNumber = tonumber(value) or 1
    end)
    startInput.Text = "1"
    
    -- Até o
    Components:CreateText(MainFrame, I18N.UI.Until or "Até o:", UDim2.new(0.4, 0, 0, 20), UDim2.new(0.05, 0, 0, 75))
    local endInput = Components:CreateInput(MainFrame, "10", UDim2.new(0.5, 0, 0, 25), UDim2.new(0.45, 0, 0, 75), function(value)
        Config.EndNumber = tonumber(value) or 10
    end)
    endInput.Text = "10"
    
    -- Final do Prefix
    Components:CreateText(MainFrame, I18N.UI.FinalPrefix or "Final do Prefix:", UDim2.new(0.4, 0, 0, 20), UDim2.new(0.05, 0, 0, 110))
    local prefixInput = Components:CreateInput(MainFrame, "!", UDim2.new(0.5, 0, 0, 25), UDim2.new(0.45, 0, 0, 110), function(value)
        Config.FinalPrompt = value or "!"
    end)
    prefixInput.Text = "!"
    
    -- Pular toggle
    Components:CreateText(MainFrame, I18N.UI.Skip or "Pular:", UDim2.new(0.4, 0, 0, 20), UDim2.new(0.05, 0, 0, 145))
    Components:CreateToggle(MainFrame, UDim2.new(0.5, 0, 0, 20), UDim2.new(0.45, 0, 0, 145), function(toggled)
        Config.Skip = toggled
    end)
    
    -- Botão play
    local playButton = Components:CreateButton(MainFrame, "▶", UDim2.new(0.9, 0, 0, 50), UDim2.new(0.05, 0, 0, 180))
    
    -- Tornar draggable
    Draggable:MakeDraggable(MainFrame)
    
    -- Função para iniciar/parar
    local function ToggleAutoJJs()
        if IsRunning then
            IsRunning = false
            if Modules.Notification then
                Modules.Notification:ShowI18N(I18N, "Stopped", 2)
            end
            return
        end
        
        IsRunning = true
        CurrentNumber = Config.StartNumber or 1
        local endNumber = Config.EndNumber or 10
        
        if Modules.Notification then
            Modules.Notification:ShowI18NWithVars(I18N, "Started", {start = CurrentNumber, end = endNumber}, 3)
        end
        
        spawn(function()
            while IsRunning and CurrentNumber <= endNumber do
                if SendMessage(CurrentNumber) then
                    CurrentNumber = CurrentNumber + 1
                    
                    if CurrentNumber % 10 == 0 and Modules.Notification then
                        Modules.Notification:ShowI18NWithVars(I18N, "Progress", {current = CurrentNumber - 1}, 1)
                    end
                else
                    if Modules.Notification then
                        Modules.Notification:ShowI18N(I18N, "Error", 3)
                    end
                    break
                end
                
                wait(Config.Tempo or 2.5)
            end
            
            IsRunning = false
            if Modules.Notification then
                Modules.Notification:ShowI18N(I18N, "Completed", 3)
            end
        end)
    end
    
    playButton.MouseButton1Click:Connect(ToggleAutoJJs)
    
    -- Notificação de carregamento
    if Modules.Notification then
        Modules.Notification:ShowI18N(I18N, "Loaded", 3)
    end
end

-- Função principal
local function Main(Options)
    Config = Options or {}
    Config.StartNumber = 1
    Config.EndNumber = 10
    Config.FinalPrompt = "!"
    Config.Tempo = Config.Tempo or 2.5
    Config.Language = Config.Language or "pt-br"
    
    if ImportI18N(Config.Language) and ImportModules() then
        CreateUI()
        print("Auto JJS v1.0.0 carregado!")
        print("Criado por K9zzzzz")
    else
        warn("Erro ao carregar módulos!")
    end
end

return Main 