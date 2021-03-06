local playersReady = 0
function openLobby()
	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW(), ScrH())
	frame:Center()
	frame:ShowCloseButton(false)
	frame:SetDraggable(false)
	frame:SetTitle("")
	frame:SetVisible(true)
	frame.Paint = function()
		draw.RoundedBox(8,0,0, frame:GetWide(), frame:GetTall(), Color(30, 144, 255))
	end
	frame:MakePopup()
	frame:SetBackgroundBlur(true)
	local panel = vgui.Create("DPanel", frame)
	panel:SetSize(ScrW() - 100, ScrH() - 50)
	panel:Center()
	panel:SetVisible(true)
	panel.Paint = function()
		draw.RoundedBox(8,0,0, panel:GetWide(), panel:GetTall(), Color(192, 192, 192))
	end
	local but = vgui.Create("DButton", frame)
	but:SetSize(175, 50)
	but:SetPos(250, ScrH() / 2)
	but:SetText("Class 1 {Revolver}")
	but.DoClick = function()
		net.Start("startGame")
		net.SendToServer()
		net.Start("class1")
		net.SendToServer()
		frame:Close()
	end
	local but2 = vgui.Create("DButton", frame)
	but2:SetSize(175, 50)
	but2:SetPos(500, ScrH() / 2)
	but2:SetText("Class 2 {SMG}")
	but2.DoClick = function()
		net.Start("startGame")
		net.SendToServer()
		net.Start("class2")
		net.SendToServer()
		frame:Close()
	end
	local but3 = vgui.Create("DButton", frame)
	but3:SetSize(175, 50)
	but3:SetPos(750, ScrH() / 2)
	but3:SetText("Class 3 {Assault Rifle}")
	but3.DoClick = function()
		net.Start("startGame")
		net.SendToServer()
		net.Start("class3")
		net.SendToServer()
		frame:Close()
	end
	local but4 = vgui.Create("DButton", frame)
	but4:SetSize(175, 50)
	but4:SetPos(1000, ScrH() / 2)
	but4:SetText("Class 4 {Shotgun}")
	but4.DoClick = function()
		net.Start("startGame")
		net.SendToServer()
		net.Start("class4")
		net.SendToServer()
		frame:Close()
	end
end
net.Receive("openLobby", openLobby)