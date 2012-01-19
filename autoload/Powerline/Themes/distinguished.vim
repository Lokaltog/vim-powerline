let g:Powerline#Themes#distinguished#theme = Pl#Theme#Create(
	\ 'distinguished',
	\
	\ Pl#Theme#BufferSegments(Pl#Match#Any()
		\ , 'mode_indicator'
		\ , 'fugitive:branch'
		\ , 'fileinfo'
		\ , Pl#Segment#Truncate()
		\ , 'cfi:current_function'
		\ , Pl#Segment#Split()
		\ , 'fileformat'
		\ , 'fileencoding'
		\ , 'filetype'
		\ , 'scrollpercent'
		\ , 'lineinfo'
	\ ),
	\ Pl#Theme#BufferSegments(Pl#Match#Any('ft_help')
		\ , ['static_filename', 'Help']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
		\ , 'scrollpercent'
	\ )
\ )
