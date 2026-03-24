return {
  --- @module 'cursor-agent'
  {
    "Sarctiann/cursor-agent.nvim",
    lazy = true,
    dependencies = {
      "folke/snacks.nvim",
    },
    --- @type Cursor-Agent.Config
    opts = {
      use_default_mappings = false,
    },
    keys = {
      { "<leader>aa",  nil,                                    desc = "Cursor Agent" },
      { "<leader>aaj", "<cmd>CursorAgent open_root<cr>",       desc = "Toggle Cursor-Agent (Project Root)", mode = "n" },
      { "<leader>aaJ", "<cmd>CursorAgent open_cwd<cr>",        desc = "Toggle Cursor-Agent (Current Dir)",  mode = "n" },
      { "<leader>aal", "<cmd>CursorAgent session_list<cr>",    desc = "Toggle Cursor-Agent (Show Sessions)", mode = "n" },
    },
  }
}
