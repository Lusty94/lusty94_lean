local QBCore = exports['qb-core']:GetCoreObject()
local InvType = Config.CoreSettings.Inventory.Type
local NotifyType = Config.CoreSettings.Notify.Type
local Levels = Config.XP.Levels
local MetaDataName = Config.XP.MetaDataName
local xpChance = Config.XP.XPChance

--useable plastic cup to make lean
QBCore.Functions.CreateUseableItem('plasticcup', function(source, item)
    TriggerClientEvent("lusty94_lean:client:LeanMenu", source)
end)
--useable lean cup
QBCore.Functions.CreateUseableItem('leancup', function(source, item)
    TriggerClientEvent("lusty94_lean:client:DrinkLean", source)
end)


--notification function
local function SendNotify(src, msg, type, time, title)
    if not title then title = "Lean" end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print("Notification Sent With No Message") return end
    if NotifyType == 'qb' then
        TriggerClientEvent('QBCore:Notify', src, msg, type, time)
    elseif NotifyType == 'okok' then
        TriggerClientEvent('okokNotify:Alert', src, title, msg, time, type, Config.CoreSettings.Notify.Sound)
    elseif NotifyType == 'mythic' then
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = type, text = msg, style = { ['background-color'] = '#00FF00', ['color'] = '#FFFFFF' } })
    elseif NotifyType == 'boii'  then
        TriggerClientEvent('boii_ui:notify', src, title, msg, type, time)
    elseif NotifyType == 'ox' then 
        TriggerClientEvent('ox_lib:notify', src, ({ title = title, description = msg, length = time, type = type, style = 'default'}))
    end
end

-- check active cops on duty
local function copsOnDuty()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(players) do
        if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "bcso" or Player.PlayerData.job.name == "leo" and Player.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    return amount
end

-- callback to check for starting mission
QBCore.Functions.CreateCallback('lusty94_lean:server:StartMission', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local copsOnDuty = copsOnDuty()
    if not Player then return end
    if copsOnDuty >= Config.CoreSettings.Police.MinCops then
        cb(true)
    else
        cb(false)
        SendNotify(src, Config.Language.Notifications.NoPolice, 'error', 2500)
    end
end)

-- give codeinepromethazine when searching peds
RegisterNetEvent('lusty94_lean:server:SearchBody', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local LeanXP = Player.PlayerData.metadata[MetaDataName]
    local xpAmount = math.random(10,25) -- edit xp amount here
    if not Player then return end
    local returnAmount
    if Config.XP.Enabled then
        if LeanXP >= 150 then
            returnAmount = math.random(2,5)
        elseif LeanXP >= 500 then
            returnAmount = math.random(5,9)
        elseif LeanXP >= 750 then
            returnAmount = math.random(9, 13)
        elseif LeanXP >= 1250 then
            returnAmount = math.random(13, 18)
        elseif LeanXP >= 1500 then
            returnAmount = math.random(18, 25)
        elseif LeanXP >= 2200 then
            returnAmount = math.random(25, 32)
        end
    else
        returnAmount = math.random(1,3) -- edit return amount here if not using xp
    end
    if InvType == 'qb' then
        if exports['qb-inventory']:AddItem(src, 'codeinepromethazine', returnAmount, nil, nil, nil) then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['codeinepromethazine'], 'add', returnAmount)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, 'codeinepromethazine', returnAmount) then
            exports.ox_inventory:AddItem(src, 'codeinepromethazine', returnAmount)
        else
            SendNotify(src,Config.Language.Notifications.CantCarry, 'error', 5000)
        end
    end
    if Config.XP.Enabled then
        if math.random(1,100) <= xpChance then
            Player.Functions.SetMetaData(MetaDataName, (LeanXP + xpAmount))
            SendNotify(src,Config.Language.Notifications.EarnedXP, 'success', 2000)
        end
    end
end)


--lean ingredients callback
QBCore.Functions.CreateCallback('lusty94_lean:get:LeanIngredients', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local lean = Player.Functions.GetItemByName('codeinepromethazine')
    local sweets = Player.Functions.GetItemByName('sweets')
    local drink = Player.Functions.GetItemByName('fizzydrink')
    local cup = Player.Functions.GetItemByName('plasticcup')
    if lean and lean.amount >= 1 then
        if sweets and sweets.amount >= 1 then
            if drink and drink.amount >= 1 then
                if cup and cup.amount >= 1 then
                    cb(true)
                else
                    cb(false)
                    SendNotify(src,Config.Language.Notifications.NoCup, 'error', 2500)
                end
            else
                cb(false)
                SendNotify(src,Config.Language.Notifications.NoDrink, 'error', 2500)
            end
        else
            cb(false)
            SendNotify(src,Config.Language.Notifications.NoSweets, 'error', 2500)
        end
    else
        cb(false)
        SendNotify(src,Config.Language.Notifications.NoCodeine, 'error', 2500)
    end
end)


--lean ingredients callback
QBCore.Functions.CreateCallback('lusty94_lean:get:Lean', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local lean = Player.Functions.GetItemByName('leancup')
    if lean and lean.amount >= 1 then
        cb(true)
    else
        cb(false)
    end
end)


-- give codeine and promethazine when searching peds
RegisterNetEvent('lusty94_lean:server:MakeLean', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then     
        if exports['qb-inventory']:RemoveItem(src, 'codeinepromethazine', 1, nil, nil, nil) then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['codeinepromethazine'], 'remove', 1)
            exports['qb-inventory']:RemoveItem(src, 'sweets', 1, nil, nil, nil)
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['sweets'], 'remove', 1)
            exports['qb-inventory']:RemoveItem(src, 'fizzydrink', 1, nil, nil, nil)
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['fizzydrink'], 'remove', 1)
            exports['qb-inventory']:RemoveItem(src, 'plasticcup', 1, nil, nil, nil)
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['plasticcup'], 'remove', 1)
            exports['qb-inventory']:AddItem(src, 'leancup', 1, nil, nil, nil)
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['leancup'], 'add', 1)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src, 'codeinepromethazine', 1) then
            exports.ox_inventory:RemoveItem(src, 'sweets', 1)
            exports.ox_inventory:RemoveItem(src, 'fizzydrink', 1)
            exports.ox_inventory:RemoveItem(src, 'plasticcup', 1)
            if exports.ox_inventory:CanCarryItem(src, 'leancup', 1) then
                exports.ox_inventory:AddItem(src, 'leancup', 1)
            else
                SendNotify(src,Config.Language.Notifications.CantCarry, 'error', 5000)
            end
        end
    end
end)


-- drink lean
RegisterNetEvent('lusty94_lean:server:DrinkLean', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then     
        if exports['qb-inventory']:RemoveItem(src, 'leancup', 1, nil, nil, nil) then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['leancup'], 'remove', 1)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:RemoveItem(src, 'leancup', 1) then end
    end
end)





---------------------< DONT TOUCH >-----------


local function CheckVersion()
	PerformHttpRequest('https://raw.githubusercontent.com/Lusty94/UpdatedVersions/main/Lean/version.txt', function(err, newestVersion, headers)
		local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
		if not newestVersion then print("Currently unable to run a version check.") return end
		local advice = "^1You are currently running an outdated version^7, ^1please update^7"
		if newestVersion:gsub("%s+", "") == currentVersion:gsub("%s+", "") then advice = '^6You are running the latest version.^7'
		else print("^3Version Check^7: ^2Current^7: "..currentVersion.." ^2Latest^7: "..newestVersion..advice) end
	end)
end
CheckVersion()