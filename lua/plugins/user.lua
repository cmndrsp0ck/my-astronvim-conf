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

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },
  -- You can disable default plugins as follows:
  -- {
  --   "max397574/better-escape.nvim",
  -- enabled = false,
  -- },
  {
    "max397574/better-escape.nvim",
    config = function() require("better_escape").setup() end,
  },
  {
    "nat-418/boole.nvim",
    config = function()
      require("boole").setup {
        mappings = {
          increment = "<C-a>",
          decrement = "<C-x",
        },
      }
    end,
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
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
      },
    },
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
    build = function() require("gitlab.server").build(true) end, -- Builds the Go binary
    config = function() require("gitlab").setup() end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function() require("copilot").setup {} end,
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
    "AstroNvim/astrocommunity",
  },
  {
    import = "astrocommunity.completion.copilot-lua",
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    requires = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup {} end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function() require("nvim-surround").setup {} end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function()
      require("neo-tree").setup {
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
      }
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
      require("chatgpt").setup {
        openai_params = {
          model = "gpt-4-turbo",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 4095,
          temperature = 0.3,
          top_p = 1,
        },
      }
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "olimorris/codecompanion.nvim",
    config = function()
      require("codecompanion").setup {
        adapters = {
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "OPENAI_API_KEY",
              },
            })
          end,
          gemini2 = function()
            return require("codecompanion.adapters").extend("gemini", {
              name = "gemini2",
              schema = {
                model = {
                  default = "gemini-2.0-pro-exp-02-05",
                },
              },
              env = {
                api_key = "GEMINI_API_KEY",
              },
            })
          end,
        },
        strategies = {
          -- Change the default chat adapter
          -- chat = { adapter = "openai" },
          -- inline = { adapter = "openai" },
          chat = { adapter = "gemini" },
          inline = { adapter = "gemini" },
          -- chat = { adapter = "copilot" },
          -- inline = { adapter = "copilot" },
        },
        display = {
          chat = {
            show_header_separator = false,
            separator = "-",
            start_in_insert_mode = true,
            auto_scroll = false,
          },
        },
        extensions = {
          history = {
            enabled = true,
            opts = {
              -- Keymap to open history from chat buffer (default: gh)
              keymap = "gh",
              -- Keymap to save the current chat manually (when auto_save is disabled)
              save_chat_keymap = "sc",
              -- Save all chats by default (disable to save only manually using 'sc')
              auto_save = true,
              -- Number of days after which chats are automatically deleted (0 to disable)
              expiration_days = 0,
              -- Picker interface (auto resolved to a valid picker)
              picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default")
              ---Optional filter function to control which chats are shown when browsing
              chat_filter = nil, -- function(chat_data) return boolean end
              -- Customize picker keymaps (optional)
              picker_keymaps = {
                rename = { n = "r", i = "<M-r>" },
                delete = { n = "d", i = "<M-d>" },
                duplicate = { n = "<C-y>", i = "<C-y>" },
              },
              ---Automatically generate titles for new chats
              auto_generate_title = true,
              title_generation_opts = {
                ---Adapter for generating titles (defaults to current chat adapter)
                adapter = nil, -- "copilot"
                ---Model for generating titles (defaults to current chat model)
                model = nil, -- "gpt-4o"
                ---Number of user prompts after which to refresh the title (0 to disable)
                refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
                ---Maximum number of times to refresh the title (default: 3)
                max_refreshes = 3,
                format_title = function(original_title)
                  -- this can be a custom function that applies some custom
                  -- formatting to the title.
                  return original_title
                end
              },
              ---On exiting and entering neovim, loads the last chat on opening chat
              continue_last_chat = false,
              ---When chat is cleared with `gx` delete the chat from history
              delete_on_clearing_chat = false,
              ---Directory path to save the chats
              dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
              ---Enable detailed logging for history extension
              enable_logging = false,

              -- Summary system
              summary = {
                -- Keymap to generate summary for current chat (default: "gcs")
                create_summary_keymap = "gcs",
                -- Keymap to browse summaries (default: "gbs")
                browse_summaries_keymap = "gbs",

                generation_opts = {
                  adapter = nil, -- defaults to current chat adapter
                  model = nil, -- defaults to current chat model
                  context_size = 90000, -- max tokens that the model supports
                  include_references = true, -- include slash command content
                  include_tool_outputs = true, -- include tool execution results
                  system_prompt = nil, -- custom system prompt (string or function)
                  format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
                },
              },

              -- Memory system (requires VectorCode CLI)
              memory = {
                -- Automatically index summaries when they are generated
                auto_create_memories_on_summary_generation = true,
                -- Path to the VectorCode executable
                vectorcode_exe = "vectorcode",
                -- Tool configuration
                tool_opts = {
                  -- Default number of memories to retrieve
                  default_num = 10
                },
                -- Enable notifications for indexing progress
                notify = true,
                -- Index all existing memories on startup
                -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
                index_on_startup = false,
              },
            }
          }
        }
      }
    end,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
      { "nvim-lua/plenary.nvim" },
      { "ravitemer/codecompanion-history.nvim" },
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
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
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
    config = function() require("global-note").setup() end,
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
      require("glow").setup() {
        -- glow_path = "",                -- will be filled automatically with your glow bin in $PATH, if any
        -- install_path = "~/.local/bin", -- default path for installing glow binary
        border = "shadow", -- floating window border config
        -- style = "dark|light", -- filled automatically with your current editor background, you can override using glow json style
        -- pager = false,
        width = 80,
        height = 150,
        width_ratio = 0.8, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
        height_ratio = 0.8,
      }
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
