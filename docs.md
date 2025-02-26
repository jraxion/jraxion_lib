# CB_LIB Documentation

CB_LIB is a compatibility layer that provides a unified API for interacting with various FiveM resources. This documentation covers the main components of the library.

## Table of Contents
- [Framework](#framework)
- [Inventory](#inventory)
- [Target](#target)
- [TextUI](#textui)
- [Notifications](#notifications)
- [Clothing](#clothing)
- [Dispatch](#dispatch)
- [Fuel](#fuel)

## Framework

The Framework module provides a consistent way to interact with different framework resources (ESX, QBCore, QBX, ox).

### Usage

```lua
-- Check if player is loaded
if Framework.PlayerLoaded then
    -- Player is loaded
end

-- Trigger a callback
local result = Framework.Callbacks.Trigger('callback_name', arg1, arg2)

-- Trigger a callback asynchronously
Framework.Callbacks.TriggerAsync('callback_name', function(result)
    -- Handle result
end, arg1, arg2)

-- Spawn a vehicle
Framework.SpawnVehicle('vehicle_model', vector4(x, y, z, h), function(vehicle)
    -- Do something with the vehicle
end, networked)

-- Get vehicle properties
local properties = Framework.GetVehicleProperties(vehicle)

-- Set vehicle properties
Framework.SetVehicleProperties(vehicle, properties)
```

### Events

- `peuren_lib:PlayerLoaded` - Triggered when the player is loaded
- `cb_lib:PlayerLoaded` - Alternative event name for player loaded (for QBCore)

### Supported Frameworks

- ESX (Legacy and older versions)
- QBCore
- QBX
- ox_core

### Framework Detection

The library automatically detects which framework is being used based on the configuration in `config.lua`. You don't need to modify your code when switching between frameworks.

## Inventory

The Inventory module provides a unified way to interact with different inventory systems.

### Usage

```lua
-- Check if player has an item
local hasItem = Inventory.HasItem('item_name', amount)

-- Get item count
local count = Inventory.GetItemCount('item_name')

-- Add item to inventory
Inventory.AddItem('item_name', amount, metadata)

-- Remove item from inventory
Inventory.RemoveItem('item_name', amount, metadata)

-- Get inventory items
local items = Inventory.GetItems()

-- Check item weight
local weight = Inventory.GetItemWeight('item_name')

-- Check if inventory can carry item
local canCarry = Inventory.CanCarryItem('item_name', amount)

-- Check if inventory can carry weight
local canCarryWeight = Inventory.CanCarryWeight(weight)
```

### Supported Inventory Systems

- ESX Inventory
- QBCore Inventory
- ox_inventory
- qs-inventory
- mf-inventory
- core_inventory

### Item Metadata

When using inventory systems that support metadata (like ox_inventory), you can pass metadata as the third parameter to AddItem and RemoveItem functions:

```lua
-- Add item with metadata
Inventory.AddItem('phone', 1, {number = '555-123-4567'})

-- Remove specific item with metadata
Inventory.RemoveItem('phone', 1, {number = '555-123-4567'})
```

## Target

The Target module provides a unified way to interact with different targeting systems.

### Usage

```lua
-- Add a target to a model
Target.AddTargetModel('model_name', {
    options = {
        {
            label = 'Option Label',
            icon = 'fas fa-icon',
            action = function(entity)
                -- Do something with the entity
            end,
            canInteract = function(entity)
                -- Return true if player can interact with entity
                return true
            end
        }
    },
    distance = 2.5
})

-- Add a target to an entity
Target.AddTargetEntity(entity, {
    options = {
        {
            label = 'Option Label',
            icon = 'fas fa-icon',
            action = function(entity)
                -- Do something with the entity
            end,
            canInteract = function(entity)
                -- Return true if player can interact with entity
                return true
            end
        }
    },
    distance = 2.5
})

-- Add a target to a zone
Target.AddBoxZone('zone_name', vector3(x, y, z), length, width, {
    name = 'zone_name',
    heading = heading,
    debugPoly = false,
    minZ = minZ,
    maxZ = maxZ
}, {
    options = {
        {
            label = 'Option Label',
            icon = 'fas fa-icon',
            action = function()
                -- Do something
            end,
            canInteract = function()
                -- Return true if player can interact
                return true
            end
        }
    },
    distance = 2.5
})

-- Remove a target
Target.RemoveZone('zone_name')
```

### Supported Target Systems

- qtarget
- qb-target
- ox_target
- bt-target

### Zone Types

In addition to box zones, the Target module also supports:

```lua
-- Add a sphere zone
Target.AddSphereZone('zone_name', vector3(x, y, z), radius, {
    name = 'zone_name',
    debugPoly = false
}, {
    options = {...},
    distance = 2.5
})

-- Add a circle zone
Target.AddCircleZone('zone_name', vector3(x, y, z), radius, {
    name = 'zone_name',
    debugPoly = false
}, {
    options = {...},
    distance = 2.5
})

-- Add a poly zone
Target.AddPolyZone('zone_name', points, {
    name = 'zone_name',
    minZ = minZ,
    maxZ = maxZ,
    debugPoly = false
}, {
    options = {...},
    distance = 2.5
})
```

## TextUI

The TextUI module provides a unified way to display text UI elements.

### Usage

```lua
-- Show text UI
TextUI.Show('Message to display', 'info')

-- Hide text UI
TextUI.Hide()
```

### Supported TextUI Systems

- ESX TextUI
- QBCore DrawText
- ox_lib
- okokTextUI
- mythic_notify

### TextUI Types

The second parameter of the Show function specifies the type of notification:

- `'info'` - Information message (default, blue)
- `'success'` - Success message (green)
- `'error'` - Error message (red)
- `'warning'` - Warning message (yellow)

Example:
```lua
-- Show success message
TextUI.Show('Item added to inventory', 'success')

-- Show error message
TextUI.Show('Not enough money', 'error')
```

## Notifications

The Notifications module provides a unified way to display notifications.

### Usage

```lua
-- Show a notification
Notifications.Show('Message to display', 'info', 5000)

-- Show an advanced notification
Notifications.Advanced('Title', 'Message', 'info', 5000)
```

### Supported Notification Systems

- ESX Notifications
- QBCore Notifications
- ox_lib
- okokNotify
- mythic_notify
- t-notify
- codem-notification

### Notification Types

The second parameter of the Show function specifies the type of notification:

- `'info'` - Information notification (default, blue)
- `'success'` - Success notification (green)
- `'error'` - Error notification (red)
- `'warning'` - Warning notification (yellow)

### Duration

The third parameter specifies the duration in milliseconds for which the notification will be displayed. If not provided, a default duration (usually 5000ms) will be used.

Example:
```lua
-- Show success notification for 3 seconds
Notifications.Show('Item purchased successfully', 'success', 3000)

-- Show error notification for 5 seconds
Notifications.Show('Transaction failed', 'error', 5000)
```

## Clothing

The Clothing module provides a unified way to interact with different clothing systems.

### Usage

```lua
-- Set clothing
Clothing.Set({
    tshirt_1 = 1,
    tshirt_2 = 0,
    arms = 0,
    torso_1 = 0,
    torso_2 = 0,
    pants_1 = 0,
    pants_2 = 0,
    shoes_1 = 0,
    shoes_2 = 0,
    chain_1 = 0,
    chain_2 = 0,
    glasses_1 = 0,
    glasses_2 = 0,
    ears_1 = 0,
    ears_2 = 0,
    decals_1 = 0,
    decals_2 = 0
})

-- Reset clothing
Clothing.Reset()
```

## Dispatch

The Dispatch module provides a unified way to interact with different dispatch systems.

### Usage

```lua
-- Send a dispatch alert
Dispatch({
    pos = vector3(x, y, z),
    message = 'Alert message',
    dispatch_code = '10-90',
    time = 60, -- seconds
    sprite = 161,
    color = 1,
    scale = 1.0,
    police_jobs = {'police', 'sheriff'}
})
```

## Fuel

The Fuel module provides a unified way to interact with different fuel systems.

### Usage

```lua
-- Get vehicle fuel
local fuel = Fuel.GetFuel(vehicle, plate)

-- Set vehicle fuel
Fuel.SetFuel(vehicle, plate, level)
```
