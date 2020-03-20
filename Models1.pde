class Models1 extends Vision
{
  Model model;
  
  Models1(String fileName)
  {
    model = new Model(fileName, 0, 0, 0);    
  }
  
  void restart()
  {
    model.smoothedBoxSize = 0;
  }
  
  void render()
  {
    background(0);
    noFill();
    lights();
    stroke(map(smoothedAmplitude, 0, 1, 0, 255), 255, 200);
    pushMatrix();    
    camera(0, 150, -300, 20, 20, 0, 0, 1, 0);
    model.render();
    popMatrix();
    camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);

  }
  
}
