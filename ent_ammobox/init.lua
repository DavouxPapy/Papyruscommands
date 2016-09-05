--Adding clientside files and including other files--
AddCSLuaFile("shared.lua")
include("shared.lua")
AddCSLuaFile("cl_init.lua")
----
--Different ammo types for the box. You can change these if you want. --
local ammoTypes = {}
ammoTypes["ar2"] = 200
ammoTypes["pistol"] = 50
ammoTypes["smg1"] = 250
ammoTypes["357"] = 35
ammoTypes["buckshot"] = 45
ammoTypes["sniperround"] = 60
ammoTypes["battery"] = 50
ammoTypes["pulse"] = 150
----
function ENT:Initialize()
	local ent = self
	ent:SetModel("models/Items/item_item_crate.mdl")
	ent:SetPlaybackRate(1) --Default speed--
	ent:SetUseType(SIMPLE_USE) --Could use decimal version "3", dependant on whatever your server's gmod instance is--
	ent:PhysicsInit(SOLID_VPHYSICS)--Makes the entity solid, just so we cant go through it.--
	if ent:GetPhysicsObject():IsValid() then --Makes it so the box cannot be moved--
		ent:GetPhysicsObject():EnableMotion(false)--Makes the entity not able to move--
		ent:GetPhysicsObject():Wake()--Wakes the entity
	end
end
----
--On use--
function giveAmmo(ammotype, ply)
	ammotype = string.lower(game.GetAmmoName(ammotype))
	if ammoTypes[ammotype] then
		ply:GiveAmmo(ammoTypes[ammotype], ammotype, true)
	else
		ply:GiveAmmo(10, ammotype, true)
	end
end
function ENT:Use(user, caller)
	if not IsValid(user) or not user:Alive() then--If the player using the box isnt alive, do nothing.--
		return
	elseif IsValid(user)  and user:Alive() then
		for _, weap in pairs(user:GetWeapons()) do
			local ammotype = weap:GetPrimaryAmmoType()
			if ammotype ~= nil and ammotype > 0 then
				giveAmmo(ammotype, user)
			end
		end
		self:EmitSound("items/ammocrate_open.wav")
	end
end
----
