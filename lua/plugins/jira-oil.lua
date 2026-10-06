vim.pack.add({
	{ src = "https://github.com/sbulav/jira-oil.nvim" },
})

return {
	"sbulav/jira-oil.nvim",

	-- Load on demand via keymaps
	keys = {
		{
			"<leader>jj",
			function()
				require("jira-oil").open("all")
			end,
			desc = "JiraOil: all",
		},
		{
			"<leader>js",
			function()
				require("jira-oil").open("sprint")
			end,
			desc = "JiraOil: sprint",
		},
		{
			"<leader>jc",
			function()
				require("jira-oil.scratch").open_new()
			end,
			desc = "JiraOil: create issue",
		},
	},

	config = function()
		require("jira-oil").setup({
			cli = {
				cmd = "jira",
				timeout = 10000,
				cache = {
					enabled = true,
					ttl_ms = {
						sprint_issues = 5000,
						backlog_issues = 5000,
						issue = 15000,
						epics = 30000,
					},
				},
				issues = {
					columns = { "key", "assignee", "status", "summary", "labels" },
					team_jql = "", -- e.g. "assignee in membersOf('TEAM_JQL')"
					exclude_jql = "issuetype not in (Epic, Theme, Initiative)",
					status_jql = "status not in (Closed, Deployed, \"Deployed in Prod\")",
				},
				epics = {
					args = { "issue", "list", "--type", "Epic" },
					columns = { "key", "summary", "status" },
					filters = { "-s~Closed", "-s~Deployed in Prod" },
					order_by = "created",
					prefill_search = "",
				},
				epic_issues = {
					args = { "issue", "list" },
					columns = { "type", "key", "assignee", "status", "summary", "labels" },
					filters = { "-s~Closed", "-s~Deployed", "-s~Deployed in Staging", "-s~Deployed in Prod" },
					order_by = "status",
					prefill_search = "",
				},
			},

			view = {
				columns = {
					{ name = "status", width = 15 },
					{ name = "assignee", width = 15 },
					{ name = "summary" },
					{ name = "labels", width = 20 },
				},
				key_width = 12,
				default_sort = "key",
				show_winbar = true,
				sections = {
					show_count = true,
					sprint_label = "Sprint",
					backlog_label = "Backlog",
				},
				status_icons = {
					-- GS Task statuses
					["New"] = "\u{f10c} ",
					["Confirmed"] = "\u{f14a} ",
					["In Progress"] = "\u{f144} ",
					["In Review"] = "\u{f06e} ",
					["Code Complete"] = "\u{f121} ",
					["To Verify"] = "\u{f002} ",
					["Verification in Progress"] = "\u{f110} ",
					["Deployed"] = "\u{f135} ",
					["Deployed in Staging"] = "\u{f0c2} ",
					["Deployed in Prod"] = "\u{f135} ",
					["Closed"] = "\u{f058} ",
					["Blocked"] = "\u{f05e} ",
					-- GS Epic statuses
					["Triage"] = "\u{f0e8} ",
					["Planning"] = "\u{f073} ",
					["Ready for Execution"] = "\u{f04b} ",
					-- GS Initiative/Feedback statuses
					["Ready for Review"] = "\u{f06e} ",
					["Not Started"] = "\u{f10c} ",
					default = "\u{f111} ",
				},
				type_icons = {
					-- GS issue types
					Task = "\u{f0ae} ",
					Story = "\u{f02d} ",
					Epic = "\u{f0e7} ",
					Bug = "\u{f188} ",
					Architecture = "\u{f1b2} ",
					Design = "\u{f1fc} ",
					Feedback = "\u{f086} ",
					["Customer Request"] = "\u{f007} ",
					["Sub-task"] = "\u{f0ae} ",
					["Defect Sub-task"] = "\u{f188} ",
					Test = "\u{f0c3} ",
					Theme = "\u{f02b} ",
					Initiative = "\u{f135} ",
					["Efficiency+"] = "\u{f0d0} ",
					default = "\u{f016} ",
				},
			},

			keymaps = {
				["g?"] = { "actions.show_help", mode = "n" },
				["gR"] = { "actions.reset", mode = "n" },
				["<CR>"] = "actions.select",
				["<C-c>"] = { "actions.create", mode = "n" },
				["gB"] = { "actions.open_in_browser", mode = "n" },
				["<C-y>"] = { "actions.yank_issue_key", mode = { "n", "v" } },
				["dd"] = { "actions.queue_removal", mode = "n" },
				[">>"] = { "actions.move_to_sprint", mode = "n" },
				["<<"] = { "actions.move_to_backlog", mode = "n" },
				["ga"] = { "actions.filter_by_assignee", mode = "n" },
				["gS"] = { "actions.filter_by_status", mode = "n" },
				["gp"] = { "actions.filter_by_project", mode = "n" },
				["g/"] = { "actions.filter_prompt", mode = "n" },
				["gu"] = { "actions.clear_filters", mode = "n" },
				["-"] = { "actions.parent_view", mode = "n" },
				["p"] = { "actions.paste_after", mode = "n" },
				["P"] = { "actions.paste_before", mode = "n" },
				["<M-r>"] = { "actions.refresh", mode = "n" },
				["<C-q>"] = { "actions.close", mode = "n" },
				["<C-s>"] = { "actions.save", mode = "n" },
			},
			keymaps_issue = {
				["g?"] = { "actions.show_help", mode = { "n", "i" } },
				["gR"] = { "actions.reset", mode = { "n", "i" } },
				["<C-e>"] = { "actions.pick_epic", mode = { "n", "i" } },
				["<C-o>"] = { "actions.pick_components", mode = { "n", "i" } },
				["gB"] = { "actions.open_in_browser", mode = { "n", "i" } },
				["<C-y>"] = { "actions.yank_issue_key", mode = { "n", "i" } },
				["<C-q>"] = { "actions.close", mode = { "n", "i" } },
				["<C-s>"] = { "actions.save", mode = { "n", "i" } },
			},
			use_default_keymaps = true,

			keymaps_help = {
				border = nil,
				show_title = true,
				show_footer = true,
				key_width = 18,
				separator = " \u{2502} ",
				max_width_ratio = 0.9,
				max_height_ratio = 0.8,
			},

			defaults = {
				project = vim.env.JIRA_PROJECT or "GS",
				assignee = vim.env.JIRA_USER or vim.env.JIRA_ASSIGNEE or "",
				issue_type = "Task",
				status = "New",
			},

			-- GS uses customfield_11800 for Epic Link
			epic_field = "customfield_11800",

			create = {
				available_components = {
					"Agents",
					"Agentic UI",
					"Brands",
					"Campaigns",
					"Connectors",
					"Content",
					"Content Generation",
					"Core Engineering",
					"Extensibility",
					"Foundation",
					"Home",
					"Insights",
					"MCP",
					"Navigation",
					"Personas",
					"Plugins",
					"Provisioning",
					"Review and Approval",
					"Templates",
					"Unified Experience",
				},
			},
		})
	end,
}
