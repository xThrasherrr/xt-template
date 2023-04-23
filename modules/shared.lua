-- Shared Modules --
QBCore = exports['qb-core']:GetCoreObject()
sharedItems = QBCore.Shared.Items
sharedVehicles = QBCore.Shared.Vehicles

-- Debug Print --
function XTDebug(type, debugTxt)
    if debugTxt == nil then debugTxt = '' end
    if Config.Debug then
        print("^2xT Debug ^7| "..type.." | ^2"..debugTxt)
    end
end

-- Check Job Client/Server --
function XTCheckJob(job)
    local checkType = IsDuplicityVersion() and 'server' or 'client'
    local callback = false
    if checkType == 'client' then -- Checks for client/server
        local Player = QBCore.Functions.GetPlayerData()
        if type(job) == 'string' then -- Checks for string or table of jobs
            if Player.job.name == job then
                callback = true
            end
        elseif type(job) == 'table' then
            for _,v in pairs(job) do
                if Player.job.name == v then
                    callback = true
                    break
                end
            end
        end
    else
        local Player = QBCore.Functions.GetPlayer(source)
        if type(job) == 'string' then
            if Player.PlayerData.job.name == job then
                callback = true
            end
        elseif type(job) == 'table' then
            for _,v in pairs(job) do
                if Player.PlayerData.job.name == v then
                    callback = true
                    break
                end
            end
        end
    end
    XTDebug('Job Check', 'Type: '..checkType)
    return callback
end

-- Debug / Resource Print on Startup --
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        XTDebug('xT Development', 'dsc.gg/xtdev ^7| '..resource)
    end
end)