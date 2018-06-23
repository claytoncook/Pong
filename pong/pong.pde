//ball
float speedX = 2.5, speedY = 2;
float ballX, ballY;
int ballRad = 10;

//slider
int s1X = 0, s1Y = 0;
int s1W, s1H;
int slidSpeed = 3;

//score
int score = 0;

void setup() {
  size(800, 400);
  ballX = width/2;
  ballY = height/2;
  s1H = height/5;
  s1W = 20;
  s1X = 10;
  s1Y = (height/5) + (s1H/2);
};

void draw() {
  background(0);
  stroke(255);
  line(width/2, 0, width/2, height);

  //slider player one
  fill(255);
  rect(s1X, s1Y - (s1H/2), s1W, s1H);

  //ball
  ellipse(ballX, ballY, ballRad * 2, ballRad * 2);

  //score
  textSize(20);
  text(" " + score + " ", width/2, 20);

  move();
  collision();
};

void move() {
  //slider controls
  if (key == CODED) {
    if (keyCode == UP) {
      s1Y -= slidSpeed;
    } else if (keyCode == DOWN) {
      s1Y += slidSpeed;
    }
  }

  // move ball
  ballX += speedX;
  ballY += speedY;
};

void collision() {
  //slider screen containment
  if (s1Y < 0 + (s1H/2)) {
    s1Y = s1H/2;
  } else if (s1Y + (s1H/2) > height) {
    s1Y = height - (s1H/2);
  }

  //wall collision
  if (ballX + ballRad >= width) {
    speedX = (speedX * -1);
  }
  if (ballX - ballRad <= 0) {
    speedX = (speedX * -1);
    score++;
    reset();
  }
  if (ballY + ballRad >= height) {
    speedY = (speedY * -1);
  }
  if (ballY - ballRad <= 0) {
    speedY = (speedY * -1);
  }

  //fix if ball goes out of bounds
  if (ballX > width) {
    ballX = width - (ballRad*2);
  } 
  if (ballX < 0) {
    ballX = (ballRad*2);
  } 
  if (ballY > height) {
    ballX = height - (ballRad*2);
  } 
  if (ballY < 0) {
    ballX = (ballRad*2);
  } 

  //slider + ball collision 
  if (ballX - ballRad < s1X + s1W) {
    if ((s1Y < ballY) && (ballY < s1Y + s1H)) {
      speedX = speedX * -1;
      harder();
    }
  }
};

void reset() {
  ballX = width/2;
  ballY = height/2;
  s1Y = height/2;
};

void harder() {
  speedX += 0.15 * speedX;
  speedY += 0.15 * speedY;
};
