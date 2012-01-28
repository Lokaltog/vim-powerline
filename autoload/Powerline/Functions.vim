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
	elseif mode =~# '\v(s|S|)'
		" Select mode
		if mode ==# 's'
			let mode = 'SELECT'
		elseif mode ==# 'S'
			let mode = 'S·LINE'
		elseif mode ==# ''
			let mode = 'S·BLOCK'
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
function! Powerline#Functions#GetFilesize() " {{{
	let bytes = getfsize(expand("%:p"))

	if bytes <= 0
		return ''
	endif

	if bytes < 1024
		return bytes . 'B'
	else
		return (bytes / 1024) . 'kB'
	endif
endfunction "}}}
function! Powerline#Functions#GetPwd() "{{{
	let pwd = substitute(getcwd(), expand("$HOME"), "~", "g")

	return pwd
endfunction " }}}
function! Powerline#Functions#GetCharCode() " {{{
	let tmp = @a
	redir @a
	exec ':silent! ascii'
	redir END
	if -1 < match(@a, 'NUL')
		let @a = tmp
		return 'NUL'
	endif
	let info = split(@a, ',\s\+')
	let @a = tmp
	let char = matchstr(info[0], '<\zs.*\ze>')
	let hex = matchstr(info[1], '[0-9a-f]*$')
	return '''' . char . ''' ' . hex
endfunction "}}}
