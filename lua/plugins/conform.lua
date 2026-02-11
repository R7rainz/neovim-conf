return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      go = { "goimports", "gofumpt" },
    },
    -- Ensure format on save is enabled for Go
    format_on_save = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
  },
}
