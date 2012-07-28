call Pl#Hi#Allocate({
\ 'black' : 16,
\ 'white' : 231,
\
\ 'darkestgreen' : 22,
\ 'darkgreen' : 28,
\ 'mediumgreen' : 70,
\ 'brightgreen' : 148,
\
\ 'darkestcyan' : 23,
\ 'mediumcyan' : 117,
\
\ 'darkestblue' : 24,
\ 'darkblue' : 31,
\
\ 'darkestred' : 52,
\ 'darkred' : 88,
\ 'mediumred' : 124,
\ 'brightred' : 160,
\ 'brightestred' : 196,
\
\ 'darkestpurple' : 55,
\ 'mediumpurple' : 98,
\ 'brightpurple' : 189,
\
\ 'brightorange' : 208,
\ 'brightestorange': 214,
\
\ 'gray0' : 233,
\ 'gray1' : 235,
\ 'gray2' : 236,
\ 'gray3' : 239,
\ 'gray4' : 240,
\ 'gray5' : 241,
\ 'gray6' : 244,
\ 'gray7' : 245,
\ 'gray8' : 247,
\ 'gray9' : 250,
\ 'gray10' : 252,
  \
  \ 'zen_color_1' : 108,
  \ 'zen_color_2' : 66,
  \ 'zen_color_3' : 188,
  \ 'zen_color_4' : 174,
  \ 'zen_color_5' : 223,
\ })

let g:Powerline#Colorschemes#zenburn#colorscheme = Pl#Colorscheme#Init([
\ Pl#Hi#Segments(['SPLIT'], {
\ 'n': ['white', 'zen_color_4'],
\ 'N': ['white', 'gray0'],
\ 'i': ['white', 'zen_color_1'],
\ }),
\
\ Pl#Hi#Segments(['mode_indicator'], {
\ 'n': ['gray3', 'zen_color_4', ['bold']],
\ 'i': ['gray3', 'zen_color_1', ['bold']],
\ 'v': ['gray3', 'zen_color_5', ['bold']],
\ 'r': ['gray3', 'mediumcyan', ['bold']],
\ 's': ['white', 'gray5', ['bold']],
\ }),
\
\ Pl#Hi#Segments(['branch', 'scrollpercent', 'raw', 'filesize'], {
\ 'n': ['gray9', 'gray4'],
\ 'N': ['gray3', 'gray1'],
\ 'i': ['gray9', 'gray4'],
\ }),
\
\ Pl#Hi#Segments(['fileinfo', 'filename'], {
\ 'n': ['gray3', 'zen_color_4', ['bold']],
\ 'N': ['gray7', 'gray1', ['bold']],
\ 'i': ['gray3', 'zen_color_1', ['bold']],
\ }),
\
\ Pl#Hi#Segments(['static_str'], {
\ 'n': ['white', 'gray4'],
\ 'N': ['gray7', 'gray1'],
\ 'i': ['white', 'gray4'],
\ }),
\
\ Pl#Hi#Segments(['fileinfo.flags'], {
\ 'n': ['gray2', ['bold']],
\ 'N': ['zen_color_4'],
\ 'i': ['gray2', ['bold']],
\ }),
\
\ Pl#Hi#Segments(['current_function', 'fileformat', 'fileencoding', 'pwd', 'filetype', 'rvm:string', 'rvm:statusline', 'virtualenv:statusline', 'charcode', 'currhigroup'], {
\ 'n': ['gray8', 'gray2'],
\ 'i': ['gray8', 'gray2'],
\ }),
\
\ Pl#Hi#Segments(['lineinfo'], {
\ 'n': ['gray2', 'gray10', ['bold']],
\ 'N': ['gray3', 'gray1', ['bold']],
\ 'i': ['gray2', 'gray10', ['bold']],
\ }),
\
\ Pl#Hi#Segments(['errors'], {
\ 'n': ['brightestorange', 'gray2', ['bold']],
\ 'i': ['brightestorange', 'darkestblue', ['bold']],
\ }),
\
\ Pl#Hi#Segments(['lineinfo.line.tot'], {
\ 'n': ['gray3'],
\ 'N': ['gray3'],
\ 'i': ['gray3'],
\ }),
\
\ Pl#Hi#Segments(['ctrlp:focus', 'ctrlp:byfname'], {
\ 'n': ['brightpurple', 'darkestpurple'],
\ }),
\
\ Pl#Hi#Segments(['ctrlp:prev', 'ctrlp:next', 'ctrlp:pwd'], {
\ 'n': ['white', 'mediumpurple'],
\ }),
\
\ Pl#Hi#Segments(['ctrlp:item'], {
\ 'n': ['darkestpurple', 'white', ['bold']],
\ }),
\
\ Pl#Hi#Segments(['ctrlp:marked'], {
\ 'n': ['brightestred', 'darkestpurple', ['bold']],
\ }),
\
\ Pl#Hi#Segments(['ctrlp:count'], {
\ 'n': ['darkestpurple', 'white'],
\ }),
\
\ Pl#Hi#Segments(['paste_indicator', 'ws_marker'], {
\ 'n': ['white', 'zen_color_4', ['bold']],
\ }),
  \
\ Pl#Hi#Segments(['ctrlp:SPLIT'], {
\ 'n': ['white', 'darkestpurple'],
\ }),
\ ])
