Poly = {
    Data = {},
    ResourceZones = {},

    AddBoxZone = function(pos, height, width, heading, cb)
        local invokingResource = GetInvokingResource() or GetCurrentResourceName()
        local id = "jraxion_lib:"..math.random(100, 999)

        if Poly.Data[id] then return Poly.AddBoxZone(pos, height, width, heading, cb) end
        
        Poly.Data[id] = BoxZone:Create(pos, height, width, {
            name = id,
            heading = heading,
            debugPoly = Config.Debug,
            minZ = pos.z - height,
            maxZ = pos.z + height
        })

        Poly.Data[id]:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
            cb(isPointInside, point)
        end)

        if not Poly.ResourceZones[invokingResource] then Poly.ResourceZones[invokingResource] = {} end
        Poly.ResourceZones[invokingResource][id] = id

        return id
    end, 

    AddCircularZone = function(pos, radius, cb)
        local invokingResource = GetInvokingResource() or GetCurrentResourceName()
        local id = "jraxion_lib:"..math.random(100, 999)

        if Poly.Data[id] then return Poly.AddCircularZone(pos, radius, cb) end

        Poly.Data[id] = CircleZone:Create(pos, radius, {
            name = id,
            debugPoly = Config.Debug,
            useZ = true
        })

        Poly.Data[id]:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
            cb(isPointInside, point)
        end)

        if not Poly.ResourceZones[invokingResource] then Poly.ResourceZones[invokingResource] = {} end
        Poly.ResourceZones[invokingResource][id] = id

        return id
    end,

    AddPolyZone = function(points, cb)
        local invokingResource = GetInvokingResource() or GetCurrentResourceName()
        local id = "jraxion_lib:"..math.random(100, 999)

        if Poly.Data[id] then return Poly.AddPolyZone(points, cb) end

        Poly.Data[id] = PolyZone:Create(points, {
            name = id,
            debugGrid = Config.Debug,
        })

        Poly.Data[id]:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
            cb(isPointInside, point)
        end)

        if not Poly.ResourceZones[invokingResource] then Poly.ResourceZones[invokingResource] = {} end
        Poly.ResourceZones[invokingResource][id] = id

        return id
    end,

    RemoveZone = function(id)
        local invokingResource = GetInvokingResource() or GetCurrentResourceName()
        if not id then return end 
        if not Poly.Data[id] then return end 
        Poly.Data[id]:destroy()

        if Poly.ResourceZones[invokingResource] then
            Poly.ResourceZones[invokingResource][id] = nil
        end
    end,
}

RegisterNetEvent("onResourceStop", function(resName)
    if Poly.ResourceZones[resName] then
        for k, v in pairs(Poly.ResourceZones[resName]) do
            Poly.Data[k]:destroy() 
        end
    end
end)

return Poly