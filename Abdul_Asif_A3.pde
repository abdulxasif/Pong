/***********************
 *     Abdul Asif      *
 *                     *
 *  Abdul_Asif_A3.pde  *
 *                     *
 * ICS 3U1 Assignment  *
 *        #3           *
 *                     *
 * Creating a game of  *
 * Pong in Processing  *
 * using a variety of  *
 * boolean expressions,*
 * if statements,      *
 * methods, and        *
 * variables           *
 *                     *
 *  November 29, 2022  *
 **********************/
//global variables and boolean expressions
int ballX = 400;
int ballY = 400;
int ballXSpeed = -3;
int ballYSpeed = 3;
int p1Score = 0;
int p2Score = 0;
int leftPaddleX = 50;
int leftPaddleY = 350;
int rightPaddleX = 700;
int rightPaddleY = 350;
int time;
int gameScreen = 1; //variable to change game screen between menu and game
boolean pointIsScored = false;
boolean ballTouchingLeftPaddle = true;
boolean ballTouchingRightPaddle = true;
boolean restartGame = true;
//boolean expressions used in keyPressed() to allow paddle movement
boolean moveLeftPaddleUp = false, moveLeftPaddleDown = false, moveRightPaddleUp = false, moveRightPaddleDown = false;
void setup () {
  size (800, 800); //canvas size
  time = millis (); // time variable used with millis function to allow ball to delay before restarting
  strokeWeight(0);
}
void draw () {
  //contains the code to allow the screen to change from the menu to instructions to the game
  if (gameScreen == 1) {
    drawMenu ();
  } else if (gameScreen == 2) {
    drawInstructions ();
  } else if (gameScreen == 3) {
    drawGame ();
  }
}
//a seperate void made for the game so that there is a differentiation between the game screens
void drawGame () {
  background (#DBDBDB); //background colour for game
  //text for scores
  textSize (50);
  text (p1Score, 20, 60);
  text (p2Score, 750, 60);
  drawBall (); // the ball
  moveBall (); //move the ball
  checkIfBallHitEdges (); //boundaries for ball
  drawLeftPaddle(); //the left paddle
  drawRightPaddle (); //the right paddle
  moveLeftPaddle (); //move the left paddle
  moveRightPaddle ();//move the right paddle
  checkIfLeftPaddleHitEdges ();//left paddle boundaries
  checkIfRightPaddleHitEdges ();//right paddle boundaries
  checkIfBallHitsLeftPaddle ();//ball hits the left paddle
  checkIfBallHitsRightPaddle ();//ball hits the right paddle
  endGame (); //win screen
}
//if the ball hits the left and right edge (meaning a point is scored), recenter the ball
void checkIfBallHitEdges () {
  if (pointIsScored) {
    recenterBall ();
  }
  //boundaries for the ball and making it come back to the centre when a point is scored
  if (ballX <25) {
    p2Score = p2Score + 1;
    time = millis ();
    pointIsScored = true;
  } else if (ballX > 775) {
    p1Score = p1Score + 1;
    time = millis ();
    pointIsScored = true;
  } else if (pointIsScored) {
    recenterBall ();
  }

  if (ballY < 25 || ballY > 775) {
    ballYSpeed = -ballYSpeed;
  }
}
// the ball
void drawBall () {
  fill (#000000);
  ellipse (ballX, ballY, 50, 50);
}
// move the ball using ballX and ballY positions along with speed
void moveBall () {
  ballX = ballX + ballXSpeed;
  ballY = ballY + ballYSpeed;
}
//the left paddle
void drawLeftPaddle () {
  fill (#8B0707);
  rect (leftPaddleX, leftPaddleY, 50, 100);
}
// the right paddle
void drawRightPaddle () {
  fill (#023020);
  rect (rightPaddleX, rightPaddleY, 50, 100);
}
// moving the paddles, which works together with keyPressed () and keyReleased ()
void moveLeftPaddle() {
  if (moveLeftPaddleDown) {
    leftPaddleY+=7;
  }
  if (moveLeftPaddleUp) {
    leftPaddleY-=7;
  }
}
void moveRightPaddle() {
  if (moveRightPaddleDown) {
    rightPaddleY+=7;
  }
  if (moveRightPaddleUp) {
    rightPaddleY-=7;
  }
}
//boundaries for left paddle
void checkIfLeftPaddleHitEdges () {
  if (leftPaddleY < 0) {
    leftPaddleY = leftPaddleY+7;
  } else if (leftPaddleY > 700) {
    leftPaddleY = leftPaddleY-7;
  }
}
//boundaries for right paddle
void checkIfRightPaddleHitEdges () {
  if (rightPaddleY < 0) {
    rightPaddleY = rightPaddleY+7;
  } else if (rightPaddleY > 700) {
    rightPaddleY = rightPaddleY-7;
  }
}
// make the ball hit the left paddle
void checkIfBallHitsLeftPaddle() {
  ballTouchingLeftPaddle = (ballX < leftPaddleX + 75 && ballY > leftPaddleY - 25 && ballY < leftPaddleY + 125); //condition for the ball hitting off the left paddle
  if (ballTouchingLeftPaddle) {
    ballXSpeed = abs(ballXSpeed);
  }
}
// make the ball hit the right paddle
void checkIfBallHitsRightPaddle() {
  ballTouchingRightPaddle = (ballX > rightPaddleX - 25 && ballY > rightPaddleY - 25 && ballY < rightPaddleY + 125); //condition for the ball hitting off the right paddle
  if (ballTouchingRightPaddle) {
    ballXSpeed = -abs(ballXSpeed);
  }
}
//recenter the ball for when a point is scored (ball returns to middle and it does not move)
void recenterBall () {
  ballXSpeed = 0;
  ballYSpeed = 0;
  ballX = 400;
  ballY = 400;
  restartBall ();
}
//restart the ball after 2 seconds of being in the middle after a point is scored
void restartBall () {
  if (millis () - time >= 2000) {
    ballXSpeed = 4;
    ballYSpeed = 4;
    pointIsScored = false;
  }
}
//the void for the win screens
void endGame () {
  if (p1Score == 3) { //if player 1's score is 3, p1 wins
    p1WinScreen ();
  }
  if (p2Score == 3) { //if player 2's score is 3, p2 wins
    p2WinScreen ();
  }
}
//p2's win screen
void p2WinScreen () {
  background (#ffffff);
  textSize (50);
  ballXSpeed=0; //stop the ball when the player wins
  ballYSpeed=0;
  text ("Player 2 Wins", 250, 400);
  textSize (30);
  text ("Press Spacebar to Play Again", 220, 450);
}
//p1's win screen
void p1WinScreen () {
  background(#ffffff);
  textSize (50);
  ballXSpeed=0;
  ballYSpeed=0;
  text ("Player 1 Wins", 250, 400);
  textSize (30);
  text ("Press Spacebar to Play Again", 220, 450);
}
// the void for the menu
void drawMenu () {
  background(#6ED9F2);
  fill(0);
  textSize (150);
  ballXSpeed=0;
  ballYSpeed=0;
  text ("Pong", 225, 380);
  textSize (45);
  text ("Press Enter to See Instructions", 120, 500);
}
// the void for the instructions
void drawInstructions () {
  background(#348DA2);
  fill(0);
  textSize (25);
  ballXSpeed=0;
  ballYSpeed=0;
  text ("Player 1: Press W to go Up, Press S to go Down", 150, 305);
  text ("Player 2: Press Up Arrow to go Up, Press Down Arrow to go Down", 70, 425);
  text ("Press Enter to Play", 300, 555);
}
//movement based off of keys pressed
void keyPressed() {
  //if the up key is pressed, the right paddle moves up
  if (keyCode == 38) { // Up Key
    moveRightPaddleUp = true;
  }
  //if the down key is pressed, the right paddle moves down
  if (keyCode == 40) { // Down Key
    moveRightPaddleDown = true;
  }
  //if the W key is pressed, the left paddle moves up
  if (keyCode == 87) { // W Key
    moveLeftPaddleUp = true;
  }
  //if the S key is pressed, the left paddle moves down
  if (keyCode == 83) { // S Key
    moveLeftPaddleDown = true;
  }
  //if the spacebar is pressed, the game restarts
  if (keyCode == 32) { //Spacebar
    p1Score = 0;
    p2Score = 0;
    ballXSpeed = -4;
    ballYSpeed = 4;
    //if the enter key is pressed and you are on the start screen, the instructions appear
  } else if (keyCode == 10 && gameScreen==1) { // Enter Key
    gameScreen=2;
    //if the enter key is pressed and you are on the instructions screen, the game starts
  } else if (keyCode == 10 && gameScreen==2) { // Enter Key
    gameScreen=3;
    ballXSpeed = -4;
    ballYSpeed = 4;
  }
}
void keyReleased() {
  if (keyCode == 38) { // Up Key
    moveRightPaddleUp = false;
  }
  if (keyCode == 40) { // Down Key
    moveRightPaddleDown = false;
  }
  if (keyCode == 87) { // W Key
    moveLeftPaddleUp = false;
  }
  if (keyCode == 83) { // S Key
    moveLeftPaddleDown = false;
  }
}
