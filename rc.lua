-- Standard awesome library
local awful = require('awful')
--require('awful.autofocus')
-- Theme handling library
local beautiful = require('beautiful')
-- Notification library
local naughty = require('naughty')
--wibox
local wibox = require('wibox')

local gears = require('gears')

--:Wrequire('revelation')
--Widgets
--require('mocp')
require('lib/runBackground')

--awful.util.spawn_with_shell('xcompmgr')
--awful.util.spawn_with_shell('xsetroot -cursor_name left_ptr')
--awful.util.spawn_with_shell('wicd-client --tray')
awful.util.spawn_with_shell('urxvtd')

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init('/home/nicolas/.config/awesome/themes/perso/theme.lua')

-- This is used later as the default terminal and editor to run.
terminal = 'urxvtc'
editor = os.getenv('EDITOR') or 'vim'
editor_cmd = terminal .. ' -e ' .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = 'Mod4'

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
	awful.layout.suit.floating, --1
	awful.layout.suit.tile, --2
	awful.layout.suit.tile.left, --3
	awful.layout.suit.tile.bottom, --4
	awful.layout.suit.tile.top, --5
	awful.layout.suit.fair, --6
	awful.layout.suit.fair.horizontal, --7
	--	    awful.layout.suit.spiral, --8
	--	    awful.layout.suit.spiral.dwindle, --9
	--	    awful.layout.suit.max, --10
	--	    awful.layout.suit.max.fullscreen, --11
	--	    awful.layout.suit.magnifier --12
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
	names = { 'web' , 'term' , 'office' ,'file' , 'film' , 'misc' ,  'music' , 'mail' , 'im' },
	layout = { layouts[1] , layouts[2] , layouts[2] , layouts[2] , layouts[2] , layouts[2] , layouts[2] , layouts[2] , layouts[2] } 
}
for s = 1, screen.count() do
	-- Each screen has its own tag table.
	tags[s] = awful.tag(tags.names , s, tags.layout)
end

-- }}}

require('menus')

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
--require('widgets.clock')
--mytextclock = widgets.clock({ }, 60, "%A %e %B %H:%M")
--require('widgets.cal')
--widgets.cal.register(mytextclock.widget)

--cal.register(mytextclock)

-- Create a systray
mysystray = wibox.widget.systray

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
awful.button({ }, 1, awful.tag.viewonly),
awful.button({ modkey }, 1, awful.client.movetotag),
awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({ modkey }, 3, awful.client.toggletag),
awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
awful.button({ }, 1, function (c)
	if c == client.focus then
		c.minimized = true
	else
		if not c:isvisible() then
			awful.tag.viewonly(c:tags()[1])
		end
		-- This will also un-minimize
		-- the client, if needed
		client.focus = c
		c:raise()
	end
end),
awful.button({ }, 3, function ()
	if instance then
		instance:hide()
		instance = nil
	else
		instance = awful.menu.clients({ width=250 })
	end
end),
awful.button({ }, 4, function ()
	awful.client.focus.byidx(1)
	if client.focus then client.focus:raise() end
end),
awful.button({ }, 5, function ()
	awful.client.focus.byidx(-1)
	if client.focus then client.focus:raise() end
end))

for s = 1, screen.count() do
	-- Create a promptbox for each screen
	mypromptbox[s] = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	mylayoutbox[s] = awful.widget.layoutbox(s)
	mylayoutbox[s]:buttons(awful.util.table.join(
	awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
	awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
	awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
	awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
	-- Create a taglist widget
	mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

	-- Create a tasklist widget
	mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

	--Volume control
	local volume = require('widgets/vol')
	volume:update()

	--Mpd widget
--	require('widgets/mpd')

	--Irc widget
--	require('widgets.irc')
--	tools = { }
--	tools.irc = widgets.irc({ }, {
--		text = "<span font_desc='Dejavu Sans 11'>&#x2318;</span>",
--		highlights = { 'pata' },
--		clientname = 'weechat-curses',
--	})

	--Battery applet
	local bat = require('widgets/battery')
	battery = bat:new('BAT0')

	--Refresh battery applet
	battery:update()
	batbar_timer = timer({ timeout = 7 })
	batbar_timer:connect_signal('timeout', function () battery:update() end)
	batbar_timer:start()

	local usb = require('widgets/usbmount')

	local spacers = require('widgets/spacers')

	-- Create the wibox
	--require('lib.layout.center')
	mywibox[s] = awful.wibox({ position = 'top', screen = s, height = '18' })
	-- Add widgets to the wibox - order matters
		local left_layout = wibox.layout.fixed.horizontal()
		left_layout:add(mylauncher)
		left_layout:add(mytaglist[s])
		left_layout:add(mypromptbox[s])

		local right_layout = wibox.layout.fixed.horizontal()
		right_layout:add(usb.img)
		right_layout:add(spacers.space) 
		right_layout:add(spacers.lbracket) right_layout:add(spacers.space) right_layout:add(volume.barm)
		right_layout:add(volume.img) right_layout:add(spacers.rbracket)
		right_layout:add(spacers.lbracket) right_layout:add(spacers.space)
		right_layout:add(battery.barm) right_layout:add(battery.img) right_layout:add(spacers.rbracket)
		right_layout:add(spacers.space)

		local layout = wibox.layout.align.horizontal()
		layout:set_left(left_layout)
		layout:set_right(right_layout)
		mywibox[s]:set_widget(layout)

	my2wibox = awful.wibox({ position = 'bottom', screen = s, height = '18' })
		local layout2 = wibox.layout.align.horizontal()
		layout2:set_left(mylayoutbox[s], mysystray)
		layout2:set_right(mytasklist[s])
		my2wibox:set_widget(layout2)
end
-- }}}

require('bindings')

require('rules')

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal('manage', function (c, startup)
	-- Add a titlebar
	-- awful.titlebar.add(c, { modkey = modkey })

	-- Enable sloppy focus
	c:connect_signal('mouse::enter', function(c)
		if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
			and awful.client.focus.filter(c) then
			client.focus = c
		end
	end)

	if not startup then
		-- Set the windows at the slave,
		-- i.e. put it at the end of others instead of setting it master.
		-- awful.client.setslave(c)

		-- Put windows in a smart way, only if they does not set an initial position.
		if not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_overlap(c)
			awful.placement.no_offscreen(c)
		end
	end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal('focus', function(c) c.border_color = beautiful.border_focus end)
client.connect_signal('unfocus', function(c) c.border_color = beautiful.border_normal end)
-- }}}
