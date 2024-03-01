fx_version 'cerulean'
game 'gta5'

description 'V7 Developers Team || https://discord.gg/w64WBNaWmT'
author 'V7 Developers Team'

files {
    'ui/index.html',
    'ui/style.css',
    'ui/app.js', 
    'ui/Sound/*.mp3'
}

ui_page 'ui/index.html'

client_scripts {
    'C/C.lua',
}

server_scripts {
    'S/S.lua',
}

shared_scripts {
    'CFG/Config.lua'
}