let g:Pl#Mod#theme = []

function! Pl#Mod#UpdateTheme(theme) " {{{
	let theme = deepcopy(a:theme)

	for mod in g:Pl#Mod#theme
		" We have to loop through instead of using index() because some
		" segments are lists!
		let target_seg_idx = -1

		for i in range(0, len(theme) - 1)
			unlet! segment
			let segment = theme[i]

			if type(segment) == type(mod.target_segment) && segment == mod.target_segment
				let target_seg_idx = i
				break
			endif
		endfor

		if mod.action == 'insert'
			" Insert segment
			if target_seg_idx != -1
				call insert(theme, mod.new_segment, (mod.where == 'before' ? target_seg_idx : target_seg_idx + 1))
			endif
		elseif mod.action == 'remove'
			" Remove segment
			if target_seg_idx != -1
				call remove(theme, target_seg_idx)
			endif
		endif
	endfor

	return theme
endfunction " }}}
