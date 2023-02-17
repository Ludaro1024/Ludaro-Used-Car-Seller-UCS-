Config = {}
-- debug stuff -- 
Config.Debug = true
Config.DebugCommand = "test"
Config.ShowPolyzones = false
-- stuff for normal item to give people vehicles
Config.Item = "vehiclekeys"
Config.Job = "ucd"
Config.OnlyJobCanuseItem = false
Config.Radius = 10 -- radius in which cars get searched (in m)
Config.TakeItem = false
Config.warpPedInVehicle = true
Config.SocietyIdentifier = "society_ucd" -- The Identifier for the Society, and what will be inputted as owner in the owned_vehicles row :)
Config.useLegacyFuel = false
Config.useMyGarage = true
Config.GarageID = 4
Config.Webhook = ""


function textuienter(txt)
    -- if you want to check if exited you can do that in the source code,
        lib.showTextUI(txt, {
            position = "top-center",
            icon = 'car',
            style = {
                borderRadius = 0,
                backgroundColor = 'black',
                color = 'white'
            }
        })
end

function textuiexit()
    lib.hideTextUI()
end

function textuiinside()
    -- this gets drawn EVERY second that your inside the range of a TextUI i didnt use it but there are alot of use cases
end
-- Notify Stuff
function notify(txt)
--print(txt)
    local data = {
        id = 'yes',
        title = 'GebrauchtwarenHandel',
        description = txt,
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#909296'
        },
        icon = 'file-contract',
        iconColor = '#C53030'
    }
    lib.notify(data)-- if u have a custom notify like okokNotify just input it here, and do txt as your text ;)
end    

-- locations for the USED Car Dealer
Config.Locations = {
["Heroes"] = {
-- BossPoint = vector3(134.4516, -1707.7689, 29.2916),
    blip = { blipID = 71, Size = 0.8, ColorID = 56 },
    Range = 1, 
    helpnotification = {enabled = true, msg = "Herr Kutz Boss-Menu"}, -- boss menu is wip
    Garage = {  coords = vector3(-199.8873, -1379.2745, 31.2582), range = vec3(3, 3, 3), 
        marker = { enabled = true, zoffset = 0,markerid = 36, scalex = 0.9, scaley = 0.9, scalez = 0.9, red = 0, green = 0, blue = 255, alpha = 150, bobUpAndDown = false, faceCamera = true, rotx = 0.0, roty = 180.0, rotz = 0, rotx = 0.0, roty = 0.0, rotz = 0,  }, -- https://docs.fivem.net/docs/game-references/markers/ 
    carspawncoords = vector4(-205.5503, -1387.9158, 31.2550, 335.4594)},
--     Showrooms = {
--     -- [1] = {
--     --     coords= vector4(-51.9419, -1695.0747, 29.4918, 48.3210),
--     --     Range = 1.5,
--     --      marker = { enabled = true, zoffset = 1 ,markerid = 20, scalex = 0.1, scaley = 0.1, scalez = 0.1, red = 0, green = 255, blue = 0, alpha = 150, bobUpAndDown = false, faceCamera = true, rotx = 0.0, roty = 180.0, rotz = 0, }, -- https://docs.fivem.net/docs/game-references/markers/
--     -- },
--     --  [2] = {
--     --     coords = vector4(-58.2857, -1684.5648, 29.4917, 255.6896),
--     --     Range = 1.5,
--     --    marker = { enabled = true, zoffset = 1,markerid = 20, scalex = 0.1, scaley = 0.1, scalez = 0.1, red = 0, green = 255, blue = 0, alpha = 150, bobUpAndDown = false, faceCamera = true, rotx = 0.0, roty = 180.0, rotz = 0, }, -- https://docs.fivem.net/docs/game-references/markers/
--     -- }
-- }
},


-- add new points here if you need
}

Config.Locale = "en" -- de or en
Translation = {
        ['de'] = {
           
            ['Noox'] = "Du Hast ox-lib Nicht Installiert! Installiere ox-lib! --> https://github.com/overextended/ox_lib",
            ['rlysell'] = "Willst du Wirklich das Auto mit dem Kennzeichen %s Verkaufen?",
            ['confirm'] = "Bestätigen",
            ['cancel'] = "Abbrechen",
            ['inputid'] = "ID-Eingeben für die Übertragung",
            ['invalidid'] = "Diese ID ist nicht Online!",
            ['invalididjob'] = "Diese ID ist nicht Online! oder kein GebrauchtwagenHändler!",
            ['notowner'] = "Auto wurde nicht gefunden oder .. Du bist nicht Besitzer dieses Autos!",
            ['yougot'] = "Du hast ein Auto bekommen! von..",
            ['youtrans'] = "Du hast deine Autoschlüssel erfolgreich abgegeben an..",
            ['onlyjob'] = "Du hast nicht die Qualifikation um das zu tuhen!",
            ['issoc'] = "Ist dies ein Privatverkauf?",
            ['Garage'] = "[E] um die Gebrauchtwarenhandel Garage zu Öffnen!",
            ['UCS'] = "Gebrauchtwarenhandel",
            ['ParkIn'] = "Fahrzeug Einparken",
            ['ParkOut'] = "Park das Fahrzeug aus",
        },
        ['en'] = {
            ['Noox'] = "You dont have ox-lib Installed Please Install ox-lib! --> https://github.com/overextended/ox_lib",
            ['rlysell'] = "Do you realy wanna sell the car with the plate %s?",
            ['confirm'] = "Confirm",
            ['cancel'] = "Cancel",
            ['inputid'] = "Insert ID for Transfer",
            ['invalidid'] = "That ID isnt Online!",
            ['invalididjob'] = "This ID is not online or not a buyer!",
            ['notowner'] = "Car Couldnt be found or.. Thats not your car!",
            ['yougot'] = "You got a car from..",
            ['youtrans'] = "You Gave your car keys to..",
            ['onlyjob'] = "You Dont have the qualifications for this!",
            ['issoc'] = "Ist dies ein Privatverkauf?",
            ['Garage'] = "[E] to open the Used Car Seller garage",
            ['UCS'] = "Used-Car-Dealer!",
            ['ParkIn'] = "Store a Car",
            ['ParkOut'] = "Park out the Vehicle",
        }
}
