--[[ - - - - - - - - - - - - - - - - - - - - 

▓█████▄  ██▀███   ██▓███  ▒███████▒ ██▓
▒██▀ ██▌▓██ ▒ ██▒▓██░  ██▒▒ ▒ ▒ ▄▀░▓██▒
░██   █▌▓██ ░▄█ ▒▓██░ ██▓▒░ ▒ ▄▀▒░ ▒██▒
░▓█▄   ▌▒██▀▀█▄  ▒██▄█▓▒ ▒  ▄▀▒   ░░██░
░▒████▓ ░██▓ ▒██▒▒██▒ ░  ░▒███████▒░██░
 ▒▒▓  ▒ ░ ▒▓ ░▒▓░▒▓▒░ ░  ░░▒▒ ▓░▒░▒░▓  
 ░ ▒  ▒   ░▒ ░ ▒░░▒ ░     ░░▒ ▒ ░ ▒ ▒ ░
 ░ ░  ░   ░░   ░ ░░       ░ ░ ░ ░ ░ ▒ ░
   ░       ░                ░ ░     ░  
 ░                        ░            
- - - - - - - - - By Dank Rabbit - - - - ]]--

drp_zInfection = {}

drp_zInfection.friendlyFire	= false			-- Allow friendly fire between zombies
drp_zInfection.infectedPK	= true			-- Do zombies get kicked off the zombie job on death
drp_zInfection.enforceJob	= false			-- Prevent zombies from escaping their fate
drp_zInfection.defaultTeam	= TEAM_CITIZEN	-- Team to kick zombies to if infectedPK is true
drp_zInfection.PLYinfected	= TEAM_ZOMBIE	-- The zombie job
drp_zInfection.maxHP		= 1200			-- The max health a zombie can achieve from feeding
drp_zInfection.zWeapon		= "weapon_fists"
drp_zInfection.zDamage		= 10			-- Damage multiplier for zombies using their zWeapon
drp_zInfection.spawnTime	= 2				-- Spawn timer after player dies from a zombie

-- Hunger Mod support! If not enabled, kills will reward zombies with health based on hungerFeed
drp_zInfection.hungerLoss	= 100	-- How much hunger zombies lose each hungerUpdate
drp_zInfection.hungerFeed	= 420	-- Hunger (or Health) restored on player kiil as a zombie
drp_zInfection.hungerDMG	= 20	-- How much damage zombies take each hungerUpdate if hunger is 0
drp_zInfection.cureHP		= 20	-- How much HP does the cure entity give players when used

drp_zInfection.NPCinfected = {		-- NPCs that will turn the player into a zombie on death
	"npc_headcrab",
	"npc_headcrab_fast",
	"npc_headcrab_black",
	"npc_zombie",
	"npc_zombie_torso",
	"npc_fastzombie",
	"npc_fastzombie_torso",
	"npc_poisonzombie",
}

hook.Add("loadCustomDarkRPItems", "drpZI_Jobz", function()

	TEAM_ZOMBIE = DarkRP.createJob("Zombie", {
		color = Color(0, 0, 0, 255),
		model = {"models/player/zombie_fast.mdl"},
		description = [[Eat brains.]],
		weapons = {},
		command = "zombie",
		max = 0,
		salary = 0,
		admin = 0,
		vote = false,
		hasLicense = false,
		candemote = false,
		category = "Other",
		PlayerLoadout = function(ply) return true end, -- Restrict default loadout
		PlayerSpawn = function(ply) ply:StripWeapons() ply:Give(drp_zInfection.zWeapon)
									ply:SetHealth(420) ply:SetMaxHealth(420)
								--	ply:SetJumpPower( ply:GetJumpPower()*1.5)
								--	ply:SetRunSpeed( ply:GetRunSpeed()*1.5 )
								--	ply:SetWalkSpeed( ply:GetWalkSpeed()*1.5 )
									ply:SetNoTarget(true) ply:AllowFlashlight(false) end,
		customCheck = function(ply) return false end	-- Prevent
	})

end)