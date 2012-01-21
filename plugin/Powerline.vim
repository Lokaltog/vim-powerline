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
	for [key, value] in items({
		\   'theme'        : 'distinguished'
		\ , 'colorscheme'  : 'distinguished'
		\ , 'symbols'      : 'compatible'
		\ , 'cache_file'   : (exists('$TEMP') && ! empty($TEMP) ? $TEMP : '/tmp') . '/Powerline.cache'
		\ , 'cache_enabled': 1
		\ })

		if ! exists('g:Powerline_' . key)
			exec printf('let g:Powerline_%s = %s', key, string(value))
		endif
	endfor
" }}}
" Autocommands {{{
	augroup Powerline
		autocmd!

		" Reload statuslines when changing color scheme
		au ColorScheme *
			\ call Pl#Load()

		au BufEnter,WinEnter,FileType,BufUnload *
			\ call Pl#UpdateStatusline(1)

		au BufLeave,WinLeave *
			\ call Pl#UpdateStatusline(0)
	augroup END
" }}}
