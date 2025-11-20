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
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
vim.keymap.set('n', '<leader>t', ":tabnew<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")

vim.lsp.enable({ "lua_ls", "clangd", "gopls", "pyright" })

require('gitsigns').setup()
require('mason').setup()
require('mini.pick').setup()
require('oil').setup()
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

require("rose-pine").setup({
    variant = "auto",
    dark_variant = "main",
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
    },

    styles = {
        bold = true,
        italic = true,
        transparency = true,
    },
})

vim.cmd("colorscheme rose-pine")
vim.api.nvim_set_hl(0, "StatusLine", { bg = "None" })
