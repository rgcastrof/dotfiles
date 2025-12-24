vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.o.signcolumn = "yes"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.showtabline = 2
vim.o.wrap = false
vim.o.swapfile = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartindent = true
vim.o.termguicolors = true

vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/iamcco/markdown-preview.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
})

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
vim.keymap.set('n', '<leader>t', ":tabnew<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")

vim.lsp.enable({ "lua_ls", "clangd", "gopls", "pyright" })

require('gitsigns').setup()
require('mason').setup()
require('oil').setup({
	default_file_explorer = true,
	columns = { "permissions", "icon" },
})
require'nvim-treesitter.configs'.setup({
	ensure_installed = { "c", "lua", "go", "python" },
	highlight = { enable = true }
})

local cmp = require('cmp')
cmp.setup({
	window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered(), },
    sources = { { name = 'nvim_lsp' }, },
	mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    }),
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
})

require('lualine').setup({
	options = { component_separators = '' },
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff'},
		lualine_c = {'filename'},
		lualine_x = {
			{
				'diagnostics',
				sections = { 'error', 'warn', 'info', 'hint' },

				diagnostics_color = {
					error = 'DiagnosticError',
					warn  = 'DiagnosticWarn',
					info  = 'DiagnosticInfo',
					hint  = 'DiagnosticHint',
			  },
			  symbols = {error = '⚫', warn = '⚫', info = '⚫', hint = '⚫'},
			}, 'filetype'
		},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
})

local signs = {}
for _, sev in pairs(vim.diagnostic.severity) do
	signs[sev] = "⚫"
end
vim.diagnostic.config ({ signs = { text = signs } })

vim.cmd[[colorscheme tokyonight-night]]
