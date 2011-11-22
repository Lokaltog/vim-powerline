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
	function! s:InitOptions(options) " {{{
		for [key, value] in items(a:options)
			if ! exists('g:Powerline_' . key)
				exec printf('let g:Powerline_%s = %s', key, string(value))
			endif
		endfor
	endfunction " }}}
	call s:InitOptions({
	\   'theme'    : 'distinguished'
	\ , 'symbols'  : 'compatible'
	\ , 'cachefile': '/tmp/Powerline.cache'
	\ })
" }}}
" Autocommands {{{
	augroup Powerline
		autocmd!

		" Initialize when opening vim and re-initialize when changing color scheme
		" Most colorschemes run 'hi clear', so we need to recreate the colors
		au ColorScheme,VimEnter *
			\ call Pl#Load() | call Pl#Powerline('current')

		au BufEnter,BufWinEnter,WinEnter,CmdwinEnter,CursorHold,BufWritePost,InsertLeave *
			\ call Pl#Powerline('current')

		au BufLeave,BufWinLeave,WinLeave,CmdwinLeave *
			\ call Pl#Powerline('noncurrent')

		au InsertEnter,CursorHoldI *
			\ call Pl#Powerline('insert')
	augroup END
" }}}
