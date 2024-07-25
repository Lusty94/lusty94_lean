fx_version 'cerulean'

game 'gta5'

lua54 'yes'

author 'Lusty94'

description 'Lean Making Script For QB-Core'

version '1.0.0'


client_scripts {
    'client/lean_client.lua',
    'shared/menus.lua',
}

server_scripts {
    'server/lean_server.lua',
} 

shared_scripts { 
	'shared/config.lua',
    '@ox_lib/init.lua'
}


escrow_ignore {
    'shared/**.lua',
    'client/**.lua',
    'server/**.lua',
    'stream/**.ydr',
    'stream/**.ytyp',
}


files {
    'stream/*.ytyp',
}
data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'


