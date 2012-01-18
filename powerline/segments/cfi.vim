call Pl#Segment#Init('cfi',
	\ (exists('g:cfi_disable') && g:cfi_disable == 0),
	\
	\ Pl#Segment#Create('current_function', '%{Pl_Cfi_GetCurrentFunction()}', '!N')
\ )
