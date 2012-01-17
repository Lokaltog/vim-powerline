=================
Powerline for vim
=================

:Author: Kim Silkebækken (kim.silkebaekken+vim@gmail.com)
:Source: https://github.com/Lokaltog/vim-powerline
:Version: β

Introduction
------------

Powerline is a utility plugin which allows you to create better-looking, 
more functional vim statuslines. See the screenshots below for 
a demonstration of the plugin's capabilities.

It's recommended that you install the plugin using Pathogen_ or Vundle_.  
After the plugin is installed update your help tags and see ``:help 
Powerline`` for instructions on how to enable and configure the plugin.

See the `Troubleshooting`_ section below if you're having any issues with 
the plugin or the font patcher.

**Note:** You need a patched font to be able to use the symbols in the 
statusbar. An experimental Python/fontforge-based font patcher is included 
in the ``fontpatcher`` directory. See ``fontpatcher/README.rst`` for usage 
instructions.

.. _Pathogen: https://github.com/tpope/vim-pathogen
.. _Vundle: https://github.com/gmarik/vundle

Important information about caching
-----------------------------------

Powerline caches the statuslines in ``/tmp/Powerline.cache`` or 
``$TEMP/Powerline.cache``. **Please remember to delete the cache file after 
updating Powerline, after modifying your statusline theme or after changing 
the font settings!** See ``:help Powerline_cache_file`` for more info about 
the cache file.

Screenshots
-----------

**Normal mode**

.. image:: http://i.imgur.com/xFmOt.png

**Insert mode**

.. image:: http://i.imgur.com/5vDlB.png

**Command-T buffer** with custom color

.. image:: http://i.imgur.com/fDIhz.png

**Tagbar buffer** with custom color

.. image:: http://i.imgur.com/WZUvj.png

**Symbols when buffer is modified or read-only**

.. image:: http://i.imgur.com/dGJHZ.png

**Split window showing inactive buffer statusline**

.. image:: http://i.imgur.com/z18KU.png

**Normal mode without custom font**

.. image:: http://i.imgur.com/yCybn.png

Troubleshooting
---------------

I can't see the fancy symbols, what's wrong?
    Make sure that you have ``let g:Powerline_symbols = 'fancy'`` in your 
    ``vimrc`` file. The settings may be loaded too late if you have this in 
    ``gvimrc``, so always put this in your ``vimrc``.

    Delete the cache file (default location is ``/tmp/Powerline.cache``).

    Make sure that you've configured gvim or your terminal emulator to use 
    a patched font.

I'm unable to patch my font, what should I do?
    Font patching is only known to work on most Linux and OS X machines. If 
    you have followed the instructions in the fontpatcher README and still 
    have problems, please submit an issue on GitHub.

    You can download some community-contributed patched fonts from the 
    `Powerline wiki`_ if you don't want to mess around with the font 
    patcher.

The Syntastic/Fugitive statusline flags don't work!
    These flags should work without any configuration. If you installed 
    either plugin after Powerline, you'll have to delete the Powerline cache 
    file.

The colors are weird in the default OS X Terminal app!
    The default OS X Terminal app is known to have some issues with the 
    Powerline colors. Please use another terminal emulator. iTerm2 should 
    work fine.

The statusbar is hidden/only appears in split windows!
    Make sure that you have ``set laststatus=2`` in your ``vimrc``.

If you have any other issues and you can't find the answer in the docs, 
please submit an issue on GitHub.

.. _`Powerline wiki`: https://github.com/Lokaltog/vim-powerline/wiki/Patched-fonts
