local M = {}

M.config = function ()
  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  lualine.setup {
    options = {
      icons_enabled = false,
      theme = 'tokyonight',
      component_separators = {'', ''},
      section_separators = {'', ''},
      disabled_filetypes = {}
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
  }
end

return M
