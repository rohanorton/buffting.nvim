local popup = require("plenary.popup")
local log = require("buffting.dev").log

local function Ui(opts)
  local self = {}

  local buffers = opts.buffers

  local win_id = nil
  local bufh = nil

  local function create_window()
    log.trace("create_window()")
    local height = opts.height or 10
    local width = opts.width or 60
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local bufnr = vim.api.nvim_create_buf(false, false)

    local id, win = popup.create(bufnr, {
      title = "Buffting",
      highlight = "BufftingWindow",
      line = math.floor(((vim.o.lines - height) / 2) - 1),
      col = math.floor((vim.o.columns - width) / 2),
      minwidth = width,
      minheight = height,
      borderchars = borderchars,
    })

    vim.api.nvim_win_set_option(win.border.win_id, "winhl", "Normal:BufftingBorder")

    return {
      bufnr = bufnr,
      win_id = id,
    }
  end

  local function set_line_number(line_num)
    vim.api.nvim_win_set_cursor(win_id, { line_num, 0 })
  end

  local function select_current_menu_item()
    local idx = vim.fn.line(".")
    self.close_menu()
    buffers.jump_to(idx)
  end

  local function is_menu_open()
    return win_id and vim.api.nvim_win_is_valid(win_id)
  end

  function self.close_menu()
    log.trace("close_menu()")
    if is_menu_open() then
      vim.api.nvim_win_close(win_id, true)

      win_id = nil
      bufh = nil
    end
  end

  function self.open_menu()
    log.trace("open_menu()")
    if is_menu_open() then
      return
    end

    local win_info = create_window()
    win_id = win_info.win_id
    bufh = win_info.bufnr

    local contents = buffers.get_names()

    -- Add line numbers (gives basic idea of what the )
    vim.api.nvim_win_set_option(win_id, "number", true)

    vim.api.nvim_buf_set_name(bufh, "buffting-menu")

    -- Set buffer content
    vim.api.nvim_buf_set_lines(bufh, 0, #contents, false, contents)

    vim.api.nvim_buf_set_option(bufh, "filetype", "buffting")
    vim.api.nvim_buf_set_option(bufh, "buftype", "nofile")
    vim.api.nvim_buf_set_option(bufh, "bufhidden", "delete")
    vim.api.nvim_buf_set_option(bufh, "modifiable", false)

    -- Exit on Q / <Esc>
    vim.keymap.set("n", "q", self.close_menu, { silent = true, buffer = bufh })
    vim.keymap.set("n", "<Esc>", self.close_menu, { silent = true, buffer = bufh })

    -- Select buffer with Enter
    vim.keymap.set("n", "<CR>", select_current_menu_item, { silent = true, buffer = bufh })

    -- Or use line number
    for i = 1, 9 do
      vim.keymap.set("n", tostring(i), function()
        set_line_number(i)
        select_current_menu_item()
      end, { silent = true, buffer = bufh })
    end

    -- Close buffer on click out
    vim.api.nvim_create_autocmd("BufLeave", { nested = true, once = true, callback = self.close_menu, buffer = bufh })

    -- Find current buffer and set line number
    local active_idx = buffers.get_active_buffer_index()
    set_line_number(active_idx)
  end

  function self.toggle_menu()
    log.trace("toggle_menu()")
    return is_menu_open() and self.close_menu() or self.open_menu()
  end

  return self
end

return Ui
