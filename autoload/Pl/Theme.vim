function! Pl#Theme#Create(colorscheme, ...) " {{{
	return Pl#Colorscheme#Apply(a:colorscheme, a:000)
endfunction " }}}
function! Pl#Theme#BufferSegments(matches, ...) " {{{
	let segments = []

	let theme = a:000
	let theme = Pl#Mod#UpdateTheme(theme) " Do all actions in Pl#Mod#theme

	" Fetch segment data dicts
	for segment_name in theme
		let segment = Pl#Segment#Get(segment_name)

		call add(segments, segment)

		unlet! segment_name
	endfor

	return {
		\ 	'matches': a:matches,
		\ 	'segments': segments
		\ }
endfunction " }}}
function! Pl#Theme#InsertSegment(new_segment, where, target_segment) " {{{
	" It's very important to NOT refer to the theme dict until everything's loaded!
	"
	" Because these functions are called from the vimrc, we need to put the
	" actions in a list which will be parsed later.
	"
	" These functions don't accept a name parameter, because they work on the
	" currently selected theme (will change any selected theme)
	call add(g:Pl#Mod#theme, {
		\ 'action': 'insert',
		\ 'new_segment': a:new_segment,
		\ 'where': a:where,
		\ 'target_segment': a:target_segment
		\ })
endfunction " }}}
function! Pl#Theme#RemoveSegment(target_segment) " {{{
	" It's very important to NOT refer to the theme dict until everything's loaded!
	"
	" Because these functions are called from the vimrc, we need to put the
	" actions in a list which will be parsed later.
	"
	" These functions don't accept a name parameter, because they work on the
	" currently selected theme (will change any selected theme)
	call add(g:Pl#Mod#theme, {
		\ 'action': 'remove',
		\ 'target_segment': a:target_segment
		\ })
endfunction " }}}
function! Pl#Theme#ReplaceSegment(old_segment, new_segment) " {{{
	call Pl#Theme#InsertSegment(a:new_segment, 'after', a:old_segment)
	call Pl#Theme#RemoveSegment(a:old_segment)
endfunction " }}}
