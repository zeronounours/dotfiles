local M = {}
local configs = require("nvchad.configs.lspconfig")

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

-- List of lsp servers to be installed
--    key = Mason package to install
--    value = lspconfig entry name
local servers = {
    ["ansible-language-server"] = "ansiblels",
    ["bash-language-server"] = "bashls",
    ["clangd"] = "clangd",
    ["css-lsp"] = "cssls",
    ["docker-compose-language-service"] = "docker_compose_language_service",
    ["dockerfile-language-server"] = "dockerls",
    ["eslint-lsp"] = "eslint",
    ["gitlab-ci-ls"] = "gitlab_ci_ls",
    ["gopls"] = "gopls",
    ["helm-ls"] = "helm_ls",
    ["html-lsp"] = "html",
    ["json-lsp"] = "jsonls",
    ["lua-language-server"] = "lua_ls",
    ["openscad-language-server"] = "openscad_ls",
    ["phpactor"] = "phpactor",
    ["ruby-lsp"] = "ruby_lsp",
    ["ruff"] = "ruff",
    ["rust-analyzer"] = "rust_analyzer",
    ["tailwindcss-language-server"] = "tailwindcss",
    ["terraform-ls"] = "terraformls",
    ["typescript-language-server"] = "tsserver",
    ["texlab"] = "texlab",
}

local mason_pkg = {}
local lspconfig_pkg = {}
for k, v in pairs(servers) do
  table.insert(mason_pkg, k)
  table.insert(lspconfig_pkg, v)
end

-- list of all lsp to install
M.mason= {
  ensure_installed = vim.tbl_deep_extend(
    "force",
    -- Formatter
    {
      "black",
      "gofumpt",
      "prettier",
      "stylua",
      "ts-standard",
    },
    --- LSP
    mason_pkg
  )
}

-- Configure language
M.lspconfig = function()
  for _, lsp in pairs(lspconfig_pkg) do
    lspconfig[lsp].setup {
      on_init = on_init,
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end

return M
