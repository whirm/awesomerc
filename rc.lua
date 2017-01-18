local print = print
print('+++++++++++++++++++++++++Starting teh win+++++++++++++++++++++++++++++++')
-- @DOC_REQUIRE_SECTION@
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local tyrannical = require("tyrannical")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- {{{ Error handling
-- @DOC_ERROR_HANDLING@
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
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

require("collision")()

vicious = require("vicious")

-- {{{ Variable definitions
-- @DOC_LOAD_THEME@
-- Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.get_configuration_dir() .. "themes/whirm/theme.lua")


-- @DOC_DEFAULT_APPLICATIONS@
-- This is used later as the default terminal and editor to run.
terminal = "urxvtcd"
editor   = "emacs"
-- editor = os.getenv("EDITOR") or "emacs"
-- editor_cmd = terminal .. " -e " .. editor
editor_cmd = editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
alt    = "Mod1"

-- @DOC_LAYOUT@
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.max,
  awful.layout.suit.fair,
  awful.layout.suit.tile,
  awful.layout.suit.tile.bottom,
  -- awful.layout.suit.floating,
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- @DOC_MENU@
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
-- @TAGLIST_BUTTON@
local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

-- @TASKLIST_BUTTON@
local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

-- @DOC_WALLPAPER@
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)


tyrannical.tags = {
  {
    name          = "1",
    key           = "1",
    index         = 1,
    screen        = 1,
    layout        = awful.layout.suit.fair, -- Use the tile layout
    init          = true,
    selected      = true,
    exclusive     = false,
    fallback      = true,
  },
  {
    name          = "2",
    key           = "2",
    index         = 2,
    init          = true,
    screen        = 1,
    layout        = awful.layout.suit.fair, -- Use the tile layout
    exclusive     = false,
  },
  {
    name          = "3",
    key           = "3",
    index         = 3,
    init          = true,
    screen        = 1,
    layout        = awful.layout.suit.fair, -- Use the tile layout
  },
  {
    name          = "4",
    key           = "4",
    index         = 4,
    init          = true,
    screen        = 1,
    layout        = awful.layout.suit.fair, -- Use the tile layout
    exclusive     = false,
  },
  {
    name          = "5",
    key           = "5",
    index         = 5,
    init          = true,
    screen        = 1,
    layout        = awful.layout.suit.fair, -- Use the tile layout
    exclusive     = false,
  },
  {
    name          = "6",
    key           = "6",
    index         = 6,
    init          = true,
    screen        = 1,
    layout        = awful.layout.suit.fair, -- Use the tile layout
    exclusive     = false,
  },
  {
    name          = "7",
    key           = "7",
    index         = 7,
    init          = true,
    screen        = 1,
    layout        = awful.layout.suit.fair, -- Use the tile layout
    exclusive     = false,
  },
  {
    name          = "8",
    key           = "8",
    index         = 8,
    init          = true,
    screen        = 1,
    layout        = awful.layout.suit.fair, -- Use the tile layout
    exclusive     = false,
  },
  {
    name          = "9",
    key           = "9",
    index         = 9,
    init          = true,
    screen        = 1,
    layout        = awful.layout.suit.fair, -- Use the tile layout
    exclusive     = false,
  },
  {
    name          = "Develop",
    key           = "q",
    index         = 10,
    --exec_once   = {"emacs"}, --When the tag is accessed for the first time, execute this command
    init          = true,
    --exclusive   = true,
    screen        = 1,
    clone_on      = 2, -- Create a single instance of this tag on screen 1, but also show it on screen 2
    no_focus_stealing = true,
    exclusive     = true,
    -- The tag can be used on both screen, but only one at once
    layout        = awful.layout.suit.max.fullscreen,
    class         = {
      "Kate", "KDevelop", "Codeblocks", "Code::Blocks" , "DDD", "kate4", "Emacs"}
  },
  {
    name          = "Internet",
    key           ="w",
    index         = 11,
    init          = true,
    exclusive     = true,
    --icon        = "~net.png",                 -- Use this icon for the tag (uncomment with a real path)
    screen        = screen.count()>1 and 2 or 1,-- Setup on screen 2 if there is more than 1 screen, else on screen 1
    layout        = awful.layout.suit.max,      -- Use the max layout
    class         = {
      "Opera"         , "Firefox"        , "Rekonq"    , "Dillo"    , "Arora",
      "Chromium"      , "nightly"        , "minefield" , "Iceweasel", "weechat 0.4.1" }
  },
  {
    name          = "Doc",
    key           = "e",
    index         = 12,
    screen        = screen.count(),
    init          = true, -- This tag wont be created at startup, but will be when one of the
    -- client in the "class" section will start. It will be created on
    -- the client startup screen
    exclusive     = true,
    layout        = awful.layout.suit.max,
    class         = {
      "Assistant"     , "Okular"         , "Evince"    , "EPDFviewer"   , "xpdf",
      "Xpdf"          ,                                        }
  },
}

-- Ignore the tag "exclusive" property for the following clients (matched by classes)
tyrannical.properties.intrusive = {
  "ksnapshot"     , "pinentry"       , "gtksu"     , "kcalc"        , "xcalc"               ,
  "feh"           , "Gradient editor", "About KDE" , "Paste Special", "Background color"    ,
  "kcolorchooser" , "plasmoidviewer" , "Xephyr"    , "kruler"       , "plasmaengineexplorer",
  "assword",        "gcr-prompter",
}

-- Ignore the tiled layout for the matching clients
tyrannical.properties.floating = {
  "MPlayer"       , "pinentry"        , "ksnapshot"  , "pinentry"     , "gtksu"          ,
  "xine"          , "feh"             , "kmix"       , "kcalc"        , "xcalc"          ,
  "yakuake"       , "Select Color$"   , "kruler"     , "kcolorchooser", "Paste Special"  ,
  "New Form"      , "Insert Picture"  , "kcharselect", "mythfrontend" , "plasmoidviewer",  "assword"
}

-- Make the matching clients (by classes) on top of the default layout
tyrannical.properties.ontop = {
  "Xephyr"        , "ksnapshot"       , "kruler",      "Gkrellm",       "assword",         "gcr-prompter",
}

-- Force the matching clients (by classes) to be centered on the screen on init
tyrannical.properties.centered = {
  "kcalc", "assword", "gcr-prompter",
}

tyrannical.properties.size_hints_honor = { xterm = false, URxvt = false, aterm = false, sauer_client = false, mythfrontend  = false, Steam = true, assword=true}
--tyrannical.properties.fullscreen = { Emacs = false, Emacs24 = false }
tyrannical.properties.focusable = { Gkrellm = false } -- Doesn't seem to work for gkrellm
tyrannical.properties.border_width = { Gkrellm = 0, Emacs = 0, Emacs24 = 0, Emacs25 = 0, spacemacs = 0, iceweasel = 0, KRuler = 0, assword=0 }
tyrannical.properties.default_layout = awful.layout.suit.tile
tyrannical.settings.mwfact = 0.66

-- Keyboard map indicator and changer
-- TODO: use the official keyboard layout widget
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "us", "" , "US" }, { "es", "" , "ES" } }
kbdcfg.current = 1  -- us is our default layout
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.widget:set_text(" " .. kbdcfg.layout[kbdcfg.current][3] .. " ")
kbdcfg.switch = function ()
  kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
  local t = kbdcfg.layout[kbdcfg.current]
  kbdcfg.widget:set_text(" " .. t[3] .. " ")
  os.execute( "(" .. kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] .. "; sleep 0.3 ; xmodmap ~/.xmodmap.mackeyboard) &" )
end

-- Mouse bindings
kbdcfg.widget:buttons(
  awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch() end))
)


