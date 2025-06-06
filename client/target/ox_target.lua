function TransformOnSelect(callback)
    return function(data)
        callback(data?.entity)
    end
end

Target = {
    Zones = {},

    AddEntity = function(entities, options, distance)
        if type(entities) == 'table' then
            for k,v in pairs(entities) do 
                if not DoesEntityExist(v) and NetworkDoesEntityExistWithNetworkId(v) then
                    entities[k] = NetworkGetEntityFromNetworkId(v)
                end
            end
        else 
            if not DoesEntityExist(entities) and NetworkDoesEntityExistWithNetworkId(entities) then 
                entities = NetworkGetEntityFromNetworkId(entities)
            end
        end

        local tOptions = {}
        for k, v in pairs(options) do
            tOptions[#tOptions + 1] = {
                name = v.name,
                icon = v.icon,
                label = v.label,
                items = v.item,
                canInteract = v.canInteract,
                onSelect = TransformOnSelect(v.onSelect),
                distance = distance,
                groups = v.jobs,
            }
        end
        return exports[Config.TargetResource]:addLocalEntity(entities, tOptions)
    end,
    AddNetworkedEntity = function(netId, options, distance)
        local tOptions = {}
        for k, v in pairs(options) do
            tOptions[#tOptions + 1] = {
                name = v.name,
                icon = v.icon,
                label = v.label,
                items = v.item,
                canInteract = v.canInteract,
                onSelect = TransformOnSelect(v.onSelect),
                distance = distance,
                groups = v.jobs,
            }
        end

        return exports.ox_target:addEntity(netId, tOptions)
    end,
    AddBone = function(bones, options, distance)
        local tOptions = {}
        for k, v in pairs(options) do
            tOptions[#tOptions + 1] = {
                name = v.name,
                icon = v.icon,
                label = v.label,
                items = v.item,
                canInteract = v.canInteract,
                onSelect = TransformOnSelect(v.onSelect),
                bones = v.bones,
                distance = distance,
                groups = v.jobs,
            }
        end
        return exports[Config.TargetResource]:addGlobalVehicle(tOptions)
    end,
    AddModel = function(models, options, distance)
        local tOptions = {}
        for k, v in pairs(options) do
            tOptions[#tOptions + 1] = {
                name = v.name,
                icon = v.icon,
                label = v.label,
                items = v.item,
                canInteract = v.canInteract,
                onSelect = TransformOnSelect(v.onSelect),
                distance = distance,
                groups = v.jobs,
            }
        end
        return exports[Config.TargetResource]:addModel(models, tOptions)
    end,
    AddBoxZone = function(boxData, options, distance)
        local tOptions = {}
        for k, v in pairs(options) do
            tOptions[#tOptions + 1] = {
                name = v.name,
                icon = v.icon,
                label = v.label,
                items = v.item,
                canInteract = v.canInteract,
                onSelect = TransformOnSelect(v.onSelect),
                distance = distance,
                groups = v.jobs,
            }
        end

        local id = exports[Config.TargetResource]:addBoxZone({
            name = boxData.name,
            coords = vector3(boxData.coords.x, boxData.coords.y, boxData.coords.z + boxData.size.z / 2),
            size = vector3(boxData.size.y, boxData.size.x, boxData.size.z),
            rotation = boxData.heading,
            options = tOptions,
            debug = Config.Debug,
            resource = GetInvokingResource(),
            drawSprite = Config.Debug
        })

        Target.Zones[id] = true
        return id
    end,
    AddPlayer = function(options, distance)
        local tOptions = {}
        for k, v in pairs(options) do
            tOptions[#tOptions + 1] = {
                name = v.name,
                icon = v.icon,
                label = v.label,
                items = v.item,
                canInteract = v.canInteract,
                onSelect = TransformOnSelect(v.onSelect),
                distance = distance,
                groups = v.jobs,
            }
        end

        return exports[Config.TargetResource]:addGlobalPlayer(tOptions)
    end,
    AddVehicle = function(options, distance)
        local tOptions = {}
        for k, v in pairs(options) do
            tOptions[#tOptions + 1] = {
                name = v.name,
                icon = v.icon,
                label = v.label,
                items = v.item,
                canInteract = v.canInteract,
                onSelect = TransformOnSelect(v.onSelect),
                distance = distance,
                groups = v.jobs,
            }
        end

        return exports[Config.TargetResource]:addGlobalVehicle(tOptions)
    end,
    RemoveZone = function(data)
        if not Target.Zones[data] then return end
        exports[Config.TargetResource]:removeZone(data)
        Target.Zones[data] = nil
    end,
    RemoveEntityZone = function(entities, names)
        if type(entities) == 'table' then
            for k,v in pairs(entities) do 
                if not DoesEntityExist(v) and NetworkDoesEntityExistWithNetworkId(v) then
                    entities[k] = NetworkGetEntityFromNetworkId(v)
                end
            end
        else 
            if not DoesEntityExist(entities) and NetworkDoesEntityExistWithNetworkId(entities) then 
                entities = NetworkGetEntityFromNetworkId(entities)
            end
        end        
        exports[Config.TargetResource]:removeLocalEntity(entities, names)
    end,
    RemoveBone = function(bones, names)
        exports[Config.TargetResource]:removeGlobalVehicle(bones)
    end,
    RemovePlayer = function(names) 
        exports[Config.TargetResource]:removeGlobalPlayer(names)
    end,
    RemoveVehicle = function(names)
        exports[Config.TargetResource]:removeGlobalVehicle(names)
    end
}

return Target