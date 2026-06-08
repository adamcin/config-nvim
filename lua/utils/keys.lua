local M = {}

-- Translate a single lazy.vim-style keys entry into a vim.keymap.set() call.
-- Entry format: { lhs, rhs, mode = "n", desc = "...", noremap, silent, expr, nowait, ft }
-- If rhs is absent, the entry is a lazy-load trigger with no action — skip it.
-- If ft is set, scope the keymap to that filetype via FileType autocmd.
local function apply_key(entry)
  if type(entry) == "string" then return end

  local lhs = entry[1]
  local rhs = entry[2]
  if not lhs or not rhs then return end

  local mode = entry.mode or "n"

  local opts = {
    desc    = entry.desc,
    noremap = entry.noremap ~= false,
    silent  = entry.silent ~= false,
  }
  if entry.buffer ~= nil then opts.buffer = entry.buffer end
  if entry.expr ~= nil then opts.expr = entry.expr end
  if entry.nowait ~= nil then opts.nowait = entry.nowait end
  if entry.replace_keycodes ~= nil then opts.replace_keycodes = entry.replace_keycodes end

  if entry.ft ~= nil then
    local pattern = type(entry.ft) == "string" and { entry.ft } or entry.ft
    vim.api.nvim_create_autocmd("FileType", {
      pattern = pattern,
      callback = function()
        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { buffer = true }))
      end,
    })
    return
  end

  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Register keymaps from a lazy.vim-style plugin spec table.
-- Safe to call with nil or non-table values (e.g. plugins that return nothing).
function M.register(spec)
  if type(spec) ~= "table" then return end
  local keys = spec.keys
  if not keys then return end
  for _, entry in ipairs(keys) do
    apply_key(entry)
  end
end

return M
