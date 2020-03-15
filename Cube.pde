class Cube
{
  PVector position;
  
  float smoothedBoxSize = 0;
  float angle = 0;
  
  Cube(float x, float y, float z)
  {
    position = new PVector(x, y, z);
  }
  
  void render()
  {
    pushMatrix();
    strokeWeight(2);        
    stroke(map(smoothedAmplitude, 0, 1, 0, 255), 255, 255);
    translate(position.x, position.y, position.z);       
    println(position);
    float boxSize = 50 + (amplitude * 300); 
    smoothedBoxSize = lerp(smoothedBoxSize, boxSize, 0.2f);                

    rotateY(angle);
    rotateX(angle);
    strokeWeight(5);
    
    box(smoothedBoxSize);
    angle+=0.01f;
    popMatrix();
  }
  
}
