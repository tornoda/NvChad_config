-- n, v, i, t = mode names

local M = {}

M.general = {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "論 beginning of line" },
    ["<C-e>"] = { "<End>", "壟 end of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "  move left" },
    ["<C-l>"] = { "<Right>", " move right" },
    ["<C-j>"] = { "<Down>", " move down" },
    ["<C-k>"] = { "<Up>", " move up" },
  },

  n = {
    ["<leader>q"] = { "<cmd>:q<CR>", "  exit buffer" },
    ["<leader>wj"] = { "<cmd>:sp<CR><c-j>", " new buffer and move to it" },
    ["<leader>wl"] = { "<cmd>:vsp<CR><c-l>", " new buffer and move to it" },
    ["<leader>."] = { ":<Up><CR>", "repeat cmd last time" },
    ["<space>"] = { "viw", "visual select a word" },
    ["<M-k>"] = { "<C-b>", "back forward" },

    -- preview content in quickfix
    ["<leader>p"] = {
      function()
        if vim.bo.buftype == "quickfix" then
          vim.api.nvim_command 'execute "normal! <cr>"'
        end
      end,
      "todo  preview quicklist",
    },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "   toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "   toggle relative number" },

    -- update nvchad
    -- ["<leader>uu"] = "",

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
  },
}

M.tabufline = {

  n = {
    -- new buffer
    -- disable default
    ["<S-b>"] = {
      function()
        vim.api.nvim_command "execute 'normal! B'"
      end,
      "just B !",
    },

    -- cycle through buffers
    ["<TAB>"] = {
      function()
        require("core.utils").tabuflineNext()
      end,
      "  goto next buffer",
    },

    ["<S-Tab>"] = {
      function()
        require("core.utils").tabuflinePrev()
      end,
      "  goto prev buffer",
    },

    -- close buffer + hide terminal buffer
    ["<leader>x"] = {
      function()
        require("core.utils").close_buffer()
      end,
      "   close buffer",
    },

    -- pick buffers via numbers
    ["<Bslash>"] = { "<cmd> TbufPick <CR>", "  Pick buffer" },
  },
}

M.comment = {

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle_current_linewise()
      end,

      "蘒  toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
      "蘒  toggle comment",
    },
  },
}

M.lspconfig = {
  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        -- vim.lsp.buf.declaration()
        vim.api.nvim_command "execute 'Telescope lsp_type_definitions'"
      end,
      "   lsp declaration",
    },

    ["gd"] = {
      function()
        -- vim.lsp.buf.definition()
        vim.api.nvim_command "execute 'Telescope lsp_definitions'"
      end,
      "   lsp definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "   lsp hover",
    },

    ["gi"] = {
      function()
        -- vim.lsp.buf.implementation()
        vim.api.nvim_command "execute 'Telescope lsp_implementation'"
      end,
      "   lsp implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "   lsp signature_help",
    },

    ["<leader>D"] = {
      function()
        -- vim.lsp.buf.type_definition()
        vim.api.nvim_command "execute 'Telescope lsp_type_definitions'"
      end,
      "   lsp definition type",
    },

    ["<leader>ra"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "   lsp rename",
    },

    ["<leader>a"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "   lsp code_action",
    },

    ["gr"] = {
      function()
        -- vim.lsp.buf.references()
        vim.api.nvim_command "execute 'Telescope lsp_references'"
      end,
      "   lsp references",
    },

    ["<leader>s"] = {
      function()
        -- vim.lsp.buf.references()
        vim.api.nvim_command "execute 'Telescope lsp_document_symbols'"
      end,
      "   lsp references",
    },

    ["<leader>S"] = {
      function()
        -- vim.lsp.buf.references()
        vim.api.nvim_command "execute 'Telescope lsp_workspace_symbols'"
      end,
      "   lsp references",
    },

    ["<leader>f"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "   floating diagnostic",
    },

    ["[e"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "   goto prev",
    },

    ["]e"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "   goto_next",
    },

    -- ["<leader>q"] = {
    --   function()
    --     vim.diagnostic.setloclist()
    --   end,
    --   "   diagnostic setloclist",
    -- },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.formatting()
      end,
      "   lsp formatting",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "   add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "   remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "   list workspace folders",
    },
  },
}

M.nvimtree = {

  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },

    -- focus
    ["<leader>l"] = { "<cmd> NvimTreeFocus <CR>", "   focus nvimtree" },
  },
}

M.telescope = {
  n = {
    -- find
    -- ["<leader>ff"] = {
    --   function() end,
    --   "  find files",
    -- },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },
    ["<leader>b"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "  help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "   find oldfiles" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "   show keys" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "   git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "  git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "   pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "   nvchad themes" },
  },
}

M.nvterm = {
  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "   toggle floating term",
    },

    ["<A-t>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "   toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "   toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "   toggle floating term",
    },

    ["<C-\\>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "   toggle horizontal term",
    },

    ["<C-/>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "   toggle vertical term",
    },

    -- new

    ["<leader>h"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "   new horizontal term",
    },

    ["<leader>v"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "   new vertical term",
    },
  },
}

M.gitsigns = {
  n = {
    -- gitsigns
    ["[c"] = {
      function()
        require("gitsigns").prev_hunk()
      end,
      "Jump to preview hunk",
    },
    ["]c"] = {
      function()
        require("gitsigns").next_hunk()
      end,
      "Jump to next hunk",
    },
  },
}

return M
