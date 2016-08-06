--------------Give Weapon --------------------
function ulx.giveweap(calling_ply, target_plys, weapon)
	local affected_plys = {} 
	for i=1, #target_plys do
		local v = target_plys[ i ]
		table.insert(affected_plys, v)
	end
	affected_plys[1]:Give(weapon)
	ulx.fancyLogAdmin(calling_ply, "#A gave #T #s", target_plys, weapon)
end
local giveweap = ulx.command( "Utility", "ulx giveweapon", ulx.giveweap, "!give")
giveweap:addParam{type = ULib.cmds.PlayersArg}
giveweap:addParam{ type = ULib.cmds.StringArg, hint="weapon", ULib.cmds.takeRestOfLine}
giveweap:defaultAccess(ULib.ACCESS_ADMIN)
giveweap:help("Gives a named weapon to the target")
------------------- Weaponlist -----------------
local wlist = [[
-------------Pistols-------------
weapon_zs_peashooter = Peashooter
weapon_zs_battleaxe = Battleaxe 
weapon_zs_deagle = Desert Eagle
weapon_zs_glock3 = Glock
weapon_zs_owens = Owens handgun
weapon_zs_eraser = Eraser Tac
weapon_zs_ricochet = Magnum
weapon_zs_redeemers = Redeemers
weapon_zs_z9000 = Z9000 Pulse Pistol
-------------Shotguns-------------
weapon_zs_blaster = Blaster
weapon_zs_ender = Ender
weapon_zs_sweeper = Sweeper
weapon_zs_annabelle = Annabelle
weapon_zs_boomstick = Boomstick
-------------Assault Rifles and Sub Machine Guns-------------
weapon_zs_crackler = Crackler(AR)
weapon_zs_tosser = Tosser(SMG)
weapon_zs_uzi = Sprayer UZI(SMG)
weapon_zs_silencer = Silencer(SMG)
weapon_zs_smg = MP5/ Shredder(SMG)
weapon_zs_bulletstorm = Bulletstorm(SMG)
weapon_zs_reaper = Reaper(SMG)
weapon_zs_akbar = Akbar(AR)
weapon_zs_inferno = Inferno(AR)
weapon_zs_m4 = Stalker(AR)
weapon_zs_sg552 = Eliminator(AR)
weapon_zs_pulserifle = Adonis Pulse Rifle 
-------------Snipers-------------
weapon_zs_stubber = Stubber
weapon_zs_hunter = Hunter
weapon_zs_slugrifle = Tiny Slug
weapon_zs_sg550 = Killer Rifle
-------------Melee Weapons-------------
weapon_zs_axe = Axe
weapon_zs_stunbaton = Stun Baton
weapon_zs_crowbar = Crowbar
weapon_zs_sledgehammer = Sledgehammer
weapon_zs_swissarmyknife = Knife
weapon_zs_shovel = Shovel
weapon_zs_pot = Cooking Pot
weapon_zs_fryingpan = Frying Pan
weapon_zs_fists = Fists
weapon_zs_pipe = Pipe
weapon_zs_plank = Plank
weapon_zs_hook = MeatHook
-------------Crafted Item-------------
weapon_zs_waraxe = WarAxe
weapon_zs_bust = Bust On A Stick
weapon_zs_megamasher = MegaMasher
weapon_zs_sawhack = SawHack
-------------Random-------------
weapon_zs_arsenalcrate = Arsenal Crate
weapon_zs_resupplybox = Resupply Box
weapon_zs_grenade = Grenade
weapon_zs_hammer = Hammer
weapon_zs_m249 = Punisher Machine Gun
weapon_zs_wrench = Wrench
weapon_zs_medicgun = Savior Medic Gun
weapon_zs_medicalkit = Medic Kit
weapon_zs_gunturret = Turret
weapon_zs_crossbow = Impaler Crossbow
weapon_zs_barricadekit = Aegis Kit
weapon_zs_manhack = Manhack
weapon_zs_detpack = Detonation Pack
weapon_zs_detpackremote = Remote control for detonation pack
]]

function ulx.weaponlist(calling_ply)
	timer.Simple(0.5, function() calling_ply:ChatPrint("Weapon list printed to console") end)
	local weapon = ULib.explode("\n", wlist)
	for k, v in ipairs(weapon) do 
		calling_ply:PrintMessage(HUD_PRINTCONSOLE, v .. "\n")
	end
