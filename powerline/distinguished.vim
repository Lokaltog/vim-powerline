function! Stl_GetMode() " {{{
	let ret = mode()

	let ret = substitute(ret, '', '^V', 'g')

	return ret
endfunction " }}}
function! Stl_GetBranch(branch_symbol) " {{{
	let ret = fugitive#statusline()

	let ret = substitute(ret, 'GIT(\([a-z0-9\-_\./:]\+\))', ' '. a:branch_symbol .' \1 ', 'gi')

	return ret
endfunction " }}}
function! Stl_GetSyntaxErrors(line_symbol) " {{{
	if ! exists('g:syntastic_stl_format')
		" Syntastic hasn't been loaded yet
		return ''
	endif

	" Temporarily change syntastic output format
	let old_stl_format = g:syntastic_stl_format
	let g:syntastic_stl_format = '╱╱╱%E{ ERRORS (%e) '. a:line_symbol .' %fe }%W{ WARNINGS (%w) '. a:line_symbol .' %fw }╱╱╱'

	let ret = SyntasticStatuslineFlag()

	let g:syntastic_stl_format = old_stl_format

	return ret
endfunction " }}}
function! Stl_GetCurrentFunction() " {{{
	return cfi#format(' %s', '')
endfunction " }}}
function! Stl_GetCommandTLine() " {{{
	let line = getline('.')

	" Trim whitespace from current line
	let line = substitute(line, '\v^\>\s+|\s+$', '', 'g')

	return line
endfunction " }}}
function! Stl_GetManPage() " {{{
	let matches = matchlist(getline(1), '\v^([a-zA-Z_\.\-]+)\((\d+)\)')

	if ! len(matches)
		return 'n/a'
	endif

	let file = tolower(matches[1])
	let num = matches[2]

	return file
endfunction " }}}
