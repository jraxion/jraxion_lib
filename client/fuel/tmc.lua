Fuel = {
    GetFuel = function(veh, plate)
        if not veh or not plate then return 0 end
        return Entity(veh).state.fuel
    end,

    SetFuel = function(veh, plate, level)
        Entity(veh).state.fuel = level
    end
}

return Fuel