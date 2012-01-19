let s:LEFT_SIDE = 0
let s:RIGHT_SIDE = 1

let s:PADDING = 1

let s:EMPTY_SEGMENT = { 'type': 'empty' }

function! Pl#Parser#GetStatusline(segments) " {{{
	let statusline = {
		\ 'n': '',
		\ 'N': '',
		\ 'v': '',
		\ 'i': '',
		\ 'r': ''
		\ }

	" Run through the different modes and create the statuslines
	for mode in keys(statusline)
		" Create an empty statusline list
		let stl = []

		for i in range(0, len(a:segments) - 1)
			unlet! seg_prev seg_curr seg_next

			" Prepare some resources (fetch previous, current and next segment)
			let seg_prev = (i == 0) ? s:EMPTY_SEGMENT : copy(get(a:segments, i - 1))
			let seg_curr = copy(get(a:segments, i))
			let seg_next = (i == (len(a:segments) - 1)) ? s:EMPTY_SEGMENT : copy(get(a:segments, i + 1))

			if index(seg_curr.modes, mode) == -1
				" The segment is invisible in this mode, skip it
				continue
			endif

			call extend(stl, s:ParseSegments(mode, s:LEFT_SIDE, seg_curr))
		endfor

		let statusline[mode] .= join(stl, '')
	endfor

	return statusline
endfunction " }}}
function! s:ParseSegments(mode, side, segment, ...) " {{{
	let mode    = a:mode
	let side    = a:side
	let segment = a:segment

	let level      = exists('a:1') ? a:1 : 0
	let base_color = exists('a:2') ? a:2 : {}

	let ret = []

	" Handle the different segment types
	if segment.type == 'segment'
		if segment.name == 'special.truncate'
			" Truncate statusline
			call add(ret, '%<')
		elseif segment.name == 'special.split'
			" Split statusline

			" Switch sides
			let side = s:RIGHT_SIDE

			" Handle highlighting
			let mode_colors = ! has_key(segment.colors, mode) ? segment.colors['n'] : segment.colors[mode]
			let hl_group = s:HlCreate(mode_colors)

			" Add segment text
			call add(ret, '%#'. hl_group .'#%=')
		else
			" Add segment text
			let text = segment.text

			" Decide on whether to use the group's colors or the segment's colors
			let colors = ! has_key(segment, 'colors') ? base_color : segment.colors

			" Fallback to normal (current) highlighting if we don't have mode-specific highlighting
			let mode_colors = ! has_key(colors, mode) ? colors['n'] : colors[mode]

			" Check if we're in a group (level > 0)
			if level > 0
				" If we're in a group we don't have dividers, so we should only pad one side
				let padding_left  = (side == s:LEFT_SIDE  ? repeat(' ', s:PADDING) : '')
				let padding_right = (side == s:RIGHT_SIDE ? repeat(' ', s:PADDING) : '')

				" Check if we lack a bg/fg color for this segment
				" If we do, use the bg/fg color from base_color
				let base_color_mode = ! has_key(base_color, mode) ? base_color['n'] : base_color[mode]

				for col in ['ctermbg', 'ctermfg', 'guibg', 'guifg']
					if empty(mode_colors[col])
						let mode_colors[col] = base_color_mode[col]
					endif
				endfor
			else
				" If we're outside a group we have dividers and must pad both sides
				let padding_left  = repeat(' ', s:PADDING)
				let padding_right = repeat(' ', s:PADDING)
			endif

			" Get main hl group for segment
			let hl_group = s:HlCreate(mode_colors)

			" Prepare segment text
			let text = '%#'. hl_group .'#%('. padding_left . text . padding_right .'%)'

			call add(ret, text)
		endif
	elseif segment.type == 'segment_group'
		for child_segment in segment.segments
			" Recursively parse segment group
			if ! has_key(segment, 'colors')
				call extend(ret, s:ParseSegments(mode, side, child_segment, level + 1))

				continue
			endif

			" Pass the base colors on to the child segments
			call extend(ret, s:ParseSegments(mode, side, child_segment, level + 1, segment.colors))
		endfor
	endif

	return ret
endfunction " }}}
function! s:HlCreate(hl) " {{{
	" Create a short and unique highlighting group name
	" It uses the hex values of all the color properties and an attribute flag at the end
	" NONE colors are translated to NN for cterm and NNNNNN for gui colors
	let hi_group = printf('Pl%s%s%s%s%s'
		\ , (a:hl['ctermfg'] == 'NONE' ? 'NN'     : printf('%02x', a:hl['ctermfg']))
		\ , (a:hl['guifg']   == 'NONE' ? 'NNNNNN' : printf('%06x', a:hl['guifg']  ))
		\ , (a:hl['ctermbg'] == 'NONE' ? 'NN'     : printf('%02x', a:hl['ctermbg']))
		\ , (a:hl['guibg']   == 'NONE' ? 'NNNNNN' : printf('%06x', a:hl['guibg']  ))
		\ , substitute(a:hl['attr'], '\v([a-zA-Z])[a-zA-Z]*,?', '\1', 'g')
		\ )

	if ! s:HlExists(hi_group)
		" Create the highlighting group
		let hi_cmd = printf('hi %s ctermfg=%s ctermbg=%s cterm=%s guifg=%s guibg=%s gui=%s'
			\ , hi_group
			\ , (a:hl['ctermfg'] == 'NONE' ? 'NONE' : printf('%d', a:hl['ctermfg']))
			\ , (a:hl['ctermbg'] == 'NONE' ? 'NONE' : printf('%d', a:hl['ctermbg']))
			\ , a:hl['attr']
			\ , (a:hl['guifg'] == 'NONE' ? 'NONE' : printf('#%06x', a:hl['guifg']))
			\ , (a:hl['guibg'] == 'NONE' ? 'NONE' : printf('#%06x', a:hl['guibg']))
			\ , a:hl['attr']
			\ )

		exec hi_cmd

		" Add command to Pl#HL list for caching
		call add(g:Pl#HL, hi_cmd)
	endif

	" Return only the highlighting group name
	return hi_group
endfunction " }}}
function! s:HlExists(hl) " {{{
	if ! hlexists(a:hl)
		return 0
	endif

	redir => hlstatus
	silent exec 'hi' a:hl
	redir END

	return (hlstatus !~ 'cleared')
endfunction " }}}
