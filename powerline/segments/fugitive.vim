call Pl#Segment#Init('fugitive',
	\ (exists('g:loaded_fugitive') && g:loaded_fugitive == 1),
	\
	\ Pl#Segment#Create('branch', '%{Pl_Fugitive_GetBranch("$branch")}'),
\ )
