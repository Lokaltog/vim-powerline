let s:matches = Pl#MATCHES

function! Pl#Match#Add(name, pat, expr) " {{{
	let s:matches[a:name] = [a:pat, a:expr]
endfunction " }}}
function! Pl#Match#Any(...) " {{{
	" Empty match array matches everything
	let matches = []

	for match_name in a:000
		call add(matches, s:matches[match_name])
	endfor

	return ['match', 'any', matches]
endfunction " }}}
