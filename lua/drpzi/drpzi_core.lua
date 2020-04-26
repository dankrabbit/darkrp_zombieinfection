hook.Add("PlayerDeath", "drpZI_InfectPlyOnDeath", function(victim, inflictor, attacker)
	if ( victim == attacker ) or !IsValid(victim) or !IsValid(attacker) then return end
	if attacker:IsNPC() and table.HasValue(drp_zInfection.NPCinfected, attacker:GetClass()) then
		local zombiespawn = attacker:GetPos()
		timer.Simple(drp_zInfection.spawnTime, function()
			victim:changeTeam(drp_zInfection.PLYinfected, true)
			victim:Spawn()
			victim:SetPos(zombiespawn)
		end)
	end

	if attacker:IsPlayer() and team.GetName(attacker:Team()) == team.GetName(drp_zInfection.PLYinfected) then
		local zombiespawn = attacker:GetPos()

		if IsValid(attacker:getDarkRPVar("Energy")) then
			local newEnergy = attacker:getDarkRPVar("Energy") + drp_zInfection.hungerFeed
			attacker:setSelfDarkRPVar("Energy", newEnergy)
		else
			attacker:SetHealth( math.min(attacker:Health() + drp_zInfection.hungerFeed, drp_zInfection.maxHP) )
		end

		timer.Simple(drp_zInfection.spawnTime, function()
			victim:changeTeam(drp_zInfection.PLYinfected, true)
			victim:Spawn()
			victim:SetPos(zombiespawn)
		end)
	end

	if victim:IsPlayer() then
		if team.GetName(victim:Team()) == team.GetName(drp_zInfection.PLYinfected) then
			if drp_zInfection.infectedPK != true then return end
			victim:changeTeam(drp_zInfection.defaultTeam, true)
			if victim.izInfected then victim.izInfected = nil end

		elseif victim.izInfected then
			victim.izInfected = nil
			timer.Simple(drp_zInfection.spawnTime, function()
				victim:changeTeam(drp_zInfection.PLYinfected, true)
				victim:Spawn()
				victim:SetPos(zombiespawn)
			end)
		end
	end
end)

hook.Add("hungerUpdate", "drpZI_Hunger", function(ply, energy)
	if team.GetName(ply:Team()) != team.GetName(drp_zInfection.PLYinfected) then return end
	if ply:getDarkRPVar("Energy") == 0 then
		ply:TakeDamage(drp_zInfection.hungerDMG, ply, ply)
	end

	local zombHunger = ply:getDarkRPVar("Energy") - drp_zInfection.hungerLoss
	if zombHunger < 0 then zombHunger = 0 end
	ply:setSelfDarkRPVar("Energy", zombHunger)
end)

hook.Add("EntityTakeDamage", "drpZI_dmgScale", function(target, dmginfo)
	if !target:IsPlayer() then return end

	local zomb = dmginfo:GetAttacker()
	if IsValid(zomb) and zomb:IsPlayer() then
		if team.GetName(zomb:Team()) == team.GetName(drp_zInfection.PLYinfected) then
			if zomb:GetActiveWeapon() != drp_zInfection.zWeapon then return end
			dmginfo:ScaleDamage(drp_zInfection.zDamage)
			if !target.izInfected then target.izInfected = true end
		end

	elseif zomb:IsNPC() and table.HasValue(drp_zInfection.NPCinfected, attacker:GetClass()) then
		if !target.izInfected then target.izInfected = true end
	end
end)

hook.Add("PlayerUse", "drpZI_useEnt", function(ply, ent)
	if ent:GetClass() != "drpzi_cure" then return end
	ent:Remove()

	if ply.izInfected then ply.izInfected = nil end
	ply:SetHealth( math.min(ply:Health() + drp_zInfection.cureHP, ply:GetMaxHealth()) )

	if team.GetName(ply:Team()) != team.GetName(drp_zInfection.PLYinfected) then
		local pos = ply:GetPos()
		ply:changeTeam(drp_zInfection.defaultTeam, true)
		ply:Spawn()
		ply:SetPos(pos)
	end
end)

print("DarkRP Zombie Infection has loaded!")