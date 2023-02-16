
fx_version('cerulean')
games({ 'gta5' })
lua54 'yes'
dependency "ox_lib"

shared_scripts {
    'config/*.lua',
    '@ox_lib/init.lua'
}

server_scripts({
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
});

client_scripts({
    'client/*.lua'
});