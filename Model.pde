import com.jogamp.opengl.GL;
import com.jogamp.opengl.GL2ES2;

class Model
{    
  PShape s;
  PVector position;
  float smoothedBoxSize = 0;
  float angle = 0;
  float weight = 5;
  float size = 50;
  myObject obj;
  float theta = 0;

  Model(String fileName, float x, float y, float z)
  {
    //obj = new myObject(fileName);
    s = loadShape(fileName);
    position = new PVector(x, y, z);
  }
  float c = 0;

  void render()
  {
    pushMatrix();
    //strokeWeight(2);        
    s.setFill(color(c % 255, 255, 255));
    translate(position.x, position.y, position.z);       
    
    //strokeWeight(weight);
    float boxSize = size + (amplitude * 10); 
    smoothedBoxSize = lerp(smoothedBoxSize, boxSize, 0.2f);
    //scale(1);
    rotateX(-HALF_PI);
    rotateZ(PI);
    rotateZ(0.2 + sin(theta) * 0.2f);
    theta += speed;
    c += speed * 100 * amplitude;
    scale(smoothedBoxSize * 2);
    shape(s);
    popMatrix();


    /*
    ArrayList<Quad> quads = obj.getQuads();  
     for (int i = 0; i < quads.size(); i++) {
     beginShape(QUADS);
     quads.get(i).createVertex();
     endShape();
     }
     
     ArrayList<Tri> tris = obj.getTris();  
     for (int i = 0; i < tris.size(); i++) {
     beginShape(TRIANGLES);
     tris.get(i).createVertex();
     endShape();
     }
     //shape(s);
     //box(1);
     //angle+=0.01f;
     popMatrix();
     }
     */
  }
}

class myObject {
  private ArrayList<PVector> vertices;
  private ArrayList<Tri> tris;
  private ArrayList<Quad> quads;

  public myObject(String objFile) {
    String[] lines;
    vertices = new ArrayList<PVector>();
    tris = new ArrayList<Tri>();
    quads = new ArrayList<Quad>();

    lines = loadStrings(objFile);
    for (int idx = 0; idx < lines.length; idx++) {

      String[] data = split(lines[idx], " ");

      if (data[0].equals("v")) {
        vertices.add(new PVector(float(data[1]), float(data[2]), float(data[3])));
      } else if (data[0].equals("f")) {
        PVector v0, v1, v2;
        int idx0, idx1, idx2;

        idx0 = int(split(data[1], "/")[0]) - 1;
        idx1 = int(split(data[2], "/")[0]) - 1;
        idx2 = int(split(data[3], "/")[0]) - 1;

        printArray(data);
        println(idx0, idx1, idx2);

        v0 = vertices.get(idx0).copy();
        v1 = vertices.get(idx1).copy();
        v2 = vertices.get(idx2).copy();

        if (data.length == 5) {
          PVector v3;
          int idx3;
          idx3 = int(split(data[4], "/")[0]) - 1;
          v3 = vertices.get(idx3).copy();
          quads.add(new Quad(v0, v1, v2, v3));
        } else {
          tris.add(new Tri(v0, v1, v2));
        }
      }
    }
  }

  public ArrayList<Tri> getTris() {
    return tris;
  }

  public ArrayList<Quad> getQuads() {
    return quads;
  }
}

class Tri {
  private PVector[] vertices;

  public Tri(PVector v0, PVector v1, PVector v2) {
    vertices = new PVector[3];
    vertices[0] = v0;
    vertices[1] = v1;
    vertices[2] = v2;
  }

  public void createVertex() {
    vertex(vertices[0].x, vertices[0].y, vertices[0].z);
    vertex(vertices[1].x, vertices[1].y, vertices[1].z);
    vertex(vertices[2].x, vertices[2].y, vertices[2].z);
  }
}

class Quad {
  private PVector[] vertices;

  public Quad(PVector v0, PVector v1, PVector v2, PVector v3) {
    vertices = new PVector[4];
    vertices[0] = v0;
    vertices[1] = v1;
    vertices[2] = v2;
    vertices[3] = v3;
  }

  public void createVertex() {
    vertex(vertices[0].x, vertices[0].y, vertices[0].z);
    vertex(vertices[1].x, vertices[1].y, vertices[1].z);
    vertex(vertices[2].x, vertices[2].y, vertices[2].z);
    vertex(vertices[3].x, vertices[3].y, vertices[3].z);
  }
}
