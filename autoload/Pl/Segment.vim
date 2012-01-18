let s:segments = Pl#SEGMENTS
let s:default_modes = ['n', 'N', 'v', 'i', 'r']

function! s:CheckConditions(params) " {{{
	" Check conditions for a segment/group
	" Integer parameters are always conditions
	for param in a:params
		if type(param) == type(0) && param == 0
			" Break here if it's an integer parameter and it's false (0)
			return 0
		endif
		unlet! param
	endfor

	return 1
endfunction " }}}
function! Pl#Segment#Create(name, ...) " {{{
	" Check condition parameters
	if ! s:CheckConditions(a:000)
		return
	endif

	let name = a:name

	let modes = s:default_modes
	for param in a:000
		" Lookup modes for this segment/group
		if type(param) == type([]) && param[0] == 'modes'
			let modes = param[1]

			break
		endif

		unlet! param
	endfor

	if type(a:1) == type([]) && a:1[0] == 'segment'
		" This is a segment group
		return ['segment_group', {
			\ 'name': name,
			\ 'segments': a:000,
			\ 'modes': modes
			\ }]
	else
		" This is a single segment
		let text = a:1

		return ['segment', {
			\ 'name': name,
			\ 'text': text,
			\ 'modes': modes
			\ }]
	endif

endfunction " }}}
function! Pl#Segment#Init(...) " {{{
	" Check condition parameters
	if ! s:CheckConditions(a:000)
		return
	endif

	let ns = '__common__'

	if type(a:1) == type('')
		" Set namespace
		let ns = a:1
	endif

	let s:segments[ns] = {}

	for param in a:000
		if type(param) == type([])
			" Info dict is key 1 in segment/groups
			let info = param[1]

			if param[0] == 'segment_group'
				" Segment group
				let s:segments[ns][info.name] = {}

				for segment in info.segments
					let s:segments[ns][info.name][segment[1].name] = segment[1]
				endfor
			elseif param[0] == 'segment'
				" Single segment
				let s:segments[ns][info.name] = param[1]
			endif
		endif

		unlet! param
	endfor
endfunction " }}}
function! Pl#Segment#Modes(modes) " {{{
	" Handle modes for both segments and groups
	let modes = split(copy(a:modes), '\zs')

	if modes[0] == '!'
		" Filter modes (e.g. "!nr" will ignore the segment in normal and replace modes)
		let modes = filter(copy(s:default_modes), 'v:val !~# "['. join(modes[1:]) .']"')
	endif

	return ['modes', modes]
endfunction " }}}
