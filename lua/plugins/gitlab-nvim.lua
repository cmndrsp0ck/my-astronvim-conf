return {
  {
    "harrisoncramer/gitlab.nvim",
    lazy = true,
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
    keys = {
      { "<leader>gm",  nil,                                                                             desc = "GitLab MR" },
      { "<leader>gms", "<cmd>lua require('gitlab').choose_merge_request()<cr>",                         desc = "Choose MR for review",              mode = "n" },
      { "<leader>gmr", "<cmd>lua require('gitlab').review()<cr>",                                       desc = "MR review current branch",          mode = "n" },
      { "<leader>gmq", "<cmd>lua require('gitlab').close_review()<cr>",                                 desc = "Close MR review",                   mode = "n" },
      -- { "<leader>gmo", "<cmd>lua require('gitlab').merge_request()<cr>",                             desc = "Open MR",                           mode = "n" },
      -- { "<leader>gmC", "<cmd>lua require('gitlab').create_mr()<cr>",                                 desc = "Create MR",                         mode = "n" },
      -- { "<leader>gmO", "<cmd>lua require('gitlab').create_mr(true)<cr>",                             desc = "Create MR with current branch",     mode = "n" },
      -- { "<leader>gmj", "<cmd>lua require('gitlab').jump_to_mr()<cr>",                                desc = "Jump to MR",                        mode = "n" },
      -- { "<leader>gmJ", "<cmd>lua require('gitlab').jump_to_mr(true)<cr>",                            desc = "Jump to MR with current branch",    mode = "n" },
      -- { "<leader>gmp", "<cmd>lua require('gitlab').push_mr()<cr>",                                   desc = "Push to MR",                        mode = "n" },
      -- { "<leader>gmP", "<cmd>lua require('gitlab').push_mr(true)<cr>",                               desc = "Push to MR with current branch",    mode = "n" },
      -- { "<leader>gmrr", "<cmd>lua require('gitlab').refresh_mr()<cr>",                               desc = "Refresh MR",                        mode = "n" },
      -- { "<leader>gmR", "<cmd>lua require('gitlab').refresh_mr(true)<cr>",                            desc = "Refresh MR with current branch",    mode = "n" },
      -- { "<leader>gmd", "<cmd>lua require('gitlab').diff_mr()<cr>",                                   desc = "Diff MR",                           mode = "n" },
      -- { "<leader>gmD", "<cmd>lua require('gitlab').diff_mr(true)<cr>",                               desc = "Diff MR with current branch",       mode = "n" },
      -- { "<leader>gmss", "<cmd>lua require('gitlab').status_mr()<cr>",                                desc = "MR status",                         mode = "n" },
      -- { "<leader>gmS", "<cmd>lua require('gitlab').status_mr(true)<cr>",                             desc = "MR status with current branch",     mode = "n" },
      -- { "<leader>gml", "<cmd>lua require('gitlab').list_mr()<cr>",                                   desc = "List MR",                           mode = "n" },
      -- { "<leader>gmL", "<cmd>lua require('gitlab').list_mr(true)<cr>",                               desc = "List MR with current branch",       mode = "n" },
    },
  },
}
