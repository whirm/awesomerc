local print = print

path="/home/whirm/.config/awesome/themes"
local theme_dir=path.."/whirm"

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


local theme = {}

theme.font          = "terminus 8"

theme.bg_normal     = "#3F3F3F"
theme.bg_focus      = "#8b4500"
theme.bg_alternate  = "#2B2B2B"
theme.bg_urgent     = "#8b1a1a"
theme.bg_minimize   = light_grey
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#DCDCCC"
theme.fg_focus      = "#F0DFAF"
theme.fg_urgent     = "#CC9393"
theme.fg_minimize   = light_white

theme.useless_gap   = 0
theme.border_width  = 1
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = theme_dir.."/taglist/squarefz.png"
theme.taglist_squares_unsel = theme_dir.."/taglist/squarez.png"
--theme.taglist_squares_resize = "false"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_border_width = 3
theme.menu_border_color = theme.bg_normal
theme.menu_submenu_icon = theme_dir.."/submenu.png"
theme.menu_height = 15
theme.menu_width  = 100

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"

theme.fg_sb_hi     = "#cfcfff"
theme.fg_batt_mid  = "#00cb00"
theme.fg_batt_low  = "#e6f21d"
theme.fg_batt_crit = "#f8700a"
theme.cpu_end      = "#243367"
theme.cpu_mid      = "#285577"
theme.cpu_st        = "#AEC6D8"
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


theme.tasklist_bg_focus = "#455b1f"
theme.tasklist_fg_focus = "#Bdbdbd"
--theme.taglist_bg_normal= "#333333"
--theme.titlebar_bg_normal =
--theme.titlebar_bg_focus =


-- Define the image to load
theme.titlebar_close_button_normal = theme_dir.."/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme_dir.."/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = theme_dir.."/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = theme_dir.."/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme_dir.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme_dir.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme_dir.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme_dir.."/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_dir.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme_dir.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme_dir.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme_dir.."/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_dir.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme_dir.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme_dir.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme_dir.."/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_dir.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme_dir.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme_dir.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme_dir.."/titlebar/maximized_focus_active.png"

theme.wallpaper = theme_dir.."/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh      = theme_dir.."/layouts/fairh.png"
theme.layout_fairv      = theme_dir.."/layouts/fairv.png"
theme.layout_floating   = theme_dir.."/layouts/floating.png"
theme.layout_magnifier  = theme_dir.."/layouts/magnifier.png"
theme.layout_max        = theme_dir.."/layouts/max.png"
theme.layout_fullscreen = theme_dir.."/layouts/fullscreen.png"
theme.layout_tilebottom = theme_dir.."/layouts/tilebottom.png"
theme.layout_tileleft   = theme_dir.."/layouts/tileleft.png"
theme.layout_tile       = theme_dir.."/layouts/tile.png"
theme.layout_tiletop    = theme_dir.."/layouts/tiletop.png"
theme.layout_spiral     = theme_dir.."/layouts/spiral.png"
theme.layout_dwindle    = theme_dir.."/layouts/dwindle.png"
theme.layout_cornernw   = theme_dir.."/layouts/cornernww.png"
theme.layout_cornerne   = theme_dir.."/layouts/cornernew.png"
theme.layout_cornersw   = theme_dir.."/layouts/cornersww.png"
theme.layout_cornerse   = theme_dir.."/layouts/cornersew.png"

theme.awesome_icon           = theme_dir.."/awesome-icon.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
