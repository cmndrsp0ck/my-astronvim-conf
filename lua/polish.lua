-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

-- set  custom augroups
local ws_clipper = vim.api.nvim_create_augroup("ws_clipper", { clear = true })
-- set custom autocommands
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "Remove trailing white space",
  group = ws_clipper,
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

local function yaml_ft(path, bufnr)
  -- get content of buffer as string
  local content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  if type(content) == "table" then content = table.concat(content, "\n") end

  -- check if file is in roles, tasks, or handlers folder
  local path_regex = vim.regex "(tasks\\|roles\\|handlers)/"
  if path_regex and path_regex:match_str(path) then
    return "yaml.ansible"
  end
  -- check for known ansible playbook text and if found, return yaml.ansible
  local regex = vim.regex "hosts:\\|tasks:"
  if regex and regex:match_str(content) then
    return "yaml.ansible"
  end

  -- return yaml if nothing else
  return "yaml"
end

vim.filetype.add {
  extension = {
    yml = yaml_ft,
    yaml = yaml_ft,
    xsh = "python",
  },
  filename = {
    ["inventory"] = "ini",
    [".dockerignore"] = "gitignore",
  },
}
