CarKeys = {
    Give = function(veh, plate)
        exports[Config.VehicleKeysResource]:addKey(plate)
    end
}

RegisterNetEvent('jraxion_lib:RemoveVehKeys', function(veh, plate)
    exports[Config.VehicleKeysResource]:removeKey(plate)
end)

return CarKeys