let s:matches = Pl#MATCHES

function! Pl#Match#Add(name, pat, expr) " {{{
	let s:matches[a:name] = [a:pat, a:expr]
endfunction " }}}
