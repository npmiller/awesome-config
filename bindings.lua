local awful = require('awful')
local menubar = require('menubar')
local naughty = require('naughty')

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
awful.button({ }, 3, function () mymainmenu:toggle() end),
awful.button({ }, 4, awful.tag.viewnext),
awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
awful.key({ modkey,           }, 'Left',   awful.tag.viewprev       ),
awful.key({ modkey,           }, 'Right',  awful.tag.viewnext       ),
awful.key({ modkey,           }, 'Escape', awful.tag.history.restore),

awful.key({ modkey,           }, 'j',
function ()
	awful.client.focus.byidx( 1)
	if client.focus then client.focus:raise() end
end),

awful.key({ modkey,           }, 'k',
function ()
	awful.client.focus.byidx(-1)
	if client.focus then client.focus:raise() end
end),

awful.key({ modkey,           }, 'w', function () mymainmenu:show({keygrabber=true}) end),

-- Layout manipulation
awful.key({ modkey, 'Shift'   }, 'j', function () awful.client.swap.byidx(  1)    end),
awful.key({ modkey, 'Shift'   }, 'k', function () awful.client.swap.byidx( -1)    end),
awful.key({ modkey, 'Control' }, 'j', function () awful.screen.focus_relative( 1) end),
awful.key({ modkey, 'Control' }, 'k', function () awful.screen.focus_relative(-1) end),
awful.key({ modkey,           }, 'u', awful.client.urgent.jumpto),
awful.key({ modkey,           }, 'Tab',
function ()
	awful.client.focus.history.previous()
	if client.focus then
		client.focus:raise()
	end
end),

--Multimedia keys
awful.key({ }, 'XF86AudioRaiseVolume', function () volume:up() end),
awful.key({ }, 'XF86AudioLowerVolume', function () volume:down() end),
awful.key({ }, 'XF86AudioMute', function () volume:toggle() end),
awful.key({ }, 'XF86AudioPlay', function () awful.util.spawn_with_shell('ncmpcpp toggle') end),     	
awful.key({ }, 'XF86AudioNext', function () awful.util.spawn_with_shell('ncmpcpp next') end),     	
awful.key({ }, 'XF86AudioPrev', function () awful.util.spawn_with_shell('ncmpcpp prev') end),     	
awful.key({modkey}, 'e', revelation),
awful.key({modkey}, 'v', function() awful.util.spawn_with_shell('slimlock') end),

--Print Screen
--awful.key({ 'Control' }, 'Print', function () awful.util.spawn_with_shell('emprint /home/nicolas/Screenshots/') end),
awful.key({ modkey }, 'Print', function () awful.util.spawn_with_shell('emprint --region /home/nicolas/Screenshots') end),
awful.key({ modkey, 'shift' }, 'Print', function () awful.util.spawn_with_shell('emprint --window /home/nicolas/Screenshots') end),

-- Standard program
awful.key({ modkey,           }, 'Return', function () awful.util.spawn(terminal) end),
awful.key({ modkey, 'Control' }, 'r', awesome.restart),
awful.key({ modkey, 'Shift'   }, 'q', awesome.quit),

awful.key({ modkey,           }, 'l',     function () awful.tag.incmwfact( 0.05)    end),
awful.key({ modkey,           }, 'h',     function () awful.tag.incmwfact(-0.05)    end),
awful.key({ modkey, 'Shift'   }, 'h',     function () awful.tag.incnmaster( 1)      end),
awful.key({ modkey, 'Shift'   }, 'l',     function () awful.tag.incnmaster(-1)      end),
awful.key({ modkey, 'Control' }, 'h',     function () awful.tag.incncol( 1)         end),
awful.key({ modkey, 'Control' }, 'l',     function () awful.tag.incncol(-1)         end),
awful.key({ modkey,           }, 'space', function () awful.layout.inc(layouts,  1) end),
awful.key({ modkey, 'Shift'   }, 'space', function () awful.layout.inc(layouts, -1) end),

awful.key({ modkey, 'Control' }, 'n', awful.client.restore),

-- Prompt
awful.key({ modkey },            'r',     function () mypromptbox[mouse.screen]:run() end),

awful.key({ modkey }, 'x',
function ()
	awful.prompt.run({ prompt = 'Run Lua code: ' },
	mypromptbox[mouse.screen].widget,
	awful.util.eval, nil,
	awful.util.getdir('cache') .. '/history_eval')
end),
awful.key({modkey }, 'c', function()
	awful.prompt.run({ prompt = 'Calculate: ' }, mypromptbox[mouse.screen].widget,
	function (expr)
		local result = awful.util.eval('return (' .. expr .. ')')
		naughty.notify({ text = expr .. ' = ' .. result, timeout = 10 })
	end,
	nil,
	awful.util.getdir('cache') .. '/history_calc'
	)
end),
awful.key({modkey, 'Shift'}, 's', function ()
	awful.prompt.run({prompt = 'Say: '}, mypromptbox[mouse.screen].widget,
		function (expr)
			awful.util.spawn_with_shell('espeak ' .. expr)
		end
		)
	end
	),
