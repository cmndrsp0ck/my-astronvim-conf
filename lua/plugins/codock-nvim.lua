if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    'gitsang/codock.nvim',
    opts = {
      width = 80, -- Width of the vertical split
      fixed_width = false, -- Whether to fix the width (true = locked, false = adjustable)
      codock_cmd = "crush", -- Command to run in the terminal (crush, opencode, claude, gemini-cli, etc.)
      copy_to_clipboard = false, -- Copy to system clipboard
      actions = {},
    },
    cmd = { "Codock", "CodockFilePos", "CodockActions" },
    keys = {
      { "<leader>tCt", "<cmd>Codock<cr>", desc = "Toggle Codock", mode = { "n", "v" } },
      { "<leader>tCp", ":'<,'>CodockFilePos<cr>", desc = "Copy file path and line info", mode = { "n", "v" } },
      { "<leader>tCa", ":'<,'>CodockActions<cr>", desc = "Run Codock actions", mode = { "n", "v" } },
    },
  }
}
