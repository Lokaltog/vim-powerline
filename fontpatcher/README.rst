======================
Powerline font patcher
======================

:Author: Kim Silkebækken (kim.silkebaekken+vim@gmail.com)

Description
-----------

This font patcher creates dividers and symbols for use with Powerline. The 
script requires Python 2 and FontForge compiled with Python bindings.

Patched fonts are renamed by default (" for Powerline" is added to the font 
name) so they don't conflict with existing fonts. Use the ``--no-rename`` 
option to disable font renaming.

**Note for Mac users:** The FontForge package in Homebrew isn't compiled 
with Python bindings, and will not work. I haven't been able to find a good 
solution for Mac users, please let me know if you've been able to install 
FontForge with Python bindings and how you did it and I'll update this 
README.

Font patching guide
-------------------

First of all you'll need to patch your font file and ensure that the patched 
font is available in your font path::

    # Patch the font file
    ./fontpatcher MyFontFile.ttf

    # Copy the font file into ~/.fonts
    # This is not needed if the original font already is in this folder
    cp MyFontFile-Powerline.otf ~/.fonts

    # Update font cache
    sudo fc-cache -vf

**Note:** If the font is a pure bitmap font (e.g. a PCF font) it will be 
stored in the BDF format. This is usually not a problem, and you may convert 
the font back to the PCF format using ``bdftopcf`` if you want to. All other 
fonts will be stored in the OTF format regardless of the original format.

After this is done you'll need to update your vim configuration to use the 
new font. You'll also need to add this configuration option to your 
``.vimrc`` file::

    let g:Powerline_symbols = 'fancy'

You may also need to remove the Powerline cache file for the setting to take 
effect. The cache file is located in ``/tmp/Powerline.cache`` by default::

    rm /tmp/Powerline.cache

**Note:** If you use vim in rxvt-unicode in the client/daemon mode, you'll 
need to close all running terminals for the font to be updated.

Glyph table
-----------

All the glyphs are stored in the ``U+2B60``-``U+2BFF`` range ("Misc symbols 
and arrows").

+------------+-------------------+
| Code point | Description       |
+============+===================+
| ``U+2B60`` | Branch symbol     |
+------------+-------------------+
| ``U+2B61`` | LN (line) symbol  |
+------------+-------------------+
| ``U+2B62`` | FT symbol, part 1 |
+------------+-------------------+
| ``U+2B63`` | FT symbol, part 2 |
+------------+-------------------+
| ``U+2B64`` | Padlock (closed)  |
+------------+-------------------+
| ``U+2B80`` | Hard right arrow  |
+------------+-------------------+
| ``U+2B81`` | Soft right arrow  |
+------------+-------------------+
| ``U+2B82`` | Hard left arrow   |
+------------+-------------------+
| ``U+2B83`` | Soft left arrow   |
+------------+-------------------+
