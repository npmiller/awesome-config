-- Wicd interface
--
local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local capi = { dbus = dbus }
local naughty = require('naughty')
capi.dbus.add_match("session", "interface='org.wicd.daemon',member='wireless'")
local net = { 
	wired_list = { },
	wireless_list = { },
	dev = { wired = 'eth0', wireless = 'wlan0' },
	hl =  { network_id = 0, wireless = false   },
	img = wibox.widget.imagebox(),
	tooltip = awful.tooltip({ })
}
net.tooltip:add_to_object(net.img)
net.img:connect_signal('mouse::enter', 
function()
	net:list_all_networks()
	net:update() 
	if net:wireless_connected() then
		net.tooltip:set_text(string.format('<span font_desc="monospace 10">%s</span>', net:wless_parse()))
	else
		local c, ip = net:wired_connected()
		if c then
			net.tooltip:set_text(string.format('<span font_desc="monospace 10">%s</span>', 'Connecté en filaire (' .. ip .. ')'))
		else
			net.tooltip:set_text(net:show_all())
		end
	end
end)
net.img:buttons(awful.util.table.join(
awful.button({ }, 4, function() net:dec() net.tooltip:set_text(net:show_all()) end),
awful.button({ }, 5, function() net:inc() net.tooltip:set_text(net:show_all()) end),
awful.button({ }, 1, function() net:connect(net.hl.network_id, net.hl.wireless) end), 
awful.button({ }, 3, function() net:list_all_networks() net.tooltip:set_text(net:show_all()) end)
))


function net:inc()
	self.hl.network_id = self.hl.network_id + 1
	if self.hl.wireless then
		if self.hl.network_id + 1 > #self.wireless_list then
			self.hl.network_id = 0
			self.hl.wireless = false
		end
	else
		if self.hl.network_id + 1 > #self.wired_list then
			self.hl.network_id = 0
			self.hl.wireless = true
		end
	end
end

function net:dec()
	self.hl.network_id = self.hl.network_id - 1
	if self.hl.wireless then
		if self.hl.network_id < 0 then
			self.hl.network_id = #self.wired_list - 1
			self.hl.wireless = false
		end
	else
		if self.hl.network_id < 0 then
			self.hl.network_id = #self.wireless_list - 1
			self.hl.wireless = true
		end
	end
end

function net:wired_connected()
	wired = io.popen('ip addr show dev '..self.dev.wired):read("*all")
	ip = string.match(wired, "inet (%d?%d?%d%.%d?%d?%d%.%d?%d?%d%.%d?%d?%d)")
	if  ip ~= nil then 
		return true, ip
	else
		return false, ''
	end
end

function net:connect(network_id, wireless)
	if wireless then
		os.execute('wicd-cli --wireless -n '..self.hl.network_id..' -c')
	else 
		os.execute('wicd-cli --wired -n '..self.hl.network_id..' -c')
	end
end

function net:wireless_connected()
	wireless = io.popen('ip addr show dev '..self.dev.wireless):read("*all")
	if string.match(wireless, "inet (%d?%d?%d%.%d?%d?%d%.%d?%d?%d%.%d?%d?%d)") ~= nil then
		return true --, string.match(wireless, "inet (%d?%d?%d%.%d?%d?%d%.%d?%d?%d%.%d?%d?%d)")
	else
		return false --, ''
	end
end

function net:list_all_networks()
	wired = io.popen('wicd-cli --wired -l')
	--wireless = io.popen('wicd-cli --wireless -l')
	wireless = io.popen('python2 ~/.config/awesome/widgets/wicd-curses.py')
	
	self.wired_list = { }
	for line in wired:lines() do
		table.insert(self.wired_list, awful.util.escape(line))
	end
	table.remove(self.wired_list, 1)
	self.wireless_list = { }
	for line in wireless:lines() do
		table.insert(self.wireless_list, awful.util.escape(line))
	end
	--table.remove(self.wireless_list, 1)
	wired:close()
	wireless:close()
end

function net:show_all()
	local res = 'Wired :\n'
	for i=1,#self.wired_list do
		if not self.hl.wireless and i == self.hl.network_id + 1 then
			res = res .. '<u>' .. self.wired_list[i] .. '</u>\n'
		else
			res = res .. self.wired_list[i] .. '\n'
		end
	end
	res = res .. 'Wireless :\n'
	for i=1,#self.wireless_list do
		if self.hl.wireless and i == self.hl.network_id + 1 then
			res = res .. '<u>' .. self.wireless_list[i] .. '</u>\n'
		else
			res = res .. self.wireless_list[i] .. '\n'
		end
	end
	return string.format('<span font_desc="monospace 10">%s</span>', res)
end

function net:wless_parse()
	t = io.popen('wicd-cli --wireless -d'):read("*all")
	res = 'Connecté à '
		.. string.match(t, 'Essid: (.-)%c')
		.. ' '
		.. '('..string.match(t, 'Quality: (.-)%c') ..'%'..')'
	return res
end

function net:update()
	if self:wired_connected() then
		self.img:set_image(beautiful.net_wired)
	else
		if self:wireless_connected() then
			self.img:set_image(beautiful.net_up_01)
		else
			self.img:set_image(beautiful.net_down_01)
		end
	end
end

return net
