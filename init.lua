-- example file i.e lua/custom/init.lua
-- load your options globals, autocmds here or anything .__.
-- you can even override default options here (core/options.lua)
local autocmd = vim.api.nvim_create_autocmd

vim.g.mapleader = ";"
vim.opt.signcolumn = "number"
vim.opt.scrolloff = 2

vim.keymap.set("n", "<leader>i", "<cmd> set ignorecase!<CR>")
vim.keymap.set("n", "<leader>1", "1gt")
vim.keymap.set("n", "<leader>2", "2gt")
vim.keymap.set("n", "<leader>3", "3gt")
vim.keymap.set("n", "<leader>4", "4gt")
vim.keymap.set("n", "<leader>5", "5gt")
vim.keymap.set("n", "<leader>6", "6gt")

vim.api.nvim_create_augroup("_my_auto", { clear = true })
autocmd("Filetype", {
  pattern = "typescript,typescriptreact,javascript,javascriptreact,yml,json,css,scss,sass,less,lua",
  callback = function()
    vim.opt_local.foldmethod = "indent"
  end,
  group = "_my_auto",
})
