" Powerline - The ultimate statusline utility
"
" Author: Kim Silkebækken <kim.silkebaekken+vim@gmail.com>
" Source repository: https://github.com/Lokaltog/vim-powerline
"
" Known issues:
"   * When a boolean segment parameter is false, it messes up both the previous and the next segment highlighting
"   * This bug also affects segments which are hidden in e.g. non-current windows, a possible fix for this is to create a recursive function to parse segments and segment groups
"   * If HiNonCurrent isn't set before a SegmentGroup, vim will barf a million error messages (try removing the fugitive block from distinguished) - possible fix by setting default values for all colors
"   * Spaces must be added manually in each segment, I haven't found a way to reliably add spaces without adding minor bugs like wrong highlighting, weird double text issues, etc.
"   * Because %() is wrapped around a segment, text-only segments won't be rendered unless the text is wrapped in an eval block like this: %{'My static text'}

" Script resources {{{
	let s:dividers = {
		\   'default'   : [ [0x2b80], [0x2b81], [0x2b82], [0x2b83] ]
		\ , 'compatible': [       '', [0x2502],       '', [0x2502] ]
	\ }

	let s:symbols = {
		\ 'default': {
			\   'branch': [0x2b60]
			\ , 'ro'    : [0x2b64]
			\ , 'ft'    : [0x2b62, 0x2b63]
			\ , 'line'  : [0x2b61]
		\ },
		\ 'compatible': {
			\   'branch': 'BR:'
			\ , 'ro'    : 'RO'
			\ , 'ft'    : 'FT'
			\ , 'line'  : 'LN'
		\ }
	\ }

	let s:EMPTY = ['', 0]

	let s:LEFT_SIDE = 0
	let s:RIGHT_SIDE = 2

	let s:HARD_DIVIDER = 0
	let s:SOFT_DIVIDER = 1
" }}}
" Script variables {{{
	let s:hi_groups = {}
	let s:hi_current_group = {}
	let s:statuslines = []
" }}}
" Configuration functions {{{
	function! Pl#InitOptions(options) " {{{
		for [key, value] in items(a:options)
			if ! exists('g:Powerline_' . key)
				exec printf('let g:Powerline_%s = %s', key, string(value))
			endif
		endfor
	endfunction " }}}
