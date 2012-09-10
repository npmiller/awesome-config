require('appMenu')
require('lib/filesmenu')

--Create the main menu
myawesomemenu = {
	{ 'Manual', terminal .. ' -e man awesome' },
	{ 'Edit config', editor_cmd .. ' ' .. awful.util.getdir('config') .. '/rc.lua' },
	{ 'Restart', awesome.restart },
	{ 'Quit', awesome.quit }
}
sysmenu = {
	{ 'Update', terminal .. ' -e yaourt -Sayu'},
	{ 'Shutdown', 'poweroff' },
	{ 'Reboot', 'reboot' },
	{ 'Suspend', 'suspend' },
} 
--[[
filesmenu = {
	{ 'Documents', genMenu('/home/nicolas/Documents/')},
	{ 'Desktop',  genMenu('/home/nicolas/Desktop/')},
	{ 'info',  genMenu('/home/nicolas/info/')},
	{ 'Downloads',  genMenu('/home/nicolas/Downloads/')},
	{ 'Pics',  genMenu('/home/nicolas/Pics/')},
	{ 'Screenshots',  genMenu('/home/nicolas/Screenshots/')},
	{ 'Series',  genMenu('/media/DATA/Series/')},
	{ 'Mount USB', 'mount /mnt/USB' },
	{ 'Umount USB', 'umount /mnt/USB' }
}--]]

mymainmenu = awful.menu({ items = { { 'Awesome', myawesomemenu --[[, beautiful.awesome_icon --]] },
{ 'System', sysmenu },
{ 'Apps', categoriesMenu },
--{ 'Files', filesmenu },
{ 'Open terminal', terminal }
} })

