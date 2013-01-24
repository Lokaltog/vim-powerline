let g:Powerline#Segments#linesinfo#segments = Pl#Segment#Init(['linesinfo',
   \ Pl#Segment#Create('lineinfo',
      \ Pl#Segment#Create('lines', '$LINE %3l/%-3L'),
      \ Pl#Segment#Create('line.tot',
         \ '%2c/%-2{strlen(getline(line(".")))}'),
   \ )
\ ])
