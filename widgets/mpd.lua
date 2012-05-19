function mpd_update (textbox)
	local f = io.popen('mpc')
	local text = f:read('*all')
	f:close()
	if text:find('[playing]') then
		textbox.text = text:sub(0,(text:find('\n') - 1))
--		button.image = image(beautiful.pause)
	elseif text:find('[paused]') then
		textbox.text = text:sub(0,(text:find('\n') - 1))
--		button.image = image(beautiful.play)
--	else
--		button.image = image(beautiful.play)
	end
end

--	mpdlauncher = awful.widget.launcher({ image = image(beautiful.play), command = 'mpc toggle' })
	mpdtext = widget({type = 'textbox'})
	
	mpd_timer = timer({ timeout = 3 })
	mpd_timer:add_signal('timeout', function () mpd_update(mpdtext) end)
	mpd_timer:start()
