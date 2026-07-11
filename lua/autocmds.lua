require "nvchad.autocmds"

-- Keep indentation consistent across every filetype.
local indentation = vim.api.nvim_create_augroup("four_space_indentation", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = indentation,
  desc = "Use four spaces for indentation in every language",
  callback = function(args)
    vim.bo[args.buf].tabstop = 4
    vim.bo[args.buf].shiftwidth = 4
    vim.bo[args.buf].softtabstop = 4
    vim.bo[args.buf].expandtab = true
  end,
})
