local Disjointer = {}

Disjointer.disjointOption = Menu.AddOption({ "Hero Specific", "Puck" }, "Auto Disjointer (Phase Shift)", "Automatically disjoints abilities with Puck's Phase Shift. Can hold a key to disjoint auto attacks.")
Disjointer.disjointAutoAttacksOption = Menu.AddOption({ "Hero Specific", "Puck" }, "Disjoint Auto Attacks", "Automatically disjoints auto attacks with Puck's Phase Shift (no key needed)")
Disjointer.phaseAutoAttacksKey = Menu.AddKeyOption({ "Hero Specific", "Puck" }, "Disjoint Auto Attacks Key", Enum.ButtonCode.KEY_F)

function Disjointer.OnProjectile(projectile)
    if not Menu.IsEnabled(Disjointer.disjointOption) then return end
    if not projectile.source or not projectile.target then return end
    if not projectile.dodgeable then return end
    if not Entity.IsHero(projectile.source) then return end

    local myHero = Heroes.GetLocal()

    if projectile.target ~= myHero then return end

    if Entity.IsSameTeam(projectile.source, projectile.target) then return end

    if projectile.isAttack and not (Menu.IsKeyDown(Disjointer.phaseAutoAttacksKey) or Menu.IsEnabled(Disjointer.disjointAutoAttacksOption)) then 
        return 
    end

    Log.Write(projectile.name)

    local phase_shift = NPC.GetAbility(myHero, "puck_phase_shift")

    if phase_shift and Ability.IsCastable(phase_shift, 0) then
        Ability.CastNoTarget(phase_shift)
    end
end

return Disjointer