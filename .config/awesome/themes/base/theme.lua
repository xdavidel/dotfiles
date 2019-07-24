local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local homedir = os.getenv("HOME")

local system_colors = {
	foreground 	= xrdb.foreground 	or '#f2e6c9',
	background 	= xrdb.background 	or '#272929',
	cursor 		= xrdb.cursorColor 	or '#c5c8c6',

	-- black
	black_d		= xrdb.color0	 	or '#1d2021',
	black_l		= xrdb.color8	 	or '#373b41',

	-- red
	red_d 		= xrdb.color1		or '#cc241d',
	red_l 		= xrdb.color9 		or '#a54242',

	-- green
	green_d		= xrdb.color2		or '#5F9E0E',
	green_l		= xrdb.color10		or '#8c9440',

	-- yellow
	yellow_d	= xrdb.color3		or '#d79921',
	yellow_l	= xrdb.color11		or '#f0c674',

	-- blue
	blue_d		= xrdb.color4		or '#5f819d',
	blue_l		= xrdb.color12		or '#7197E7',

	-- magenta
	magenta_d	= xrdb.color5		or '#750775',
	magenta_l	= xrdb.color13		or '#A77AC4',

	-- cyan
	cyan_d		= xrdb.color6		or '#5e8d87',
	cyan_l		= xrdb.color14		or '#8abeb7',

	-- white
	white_d		= xrdb.color7		or '#f2e6c9',
	white_l		= xrdb.color15		or '#c5c8c6',
}

local theme                                     = {}
theme.dir                                       = homedir .. "/.config/awesome/themes/base"
theme.wallpaper                                 = homedir .. "/.config/wall.png"
theme.font                                      = "mono 12"
theme.taglist_font                              = "sans 12"
theme.fg_normal                                 = system_colors.foreground
theme.fg_focus                                  = system_colors.white_d
theme.fg_urgent                                 = system_colors.foreground
theme.bg_normal                                 = system_colors.background
theme.bg_focus                                  = system_colors.magenta_d
theme.bg_urgent                                 = system_colors.red_d
theme.taglist_fg_focus                          = system_colors.white_l
theme.tasklist_bg_focus                         = system_colors.magenta_d
theme.tasklist_fg_focus                         = system_colors.magenta_l
theme.border_width                              = 3
theme.border_normal                             = system_colors.black_d
theme.border_focus                              = system_colors.magenta_d
theme.border_marked                             = system_colors.red_l
theme.titlebar_bg_focus                         = system_colors.background
theme.titlebar_bg_normal                        = system_colors.background
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_height                               = 20
theme.menu_width                                = 180
theme.awesome_icon                              = theme.dir .. "/icons/awesome.svg"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.menu_submenu								= ""

theme.layout_tile                               = theme.dir .. "/icons/layouts/tile.svg"
theme.layout_tileleft                           = theme.dir .. "/icons/layouts/tileleft.svg"
theme.layout_tilebottom                         = theme.dir .. "/icons/layouts/tilebottom.svg"
theme.layout_tiletop                            = theme.dir .. "/icons/layouts/tiletop.svg"
theme.layout_fairv                              = theme.dir .. "/icons/layouts/fairv.svg"
theme.layout_fairh                              = theme.dir .. "/icons/layouts/fairh.svg"
theme.layout_spiral                             = theme.dir .. "/icons/layouts/spiral.svg"
theme.layout_dwindle                            = theme.dir .. "/icons/layouts/dwindle.svg"
theme.layout_max                                = theme.dir .. "/icons/layouts/max.svg"
theme.layout_fullscreen                         = theme.dir .. "/icons/layouts/fullscreen.svg"
theme.layout_magnifier                          = theme.dir .. "/icons/layouts/magnifier.svg"
theme.layout_floating                           = theme.dir .. "/icons/layouts/floating.svg"

theme.useless_gap                               = 6

theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close.svg"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close.svg"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop.svg"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop.svg"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop.svg"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop.svg"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/pin.svg"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/pin.svg"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/pin.svg"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/pin.svg"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating.svg"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating.svg"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating.svg"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating.svg"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized.svg"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized.svg"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized.svg"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized.svg"

