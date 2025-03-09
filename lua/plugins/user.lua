-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },
  -- You can disable default plugins as follows:
  {
    "max397574/better-escape.nvim",
    enabled = false,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "sindrets/diffview.nvim",
  },
  {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
      "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
    },
    enabled = true,
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    commit = "aa5d3c1",
    config = function()
      require("gitlab").setup()
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
    opts = {
      -- suggestion = {
      --   keymap = {
      --     accept = "<C-l>",
      --     accept_word = false,
      --     accept_line = false,
      --     next = "<C-.>",
      --     prev = "<C-,>",
      --     dismiss = "<C/>",
      --   },
      -- },
    },
  },
  {
    "AstroNvim/astrocommunity"
  },
  {
    import = "astrocommunity.completion.copilot-lua",
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    requires = "nvim-lua/plenary.nvim",
    config = function()
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function()
      require("neo-tree").setup({
        filesystem = {
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          filtered_items = {
            visible = true,
            show_hidden_count = true,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              -- '.git',
              -- '.DS_Store',
              -- 'thumbs.db',
            },
            never_show = {},
          },
        },
      })
    end,
  },
  {
    "Wansmer/treesj",
    keys = {
      {
        "<leader>m",
        "<CMD>TSJToggle<CR>",
        desc = "Toggle Treesitter Join",
      },
    },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = { use_default_keymaps = false },
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        openai_params = {
          model = 'gpt-4-turbo',
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 4095,
          temperature = 0.3,
          top_p = 1,
        }
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
      { "nvim-lua/plenary.nvim" },
      { "ravitemer/mcphub.nvim" },
      -- Test with blink.cmp
      -- {
      --   "saghen/blink.cmp",
      --   lazy = false,
      --   version = "*",
      --   opts = {
      --     keymap = {
      --       preset = "enter",
      --       ["<S-Tab>"] = { "select_prev", "fallback" },
      --       ["<Tab>"] = { "select_next", "fallback" },
      --     },
      --     sources = {
      --       default = { "lsp", "path", "buffer", "codecompanion" },
      --       cmdline = {}, -- Disable sources for command-line mode
      --     },
      --   },
      -- },
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "OPENAI_API_KEY",
              },
            })
          end,
        },
        strategies = {
          -- Change the default chat adapter
          chat = {
            adapter = "openai",
            tools = {
              ["mcp"] = {
                callback = require("mcphub.extensions.codecompanion"),
                description = "Call tools and resources from the MCP Servers",
                opts = {
                  requires_approval = true
                }
              }
            }

          },
          inline = { adapter = "openai" },
          -- chat = { adapter = "gemini" },
          -- inline = { adapter = "gemini" },
          -- chat = { adapter = "copilot" },
          -- inline = { adapter = "copilot" },
        },
      })
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- Required for Job and HTTP requests
    },
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    config = function()
      require("mcphub").setup({
        -- Required options
        port = 3000,  -- Port for MCP Hub server
        config = vim.fn.expand("~/mcpservers.json"),  -- Absolute path to config file

        -- Optional options
        on_ready = function(hub)
          -- Called when hub is ready
        end,
        on_error = function(err)
          -- Called on errors
        end,
        shutdown_delay = 0, -- Wait 0ms before shutting down server after last client exits
        log = {
          level = vim.log.levels.WARN,
          to_file = false,
          file_path = nil,
          prefix = "MCPHub"
        },
      })
    end
  },
  -- {
  --     "kiddos/gemini.nvim",
  --     build = { 'pip install -r requirements.txt', ':UpdateRemotePlugins' },
  --     event = "VeryLazy",
  --     config = function()
  --         require("gemini").setup()
  --     end
  -- },
  {
    "backdround/global-note.nvim",
    event = "VeryLazy",
    config = function()
      require("global-note").setup()
    end,
  },
  {
    "michaelb/sniprun",
    run = "bash ./install.sh",
    lazy = false,
  },
  {
    "ellisonleao/glow.nvim",
    -- config = true,
    cmd = "Glow",
    config = function()
      require("glow").setup({
        -- glow_path = "",                -- will be filled automatically with your glow bin in $PATH, if any
        -- install_path = "~/.local/bin", -- default path for installing glow binary
        border = "shadow", -- floating window border config
        -- style = "dark|light", -- filled automatically with your current editor background, you can override using glow json style
        -- pager = false,
        width = 80,
        height = 150,
        width_ratio = 0.8, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
        height_ratio = 0.8,
      })
    end,
  },
  {
    "mbbill/undotree",
    lazy = false,
  },
  -- Setting colorschemes
  { "folke/tokyonight.nvim" },
  { "lunarvim/darkplus.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "tanvirtin/monokai.nvim" },
  { "jacoborus/tender.vim" },
}
