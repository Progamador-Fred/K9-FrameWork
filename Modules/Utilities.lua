local Utilities = {}

-- Envia notificação
function Utilities:Notify(text)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "K9zzzzzz Script",
            Text = text,
            Duration = 3
        })
    end)
end

-- Animação arco-íris no texto
function Utilities:AnimateRainbow(label)
    task.spawn(function()
        while task.wait(0.1) do
            for i = 0, 255, 10 do
                label.TextColor3 = Color3.fromHSV(i/255, 1, 1)
                task.wait(0.05)
            end
        end
    end)
end

-- Aplica sombra
function Utilities:ApplyDropShadow(obj)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "DropShadow"
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.ZIndex = obj.ZIndex - 1
    shadow.BackgroundTransparency = 1
    shadow.Parent = obj
end

-- Hover Effect
function Utilities:ApplyHoverEffect(btn)
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
end

-- Som de clique
function Utilities:PlayClickSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://12222142" -- Clique básico
    sound.Volume = 1
    sound.Parent = workspace
    sound:Play()
    game.Debris:AddItem(sound, 2)
end

return Utilities
