local ox_inventory = exports.ox_inventory

RegisterNetEvent('WRepair:Cost')
AddEventHandler('WRepair:Cost', function(data)
    local curweapon = data.selweapon
    local weapon = ox_inventory:Search(source, 'slots', curweapon)
    weapon = weapon[1]
    ox_inventory:RemoveItem(source, 'repairkit_weapon', 1) --You can change 'repairkit_weapon' to whatever item you want to remove as payment
    ox_inventory:SetDurability(source, weapon.slot, 100)
end)
