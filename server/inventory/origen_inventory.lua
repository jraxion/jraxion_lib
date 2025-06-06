Inventory = {
    AddItem = function(source, item, amount, metadata) 
        return exports[Config.InventoryResource]:AddItem(source, item, amount, nil, nil, metadata)
    end,
    RemoveItem = function(source, item, amount, metadata)
        return exports[Config.InventoryResource]:RemoveItem(source, item, amount, nil, metadata)
    end,
    CanCarryItem = function(source, item, amount)
        return exports[Config.InventoryResource]:canCarryItem(source, item, amount)
    end,
    GetItem = function(source, item, metadata)
        local itemData = exports[Config.InventoryResource]:GetItem(source, item, metadata, true)
        if not itemData then return nil end
        return {
            item = itemData.name,
            count = itemData.count,
            metadata = itemData.metadata,
        }
    end,
    GetItems = function(source)
        local data = exports[Config.InventoryResource]:GetInventory(source)
        if not data then return {} end

        local formattedItems = {}
        for k, v in pairs(data.inventory) do
            if v.name then
                formattedItems[#formattedItems+1] = {
                    item = v.name,
                    count = v.amount,
                    metadata = v.metadata,
                }
            end
        end
        return formattedItems
    end,
    HasPlayerItem = function(source, item, count)
        return exports[Config.InventoryResource]:HasItem(source, item, amount)
    end,
    RegisterUsableItem = function(item, callback)
        exports[Config.InventoryResource]:CreateUsableItem(item, callback)
    end
}

Core.Framework.RegisterCallback("peuren_lib:GetPlayerInventory", function(player, cb)
    cb(Inventory.GetItems(player))
end)

Core.Framework.RegisterCallback("peuren_lib:inventory:RegisterStash", function(player, cb, data)
    exports[Config.InventoryResource]:RegisterStash(data.stashName, {
        label = data.stashName,
        slots = data.slots,
        weight = data.weight
    })
    cb(true)
end)

return Inventory