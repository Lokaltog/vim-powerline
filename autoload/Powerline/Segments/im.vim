function! PrintImfix()
    if IMStatus("foo") == "foo"
        return "imON"
    else
        return "imOFF"
    endif
endfunction

let g:Powerline#Segments#im#segments = Pl#Segment#Init(['im',
	\ has('python'),
	\
	\ Pl#Segment#Create('im', '%{IMStatus("foo") == "foo" ? "imON" : "imOFF"}')
\ ])
