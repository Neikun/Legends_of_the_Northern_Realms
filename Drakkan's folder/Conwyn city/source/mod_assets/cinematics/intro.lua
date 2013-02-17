-- opening cinematic with a title and story text
enableUserInput()
startMusic("mod_assets/sounds/tavernsad.ogg")

-- show title
sleep(1)
fadeIn(0.5)
setFont("IntroTitle")
showText("The City of Conwyn", 3)

fadeIn(3)
setFont("Intro")
textWriter([[
exclusively just for LotNR Team :)  beta version
]])

fadeOutText(2)
fadeOut(2)


-- show the story text
showImage("mod_assets/cinematics/intro1.tga")
fadeIn(2)

textWriter([[
There is lots of opportunities in the City of Conwyn. 

Or is said so.

You have decided to grab this opportunity and become rich.

This night will change everything. YOU have chance to change everything.

Good luck !


]])
click()
fadeOutText(0.5)
fadeOut(4)
fadeOutMusic(3)