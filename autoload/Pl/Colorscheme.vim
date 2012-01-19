function! Pl#Colorscheme#Init(...) " {{{
	let colorscheme = {}

	for param in a:000
		let segment = param[0]
		let mode_hi_dict = param[1]

		let colorscheme[segment] = mode_hi_dict
	endfor

	return colorscheme
endfunction " }}}
function! Pl#Colorscheme#Apply(colorscheme, buffer_segments) " {{{
	" Set color parameters for all segments in a:buffer_segments
	let colorscheme = g:Powerline#Colorschemes#{a:colorscheme}#colorscheme
	let buffer_segments = copy(a:buffer_segments)

	" This is a bit complex, I'll walk you through exactly what happens here...
	"
	" First of all we loop through the buffer_segments, which are the segments that
	" this specific buffer will have.
	for buffer_segment in buffer_segments
		" The buffer_segment consists of a 'matches' list and a 'segments' list.
		" The 'matches' list has conditions to limit this statusline to specific buffers/windows.
		" The 'segments' list has each segment and segment group for this buffer
		for segment in buffer_segment.segments
			let type = get(segment, 'type', '')

			if type == 'segment_group'
				" We're going to handle segment groups different from single segments. Segment groups
				" have child segments which may have their own highlighting (e.g. fileinfo.flags),
				" and these child segments may be grouped (e.g. fileinfo.flags.ro) to provide very
				" specific highlighting. So here we'll handle all that:

				" Apply colors to the entire segment group
				if has_key(colorscheme, segment.name)
					let segment.colors = colorscheme[segment.name]
				endif

				" Apply colors to each child segment
				for child_segment in segment.segments
					" Check if this child segment is grouped (e.g. fileinfo.flags.group.subgroup)
					" We're going to prioritize the most specific grouping and then work back to the
					" most common group (e.g. fileinfo.flags)
					let child_segment_name_split = split(child_segment.name, '\.')

					for i in range(len(child_segment_name_split) - 1, 0, -1)
						let child_segment_name = segment.name .'.'. join(child_segment_name_split[0:i], '.')

						if has_key(colorscheme, child_segment_name)
							" Add the specific colors to the child segment
							let child_segment.colors = colorscheme[child_segment_name]
						endif
					endfor
				endfor
			elseif type == 'segment'
				" TODO Handle namespaced highlighting groups, e.g. 'help:scrollpercent' should
				" try that highlighting group and fallback to scrollpercent

				" Apply colors to a single segment
				if has_key(colorscheme, segment.name)
					let segment.colors = colorscheme[segment.name]
				endif
			endif

			unlet! segment
		endfor
	endfor

	" Good luck parsing this return value
	"
	" It's a huge dict with all segments for all buffers with their respective syntax highlighting.
	" It will be parsed by the main Powerline code, where all the data will be shortened to a simple
	" array consiting of a statusline for each mode, with generated highlighting groups and dividers.
	return buffer_segments
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
