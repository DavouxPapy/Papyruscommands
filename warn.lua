----------------------------Warn------------------------
function ulx.warntest(calling_ply, target_ply, reason)
	local id = target_ply:SteamID()
	if reason and reason ~= "" then
		local pdata = target_ply:GetPData("warns", "{}")
		local json = util.JSONToTable(pdata)
		if json == nil then
			json = {}
		else
			json = util.JSONToTable(pdata)
		end
		table.insert(json, reason)
		local json2 = util.TableToJSON(json)
		target_ply:SetPData("warns", json2)
		ulx.fancyLogAdmin(calling_ply, "#A warned #T for #s", target_ply, reason)
		ULib.csay(target_ply, "You have been warned for: " .. reason, Color(255,0,255), 4)
	else
		local pdata = target_ply:GetPData("warns", "{}")
		local json = util.JSONToTable(pdata)
		if json == nil then
			json = {}
		else
			json = util.JSONToTable(pdata)
		end
		table.insert(json, "Warned Without Reason")
		local json2 = util.TableToJSON(json)
		target_ply:SetPData("warns", json2)
		ulx.fancyLogAdmin(calling_ply, "#A warned #T", target_ply)
	end
end
local warn = ulx.command("Utility", "ulx warn", ulx.warntest, "!warn")
warn:addParam{type = ULib.cmds.PlayerArg}
warn:addParam{ type = ULib.cmds.StringArg, hint = "reason", ULib.cmds.optional, ULib.cmds.takeRestOfLine, completes = ulx.common_kick_reasons}
warn:defaultAccess(ULib.ACCESS_OPERATOR)
---------------------------- Warn info -----------------
function ulx.readwarn(calling_ply, target_ply)
	local pdata = target_ply:GetPData("warns", "{}")
	if #pdata == 0 then
		calling_ply:ChatPrint("That player has no warnings")
	elseif #pdata >= 1 then
		local json = util.JSONToTable(pdata)
		ULib.tsayColor(calling_ply, nil, Color(255,0,255), "Warns printed to console)")
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
	ulx.fancyLogAdmin(calling_ply, "#A cleared the warnings of #T", target_ply)
	target_ply:RemovePData("warns")
	util.RemovePData(id, "warns")
end
local clearwarn = ulx.command("Utility", "ulx clearwarn", ulx.clearwarn, "!clearwarns")
clearwarn:addParam{type = ULib.cmds.PlayerArg}