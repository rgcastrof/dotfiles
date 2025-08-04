vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.swapfile = false
vim.o.signcolumn = "yes"
vim.g.mapleader = " "
vim.o.cursorline = true

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.pack.add({
    { src = "https://github.com/navarasu/onedark.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
vim.lsp.enable({ "lua_ls", "clangd", "gopls" })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

require('gitsigns').setup()
require('nvim-autopairs').setup()
require('mason').setup()
require('mini.pick').setup()
require('oil').setup()
require('onedark').setup { style = 'darker' }
require('onedark').load()
require'nvim-treesitter.configs'.setup({
	ensure_installed = { "c", "lua", "go" },
	highlight = { enable = true },
})
local cmp = require('cmp')
cmp.setup({
	window = {
		completion = {
			border = 'rounded',
			winhighlight = "Normal:Normal,FloatBorder:Normal,Search:None",
		},
		documentation = {
			border = 'rounded',
			winhighlight = "Normal:Normal,FloatBorder:Normal,Search:None",
		}
	},
    sources = {
        { name = 'nvim_lsp' },
    },
	mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    }),
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
})

local x = vim.diagnostic.severity
vim.diagnostic.config {
    virtual_text = true,
    signs = { text = { [x.ERROR] = " ", [x.WARN] = " ", [x.INFO] = " ", [x.HINT] = "󰠠 " } },
}

for _, group in ipairs({ "Error", "Warn", "Info", "Hint"}) do
	local hl = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualText" .. group, link = false})
	hl.bg = "None"
	vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. group, hl)
end
vim.api.nvim_set_hl(0, "StatusLine", { bg = "None" })
