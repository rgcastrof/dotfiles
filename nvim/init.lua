vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.swapfile = false
vim.o.signcolumn = "yes"
vim.g.mapleader = " "
vim.o.winborder = 'rounded'

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
vim.lsp.enable({ "lua_ls", "clangd", "gopls" })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.diagnostic.config ({ virtual_text = true })

require('gitsigns').setup()
require('mason').setup()
require('mini.pick').setup()
require('oil').setup()
require'nvim-treesitter.configs'.setup({
	ensure_installed = { "c", "lua", "go" },
	highlight = { enable = true }
})
local cmp = require('cmp')
cmp.setup({
	window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered(), },
    sources = { { name = 'nvim_lsp' }, },
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

require "vague".setup({ transparent = true })
vim.cmd.colorscheme "vague"
vim.api.nvim_set_hl(0, "StatusLine", { bg = "None" })
