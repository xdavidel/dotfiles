local utils = require "mp.utils"

local homedir = os.getenv('HOME')
local configpath = ("/.config/mpv/lastvolume")
local volumepath = homedir .. configpath

function save_volume()
	local file = io.open(volumepath, "w")
	local currentvolume = mp.get_property("volume")
	file:write(currentvolume)
	file:close()
end

function load_volume()
	local file = io.open(volumepath, "r")
	local lastvolume = file:read()
	file:close()
	if lastvolume then
		mp.set_property("volume", lastvolume)
	end
end

-- load volume on start
load_volume()

-- save volume on exit
mp.register_event("shutdown", save_volume)
