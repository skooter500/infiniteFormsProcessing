
float c = 0;
float speed = 0.0f;

float cx;
float cy;

ArrayList<Vision> visions = new ArrayList<Vision>();

int vision = 0;

void setup()
{
  colorMode(HSB);
  //size(800, 600);
  fullScreen();
  //noCursor();
  cx = width / 2;
  cy = height / 2;

  
  visions.add(new Kaleidoscope());
  visions.add(new Life(0, 200));
  visions.add(new Life(1, 200));
  visions.add(new Rects());
  visions.add(new Circles());
  visions.add(new Triangles());
  visions.add(new FlowField());
  visions.add(new Star(4, false, true));   
  visions.add(new Star(6, false, true));
  visions.add(new Star(12, false, true));
  
  for(Vision v:visions)
  {
    v.initialize();
  }
  background(0);
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

void draw()
{
  float cc = mouseX % 256.0f;
  //background(cc, 255, 255);
  //background(random(0, 255), 255, 255);
  visions.get(vision).render();
  
  
  speed = -0.04;
  //numRects = (int) map(mouseY, 0, height, 5, 50);
  //println(frameRate);
}
