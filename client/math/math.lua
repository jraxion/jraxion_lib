local StringCharset = {}
local NumberCharset = {}

for i = 48, 57 do NumberCharset[#NumberCharset + 1] = string.char(i) end
for i = 65, 90 do StringCharset[#StringCharset + 1] = string.char(i) end
for i = 97, 122 do StringCharset[#StringCharset + 1] = string.char(i) end

-- Credits QBCore and es_extended

Math = {
    RandomStr = function (length)
        if length <= 0 then return '' end
        return Core.Math.RandomStr(length - 1) .. StringCharset[math.random(1, #StringCharset)]
    end,
    RandomInt = function(length)
        if length <= 0 then return '' end
        return Core.Math.RandomInt(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
    end,
    SplitStr = function(str, delimiter)
        local result = {}
        local from = 1
        local delim_from, delim_to = string.find(str, delimiter, from)
        while delim_from do
            result[#result + 1] = string.sub(str, from, delim_from - 1)
            from = delim_to + 1
            delim_from, delim_to = string.find(str, delimiter, from)
        end
        result[#result + 1] = string.sub(str, from)
        return result
    end,
    Trim = function(value)
        if not value then return nil end
        return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
    end,
    FirstToUpper = function (value)
        if not value then return nil end
        return (value:gsub("^%l", string.upper))
    end,
    Round = function(value, numDecimalPlaces)
        if numDecimalPlaces then
            local power = 10 ^ numDecimalPlaces
            return math.floor((value * power) + 0.5) / power
        else
            return math.floor(value + 0.5)
        end
    end,
    GetPlate = function(vehicle)
        if vehicle == 0 then return end
        return Core.Math.Trim(GetVehicleNumberPlateText(vehicle))
    end
}

return Math