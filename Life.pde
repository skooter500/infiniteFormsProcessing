void crossShape()
{
  clearBoard();
  int half = size / 2;
  for (int i = 0; i < size; i ++)
  {
    board[i][half] = random(255);
    board[half][i] = random(255);
  }
}

void xShape()
{
  clearBoard();
  int half = size / 2;
  for (int i = 0; i < size; i ++)
  {
    board[i][i] = random(255);
    board[(size - 1) - i][i] = random(255);
  }
}

void clearBoard()
{
  for (int row = 0; row < size; row ++)
  {
    for (int col = 0; col < size; col ++)
    {
      board[row][col] = -1;
    }
  }
}

int size = 200;

float[][] board = new float[size][size];
float[][] nextBoard  = new float[size][size];

void updateBoard()
{
  for (int row = 0; row < size; row ++)
  {
    for (int col = 0; col < size; col ++)
    {
      int c = countAround(row, col);
      if (board[row][col] >= 0)
      {
        if (c == 2 || c == 3)
        {
          nextBoard[row][col] = board[row][col];
        } else
        {
          nextBoard[row][col] = -1;
        }
      } else
      {
        if (c == 3)
        {
          nextBoard[row][col] = randomAround(row, col);
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
  if (row >= 0 && row < size && col >= 0 && col < size)
  {
    return board[row][col];
  } else return -1;
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
      if (r != row && c !=col && e != -1)
      {
        float angle = map(e, 0, 255, 0, TWO_PI);
        xsum += cos(angle);
        ysum += sin(angle);       
        ec ++;
      }
    }
  }
  println(ec); //<>//
  xsum /= 3.0f;
  ysum /= 3.0f;
  return atan2(ysum, xsum) + PI;
}


void randomise()
{
  for (int row = 0; row < size; row ++) {
    for (int col = 0; col < size; col ++) {
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
  float cellWidth = width / size;
  for (int row = 0; row < size; row ++) {
    for (int col = 0; col < size; col ++) {
      if (board[row][col] != -1)
      {
        fill(board[row][col], 255, 255);
      } else
      {
        fill(0);
      }
      rect(col * cellWidth, row * cellWidth, cellWidth, cellWidth);
    }
  }
}

void life()
{
  background(0);
  colorMode(HSB);
  drawBoard();
  updateBoard();
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
  if (row > 0 && col < size -1 && board[row-1][col+1] != -1)
  {
    count ++;
  }
  if (col>0 && board[row][col-1] != -1)
  {
    count ++;
  }
  if (col < size - 1 && board[row][col+1] != -1)
  {
    count ++;
  }
  if (col > 0 && row < size -1 && board[row+1][col-1] != -1)
  {
    count ++;
  }
  if (row < size -1 && board[row + 1][col] != -1)
  {
    count ++;
  }
  if (row < size - 1 && col < size -1 && board[row+1][col+1] != -1) 
  {
    count ++;
  }

  return count;
}