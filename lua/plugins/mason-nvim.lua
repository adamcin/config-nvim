vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim", opts = {} },
})

require("mason").setup()

return {
  "mason-org/mason.nvim",
  opts = {},
}
