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
	let segments = []

	for param in a:000
		" Lookup modes for this segment/group
		if type(param) == type([]) && param[0] == 'modes'
			let modes = param[1]
		elseif type(a:1) == type([]) && a:1[0] == 'segment'
			call add(segments, param[1])
		endif

		unlet! param
	endfor

	if type(a:1) == type([]) && a:1[0] == 'segment'
		" This is a segment group
		return ['segment_group', {
			\ 'type': 'segment_group',
			\ 'name': name,
			\ 'segments': segments,
			\ 'modes': modes
			\ }]
	else
		" This is a single segment
		let text = a:1

		return ['segment', {
			\ 'type': 'segment',
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

			if ns != '__common__'
				" Prepend segment name with namespace if not in common namespace
				let info.name = ns .':'. info.name
			endif

			let s:segments[ns][info.name] = info
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
function! Pl#Segment#Split() " {{{
	return 'special.split'
endfunction " }}}
function! Pl#Segment#Truncate() " {{{
	return 'special.truncate'
endfunction " }}}
function! Pl#Segment#Get(name) " {{{
	" Return a segment data dict
	let args = []

	" Check for printf segments (lists)
	if type(a:name) == type([])
		" We're dealing with a segment with printf arguments
		let seg_name = a:name[0]
		let args = a:name[1:]
	else
		let seg_name = a:name
	endif

	let seg_name_split = split(seg_name, ':')

	" Handle segment namespacing
	let ns = '__common__'
	let func = seg_name_split[0]

	if len(seg_name_split) > 1
		" The segment is in a namespace ("ns:segment")
		let ns = seg_name_split[0]
		let func = ns .':'. seg_name_split[1]
	endif

	let segment = s:segments[ns][func]

	if len(args)
		" Handle segment printf arguments
		" printf doesn't accept lists as its second argument, so we have to work around that
		let segment.text = call('printf', [ segment.text ] + args)
	endif

	return segment
endfunction " }}}
