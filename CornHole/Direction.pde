//Author: Tamara Jennings
//Creation Date: April 18, 2020
//Due Date: May 7, 2020
//Course: Spring 2020 CSC 480
//Professor: Dr. Parson
//Assignment: #5
//Filename: Direction.pde
//Purpose: Interactive corn hole game - Direction class

public class Direction {
  private float x = 25;
  private float y = 56.25;
  private int dx = 5;
  private int dy = 0;
  private int size = 15;
  
  //Method name: constructor
  //Description: initialize variables
  //Parameters: none
  //Return value: none
  public void constructor() {
    x = 25;
    y = 56.25;
    dx = 5;
    dy = 0;
    size = 15;
  }
  
  //Function name: move
  //Description: move location of circle along selector scale
  //Parameters: none
  //Return value: none
  public void move() {
    y+= dy;
    x+= dx;
  }

  //Method name: setdx
  //Description: change the rate of change of the x-coordinate
  //Parameters: int dx - rate of change of the x-coordinate
  //Return value: none
  public void setdx(int dx) { 
    this.dx = dx;
  }
  
  //Method name: getdx
  //Description: get value of current rate of change of the x-coordinate
  //Parameters: none
  //Return value: int - current value of dx
  public int getdx() { 
    return this.dx;
  }
  
  //Method name: getx
  //Description: get value of current x-coordinate
  //Parameters: none
  //Return value: float - current value of x 
  public float getx() { 
    return this.x;
  }
  
  //Function name: directionBox
  //Description: draw box that contains the direction selector
  //Parameters: none
  //Return value: none
  public void directionBox() {
    //scale box
    stroke(255);
    fill(0);
    rect(0,0,w/3, w/6);
    line(25,56.25,200,56.25);
    line(25,50,25,62.5);
    line(200,50,200,62.5);
  }
  
  //Function name: display
  //Description: show direction box and the direction selector according to 
  //  current values
  //Parameters:
  //Return value:  
  public void display() {
    directionBox();
    
    //circle shape
    fill(#ff0000);
    ellipse (x, y, size, size);
  }
  
}
