let s:colorschemes = Pl#COLORSCHEMES

function! Pl#Colorscheme#Init(name, ...) " {{{
	let s:colorschemes[a:name] = {}

	for param in a:000
		let segment = param[0]
		let mode_hi_dict = param[1]

		let s:colorschemes[a:name][segment] = mode_hi_dict
	endfor

	echoe join(items(s:colorschemes))
endfunction " }}}
function! Pl#Colorscheme#HiSegment(segment, normal, ...) " {{{
	let mode_hi_dict = {
		\ 	'n': a:normal
		\ }

	if a:0 && type(a:1) == type({})
		for [modes, hl] in items(a:1)
			for mode in split(modes, '\zs')
				let mode_hi_dict[mode] = hl
			endfor
		endfor
	endif

	return [a:segment, mode_hi_dict]
endfunction " }}}
