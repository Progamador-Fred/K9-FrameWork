local AutoJJs = {}

-- Variáveis internas
local running = false
local paused = false
local current = 0
local total = 0
local delay = 1
local finalPrompt = "!"
local progressBar

function AutoJJs:Start(quantity, prompt, d, numberToWords)
    running = true
    paused = false
    current = 1
    total = quantity
    finalPrompt = prompt or "!"
    delay = tonumber(d) or 1

    while running and current <= total do
        if paused then
            repeat task.wait() until not paused
        end

        -- Monta a mensagem
        local msg = numberToWords(current) .. finalPrompt

        -- Envia no chat
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")

        -- Atualiza barra de progresso
        if progressBar then
            local pct = current / total
            progressBar.Size = UDim2.new(pct, 0, 1, 0)
        end

        current += 1
        task.wait(delay)
    end

    if running then
        game.StarterGui:SetCore("SendNotification", {
            Title = "K9zzzzzz Script",
            Text = "✅ Auto JJs concluído!",
            Duration = 3
        })
    end
    running = false
end

function AutoJJs:Pause() paused = true end
function AutoJJs:Resume() paused = false end
function AutoJJs:Stop() running = false end

-- UI do Auto JJs
function AutoJJs:OpenUI(ScreenGui, MainFrame)
    MainFrame:ClearAllChildren()

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Text = "Auto JJs"
    Title.Font = Enum.Font.GothamBold
    Title.TextScaled = true
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.Parent = MainFrame

    -- Inputs: Quantidade, Prompt, Delay
    local function CreateInput(labelText, order, default)
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(0.4, 0, 0, 40)
        Label.Position = UDim2.new(0.05, 0, 0, 70 + order * 50)
        Label.Text = labelText
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.BackgroundTransparency = 1
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 16
        Label.Parent = MainFrame

        local Box = Instance.new("TextBox")
        Box.Size = UDim2.new(0.4, 0, 0, 40)
        Box.Position = UDim2.new(0.5, 0, 0, 70 + order * 50)
        Box.Text = default
        Box.ClearTextOnFocus = false
        Box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Box.TextColor3 = Color3.fromRGB(255, 255, 255)
        Box.Font = Enum.Font.Gotham
        Box.TextSize = 16
        Box.Parent = MainFrame
        return Box
    end

    local QuantityBox = CreateInput("Quantidade", 0, "100")
    local PromptBox = CreateInput("Final do Prompt", 1, "!")
    local DelayBox = CreateInput("Delay (seg)", 2, "0.5")

    -- Barra de progresso
    local ProgressFrame = Instance.new("Frame")
    ProgressFrame.Size = UDim2.new(0.9, 0, 0, 20)
    ProgressFrame.Position = UDim2.new(0.05, 0, 0, 230)
    ProgressFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ProgressFrame.Parent = MainFrame

    progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    progressBar.Parent = ProgressFrame

    -- Botões: Start, Pause, Resume, Stop, Voltar
    local function CreateButton(text, xPos, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(0.25, 0, 0, 40)
        Btn.Position = UDim2.new(xPos, 0, 1, -50)
        Btn.Text = text
        Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.Font = Enum.Font.GothamBold
        Btn.TextSize = 16
        Btn.Parent = MainFrame
        Btn.MouseButton1Click:Connect(function()
            callback()
        end)
    end

    CreateButton("Iniciar", 0.05, function()
        AutoJJs:Start(tonumber(QuantityBox.Text), PromptBox.Text, DelayBox.Text, NumberToWords)
    end)
    CreateButton("Pausar", 0.35, function() AutoJJs:Pause() end)
    CreateButton("Retomar", 0.65, function() AutoJJs:Resume() end)
    CreateButton("Parar", 0.95, function() AutoJJs:Stop() end)
end

return AutoJJs
