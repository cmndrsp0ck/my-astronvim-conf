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

      -- Returns the full path to the current project's note file
      local function get_project_note_path()
        local dir = vim.fn.stdpath("data") .. "/global-note"
        return dir .. "/" .. get_project_name() .. ".md"
      end

      -- Appends a list of lines to the project note file (or its buffer if loaded)
      local function append_to_project_note(lines_to_append)
        local filepath = get_project_note_path()
        local bufnr = vim.fn.bufnr(filepath)
        if bufnr ~= -1 and vim.fn.bufloaded(bufnr) == 1 then
          -- Buffer is open: append in memory then save
          local line_count = vim.api.nvim_buf_line_count(bufnr)
          vim.api.nvim_buf_set_lines(bufnr, line_count, line_count, false, lines_to_append)
          vim.api.nvim_buf_call(bufnr, function()
            vim.cmd("silent! write")
          end)
        else
          -- Buffer not open: append directly to file
          vim.fn.writefile(lines_to_append, filepath, "a")
        end
        vim.notify("Appended to project note: " .. get_project_name(), vim.log.levels.INFO)
      end

      -- Sends the visually selected text to the project note
      local function send_visual_to_project_note()
        local rel_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
        local ft = vim.bo.filetype

        local start_pos = vim.fn.getpos("v")
        local end_pos   = vim.fn.getpos(".")
        local start_row, start_col = start_pos[2], start_pos[3]
        local end_row,   end_col   = end_pos[2],   end_pos[3]

        -- Normalise order
        if start_row > end_row or (start_row == end_row and start_col > end_col) then
          start_row, end_row = end_row, start_row
          start_col, end_col = end_col, start_col
        end

        local selected = vim.api.nvim_buf_get_text(
          0,
          start_row - 1, start_col - 1,
          end_row   - 1, end_col,
          {}
        )

        -- Exit visual mode so the marks '</'> are set before we act
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false
        )

        local annotation = string.format("- [%s:%d]", rel_path, start_row)
        local lines_to_append

        if #selected == 1 then
          lines_to_append = { annotation .. " " .. selected[1], "" }
        else
          lines_to_append = { annotation, "", "```" .. ft }
          for _, line in ipairs(selected) do
            table.insert(lines_to_append, line)
          end
          table.insert(lines_to_append, "```")
          table.insert(lines_to_append, "")
        end

        append_to_project_note(lines_to_append)
      end

      -- Sends the current line to the project note
      local function send_line_to_project_note()
        local rel_path  = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
        local line_num  = vim.fn.line(".")
        local line_text = vim.api.nvim_get_current_line()
        local annotation = string.format("- [%s:%d] %s", rel_path, line_num, line_text)
        append_to_project_note({ annotation, "" })
      end

      -- Expose quick-add functions globally
      _G.send_visual_to_project_note = send_visual_to_project_note
      _G.send_line_to_project_note   = send_line_to_project_note
    end,
    keys = {
      { "<leader>G",  nil,                                                        desc = "GlobalNote" },
      { "<leader>Gs", "<cmd>lua _G.select_global_note()<cr>",                     desc = "Select global note",        mode = "n" },
      { "<leader>Gn", function() require("global-note").toggle_note() end,        desc = "Open global note",          mode = "n" },
      { "<leader>Gp", "<cmd>ProjectNote<cr>",                                     desc = "Open project note",         mode = "n" },
      { "<leader>Gg", "<cmd>GitBranchNote<cr>",                                   desc = "Open git branch note",      mode = "n" },
      { "<leader>Gv", "<cmd>lua _G.send_visual_to_project_note()<cr>",            desc = "Send selection to project note", mode = "v" },
      { "<leader>Gy", "<cmd>lua _G.send_line_to_project_note()<cr>",              desc = "Send line to project note", mode = "n" },
    },
  },
}
