local M = {}

local comment_groups = {
  "Comment",
  "@comment",
  "@comment.documentation",
  "@lsp.type.comment",
}

local function make_italic(group)
  local ok, current = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
  if not ok then
    current = {}
  end

  current.italic = true
  vim.api.nvim_set_hl(0, group, current)
end

function M.apply()
  for _, group in ipairs(comment_groups) do
    make_italic(group)
  end
end

function M.setup()
  M.apply()

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("user_italic_comments", { clear = true }),
    callback = M.apply,
  })
end

M.setup()

return M
