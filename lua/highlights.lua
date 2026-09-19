local M = {}

local italic_groups = {
  "Comment",
  "@comment",
  "@comment.documentation",
  "@lsp.type.comment",
  "Function",
  "@function",
  "@function.call",
  "@function.method",
  "@function.method.call",
  "@lsp.type.function",
  "@lsp.type.method",
}

local transparent_groups = {
  "Normal",
  "NormalNC",
  "NormalFloat",
  "FloatBorder",
  "SignColumn",
  "FoldColumn",
  "LineNr",
  "CursorLineNr",
  "EndOfBuffer",
  "NonText",
  "StatusLine",
  "StatusLineNC",
  "TabLine",
  "TabLineFill",
}

local function make_italic(group)
  local ok, current = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
  if not ok then
    current = {}
  end

  current.italic = true
  vim.api.nvim_set_hl(0, group, current)
end

local function make_transparent(group)
  local ok, current = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
  if not ok then
    current = {}
  end

  current.bg = "NONE"
  vim.api.nvim_set_hl(0, group, current)
end

function M.apply()
  for _, group in ipairs(italic_groups) do
    make_italic(group)
  end

  for _, group in ipairs(transparent_groups) do
    make_transparent(group)
  end
end

function M.setup()
  M.apply()

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("user_italic_syntax", { clear = true }),
    callback = M.apply,
  })
end

M.setup()

return M
