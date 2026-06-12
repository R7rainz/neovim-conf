return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        prisma = { "prisma_format" },
        go = { "goimports", "gofumpt" },
        gomod = { "goimports" },
        c = { "clang_format" },
        cpp = { "clang_format" },
      },
      format_on_save = {
        timeout_ms = 3000,
        lsp_fallback = true,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      local nvlsp = require "nvchad.configs.lspconfig"
      nvlsp.defaults()

      local servers = { "html", "cssls", "jsonls", "yamlls", "prismals",
        "emmet_language_server", "pyright", "rust_analyzer", "bashls",
        "dockerls", "marksman", "clangd" }

      for _, lsp in ipairs(servers) do
        vim.lsp.enable(lsp)
      end

      vim.lsp.config.gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.work", "go.mod", ".git" },
        single_file_support = true,
        settings = {
          gopls = {
            analyses = { unusedparams = true, shadow = true },
            staticcheck = true, gofumpt = true,
            completeUnimported = true, usePlaceholders = true,
            hints = {
              assignVariableTypes = false, compositeLiteralFields = false,
              compositeLiteralTypes = false, constantValues = false,
              functionTypeParameters = false, parameterNames = false,
              rangeVariableTypes = false,
            },
          },
        },
      }
      vim.lsp.enable "gopls"

      require("typescript-tools").setup {
        settings = {
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "none",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = false,
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = false,
            includeInlayFunctionLikeReturnTypeHints = false,
            includeInlayEnumMemberValueHints = false,
          },
        },
      }

      vim.diagnostic.config {
        virtual_text = true, signs = true, underline = true,
        update_in_insert = false, severity_sort = true,
        float = { border = "rounded", source = "always" },
      }

      vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
        config = config or {}
        config.border = "rounded"
        return vim.lsp.handlers.hover(err, result, ctx, config)
      end

      vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
        config = config or {}
        config.border = "rounded"
        return vim.lsp.handlers.signature_help(err, result, ctx, config)
      end
    end,
  },

  -- NvChad blink completion
  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",

        -- web dev
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "jsonc",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",

        -- backend / tools
        "bash",
        "dockerfile",
        "prisma",
        "go",
        "gomod",
        "gowork",
        "gosum",

        -- optional c/c++
        "c",
        "cpp",
      },
    },
  },

  -- auto close brackets/tags
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- better TypeScript support
  {
    "pmizio/typescript-tools.nvim",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {},
  },

  -- Tailwind CSS tools (install tailwindcss-language-server via :Mason to enable)
  -- {
  --   "luckasRanarison/tailwind-tools.nvim",
  --   ft = {
  --     "html",
  --     "css",
  --     "scss",
  --     "javascript",
  --     "javascriptreact",
  --     "typescript",
  --     "typescriptreact",
  --   },
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   opts = {},
  -- },

  -- Terminal toggle
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm" },
    keys = {
      { "<leader>tt", desc = "Terminal (horizontal)" },
      { "<leader>tv", desc = "Terminal (vertical)" },
      { "<leader>tf", desc = "Terminal (float)" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      direction = "float",
      float_opts = {
        border = "rounded",
      },
      shade_terminals = true,
      shading_factor = 2,
    },
  },

  -- Which-key popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 300,
      win = {
        border = "rounded",
      },
      layout = {
        spacing = 3,
      },
    },
  },

  -- Jump/search with s
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- Auto save/restore sessions per project
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~", "~/", "/", "" },
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_create_enabled = true,
      session_lens = {
        load_on_setup = true,
        theme_conf = { border = "rounded" },
        previewer = false,
      },
    },
    keys = {
      { "<leader>ss", "<cmd>SessionSave<cr>", desc = "Save Session" },
      { "<leader>sl", "<cmd>SessionRestore<cr>", desc = "Restore Session" },
      { "<leader>sd", "<cmd>SessionDelete<cr>", desc = "Delete Session" },
      { "<leader>sf", "<cmd>SessionSearch<cr>", desc = "Search Sessions" },
    },
  },


}
