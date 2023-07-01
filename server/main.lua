-----------------For support, scripts, and more----------------
--------------- https://discord.gg/VGYkkAYVv2  -------------
---------------------------------------------------------------

QBCore = nil
ESX = nil

local minedInformation = {}

if Config.Core == "QBCore" then
    TriggerEvent(Config.Core..':GetObject', function(obj) QBCore = obj end)
    if QBCore == nil then
        QBCore = exports[Config.CoreFolderName]:GetCoreObject()
    end
elseif Config.Core == "ESX" then
    local status, errorMsg = pcall(function() ESX = exports[Config.CoreFolderName]:getSharedObject() end)
    if ESX == nil then
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
    end
end

local function GetFWIdentifier(playerId)
    if Config.Core == "QBCore" then
        local player = QBCore.Functions.GetPlayer(playerId)
        if player ~= nil then
            return player.PlayerData.citizenid
        end
    elseif Config.Core == "ESX" then
        local player = ESX.GetPlayerFromId(playerId)
        if player ~= nil then
            return player.identifier
        end
    end
end

local function AddItem(src, item, amount)
    if Config.Core == "QBCore" then
        local player = QBCore.Functions.GetPlayer(src)
        if player ~= nil then
            if player.Functions.AddItem(item, amount) then
                return true
            else
                return false
            end
        end
    elseif Config.Core == "ESX" then
        local player = ESX.GetPlayerFromId(src)
        if player ~= nil then
            if player.canCarryItem(item, amount) then
                player.addInventoryItem(item, amount)
                return true
            else
                return false
            end
        end
    end
end

local function HasItem(source, item ,amount)
    if Config.Core == "QBCore" then
        local player = QBCore.Functions.GetPlayer(source)
        if player ~= nil then
            return player.Functions.GetItemByName(item).count >= amount
        end
    elseif Config.Core == "ESX" then
        local player = ESX.GetPlayerFromId(source)
        if player ~= nil then
            return player.getInventoryItem(item).count >= amount
        end
    end
end

lib.callback.register("snipe-mining:server:hasItem", function(source, item)
    return HasItem(source, item, 1)
end)

lib.callback.register("snipe-mining:server:canMine", function(source, id)
    local source = source
    local identifier = GetFWIdentifier(source)
    if not minedInformation[identifier] then
        minedInformation[identifier] = {}
        return true
    else
        if not minedInformation[identifier][id] then
            return true
        else
            return false
        end
    end
end)

lib.callback.register("snipe-mining:server:minedLocation", function(source, id)
    local source = source
    local identifier = GetFWIdentifier(source)
    local randomNumber = math.random(1, 100)
    local itemAdded = false
    for k, v in pairs(Config.MineItems) do
        if type(v.chance) == "table" then
            if v.chance[1] <= randomNumber and v.chance[2] > randomNumber then
                local giveAmount = 1
                if type(v.amount) == "table" then
                    if v.amount[1] > v.amount[2] then
                        giveAmount = math.random(v.amount[2], v.amount[1])
                    else
                        giveAmount = math.random(v.amount[1], v.amount[2])
                    end
                else
                    giveAmount = v.amount
                end
                itemAdded = AddItem(source, v.item, giveAmount)
                break
            end
        else
            if v.chance >= randomNumber then
                local giveAmount = 1
                if type(v.amount) == "table" then
                    if v.amount[1] > v.amount[2] then
                        giveAmount = math.random(v.amount[2], v.amount[1])
                    else
                        giveAmount = math.random(v.amount[1], v.amount[2])
                    end
                else
                    giveAmount = v.amount
                end
                itemAdded = AddItem(source, v.item, giveAmount)
                break
            end
        end
    end
    if not itemAdded then
        return false
    end
    if Config.AllowUnlimitedMining then
        return true
    end
    minedInformation[identifier][id] = true
    return true
end)