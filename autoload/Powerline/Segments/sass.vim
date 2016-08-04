let g:Powerline#Segments#sass#segments = Pl#Segment#Init(['sass',
	\ (exists('g:autoloaded_sass_status') && g:autoloaded_sass_status== 1),
	\
	\ Pl#Segment#Create('status', '%{sass_status#statusline()}')
\ ])
