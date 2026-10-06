-- ================================================================================================
-- TITLE : copilot
-- LINKS :
--   > github : https://github.com/github/copilot.vim
-- ABOUT : ✨ AI Coding, Vim Style
-- ================================================================================================

vim.g.copilot_node_command = "~/.nvm/versions/node/v22.18.0/bin/node"
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

vim.pack.add({
	{ src = "https://github.com/github/copilot.vim" },
})

vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })

return {
	"github/copilot.vim",
	keys = {
		{ "<leader>cc", "<cmd>Copilot<cr>", desc = "Toggle Copilot" },
	},
}
