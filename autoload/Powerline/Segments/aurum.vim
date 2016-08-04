let g:Powerline#Segments#aurum#segments = Pl#Segment#Init(['aurum',
	\ (exists('*FraworLoad') && FraworLoad('autoload/aurum')),
	\
	\ Pl#Segment#Create('branch', '%{Powerline#Functions#aurum#GetBranch("$BRANCH")}'),
	\ Pl#Segment#Create('status', '%{Powerline#Functions#aurum#GetStatus()}')
\ ])
