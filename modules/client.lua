-- Client Modules --

QBCore = exports['qb-core']:GetCoreObject()

local peds = {}
local blips = {}

-- Play Emote --
function XTEmote(emote)
    if emote == nil then XTDebug('Play Emote Error', 'Emote is nil!') return end
    if not exports.scully_emotemenu:PlayByCommand(emote) then
        TriggerEvent('animations:client:EmoteCommandStart', {emote})
    end
    XTDebug('Play Emote', emote)
end

-- End Emote --
function XTEndEmote()
    if not exports.scully_emotemenu:CancelAnimation() then
        TriggerEvent('animations:client:EmoteCommandStart', {'c'})
    end
    XTDebug('End Emote')
end

-- Create Blip --
function XTBlip(text, coords, icon, scale, color, setRoute)
    if text == nil then XTDebug('Create Blip Error', 'Missing Blip Text!') return end
    if coords == nil then XTDebug('Create Blip Error', 'Missing Blip Coordinates!') return end
    if icon == nil then XTDebug('Create Blip Error', 'Missing Blip Icon!') return end
    if scale == nil then XTDebug('Create Blip Error', 'Missing Blip Scale!') return end
    if color == nil then XTDebug('Create Blip Error', 'Missing Blip Color!') return end
    local blipID = blips[#blips+1]
    blipID = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blipID, icon)
    SetBlipScale(blipID, scale)
    SetBlipDisplay(blipID, 4)
    SetBlipColour(blipID, color)
    SetBlipAsShortRange(blipID, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blipID)
    if setRoute then SetBlipRoute(blipID, true) SetBlipRouteColour(blipID, color) end
    XTDebug('Create Blip', 'Blip Text: '..text)
    return blipID
end

-- Remove Blip
function XTRemoveBlip(blipName)
    if blipName == nil then XTDebug('Remove Blip Error', 'Blip ID is nil!') return end
    RemoveBlip(blipName)
end

-- Spawn Ped --
function XTPed(model, coords, scenario)
    if model == nil then XTDebug('Spawn Ped Error', 'Missing Model Hash!') return end
    if coords == nil then XTDebug('Spawn Ped Error', 'Missing Spawn Coordinates!') return end
    if scenario == nil then XTDebug('Spawn Ped Error', 'Missing Ped Scenario!') return end
    local pedId = peds[#peds+1]

    model = type(model) == 'string' and GetHashKey(model) or model
    RequestModel(model)

    while not HasModelLoaded(model) do Wait(0) end

    pedId = CreatePed(0, model, coords.x, coords.y, coords.z - 1, coords.w, false, false)
    TaskStartScenarioInPlace(pedId, scenario, 0, true)
    FreezeEntityPosition(pedId, true)
    SetEntityInvincible(pedId, true)
    SetBlockingOfNonTemporaryEvents(pedId, true)
    XTDebug('Spawn Ped', 'Ped Name: '..pedId..' Model: '..model..' Coordinates: '..coords..' Scenario: '..scenario )
    return pedId
end

-- Remove Ped --
function XTDeletePed(pedName)
    if pedName == nil then XTDebug('Remove Ped Error', 'Ped Name is nil!') return end
    DeletePed(pedName)
    XTDebug('Delete Ped', 'Ped Name: '..pedName)
end