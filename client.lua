local jobBlips = {}

function CreateDutyBlips(data)
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
end

function RemoveDutyBlips()
    if jobBlips then
        for _, v in pairs(jobBlips) do
            RemoveBlip(v)
        end
    end
    jobBlips = {}
end

RegisterNetEvent('cad-jobblips:updateBlips', function(value)
    RemoveDutyBlips()
    if value then
        for _, data in pairs(value) do
            if data.src ~= GetPlayerServerId(PlayerId()) then
                local player = GetPlayerFromServerId(data.src)
                CreateDutyBlips({ pid = player, label = data.label, job = data.job, coords = data.coords, sprite = data.sprite })
            end
        end
    end
end)