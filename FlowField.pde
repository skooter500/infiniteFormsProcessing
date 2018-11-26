class FlowField extends Vision
{
  float offs = 0;
  float scale = 0.0005;

  int box = 40;

  void render()
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
    offs += speed * 100;
    popStyle();
  }
}
