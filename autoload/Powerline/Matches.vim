let g:Powerline#Matches#matches = {
	\ 'command_t'       : Pl#Match#Add('bufname(winbufnr(a:window))', '^GoToFile$'),
	\ 'bt_help'         : Pl#Match#Add('getwinvar(a:window, "&bt")' , '^help$'),
	\ 'ft_man'          : Pl#Match#Add('getwinvar(a:window, "&ft")' , '^man$'),
	\ 'ft_qf'           : Pl#Match#Add('getwinvar(a:window, "&ft")' , '^qf$'),
	\ 'ft_vimpager'     : Pl#Match#Add('getwinvar(a:window, "&ft")' , 'vimpager'),
	\ 'gundo_preview'   : Pl#Match#Add('bufname(winbufnr(a:window))', '^__Gundo_Preview__$'),
	\ 'gundo_tree'      : Pl#Match#Add('bufname(winbufnr(a:window))', '^__Gundo__$'),
	\ 'lustyexplorer'   : Pl#Match#Add('bufname(winbufnr(a:window))', '\[LustyExplorer\-Buffers\]'),
	\ 'minibufexplorer' : Pl#Match#Add('bufname(winbufnr(a:window))', '^\-MiniBufExplorer\-$'),
	\ 'tagbar'          : Pl#Match#Add('getwinvar(a:window, "&ft")' , '^tagbar$'),
	\ 'nerdtree'        : Pl#Match#Add('getwinvar(a:window, "&ft")' , '^nerdtree$'),
\ }
