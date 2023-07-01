-----------------For support, scripts, and more----------------
--------------- https://discord.gg/VGYkkAYVv2  -------------
---------------------------------------------------------------

QBCore, ESX = nil, nil

local minigameConfig = {
    initializingTimer= 2, -- in seconds before the game starts
    gameCountDownTime= 15, --in seconds how much time they have to complete the game
    totalCorrectClicksAllowed= 3, -- total number of correct clicks required to win
    totalWrongClicksAllowed= 2, -- total number of wrong click they can do before losing

    chooseRandomBubbleColors= true, --if false singleBubbleColor will be given if provided else color from code used 
    singleBubbleColor= '', --optional - if not provided, color from code will be used
    chooseRandomSizeBubbles= false, --if false singleBubbleSize will be given if provided else size from code used 
    singleBubbleSize= '1'--optional - if not provided, size from code will be used -> value should be integer values from 1 to 3
}

local function SetTargetExports()
    CreateThread(function()
        for k, v in pairs(Config.Locations) do
            exports["qb-target"]:AddBoxZone("mininglocation"..k, v.coords, 1.0,  1.0, {
                name = "mininglocation" .. k,
                heading = 45.0,
                minZ = v.coords.z - 1.0 ,
                maxZ = v.coords.z + 1.0 ,
                debugPoly = Config.Debug
            }, {
                options = {
                    {
                        type = "client",
                        icon = "fa fa-hand",
                        label = "Mine",
                        action = function()
                            Mine(v.id)
                        end,
                    }
                },
                distance = 1.5
            })
        end
    end)
end

function Mine(id)
    local hasItem = false
    hasItem = lib.callback.await("snipe-mining:server:hasItem", false, Config.MineItem)
    if not hasItem then
        lib.notify({description = "You don't have a pickaxe", type = "error"})
        return
    end
    local success = true
    if not Config.AllowUnlimitedMining then
        success = lib.callback.await("snipe-mining:server:canMine", false, id)
    end
    if success then
        local result = exports["snipe-aimgame"]:openAimGame(minigameConfig)
        if not result then
            lib.notify({description = "You failed", type = "error"})
            return
        end
        
        local pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true)
		AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
        if lib.progressCircle({
            label = "Mining..",
            duration = 5000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = "melee@large_wpn@streamed_core",
                clip = "ground_attack_on_spot"
            },
        }) then 
            DetachEntity(pickaxe, 1, true)
            DeleteEntity(pickaxe)
            DeleteObject(pickaxe)
            local success = lib.callback.await("snipe-mining:server:minedLocation", false, id)
            if not success then
                lib.notify({description = "You cannot carry items", type = "error"})
                return
            end
            lib.notify({description = "You mined this location", type = "success"})
        else 
            DetachEntity(pickaxe, 1, true)
            DeleteEntity(pickaxe)
            DeleteObject(pickaxe)
            lib.notify({description = "You cancelled the mining", type = "error"})
        end
        
    else
        lib.notify({description = "You already mined this location", type = "error"})
    end
end


-- Framework Related (No need to touch!)

if Config.Core == "QBCore" then
    local status, errorMsg = pcall(function() ESX = exports[Config.CoreFolderName]:getSharedObject() end)
    Wait(250)
    if QBCore == nil then
        Citizen.CreateThread(function()
            while QBCore == nil do
                TriggerEvent(Config.Core..':GetObject', function(obj) QBCore = obj end)
                Citizen.Wait(200)
            end
        end)
    end
    SetTargetExports()
elseif Config.Core == "ESX" then
    local status, errorMsg = pcall(function() ESX = exports[Config.CoreFolderName]:getSharedObject() end)
    Wait(250)
    if (ESX == nil) then
        while ESX == nil do
            Wait(100)
            TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        end
    end
    SetTargetExports()
end
