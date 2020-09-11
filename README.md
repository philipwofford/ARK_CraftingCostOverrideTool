# ARK Crafting Cost Override Tool
This is a simple script that, when ran, will generate the override codes that should be placed in the Game.ini file on your ARK server, for the following materials and structures:

- Wood
- Stone
- Greenhouse

- Foundations
- Pillars
- Walls
- Window Walls
- Railings
- Ceilings
- Doors and Double Doors
- Door and Double Door Frames

## Utility

Currently, if you wanted to play with 50% crafting costs on the items that this generator affects, you would run this code in the terminal:

```bash
# change the permissions
$ chmod +x overridesGenerator.sh
# execute the file with 50 as an argument to mean 50% (defaults to 100 or 100%)
$ ./overridesGenerator.sh 50
# the code for the arg is on line 72 in overridesGenerator.sh
``` 

## Project Goals

The initial functionality suits my personal needs, but I enjoy working on this, and so I set out with the intention to build this in a way that (or others) can build upon it to make it more holistic, and smarter. Some ideas I'm kicking around to implement:

- a 'furniture' toggle, to make the more decorative items (only, if you want) cheaper. Items like the table, chair, bench, etc.

- adding the rest of the items available in the existing materials affected, and abstract them into heirarchical groups for better customization and control... like maybe 'foundational' items crucial to snap points would be a group, walls and ceilings another, and exotic walls, ceilings, corners, etc., another

- arg/flag functionality to specify material types or structures to ignore/include

- arg/flag functionality to treat materials differently, e.g. reduce stone by 50% and wood by 25% but leave everything else alone