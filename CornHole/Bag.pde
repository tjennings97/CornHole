//Author: Tamara Jennings
//Creation Date: April 20, 2020
//Due Date: May 7, 2020
//Course: Spring 2020 CSC 480
//Professor: Dr. Parson
//Assignment: #5
//Filename: Bag.pde
//Purpose: Interactive corn hole game - Bag class

public class Bag {
  private float x = 0;
  private float y = 180; //throw from 180 units off the ground
  private float z = 0;
  private float dx = 0;
  private float dy1 = 0;
  private float dy2 = 0;
  private float dz1 = 0;
  private float dz2 = 0;
  private int size = 45;
  private float maxHeightY = 0;
  private float maxHeightZ = 0;
  private float targetX = 0;
  private float targetY = 22.5;
  private float targetZ = 0;
  private boolean goingUp = true;
  
  //Method name: constructor
  //Description: initialize variables
  //Parameters: none
  //Return value: none
  public void constructor() {
    x = 0;
    y = 180;  
    z = 0; 
    dx = 0;
    dy1 = 0;
    dz1 = 0;
    dy2 = 0;
    dz2 = 0;
    size = 45;
    maxHeightY = 0;
    maxHeightZ = 0;
    targetX = 0;
    targetY = 22.5;
    targetZ = 0;
    goingUp = true;
  }
  
  //Method name: move
  //Description: move the location of the bag as it goes through the air
  //Parameters: none
  //Return value: none
  public void move() {
    x+= dx;
    if(goingUp == true) {
      y+= dy1;
      z += dz1;
    }
    else {
      y-= dy2;
      z+= dz2;
    }
  }
  
  //Method name: setdx
  //Description: change the rate of change of the x-coordinate
  //Parameters: float dx - rate of change of the x-coordinate
  //Return value: none
  public void setdx(float dx) {
    this.dx = dx;
  }
  
  //Method name: setdy1
  //Description: change the rate of change of the y-coordinate
  //Parameters: float dy - rate of change of the y-coordinate
  //Return value: none
  public void setdy1(float dy1) {
    this.dy1 = dy1;
  }
  
  //Method name: setdy2
  //Description: change the rate of change of the y-coordinate
  //Parameters: float dy2 - rate of change of the y-coordinate
  //Return value: none
  public void setdy2(float dy2) {
    this.dy2 = dy2;
  }
  
  //Method name: setdz1
  //Description: change the rate of change of the z-coordinate
  //Parameters: float dz - rate of change of the z-coordinate
  //Return value:
  public void setdz1(float dz1) {
    this.dz1 = dz1;
  }
  
  //Method name: setdz2
  //Description: change the rate of change of the z-coordinate
  //Parameters: float dz2 - rate of change of the z-coordinate
  //Return value:
  public void setdz2(float dz2) {
    this.dz2 = dz2;
  }
  
  //Method name: setGoingUp
  //Description: change the rate of change of the x-coordinate
  //Parameters: float dx - rate of change of the x-coordinate
  //Return value: none
  public void setGoingUp(boolean goingUp) {
    this.goingUp = goingUp;
  }
  
  //Method name: setMaxHeightY
  //Description: change the value of maxHeightY to the value of the highest
  //  point of the toss arc
  //Parameters: float maxHeightY - value of highest point of toss arc
  //Return value: none
  public void setMaxHeightY(float maxHeightY) {
    this.maxHeightY = maxHeightY;
  }
  
  //Method name: setMaxHeightZ
  //Description: change the value of maxHeighZY to the value of the highest
  //  point of the toss arc
  //Parameters: float maxHeightZ - value of highest point of toss arc
  //Return value: none
  public void setMaxHeightZ(float maxHeightZ) {
    this.maxHeightZ = maxHeightZ;
  }
  
  //Method name: setTargetX
  //Description: change the value of targetX to the x-coordinate of the landing
  // point
  //Parameters: float targetX - value of x-coordinate of the landing point
  //Return value: none
  public void setTargetX(float targetX) {
    this.targetX = targetX;
  }

  //Method name: setTargetY
  //Description: change the value of targetX to the y-coordinate of the landing
  // point
  //Parameters: float targetY - value of y-coordinate of the landing point
  //Return value: none
  public void setTargetY(float targetY) {
    this.targetY = targetY;
  }
  
  //Method name: setTargetZ
  //Description: change the value of targetZ to the z-coordinate of the landing
  // point
  //Parameters: float targetZ - value of z-coordinate of the landing point
  //Return value: none
  public void setTargetZ(float targetZ) {
    this.targetZ = targetZ;
  }
  
  //Method name: getx
  //Description: get value of current x-coordinate
  //Parameters: none
  //Return value: float - current value of x 
  public float getx() {
    return this.x;
  }
  
  //Method name: getz
  //Description: get value of current z-coordinate
  //Parameters: none
  //Return value: float - current value of z
  public float getz(){
    return this.z;
  }  
  
    
  //Method name: getdy
  //Description: get value of current rate of change of the y-coordinate
  //Parameters: none
  //Return value: int - current value of dx
  public float gety() { 
    return this.y;
  }
  
  //Method name: display
  //Description: show bag at specified location on toss arc
  //Parameters: none
  //Return value: none
  public void display() {
    fill(#0000ff);
    rectMode(CENTER);
    translate(x,y,z);
    rotateX(PI/2);
    rect(0, 0, size, size);
    rotateX(-PI/2);
    translate(-x,-y,-z);
    rectMode(CORNER);
    
  }
}
