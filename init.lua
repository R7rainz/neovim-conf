vim.g.mapleader = " "

vim.opt.cmdheight = 0

if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono Nerd Font:h15"
    vim.opt.linespace = 1
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    vim.g.neovide_cursor_vfx_particle_lifetime = 0.7
    vim.g.neovide_cursor_vfx_particle_density = 40.0
    vim.g.neovide_cursor_vfx_opacity = 100.0
    vim.g.neovide_cursor_vfx_particle_speed = 10.0
    vim.g.neovide_cursor_animation_length = 0.2
    vim.g.neovide_cursor_trail_size = 1.0
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
    vim.g.neovide_cursor_unfocused_outline_width = 0.125
    vim.g.neovide_scroll_animation_length = 0.25
    vim.g.neovide_scroll_animation_far_lines = 1
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_opacity = 0.95
    vim.g.neovide_window_blurred = true
    vim.g.neovide_floating_blur_amount_x = 3.0
    vim.g.neovide_floating_blur_amount_y = 3.0
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 10
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 5
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 5
    vim.g.neovide_no_idle = true
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_padding_top = 12
    vim.g.neovide_padding_bottom = 12
    vim.g.neovide_padding_right = 12
    vim.g.neovide_padding_left = 12
    vim.g.neovide_fullscreen = false
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_input_macos_alt_is_meta = true
    vim.g.neovide_scale_factor = 1.0

    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function() change_scale_factor(1.1) end, { desc = "Increase scale" })
    vim.keymap.set("n", "<C-->", function() change_scale_factor(1 / 1.1) end, { desc = "Decrease scale" })
    vim.keymap.set("n", "<C-0>", function() vim.g.neovide_scale_factor = 1.0 end, { desc = "Reset scale" })
    vim.keymap.set("n", "<F11>", function() vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen end, { desc = "Toggle fullscreen" })
    vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete previous word" })
    vim.keymap.set("i", "<C-H>", "<C-w>", { desc = "Delete previous word" })
    vim.keymap.set({ "n", "v", "i", "c" }, "<D-v>", function() vim.api.nvim_paste(vim.fn.getreg("+"), true, -1) end, { desc = "Paste from clipboard" })
    vim.keymap.set("v", "<D-c>", '"+y', { desc = "Copy to clipboard" })
end

require("options")
require("keymaps")
require("autocmds")
require("bootstrap")
