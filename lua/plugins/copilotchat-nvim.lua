vim.pack.add({
	{ src = "https://github.com/CopilotC-Nvim/CopilotChat.nvim" },
})

vim.keymap.set("n", "<leader>ac", "<cmd>CopilotChatToggle<cr>", { desc = "Toggle Copilot" })
--vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
--vim.keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
--vim.keymap.set("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
vim.keymap.set("n", "<leader>am", "<cmd>CopilotChatModels<cr>", { desc = "Select Copilot model" })
--vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer" })
--vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })
--vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
--vim.keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })

return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		-- build = "make tiktoken",
		opts = {
			model = "gpt-5-mini", -- AI model to use
			temperature = 0.1, -- Lower = focused, higher = creative
			trusted_tools = nil, -- Require approval for all tool calls
			window = {
				layout = "vertical", -- 'vertical', 'horizontal', 'float'
				width = 0.5, -- 50% of screen width
			},
			auto_insert_mode = true, -- Enter insert mode when opening
		},
	},
}
