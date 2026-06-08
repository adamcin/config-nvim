vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.opt.wrap = false -- Don't wrap lines
vim.opt.cmdheight = 1 -- Command line height
vim.opt.spelllang = { "en" } -- Set language for spellchecking

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.lazyredraw = false
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
vim.opt.synmaxcol = 300

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.autoread = true
vim.opt.autowrite = false


vim.opt.diffopt:append("vertical")
vim.opt.diffopt:append("algorithm:patience")
vim.opt.diffopt:append("linematch:60")

local undodir = "~/.local/share/nvim/undodir"
vim.opt.undodir = vim.fn.expand(undodir)
-- local undodir_path = "~/.local/share/nvim/undodir"
-- if vim.fn.isdirectory(undodir_path) == 0 then
	-- vim.fn.mkdir(undodir_path, "p")
-- end

vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "inclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignorecase = true

vim.opt.guicursor = {
	"n-v-c:block",
	"i-ci-ve:block",
	"r-cr:hor20",
	"o:hor50",
	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
	"sm:block-blinkwait175-blinkoff150-blinkon175",
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

vim.opt.splitbelow = true
vim.opt.splitright = true

