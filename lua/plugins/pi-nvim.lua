-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "carderne/pi-nvim",
  config = function() require("pi-nvim").setup()
    vim.keymap.del({"n", "v"}, "<leader>p")
    vim.keymap.set("n", "<leader>api", ":Pi<CR>")
    vim.keymap.set("n", "<leader>aps", ":PiSend<CR>")
    vim.keymap.set("n", "<leader>apf", ":PiSendFile<CR>")
    vim.keymap.set("v", "<leader>apv", ":PiSendSelection<CR>")
    vim.keymap.set("n", "<leader>apb", ":PiSendBuffer<CR>")
    vim.keymap.set("n", "<leader>app", ":PiPing<CR>")
  end,
}
