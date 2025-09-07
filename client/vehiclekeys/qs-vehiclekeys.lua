CarKeys = {
    Give = function(veh, plate)
        local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
        exports[Config.VehicleKeysResource]:GiveKeys(plate, model, true)
    end
}

RegisterNetEvent('jraxion_lib:RemoveVehKeys', function(veh, plate)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
    exports[Config.VehicleKeysResource]:RemoveKeys(plate, model)
end)

return CarKeys