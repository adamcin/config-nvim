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

-- Process a lazy.vim-style plugin spec: register keys and invoke the config function.
-- Also recurses into dependencies that carry their own config or keys.
-- Handles both a single spec table and an array of specs (e.g. theme.lua).
-- Safe to call with nil or non-table values.
function M.register(spec)
  if type(spec) ~= "table" then return end

  -- Array of specs: { { "plugin-a", ... }, { "plugin-b", ... } }
  -- Detected by the first element being a table rather than the plugin name string.
  if type(spec[1]) == "table" then
    for _, s in ipairs(spec) do
      M.register(s)
    end
    return
  end

  -- Recurse into dependencies before the parent so they are ready when config runs.
  if type(spec.dependencies) == "table" then
    for _, dep in ipairs(spec.dependencies) do
      if type(dep) == "table" then
        M.register(dep)
      end
    end
  end

  -- Register keys
  if type(spec.keys) == "table" then
    for _, entry in ipairs(spec.keys) do
      apply_key(entry)
    end
  end

  -- Call config. lazy.vim passes (plugin, opts) but current plugin files don't use
  -- those args, so we pass (spec, opts) as a close approximation.
  if type(spec.config) == "function" then
    spec.config(spec, spec.opts or {})
  end
end

return M
