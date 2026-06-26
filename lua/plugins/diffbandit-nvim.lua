-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "CoreyKaylor/diffbandit.nvim",
    cmd = {
      "DiffBandit",
      "DiffBanditBuffers",
      "DiffBanditGit",
      "DiffBanditGitCurrent",
      "DiffBanditCommitPanel",
    },
    keys = {
      { "<leader>gdb", "<cmd>DiffBanditGit<cr>", desc = "DiffBandit Git" },
      { "<leader>gdc", "<cmd>DiffBanditGitCurrent<cr>", desc = "DiffBandit current file" },
      { "<leader>gdp", "<cmd>DiffBanditCommitPanel<cr>", desc = "DiffBandit commit panel" },
    },
    init = function()
      local ok, wk = pcall(require, "which-key")
      if ok then
        wk.add({ { "<leader>gd", group = "DiffBandit" } })
      end
    end,
    config = function()
      require("diffbandit").setup()
    end,
  },
}
