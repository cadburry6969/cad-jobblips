fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Cadburry (ByteCode Studios)'
description 'Job blips system (standalone)'

shared_scripts {
    'config/config.lua',
}

client_scripts {
    'client.lua',
}

server_scripts {
    'config/config_server.lua',
    'server.lua'
}

dependencies {
    '/onesync',
}