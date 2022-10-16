local Buffer = require("buffting.buffer")

local function Buffers()
  local self = {}

  local buffers = {}

  local function add_buffer(id)
    local buf = Buffer(id)
    if buf.is_loaded() and buf.is_listed() then
      table.insert(buffers, buf)
    end
  end

  local function populate_buffers_list()
    local bufs = vim.api.nvim_list_bufs()
    for _, id in ipairs(bufs) do
      add_buffer(id)
    end
  end

  local function len()
    return #buffers
  end

  local function check_range(n)
    if n > len() then
      error("RangeError: No buffer in range.")
    end
  end

  local function wrap(n)
    return ((n - 1) % len()) + 1
  end

  local function _jump_to(idx)
    check_range(idx)
    buffers[idx].jump_to()
  end

  local function get_name(idx)
    return buffers[idx].get_name()
  end

  function self.jump_to(idx)
    populate_buffers_list()
    _jump_to(idx)
  end

  function self.next()
    populate_buffers_list()
    local curr_idx = self.get_active_buffer_index()
    local idx = wrap(curr_idx + 1)
    _jump_to(idx)
  end

  function self.prev()
    populate_buffers_list()
    local curr_idx = self.get_active_buffer_index()
    local idx = wrap(curr_idx - 1)
    _jump_to(idx)
  end

  function self.get_names()
    populate_buffers_list()
    local result = {}
    for idx = 1, len() do
      local name = get_name(idx)
      table.insert(result, name)
    end
    return result
  end

  function self.get_active_buffer_index()
    local active_buffer_idx = 1
    local last_used = 0
    for idx, buf in ipairs(buffers) do
      if buf.is_visible() then
        if buf.last_used() > last_used then
          last_used = buf.last_used()
          active_buffer_idx = idx
        end
      end
    end
    return active_buffer_idx
  end

  return self
end

return Buffers
