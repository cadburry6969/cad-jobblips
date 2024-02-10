if Config.Framework == 'qb' then
    local QBCore = exports['qb-core']:GetCoreObject()

    function GetPlayerInfo(source)
        local player = QBCore.Functions.GetPlayer(source)
        if not player then return { label = 'Undefined', job = 'unemployed' } end
        local label = player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
        local job =  player.PlayerData.job.name
        return { label = label, job = job }
    end
elseif Config.Framework == 'esx' then
    local ESX = exports.es_extended:getSharedObject()

    function GetPlayerInfo(source)
        local player = ESX.GetPlayerFromId(source)
        if not player then return { label = 'Undefined', job = 'unemployed' } end
        local label = player.getName()
        local job = player.getJob() and player.getJob().name
        return { label = label, job = job }
    end
else
    -- edit the function below to get your details if you are using framework apart from esx/qb
    function GetPlayerInfo(source)
        local label = GetPlayerName(source)
        local job = 'police'
        return { label = label, job = job }
    end
end

function GetPlayerIdentifier(source)
    return GetPlayerIdentifierByType(source, Config.Identifier) or source
end

exports('useTracker', function(event, _, inventory, _, _)
    if event == 'usingItem' then
        local source = inventory.id
        local label, job = GetPlayerInfo(source)
        exports['cad-jobblips']:TogglePlayer(source, label, job)
        return
    end
end)


--[[
RegisterCommand('duty', function(source, args)
    if args[1] ~= ' ' then
		exports['cad-jobblips']:AddPlayer(source, 'Cadburry', 'police')
    else
        exports['cad-jobblips']:RemovePlayer(source)
    end
end, true)
]]