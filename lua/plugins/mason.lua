-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "ansible-language-server",
        "bash-language-server",
        "clangd",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "gitlab-ci-ls",
        "gopls",
        "helm-ls",
        "jinja-lsp",
        "jq-lsp",
        "json-lsp",
        "lemminx",
        "lua-language-server",
        "marksman",
        "python-lsp-server",
        "rust-analyzer",
        "serve-d",
        "sqls",
        "taplo",
        "terraform-ls",
        "v-analyzer",
        "yaml-language-server",

        -- install formatters
        "stylua",
        "prettier",

        -- install debuggers
        "bash-debug-adapter",
        "cpptools",
        "debugpy",
        "go-debug-adapter",

        -- install any other package
        "tree-sitter-cli",
        "shellharden",
        "staticcheck",
        "systemdlint",
      },
    },
  },
}