" }}}
" Statusline functions {{{
	function! Pl#Statusline(...) " {{{
		let side = s:LEFT_SIDE
		let statuslines = { 'current': '', 'insert': '', 'noncurrent': '' }
		let matches = { 'bufname': [], 'filetype': [] }

		" Prepare segment array for traversing by removing empty segments
		let args = []
		for item in a:000
			if empty(item[0])
				" If the current segment for some reason is false/empty (e.g. if
				" one of the segment conditions is false), skip the entire segment
				continue
			endif

			call add(args, item)
		endfor

		for i in range(0, len(args) - 1)
			unlet! a_prev a_curr a_next

			" Prepare some resources (fetch previous, current and next segment)
			let a_prev = (i == 0) ? s:EMPTY : get(args, i - 1)
			let a_curr = get(args, i)
			let a_next = (i == (len(args) - 1)) ? s:EMPTY : get(args, i + 1)

			" Loop through the different statusline types
			for type in keys(statuslines)
				let add_divider = 1

				" We don't want to add dividers right before or right after the split
				if (a_next[0] == 'segment_split' || a_prev[0] == 'segment_split')
					let add_divider = 0
				endif

				if a_curr[0] == 'segment' " {{{
					" Check if we have highlighting for this type
					if ! has_key(a_curr[2], 'hi_'. type)
						" We don't, skip this segment for this type
						continue
					endif

					" Use soft divider w/ current hi group by default
					let divider_color = a_curr[2]['hi_'. type]
					let divider_type = s:SOFT_DIVIDER

					" Check if we should use a hard divider {{{
						" Fetch current highlighting colors
						let hi_curr = s:hi_groups[a_curr[2]['hi_'. type]]

						if side == s:LEFT_SIDE
							" Compare curr/next highlighting
							let hi_cmp = exists('a_next[2]') && has_key(a_next[2], 'hi_'. type) ? s:hi_groups[a_next[2]['hi_'. type]] : []
						else
							" Compare curr/prev highlighting
							let hi_cmp = exists('a_prev[2]') && has_key(a_prev[2], 'hi_'. type) ? s:hi_groups[a_prev[2]['hi_'. type]] : []
						endif

						if ! empty(hi_cmp)
							" Compare the highlighting groups
							"
							" If the background color for GUI and term is equal, use soft divider with the current segment's highlighting
							" If not, use hard divider with a new highlighting group
							if hi_curr['bg'] != hi_cmp['bg']
								let divider_type = s:HARD_DIVIDER

								" Create new highlighting group
								" Use FG = CURRENT BG, BG = CMP BG
								let divider_color = s:GetHi('hi_'. type, [
									\ Pl#FG(hi_curr['bg']['cterm'], hi_curr['bg']['gui']),
									\ Pl#BG(hi_cmp['bg']['cterm'],  hi_cmp['bg']['gui'])
								\ ])
							endif
						endif

						unlet hi_curr hi_cmp
					" }}}

					" Prepare segment
					let segment = a_curr[1]

					" Add highlighting
					let segment = '%#'. a_curr[2]['hi_'. type] .'#'. segment .''

					if add_divider
						let segment = s:AddDivider(segment, side, divider_color, divider_type)
					endif

					let segment = '%('. segment .'%)'
					" }}}
				elseif a_curr[0] == 'segment_group' " {{{
					" Loop through the segment group
					let segment = ''
					let segment_hi = {'hi_current': '', 'hi_insert': '', 'hi_noncurrent': ''}

					" Prepare group segment array for traversing by removing empty segments
					let group_args = []
					for item in a_curr[1]
						if empty(item[0])
							" If the current segment for some reason is false/empty (e.g. if
							" one of the segment conditions is false), skip the entire segment
							continue
						endif

						call add(group_args, item)
					endfor

					for arg in group_args
						if arg[0] == 'segment'
							" Handle segment HL group/text
							let segment .= '%#'. arg[2]['hi_'. type] .'#%('. arg[1] .'%)'
						else
							let segment_hi[arg[0]] = arg[1]
						endif
					endfor

					" Use soft divider w/ current hi group by default
					let divider_color = segment_hi['hi_'. type]
					let divider_type = s:SOFT_DIVIDER

					" Check if we should use a hard divider {{{
						" Fetch current highlighting colors
						let hi_curr = s:hi_groups[segment_hi['hi_'. type]]

						if side == s:LEFT_SIDE
							" Compare curr/next highlighting
							let hi_cmp = exists('a_next[2]') && has_key(a_next[2], 'hi_'. type) ? s:hi_groups[a_next[2]['hi_'. type]] : []
						else
							" Compare curr/prev highlighting
							let hi_cmp = exists('a_prev[2]') && has_key(a_prev[2], 'hi_'. type) ? s:hi_groups[a_prev[2]['hi_'. type]] : []
						endif

						if ! empty(hi_cmp)
							" Compare the highlighting groups
							"
							" If the background color for GUI and term is equal, use soft divider with the current segment's highlighting
							" If not, use hard divider with a new highlighting group
							if hi_curr['bg'] != hi_cmp['bg']
								let divider_type = s:HARD_DIVIDER

								" Create new highlighting group
								" Use FG = CURRENT BG, BG = CMP BG
								let divider_color = s:GetHi('hi_'. type, [
									\ Pl#FG(hi_curr['bg']['cterm'], hi_curr['bg']['gui']),
									\ Pl#BG(hi_cmp['bg']['cterm'],  hi_cmp['bg']['gui'])
								\ ])
							endif
						endif

						unlet hi_curr hi_cmp
					" }}}

					if add_divider
						let segment = s:AddDivider(segment, side, divider_color, divider_type)
					endif
					" }}}
				elseif a_curr[0] == 'segment_split' " {{{
					" Change divider side
					let side = s:RIGHT_SIDE

					" Add segment text
					let segment = a_curr[1]
					" }}}
				elseif a_curr[0] == 'match' " {{{
					" Handle match parameters
					" These should simply be added to the return array and be handled in s:Powerline()
					call add(matches[a_curr[1]], a_curr[2])

					continue
					" }}}
				endif

				" Append segment to statusline
				let statuslines[type] .= segment
			endfor
		endfor

		call add(s:statuslines, {
			\ 'match': matches,
			\ 'modes': statuslines
		\ })
	endfunction " }}}
	function! Pl#MatchBufname(re) " {{{
		return ['match', 'bufname', a:re]
	endfunction " }}}
	function! Pl#MatchFiletype(re) " {{{
		return ['match', 'filetype', a:re]
	endfunction " }}}
	function! Pl#Segment(text, ...) " {{{
		let text = a:text
		let hi = {}

		" Handle optional arguments (colors and conditions)
		" Arguments can either be a highlighting array or a boolean (0/1)
		for arg in a:000
			if type(arg) == type(0)
				" Boolean argument
				if ! arg
					" The argument is false, return empty segment
					return s:EMPTY
				endif
			elseif type(arg) == type([])
				" Color argument
				let hi[arg[0]] = arg[1]
			else
				" Unknown argument
				return s:EMPTY
			endif

			unlet arg
		endfor

		" Search/replace symbols
		for [key, symbol] in items(s:symbols[g:Powerline_dividers])
			let text = substitute(
				\ text,
				\ '\v\$('. key .')',
				\ '\=s:ParseChars(s:symbols[g:Powerline_dividers][submatch(1)])',
				\ 'g')
		endfor

		return ['segment', text, hi]
	endfunction " }}}
	function! Pl#SegmentGroup(...) " {{{
		" Return the plain segment group, this will be dealt with in Pl#Statusline
		return ['segment_group', a:000]
	endfunction " }}}
	function! Pl#Split() " {{{
		return ['segment_split', '%=']
	endfunction " }}}
	function! Pl#FG(cterm, gui) " {{{
		let color = { 'cterm': a:cterm, 'gui': a:gui }

		return ['fg', color]
	endfunction " }}}
	function! Pl#BG(cterm, gui) " {{{
		let color = { 'cterm': a:cterm, 'gui': a:gui }

		return ['bg', color]
	endfunction " }}}
	function! Pl#Attr(...) " {{{
		return ['attr', sort(copy(a:000))]
	endfunction " }}}
	function! Pl#HiCurrent(...) " {{{
		let hi = s:GetHi('hi_current', a:000)
		let s:hi_current_group['hi_current'] = s:hi_groups[hi]

		return ['hi_current', hi]
	endfunction " }}}
	function! Pl#HiInsert(...) " {{{
		let hi = s:GetHi('hi_insert', a:000)
		let s:hi_current_group['hi_insert'] = s:hi_groups[hi]

		return ['hi_insert', hi]
	endfunction " }}}
	function! Pl#HiNonCurrent(...) " {{{
		let hi = s:GetHi('hi_noncurrent', a:000)
		let s:hi_current_group['hi_noncurrent'] = s:hi_groups[hi]

		return ['hi_noncurrent', hi]
	endfunction " }}}
