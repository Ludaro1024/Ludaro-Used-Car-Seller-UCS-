Config = {}
Config.Debug = false
Config.DebugCommand = "test"
Config.Item = "vehiclekeys"
Config.Job = "cdm"
Config.OnlyJobTransfer = "true"
Config.Radius = 10
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
            ['notowner'] = "Du bist nicht Besitzer dieses Autos!",
            ['yougot'] = "Du hast ein Auto bekommen! von..",
            ['youtrans'] = "Du hast deine Autoschlüssel erfolgreich abgegeben an..",



        },
        ['en'] = {
            ['Noox'] = "You dont have ox-lib Installed Please Install ox-lib! --> https://github.com/overextended/ox_lib",
            ['rlysell'] = "Do you realy wanna sell the car with the plate %s?",
            ['confirm'] = "Confirm",
            ['cancel'] = "Cancel",
            ['inputid'] = "Insert ID for Transfer",
            ['invalidid'] = "That ID isnt Online!",
            ['invalididjob'] = "This ID is not online or not a buyer!",
            ['notowner'] = "Thats not your car!",
            ['yougot'] = "You got a car from..",
            ['youtrans'] = "You Gave your car keys to..",

        }
}
