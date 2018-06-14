#ifndef APINCLUDE_H
#define APINCLUDE_H

#define SCREEN_WIDTH 800
#define SCREEN_HEIGHT 600

#define MAX_DC_HEIGHT 1600

#define MAX_TIMER_NUM 10
#define MESSAGE_QUEUE_SIZE 64
#define MAX_WND_NUM 10
#define MAX_WND_TITLE_LENGTH 20

#define WND_TITLE_HEIGHT 50

#define GRID_WIDTH 50
#define GRID_W_NUMBER   SCREEN_WIDTH/GIRD_WIDTH
#define GRID_H_NUMBER   (SCREEN_HEIGHT - WND_TITLE_HEIGHT)/GRID_HEIGHT

#define DEFAULT_BACKGROUND_COLOR 0xffffff
#define DEFAULT_TITLE_COLOR 0x0000ff

enum GRID {
   GRID_WALL,
   GRID_ROAD,
   GRID_GRASS,
   GRID_RIVER,
   GRID_UP_1,
   GRID_DOWN_1,
   GRID_PROGRAM_SNAKE,
   GRID_PALACE,
};


//字符初始化
#define GBK2312_SIZE 261696
#define ASCII_SIZE 2048

#define COLOR_NULL_ALPHA 0x0c
#define COLOR_NULL RGB(COLOR_NULL_ALPHA, COLOR_NULL_ALPHA, COLOR_NULL_ALPHA)


typedef char bool;
#define true (char)1
#define false (char)0
#define True true
#define False false


#define MAX_X 6
#define MAX_Y 4
//界面中横向个数和纵向个数



enum MSG {
    MSG_NULL,
	MSG_DRAWMAINWINDOW,
    
    MSG_INIT,
    MSG_PAINT,
    MSG_TIMEOUT,
};

enum WndFocusState
{
    WFS_HAS_FOCUS,
    WFS_LOSE_FOCUS,
    WFS_NO_FOCUS,
    WFS_CHILD_FOCUS
};

#endif
