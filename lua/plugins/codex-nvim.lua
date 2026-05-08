return {
  {
    "johnseth97/codex.nvim",
    lazy = true,
    cmd = { "Codex", "CodexToggle" },
    opts = {
      keymaps = {
        toggle = nil,
        quit = "<C-q>",
      },
      border = "rounded",
      width = 0.8,
      height = 0.8,
      autoinstall = false,
      panel = false,
      use_buffer = false,
    },
    keys = {
      { "<leader>ad", nil, desc = "Codex Agent" },
      {
        "<leader>ado",
        function() require("codex").toggle() end,
        desc = "Toggle Codex",
        mode = { "n", "t" },
      },
    },
  },
}
