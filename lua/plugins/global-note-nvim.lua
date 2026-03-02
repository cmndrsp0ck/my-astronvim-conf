return {
  {
    "backdround/global-note.nvim",
    event = "VeryLazy",
    config = function()
      local function get_project_name()
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        if project_name == "." or project_name == "" then
          return "default"
        end
        return project_name
      end

      local function get_git_branch()
        local handle = io.popen("git branch --show-current 2>/dev/null")
        if not handle then
          return "main"
        end

        local branch = handle:read("*a")
        handle:close()

        -- Remove newline and sanitize for filename
        branch = branch:gsub("\n", ""):gsub("[^%w%-_]", "_")
        if branch == "" then
          return "main"
        end

        return branch
      end

      local global_note = require("global-note")

      local function select_note()
        local options = {
          {
            name = "ProjectNote - " .. get_project_name(),
            action = function()
              vim.cmd("ProjectNote")
            end
          },
          {
            name = "GitBranchNote - " .. get_git_branch(),
            action = function()
              vim.cmd("GitBranchNote")
            end
          },
          {
            name = "GlobalNote - Default",
            action = function()
              global_note.toggle_note()
            end
          },
          {
            name = "WorkNote",
            action = function()
              vim.cmd("WorkNote")
            end
          },
          {
            name = "TodoNote",
            action = function()
              vim.cmd("TodoNote")
            end
          },
        }

        vim.ui.select(options, {
          prompt = "Select Note:",
          format_item = function(item)
            return item.name
          end,
        }, function(choice)
          if choice then
            choice.action()
          end
        end)
      end

      global_note.setup({
        additional_presets = {
          work = {
            filename = "work.md",
            command_name = "WorkNote",
          },
          todos = {
            filename = "todos.md",
            command_name = "TodoNote",
          },
          project = {
            filename = function()
              return get_project_name() .. ".md"
            end,
            command_name = "ProjectNote",
            title = "Project note",
          },
          git_branch = {
            directory = function()
              return get_project_name()
            end,
            filename = function()
              return get_git_branch() .. ".md"
            end,
            command_name = "GitBranchNote",
            title = function()
              return get_git_branch()
            end,
          },
        },
      })

      -- Make select_note function globally accessible
      _G.select_global_note = select_note
    end,
  },
}
