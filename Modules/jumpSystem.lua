-- jumpSystem.lua
-- Sistema para fazer o personagem pular no Roblox
-- Criado por: k9zzzzzz

local JumpSystem = {}

-- Função para fazer o personagem pular (MÉTODO MAIS EFICIENTE)
function JumpSystem.makePlayerJump()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")

    Humanoid.Jump = true
    return true
end

return JumpSystem 