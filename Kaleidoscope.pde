class Kaleidoscope extends Vision
{
  PGraphics p;
  
  int w, h;
  float s = 0;
  
  Kaleidoscope()
  {
    w = width / 2;
    h = height / 2;    
  }
  
  void initialize()
  {
    p = createGraphics(w, h); //<>//
  }
  
  void render()
  { //<>//
    p.beginDraw();
    p.colorMode(RGB);
    p.fill(0, 20);
    p.rectMode(CORNER);
    p.rect(0, 0, width, height);
    p.colorMode(HSB);    
    p.fill(s, 255, 255);
    p.stroke(s, 255, 255);
    //p.noStroke();
    p.strokeWeight(5);
    p.line(random(0, w), random(0, h), w, h);
    //p.ellipse(random(0,w), random(0, h), random(10, 200), random(10, 200));
    //if (frameCount % 1 == 0)
    //p.rect(random(0,w), random(0, h), random(0,w), random(0, h));    
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
    s-= speed * 100;
    if (s > 255)
    {
      s = 0;
    }
  }  
}
