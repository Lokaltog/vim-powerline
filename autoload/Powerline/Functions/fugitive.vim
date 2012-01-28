function! Powerline#Functions#fugitive#GetBranch(symbol) " {{{
	let ret = fugitive#statusline()

	let ret = substitute(ret, '\v\[?GIT\(([a-z0-9\-_\./:]+)\)\]?', a:symbol .' \1', 'gi')

	return ret
endfunction " }}}
