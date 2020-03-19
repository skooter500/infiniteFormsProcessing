class City extends Vision
{
    int rows = 100;
    float gap = 100;
    //Street[] streets;
    PVector pos;
    
    City()
    {
      this(0, 0, -500, 10, 100);
    }

    City(float x, float y, float z, int rows, float gap)
    {
        pos = new PVector(x, y, z);
        this.rows = rows;
        this.gap = gap;        
        
        /*
        streets = new Street[rows];

        for(int i = 0 ; i < rows ; i ++)
        {
            streets[i] = new Street(, i, x, y, z * -gap);
        }
        */
    }
    
    // Ugh Java
    PVector rowPos = new PVector(); 
        
    float smoothedBoxSize = 0;
    float camY = 0;
    void render()
    {
        background(0);
        noFill();
        lights();    
        camera(0, camY, 0, 0, 0, -1000, 0, 1, 0);
        
        pushMatrix();
        if (checkKey('i'))
        {
          camY += 5;
        }
        
        for(int row = 0 ; row < rows ; row ++)
        {
            rowPos.z = pos.z -(gap * row);
            //Street s = streets[row];
            for(int i = 0 ; i < smoothedBands.length; i ++)
            {
                float base = 40;
                float boxSize = base + (smoothedBands[i] * 2); 
                smoothedBoxSize = lerp(smoothedBoxSize, boxSize, 0.2f);    
                
                stroke(map(i, 0, smoothedBands.length, 0, 255), 255, 255);                
                pushMatrix();
                translate(rowPos.x + (i+1) * gap, rowPos.y - (smoothedBoxSize * 0.5f), rowPos.z);
                box(base, smoothedBoxSize, base);
                popMatrix();      

                pushMatrix();
                translate(rowPos.x - (i+1) * gap, rowPos.y  - (smoothedBoxSize * 0.5f), rowPos.z);
                box(base, smoothedBoxSize, base);
                popMatrix();      
            }
        }        
        popMatrix();
        camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);          
    }
}