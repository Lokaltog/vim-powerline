" Powerline - The ultimate statusline utility
"
" Author: Kim Silkebækken <kim.silkebaekken+vim@gmail.com>
" Source repository: https://github.com/Lokaltog/vim-powerline

" Script resources {{{
	let s:symbols = {
		\ 'compatible': {
			\   'dividers': [ '', [0x2502], '', [0x2502] ]
			\ , 'symbols' : {
				\   'branch': 'BR:'
				\ , 'ro'    : 'RO'
				\ , 'ft'    : 'FT'
				\ , 'line'  : 'LN'
			\ }
		\ },
		\ 'unicode': {
			\   'dividers': [ [0x25b6], [0x276f], [0x25c0], [0x276e]  ]
			\ , 'symbols' : {
				\   'branch'  : [0x26a1]
				\ , 'ro'      : [0x2613]
				\ , 'ft'      : [0x2691]
				\ , 'line'    : [0x204b]
			\ },
		\ },
		\ 'fancy': {
			\   'dividers': [ [0x2b80], [0x2b81], [0x2b82], [0x2b83] ]
			\ , 'symbols' : {
				\   'branch'  : [0x2b60]
				\ , 'ro'      : [0x2b64]
				\ , 'ft'      : [0x2b62, 0x2b63]
				\ , 'line'    : [0x2b61]
			\ }
		\ }
	\ }

	let s:EMPTY = ['', 0]
	let s:HI_FALLBACK = { 'cterm': 0, 'gui': 0x000000 }
	let s:MODES = { 'current': '', 'insert': '', 'noncurrent': '' }

	let s:LEFT_SIDE = 0
	let s:RIGHT_SIDE = 2

	let s:HARD_DIVIDER = 0
	let s:SOFT_DIVIDER = 1

	" Cache revision, this must be incremented whenever the cache format is changed
	let s:CACHE_REVISION = 1
" }}}
" Script variables {{{
	let s:hi_groups = {}
	let s:hi_current_group = {}
	let s:hi_cmds = []

	let s:match_statuslines = []
	let s:stored_statuslines = {}
