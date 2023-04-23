local QBCore = exports['qb-core']:GetCoreObject()
local Player = QBCore.Functions.GetPlayerData()
local PlayerJob = QBCore.Functions.GetPlayerData().job
local PlayerGang = QBCore.Functions.GetPlayerData().gang
local onDuty = false
local CurrentCops = 0

local function playerLoaded()
    Player = QBCore.Functions.GetPlayerData()
    PlayerJob = QBCore.Functions.GetPlayerData().job
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
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() playerLoaded() end)
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function() playerUnload() end)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job) PlayerJob = job end)
RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo) PlayerGang = GangInfo end)
RegisterNetEvent('police:SetCopCount', function(amount) CurrentCops = amount end)
RegisterNetEvent('QBCore:Client:SetDuty', function(duty) onDuty = duty end)