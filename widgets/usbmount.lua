local wibox = require('wibox')
local beautiful = require('beautiful')
local awful = require('awful')
local naughty = require('naughty')

hl = 1
disks = { }
disksToDisplay = { }
function usbCheck()
	ignoredDevices = { 'sda', 'sr0' }
	cmd = 'udisksctl dump'
	for i=1,#ignoredDevices do
		cmd = cmd .. ' | grep -v ' .. ignoredDevices[i] 
	end
	disks = { }
	f = io.popen(cmd)
	line = f:read('*line')
	if line == nil then
		f:close()
		return false
	else
		while line ~= nil do
			disk = string.match(line,'[ \t]+Device:[ \t]*(/dev/sd%a%d*)')
			if disk ~= nil then
				diskInfo = io.popen('udisksctl info -b ' .. disk):read('*all')
				if string.match(diskInfo, '[ \t]*IdUsage:[ \t]*(%a-)\n')=='filesystem' then
					table.insert(disks,disk)
				end
			end
			line = f:read('*line')
		end
		f:close()
		if next(disks) ~= nil then
			disksInfo()
			return true
		else
			return false
		end
	end
end


function usbMount(disk)
	f = io.popen('udisksctl mount -b ' .. disk)
	info = f:read('*all')
	f:close()
	return info
end


function usbUnmount(disk)
	local f = io.popen('udisksctl unmount -b ' .. disk)
	local info = f:read('*line')
	f:close()
	return info
end

function disksInfo()
	disksToDisplay = { }
	for i=1,#disks do
		f = io.popen('udisksctl info -b ' .. disks[i]):read('*all')
		elt = string.match(f,'[ \t]*IdLabel:[ \t]*([^ ]-)\n')
		if elt == '' then elt = string.match(f, '[ \t]*IdUUID:[ \t]*([^ ]-)\n') end
		f = io.popen('udisksctl info -b ' .. disks[i]):read('*all')
		elt = elt .. ' ' .. (string.match(f, '[ \t]*MountPoints:[ \t]*([^ ]-)\n') or '') 
		disksToDisplay[i] = elt
	end
end

function display()
	local str = ''
	for i=1,#disksToDisplay do
		if i == hl then
			str = str .. '<u>' .. disksToDisplay[i] .. '</u>\n'
		else
			str = str .. disksToDisplay[i] .. '\n'
		end
	end
	return "<span font_desc='monospace 10'>" .. str .. "</span>"
end






function lsof(disk)
	local f = io.popen('lsof /dev/' .. disk)
	local info = ''
	info = info .. f:read('*all')
	f:close()
	return info
end


local usb = {}
usb.img = wibox.widget.imagebox()
usb.tooltip = awful.tooltip({ })
usb.tooltip:add_to_object(usb.img)

function usb:chd(delta)
	hl = (hl + delta)
	if hl <= 0 then
		hl = #disks
	elseif hl > #disks then
		hl = 1
	end
	self.tooltip:set_text(display())
end

function usb.img.visible(self, bool)
	if bool then
		self:set_image(beautiful.usb)
	else
		self:set_image()
	end
end

usb.img:connect_signal('mouse::enter', 
function()
	hl = 1
	usb.tooltip:set_text(display()) 
end)

usb.img:buttons(awful.util.table.join(
awful.button({ }, 4, function() usb:chd(-1) end),
awful.button({ }, 5, function() usb:chd(1) end),
awful.button({ }, 1, function() naughty.notify({text = usbMount(disks[hl])}) end),
awful.button({ }, 3, function()
	t = usbUnmount(disks[hl]) or 'Unmounted ' .. disks[hl]
	t = t .. '\n\n'  .. lsof(disks[hl])
	naughty.notify({text = t, timeout = 10})
end)))
usb.img:visible(usbCheck())
usb.img_timer = timer({ timeout = 3 })
usb.img_timer:connect_signal('timeout', function ()
	usb.img:visible(usbCheck())
end)
usb.img_timer:start()
return usb
