int mapHeight = 600;
int mapWidth = 600;
boolean up = false;
boolean left = false;
boolean right = false;
boolean down = false;
boolean hyperspace = false;
SpaceShip battleCruiser = new SpaceShip();

public void setup() 
{
  size(mapHeight, mapWidth);
}
public void draw() 
{
  background(0);
  battleCruiser.show();
  battleCruiser.move();
  if(up == true)
  {
    battleCruiser.accelerate(0.1);
  }
  if(left == true)
  {
    battleCruiser.setPointDirection((int)(battleCruiser.getPointDirection()-5));
  }
  if(right == true)
  {
    battleCruiser.setPointDirection((int)(battleCruiser.getPointDirection()+5));
  }
  if(down == true)
  {
    battleCruiser.accelerate(-0.1);
  }
}
class SpaceShip extends Floater  
{   private double dRadians; 
  public SpaceShip()
  {
    corners = 4;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -10;
    yCorners[0] = -10;
    xCorners[1] = -7;
    yCorners[1] = 0;
    xCorners[2] = -10;
    yCorners[2] = 10;
    xCorners[3] = 10;
    yCorners[3] = 0;

    myColor = color(255,255,255);
    setX((int)(mapWidth/2));
    setY((int)(mapHeight/2));
    setDirectionX(0);
    setDirectionY(0);
    setPointDirection(270);
  }

    public void setX(int x){myCenterX = x;}  
    public int getX(){return (int)(myCenterX);}   
    public void setY(int y){myCenterY = y;}   
    public int getY(){return (int)(myCenterY);}   
    public void setDirectionX(double x) {myDirectionX = x;}   
    public double getDirectionX(){return myDirectionX;}   
    public void setDirectionY(double y) {myDirectionY = y;}   
    public double getDirectionY(){return myDirectionY;}   
    public void setPointDirection(int degrees) {myPointDirection = degrees;}   
    public double getPointDirection(){return myPointDirection;} 
       public void hyperspace()
    {
      setX((int)(Math.random()*width));
      setY((int)(Math.random()*height));
      setDirectionX(0);
      setDirectionY(0);
      setPointDirection((int)(Math.random()*360));
      
    }
}
    
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x); 
  abstract public int getX();  
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    int maxSpeed = 10;
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     
    if(myDirectionX > maxSpeed)
    myDirectionX = maxSpeed;
    if(myDirectionY > maxSpeed)
    myDirectionY = maxSpeed;
    if(myDirectionX < -1 * maxSpeed)
    myDirectionX = -1 * maxSpeed;
    if(myDirectionY < -1 * maxSpeed)
    myDirectionY = -1 * maxSpeed;

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

//class Star
//{
  //myX = (int)(Math.random()*600);
  //myY = (int)(Math.random()*600);
//}

void keyPressed()
{
  if(keyCode == 'W')
  { 
    up = true;
  }
  else if(keyCode == 'A')
  { 
    left = true;
  }
  else if(keyCode == 'D')
  { 
    right = true;
  }
  else if(keyCode == 'S'){
    down = true;
  }
}

void keyReleased(){
  if (keyCode == 'W'){
    up = false;
  }
  else if (keyCode == 'A'){
    left = false;
  }
  else if (keyCode == 'D'){
    right = false;
  }
  else if (keyCode == 'S'){
    down = false;
  }

}
