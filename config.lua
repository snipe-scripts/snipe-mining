-----------------For support, scripts, and more----------------
--------------- https://discord.gg/VGYkkAYVv2  -------------
---------------------------------------------------------------

Config = {}


Config.Core = "ESX" -- ESX or QBCore
Config.CoreFolderName = "es_extended"  -- es_extended || qb-core

Config.PlayerLoadedEvent = "esx:playerLoaded" -- esx:playerLoaded || QBCore:Client:OnPlayerLoaded
Config.PlayerUnloadEvent = "esx:onPlayerLogout" -- esx:onPlayerLogout || QBCore:Client:OnPlayerUnload     

Config.Debug = true -- set to false if you dont want debug messages in console or target zones

Config.AllowUnlimitedMining = true -- set to true if you want players to be able to mine unlimited times at each location

Config.MineItem = "pickaxe" -- item that is required to mine

-- always add items in order of rarity so it goes through table properly and gives you the rare item if you chance is good. 
-- If you put the 100% chance at top, it will give the stone everytime and break the loop and player will never get the rare item
Config.MineItems = {
    [1] = {
        item = "diamond",
        chance = {1, 6}, -- if random number is between 5 and 10 then it will give this item
        amount = {1, 2}, -- if you give a table of values then it will give a random amount between those values
    },
    [2] = {
        item = "ruby",
        chance = {6, 10}, -- if random number is between 11 and 16 then it will give this item
        amount = 1, -- if you just pass a number then it will always give this amount
    },
    [3] = {
        item = "stone",
        chance = 100, -- if 100, then it will give this item if the random number is not between any of the other items
        amount = {1, 2}, -- if random number is between 1 and 2 then it will give this amount
    }
}

Config.Locations = {
    [1] = {
        id = 1,
        coords = vector3(2983.2622070313, 2750.2133789063, 43.140986633301),

    },
    [2] = {
        id =2,
        coords = vector3(2986.6740722656, 2751.4396972656, 43.619853210449),
    },
    [3] = {
        id = 3,
        coords = vector3(2989.7763671875, 2751.1118164063, 43.617316436768)
    },
    [4] = {
        id = 4,
        coords = vector3(2993.5278320313, 2749.9968261719, 43.969897460938)
    },
    [5] = {
        id = 5,
        coords = vector3(2998.9965820313, 2751.2802734375, 44.038535308838)
    },
    [6] = {
        id = 6,
        coords = vector3(3001.2897949219, 2755.3032226563, 43.897917938232)
    },
    [7] = {
        id = 7,
        coords = vector3(3005.1977539063, 2762.5668945313, 43.539195251465)
    },
    [8] = {
        id = 8,
        coords = vector3(3005.9313964844, 2773.0051269531, 43.425006103516)
    },
    [9] = {
        id = 9,
        coords = vector3(3006.630859375, 2781.4780273438, 43.504875946045)
    },
    [10] = {
        id = 10,
        coords = vector3(3004.2805175781, 2785.9936523438, 44.091098022461)
    },
}
