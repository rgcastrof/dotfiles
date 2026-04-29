vim.g.mapleader      = " "
vim.o.winborder      = "single"
vim.o.signcolumn     = "yes"
vim.o.colorcolumn    = "80"
vim.o.tabstop        = 4
vim.o.shiftwidth     = 4
vim.o.wrap           = false
vim.o.swapfile       = false
vim.o.number         = true
vim.o.relativenumber = true
vim.o.ignorecase     = true
vim.o.smartindent    = true
vim.o.termguicolors  = true

vim.pack.add({
    { src = "https://github.com/vague-theme/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
})

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")

require('vague').setup({ transparent = true })
require('mini.pick').setup({})
require('gitsigns').setup()
require('oil').setup({ default_file_explorer = true, columns = { "permissions", "size" } })
require("luasnip.loaders.from_vscode").lazy_load()

local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>",     function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

local cmp = require'cmp'
cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},

	window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered(), },

	mapping = cmp.mapping.preset.insert({
		["<Tab>"]        = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<S-Tab>"]      = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		['<C-b>']        = cmp.mapping.scroll_docs(-4),
		['<C-f>']        = cmp.mapping.scroll_docs(4),
		['<C-e>']        = cmp.mapping.abort(),
		['<C-Space>']    = cmp.mapping.confirm({ select = true }),
	}),

	sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'luasnip' }, }, { { name = 'buffer' } })
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }

		vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<leader>x', vim.lsp.buf.format, opts)
		vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
		vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gd',        vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gD',        vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gy',        vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', 'gr',        vim.lsp.buf.references, opts)
		vim.keymap.set('n', 'gi',        vim.lsp.buf.implementation, opts)
	end,
})
vim.lsp.enable({ "lua_ls", "clangd", "gopls", "zls", "css", "html" })

vim.cmd.colorscheme('vague')

local ls = require("luasnip")

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
