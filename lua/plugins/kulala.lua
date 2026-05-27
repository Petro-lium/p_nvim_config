local K = require("kulala")

local function kulala(key, fn, desc)
  return {
    key,
    function() K[fn]() end,
    desc = "Kulala: " .. desc,
    ft = "http",
  }
end

return {
  "mistweaverco/kulala.nvim",
  ft = "http",
  keys = {
    kulala("<leader>Rs", "run", "Send request"),
    kulala("<leader>Ra", "run_all", "Send all requests"),
    kulala("<leader>Rb", "scratchpad", "Scratchpad"),
  },
  opts = {
    global_keymaps = false,
  },
}
