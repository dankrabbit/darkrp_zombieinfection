AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName= "Zombie Infection Cure"
ENT.Spawnable = false
ENT.AdminSpawnable = false

if CLIENT then function ENT:Draw() self:DrawModel() end end

function ENT:Initialize()
	if CLIENT then return end

	self:SetModel("models/props_junk/PopCan01a.mdl");
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
end