-- overriding default plugin configs!

local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "html",
    "css",
    "javascript",
    "typescript",
    "json",
    "markdown",
    "bash",
    "lua",
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "emmet-ls",
    "json-lsp",
    "eslint-lsp",

    -- shell
    "shfmt",
    "shellcheck",
  },
}

M.telescope = {
  defaults = {
    dynamic_preview_title = true,
    file_ignore_patterns = nil,
  },
  extensions_list = { "themes", "terms", "fzf" },
}

M.cmp = {
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "omni" },
  },
}

return M
