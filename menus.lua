require('appMenu')
require('lib/filesmenu')

--Create the main menu
myawesomemenu = {
	{ 'manual', terminal .. ' -e man awesome' },
	{ 'edit config', editor_cmd .. ' ' .. awful.util.getdir('config') .. '/rc.lua' },
	{ 'restart', awesome.restart },
	{ 'quit', awesome.quit }
}
sysmenu = {
	{ 'Shutdown', 'halt' },
	{ 'Reboot', 'reboot' },
	{ 'Suspend', 'suspend' },
} 
filesmenu = {
	{ 'Documents', genMenu('/home/nicolas/Documents/')},
	{ 'Desktop',  genMenu('/home/nicolas/Desktop/')},
	{ 'info',  genMenu('/home/nicolas/info/')},
	{ 'Downloads',  genMenu('/home/nicolas/Downloads/')},
	{ 'Pics',  genMenu('/home/nicolas/Pics/')},
	{ 'Screenshots',  genMenu('/home/nicolas/Screenshots/')},
	{ 'Series',  genMenu('/media/DATA/Series/')},
	{ 'Mount USB', 'mount /media/USB' },
	{ 'Umount USB', 'umount /media/USB' }
}

mymainmenu = awful.menu({ items = { { 'awesome', myawesomemenu --[[, beautiful.awesome_icon --]] },
{ 'System', sysmenu },
{ 'Apps', categoriesMenu },
{ 'Files', filesmenu },
{ 'open terminal', terminal }
} })

