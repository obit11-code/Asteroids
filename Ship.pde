class Ship  {
  
  PVector location;
  Ship() {
    location = new PVector(width/2, height/2);
  }
  
  PImage Ship, shipJet;
  float xPos, yPos, rotation, minSpeed, maxSpeed, speed, angle; 
  
  Ship(float x, float y,
        float min, float max,
          float initspeed, float ang){
            
    xPos = x;
    yPos = y;
    minSpeed = min;
    maxSpeed = max;
    speed = initspeed;
    angle = ang;
  }
  
  void display(){
    Ship = loadImage("Ship.png");
    Ship.resize(70,60);
    shipJet = loadImage("shipJet.png");
    shipJet.resize(75,60);
  }
  
  void move(){
    //For ship Location and movement
    pushMatrix();
    translate(xPos, yPos); 
    rotate(angle);
    xPos += cos(angle)*speed; 
    yPos += sin(angle)*speed;
    if(keyIsPressed[UP]){ //Moving Ship
      image(shipJet,0,0);
      speed += width/100;}
    else{
      image(Ship,0,0);}
    if(keyIsPressed[LEFT]) angle -= radians(5.0); //Rotate Left
    if(keyIsPressed[RIGHT]) angle += radians(5.0); //Rotate Right
    if(speed < minSpeed){speed = minSpeed;} //Cap minimum speed
    if(speed > maxSpeed){speed = maxSpeed;} //Cap maximum speed
    popMatrix();
    speed -= 0.5; //Slow ship down
  
    //Boundary Detection
    if (xPos > width+Ship.width) xPos = 0;
    else if (xPos < -Ship.width) xPos = width;
    if (yPos > height+Ship.width) yPos = 0;
    else if (yPos < -Ship.width) yPos = height; 
   
  }
  
  //Return to main screen if you destroy enough asteroids.
  void win(){
    if (score >= 3*numRoids){ 
        instructions = false;}
  }
  
  //Reset Ship position at the centre
  void reset(){ //For delaying collision detection
    if (millis() < 3000){
      shipCollision = false;}
    else {
      if (lives > 0){ //Reset position if you still have lives
        xPos = width/2;
        yPos = height/2;
        angle = 0;
        shipCollision = false;}
      else{
        instructions = false;}
    }
  }
  
  //Detects collions between ship and asteroids. 
  void collide(){ 
    //Time delay for Collisions
    int CollideTimer = millis() - saveTime; 
    if (CollideTimer > 3000) {
      for (int i = 0; i < Roids.length; i++){  //Collision detection between ship and Asteroids. 
        float d = dist(xPos,yPos,Roids[i].x,Roids[i].y);
        if((d <= Roids[i].area)) {
          shipexplode.play();
          lives--;
          ship.reset();
          saveTime = millis();}
      }           
    }                    
  }
  
  void update() {
    if (mousePressed == true) {
      //Adds delay between shots
      if (canShoot == true) {
        bullets.add(new Bullet());
        shoot1.play();
        canShoot = false;
        canShootCounter = 0;
      }
    }
    if (canShoot == false) {
      canShootCounter ++;
      if (canShootCounter == 10){
        canShoot = true;
      }
    }
  }  
}
