local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function setTelescopeKeyMap(keyName, actionName)
  vim.keymap.set("n", keyName, function()
    if vim.bo.filetype == "NvimTree" then
      local nodeInfo = require("nvim-tree.api").tree.get_node_under_cursor()

      -- for key in pairs(nodeInfo) do
      --  if type(nodeInfo[key]) ~= "table" then
      --    print(key .. ":  " .. tostring(nodeInfo[key]))
      --  end
      -- end

      require("telescope.builtin")[actionName] {
        cwd = nodeInfo.absolute_path,
        prompt_title = string.upper(actionName) .. " in " .. nodeInfo.name,
        attach_mappings = function(prompt_bufnr, map)
          local function show_file(type)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              local pathname = nodeInfo.absolute_path .. "/" .. selection.value
              -- print(vim.inspect(selection, { depth = 3 }))
              vim.cmd(type .. " " .. pathname)
            end)
          end

          map("i", "<cr>", function()
            show_file "vsp"
          end)

          map("n", "<C-v>", function()
            show_file "vsp"
          end)

          map("n", "<C-x>", function()
            show_file "sp"
          end)

          map("n", "<C-t>", function()
            show_file "tabn"
          end)

          return true
        end,
      }
    else
      require("telescope.builtin")[actionName]()
    end
  end)
end

setTelescopeKeyMap("<leader>ff", "find_files")
setTelescopeKeyMap("<leader>fw", "live_grep")
