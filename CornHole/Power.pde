//Author: Tamara Jennings
//Creation Date: April 19, 2020
//Due Date: May 7, 2020
//Course: Spring 2020 CSC 480
//Professor: Dr. Parson
//Assignment: #5
//Filename: Power.pde
//Purpose: Interactive corn hole game - Power class

public class Power{
  private float scale = 1.0;
  private float scaleChange = 1;
  private float powerW = 75;
  private float powerH = 75;
  
  //Method name: constructor
  //Description: initialize variables
  //Parameters: none
  //Return value: none
  public void constructor() {
    scale = 1.0;
    scaleChange = 1;
    powerW = 75;
    powerH = 75;
  }
  
  //Method name: move
  //Description: change size of inner triangle
  //Parameters: none
  //Return value: none
  public void move() {
    scale *= 10;
    scale -= scaleChange;
    scale = scale/10;
  }
  
  //Method name: getScale
  //Description: provide current scale of inner triangle
  //Parameters: nont
  //Return value: float - current value of scale
  public float getScale(){
    return this.scale;
  }
  
  //Method name: getScaleChange
  //Description: provide current rate of change of scale
  //Parameters: none
  //Return value: float - current value of scaleChange
  public float getScaleChange(){
    return this.scaleChange;
  }
  
  //Method name: setScaleChange
  //Description: change the scale of the triangle to become larger/smaller
  //Parameters: float scaleChange - pos/neg of current scale
  //Return value:  none
  public void setScaleChange(float scaleChange) {
    this.scaleChange = scaleChange;
  }
  
  //Method name: getSideLength
  //Description: provide size of inner triangle side length
  //Parameters: none
  //Return value: float - size of outer triangle multiplied by current scale
  public float getSideLength() {
    return this.powerW * scale;
  }
  
  //Method name: getMaxSideLength
  //Description: provide size of outer triangle side length
  //Parameters: none
  //Return value: float - value of powerW
  public float getMaxSideLength() {
    return this.powerW;
  }
  
  //Method name: powerBox
  //Description: draw box that contains the power selector
  //Parameters: none
  //Return value: none
  public void powerBox() {
    //scale box
    fill(0);
    rect(0,0,w/3, w/6);
    triangle(w/6-37.5, 25, w/6+37.5, 25, w/6+37.5, 100);
  }
  
  //Method name: display
  //Description: show power box and power selector according to current values
  //Parameters: none
  //Return value: none
  public void display(){
    powerBox();
    
    //triangle shape
    translate(w/6-37.5, 25, 0);
    fill(#ff0000);
    triangle (0, 0, powerW*scale, 0, powerW*scale, powerH*scale);

    translate(-w/6-37.5, -25, 0);
  }
}
