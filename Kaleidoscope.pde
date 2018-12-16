class Kaleidoscope extends Vision
{
  PGraphics p;
  
  int w, h;
  float s = 0;
  float hue = 0;
  float frequency = 2.0f;
  Painter painter;
  
  Kaleidoscope(Painter painter)
  {
    w = width / 2;
    h = height / 2;    
    this.painter = painter;
  }
  
  void initialize()
  {
    p = createGraphics(w, h); //<>//
  }
  
  void render()
  { //<>//
    p.beginDraw();
    p.colorMode(RGB);
    p.fill(0, 5);
    p.rectMode(CORNER);
   p.rect(0, 0, width, height);    
    float toPass = (1.0f / frequency);
    if (s > toPass)
    {
      painter.paint(p, hue, w, h);      
      s = 0;
    }
    p.endDraw();
    image(p, 0, 0);
    
    pushMatrix();
    translate(width,0);
    scale(-1, 1);
    image(p, 0,0);  
    popMatrix();
    
    pushMatrix();
    translate(0,height);
    scale(1, -1);
    image(p, 0,0);  
    popMatrix();

    pushMatrix();
    translate(width,height);
    scale(-1, -1);
    image(p, 0,0);  
    popMatrix();
    s+= timeDelta;
    hue += timeDelta * 10;
    if (hue > 255)
    {
      hue = 0;
    }
  }  
}

interface Painter
{
  void paint(PGraphics p, float hue, int w, int h);
}

Painter linePainter = new Painter()
{
  void paint(PGraphics p, float hue, int w, int h)
  {
    p.colorMode(HSB);    
    p.stroke(random(0, 255), sat, value);
    //p.noStroke();
    p.strokeWeight(5);
    p.line(random(0, w), random(0, h), w, h);    
  }
};

Painter circlePainter = new Painter()
{
  void paint(PGraphics p, float hue, int w, int h)
  {
    p.colorMode(HSB);    
    noFill();
    p.stroke(random(0, 255), sat, value);
    //p.noStroke();
    p.strokeWeight(5);
    float ww = random(0, w);
    p.ellipse(random(0, w), random(0, h), ww, ww);    
  }
};
