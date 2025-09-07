fx_version 'cerulean'
game 'gta5'

author 'PEUREN DEVELOPMENT - peuren.tebex.io'
version '0.4.9'

lua54 'yes'
use_experimental_fxv2_oal 'yes'

client_scripts { 
  -- '@ox_core/imports/client.lua', --Remove the two -- if you're using ox_core in your server
  'utils/**/*.lua', 
  'client/groups/**', 
  "client/inventory/carryItems.lua", 
  'client/entitySync/**',
  'client/main.lua', 
  "client/menu/skillMenu.lua",
}

shared_scripts { 
  -- '@PolyZone/client.lua', --Remove the two -- if you're using polyzone in your server
  -- '@PolyZone/BoxZone.lua', --Remove the two -- if you're using polyzone in your server
  -- '@PolyZone/EntityZone.lua', --Remove the two -- if you're using polyzone in your server
  -- '@PolyZone/CircleZone.lua', --Remove the two -- if you're using polyzone in your server
  -- '@PolyZone/ComboZone.lua', --Remove the two -- if you're using polyzone in your server

  '@ox_lib/init.lua', --Remove the two -- if you're using ox_lib in your server
  -- '@qbx_core/modules/lib.lua', --Remove the two -- if you're using qbx_core in your server

  'shared/config.lua',
  'shared/itemLabels.lua',
}

server_scripts { 
  -- '@ox_core/imports/server.lua', --Remove the two -- if you're using ox_core in your server
  'shared/discordLogs.lua',
  'utils/**/*.lua',
  'server/groups/**',
  'server/main.lua',
  'server/entitySync/**',
}

files { 'locales/*.json', 'client/**/*.lua' }
