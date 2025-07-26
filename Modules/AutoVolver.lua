local AutoVolver = {}

local active = false
local queue = {}
local history = {}
local commandsFrame

function AutoVolver:Enable()
    active = true
    game.Players.LocalPlayer.Chatted:Connect(function(msg)
        if not active then return end
        local normalized = string.upper(msg):gsub("%s+", "")
        if normalized:find("VOLVER") then
            local angle
            if normalized:find("DIREITA") then
                angle = 90
                table.insert(queue, {cmd = "DIREITA VOLVER", ang = 90})
            elseif normalized:find("ESQUERDA") then
                angle = -90
                table.insert(queue, {cmd = "ESQUERDA VOLVER", ang = -90})
            elseif normalized:find("RETAGUARDA") then
                queue = {{cmd = "RETA GUARDA VOLVER", ang = 0}}
            elseif normalized:find("VANGUARDA") then
                queue = {{cmd = "VAN GUARDA VOLVER", ang = 180}}
            end
            AutoVolver:UpdateQueueUI()
        end
    end)
end

function AutoVolver:Execute()
    local angle = 0
    for _, v in ipairs(queue) do
        angle += v.ang
    end
    if #queue > 0 then
        table.insert(history, "Executado: " .. angle .. "°")
    end
    queue = {}
    AutoVolver:UpdateQueueUI()

    -- Gira personagem
    local plr = game.Players.LocalPlayer
    local char = plr.Character or plr.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local currentCFrame = hrp.CFrame
        local newCFrame = CFrame.new(currentCFrame.Position) * CFrame.Angles(0, math.rad(angle), 0)
        local tween = game:GetService("TweenService"):Create(hrp, TweenInfo.new(1, Enum.EasingStyle.Sine), {CFrame = newCFrame})
        tween:Play()
    end
end

function AutoVolver:UpdateQueueUI()
    if not commandsFrame then return end
    for _, child in ipairs(commandsFrame:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end
    local y = 0
    for _, cmd in ipairs(queue) do
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0, 20)
        Label.Position = UDim2.new(0, 0, 0, y)
        Label.BackgroundTransparency = 1
        Label.Text = cmd.cmd .. " (" .. cmd.ang .. "°)"
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 14
        Label.Parent = commandsFrame
        y = y + 20
    end
end

-- UI Premium
function AutoVolver:OpenUI(ScreenGui, MainFrame)
    active = true
    MainFrame:ClearAllChildren()

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Text = "Auto Volver"
    Title.Font = Enum.Font.GothamBold
    Title.TextScaled = true
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.Parent = MainFrame

    -- Frame para mostrar comandos detectados
    commandsFrame = Instance.new("Frame")
    commandsFrame.Size = UDim2.new(0.9, 0, 0.5, 0)
    commandsFrame.Position = UDim2.new(0.05, 0, 0, 70)
    commandsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    commandsFrame.Parent = MainFrame

    -- Botões
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
        Btn.MouseButton1Click:Connect(callback)
    end

    CreateButton("Executar", 0.05, function() AutoVolver:Execute() end)
    CreateButton("Limpar", 0.35, function() queue = {}; AutoVolver:UpdateQueueUI() end)
    CreateButton("Voltar", 0.65, function()
        active = false
        MainFrame:ClearAllChildren()
    end)
end

return AutoVolver
