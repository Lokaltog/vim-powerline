function! Stl_GetMode() " {{{
	let ret = mode()

	let ret = substitute(ret, '', '^V', 'g')
	let ret = substitute(ret, 'i', 'INS', 'g')

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
let s:cterm2solarized = {
   \  0: 0x073642,
   \  1: 0xdc322f,
   \  2: 0x859900,
   \  3: 0xb58900,
   \  4: 0x268bd2,
   \  5: 0xd33682,
   \  6: 0x2aa198,
   \  7: 0xeee8d5,
   \  8: 0x002b36,
   \  9: 0xcb4b16,
   \ 10: 0x586e75,
   \ 11: 0x657b83,
   \ 12: 0x839496,
   \ 13: 0x6c71c4,
   \ 14: 0x93a1a1,
   \ 15: 0xfdf6e3
\ }
" }}}
function! Pl#Colors#cterm2gui(cterm) " {{{
	if ! has_key(s:cterm2solarized, a:cterm)
		return 0xff0000
	endif

	return s:cterm2solarized[a:cterm]
endfunction " }}}
