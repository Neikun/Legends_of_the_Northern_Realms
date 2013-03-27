So this idea is an unconventional way to conserve space in the outdoor environments for giving
you the feel you are traveling for more than 32 spaces in one direction, but the design is still contained
in one level of the editor.

in the Travel_Lvl_BetterExample.png in my folder on git is a pic of how this might work.  
Mahric has a hidden teleporter for traveling to Uttermost in his latest dialogTest.dat; 
the blue squares in the pic represent these kind of teleporters.
An example this could be in the endless tundra up north.  You walk for 30 spaces in a waste land then walk into
Mahric's teleporter which continues the path to the next 30 spaces where you walk into another teleporter.  The 
next 30 spaces in the same direction may contain some open spaces etc. so it isn't so boring--a fight area maybe.
Then you continue on your journey on this endless tundra road for another 30 spaces, walk into another Mahric teleporter
and you walk another 30 spaces and the above is repeated.  This is all contained in one level on editor.
My example is going west to east for a total of 270 spaces with some turns and open areas--all contained in the same
level.  I think this unconventional method could save us valuable space while giving the player the feel it is
an open large world.


Another item that I think we should include, talking with Georges Dimitrov, is an overworld map to show you where you are
in the Nothern Realms.

#### Conversation with Georges about this #####

[10:32:08 PM] Arkos: On another note, I'm going to post on github an unconventional way to conserve space on the levels 
for outside environments.  Example is you are on a road that goes straight for about 60-90 spaces; 
well, a level is 32x32  so on top of the editor, do a 30 space road with a teleporter like Mahric's in his latest .dat in his folder, 
then under that put another 30 space road with a teleporter at the end of that anything else would be contained in the level for 
that 60-90 space road environment.
[10:33:52 PM] Arkos: I'm going to put up a pic of what I'm talking about.  
I have a pic in my folder of the idea which goes 420 spaces in a straight line, Neikun said that would be borrowing, 
so I thought a hybrid of being able to go straight for more than 32 spaces could be done in the same level
[10:35:38 PM] Georges Dimitrov: Yes, definitely. The only potential problem is that it will look wierd on the automap... 
but I think we'll have to accept that the automap will be off sometimes.
[10:36:32 PM] Arkos: :D  true.  I think we'll also need another map for where we are at in the overworld
[10:38:04 PM] Georges Dimitrov: Adding a new map shouldn't be a problem once we get the gui framework ready 
from the Xanathar/jKos/thomson team. But I don't think we can override the standard automap.