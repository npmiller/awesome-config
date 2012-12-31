--Battery applet
--
local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local setmetatable = setmetatable

local battery = { }

function battery:new(bat_name, props)
	local props = props or { }
	local imgs = props.imgs or { charging = beautiful.ac_01, discharging = beautiful.bat_empty_01 }
	local bar_props = props.bar_props or { }
	local bar_margins = props.bar_margins or { }

	local bat = { }
	
	bat.bat_name = bat_name
	-- Creating progressbar
	bat.bar = awful.widget.progressbar()
	-- Setting progressbar properties
	bat.bar:set_width(bar_props.width or 50)
	bat.bar:set_height(bar_props.width or 6)
	bat.bar:set_vertical(bar_props.vertical or false)
	bat.bar:set_background_color(bar_props.bg_color or beautiful.bg_normal or '#434343')
	bat.bar:set_border_color(nil or bar_props.border_color)
	bat.bar:set_color(bar_props.fg_color or beautiful.fg_normal or '#000000')
	-- Settings margins on the progressbar
	bat.barm = wibox.layout.margin(bat.bar, bar_margins.left or 0,
											bar_margins.right or 0,
											bar_margins.top or 6,
											bar_margins.bottom or 4)
	-- Icons
	bat.img = wibox.widget.imagebox()
	bat.imgs = imgs
	--Full charge :
	io.input('/sys/class/power_supply/' .. bat.bat_name .. '/charge_full')
	bat.full_charge = tonumber(io.read("*line"))

	setmetatable(bat, {__index = self})

	return bat
end

function battery.update(self)
	--Current charge :
	io.input("/sys/class/power_supply/" .. self.bat_name .. "/charge_now")
	local current_charge = tonumber(io.read("*line"))

	--Battery state :
	io.input("/sys/class/power_supply/" .. self.bat_name .. "/status")
	local status = io.read("*line")
	
	local charge = (current_charge/self.full_charge)

	if string.match(status,"Discharging") then
		if charge <= 0.15 then
			self.bar:set_value(charge)
			self.img:set_image(self.imgs.discharging)
		else
			self.bar:set_value(charge)
			self.img:set_image(self.imgs.discharging)
		end
	elseif string.match(status,"Charging") then
		self.bar:set_value(charge)
		self.img:set_image(self.imgs.charging)
	else
		self.bar:set_value(charge)
		self.img:set_image(self.imgs.charging)
	end
end

return battery
