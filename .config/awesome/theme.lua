---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

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

local theme = {
    dir             = homedir .. "/.config/awesome/themes/base",
    wallpaper       = homedir .. "/.config/wall.png",
    font            = "mono 12",
    taglist_font    = "sans 12",
    fg_normal       = system_colors.foreground,
    fg_focus        = system_colors.white_d,
    fg_urgent       = system_colors.foreground,
    fg_minimize     = system_colors.foreground,
    bg_normal       = system_colors.background,
    bg_minimize     = system_colors.black_l,
    bg_focus        = system_colors.magenta_d,
    bg_urgent       = system_colors.red_d,
    bg_systray      = system_colors.background,
    border_normal   = system_colors.black_l,
    border_focus    = system_colors.magenta_l,
    border_width    = dpi(3),
    useless_gap     = dpi(4),
}

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming the menu:
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(25)
theme.menu_width  = dpi(200)

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
