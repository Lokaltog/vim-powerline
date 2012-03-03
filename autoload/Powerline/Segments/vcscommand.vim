let g:Powerline#Segments#vcscommand#segments = Pl#Segment#Init(['vcscommand',
   \ (exists('g:loaded_VCSCommand') && g:loaded_VCSCommand == 2),
   \
   \ Pl#Segment#Create('branch',
   \    '%{Powerline#Functions#vcscommand#GetBranch("$BRANCH")}')
\ ])
