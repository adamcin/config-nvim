vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("3") },
})

local events = require("neo-tree.events")
require("neo-tree").setup({
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

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })
