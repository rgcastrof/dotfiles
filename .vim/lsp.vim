let lspOpts = #{
	\ autoComplete: v:true,
	\ popupBorder: v:true,
	\ autoHighlightDiags: v:true,
	\ diagSignErrorText: '>>',
	\ diagSignHintText: '->',
	\ diagSignInfoText: '**',
	\ diagSignWarningText: '!!',
\ }
autocmd User LspSetup call LspOptionsSet(lspOpts)

let lspServers = [
	\ #{
	\	  name: 'clangd',
	\	  filetype: ['c', 'cpp'],
	\	  path: '/usr/bin/clangd',
	\	  args: ['--background-index', '--clang-tidy']
	\ },
	\ #{
	\	  name: 'gopls',
	\	  filetype: 'go',
	\	  path: expand('~/.local/bin/gopls'),
	\	  args: ['serve']
	\ },
	\ #{
	\	  name: 'zls',
	\	  filetype: 'zig',
	\	  path: '/usr/local/bin/zls',
	\	  args: []
	\ },
	\ #{
	\	  name: 'tsserver',
	\     filetype: ['javascript', 'typescript'],
	\     path: expand('~/.nvm/versions/node/v26.0.0/bin/typescript-language-server'),
	\     args: ['--stdio']
	\ },
\ ]

autocmd User LspSetup call LspAddServer(lspServers)

nnoremap <leader>k :LspHover<CR>
nnoremap <leader>r :LspRename<CR>
nnoremap <leader>x :LspFormat<CR>
nnoremap <leader>d :LspDiag current<CR>
nnoremap <leader>c :LspCodeAction<CR>
nnoremap gd        :LspGotoDefinition<CR>
nnoremap gD        :LspGotoDeclaration<CR>
nnoremap gy        :LspGotoTypeDef<CR>
nnoremap gr        :LspPeekReferences<CR>
nnoremap gi        :LspGotoImpl<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
