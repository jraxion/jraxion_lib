CarKeys = {
    Give = function(veh, plate)
        exports[Config.VehicleKeysResource]:GiveKeys(veh)
    end
}

RegisterNetEvent('jraxion_lib:RemoveVehKeys', function(veh, plate)
    exports[Config.VehicleKeysResource]:RemoveKeys(veh)
end)

return CarKeys