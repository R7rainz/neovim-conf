return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        opts = {
            styles = { transparency = true, italic = true },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "typescript", "tsx", "javascript", "jsdoc",
                "html", "css", "scss",
                "go", "gomod", "gowork", "gosum",
                "lua",
                "json", "yaml", "markdown", "markdown_inline",
                "bash", "vim", "vimdoc", "query", "regex",
            },
            highlight = { enable = true },
            indent = { enable = true },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        opts = {
            enable = true,
            max_lines = 0,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = "outer",
            mode = "cursor",
            separator = nil,
            zindex = 20,
        },
    },

    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        opts = {
            ensure_installed = {
                "stylua",
                "prettierd",
                "goimports",
                "gofumpt",
                "golines",
                "gomodifytags",
                "impl",
            },
        },
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        opts = {
            ensure_installed = {
                "vtsls",
                "gopls",
                "lua_ls",
                "tailwindcss",
                "html",
                "cssls",
                "emmet_ls",
                "eslint",
            },
            automatic_installation = true,
        },
    },

    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        config = function()
            local lspconfig = require("lspconfig")

            lspconfig.vtsls.setup({})

            lspconfig.gopls.setup({
                settings = {
                    gopls = {
                        gofumpt = true,
                        codelenses = {
                            gc_details = false,
                            generate = true,
                            regenerate_cgo = true,
                            run_govulncheck = true,
                            test = true,
                            tidy = true,
                            upgrade_dependency = true,
                            vendor = true,
                        },
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                        analyses = {
                            fieldalignment = true,
                            nilness = true,
                            unusedparams = true,
                            unusedwrite = true,
                            useany = true,
                        },
                        usePlaceholders = true,
                        completeUnimported = true,
                        staticcheck = true,
                        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                        semanticTokens = false,
                    },
                },
            })

            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            lspconfig.tailwindcss.setup({
                filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
                settings = {
                    tailwindCSS = {
                        experimental = {
                            classRegex = {
                                'tw`([^`]*)',
                                'tw="([^"]*)',
                                'tw={"([^"}]*)',
                                'tw\\.\\w+`([^`]*)',
                                'tw\\(.*?\\)`([^`]*)',
                            },
                        },
                    },
                },
            })

            lspconfig.html.setup({ filetypes = { "html", "htmldjango" } })

            lspconfig.cssls.setup({
                settings = {
                    css = { validate = true, lint = { unknownAtRules = "ignore" } },
                    scss = { validate = true, lint = { unknownAtRules = "ignore" } },
                    less = { validate = true, lint = { unknownAtRules = "ignore" } },
                },
            })

            lspconfig.emmet_ls.setup({
                filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
            })

            lspconfig.eslint.setup({
                settings = { workingDirectories = { mode = "auto" } },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
                    end
                    map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
                    map("n", "K", vim.lsp.buf.hover, "Hover")
                    map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
                    map("n", "gr", vim.lsp.buf.references, "References")
                    map("n", "gl", vim.diagnostic.open_float, "Line Diagnostic")
                    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
                    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
                    map("n", "[d", function() vim.diagnostic.goto_next() end, "Next Diagnostic")
                    map("n", "]d", function() vim.diagnostic.goto_prev() end, "Prev Diagnostic")
                end,
            })
        end,
    },

    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        dependencies = { "saghen/blink.lib" },
        opts = {
            keymap = {
                preset = "default",
                ["<C-y>"] = { "select_and_accept" },
                ["<C-e>"] = { "hide", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-d>"] = { "scroll_documentation_down" },
                ["<C-u>"] = { "scroll_documentation_up" },
            },
            sources = {
                default = { "lsp", "path", "buffer" },
                providers = {
                    snippets = {
                        enabled = false,
                        opts = {
                            friendly_snippets = false,
                            global_snippets = {},
                            search_paths = {},
                        },
                    },
                },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "normal",
            },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
            },
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                cond = function() return vim.fn.executable("cmake") == 1 end,
            },
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<leader>ff", function() require("telescope.builtin").find_files({}) end, desc = "Find Files" },
            { "<leader>fw", function() require("telescope.builtin").live_grep({}) end, desc = "Find Words" },
            { "<leader>fb", function() require("telescope.builtin").buffers({}) end, desc = "Find Buffers" },
            { "<leader>fh", function() require("telescope.builtin").help_tags({}) end, desc = "Help Tags" },
        },
        opts = {
            defaults = {
                prompt_prefix = "   ",
                selection_caret = " ",
                entry_prefix = "  ",
                path_display = { "truncate" },
                layout_strategy = "flex",
                layout_config = {
                    horizontal = { prompt_position = "top", preview_width = 0.55 },
                    vertical = { mirror = false },
                    width = 0.9,
                    height = 0.8,
                    preview_cutoff = 120,
                },
                sorting_strategy = "ascending",
                winblend = 10,
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
            },
        },
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {
            color_icons = true,
            default = true,
            strict = true,
            override_by_filename = {
                ["docker-compose.yml"] = { icon = "󰡨", color = "#0db7ed", name = "DockerCompose" },
                ["Dockerfile"] = { icon = "󰡨", color = "#0db7ed", name = "Dockerfile" },
                [".dockerignore"] = { icon = "󰡨", color = "#0db7ed", name = "DockerIgnore" },
            },
            override_by_extension = {
                ["log"] = { icon = "󰌱", color = "#81e043", name = "Log" },
            },
        },
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        branch = "v3.x",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
        init = function() vim.g.neo_tree_remove_legacy_commands = 1 end,
        keys = {
            { "<leader>e", "<cmd>Neotree float toggle<cr>", desc = "NeoTree (float)" },
            { "<leader><tab>", "<cmd>Neotree toggle<cr>", desc = "NeoTree (toggle)" },
            { "<leader>o", "<cmd>Neotree focus<cr>", desc = "NeoTree (focus)" },
        },
        opts = {
            open_on_setup = false,
            open_on_setup_file = false,
            open_on_tab = false,
            close_if_last_window = true,
            popup_border_style = "rounded",
            sort_case_insensitive = true,
            enable_git_status = true,
            enable_diagnostics = true,
            default_component_configs = {
                container = { enable_character_fade = false },
                indent = { indent_size = 2, padding = 0, with_markers = false, with_expanders = true, expander_collapsed = "›", expander_expanded = "⌄", expander_highlight = "NeoTreeExpander" },
                icon = { folder_closed = "󰉋", folder_open = "󰝰", folder_empty = "󰉖", folder_empty_open = "󰉖", default = "󰈔", highlight = "NeoTreeFileIcon" },
                modified = { symbol = "●", highlight = "NeoTreeModified" },
                name = { trailing_slash = false, use_git_status_colors = true, highlight = "NeoTreeFileName" },
                git_status = {
                    symbols = { added = "+", modified = "~", deleted = "-", renamed = ">", untracked = "?", ignored = "", unstaged = "!", staged = "*", conflict = "!" },
                },
            },
            window = {
                position = "left",
                width = 34,
                mappings = {
                    ["<cr>"] = "open", ["l"] = "open", ["h"] = "close_node", ["<esc>"] = "cancel",
                    ["P"] = { "toggle_preview", config = { use_float = true } },
                    ["s"] = "open_split", ["v"] = "open_vsplit", ["t"] = "open_tabnew",
                    ["a"] = "add", ["A"] = "add_directory", ["d"] = "delete", ["r"] = "rename",
                    ["y"] = "copy_to_clipboard", ["x"] = "cut_to_clipboard", ["p"] = "paste_from_clipboard",
                    ["R"] = "refresh", ["q"] = "close_window", ["?"] = "show_help",
                },
            },
            filesystem = {
                follow_current_file = { enabled = true, leave_dirs_open = false },
                group_empty_dirs = true,
                hijack_netrw_behavior = "open_default",
                use_libuv_file_watcher = true,
                filtered_items = { visible = false, hide_dotfiles = false, hide_gitignored = false },
                window = { mappings = { ["<bs>"] = "navigate_up", ["."] = "set_root", ["H"] = "toggle_hidden", ["/"] = "fuzzy_finder", ["D"] = "fuzzy_finder_directory" } },
            },
            buffers = { follow_current_file = { enabled = true }, group_empty_dirs = true },
            git_status = { window = { position = "float" } },
        },
    },

    {
        "stevearc/conform.nvim",
        event = "VeryLazy",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "goimports", "gofumpt" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
                css = { "prettierd" },
                html = { "prettierd" },
                json = { "prettierd" },
                yaml = { "prettierd" },
                markdown = { "prettierd" },
            },
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },

    {
        "ray-x/go.nvim",
        dependencies = { "ray-x/guihua.lua", "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
        opts = {
            disable_defaults = true,
            go = "go",
            goimports = "gopls",
            fillstruct = "gopls",
            gofmt = "golines",
            max_line_len = 120,
            tag_transform = false,
            test_dir = "",
            comment_placeholder = "   ",
            lsp_cfg = false,
            lsp_gofumpt = true,
            lsp_on_attach = false,
        },
        config = function(_, opts)
            require("go").setup(opts)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "go",
                callback = function()
                    local map = function(lhs, rhs, desc)
                        vim.keymap.set("n", lhs, rhs, { buffer = true, desc = desc })
                    end
                    map("<leader>gf", "<cmd>GoFillStruct<cr>", "Go Fill Struct")
                    map("<leader>gi", "<cmd>GoIfErr<cr>", "Go If Err")
                    map("<leader>gt", "<cmd>GoTest<cr>", "Go Test")
                    map("<leader>gT", "<cmd>GoTestFunc<cr>", "Go Test Function")
                    map("<leader>gr", "<cmd>GoRun<cr>", "Go Run")
                    map("<leader>gb", "<cmd>GoBuild<cr>", "Go Build")
                    map("<leader>gd", "<cmd>GoDoc<cr>", "Go Doc")
                    map("<leader>ga", "<cmd>GoAlt<cr>", "Go Alternate")
                    map("<leader>gc", "<cmd>GoCoverage<cr>", "Go Coverage")
                end,
            })
        end,
    },

    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = {
            filetypes = { "*", "!lazy" },
            buftype = { "*", "!prompt", "!nofile" },
            user_default_options = {
                RGB = true,
                RRGGBB = true,
                names = false,
                RRGGBBAA = true,
                AARRGGBB = false,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true,
                mode = "background",
                tailwind = true,
                sass = { enable = true, parsers = { "css" } },
                virtualtext = "■",
                always_update = false,
            },
        },
    },

    {
        "vuki656/package-info.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        event = { "BufRead package.json" },
        opts = {},
    },

    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {
            dir = vim.fn.stdpath("state") .. "/sessions/",
            options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" },
        },
    },

    {
        "akinsho/toggleterm.nvim",
        cmd = "ToggleTerm",
        opts = {
            size = 20,
            open_mapping = [[<c-`>]],
            hide_numbers = true,
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = { border = "curved", winblend = 3 },
        },
    },
}
