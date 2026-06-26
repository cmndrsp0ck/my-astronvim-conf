-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "mbbill/undotree",
    lazy = false,
    keys = {
      { "<leader>tU", "<cmd>UndotreeToggle<cr>", desc = "Undotree Toggle", mode = "n" },
    }
  },
}
