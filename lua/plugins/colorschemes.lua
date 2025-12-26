return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    config = function()
      -- Gruvbox configuration
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        inverse = true, -- invert bg for search, diffs, statuslines and errors
        contrast = "hard", -- dark mode: hard contrast
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
      })

      -- Helper command to switch to dark hard variant
      -- :GruvboxDarkHard  -> dark mode, hard contrast
      vim.api.nvim_create_user_command("GruvboxDarkHard", function()
        require("gruvbox").setup({
          terminal_colors = true,
          undercurl = true,
          underline = true,
          bold = true,
          italic = {
            strings = true,
            emphasis = true,
            comments = true,
            operators = false,
            folds = true,
          },
          strikethrough = true,
          invert_selection = false,
          invert_signs = false,
          invert_tabline = false,
          inverse = true,
          contrast = "hard",
          palette_overrides = {},
          overrides = {},
          dim_inactive = false,
          transparent_mode = true,
        })
        vim.o.background = "dark"
        vim.cmd("colorscheme gruvbox")
      end, {})
    end,
  },

  -- Tokyodark theme
  {
    "tiagovla/tokyodark.nvim",
    lazy = true,
    opts = {
      transparent_background = true,
      gamma = 1.0,
    },
  },

  -- Rose Pine theme (default)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        styles = { transparency = true },
        disable_background = true,
        disable_float_background = true,
      })
    end,
  },
}
