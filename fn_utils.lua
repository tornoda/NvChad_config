local M = {}

M.trimText = function()
  vim.api.nvim_exec(
    [[
  function! TrimText(text)
  let str = a:text
  let res = substitute(str, '^\s*', '', 'g')
  return res
endfunction
]],
    true
  )
end

return M
