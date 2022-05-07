local entity = nil

local function weaponNpc()
    if not entity then
            local ped = CreatePed(4, 'a_f_m_prolhost_01', 231.6, -1094.99, 29.29, 94.31, true, false) -- npc model / spawn location
            entity = NetworkGetNetworkIdFromEntity(ped)
            FreezeEntityPosition(ped, true)
        end
    end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    weaponNpc()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if entity then
        if GetCurrentResourceName() ~= resourceName then
            return
        end

        local entity = NetworkGetEntityFromNetworkId(ped)
        DeleteEntity(entity); entity = nil
    end
end)
