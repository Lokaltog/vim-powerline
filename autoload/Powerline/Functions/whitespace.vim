"recalculate the trailing whitespace warning when idle, and after saving
autocmd CursorHold,BufWritePost,InsertLeave * unlet! b:statusline_trailing_space_warning

"return '...' if trailing white space is detected
"return '' otherwise
function! Powerline#Functions#whitespace#marker()
	if !exists("b:statusline_trailing_space_warning")
		if search('\s$', 'nw') != 0
			let b:statusline_trailing_space_warning = '… '
		else
			let b:statusline_trailing_space_warning = ''
		endif
	endif
	return b:statusline_trailing_space_warning
endfunction
