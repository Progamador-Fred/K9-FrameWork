local UIManager = {}

-- Referência para módulos externos
local AutoJJs, AutoVolver, Utilities, NumberToWords

function UIManager:Init(modules)
    AutoJJs = modules.AutoJJs
    AutoVolver = modules.AutoVolver
    Utilities = modules.Utilities
    NumberToWords = modules.NumberToWords

    -- Criando ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "K9zzzzzzUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game.CoreGui

    -- Frame principal com estilo premium
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 520, 0, 420)
    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -210)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.Parent = ScreenGui
    Utilities:ApplyDropShadow(MainFrame)

    -- Título animado
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🔥 K9zzzzzz Script 🔥"
    Title.Font = Enum.Font.GothamBold
    Title.TextScaled = true
    Title.TextColor3 = Color3.fromRGB(255, 170, 0)
    Title.Parent = MainFrame
    Utilities:AnimateRainbow(Title) -- Animação arco-íris no texto

    -- Botão Template
    local function CreateButton(text, order, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(0.8, 0, 0, 50)
        Btn.Position = UDim2.new(0.1, 0, 0, 70 + (order * 60))
        Btn.Text = text
        Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.Font = Enum.Font.GothamBold
        Btn.TextSize = 20
        Btn.Parent = MainFrame
        Utilities:ApplyHoverEffect(Btn)
        Btn.MouseButton1Click:Connect(function()
            Utilities:PlayClickSound()
            callback()
        end)
        return Btn
    end

    -- Botões da Home
    CreateButton("Auto JJs", 0, function()
        Utilities:Notify("Abrindo Auto JJs...")
        AutoJJs:OpenUI(ScreenGui, MainFrame)
    end)
    CreateButton("Auto Volver", 1, function()
        Utilities:Notify("Abrindo Auto Volver...")
        AutoVolver:OpenUI(ScreenGui, MainFrame)
    end)
    CreateButton("Extras", 2, function()
        Utilities:Notify("Abrindo Extras...")
    end)
    CreateButton("Configurações", 3, function()
        Utilities:Notify("Abrindo Configurações...")
    end)

    -- Rodapé
    local Footer = Instance.new("TextLabel")
    Footer.Size = UDim2.new(1, 0, 0, 30)
    Footer.Position = UDim2.new(0, 0, 1, -30)
    Footer.BackgroundTransparency = 1
    Footer.Text = "Feito por K9zzzzzz | discord.gg/seuLink"
    Footer.Font = Enum.Font.Gotham
    Footer.TextSize = 16
    Footer.TextColor3 = Color3.fromRGB(180, 180, 180)
    Footer.Parent = MainFrame
end

return UIManager
