AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "LongSword"

    SWEP.Slot = 0

    SWEP.ViewModelFOV = 60
    SWEP.ViewModelFlip = false

    SWEP.ShowViewModel = false
    SWEP.ShowWorldModel = false

    SWEP.ViewModelBoneMods = {
        ["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, -15.742, -5), angle = Angle(-180, 0, 0) }
    }

    SWEP.VElements = {
        ["sword"] = { type = "Model", model = "models/melee/knight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 1.557, -2.597), angle = Angle(-167.144, -50.26, 5.843), size = Vector(1.404, 1.404, 1.404), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
    }


    SWEP.WElements = {
        ["sword"] = { type = "Model", model = "models/melee/knight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 0.518, -1.558), angle = Angle(-180, 132.078, 0), size = Vector(1.08, 1.08, 1.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
    }

    SWEP.Description = "Sword Of The Four Kings"
 end

SWEP.Base = "weapon_zs_basemelee"
SWEP.DamageType = DMG_SLASH

SWEP.HitDecal = "Manhackcut"
SWEP.ViewModel = "models/weapons/v_sledgehammer/v_sledgehammer.mdl"
SWEP.WorldModel = "models/melee/knight.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 100
SWEP.MeleeRange = 60
SWEP.MeleeSize = 0.5
SWEP.MeleeKnockBack = SWEP.MeleeDamage * 0.001
SWEP.MeleeDelay = 1
SWEP.Primary.Delay = 1

SWEP.SwingTime = 0.8
SWEP.SwingRotation = Angle(30, -30, -30)
SWEP.SwingOffset = Vector(0, -30, 0)
SWEP.SwingHoldType = "melee2"
SWEP.HoldType = "melee2"
function SWEP:Equip()
    self:EmitSound("papy/heman.mp3")
end
SWEP.HitAnim = ACT_VM_MISSCENTER

function SWEP:PlaySwingSound()
    self:EmitSound("weapons/knife/knife_slash"..math.random(2)..".wav", 72, math.Rand(85, 95))
end

function SWEP:PlayHitSound()
    self:EmitSound("weapons/knife/knife_hitwall1.wav", 72, math.Rand(75, 85))
end

function SWEP:PlayHitFleshSound()
    self:EmitSound("physics/flesh/flesh_squishy_impact_hard"..math.random(4)..".wav")
    self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end

function SWEP:PostOnMeleeHit(hitent, hitflesh, tr)
    if hitent:IsValid() and hitent:IsPlayer() and hitent:Health() <= 0 then
        -- Dismember closest limb to tr.HitPos
    end
end
resource.AddFile("models/melee/knight.mdl")