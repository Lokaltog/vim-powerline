function! Powerline#Functions#GetMode() " {{{
	let mode = mode()

	if mode =~# '\v(v|V|)'
		" Visual mode
		if mode ==# 'v'
			let mode = ' V '
		elseif mode ==# 'V'
			let mode = 'V·LINE'
		elseif mode ==# ''
			let mode = 'V·BLCK'
		endif
	elseif mode =~# '\vi'
		let mode = 'INS' " Insert mode
	elseif mode =~# '\v(R|Rv)'
		let mode = ' R ' " Replace mode
	else
		" Fallback to normal mode
		let mode = ' N ' " Normal (current)
	endif

	return mode
endfunction " }}}
