return {
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    opts = {
      -- General options
      auto_update = true,
      neovim_image_text = "Neovim - The Superior Text Editor",
      main_image = "neovim", -- or "file" to show file icon
      client_id = "793271441293967371",
      log_level = nil,
      debounce_timeout = 10,
      enable_line_number = false,
      blacklist = {}, -- Add directories to blacklist like: { "/path/to/secret" }
      buttons = true,
      file_assets = nil,
      show_time = true,

      -- Rich presence text (uses %s as placeholder)
      editing_text = "Editing %s",
      file_explorer_text = "Browsing %s",
      git_commit_text = "Committing changes",
      plugin_manager_text = "Managing plugins",
      reading_text = "Reading %s",
      workspace_text = "Working on %s",
      line_number_text = "Line %s out of %s",
    },

    config = function(_, opts)
      require("presence").setup(opts)

      -- Keymaps for control
      vim.keymap.set("n", "<leader>dc", function()
        vim.cmd("PresenceCancel")
        vim.defer_fn(function()
          vim.cmd("Presence")
        end, 500)
        vim.notify("Discord Presence toggled", vim.log.levels.INFO)
      end, { desc = "Toggle Discord Presence", silent = true })

      -- Individual commands
      vim.keymap.set("n", "<leader>dd", "<cmd>PresenceCancel<cr>", {
        desc = "Disable Discord Presence",
        silent = true,
      })

      vim.keymap.set("n", "<leader>de", "<cmd>Presence<cr>", {
        desc = "Enable Discord Presence",
        silent = true,
      })
    end,
  },
}
