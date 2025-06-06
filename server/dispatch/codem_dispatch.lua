Dispatch = function(data)
    local Data = {
        type = Type,
        header = 'Robbery in progress',
        text = Text,
        code = Config.DispatchTypes['Robbery'].code,
    }

    exports['codem-dispatch']:CustomDispatch(Data)
end 

return Dispatch