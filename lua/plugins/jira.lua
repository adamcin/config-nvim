vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	-- { src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/kid-icarus/jira.nvim" },
})

return {
	"kid-icarus/jira.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "nvim-telescope/telescope.nvim", -- optional
		"folke/snacks.nvim", -- optional
	},
	config = function()
		require("jira").setup({
			jira_api = {
				domain = vim.env.JIRA_DOMAIN,
				username = vim.env.JIRA_USER,
				token = vim.env.JIRA_API_TOKEN,
			},
			use_git_branch_issue_id = true,
			git_trunk_branch = "main", -- The main branch of your project
			git_branch_prefix = "adamcin/", -- The prefix for your feature branches
			-- or leave it empty to use the default settings
		})
	end,
	keys = {
		{
			"<leader>jv",
			"<cmd>Jira issue view<cr>",
			desc = "Jira View Issue",
		},
		{
			"<leader>jc",
			"<cmd>Jira issue create<cr>",
			desc = "Jira Create Issue",
		},
		{
			"<leader>jt",
			require("jira.pickers.snacks").transitions,
			-- require("jira.pickers.telescope").transitions,
			desc = "Jira Transitions",
		},
	},
	opts = {}, -- see configuration section
}
