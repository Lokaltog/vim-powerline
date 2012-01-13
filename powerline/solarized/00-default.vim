call Pl#Statusline(
	\ Pl#Segment("  %-2{Stl_GetMode()} ",
		\ Pl#HiCurrent(   Pl#FG( 14), Pl#BG(0), Pl#Attr('bold')),
		\ Pl#HiInsert(    Pl#FG( 14), Pl#BG(0), Pl#Attr('bold')),
		\ Pl#HiNonCurrent(Pl#FG( 14), Pl#BG(0), Pl#Attr('bold'))
		\ ),
	\
	\ Pl#SegmentGroup(
		\ Pl#HiCurrent(   Pl#FG(7), Pl#BG(0)),
		\ Pl#HiInsert(    Pl#FG(7), Pl#BG(0)),
		\ Pl#HiNonCurrent(Pl#FG(7), Pl#BG(0)),
		\
		\ Pl#Segment("%{&readonly ? ' $ro' : ''}",
			\ Pl#HiCurrent(   Pl#FG(196)),
			\ Pl#HiInsert(    Pl#FG(196)),
			\ Pl#HiNonCurrent(Pl#FG( 88))
			\ ),
		\ Pl#Segment(" %M ",
			\ Pl#HiCurrent(   Pl#FG(15), Pl#BG(13), Pl#Attr('bold')),
			\ Pl#HiInsert(    Pl#FG(15), Pl#BG(13), Pl#Attr('bold')),
			\ Pl#HiNonCurrent(Pl#FG(15), Pl#BG(13), Pl#Attr('bold'))
			\ ),
		\ Pl#Segment(" %t ",
			\ Pl#HiCurrent(   Pl#FG(7), Pl#BG(0), Pl#Attr('bold')),
			\ Pl#HiInsert(    Pl#FG(7), Pl#BG(0), Pl#Attr('bold')),
			\ Pl#HiNonCurrent(Pl#FG(7), Pl#BG(0))
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
		\ Pl#HiCurrent(   Pl#BG(5)),
		\ Pl#HiInsert(    Pl#BG(9)),
		\ Pl#HiNonCurrent(Pl#BG(0))
		\ ),
	\
	\ Pl#Segment(" %{strlen(&ft) ? &ft : 'n/a'} ",
		\ Pl#HiCurrent(   Pl#FG(246)),
		\ Pl#HiInsert(    Pl#FG( 75)),
		\ ),
	\
	\ Pl#Segment(" %3p%% ",
		\ Pl#HiCurrent(   Pl#FG(7), Pl#BG(0)),
		\ Pl#HiInsert(    Pl#FG(7), Pl#BG(0)),
		\ Pl#HiNonCurrent(Pl#FG(14), Pl#BG(0))
		\ ),
	\
	\ Pl#SegmentGroup(
		\ Pl#HiCurrent(   Pl#BG(15)),
		\ Pl#HiInsert(    Pl#BG(15)),
		\ Pl#HiNonCurrent(Pl#BG(7)),
		\
		\ Pl#Segment(" $line %3l",
			\ Pl#HiCurrent(   Pl#FG(0), Pl#Attr('bold')),
			\ Pl#HiInsert(    Pl#FG(0), Pl#Attr('bold')),
			\ Pl#HiNonCurrent(Pl#FG(10))
			\ ),
		\ Pl#Segment(":%-2c ",
			\ Pl#HiCurrent(   Pl#FG(0)),
			\ Pl#HiInsert(    Pl#FG(0))
			\ )
		\ )
	\ )
