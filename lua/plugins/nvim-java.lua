-- ================================================================================================
-- TITLE : nvim-java
-- ABOUT : Java support for nvim
-- LINKS :
--   > github                             : https://github.com/nvim-java/nvim-java
-- ================================================================================================

local javaHomeObj = vim.system({ "brew", "--prefix", "openjdk@21" }, { text = true }):wait()
vim.env["JAVA_HOME"] = vim.trim(javaHomeObj.stdout)

vim.pack.add({
	{
		src = "https://github.com/JavaHello/spring-boot.nvim",
		version = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0",
	},
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/mfussenegger/nvim-dap",

	"https://github.com/nvim-java/nvim-java",
})

require("java").setup()
