call Pl#Colorscheme#Init('distinguished',
	\ Pl#Colorscheme#HiSegment('special.split', Pl#Hi#Create(Pl#Hi#Cterm(16, 231))),
	\
	\ Pl#Colorscheme#HiSegment('mode_indicator',
		\ Pl#Hi#Create(Pl#Hi#Cterm(22, 148), 'bold'),
		\
		\ {
			\ 'N' : Pl#Hi#Create(Pl#Hi#Cterm(88, 231), 'bold'),
			\ 'vr': Pl#Hi#Create(Pl#Hi#Cterm(88, 231), 'bold')
		\ }
	\ ),
	\ Pl#Colorscheme#HiSegment('fugitive:branch'   , Pl#Hi#Create(Pl#Hi#Cterm(16, 231))),
	\ Pl#Colorscheme#HiSegment('fileinfo'          , Pl#Hi#Create(Pl#Hi#Cterm(16, 231))),
	\ Pl#Colorscheme#HiSegment('fileinfo.flags'    , Pl#Hi#Create(Pl#Hi#Cterm(16, 231))),
	\ Pl#Colorscheme#HiSegment('fileinfo.flags.ro' , Pl#Hi#Create(Pl#Hi#Cterm(16, 231))),
	\ Pl#Colorscheme#HiSegment('scrollpercent'     , Pl#Hi#Create(Pl#Hi#Cterm(16, 231))),
	\ Pl#Colorscheme#HiSegment('static_filename'   , Pl#Hi#Create(Pl#Hi#Cterm(16, 231))),
	\ Pl#Colorscheme#HiSegment('help:scrollpercent', Pl#Hi#Create(Pl#Hi#Cterm(16, 231)))
\ )
