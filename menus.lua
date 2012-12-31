require('appMenu')
--require('lib/filesmenu')
local awful = require('awful')

--Create the main menu
configmenu = {
	{ 'Main', editor_cmd .. ' ' .. awful.util.getdir('config') .. "/rc.lua" },
	{ 'Bindings', editor_cmd .. ' ' .. awful.util.getdir('config') .. "/bindings.lua" },
	{ 'Rules', editor_cmd .. ' ' .. awful.util.getdir('config') .. "/rules.lua" },
	{ 'Menus', editor_cmd .. ' ' .. awful.util.getdir('config') .. "/menus.lua" },
}

myawesomemenu = {
	{ 'Manual', terminal .. ' -e man awesome' },
	{ 'Edit config', configmenu },
	{ 'Restart', awesome.restart },
	{ 'Quit', awesome.quit }
}
sysmenu = {
	{ 'Update', terminal .. ' -e yaourt -Sayu'},
	{ 'Shutdown', 'poweroff' },
	{ 'Reboot', 'reboot' },
	{ 'Suspend', 'systemctl suspend' },
} 


--filesmenu = {
	--{ 'Documents',function () co = coroutine.create(function () return genMenu('/home/nicolas/Documents/') end) ; _,tab = coroutine.resume(co) ; return tab end },
	--{ 'Documents',genMenu('/home/nicolas/Documents/')},
	--{ 'Desktop',  genMenu('/home/nicolas/Desktop/')},
	--{ 'Info',  genMenu('/home/nicolas/Info/')},
	--{ 'Downloads',  genMenu('/home/nicolas/Downloads/')},
	--{ 'Pics',  genMenu('/home/nicolas/Pics/')},
	--{ 'Screenshots',  genMenu('/home/nicolas/Screenshots/')},
	--{ 'Musique',  genMenu('/home/nicolas/Musique/')},
	--{ 'Series',  genMenu('/media/Home/Series/')},
	--{ 'Mount USB', 'mount /mnt/USB' },
	--{ 'Umount USB', 'umount /mnt/USB' }
--}

mymainmenu = awful.menu({ items = { { 'Awesome', myawesomemenu --[[, beautiful.awesome_icon --]] },
{ 'System', sysmenu },
{ 'Apps', categoriesMenu },
{ 'Files', filesmenu },
{ 'Open terminal', terminal },
} })

