lib.callback.register('lcdm:checkid', function(source, id)
    local xPlayer = ESX.GetPlayerFromId(tonumber(id))
    if xPlayer ~= nil then
        return true, xPlayer.getJob().name
    else
        return false, xPlayer.getJob().name
    end
end)


lib.callback.register('ucs:getsocietycars', function()
    local result = MySQL.query.await('SELECT * FROM owned_vehicles WHERE owner = ?', {Config.SocietyIdentifier})
if result then
    if #result > 0 then
        for k, v in pairs(result) do
            local decodedVehicleData = json.decode(v.vehicle)
            v.vehicle = decodedVehicleData
        end
    end
   return result
end
end)



lib.callback.register('ucs:checksocowner', function(source, plate)
  print(plate)
  print(Config.SocietyIdentifier)
    if isownerofcar(plate, Config.SocietyIdentifier) then
        if Config.useMyGarage then
            MySQL.update('UPDATE owned_vehicles SET garageID = ? WHERE plate = ?', {Config.GarageID, plate}, function(affectedRows)
          
            end)
        end
        MySQL.update('UPDATE owned_vehicles SET stored = ? WHERE plate = ?', {1, plate}, function(affectedRows)
          
        end)
        return true
    else
        return false
    end
end)


lib.callback.register('ucs:getjob', function(id)
    local xPlayer = ESX.GetPlayerFromId(tonumber(id))
    return xPlayer.getJob().name
end)