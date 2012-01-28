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
	" Get the output of :ascii
	redir => ascii
	silent! ascii
	redir END

	if match(ascii, 'NUL') != -1
		return 'NUL'
	endif

	" Zero pad hex values
	let nrformat = '0x%02x'

	let encoding = (&fenc == '' ? &enc : &fenc)

	if encoding == 'utf-8'
		" Zero pad with 4 zeroes in unicode files
		let nrformat = '0x%04x'
	endif

	" Get the character and the numeric value from the return value of :ascii
	" This matches the two first pieces of the return value, e.g.
	" "<F>  70" => char: 'F', nr: '70'
	let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

	" Format the numeric value
	let nr = printf(nrformat, nr)

	return "'". char ."' ". nr
endfunction "}}}
