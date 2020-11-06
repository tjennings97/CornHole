//Author: Tamara Jennings
//Creation Date: April 18, 2020
//Due Date: May 7, 2020
//Course: Spring 2020 CSC 480
//Professor: Dr. Parson
//Assignment: #5
//Filename: Angle.pde
//Purpose: Interactive corn hole game - Angle class

public class Angle {
  private float angleChange = 1.0;
  private float arrowAngle = 0.0;
  private PShape  arrow, line1, line2, line3;
  
  //Method name: constructor
  //Description: initialize variables
  //Parameters: none
  //Return value: none
  public void constructor() {
    angleChange = 1.0;
    arrowAngle = 0.0;
    //angleBox();
  }
  
  //Method name: move
  //Description: move angle of arrow
  //Parameters: none
  //Return value: none
  public void move() {
    arrowAngle += angleChange;
  }
  
  //Method name: getArrowAngle
  //Description: provide current angle of arrow
  //Parameters: none
  //Return value: float - current value of arrowAngle 
  public float getArrowAngle() {
    return this.arrowAngle;
  }
  
  //Method name: getAngleChange
  //Description: provide current direction of angle change - pos/neg
  //Parameters: none
  //Return value: float - current value of angleChange 
  public float getAngleChange() {
    return this.angleChange;
  }
  
  //Method name: setAngleChange
  //Description: change the direction of the angle change - pos/neg
  //Parameters: float angleChange - pos/neg of current direction
  //Return value: none
  public void setAngleChange(float angleChange){
    this.angleChange = angleChange;
  }
  
  //Method name: angleBox
  //Description: draw box that contains the angle selector
  //Parameters: none
  //Return value: none
  public void angleBox() {
    //scale box
    fill(0);
    rect(0,0,w/3, w/6);
    line(w/6-37.5, 25, w/6+37.5, 25);
    line(w/6-37.5, 25, w/6+37.5, 100);
    arc(w/6-37.5, 25, 50, 50, 0, QUARTER_PI);
  }
  
  //Method name: display
  //Description: show angle box and angle selector according to current values
  //Parameters: none
  //Return value: none
  public void display() {
    angleBox();
    
    //arrow shape
    stroke(#ff0000);
    translate(w/6-37.5, 25, 0);
    rotate(radians(arrowAngle));
    translate(-w/6-37.5, -25, 0);
    arrow = createShape(GROUP);
    line1 = createShape(LINE, w/6-37.5, 25, w/6+37.5, 25);
    line2 = createShape(LINE, w/6+37.5, 25, w/6+30.5, 35);
    line3 = createShape(LINE, w/6+37.5, 25, w/6+30.5, 15);
    arrow.addChild(line1);
    arrow.addChild(line2);
    arrow.addChild(line3);
    shape(arrow, w/6-37.5, 0);
    stroke(255);
  }
  
}
