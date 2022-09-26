local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local nvimTreeApi = require "nvim-tree.api"

-- ASCII US "unit separator"
-- used to delimit both keys and values
local token_sep = ": "

-- ASCII GS "group separator"
-- used to delimit the begining of a
-- subtable following a key
local subtable_start = "\29"

-- ASCII RS "record separator"
-- used to delimit the end of a subtable
local subtable_end = "\30"

local function stringify_table(table)
  local str = ""
  str = str .. "{"
  for key, val in pairs(table) do
    local t = type(val)
    if t == "table" then
      str = str .. key .. ": " .. stringify_table(val) .. ","
    elseif t == "boolean" then
      str = str .. key .. ":" .. tostring(val) .. ","
    elseif t ~= "function" then
      str = str .. key .. ":" .. val .. ","
    end
  end
  return str .. "}"
end

local colors = function(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "colors",
      finder = finders.new_table {
        results = {
          { "red", "#ff0000" },
          { "green", "#00ff00" },
          { "blue", "#0000ff" },
        },
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry[1],
            ordinal = entry[1],
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          print(vim.inspect(selection))
          -- vim.api.nvim_put({ selection[1] }, "", false, true)
        end)
        return true
      end,
    })
    :find()
end

-- to execute the function
colors(require("telescope.themes").get_dropdown {})
