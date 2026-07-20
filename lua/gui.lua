local M = {}

M.font_size = 17
M.font_candidates = {
  "SauceCodePro Nerd Font Mono",
  "SauceCodePro Nerd Font",
}

local function font_exists(font)
  if vim.fn.executable("fc-match") == 0 then
    return font == "SauceCodePro Nerd Font Mono"
  end

  local family_list = vim.fn.systemlist({ "fc-match", "-f", "%{family}", font })[1] or ""
  for family in family_list:gmatch("[^,]+") do
    if vim.trim(family):lower() == font:lower() then
      return true
    end
  end

  return false
end

local function preferred_font()
  for _, font in ipairs(M.font_candidates) do
    if font_exists(font) then
      return font
    end
  end

  return "SauceCodePro Nerd Font Mono"
end

local function apply_font()
  vim.o.guifont = string.format("%s:h%d", preferred_font(), M.font_size)
end

local function apply_neovide()
  if not vim.g.neovide then
    return
  end

  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_refresh_rate_idle = 30
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_hide_mouse_when_typing = true

  vim.g.neovide_padding_top = 6
  vim.g.neovide_padding_bottom = 6
  vim.g.neovide_padding_left = 8
  vim.g.neovide_padding_right = 8

  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_normal_opacity = 1.0

  vim.g.neovide_position_animation_length = 0.16
  vim.g.neovide_scroll_animation_length = 0.24
  vim.g.neovide_scroll_animation_far_lines = 1

  vim.g.neovide_cursor_animation_length = 0.09
  vim.g.neovide_cursor_short_animation_length = 0.045
  vim.g.neovide_cursor_trail_size = 0.9
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_unfocused_outline_width = 0.125

  vim.g.neovide_cursor_vfx_mode = "torpedo"
  vim.g.neovide_cursor_vfx_opacity = 135.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 0.7
  vim.g.neovide_cursor_vfx_particle_density = 5.0
  vim.g.neovide_cursor_vfx_particle_speed = 10.0
  vim.g.neovide_cursor_vfx_particle_phase = 1.5
  vim.g.neovide_cursor_vfx_particle_curl = 0.7
end

function M.setup()
  apply_font()
  apply_neovide()
end

M.setup()

return M
