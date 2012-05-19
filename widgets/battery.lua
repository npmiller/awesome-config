--Battery applet
--
--Full charge :
io.input("/sys/class/power_supply/BAT0/charge_full")
full_charge = tonumber(io.read("*line"))

function bat(bar,img)
	--Current charge :
	io.input("/sys/class/power_supply/BAT0/charge_now")
	current_charge = tonumber(io.read("*line"))

	--Battery state :
	io.input("/sys/class/power_supply/BAT0/status")
	status = io.read("*line")
	
	charge = (current_charge/full_charge)

	if string.match(status,"Discharging") then
		if charge <= 0.15 then
			bar:set_value(charge)
			img.image = image(beautiful.bat_empty_01)
		else
			bar:set_value(charge)
			img.image = image(beautiful.bat_empty_01)
		end
	elseif string.match(status,"Charging") then
		bar:set_value(charge)
		img.image= image(beautiful.ac_01)
	else
		bar:set_value(charge)
		img.image= image(beautiful.ac_01)
	end
end

batbar = awful.widget.progressbar()
batbar:set_width(50)
batbar:set_height(6)
batbar:set_vertical(false)
batbar:set_background_color("#434343")
batbar:set_border_color(nil)
batbar:set_gradient_colors({ beautiful.fg_normal, beautiful.fg_normal, beautiful.fg_normal, beautiful.bar })
awful.widget.layout.margins[batbar.widget] = { top = 6 }

batimg = widget({ type = "imagebox" })
batimg.image = image(beautiful.ac_01)
