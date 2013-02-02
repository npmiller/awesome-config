local wibox = require('wibox')
local beautiful = require('beautiful')
local awful = require('awful')
local naughty = require('naughty')

hl = 1
disks = { }
function usbCheck()
	ignoredDevices = { 'sda', 'sr0' }
	cmd = 'udisks --enumerate'
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
			disk = string.match(line,'sd%a%d')
			if disk ~= nil then
				table.insert(disks,disk)
			end
			line = f:read('*line')
		end
		f:close()
		if next(disks) ~= nil then
			return true
		else
			return false
		end
	end
end


function usbMount(disk)
	f = io.popen('udisks --mount /dev/' .. disk)
	info = f:read('*all')
	f:close()
	return info
end


function usbUnmount(disk)
	local f = io.popen('udisks --unmount /dev/' .. disk)
	local info = f:read('*line')
	f:close()
	return info
end


function display()
	local str = ''
	for i=1,#disks do
		f = io.popen('udisks --show-info /dev/' .. disks[i] .. ' | grep label')
		elt = string.gsub(f:read('*line'),'  label:                       ','')
		f:close()
		if i == hl then
			elt = '<u>' .. elt ..'</u>'
		end
		f = io.popen('udisks --show-info /dev/' .. disks[i] .. ' | grep "mount paths"')
		elt = string.gsub(f:read('*line'),'  mount paths:             ','') .. ' ' .. elt
		str = str .. elt .. ' \n'
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

--usb.img:draw(false)
usb.img:connect_signal('mouse::enter', 
function()
	hl = 1
	usbCheck()
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
