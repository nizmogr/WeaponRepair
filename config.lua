Config = {}
Config.RepairItem = 'repairkit_weapon' -- Item used to repair your weapons, Make sure you have the item in your items.lua

Config.Marker = {                  -- Marker settings
OpenLocations = {                  -- Locations where the marker will be drawn, set as many as you want
    {Pos = vector3(228.1186, -1090.708, 29.29676)},
},

MarkerDraw = 21,                   -- Marker draw type, see here for more info: https://docs.fivem.net/game-references/markers/
MarkerDraw2 = 6,                   -- Second Marker draw type, set it if you want to draw a second marker at same place for nicer style, if you don't want it set it to -1
MarkerColor = {190, 193, 196},     -- Marker color
MarkerColor2 = {64, 173, 66},      -- Second Marker color
MarkerSize = 1.1,                  -- Marker size
MarkerSize2 = 1.6,                 -- Second Marker size
DrawDistance = 100,                -- Draw distance
}