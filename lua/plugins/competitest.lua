return {
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("competitest").setup({
        -- Path to your template file
        template_file = {
          cpp = vim.fn.stdpath("config") .. "/templates/cpp.cpp",
        },
        evaluate_template_modifiers = true,
        date_format = "%H:%M", -- Matches your desired ${CURRENT_HOUR}:${CURRENT_MINUTE} format

        -- Compile and Run commands (adjust as needed for your system)
        compile_command = {
          cpp = { exec = "g++", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
        },
        run_command = {
          cpp = { exec = "./$(FNOEXT)" },
        },

        -- Competitive Companion setup
        runner_ui = {
          interface = "popup",
        },
        popup_ui = {
          total_width = 0.8,
          total_height = 0.8,
          layout = {
            { 4, "tc" },
            { 5, { { 1, "so" }, { 1, "si" } } },
            { 5, { { 1, "eo" }, { 1, "se" } } },
          },
        },
        
        -- Default paths for received problems (saves in current directory by default)
        -- You can customize this to save in specific CP folders if you prefer
        received_problems_path = "$(CWD)/$(PROBLEM).$(FEXT)",
        received_contests_directory = "$(CWD)",
        received_contests_problems_path = "$(PROBLEM).$(FEXT)",
      })
    end,
  },
}
