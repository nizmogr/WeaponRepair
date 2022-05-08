local ox_inventory = exports.ox_inventory
local weapons = {'WEAPON_ADVANCEDRIFLE','WEAPON_APPISTOL','WEAPON_ASSAULTRIFLE','WEAPON_ASSAULTSHOTGUN','WEAPON_BULLPUPRIFLE','WEAPON_CARBINERIFLE','WEAPON_COMBATMG','WEAPON_COMBATPISTOL','WEAPON_COMBATPDW','WEAPON_COMBATSHOTGUN','WEAPON_HEAVYSNIPER','WEAPON_HEAVYSNIPER_MK2','WEAPON_MARKSMANRIFLE','WEAPON_MARKSMANRIFLE_MK2','WEAPON_MG','WEAPON_MICROSMG','WEAPON_MINIGUN','WEAPON_MOLOTOV','WEAPON_MUSKET','WEAPON_PETROLCAN','WEAPON_PISTOL','WEAPON_PISTOL50','WEAPON_PROXMINE','WEAPON_PUMPSHOTGUN','WEAPON_REVOLVER','WEAPON_RPG','WEAPON_SAWNOFFSHOTGUN','WEAPON_SMG','WEAPON_SMG_MK2','WEAPON_SNIPERRIFLE','WEAPON_SNIPERRIFLE_MK2','WEAPON_SWITCHBLADE','WEAPON_VINTAGEPISTOL','WEAPON_ASSAULTRIFLE_MK2','WEAPON_ASSAULTSMG','WEAPON_BAT','WEAPON_BATTLEAXE','WEAPON_BULLPUPSHOTGUN','WEAPON_CARBINERIFLE_MK2','WEAPON_CERAMICPISTOL','WEAPON_COMBATMG_MK2','WEAPON_COMPACTRIFLE','WEAPON_CROWBAR','WEAPON_DAGGER','WEAPON_DBSHOTGUN','WEAPON_DOUBLEACTION','WEAPON_FIREWORK','WEAPON_FLAREGUN','WEAPON_FLASHLIGHT','WEAPON_GOLFCLUB','WEAPON_GUSENBERG','WEAPON_HAMMER','WEAPON_HATCHET','WEAPON_HEAVYPISTOL','WEAPON_HEAVYSHOTGUN','WEAPON_KNIFE','WEAPON_KNUCKLE','WEAPON_MACHETE','WEAPON_MACHINEPISTOL','WEAPON_MARKSMANPISTOL','WEAPON_MILITARYRIFLE','WEAPON_MINISMG','WEAPON_NAVYREVOLVER','WEAPON_NIGHTSTICK','WEAPON_PISTOL_MK2','WEAPON_POOLCUE','WEAPON_PUMPSHOTGUN_MK2','WEAPON_REVOLVER_MK2','WEAPON_SNSPISTOL','WEAPON_SNSPISTOL_MK2','WEAPON_SPECIALCARBINE','WEAPON_SPECIALCARBINE_MK2','WEAPON_STONE_HATCHET','WEAPON_STUNGUN','WEAPON_SWEEPERSHOTGUN','WEAPON_WRENCH'}

local function openContext()
    lib.registerContext({
        id = 'weapon_menu',
        title = 'Repair Weapon',
        options = {
            ['Do you wish to repair your weapon?'] = {
                description = 'Yes',
                event = 'WRepair:repairWeapon'
            }
        }
    })
    lib.showContext('weapon_menu')
end

RegisterNetEvent('WRepair:repairWeapon', function()
    if true then
        lib.callback('WRepair:Cost', false, function(response)
            if response then
               -- Uncomment this if you plan on adding the item check back. *shrug*
                --[[ 
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
                openContext()
                --]]
            elseif not response then
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
            end
        end)
    end
end)

local repairguy = `a_f_m_prolhost_01`
    exports["qtarget"]:AddTargetModel(repairguy, {
        options = {
            {
                icon = "fa-solid fa-gun",
                label = "Repair Weapon",
                action = function(entity)
                    openContext()
                end
            }
        },
    distance = 3.0
})

-- Map blip
CreateThread(function ()
    blip = AddBlipForCoord(231.6, -1094.99) -- x & y coordinates
    SetBlipSprite(blip, 110) --  icon 
    SetBlipScale(blip, 0.7) -- size
    SetBlipColour(blip, 0) -- color
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Repair Station') -- name that shows on the map
    EndTextCommandSetBlipName(blip)
end)
