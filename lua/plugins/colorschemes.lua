return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- darkest variant (latte, frappe, macchiato, mocha)
        transparent_background = true,
        term_colors = true,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          keywords = { "italic" },
          functions = {},
          strings = {},
          variables = {},
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          neotree = true,
          treesitter = true,
          telescope = { enabled = true },
          mason = true,
          which_key = true,
        },
        color_overrides = {
          mocha = {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000",
          },
        },
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        colors.bg = "#000000"
        colors.bg_dark = "#000000"
        colors.bg_float = "#000000"
        colors.bg_sidebar = "#000000"
      end,
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
      vim.g.gruvbox_material_transparent_background = 2 -- full transparency

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

      -- Warm whites / text - transparent bg
      set(0, "Normal", { fg = "#E5D5B1", bg = "NONE" })
      set(0, "NormalNC", { bg = "NONE" })
      set(0, "NormalFloat", { bg = "NONE" })
      set(0, "SignColumn", { bg = "NONE" })
      set(0, "EndOfBuffer", { bg = "NONE" })
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
      transparent_background = true,
      gamma = 1.0,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        identifiers = {},
        functions = {},
        variables = {},
      },
      custom_highlights = function(highlights, palette)
        return {
          Normal = { bg = "NONE" },
          NormalNC = { bg = "NONE" },
          NormalFloat = { bg = "NONE" },
          SignColumn = { bg = "NONE" },
          EndOfBuffer = { bg = "NONE" },
        }
      end,
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
          transparency = true, -- Enable transparency
          italic = true,
          bold = false,
        },

        highlight_groups = {
          ----------------------------------------------------------------
          -- Transparent black background
          ----------------------------------------------------------------
          Normal = { bg = "NONE" },
          NormalNC = { bg = "NONE" },
          NormalFloat = { bg = "NONE" },
          SignColumn = { bg = "NONE" },
          EndOfBuffer = { fg = "#262626", bg = "NONE" },
          FloatBorder = { fg = "muted", bg = "NONE" },

          -- Cursor & selection
          CursorLine = { bg = "#151515" },
          Visual = { bg = "#1e1e1e" },

          -- Line numbers
          LineNr = { fg = "#4a4a4a", bg = "NONE" },
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
          -- Telescope polish (transparent)
          ----------------------------------------------------------------
          TelescopeBorder = { fg = "muted", bg = "NONE" },
          TelescopeNormal = { bg = "NONE" },
          TelescopePromptNormal = { bg = "NONE" },
          TelescopeResultsNormal = { fg = "subtle", bg = "NONE" },
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
        colors = {
          bg0 = "#000000",
          bg1 = "#000000",
          bg2 = "#000000",
          bg3 = "#000000",
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
          sidebars = "transparent",
          floats = "transparent",
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.4, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = true, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

        on_colors = function(colors)
          colors.bg = "#000000"
          colors.bg_dark = "#000000"
          colors.bg_float = "#000000"
          colors.bg_sidebar = "#000000"
        end,
        on_highlights = function(hl, c)
          hl.Normal = { bg = "NONE" }
          hl.NormalNC = { bg = "NONE" }
          hl.NormalFloat = { bg = "NONE" }
          hl.SignColumn = { bg = "NONE" }
          hl.TelescopeNormal = {
            bg = "NONE",
            fg = c.fg_dark,
          }
          hl.TelescopeBorder = {
            bg = "NONE",
            fg = c.bg_dark,
          }
          hl.TelescopePromptNormal = {
            bg = "NONE",
          }
          hl.TelescopePromptBorder = {
            bg = "NONE",
            fg = c.bg_dark,
          }
          hl.TelescopePromptTitle = {
            bg = "NONE",
            fg = c.fg_dark,
          }
          hl.TelescopePreviewTitle = {
            bg = "NONE",
            fg = c.fg_dark,
          }
          hl.TelescopeResultsTitle = {
            bg = "NONE",
            fg = c.fg_dark,
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
        transparent = true,
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
            -- Base UI - transparent
            Normal = { fg = theme.ui.fg, bg = "NONE" },
            NormalNC = { bg = "NONE" },
            NormalFloat = { bg = "NONE" },
            FloatBorder = { fg = theme.ui.border, bg = "NONE" },
            SignColumn = { bg = "NONE" },
            EndOfBuffer = { fg = "#262626", bg = "NONE" },

            -- Cursor / selection
            CursorLine = { bg = "#151515" },
            Visual = { bg = "#1e1e1e" },

            -- Line numbers
            LineNr = { fg = "#4a4a4a", bg = "NONE" },
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
            Pmenu = { bg = "NONE", fg = theme.ui.fg },
            PmenuSel = { bg = "#242424", fg = theme.ui.fg },
            PmenuBorder = { fg = theme.ui.border, bg = "NONE" },
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
  {
    "philosofonusus/morta.nvim",
    name = "morta",
    priority = 1000,
    lazy = true,
    config = function()
      -- setup morta
      require("morta").setup({
        styles = {
          transparency = true,
          italic = true,
          bold = false,
        },
      })

      -- load colorscheme
      vim.cmd.colorscheme("morta")

      -- FORCE highlights after colorscheme
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local neotree_bg = "#0a0a0a" -- slightly lighter than pure black
          local subtle = "#1a1a1a"

          -- === editor background - transparent ===
          vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })

          -- === remove white separator line ===
          vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#000000", bg = "NONE" })
          vim.api.nvim_set_hl(0, "VertSplit", { fg = "#000000", bg = "NONE" })

          -- === Neo-tree separation ===
          vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = neotree_bg })
          vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = neotree_bg })
          vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = neotree_bg })

          -- cursor line inside neotree
          vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = subtle })

          -- indent guides
          vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#303030" })

          -- optional: line numbers cleaner
          vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
          vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
        end,
      })
    end,
  },
  {
    "nobbmaestro/nvim-andromeda",
    priority = 1000, -- load before other UI stuff
    lazy = true,
    dependencies = {
      {
        "tjdevries/colorbuddy.nvim",
        branch = "dev",
      },
    },
    config = function()
      require("andromeda").setup({
        transparent_bg = true,
      })
      vim.cmd.colorscheme("andromeda")

      -- Force transparent backgrounds
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
    end,
  },
}
