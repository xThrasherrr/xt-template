-- Redline Studios Resource Shared Modules --
QRCore = exports['qr-core']:GetCoreObject()
sharedItems = QRCore.Shared.Items
sharedVehicles = QRCore.Shared.Vehicles
sharedHorses = QRCore.Shared.Horses
Keys = QRCore.Shared.Keybinds

-- Debug Print --
function XTDebug(type, debugTxt)
    if debugTxt == nil then debugTxt = '' end
    if Config.Debug then print("^0xT Debug ^7| "..type.." | ^0"..debugTxt) end
end

-- Debug / Resource Print on Startup --
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        XTDebug('dsc.gg/xtdev', '^7 | '..resource)
    end
end)