" }}}
" Statusline functions {{{
	function! Pl#Statusline(...) " {{{
		let modes = copy(s:MODES)

		for mode in keys(modes)
			let matches = []

			let [segment, hi_curr, matches] = s:GroupHandler(mode, a:000, s:LEFT_SIDE, [])

			let modes[mode] = segment
		endfor

		call add(s:match_statuslines, {
			\ 'matches': matches,
			\ 'modes': modes
		\ })
	endfunction " }}}
	function! Pl#StoreStatusline(key, ...) " {{{
		let modes = copy(s:MODES)

		for mode in keys(modes)
			let matches = []

			let [segment, hi_curr, matches] = s:GroupHandler(mode, a:000, s:LEFT_SIDE, [])

			let modes[mode] = segment
		endfor

		let s:stored_statuslines[a:key] = modes
	endfunction " }}}
	function! Pl#Match(expr, re) " {{{
		return ['match', a:expr, a:re]
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
		for [key, symbol] in items(s:symbols[g:Powerline_symbols].symbols)
			let text = substitute(
				\ text,
				\ '\v\$('. key .')',
				\ '\=s:ParseChars(s:symbols[g:Powerline_symbols].symbols[submatch(1)])',
				\ 'g')
		endfor

		return ['segment', text, hi]
	endfunction " }}}
	function! Pl#SegmentGroup(...) " {{{
		let segments = []
		let hi = {}

		" Handle arguments (colors and segments)
		for arg in a:000
			if arg[0] == 'segment' || arg[0] == 'segment_group'
				" Add segment
				call add(segments, arg)
			elseif arg != s:EMPTY
				" Add highlighting
				let hi[arg[0]] = arg[1]
			endif
		endfor

		return ['segment_group', segments, hi]
	endfunction " }}}
	function! Pl#Split(...) " {{{
		let hi = {}

		" Handle arguments (colors)
		for arg in a:000
			if arg != s:EMPTY
				" Add highlighting
				let hi[arg[0]] = arg[1]
			endif
		endfor

		return ['segment_split', '%=', hi]
	endfunction " }}}
	function! Pl#FG(cterm, ...) " {{{
		if a:0 && a:1
			let gui = a:1
		else
			let gui = Pl#Colors#cterm2gui(a:cterm)
		endif

		let color = { 'cterm': toupper(a:cterm), 'gui': toupper(gui) }

		return ['fg', color]
	endfunction " }}}
	function! Pl#BG(cterm, ...) " {{{
		if a:0 && a:1
			let gui = a:1
		else
			let gui = Pl#Colors#cterm2gui(a:cterm)
		endif

		let color = { 'cterm': toupper(a:cterm), 'gui': toupper(gui) }

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
	function! s:GroupHandler(type, args, side, matches, ...) " {{{
		" Recursive function for handling segment groups
		let side = a:side
		let ret = ''
		let args = []
		let level = a:0 ? a:1 : 0
		let matches = a:matches

		let hi_group = 'hi_'. a:type
		let hi_curr = {}

		" Remove empty and invalid segments from argument array
		for i in range(0, len(a:args) - 1)
			let item = a:args[i]

			if empty(item[0])
				" If the current segment for some reason is false/empty (e.g. if
				" one of the segment conditions is false), skip the entire segment
				continue
			endif

			if item[0] == 'segment' && ! has_key(item[2], hi_group)
				" If this segment is missing highlighting for this type,
				" skip the entire segment (e.g. if HiNonCurrent is missing)
				continue
			endif

			call add(args, item)
		endfor

		for i in range(0, len(args) - 1)
			unlet! a_prev a_curr a_next

			" Prepare some resources (fetch previous, current and next segment)
			let a_prev = (i == 0) ? s:EMPTY : copy(get(args, i - 1))
			let a_curr = copy(get(args, i))
			let a_next = (i == (len(args) - 1)) ? s:EMPTY : copy(get(args, i + 1))

			let add_divider = 1

			" If we're in a segment group (level > 0), don't add dividers
			if level && a_next[0] != 'segment_group' && a_prev[0] != 'segment_group'
				let add_divider = 0
			endif

			" Render segment groups as segments, and handle them as segments in the next if block
			if a_curr[0] == 'segment_group'
				let [segment, hi_curr, matches] = s:GroupHandler(a:type, a_curr[1], side, matches, level + 1)

				let a_curr[0] = 'segment'
				let a_curr[1] = segment
			endif

			" Handle the different argument types
			if a_curr[0] == 'segment' " {{{
				" Use soft divider w/ current hi group by default
				let divider_color = a_curr[2][hi_group]
				let divider_type = s:SOFT_DIVIDER

				" Check if we should use a hard divider {{{
					" Fetch current highlighting colors
					unlet! hi_curr hi_cmp

					let hi_curr = s:hi_groups[a_curr[2][hi_group]]

					if side == s:LEFT_SIDE
						" Compare curr/next highlighting
						let hi_cmp = exists('a_next[2]') && has_key(a_next[2], hi_group) ? s:hi_groups[a_next[2][hi_group]] : []
					else
						" Compare curr/prev highlighting
						let hi_cmp = exists('a_prev[2]') && has_key(a_prev[2], hi_group) ? s:hi_groups[a_prev[2][hi_group]] : []
					endif

					if ! empty(hi_cmp)
						" Compare the highlighting groups
						"
						" If the background color for GUI and term is equal, use soft divider with the current segment's highlighting
						" If not, use hard divider with a new highlighting group
						"
						" Note that if the previous/next segment is the split, a hard divider is always used
						if hi_curr['bg'] != hi_cmp['bg'] || (a_next[0] == 'segment_split' || a_prev[0] == 'segment_split')
							let divider_type = s:HARD_DIVIDER

							" Create new highlighting group
							" Use FG = CURRENT BG, BG = CMP BG
							let divider_color = s:GetHi(hi_group, [
								\ Pl#FG(hi_curr['bg']['cterm'], hi_curr['bg']['gui']),
								\ Pl#BG(hi_cmp['bg']['cterm'],  hi_cmp['bg']['gui'])
							\ ])
						endif
					endif
				" }}}

				" Prepare segment
				let segment = a_curr[1]

				" Add highlighting
				let segment = '%#'. a_curr[2][hi_group] .'#'. segment

				if add_divider
					let segment = s:AddDivider(segment, side, divider_color, divider_type)
				endif

				let segment = '%('. segment .'%)'
				" }}}
			elseif a_curr[0] == 'segment_split' " {{{
				" Change divider side
				let side = s:RIGHT_SIDE

				" Add segment text
				let segment = a_curr[1]
				" }}}
			elseif a_curr[0] == 'match' " {{{
				" Handle match parameters
				call add(matches, [a_curr[1], a_curr[2]])

				continue
				" }}}
			endif

			" Append segment to statusline
			let ret .= segment
		endfor

		" Return an empty statusline if we're missing all highlighting for this mode
		if empty(hi_curr)
			let ret = ''
		endif

		return [ret, hi_curr, matches]
	endfunction " }}}
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
			let hi['fg'] = has_key(s:hi_current_group, a:type) ? s:hi_current_group[a:type]['fg'] : s:HI_FALLBACK
		endif

		if ! len(hi['bg'])
			let hi['bg'] = has_key(s:hi_current_group, a:type) ? s:hi_current_group[a:type]['bg'] : s:HI_FALLBACK
		endif

		" Make sure that we have properly formatted attributes
		if ! len(hi['attr'])
			let hi['attr'] = 'NONE'
		else
			let hi['attr'] = join(hi['attr'], ',')
		endif

		" Return the finished highlighting group name
		return s:CreateHiGroup(hi)
	endfunction " }}}
	function! s:CreateHiGroup(hi) " {{{
		let fg   = a:hi['fg']
		let bg   = a:hi['bg']
		let attr = a:hi['attr']

		" Create a short and unique highlighting group name
		" It uses the hex values of all the color properties and an attribute flag at the end
		" NONE colors are translated to NN for cterm and NNNNNN for gui colors
		let hi_group = printf('Pl%s%s%s%s%s'
			\ , (fg['cterm'] == 'NONE' ? 'NN'     : printf('%02x', fg['cterm']))
			\ , (fg['gui']   == 'NONE' ? 'NNNNNN' : printf('%06x', fg['gui']  ))
			\ , (bg['cterm'] == 'NONE' ? 'NN'     : printf('%02x', bg['cterm']))
			\ , (bg['gui']   == 'NONE' ? 'NNNNNN' : printf('%06x', bg['gui']  ))
			\ , substitute(attr, '\v([a-zA-Z])[a-zA-Z]*,?', '\1', 'g')
			\ )

		if ! s:HlExists(hi_group) || ! has_key(s:hi_groups, hi_group)
			" Create the highlighting group
			let hi_cmd = printf('hi %s ctermfg=%s ctermbg=%s cterm=%s guifg=%s guibg=%s gui=%s'
				\ , hi_group
				\ , (fg['cterm'] == 'NONE' ? 'NONE' : printf('%d', fg['cterm']))
				\ , (bg['cterm'] == 'NONE' ? 'NONE' : printf('%d', bg['cterm']))
				\ , attr
				\ , (fg['gui'] == 'NONE' ? 'NONE' : printf('#%06x', fg['gui']))
				\ , (bg['gui'] == 'NONE' ? 'NONE' : printf('#%06x', bg['gui']))
				\ , attr
				\ )

			exec hi_cmd

			" Add command to hi_cmds array for caching
			call add(s:hi_cmds, hi_cmd)

			" Store the raw highlighting information in a global script variable
			" This will be used in s:GetHiCurrent()
			let s:hi_groups[hi_group] = a:hi
		endif

		" Return only the highlighting group name
		return hi_group
	endfunction " }}}
	function! s:HlExists(hl) " {{{
		if ! hlexists(a:hl)
			return 0
		endif

		redir => hlstatus
		silent exec 'hi' a:hl
		redir END

		return (hlstatus !~ 'cleared')
	endfunction " }}}
	function! s:AddDivider(text, side, color, ...) " {{{
		" Adds divider symbol to text
		let divider_type = a:1

		" Fetch and parse divider symbol
		let divider_raw = copy(s:symbols[g:Powerline_symbols].dividers[a:side + divider_type])
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
" Script initialization {{{
	function! Pl#LoadCached() " {{{
		if filereadable(g:Powerline_cache_file)
			exec 'source' escape(g:Powerline_cache_file, ' \')

			if ! exists('g:Powerline_cache_revision') || g:Powerline_cache_revision != s:CACHE_REVISION
				" Cache revision differs, force statusline reloading
				unlet! g:Powerline_cache_revision
				     \ g:Powerline_match_statuslines
				     \ g:Powerline_stored_statuslines
				     \ g:Powerline_hi_cmds

				return 0
			endif

			" Create highlighting groups
			for hi_cmd in g:Powerline_hi_cmds
				exec hi_cmd
			endfor

			" Assign statuslines
			let s:match_statuslines  = g:Powerline_match_statuslines
			let s:stored_statuslines = g:Powerline_stored_statuslines

			unlet! g:Powerline_cache_revision
			     \ g:Powerline_match_statuslines
			     \ g:Powerline_stored_statuslines
			     \ g:Powerline_hi_cmds

			return 1
		endif

		return 0
	endfunction " }}}
	function! Pl#Load(...) " {{{
		if a:0 && a:1 == 1
			" Force cache reloading by deleting cache file
			call delete(g:Powerline_cache_file)
		endif

		" Load main statusline file
		" If &rtp contains more than one matching files, take the first one
		let main_path = split(globpath(&rtp, 'powerline/'. g:Powerline_theme .'.vim', 1), '\n')[0]
		if ! empty(main_path) && filereadable(main_path)
			exec 'source' escape(main_path, ' \')
		endif

		" Load cached statuslines
		" Reload and cache statuslines if no cached statuslines exist
		if ! Pl#LoadCached()
			for path in split(globpath(&rtp, 'powerline/'. g:Powerline_theme .'/*', 1), '\n')
				exec 'source' escape(path, ' \')
			endfor

			" Prepare colors and statuslines for caching
			let cache = [
				\ 'let g:Powerline_cache_revision = '. string(s:CACHE_REVISION),
				\ 'let g:Powerline_hi_cmds = '. string(s:hi_cmds),
				\ 'let g:Powerline_match_statuslines  = '. string(s:match_statuslines),
				\ 'let g:Powerline_stored_statuslines = '. string(s:stored_statuslines)
			\ ]

			if empty(g:Powerline_cache_file)
				" Don't cache anything if g:Powerline_cache_file is empty
				return
			endif

			call writefile(cache, g:Powerline_cache_file)
		endif
	endfunction " }}}
" }}}
" Statusline updater {{{
	function! Pl#GetStatusline(statuslines, current) " {{{
		let current_mode = mode()
		let current_window = a:current

		if current_window && current_mode == 'i'
			let statusline_mode = 'insert'
		elseif current_window
			let statusline_mode = 'current'
		else
			let statusline_mode = 'noncurrent'
		endif

		return a:statuslines[statusline_mode]
	endfunction " }}}
	function! Pl#GetStoredStatusline(key) " {{{
		return s:stored_statuslines[a:key]
	endfunction " }}}
	function! Pl#UpdateStatusline(current) " {{{
		if empty(s:match_statuslines)
			" Load statuslines if they aren't loaded yet
			call Pl#Load()
		endif

		for statusline in s:match_statuslines
			let valid = 1

			" Validate matches
			if len(statusline['matches'])
				for [eval, re] in statusline['matches']
					if match(eval(eval), '\v'. re) == -1
						let valid = 0

						break
					endif
				endfor
			endif

			if valid
				" Update window-local statusline
				let &l:statusline = '%!Pl#GetStatusline('. string(statusline['modes']) .','. a:current .')'
			endif
		endfor
	endfunction " }}}
" }}}
