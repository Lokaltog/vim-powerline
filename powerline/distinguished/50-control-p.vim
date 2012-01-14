call Pl#StoreStatusline('ctrlp_main',
	\ Pl#Segment('%{"%REGEX"}', Pl#HiCurrent(Pl#FG( 23), Pl#BG(117))),
	\
	\ Pl#Segment(' %{"%FOCUS %BYFNAME"}%< ', Pl#HiCurrent(Pl#FG(159), Pl#BG( 31), Pl#Attr('bold'))),
	\
	\ Pl#Segment(' %-3{"%PREV"} ', Pl#HiCurrent(Pl#FG(247), Pl#BG(239))),
	\ Pl#Segment(' %-9{"%ITEM"} ', Pl#HiCurrent(Pl#FG(231), Pl#BG(244), Pl#Attr('bold'))),
	\ Pl#Segment(' %-3{"%NEXT"} ', Pl#HiCurrent(Pl#FG(247), Pl#BG(239))),
	\
	\ Pl#Segment('%{"%MARKED"}',   Pl#HiCurrent(Pl#FG(196), Pl#BG(236), Pl#Attr('bold'))),
	\
	\ Pl#Split(Pl#HiCurrent(Pl#BG(236))),
	\
	\ Pl#Segment(' %{getcwd()} ',  Pl#HiCurrent(Pl#FG(236), Pl#BG(252)))
	\ )

call Pl#StoreStatusline('ctrlp_prog',
	\ Pl#Segment(' Loading %{getcwd()}... ', Pl#HiCurrent(Pl#FG(250), Pl#BG(240), Pl#Attr('bold'))),
	\ Pl#Segment(' %-6{"%LEN"} %< ',         Pl#HiCurrent(Pl#FG(247), Pl#BG(236))),
	\ Pl#Split(Pl#HiCurrent(Pl#BG(236)))
	\ )
