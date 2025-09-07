local dict = {}

function locale(str, ...)
    local resource = GetInvokingResource() or GetCurrentResourceName()
    local lstr = dict[resource][str]

    if not lstr and dict["peuren_lib"][str] then
        lstr = dict["peuren_lib"][str]
    end

    if lstr then
        if ... then
            return lstr and lstr:format(...)
        end

        return lstr
    end

    return str
end

function getLocales()
    return dict
end

function loadLocales()
    local resource = GetInvokingResource() or GetCurrentResourceName()
    local locales = json.decode(LoadResourceFile(resource, ('locales/%s.json'):format(Config.Language)))

    if not locales then
        local warning = "could not load 'locales/%s.json'"
        warn(warning:format(Config.Language))

        if Config.Language ~= 'en' then
            locales = json.decode(LoadResourceFile(resource, 'locales/en.json'))

            if not locales then
                warn(warning:format('en'))
            end
        end

        if not locales then return end
    end


    if not dict[resource] then dict[resource] = {} end
    for k, v in pairs(locales) do
        if type(v) == 'string' then
            for var in v:gmatch('${[%w%s%p]-}') do
                local locale = locales[var:sub(3, -2)]

                if locale then
                    locale = locale:gsub('%%', '%%%%')
                    v = v:gsub(var, locale)
                end
            end
        end
        dict[resource][k] = v
    end
end