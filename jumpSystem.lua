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
            -- Método 1: Reset JumpPower e depois Jump = true
            local success = pcall(function()
                Humanoid.JumpPower = 50
                task.wait(0.01) -- Pequena pausa para garantir
                Humanoid.Jump = true
            end)
            
            -- Método 2: Fallback com ChangeState
            if not success then
                pcall(function()
                    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end)
            end
            
            -- Método 3: Último recurso - forçar pulo
            if not success then
                pcall(function()
                    Humanoid.JumpPower = 50
                    Humanoid.Jump = true
                    task.wait(0.05)
                    Humanoid.Jump = false
                    Humanoid.Jump = true
                end)
            end
            
            return true
        end
    end
    
    return false
end

return JumpSystem 