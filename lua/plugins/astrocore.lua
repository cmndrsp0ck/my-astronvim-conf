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
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
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
        python3_host_progs = "~/.pyenv/versions/neovim/bin/python",
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
        ["<leader>fs"] = { "<cmd>Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<cr>", desc = "Find words in current buffer" },
        ["<leader>fS"] = { "<cmd>Telescope aerial sorting_strategy=descending<cr>", desc = "Find symbols" },
        -- ToggleTerm mapping
        ["<C-\\>"] = { "<cmd>ToggleTerm direction=horizontal size=30<cr>", desc = "Open terminal in horizontal mode" },
        ["<leader>tc"] = { "<cmd>ChatGPT<cr>", desc = "Open ChatGPT prompt" },
        ["<leader>te"] = { "<cmd>ChatGPTEditWithInstructions<cr>", desc = "Open ChatGPTEditWithInstructions" },
        ["<leader>tm"] = { "<cmd>lua require('global-note').toggle_note()<cr>", desc = "Toggle global note" },
        -- navigate buffer tabs with `H` and `L`
        L = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        H = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
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
        ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
      },
      t = {
        -- setting a mapping to false will disable it
        ["<esc>"] = false,
        ["<C-l>"] = false,
      },
      v = {
        ["<leader>te"] = { "<cmd>ChatGPTRun explain_code<cr>", desc = "ChatGPT explain code" },
        ["<leader>ts"] = { "<cmd>ChatGPTRun summarize<cr>", desc = "ChatGPT summarize text" },
      }
    },
  },
}
