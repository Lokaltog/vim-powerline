call Pl#Statusline(
	\ Pl#Segment(" %{substitute(mode(), '', '^V', 'g')} ",
		\ Pl#HiCurrent(   Pl#FG(235, 0x262626), Pl#BG(214, 0xffaf00), Pl#Attr('bold')),
		\ Pl#HiInsert(    Pl#FG( 23, 0x005f5f), Pl#BG(153, 0xafd7ff), Pl#Attr('bold'))
		\ ),
	\
	\ Pl#Segment("%{substitute(fugitive#statusline(), 'GIT(\\([a-z0-9\\-_\\./:]\\+\\))', ' $branch \\1 ', 'gi')}",
		\ exists('g:loaded_fugitive') && g:loaded_fugitive == 1,
		\
		\ Pl#HiCurrent(   Pl#FG(250, 0xbcbcbc), Pl#BG(240, 0x585858)),
		\ Pl#HiInsert(    Pl#FG(117, 0x87d7ff), Pl#BG( 31, 0x0087af)),
		\ Pl#HiNonCurrent(Pl#FG(239, 0x4e4e4e), Pl#BG(234, 0x1c1c1c))
		\ ),
	\
	\ Pl#SegmentGroup(
		\ Pl#HiCurrent(   Pl#BG(240, 0x585858)),
		\ Pl#HiInsert(    Pl#BG( 31, 0x0087af)),
		\ Pl#HiNonCurrent(Pl#BG(234, 0x1c1c1c)),
		\
		\ Pl#Segment("%{&readonly ? ' $ro' : ''}",
			\ Pl#HiCurrent(   Pl#FG(196, 0xff0000)),
			\ Pl#HiInsert(    Pl#FG(196, 0xff0000)),
			\ Pl#HiNonCurrent(Pl#FG(239, 0x4e4e4e))
			\ ),
		\ Pl#Segment(" %t ",
			\ Pl#HiCurrent(   Pl#FG(231, 0xffffff), Pl#Attr('bold')),
			\ Pl#HiInsert(    Pl#FG(231, 0xffffff), Pl#Attr('bold')),
			\ Pl#HiNonCurrent(Pl#FG(244, 0x808080), Pl#Attr('bold'))
			\ ),
		\ Pl#Segment("%M ",
			\ Pl#HiCurrent(   Pl#FG(196, 0xff0000), Pl#Attr('bold')),
			\ Pl#HiInsert(    Pl#FG(196, 0xff0000), Pl#Attr('bold')),
			\ Pl#HiNonCurrent(Pl#FG(239, 0x4e4e4e))
			\ ),
		\  Pl#Segment("%H%W ",
			\ Pl#HiCurrent(   Pl#FG(250, 0xbcbcbc)),
			\ Pl#HiInsert(    Pl#FG(117, 0x87d7ff)),
			\ Pl#HiNonCurrent(Pl#FG(239, 0x4e4e4e))
			\ ),
		\ Pl#Segment("%{substitute(SyntasticStatuslineFlag(), '\\[Syntax: line:\\(\\d\\+\\) \\((\\(\\d\\+\\))\\)\\?\\]', '┃┃┃ SYNTAX $line \\1 \\2 ┃┃┃', 'i')}",
			\ exists('g:loaded_syntastic_plugin') && g:loaded_syntastic_plugin == 1,
			\
			\ Pl#HiCurrent(   Pl#FG(202, 0xff5f00)),
			\ Pl#HiInsert(    Pl#FG(202, 0xff5f00)),
			\ Pl#HiNonCurrent(Pl#FG(239, 0x4e4e4e))
			\ )
		\ ),
	\
	\ Pl#Segment("%<%{cfi#format(' %s', '')}",
		\ exists('g:has_cfi') && g:has_cfi == 1,
		\
		\ Pl#HiCurrent(   Pl#FG(247, 0x9e9e9e), Pl#BG(236, 0x303030)),
		\ Pl#HiInsert(    Pl#FG(117, 0x87d7ff), Pl#BG( 24, 0x005f87))
		\ ),
	\
	\ Pl#Split(
		\ Pl#HiCurrent(   Pl#BG(236, 0x303030)),
		\ Pl#HiInsert(    Pl#BG( 24, 0x005f87)),
		\ Pl#HiNonCurrent(Pl#BG(234, 0x1c1c1c))
		\ ),
	\
	\ Pl#Segment("%{&fileformat} %{(&fenc == '' ? &enc : &fenc)} ",
		\ Pl#HiCurrent(   Pl#FG(244, 0x808080), Pl#BG(236, 0x303030)),
		\ Pl#HiInsert(    Pl#FG( 75, 0x5fafff), Pl#BG( 24, 0x005f87))
		\ ),
	\
	\ Pl#Segment(" $ft %{strlen(&ft) ? &ft : 'n/a'} ",
		\ Pl#HiCurrent(   Pl#FG(248, 0xa8a8a8), Pl#BG(236, 0x303030)),
		\ Pl#HiInsert(    Pl#FG( 81, 0x5fd7ff), Pl#BG( 24, 0x005f87)),
		\ ),
	\
	\ Pl#Segment(" %p%% ",
		\ Pl#HiCurrent(   Pl#FG(250, 0xbcbcbc), Pl#BG(240, 0x585858)),
		\ Pl#HiInsert(    Pl#FG(117, 0x87d7ff), Pl#BG( 31, 0x0087af)),
		\ Pl#HiNonCurrent(Pl#FG(244, 0x808080), Pl#BG(234, 0x1c1c1c))
		\ ),
	\
	\ Pl#SegmentGroup(
		\ Pl#HiCurrent(   Pl#BG(252, 0xd0d0d0)),
		\ Pl#HiInsert(    Pl#BG(117, 0x87d7ff)),
		\ Pl#HiNonCurrent(Pl#BG(239, 0x4e4e4e)),
		\
		\ Pl#Segment(" $line %l",
			\ Pl#HiCurrent(   Pl#FG(236, 0x303030), Pl#Attr('bold')),
			\ Pl#HiInsert(    Pl#FG( 21, 0x0000ff), Pl#Attr('bold')),
			\ Pl#HiNonCurrent(Pl#FG(250, 0xbcbcbc))
			\ ),
		\ Pl#Segment(":%c%V ",
			\ Pl#HiCurrent(   Pl#FG(244, 0x808080)),
			\ Pl#HiInsert(    Pl#FG( 21, 0x0000ff)),
			\ Pl#HiNonCurrent(Pl#FG(244, 0x808080))
			\ )
		\ )
	\ )
