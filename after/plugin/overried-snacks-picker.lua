return {
  -- Override the entire snacks_picker extra to prevent it from loading
  {
    "nvim-telescope/telescope.nvim",
    keys = function()
      -- Return empty to override snacks_picker keymaps
      return {}
    end,
    optional = true,
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.dashboard = { enabled = false }
      opts.picker = { enabled = false }
      return opts
    end,
  },
}