end
local weaponlist = ulx.command("Utility", "ulx weaponlist", ulx.weaponlist, "!weaponlist")
weaponlist:defaultAccess(ULib.ACCESS_ALL)
weaponlist:help("Prints the entity name of all the weapons for zombie survival")
------------------------- Lottery stuff -----------------------
local lottery_plys = {}
local names = {}
local pot = 0
local cant_join_lot_anymore = false
----------------- Join lottery ---------------
function ulx.joinlot(calling_ply)
	if calling_ply.can_join == nil then
		calling_ply.can_join = true
	end
	if calling_ply.can_join == true then
		if calling_ply:PS_GetPoints() > 999 then
			if calling_ply.can_join == true then
				local ply_id = calling_ply:SteamID()
				local nick = calling_ply:Nick()
				table.insert(lottery_plys, ply_id)
				table.insert(names, nick)
				calling_ply:PS_TakePoints(1000)
				ulx.fancyLogAdmin(calling_ply, "#A joined the lottery!")
				pot = pot + 1000
				pot = pot + 50 --Interest from server
				pot = tonumber(pot)
				calling_ply.can_join = false
				timer.Simple(1, function() ULib.tsayColor(nil, false, Color(255,0,255), "The current amount of tokens in the pot is " .. pot) end)
			else
				calling_ply:ChatPrint("You can no longer join the lottery")
			end
		else
			calling_ply:ChatPrint("The lottery is not open at the moment")
		end
		if calling_ply:PS_GetPoints() < 1000 then
			calling_ply:ChatPrint("You dont have enough points")
		end
		if cant_join_lot_anymore == true then
			PrintMessage(HUD_PRINTTALK, "The lottery is now closed for this game!")
		end
	end
end
local joinlottery = ulx.command("Lottery", "ulx joinlot", ulx.joinlot, "!play")
joinlottery:defaultAccess(ULib.ACCESS_ALL)
joinlottery:help("Allows you to join the lottery. [Costs 1000 tokens]")
----------------------- Who's in lottery -------------------
function ulx.wholot(calling_ply)
	if #names == 0 then
		calling_ply:ChatPrint("No players in the lottery at the moment")
	else
		ulx.fancyLogAdmin(calling_ply, "#A checked the players in the lottery")
		for k, v in pairs(names) do
			calling_ply:PrintMessage(HUD_PRINTCONSOLE, "Player: " .. v)
		end
	end
end
local wholot = ulx.command("Lottery", "ulx wholot", ulx.wholot, "!wholot")
wholot:defaultAccess(ULib.ACCESS_ALL)
wholot:help("Prints all lottery players to the calling player")
------------------------------Decide winner ---------------
function ulx.lotterywinner(calling_ply)
	if #lottery_plys != 0 then
		local table_empty = false
		local string_table = table.Random(lottery_plys)
		local the_winner = player.GetBySteamID(string_table)
		the_winner:PS_GivePoints(pot)
		local winner_2 = the_winner:Nick()
		ULib.tsayColor(nil, false, Color(255,0,255), "The winner of the lottery is " .. winner_2)
		table_empty = true
		pot = 0
		player.GetAll().can_join = false
		if table_empty == true then
			table.Empty(names)
			table.Empty(lottery_plys)
			cant_join_lot_anymore = true
			table_empty = false
		end
	else
		calling_ply:ChatPrint("There is no one in the lottery at the moment")
	end
end
local lotwin = ulx.command("Lottery", "ulx lottery", ulx.lotterywinner, "!lottery")
lotwin:defaultAccess(ULib.ACCESS_ADMIN)
lotwin:help("Decides a winner of the lottery")
----------------------------Warn------------------------
function ulx.warntest(calling_ply, target_ply, reason)
	local id = target_ply:SteamID()
	if reason and reason ~= "" then
		util.SetPData(id, "warns", reason)
		local pdata = target_ply:GetPData("warns", "{}")
		local json = util.JSONToTable(pdata)
		table.insert(json, reason)
		local json2 = util.TableToJSON(json)
		target_ply:SetPData("warns", json2)
		ulx.fancyLogAdmin(calling_ply, "#A warned #T for #s", target_ply, reason)
	else
		util.SetPData(id, "warns", "Warned without reason")
		local pdata = target_ply:GetPData("warns", "{}")
		local json = util.JSONToTable(pdata)
		table.insert(json, "Warned Without Reason")
		local json2 = util.TableToJSON(json)
		target_ply:SetPData("warns", json2)
		ulx.fancyLogAdmin(calling_ply, "#A warned #T", target_ply)
	end
