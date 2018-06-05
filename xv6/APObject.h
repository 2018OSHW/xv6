#ifndef APOBJECT_H_
#define APOBJECT_H_

#include "types.h"
#include "APInclude.h"
#include "spinlock.h"

typedef struct Pos
{
    uint x,y;               //pos x,y
}Pos;

typedef struct APPos
{
    struct Pos scene;       //pos x,y in the scene
    struct Pos view;        //pos x,y in the view (view is the window)
}APPos;

struct Pos get_view_pos(struct APPos item, struct APPos window);


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
    int penwidth;
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
    int id;
    int pid;
    int msgQueueID;
    int parentID;
    int childFocusId;
    int focusState;
    
    APoint pos;
    APoint clientPos;
    
    ADc Dc;
    ADc wholeDc;
    
    AMessage msg;
    bool (*wndProc)(struct AWindow*,AMessage);
    
    char title[MAX_WND_TITLE_LENGTH];
    
}AWindow;
typedef AWindow *AHwnd;

typedef struct AWndListNode
{
    int prev,next;
    int pID;
    int parentID;
    struct spinlock lock;
    
    AMessage msg;
    int msgQueueID;
    AMsgQueue msgQueue;
    
    ARect rect;
    ARect clientRect;
    
    char title[MAX_WND_TITLE_LENGTH];
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
        int curItrvl;
        int next;
    } data[MAX_WND_NUM];
    int head;
    int space;
    struct spinlock lock;
}ATimerList;

#pragma pack(2)
typedef struct
{
    unsigned short  bfType;
    unsigned long   bfSize;
    unsigned short  bfReserved1;
    unsigned short  bfReserved2;
    unsigned long   bfOffBits;
} PBitmapFileHeader;

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
} PBitmapInfoHeader;

int APError(int)
{
    return;
}

#endif
