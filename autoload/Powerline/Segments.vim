let g:Powerline#Segments#segments = Pl#Segment#Init(
	\ Pl#Segment#Create('special.split'   , '__split__'),
	\ Pl#Segment#Create('special.truncate', '__truncate__'),
	\
	\ Pl#Segment#Create('mode_indicator'  , '%{Powerline#Functions#GetMode()}', Pl#Segment#Modes('!N')),
	\ Pl#Segment#Create('fileinfo',
		\ Pl#Segment#Create('flags.ro'    , '%{&readonly ? "$RO" : ""}'),
		\ Pl#Segment#Create('name'        , '%t'),
		\ Pl#Segment#Create('flags.mod'   , '%M'),
		\ Pl#Segment#Create('flags.type'  , '%H%W'),
	\ ),
	\ Pl#Segment#Create('static_filename' , '%%{"%s"}'),
	\ Pl#Segment#Create('fileformat'      , '%{&fileformat}'                  , Pl#Segment#Modes('!N')),
	\ Pl#Segment#Create('fileencoding'    , '%{(&fenc == "" ? &enc : &fenc)}' , Pl#Segment#Modes('!N')),
	\ Pl#Segment#Create('filetype'        , '$FT %{strlen(&ft) ? &ft : "n/a"}', Pl#Segment#Modes('!N')),
	\ Pl#Segment#Create('scrollpercent'   , '%3p%%'),
	\ Pl#Segment#Create('lineinfo',
		\ Pl#Segment#Create('line.cur'    , '$LINE %3l'),
		\ Pl#Segment#Create('line.tot'    , '$COL %-2c'),
	\ )
\ )
