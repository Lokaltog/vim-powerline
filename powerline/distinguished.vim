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
	let g:syntastic_stl_format = '╱╱╱%E{ ERRORS (%e) '. a:line_symbol .' %fe }%W{ WARNINGS (%w) '. a:line_symbol .' %fw }╱╱╱ '

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
" Handle Ctrl-P statuslines {{{
if exists('g:loaded_ctrlp') && g:loaded_ctrlp
	let g:ctrlp_status_func = {
		\ 'main': 'CtrlP_Statusline_Main',
		\ 'prog': 'CtrlP_Statusline_Prog'
		\ }

	function! CtrlP_Statusline_Main(...) " {{{
		let stl = Pl#GetStoredStatusline('ctrlp_main')['current']

		let regex = a:3 ? '  RE ' : ''
		let marked = strpart(a:7, 2, len(a:7) - 3)

		let substitutes = {
			\ 'focus'  : a:1,
			\ 'byfname': a:2,
			\ 'regex'  : regex,
			\ 'prev'   : a:4,
			\ 'item'   : a:5,
			\ 'next'   : a:6,
			\ 'marked' : (marked == '+' ? '' : ' ' . marked . ' ')
			\ }

		for [k, v] in items(substitutes)
			let stl = substitute(stl, '\v\%' . toupper(k), v, 'g')
		endfor

		return stl
	endfunction " }}}
	function! CtrlP_Statusline_Prog(...) " {{{
		let stl = Pl#GetStoredStatusline('ctrlp_prog')['current']

		let substitutes = {
			\ 'len'  : a:1
			\ }

		for [k, v] in items(substitutes)
			let stl = substitute(stl, '\v\%' . toupper(k), v, 'g')
		endfor

		return stl
	endfunction " }}}
endif
" }}}
