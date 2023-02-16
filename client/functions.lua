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
            print("[Ludaro-Used-Cardealer|Debug] : " .. msg)
        end
    end
end

if Config.Debug then
    RegisterCommand(Config.DebugCommand, function(source, args, rawCommand)
        TriggerServerEvent("lcdm:useitem", GetPlayerServerId(PlayerId()))
       --- openMenu()
    end)
end

lib.callback.register('ox:getNearbyVehicles', function(radius)
    local nearbyVehicles = lib.getNearbyVehicles(GetEntityCoords(cache.ped), radius, true)
    if nearbyVehicles then 
    return  GetVehicleNumberPlateText(nearbyVehicles[1].vehicle)
    else
        notify(trans)
    end
end)


RegisterNetEvent('lcdm:notify', function(msg)
    notify(msg)
end)