PImage cruiser;
int mapHeight = 600;
int mapWidth = 600;
double gravity = 1.015;
boolean up = false;
boolean left = false;
boolean right = false;
boolean down = false;
boolean shoot = false;
boolean hyperspace = false;
SpaceShip battleCruiser = new SpaceShip();
Asteroid asteroid1 = new Asteroid();
Star [] starfield;
ArrayList <Asteroid> asteroidList;
ArrayList <Bullet> bulletList = new ArrayList <Bullet>();

public void setup() 
{
   size(600, 600);
  cruiser = loadImage("cruiser.png");
  starfield = new Star[250];
  for (int i = 0; i <starfield.length; i++){
    starfield[i] = new Star();
  }

  asteroidList = new ArrayList<Asteroid>();
   for (int j = 0; j<50; j++){
    asteroidList.add(new Asteroid());
  }
  System.out.println(asteroidList.size());
}

public void draw() 
{
  background(22,23,36);
 
  for (int i = 0; i < starfield.length; i++){
     starfield[i].show();
  }
  for (int j = 0; j<asteroidList.size(); j++){
    asteroidList.get(j).show();
    asteroidList.get(j).move();
     for (int q = 0; q < bulletList.size(); q++){
      if (dist(asteroidList.get(j).getX(), asteroidList.get(j).getY(), bulletList.get(q).getX(), bulletList.get(q).getY()) < 20){
        bulletList.remove(q);
        asteroidList.remove(j);
        asteroidList.add(new Asteroid());
        break;


      }
    }
    
  }
  for (int h = 0; h < bulletList.size(); h++){
    bulletList.get(h).show();
    bulletList.get(h).move();
  }

  battleCruiser.show();
  battleCruiser.move();


  if(up == true)
  {
    battleCruiser.accelerate(.2);
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
    battleCruiser.accelerate(-0.15);
  }
  if(shoot == true)
  {
    bulletList.add(new Bullet(battleCruiser));
  }

  for (int i = 0; i < bulletList.size(); i++) {
    if (dist(bulletList.get(i).getX(),bulletList.get(i).getY(),width/2,500/2)>width/3*2) {
      bulletList.remove(i);
    }
  }
  noStroke();
fill(112,122,132);
rect(0, 500, 600, 100);
stroke(0);
rect(30, 510, 30,30);
fill(0);
textSize(32);
text("f", 39, 538);
textSize(20);
text("Hyperspace", ,532);



}
class SpaceShip extends Floater  
{   
  private double dRadians; 
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
    setY((int)(500/2));
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
  
    public void move ()   //move the floater in the current direction of travel
  {      
    int maxSpeed = 5;
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

    myDirectionX = myDirectionX/gravity;
    myDirectionY = myDirectionY/gravity;
    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
       starfield = new Star[200];
          for (int y = 0; y <starfield.length; y++){
            starfield[y] = new Star();
}
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;   

            starfield = new Star[200];
          for (int y = 0; y <starfield.length; y++){
            starfield[y] = new Star();
}
    }    
    if(myCenterY >height-100)
    {    
      myCenterY = 0;   
       starfield = new Star[200];
          for (int y = 0; y <starfield.length; y++){
            starfield[y] = new Star();
} 

    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height-100;   
       starfield = new Star[200];
          for (int y = 0; y <starfield.length; y++){
            starfield[y] = new Star();
} 
    }   
  }   
}

 class Bullet extends Floater
 {
    public Bullet (SpaceShip batteCruiser)
    {
      double dRadians =battleCruiser.myPointDirection*(Math.PI/180);
      setX((int)battleCruiser.myCenterX);
      setY((int)battleCruiser.myCenterY);
      //myPointDirection = battleCruiser.getPointDirection();
      setDirectionX(8 * Math.cos(dRadians));
      setDirectionY(8 * Math.sin(dRadians));    
    }

    public void show()
    {
      fill(255,255,255, 50);
      ellipse((float)myCenterX, (float)myCenterY, 12, 12);
    }
public void move(){
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     
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
  } 

    
 class Asteroid extends Floater
    {
      private int rotateSpeed;
      public Asteroid ()
      {
      myColor = color(44,142,222,130);
      corners = 8;
      xCorners = new int[corners];
      yCorners = new int[corners];
      xCorners[0] = 14;
      yCorners[0] = 0;
      xCorners[1] = 10;
      yCorners[1] = 10;
      xCorners[2] = 0;
      yCorners[2] = 14;
      xCorners[3] = -10;
      yCorners[3] = 10;
      xCorners[4] = -14;
      yCorners[4] = 0;
      xCorners[5] = -10;
      yCorners[5] = -10;
      xCorners[6] = 0;
      yCorners[6] = -14;
      xCorners[7] = 10;
      yCorners[7] = -10;
    //setX((int)(Math.random()*600));
    setX(0);
    setY((int)(Math.random()*500));

    setDirectionX((Math.random()*4-2));
    setDirectionY((Math.random()*4-2));
    setPointDirection(270);
      rotateSpeed = (int)(Math.random()*10-5);
      }
    public void move(){
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     
    myPointDirection +=rotateSpeed;
     if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height-100)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height-100;    
    }   

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
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height-100)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height-100;    
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

class Star
{
  private int myX, myY;

  public Star(){
    myX = (int)(Math.random()*600);
    myY = (int)(Math.random()*600);
  }

  public void show(){
    fill(255, 255, 255);
    ellipse(myX, myY, 2.1, 2.1);
  }
}

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
  else if(keyCode == ' '){
    shoot=true;
  }
  else if(keyCode == 'F'){
    
      battleCruiser.setX((int)(Math.random()*width));
      battleCruiser.setY((int)(Math.random()*500));
      battleCruiser.setDirectionX(0);
      battleCruiser.setDirectionY(0);
      battleCruiser.setPointDirection((int)(Math.random()*360));
      
    
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
  else if(keyCode == ' '){
    shoot = false;
  }
    else if(keyCode == 'F'){
    
  }
}

void keyTyped(){
  
}
