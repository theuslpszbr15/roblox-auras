-- Exemplo (LocalScript em StarterPlayerScripts): veste o seu personagem com uma aura
-- e coloca um boneco de vitrine com outra aura na frente do spawn.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AuraKit = require(ReplicatedStorage:WaitForChild("AuraKit"))

local player = Players.LocalPlayer

local function onCharacter(character: Model)
	character:WaitForChild("UpperTorso")
	AuraKit.wear(character, "Aura_FlameCrown")
end
if player.Character then task.spawn(onCharacter, player.Character) end
player.CharacterAdded:Connect(onCharacter)

-- vitrine: Trovão azul com a aura Atomic puxada para azul claro
AuraKit.ghost("Aura_Atomic", CFrame.new(0, 0.5, -12), 5.2, Color3.fromRGB(110, 210, 255))
