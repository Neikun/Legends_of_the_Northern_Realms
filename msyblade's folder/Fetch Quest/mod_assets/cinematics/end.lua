enableUserInput()
startMusic("mod_assets/sounds/intro.ogg")


showImage("assets/textures/cinematic/intro/page02.tga")
fadeIn(2)

-- show the title text
sleep(1)
setFont("IntroTitle")
showText("The End", 3)
sleep(2)
fadeOutText(1)

-- show the story text
sleep(1)
setFont("Intro")
textWriter([[

Thanx for checkin it out! Tell me what you think.


]])
click()
fadeOutText(0.5)

fadeOut(4)
fadeOutMusic(3)
