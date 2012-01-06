call Pl#Statusline(
	\ Pl#Segment("  %-2{Stl_GetMode()} ",
		\ Pl#HiCurrent(   Pl#FG( 22), Pl#BG(148), Pl#Attr('bold')),
		\ Pl#HiInsert(    Pl#FG( 23), Pl#BG(231), Pl#Attr('bold'))
		\ ),
	\
	\ Pl#Segment("%{Stl_GetBranch('$branch')}",
		\ exists('g:loaded_fugitive') && g:loaded_fugitive == 1,
		\
		\ Pl#HiCurrent(   Pl#FG(250), Pl#BG(240)),
		\ Pl#HiInsert(    Pl#FG(117), Pl#BG( 31)),
		\ Pl#HiNonCurrent(Pl#FG(239), Pl#BG(235))
		\ ),
	\
	\ Pl#SegmentGroup(
		\ Pl#HiCurrent(   Pl#BG(240)),
		\ Pl#HiInsert(    Pl#BG( 31)),
		\ Pl#HiNonCurrent(Pl#BG(235)),
		\
		\ Pl#Segment("%{&readonly ? ' $ro' : ''}",
			\ Pl#HiCurrent(   Pl#FG(196)),
			\ Pl#HiInsert(    Pl#FG(196)),
			\ Pl#HiNonCurrent(Pl#FG( 88))
			\ ),
		\ Pl#Segment(" %t ",
			\ Pl#HiCurrent(   Pl#FG(231), Pl#Attr('bold')),
			\ Pl#HiInsert(    Pl#FG(231), Pl#Attr('bold')),
			\ Pl#HiNonCurrent(Pl#FG(245), Pl#Attr('bold'))
			\ ),
		\ Pl#Segment("%M ",
			\ Pl#HiCurrent(   Pl#FG(196), Pl#Attr('bold')),
			\ Pl#HiInsert(    Pl#FG(196), Pl#Attr('bold')),
			\ Pl#HiNonCurrent(Pl#FG( 88))
			\ ),
		\  Pl#Segment("%H%W ",
			\ Pl#HiCurrent(   Pl#FG(250)),
			\ Pl#HiInsert(    Pl#FG(117)),
			\ Pl#HiNonCurrent(Pl#FG(239))
			\ ),
		\ Pl#Segment("%{Stl_GetSyntaxErrors('$line')}",
			\ exists('g:loaded_syntastic_plugin') && g:loaded_syntastic_plugin == 1,
			\
			\ Pl#HiCurrent(   Pl#FG(214), Pl#Attr('bold')),
			\ Pl#HiInsert(    Pl#FG(214), Pl#Attr('bold')),
			\ )
		\ ),
	\
	\ Pl#Segment("%<%{Stl_GetCurrentFunction()}",
		\ exists('g:cfi_disable') && g:cfi_disable == 0,
		\
		\ Pl#HiCurrent(   Pl#FG(247), Pl#BG(236)),
		\ Pl#HiInsert(    Pl#FG(117), Pl#BG( 24))
		\ ),
	\
	\ Pl#Split(
		\ Pl#HiCurrent(   Pl#BG(236)),
		\ Pl#HiInsert(    Pl#BG( 24)),
		\ Pl#HiNonCurrent(Pl#BG(233))
		\ ),
	\
	\ Pl#Segment("%{&fileformat} %{(&fenc == '' ? &enc : &fenc)} ",
		\ Pl#HiCurrent(   Pl#FG(246), Pl#BG(236)),
		\ Pl#HiInsert(    Pl#FG( 75), Pl#BG( 24))
		\ ),
	\
	\ Pl#Segment(" $ft %{strlen(&ft) ? &ft : 'n/a'} ",
		\ Pl#HiCurrent(   Pl#FG(246), Pl#BG(236)),
		\ Pl#HiInsert(    Pl#FG( 75), Pl#BG( 24)),
		\ ),
	\
	\ Pl#Segment(" %3p%% ",
		\ Pl#HiCurrent(   Pl#FG(250), Pl#BG(240)),
		\ Pl#HiInsert(    Pl#FG(117), Pl#BG( 31)),
		\ Pl#HiNonCurrent(Pl#FG(241), Pl#BG(234))
		\ ),
	\
	\ Pl#SegmentGroup(
		\ Pl#HiCurrent(   Pl#BG(252)),
		\ Pl#HiInsert(    Pl#BG(117)),
		\ Pl#HiNonCurrent(Pl#BG(235)),
		\
		\ Pl#Segment(" $line %3l",
			\ Pl#HiCurrent(   Pl#FG(236), Pl#Attr('bold')),
			\ Pl#HiInsert(    Pl#FG( 23), Pl#Attr('bold')),
			\ Pl#HiNonCurrent(Pl#FG(245))
			\ ),
		\ Pl#Segment(":%-2c ",
			\ Pl#HiCurrent(   Pl#FG(244)),
			\ Pl#HiInsert(    Pl#FG( 23)),
			\ Pl#HiNonCurrent(Pl#FG(241))
			\ )
		\ )
	\ )
