---------------------------
-- Base awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local home_dir    = os.getenv("HOME")
local themes_dir  = home_dir .. "/.config/awesome/themes"

local theme = {}

theme.font          = "sans mono 12"

theme.bg_normal     = xrdb.color8
theme.bg_focus      = xrdb.color5
theme.bg_urgent     = xrdb.color1
theme.bg_minimize   = xrdb.color8
theme.bg_systray    = xrdb.color8
theme.fg_normal     = xrdb.color15
theme.fg_focus      = xrdb.color15
theme.fg_urgent     = xrdb.color15
theme.fg_minimize   = xrdb.color15
theme.border_normal = xrdb.color8
theme.border_focus  = xrdb.color5
theme.border_marked = xrdb.color8


theme.useless_gap   = dpi(6)
theme.border_width  = dpi(5)

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(30)
theme.menu_width  = dpi(200)

-- Set wallpaper
theme.wallpaper = home_dir.."/.config/wall.png"

-- Define the image to load
theme.titlebar_close_button_normal              = themes_dir.."base/titlebar/close.svg"
theme.titlebar_close_button_focus               = themes_dir.."base/titlebar/close.svg"

theme.titlebar_minimize_button_normal           = themes_dir.."base/titlebar/minimize.svg"
theme.titlebar_minimize_button_focus            = themes_dir.."base/titlebar/minimize.svg"

theme.titlebar_ontop_button_normal_inactive     = themes_dir.."base/titlebar/ontop.svg"
theme.titlebar_ontop_button_focus_inactive      = themes_dir.."base/titlebar/ontop.svg"
theme.titlebar_ontop_button_normal_active       = themes_dir.."base/titlebar/ontop.svg"
theme.titlebar_ontop_button_focus_active        = themes_dir.."base/titlebar/ontop.svg"

theme.titlebar_floating_button_normal_inactive  = themes_dir.."base/titlebar/floating.svg"
theme.titlebar_floating_button_focus_inactive   = themes_dir.."base/titlebar/floating.svg"
theme.titlebar_floating_button_normal_active    = themes_dir.."base/titlebar/floating.svg"
theme.titlebar_floating_button_focus_active     = themes_dir.."base/titlebar/floating.svg"

theme.titlebar_maximized_button_normal_inactive = themes_dir.."base/titlebar/maximized.svg"
theme.titlebar_maximized_button_focus_inactive  = themes_dir.."base/titlebar/maximized.svg"
theme.titlebar_maximized_button_normal_active   = themes_dir.."base/titlebar/maximized.svg"
theme.titlebar_maximized_button_focus_active    = themes_dir.."base/titlebar/maximized.svg"


-- You can use your own layout icons like this:
theme.layout_floating   = themes_dir.."/base/layouts/floating.svg"
theme.layout_magnifier  = themes_dir.."/base/layouts/magnifier.svg"
theme.layout_max        = themes_dir.."/base/layouts/max.svg"
theme.layout_fullscreen = themes_dir.."/base/layouts/fullscreen.svg"
theme.layout_tilebottom = themes_dir.."/base/layouts/tilebottom.svg"
theme.layout_tileleft   = themes_dir.."/base/layouts/tileleft.svg"
theme.layout_tile       = themes_dir.."/base/layouts/tile.svg"
theme.layout_tiletop    = themes_dir.."/base/layouts/tiletop.svg"
theme.layout_spiral     = themes_dir.."/base/layouts/spiral.svg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
