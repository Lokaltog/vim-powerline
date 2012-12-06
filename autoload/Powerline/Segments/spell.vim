let g:Powerline#Segments#spell#segments = Pl#Segment#Init(['spell',
	\ has('spell'),
	\
	\ Pl#Segment#Create('lang', '%{(&spell && !empty(&spelllang)) ? &spelllang : "no lang"}'),
\ ])
