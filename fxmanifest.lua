fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'QB-Crafting'
version '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua'
}

client_script 'client.lua'
server_script 'server.lua'
