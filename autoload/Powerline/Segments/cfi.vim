let g:Powerline#Segments#cfi#segments = Pl#Segment#Init('cfi',
	\ (exists('g:cfi_disable') && g:cfi_disable == 0),
	\
	\ Pl#Segment#Create('current_function', '%{Powerline#Functions#cfi#GetCurrentFunction()}', Pl#Segment#Modes('!N'))
\ )
