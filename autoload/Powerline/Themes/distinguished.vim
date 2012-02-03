let g:Powerline#Themes#distinguished#theme = Pl#Theme#Create(
	\ Pl#Theme#Buffer(''
		\ , 'mode_indicator'
		\ , 'fugitive:branch'
		\ , 'fileinfo'
		\ , 'syntastic:errors'
		\ , Pl#Segment#Truncate()
		\ , 'cfi:current_function'
		\ , Pl#Segment#Split()
		\ , 'rvm:string'
		\ , 'virtualenv:statusline'
		\ , 'fileformat'
		\ , 'fileencoding'
		\ , 'filetype'
		\ , 'scrollpercent'
		\ , 'lineinfo'
	\ ),
	\
	\ Pl#Theme#Buffer('command_t'
		\ , ['static_str.name', 'Command-T']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
		\ , ['raw.line', '%10(Match #%l%)']
	\ ),
	\
	\ Pl#Theme#Buffer('gundo', Pl#Match#Any('gundo_tree')
		\ , ['static_str.name', 'Gundo']
		\ , ['static_str.buffer', 'Undo tree']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
	\ ),
	\
	\ Pl#Theme#Buffer('gundo', Pl#Match#Any('gundo_preview')
		\ , ['static_str.name', 'Gundo']
		\ , ['static_str.buffer', 'Diff preview']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
	\ ),
	\
	\ Pl#Theme#Buffer('ft_help'
		\ , ['static_str.name', 'Help']
		\ , 'filename'
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
		\ , 'scrollpercent'
	\ ),
	\
	\ Pl#Theme#Buffer('ft_vimpager'
		\ , ['static_str.name', 'Pager']
		\ , 'filename'
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
		\ , 'scrollpercent'
	\ ),
	\
	\ Pl#Theme#Buffer('lustyexplorer'
		\ , ['static_str.name', 'LustyExplorer']
		\ , ['static_str.buffer', 'Buffer list']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
	\ ),
	\
	\ Pl#Theme#Buffer('ft_man'
		\ , ['static_str.name', 'Man page']
		\ , 'filename'
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
		\ , 'scrollpercent'
	\ ),
	\
	\ Pl#Theme#Buffer('minibufexplorer'
		\ , ['static_str.name', 'MiniBufExplorer']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
	\ ),
	\
	\ Pl#Theme#Buffer('ft_qf'
		\ , ['static_str.name', 'Quickfix']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
	\ ),
	\
	\ Pl#Theme#Buffer('tagbar'
		\ , ['static_str.name', 'Tagbar']
		\ , ['static_str.buffer', 'Tree']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
	\ )
\ )
