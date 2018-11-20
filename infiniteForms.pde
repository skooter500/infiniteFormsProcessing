void rects()
{
  rectMode(CENTER);
  noStroke();
  float wgap = width / count;
  float hgap = height / count;
  float colorGap = 255 / count;
  for (float i = count; i > 0; i --)
  {
    float w = i * wgap;
    float h = i * hgap;
    float f = abs((c + i * colorGap) % 256.0f);
    fill(f, 255, 255);
    rect(width / 2, height / 2, w, h);

    c = (c + speed);
  }
}

float c = 0;
float speed = 0.0f;

float scale = 0.001;

float box = 50;

float offs = 0;

float theta = 0;
float timer = 0.0f;
int sides = 4;
float gOff = 0;

float cx;
float cy;



void circles()
{
  pushStyle();
  noStroke();
  float gap = width * 1.2 / count;
  float colorGap = 255 / count;
  for (float i = count; i >= 0; i --)
  {
    float w = i * gap;
    float f = abs((c + i * colorGap) % 256.0f);
    fill(f, 255, 255);
    ellipse(width / 2, height / 2, w, w);
    c = (c + speed);
  }
  popStyle();
}

void triangles()
{
  pushStyle();
  noStroke();
  float wgap = width * 3 / count;
  float hgap = height * 3 / count;
  float colorGap = 255 / count;
  for (float i = count; i >= 0; i --)
  {
    float w = i * wgap * 0.5;
    float h = i * hgap * 0.5;
    float f = abs((c + i * colorGap) % 256.0f);
    fill(f, 255, 255);
    c = (c + speed);
    triangle(cx-w, cy+h, cx, cy-h, cx+w, cy+h);
  }
  popStyle();
}

void stars()
{
  pushStyle();
  background(255);
  strokeWeight(60);
  float offset = 0 ;
  translate(cx, cy);  
  for (float radius = 0; radius < width * 1.6; radius += 60)
  {
    offset += 0.1f;
    float t = map(sin(theta + offset), -1.0f, 1.0f, 0.0f, 1.0f);
    color col = color(map(sin(theta + offset), -1, 1, 0, 255), 255, 255) ; // lerpColor(from, to, t);
    rotate(speed);  
    drawStar(0, 0, radius, sides, col);
  }
  theta += speed / 5;
  gOff += speed/5;
  timer += abs(speed/5);
  popStyle();
}

void drawStar(float cx, float cy, float radius, int points, color c)
{
  float thetaInc = TWO_PI / (points * 2);
  float lastX;
  float lastY;
  lastX = cx;
  lastY = cy -radius; 

  stroke(c);

  for (int i = 1; i <= (points * 2); i ++)
  {
    float theta = (i * thetaInc);
    float x, y;
    float r;
    if (i % 2 == 1)
    {
      r = radius * 0.5f;
    } else
    {
      r = radius;
    }

    x = cx + sin(theta) * r;
    y = cy -cos(theta) * r;
    line(lastX, lastY, x, y);
    lastX = x;
    lastY = y;
  }
}

void flowField()
{
  pushStyle();
  background(255);       
  noFill();
  strokeWeight(100);
  for (int x = 0; x < width; x+= box) {
    for (int y = 0; y < height; y+=box) {
      //noStroke();
      //rect(x, y, box, box);
      float cx = x + box / 2;
      float cy = y + box / 2;
      pushMatrix();
      translate(cx, cy);
      rotate(map(noise((cx) * scale, (cy + offs) * scale), 0, 1, 0, TWO_PI));
      stroke(map(noise((cx) * scale, (cy + offs) * scale), 0, 1, 0.0f, 255.0f), 255, 255);      
      line(0, -30, 0, 30);
      //rect(-10, 10, 20, 20);
      popMatrix();
    }
  }
  offs += speed * 50;
  popStyle();
}

float count = 40;
int mode = 0;

color from;
color to;


void restartPatterns()
{
  crossShape();
}

int MODES = 7;
void setup()
{
  colorMode(HSB);
  //size(800, 600, P3D);
  startLife();
  fullScreen(P3D);
  //noCursor();
  cx = width / 2;
  cy = height / 2;

  from = color(255, 255, 255);
  to = color(0, 0, 0);
}


void keyPressed()
{
  if (keyCode == RIGHT)
  {
    mode = (mode + 1) % MODES;    
  }
  if (keyCode == LEFT)
  {
    mode = (mode == 0) ? MODES - 1 : mode - 1 ;    
  }
  restartPatterns();
    background(0);
}

void draw()
{
  //background(0);
  float cc = mouseX % 256.0f;
  //background(cc, 255, 255);
  //background(random(0, 255), 255, 255);

  switch(mode)
  {
  case 0:
    rects();
    break;
  case 1:
    circles();
    break;
  case 2:
    triangles();
    break;
  case 3:
    flowField();
    break;
  case 4:      
    stars();
    break;
  case 5:
    randomLife();
    break;
  case 6:
    patternLife();
    break;
  }
  speed = map(mouseX, 0, width, -0.04, 0.04);
  //numRects = (int) map(mouseY, 0, height, 5, 50);
  //println(frameRate);
}
