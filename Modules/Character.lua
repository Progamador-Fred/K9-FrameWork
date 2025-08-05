-- Character.lua
-- Módulo para gerenciar personagem e informações do jogador
-- Criado por K9zzzzz

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Character = {}

-- Obter o jogador local
function Character:GetPlayer()
    return Players.LocalPlayer
end

-- Obter o personagem do jogador
function Character:GetCharacter()
    local player = self:GetPlayer()
    if player then
        return player.Character
    end
    return nil
end

-- Obter o humanoid do personagem
function Character:GetHumanoid()
    local character = self:GetCharacter()
    if character then
        return character:FindFirstChild("Humanoid")
    end
    return nil
end

-- Obter o HumanoidRootPart do personagem
function Character:GetRootPart()
    local character = self:GetCharacter()
    if character then
        return character:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

-- Verificar se o personagem está carregado
function Character:IsCharacterLoaded()
    local character = self:GetCharacter()
    local humanoid = self:GetHumanoid()
    local rootPart = self:GetRootPart()
    
    return character ~= nil and humanoid ~= nil and rootPart ~= nil
end

-- Aguardar o personagem carregar
function Character:WaitForCharacter()
    local player = self:GetPlayer()
    if not player then return false end
    
    if not player.Character then
        player.CharacterAdded:Wait()
    end
    
    local character = player.Character
    if not character:FindFirstChild("Humanoid") then
        character:WaitForChild("Humanoid")
    end
    
    if not character:FindFirstChild("HumanoidRootPart") then
        character:WaitForChild("HumanoidRootPart")
    end
    
    return true
end

-- Obter a posição atual do personagem
function Character:GetPosition()
    local rootPart = self:GetRootPart()
    if rootPart then
        return rootPart.Position
    end
    return Vector3.new(0, 0, 0)
end

-- Obter a velocidade atual do personagem
function Character:GetVelocity()
    local rootPart = self:GetRootPart()
    if rootPart then
        return rootPart.Velocity
    end
    return Vector3.new(0, 0, 0)
end

-- Verificar se o personagem está no chão
function Character:IsOnGround()
    local humanoid = self:GetHumanoid()
    if humanoid then
        return humanoid.FloorMaterial ~= Enum.Material.Air
    end
    return false
end

-- Obter informações completas do personagem
function Character:GetCharacterInfo()
    local player = self:GetPlayer()
    local character = self:GetCharacter()
    local humanoid = self:GetHumanoid()
    local rootPart = self:GetRootPart()
    
    return {
        Player = player,
        Character = character,
        Humanoid = humanoid,
        RootPart = rootPart,
        Position = rootPart and rootPart.Position or Vector3.new(0, 0, 0),
        Velocity = rootPart and rootPart.Velocity or Vector3.new(0, 0, 0),
        Health = humanoid and humanoid.Health or 0,
        MaxHealth = humanoid and humanoid.MaxHealth or 0,
        WalkSpeed = humanoid and humanoid.WalkSpeed or 16,
        JumpPower = humanoid and humanoid.JumpPower or 50,
        IsLoaded = self:IsCharacterLoaded(),
        IsOnGround = self:IsOnGround()
    }
end

-- Monitorar mudanças no personagem
function Character:MonitorCharacter(callback)
    local player = self:GetPlayer()
    if not player then return end
    
    -- Conectar ao evento CharacterAdded
    player.CharacterAdded:Connect(function(character)
        if callback then
            callback("CharacterAdded", character)
        end
    end)
    
    -- Conectar ao evento CharacterRemoving
    player.CharacterRemoving:Connect(function(character)
        if callback then
            callback("CharacterRemoving", character)
        end
    end)
end

-- Função para testar o módulo
function Character:Test()
    print("=== Teste do Módulo Character ===")
    print("Player:", self:GetPlayer() and self:GetPlayer().Name or "N/A")
    print("Character:", self:GetCharacter() and "Carregado" or "Não carregado")
    print("Humanoid:", self:GetHumanoid() and "Encontrado" or "Não encontrado")
    print("RootPart:", self:GetRootPart() and "Encontrado" or "Não encontrado")
    print("IsLoaded:", self:IsCharacterLoaded())
    print("IsOnGround:", self:IsOnGround())
    
    local info = self:GetCharacterInfo()
    print("Health:", info.Health .. "/" .. info.MaxHealth)
    print("WalkSpeed:", info.WalkSpeed)
    print("JumpPower:", info.JumpPower)
    print("================================")
end

return Character 