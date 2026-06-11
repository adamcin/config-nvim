vim.pack.add({
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/antoinemadec/FixCursorHold.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-neotest/neotest" },
  { src = "https://github.com/nvim-neotest/neotest-jest" },
  { src = "https://github.com/marilari88/neotest-vitest" },
});

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
  },
  config = function()
    local nodeproject = require("utils.nodeproject")
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestConfigFile = nodeproject.jest_config_for_file,
          jestCommand = nodeproject.jest_command_for_file,
        }),
        require("neotest-vitest"),
      }
    })
  end,
};
