Catacomb Wall Plaques
=====================

File Info
---------

Verion: 1.1.0
Date: 2012-12-07
Author: John Wordsworth
Copyright: John Wordsworth 2012


Introduction
------------

This pack introduces a new model for presenting wall text to players in 
Legend of Grimrock Mods. These plaques are designed to be used above slots
in catacombs and can be layered on top of a catacomb wall piece to provide
wall text that can be used in conjunction with custom alcoves for instance.


Installation
------------

Using these custom assets in your own mod simply requires you to...

1. Unzip this folder into your mod assets folder so that you should have
the following in your dungeon folder;

> mod_assets/wall_plaques/<files>

2. Add the following line to your mod_assets/init.lua file.

> import "mod_assets/wall_plaques/scripts/wall_plaques.lua"

3. Reload your dungeon in the editor and look for the following new items;

* dungeon_catacomb_plaque_<high/low>: Intended for placing on dungeon catacombs.
* temple_catacomb_plaque_<high/low>: Intended for placing on temple catacombs.
* <wallset>_wall_plaque: A conveniently placed wall plaque for use on standard walls.
* <above_name>_weathered: Each object has a weathered version for a more authentic look.


Uninstallation
--------------

If you decide that you no longer need these assets in your dungeon, you should...

1. Delete all instances of these assets from your dungeon. Do this first otherwise 
your dungeon will not load afterwards and you will have to fix dungeon.lua manually.

2. Delete the line relevant import line from your init.lua file.

>  import "mod_assets/wall_plaques/scripts/wall_plaques.lua"

3. Delete the folder mod_assets/wall_plaques from your mod directory and reload your dungeon.


Change Log
----------

Version 1.1.0: Added weathered texture and _weathered versions of all objects.


Contact Me
----------

You can get in touch with me through the Legend of Grimrock forums where my username
is JohnWordsworth. Alternatively, you can contact me through my blog.

> http://www.grimrock.net/forums - Legend of Grimrock Forums

> http://www.johnwordsworth.com - My Personal Blog


Liscense / Usage
----------------

You are free to use these assets in any Legend of Grimrock Mod. All I ask is that you 
give me any credit if you do.
