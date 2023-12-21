fx_version('cerulean')
games({ 'gta5' })

author 'gasiguus'
description 'Shop robbery'
version '1.0.0'
lua54 'yes'

server_scripts{
  'server/main.lua',
  'config.lua',
  'strings.lua'
}

client_scripts{
    'client/main.lua',
    'config.lua',
    'strings.lua'
}

shared_scripts {
  '@ox_lib/init.lua',
  'config.lua',
  '@es_extended/imports.lua'
}

escrow_ignore {
  'config.lua',
  'client/main.lua',
  'server/main.lua',
  'strings.lua',
}
