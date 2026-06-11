function! ReadMode()
	let l:m = mode()
	if l:m ==# 'n' | return 'NOR'
	elseif l:m ==# 'i' | return 'INS'
	elseif l:m ==# 'v' || l:m ==# 'V' || l:m ==# "\<C-v>" | return 'SEL'
	elseif l:m ==# 'c' | return 'CMD'
	else | return l:m
	endif
endfunction

set laststatus=2
set statusline=
set statusline+=%{ReadMode()}
set statusline+=\ %f
set statusline+=\ %m
set statusline+=%{FugitiveStatusline()}
set statusline+=%=
set statusline+=%{&fileformat}
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %y
set statusline+=\ %p%%
set statusline+=\ %l:%c
