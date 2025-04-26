fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Cadburry (ByteCode Studios)'
description 'Job blips system (standalone)'
version '1.0'

shared_scripts {
    'config/config.lua',
}

client_scripts {
    'config/config_client.lua',
    'client.lua',
}

server_scripts {
    'config/config_server.lua',
    'server.lua'
}

dependencies {
    '/onesync',
}