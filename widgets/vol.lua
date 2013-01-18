-- Sound Control
local beautiful = require('beautiful')
local wibox = require('wibox')
local awful = require('awful')

local volume = { }

function volume:new(cardid, channel, props)
	local props = props or { }
	local bar_props = props.bar_props or { }
	local vol = { }

	vol.cardid = cardid -- 0
	vol.channel = channel or 'Master' -- Master
	vol.imgs = { normalimg = props.normalimg or beautiful.spkr_01, muteimg = props.mutemimg or beautiful.spkr_02 }


	vol.img = wibox.widget.imagebox()

	vol.bar = awful.widget.progressbar()


	vol.bar:set_width(bar_props.width or 50)
	vol.bar:set_height(bar_props.height or 6)
	vol.bar:set_vertical(bar_props.vertical or false)
	vol.bar:set_background_color(bar_props.bg_color or beautiful.bg_normal or "#434343")
	vol.bar:set_border_color(nil or bar_props.border_color)
	vol.bar:set_color(bar_props.fg_color or beautiful.fg_normal)

	vol.barm = wibox.layout.margin(vol.bar, 0, 0, 6, 4)

	setmetatable(vol, {__index = self})

	return vol
end

function volume:update()
		local fd = io.popen("amixer -c " .. self.cardid .. " -- sget " .. self.channel)
		local status = fd:read("*all")
		fd:close()

		local vol = string.match(status, "(%d?%d?%d)%%")
		vol = string.format("% 3d", vol)
		status = string.match(status, "%[(o[^%]]*)%]")
		if string.find(status, "on", 1, true) then
			self.bar:set_value(vol/100)
			self.img:set_image(self.imgs.normalimg)
		else
			self.bar:set_value(vol/100)
			self.img:set_image(self.imgs.muteimg)
		end
end

function volume:up()
		io.popen("amixer sset " .. self.channel .. " 5%+"):read("*all")
		self:update()
end

function volume:down()
		io.popen("amixer sset " .. self.channel .. " 5%-"):read("*all")
		self:update()
end

function volume:toggle()
		io.popen("amixer sset " .. self.channel .. " toggle"):read("*all")
		self:update()
end
--Le :read("*all") permet d'attendre un peu de sorte que la fonction update puisse détecter les changements

return volume
