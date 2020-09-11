# ARK Crafting Cost Override Tool
This is a simple script that, when ran, will generate the override codes that should be placed in the Game.ini file on your ARK server, for the following materials and structures:

### Materials 
- Wood
- Stone
- Greenhouse

### Structures 
- Foundations
- Pillars
- Walls
- Window Walls
- Railings
- Ceilings
- Doors and Double Doors
- Door and Double Door Frames

The script is hopefully easy to skim over, even if you are not into coding. While I probably did far from a perfect job in the last 10 hours I non-stop-slapped this together, I tried to make it easy to understand, without relying too heavily on comments. A lot of my design and syntax and style choices were with 'noob eyes' in mind. I might have made some things too complicated, some things too simple, or I might have stylistic inconsistencies that make it hard to read, but I think you will agree with me on this:

This script is not trying to make http calls, access the internet, change any files on your system (besides the creation of 'configOverrides.txt' which is where you copy the settings from to go into your Game.ini), or anything weird or hackery. It's just making a file for you. A plain text file.

I'm only bringing this up because I felt like a lot of the tools out there for this sort of thing involve going to 'strange' websites, where I feel users are inherently more at risk. You can use this tool offline. 

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

The initial functionality suits my personal needs, but I enjoy working on this, and so I set out with the intention to build this in a way that can be built upon to make it more holistic, and smarter. Some ideas I'm kicking around to implement:

- I wrote this on a mac, and don't have a windows machine at my disposal... if anyone thinks this is worth the time to do a Windows compatible refactor in the short term, that'd be great, otherwise I will eventually update this to detect OS/UNIX/POSIX/etc to be easier and more inclusive

- a 'furniture' toggle, to make the more decorative items (only, if you want) cheaper. Items like the table, chair, bench, etc.

- adding the rest of the items available in the existing materials affected, and abstract them into heirarchical groups for better customization and control... like maybe 'foundational' items crucial to snap points would be a group, walls and ceilings another, and exotic walls, ceilings, corners, etc., another

- arg/flag functionality to specify material types or structures to ignore/include

- arg/flag functionality to treat materials differently, e.g. reduce stone by 50% and wood by 25% but leave everything else alone