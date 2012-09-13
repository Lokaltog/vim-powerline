let g:Powerline#Segments#spell#segments = Pl#Segment#Init(['spell',
	\ has('spell'),
	\
	\ Pl#Segment#Create('spelllang', '%{(&spell && strlen(&spelllang)) ? &spelllang : "no lang"}'),
\ ])
