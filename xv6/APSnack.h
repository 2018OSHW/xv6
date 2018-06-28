#include "APInclude.h"
#include "APLib.h"

#define BLOCK_WIDTH 10
#define BLOCK_NUM_X 30
#define BLOCK_NUM_Y 30

int my_block[BLOCK_NUM_X][BLOCK_NUM_Y];//0->background;UP,Down,Left,RIGHT->direction;
bool my_food[BLOCK_NUM_X][BLOCK_NUM_Y]//0->no food

APoint head,tail;

int current_direction;

void Move();


void draw(AHwnd hwnd);

void init(AHwnd hwnd);

bool Is_Dead();