end
local warn = ulx.command("Utility", "ulx warn", ulx.warntest, "!warn")
warn:addParam{type = ULib.cmds.PlayerArg}
warn:addParam{type = ULib.cmds.StringArg, hint="reason", ULib.cmds.optional, ULib.cmds.takeRestOfLine, completes=ulx.common_kick_reasons}
warn:defaultAccess(ULib.ACCESS_OPERATOR)
---------------------------- Warn info -----------------
function ulx.readwarn(calling_ply, target_ply)
	local pdata = target_ply:GetPData("warns", "{}")
	if #pdata == 0 then
		calling_ply:ChatPrint("That player has no warnings")
	elseif #pdata >= 1 then
		local json = util.JSONToTable(pdata)
		calling_ply:ChatPrint("Warns printed to console")
		for k, v in pairs(json) do
			ULib.console(calling_ply, "Reason: " .. v)
		end
	else
		calling_ply:ChatPrint("An error has occured. Blame Papyrus")
	end
end
local warninfo = ulx.command("Utility", "ulx warninfo", ulx.readwarn, "!warninfo")
warninfo:addParam{type = ULib.cmds.PlayerArg}
warn:defaultAccess(ULib.ACCESS_OPERATOR)
--------------------------- Clear Warns ----------------------
function ulx.clearwarn(calling_ply, target_ply)
	local id = target_ply:SteamID()
	local pdata = target_ply:GetPData("warns", "{}")
	ulx.fancyLogAdmin(calling_ply, "#A cleared the warnings of #T", target_ply)
	target_ply:RemovePData("warns")
	util.RemovePData(id, "warns")
end
local clearwarn = ulx.command("Utility", "ulx clearwarn", ulx.clearwarn, "!clearwarns")
clearwarn:addParam{type = ULib.cmds.PlayerArg}
clearwarn:defaultAccess(ULib.ACCESS_ADMIN)
------- Check arsenal and resupply -----------
function ulx.checkall(calling_ply)
	local plyars = {}
	local plyres = {}
	local arsowner = {}
	local resupowner = {}
	local all_plys = player.GetAll() -- Gets all the players in the server
	for i=1, #all_plys do -- Loops through the player's table (as all_plys gives us a table, or a list of the players)
		local ply = all_plys[ i ] -- Chooses the value of the table, so if i=1, it will get the first player, and if i=2, it will get the second player, etc.
		local hasars = ply:HasWeapon("weapon_zs_arsenalcrate") --Checks if the player has an arsenal
		local hasresup = ply:HasWeapon("weapon_zs_resupplybox") -- Same for resupply
		if hasars then -- If the player has an arsenal
			timer.Simple(1, function() ULib.tsayColor(nil, false, Color(255,255,255), ply:Nick() .. " has an arsenal crate in their inventory")end)
			table.insert(plyars, ply:Nick())
		end
		if hasresup then -- If the player has a resupply
			timer.Simple(1, function() ULib.tsayColor(nil, false, Color(255,255,255), ply:Nick() .. " has a resupply in their inventory")end)
			table.insert(plyres, ply:Nick())
		end
	end
	local owner = ""
	local rowner = ""
	for k, v in pairs(ents.FindByClass("prop_arsenalcrate")) do
		owner = v:GetObjectOwner()
		if owner != nil then
			table.insert(arsowner, owner)
		end
	end
	for k, v in pairs(ents.FindByClass("prop_resupplybox")) do
		rowner = v:GetObjectOwner()
		if rowner != nil then
			table.insert(resupowner, rowner)
		end
	end
	if #arsowner != 0 or #resupowner != 0 then
		timer.Simple(1, function() ULib.csay(calling_ply, "Players who have arsenals or resupplies placed down have been printed to your console", Color(150,150,150), 3)end)
		if #arsowner != 0 then
			timer.Create("ars", 1, 1, function()
				for k, v in pairs(arsowner) do
					ULib.console(calling_ply, "Arsenal down: " .. v:Nick())
				end
			end)
		end
		if #resupowner != 0 then
			timer.Create("resupps", 1, 1, function()
				for k, v in pairs(resupowner) do
					ULib.console(calling_ply, "Resupply down: " .. v:Nick())
				end
			end)
		end
	end
	if #plyars == 0 then
		timer.Simple(1, function() ULib.tsayColor(nil, false, Color(255,0,0), "No one has an arsenal in their inventory")end)
	end
	if #plyres == 0 then
		timer.Simple(1, function() ULib.tsayColor(nil, false, Color(255,0,0), "No one has a resupply in their inventory") end)
	end
	ulx.fancyLogAdmin(calling_ply, "#A checked for arsenals and resupplies")
end
local check = ulx.command("Zombie Survival", "ulx checkars/resup", ulx.checkall, "!check")
check:defaultAccess(ULib.ACCESS_OPERATOR)
check:help("Searches everyone's inventory for an arsenal crate, or a resupply box")