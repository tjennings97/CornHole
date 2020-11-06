//Author: Tamara Jennings
//Creation Date: April 17, 2020
//Due Date: May 7, 2020
//Course: Spring 2020 CSC 480
//Professor: Dr. Parson
//Assignment: #5
//Filename: CornHole.pde
//Purpose: Interactive corn hole game

import java.util.LinkedList ;

PImage intro, points, scales, winner, loser;
float h = 675.0; //height of the screen
float w = 675.0; //width of the screen
float viewh = h-h/6; //height of the screen, excluding the scales
PImage bg; 

Direction direction = new Direction();
Angle angle = new Angle();
Power power = new Power();
Bag bag = new Bag();

boolean angleOff = true; //angle selector on/pff
boolean directionOff = true; //direction selector on/off
boolean gameOn = false; //game in progress
boolean instructions = true; //show directions
boolean powerOff = true; //power selector on/off
boolean showBoardBags = false; //thrown bags shown on board
boolean throwBag = false; //show toss
boolean showWinner = false; //show winner tile
boolean showLoser = false; //show loser tile
int instCount = 0; //keep track of place in instructions
int spaceCount = 0; //keep track of place in selectors

int tossCount = 0; //keep track of tosses
int tossPoints = 0; //score of individual toss
int score = 0; //keep track of game score
int remainingTosses = 9; //keep track of remaining tosses

float targetX = 0; //value of direction selector, x-coordinate of landing point
float targetY = 0; //y-coordinate of landing point
float targetZ = 0; //value of calcLandingZ method, z-coordinate of landing point
float maxHeightY = 0; //value of calcMaxHeightY, y-coordinate of max height of arc
float maxHeightZ = 0;

//Linked lists for x-, y-, z- coordinates of landing points of bags during a game
LinkedList<Float> xValues = new LinkedList<Float>();
LinkedList<Float> yValues = new LinkedList<Float>();
LinkedList<Float> zValues = new LinkedList<Float>();

//Constants
final float startingHeight = 180; //height of release point - hip height not the ground
final float velocityMax = 87.11; 
final float velocityMin = 78.37;  

/*
Goal: 
    Score 15 points in 9 or fewer tosses
Keys:
    'I' or 'i' - show instructions
        This causes the game to reset
        Can be pressed at any time
            Will not return to beginning if pressed while instructions are displayed
    'N' or 'n' - start new game 
        This causes the game to reset   
        No action occurs if pressed while instructions are displayed
    ' ' - start and stop selectors  
        No action occures while instructions are displayed
    RIGHT arrow key - parse through instructions
        No action occurs unless instructions are displayed
*/

//Method name: setup
//Description: according to proccessing website - "used to define initial enviroment 
//  properties such as screen size and to load media such as images and fonts as the 
//  program starts."
//Parameters: none
//Return value: none
void setup() {
  size(675, 675, P3D); //do not change this, not scalable
  bg = loadImage("backyard2.png");
  background(bg);
  frameRate(30);
  textAlign(CENTER);
  viewGame();
  
  intro = loadImage("intro.png"); //450px x 262.5px
  points = loadImage("points.png");
  scales = loadImage("selectors.png");
  winner = loadImage("winner.png");
  loser = loadImage("loser.png");
}

