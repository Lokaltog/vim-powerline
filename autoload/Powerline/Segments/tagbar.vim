let g:Powerline#Segments#tagbar#segments = Pl#Segment#Init(['tagbar',
	\ (exists(':Tagbar') > 0),
	\
	\ Pl#Segment#Create('currenttag', '%{Powerline#Functions#tagbar#GetTag()}', Pl#Segment#Modes('!N'))
\ ])
