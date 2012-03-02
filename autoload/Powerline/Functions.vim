" Recalculate the trailing whitespace warning when idle, and after saving
autocmd CursorHold,BufWritePost,InsertLeave * unlet! b:statusline_trailing_space_warning

function! Powerline#Functions#GetFilename() " {{{
	let relpath = expand('%')
	let fullpath = expand('%:p')
	let filename = expand('%:t')
	let noname = '[No Name]'

	if empty(filename)
		return noname
	endif

	if empty(g:Powerline_stl_path_style) || g:Powerline_stl_path_style == 'filename'
		" Display only the file name, similar to the %t statusline item
		return filename
	elseif g:Powerline_stl_path_style == 'short'
		" Display a short path, i.e. "/home/user/foo/bar/baz.vim" becomes
		" "~/f/b/baz.vim"
		let shortpath = substitute(substitute(expand('%:h'), $HOME, '~', 'g'), '\v/(\w)[^/]*', '/\1', 'g')

		return empty(shortpath) || shortpath == '.' ? filename : shortpath .'/' . filename
	elseif g:Powerline_stl_path_style == 'relative'
		" Display a relative path, similar to the %f statusline item
		return substitute(relpath, $HOME, '~', 'g')
	elseif g:Powerline_stl_path_style == 'full'
		" Display the full path, similar to the %F statusline item
		return substitute(fullpath, $HOME, '~', 'g')
	endif

	return 'INVALID FILENAME SETTING: '. g:Powerline_stl_path_style
endfunction " }}}
function! Powerline#Functions#GetShortPath(threshold) " {{{
	let fullpath = split(substitute(expand('%:p:h'), $HOME, '~', 'g'), '/')

	if len(fullpath) > a:threshold
		let fullpath = [fullpath[0], '…'] +  fullpath[-a:threshold + 1 :]
	endif

	return join(fullpath, '/')
endfunction " }}}
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
function! Powerline#Functions#GetWSMarker() " {{{
	" Return '...' if trailing white space is detected
	" Return '' otherwise
	if ! exists("b:statusline_trailing_space_warning")
		if search('\s$', 'nw') != 0
			let b:statusline_trailing_space_warning = ' … '
		else
			let b:statusline_trailing_space_warning = ''
		endif
	endif
	return b:statusline_trailing_space_warning
endfunction " }}}
