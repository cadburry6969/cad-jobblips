if Config.Framework == 'qb' then
    local QBCore = exports['qb-core']:GetCoreObject()

    function GetPlayerJob()
        local job = QBCore.Functions.GetPlayerData().job
        if not job then return { label = 'Undefined', job = 'unemployed' } end
        return { name = job.name, onduty = job.onduty }
    end
elseif Config.Framework == 'esx' then
    local ESX = exports.es_extended:getSharedObject()

    function GetPlayerJob()
        local job = ESX.GetPlayerData().job
        if not job then return { label = 'Undefined', job = 'unemployed' } end
        return { name = job.name, onduty = true }
    end
else
    -- edit the function below to get your details if you are using framework apart from esx/qb
    function GetPlayerJob()
        local name = 'police'
        local onduty = true
        return { name = name, onduty = onduty }
    end
end