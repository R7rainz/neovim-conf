vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function() vim.opt_local.formatoptions:remove({ "r", "o" }) end,
    desc = "Disable auto-comment on new line",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go", "gomod", "gowork", "gosum" },
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
    end,
    desc = "Go tab indentation",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end,
    desc = "JS/TS 2-space indentation",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css", "scss", "sass", "less" },
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end,
    desc = "HTML/CSS 2-space indentation",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua" },
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
    end,
    desc = "Lua 4-space indentation",
})
