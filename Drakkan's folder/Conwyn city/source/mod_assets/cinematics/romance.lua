enableUserInput()
startMusic("mod_assets/sounds/tavernsad.ogg")


-- show the story text
showImage("mod_assets/cinematics/romance1.tga")
fadeIn(2)
textWriter([[
										With whole Guild at your back, you have escaped together. 
										Hunted, you new adventure begin. But thats another story.

													The End



]])
click()
fadeOutText(0.5)
textWriter([[


										Welcoming any ideas for improvements.

										Thanks Skugg for this amazing tileset
										and thomson for scripting help.

]])
fadeOutText(0.5)
fadeOut(4)
fadeOutMusic(3)