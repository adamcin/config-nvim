local M = {}

M.read_json = function(path)
  if vim.fn.filereadable(path) ~= 1 then return nil end
  local ok, result = pcall(function()
    return vim.fn.json_decode(table.concat(vim.fn.readfile(path), "\n"))
  end)
  return ok and result or nil
end

-- A workspace root has pnpm-workspace.yaml (pnpm) or a workspaces field in package.json (npm/yarn).
M.is_workspace_root = function(dir)
  if vim.fn.filereadable(dir .. "/pnpm-workspace.yaml") == 1 then return true end
  local pkg = M.read_json(dir .. "/package.json")
  return pkg ~= nil and pkg.workspaces ~= nil
end

-- Walk up from a file or directory, collecting dirs with package.json and stopping at the
-- workspace root. Returns (workspace_root or nil, pkg_dirs from innermost to outermost).
M.find_workspace_info = function(file)
  local dir = vim.fn.isdirectory(file) == 1 and file or vim.fn.fnamemodify(file, ":h")
  local pkg_dirs = {}
  local workspace_root = nil

  while true do
    if vim.fn.filereadable(dir .. "/package.json") == 1 then
      table.insert(pkg_dirs, dir)
      if M.is_workspace_root(dir) then
        workspace_root = dir
        break
      end
    end
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then break end
    dir = parent
  end

  return workspace_root, pkg_dirs
end

M.find_jest_config = function(dir)
  for _, name in ipairs({
    "jest.config.js", "jest.config.ts",
    "jest.config.mjs", "jest.config.cjs", "jest.config.json",
  }) do
    if vim.fn.filereadable(dir .. "/" .. name) == 1 then
      return dir .. "/" .. name
    end
  end
end

M.jest_config_for_file = function(file)
  local workspace_root, pkg_dirs = M.find_workspace_info(file)

  -- Prefer the innermost workspace member package that has its own jest config.
  for _, pkg_dir in ipairs(pkg_dirs) do
    if pkg_dir == workspace_root then break end
    local cfg = M.find_jest_config(pkg_dir)
    if cfg then return cfg end
  end

  -- Fall back to the workspace root (or cwd if no workspace was found).
  local root = workspace_root or vim.fn.getcwd()
  return M.find_jest_config(root) or (root .. "/jest.config.js")
end

-- Detect package manager from the packageManager field in package.json, then from lock files.
M.get_package_manager = function(root)
  local pkg = M.read_json(root .. "/package.json")
  if pkg and pkg.packageManager then
    if pkg.packageManager:match("^pnpm") then return "pnpm" end
    if pkg.packageManager:match("^yarn") then return "yarn" end
    if pkg.packageManager:match("^npm") then return "npm" end
  end
  if vim.fn.filereadable(root .. "/pnpm-lock.yaml") == 1 then return "pnpm" end
  if vim.fn.filereadable(root .. "/yarn.lock") == 1 then return "yarn" end
  return "npm"
end

-- Return the jest command for a file's package.
-- Delegates to the package's test script when one is defined; otherwise runs jest directly
-- via the workspace package manager.
M.jest_command_for_file = function(file)
  local workspace_root, pkg_dirs = M.find_workspace_info(file)
  local root = workspace_root or vim.fn.getcwd()
  local pm = M.get_package_manager(root)

  local innermost = pkg_dirs[1]
  if innermost and innermost ~= workspace_root then
    local pkg = M.read_json(innermost .. "/package.json")
    if pkg and pkg.scripts and pkg.scripts.test then
      if pm == "pnpm" then return "pnpm test --" end
      if pm == "yarn" then return "yarn test" end
      return "npm test --"
    end
  end

  if pm == "pnpm" then return "pnpm exec jest" end
  if pm == "yarn" then return "yarn jest" end
  return "npx jest"
end

return M
