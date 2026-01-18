return {
  ------------------------------------------------------------------
  -- SESSION / PERSISTENCE (FIXED)
  ------------------------------------------------------------------
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize" },

      pre_save = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf) then
            local name = vim.api.nvim_buf_get_name(buf)
            local ft = vim.bo[buf].filetype

            -- Kill unwanted buffers before saving session
            if name == "" or ft == "alpha" or ft == "netrw" then
              vim.bo[buf].bufhidden = "wipe"
              pcall(vim.api.nvim_buf_delete, buf, { force = true })
            end
          end
        end
      end,
    },
  },

  ------------------------------------------------------------------
  -- PROJECT MANAGEMENT (SAFE SESSION LOAD)
  ------------------------------------------------------------------
  {
    "ahmedkhalf/project.nvim",
    opts = {
      detection_methods = { "pattern" },
      patterns = {
        ".git",
        "Makefile",
        "package.json",
        "go.mod",
        "Cargo.toml",
      },
      silent_chdir = false,
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")

      -- Disable netrw completely
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      local group = vim.api.nvim_create_augroup("ProjectSession", { clear = true })

      vim.api.nvim_create_autocmd("DirChanged", {
        group = group,
        callback = function()
          vim.schedule(function()
            -- Kill alpha + empty buffers first
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_valid(buf) then
                local ft = vim.bo[buf].filetype
                local name = vim.api.nvim_buf_get_name(buf)

                if ft == "alpha" or name == "" then
                  vim.bo[buf].modified = false
                  vim.bo[buf].bufhidden = "wipe"
                  pcall(vim.api.nvim_buf_delete, buf, { force = true })
                end
              end
            end

            -- Load session safely
            local ok, persistence = pcall(require, "persistence")
            if ok then
              pcall(persistence.load)
            end

            -- Final cleanup (kills [No Name])
            vim.defer_fn(function()
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_valid(buf) then
                  if vim.api.nvim_buf_get_name(buf) == "" then
                    pcall(vim.api.nvim_buf_delete, buf, { force = true })
                  end
                end
              end
            end, 150)
          end)
        end,
      })
    end,
  },

  ------------------------------------------------------------------
  -- ALPHA DASHBOARD (JAPANESE AESTHETIC)
  ------------------------------------------------------------------
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      ----------------------------------------------------------------
      -- 🌸 JAPANESE AESTHETIC ASCII (MINIMAL / ZEN)
      ----------------------------------------------------------------
      local logo = [[
 ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
 ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ 
▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   
         ░    ░  ░    ░ ░        ░   ░         ░   
                                ░                  
]]

      dashboard.section.header.val = vim.split(logo, "\n")

      ----------------------------------------------------------------
      -- BUTTONS (ALL ICONS FIXED)
      ----------------------------------------------------------------
      dashboard.section.buttons.val = {
        dashboard.button("f", "󰈞  Find File", "<cmd>Telescope find_files<CR>"),
        dashboard.button("n", "  New File", "<cmd>ene | startinsert<CR>"),
        dashboard.button("r", "󰄉  Recent Files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("p", "󰏓  Find Project", "<cmd>Telescope projects<CR>"),
        dashboard.button("g", "󰱼  Find Text", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("s", "󰁯  Restore Session", function()
          -- Kill alpha before restoring
          local buf = vim.api.nvim_get_current_buf()
          if vim.bo[buf].filetype == "alpha" then
            vim.cmd("enew")
            vim.api.nvim_buf_delete(buf, { force = true })
          end
          require("persistence").load()
        end),
        dashboard.button("c", "  Configuration", "<cmd>cd ~/.config/nvim | edit $MYVIMRC<CR>"),
        dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<CR>"),
        dashboard.button("m", "󰆼  Mason", "<cmd>Mason<CR>"),
        dashboard.button("q", "󰗼  Quit", "<cmd>qa<CR>"),
      }

      ----------------------------------------------------------------
      -- FOOTER
      ----------------------------------------------------------------
      local function footer()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime * 100) / 100
        return "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins loaded in " .. ms .. "ms"
      end

      dashboard.section.footer.val = footer()

      ----------------------------------------------------------------
      -- LAYOUT
      ----------------------------------------------------------------
      dashboard.opts.layout = {
        { type = "padding", val = 3 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }

      return dashboard.config
    end,

    config = function(_, dashboard)
      require("alpha").setup(dashboard)

      -- Redraw footer after Lazy loads
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          if vim.bo.filetype == "alpha" then
            vim.cmd("AlphaRedraw")
          end
        end,
      })
    end,
  },
}
