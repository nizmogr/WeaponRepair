local ox_inventory = exports.ox_inventory

local function OpenMenu()
    local elements = {}
    local weapons = {'WEAPON_ADVANCEDRIFLE','WEAPON_APPISTOL','WEAPON_ASSAULTRIFLE','WEAPON_ASSAULTSHOTGUN','WEAPON_BULLPUPRIFLE','WEAPON_CARBINERIFLE','WEAPON_COMBATMG','WEAPON_COMBATPISTOL','WEAPON_COMBATPDW','WEAPON_COMBATSHOTGUN','WEAPON_HEAVYSNIPER','WEAPON_HEAVYSNIPER_MK2','WEAPON_MARKSMANRIFLE','WEAPON_MARKSMANRIFLE_MK2','WEAPON_MG','WEAPON_MICROSMG','WEAPON_MINIGUN','WEAPON_MOLOTOV','WEAPON_MUSKET','WEAPON_PETROLCAN','WEAPON_PISTOL','WEAPON_PISTOL50','WEAPON_PROXMINE','WEAPON_PUMPSHOTGUN','WEAPON_REVOLVER','WEAPON_RPG','WEAPON_SAWNOFFSHOTGUN','WEAPON_SMG','WEAPON_SMG_MK2','WEAPON_SNIPERRIFLE','WEAPON_SNIPERRIFLE_MK2','WEAPON_SWITCHBLADE','WEAPON_VINTAGEPISTOL','WEAPON_ASSAULTRIFLE_MK2','WEAPON_ASSAULTSMG','WEAPON_BAT','WEAPON_BATTLEAXE','WEAPON_BULLPUPSHOTGUN','WEAPON_CARBINERIFLE_MK2','WEAPON_CERAMICPISTOL','WEAPON_COMBATMG_MK2','WEAPON_COMPACTRIFLE','WEAPON_CROWBAR','WEAPON_DAGGER','WEAPON_DBSHOTGUN','WEAPON_DOUBLEACTION','WEAPON_FIREWORK','WEAPON_FLAREGUN','WEAPON_FLASHLIGHT','WEAPON_GOLFCLUB','WEAPON_GUSENBERG','WEAPON_HAMMER','WEAPON_HATCHET','WEAPON_HEAVYPISTOL','WEAPON_HEAVYSHOTGUN','WEAPON_KNIFE','WEAPON_KNUCKLE','WEAPON_MACHETE','WEAPON_MACHINEPISTOL','WEAPON_MARKSMANPISTOL','WEAPON_MILITARYRIFLE','WEAPON_MINISMG','WEAPON_NAVYREVOLVER','WEAPON_NIGHTSTICK','WEAPON_PISTOL_MK2','WEAPON_POOLCUE','WEAPON_PUMPSHOTGUN_MK2','WEAPON_REVOLVER_MK2','WEAPON_SNSPISTOL','WEAPON_SNSPISTOL_MK2','WEAPON_SPECIALCARBINE','WEAPON_SPECIALCARBINE_MK2','WEAPON_STONE_HATCHET','WEAPON_STUNGUN','WEAPON_SWEEPERSHOTGUN','WEAPON_WRENCH'}
    local inventory = ox_inventory:Search('count', weapons)
    if inventory then
        for name, count in pairs(inventory) do
            if count >= 1 then
                table.insert(elements, {
                    label = ESX.GetWeaponLabel(name) .. ' [' .. count .. ']',
                    type  = 'item_weapon',
                    value = name,
                    index = i
                })
            end
        end
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'repair_menu', {
        title = 'Repair Menu',
        align = 'bottom-right',
        elements = elements
        
    }, function(data, menu)
        menu.close()
        isMenuOpen = false
            if data.current.type == 'item_weapon' then
                TriggerServerEvent('WRepair:Cost', data.current.value)
            end
        end,
    function(data, menu)
        menu.close()
        isMenuOpen = false
    end)
end



CreateThread(function()
	while true do
        Wait(0)
		-- draw every frame
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
        for _, v in ipairs(Config.Marker.OpenLocations) do
            local dist = #(coords - v.Pos)
            if(Config.Marker.MarkerDraw ~= -1 and dist < Config.Marker.DrawDistance) then
		    DrawMarker(Config.Marker.MarkerDraw, v.Pos[1], v.Pos[2], v.Pos[3], 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, Config.Marker.MarkerSize, Config.Marker.MarkerSize, 1.0, Config.Marker.MarkerColor[1], Config.Marker.MarkerColor[2], Config.Marker.MarkerColor[3], 100, false, true, 2, false, false, false, false)
	        end
            if(Config.Marker.MarkerDraw2 ~= -1 and dist < Config.Marker.DrawDistance) then
                DrawMarker(Config.Marker.MarkerDraw2, v.Pos[1], v.Pos[2], v.Pos[3], 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, Config.Marker.MarkerSize2, Config.Marker.MarkerSize2, Config.Marker.MarkerSize2 , Config.Marker.MarkerColor2[1], Config.Marker.MarkerColor2[2], Config.Marker.MarkerColor2[3], 100, false, true, 2, false, false, false, false)
                end
            if dist < Config.Marker.MarkerSize then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to Repair your Weapons") 
                if IsControlJustReleased(0, 38) then
                    OpenMenu()
                end
            end
        end
    end
end)