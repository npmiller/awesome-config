-- Enable mocp
function moc_control (action)
    local moc_info,moc_state

    if action == "next" then
        io.popen("mocp --next")
    elseif action == "previous" then
        io.popen("mocp --previous")
    elseif action == "stop" then
        io.popen("mocp --stop")
    elseif action == "play_pause" then
        moc_info = io.popen("mocp -i"):read("*all")
            moc_state = string.gsub(string.match(moc_info, "State: %a*"),"State: ","")

        if moc_state == "PLAY" then
            io.popen("mocp --pause")
        elseif moc_state == "PAUSE" then
            io.popen("mocp --unpause")
        elseif moc_state == "STOP" then
            io.popen("mocp --play")
        end
    end
end


function hook_moc()
       moc_info = io.popen("mocp -i"):read("*all")
       moc_state = string.gsub(string.match(moc_info, "State: %a*"),"State: ","")
       if moc_state == "PLAY" or moc_state == "PAUSE" then
           moc_artist = string.gsub(string.match(moc_info, "Artist: %C*"), "Artist: ","")
           moc_title = string.gsub(string.match(moc_info, "SongTitle: %C*"), "SongTitle: ","")
           moc_curtime = string.gsub(string.match(moc_info, "CurrentTime: %d*:%d*"), "CurrentTime: ","")
           moc_totaltime = string.gsub(string.match(moc_info, "TotalTime: %d*:%d*"), "TotalTime: ","")
           if moc_artist == "" then
               moc_artist = "unknown artist"
           end
           if moc_title == "" then
               moc_title = "unknown title"
           end
       -- moc_title = string.format("%.5c", moc_title)
           moc_string = moc_artist .. " - " .. moc_title .. "(" .. moc_curtime .. "/" .. moc_totaltime .. ")"
           if moc_state == "PAUSE" then
               moc_string = "▮▮ " .. moc_string .. ""
           end
       else
           moc_string = "-- not playing --"
       end
       return moc_string
end

  -- Moc Widget
    tb_moc = widget({ type = "textbox", align = "right" })
    tb_moc:buttons(awful.util.table.join(
  --  awful.button({ modkey }, 1, function () awful.util.spawn_with_shell(terminal.." -e mocp") end),
    awful.button({ }, 1, function () moc_control("play_pause") end),
    --awful.button({ }, 3 , function () mymocmenu:show() end),
    awful.button({ }, 4, function () moc_control("next") end),
    awful.button({ }, 5, function () moc_control("previous") end)
    ))
    -- refresh Moc widget
    --awful.hooks.timer.register(1, function() tb_moc.text = '| ' .. hook_moc() .. ' ' end)
    moc_timer = timer({timeout = 1})
    moc_timer:add_signal("timeout", function() tb_moc.text = hook_moc() end)
    moc_timer:start()


