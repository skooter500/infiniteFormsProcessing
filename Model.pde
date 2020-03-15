class Model
{    
  PShape s;
  PVector position;
  float smoothedBoxSize = 0;
  float angle = 0;
  float weight = 5;
  float size = 50;
    
  Model(String fileName, float x, float y, float z)
  {
    s = loadShape(fileName);
    position = new PVector(x, y, y);
  }
  
  void render()
  {
    pushMatrix();
    strokeWeight(2);        
    stroke((map(smoothedAmplitude, 0, 1, 0, 255) + colorOffset) % 255, 255, 255);
    translate(position.x, position.y, position.z);       
    
    rotateY(angle);
    rotateX(angle);
    strokeWeight(weight);
    float boxSize = size + (amplitude * 300); 
    smoothedBoxSize = lerp(smoothedBoxSize, boxSize, 0.2f);
    
    scale(smoothedBoxSize);
    shape(s);
    angle+=0.01f;
    popMatrix();    
  }
  
}
