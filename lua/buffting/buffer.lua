local function Buffer(id)
  local self = {}

  local function get_filename()
    return vim.fn.bufname(id)
  end

  local function get_buf_info()
    local info = vim.fn.getbufinfo(id)
    return info and info[1] or {}
  end

  self.get_id = function()
    return id
  end

  self.get_name = function()
    return get_filename() or "(empty)"
  end

  self.is_visible = function()
    local info = get_buf_info()
    return info.hidden == 0
  end

  self.last_used = function()
    local info = get_buf_info()
    return info.lastused or 0
  end

  self.is_loaded = function()
    return vim.fn.bufloaded(id) == 1
  end

  self.is_listed = function()
    return vim.fn.buflisted(id) == 1
  end

  self.jump_to = function()
    vim.api.nvim_set_current_buf(id)
  end

  return self
end

return Buffer
