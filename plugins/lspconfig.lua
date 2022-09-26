local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = { "tsserver" }

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  filetypes = { "json" },
}

lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  filetypes = { "css", "less" },
}

lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  filetypes = { "html" },
}

lspconfig.emmet_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  filetypes = { "html", "typescriptreact", "javascriptreact" },
}

lspconfig.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,

  root_dir = lspconfig.util.root_pattern(
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json"
  ),
}
