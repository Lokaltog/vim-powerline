function! Powerline#Functions#aurum#GetBranch(symbol) " {{{
	let r = aurum#branch()
	return empty(r) ? '' : a:symbol .' '. r
endfunction " }}}
function! Powerline#Functions#aurum#GetStatus() " {{{
	let r = aurum#status()
	return (empty(r) || r is# 'clean') ? '' : toupper(r[0])
endfunction " }}}
