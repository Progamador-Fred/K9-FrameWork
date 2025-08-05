-- jumpSystem.lua
-- Sistema para fazer o personagem pular no Roblox
-- Criado por: k9zzzzzz

local JumpSystem = {}

-- Função para fazer o personagem pular
function JumpSystem.makePlayerJump()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    if LocalPlayer then
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")
        
        if Humanoid then
            -- Método principal: Humanoid.Jump = true
            local success = pcall(function()
                Humanoid.Jump = true
            end)
            
            return success
        end
    end
    
    return false
end

return JumpSystem 