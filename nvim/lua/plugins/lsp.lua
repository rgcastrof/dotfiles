vim.lsp.enable({ "lua_ls", "clangd", "gopls", "zls", "pylsp", "ts_ls" })

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

local severity = vim.diagnostic.severity

vim.diagnostic.config({
	signs = {
		text = {
			[severity.ERROR] = ">>",
			[severity.WARN]  = "->",
			[severity.HINT]  = "**",
			[severity.INFO]  = "!!",
		},
	},
})
