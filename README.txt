//Author: Tamara Jennings
//Creation Date: May 6, 2020
//Due Date: May 7, 2020
//Course: Spring 2020 CSC 480
//Professor: Dr. Parson
//Assignment: #5
//Filename: README.txt
//Purpose: Provide info about corn hole game

Acknowledgements:
    I want to thank my brother, Tristan Jennings, for his help with
    the projectile motion calculations. Tristan is finishing up his 
    freshman year at Temple, where he has learned more than enough 
    physics in his mechanical engineering classes to help me understand 
    how objects move through the air. This would not be the project 
    it is today without his patience and willingness to help his big 
    sister make a basic video game. 

Demo Link: https://youtu.be/vI8p8pg7few

Included:
    - file: EquationsAndFormulas.docx
    - file: README.txt
    - file: CornHoleDiagram.png
    - folder: CornHole
        - Processing Source Code: Angle.pde
        - Processing Source Code: Bag.pde
        - Processing Source Code: CornHole.pde
        - Processing Source Code: Direction.pde
        - Processing Source Code: Power.pde
        - PNG Image: backyard2.png
        - PNG Image: intro.png
        - PNG Image: loser.png
        - PNG Image: points.png
        - PNG Image: selectors.png
        - PNG Image: winner.png

Imports:
    - import java.util.LinkedList ; 
        - used in CornHole.pde
        - linked lists store coordinates of tossed bags

Objective:
    Score 15 points in 9 or fewer tosses

Instructions:
    1. Run CornHole.pde in Processing
    2. Read the instructions that appear on the screen
    3. Use the right arrow > to move through instructions tiles
    4. To start the selectors at the bottom of the screen, hit <SPACE>
    5. Hit <SPACE> to stop a selector's movement
    6. Continue until all selectors have started and stopped
    7. Watch bag move across screen towards playing field
    8. Observe change in score and toss count
    9. Repeat steps 4-8 until the game ends

Keys:
    'I' or 'i' - show instructions
        This causes the game to reset
        Can be pressed at any time    
            - Will not return to beginning if pressed while instructions are 
                displayed 
    'N' or 'n' - start new game 
        This causes the game to reset   
        No action occurs if pressed while instructions are displayed
    ' ' - start and stop selectors  
        No action occures while instructions are displayed
    RIGHT arrow key - parse through instructions
        No action occurs unless instructions are displayed

How the Game is Supposed to Run:
    - After start up, instructions should immediately appear
    - While instructions are displayed, the only key that performs an action
        is RIGHT arrow key
    - There are 3 instruction tiles
    - Start the angle selector by hitting <SPACE>
    - The red angle arrow should move continuously from 0-45 degrees
    - Hitting <SPACE> stops the angle arrow's movement and starts the 
        direction selector's movement
    - The red direction circle should move continuously from left to right on 
        the displayed line segment
    - Hitting <SPACE> stops the direction circle's movement and starts the 
        power selector's movement
    - The red inner triangle should scale continuously, never growing larger 
        than the outer triangle
    - Hitting <SPACE stops the inner triangle's movement and starts the 
        projectile motion of the bag
    - The path of the bag is viewed in 10 steps
        - The first 5 steps show the movement of the bag as it reaches its 
            maximum height
        - The last 5 steps show the movement of the bag as it descends
            toward the playing field
    - Once the bag has landed, the scoreboard will be updated and the bag's
        trail will disappear. The selectors will also be reset.
    - If user reaches 15 points, the winner tile card will appear
    - If the user fails to reach 15 points before completing 9 tosses, the 
        loser tile will appear

How Points are Calculated:
    The location of the bag is based on the center of the bag. This center 
    point must be on or within the boundaries of the board to earn a point.
    To earn 3 points, the center point must be on or within the boundaries of
    the hole. Tosses that land on the grass are worth 0 points.

Physics:
    This game was developed with limits. Every toss lands on the playing field.
    The angle of the toss can only be be between 0-45 degrees. The power (velocity) 
    can only be between 78.37-87.11. The bag can only move left-right so long as it 
    lands within the width of the playing field. 
    If the dimensions of this game were used in real life, it would be huge. The 
    scale is 1px = 1m with the end of the playing field extending 925px in the 
    z-direction.
    The equations that were used in this project are detailed in the file 
    EquationsAndFormulas.docx.

Dimensions:
    Screen: 675 height x 675 width
    Selectors: h/6 height x 675/3 width each, h/6 height x 675 width total
    Height of start of start of toss: 180
    For playing field dimension info & distance see: CornHoleDiagram.png
