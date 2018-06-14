#ifndef APOBJECT_H_
#define APOBJECT_H_

#include "types.h"
#include "APInclude.h"
#include "spinlock.h"

typedef struct AColor
{
    uchar r;
    uchar g;
    uchar b;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    AColor rgb;
    rgb.r = r;
    rgb.g = g;
    rgb.b = b;
    return rgb;
}

typedef struct ABitmap
{
    uint width;
    uint height;
    AColor *data;
}ABitmap;

typedef struct ASize
{
    int cx;
    int cy;
}ASize;

typedef struct ARect
{
    int x;
    int y;
    int w;
    int h;
}ARect;

typedef struct APen
{
    AColor color;
    int size;
}APen;

typedef struct ABrush
{
    AColor color;
}ABrush;

typedef struct AFont
{
    AColor color;
}AFont;

typedef struct ADc
{
    ASize size;
    APen  pen;
    ABrush brush;
    AFont font;
    AColor *content;
}ADc;
typedef ADc * AHdc;

typedef struct AMessage
{
    uint type;
    uint param;
    uint wndID;
}AMessage;

typedef struct AMsgQueue
{
    AMessage data[MESSAGE_QUEUE_SIZE];
    uint head;
    uint tail;
}AMsgQueue;


typedef struct APoint
{
    int x;
    int y;
}APoint;

typedef struct AWindow
{
    //index in the Wndlist and Program id
    int id;
    int pid;
    int msgQueueID;
    
    //whether display character
    bool is_character;
    
    // if activate Grid-Mode
    bool is_map;
    //Grid mode
    int *GRID;
    int total_page;
    int cur_page;
    //Non-Grid mode
    ADc wholeDc;
    
    //Universal structure
    ADc Dc;
    ADc TitleDc;
    
    //current message wait to be processed
    AMessage msg;
    bool (*wndProc)(struct AWindow*,AMessage);
    //titlt
    char title[MAX_WND_TITLE_LENGTH];
}AWindow;
typedef AWindow *AHwnd;

typedef struct AWndListNode
{
    int prev,next;
    
    //message queue lock
    spinlock lock;
    // current message
    AMessage msg;
    //message queue
    AMsgQueue msgQueue;
    // master window id
    int msgQueueID;
    
    //window
    AHwnd hwnd;
}AWndListNode;

typedef struct AWndList
{
    AWndListNode data[MAX_WND_NUM];
    int head;
    int tail;
    int space;      
    int desktop;
    int entry;
    struct spinlock lock;
}AWndList;

typedef struct ATimerList
{
    struct
    {
        int wndId;
        int id;
        int interval;
        int count;
        int next;
    } data[MAX_TIMER_NUM];
    int head;
    int space;
    struct spinlock lock;
}ATimerList;

typedef struct
{
    unsigned short  bfType;
    unsigned long   bfSize;
    unsigned short  bfReserved1;
    unsigned short  bfReserved2;
    unsigned long   bfOffBits;
} ABitmapFileHeader;

typedef struct
{
    unsigned long       biSize;
    long                biWidth;
    long                biHeight;
    unsigned short      biPlanes;
    unsigned short      biBitCount;
    unsigned long       biCompression;
    unsigned long       biSizeImage;
    long                biXPelsPerMeter;
    long                biYPelsPerMeter;
    unsigned long       biClrUsed;
    unsigned long       biClrImportant;
} ABitmapInfoHeader;
//bitmap�Ĵ����ʽ

int APError(int index);


#endif