" }}}
" Internal functions {{{
	function! s:GetHi(type, args) " {{{
		let hi = { 'fg': [], 'bg': [], 'attr': [] }

		" Store our arguments
		for arg in a:args
			if ! has_key(hi, arg[0])
				" Invalid argument
				continue
			endif

			let hi[arg[0]] = arg[1]
		endfor

		" Make sure that we have both FG and BG colors
		" Falls back to the current active FG/BG color if the color isn't passed to this function
		if ! len(hi['fg'])
			let hi['fg'] = s:hi_current_group[a:type]['fg']
		endif

		if ! len(hi['bg'])
			let hi['bg'] = s:hi_current_group[a:type]['bg']
		endif

		" Make sure that we have properly formatted attributes
		if ! len(hi['attr'])
			let hi['attr'] = 'NONE'
		else
			let hi['attr'] = join(hi['attr'], ',')
		endif

		" Return the finished highlighting group name
		return s:GetHiGroup(hi)
	endfunction " }}}
	function! s:GetHiGroup(hi) " {{{
		let fg   = a:hi['fg']
		let bg   = a:hi['bg']
		let attr = a:hi['attr']

		" Calculate checksum for this highlighting group
		" We do this to get a safe and shorter but still unique group name
		let key = printf('%02x%06x%02x%06x%s'
			\ , fg['cterm']
			\ , fg['gui']
			\ , bg['cterm']
			\ , bg['gui']
			\ , substitute(attr, '\v([a-zA-Z])[a-zA-Z]*,?', '\1', 'g')
			\ )

		let hi_group = 'Pl'. key

		if ! hlexists(hi_group) || ! has_key(s:hi_groups, hi_group)
			" Create the highlighting group
			exec printf('hi %s ctermfg=%03d ctermbg=%03d cterm=%s guifg=#%06x guibg=#%06x gui=%s'
				\ , hi_group
				\ , fg['cterm']
				\ , bg['cterm']
				\ , attr
				\ , fg['gui']
				\ , bg['gui']
				\ , attr
				\ )

			" Store the raw highlighting information in a global script variable
			" This will be used in s:GetHiCurrent()
			let s:hi_groups[hi_group] = a:hi
		endif

		" Return only the highlighting group name
		return hi_group
	endfunction " }}}
	function! s:AddDivider(text, side, color, ...) " {{{
		" Adds divider symbol to text
		let divider_type = a:1

		" Fetch and parse divider symbol
		let divider_raw = copy(s:dividers[g:Powerline_dividers][a:side + divider_type])
		let divider = s:ParseChars(divider_raw)

		if a:side == s:LEFT_SIDE
			" Left side
			" Divider to the right
			return printf('%s%%#%s#%s', a:text, a:color, divider)
		else
			" Right side
			" Divider to the left
			return printf('%%#%s#%s%s', a:color, divider, a:text)
		endif
	endfunction " }}}
	function! s:ParseChars(arg) " {{{
		" Handles symbol arrays which can be either an array of hex values,
		" or a string. Will convert the hex array to a string, or return the
		" string as-is.
		let arg = copy(a:arg)

		if type(arg) == type([])
			" Hex array
			call map(arg, 'nr2char(v:val)')

			return join(arg, '')
		endif

		" Anything else, just return it as it is
		return arg
	endfunction " }}}
