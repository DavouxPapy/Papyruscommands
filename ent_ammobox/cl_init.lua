--Including other files for the client--
include("shared.lua")
----
--What happens when the entity is actually created on the client's side--
function ENT:Initialize()
	self:SetRenderBounds(Vector(-72, -72), Vector(72, 72, 128))
end
----
--Called everytime the entity needs to know whether the entity using it can actually receive ammo--
function ENT:Think()
	self:NextThink(CurTime() + 2)
	return true
end
----
--Draws the ClientsideModel--
function ENT:Draw()
	self:DrawModel()
	if not self:IsValid() then
		return false
	end
end
----