let g:Powerline#Themes#distinguished#theme = Pl#Theme#Create(
	\ 'distinguished',
	\
	\ Pl#Theme#BufferSegments(Pl#Match#Any(),
		\ 'mode_indicator',
		\ 'fugitive:branch',
		\ 'fileinfo',
		\ Pl#Segment#Truncate(),
		\ Pl#Segment#Split(),
		\ 'scrollpercent'
	\ ),
	\ Pl#Theme#BufferSegments(Pl#Match#Any('ft_help'),
		\ ['static_filename', 'Help'],
		\ Pl#Segment#Truncate(),
		\ Pl#Segment#Split(),
		\ 'scrollpercent'
	\ )
\ )
