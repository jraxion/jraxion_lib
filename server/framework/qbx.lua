--[[
    ox_lib server callbacks run in a coroutine context where nesting `Citizen.Await(promise)`
    after `lib.callback.await` on the client can break the script host. We bridge the legacy
    `function(source, cb, ...)` style by capturing `cb(...)` synchronously and returning the
    value from the lib handler (ox_lib's supported pattern).
]]
local function registerLibCallback(name, userCb)
    lib.callback.register(name, function(source, ...)
        local ret
        local done = false
        local function finish(...)
            if done then return end
            done = true
            local n = select('#', ...)
            if n == 0 then
                ret = nil
            elseif n == 1 then
                ret = select(1, ...)
            else
                ret = table.pack(...)
            end
        end

        local ok, err = pcall(userCb, source, finish, ...)
        if not ok then
            print(('^1[jraxion_lib]^0 RegisterCallback %q failed: %s'):format(tostring(name), tostring(err)))
            return nil
        end
        if not done then
            print(('^1[jraxion_lib]^0 RegisterCallback %q never called cb()'):format(tostring(name)))
            return nil
        end
        return ret
    end)
end

Framework = {
    RegisterCallback = function(name, cb, ...)
        registerLibCallback(name, cb)
    end,
    GetIdentifier = function(player)
        local Player = exports.qbx_core:GetPlayer(player)
        if not Player then return end
        return Player.PlayerData.citizenid
    end,
    GetIdentifierID = function(identifier)
        local player = exports.qbx_core:GetPlayerByCitizenId(identifier)
        if not player then return false end
        return player.PlayerData.source
    end,
    GetCharName = function(player)
        local Player = exports.qbx_core:GetPlayer(player)
        if not Player then return end
        return {
            first = Player.PlayerData.charinfo.firstname,
            last = Player.PlayerData.charinfo.lastname,
            full = ("%s %s"):format(Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname)
        }
    end,
    GetJobPlayerCount = function(jobs)
        local count = 0

        for _, job in pairs(jobs) do
            count += exports.qbx_core:GetDutyCountJob(job)
        end
        return count
    end,
    GetPlayers = function()
        return exports.qbx_core:GetQBPlayers()
    end,
    HasGroup = function(player, group)
        return exports.qbx_core:HasPermission(player, group)
    end,
    Money = {
        Give = function(player, amount, account)

            if account == "black_money" then
                return Inventory.AddItem(player, "black_money", amount)
            end

            if account ~= "cash" and account ~= "bank" then
                return error("Wrong money account: cash or bank required.", 3)
            end

            local Player = exports.qbx_core:GetPlayer(player)
            if not Player then return end

            return Player.Functions.AddMoney(account, amount)
        end,
        Get = function(player, account)
            if account == "black_money" then
                local item = Inventory.GetItem(player, "black_money")
                if not item then return 0 end
                return item.count
            end

            if account ~= "cash" and account ~= "bank" then
                return error("Wrong money account: cash or bank required.", 3)
            end

            local Player = exports.qbx_core:GetPlayer(player)
            if not Player then return end
            return Player.Functions.GetMoney(account)
        end,
        Remove = function(player, amount, account)
            if account == "black_money" then
                return Inventory.RemoveItem(player, "black_money", amount)
            end

            if account ~= "cash" and account ~= "bank" then
                return error("Wrong money account: cash or bank required.", 3)
            end

            local Player = exports.qbx_core:GetPlayer(player)
            if not Player then return end
            return Player.Functions.RemoveMoney(account, amount)
        end,
    },
    Job = {
        Set = function(player, job, grade)
            local Player = exports.qbx_core:GetPlayer(player)
            if not Player then return end
            Player.Functions.SetJob(job, grade)
            return true
        end,
        Get = function(player)
            local Player = exports.qbx_core:GetPlayer(player)
            if not Player then return end
            return Player.PlayerData.job.name
        end,
        GetLabel = function(player)
            local Player = exports.qbx_core:GetPlayer(player)
            if not Player then return end
            return Player.PlayerData.job.label
        end,
        GetGrade = function(player)
            local Player = exports.qbx_core:GetPlayer(player)
            if not Player then return end
            return Player.PlayerData.job.grade.level
        end,
        GetGradeLabel = function(player)
            local Player = exports.qbx_core:GetPlayer(player)
            if not Player then return end
            return Player.PlayerData.job.grade.name
        end
    },
}

lib.callback.register('jraxion_lib:SpawnVehicle', function(player, model, pos)
    local netId = qbx.spawnVehicle({ model = model, spawnSource = pos })
    return netId
end)

return Framework