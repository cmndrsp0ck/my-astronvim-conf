-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = true, -- sets vim.opt.wrap
        colorcolumn = "80,100",
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = 4,
        expandtab = true,
        scrolloff = 8,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        python3_host_prog = "~/.pyenv/versions/neovim/bin/python",
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map
        ["<leader>U"] = { "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
        -- ["<leader>uP"] = { "<cmd>lua TogglePaste()<cr>", desc = "Toggle Paste" }
        -- Search for word in current buffer
        ["<leader>fs"] = {
          "<cmd>Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<cr>",
          desc = "Find words in current buffer",
        },
        ["<leader>fS"] = { "<cmd>Telescope aerial sorting_strategy=descending<cr>", desc = "Find symbols" },
        -- ToggleTerm mapping
        ["<C-\\>"] = { "<cmd>ToggleTerm direction=horizontal size=30<cr>", desc = "Open terminal in horizontal mode" },
        ["<leader>tC"] = { "<cmd>ChatGPT<cr>", desc = "Open ChatGPT prompt" },
        ["<leader>te"] = { "<cmd>ChatGPTEditWithInstructions<cr>", desc = "Open ChatGPTEditWithInstructions" },
        ["<leader>tca"] = { "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
        ["<leader>tcc"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion Chat" },
        ["<leader>tcC"] = { "<cmd>CodeCompanion /commit<cr>", desc = "CodeCompanion Commit" },
        ["<leader>tce"] = { "<cmd>CodeCompanionChat #{buffer} explain<cr>", desc = "CodeCompanion Explain"},
        ["<leader>tch"] = { "<cmd>CodeCompanionHistory<cr>", desc = "CodeCompanion History" },
        ["<leader>tM"] = {"<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview Toggle"},
        -- ["<leader>N"] = { "<cmd>lua require('global-note').toggle_note()<cr>", desc = "Toggle global note" },
        ["<leader>Gs"] = { "<cmd>lua _G.select_global_note()<cr>", desc = "Select global note" },
        ["<leader>Gn"] = { "<cmd>lua require('global-note').toggle_note()<cr>", desc = "Open global note" },
        ["<leader>Gp"] = { "<cmd>ProjectNote<cr>", desc = "Open project note" },
        ["<leader>Gg"] = { "<cmd>GitBranchNote<cr>", desc = "Open git branch note" },
        ["<leader>gB"] = { "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle git blame" },
        -- gitlab MR keymaps
        ["<leader>gms"] = { "<cmd>lua require('gitlab').choose_merge_request()<cr>", desc = "Choose MR for review" },
        ["<leader>gmr"] = { "<cmd>lua require('gitlab').review()<cr>", desc = "MR review current branch" },
        ["<leader>gmq"] = { "<cmd>lua require('gitlab').close_review()<cr>", desc = "Close MR review" },
        -- ["<leader>gmo"] = { "<cmd>lua require('gitlab').merge_request()<cr>", desc = "Open MR" },
        -- ["<leader>gmC"] = { "<cmd>lua require('gitlab').create_mr()<cr>", desc = "Create MR" },
        -- ["<leader>gmO"] = { "<cmd>lua require('gitlab').create_mr(true)<cr>", desc = "Create MR with current branch" },
        -- ["<leader>gmj"] = { "<cmd>lua require('gitlab').jump_to_mr()<cr>", desc = "Jump to MR" },
        -- ["<leader>gmJ"] = { "<cmd>lua require('gitlab').jump_to_mr(true)<cr>", desc = "Jump to MR with current branch" },
        -- ["<leader>gmp"] = { "<cmd>lua require('gitlab').push_mr()<cr>", desc = "Push to MR" },
        -- ["<leader>gmP"] = { "<cmd>lua require('gitlab').push_mr(true)<cr>", desc = "Push to MR with current branch" },
        -- ["<leader>gmr"] = { "<cmd>lua require('gitlab').refresh_mr()<cr>", desc = "Refresh MR" },
        -- ["<leader>gmR"] = { "<cmd>lua require('gitlab').refresh_mr(true)<cr>", desc = "Refresh MR with current branch" },
        -- ["<leader>gmd"] = { "<cmd>lua require('gitlab').diff_mr()<cr>", desc = "Diff MR" },
        -- ["<leader>gmD"] = { "<cmd>lua require('gitlab').diff_mr(true)<cr>", desc = "Diff MR with current branch" },
        -- ["<leader>gms"] = { "<cmd>lua require('gitlab').status_mr()<cr>", desc = "MR status" },
        -- ["<leader>gmS"] = { "<cmd>lua require('gitlab').status_mr(true)<cr>", desc = "MR status with current branch" },
        -- ["<leader>gml"] = { "<cmd>lua require('gitlab').list_mr()<cr>", desc = "List MR" },
        -- ["<leader>gmL"] = { "<cmd>lua require('gitlab').list_mr(true)<cr>", desc = "List MR with current branch" },
        -- ["<leader>gt"] =
        -- navigate buffer tabs with `H` and `L`
        L = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        H = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },
        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        -- L = {
        --   function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
        --   desc = "Next buffer",
        -- },
        -- H = {
        --   function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        --   desc = "Previous buffer",
        -- },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
      },
      t = {
        -- setting a mapping to false will disable it
        ["<esc>"] = false,
        ["<C-l>"] = false,
      },
      v = {
        ["<leader>te"] = { "<cmd>ChatGPTRun explain_code<cr>", desc = "GPT explain code" },
        ["<leader>ts"] = { "<cmd>ChatGPTRun summarize<cr>", desc = "GPT summarize text" },
        ["<leader>tce"] = { "<cmd>CodeCompanion /explain<cr>", desc = "CodeCompanion Explain"},
        ["<leader>tcf"] = { "<cmd>CodeCompanion /fix<cr>", desc = "CodeCompanion Fix"},
        ["<leader>tct"] = { "<cmd>CodeCompanion /tests<cr>", desc = "CodeCompanion Unit Tests"},
      },
    },
  },
}
