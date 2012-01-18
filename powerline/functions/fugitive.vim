function! Pl_Fugitive_GetBranch(branch_symbol) " {{{
	let ret = fugitive#statusline()

	let ret = substitute(ret, 'GIT(\([a-z0-9\-_\./:]\+\))', ' '. a:branch_symbol .' \1 ', 'gi')

	return ret
endfunction " }}}

