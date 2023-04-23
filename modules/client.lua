QRCore = exports['qr-core']:GetCoreObject()

local peds = {}
local blips = {}

-- Ped Relationships --
function SET_PED_RELATIONSHIP_GROUP_HASH ( iVar0, iParam0 )
    return Citizen.InvokeNative( 0xC80A74AC829DDD92, iVar0, _GET_DEFAULT_RELATIONSHIP_GROUP_HASH( iParam0 ) )
end

function _GET_DEFAULT_RELATIONSHIP_GROUP_HASH ( iParam0 )
    return Citizen.InvokeNative( 0x3CC4A718C258BDD0 , iParam0 );
end

-- Request Model --
function modelrequest(model)
    CreateThread(function() RequestModel(model) end)
end

-- Create Blip --
function XTBlip(text, coords, icon, scale)
    if text == nil then XTDebug('Create Blip Error', 'Missing Blip Text!') return end
    if coords == nil then XTDebug('Create Blip Error', 'Missing Blip Coordinates!') return end
    if icon == nil then XTDebug('Create Blip Error', 'Missing Blip Icon!') return end
    if scale == nil then XTDebug('Create Blip Error', 'Missing Blip Scale!') return end
    local blipID = blips[#blips+1]

    blipID = N_0x554d9d53f696d002(1664425300, coords)
    SetBlipSprite(blipID, icon, 1)
    SetBlipScale(blipID, scale)
    Citizen.InvokeNative(0x9CB1A1623062F402, blipID, text)
    XTDebug('Create Blip', 'Blip Text: '..text..' | Coords: '..coords)
    return blipID
end

-- Remove Blip
function XTRemoveBlip(blipName)
    if blipName == nil then XTDebug('Remove Blip Error', 'Blip ID is nil!') return end
    RemoveBlip(blipName)
end

-- Spawn Ped --
function XTSpawnPed(model, coords)
    if model == nil then XTDebug('Spawn Ped Error', 'Missing Model Hash!') return end
    if coords == nil then XTDebug('Spawn Ped Error', 'Missing Spawn Coordinates!') return end
    local pedId = peds[#peds+1]

    local pedmodel = GetHashKey(model)

    while not HasModelLoaded(GetHashKey(model)) do Wait(500) modelrequest(GetHashKey(model)) end

    pedId = CreatePed(pedmodel, coords.x, coords.y, coords.z - 1, coords.w, false, false, 0, 0)
    while not DoesEntityExist(pedId) do Wait(300) end

    Citizen.InvokeNative(0x283978A15512B2FE, pedId, true)
    FreezeEntityPosition(pedId, true)
    SetEntityInvincible(pedId, true)
    TaskStandStill(pedId, -1)
    SetBlockingOfNonTemporaryEvents(pedId, true)
    SET_PED_RELATIONSHIP_GROUP_HASH(pedId, pedmodel)
    SetEntityCanBeDamagedByRelationshipGroup(pedId, false, `PLAYER`)
    SetEntityAsMissionEntity(pedId, true, true)
    SetModelAsNoLongerNeeded(pedmodel)
    XTDebug('Spawn Ped', 'Ped Name: '..pedId..' Model: '..pedmodel..' Coordinates: '..coords)
    return pedId
end

-- Remove Ped --
function XTDeletePed(pedName)
    if pedName == nil then XTDebug('Remove Ped Error', 'Ped Name is nil!') return end
    DeletePed(pedName)
    XTDebug('Delete Ped', 'Ped Name: '..pedName)
end