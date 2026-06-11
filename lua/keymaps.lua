local map = vim.keymap.set

local function close_other_buffers()
    local current = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and buf ~= current then
            vim.cmd("bdelete " .. buf)
        end
    end
end

map("n", "<leader><tab>", "<cmd>Neotree toggle left<cr>", { desc = "Toggle NeoTree (left)" })
map("n", "<leader>e", "<cmd>Neotree float<cr>", { desc = "NeoTree (floating)" })

map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

map("n", "<C-x>", "<cmd>bdelete<cr>", { desc = "Close buffer" })
map("n", "<leader>X", "<cmd>bdelete!<cr>", { desc = "Force close buffer" })
map("n", "<leader>bo", close_other_buffers, { desc = "Close other buffers" })

map("n", "<leader>wx", "<cmd>close<cr>", { desc = "Close window" })
map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>qQ", "<cmd>q!<cr>", { desc = "Quit (force)" })
map("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>qA", "<cmd>qa!<cr>", { desc = "Quit all (force)" })

map("n", "<leader>cf", function() require("conform").format() end, { desc = "Format file" })

map("n", "<leader>th", function()
    local Terminal = require("toggleterm.terminal").Terminal
    if not _horizontal_term then
        _horizontal_term = Terminal:new({ direction = "horizontal", hidden = true })
    end
    _horizontal_term:toggle()
end, { desc = "Toggle Terminal (horizontal)" })

map("n", "<leader>tv", function()
    local Terminal = require("toggleterm.terminal").Terminal
    if not _vertical_term then
        _vertical_term = Terminal:new({ direction = "vertical", hidden = true })
    end
    _vertical_term:toggle()
end, { desc = "Toggle Terminal (vertical)" })
