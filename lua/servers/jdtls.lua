-- ================================================================================================
-- TITLE : jdtls (Java Language Server) LSP Setup
-- LINKS :
--   > website: https://github.com/mfussenegger/nvim-jdtls
-- ================================================================================================

local javaHomeObj = vim.system({ 'brew', '--prefix', 'openjdk@21' }, { text = true }):wait()
vim.env["JAVA_HOME"] = vim.trim(javaHomeObj.stdout)

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config('jdtls', {
		capabilities = capabilities,
    settings = {
      java = {
          -- Custom eclipse.jdt.ls options go here
      },
    },
		-- cmd = { "jdtls", "--java-executable", javaHome .. "/bin/java" },
		filetypes = { "java" },
    init_options = {
      bundles = {}
    },
	})
end
