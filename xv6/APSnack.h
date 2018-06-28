#include "APInclude.h"

#define BLOCK_WIDTH 10
#define BLOCK_NUM_X 30
#define BLOCK_NUM_Y 30

struct SnackBody
{
int begin_x;
int begin_y;
int direction;
int length;
SnackBody *next,*before;
};

SnackBody *my_snack = NULL;

void Move(SnackBody *head,bool eat);

void ChangeDirection(SnackBody *head,int direction); 

void draw(AHwnd hwnd);

void init(AHwnd hwnd);
