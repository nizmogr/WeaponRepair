fx_version 'cerulean'
lua54 'yes'
game 'gta5'
version '0.1'

author 'Nizmogr'
description 'Weapon Repair Tables'

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}

client_script 'client.lua'

server_scripts {
    'server/*.lua'
}
