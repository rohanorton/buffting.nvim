local Ui = require("buffting.ui")
local Buffers = require("buffting.buffers")

local M = {}

M.open_menu = function()
  local buffers = Buffers()
  local ui = Ui({
    buffers = buffers,
    height = 10,
    width = 60,
  })
  ui.open_menu()
end

M.jump_to = function(idx)
  local buffers = Buffers()
  -- Use pcall to ignore error (e.g. range error)
  pcall(buffers.jump_to, idx)
end

-- TODO: setup function

return M
