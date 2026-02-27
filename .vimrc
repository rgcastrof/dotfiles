" general options
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set signcolumn=yes
set laststatus=2
set wrap
set noswapfile
set number
set relativenumber
set ignorecase
set smartcase
set smartindent
set termguicolors
syntax on

" keymaps
let mapleader = " "
nnoremap <leader>e :Ex<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<Space>
nnoremap <leader>y "+y
nnoremap <leader>d "+d
vnoremap <leader>y "+y
vnoremap <leader>d "+d

" plugins
let s:plugin_dir = expand("~/.local/share/vim/plugged")

function! s:ensure(repo)
	let name = split(a:repo, "/")[-1]
	let path = s:plugin_dir . "/" . name

	if !isdirectory(path)
		if !isdirectory(s:plugin_dir)
			call mkdir(s:plugin_dir, "p")
		endif
		execute "!git clone --depth=1 https://github.com/" . a:repo . " " . shellescape(path)
	endif

	execute "set runtimepath+=" . fnameescape(path)
endfunction

call s:ensure("ghifarit53/tokyonight-vim")
call s:ensure("junegunn/fzf")
call s:ensure("junegunn/fzf.vim")
call s:ensure("itchyny/lightline.vim")
call s:ensure("yegappan/lsp")

" colorscheme
let g:tokyonight_enable_italic = 1
let g:lightline = {
		\ "colorscheme": "tokyonight",
		\ "mode_map": {
			\ "n": "NOR",
			\ "i": "INS",
			\ "v": "VIS",
			\ "V": "VIS",
		\ },
	\ }

colorscheme tokyonight

" lsp
let lspOpts = #{autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)

let lspServers = [
	\ #{
	\    name: 'clang',
	\    filetype: ['c', 'cpp'],
	\    path: '/usr/local/bin/clangd',
	\    args: ['--background-index']
	\ },
	\ #{
	\    name: 'gopls',
	\    filetype: 'go',
	\    path: expand('~/go/bin/gopls'),
	\    args: ['serve']
	\ }
\ ]
autocmd User LspSetup call LspAddServer(lspServers)

nnoremap gd :LspGotoDefinition<CR>
nnoremap gr :LspShowReferences<CR>
nnoremap K  :LspHover<CR>
nnoremap gl :LspDiag current<CR>
nnoremap g] :LspDiag next \| LspDiag current<CR>
nnoremap g[ :LspDiag prev \| LspDiag current<CR>

autocmd User LspSetup call LspOptionsSet(#{
    \ noNewlineInCompletion: v:true,
    \ popupBorder: v:true,
    \ popupBorderHighlight: 'Title',
    \ popupBorderSignatureHelp: v:true,
    \ popupHighlight: 'Normal',
\ })
