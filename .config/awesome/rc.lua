-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

-- Standard awesome library
local gears         = require("gears") --Utilities such as color parsing and objects
local awful         = require("awful") --Everything related to window managment
                      require("awful.autofocus")
-- Widget and layout library
local wibox         = require("wibox")

-- Theme handling library
local beautiful     = require("beautiful")

-- Notification library
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 100

--local menubar       = require("menubar")

local lain          = require("lain")
local freedesktop   = require("freedesktop")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
-- }}}



-- {{{ Error handling
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


-- {{{ Variable definitions

local themes = {
    "base", -- 1
    "powerarrow",      -- 2
    "multicolor",      -- 3

}

-- choose your theme here
local chosen_theme = themes[1]

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

-- modkey or mod4 = super key
local modkey    = "Mod4"
local altkey    = "Mod1"
local ctlkey	= "Control"
local sftkey	= "Shift"

-- personal variables
--change these variables if you want
local browser           = os.getenv("BROWSER") 		or "firefox"
local editor            = os.getenv("EDITOR") 		or "nvim"
local editorgui         = os.getenv("EDITORGUI") 	or "geany"
local filemanager       = os.getenv("FILE") 		or "vifm"
local filemanagergui    = os.getenv("FILEGUI") 		or "pcmanfm"
local mediaplayer       = os.getenv("MEDIAPLAYER") 	or "mpv"
local terminal          = os.getenv("TERMINAL") 	or "st"

-- awesome variables
awful.util.terminal = terminal
awful.util.tagnames = { " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 " }

awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
}

awful.util.taglist_buttons = my_table.join(
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

awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = 250}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format(gears.filesystem.get_configuration_dir() .. "/themes/%s/theme.lua", chosen_theme))
-- }}}



-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e 'man awesome'" },
    { "edit config", string.format("%s %s %s/.config/awesome/rc.lua", terminal, editor, os.getenv("HOME")) },
    { "arandr", "arandr" },
    { "restart", awesome.restart },
}

local exitmenu = {
	{ "Lock", "lockscreen" },
	{ "Log out", "closesession" },
	{ "Sleep", "prompt 'Hibernate computer?' 'sudo systemctl suspend'" },
	{ "Restart", "prompt 'Reboot computer?' 'sudo -A shutdown -h now'" } ,
	{ "Shutdown", "prompt 'Shutdown computer?' 'sudo -A shutdown -h now'" },
}

awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or 16,
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
		{ "Run", "dmenu_run" },
        { "Terminal", terminal },
        { "Exit", exitmenu },
        -- other triads can be put here
    }
})
--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}



-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}



