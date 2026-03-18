-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local function open_pi_split(cmd)
  vim.cmd("vsplit")
  vim.cmd("vertical resize 80")
  vim.cmd("terminal " .. cmd)
  vim.cmd("startinsert")
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = buf,
    once = true,
    callback = function()
      vim.api.nvim_buf_delete(buf, { force = true })
    end,
  })
end

local function pi_resume_picker()
  local session_dir = vim.fn.expand("~/.pi/agent/sessions")
  local cwd = vim.fn.getcwd()
  local files = vim.fn.glob(session_dir .. "/**/*.jsonl", false, true)

  local items = {}
  for _, path in ipairs(files) do
    local f = io.open(path, "r")
    if f then
      local first_line = f:read("*l")
      f:close()
      if first_line then
        local ok, data = pcall(vim.fn.json_decode, first_line)
        if ok and data and data.type == "session" and data.cwd == cwd then
          local display = string.format("[%s]", data.timestamp:sub(1, 19):gsub("T", " "))
          table.insert(items, { text = display, path = path })
        end
      end
    end
  end

  table.sort(items, function(a, b) return a.text > b.text end)

  require("snacks").picker.pick({
    title = "pi sessions",
    items = items,
    format = function(item) return { { item.text } } end,
    confirm = function(picker, item)
      picker:close()
      if item then
        open_pi_split("pi --session " .. vim.fn.shellescape(item.path))
      end
    end,
  })
end

return {
  "carderne/pi-nvim",
  config = function() require("pi-nvim").setup()
    vim.keymap.del({"n", "v"}, "<leader>p")
    vim.keymap.set("n", "<leader>apl", function() open_pi_split("pi") end)
    vim.keymap.set("n", "<leader>apc", function() open_pi_split("pi --continue") end)
    vim.keymap.set("n", "<leader>apr", pi_resume_picker)
    vim.keymap.set("n", "<leader>api", ":Pi<CR>")
    vim.keymap.set("n", "<leader>aps", ":PiSend<CR>")
    vim.keymap.set("n", "<leader>apf", ":PiSendFile<CR>")
    vim.keymap.set("v", "<leader>apv", ":PiSendSelection<CR>")
    vim.keymap.set("n", "<leader>apb", ":PiSendBuffer<CR>")
    vim.keymap.set("n", "<leader>app", ":PiPing<CR>")
  end,
}
