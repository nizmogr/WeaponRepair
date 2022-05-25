local ox_inventory = exports.ox_inventory
local weapon = {}
local weapons = {'WEAPON_ADVANCEDRIFLE','WEAPON_APPISTOL','WEAPON_ASSAULTRIFLE','WEAPON_ASSAULTSHOTGUN','WEAPON_BULLPUPRIFLE','WEAPON_CARBINERIFLE','WEAPON_COMBATMG','WEAPON_COMBATPISTOL','WEAPON_COMBATPDW','WEAPON_COMBATSHOTGUN','WEAPON_HEAVYSNIPER','WEAPON_HEAVYSNIPER_MK2','WEAPON_MARKSMANRIFLE','WEAPON_MARKSMANRIFLE_MK2','WEAPON_MG','WEAPON_MICROSMG','WEAPON_MINIGUN','WEAPON_MOLOTOV','WEAPON_MUSKET','WEAPON_PETROLCAN','WEAPON_PISTOL','WEAPON_PISTOL50','WEAPON_PROXMINE','WEAPON_PUMPSHOTGUN','WEAPON_REVOLVER','WEAPON_RPG','WEAPON_SAWNOFFSHOTGUN','WEAPON_SMG','WEAPON_SMG_MK2','WEAPON_SNIPERRIFLE','WEAPON_SNIPERRIFLE_MK2','WEAPON_SWITCHBLADE','WEAPON_VINTAGEPISTOL','WEAPON_ASSAULTRIFLE_MK2','WEAPON_ASSAULTSMG','WEAPON_BAT','WEAPON_BATTLEAXE','WEAPON_BULLPUPSHOTGUN','WEAPON_CARBINERIFLE_MK2','WEAPON_CERAMICPISTOL','WEAPON_COMBATMG_MK2','WEAPON_COMPACTRIFLE','WEAPON_CROWBAR','WEAPON_DAGGER','WEAPON_DBSHOTGUN','WEAPON_DOUBLEACTION','WEAPON_FIREWORK','WEAPON_FLAREGUN','WEAPON_FLASHLIGHT','WEAPON_GOLFCLUB','WEAPON_GUSENBERG','WEAPON_HAMMER','WEAPON_HATCHET','WEAPON_HEAVYPISTOL','WEAPON_HEAVYSHOTGUN','WEAPON_KNIFE','WEAPON_KNUCKLE','WEAPON_MACHETE','WEAPON_MACHINEPISTOL','WEAPON_MARKSMANPISTOL','WEAPON_MILITARYRIFLE','WEAPON_MINISMG','WEAPON_NAVYREVOLVER','WEAPON_NIGHTSTICK','WEAPON_PISTOL_MK2','WEAPON_POOLCUE','WEAPON_PUMPSHOTGUN_MK2','WEAPON_REVOLVER_MK2','WEAPON_SNSPISTOL','WEAPON_SNSPISTOL_MK2','WEAPON_SPECIALCARBINE','WEAPON_SPECIALCARBINE_MK2','WEAPON_STONE_HATCHET','WEAPON_STUNGUN','WEAPON_SWEEPERSHOTGUN','WEAPON_WRENCH'}

function openContext()
    local inventory = ox_inventory:Search('count', weapons)
    local options = {}
    if inventory then
        for name, count in pairs(inventory) do
            if count >= 1 then
                local curweapon = name
                local weapon = ESX.GetWeaponLabel(name)
                options[weapon] = {
                    event = 'WRepair:repairWeapon',
                    args = {selweapon = curweapon}
                }
            end
        end
    end

    lib.registerContext({
        id = 'weapon_menu',
        title = 'Repair Weapon',
        options = options
    })
    lib.showContext('weapon_menu')
end

RegisterNetEvent('WRepair:repairWeapon', function(data)
    local rcount = ox_inventory:Search('count', 'repairkit_weapon')
    if rcount > 0 then
        TriggerServerEvent('WRepair:Cost', data)
                lib.notify({
                    title = 'Success',
                    description = 'You have repaired your weapon!',
                    position = 'top',
                    duration = 3500,
                    style = {
                        backgroundColor = 'darkseagreen',
                        color = 'white'
                    },
                    icon = 'gun',
                    iconColor = 'white'
                })       
    else
        lib.notify({
            title = 'Error',
            description = 'You are missing a Weapon Kit!',
            position = 'top',
            duration = 3500,
            style = {
                backgroundColor = 'lightcoral',
                color = 'white'
            },
            icon = 'gun',
            iconColor = 'white'
        })
    end
end)

Config = {
    PedModel = `cs_josef`,
    Peds = {
        vector4(12.0596, -1106.9465, 29.7970, 342.0751),    --You can add as many peds as you like thanks to SNIPER
        --vector4(487.3318, -996.91, 30.67834, 89.514),     --Example at mrpd
    }
}

CreateThread(function()
    for i=1, #Config.Peds, 1 do
        -- Blip
        local blip = AddBlipForCoord(Config.Peds[i].x, Config.Peds[i].y)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 0)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString('Repair Station')
        EndTextCommandSetBlipName(blip)

        -- Ped
        RequestModel(Config.PedModel)
        while not HasModelLoaded(Config.PedModel) do 
            Wait(1)
        end
        local ped = CreatePed(4, Config.PedModel, Config.Peds[i].x, Config.Peds[i].y, Config.Peds[i].z - 1, Config.Peds[i].w, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        exports.qtarget:AddTargetEntity(ped, {
            options = {
                {
                    icon = "fa-solid fa-screwdriver-wrench",
                    label = "Repair Bench",
                    action = function(entity)
                        openContext()
                    end
                },
            },
            distance = 2
        })
    end
end)
