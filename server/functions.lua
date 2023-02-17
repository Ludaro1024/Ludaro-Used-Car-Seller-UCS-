


if not GetResourceState("ox_lib") == "started" or not lib then
    error(Translation[Config.Locale]["Noox"], 100)
end

if (GetResourceState("es_extended") == "started") then
    if (exports["es_extended"] and exports["es_extended"].getSharedObject) then
        ESX = exports["es_extended"]:getSharedObject()
    else
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
end

function debug(msg)
    if Config.Debug then
        if type(msg) == "table" then
            print(print(ESX.DumpTable(msg)))
        else
            print("[Ludaro-Used-Cardealer|Debug] : " .. tostring(msg))
        end
    end
end

function isownerofcar(plate, identifier)
    local results = MySQL.Sync.fetchAll(
			"SELECT `plate` FROM `owned_vehicles` WHERE `plate` = @plate AND `owner` = @identifier", {
				['@plate']			= plate,
				['@identifier']	= identifier
			}
		)
if results ~= nil and next(results) ~= nil then
    return true
else
    return false
end
 
end

function hasrightjob(src)
   if ESX.GetPlayerFromId(src).getJob().name == Config.Job then
    return true
   else
    return false 
   end
end

RegisterNetEvent('lcdm:useitem', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    local job = xPlayer.getJob().name
    if Config.OnlyJobCanuseItem and job == Config.job or not Config.OnlyJobCanuseItem then
    local plate = lib.callback.await('ox:getNearbyVehicles', source, Config.Radius)
    if isownerofcar(plate, identifier) then
       TriggerClientEvent("lcdm:openmenu", source, plate)
    else
        TriggerClientEvent("lcdm:notify", source, Translation[Config.Locale]["notowner"])
    end
else
    TriggerClientEvent("lcdm:notify", source, Translation[Config.Locale]["onlyjob"])
end
end)

ESX.RegisterUsableItem(Config.Item, function(playerId)
        TriggerEvent("lcdm:useitem", playerId)
end)


RegisterNetEvent('lcdm:GiveCar', function(source, id, plate, issoc)
local xPlayer = ESX.GetPlayerFromId(source)
local seller = xPlayer.getIdentifier()
local xPlayer2 = ESX.GetPlayerFromId(tonumber(id))
if issoc then
    buyer = xPlayer2.getIdentifier()
else
    buyer = Config.SocietyIdentifier
end
debug(tostring(buyer))
MySQL.update('UPDATE owned_vehicles SET owner = ? WHERE plate = ?', {buyer, plate}, function(affectedRows)
if Config.TakeItem then
    xPlayer.removeInventoryItem(Config.Item, 1)
end
end)

xPlayer.triggerEvent("lcdm:notify", Translation[Config.Locale]["youtrans"].. xPlayer2.getName())
xPlayer2.triggerEvent("lcdm:notify", Translation[Config.Locale]["yougot"].. xPlayer.getName())
end)




RegisterNetEvent('lcdm:storecar', function(plate, stored)
debug("storing car..")
    if Config.useMyGarage then
        MySQL.update('UPDATE owned_vehicles SET garageID = ? WHERE plate = ?', {stored, plate}, function(affectedRows)
        end)
    else
        MySQL.update('UPDATE owned_vehicles SET stored = ? WHERE plate = ?', {stored, plate}, function(affectedRows)
        end)
    end
end)