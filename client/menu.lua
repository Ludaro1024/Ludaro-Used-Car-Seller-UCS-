
if not GetResourceState("NativeUILua_Reloaded") == "started" or not NativeUI then
    error(Translation[Config.Locale]["NoNativeUI"], 100)
end


Citizen.CreateThread(function()
    while true do
        Wait(1)
        if Config.Locations and job == Config.Job then
        for k, L in pairs(Config.Locations) do
        DrawMarker(L.Garage.marker.markerid, L.Garage.coords.x, L.Garage.coords.y, L.Garage.coords.z + L.Garage.marker.zoffset, 0.0, 0.0, 0.0, L.Garage.marker.rotx, L.Garage.marker.roty, L.Garage.marker.rotz, L.Garage.marker.scalex, L.Garage.marker.scaley, L.Garage.marker.scalez, L.Garage.marker.red, L.Garage.marker.green, L.Garage.marker.blue, L.Garage.marker.alpha, L.Garage.marker.bobUpAndDown, L.Garage.marker.faceCamera, 2, nil, nil, false)
        end
    end
end
end)

_menuPool = NativeUI.CreatePool()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if _menuPool:IsAnyMenuOpen() then
            _menuPool:ProcessMenus()
        else
            Citizen.Wait(150) -- this small line
        end
    end
end)






function openMenu(plate)
local data = {header = string.format(Translation[Config.Locale]["rlysell"], tostring(plate)), centered = true, cancel = true, labels = {cancel = Translation[Config.Locale]["cancel"], confirm = Translation[Config.Locale]["confirm"]} }
popup = lib.alertDialog(data)

if popup == "confirm" then
    local inputid = lib.inputDialog('Police locker', {
        { type = "number", label = "ID:", default = 1 },
        { type = "checkbox", label = Translation[Config.Locale]["issoc"] },
    })
    if not inputid then return end
local id = tonumber(inputid[1])
local issoc = inputid[2]
debug(id)
debug(tostring(issoc))
local idvalid, job= lib.callback.await('lcdm:checkid', 100, id)
if idvalid then
TriggerServerEvent("lcdm:GiveCar", GetPlayerServerId(PlayerId()), id, plate, issoc)
elseif Config.OnlyJobTransfer and job ~= Config.Job then
notify(Translation[Config.Locale]["invalididjob"])
elseif not idvalid then
    notify(Translation[Config.Locale]["invalidid"])
end
end
end



for k, loc in pairs(Config.Locations) do

 
    if loc.Garage.coords then

        function onEnter(self)
            textuienter(Translation[Config.Locale]["Garage"])
        end

        function onExit(self)
           textuiexit()
           lib.hideMenu(true)
           _menuPool:CloseAllMenus()
        end
        
        function insideZone(self)
            textuiinside()

            if IsControlJustReleased(0, 38) and not _menuPool:IsAnyMenuOpen() then
             opennativemenu(loc.Garage.carspawncoords)
           debug(loc.Garage.carspawncoords)
            end
        end
        local box = lib.zones.box({
            coords = loc.Garage.coords,
            size = loc.Garage.range,
            rotation = 45,
            debug = Config.ShowPolyzones,
            inside = insideZone,
            onEnter = onEnter,
            onExit = onExit
        })

      
        
    end
end

function opennativemenu(carcoords)
    


     mainmenu = NativeUI.CreateMenu(Translation[Config.Locale]["UCS"], "")
    
    _menuPool:Add(mainmenu)
    _menuPool:RefreshIndex()
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    mainmenu:Visible(true)

local cartable = lib.callback("ucs:getsocietycars")
if cartable then
    for k, car in pairs(cartable) do

 local item = NativeUI.CreateItem(car.plate, "")
 mainmenu:AddItem(item)
debug(car.garageID)
 if car.stored == 0 then
    item:Enabled(false)
 end

 if  Config.useMyGarage then
    if car.garageID == 0 then
        item:Enabled(false)
    end
end
    item.Activated = function(sender, index)
        _menuPool:CloseAllMenus()
        carmenu = NativeUI.CreateMenu(car.plate, "")
       
        _menuPool:Add(carmenu)
        _menuPool:RefreshIndex()
        _menuPool:MouseControlsEnabled(false)
        _menuPool:MouseEdgeEnabled(false)
        _menuPool:ControlDisablingEnabled(false)
        carmenu:Visible(true)
       
          local out = NativeUI.CreateItem(Translation[Config.Locale]["ParkOut"],"")
          carmenu:AddItem(out)
          out:RightLabel("~g~>>")
          out.Activated = function(sender, index)
          carmenu:Visible(false)
          debug(car.vehicle)
          debug("Setting stored to 0")
          TriggerServerEvent("lcdm:storecar", car.vehicle.plate, 0)
          SpawnVehicle(car.vehicle, car.plate, car.vehicle.fuelLevel, carcoords)
          end
end
end
end
local parkin = NativeUI.CreateItem(Translation[Config.Locale]["ParkIn"], "")
mainmenu:AddItem(parkin)
parkin:RightLabel('~g~>>')
parkin.Activated = function(sender, index)
    local nearbyVehicles, coords = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 5, true)
    print(nearbyVehicles)
    local plate = GetVehicleNumberPlateText(nearbyVehicles)
    local isowner = lib.callback.await("ucs:checksocowner", false, plate)

    if nearbyVehicles and isowner then
        ESX.Game.DeleteVehicle(nearbyVehicles)
        --TriggerServerEvent() 
    _menuPool:CloseAllMenus()
    end
end
end


function SpawnVehicle(vehicle, plate, fuel, spawnCoords)
	ESX.Game.SpawnVehicle(vehicle.model, spawnCoords, spawnCoords.rot, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
        if plate ~= nil then
            SetVehicleNumberPlateText(callback_vehicle, plate)
        end
		SetVehicleEngineOn(callback_vehicle, true, true)
        if vehicle ~= nil and vehicle.engineHealth ~= nil then
		    SetVehicleEngineHealth(callback_vehicle, vehicle.engineHealth)
        end
        if vehicle ~= nil and vehicle.bodyHealth ~= nil then
		    SetVehicleBodyHealth(callback_vehicle, vehicle.bodyHealth)
        end
		if Config.useLegacyFuel then
            if fuel ~= nil then
                exports['LegacyFuel']:SetFuel(callback_vehicle, fuel)
                --print('set fuel to:' .. fuel)
            else
                exports['LegacyFuel']:SetFuel(callback_vehicle, 60.0)
            end
			
            --
		end

        if Config.warpPedInVehicle then
		    TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
        end
	end)
end









RegisterNetEvent('lcdm:openmenu', function(plate)
    openMenu(plate)
end)