" }}}
" Initialize script {{{
	function! Pl#Load()
		for path in split(globpath(&rtp, 'powerline/'. g:Powerline_theme .'/*', 1))
			exec 'source' path
		endfor
	endfunction
" }}}
" Create autocommands {{{
	function! s:Powerline(mode) " {{{
		" Update the local statusline
		for statusline in s:statuslines
			let valid = 1

			for re in statusline['match']['bufname']
				" Check if the statusline matches the buffer name
				if match(bufname('%'), '\v'.re) == -1
					let valid = 0

					break
				endif
			endfor

			for re in statusline['match']['filetype']
				" Check if the statusline matches the filetype
				if match(&ft, '\v'.re) == -1
					let valid = 0

					break
				endif
			endfor

			if valid
				let &l:statusline = statusline['modes'][a:mode]
			endif
		endfor
	endfunction " }}}
	augroup Powerline
		autocmd!

		" Re-initialize when changing color scheme
		" Most colorschemes run 'hi clear', so we need to recreate the colors
		au ColorScheme *
			\ call Pl#Load()

		au BufEnter,BufWinEnter,WinEnter,CmdwinEnter,CursorHold,BufWritePost,InsertLeave *
			\ call s:Powerline('current')

		au BufLeave,BufWinLeave,WinLeave,CmdwinLeave *
			\ call s:Powerline('noncurrent')

		au InsertEnter,CursorHoldI *
			\ call s:Powerline('insert')
	augroup END
" }}}
