call Pl#Segment#Init('syntastic',
	\ (exists('g:loaded_syntastic_plugin') && g:loaded_syntastic_plugin == 1),
	\
	\ Pl#Segment#Create('errors', '%{Pl_Syntastic_GetErrors("$line")}'),
\ )
