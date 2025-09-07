Poly = {
    Data = {},
    ResourceZones = {},

    AddBoxZone = function(pos, height, width, heading, cb)
        local invokingResource = GetInvokingResource() or GetCurrentResourceName()
        local id = "jraxion_lib:" .. math.random(100, 999)

        if Poly.Data[id] then return Poly.AddBoxZone(pos, height, width, heading, cb) end

        Poly.Data[id] = lib.zones.box({
            coords = pos,
            size = vec3(height, width, height),
            rotation = heading,
            debug = Config.Debug,
            onEnter = function(self)
                cb(true, self)
            end,
            onExit = function(self)
                cb(false, self)
            end,
        })

        if not Poly.ResourceZones[invokingResource] then Poly.ResourceZones[invokingResource] = {} end
        Poly.ResourceZones[invokingResource][id] = id


        return id
    end,

    AddCircularZone = function(pos, radius, cb)
        local invokingResource = GetInvokingResource() or GetCurrentResourceName()
        local id = "jraxion_lib:" .. math.random(100, 999)

        if Poly.Data[id] then return Poly.AddCircularZone(pos, radius, cb) end

        Poly.Data[id] = lib.zones.sphere({
            coords = pos,
            radius = radius,
            debug = Config.Debug,
            onEnter = function(self)
                cb(true, self)
            end,
            onExit = function(self)
                cb(false, self)
            end,
        })

        if not Poly.ResourceZones[invokingResource] then Poly.ResourceZones[invokingResource] = {} end
        Poly.ResourceZones[invokingResource][id] = id


        return id
    end,

    AddPolyZone = function(points, cb)
        local invokingResource = GetInvokingResource() or GetCurrentResourceName()
        local id = "jraxion_lib:" .. math.random(100, 999)

        if Poly.Data[id] then return Poly.AddPolyZone(points, cb) end

        for k, v in pairs(points) do
            points[k] = vec3(v.x, v.y, 0.0)
        end

        Poly.Data[id] = lib.zones.poly({
            points = points,
            debug = Config.Debug,
            thickness = 2000,
            onEnter = function(self)
                cb(true, self)
            end,
            onExit = function(self)
                cb(false, self)
            end,
        })

        if not Poly.ResourceZones[invokingResource] then Poly.ResourceZones[invokingResource] = {} end
        Poly.ResourceZones[invokingResource][id] = id


        return id
    end,

    RemoveZone = function(id)
        local invokingResource = GetInvokingResource() or GetCurrentResourceName()
        if not id then return end
        if not Poly.Data[id] then return end
        Poly.Data[id]:remove()

        if Poly.ResourceZones[invokingResource] then
            Poly.ResourceZones[invokingResource][id] = nil
        end
    end,
}

RegisterNetEvent("onResourceStop", function(resName)
    if Poly.ResourceZones[resName] then
        for k, v in pairs(Poly.ResourceZones[resName]) do
            Poly.Data[k]:remove()
        end
    end
end)

return Poly
