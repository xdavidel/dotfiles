-- Grab environment
-----------------------------------------------------------------------------------------------------------------------
local table = table
local string = string
local setmetatable = setmetatable
local awful = require("awful")
local watch = require("awful.widget.watch")
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")

local tooltip = require("redflat.float.tooltip")
local audio = require("redflat.gauge.audio.blue")
local rednotify = require("redflat.float.notify")
local redutil = require("redflat.util")


-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local pulse = { widgets = {}, mt = {} }
pulse.startup_time = 4

-- Generate default theme vars
-----------------------------------------------------------------------------------------------------------------------
local function default_style()
	local style = {
		notify      = {},
		widget      = audio.new,
		audio       = {}
	}
	return redutil.table.merge(style, redutil.table.check(beautiful, "widget.pulse") or {})
end

local change_volume_default_args = {
	down        = false,
	step        = math.floor(65536 / 100 * 5 + 0.5),
	show_notify = false
}

-- Support functions
-----------------------------------------------------------------------------------------------------------------------
local function get_default_sink(args)
	args = args or {}
	local type_ = args.type or "sink"

	local cmd = string.format("pacmd dump | grep 'set-default-%s'", type_)
	local output = redutil.read.output(cmd)
	local def_sink = string.match(output, "set%-default%-%w+%s(.+)\r?\n")

	return def_sink
end

-- Change volume level
-----------------------------------------------------------------------------------------------------------------------
function pulse:change_volume(args)

	-- initialize vars
	args = redutil.table.merge(change_volume_default_args, args or {})
	local updown = args.down and -1 or 1

	-- set new volume
	awful.spawn(string.format("pulsemixer --change-volume %d", 5 * updown))

	-- update volume indicators
	self:update_volume()
end

-- Set mute
-----------------------------------------------------------------------------------------------------------------------
function pulse:mute(args)
	awful.spawn(string.format("pulsemixer --toggle-mute"))

	self:update_volume()
end

-- Update volume level info
-----------------------------------------------------------------------------------------------------------------------
function pulse:update_volume(args)
	args = args or {}
	if not self._type or not self._sink then return end

	-- get current volume and mute state
	local volume = redutil.read.output(string.format("pulsemixer --get-volume | awk '{printf $1}'"))
	local m = redutil.read.output(string.format("pulsemixer --get-mute'"))

	local mute = not m

	-- update widgets value
	self:set_value(volume / 150)
	self:set_mute(mute)
	self._tooltip:set_text(volume .. "%")
end

-- Create a new pulse widget
-- @param timeout Update interval
-----------------------------------------------------------------------------------------------------------------------
function pulse.new(args, style)

	-- Initialize vars
	--------------------------------------------------------------------------------
	style = redutil.table.merge(default_style(), style or {})

	args = args or {}
	local timeout = args.timeout or 5
	local autoupdate = args.autoupdate or false

	-- create widget
	--------------------------------------------------------------------------------
	local widg = style.widget(style.audio)
	gears.table.crush(widg, pulse, true) -- dangerous since widget have own methods, but let it be by now

	widg._type = args.type or "sink"
	widg._sink = args.sink
	widg._style = style

	table.insert(pulse.widgets, widg)

	-- Set tooltip
	--------------------------------------------------------------------------------
	widg._tooltip = tooltip({ objects = { widg } }, style.tooltip)

	watch('pulsemixer --get-volume', 1, function() widg:update_volume() end, {})

	-- Set startup timer
	-- This is workaround if module activated bofore pulseaudio servise start
	--------------------------------------------------------------------------------
	if not widg._sink then
		local st = gears.timer({ timeout = 1 })
		local counter = 0
		st:connect_signal("timeout", function()
			counter = counter + 1
			widg._sink = get_default_sink({ type = widg._type })
			if widg._sink then widg:update_volume() end
			if counter > pulse.startup_time or widg._sink then st:stop() end
		end)
		st:start()
	else
		widg:update_volume()
	end

	--------------------------------------------------------------------------------
	return widg
end

-- Config metatable to call pulse module as function
-----------------------------------------------------------------------------------------------------------------------
function pulse.mt:__call(...)
	return pulse.new(...)
end

return setmetatable(pulse, pulse.mt)
