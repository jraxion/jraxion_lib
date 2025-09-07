# jraxion_lib Documentation

jraxion_lib is a compatibility layer that provides a unified API for interacting with various FiveM resources. This documentation covers the main components of the library.

## Table of Contents
- [Framework](#framework)
- [Inventory](#inventory)
- [Target](#target)
- [TextUI](#textui)
- [Notifications](#notifications)
- [Clothing](#clothing)
- [Dispatch](#dispatch)
- [Fuel](#fuel)
- [VehicleKeys](#vehiclekeys)
- [ProgressBar](#progressbar)
- [Menu](#menu)
- [Input](#input)
- [Poly](#poly)
- [Weather](#weather)
- [Database](#database)
- [Groups](#groups)
- [Math](#math)
- [Utils](#utils)
- [Callbacks](#callbacks)
- [Configuration](#configuration)

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

- `jraxion_lib:PlayerLoaded` - Triggered when the player is loaded
- `jraxion_lib:PlayerLoaded` - Alternative event name for player loaded (for QBCore)

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
- peuren_notify
- ps-ui
- s1n_notify
- tgiann
- k5_notify
- vms_notifyv2

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

### Clothing Functions

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

### Supported Clothing Systems

- crm-appearance
- codem-appearance
- tgiann-clothing
- esx_skin
- fivem-appearance
- illenium-appearance
- ox_appearance
- qb-clothing
- rcore_clothing

## Dispatch

The Dispatch module provides a unified way to send dispatch alerts.

### Dispatch Function

```lua
-- Send dispatch alert
Core.Dispatch({
    pos = vector3(x, y, z),
    message = 'Alert message',
    dispatch_code = '10-90',
    time = 60,  -- seconds
    sprite = 161,
    color = 1,
    scale = 1.0,
    police_jobs = {'police', 'sheriff'}
})
```

### Supported Dispatch Systems

- fea-dispatch
- origen_police
- rcore_dispatch
- cd_dispatch
- core_dispatch
- default
- outwalter
- ps-dispatch
- qs-dispatch
- tk_dispatch
- redutzu-mdt
- codem_dispatch

## Fuel

The Fuel module provides a unified way to interact with different fuel systems.

### Fuel Functions

```lua
-- Get vehicle fuel
local fuel = Core.Fuel.GetFuel(vehicle, plate)

-- Set vehicle fuel
Core.Fuel.SetFuel(vehicle, plate, level)
```

### Supported Fuel Systems

- okokGasStation
- LegacyFuel
- ox_fuel
- lj-fuel
- ti_fuel
- ND_fuel
- ps-fuel
- esx-sna-fuel
- cdn-fuel
- FRFuel
- renewed-fuel
- xFuel
- rcore_fuel
- qs-fuelstations
- lc_fuel
- sgx-fuel

## VehicleKeys

The VehicleKeys module provides a unified way to interact with different vehicle key systems.

### VehicleKeys Functions

```lua
-- Give vehicle keys
Core.VehicleKeys.Give(vehicle, plate)

-- Remove vehicle keys (some systems)
TriggerEvent('jraxion_lib:RemoveVehKeys', vehicle, plate)
```

### Supported Vehicle Key Systems

- MrNewbVehicleKeys
- mk_vehiclekeys
- okokGarage
- qs-vehiclekeys
- wasabi_carlock
- cd_garage
- t1ger_keys
- F_RealCarKeysSystem
- fivecode_carkeys
- qb-vehiclekeys
- stasiek_vehiclekeys
- ti_vehicleKeys
- vehicles_keys
- xd_locksystem
- tgiann-hotwire
- dusa_vehiclekeys
- Renewed-Vehiclekeys
- ak47_vehiclekeys

## ProgressBar

The ProgressBar module provides a unified way to display progress bars.

### ProgressBar Function

```lua
-- Show progress bar
local success = Core.ProgressBar('Loading...', 5000, {
    useWhileDead = false,
    canCancel = true,
    disableCarMovement = true,
    disableMovement = false,
    disableMouse = false,
    disableCombat = true,
    animation = {
        animDict = 'anim_dict',
        anim = 'anim_name',
        flags = 49
    }
})

if success then
    -- Progress completed
else
    -- Progress cancelled
end
```

### Supported Progress Bar Systems

- ox_lib
- qb
- tgiann

## Menu

The Menu module provides a unified way to display context menus.

### Menu Function

```lua
-- Show menu
Core.Menu('Menu Title', {
    {
        title = 'Option 1',
        description = 'Description',
        icon = 'fas fa-icon',
        metadata = {'Info 1', 'Info 2'},
        event = 'client_event',
        args = {arg1, arg2},
        disabled = false,
        onSelect = function()
            -- Custom select logic
        end
    },
    {
        title = 'Server Option',
        description = 'Server action',
        isServer = true,
        serverEvent = 'server_event',
        args = {arg1, arg2}
    }
})
```

### Supported Menu Systems

- ox_lib
- ps-ui
- qb
- nh-context
- esx_menu_default
- esx_context

## Input

The Input module provides a unified way to get user input.

### Input Function

```lua
-- Show input dialog
local result = Core.Input('Input Title', {
    {
        type = 'input',
        label = 'Text Input',
        name = 'text_field',
        default = 'Default value'
    },
    {
        type = 'number',
        label = 'Number Input',
        name = 'number_field',
        default = 0
    },
    {
        type = 'checkbox',
        label = 'Checkbox',
        name = 'checkbox_field',
        default = false
    },
    {
        type = 'select',
        label = 'Select Option',
        name = 'select_field',
        options = {
            { value = 'option1', text = 'Option 1' },
            { value = 'option2', text = 'Option 2' }
        }
    }
})

if result then
    local text = result.text_field
    local number = result.number_field
    local checkbox = result.checkbox_field
    local select = result.select_field
end
```

### Supported Input Systems

- ox_lib
- qb-input
- nh-keyboard
- ps-ui

## Poly

The Poly module provides a unified way to create and manage zones.

### Poly Functions

```lua
-- Add box zone
local zoneId = Poly.AddBoxZone(vector3(x, y, z), height, width, heading, function(entering, zone)
    if entering then
        -- Player entered zone
    else
        -- Player left zone
    end
end)

-- Add circular zone
local zoneId = Poly.AddCircularZone(vector3(x, y, z), radius, function(entering, zone)
    -- Zone logic
end)

-- Add poly zone
local zoneId = Poly.AddPolyZone(points, function(entering, zone)
    -- Zone logic
end)

-- Remove zone
Poly.RemoveZone(zoneId)
```

### Supported Polyzone Systems

- ox_lib
- polyzone

## Weather

The Weather module provides a unified way to interact with weather sync systems.

### Weather Functions

```lua
-- Enable weather sync
Core.Weather.Enable()

-- Disable weather sync
Core.Weather.Disable()
```

### Supported Weather Systems

- renewed-weathersync
- qb-weathersync
- cd_easytime

## Database

The Database module provides a unified way to interact with different database systems.

### Database Functions

```lua
-- Fetch data synchronously
local result = Core.Database.FetchSync('SELECT * FROM table WHERE id = ?', {id})

-- Execute query synchronously
Core.Database.ExecuteSync('UPDATE table SET column = ? WHERE id = ?', {value, id})

-- Insert data asynchronously
Core.Database.Insert('INSERT INTO table (column) VALUES (?)', {value}, function(result)
    -- Handle result
end)

-- Execute query asynchronously
Core.Database.Execute('UPDATE table SET column = ? WHERE id = ?', {value, id}, function(result)
    -- Handle result
end)
```

### Supported Database Systems

- oxmysql
- mysql-async
- ghmattimysql

## Groups

The Groups module provides a comprehensive group management system for multiplayer activities.

### Server-Side Groups Functions

```lua
-- Create a group
local group = Groups.Set(source, {
    name = 'Group Name',
    maxMembers = 4,
    -- Additional group data
})

-- Get group
local group = Groups.Get(source, groupId)

-- Update group
local updatedGroup = Groups.Update(source, groupId, newData)

-- Get group member
local member = Groups.GetMember(source, groupId)

-- Get job groups
local jobGroups = Groups.GetJobGroups()

-- Remove group
Groups.Remove(source, groupId)

-- Add member to group
local result = Groups.AddMember(source, groupId, password)
-- Returns: group data, 'wrong_pass', 'full', or nil

-- Remove member from group
Groups.RemoveMember(source, groupId)

-- Check if player is in any group
local inGroup = Groups.IsPlayerInGroup(source)

-- Send event to all group members
Groups.SendEvent(source, groupId, 'event_name', data)

-- Handle member disconnection
Groups.MemberDisconnected(source)

-- Create password
local password = Groups.CreatePassword()

-- Create group ID
local groupId = Groups.CreateGroupId()
```

### Client-Side Groups Functions

```lua
-- Create blip for group
RegisterNetEvent('jraxion_lib:Groups:CreateBlip', function(name, data)
    -- Blip creation logic
end)

-- Remove blip
RegisterNetEvent('jraxion_lib:Groups:RemoveBlip', function(name)
    -- Blip removal logic
end)
```

### Group Events

```lua
-- Client events
'resource:group:MemberAdded'     -- Member added to group
'resource:group:MemberRemoved'   -- Member removed from group
'resource:group:Updated'         -- Group updated
'resource:group:Deleted'         -- Group deleted
'jraxion_lib:group:OwnerChanged' -- Group owner changed
```

### Group Configuration

```lua
Config.Groups = {
    MemberLimit = 4,       -- Maximum group member amount
    Timeout = { 
        min = 0, 
        sec = 10 
    },                     -- Time before assigning new group leader
    password = {
        type = 'number',   -- 'number' or 'char'
        length = 6         -- Password length
    }
}
```

## Math

The Math module provides utility functions for common mathematical operations.

### Math Functions

```lua
-- Generate random string
local randomStr = Core.Math.RandomStr(length)

-- Generate random integer string
local randomInt = Core.Math.RandomInt(length)

-- Split string
local parts = Core.Math.SplitStr('hello,world', ',')

-- Trim string
local trimmed = Core.Math.Trim('  hello  ')

-- Capitalize first letter
local capitalized = Core.Math.FirstToUpper('hello')

-- Round number
local rounded = Core.Math.Round(3.14159, 2)

-- Get vehicle plate
local plate = Core.Math.GetPlate(vehicle)
```

## Utils

The Utils module provides utility functions.

### Utils Functions

```lua
-- Compare tables
local areEqual = Utils.CompareTables(table1, table2)

-- Debug print (only if Config.Debug is true)
Utils.Print('Debug message')
```

## Callbacks

The library provides several built-in callbacks for common operations.

### Built-in Callbacks

#### `jraxion_lib:GetSkillData`
Returns skill data for supported skill systems.

```lua
-- Client-side usage
local skillData = Core.Framework.Callbacks.Trigger('jraxion_lib:GetSkillData')

-- Returns array of skill data:
-- {
--     { locale = "peuren_fishing", xp = 100, level = 5 },
--     { locale = "peuren_burglary_hacking", xp = 50, level = 3 },
--     { locale = "peuren_burglary_lockpicking", xp = 75, level = 4 },
--     { locale = "peuren_burglary_looting", xp = 25, level = 2 }
-- }
```

#### `jraxion_lib:GetPlayerInventory`
Returns the player's current inventory items.

```lua
-- Client-side usage
local inventory = Core.Framework.Callbacks.Trigger('jraxion_lib:GetPlayerInventory')

-- Returns array of inventory items
```

#### `jraxion_lib:inventory:RegisterStash`
Registers a stash with the inventory system.

```lua
-- Client-side usage
local response = Core.Framework.Callbacks.Trigger('jraxion_lib:inventory:RegisterStash', {
    stashName = 'stash_name',
    slots = 50,
    weight = 100000
})
```

#### `jraxion_lib:SpawnVehicle`
Spawns a vehicle and returns the network ID.

```lua
-- Client-side usage (QBCore/QBX)
local result = Core.Framework.Callbacks.Trigger('jraxion_lib:SpawnVehicle', model, pos, 90)
local vehicle = NetToVeh(result)

-- Client-side usage (ox_core)
local result = Core.Framework.Callbacks.Trigger('jraxion_lib:SpawnVehicle', model, pos)
local vehicle = NetToVeh(result)
```

### Framework-Specific Callbacks

#### ESX Framework
```lua
-- Register callback
ESX.RegisterServerCallback('callback_name', function(source, cb, ...)
    -- Callback logic
    cb(result)
end)

-- Trigger callback (client)
ESX.TriggerServerCallback('callback_name', function(result)
    -- Handle result
end, ...)
```

#### QBCore Framework
```lua
-- Register callback
QBCore.Functions.CreateCallback('callback_name', function(source, cb, ...)
    -- Callback logic
    cb(result)
end)

-- Trigger callback (client)
QBCore.Functions.TriggerCallback('callback_name', function(result)
    -- Handle result
end, ...)
```

#### QBX Framework
```lua
-- Register callback
lib.callback.register('callback_name', function(source, ...)
    -- Callback logic
    return result
end)

-- Trigger callback (client)
local result = lib.callback.await('callback_name', false, ...)
```

#### ox_core Framework
```lua
-- Register callback
lib.callback.register('callback_name', function(source, ...)
    -- Callback logic
    return result
end)

-- Trigger callback (client)
local result = lib.callback.await('callback_name', false, ...)
```

## Configuration

The library uses a comprehensive configuration system to support multiple resources.

### Main Configuration Options

```lua
Config = {
    Debug = false,                    -- Enable debug mode
    Language = 'en',                  -- Default language
    Framework = "qbx",               -- Framework to use
    IsOldESX = false,                -- For older ESX versions
    FrameworkResource = "qb-core",   -- Framework resource name
    
    -- Supported frameworks: "esx", "qbx", "ox"
    
    SQLConnector = "oxmysql",        -- Database connector
    -- Supported: "oxmysql", "mysql-async", "ghmattimysql"
    
    Inventory = "ox_inventory",      -- Inventory system
    InventoryResource = 'ox_inventory',
    CarryItemsEnabled = true,        -- Enable carry items system
    
    Target = "ox_target",            -- Targeting system
    TargetResource = 'ox_target',
    
    ProgessBar = 'ox_lib',          -- Progress bar system
    Menu = 'ox_lib',                -- Menu system
    Input = 'ox_lib',               -- Input system
    TextUI = "ox_lib",              -- TextUI system
    Poly = "ox_lib",                -- Polyzone system
    Notifications = "ox_lib",       -- Notification system
    WeatherSync = 'qb-weathersync', -- Weather sync system
    Dispatch = 'cd_dispatch',       -- Dispatch system
    Fuel = 'LegacyFuel',            -- Fuel system
    VehicleKeys = 'qb-vehiclekeys', -- Vehicle keys system
    Clothing = 'qb-clothing',       -- Clothing system
}
```

### Skill Menu Configuration

```lua
Config.SkillMenu = {
    Enabled = true,        -- Should the Skill Menu be enabled
    Command = "skills"     -- Command to open skill menu (set to false to disable)
}
```

### Groups Configuration

```lua
Config.Groups = {
    MemberLimit = 4,       -- Maximum group member amount
    Timeout = { 
        min = 0, 
        sec = 10 
    },                     -- Time before assigning new group leader
    password = {
        type = 'number',   -- 'number' or 'char'
        length = 6         -- Password length
    }
}
```

### Supported Resources

The library supports a wide range of FiveM resources:

#### Frameworks
- ESX (Legacy and newer versions)
- QBCore
- QBX
- ox_core

#### Inventory Systems
- ox_inventory
- qb-inventory
- qb-inventory-new
- esx_inventory
- mf-inventory
- qs-inventory
- tgiann-inventory
- codem-inventory
- origen_inventory
- avp_inv_4

#### Targeting Systems
- ox_target
- qb-target
- qtarget

#### UI Systems
- ox_lib
- ps-ui
- qb
- okokTextUI
- jg-textui
- mythic_notify
- okokNotify
- s1n_notify
- tgiann
- k5_notify
- vms_notifyv2

#### Progress Bar Systems
- ox_lib
- qb
- tgiann

#### Menu Systems
- ox_lib
- ps-ui
- qb
- nh-context
- esx_menu_default
- esx_context

#### Input Systems
- ox_lib
- qb-input
- nh-keyboard

#### Polyzone Systems
- ox_lib
- polyzone

#### Weather Systems
- renewed-weathersync
- qb-weathersync
- cd_easytime

#### Dispatch Systems
- fea-dispatch
- origen_police
- rcore_dispatch
- cd_dispatch
- core_dispatch
- default
- outwalter
- ps-dispatch
- qs-dispatch
- tk_dispatch
- redutzu-mdt
- codem_dispatch

#### Fuel Systems
- okokGasStation
- LegacyFuel
- ox_fuel
- lj-fuel
- ti_fuel
- ND_fuel
- ps-fuel
- esx-sna-fuel
- cdn-fuel
- FRFuel
- renewed-fuel
- xFuel
- rcore_fuel
- qs-fuelstations
- lc_fuel
- sgx-fuel

#### Vehicle Key Systems
- MrNewbVehicleKeys
- mk_vehiclekeys
- okokGarage
- qs-vehiclekeys
- wasabi_carlock
- cd_garage
- t1ger_keys
- F_RealCarKeysSystem
- fivecode_carkeys
- qb-vehiclekeys
- stasiek_vehiclekeys
- ti_vehicleKeys
- vehicles_keys
- xd_locksystem
- tgiann-hotwire
- dusa_vehiclekeys
- Renewed-Vehiclekeys
- ak47_vehiclekeys

#### Clothing Systems
- crm-appearance
- codem-appearance
- tgiann-clothing
- esx_skin
- fivem-appearance
- illenium-appearance
- ox_appearance
- qb-clothing
- rcore_clothing

#### Database Systems
- oxmysql
- mysql-async
- ghmattimysql

## Events

### Client Events

```lua
-- Player loaded
'jraxion_lib:PlayerLoaded'

-- Item events
'jraxion_lib:AddedItem'
'jraxion_lib:RemovedItem'

-- Notification
'jraxion_lib:notify'

-- Group events
'jraxion_lib:Groups:CreateBlip'
'jraxion_lib:Groups:RemoveBlip'

-- Dispatch events
'jraxion_lib:SendDispatchAlert'
'fea-dispatch:peuren:alert'
```

### Server Events

```lua
-- Callbacks
'jraxion_lib:GetPlayerInventory'
'jraxion_lib:inventory:RegisterStash'
'jraxion_lib:GetSkillData'
'jraxion_lib:SpawnVehicle'

-- Vehicle keys
'jraxion_lib:RemoveVehKeys'
```

## Exports

### Client Exports

```lua
-- Get core library
local Core = exports['jraxion_lib']:Core()

-- Carry items exports
exports['jraxion_lib']:GetCarryItem()
exports['jraxion_lib']:RemoveCarryItem(item)
exports['jraxion_lib']:AddCarryItem(item)

-- Skill menu export
exports['jraxion_lib']:OpenSkillMenu()
```

### Server Exports

```lua
-- Get core library
local Core = exports['jraxion_lib']:Core()
```

## Usage Examples

### Basic Setup

```lua
-- Client-side
local Core = exports['jraxion_lib']:Core()

-- Wait for player to load
while not Core.Framework.PlayerLoaded do
    Wait(100)
end

-- Show notification
Core.Notify('Welcome', 'You have joined the server!', 'success')

-- Add target to a vehicle
Core.Target.AddVehicle({
    {
        name = 'lock_vehicle',
        icon = 'fas fa-lock',
        label = 'Lock Vehicle',
        onSelect = function()
            -- Lock vehicle logic
        end
    }
}, 2.5)
```

### Inventory Management

```lua
-- Server-side
local Core = exports['jraxion_lib']:Core()

-- Give item to player
local success = Core.Inventory.AddItem(source, 'phone', 1, {
    number = '555-123-4567'
})

if success then
    Core.Notify(source, 'Item Given', 'Phone added to inventory', 'success')
else
    Core.Notify(source, 'Error', 'Cannot carry item', 'error')
end
```

### Group System

```lua
-- Server-side
local Core = exports['jraxion_lib']:Core()

-- Create a group
local group = Core.Groups.Set(source, {
    name = 'Heist Group',
    maxMembers = 4
})

-- Add member to group
local result = Core.Groups.AddMember(targetSource, group.groupId, group.pass)

if result == 'wrong_pass' then
    Core.Notify(targetSource, 'Error', 'Wrong password', 'error')
elseif result == 'full' then
    Core.Notify(targetSource, 'Error', 'Group is full', 'error')
else
    Core.Notify(targetSource, 'Success', 'Joined group', 'success')
end
```

### Zone Management

```lua
-- Client-side
local Core = exports['jraxion_lib']:Core()

-- Create a zone
local zoneId = Core.Poly.AddBoxZone(
    vector3(100.0, 200.0, 30.0),
    5.0,  -- height
    3.0,  -- width
    90.0, -- heading
    function(entering, zone)
        if entering then
            Core.TextUI.Draw('Press E to interact', 'info')
        else
            Core.TextUI.Stop()
        end
    end
)

-- Remove zone when done
Core.Poly.RemoveZone(zoneId)
```

### Skill System Integration

```lua
-- Client-side
local Core = exports['jraxion_lib']:Core()

-- Get skill data
local skillData = Core.Framework.Callbacks.Trigger('jraxion_lib:GetSkillData')

for _, skill in pairs(skillData) do
    print(skill.locale, skill.xp, skill.level)
end

-- Open skill menu
exports['jraxion_lib']:OpenSkillMenu()
```

This documentation covers all the functions and features available in the jraxion_lib library. The library provides a comprehensive compatibility layer that makes it easy to switch between different FiveM resources without changing your code.
