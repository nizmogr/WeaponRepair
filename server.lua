local ox_inventory = exports.ox_inventory

RegisterServerEvent('WRepair:Cost')
AddEventHandler('WRepair:Cost', function(weapon)
    local itemcheck = ox_inventory:GetItem(source, Config.RepairItem, false, true)
    if Config.RepairItem == 0 then
        print(('WRepair: %s attempted to exploit the shop! (invalid repair cost)'):format(xPlayer.identifier))
        cb(false)
    elseif itemcheck >= 1 then
            ox_inventory:RemoveItem(source, Config.RepairItem, 1)
            local weapon = ox_inventory:Search(source, 'slots', weapon)
            weapon = weapon[1]
            weapon.metadata.durability = 100
            ox_inventory:SetMetadata(source, weapon.slot, weapon.metadata )
            TriggerClientEvent('ox_lib:notify', source, {
				type = 'success',
                duration = 5000,
				description = ('Used %s '..ESX.GetItemLabel(Config.RepairItem)..' for repairing your Weapon'):format(1)
			})
    elseif itemcheck < 1 then
        TriggerClientEvent('ox_lib:notify', source, {
                type = 'error',
                duration = 5000,
                description = ('You don\'t have any '..ESX.GetItemLabel(Config.RepairItem)..' to repair your Weapon'):format(0)
        })

    end
end)

