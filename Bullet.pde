class Bullet {
  
  PVector locate; //Location of the bullet
  float initX, initY, rotate, speed;
  Bullet() {
    //places the bullet to start at ship position
    locate = new PVector(ship.xPos, ship.yPos);
    //for angle
    initX = mouseX;
    initY = mouseY;
    rotate = atan2(initY - locate.y, initX - locate.x) / PI * 180;
    speed = 10; //bullet speed
  } 
  
  void move() {
    //move the bullet
    locate.x = locate.x + cos(rotate/180*PI)*speed;
    locate.y = locate.y + sin(rotate/180*PI)*speed;
    stroke(0);
    fill(0,255,51); //sets bullet colour
    ellipse(locate.x, locate.y, 10, 10);
    //removes the bullet from the array when off screen
    if (locate.x > 0 && locate.x < width && locate.y > 0 && locate.y < height){}
    else {bullets.remove(i);}
  }
  
  void collide(){ 
    //Time delay for Collisions
    int BulletTimer = millis() - saveBulletTime; 
    if (BulletTimer > 1000) {
      for (int i = 0; i < Roids.length; i++){  //Collision detection between bullet and Asteroids. 
        float d = dist(locate.x,locate.y,Roids[i].x,Roids[i].y);
        if((d <= Roids[i].area)) {  
          Roids[i].explode(); //Roid Explosion Delay
          saveBulletTime = millis(); //reset timer
          score++;} //adds to score for each asteroid destroyed
      }           
    }                    
  }
}
