local jobBlips = {}

local function createDutyBlips(data)
    if not data then return end
    local pid, label, job, coords, pblip = data.pid, data.label, data.job, data.coords, data.sprite
    local ped = GetPlayerPed(pid)
    local blip = GetBlipFromEntity(ped)
    if not DoesBlipExist(blip) then
        blip = (NetworkIsPlayerActive(pid) and AddBlipForEntity(ped)) or AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, pblip)
        SetBlipShowCone(blip, true)
        SetBlipRotation(blip, math.ceil(coords.w))
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, Config.Sprites.Job[job] or 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(label)
        EndTextCommandSetBlipName(blip)
        jobBlips[#jobBlips+1] = blip
    end
    if GetBlipFromEntity(PlayerPedId()) == blip then
        RemoveBlip(blip)
    end
end

local function removeDutyBlips()
    if jobBlips then
        for _, v in pairs(jobBlips) do
            RemoveBlip(v)
        end
    end
    jobBlips = {}
end

RegisterNetEvent('cad-jobblips:updateBlips', function(blipData)
    removeDutyBlips()
    if not blipData then return end
    local job = GetPlayerJob()
    if Config.DutyBlipJobs[job.name] and job.onduty then
        for _, data in pairs(value) do
            local player = GetPlayerFromServerId(data.src)
            createDutyBlips({ pid = player, label = data.label, job = data.job, coords = data.coords, sprite = data.sprite })
        end
    end
end)