Menu = function(title, options)
    local menu = {}

    for k, v in pairs(options) do
        if v.isServer then
            menu[#menu + 1] = {
                title = v.title,
                description = v.description or nil,
                icon = v.icon or false,
                metadata = v.metadata or nil,
                serverEvent = v.event or nil,
                args = v.args or nil,
                disabled = v.disabled or false,
                onSelect = v.onSelect or nil,
            }
        else
            menu[#menu + 1] = {
                title = v.title,
                description = v.description or nil,
                icon = v.icon or false,
                metadata = v.metadata or nil,
                event = v.event or nil,
                args = v.args or nil,
                disabled = v.disabled or false,
                onSelect = v.onSelect or nil,
            }
        end
    end

    lib.registerContext({id = "peulib", title = title, onExit = OnMenuClose, options = menu})
    lib.showContext('peulib')
end

return Menu