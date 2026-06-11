let s:plugin_dir = expand('~/.local/vim/plugged')

function! s:ensure(repo)
	let name = split(a:repo, '/')[-1]
	let path = s:plugin_dir . '/' . name

	if !isdirectory(path)
		if !isdirectory(s:plugin_dir)
			call mkdir(s:plugin_dir, 'p')
		endif
		execute '!git clone --depth=1 https://github.com/' . a:repo . ' ' . shellescape(path)
	endif
	execute 'set runtimepath+=' . fnameescape(path)
endfunction

call s:ensure('bluz71/vim-moonfly-colors')
call s:ensure('junegunn/fzf')
call s:ensure('junegunn/fzf.vim')
call s:ensure('yegappan/lsp')
call s:ensure('tpope/vim-fugitive')
call s:ensure('tpope/vim-commentary')
call s:ensure('airblade/vim-gitgutter')