-- Unique widgets

-- batt
vicious.cache(vicious.widgets.bat)
ac_widget = wibox.widget {
  align = "center",
  text = "X",
  widget = wibox.widget.textbox,
}
vicious.register(ac_widget, vicious.widgets.bat, "$1", 2, "BAT0")

batmon = wibox.container {
  ac_widget,
  color        = beautiful.fg_batt_low,
  border_color = beautiful.fg_batt_crit,
  border_width = 0,
  background_color = beautiful.border_marked,
  max_value = 1,
  thickness = 2,
  widget = wibox.container.arcchart
}
batmon.t = awful.tooltip({ objects = { batmon.widget },})
vicious.register(batmon, vicious.widgets.bat, function (widget, args)
                   batmon.t:set_text(" State: " .. args[1] .. " | Charge: " .. args[2] .. "% | Remaining: " .. args[3])
                   if args[2] <= 5 then
                     naughty.notify({ text="Battery is low! " .. args[2] .. " percent remaining." })
                   end
                   return args[2]
                                              end , 60, "BAT0")

-- CPU cores
vicious.cache(vicious.widgets.cpu)
cores = wibox.widget {
  forced_width = 20,
  layout  = wibox.layout.flex.horizontal,
}
for scr=1,4 do
  local w = wibox.widget {
    max_value     = 1,
    color         = beautiful.cpu_st,
    background_color = beautiful.bg_systray,
    widget        = wibox.widget.progressbar,
  }
  local we = wibox.container {
    w,
    direction = 'east',
    widget    = wibox.container.rotate
  }
  vicious.register(w, vicious.widgets.cpu, "$"..(scr+1).."",1)
  cores:add(we)
end

-- CPU usage
cpuwidget = wibox.widget {
  color = "#BBAABB",
  max_value = 1,
  step_width = 3,
  step_spacing = 1,
  widget = wibox.widget.graph
}
vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 1)

-- MEM usage
memwidget = wibox.widget {
  color = "#AABBAA",
  max_value = 1,
  step_width = 3,
  step_spacing = 1,
  widget = wibox.widget.graph
}
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem, '$1', 1)

-- Disk IO
diskwidget = wibox.container {
  max_value = 6,
  thickness = 1,
  widget = wibox.container.arcchart
}
vicious.cache(vicious.widgets.dio)
vicious.register(diskwidget, vicious.widgets.dio, "${sda iotime_s}", 1)


