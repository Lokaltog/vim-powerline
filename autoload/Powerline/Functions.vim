function! Powerline#Functions#GetMode() " {{{
	let mode = mode()

	if mode =~# '\v(v|V|)'
		" Visual mode
		if mode ==# 'v'
			let mode = 'VISUAL'
		elseif mode ==# 'V'
			let mode = 'V·LINE'
		elseif mode ==# ''
			let mode = 'V·BLOCK'
		endif
	elseif mode =~# '\vi'
		let mode = 'INSERT' " Insert mode
	elseif mode =~# '\v(R|Rv)'
		let mode = 'REPLACE' " Replace mode
	else
		" Fallback to normal mode
		let mode = ' N ' " Normal (current)
	endif

	return mode
endfunction " }}}
