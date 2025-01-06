local dir = "client/%s/%s.lua"
local resource = "cb_lib"

function LoadModule(module, selection)
    local chunk = LoadResourceFile(resource, dir:format(module, string.lower(selection)))
    if not chunk then
        return error(("Couldn't load module file: %s - %s"):format(module, string.lower(selection)), 3)
    end

    local fn, err = load(chunk, ("@@cb_lib/client/%s/%s.lua"):format(module, string.lower(selection)))

    if not fn and err then
        return error(("Error loading module: %s - %s"):format(module, string.lower(selection)), 3)
    end

    return fn()
end

Core = {}
Core.Framework = LoadModule("framework", Config.Framework)
Core.Inventory = LoadModule("inventory", Config.Inventory)
Core.VehicleKeys = LoadModule("vehiclekeys", Config.VehicleKeys)
Core.ProgressBar = LoadModule("progressbar", Config.ProgessBar)
Core.Notify = LoadModule("notifications", Config.Notifications)
Core.Weather = LoadModule("weathersync", Config.WeatherSync)
Core.Dispatch = LoadModule("dispatch", Config.Dispatch)
Core.Target = LoadModule("target", Config.Target)
Core.Input = LoadModule("input", Config.Input)
Core.Menu = LoadModule("menu", Config.Menu)
Core.Fuel = LoadModule("fuel", Config.Fuel)
Core.Poly = LoadModule("poly", Config.Poly)
Core.TextUI = LoadModule("textui", Config.TextUI)
Core.Clothing = LoadModule("clothing", Config.Clothing)
Core.Math = LoadModule("math", "math")
Core.LoadLocales = loadLocales
Core.GetLocales = getLocales
Core.Locale = locale
Core.Print = Utils.Print

Core.LoadLocales()

RegisterNetEvent("cb_lib:notify", function(title, desc, type)
    Core.Notify(title, desc, type)
end)

exports("Core", function() return Core end)