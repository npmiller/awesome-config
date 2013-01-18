-- Sound Control
local beautiful = require('beautiful')
local wibox = require('wibox')
local awful = require('awful')

local vol = { }
local cardid  = 0
local channel = "Master"
local normalimg = beautiful.spkr_01
local muteimg = beautiful.spkr_02

function volume (mode, bar, img)
	if mode == "update" then
             local fd = io.popen("amixer -c " .. cardid .. " -- sget " .. channel)
             local status = fd:read("*all")
             fd:close()
 
		local volume = string.match(status, "(%d?%d?%d)%%")
		volume = string.format("% 3d", volume)
		status = string.match(status, "%[(o[^%]]*)%]")
		if string.find(status, "on", 1, true) then
			bar:set_value(volume/100)
			img:set_image(normalimg)
		else
			bar:set_value(volume/100)
			img:set_image(muteimg)
		end
		
	elseif mode == "up" then
		io.popen("amixer sset " .. channel .. " 5%+"):read("*all")
		volume("update",bar,img)
	elseif mode == "down" then
		io.popen("amixer sset " .. channel .. " 5%-"):read("*all")
		volume("update", bar, img)
	else
		io.popen("amixer sset " .. channel .. " toggle"):read("*all")
		volume("update", bar, img)
	end
end
vol.img = wibox.widget.imagebox()
vol.img:set_image(normalimg)

	vol.img:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) volume("update",vol.bar,vol.img)  end),
    awful.button({ }, 3, function () awful.util.spawn("urxvtc -e alsamixer", true) end),
    awful.button({ }, 4, function () volume("up",vol.bar,vol.img) end),
    awful.button({ }, 5, function () volume("down",vol.bar,vol.img) end)
	))

vol.bar = awful.widget.progressbar()
vol.bar:set_width(50)
vol.bar:set_height(6)
vol.bar:set_vertical(false)
vol.bar:set_background_color("#434343")
vol.bar:set_border_color(nil)
vol.bar:set_color(beautiful.fg_normal)
--awful.widget.layout.margins[volbar.widget] = { top = 6 }

	vol.bar:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) volume("update",vol.bar,vol.img) end),
    awful.button({ }, 3, function () awful.util.spawn("urxvtc -e alsamixer", true) end),
    awful.button({ }, 4, function () volume("up",vol.bar,vol.img) end),
    awful.button({ }, 5, function () volume("down",vol.bar,vol.img) end)
	))
vol.update = function (self)
	volume("update", self.bar, self.img)
end

vol.barm = wibox.layout.margin(vol.bar, 0, 0, 6, 4)

return vol