local markup = lain.util.markup
local separators = lain.util.separators


-- Textclock
local clockwidget = awful.widget.watch(
    "date +'%d %b (%a) %R'", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { clockwidget },
    week_start = 1,
    notification_preset = {
		font = "UbuntuMono Nerd Font 11",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- MPD
local mpdscript = lain.widget.script({
	script_cmd = "musicmpc",
	notification_preset = { title = "Music module", timeout = 6, text = [[Click to open player]] },
	updatesignal = "refmusic",
	settings = function()
        widget:set_markup(markup.font(theme.font, " " .. script_now.text .. " "))
    end
})
local mpdwidget = wibox.widget {
	wibox.widget.textbox(""),
	mpdscript,
	layout = wibox.layout.align.horizontal 
}	
mpdwidget:buttons(my_table.join(
    awful.button({ modkey }, 1, function () awful.spawn.with_shell("$TERMINAL -e ncmpcpp") end),
    awful.button({ }, 2, function ()
        awful.spawn.with_shell("mpc toggle")
        theme.mpd.update()
    end),
    awful.button({ modkey }, 3, function () awful.spawn.with_shell("pkill ncmpcpp") end),
    awful.button({ }, 3, function ()
        awful.spawn.with_shell("mpc stop")
        theme.mpd.update()
    end))
)

local weatherscript = lain.widget.script({
	script_cmd = "forecast",
	notification_preset = { title = "🌈 Weather module", timeout = 6, text = [[Click for wttr.in forecast
☔: Chance of rain/snow
❄ : Daily low
🌞: Daily high]] },
	settings = function()
        widget:set_markup(markup.font(theme.font, " " .. script_now.text .. " "))
    end
})
weatherscript.widget:buttons(my_table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("$TERMINAL -e less -S /tmp/weatherreport")
    end),
    awful.button({ }, 2, function ()
        weatherscript.update()
    end))
)
local weatherwidget = wibox.widget { weatherscript.widget, layout = wibox.layout.align.horizontal }

-- Available packages - updates every 30 minutes
local packscript = lain.widget.script({
	script_cmd = "uppackages",
	notification_preset = { title = "Updates module", timeout = 6 },
	updatesignal = "refupdates",
	settings = function()
        widget:set_markup(markup.font(theme.font, " " .. script_now.text .. " "))
    end
})
local packswidget = wibox.widget { 
	wibox.widget.textbox(""),
	packscript.widget, 
	layout = wibox.layout.align.horizontal,
}
packswidget:buttons(my_table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("$TERMINAL -e popupgrade")
    end),
    awful.button({ }, 2, function ()
        awful.spawn.with_shell("$TERMINAL -e pacman -Qu")
    end))
)

-- Network
local netscript = lain.widget.script({
	script_cmd = "network",
	notification_preset = { title = "Network module", timeout = 6, text = [[Click for Network Manager]] },
	settings = function()
        widget:set_markup(markup.font(theme.font, " " .. script_now.text .. " "))
    end
})
netscript.widget:buttons(my_table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("$TERMINAL -e nmtui")
    end))
)
local netwidget = wibox.widget { netscript.widget, layout = wibox.layout.align.horizontal }

-- Battery
local batscript = lain.widget.script({
	script_cmd = "bats",
	notification_preset = { title = "Power module", timeout = 6 },
	settings = function()
        widget:set_markup(markup.font(theme.font, " " .. script_now.text .. " "))
    end
})
local batswidget = wibox.widget { batscript.widget, layout = wibox.layout.align.horizontal }

-- ALSA volume
local volumescript = lain.widget.script({
	script_cmd = "audiovol",
	notification_preset = { title = "Volume module", timeout = 6 },
	updatesignal = "refvol",
	settings = function()
        widget:set_markup(markup.font(theme.font, " " .. script_now.text .. " "))
    end
})
local volumewidget = wibox.widget { volumescript.widget, layout = wibox.layout.align.horizontal }

