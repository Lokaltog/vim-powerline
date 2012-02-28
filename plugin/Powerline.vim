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
" Commands {{{
	command! PowerlineClearCache call Pl#ClearCache()
	command! PowerlineReloadColorscheme call Pl#ReloadColorscheme()
" }}}
" Set default options {{{
	for [s:key, s:value] in items({
		\   'theme'        : 'default'
		\ , 'colorscheme'  : 'default'
		\ , 'symbols'      : 'compatible'
		\ , 'cache_enabled': 1
		\ })

		if ! exists('g:Powerline_' . s:key)
			exec printf('let g:Powerline_%s = %s', s:key, string(s:value))
		endif
	endfor

	if ! exists('g:Powerline_cache_file')
		exec 'let g:Powerline_cache_file = '. string(printf('%s/Powerline_%s_%s_%s.cache'
			\ , simplify(expand('<sfile>:p:h') .'/..')
			\ , g:Powerline_theme
			\ , g:Powerline_colorscheme
			\ , g:Powerline_symbols
			\ ))
	endif
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

		au BufWritePost */autoload/Powerline/Colorschemes/*.vim
			\ :PowerlineReloadColorscheme
	augroup END
" }}}
