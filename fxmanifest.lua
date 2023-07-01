fx_version 'cerulean'
game 'gta5'

description 'Mining Script'
version '1.0.0'
author 'Snipe'

lua54 'yes'

shared_scripts{
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts{
    'client/**/*.lua',
} 

server_scripts{
    'server/**/*.lua'
}