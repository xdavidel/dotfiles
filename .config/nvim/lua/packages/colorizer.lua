local M = {}

M.config = function()
  O.plugin.colorizer = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  }
end

M.setup = function()
  local status_ok, colorizer = pcall(require, "colorizer")
  if not status_ok then
    print("Problem with colorizer")
    return
  end

  colorizer.setup({ "*" }, O.plugin.colorizer)
end

return M