-- {{{ Mouse bindings
root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end)
    --awful.button({ }, 4, awful.tag.viewnext),
    --awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}



-- {{{ Key bindings
globalkeys = my_table.join(

    -- {{{ Personal keybindings
    -- dmenu
    --awful.key({ modkey, sftkey }, "Return",
    --function ()
     --   awful.spawn(string.format("dmenu_run -i  -nb '#292d3e' -nf '#bbc5ff' -sb '#82AAFF' -sf '#292d3e' -fn 'UbuntuMono Nerd Font:bold:pixelsize=14'",
     --   beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
	--end,
    --{description = "show dmenu", group = "hotkeys"}),


    -- Personal keybindings}}}

    -- Hotkeys Awesome

    awful.key({ modkey, sftkey  }, "/",      hotkeys_popup.show_help,
        {description = "show help", group="awesome"}),

    -- Tag browsing with modkey
    awful.key({ modkey, ctlkey  }, "Left",   awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({ modkey, ctlkey  }, "Right",  awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    --awful.key({ altkey,           }, "Escape", awful.tag.history.restore,
    --    {description = "go back", group = "tag"}),

     -- Tag browsing alt + tab
    --awful.key({ altkey,           }, "Tab",   awful.tag.viewnext,
    --    {description = "view next", group = "tag"}),
    --awful.key({ altkey, sftkey   }, "Tab",  awful.tag.viewprev,
    --    {description = "view previous", group = "tag"}),

     -- Tag browsing modkey + tab
    --awful.key({ modkey,           }, "Tab",   awful.tag.viewnext,
    --    {description = "view next", group = "tag"}),
    --awful.key({ modkey, sftkey   }, "Tab",  awful.tag.viewprev,
    --    {description = "view previous", group = "tag"}),


    -- Non-empty tag browsing
    --awful.key({ modkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
              --{description = "view  previous nonempty", group = "tag"}),
   -- awful.key({ modkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
             -- {description = "view  previous nonempty", group = "tag"}),

    -- Default client focus
    awful.key({ altkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ altkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),
    awful.key({ modkey }, "Down",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "Up",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "Left",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "Right",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),


    --awful.key({ modkey,           }, "w", function () awful.util.mymainmenu:show() end,
    --          {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, sftkey   }, "j", function () awful.client.swap.global_bydirection(  "down")    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, sftkey   }, "k", function () awful.client.swap.global_bydirection( "up")    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, sftkey   }, "h", function () awful.client.swap.global_bydirection(  "left")    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, sftkey   }, "l", function () awful.client.swap.global_bydirection( "right")    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, sftkey   }, "Down", function () awful.client.swap.global_bydirection(  "down")    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, sftkey   }, "Up", function () awful.client.swap.global_bydirection( "up")    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, sftkey   }, "Left", function () awful.client.swap.global_bydirection(  "left")    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, sftkey   }, "Right", function () awful.client.swap.global_bydirection( "right")    end,
              {description = "swap with previous client by index", group = "client"}),

    --awful.key({ modkey, ctlkey }, "j", function () awful.screen.focus_relative( 1) end,
    --          {description = "focus the next screen", group = "screen"}),
    --awful.key({ modkey, ctlkey }, "k", function () awful.screen.focus_relative(-1) end,
    --          {description = "focus the previous screen", group = "screen"}),
    --awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
    --          {description = "jump to urgent client", group = "client"}),
    awful.key({ ctlkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}),

    -- On the fly useless gaps change
    awful.key({ modkey }, "s", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "tag"}),
    awful.key({ modkey, sftkey }, "s", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "tag"}),

    -- Dynamic tagging
    --awful.key({ modkey, sftkey }, "n", function () lain.util.add_tag() end,
    --          {description = "add new tag", group = "tag"}),
    --awful.key({ modkey, ctlkey }, "r", function () lain.util.rename_tag() end,
    --          {description = "rename tag", group = "tag"}),
   -- awful.key({ modkey, sftkey }, "Left", function () lain.util.move_tag(-1) end,
    --          {description = "move tag to the left", group = "tag"}),
    --awful.key({ modkey, sftkey }, "Right", function () lain.util.move_tag(1) end,
    --          {description = "move tag to the right", group = "tag"}),
    --awful.key({ modkey, sftkey }, "d", function () lain.util.delete_tag() end,
     --         {description = "delete tag", group = "tag"}),

    -- Standard program
    --awful.key({ modkey, sftkey }, "r", awesome.restart,
    --          {description = "reload awesome", group = "awesome"}),

    awful.key({ modkey, altkey }, "Left",     function () awful.tag.incmwfact( -0.02)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, altkey  }, "Right",     function () awful.tag.incmwfact(0.02)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, altkey  }, "Up",     function () awful.client.incwfact(0.02)       end,
              {description = "decrease master height factor", group = "layout"}),
    awful.key({ modkey, altkey  }, "Down",     function () awful.client.incwfact(-0.02)       end,
              {description = "increase master height factor", group = "layout"}),

    --awful.key({ modkey, sftkey   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    --          {description = "increase the number of master clients", group = "layout"}),
    --awful.key({ modkey, sftkey   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    --          {description = "decrease the number of master clients", group = "layout"}),
    --awful.key({ modkey, altkey }, "h",     function () awful.tag.incncol( 0.02, nil, true)    end,
    --          {description = "increase the number of columns", group = "layout"}),
    --awful.key({ modkey, altkey }, "l",     function () awful.tag.incncol(-0.02, nil, true)    end,
    --          {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey, ctlkey }, "k", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, ctlkey }, "j", function () awful.layout.inc( -1)                end,
              {description = "select next", group = "layout"}),
    --awful.key({ modkey, ctlkey }, "Up", function () awful.layout.inc( 1)                end,
    --          {description = "select next", group = "layout"}),
    --awful.key({ modkey, ctlkey }, "Down", function () awful.layout.inc( -1)                end,
    --          {description = "select next", group = "layout"}),

    -- Dropdown application
    --awful.key({ modkey, }, "z", function () awful.screen.focused().quake:toggle() end,
    --          {description = "dropdown application", group = "super"}),

    -- Widgets popups
    --awful.key({ altkey, }, "c", function () lain.widget.calendar.show(7) end,
    --          {description = "show calendar", group = "widgets"}),
    --awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
    --          {description = "show filesystem", group = "widgets"}),
    --awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
    --          {description = "show weather", group = "widgets"}),

    -- Default
    --[[ Menubar

    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "super"})
    --]]

    awful.key({ altkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Lua: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"})
    --]]
)

