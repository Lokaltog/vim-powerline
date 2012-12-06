
" Solarized color scheme for Powerline
" N = no focus
" 16 hex colors as defined on http://ethanschoonover.com/solarized
call Pl#Hi#Allocate({
  \ 'base03'  : [8,   0x002b36],
  \ 'base02'  : [0,   0x073642],
  \ 'base01'  : [10,  0x586e75],
  \ 'base00'  : [11,  0x657b83],
  \ 'base0'   : [12,  0x839496],
  \ 'base1'   : [14,  0x93a1a1],
  \ 'base2'   : [7,   0xeee8d5],
  \ 'base3'   : [15,  0xfdf6e3],
  \ 'yellow'  : [3,   0xb58900],
  \ 'orange'  : [9,   0xcb4b16],
  \ 'red'     : [1,   0xdc322f],
  \ 'magenta' : [5,   0xd33682],
  \ 'violet'  : [13,  0x6c71c4],
  \ 'blue'    : [4,   0x268bd2],
  \ 'cyan'    : [6,   0x2aa198],
  \ 'green'   : [2,   0x859900],
	\ })

let g:Powerline#Colorschemes#solarized#colorscheme = Pl#Colorscheme#Init([
	\ Pl#Hi#Segments(['SPLIT'], {
		\ 'n': ['base3',  'base2'],
		\ 'N': ['base3',  'base2'],
		\ 'i': ['base3',  'base2'],
		\ }),
	\
	\ Pl#Hi#Segments(['mode_indicator'], {
		\ 'n': ['base2',  'blue',     ['bold']],
		\ 'i': ['base3',  'orange',   ['bold']],
		\ 'v': ['base3',  'magenta',  ['bold']],
		\ 'r': ['base3',  'violet',   ['bold']],
		\ 's': ['base3',  'yellow',   ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['branch'], {
		\ 'n': ['base2',   'base02'],
		\ 'N': ['base02',  'base1'],
		\ 'i': ['base2',   'base00'],
		\ }),
	\
  \ Pl#Hi#Segments(['scrollpercent', 'raw', 'filesize'], {
		\ 'n': ['base2',   'base0'],
		\ 'N': ['base00',  'base2'],
		\ 'i': ['base2',   'base1'],
		\ }),
	\
	\ Pl#Hi#Segments(['fileinfo', 'filename'], {
		\ 'n': ['base2',   'base01',   ['bold']],
		\ 'N': ['base01',  'base2' ],
		\ 'i': ['base3',   'base1',    ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['fileinfo.filepath'], {
		\ 'n': ['base1'],
		\ 'N': ['base1'],
		\ 'i': ['base01'],
		\ }),
	\
	\ Pl#Hi#Segments(['static_str'], {
		\ 'n': ['base3',   'green'],
		\ 'N': ['base02',  'base01'],
		\ 'i': ['base3',   'blue'],
		\ }),
	\
	\ Pl#Hi#Segments(['fileinfo.flags'], {
		\ 'n': ['base3'],
		\ 'N': ['base00'],
		\ 'i': ['base3'],
		\ }),
	\
	\ Pl#Hi#Segments(['currenttag', 'fileformat', 'fileencoding', 'pwd', 'filetype', 'rvm:string', 'rvm:statusline', 'virtualenv:statusline', 'charcode', 'currhigroup'], {
		\ 'n': ['base00', 'base2'],
		\ 'i': ['base0', 'base2'],
		\ }),
	\
	\ Pl#Hi#Segments(['lineinfo'], {
		\ 'n': ['base2',   'base01',  ['bold']],
		\ 'N': ['base02',  'base0'],
		\ 'i': ['base2',   'base00',  ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['errors'], {
		\ 'n': ['red',  'base2',  ['bold']],
		\ 'i': ['red',  'base2',  ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['lineinfo.line.tot'], {
		\ 'n': ['base3'],
		\ 'N': ['base02'],
		\ 'i': ['base3'],
		\ }),
	\
	\ Pl#Hi#Segments(['paste_indicator', 'ws_marker'], {
		\ 'n': ['base3', 'red', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['gundo:static_str.name', 'command_t:static_str.name'], {
		\ 'n': ['base3',   'red',     ['bold']],
		\ 'N': ['base02',  'base01',  ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['gundo:static_str.buffer', 'command_t:raw.line'], {
		\ 'n': ['base3',  'base00'],
		\ 'N': ['base0',  'base02'],
		\ }),
	\
	\ Pl#Hi#Segments(['gundo:SPLIT', 'command_t:SPLIT'], {
		\ 'n': ['base3',  'base02'],
		\ 'N': ['base0',  'base03'],
		\ }),
	\
	\ Pl#Hi#Segments(['lustyexplorer:static_str.name', 'minibufexplorer:static_str.name', 'nerdtree:raw.name', 'tagbar:static_str.name'], {
		\ 'n': ['base2',   'green',   ['bold']],
		\ 'N': ['base02',  'base1'],
		\ }),
	\
	\ Pl#Hi#Segments(['lustyexplorer:static_str.buffer', 'tagbar:static_str.buffer'], {
		\ 'n': ['base3',   'base01'],
		\ 'N': ['base02',  'base01'],
		\ }),
	\
	\ Pl#Hi#Segments(['lustyexplorer:SPLIT', 'minibufexplorer:SPLIT', 'nerdtree:SPLIT', 'tagbar:SPLIT'], {
		\ 'n': ['base2',  'base2'],
		\ 'N': ['base2',  'base2'],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:focus', 'ctrlp:byfname'], {
		\ 'n': ['base03', 'base01'],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:prev', 'ctrlp:next', 'ctrlp:pwd'], {
		\ 'n': ['base3', 'base00'],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:item'], {
		\ 'n': ['base3', 'violet', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:marked'], {
		\ 'n': ['base1', 'base01', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:count'], {
		\ 'n': ['base3', 'violet'],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:SPLIT'], {
		\ 'n': ['base3', 'base03'],
		\ }),
	\ ])
