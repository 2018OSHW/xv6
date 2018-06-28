#ifndef APDESKTOP_H
#define APDESKTOP_H

#include "APInclude.h"
#include "APObject.h"
#include "user.h"
#include "APGui.h"
#include "APPaint.h"
#include "APLib.h"
#include "APWindow.h"

#define BLOCK_WIDTH 10
#define BLOCK_NUM_X 30
#define BLOCK_NUM_Y 30

int my_block[BLOCK_NUM_X][BLOCK_NUM_Y];//0->background;UP,Down,Left,RIGHT->direction;
bool my_food[BLOCK_NUM_X][BLOCK_NUM_Y];//0->no food

APoint head,tail;

int current_direction, current_direction_copy;

APoint nextpoint(APoint p,int direction);


void Move();
bool wndProc(AHwnd hwnd,AMessage msg);
void init(AHwnd hwnd);
void timerUpdate(AHwnd hwnd);

void keyDown(AHwnd hwnd,AMessage msg);

void draw(AHwnd hwnd);



bool Is_Dead();

void updateFood();

#endif
