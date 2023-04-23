local QBCore = exports['qb-core']:GetCoreObject()

-- Debug / Resource Print on Startup --
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Debug('xT Dev', 'dsc.gg/xtdev ^7| '..resource)
    end
end)