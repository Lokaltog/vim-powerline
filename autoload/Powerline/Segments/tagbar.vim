let g:Powerline#Segments#tagbar#segments = Pl#Segment#Init(['tagbar'
	\ (exists('g:loaded_tagbar') && g:loaded_tagbar == 1),
	\
	\ , Pl#Segment#Create('currenttag', '%{tagbar#currenttag("%s", "")}', Pl#Segment#Modes('!N'))
\ ])
