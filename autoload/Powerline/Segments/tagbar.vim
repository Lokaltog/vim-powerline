let g:Powerline#Segments#tagbar#segments = Pl#Segment#Init(['tagbar'
	\ , Pl#Segment#Create('currenttag', '%{tagbar#currenttag("%s", "")}', Pl#Segment#Modes('!N'))
\ ])