-- @DOC_FOR_EACH_SCREEN@
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table. (nope, we use tyrannical)
    -- awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- @DOC_WIBAR@
    -- Create the wibox
    s.mywibox = awful.wibar({ position = "bottom", screen = s })

    left_layout = wibox.widget { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
      s.mytaglist,
      s.mypromptbox,
    }

    if s.index == 1 then
      left_layout:add(batmon,
                      cores,
                      cpuwidget,
                      diskwidget,
                      memwidget)
    end

    -- @DOC_SETUP_WIDGETS@
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        left_layout,
        s.mytasklist, -- Middle widget
        { -- Right widgets
          layout = wibox.layout.fixed.horizontal,
          mykeyboardlayout,
          kbdcfg.widget,
          wibox.widget.systray(),
          mytextclock,
          s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
-- @DOC_ROOT_BUTTONS@
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
-- @DOC_GLOBAL_KEYBINDINGS@
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end,
        {description = "focus previous by index", group = "client"}
    ),
    -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
    --          {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn(editor) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),

    -- Other handy commands
    awful.key({ modkey, "Shift"   }, "l", function () awful.util.spawn("i3lock -c 332244 -d -I 300") end),
    awful.key({ modkey, "Shift"   }, "p", function () awful.util.spawn("assword gui") end),

    -- That's F18 on an apple alu keyboard
    awful.key({                   }, "XF86Launch9", function () awful.util.spawn("sudo systemctl suspend") end),
    awful.key({                   }, "XF86Search", function () awful.util.spawn("sudo systemctl suspend") end),

    -- Laptop backlight control
    awful.key({                   }, "XF86MonBrightnessUp",   function () awful.util.spawn("light -A 10") end),
    awful.key({         "Shift"   }, "XF86MonBrightnessUp",   function () awful.util.spawn("light -S 100") end),
    awful.key({                   }, "XF86MonBrightnessDown", function () awful.util.spawn("light -U 10") end),
    awful.key({         "Shift"   }, "XF86MonBrightnessDown", function () awful.util.spawn("light -S 1") end),

    awful.key({                   }, "XF86AudioRaiseVolume",  function () awful.util.spawn("amixer sset Master 5%+") end),
    awful.key({                   }, "XF86AudioLowerVolume",  function () awful.util.spawn("amixer sset Master 5%-") end),
    awful.key({                   }, "XF86AudioMute",         function () awful.util.spawn("amixer sset Master 1+ toggle") end),


    -- awful.key({ modkey, "Shift"   }, "q", awesome.quit,
    --           {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt TODO: this should show the bar first
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

-- @DOC_CLIENT_KEYBINDINGS@
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- @DOC_NUMBER_KEYBINDINGS@
-- Bind all key numbers to tags.

for name, ttag in pairs(tyrannical.tags_by_name) do
  if ttag.key then
    globalkeys = awful.util.table.join(globalkeys,
                                       awful.key({ modkey }, ttag.key,
                                         function ()
                                           local tag = get_or_create_tag(name,ttag)
                                           if tag then
                                             tag:view_only()
                                           end
                                       end),
                                       awful.key({ modkey, "Control" }, ttag.key,
                                         function ()
                                           local tag = get_or_create_tag(name,ttag)
                                           if tag then
                                             awful.tag.viewtoggle(tag)
                                           end
                                       end),
                                       awful.key({ modkey, "Shift" }, ttag.key,
                                         function ()
                                           local tag = get_or_create_tag(name,ttag)
                                           if client.focus and tag then
                                             client.focus:move_to_tag(tag)
                                             tag:view_only()
                                           end
                                       end),
                                       awful.key({ modkey, "Control", "Shift" }, ttag.key,
                                         function ()
                                           local tag = get_or_create_tag(name,ttag)
                                           if client.focus and tag then
                                             client.focus:toggle_tag(tag)
                                           end
                                       end)

    )
  end
end

function get_or_create_tag(name,ttag)
  if ttag and ttag.instances then
    tag = ttag.instances[awful.screen.focused().index]
    if tag ~= nil then
      return tag
    else
      -- There's no tag for the current screen, find on another
      for _,tag in pairs(ttag.instances) do
        return tag
      end
    end
  else
    print("TTAG noinstances")
    local tag = awful.tag.add(ttag.name, ttag)
    -- If the ttag has the index atribute set move the tag to its position
    -- if ttag.index then
    --    reorder_tags()
    -- end
    return tag
  end
end

-- @DOC_CLIENT_BUTTONS@
clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
-- @DOC_RULES@
awful.rules.rules = {
    -- @DOC_GLOBAL_RULE@
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     -- size_hints_honor = false,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- @DOC_FLOATING_RULE@
    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- @DOC_DIALOG_RULE@
    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
-- @DOC_MANAGE_HOOK@
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- @DOC_TITLEBARS@
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
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
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- @DOC_BORDER@
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
