
float c = 0;
float speed = 0.0f;

float cx;
float cy;
float sat = 255;
float value = 255;

ArrayList<Vision> visions = new ArrayList<Vision>();

int vision = 0;

float timeDelta = 0;

void setup()
{
  colorMode(HSB);
  //size(800, 600, P3D);
  fullScreen(P3D);
  //noCursor();
  cx = width / 2;
  cy = height / 2;

  
  visions.add(new Kaleidoscope(linePainter));
  visions.add(new Kaleidoscope(circlePainter));
  visions.add(new Life(0, 200));
  visions.add(new Life(1, 200));
  visions.add(new Rects());
  visions.add(new Circles());
  //visions.add(new Triangles());
  visions.add(new FlowField());
  visions.add(new Star(3, false, false));   
  visions.add(new Star(6, false, true));
  visions.add(new Star(12, false, false));
  
  for(Vision v:visions)
  {
    v.initialize();
  }
  background(0);
  previous = millis();
}


void keyPressed()
{
  if (keyCode == RIGHT)
  {
    vision = (vision + 1) % visions.size();    
  }
  if (keyCode == LEFT)
  {
    vision = (vision == 0) ? visions.size() - 1 : vision - 1 ;    
  }
  visions.get(vision).restart();
}

long previous;

void draw()
{
  long now = millis();
  timeDelta = (now - previous) / 1000.0f;
  previous = now;
  println(timeDelta);
  float cc = mouseX % 256.0f;
  //background(cc, 255, 255);
  //background(random(0, 255), 255, 255);
  visions.get(vision).render();
  
  
  speed = -0.04;
  //numRects = (int) map(mouseY, 0, height, 5, 50);
  //println(frameRate);
  
}
