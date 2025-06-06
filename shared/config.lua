Config = {}

Config.Debug = false -- Adds additional prints and enables all other resource debug options | true or false
Config.Language = 'en' -- Language file name, this means, that it will only load files from script locales folders that contain this name, 
                       -- if this is an invalid locale name on a resource it will default to english

Config.Framework = "qbx" 
Config.IsOldESX = false --This option is needed if you are running an older version of ESX
Config.FrameworkResource = "qb-core" -- Framework resource name
--SUPPORTED FRAMEWORK NAMES TO PUT IN: Config.Framework = ""
--[[
    esx
    qbx - (Uncomment qbx_core export in jraxion_lib/fxmanifest.lua file)
    ox - (Uncomment ox_core imports in fxmanifest.lua file)
]]

Config.SQLConnector = "oxmysql"
--SUPPORTED SQL CONNECTOR NAMES TO PUT IN: Config.SQLConnector = ""
--[[
    oxmysql
    mysql-async
    ghmattimysql
]]

Config.Inventory = "ox_inventory"
Config.InventoryResource = 'ox_inventory' -- The inventory system folder name that you're using
Config.CarryItemsEnabled = true -- Should the Carry Items system be enabled
--SUPPORTED INVENTORY SCRIPT NAMES TO PUT IN: Config.Inventory = ""
--[[
    avp_inv_4
    mf-inventory
    esx_inventory
    qb-inventory
    qb-inventory-new (for new versions of qb-inventory)
    ox_inventory
    qs-inventory
    tgiann-inventory
    codem-inventory
    origen_inventory
]]

Config.Target = "ox_target"
Config.TargetResource = 'ox_target' -- The inventory system folder name that you're using
--SUPPORTED TARGET SCRIPT NAMES TO PUT IN: Config.Target  = ""
--[[
    qb-target
    ox_target
    qtarget
]]

Config.ProgessBar = 'ox_lib'
Config.ProgessBarResource = 'ox_lib' -- The menu system folder name that you're using
--SUPPORTED PROGRESS BAR SCRIPT NAMES TO PUT IN: Config.ProgessBar = ""
--[[
    ox_lib - (Uncomment ox_lib import in jraxion_lib/fxmanifest.lua file)
    qb
    tgiann
]]

Config.Menu = 'ox_lib'
Config.MenuResource = 'ox_lib' -- The menu system folder name that you're using
--SUPPORTED MENU SCRIPT NAMES TO PUT IN: Config.Menu = ""
--[[
    ps-ui
    ox_lib - (Uncomment ox_lib import in jraxion_lib/fxmanifest.lua file)
    qb
    nh-context
    esx_menu_default
    esx_context
]]

Config.Input = 'ox_lib'
Config.InputResource = 'ox_lib' -- The input system folder name that you're using
--SUPPORTED INPUT SCRIPT NAMES TO PUT IN: Config.Input = ""
--[[
    ox_lib - (Uncomment ox_lib import in jraxion_lib/fxmanifest.lua file)
    qb-input
    nh-keyboard
]]

Config.TextUI = "ox_lib"
Config.TextUIResource = "ox_lib" -- The TextUI system folder name that you're using
--SUPPORTED TEXT UI SCRIPT NAMES TO PUT IN: Config.TextUI = ""
--[[
    ps-ui
    ox_lib - (Uncomment ox_lib import in jraxion_lib/fxmanifest.lua file)
    okokTextUI
    jg-textui
    qb
]]

Config.Poly = "ox_lib"
Config.PolyResource = "ox_lib" -- The Polyzone system folder name that you're using
--SUPPORTED ZONE SCRIPT NAMES TO PUT IN: Config.Poly = ""
--[[
    polyzone
    ox_lib - (Uncomment ox_lib import in jraxion_lib/fxmanifest.lua file)
    okokTextUI
    qb
]]

Config.Notifications = "ox_lib"
Config.NotificationsResource = "ox_lib" -- The notification system folder name that you're using
--SUPPORTED NOTIFICATION SCRIPT NAMES TO PUT IN: Config.Notifications = ""
--[[
    peuren_notify
    ps-ui
    ox_lib - (Uncomment ox_lib import in jraxion_lib/fxmanifest.lua file)
    qb
    esx
    okok
    mythic
    s1n_notify
    tgiann
    k5_notify
    vms_notifyv2
]]

Config.WeatherSync = 'qb-weathersync'
--SUPPORTED WEATHER SYNC SCRIPT NAMES TO PUT IN: Config.WeatherSync = ""
--[[
    renewed-weathersync
    qb-weathersync
    cd_easytime
]]

Config.Dispatch = 'cd_dispatch'
Config.DispatchResource = 'cd_dispatch' -- The dispatch system resource folder name
--SUPPORTED DISPATCH SCRIPT NAMES TO PUT IN: Config.Dispatch = ""
--[[
    fea-dispatch
    origen_police
    rcore_dispatch
    cd_dispatch
    core_dispatch
    default - standalon version, not recommended for productions servers without changes to the code
    outwalter
    ps-dispatch
    qs-dispatch
    tk_dispatch
    redutzu-mdt
]]

Config.Fuel = 'LegacyFuel'
Config.FuelResource = 'LegacyFuel' -- The fuel system resource folder name
--SUPPORTED FUEL SCRIPT NAMES TO PUT IN: Config.Fuel = ""
--[[
    okokGasStation
    LegacyFuel
    ox_fuel
    lj-fuel
    ti_fuel
    ND_fuel
    ps-fuel
    esx-sna-fuel
    cdn-fuel
    FRFuel
    renewed-fuel
    xFuel
    rcore_fuel
    qs-fuelstations
    lc_fuel
    sgx-fuel
]]

Config.VehicleKeys = 'qb-vehiclekeys'
Config.VehicleKeysResource = 'qb-vehiclekeys' -- The vehicle key system resource folder name
--SUPPORTED VEHICLE KEY SCRIPT NAMES TO PUT IN: Config.VehicleKeys = ""
--[[
    MrNewbVehicleKeys
    mk_vehiclekeys
    okokGarage
    qs-vehiclekeys
    wasabi_carlock
    cd_garage
    t1ger_keys
    F_RealCarKeysSystem 
    fivecode_carkeys
    qb-vehiclekeys
    stasiek_vehiclekeys
    ti_vehicleKeys
    vehicles_keys
    xd_locksystem
    tgiann-hotwire
    dusa_vehiclekeys
    Renewed-Vehiclekeys
    ak47_vehiclekeys
]]

Config.Clothing = 'qb-clothing'
Config.ClothingResource = 'qb-clothing' -- The clothing system resource folder name
--SUPPORTED CLOTHING SCRIPT NAMES TO PUT IN: Config.Clothing = ""
--[[
    crm-appearance
    codem-appearance
    tgiann-clothing
    esx_skin
    fivem-appearance
    illenium-appearance
    ox_appearance
    qb-clothing
    rcore_clothing
]]

Config.SkillMenu = { -- Configuration for skill menu.
    Enabled = true, -- Should the Skill Menu be enabled
    Command = "skills" -- The comand which opens the skill menu. Set this to false to disable it. Skill menu can be also opened by using exports["peuren_lib"]:OpenSkillMenu()
}

Config.Groups = { -- Configuration for multiplier jobs (peuren only)
    MemberLimit = 4,--Maximum group member amount in a group
    Timeout = { min = 0, sec = 10 }, --The time in which the group owner has to return to game before assigning a new group leader
    password = {
        type = 'number',--number or char
        length = 6--code length
    }
}