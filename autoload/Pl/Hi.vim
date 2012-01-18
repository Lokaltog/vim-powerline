function! Pl#Hi#Create(...) " {{{
	let hi = {
		\ 'cterm': [0, 0],
		\ 'gui'  : [0, 0],
		\ 'attr' : []
		\ }

	" Fetch highlighting details from parameters
	for param in a:000
		" String parameters are always attributes
		if type(param) == type('')
			if tolower(param) == 'none'
				let param = 'NONE'
			endif

			call add(hi['attr'], param)

			continue
		endif

		" Other parameters are either Pl#Hi#Cterm or Pl#Hi#GUI return values (lists)
		let hi[param[0]] = [toupper(param[1]), toupper(param[2])]
	endfor

	" Return formatted highlighting string
	return printf('ctermfg=%s ctermbg=%s cterm=%s guifg=%s guibg=%s gui=%s',
		\ (hi['cterm'][0] == 0 || hi['cterm'][0] == 'NONE' ? 'NONE' : printf('%d', hi['cterm'][0])),
		\ (hi['cterm'][0] == 0 || hi['cterm'][1] == 'NONE' ? 'NONE' : printf('%d', hi['cterm'][1])),
		\ join(hi['attr'], ','),
		\
		\ (hi['gui'][0] == 0 || hi['gui'][0] == 'NONE' ? 'NONE' : printf('#%06x', hi['gui'][0])),
		\ (hi['gui'][0] == 0 || hi['gui'][1] == 'NONE' ? 'NONE' : printf('#%06x', hi['gui'][1])),
		\ join(hi['attr'], ',')
		\ )
endfunction " }}}
function! Pl#Hi#Cterm(fg, ...) " {{{
	return ['cterm', a:fg, (a:0 ? a:1 : 'NONE')]
endfunction " }}}
function! Pl#Hi#GUI(fg, ...) " {{{
	return ['gui', a:fg, (a:0 ? a:1 : 'NONE')]
endfunction " }}}
