-- Standard awesome library
require('awful')
require('awful.autofocus')
-- Theme handling library
require('beautiful')
-- Notification library
require('naughty')

--:Wrequire('revelation')
--Widgets
--require('mocp')
require('lib/runBackground')

--awful.util.spawn_with_shell('xcompmgr')
--awful.util.spawn_with_shell('xsetroot -cursor_name left_ptr')
--awful.util.spawn_with_shell('wicd-client --tray')
awful.util.spawn_with_shell('urxvtd')
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

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
require('widgets.clock')
mytextclock = widgets.clock({ }, 60, "%A %e %B %H:%M")
require('widgets.cal')
widgets.cal.register(mytextclock.widget)

--cal.register(mytextclock)

-- Create a systray
mysystray = widget({ type = 'systray' })

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
awful.button({ }, 4, awful.tag.viewnext),
awful.button({ }, 5, awful.tag.viewprev)
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
	mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	mylayoutbox[s] = awful.widget.layoutbox(s)
	mylayoutbox[s]:buttons(awful.util.table.join(
	awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
	awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
	awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
	awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
	-- Create a taglist widget
	mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

	-- Create a tasklist widget
	mytasklist[s] = awful.widget.tasklist(function(c)
		return awful.widget.tasklist.label.currenttags(c, s)
	end, mytasklist.buttons)

	--Volume control
	require('widgets/vol')
	volume("update",volbar,volimg)

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
	require('widgets/battery')
	--Refresh battery applet
	bat(batbar,batimg)
	batbar_timer = timer({ timeout = 7 })
	batbar_timer:add_signal('timeout', function () bat(batbar,batimg) end)
	batbar_timer:start()

	require('widgets/usbmount')

	require('widgets/spacers')

	-- Create the wibox
	require('lib.layout.center')
	mywibox[s] = awful.wibox({ position = 'top', screen = s, height = '18' })
	-- Add widgets to the wibox - order matters
	mywibox[s].widgets = {
		{
			mylauncher, mytaglist[s], mypromptbox[s],
			layout = awful.widget.layout.horizontal.leftright
		},
		{
			mytextclock.widget,
			layout = lib.layout.center.absolute
		},
		{
			space,
			rbracket,space,volbar.widget,volimg,lbracket,
			space,
			rbracket,space,batbar.widget,batimg,lbracket,
			space,
			usbimg,
		--	rbracket,mpdtext,lbracket,
		--	tools.irc.widget,
			layout = awful.widget.layout.horizontal.rightleft
		},

		layout = awful.widget.layout.horizontal.flex
	}
	my2wibox = awful.wibox({ position = 'bottom', screen = s, height = '18' })

	my2wibox.widgets = {
		mylayoutbox[s],
		mysystray,
		mytasklist[s],
		layout = awful.widget.layout.horizontal.rightleft
	} 
end
-- }}}

require('bindings')

require('rules')

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal('manage', function (c, startup)
	-- Add a titlebar
	-- awful.titlebar.add(c, { modkey = modkey })

	-- Enable sloppy focus
	c:add_signal('mouse::enter', function(c)
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
end)

client.add_signal('focus', function(c) c.border_color = beautiful.border_focus end)
client.add_signal('unfocus', function(c) c.border_color = beautiful.border_normal end)
-- }}}
