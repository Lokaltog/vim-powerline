function! Powerline#Functions#tagbar#GetTag() " {{{
	" Wrapper function that checks if Tagbar is loaded to avoid errors when
	" Tagbar is loaded after Powerline
	let ret = ''

	if exists('g:loaded_tagbar') && g:loaded_tagbar == 1
		let ret = tagbar#currenttag('%s', '')
	endif

	return ret
endfunction " }}}
