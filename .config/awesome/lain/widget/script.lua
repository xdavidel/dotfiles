local helpers  = require("lain.helpers")
local awful	   = require("awful")
local focused  = require("awful.screen").focused
local naughty  = require("naughty")
local wibox    = require("wibox")

local function factory(args)
    local script				= { widget = wibox.widget.textbox() }
    local args             		= args or {}
    local timeout               = args.timeout or 60 * 15 -- 15 min
    local script_cmd            = args.script_cmd    
    local notification_preset   = args.notification_preset or {}
    local notification_text_fun = args.notification_text_fun or function() end
    local script_na_markup      = args.script_na_markup or " N/A "
    local followtag             = args.followtag or false
    local showpopup             = args.showpopup or "on"
    local settings              = args.settings or function() end
    local updatesignal			= args.updatesignal or "refbar"
    local result				= ""

    script.widget:set_markup(script_na_markup)

	function script.show(t_out)
		script.hide()

        if followtag then
            notification_preset.screen = focused()
        end

        if not script.notification_text then
            script.update()
        end

        script.notification = naughty.notify({
            text    = script.notification_text,
            --icon    = script.icon_path,
            timeout = t_out,
            preset  = notification_preset
        })
    end

    function script.hide()
        if script.notification then
            naughty.destroy(script.notification)
            script.notification = nil
        end
    end

    function script.attach(obj)
        obj:connect_signal("mouse::enter", function()
            script.show(0)
        end)
        obj:connect_signal("mouse::leave", function()
            script.hide()
        end)
    end

    function script.update()
        awful.spawn.easy_async_with_shell(script_cmd, function(out)
			script_now = { text = out }
			widget = script.widget
            settings()
		end)
    end
    
    awesome.connect_signal(updatesignal, function()
			--naughty.notify { text = "Update" }
			script.update()
		end
	)

    if showpopup == "on" then script.attach(script.widget) end

    script.timer = helpers.newtimer("script", timeout, script.update, false, true)

    return script
end

return factory
