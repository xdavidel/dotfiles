--- sxhkd hotkeys for awful.hotkeys_widget

local hotkeys_popup = require("awful.hotkeys_popup.widget")

local sxhkd = {}

function sxhkd.add_rules_for_terminal(rule)
    for group_name, group_data in pairs({
        ["sxhkd: apps"] = rule,
    }) do
        hotkeys_popup.add_group_rules(group_name, group_data)
    end
end

local sxhkd_keys = {
    ["sxhkd: general"] = {{
        modifiers = {"Super"},
        keys = {
			q				= "Close window",
			["Insert"]		= "Show clipboard",
			x				= "Lock",
			["Print"]		= "Choose Recording",
			["F1"]			= "Show help",
			["F2"]			= "Refresh Xorg",
			["F3"]			= "Select display",
			["F4"]			= "Hibernate",
			["F5"]			= "Refresh network",
			["F6"]			= "Start torrent daemon",
			["F7"]			= "Toggle torrent daemon",
			["F8"]			= "Sync mail",
			["F9"]			= "Mount drives",
			["F10"]			= "Unmount drives",
			["F11"]			= "Search the web",
        }
	}, {
        modifiers = {"Super+Shift"},
        keys = {
			q				= "Force close window",
			c				= "Toggle camera",
			["Esc"]			= "Exit",
			x				= "Shutdown",
			["Backspace"]	= "Reboot",
			["Print"]		= "Stop Recording",

        }
	}, {
        modifiers = {},
        keys = {
            ["Print"]		= "Screenshot",
        }
	},{

        modifiers = {"Shift"},
        keys = {
            ["Print"]		= "Screenshot Pick",
        }
	}},

    ["sxhkd: apps"] = {{
        modifiers = {"Super"},
        keys = {
            Return			= "Terminal",
			d				= "Dmenu",
			e				= "File manager",
			m				= "Media player",
			n				= "News",
			i				= "Htop",
			y				= "Calendar",
			w				= "Web Browser",
			["`"]			= "Emoji's",
			["Scroll"]		= "Screenkey",
			["F12"]			= "Network manager",
        }
	}, {
        modifiers = {"Super+Shift"},
        keys = {
            Return			= "Terminal samedir",
			d				= "Rofi",
			e				= "GUI File manager",
			a				= "Audio mixer",
			v				= "Tutorial Vidoes",
			w				= "Web Browser Private",
			g				= "Gimp",
			["`"]			= "Font Awesome",
        }
	}, {
        modifiers = {},
        keys = {
        }
	},{

        modifiers = {"Shift"},
        keys = {
        }
	}},
    ["sxhkd: media"] = {{
        modifiers = {"Super"},
        keys = {
            p				= "Toggle Player",
			[","]			= "Prev song",
			["."]			= "Next song",
			["-"]			= "Decrease volume",
			["+"]			= "Increase volume",
			["["]			= "Seek backward",
			["]"]			= "Seek forward",
        }
	}, {
        modifiers = {"Super+Shift"},
        keys = {
			m				= "Toggle mute",
			["["]			= "Seek backward faster",
			["]"]			= "Seek forward faster",
			[","]			= "Replay",
        }
	}, {
        modifiers = {},
        keys = {
        }
	},{

        modifiers = {"Shift"},
        keys = {
        }
	}},
}

hotkeys_popup.add_hotkeys(sxhkd_keys)

return sxhkd
