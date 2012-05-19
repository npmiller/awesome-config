-- Sound Control
cardid  = 0
channel = "Master"
function volume (mode,bar)
	if mode == "update" then
             local fd = io.popen("amixer -c " .. cardid .. " -- sget " .. channel)
             local status = fd:read("*all")
             fd:close()
 
		local volume = string.match(status, "(%d?%d?%d)%%")
		volume = string.format("% 3d", volume)
		status = string.match(status, "%[(o[^%]]*)%]")
		if string.find(status, "on", 1, true) then
			bar:set_value(volume/100)
		else
			bar:set_value(volume/100)
			
		end
		
	elseif mode == "up" then
		io.popen("amixer sset " .. channel .. " 5%+"):read("*all")
		volume("update",bar)
	elseif mode == "down" then
		io.popen("amixer sset " .. channel .. " 5%-"):read("*all")
		volume("update",bar)
	else
		io.popen("amixer sset " .. channel .. " toggle"):read("*all")
		volume("update",bar)
	end
end
volimg = widget({type = "imagebox"})
volimg.image = image(beautiful.note)

	volimg:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) end),
    awful.button({ }, 3, function () awful.util.spawn("urxvtc -e alsamixer", true) end),
    awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 5dB+", false) end),
    awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 5dB-", false) end)
	))

volbar = awful.widget.progressbar()
volbar:set_width(50)
volbar:set_height(6)
volbar:set_vertical(false)
volbar:set_background_color("#434343")
volbar:set_border_color(nil)
volbar:set_gradient_colors({ beautiful.fg_normal, beautiful.fg_normal, beautiful.fg_normal, beautiful.bar })
awful.widget.layout.margins[volbar.widget] = { top = 6 }

	volbar.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) end),
    awful.button({ }, 3, function () awful.util.spawn("urxvtc -e alsamixer", true) end),
    awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 5dB+", false) end),
    awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 5dB-", false) end)
	))

