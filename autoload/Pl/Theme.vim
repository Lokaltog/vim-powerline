function! Pl#Theme#Create(colorscheme, ...) " {{{
	return Pl#Colorscheme#Apply(a:colorscheme, copy(a:000))
endfunction " }}}
function! Pl#Theme#BufferSegments(matches, ...) " {{{
	let segments = []

	" Fetch segment data dicts
	for segment_name in a:000
		call add(segments, Pl#Segment#Get(segment_name))

		unlet! segment_name
	endfor

	return {
		\ 	'matches': a:matches,
		\ 	'segments': segments
		\ }
endfunction " }}}
function! Pl#Theme#InsertSegment(theme, segment, where, target_segment) " {{{
endfunction " }}}
function! Pl#Theme#RemoveSegment(theme, segment) " {{{
endfunction " }}}
