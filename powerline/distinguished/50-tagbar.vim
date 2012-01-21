call Pl#Statusline(
	\ Pl#Match('bufname("%")', '__Tagbar__'),
	\
	\ Pl#Segment(' %{"Tagbar"} ',
		\ Pl#HiCurrent(   Pl#FG(231), Pl#BG( 70), Pl#Attr('bold')),
		\ Pl#HiInsert(    Pl#FG(231), Pl#BG( 31), Pl#Attr('bold')),
		\ Pl#HiNonCurrent(Pl#FG( 70), Pl#BG( 22), Pl#Attr('bold'))
		\ ),
	\
	\ Pl#Segment('%< %{"Tree"}',
		\ Pl#HiCurrent(   Pl#FG(148), Pl#BG( 28)),
		\ Pl#HiInsert(    Pl#FG(117), Pl#BG( 24)),
		\ Pl#HiNonCurrent(Pl#FG( 70), Pl#BG( 22))
		\ ),
	\
	\ Pl#Split(
		\ Pl#HiCurrent(   Pl#BG( 28)),
		\ Pl#HiInsert(    Pl#BG( 24)),
		\ Pl#HiNonCurrent(Pl#BG( 22))
		\ )
	\ )
