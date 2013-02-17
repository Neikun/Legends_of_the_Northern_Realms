enableUserInput()
startMusic("mod_assets/sounds/tavernsad.ogg")


-- show the story text
showImage("mod_assets/cinematics/intro1.tga")
fadeIn(2)
textWriter([[
Guild master is not pleased... You need take revenge. Its not only personal !
With new Assasin in your party your hunting journey is to begin.
But thats another story.


The End


Welcoming any ideas for improvements.

Thanks Skugg for this amazing tileset
and thomson for scripting help.

]])
click()
fadeOutText(0.5)
fadeOut(4)
fadeOutMusic(3)