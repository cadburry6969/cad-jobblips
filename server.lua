local blipPlayers = {}

local function addPlayer(source, label, job)
	local cid = GetPlayerIdentifier(source)
    blipPlayers[cid] = { identifier = cid, src = source, label = label or 'Undefined', job = job or 'unemployed' }
	return blipPlayers[cid]
end
RegisterNetEvent('cad-jobblips:addPlayer', function(label, job)
	local _source = source
	addPlayer(_source, label, job)
end)
exports('AddPlayer', addPlayer)

local function removePlayer(source)
	local cid = GetPlayerIdentifier(source)
	if blipPlayers[cid] then
        blipPlayers[cid] = nil
		Player(source).state:set('duty_blips', nil, true)
		return cid
    end
	return false
end
RegisterNetEvent('cad-jobblips:removePlayer', function()
	local _source = source
	removePlayer(_source)
end)
exports('RemovePlayer', removePlayer)

local function togglePlayer(source, label, job)
	local cid = GetPlayerIdentifier(source)
	if blipPlayers[cid] then
        blipPlayers[cid] = nil
		Player(source).state:set('duty_blips', nil, true)
		return cid
	else
		blipPlayers[cid] = { identifier = cid, src = source, label = label or 'Undefined', job = job or 'unemployed' }
		return blipPlayers[cid]
    end
end
RegisterNetEvent('cad-jobblips:togglePlayer', function(label, job)
	local _source = source
	togglePlayer(_source, label, job)
end)
exports('TogglePlayer', togglePlayer)

function GetBlipPerVehicle(veh)
    local vehType = GetVehicleType(veh)
	return Config.Sprites.Vehicle[vehType] or Config.Sprites.Vehicle['other']
end

AddEventHandler('playerDropped', function()
    local cid = GetPlayerIdentifier(source)
	if blipPlayers[cid] then
		blipPlayers[cid] = nil
	end
end)

CreateThread(function ()
	while true do
		Wait(Config.UpdateInterval)
		if blipPlayers then
			local _blipdata = {}
			for _, _data in pairs(blipPlayers) do
				local _ped = GetPlayerPed(_data.src)
				local _veh = GetVehiclePedIsIn(_ped, false)
				local _sprite = ((_veh~=0) and GetBlipPerVehicle(_veh)) or 1
				local _c = GetEntityCoords(_ped)
				local _w = GetEntityHeading(_ped)
				_blipdata[#_blipdata+1] = { src = _data.src, label = _data.label, job = _data.job, coords = vec4(_c.x, _c.y, _c.z, _w), sprite = _sprite }
				Player(_data.src).state:set('duty_blips', _blipdata, true)
			end
		end
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if resourceName == GetCurrentResourceName() then
		for _, _data in pairs(blipPlayers) do
			Player(_data.src).state:set('duty_blips', nil, true)
		end
	end
end)