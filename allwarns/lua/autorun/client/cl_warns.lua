local warns = ""
local isOpen = false
for k, v in pairs(player.GetAll()) do
	local pdata = v:GetPData("warns", "{}")
	local json = util.JSONToTable(pdata)
	for _, warn in pairs(json) do
		warns = warns .. "Player: " .. v:Nick() ". Warning: " .. warn .. "\n"
	end
end
function openWarns()
	isOpen = true
	local frame = vgui.Create("DFrame")
	frame:Center()
	frame:MakePopup()
	frame:ShowCloseButton(true)
	frame.OnClose = function(self)
		isOpen = false
		self:Remove()
	end
	frame:SetTitle("All Warnings")
	frame:SetSize(300, 150)
	frame:SetVisible(true)
	frame:SetDraggable(true)
	frame.Paint = function()
		draw.RoundedBox(8,0,0, frame:GetWide(), frame:GetTall(), Color(201,201,210))
	end
	frame:SetBackgroundBlur(true)
	frame:SetScreenLock(true)
	frame:SetPaintShadow(true)
	frame:SetText(warns)
end
hook.Add("OnPlayerChat", "OpenWarnings", function(ply, text)
	if ply:IsValid() and ply:IsPlayer() and (ply:IsUserGroup("vip_dev") or ply:IsUserGroup("superadmin") or ply:IsUserGroup("vip_superadmin") or ply:IsUserGroup("headadmin") or ply:IsUserGroup("owner") or ply:IsUserGroup("Co Owner")) and string.lower(text) == "!allwarns" then
		openWarns()
		return true
	end
end)