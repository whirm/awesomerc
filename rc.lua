local print = print
print('+++++++++++++++++++++++++Starting teh win+++++++++++++++++++++++++++++++')

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
local tyrannical = require("tyrannical")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

require("collision")()


-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
--beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init("/home/whirm/.config/awesome/themes/whirm/theme.lua")

local blingbling = require("blingbling")
vicious = require("vicious")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtcd -e zsh"
--editor = os.getenv("EDITOR") or "editor"
--editor_cmd = terminal .. " -e " .. editor
editor = "emacs"
editor_cmd = editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
alt    = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
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
    -- awful.layout.suit.magnifier
}
-- }}}


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
      class         ={
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
    "assword", "gcr-prompter",
}

-- Ignore the tiled layout for the matching clients
tyrannical.properties.floating = {
    "MPlayer"       , "pinentry"        , "ksnapshot"  , "pinentry"     , "gtksu"          ,
    "xine"          , "feh"             , "kmix"       , "kcalc"        , "xcalc"          ,
    "yakuake"       , "Select Color$"   , "kruler"     , "kcolorchooser", "Paste Special"  ,
    "New Form"      , "Insert Picture"  , "kcharselect", "mythfrontend" , "plasmoidviewer", "assword"
}

-- Make the matching clients (by classes) on top of the default layout
tyrannical.properties.ontop = {
    "Xephyr"        , "ksnapshot"       , "kruler", "Gkrellm", "assword", "gcr-prompter",
}

-- Force the matching clients (by classes) to be centered on the screen on init
tyrannical.properties.centered = {
    "kcalc", "assword", "gcr-prompter",
}

tyrannical.properties.size_hints_honor = { xterm = false, URxvt = false, aterm = false, sauer_client = false, mythfrontend  = false, Steam = true, assword=true}
--tyrannical.properties.fullscreen = { Emacs = false, Emacs24 = false }
tyrannical.properties.focusable = { Gkrellm = false } -- Doesn't seem to work for gkrellm
tyrannical.properties.border_width = { Gkrellm = 0, Emacs = 0, Emacs24 = 0, iceweasel = 0, KRuler = 0, assword=0 }
tyrannical.properties.default_layout = awful.layout.suit.tile
tyrannical.settings.mwfact = 0.66

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
       gears.wallpaper.maximized(beautiful.wallpaper[s] or beautiful.wallpaper[1], s, true)
    end
end
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ MPD WIDGET
-- }}} MPD WIDGET

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

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
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
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

-- Keyboard map indicator and changer
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

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "bottom", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()

    if s == 1 then
       -- CPUWIDGET
       vicious.cache(vicious.widgets.cpu)
       -- Initialize widget
       cpu_graph = blingbling.line_graph({ height = 18,
                                           width = 120,
                                           --graph_background_color = "#00000033"
       })
       -- Register widget
       vicious.register(cpu_graph, vicious.widgets.cpu, "$1")
       mywibox[1]:set_widget(cpu_graph)
       left_layout:add(cpu_graph)

       -- CORE WIDGETS
       cores_graph_conf = {
          height = 18,
          width = 6,
          h_margin = 1,
          filled = true,
       }
       cores_graphs = {}
       for scr=1,8 do
          w = blingbling.progress_graph( cores_graph_conf)
          cores_graphs[scr] = w
          vicious.register(w, vicious.widgets.cpu, "$"..(scr+1).."",1)
          left_layout:add(w)
       end

       -- MEMORY WIDGET
       memwidget = blingbling.line_graph({ height = 18,
                                           width = 120,
                                           graph_line_color = "#8080FA",
                                           tiles = false,
                                           })
       --memwidget:set_graph_color("#3030EA")
       left_layout:add(memwidget)


       vicious.register(memwidget, vicious.widgets.mem, '$1', 1)

       right_layout:add(wibox.widget.systray())

       -- Add widget to your layout
       right_layout:add(kbdcfg.widget)
    end

    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    --awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

function nextEmptyTag()
   --gears.debug.dump(client.focus, "")
   if client.focus then s = client.focus.screen else s = mouse.screen end
   current_tag = awful.tag.getidx(awful.tag.selected(s))
   looped_tag = nil
   tags = awful.tag.gettags(s)
   for i=1,#tags,1 do
      if i > current_tag then
         if #tags[i]:clients() > 0 then
            awful.tag.viewonly(tags[i])
            return
         end
      else
         if i < current_tag then
            if #tags[i]:clients() > 0 and not looped_tag then
               looped_tag = tags[i]
            end
         end
      end
   end
   if looped_tag then awful.tag.viewonly(looped_tag) end
end

