CarKeys = {
    Give = function(veh, plate)
        exports[Config.VehicleKeysResource]:GiveKey(plate, false)
    end
}

RegisterNetEvent('peuren_lib:RemoveVehKeys', function(veh, plate)
    exports[Config.VehicleKeysResource]:RemoveKey(plate, false)
end)

return CarKeys