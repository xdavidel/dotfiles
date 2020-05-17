-- Standard awesome library
local gears                          = require("gears")
local awful                          = require("awful")
                                       require("awful.autofocus")

-- Widget and layout library
local wibox                          = require("wibox")

-- Theme handling library
local beautiful                      = require("beautiful")

-- Notification library
local naughty                        = require("naughty")
local menubar                        = require("menubar")
local hotkeys_popup                  = require("awful.hotkeys_popup")

-- Externals scripts
local xrandr                         = require("xrandr")
local freedesktop                    = require("freedesktop")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- require("awful.hotkeys_popup.keys")

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
    awesome.connect_signal("debug::error",
        function (err)
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
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- This is used later as the default terminal and editor to run.
terminal        = os.getenv("TERMINAL") or "st"
editor          = os.getenv("EDITOR") or "nvim"
homedir         = os.getenv("HOME")
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"
sftkey = "Shift"
ctlkey = "Control"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    awful.layout.suit.spiral,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    awful.layout.suit.floating,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
local myawesomemenu = {
   { "Titlebars",
        function()
            for _,c in ipairs(client.get()) do
                awful.titlebar.toggle(c)
            end
        end
   },
   { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "Edit Config", editor_cmd .. " " .. awesome.conffile },
   { "Restart", awesome.restart },
   { "Quit", function() awesome.quit() end },
}

local exitmenu = {
   { "Lock", "lockscreen" },
   { "Logout", "closesession" },
   { "Sleep", "prompt 'Hibernate computer?' 'sudo -A suspend'" },
   { "Restart", "prompt 'Reboot computer?' 'sudo -A reboot'" },
   { "Shutdown", "prompt 'Shutdown computer?' 'sudo -A shutdown -h now'" },
}

local scaledisplaymenu = {
   { "50%",  "scale 0.5"   },
   { "70%",  "scale 0.7"   },
   { "85%",  "scale 0.85"  },
   { "100%", "scale 1"     },
   { "120%", "scale 1.2"   },
}

local dpimenu = {
   { "60",  "dpiset 60"  },
   { "80",  "dpiset 80"  },
   { "100", "dpiset 100" },
   { "120", "dpiset 120" },
   { "140", "dpiset 140" },
   { "160", "dpiset 160" },
}

local monitormenu = {
        {"Choose", xrandr.normmenu() },
        {"Scale", scaledisplaymenu   },
        {"DPI", dpimenu              },
}

local mymainmenu = freedesktop.menu.build({
    before = {
        { "Awesome", myawesomemenu   },
        { "Monitor", monitormenu     },
    },
    after = {
        { "Run", "dmenu_run"         },
      { "Terminal", terminal         },
      { "Exit", exitmenu             },
    }
})
awful.util.mymainmenu = mymainmenu

local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}


