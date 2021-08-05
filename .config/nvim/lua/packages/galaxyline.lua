local M = {}

M.config = function ()
  local status_ok, galaxyline = pcall(require, "galaxyline")
  if not status_ok then
    return
  end

  local condition = require("galaxyline.condition")
  local gls = galaxyline.section

  galaxyline.short_line_list = { "NvimTree" }

  local colors = O.colors

  table.insert(gls.left, {
    ViMode = {
      provider = function()
        -- auto change color according the vim mode
        local mode_color = {
          n = colors.blue,
          i = colors.green,
          v = colors.purple,
          [""] = colors.purple,
          V = colors.purple,
          c = colors.magenta,
          no = colors.blue,
          s = colors.orange,
          S = colors.orange,
          [""] = colors.orange,
          ic = colors.yellow,
          R = colors.red,
          Rv = colors.red,
          cv = colors.blue,
          ce = colors.blue,
          r = colors.cyan,
          rm = colors.cyan,
          ["r?"] = colors.cyan,
          ["!"] = colors.blue,
          t = colors.blue,
        }
        vim.api.nvim_command("hi GalaxyViMode guibg=" .. mode_color[vim.fn.mode()])
        vim.api.nvim_command("hi GalaxySpace guibg=" .. mode_color[vim.fn.mode()])
        return "  " .. string.upper(vim.fn.mode()) .. " "
      end,
      separator_highlight = { "NONE", colors.alt_bg },
      separator = " ",
      highlight = { "NONE", colors.alt_bg },
    },
  })

  table.insert(gls.left, {
    FileName = {
      provider = "FileName",
      separator = " ",
      separator_highlight = { "NONE", colors.alt_bg },
      highlight = { colors.grey, colors.alt_bg },
    },
  })


  table.insert(gls.left, {
    GitLeft = {
      provider = function() return "|" end,
      condition = condition.check_git_workspace,
      separator = " ",
      separator_highlight = { "NONE", colors.alt_bg },
      highlight = { colors.grey, colors.alt_bg },
    },
  })

  table.insert(gls.left, {
    GitBranch = {
      provider = "GitBranch",
      condition = condition.check_git_workspace,
      separator = " ",
      separator_highlight = { "NONE", colors.alt_bg },
      highlight = { colors.grey, colors.alt_bg },
    },
  })

  table.insert(gls.left, {
    DiffAdd = {
      provider = "DiffAdd",
      condition = condition.hide_in_width,
      icon = "  ",
      highlight = { colors.green, colors.alt_bg },
    },
  })

  table.insert(gls.left, {
    DiffModified = {
      provider = "DiffModified",
      condition = condition.hide_in_width,
      icon = "  ",
      highlight = { colors.blue, colors.alt_bg },
    },
  })

  table.insert(gls.left, {
    DiffRemove = {
      provider = "DiffRemove",
      condition = condition.hide_in_width,
      icon = "  ",
      highlight = { colors.red, colors.alt_bg },
    },
  })

  table.insert(gls.left, {
    GitRight = {
      provider = function() return "|" end,
      condition = condition.check_git_workspace,
      separator = " ",
      separator_highlight = { "NONE", colors.alt_bg },
      highlight = { colors.grey, colors.alt_bg },
    },
  })

  table.insert(gls.left, {
    Filler = {
      provider = function()
        return " "
      end,
      highlight = { colors.grey, colors.alt_bg },
    },
  })

  table.insert(gls.right, {
    DiagnosticError = {
      provider = "DiagnosticError",
      icon = "  ",
      highlight = { colors.red, colors.alt_bg },
    },
  })

  table.insert(gls.right, {
    DiagnosticWarn = {
      provider = "DiagnosticWarn",
      icon = "  ",
      highlight = { colors.orange, colors.alt_bg },
    },
  })

  table.insert(gls.right, {
    DiagnosticInfo = {
      provider = "DiagnosticInfo",
      icon = "  ",
      highlight = { colors.yellow, colors.alt_bg },
    },
  })

  table.insert(gls.right, {
    DiagnosticHint = {
      provider = "DiagnosticHint",
      icon = "  ",
      highlight = { colors.blue, colors.alt_bg },
    },
  })

  table.insert(gls.right, {
    TreesitterIcon = {
      provider = function()
        if next(vim.treesitter.highlighter.active) ~= nil then
          return "  "
        end
        return ""
      end,
      separator = " ",
      separator_highlight = { "NONE", colors.alt_bg },
      highlight = { colors.green, colors.alt_bg },
    },
  })

table.insert(gls.right, {
  ShowLspClient = {
    provider = "GetLspClient",
    condition = function()
      return next(vim.lsp.buf_get_clients()) ~= nil end,
    icon = "  ",
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.right, {
  LineInfo = {
    provider = "LineColumn",
    separator = "  ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.right, {
  PerCent = {
    provider = "LinePercent",
    separator = " ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.right, {
  Tabstop = {
    provider = function()
      local label = "Spaces: "
      if not vim.api.nvim_buf_get_option(0, "expandtab") then
        label = "Tab size: "
      end
      return label .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
    end,
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.right, {
  BufferType = {
    provider = "FileTypeName",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.right, {
  FileEncode = {
    provider = "FileEncode",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.right, {
  Space = {
    provider = function()
      return " "
    end,
    separator = " ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.grey, colors.alt_bg },
  },
})

table.insert(gls.short_line_left, {
  BufferType = {
    provider = "FileTypeName",
    separator = " ",
    separator_highlight = { "NONE", colors.alt_bg },
    highlight = { colors.alt_bg, colors.alt_bg },
  },
})

table.insert(gls.short_line_left, {
  SFileName = {
    provider = "SFileName",
    condition = condition.buffer_not_empty,
    highlight = { colors.alt_bg, colors.alt_bg },
  },
})
end

return M
