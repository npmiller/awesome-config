-- A simple tool to mount devices within awesome using Udisks
--

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
	f = io.popen('udisks --unmount /dev/' .. disk)
	info = f:read('*line')
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


function chd(delta)
	hl = (hl + delta)
	if hl <= 0 then
		hl = #disks
	elseif hl > #disks then
		hl = 1
	end
	usbtooltip:set_text(display())

end

function lsof(disk)
	f = io.popen('lsof /dev/' .. disk)
	i = f:read('*all')
	f:close()
	return i
end

usbimg = widget({type = 'imagebox'})
usbimg.image = image(beautiful.usb)
usbimg.visible = false

usbtooltip = awful.tooltip({ })
usbtooltip:add_to_object(usbimg)
usbimg:add_signal('mouse::enter', function()
	hl = 1
	usbCheck()
	usbtooltip:set_text(display()) end)
usbimg:buttons(awful.util.table.join(
	awful.button({ }, 4, function() chd(-1) end),
	awful.button({ }, 5, function() chd(1) end),
	awful.button({ }, 1, function() 
		naughty.notify({text = usbMount(disks[hl])}) end),
	awful.button({ }, 3, function()
		t = usbUnmount(disks[hl]) .. '\n\n' .. lsof(disks[hl])
		if t ~= '' then naughty.notify({text = t, timeout = 10}) end 
	end)))
usbimg.visible = usbCheck()
usbimg_timer = timer({ timeout = 3 })
usbimg_timer:add_signal('timeout', function ()
	usbimg.visible = usbCheck() end)
usbimg_timer:start()

