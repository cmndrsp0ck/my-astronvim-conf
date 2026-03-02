return {
  {
    "folke/todo-comments.nvim",
    lazy = false,
    requires = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup {} end,
  },
}
