function! Powerline#Functions#fugitive#GetBranch() " {{{
	let ret = fugitive#statusline()

	let ret = substitute(ret, 'GIT(\([a-z0-9\-_\./:]\+\))', '$BRANCH \1', 'gi')

	return ret
endfunction " }}}
