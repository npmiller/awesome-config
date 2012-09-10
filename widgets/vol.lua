-- Sound Control
cardid  = 0
channel = "Master"
normalimg = image(beautiful.spkr_01)
muteimg = image(beautiful.spkr_02)

function volume (mode,bar,img)
	if mode == "update" then
             local fd = io.popen("amixer -c " .. cardid .. " -- sget " .. channel)
             local status = fd:read("*all")
             fd:close()
 
		local volume = string.match(status, "(%d?%d?%d)%%")
		volume = string.format("% 3d", volume)
		status = string.match(status, "%[(o[^%]]*)%]")
		if string.find(status, "on", 1, true) then
			bar:set_value(volume/100)
			img.image = normalimg
		else
			bar:set_value(volume/100)
			img.image = muteimg
		end
		
	elseif mode == "up" then
		io.popen("amixer sset " .. channel .. " 5%+"):read("*all")
		volume("update",bar,img)
	elseif mode == "down" then
		io.popen("amixer sset " .. channel .. " 5%-"):read("*all")
		volume("update",bar,img)
	else
		io.popen("amixer sset " .. channel .. " toggle"):read("*all")
		volume("update",bar,img)
	end
end
volimg = widget({type = "imagebox"})
volimg.image = normalimg

	volimg:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) volume("update",volbar,volimg)  end),
    awful.button({ }, 3, function () awful.util.spawn("urxvtc -e alsamixer", true) end),
    awful.button({ }, 4, function () volume("up",volbar,volimg) end),
    awful.button({ }, 5, function () volume("down",volbar,volimg) end)
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
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) volume("update",volbar,volimg) end),
    awful.button({ }, 3, function () awful.util.spawn("urxvtc -e alsamixer", true) end),
    awful.button({ }, 4, function () volume("up",volbar,volimg) end),
    awful.button({ }, 5, function () volume("down",volbar,volimg) end)
	))

