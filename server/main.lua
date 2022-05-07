local ox_inventory = exports.ox_inventory

lib.callback.register('WRepair:Cost', function(weapon)
    ox_inventory:RemoveItem(source, 'repairkit_weapon', 1) -- "repairkit_weapon" is the item you need to repair. You may change it to fit your needs,
    local weapon = ox_inventory:GetCurrentWeapon(source)
    if weapon then
        ox_inventory:SetDurability(source, weapon.slot, 100)
    end
end)
