#ifndef APINCLUDE_H
#define APINCLUDE_H

#define SCREEN_WIDTH 800
#define SCREEN_HEIGHT 600

#define WORLD_WIDTH 1600
#define WORLD_HEIGHT 1800

#define MESSAGE_QUEUE_SIZE 64
#define MAX_WND_NUM 10
#define MAX_WND_TITLE_LENGTH 20

//字符初始化
#define GBK2312_SIZE 261696
#define ASCII_SIZE 2048

#define COLOR_NULL_ALPHA 0x0c
#define COLOR_NULL RGB(COLOR_NULL_ALPHA, COLOR_NULL_ALPHA, COLOR_NULL_ALPHA)

#define SCREEN_EDGE_SIZE 20
#define WND_EDGE_SIZE 4
#define WND_TITLE_HEIGHT 30

typedef char bool;
#define true (char)1
#define false (char)0
#define True true
#define False false

#define DEFAULT_BACKGROUND_COLOR 0xbfff
#define DEFAULT_WINDOW_COLOR 0x0a



enum MSG {
    MSG_NULL,
    
};

enum WndFocusState
{
    WFS_HAS_FOCUS,
    WFS_LOSE_FOCUS,
    WFS_NO_FOCUS,
    WFS_CHILD_FOCUS
};

#endif
