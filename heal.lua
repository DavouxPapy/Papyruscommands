local ply = FindMetaTable("Player")
function ply:healOverTime()
	local hp = self:Health()
	if hp >= 100 then
		self:ChatPrint("You already have maximum health")
	elseif hp <= 99 and hp > 0 then
		PrintMessage(HUD_PRINTTALK, "Player: " .. self:Nick() .. " is being healed")
		local healRemaining = 100 - hp
		timer.Create("Healplayer", 1, healRemaining, function() 
			self:SetHealth(self:Health() + 1) 
		end)
	else
		self:ChatPrint("You are dead!")
	end
end
hook.Add("PlayerSay", "HealPly", function(ply, text)
	if string.lower(text) == "!healme" then
		ply:healOverTime()
	end
end)