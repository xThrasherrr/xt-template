-- Server Modules --

-- Server Notify --
function XTServerNotify(target, message, type)
    TriggerClientEvent('QBCore:Notify', target, message, type)
end

-- Add Money/Crypto (bool renewed-phone) --
function XTAddMoney(target, moneyType, amount, renewedCrypto)
    local Player = QBCore.Functions.GetPlayer(target)
    local cb = false
    if renewedCrypto then
        if exports['qb-phone']:AddCrypto(target, moneyType, amount) then cb = true end
    else
        if Player.Functions.AddMoney(moneyType, amount) then cb = true end
    end
    XTDebug('Add Money', 'Renewed Crypto? ' .. tostring(renewedCrypto) .. ' ^7| Money Type: ' .. moneyType .. ' ^1| Amount: ' .. amount)
    return cb
end

-- Remove Money/Crypto (bool renewed-phone) --
function XTRemoveMoney(target, moneyType, amount, renewedCrypto)
    local Player = QBCore.Functions.GetPlayer(target)
    local cb = false
    if renewedCrypto then
        if exports['qb-phone']:RemoveCrypto(target, moneyType, amount) then cb = true end
    else
        if Player.Functions.RemoveMoney(moneyType, amount) then cb = true end
    end
    XTDebug('Remove Money', 'Renewed Crypto? ' .. tostring(renewedCrypto) .. ' ^7| Money Type: ' .. moneyType .. ' ^1| Amount: ' .. amount)
    return cb
end

-- Add Item --
function XTAddItem(target, name, amount)
    local Player = QBCore.Functions.GetPlayer(target)
    local cb = false
    if Player.Functions.AddItem(name, amount) then
        TriggerClientEvent('inventory:client:ItemBox', target, sharedItems[name], 'add', amount)
        cb = true
    end
    XTDebug('Add Item', 'Item: ' .. name .. ' ^7| Amount: ' .. amount)
    return cb
end

-- Remove Item --
function XTRemoveItem(target, name, amount)
    local Player = QBCore.Functions.GetPlayer(target)
    local cb = false
    if Player.Functions.RemoveItem(name, amount) then
        TriggerClientEvent('inventory:client:ItemBox', target, sharedItems[name], 'remove', amount)
        cb = true
    end
    XTDebug('Remove Item', 'Item: ' .. name .. ' ^7| Amount: ' .. amount)
    return cb
end

-- Server Log --
function XTLog(logName, color, title, text)
    TriggerEvent("qb-log:server:CreateLog", logName, title, color, text, false, cache.resource)
end

-- Add Item to Core --
function XTCoreItem(item, label, description, image, type)
    exports['qb-core']:AddItems({
        [item] = {
            name = item,
            label = label,
            weight = 10,
            type = type,
            image = description,
            unique = false,
            useable = true,
            shouldClose = true,
            combinable = nil,
            description = description
        },
    })
    XTDebug('Add Item to Core', 'Item: ' .. label)
end