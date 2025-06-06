Framework = {
    RegisterCallback = function(name, cb, ...)
        lib.callback.register(name, function(source, ...)
            local p = promise:new()

            function callbackWrapper(...)
                p:resolve(...)
            end

            cb(source, callbackWrapper, ...)
            
            return Citizen.Await(p)
        end)
    end,
    GetIdentifier = function(player)
        local xPlayer = Ox.GetPlayer(player)
        if not xPlayer then return end
        return xPlayer.userId
    end,
    GetIdentifierID = function(identifier)
        local player = Ox.GetPlayerByFilter({userId = identifier})
        if not player then return false end
        return player.source
    end,
    GetCharName = function(player)
        local xPlayer = Ox.GetPlayer(player)
        if not xPlayer then return end
        return {
            first = xPlayer.firstName,
            last = xPlayer.lastName,
            full = xPlayer.name
        }
    end,
    GetJobPlayerCount = function(jobs)
        local players = Ox.GetPlayers({ groups = jobs })
        if not players then return 0 end 

        return #players
    end,
    GetPlayers = function()
        return Ox.GetPlayers({})
    end,
    HasGroup = function(player, group)
        local xPlayer = Ox.GetPlayer(player)
        if not xPlayer then return end
        return xPlayer.getGroup() == group
    end,
    Money = {
        Give = function(player, amount, account)
            if account ~= "cash" and account ~= "bank" and account ~= "black_money" then
                return error("Wrong money account: cash, bank, or black_money required.", 3)
            end

            local xPlayer = Ox.GetPlayer(player)  
            if not xPlayer then return end  

            local accounts = xPlayer.get('accounts')
            accounts[account] += amount
            xPlayer.set('accounts', accounts)

            if account == 'cash' then
                TriggerClientEvent("peuren_lib:notify", player, Core.Locale("paid_title"), Core.Locale("you_got_paid"):format(amount), "success")
                exports.ox_inventory:AddItem(player, 'money', amount)
            end

            return true 
        end,
        Get = function(player, account)
            if account ~= "cash" and account ~= "bank" and account ~= "black_money" then
                return error("Wrong money account: cash, bank, or black_money required.", 3)
            end

            local xPlayer = Ox.GetPlayer(player)  
            if not xPlayer then return end  

            local accounts = xPlayer.get('accounts')

            return accounts[account] 
        end,
        Remove = function(player, amount, account)
            if account ~= "cash" and account ~= "bank" and account ~= "black_money" then
                return error("Wrong money account: cash, bank, or black_money required.", 3)
            end

            local xPlayer = Ox.GetPlayer(player)  
            if not xPlayer then return end  

            local accounts = xPlayer.get('accounts')
            accounts[account] -= amount
            xPlayer.set('accounts', accounts)

            if account == 'cash' then 
                exports.ox_inventory:RemoveItem(player, 'money', amount)
            end

            return true 
        end,
    },
    Job = {
        set = function(player, job, grade)
            -- local xPlayer = Ox.GetPlayer(player)
            -- if not xPlayer then return end
            -- xPlayer.setJob(job, grade)
            return true
        end,
        Get = function(player)
            -- local xPlayer = Ox.GetPlayer(player)
            -- if not xPlayer then return end
            -- return xPlayer.getJob().name
            return ""
        end,
        GetLabel = function(player)
            -- local xPlayer = Ox.GetPlayer(player)
            -- if not xPlayer then return end
            -- return Ox.GetGroups()['police'].label
            return ""
        end,
        GetGrade = function(player)
            -- local xPlayer = Ox.GetPlayer(player)
            -- if not xPlayer then return end
            -- return xPlayer.getJob().grade
            return 0
        end,
        GetGradeLabel = function(player)
            -- local xPlayer = Ox.GetPlayer(player)
            -- if not xPlayer then return end
            -- return Ox.GetGroups()['police'].grades[1]
            return ""
        end
    },

    lib.callback.register('peuren_lib:SpawnVehicle', function(player, model, pos, heading)
        local xPlayer = Ox.GetPlayer(player)
        if not xPlayer then return end
        return Ox.CreateVehicle({ model = model, owner = player.charid }, pos, heading)
    end)
}

return Framework