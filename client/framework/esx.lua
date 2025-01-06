ESX = nil

if Config.IsOldESX then 
    CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) 
                ESX = obj 
            end)
            Citizen.Wait(0)
        end
    end)
else 
    ESX = exports[Config.FrameworkResource]:getSharedObject()
end

Framework = {
    PlayerLoaded = ESX.IsPlayerLoaded(),
    Callbacks = {
        Trigger = function(name, ...)
            local p = promise:new()
            ESX.TriggerServerCallback(name, function(...)
                p:resolve(...)
            end, ...)
            return Citizen.Await(p)
        end,
        TriggerAsync = function(name, cb, ...)
            ESX.TriggerServerCallback(name, cb, ...)
        end
    },

    SpawnVehicle = function(model, pos, cb, networked)
        ESX.Game.SpawnVehicle(model, pos, heading, cb, networked)
    end,
    GetVehicleProperties = function (vehicle)
        return ESX.Game.GetVehicleProperties(vehicle)
    end,
    SetVehicleProperties = function (vehicle, data)
        return ESX.Game.SetVehicleProperties(vehicle, data)
    end,
}

AddEventHandler('esx:onPlayerSpawn', function()
    TriggerEvent('peuren_lib:PlayerLoaded')
    Framework.PlayerLoaded = true
end)

return Framework