local log_levels = { "trace", "debug", "info", "warn", "error", "fatal" }

local default_log_level = "warn" -- If user hasn't set log_level

local function set_log_level()
  local log_level = vim.env.BUFFTING_LOG or vim.g.buffting_log_level

  for _, level in pairs(log_levels) do
    if level == log_level then
      return log_level
    end
  end

  return default_log_level
end

local log_level = set_log_level()

local log = require("plenary.log").new({
  plugin = "buffting",
  level = log_level,
})

return {
  log = log,
}
