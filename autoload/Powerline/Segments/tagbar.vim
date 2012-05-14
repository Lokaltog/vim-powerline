let g:Powerline#Segments#tagbar#segments = Pl#Segment#Init(['tagbar'
	\ , Pl#Segment#Create('currenttag', '%{tagbar#currenttag("%s", "")}', Pl#Segment#Modes('!N'))
	\ , Pl#Segment#Create('current', '%{"%0"}')
	\ , Pl#Segment#Create('sort', '%{"%1"}')
	\ , Pl#Segment#Create('fname', '%{"%2"}')
\ ])
