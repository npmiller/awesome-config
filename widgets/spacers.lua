local wibox = require('wibox')

local spacers = { }
spacers.vert = wibox.widget.textbox()
spacers.vert:set_text(' | ')

spacers.space = wibox.widget.textbox()
spacers.space:set_text(' ')

spacers.lbracket =  wibox.widget.textbox()
spacers.lbracket:set_text(' [ ')

spacers.rbracket =  wibox.widget.textbox()
spacers.rbracket:set_text(' ] ')

return spacers
