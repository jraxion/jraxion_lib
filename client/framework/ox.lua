Framework = {
    PlayerLoaded = player ~= nil,
    Callbacks = {
        Trigger = function(name, ...)
            return lib.callback.await(name, false, ...)
        end,
        TriggerAsync = function(name, cb, ...)
            cb(lib.callback.await(name, false, ...))
        end
    },

    SpawnVehicle = function(model, pos, cb, networked)
        local result = lib.callback.await('peuren_lib:SpawnVehicle', false, model, pos, 90)
        cb(NetToVeh(result))
    end,
    GetVehicleProperties = function (vehicle)
        return lib.getVehicleProperties(vehicle)
    end,
    SetVehicleProperties = function (vehicle, data)
        return lib.setVehicleProperties(vehicle, data)
    end,
}

AddEventHandler('esx:onPlayerSpawn', function()
    TriggerEvent('peuren_lib:PlayerLoaded')
    Framework.PlayerLoaded = true
end)

return Framework