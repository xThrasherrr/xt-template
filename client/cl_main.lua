local QRCore = exports['qr-core']:GetCoreObject()
local Player = QRCore.Functions.GetPlayerData()
local PlayerJob = QRCore.Functions.GetPlayerData().job
local PlayerGang = QRCore.Functions.GetPlayerData().gang
local onDuty = false
local CurrentLawmen = 0

-- Player Load --
local function playerLoaded()
    Player = QRCore.Functions.GetPlayerData()
    PlayerJob = QRCore.Functions.GetPlayerData().job
    XTDebug(locale('load',tostring(GetCurrentResourceName())))
end

-- Player Unload --
local function playerUnload()
    Player = {}
    PlayerJob = {}
    XTDebug(locale('unload', tostring(GetCurrentResourceName())))
end

AddEventHandler('onResourceStart', function(resource) if resource == GetCurrentResourceName() then playerLoaded() end end)
AddEventHandler('onResourceStop', function(resource) if resource == GetCurrentResourceName() then playerUnload() end end)
RegisterNetEvent('QRCore:Client:OnPlayerLoaded', function() playerLoaded() end)
RegisterNetEvent('QRCore:Client:OnPlayerUnload', function() playerUnload() end)
RegisterNetEvent('QRCore:Client:OnJobUpdate', function(job) PlayerJob = job end)
RegisterNetEvent('QRCore:Client:OnGangUpdate', function(GangInfo) PlayerGang = GangInfo end)
RegisterNetEvent('lawmen:SetLawmenCount', function(amount) CurrentLawmen = amount end)
RegisterNetEvent('QRCore:Client:SetDuty', function(duty) onDuty = duty end)