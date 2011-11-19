" Powerline - The ultimate statusline utility
"
" Author: Kim Silkebækken <kim.silkebaekken+vim@gmail.com>
" Source repository: https://github.com/Lokaltog/vim-powerline

" Script initialization {{{
	if exists('g:Powerline_loaded') || &compatible || version < 702
		finish
	endif

	let g:Powerline_loaded = 1
" }}}
" Set default options {{{
	call Pl#InitOptions({
	\   'theme'    : 'distinguished'
	\ , 'dividers' : 'compatible'
	\ , 'cachefile': '/tmp/Powerline.cache'
	\ })
" }}}
" Load statuslines {{{
	call Pl#Load()
" }}}
