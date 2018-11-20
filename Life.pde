void crossShape()
{
  clearBoard();
  int halfW = boardWidth / 2;
  int halfH = boardHeight / 2;  
  for (int i = 0; i < boardWidth; i ++)
  {
    board[halfH][i] = random(255);
  }
  for (int i = 0; i < boardHeight; i ++)
  {
    board[i][halfW] = random(255);
  }
}

void xShape()
{
  clearBoard();
  int half = boardHeight / 2;
  for (int i = 0; i < boardHeight; i ++)
  {
    board[i][i] = random(255);
    board[(boardWidth - 1) - i][i] = random(255);
  }
}

void clearBoard()
{
  for (int row = 0; row < boardHeight; row ++)
  {
    for (int col = 0; col < boardWidth; col ++)
    {
      board[row][col] = -1;
    }
  }
}

void startLife()
{
  cellWidth = width / (float) boardWidth;
  boardHeight = round(height / cellWidth);
  board = new float[boardHeight][boardWidth];
  nextBoard  = new float[boardHeight][boardWidth];
  
  buffer = createGraphics(width, height);
  buffer.colorMode(HSB);
  
}

int boardWidth = 50;
int boardHeight;
float cellWidth;
float[][] board = new float[boardHeight][boardWidth];
float[][] nextBoard  = new float[boardHeight][boardWidth];

PGraphics buffer;

int numAlive = 0;

void updateBoard()
{
  numAlive = 0;
  for (int row = 0; row < boardHeight; row ++)
  {
    for (int col = 0; col < boardWidth; col ++)
    {
      int c = countAround(row, col);
      if (board[row][col] >= 0)
      {
        if (c == 2 || c == 3)
        {
          nextBoard[row][col] = board[row][col];
          numAlive ++;
        } else
        {
          nextBoard[row][col] = -1;
        }
      } else
      {
        if (c == 3)
        {
          nextBoard[row][col] = randomAround(row, col);
          numAlive ++;
        } else
        {
          nextBoard[row][col] = -1;
        }
      }
    }
  }
  float[][] temp = board;
  board = nextBoard;
  nextBoard = temp;
}

float getElement(int row, int col)
{
  if (row >= 0 && row < boardHeight && col >= 0 && col < boardWidth)
  {
    return board[row][col];
  } else return -1;
}

float randomHue(float[] hue)
{
  float xsum = 0;
  float ysum = 0;
  
  for(float f:hue)
  {
    float angle = map(f, 0, 255, -PI, PI);
    xsum += cos(angle);
    ysum += sin(angle);    
  }
  xsum /= hue.length;
  ysum /= hue.length;
  float angle = atan2(ysum, xsum);
  return map(atan2(ysum, xsum), -PI, PI, 0, 255);
}

float randomAround(int row, int col)
{
  float sum = 0;
  float xsum = 0;
  float ysum = 0;
  int ec = 0;
  for (int r = row - 1; r <= row + 1; r ++)
  {
    for (int c = col - 1; c <= col + 1; c ++)
    {
      
      float e = getElement(r, c);
      if (!(r == row && c == col)  && e != -1)
      {
        float angle = map(e, 0, 255, -PI, PI);
        xsum += cos(angle);
        ysum += sin(angle);       
        ec ++;
      }
    }
  }
  xsum /= 3.0f;
  ysum /= 3.0f;
  
  return map(atan2(ysum, xsum), -PI, PI, 0, 255);
}


void randomise()
{
  for (int row = 0; row < boardHeight; row ++) {
    for (int col = 0; col < boardWidth; col ++) {
      if (random(0, 1) < 0.5f)
      {
        board[row][col] = random(255);
      } else
      {
        board[row][col] = -1;
      }
    }
  }
}

void drawBoard()
{
  buffer.beginDraw();
  buffer.colorMode(RGB);
  buffer.background(0, 0, 0, 1);
  buffer.colorMode(HSB);
  buffer.noStroke();
  for (int row = 0; row < boardHeight; row ++) {
    for (int col = 0; col < boardWidth; col ++) {
      if (board[row][col] != -1)
      {
        buffer.fill(board[row][col], 255, 255);
        buffer.rect(col * cellWidth, row * cellWidth, cellWidth, cellWidth);
      }
    }
  }
  
  buffer.fill(255);
  println(mouseY/cellWidth);
  buffer.rect(50, mouseY/cellWidth, 50, 50);
  
  
  buffer.endDraw();
  image(buffer, 0, 0);
  
}

void life()
{
  colorMode(HSB);
  rectMode(CORNER);
  if (frameCount % 30 == 0)
  updateBoard();
  drawBoard();
}

int countAround(int row, int col)
{
  int count = 0;
  if (row > 0 && col > 0 && board[row-1][col-1] != -1)
  {
    count ++;
  }
  if (row > 0 && board[row -1][col] != -1)
  {
    count ++;
  }
  if (row > 0 && col < boardWidth -1 && board[row-1][col+1] != -1)
  {
    count ++;
  }
  if (col>0 && board[row][col-1] != -1)
  {
    count ++;
  }
  if (col < boardWidth - 1 && board[row][col+1] != -1)
  {
    count ++;
  }
  if (col > 0 && row < boardHeight -1 && board[row+1][col-1] != -1)
  {
    count ++;
  }
  if (row < boardHeight -1 && board[row + 1][col] != -1)
  {
    count ++;
  }
  if (row < boardHeight - 1 && col < boardWidth -1 && board[row+1][col+1] != -1) 
  {
    count ++;
  }

  return count;
}
