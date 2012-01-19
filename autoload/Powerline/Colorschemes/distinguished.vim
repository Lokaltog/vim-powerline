let g:Powerline#Colorschemes#distinguished#colorscheme = Pl#Colorscheme#Init(
	\ Pl#Colorscheme#HiSegment('special.split',
		\ Pl#Hi#Create(Pl#Hi#Cterm(0, 236)),
		\ {
			\ 'N': Pl#Hi#Create(Pl#Hi#Cterm(0, 233)),
			\ 'i': Pl#Hi#Create(Pl#Hi#Cterm(0,  24))
		\ }
	\),
	\
	\ Pl#Colorscheme#HiSegment('mode_indicator',
		\ Pl#Hi#Create(Pl#Hi#Cterm( 22, 148), 'bold'),
		\
		\ {
			\ 'N': Pl#Hi#Create(Pl#Hi#Cterm( 23, 231), 'bold'),
			\ 'v': Pl#Hi#Create(Pl#Hi#Cterm( 23, 231), 'bold'),
			\ 'i': Pl#Hi#Create(Pl#Hi#Cterm( 23, 231), 'bold'),
			\ 'r': Pl#Hi#Create(Pl#Hi#Cterm( 23, 231), 'bold')
		\ }
	\ ),
	\
	\ Pl#Colorscheme#HiSegment('fugitive:branch',
		\ Pl#Hi#Create(Pl#Hi#Cterm(250, 240)),
		\ {
			\ 'N': Pl#Hi#Create(Pl#Hi#Cterm(239, 235)),
			\ 'i': Pl#Hi#Create(Pl#Hi#Cterm(117,  31))
		\ }
	\),
	\
	\ Pl#Colorscheme#HiSegment('fileinfo',
		\ Pl#Hi#Create(Pl#Hi#Cterm(231, 240), 'bold'),
		\ {
			\ 'N': Pl#Hi#Create(Pl#Hi#Cterm(245, 235), 'bold'),
			\ 'i': Pl#Hi#Create(Pl#Hi#Cterm(231,  31), 'bold')
		\ }
	\),
	\
	\ Pl#Colorscheme#HiSegment('fileinfo.flags',
		\ Pl#Hi#Create(Pl#Hi#Cterm(196), 'bold'),
		\ {
			\ 'N': Pl#Hi#Create(Pl#Hi#Cterm( 88)),
			\ 'i': Pl#Hi#Create(Pl#Hi#Cterm(196), 'bold')
		\ }
	\),
	\
	\ Pl#Colorscheme#HiSegment('cfi:current_function',
		\ Pl#Hi#Create(Pl#Hi#Cterm(247, 236)),
		\ {
			\ 'i': Pl#Hi#Create(Pl#Hi#Cterm(117,  24))
		\ }
	\),
	\
	\ Pl#Colorscheme#HiSegment('fileformat',
		\ Pl#Hi#Create(Pl#Hi#Cterm(246, 236)),
		\ {
			\ 'i': Pl#Hi#Create(Pl#Hi#Cterm(117, 24))
		\ }
	\),
	\
	\ Pl#Colorscheme#HiSegment('fileencoding',
		\ Pl#Hi#Create(Pl#Hi#Cterm(246, 236)),
		\ {
			\ 'i': Pl#Hi#Create(Pl#Hi#Cterm(117, 24))
		\ }
	\),
	\
	\ Pl#Colorscheme#HiSegment('filetype',
		\ Pl#Hi#Create(Pl#Hi#Cterm(246, 236)),
		\ {
			\ 'i': Pl#Hi#Create(Pl#Hi#Cterm( 75, 24)),
		\ }
	\),
	\
	\ Pl#Colorscheme#HiSegment('scrollpercent',
		\ Pl#Hi#Create(Pl#Hi#Cterm(250, 240)),
		\ {
			\ 'N': Pl#Hi#Create(Pl#Hi#Cterm(241, 234)),
			\ 'i': Pl#Hi#Create(Pl#Hi#Cterm(117,  31))
		\ }
	\),
	\
	\ Pl#Colorscheme#HiSegment('lineinfo',
		\ Pl#Hi#Create(Pl#Hi#Cterm(236, 252), 'bold'),
		\ {
			\ 'N': Pl#Hi#Create(Pl#Hi#Cterm(245, 235), 'bold'),
			\ 'i': Pl#Hi#Create(Pl#Hi#Cterm( 23, 117), 'bold')
		\ }
	\),
	\
	\ Pl#Colorscheme#HiSegment('lineinfo.line.tot',
		\ Pl#Hi#Create(Pl#Hi#Cterm(244)),
		\ {
			\ 'N': Pl#Hi#Create(Pl#Hi#Cterm(241)),
			\ 'i': Pl#Hi#Create(Pl#Hi#Cterm( 23))
		\ }
	\),
	\
	\ Pl#Colorscheme#HiSegment('static_filename',
		\ Pl#Hi#Create(Pl#Hi#Cterm(231, 240), 'bold'),
		\ {
			\ 'N': Pl#Hi#Create(Pl#Hi#Cterm(245, 235), 'bold'),
			\ 'i': Pl#Hi#Create(Pl#Hi#Cterm(231,  31), 'bold')
		\ }
	\),
	\
	\ Pl#Colorscheme#HiSegment('help:scrollpercent',
		\ Pl#Hi#Create(Pl#Hi#Cterm(231, 240), 'bold'),
		\ {
			\ 'N': Pl#Hi#Create(Pl#Hi#Cterm(245, 235), 'bold'),
			\ 'i': Pl#Hi#Create(Pl#Hi#Cterm(231,  31), 'bold')
		\ }
	\)
\ )
