local tran = "this is a debug msg"
function openMenu(plate)
--     lib.registerContext({
--         id = "Verkaufsmenü",
--         title = "Verkaufs-Menü",
--         options = {
--         {title = 'Empty button'},
--         {
--             title = 'Example button',
--             description = 'Example button description',
--             onSelect = function(args)
--               print('Pressed the button!')
--             end,
--             metadata = {
--                 {label = 'Value 1', value = 'Some value'},
--                 {label = 'Value 2', value = 300},
--             }
--     }
-- }
-- }
-- )
-- lib.showContext("mainmenu")


local data = {header = string.format(Translation[Config.Locale]["rlysell"], tostring(plate)), centered = true, cancel = true, labels = {cancel = Translation[Config.Locale]["cancel"], confirm = Translation[Config.Locale]["confirm"]} }
popup = lib.alertDialog(data)

if popup == "confirm" then
    local inputid = lib.inputDialog(Translation[Config.Locale]["inputid"], {"ID:"})
    if not inputid then return end
local id = tonumber(inputid[1])
local idvalid, job= lib.callback.await('lcdm:checkid', 100, id)
debug(job)
if idvalid then
TriggerServerEvent("lcdm:GiveCar", GetPlayerServerId(PlayerId()), id, plate)
elseif Config.OnlyJobTransfer and job ~= Config.Job then
notify(Translation[Config.Locale]["invalididjob"])
elseif not idvalid then
    notify(Translation[Config.Locale]["invalidid"])
end
end
end


RegisterNetEvent('lcdm:openmenu', function(plate)
    openMenu(plate)
end)