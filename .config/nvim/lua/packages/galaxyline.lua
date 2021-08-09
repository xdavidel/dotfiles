local M = {}

M.config = function ()
  local status_ok, galaxyline = pcall(require, "galaxyline")
  if not status_ok then
    return
  end

  local condition = require("galaxyline.condition")
  local section = galaxyline.section

  -- Hide / short status bar for
  galaxyline.short_line_list = { "NvimTree", "vista", "dbui", "packer" }

  local colors = O.colors

  local left_widgets = {
    {
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
      }
    },
    {
      FileName = {
        provider = "FileName",
        separator = " ",
        separator_highlight = { "NONE", colors.alt_bg },
        highlight = { colors.grey, colors.alt_bg },
      }
    },
    {
      GitLeft = {
        provider = function() return "|" end,
        condition = condition.check_git_workspace,
        separator = " ",
        separator_highlight = { "NONE", colors.alt_bg },
        highlight = { colors.grey, colors.alt_bg },
      }
    },
    {
      GitBranch = {
        provider = "GitBranch",
        condition = condition.check_git_workspace,
        separator = " ",
        separator_highlight = { "NONE", colors.alt_bg },
        highlight = { colors.grey, colors.alt_bg },
      }
    },
    {
      DiffAdd = {
        provider = "DiffAdd",
        condition = condition.hide_in_width,
        icon = " " .. O.icons.plus,
        highlight = { colors.green, colors.alt_bg },
      }
    },
    {
      DiffModified = {
        provider = "DiffModified",
        condition = condition.hide_in_width,
        icon = " " .. O.icons.connect,
        highlight = { colors.blue, colors.alt_bg },
      }
    },
    {
      DiffRemove = {
        provider = "DiffRemove",
        condition = condition.hide_in_width,
        icon = " " .. O.icons.minus,
        highlight = { colors.red, colors.alt_bg },
      }
    },
    {
      GitRight = {
        provider = function() return "|" end,
        condition = condition.check_git_workspace,
        separator = " ",
        separator_highlight = { "NONE", colors.alt_bg },
        highlight = { colors.grey, colors.alt_bg },
      }
    },
    {
      Filler = {
        provider = function()
          return " "
        end,
        highlight = { colors.grey, colors.alt_bg },
      }
    },
  }

  local right_widget = {
    {
      DiagnosticError = {
        provider = "DiagnosticError",
        icon = " " .. O.icons.error,
        highlight = { colors.red, colors.alt_bg },
      }
    },

    {
      DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = " " .. O.icons.warning,
        highlight = { colors.orange, colors.alt_bg },
      }
    },

    {
      DiagnosticInfo = {
        provider = "DiagnosticInfo",
        icon = " " .. O.icons.info,
        highlight = { colors.yellow, colors.alt_bg },
      }
    },

    {
      DiagnosticHint = {
        provider = "DiagnosticHint",
        icon = " " .. O.icons.bulb,
        highlight = { colors.blue, colors.alt_bg },
      }
    },

    {
      TreesitterIcon = {
        provider = function()
          if next(vim.treesitter.highlighter.active) ~= nil then
            return " " .. O.icons.tree
          end
          return ""
        end,
        separator = " ",
        separator_highlight = { "NONE", colors.alt_bg },
        highlight = { colors.green, colors.alt_bg },
      }
    },
    {
      ShowLspClient = {
        provider = "GetLspClient",
        condition = function()
          return next(vim.lsp.buf_get_clients()) ~= nil end,
          icon = " " .. O.icons.gear,
          highlight = { colors.grey, colors.alt_bg },
        }
    },
    {
      LineInfo = {
        provider = "LineColumn",
        separator = "  ",
        separator_highlight = { "NONE", colors.alt_bg },
        highlight = { colors.grey, colors.alt_bg },
      }
    },
    {
      PerCent = {
        provider = "LinePercent",
        separator = " ",
        separator_highlight = { "NONE", colors.alt_bg },
        highlight = { colors.grey, colors.alt_bg },
      }
    },
    {
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
      }
    },
    {
      BufferType = {
        provider = "FileTypeName",
        condition = condition.hide_in_width,
        separator = " ",
        separator_highlight = { "NONE", colors.alt_bg },
        highlight = { colors.grey, colors.alt_bg },
      }
    },
    {
      FileEncode = {
        provider = "FileEncode",
        condition = condition.hide_in_width,
        separator = " ",
        separator_highlight = { "NONE", colors.alt_bg },
        highlight = { colors.grey, colors.alt_bg },
      }
    },
    {
      Space = {
        provider = function()
          return " "
        end,
        separator = " ",
        separator_highlight = { "NONE", colors.alt_bg },
        highlight = { colors.grey, colors.alt_bg },
      }
    },
  }

  local left_short_widgets = {
    BufferType = {
      provider = "FileTypeName",
      separator = " ",
      separator_highlight = { "NONE", colors.alt_bg },
      highlight = { colors.alt_bg, colors.alt_bg },
    },
    SFileName = {
      provider = "SFileName",
      condition = condition.buffer_not_empty,
      highlight = { colors.alt_bg, colors.alt_bg },
    },
  }

  for i, widget in ipairs(left_widgets) do
    section.left[i] = widget
  end

  for i, widget in ipairs(right_widget) do
    section.right[i] = widget
  end

  for i, widget in ipairs(left_short_widgets) do
    section.short_line_left[i] = widget
  end

end

return M
