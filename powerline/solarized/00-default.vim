call Pl#Statusline(
		\
   \ Pl#Segment(" %n ",
      \ Pl#HiCurrent(   Pl#FG(7), Pl#BG(10)),
      \ Pl#HiInsert(    Pl#FG(7), Pl#BG(10))
      \ ),
   \ Pl#Segment(" %{Stl_GetMode()} ",
      \ Pl#HiCurrent(   Pl#FG(7), Pl#BG(0)),
      \ Pl#HiInsert(    Pl#FG(7), Pl#BG(0)),
      \ Pl#HiNonCurrent(Pl#FG(7), Pl#BG(0)),
      \ ),
	\
	\ Pl#SegmentGroup(
		\ Pl#HiCurrent(   Pl#FG(7), Pl#BG(0)),
		\ Pl#HiInsert(    Pl#FG(7), Pl#BG(0)),
		\ Pl#HiNonCurrent(Pl#FG(7), Pl#BG(0)),
		\
		\ Pl#Segment("%{&readonly ? ' $ro' : ''}",
			\ Pl#HiCurrent(   Pl#FG(15)),
			\ Pl#HiInsert(    Pl#FG(15)),
			\ Pl#HiNonCurrent(Pl#FG(15))
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
	\ Pl#Split(
		\ Pl#HiCurrent(   Pl#BG(5)),
		\ Pl#HiInsert(    Pl#BG(9)),
		\ Pl#HiNonCurrent(Pl#BG(10))
		\ ),
	\
	\ Pl#Segment(" %{strlen(&ft) ? &ft : 'n/a'} ",
		\ Pl#HiCurrent(   Pl#FG(15)),
		\ Pl#HiInsert(    Pl#FG(15)),
		\ ),
	\
	\ Pl#Segment(" %3p%% ",
		\ Pl#HiCurrent(   Pl#FG(7), Pl#BG(0)),
		\ Pl#HiInsert(    Pl#FG(7), Pl#BG(0)),
		\ Pl#HiNonCurrent(Pl#FG(14), Pl#BG(0))
		\ ),
   \ Pl#Segment(" c%-2c ",
      \ Pl#HiCurrent(   Pl#FG(0)),
      \ Pl#HiInsert(    Pl#FG(0))
      \ ),
   \ Pl#Segment("  %M  ",
      \ Pl#HiCurrent(   Pl#FG(15), Pl#BG(1), Pl#Attr('bold')),
      \ Pl#HiInsert(    Pl#FG(15), Pl#BG(1), Pl#Attr('bold')),
      \ Pl#HiNonCurrent(Pl#FG(15), Pl#BG(1), Pl#Attr('bold'))
      \ ),
	\ )
