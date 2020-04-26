hook.Add("PlayerCanPickupWeapon", "drpZI_zWepPickup", function(ply, wep)
	if ply:Team() != drp_zInfection.PLYinfected then return end
	if wep:GetClass() != drp_zInfection.zWeapon then return false end
end)

hook.Add("CanPlayerSuicide", "drpZI_Suicide", function(ply)
	if ply:Team() == drp_zInfection.PLYinfected then return false end
end)

hook.Add("playerCanChangeTeam", "drpZI_teamSwitch", function(ply, team, force)
	if drp_zInfection.enforceJob == true and ply:Team() == drp_zInfection.PLYinfected then return false end
end)

hook.Add("PlayerSpawnProp", "drpZI_PlySpawnProp", function(ply, model)
	if ply:Team() == drp_zInfection.PLYinfected then return false end
end)

hook.Add("EntityTakeDamage", "drpZI_FriendlyFire", function(target, dmginfo)
	local attacker = dmginfo:GetAttacker()
	if !attacker:IsPlayer() then return end
	if attacker:Team() != drp_zInfection.PLYinfected then return end
	if drp_zInfection.friendlyFire == true then return end

	if target:IsPlayer() and attacker:Team() == target:Team() then
		dmginfo:SetDamage(0)
	end

	if table.HasValue(drp_zInfection.NPCinfected, target:GetClass()) or target:Team() == drp_zInfection.PLYinfected then
		dmginfo:SetDamage(0)
	end
end)

hook.Add("OnNPCKilled", "drpZI_FriendlyKill", function(npc, attacker, inflictor)
	if !attacker:IsPlayer() then return end
	if attacker:Team() != drp_zInfection.PLYinfected then return end
	if drp_zInfection.friendlyFire == true then return end

	if table.HasValue(drp_zInfection.NPCinfected, npc:GetClass()) then
		attacker:Kill()
		attacker:changeTeam(drp_zInfection.defaultTeam, true)
	end
end)

print("drpZI restrictions have loaded!")