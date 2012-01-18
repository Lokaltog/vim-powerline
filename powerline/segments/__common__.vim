call Pl#Segment#Init(
	\ Pl#Segment#Create('mode_indicator', '%-2{Pl_Common_GetMode()}'        , Pl#Segment#Modes('!N')),
	\ Pl#Segment#Create('fileinfo',
		\ Pl#Segment#Create('flags.ro'  , '%{&readonly ? " $ro" : ""}'),
		\ Pl#Segment#Create('name'      , '%t'),
		\ Pl#Segment#Create('flags.mod' , '%M'),
		\ Pl#Segment#Create('flags.type', '%H%W'),
	\ ),
	\ Pl#Segment#Create('fileformat'    , '%{&fileformat}'                  , Pl#Segment#Modes('!N')),
	\ Pl#Segment#Create('fileencoding'  , '%{(&fenc == '' ? &enc : &fenc)}' , Pl#Segment#Modes('!N')),
	\ Pl#Segment#Create('filetype'      , '$ft %{strlen(&ft) ? &ft : "n/a"}', Pl#Segment#Modes('!N')),
	\ Pl#Segment#Create('scrollpercent' , '%3p%%'),
	\ Pl#Segment#Create('lineinfo',
		\ Pl#Segment#Create('line.cur'  , '$line %3l'),
		\ Pl#Segment#Create('line.tot'  , ':%-2c'),
	\ )
\ )
