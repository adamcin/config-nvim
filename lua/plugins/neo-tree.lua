vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("3") },
})

local events = require("neo-tree.events")
local Snacks = require("snacks")
require("neo-tree").setup({
  source_selector = {
      winbar = true,
      statusline = false,
  },
  event_handlers = {
    {
      event = events.FILE_MOVED,
      handler = function(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end,
    },
    {
      event = events.FILE_RENAMED,
      handler = function(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end,
    },
  },
})


--     nnoremap / :Neotree toggle current reveal_force_cwd<cr>
--     nnoremap | :Neotree reveal<cr>
--     nnoremap gd :Neotree float reveal_file=<cfile> reveal_force_cwd<cr>
--     nnoremap <leader>b :Neotree toggle show buffers right<cr>
--     nnoremap <leader>s :Neotree float git_status<cr>

vim.keymap.set("n", "<leader>/", "<cmd>Neotree toggle current reveal_force_cwd<cr>", { desc = "Toggle Tree" })
vim.keymap.set("n", "|", "<cmd>Neotree reveal<cr>", { desc = "Reveal in Tree" })
vim.keymap.set("n", "gd", "<cmd>Neotree float reveal_file=<cfile> reveal_force_cwd<cr>", { desc = "Reveal file under cursor in Tree" })
vim.keymap.set("n", "<leader>bl", "<cmd>Neotree toggle show buffers right<cr>", { desc = "List buffers" })


