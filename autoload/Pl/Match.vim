function! Pl#Match#Add(pat, expr) " {{{
	return [a:pat, a:expr]
endfunction " }}}
function! Pl#Match#Any(...) " {{{
	" Empty match array matches everything
	let matches = []

	for match_name in a:000
		call add(matches, g:Powerline#Matches#matches[match_name])
	endfor

	return ['match', 'any', matches]
endfunction " }}}