-- Keyboard
--TODO: Need more work
local keywidget = wibox.widget {
	wibox.widget.textbox(""), 
	awful.widget.keyboardlayout:new (), 
	layout = wibox.layout.align.horizontal 
}

-- Separators
local arrow = separators.arrow_left

function theme.powerline_rl(cr, width, height)
    local arrow_depth, offset = height/2, 0

    -- Avoid going out of the (potential) clip area
    if arrow_depth < 0 then
        width  =  width + 2*arrow_depth
        offset = -arrow_depth
    end

    cr:move_to(offset + arrow_depth         , 0        )
    cr:line_to(offset + width               , 0        )
    cr:line_to(offset + width - arrow_depth , height/2 )
    cr:line_to(offset + width               , height   )
    cr:line_to(offset + arrow_depth         , height   )
    cr:line_to(offset                       , height/2 )

    cr:close_path()
end

local function pl(widget, bgcolor, padding)
    return wibox.container.background(wibox.container.margin(widget, 16, 16), bgcolor, theme.powerline_rl)
end

function theme.at_screen_connect(s)
    -- Quake application
	s.quake = lain.util.quake({ app = "$TERMINAL", height = 0.50, argname = "--name %s" })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- All tags open with layout 1
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    local layoutwidget = wibox.widget { s.mylayoutbox, layout = wibox.layout.align.horizontal }
                           
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    --s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)
	s.mytasklist = awful.widget.tasklist {
		screen   = s,
		filter   = awful.widget.tasklist.filter.currenttags,
		buttons  = awful.util.tasklist_buttons,
		layout   = {
			spacing_widget = {
				{
					forced_width  = 5,
					forced_height = 24,
					thickness     = 1,
					color         = system_colors.white_l,
					widget        = wibox.widget.separator
				},
				valign = 'center',
				halign = 'center',
				widget = wibox.container.place,
			},
			spacing = 1,
			layout  = wibox.layout.fixed.horizontal
		},
		-- Notice that there is *NO* wibox.wibox prefix, it is a template,
		-- not a widget instance.
		widget_template = {
        {
            {
                {
                    {
                        id     = 'icon_role',
                        widget = wibox.widget.imagebox,
                    },
                    margins = 2,
                    widget  = wibox.container.margin,
                },
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                },
                forced_width  = 230,
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 10,
            right = 10,
            widget = wibox.container.margin
        },
        id     = 'background_role',
        widget = wibox.container.background,
        create_callback = function(self, c, index, objects) --luacheck: no unused args
            local tooltip = awful.tooltip({
				objects = { self },
				timer_function = function()
					return c.name
				end,
			})
		end
		},
	}


    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 28, bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            s.mytaglist,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            arrow("alpha", system_colors.blue_l),
            wibox.container.background(wibox.container.margin(mpdwidget, 3, 6, 5, 5), system_colors.blue_l),
            arrow(system_colors.blue_l, system_colors.magenta_l),
            wibox.container.background(wibox.container.margin(weatherwidget , 3, 3), system_colors.magenta_l),
            arrow(system_colors.magenta_l, system_colors.blue_l),
            wibox.container.background(wibox.container.margin(volumewidget, 2, 3), system_colors.blue_l),
            arrow(system_colors.blue_l, system_colors.magenta_l),
            wibox.container.background(wibox.container.margin(batswidget, 4, 8), system_colors.magenta_l),
            arrow(system_colors.magenta_l, system_colors.blue_l),
            wibox.container.background(wibox.container.margin(clockwidget, 4, 8), system_colors.blue_l),
            arrow(system_colors.blue_l, system_colors.magenta_l),
            wibox.container.background(wibox.container.margin(packswidget, 3, 6),system_colors.magenta_l),
            arrow(system_colors.magenta_l, system_colors.blue_l),
            wibox.container.background(wibox.container.margin(keywidget, 10, 0),system_colors.blue_l),
            arrow(system_colors.blue_l, "alpha"),
            wibox.container.margin(netwidget, 3, 6),
            wibox.container.margin(layoutwidget, 3, 6, 5, 5),
            wibox.widget.systray(),
        },
    }
end

return theme
