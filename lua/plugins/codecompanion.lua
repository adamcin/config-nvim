-- ================================================================================================
-- TITLE : codecompanion
-- LINKS :
--   > github : https://github.com/olimorris/codecompanion.nvim
--   > example: https://github.com/olimorris/codecompanion.nvim/blob/c8bd2d0ff58b75d9a76f0a17115581754824b725/minimal.lua#L49
-- ABOUT : ✨ AI Coding, Vim Style
-- ================================================================================================


vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/olimorris/codecompanion.nvim" }
})

require("codecompanion").setup({
  interactions = {
    -- chat = { adapter = "anthropic" },
    -- inline = { adapter = "anthropic" },
  },
  opts = {
    --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
    log_level = "DEBUG", -- or "TRACE"
  }
})

-- Author's recommendations
vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])



