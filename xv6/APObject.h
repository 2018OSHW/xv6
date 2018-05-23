#ifndef APOBJECT_H_
#define APOBJECT_H_

#include "types.h"


typedef struct Pos
{
    uint x,y;               //pos x,y
};

typedef struct APPos
{
    struct Pos scene;       //pos x,y in the scene
    struct Pos view;        //pos x,y in the view (view is the window)
};

struct Pos get_view_pos(strucpt APPos item, struct APPos window);


typedef struct AColor
{
    uchar r;
    uchar g;
    uchar b;
};

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
};

typedef struct ASize
{
    int cx;
    int cy;
};

typedef struct ARect
{
    int x;
    int y;
    int w;
    int h;
};

typedef struct APen
{
    AColor color;
    int penwidth;
};

typedef struct ABrush
{
    AColor color;
};

typedef struct AFont
{
    AColor color;
};

typedef struct ADc
{
    ASize size;
    APen  pen;
    ABrush brush;
    AFont font;
    AColor *content;
};
typedef ADc * AHdc;

typedef struct AMessage
{
    uint type;
    uint param;
    uint wndID;
};

typedef struct AMsgQueue
{
    AMessage data[MESSAGE_QUEUE_SIZE];
    uint head;
    uint tail;
};

typedef struct APoint
{
    int x;
    int y;
};

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
    aDc wholeDc;
    
    AMessage msg;
    bool (*wndProc)(struct AWindow*,AMessage);
    
    char title[MAX_WND_TITLE_LENGTH];
    
};
typedef AWindow *AHwnd;

typedef struct AWndListNode
{
    int prev,next;
    int pID;
    int parentID;
    struct spinlock lock;
    
    AMessage msg;
    int msgQueueID;
    AMsgQueue msg;
    
    ARect rect;
    ARect clientRect;
    
    char title[MAX_WND_TITLE_LENGTH];
    AHwnd hwnd;
};

typedef struct AWndList
{
    AWndListNode data[MAX_WND_NUM];
    int head;
    int tail;
    int space;
    int desktop;
    int entry;
    struct spinlock lock;
};

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
};




#endif
