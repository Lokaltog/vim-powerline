call Pl#Statusline(
	\ Pl#Segment(" %{substitute(mode(), '', '^V', 'g')} ",
		\ Pl#HiCurrent(   Pl#FG(235), Pl#BG(214), Pl#Attr('bold')),
		\ Pl#HiInsert(    Pl#FG( 23), Pl#BG(153), Pl#Attr('bold'))
		\ ),
	\
	\ Pl#Segment("%{substitute(fugitive#statusline(), 'GIT(\\([a-z0-9\\-_\\./:]\\+\\))', ' $branch \\1 ', 'gi')}",
		\ exists('g:loaded_fugitive') && g:loaded_fugitive == 1,
		\
		\ Pl#HiCurrent(   Pl#FG(250), Pl#BG(240)),
		\ Pl#HiInsert(    Pl#FG(117), Pl#BG( 31)),
		\ Pl#HiNonCurrent(Pl#FG(239), Pl#BG(234))
		\ ),
	\
	\ Pl#SegmentGroup(
		\ Pl#HiCurrent(   Pl#BG(240)),
		\ Pl#HiInsert(    Pl#BG( 31)),
		\ Pl#HiNonCurrent(Pl#BG(234)),
		\
		\ Pl#Segment("%{&readonly ? ' $ro' : ''}",
			\ Pl#HiCurrent(   Pl#FG(196)),
			\ Pl#HiInsert(    Pl#FG(196)),
			\ Pl#HiNonCurrent(Pl#FG(239))
			\ ),
		\ Pl#Segment(" %t ",
			\ Pl#HiCurrent(   Pl#FG(231), Pl#Attr('bold')),
			\ Pl#HiInsert(    Pl#FG(231), Pl#Attr('bold')),
			\ Pl#HiNonCurrent(Pl#FG(244), Pl#Attr('bold'))
			\ ),
		\ Pl#Segment("%M ",
			\ Pl#HiCurrent(   Pl#FG(196), Pl#Attr('bold')),
			\ Pl#HiInsert(    Pl#FG(196), Pl#Attr('bold')),
			\ Pl#HiNonCurrent(Pl#FG(239))
			\ ),
		\  Pl#Segment("%H%W ",
			\ Pl#HiCurrent(   Pl#FG(250)),
			\ Pl#HiInsert(    Pl#FG(117)),
			\ Pl#HiNonCurrent(Pl#FG(239))
			\ ),
		\ Pl#Segment("%{substitute(SyntasticStatuslineFlag(), '\\[Syntax: line:\\(\\d\\+\\) \\((\\(\\d\\+\\))\\)\\?\\]', '┃┃┃ SYNTAX $line \\1 \\2 ┃┃┃', 'i')}",
			\ exists('g:loaded_syntastic_plugin') && g:loaded_syntastic_plugin == 1,
			\
			\ Pl#HiCurrent(   Pl#FG(202)),
			\ Pl#HiInsert(    Pl#FG(202)),
			\ Pl#HiNonCurrent(Pl#FG(239))
			\ )
		\ ),
	\
	\ Pl#Segment("%<%{cfi#format(' %s', '')}",
		\ exists('g:has_cfi') && g:has_cfi == 1,
		\
		\ Pl#HiCurrent(   Pl#FG(247), Pl#BG(236)),
		\ Pl#HiInsert(    Pl#FG(117), Pl#BG( 24))
		\ ),
	\
	\ Pl#Split(
		\ Pl#HiCurrent(   Pl#BG(236)),
		\ Pl#HiInsert(    Pl#BG( 24)),
		\ Pl#HiNonCurrent(Pl#BG(234))
		\ ),
	\
	\ Pl#Segment("%{&fileformat} %{(&fenc == '' ? &enc : &fenc)} ",
		\ Pl#HiCurrent(   Pl#FG(244), Pl#BG(236)),
		\ Pl#HiInsert(    Pl#FG( 75), Pl#BG( 24))
		\ ),
	\
	\ Pl#Segment(" $ft %{strlen(&ft) ? &ft : 'n/a'} ",
		\ Pl#HiCurrent(   Pl#FG(248), Pl#BG(236)),
		\ Pl#HiInsert(    Pl#FG( 81), Pl#BG( 24)),
		\ ),
	\
	\ Pl#Segment(" %4(%p%%%) ",
		\ Pl#HiCurrent(   Pl#FG(250), Pl#BG(240)),
		\ Pl#HiInsert(    Pl#FG(117), Pl#BG( 31)),
		\ Pl#HiNonCurrent(Pl#FG(244), Pl#BG(234))
		\ ),
	\
	\ Pl#SegmentGroup(
		\ Pl#HiCurrent(   Pl#BG(252)),
		\ Pl#HiInsert(    Pl#BG(117)),
		\ Pl#HiNonCurrent(Pl#BG(239)),
		\
		\ Pl#Segment(" %5($line %l%)",
			\ Pl#HiCurrent(   Pl#FG(236), Pl#Attr('bold')),
			\ Pl#HiInsert(    Pl#FG( 23), Pl#Attr('bold')),
			\ Pl#HiNonCurrent(Pl#FG(250))
			\ ),
		\ Pl#Segment(":%3(%c%) ",
			\ Pl#HiCurrent(   Pl#FG(244)),
			\ Pl#HiInsert(    Pl#FG( 23)),
			\ Pl#HiNonCurrent(Pl#FG(244))
			\ )
		\ )
	\ )