-- {{{ Wibar

local altbackground = '#3d3d3d'
local emptyspace = wibox.widget.separator({
    visible = false
})
local myseparator = wibox.widget.separator({
    orientation = "vertical",
    forced_width = 20,
})

local desktoptext = wibox.widget.textbox("💻")
desktoptext:buttons(
    gears.table.join(
        desktoptext:buttons(),
        awful.button(
            {}, 1, nil,
            function () mouse.screen.selected_tag.selected = false end
        )
    )
)

local showdesktop = wibox.container.background(
    wibox.container.margin(
        desktoptext,
        5,
        5,
        0,
        0
    ),
    altbackground
)

local clockcmd = "clock"
local clockscript = awful.widget.watch(
    clockcmd,
    60,
    function(widget, stdout)
        widget:set_markup(stdout)
    end
)

local mytextclock = wibox.container.margin(
    wibox.container.background(
        wibox.container.margin(
            clockscript,
            5,
            5,
            0,
            0
        ),
        altbackground
    ),
    0,
    10,
    0,
    0
)
mytextclock:buttons(
    gears.table.join(
        mytextclock:buttons(),
        awful.button(
            {}, 1, nil,
            function () awful.spawn(clockcmd .. " 1") end
            ),
        awful.button(
            {}, 2, nil,
            function () awful.spawn(clockcmd .. " 2") end
            ),
        awful.button(
            {}, 3, nil,
            function () awful.spawn(clockcmd .. " 3") end
        )
    )
)

-- Keyboard map indicator and switcher
local keyboardlayout = awful.widget.keyboardlayout()
local mykeyboardlayout = wibox.container.margin(
    wibox.container.background(
        wibox.container.margin(
            wibox.widget {
                keyboardlayout,
                wibox.widget.textbox("⌨ "),
                layout  = wibox.layout.align.horizontal
            },
            7,
            0,
            0,
            0
        ),
        altbackground
    ),
    0,
    10,
    0,
    0
)

local musiccmd = "music"
local musicscript = awful.widget.watch(
    musiccmd,
    1000
)
local mymusic = wibox.container.margin(
    musicscript,
    0,
    10,
    0,
    0
)
mymusic:buttons(
    gears.table.join(
        mymusic:buttons(),
        awful.button(
            {}, 1, nil,
            function () awful.spawn(musiccmd .. " 1") end
        ),
        awful.button(
            {}, 2, nil,
            function () awful.spawn(musiccmd .. " 2") end
        ),
        awful.button(
            {}, 3, nil,
            function () awful.spawn(musiccmd .. " 3") end
        ),
        awful.button(
            {}, 4, nil,
            function () awful.spawn(musiccmd .. " 4") end
        ),
        awful.button(
            {}, 5, nil,
            function () awful.spawn(musiccmd .. " 5") end
        )
    )
)
awesome.connect_signal("refmusic",
    function()
        awful.spawn.easy_async_with_shell(
            musiccmd,
            function(out) musicscript:set_text(out) end
        )
    end
)

local updatescmd = "uppackages"
local myupdates
local updatesscript = awful.widget.watch(
    updatescmd,
    1000,
    function(widget, stdout)
        if string.len(stdout) <= 0 then
            myupdates.visible = false
        end
            widget:set_text(stdout)
    end
)
myupdates = wibox.container.margin(
    wibox.container.background(
        wibox.container.margin(
            updatesscript,
            5,
            5,
            0,
            0
        ),
        altbackground
    ),
    0,
    10,
    0,
    0
)
myupdates:buttons(
    gears.table.join(
        myupdates:buttons(),
        awful.button(
            {}, 1, nil,
            function () awful.spawn(updatescmd .. " 1") end
        ),
        awful.button(
            {}, 2, nil,
            function () awful.spawn(updatescmd .. " 2") end
        ),
        awful.button(
            {}, 3, nil,
            function () awful.spawn(updatescmd .. " 3") end
        )
    )
)
awesome.connect_signal("refupdates",
    function()
        awful.spawn.easy_async_with_shell(updatescmd,
            function(out) updatesscript:set_markup(out) end
        )
    end
)

local weathercmd = "weather"
local myweather
local weatherscript = awful.widget.watch(
    weathercmd,
    1000,
    function(widget, stdout)
        if string.len(stdout) <= 0 then
            myweather.visible = false
        end
        widget:set_text(stdout)
    end
)
myweather = wibox.container.margin(
    wibox.container.background(
        wibox.container.margin(
            weatherscript,
            5,
            5,
            0,
            0
        ),
        altbackground
    ),
    0,
    10,
    0,
    0
)
myweather:buttons(
    gears.table.join(
        myweather:buttons(),
        awful.button(
            {}, 1, nil,
            function () awful.spawn(weathercmd .. " 1") end
        ),
        awful.button(
            {}, 2, nil,
            function () awful.spawn(weathercmd .. " 2") end
        ),
        awful.button(
            {}, 3, nil,
            function () awful.spawn(weathercmd .. " 3") end
        )
    )
)
awesome.connect_signal("refweather",
    function()
        awful.spawn.easy_async_with_shell(weathercmd,
            function(out) weatherscript:set_text(out) end
        )
    end
)

local memorycmd = "memory"
local memoryscript = awful.widget.watch(
    memorycmd,
    30,
    function(widget, stdout)
        if string.len(stdout) <= 0 then
            mymemory.visible = false
        end
        widget:set_text(stdout)
    end
)
local mymemory = wibox.container.margin(
    wibox.container.background(
        wibox.container.margin(
            memoryscript,
            5,
            5,
            0,
            0
        ),
        altbackground
    ),
    0,
    10,
    0,
    0
)
mymemory:buttons(
    gears.table.join(
        mymemory:buttons(),
        awful.button(
            {}, 1, nil,
            function () awful.spawn(memorycmd .. " 1") end
        ),
        awful.button(
            {}, 2, nil,
            function () awful.spawn(memorycmd .. " 2") end
        ),
        awful.button(
            {}, 3, nil,
            function () awful.spawn(memorycmd .. " 3") end
        )
    )
)


local heatcmd = "heat"
local myheat
local heatscript = awful.widget.watch(
    heatcmd,
    60,
    function(widget, stdout)
        if string.len(stdout) <= 0 then
            myheat.visible = false
        end
        widget:set_text(stdout)
    end
)
myheat = wibox.container.margin(
    wibox.container.background(
        wibox.container.margin(
            heatscript,
            5,
            5,
            0,
            0
        ),
        altbackground
    ),
    0,
    10,
    0,
    0
)

local cpucmd = "cpu"
local mycpu
local cpuscript = awful.widget.watch(
    cpucmd,
    10,
    function(widget, stdout)
        if string.len(stdout) <= 0 then
            mycpu.visible = false
        end
        widget:set_text(stdout)
    end
)
mycpu = wibox.container.margin(
    wibox.container.background(
        wibox.container.margin(
            cpuscript,
            5,
            5,
            0,
            0
        ),
        altbackground
    ),
    0,
    10,
    0,
    0
)

local volcmd = "audiovol"
local myvol
local volscript = awful.widget.watch(
    volcmd,
    1000,
    function(widget, stdout)
        if string.len(stdout) <= 0 then
            myvol.visible = false
        end
        widget:set_text(stdout)
    end
)
myvol = wibox.container.margin(
    wibox.container.background(
        wibox.container.margin(
            volscript,
            5,
            5,
            0,
            0
        ),
        altbackground
    ),
    0,
    10,
    0,
    0
)
myvol:buttons(
    gears.table.join(
        myvol:buttons(),
        awful.button(
            {}, 1, nil,
            function () awful.spawn(volcmd .. " 1") end
        ),
        awful.button(
            {}, 2, nil,
            function () awful.spawn(volcmd .. " 2") end
        ),
        awful.button(
            {}, 4, nil,
            function () awful.spawn(volcmd .. " 4") end
        ),
        awful.button(
            {}, 5, nil,
            function () awful.spawn(volcmd .. " 5") end
        ),
        awful.button(
            {}, 3, nil,
            function () awful.spawn(volcmd .. " 3") end
        )
    )
)
awesome.connect_signal("refvol",
    function()
        awful.spawn.easy_async_with_shell(volcmd,
            function(out) volscript:set_markup(out) end
        )
    end
)

local netcmd = "network"
local mynet
local netscript = awful.widget.watch(
    netcmd,
    20,
    function(widget, stdout)
        if string.len(stdout) <= 0 then
            mynet.visible = false
        end
        widget:set_text(stdout)
    end
)
mynet = wibox.container.margin(
    wibox.container.background(
        wibox.container.margin(
            netscript,
            5,
            5,
            0,
            0
        ),
        altbackground
    ),
    0,
    10,
    0,
    0
)
mynet:buttons(
    gears.table.join(
        mynet:buttons(),
        awful.button(
            {}, 1, nil,
            function () awful.spawn(netcmd .. " 1") end
        ),
        awful.button(
            {}, 3, nil,
            function () awful.spawn(netcmd .. " 3") end
        )
    )
)


local batcmd = "battery"
local mybat
local batscript = awful.widget.watch(
    batcmd,
    10,
    function(widget, stdout)
        if string.len(stdout) <= 0 then
            mybat.visible = false
        end
        widget:set_text(stdout)
    end
)
mybat = wibox.container.margin(
    wibox.container.background(
        wibox.container.margin(
            batscript,
            5,
            5,
            0,
            0
        ),
        altbackground
    ),
    0,
    10,
    0,
    0
)


-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1,
    function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),

    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),

    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local currentclient
local tags = { " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 " }
-- input is a client which we want to move
local function get_tags_menu_items()
    local move_to_menu = {}
    -- iterate through all tags
    for index,tag in ipairs(tags) do
    -- create a menu item for each tag which consists of:
    --   * item title (first table element, we use tag's name here)
    --   * callback function which will be executed on item selection
    -- and then append this item to the output table
        table.insert(move_to_menu, {
    " #" .. tag,
            function ()
            -- callback function is simple: just move client to the selected tag
                currentclient:move_to_tag(awful.tag.find_by_name(awful.screen.focused(),tag))
            end,
        })
    end

    local action_menu = {
        {"Close", function() currentclient:kill() end},
        {"Maximize", function() currentclient.maximized = true end},
        {"Minimize", function() currentclient.minimized = true end},
        {"Restore",
            function()
                currentclient.minimized = false
                currentclient.maximized = false
                currentclient:raise()
            end },
    }

    local output = {}

    table.insert(output, {
        "Running Programs",
        awful.menu.client_list
    })

    table.insert(output, {
        "Move To Tag",
        move_to_menu
    })

    table.insert(output, {
        "Action",
        action_menu
    })

    table.insert(output, {
        "Swap Monitor",
        function() awful.client.movetoscreen(currentclient) end
    })

  return output
end

local tags_menu = awful.menu.new(get_tags_menu_items())

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1,
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate",
                    "tasklist",
                    {raise = true}
                )
            end
        end),

    awful.button({ }, 3,
        function(c)
            currentclient = c
            tags_menu:toggle()
        end),

    awful.button({ }, 4,
        function ()
            awful.client.focus.byidx(1)
        end),

    awful.button({ }, 5,
        function ()
            awful.client.focus.byidx(-1)
        end)
)

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

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag(tags, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end))
    )

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout  = {
            spacing_widget = {
                {
                    forced_width  = 5,
                    forced_height = 24,
                    thickness     = 0,
                    widget        = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            spacing = 1,
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    id     = 'icon_role',
                    widget = wibox.widget.imagebox,
                },
                widget      = wibox.container.margin,
                margins = 4,
            },
            id     = 'background_role',
            widget = wibox.container.background,
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                -- default icon when none is found (ex. simple terminal)
                if not c.icon then
                    self:get_children_by_id('icon_role')[1].image =
                        awful.util.get_configuration_dir() .. 'gear.svg'
                end
                local tooltip = awful.tooltip({
                    objects = { self },
                    timer_function = function() return c.name end,
                })
            end
            },
        }

        -- Create the wibox
        s.mytopwibox = awful.wibar({ position = "top", screen = s })
        s.mybottomwibox = awful.wibar({ position = "bottom", screen = s })

        -- Add widgets to the wibox
        s.mytopwibox:setup {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                s.mytaglist,
            },
            s.emptyspace,
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                mymusic,
                myupdates,
                myweather,
                mymemory,
                mycpu,
                myvol,
                mynet,
                mybat,
                s.mylayoutbox,
            },
        }
        s.mybottomwibox:setup {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                mylauncher,
                myseparator,
                s.mypromptbox,
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                mykeyboardlayout,
                mytextclock,
                showdesktop,
                wibox.widget.systray(),
            },
        }
    end
)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
    -- awful.button({ }, 2, function () naughty.notify({ preset = naughty.config.presets.critical, title = "Test", text = tags[3].name }) end)
    -- awful.button({ }, 4, awful.tag.viewnext),
    -- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey, sftkey    }, "/",      hotkeys_popup.show_help,
        {description="show help", group="awesome"}),
    awful.key({ modkey, ctlkey    }, "Left",   awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({ modkey, ctlkey    }, "Right",  awful.tag.viewnext,
        {description = "view next", group = "tag"}),

    -- focus by direction
    -- awful.key({ modkey,           }, "Down",
    --     function () awful.client.focus.global_bydirection( "down") end,
    --     {description = "focus next down", group = "client"}),
    -- awful.key({ modkey,           }, "Up",
    --     function () awful.client.focus.global_bydirection( "up") end,
    --     {description = "focus next up", group = "client"}),
    -- awful.key({ modkey,           }, "Left",
    --     function () awful.client.focus.global_bydirection( "left") end,
    --     {description = "focus next left", group = "client"}),
    -- awful.key({ modkey,           }, "Right",
    --     function () awful.client.focus.global_bydirection( "right") end,
    --     {description = "focus next right", group = "client"}),

    -- awful.key({ modkey,           }, "j",
    --     function () awful.client.focus.global_bydirection( "down") end,
    --     {description = "focus next down", group = "client"}),
    -- awful.key({ modkey,           }, "k",
    --     function () awful.client.focus.global_bydirection( "up") end,
    --     {description = "focus next up", group = "client"}),
    -- awful.key({ modkey,           }, "h",
    --     function () awful.client.focus.global_bydirection( "left") end,
    --     {description = "focus next left", group = "client"}),
    -- awful.key({ modkey,           }, "l",
    --     function () awful.client.focus.global_bydirection( "right") end,
    --     {description = "focus next right", group = "client"}),

    -- focus by index
    awful.key({ modkey,           }, "Down",
        function () awful.client.focus.byidx( 1) end,
        {description = "focus next client", group = "client"}),
    awful.key({ modkey,           }, "Up",
        function () awful.client.focus.byidx( -1) end,
        {description = "focus prev client", group = "client"}),

    awful.key({ modkey,           }, "j",
        function () awful.client.focus.byidx( 1) end,
        {description = "focus next down", group = "client"}),
    awful.key({ modkey,           }, "k",
        function () awful.client.focus.byidx( -1) end,
        {description = "focus next up", group = "client"}),

    -- Layout manipulation
    -- awful.key({ modkey, sftkey    }, "Up",
    --     function () awful.client.swap.global_bydirection( "up" ) end,
    --     {description = "swap with next upper client", group = "client"}),
    -- awful.key({ modkey, sftkey    }, "Down",
    --     function () awful.client.swap.global_bydirection( "down" )    end,
    --     {description = "swap with next lower client", group = "client"}),
    -- awful.key({ modkey, sftkey    }, "Left",
    --     function () awful.client.swap.global_bydirection( "left" )    end,
    --     {description = "swap with the client to the left", group = "client"}),
    -- awful.key({ modkey, sftkey    }, "Right",
    --     function () awful.client.swap.global_bydirection( "right" )  end,
    --     {description = "swap with the client to the right", group = "client"}),
    awful.key({ modkey, sftkey    }, "Down",
        function () awful.client.swap.byidx(  1) end,
        {description = "swap with next lower client", group = "client"}),
    awful.key({ modkey, sftkey    }, "Up",
        function () awful.client.swap.byidx( -1) end,
        {description = "swap with next upper client", group = "client"}),
    awful.key({ modkey, sftkey    }, "j",
        function () awful.client.swap.byidx(  1) end,
        {description = "swap with next upper client", group = "client"}),
    awful.key({ modkey, sftkey    }, "k",
        function () awful.client.swap.byidx( -1) end,
        {description = "swap with next lower client", group = "client"}),

    -- focus screen
    awful.key({ modkey,           }, "Right",
        function () awful.screen.focus_relative( 1) end,
        {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey,           }, "Left",
        function () awful.screen.focus_relative(-1) end,
        {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "l",
        function () awful.screen.focus_relative( 1) end,
        {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey,           }, "h",
        function () awful.screen.focus_relative(-1) end,
        {description = "focus the previous screen", group = "screen"}),

    -- Move to screen
    awful.key({ modkey, sftkey    }, "Right",
        awful.client.movetoscreen,
        {description = "Move to screen", group = "awesome"}),
    awful.key({ modkey, sftkey    }, "Left",
        awful.client.movetoscreen,
        {description = "Move to screen", group = "awesome"}),
    awful.key({ modkey, sftkey    }, "h",
        awful.client.movetoscreen,
        {description = "Move to screen", group = "awesome"}),
    awful.key({ modkey, sftkey    }, "l",
        awful.client.movetoscreen,
        {description = "Move to screen", group = "awesome"}),

        -- Layout changing
    awful.key({ modkey                    }, "t",
        function() awful.layout.set(awful.layout.suit.tile) end,
        {description = "Set tiling layout", group = "layout"}),
    awful.key({ modkey, sftkey            }, "t",
        function() awful.layout.set(awful.layout.suit.tile.bottom) end,
        {description = "Set bstack layout", group = "layout"}),
    awful.key({ modkey                    }, "g",
        function() awful.layout.set(awful.layout.suit.fair.horizontal) end,
        {description = "Set grid layout", group = "layout"}),
    awful.key({ modkey, sftkey            }, "g",
        function() awful.layout.set(awful.layout.suit.magnifier) end,
        {description = "Set magnifier layout", group = "layout"}),
    awful.key({ modkey                    }, "s",
        function() awful.layout.set(awful.layout.suit.spiral) end,
        {description = "Set spiral layout", group = "layout"}),
    awful.key({ modkey, sftkey            }, "s",
        function() awful.layout.set(awful.layout.suit.spiral.dwindle) end,
        {description = "Set dwindle layout", group = "layout"}),
    awful.key({ modkey                    }, "u",
        function() awful.layout.set(awful.layout.suit.max) end,
        {description = "Set max layout", group = "layout"}),

    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

        -- Open context menu
    awful.key({ modkey                }, "space",
        function () mymainmenu:toggle() end,
        {description = "show context menu", group = "awesome"}),

        -- Monitor options
    awful.key({ modkey, altkey    }, "s",
        function () xrandr.xrandr() end,
        {description = "Monitor options", group = "awesome"}),

        -- Show / Hide wibox
    awful.key({ modkey,           }, "b",
        function ()
            for s in screen do
                s.mytopwibox.visible = not s.mytopwibox.visible
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end,
        {description = "toggle wibox bars", group = "wibox"}),

    -- Standard program
    awful.key({ modkey, altkey    }, "Right",
        function () awful.tag.incmwfact( 0.05) end,
        {description = "increase master width", group = "layout"}),
    awful.key({ modkey, altkey    }, "Left",
        function () awful.tag.incmwfact(-0.05) end,
        {description = "decrease master width", group = "layout"}),
    awful.key({ modkey, altkey    }, "Up",
        function () awful.client.incwfact(-0.05) end,
        {description = "decrease client height", group = "layout"}),
    awful.key({ modkey, altkey    }, "Down",
        function () awful.client.incwfact(0.05) end,
        {description = "increase client height", group = "layout"}),

    awful.key({ modkey, altkey    }, "j",
        function (c) awful.client.moveresize(0,20,0,0) end,
        {description = "move floating client down", group = "client"}),
    awful.key({ modkey, altkey    }, "k",
        function (c) awful.client.moveresize(0,-20,0,0) end,
        {description = "move floating client up", group = "client"}),
    awful.key({ modkey, altkey    }, "l",
        function (c) awful.client.moveresize(20,0,0,0) end,
        {description = "move floating client right", group = "client"}),
    awful.key({ modkey, altkey    }, "h",
        function (c) awful.client.moveresize(-20,0,0,0) end,
        {description = "move floating client left", group = "client"}),

    awful.key({ modkey, ctlkey    }, "j",
        function () awful.layout.inc( 1) end,
        {description = "select next layout", group = "layout"}),
    awful.key({ modkey, ctlkey    }, "k",
        function () awful.layout.inc(-1) end,
        {description = "select previous layout", group = "layout"}),

    awful.key({ altkey }, "x",
        function ()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
              }
        end,
        {description = "lua execute prompt", group = "awesome"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, sftkey    }, "f",
        function (c)
            c.floating = not c.floating
            c:raise()
        end,
        {description = "toggle floating", group = "client"}),
    -- awful.key({ altkey,           }, "t", function(c) awful.titlebar.toggle(c) end    ,

    --           {description = "toggle titlebar", group = "client"}),
    awful.key({ altkey                          }, "t",
        function()
            for _,c in ipairs(client.get()) do
                awful.titlebar.toggle(c)
            end
        end,
        {description = "toggle titlebar", group = "client"}),

    awful.key({ modkey, ctlkey        }, "Up",
        function (c)
            if c then
                c.maximized = true
                c:raise()
            end
        end,
        {description = "maximize", group = "client"}),

    awful.key({ modkey, ctlkey    }, "Down",
        function (c)
            if c.maximized then
                c.maximized = false
                c:raise()
            else
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
                c:raise()
            end
        end ,
        {description = "umaximized / minimize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #"..i, group = "tag"}),

        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}),

        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}),

        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"})
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
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },
    {
        rule_any = { class = {"Polybar"} },
        properties = {
            skip_taskbar = true,
            border_width = 0,
            ontop = true,
            focusable = false
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer"
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester",  -- xev.
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
      },
      properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {type = { "normal", "dialog" }},
        properties = { titlebars_enabled = true }
    },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    -- if c.class == "Polybar" then
    --      c:unmanage()
    -- end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
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
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
        awful.titlebar.hide(c)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
