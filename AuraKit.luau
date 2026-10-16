--!strict
-- AuraKit (client): veste um personagem com uma aura do AuraPack e cria "fantasmas" de exibição com aura.
-- Requer ReplicatedStorage.AuraPack (importe AuraPack.rbxm). Use num LocalScript; os efeitos são só visuais.
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AuraKit = {}

local MOVE = { ParticleEmitter = true, Beam = true, Trail = true, PointLight = true, SpotLight = true, Fire = true, Sparkles = true, Smoke = true }

local function pack(): Instance
	return ReplicatedStorage:WaitForChild("AuraPack")
end

local function tint(seq: ColorSequence, color: Color3, amount: number): ColorSequence
	local kps = {}
	for _, k in seq.Keypoints do
		table.insert(kps, ColorSequenceKeypoint.new(k.Time, k.Value:Lerp(color, amount)))
	end
	return ColorSequence.new(kps)
end

-- nomes de todas as auras disponíveis
function AuraKit.list(): { string }
	local names = {}
	for _, m in pack():GetChildren() do table.insert(names, m.Name) end
	table.sort(names)
	return names
end

-- coloca a aura no personagem R15; devolve uma função que remove a aura.
-- color (opcional) puxa as cores da aura para essa cor.
function AuraKit.wear(character: Model, auraName: string, color: Color3?): () -> ()
	local source = pack():FindFirstChild(auraName)
	assert(source, "Aura não encontrada: " .. auraName)
	local copy = source:Clone()
	local referenced, items = {}, {}
	for _, item in copy:GetDescendants() do
		if item:IsA("Beam") or item:IsA("Trail") then
			if item.Attachment0 then referenced[item.Attachment0] = true end
			if item.Attachment1 then referenced[item.Attachment1] = true end
		end
		if color and (item:IsA("ParticleEmitter") or item:IsA("Beam") or item:IsA("Trail")) then
			item.Color = tint(item.Color, color, 0.75)
		end
	end
	for _, part in copy:GetChildren() do
		local target = part:IsA("BasePart") and character:FindFirstChild(part.Name)
		if target and target:IsA("BasePart") then
			for _, child in part:GetChildren() do
				if MOVE[child.ClassName] or (child:IsA("Attachment") and (referenced[child] or #child:GetChildren() > 0)) then
					child.Parent = target
					table.insert(items, child)
				end
			end
		end
	end
	copy:Destroy()
	return function()
		for _, item in items do item:Destroy() end
		table.clear(items)
	end
end

-- cria um boneco brilhante com a aura (para vitrine/pedestal). height = altura em studs.
function AuraKit.ghost(auraName: string, at: CFrame, height: number?, color: Color3?, parent: Instance?): Model
	local source = pack():FindFirstChild(auraName)
	assert(source, "Aura não encontrada: " .. auraName)
	local model = source:Clone() :: Model
	for _, d in model:GetDescendants() do
		if d:IsA("LuaSourceContainer") then
			d:Destroy()
		elseif d:IsA("BasePart") then
			d.Anchored, d.CanCollide, d.CanQuery, d.CanTouch, d.CastShadow = true, false, false, false, false
			if d.Name == "HumanoidRootPart" then
				d.Transparency = 1
			else
				d.Material, d.Transparency = Enum.Material.Neon, 0.35
				if color then d.Color = color end
				if d:IsA("MeshPart") then d.TextureID = "" end
			end
		elseif d:IsA("Decal") then
			d:Destroy()
		elseif color and (d:IsA("ParticleEmitter") or d:IsA("Beam") or d:IsA("Trail")) then
			d.Color = tint(d.Color, color, 0.75)
		end
	end
	local _, size = model:GetBoundingBox()
	if size.Y > 0.1 then model:ScaleTo(model:GetScale() * (height or 5.2) / size.Y) end
	-- apoia os pés em `at`
	local pivot = model:GetPivot()
	local box, boxSize = model:GetBoundingBox()
	local lift = pivot.Position.Y - (box.Position.Y - boxSize.Y / 2)
	model:PivotTo(at * CFrame.new(0, lift, 0))
	model.Parent = parent or workspace
	return model
end

return AuraKit
