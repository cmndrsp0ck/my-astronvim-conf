-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "jeantimex/ai-cli.nvim",
    lazy = true,
    config = function()
      require("ai-cli").setup({
        provider = "gemini",
        terminal_cmd = "gemini",
      })
    end,
    keys = {
      { "<leader>ag", nil, desc = "Gemini Agent" },
      { "<leader>agg", "<cmd>AiCli<cr>", desc = "Toggle AI CLI", mode = "n" },
      { "<leader>ago", "<cmd>AiCliOpen<cr>", desc = "Open AI CLI", mode = "n" },
      { "<leader>agc", "<cmd>AiCliClose<cr>", desc = "Close AI CLI", mode = "n" },
      { "<leader>ag>", "<cmd>AiCliWider<cr>", desc = "AI CLI Wider", mode = "n" },
      { "<leader>ag<", "<cmd>AiCliNarrower<cr>", desc = "AI CLI Narrower", mode = "n" },
      { "<C-g>", [[<C-\><C-n><cmd>AiCli<cr>]], desc = "Toggle AI CLI", mode = "t" },
      { "<M-g>", "<cmd>AiCli<cr>", desc = "Toggle AI CLI", mode = "n" },
      { "<M-g>", [[<C-\><C-n><cmd>AiCli<cr>]], desc = "Toggle AI CLI", mode = "t" },
      { "<C-h>", [[<C-\><C-n><C-w>h]], desc = "Go to left pane", mode = "t" },
      { "<C-l>", [[<C-\><C-n><C-w>l]], desc = "Go to right pane", mode = "t" },
    },
  }
}
