--Shared file--
local ply = FindMetaTable("Player") --Finds the meta table "Player", so the function can be applied to all players
function ply:healOverTime() --Metafunction name
	local hp = self:Health() --Returns the health of the player. "self" means whichever player the function's being tested on
	if hp >= 100 then
		self:ChatPrint("You already have maximum health") --Messaged printed to player's chat box
	elseif hp <= 99 and hp > 0 then --If the previous if statement isnt true then...
		PrintMessage(HUD_PRINTTALK, "Player: " .. self:Nick() .. " is being healed") --Prints a message to all player's chat boxes
		local healRemaining = 100 - hp
		timer.Create("Healplayer", 1, healRemaining, function() --Function happens over time
			self:SetHealth(self:Health() + 1) --Slowly heals the player
		end)
	else --Anything else
		self:ChatPrint("You are dead!")
	end
end
hook.Add("PlayerSay", "HealPly", function(ply, text) --Called whenver the player types something
	if string.lower(text) == "!healme" then --If the text the player writes is equal to "!healme"
		ply:healOverTime() --Carries out the meta function on the player
	end
end)
