return {
  {
    "ydkulks/cursor-dark.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("cursor-dark").setup({
        transparent = false,
      })

      vim.cmd.colorscheme("cursor-dark")

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "cursor-dark",
        callback = function()
          ----------------------------------------------------------------------
          -- Base UI (soft black, NOT pitch black)
          ----------------------------------------------------------------------
          local bg = "#0c0c0c"

          vim.api.nvim_set_hl(0, "Normal", { bg = bg, fg = "#f0f0f0" })
          vim.api.nvim_set_hl(0, "NormalNC", { bg = bg })
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg })
          vim.api.nvim_set_hl(0, "SignColumn", { bg = bg })
          vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#262626", bg = bg })
          vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#323232", bg = bg })

          local colors = {
            red = "#F53838",
            green = "#b9e28c",
            yellow = "#ffc300",
            blue = "#9fcfff",
            purple = "#cfaeff",
            cyan = "#8fe6d9",
            fg = "#f0f0f0",
            gray = "#a8a8a8",
          }

          vim.api.nvim_set_hl(0, "Comment", { fg = colors.gray, italic = true })
          vim.api.nvim_set_hl(0, "@comment", { fg = colors.gray, italic = true })

          vim.api.nvim_set_hl(0, "String", { fg = colors.green })
          vim.api.nvim_set_hl(0, "@string", { fg = colors.green })

          vim.api.nvim_set_hl(0, "Function", { fg = colors.yellow })
          vim.api.nvim_set_hl(0, "@function", { fg = colors.yellow })

          vim.api.nvim_set_hl(0, "Keyword", { fg = colors.purple, italic = true })
          vim.api.nvim_set_hl(0, "@keyword", { fg = colors.purple, italic = true })

          vim.api.nvim_set_hl(0, "Type", { fg = colors.cyan })
          vim.api.nvim_set_hl(0, "@type", { fg = colors.cyan })
          vim.api.nvim_set_hl(0, "@type.builtin", { fg = colors.cyan })

          vim.api.nvim_set_hl(0, "Identifier", { fg = colors.red })
          vim.api.nvim_set_hl(0, "@property", { fg = colors.red })
          vim.api.nvim_set_hl(0, "@lsp.type.property", { fg = colors.red })

          vim.api.nvim_set_hl(0, "Constant", { fg = colors.blue })
          vim.api.nvim_set_hl(0, "@constant", { fg = colors.blue })
          vim.api.nvim_set_hl(0, "Number", { fg = colors.blue })
          vim.api.nvim_set_hl(0, "Boolean", { fg = colors.blue })

          ----------------------------------------------------------------------
          -- UI polish
          ----------------------------------------------------------------------
          vim.api.nvim_set_hl(0, "LineNr", { fg = "#4a4a4a", bg = bg })
          vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.yellow, bold = true, bg = bg })
          vim.api.nvim_set_hl(0, "CursorLine", { bg = "#151515" })
          vim.api.nvim_set_hl(0, "VertSplit", { fg = "#2a2a2a", bg = bg })

          vim.api.nvim_set_hl(0, "Visual", { bg = "#1e1e1e" })
          vim.api.nvim_set_hl(0, "Search", { fg = "#000000", bg = colors.yellow })
          vim.api.nvim_set_hl(0, "IncSearch", { fg = "#000000", bg = colors.blue })

          ----------------------------------------------------------------------
          -- Diagnostics
          ----------------------------------------------------------------------
          vim.api.nvim_set_hl(0, "ErrorMsg", { fg = colors.red })
          vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.red })
          vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.yellow })
          vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.blue })
          vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.cyan })

          vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = colors.red, undercurl = true })
          vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = colors.yellow, undercurl = true })
          vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = colors.blue, undercurl = true })
          vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = colors.cyan, undercurl = true })

          ----------------------------------------------------------------------
          -- Completion menu
          ----------------------------------------------------------------------
          vim.api.nvim_set_hl(0, "Pmenu", { bg = "#121212", fg = colors.fg })
          vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#242424", fg = colors.fg })
          vim.api.nvim_set_hl(0, "PmenuBorder", { fg = "#323232", bg = "#121212" })
        end,
      })
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  {
    "sainnhe/gruvbox-material",
    lazy = true,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.o.background = "dark"

      -- Base gruvbox (minimal)
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_foreground = "original"

      -- Reduce visual noise
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_enable_bold = true
      vim.g.gruvbox_material_statusline_style = "default"

      vim.cmd("highlight clear")
      vim.cmd("syntax reset")
      vim.cmd.colorscheme("gruvbox-material")

      ----------------------------------------------------------------
      -- Slab Gruvbox overrides (THIS is the magic)
      ----------------------------------------------------------------
      local set = vim.api.nvim_set_hl

      -- Warm whites / text
      set(0, "Normal", { fg = "#E5D5B1", bg = "#1D2021" })
      set(0, "Identifier", { fg = "#E5D5B1" })
      set(0, "Function", { fg = "#E5D5B1", bold = true })

      -- Keywords & control flow → red
      set(0, "Keyword", { fg = "#FB4934" })
      set(0, "Conditional", { fg = "#FB4934" })
      set(0, "Repeat", { fg = "#FB4934" })

      -- Types & structs → off-white (NOT yellow/green)
      set(0, "Type", { fg = "#E5D5B1" })
      set(0, "Structure", { fg = "#E5D5B1" })

      -- Strings → muted warm (not bright yellow)
      set(0, "String", { fg = "#D5A657" })

      -- Numbers / constants → subtle
      set(0, "Number", { fg = "#D3869B" })
      set(0, "Constant", { fg = "#D3869B" })

      -- Comments → low contrast
      set(0, "Comment", { fg = "#7C6F64", italic = false })

      -- Errors
      set(0, "Error", { fg = "#FB4934", bold = true })
      set(0, "DiagnosticError", { fg = "#FB4934" })

      -- Visual selection
      set(0, "Visual", { bg = "#3C3836" })
    end,
  },

  {
    "tiagovla/tokyodark.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent_background = false,
      gamma = 1.0,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        identifiers = {},
        functions = {},
        variables = {},
      },
    },
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        styles = {
          transparency = false, -- IMPORTANT
          italic = true,
          bold = false,
        },

        highlight_groups = {
          ----------------------------------------------------------------
          -- Kanagawa-style dark background
          ----------------------------------------------------------------
          Normal = { bg = "#0c0c0c" },
          NormalNC = { bg = "#0c0c0c" },
          NormalFloat = { bg = "#0c0c0c" },
          SignColumn = { bg = "#0c0c0c" },
          EndOfBuffer = { fg = "#262626", bg = "#0c0c0c" },
          FloatBorder = { fg = "muted", bg = "#0c0c0c" },

          -- Cursor & selection
          CursorLine = { bg = "#151515" },
          Visual = { bg = "#1e1e1e" },

          -- Line numbers
          LineNr = { fg = "#4a4a4a", bg = "#0c0c0c" },
          CursorLineNr = { fg = "gold", bold = true },

          ----------------------------------------------------------------
          -- Italics (kept exactly how you like them)
          ----------------------------------------------------------------
          Comment = { italic = true },
          ["@comment"] = { italic = true },
          Keyword = { italic = true },
          ["@keyword"] = { italic = true },
          Conditional = { italic = true },
          ["@conditional"] = { italic = true },
          Repeat = { italic = true },
          ["@repeat"] = { italic = true },

          ----------------------------------------------------------------
          -- Telescope polish (unchanged, just darker)
          ----------------------------------------------------------------
          TelescopeBorder = { fg = "muted", bg = "#0c0c0c" },
          TelescopeNormal = { bg = "#0c0c0c" },
          TelescopePromptNormal = { bg = "base" },
          TelescopeResultsNormal = { fg = "subtle", bg = "#0c0c0c" },
          TelescopeSelection = { fg = "text", bg = "base" },
          TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
        },

        groups = {
          border = "muted",
          link = "iris",
          panel = "surface",

          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",

          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",
        },
      })

      vim.cmd.colorscheme("rose-pine")
    end,
  },

  {
    "navarasu/onedark.nvim",
    name = "onedark",
    lazy = true,
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "darker",
        transparent = true,
        terminal_colors = true,
        code_style = {
          comments = "italic",
          keywords = "italic",
          functions = "none",
          strings = "none",
          variables = "none",
        },
      })
    end,
  },

  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("solarized-osaka").setup({
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.4, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = true, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

        on_colors = function(colors) end,
        on_highlights = function(hl, c)
          local prompt = "#2d3149"
          hl.TelescopeNormal = {
            bg = c.bg_dark,
            fg = c.fg_dark,
          }
          hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.TelescopePromptNormal = {
            bg = prompt,
          }
          hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopePromptTitle = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopePreviewTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
        end,
      })
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { italic = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,

        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },

        overrides = function(colors)
          local theme = colors.theme
          return {
            -- Base UI
            Normal = { fg = theme.ui.fg, bg = "#0c0c0c" },
            NormalNC = { bg = "#0c0c0c" },
            NormalFloat = { bg = "#0c0c0c" },
            FloatBorder = { fg = theme.ui.border, bg = "#0c0c0c" },
            SignColumn = { bg = "#0c0c0c" },
            EndOfBuffer = { fg = "#262626", bg = "#0c0c0c" },

            -- Cursor / selection
            CursorLine = { bg = "#151515" },
            Visual = { bg = "#1e1e1e" },

            -- Line numbers
            LineNr = { fg = "#4a4a4a", bg = "#0c0c0c" },
            CursorLineNr = { fg = colors.palette.carpYellow, bold = true },

            -- Comments
            Comment = { fg = "#8a8a8a", italic = true },
            ["@comment"] = { fg = "#8a8a8a", italic = true },

            -- Keywords
            Keyword = { fg = colors.palette.oniViolet, italic = true },
            ["@keyword"] = { fg = colors.palette.oniViolet, italic = true },

            -- Functions
            Function = { fg = colors.palette.springBlue },
            ["@function"] = { fg = colors.palette.springBlue },

            -- Types
            Type = { fg = colors.palette.lightBlue },
            ["@type"] = { fg = colors.palette.lightBlue },

            -- Strings
            String = { fg = colors.palette.springGreen },
            ["@string"] = { fg = colors.palette.springGreen },

            -- Numbers / constants
            Number = { fg = colors.palette.surimiOrange },
            Boolean = { fg = colors.palette.surimiOrange },
            Constant = { fg = colors.palette.surimiOrange },

            -- Diagnostics
            DiagnosticError = { fg = colors.palette.samuraiRed },
            DiagnosticWarn = { fg = colors.palette.roninYellow },
            DiagnosticInfo = { fg = colors.palette.dragonBlue },
            DiagnosticHint = { fg = colors.palette.waveAqua },

            DiagnosticUnderlineError = { undercurl = true, sp = colors.palette.samuraiRed },
            DiagnosticUnderlineWarn = { undercurl = true, sp = colors.palette.roninYellow },
            DiagnosticUnderlineInfo = { undercurl = true, sp = colors.palette.dragonBlue },
            DiagnosticUnderlineHint = { undercurl = true, sp = colors.palette.waveAqua },

            -- Completion menu
            Pmenu = { bg = "#121212", fg = theme.ui.fg },
            PmenuSel = { bg = "#242424", fg = theme.ui.fg },
            PmenuBorder = { fg = theme.ui.border, bg = "#121212" },
          }
        end,
      })

      vim.cmd.colorscheme("kanagawa")
    end,
  },
  {
    "adibhanna/forest-night.nvim",
    priority = 1000,
    lazy = true,
    config = function()
      vim.o.termguicolors = true

      -- 🔘 Toggle like rose-pine
      local transparency = true

      vim.cmd.colorscheme("forest-night")

      if transparency then
        local groups = {
          -- Core
          "Normal",
          "NormalNC",
          "NormalFloat",
          "SignColumn",
          "EndOfBuffer",
          "MsgArea",

          -- UI
          "StatusLine",
          "StatusLineNC",
          "VertSplit",
          "WinSeparator",
          "LineNr",
          "CursorLineNr",
          "CursorLine",

          -- Popups / completion
          "Pmenu",
          "PmenuSel",
          "PmenuSbar",
          "PmenuThumb",
          "FloatBorder",

          -- Telescope
          "TelescopeNormal",
          "TelescopeBorder",
          "TelescopePromptNormal",
          "TelescopePromptBorder",
          "TelescopeResultsNormal",
          "TelescopePreviewNormal",
        }

        for _, group in ipairs(groups) do
          vim.api.nvim_set_hl(0, group, { bg = "none" })
        end
      end

      ------------------------------------------------------------------
      -- Italics (same vibe as your rose-pine config)
      ------------------------------------------------------------------
      local italic_groups = {
        "Comment",
        "Keyword",
        "Conditional",
        "Repeat",
        "Exception",
        "Include",
        "@comment",
        "@keyword",
        "@conditional",
        "@repeat",
        "@exception",
        "@include",
      }

      for _, group in ipairs(italic_groups) do
        vim.api.nvim_set_hl(0, group, { italic = true })
      end
    end,
  },
}
