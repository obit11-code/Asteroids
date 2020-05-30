/**************************************************************
 * File: Asteroids.pde
 * Group: David Ross & Tobias Smith, Group 2
 * Course: COSC101 - Software Development Studio 1
 * Desc: An implementation of the game, Asteroids, using Processing 3.
 * Usage: Press Run To Start
 * Notes: For Attributions, see README.md
 **************************************************************/
 
import processing.sound.*;

SoundFile shoot1;
SoundFile shipexplode;
SoundFile roidexplode;

PImage Background, Background1; //Backgrounds
boolean instructions = false, shipCollision = false; //Menu and Collision Booleans
boolean gameReset = true; //Game Refresh
boolean[] keyIsPressed = new boolean[256]; //For Keyboard clicks
int lives = 3, score, i; 
int savedTime, saveTime, saveBulletTime, totalTime = 30000; //For delay in collisions
float x, y, xPos, yPos, angle, maxSpeed; //Ship floats
float max = 10; //Max Speed to hand to ship
Ship ship; 

int numRoids = 20;       // sets number of asteriods on the screen    --- SET TO 25 FOR TESTING - Adjust value to required value for game play 
float richocet = 0.05;   // Sets the richocet force the atseriods have --- SET TO 0.01 FOR TESTING - Change value to 0.008 for LEVEL 1 game play
int smallestRoid = 25;   // Sets value of smallest asteriod diameter possible - NB must be >= 10 - See ranges in void display 
int largestRoid = 100;   // Sets value of largest asteriod diameter possible - NB must be <= 100 - See ranges in void display
PImage[] bigRoids = new PImage [4];  // Big Roid images array
PImage[] midRoids = new PImage [4];  // Mid sized Roid images array
PImage[] smlRoids = new PImage [4];  // Small Roid images array
PImage[] Explode = new PImage [4];   // Explosion images array
Roid[] Roids = new Roid[numRoids];  // Array for roids - the array size is set by the variable for the number of Roids (numRoids)

//Bullet arraylist
ArrayList<Bullet> bullets;
boolean canShoot = true;
float canShootCounter;

void setup() {  
  size(1280, 852);
  frameRate(60);
  Background = loadImage("Background.png");
  Background1 = loadImage("Background1.jpg");
  
  shoot1 = new SoundFile(this, "shoot.wav");
  shipexplode = new SoundFile(this, "ship_explode.mp3");
  roidexplode = new SoundFile(this, "roid_explode.mp3"); 
  
  savedTime = millis(); 
  ship = new Ship(width/2,height/2,0.5,max,0,0);
  
  for(int i =0; i < bigRoids.length; i++) {                 //Loads Big Roid images
         bigRoids[i] = loadImage("asteroidBig"+i+".png");
  }
  for(int i =0; i < midRoids.length; i++) {                 //Loads mid sized Roid images
         midRoids[i] = loadImage("asteroidMed"+i+".png");
  }
  for(int i =0; i < bigRoids.length; i++) {                 //Loads Small Roid images
         smlRoids[i] = loadImage("asteroidSmall"+i+".png");
  }
  for(int i =0; i < Explode.length; i++) {                 //Loads explosion images
         Explode[i] = loadImage("Explode"+i+".jpg");
  }
  bullets = new ArrayList<Bullet>();
  // Creates Asteroid location, size from Roid array 
  // Sets a random x location for each asteroid
  // Sets a random y location for each asteroid 
  // sets diametre of smallest asteriod and largest asteriods

  for (int i = 0; i < numRoids; i++) {                       
          Roids[i] = new Roid(random(width), random(height), random(smallestRoid, largestRoid), i, Roids); 
  }
}

void draw() {
  if (!instructions) { //Boolean for home screen
    background(Background);
    textSize(22);
    textAlign(CENTER);
    stroke(255);
    fill(255);
    text("Your goal is to destroy " + 3*numRoids + " Asteroids.", width/2, height/2+200);
    text("Every 30 seconds, the game gets harder and respawns " + numRoids + " asteroids.",width/2,height/2+220);
    if (lives < 1){ //Message on screen if you Lose
      textSize(18);
      textAlign(CENTER);
      stroke(255);
      fill(255);
      text("You Lose! You ran out of lives, your score was " + score, width/2, height-50);
      gameReset = false;} 
    else if (score >= 3*numRoids) { //Message on screen if you Win
      textSize(18);
      textAlign(CENTER);
      stroke(255);
      fill(255);
      text("You Win! Your score was " + score, width/2, height-50);
      gameReset = false;}
    return;}
  if (!gameReset) { //Reset Game to play again
    lives = 3;
    score = 0;
    richocet = 0.05;
    java.util.Arrays.fill(Roids, null);
    numRoids = 20;
    ship.reset();
    savedTime = millis();
    for (int i = 0; i < numRoids; i++) {                       
          Roids[i] = new Roid(random(width), random(height), random(smallestRoid, largestRoid), i, Roids);
    }
    gameReset = true;} 
  background(Background1);
  textSize(18);
  textAlign(CENTER);
  stroke(255);
  fill(255);
  text("Score: " + score,width-80,height-832); //Score on screen
  text("Lives: " + lives,width-170,height-832); //Lives on screen
  //Time Loop for Levels
  int passedTime = millis() - savedTime; 
    if (passedTime > totalTime) {
      java.util.Arrays.fill(Roids, null);
      numRoids = 20; 
      for (int i = 0; i < numRoids; i++) {                       
          Roids[i] = new Roid(random(width), random(height), random(smallestRoid, largestRoid), i, Roids); 
      }
      saveTime = millis();
      savedTime = millis();}
  //Ship, Roid and Bullet class calls
  ship.display(); 
  ship.move();
  for (Roid Roid : Roids) {
    Roid.motion();
    Roid.collision();
    Roid.display();
    } 
  ship.update();
  for (i = bullets.size()-1; i >= 0; i--) {
    Bullet bullet = bullets.get(i);
    bullet.move();
    bullet.collide();}
  ship.collide();
  ship.win();  
}

void keyPressed() {
    keyIsPressed[keyCode] = true;
    if (keyPressed && key == ENTER | key == RETURN) {
      instructions = true;}
    if (keyPressed && key == ESC) {
      exit();}
}
 
void keyReleased() {
    keyIsPressed[keyCode] = false;
}
