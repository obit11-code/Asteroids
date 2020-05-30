class Roid  {                          // Roid Class
  
  
  float x, y;          //  x and y variable for centre of Roid 
  float area;          //  height & width of Rroids  
  float vx = random(-1.5,1.5);        //  Initial x velocity    SETTING THESE x/y VALUES positive / negative will create whole asteroid field movement     
  float vy = random(-1.5,1.5);        //  Initial y velocity
  int loc;         
  Roid[] extras;
  
  float Ax;
  float Ay;
  float range;
  float minDist;
                                                                     
                                                                     
  Roid(float xGo, float yGo, float aGo, int locGo, Roid[] extGo) {
    x = xGo;
    y = yGo;
    area = aGo;
    loc = locGo;
    extras = extGo;
  } 
  
void collision() {
    for (int i = loc + 1; i < numRoids; i++) {
      float Ax = extras[i].x - x;                 // Determines x speed following collisions
      float Ay = extras[i].y - y;                 // Determines y speed following collisions

      float range = sqrt(Ax*Ax + Ay*Ay);          // Controls the distance movement after a collision
      
      float minDist = extras[i].area/2 + area/2;  // Sets the minimum distance for a collision (originally set at area/2)
      
                                          // COLLISION BEHAVIOUR following breach of minimum distance between ARoids
      if (range < minDist) {                        
       
         float angle = atan2(Ay, Ax);                     // Angluar curve direction after ARoids rebound off each other
         float coordX = x + cos(angle) * minDist;
         float coordY = y + sin(angle) * minDist;
 
         float Cx = (coordX - extras[i].x) * richocet;    // Force and x coordinate direction ARoids rebound off each other
         float Cy = (coordY - extras[i].y) * richocet;    // Force and y coordinatedirection ARoids rebound off each other

         vx -= Cx;                                        // Restricts the result of collision, (Prevents Pinballing)  
         vy -= Cy;
         extras[i].vx += Cx;                              
         extras[i].vy += Cy;
         
      }
    }
}// End of collision



             
void explode() {   
                                      // Roid destroy--- for bullet if (distance < Roid.minDist) = "Kaboom"           
 
             imageMode(CENTER);
             image(Explode[0],x,y,area,area);
             imageMode(CENTER);
             image(Explode[1],x,y,area,area);
             imageMode(CENTER);
             image(Explode[2],x,y,area,area);
             imageMode(CENTER);
             image(Explode[3],x,y,area,area);
             roidexplode.play();
             area = -1;   
        
       }  
       
void motion() {
     x += vx;                          // x travel velocity
     y += vy;                          // y travel velocity
    
                                      // "Warp-around" - makes asteriods reappear on opposite side of 
                                      // screen in same direction of travel

   int outerlimit = 100;              // Sets outer limit for asteriods before they warp-around (Value must be > largest roid) 
    if (x  > width+outerlimit) {        // Warp-around for sides  
      x = -outerlimit;                 
    }
    else if (x  < -outerlimit) {
      x = width+outerlimit;
    }
     if (y > height+outerlimit) {       // Warp-around for top and bottom  
      y = -outerlimit ;                

    } 
    else if (y < -outerlimit) {
      y = height+outerlimit;
    }
}



void display() {                                    // Images are set to ranges of asteriod sizes so that there is a range of each size
    
    if (area >= 10 && area <=  40) {                  // Sets smallest roid images to randomly created range of smallest ARoid sizes        
      imageMode(CENTER);
      image(smlRoids[1],x,y,area,area);
    }
    else if (area >= 41 && area <=  70) {             // Sets mid size roid images to randomly created range of mid sized ARoid sizes
      rectMode(CENTER);
      imageMode(CENTER);                             
      image(midRoids[1],x,y,area,area);
    }
    else if (area >= 71 && area <=  100) {           // Sets big size roid images to randomly created range of largest ARoid sizes
      imageMode(CENTER);
      image(bigRoids[1],x,y,area,area);
    }

   }  //end of display


}        /// END OF ROID CLASS                                           
