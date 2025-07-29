-- Character.lua
-- Módulo para gerenciar personagem
-- Criado por K9zzzzz

local Players = game:GetService("Players")
local Character = {}

function Character:GetPlayer()
    return Players.LocalPlayer
end

function Character:GetCharacter()
    return Players.LocalPlayer.Character
end

function Character:GetHumanoid()
    local character = self:GetCharacter()
    if character then
        return character:FindFirstChild("Humanoid")
    end
    return nil
end

function Character:GetRootPart()
    local character = self:GetCharacter()
    if character then
        return character:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

return Character 