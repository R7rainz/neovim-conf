vim.o.termguicolors = true
vim.wo.number = true
vim.wo.relativenumber = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.breakindent = true

vim.o.clipboard = "unnamedplus"
vim.o.scrolloff = 20
vim.o.sidescrolloff = 8

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.lsp.inlay_hint.enable(false)

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
})

vim.lsp.handlers["textDocument/semanticTokens/full"] = function() end
vim.lsp.handlers["textDocument/semanticTokens/full/delta"] = function() end
vim.lsp.handlers["textDocument/semanticTokens/range"] = function() end

vim.opt.list = false
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