function prevEmptyTag()
   if client.focus then s = client.focus.screen else s = mouse.screen end
   current_tag = awful.tag.getidx(awful.tag.selected(s))
   looped_tag = nil
   tags = awful.tag.gettags(s)
   for i=#tags,1,-1 do
      if i < current_tag then
         if #tags[i]:clients() > 0 then
            awful.tag.viewonly(tags[i])
            return
         end
      else
         if i > current_tag then
            if #tags[i]:clients() > 0 and not looped_tag then
               looped_tag = tags[i]
            end
         end
      end
   end
   if looped_tag then awful.tag.viewonly(looped_tag) end
end

-- {{{ Key bindings
globalkeys = awful.util.table.join(
   -- awful.key({ alt, "Control"    }, "Left", prevEmptyTag),
   -- awful.key({ alt, "Control"    }, "Right", nextEmptyTag),
   -- awful.key({ modkey,           }, "Up", awful.tag.viewprev),
   -- awful.key({ modkey,           }, "Down",  awful.tag.viewnext       ),
   awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Shift"   }, "Return", function () awful.util.spawn(editor) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    --awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({ modkey, "Shift"   }, "z", kbdcfg.switch),
    awful.key({ modkey, "Shift"   }, "l", function () awful.util.spawn("i3lock -c 332244 -d -I 300") end),
    awful.key({ modkey, "Shift"   }, "p", function () awful.util.spawn("assword gui") end),
    awful.key({                   }, "XF86Launch9", function () awful.util.spawn("sudo systemctl suspend") end),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),
    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.


function get_or_create_tag(name)
   local screen = mouse.screen
   local ttag = tyrannical.tags_by_name[name]

   if ttag and ttag.instances then
      return ttag.instances[screen]
   else
      local tag = awful.tag.add(ttag.name, ttag)
      -- If the ttag has the index atribute set move the tag to its position
      -- if ttag.index then
      --    reorder_tags()
      -- end
      return tag
   end
end

-- function reorder_tags()
--    for scr =1, screen.count() do
--       local tmp_tags = awful.tag.gettags(scr)
--       for index, tag in ipairs(tmp_tags) do
--          gears.debug.dump(tag.name, "TAG   ")
--          local ttag = tyrannical.tags_by_name[tag.name]
--          if ttag and ttag.index then
--             if ttag.instances then
--                if awful.tag.gettags(scr)[ttag.index] == ttag.index then
--                   print(ttag.name, " Already in the good position ", ttag.index)
--                else
--                   print(ttag.name, "  in bad position ", ttag.index)
--                   print("Moving!", ttag.index, ttag.instances[scr])
--                   if ttag.index > #tmp_tags then
--                      local pos = #tmp_tags
--                   else
--                      local pos = ttag.index
--                   end
--                   awful.tag.move(pos, tag)
--                   print(ttag.name, "  in bad position ", ttag.index)
--                end
--             end
--          else
--             awful.tag.move(#tmp_tags, tag)
--          end
--       end
--    end
-- end

-- reorder_tags()

-- view the first tag
awful.tag.viewonly(awful.tag.gettags(1)[1])

for name, ttag in pairs(tyrannical.tags_by_name) do
   print("N:", name)
   if ttag.key then
      print("Not nil " .. ttag.key)
      globalkeys = awful.util.table.join(globalkeys,
                                         awful.key({ modkey }, ttag.key,
                                                   function ()
                                                      local tag = get_or_create_tag(name)
                                                      if tag then
                                                         awful.tag.viewonly(tag)
                                                      end
                                         end),
                                         awful.key({ modkey, "Control" }, ttag.key,
                                                   function ()
                                                      local tag = get_or_create_tag(name)
                                                      if tag then
                                                         awful.tag.viewtoggle(tag)
                                                      end
                                         end),
                                         awful.key({ modkey, "Shift" }, ttag.key,
                                                   function ()
                                                      local tag = get_or_create_tag(name)
                                                      if client.focus and tag then
                                                         awful.client.movetotag(tag)
                                                         awful.tag.viewonly(tag)
                                                      end
                                         end),
                                         awful.key({ modkey, "Control", "Shift" }, ttag.key,
                                                   function ()
                                                      local tag = get_or_create_tag(name)
                                                      if client.focus and tag then
                                                         awful.client.toggletag(tag)
                                                      end
                                         end)

      )
   end
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     size_hints_honor = false,
                     buttons = clientbuttons } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },

    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
                         -- Enable sloppy focus
                         c:connect_signal("mouse::enter", function(c)
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

--client.connect_signal("focus", function(c) c.opacity = 1 end)
--client.connect_signal("unfocus", function(c) c.opacity = 0.8 end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- }}}