//Method name: draw
//Description: according to processing website - "continuously executes the lines of code 
//  contained inside its block"
//Parameters: none
//Return value: none
void draw() {
  userView();
  push(); 
  
  if(instructions == true && instCount == 0) { //show instructions
    image(intro, -225, -131.25);
  }
  if(angleOff == false) { //angle selector moving
    translate(-w/2, -7*h/12, 0); //get back to center
    angle.display();
    angle.move();
    //make sure selector arrow is between 0 and 45 degrees
    if (angle.getArrowAngle() == 0.0 || angle.getArrowAngle() == 45.0){
      angle.setAngleChange(angle.getAngleChange()*-1);
    }
  }
  if(directionOff == false) { //direction selector moving
    translate(-w/2, -7*h/12, 0); //get to Angle block
    translate(w/3,0,0);
    direction.display();
    direction.move();
    //make sure selector cirecle is between line endpoints
    if (direction.getx() == 25.0 || direction.getx() == 200.0){
      direction.setdx(direction.getdx()*-1);
    }
  }
  if(powerOff == false) { //power selector moving
    translate(-w/2, -7*h/12, 0); //get to Angle block
    translate(2*w/3,0,0);
    //translate(w/3,0,0);
    power.display();
    power.move();
    //make sure selector triangle is within outline triangle
    if (power.getScale() == .1 || power.getScale() == 1){
      power.setScaleChange(power.getScaleChange()*-1);
    }
  }
  
  if(throwBag == true) { //bag moving after selectors are stopped
    depthViewFromUserView();
    push(); 
    bag.move();
    bag.display();
    pop();
    if(ceil(bag.gety()) >= maxHeightY) {
      bag.setGoingUp(false);
    }
    if (targetX > 0) { //if direction value is negative
      if(bag.getx() >= targetX || bag.getz() >= targetZ) { //if bag movement is complete
        throwBag = false;
        showBoardBags = true;
        viewGame();
      }
    }
    else { //if direction value is positive
      if(bag.getx() <= targetX || bag.getz() >= targetZ) { //if bag movement is complete
        throwBag = false;
        showBoardBags = true;
        viewGame();
      }
    }
    userView();
  } //end if(throwBag == true)
  if(showBoardBags == true) { //after bag movement is complete
    calcPoints();
    remainingTosses -= 1;
    showStats();
    
    //loop through linked lists to show all bags on the board
    for (int i = 0; i < xValues.size(); i++) { 
      fill(#000ff0);
      depthViewFromUserView();
      translate(xValues.get(i),yValues.get(i),zValues.get(i));
      rectMode(CENTER);
      rotateX(PI/2);
      rect(0,0,45,45);
      rotateX(-PI/2);
      rectMode(CORNER);
      translate(-xValues.get(i),-yValues.get(i),-zValues.get(i));
    }
    showBoardBags = false;
    if(remainingTosses == 0 && score < 15) {
      showLoser = true;
    }
    if(score >= 15) {
      showWinner = true;
    }
  } //end if(showBoardBags == true)
  if(showWinner == true) { //if winner
    userView();
    image(winner, -225, -131.25);
    showWinner = false;
    gameOn = false;
    reset();
  }
  if(showLoser == true) { //if loser
    userView();
    image(loser, -225, -131.25);
    showLoser = false;
    gameOn = false;
    reset();
  }
  pop();
} //end draw()

//Method name: keyPressed
//Description: determines what happens when a key is pressed, depending on the value of 
//  the key
//Parameters: none
//Return value: none
void keyPressed() {
  if (keyCode == RIGHT && instructions == true) { //parse through instructions
    if (instCount == 0) { //show 2nd instruction tile
      instCount ++;
      image(scales, -225, -131.25);
    }
    else if (instCount == 1 && instructions == true) { //show 3rd instruction tile
      instCount++;
      image(points, -225, -131.25);
    }
    else { //remove instructions from screen, reset game
      if(instructions == true) {
        instCount = 0;
        instructions = false;
        viewGame();
        gameOn = true;
        showStats();
      }
    } 
  }
  if (key == 'I' || key == 'i') { //show 1st instruction tile, causes game to reset
    instructions = true;
    instCount = 0;
    gameOn = false;
    reset();
  }
  if(key == ' ') { //start & stop selectors
    if (gameOn == true){
      if(spaceCount == 0 && instructions == false) { //angle selector
        angleOff = false;
        spaceCount++;
      }
      else if(spaceCount == 1) { //direction selector
        angleOff = true;
        translate(w/2, 7*h/12, 0); //get back to center
        directionOff = false;
        spaceCount++;
      }
      else if(spaceCount == 2) { //power selector
        directionOff = true;
        translate(w/2, 7*h/12, 0); //get back to center
        translate(-w/3,0,0);
        powerOff = false;
        spaceCount++;
      }
      else { //all selections made
        translate(w/2, 7*h/12, 0); //get to Angle block
        translate(-w/3,0,0);
        translate(-w/3,0,0);
        spaceCount = 0;
        tossCount++;
        bagStats();
        powerOff = true;
        throwBag = true;
      }
    }
  }
  if(key == 'N' || key == 'n'){ //start a new game
    if(instructions != true) {
      reset();
      viewGame();
      gameOn = true;
      showStats();
    }
  }
}

//Method name: reset
//Description: reset screen and set gamekeeping variables back to default, new game ready
//Parameters: none
//Return value: none
void reset() {
  angleOff = true;
  directionOff = true;
  powerOff = true;
  showBoardBags = false;
  throwBag = false;
  angle.constructor();
  bag.constructor();
  direction.constructor();
  power.constructor();
  instCount = 0;
  spaceCount = 0;
  
  tossCount = 0;
  tossPoints = 0;
  score = 0;  
  remainingTosses = 9;
  
  targetX = 0;
  targetY = 0;
  targetZ = 0;
  maxHeightY = 0;
  maxHeightZ = 0;
  xValues.clear();
  yValues.clear();
  zValues.clear();
}

//Method name: depthView
//Description: adjust coordinate plane so that the camera views the game properly and
//  the point (0,0,0) is in the center of the screen
//Parameters: none
//Return value: none
void depthView() {
  translate(w/2, h/2, 0);
  camera(0, -h/3, (h/2.0) / tan(PI*30.0 / 180.0), 0, -h/3, 0.0, 
    0.0, 1.0, 0.0);
  rotateX(PI-PI/6);
}

//Method name: depthViewFromUserView
//Description: adjust coordinate plane so that the camera views the game properly and
//  the point (0,0,0) is in the center of the portion of the screen ABOVE the selectors
//Parameters:
//Return value:
void depthViewFromUserView() {
  translate(0, viewh/2, 0);
  camera(0, -h/3, (h/2.0) / tan(PI*30.0 / 180.0), 0, -h/3, 0.0, 
    0.0, 1.0, 0.0);
  rotateX(PI-PI/6);
}

//Method name: userView
//Description: adjust coordinate plane so that the camera views the game properly and 
//  the point (0,0,0) is at the top of the selector boxes and in the center of the width
//Parameters: none
//Return value: none
void userView() {
  camera(0, -h/3, (h/2.0) / tan(PI*30.0 / 180.0), 0, -h/3, 0.0, 
    0.0, 1.0, 0.0);
  rotateY(PI);
  rotateZ(PI);
  rotateX(PI);
  translate(0, (-viewh/2), 0);
  rotateX(PI);
}

//Method name: viewGame
//Description: show all game items
//Parameters: none
//Return value: none
void viewGame(){
  background(bg);
  //change view angles to allow for depth
  depthView();
  
  //Playing field
  translate(0,0,700); //move up z-axis for depth
  
  //corn hole board
  stroke(0);
  strokeWeight(5);
  fill(153, 102, 51);
  box(180, 22.50, 360);
  
  //grass landing zone
  rotateX(PI/2); //so rectangle is flat on z-axis
  strokeWeight(1);
  fill(0, 153, 0);
  rect(-135,-220,270,450); //create a 45p border for board
  rotateX(-PI/2); //return rotation back to normal
  translate(0,0,-700); //return to starting point
  
  //corn hole board hole
  strokeWeight(1);
  translate(0, 22.5, 790);
  fill(0);
  rotateX(PI/2); //so circle is flat on z-axis
  ellipse(0,0,60,60);
  rotateX(-PI/2); //return rotation back to normal
  translate(0,-22.5,-790); //return to starting point

  //Scales
  strokeWeight(2.5);
  stroke(255);
  rotateX(-(PI-PI/6));
  rotateY(PI);
  rotateZ(PI);
  
  //Angle
  translate(-w/2,-h/6,0);
  angle.angleBox();
  
  //Direction
  translate(w/3,0,0);
  direction.directionBox();
  
  //Power
  translate(w/3,0,0);
  power.powerBox();

  //return to initial placement of coordinate (0,0,0)
  translate(-w/3,0,0);
  translate(-w/3,0,0);
  translate(w/2,h/2,0);
  translate(w/2,h/6,0);
}

//Method name: bagStats
//Description: calculate locations of max Height and landing point
//Parameters: none
//Return value: none
void bagStats() {
  targetX = calcDirection(); //landing x
  targetZ = calcLandingZ(angle.getArrowAngle(), calcPower()); //landing z
  if ((targetX >= -90 && targetX <= 90) && (targetZ >= 520 && targetZ <=880)) {
    targetY = 22.5; //landing y, to show above board
  }
  else {
    targetY = 0;
  }
    
  maxHeightY = calcMaxHeightY(angle.getArrowAngle(), calcPower()); //max height y
  maxHeightZ = calcMaxHeightZ(angle.getArrowAngle());
  xValues.add(targetX);
  yValues.add(targetY);
  zValues.add(targetZ);
  
  bag.constructor();
  //divide dx, dy, dz by 10 to show bag in 10 places on path toward board
  //  - distance between 10 places will be smaller for shorter throws
  //  - distance between 10 places will be larger for farther throws
  bag.setdx(targetX / 10);
  bag.setdy1((maxHeightY -180)/ 5);
  bag.setdy2(maxHeightY / 5);
  bag.setdz1(maxHeightZ / 5);
  bag.setdz2((targetZ - maxHeightZ) /5);
  bag.setTargetX(targetX);
  bag.setTargetY(targetY);
  bag.setTargetZ(targetZ);
  bag.setMaxHeightY(maxHeightY);
}

//Method name: calcPower
//Description: calculate the selected power by fitting the scale of the velocityMin and 
//  velocityMax values onto the selector scale
//Parameters: none
//Return value: float tossPower - result of the calculations, the selected toss power
float calcPower() {
  float maxVelocityLength = velocityMax - velocityMin;
  float maxSideLength = power.getMaxSideLength();
  float stoppedSideLength = power.getSideLength();
  //proportion => (maxVelocityLength / maxSideLength) = (stoppedVelocityLength / stoppedSideLength)
  float stoppedVelocityLength = maxVelocityLength * stoppedSideLength / maxSideLength;
  float tossPower = velocityMin + stoppedVelocityLength;
  return tossPower;
}

//Method name: calcDirection
//Description: calculate the selected direction by fitting the scale of the selector width
// to the scale of the width of the grass landing zone
//Parameters: none
//Return value: float tossDirection - result of the calculations, the selected toss direction
float calcDirection(){
  //minField is most left point of grass landing zone box
  //fieldWidth is grass landing zone width
  float minField = -135; 
  float fieldWidth = 270;
  float maxDirectionWidth = 175;
  float stoppedDirectionWidth = direction.getx() - 25;
  //proportion => (fieldWidth / maxDirectionWidth) = (stoppedFieldWidth / stoppedDirectionWidth)
  float stoppedFieldWidth = fieldWidth * stoppedDirectionWidth / maxDirectionWidth;
  float tossDirection = minField + stoppedFieldWidth;
  return tossDirection;
}

//Method name: calcLandingZ
//Description: calculate the distance (z-coordinate of landing point) of the toss based
// on projectile motion equations using angle and velocity (power)
//Parameters: float tossAngle - angle
//            float tossPower - velocity
//Return value: float landingZ - result of calculations, z-coordinate of landing point
float calcLandingZ(float tossAngle, float tossPower) {
  float landingZ = (tossPower * cos(radians(tossAngle))) * ((-tossPower * sin(radians(tossAngle)) - sqrt(pow((tossPower *sin(radians(tossAngle))),2) + 3528))/-9.8);
  return landingZ;
}

//Method name: calcMaxHeightY
//Description: calculate the highest point of toss arc based on projectile motion 
//  equations using angle and velocity (power)
//Parameters: float tossAngle - angle
//            float tossPower - velocity
//Return value: float maxY - result of calculations, the highest point of toss arc
float calcMaxHeightY(float tossAngle, float tossPower) {
  float heightY = ((tossPower * tossPower) * sin(radians(tossAngle))*sin(radians(tossAngle))) / (2*9.8);
  float maxY = heightY + startingHeight;
  return maxY; 
}

//Method name: calcMaxHeightZ
//Description : calculate the z-coordinate of the bag when it is at the highest point
//  of its toss arc using law of sines
//Parameters: float tossAngle - angle
//Return value: float maxZ - result of calculation, z-coordinate of highest point
float calcMaxHeightZ(float tossAngle) {
  float maxZ = ((maxHeightY-180)*sin(radians(90-tossAngle)))/sin(radians(tossAngle));
  return maxZ;
}

//Method name: calcPoints
//Description: determine if the bag landed on the hole, on the board, or on the grass and
// assign points to the toss and add them to the overall score
//Note: this will be based on the location of the center point of the bag
//Parameters: none
//Return value: none
void calcPoints() {
  if ((sq(-targetX)) + (sq(targetZ-790) ) < sq(30)) //3600
    tossPoints = 3;
  else if ((targetX >= -90 && targetX <= 90) && (targetZ >= 520 && targetZ <=880)) 
    tossPoints = 1;
  else 
    tossPoints = 0;
  score += tossPoints;
}

//Method name: showStats
//Description: draw scoreboard and show points and remaining tosses
//Parameters: none
//Return value: none
void showStats() {
  userView();
  rotateZ(PI);
  rotateY(PI);
  translate(0,viewh/2);
  fill(255);
  stroke(0);
  rect(-72, -72, 72, 72);
  rect(-72, -108, 72, 36);
  rect(0, -72, 72, 72);
  rect(0, -108, 72, 36);
  fill(0);
  textSize(32);
  text(score, -32, -16);
  text(remainingTosses, 32, -16);
  textSize(16);
  text("Score", -36,-84);
  textSize(12);
  text("Tosses\nLeft", 36, -96);
  translate(0,-viewh/2);
  rotateY(-PI);
  rotateZ(-PI);
  stroke(255);
}