clientkeys = my_table.join(
    awful.key({ altkey, sftkey   }, "m",      lain.util.magnify_client,
              {description = "magnify client", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    --awful.key({ modkey, sftkey   }, "c",      function (c) c:kill()                         end,
    --          {description = "close", group = "hotkeys"}),
    awful.key({ modkey, sftkey }, "f",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    --awful.key({ modkey, ctlkey }, "Return", function (c) c:swap(awful.client.getmaster()) end,
    --          {description = "move to master", group = "client"}),
    --awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
    --          {description = "move to screen", group = "client"}),
    --awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
    --          {description = "toggle keep on top", group = "client"}),

    -- minimize / maximize a client
    awful.key({ modkey, ctlkey    }, "Down",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    --awful.key({ modkey, ctlkey    }, "Up",
        --function (c)
            --c.maximized = not c.maximized
            --c:raise()
        --end ,
        --{description = "maximize", group = "client"})

    awful.key({ modkey, ctlkey }, "Up",
        function ()
			local c = awful.client.restore()
            -- Focus restored client
            if c then
				client.focus = c
                c:raise()
            end
		end,
        {description = "restore minimized", group = "client"}),

	awful.key({ modkey   }, "t",
		function (c)
			awful.titlebar.toggle(c)
		end,
		{description = "toggle titlebar", group = "client"}),

	awful.key({ modkey, sftkey   }, "t",
		function ()
			for _, c in ipairs(client.get()) do
				awful.titlebar.toggle(c)
			end
		end,
		{description = "toggle all titlebars", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end
    globalkeys = my_table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, ctlkey }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, sftkey }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, ctlkey, sftkey }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}



-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = true } },

	-- Maximized
    --{ rule = { class = editorgui },
          --properties = { maximized = true } },

    --{ rule = { class = "Gimp*", role = "gimp-image-window" },
          --properties = { maximized = true } },

    --{ rule = { class = "inkscape" },
          --properties = { maximized = true } },

    --{ rule = { class = mediaplayer },
          --properties = { maximized = true } },

    --{ rule = { class = "Vlc" },
          --properties = { maximized = true } },

    --{ rule = { class = "VirtualBox Manager" },
          --properties = { maximized = true } },

    --{ rule = { class = "VirtualBox Machine" },
          --properties = { maximized = true } },

    

    -- Show titlebar on some window types
    {   rule_any   = { type = {"utility", "splash", "toolbar"} },
        properties = { floating = true,
                       show_titlebar = true }  },

	-- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Blueberry",
          "Galculator",
          "Gnome-font-viewer",
          "Gpick",
          "Imagewriter",
          "Font-manager",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Oblogout",
          "Peek",
          "Skype",
          "System-config-printer.py",
          "Sxiv",
          "Unetbootin.elf",
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
          "Preferences",
          "setup",
        }
      }, properties = { floating = true }},

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
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

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = 21}) : setup {
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

	-- Hide created titlebar
    awful.titlebar.hide(c)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = true})
end)

-- No border for maximized clients
function border_adjust(c)
    if c.maximized then -- no borders if only 1 client visible
        c.border_width = 0
    elseif #awful.screen.focused().clients > 1 then
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
    end
end

client.connect_signal("focus", border_adjust)
client.connect_signal("property::maximized", border_adjust)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- can be called from Lua code
prt = function(...) naughty.notify{text=table.concat({...}, '\t')} end
col = function(str) naughty.notify{text="    ", bg=str} end
