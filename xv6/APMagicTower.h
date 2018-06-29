#ifndef APMAGICTOWER_H
#define APMAGICTOWER_H

#include "APInclude.h"
#include "APObject.h"
#include "user.h"
#include "APGui.h"
#include "APPaint.h"
#include "APLib.h"
#include "APWindow.h"

#define BLOCK_WIDTH 40
#define BLOCK_NUM_X 20
#define BLOCK_NUM_Y 12

#define START_HP 500
#define START_ATK 10
#define START_DEF 10


#define MONSTER_NUM 3

#define FLOOR_NUM 3
enum Bmp
{
	Backgroud,
	Wall,
	Monster1,
	Monster2,
	Monster3,
	Valiant,
	YellowDoor,
	BlueDoor,
	RedDoor,
	UpStair,
	DownStair,
	YellowKey,
	BlueKey,
	RedKey
};

ABitmap background = APLoadBitmap ("background.bmp");
ABitmap wall = APLoadBitmap ("wall.bmp");
ABitmap monster1 = APLoadBitmap ("monster1.bmp");
ABitmap monster2 = APLoadBitmap ("monster2.bmp");
ABitmap monster3 = APLoadBitmap ("monster3.bmp");
ABitmap valiant = APLoadBitmap ("valiant.bmp");
ABitmap yellowdoor = APLoadBitmap ("yellowdoor.bmp");
ABitmap bluedoor = APLoadBitmap ("bluedoor.bmp");
ABitmap reddoor = APLoadBitmap ("reddoor.bmp");
ABitmap upstair = APLoadBitmap ("upstair.bmp");
ABitmap downstair = APLoadBitmap ("downstair.bmp");
ABitmap yellowkey = APLoadBitmap ("yellowkey.bmp");
ABitmap bluekey = APLoadBitmap ("bluekey.bmp");
ABitmap redkey = APLoadBitmap ("redkey.bmp");

enum Direction
{
	Up,
	Down,
	Left,
	Right
};

enum Status
{
	Play,
	Menu,
	Dead
	
};

int status;

int floor;
APoint position;
int hp,atk,def;
int my_key[3];
int monster_info[MONSTER_NUM][3];//hp.atk,def
int my_tower[FLOOR_NUM][BLOCK_NUM_X][BLOCK_NUM_Y];



//颜色常量	


APoint nextpoint(APoint p,int direction);
void TowerInit();
void init(AHwnd hwnd);
bool fight()


#endif
