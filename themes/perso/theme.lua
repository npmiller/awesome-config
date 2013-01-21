-------------------------------
--  "Fedora16" awesome theme --
--    By Nicolas M.          --
-------------------------------

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons


-- Theme's folder
folder = "/home/nicolas/.config/awesome/themes/perso/"

-- {{{ Main
theme = {}
theme.wallpaper = "/home/nicolas/Pics/Wallpapers/nintendo.jpg"
-- }}}

-- {{{ Styles
--theme.font      = "DejaVuSansMono 8"

-- {{{ Colors
theme.fg_normal = "#FFFFFF"
theme.fg_focus  = "#FFFFFF"
theme.fg_urgent = "#FFFFFF"
theme.bg_normal = "#000000"
theme.bg_focus  = "#000000"
theme.bg_urgent = "#EA6868"
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#242424"
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
--theme.titlebar_bg_focus  = "#3F3F3F"
--theme.titlebar_bg_normal = "#000000"
theme.titlebar_fg_focus = "FFFFFF"
theme.titlebar_fg_normal = "8F8F8F"
-- }}}

--There are other variable sets
--overriding the default one when
--defined, the sets are:
--[taglist|tasklist]_[bg|fg]_[focus|urgent]
--titlebar_[normal|focus]
--tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
theme.taglist_bg_focus = "#000000"
theme.taglist_fg_focus = "#8F8F8F8F"
theme.tasklist_bg_focus = "#000000"
theme.tasklist_fg_focus = "#FFFFFF"
theme.tasklist_fg_normal = "#8F8F8F"
theme.tooltip_bg_color = "#000000"
theme.tooltip_fg_color = "#FFFFFF"
theme.tooltip_opacity = "0.75"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = "15"
theme.menu_width  = "160"
theme.menu_fg_normal = "#FFFFFF"
theme.menu_bg_focus = "#242424"
theme.menu_bg_normal = "#000000"
theme.menu_border_width = "0"
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = folder .. "taglist/squaref.png"
theme.taglist_squares_unsel = folder .. "taglist/square_b.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = folder .. "awesome-icon.png"
theme.menu_submenu_icon      = folder .. "submenu.png"
theme.tasklist_floating_icon = folder .. "tasklist/floatingw.png"

icon_folder = folder .. "icons/White18x18/"

theme.ac_01 = icon_folder .. "ac_01.png"
theme.arch = icon_folder .. "arch.png"
theme.arch_10x10 = icon_folder .. "arch_10x10.png"
theme.bat_empty_01 = icon_folder .. "bat_empty_01.png"
theme.bat_empty_02 = icon_folder .. "bat_empty_02.png"
theme.bat_full_01 = icon_folder .. "bat_full_01.png"
theme.bat_full_02 = icon_folder .. "bat_full_02.png"
theme.bat_low_01 = icon_folder .. "bat_low_01.png"
theme.bat_low_02 = icon_folder .. "bat_low_02.png"
theme.bluetooth = icon_folder .. "bluetooth.png"
theme.bug_01 = icon_folder .. "bug_01.png"
theme.bug_02 = icon_folder .. "bug_02.png"
theme.cat = icon_folder .. "cat.png"
theme.clock = icon_folder .. "clock.png"
theme.cpu = icon_folder .. "cpu.png"
theme.dish = icon_folder .. "dish.png"
theme.diskette = icon_folder .. "diskette.png"
theme.empty = icon_folder .. "empty.png"
theme.eye_l = icon_folder .. "eye_l.png"
theme.eye_r = icon_folder .. "eye_r.png"
theme.fox = icon_folder .. "fox.png"
theme.fs_01 = icon_folder .. "fs_01.png"
theme.fs_02 = icon_folder .. "fs_02.png"
theme.full = icon_folder .. "full.png"
theme.fwd = icon_folder .. "fwd.png"
theme.half = icon_folder .. "half.png"
theme.info_01 = icon_folder .. "info_01.png"
theme.info_02 = icon_folder .. "info_02.png"
theme.info_03 = icon_folder .. "info_03.png"
theme.mail = icon_folder .. "mail.png"
theme.mem = icon_folder .. "mem.png"
theme.mouse_01 = icon_folder .. "mouse_01.png"
theme.net_down_01 = icon_folder .. "net_down_01.png"
theme.net_down_02 = icon_folder .. "net_down_02.png"
theme.net_down_03 = icon_folder .. "net_down_03.png"
theme.net_up_01 = icon_folder .. "net_up_01.png"
theme.net_up_02 = icon_folder .. "net_up_02.png"
theme.net_up_03 = icon_folder .. "net_up_03.png"
theme.net_wired = icon_folder .. "net_wired.png"
theme.next = icon_folder .. "next.png"
theme.note = icon_folder .. "note.png"
theme.pacman = icon_folder .. "pacman.png"
theme.pause = icon_folder .. "pause.png"
theme.phones = icon_folder .. "phones.png"
theme.play = icon_folder .. "play.png"
theme.plug = icon_folder .. "plug.png"
theme.prev = icon_folder .. "prev.png"
theme.rwd = icon_folder .. "rwd.png"
theme.scorpio = icon_folder .. "scorpio.png"
theme.shroom = icon_folder .. "shroom.png"
theme.spkr_01 = icon_folder .. "spkr_01.png"
theme.spkr_02 = icon_folder .. "spkr_02.png"
theme.spkr_03 = icon_folder .. "spkr_03.png"
theme.stop = icon_folder .. "stop.png"
theme.temp = icon_folder .. "temp.png"
theme.test = icon_folder .. "test.png"
theme.usb = icon_folder .. "usb.png"
theme.usb_02 = icon_folder .. "usb_02.png"
theme.wifi_01 = icon_folder .. "wifi_01.png"
theme.wifi_02 = icon_folder .. "wifi_02.png"

-- }}}

-- {{{ Layout
theme.layout_tile       = folder .. "layouts/tile.png"
theme.layout_tileleft   = folder .. "layouts/tileleft.png"
theme.layout_tilebottom = folder .. "layouts/tilebottom.png"
theme.layout_tiletop    = folder .. "layouts/tiletop.png"
theme.layout_fairv      = folder .. "layouts/fairv.png"
theme.layout_fairh      = folder .. "layouts/fairh.png"
theme.layout_spiral     = folder .. "layouts/spiral.png"
theme.layout_dwindle    = folder .. "layouts/dwindle.png"
theme.layout_max        = folder .. "layouts/max.png"
theme.layout_fullscreen = folder .. "layouts/fullscreen.png"
theme.layout_magnifier  = folder .. "layouts/magnifier.png"
theme.layout_floating   = folder .. "layouts/floating.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = folder .. "titlebar/close_focus.png"
theme.titlebar_close_button_normal = folder .. "titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = folder .. "titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = folder .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = folder .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = folder .. "titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = folder .. "titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = folder .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = folder .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = folder .. "titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = folder .. "titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = folder .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = folder .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = folder .. "titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = folder .. "titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = folder .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = folder .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = folder .. "titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme
