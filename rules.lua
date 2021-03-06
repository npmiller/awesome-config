local rules = require("awful.rules")
local beautiful = require('beautiful')
-- {{{ Rules
rules.rules = {
	-- All clients will match this rule.
	{ rule = { },
	properties = { border_width = beautiful.border_width,
	border_color = beautiful.border_normal,
	focus = true,
	keys = clientkeys,
	buttons = clientbuttons,
	size_hints_honor = false --<--- remove gap between windows
} },
{ rule = { class = "MPlayer" }, properties = { floating = true } },
{ rule = { class = "pinentry" }, properties = { floating = true } },
{ rule = { class = "gimp" }, properties = { floating = true } },
{ rule = { class = "Gnuplot" }, properties = { floating = true } }, 
{ rule = { class = "Plasma" }, properties = { floating = true } }, 
{ rule = { name = "plasma-desktop" }, properties = { floating = true } }, 
{ rule = { class = "Avant-window-navigator" }, properties = { floating = true, ontop = true, border_width = "0" } }, 
-- Apps repartition
{ rule = { class = "Firefox" }, properties = { tag = tags[1][1], maximised=true, floating=false } },
{ rule = { name = "plugin-container" }, properties = { floating = true } },
{ rule = { name = "exe" }, properties = { floating = true, titlebar = false } },
{ rule = { class = "LilyTerm" }, properties = { tag = tags[1][2] } },
{ rule = { class = "Thunar" }, properties = { tag = tags[1][4] } },
{ rule = { class = "Epdfview" }, properties = { tag = tags[1][3] }},
{ rule = { class = "Zathura" }, properties = { tag = tags[1][3] } },
{ rule = { class = "luakit" }, properties = { tag = tags[1][1] } },
{ rule = { class = "Abiword" }, properties = { tag = tags[1][3] } },
{ rule = { class = "Gnumeric" }, properties = { tag = tags[1][3] } },
{ rule = { class = "Gvim" }, properties = { tag = tags[1][3] } },
{ rule = { class = "Sonata" }, properties = { tag = tags[1][7] } },
{ rule = { class = "Evolution" }, properties = { tag = tags[1][8] } },
{ rule = { class = "Thunderbird" }, properties = { tag = tags[1][8], floating = false } },
{ rule = { class = "Xchat" }, properties = { tag = tags[1][9] } },
{ rule = { class = "Quasselclient" }, properties = { tag = tags[1][9] } },
{ rule = { class = "Vlc" }, properties = { tag = tags[1][5] } },
{ rule = { class = "Scilab" }, properties = { floating = true } },
	}
	-- }}}

