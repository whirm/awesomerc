local print = print

path="/home/whirm/.config/awesome/themes"
local theme_dir=path.."/whirm"

print('#########'..theme_dir)

local function rgb(red, green, blue)
  if type(red) == "number" or type(green) == "number" or type(blue) == "number" then
    return "#"..string.format("%02x",red)..string.format("%02x",green)..string.format("%02x",blue)
  else
    return nil
  end
end

local function rgba(red, green, blue, alpha)
  if type(red) == "number" or type(green) == "number" or type(blue) == "number" or type(alpha) == "number" then
    return "#"..string.format("%02x",red)..string.format("%02x",green)..string.format("%02x",blue)..string.format("%02x",alpha * 255)
  else
    return nil
  end
end

--colors
local bordeaux= rgb(47,28,28)
local light_bordeaux = rgba(191,64,64,0.6)
local grey = "#444444ff"
local light_grey = "#555555"
local white = "#ffffff"
local light_white = "#999999"
local black = "#000000"
local light_black = "#232323"


-- {{{ Main
theme = {}
theme.wallpaper = { theme_dir.."/background.png" }
--theme.wallpaper_cmd = { "awsetbg -l" }
--theme.wallpaper_cmd = { "xsetroot" }
-- }}}

-- {{{ Styles
theme.font      = "terminus 8"

-- {{{ Colors
theme.bg_normal = "#3F3F3F"
theme.bg_focus  = "#8b4500"
theme.bg_urgent = "#8b1a1a"
theme.bg_minimize   = light_grey
theme.bg_systray    = theme.bg_normal

theme.fg_normal = "#DCDCCC"
theme.fg_focus  = "#F0DFAF"
theme.fg_urgent = "#CC9393"
theme.fg_minimize   = light_white


-- }}}
-- specific
theme.fg_sb_hi     = "#cfcfff"
theme.fg_batt_mid  = "#00cb00"
theme.fg_batt_low  = "#e6f21d"
theme.fg_batt_crit = "#f8700a"
theme.widg_cpu_st  = "#243367"
theme.widg_cpu_mid = "#285577"
theme.widg_cpu_end = "#AEC6D8"
theme.vol_bg       = "#000033"


-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = "#111111"
theme.border_focus  = "#6F1111"
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

-- There are other variable sets overriding the default one when defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]


theme.tasklist_bg_focus = "#455b1f"
theme.tasklist_fg_focus = "#Bdbdbd"
--theme.taglist_bg_normal= "#333333"
--theme.titlebar_bg_normal =
--theme.titlebar_bg_focus =


-- {{{ Widgets
-- You can add as many variables as you wish and access them by using beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- You can add as many variables as you wish and access them by using beautiful.variable in your rc.lua


-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_dir.."/submenu.png"
theme.menu_border_width = 3
theme.menu_border_color = theme.bg_normal
theme.menu_height = 15
theme.menu_width  = 100
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = theme_dir.."/taglist/squarefz.png"
theme.taglist_squares_unsel = theme_dir.."/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = theme_dir.."/awesome-icon.png"
theme.menu_submenu_icon      = theme_dir.."/default/submenu.png"
theme.tasklist_floating_icon = theme_dir.."/default/layouts/floating.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = theme_dir.."/layouts/tile.png"
theme.layout_tileleft   = theme_dir.."/layouts/tileleft.png"
theme.layout_tilebottom = theme_dir.."/layouts/tilebottom.png"
theme.layout_tiletop    = theme_dir.."/layouts/tiletop.png"
theme.layout_fairv      = theme_dir.."/layouts/fairv.png"
theme.layout_fairh      = theme_dir.."/layouts/fairh.png"
theme.layout_spiral     = theme_dir.."/layouts/spiral.png"
theme.layout_dwindle    = theme_dir.."/layouts/dwindle.png"
theme.layout_max        = theme_dir.."/layouts/max.png"
theme.layout_fullscreen = theme_dir.."/layouts/fullscreen.png"
theme.layout_magnifier  = theme_dir.."/layouts/magnifier.png"
theme.layout_floating   = theme_dir.."/layouts/floating.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = theme_dir.."/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme_dir.."/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = theme_dir.."/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme_dir.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = theme_dir.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme_dir.."/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = theme_dir.."/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme_dir.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = theme_dir.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme_dir.."/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = theme_dir.."/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme_dir.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = theme_dir.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme_dir.."/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = theme_dir.."/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme_dir.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme_dir.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme_dir.."/titlebar/maximized_normal_inactive.png"
-- }}}

-- Define the icon theme for application icons. If not set then the icons from /usr/share/icons and
-- /usr/share/icons/hicolor will be used.
--theme.icon_theme = "/home/cedlemo/.icons/AwOkenDark"
theme.blingbling = {
    graph_background_color = "#00000000",
    graph_color = light_white,
    graph_line_color = light_white,
    text_color = light_white,
    reboot = theme_dir .. "/reboot.png",
    shutdown = theme_dir .. "/shutdown.png",
    logout = theme_dir .. "/logout.png",
    accept = theme_dir .. "/ok.png",
    cancel = theme_dir .. "/cancel.png",
    lock = theme_dir .. "/lock.png",
    tagslist = {    normal ={   background_color = "#303030",--rgb(26,26,26),
                                text_background_color = "#00000000", --no color
                                rounded_size = { 0, 0.4,0,0.4 },
                                text_color = theme.fg_normal,
                                font = "Droid Sans",
                                font_size = 7
                            },
                    focus ={    h_margin = 1,
                                v_margin = 1,
                                background_color = rgb(59,162,117),--"#999999",
                                text_background_color = "#303030",--theme.bg_normal,
                                text_color = theme.fg_normal,
                                rounded_size = { 0, 0.4,0,0.4 },
                                font = "Droid Sans",
                                font_size = 8
                            }
    }
}
theme.blingbling.tagslist.urgent = theme.blingbling.tagslist.focus
theme.blingbling.tagslist.occupied = theme.blingbling.tagslist.normal

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
