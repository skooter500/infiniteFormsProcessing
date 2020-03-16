class Models1 extends Vision
{
  Model model;
  
  Models1(String fileName)
  {
    model = new Model(fileName, 0, 0, 0);    
  }
  
  void render()
  {
    background(0);
    noFill();
    lights();
    stroke(map(smoothedAmplitude, 0, 1, 0, 255), 255, 255);
    pushMatrix();    
    camera(0, 150, -500, 0, 0, 0, 0, 1, 0);
    model.render();
    popMatrix();
    camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);

  }
  
}