awful.key({modkey }, 'd', function()
	awful.prompt.run({ prompt = 'Desktop: ' }, mypromptbox[mouse.screen].widget,
	function (name) 
		if string.sub(name,1,1) == '+' then
			name = string.sub(name,2,-1)
			for i=1,#tags.names do
				if name == tags.names[i] then
					awful.tag.viewtoggle(tags[mouse.screen][i])
				end
			end
		else
			for i=1,#tags.names do
				if name == tags.names[i] then
					awful.tag.viewonly(tags[mouse.screen][i])
				end
			end	
		end 
	end, nil, awful.util.getdir('cache') .. '/history_desk'
	)
end),

awful.key({ modkey, 'Shift' }, 'p', function()
	awful.prompt.run({ prompt = 'Ping: ' }, mypromptbox[mouse.screen].widget,
	function (expr)
		run_background('ping -c 5 '.. expr, function(result)
			naughty.notify({ text = expr .. ' = ' .. result, timeout = 0 }) end)
		end,
		nil,
		awful.util.getdir('cache') .. '/history_ping'
		)
	end),
	awful.key({ modkey }, 's', function()
		awful.prompt.run({ prompt = 'Search: ' }, mypromptbox[mouse.screen].widget,
		function (expr) 
			awful.util.spawn_with_shell('firefox https://duckduckgo.com/?q=' .. expr)
			awful.tag.viewonly(tags[mouse.screen][1])
		end,
		nil,
		awful.util.getdir('cache') .. '/history_search'
		)
	end),
	awful.key({modkey}, 'i', function()
		awful.prompt.run({ prompt = 'install: '}, mypromptbox[mouse.screen].widget,
		function (expr)
			awful.util.spawn_with_shell(terminal .. ' -e yaourt -S '..expr) end,
			nil,
			awful.util.getdir('cache') .. '/history_install')
		end),
			
    awful.key({ modkey }, "p", function() menubar.show() end)

	)

	clientkeys = awful.util.table.join(
	awful.key({ modkey,           }, 'f',      function (c) c.fullscreen = not c.fullscreen  end),
	awful.key({ modkey, 'Shift'   }, 'c',      function (c) c:kill()                         end),
	awful.key({ modkey, 'Control' }, 'space',  awful.client.floating.toggle                     ),
	awful.key({ modkey, 'Control' }, 'Return', function (c) c:swap(awful.client.getmaster()) end),
	awful.key({ modkey,           }, 'o',      awful.client.movetoscreen                        ),
	awful.key({ modkey,           }, 't',      function (c) c.ontop = not c.ontop            end),
	awful.key({ modkey,           }, 'n',
	function (c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end),
	awful.key({ modkey,           }, 'm',
	function (c)
		c.maximized_horizontal = not c.maximized_horizontal
		c.maximized_vertical   = not c.maximized_vertical
	end)
	)

	-- Compute the maximum number of digit we need, limited to 9
	keynumber = 0
	for s = 1, screen.count() do
		keynumber = math.min(9, math.max(#tags[s], keynumber));
	end

	-- Bind all key numbers to tags.
	-- Be careful: we use keycodes to make it works on any keyboard layout.
	-- This should map on the top row of your keyboard, usually 1 to 9.
	for i = 1, keynumber do
		globalkeys = awful.util.table.join(globalkeys,
		awful.key({ modkey }, '#' .. i + 9,
		function ()
			local screen = mouse.screen
			if tags[screen][i] then
				awful.tag.viewonly(tags[screen][i])
			end
		end),
		awful.key({ modkey, 'Control' }, '#' .. i + 9,
		function ()
			local screen = mouse.screen
			if tags[screen][i] then
				awful.tag.viewtoggle(tags[screen][i])
			end
		end),
		awful.key({ modkey, 'Shift' }, '#' .. i + 9,
		function ()
			if client.focus and tags[client.focus.screen][i] then
				awful.client.movetotag(tags[client.focus.screen][i])
			end
		end),
		awful.key({ modkey, 'Control', 'Shift' }, '#' .. i + 9,
		function ()
			if client.focus and tags[client.focus.screen][i] then
				awful.client.toggletag(tags[client.focus.screen][i])
			end
		end))
	end

	clientbuttons = awful.util.table.join(
	awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
	awful.button({ modkey }, 1, awful.mouse.client.move),
	awful.button({ modkey }, 3, awful.mouse.client.resize))

	-- Set keys
	root.keys(globalkeys)
	-- }}}

