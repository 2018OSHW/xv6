#include "APGui.h"
#include "types.h"
#include "x86.h"
#include "memlayout.h"
#include "defs.h"


ushort screenWidth = 0;
ushort screenHeight = 0;
uchar bitsPerPixel = 0;
static AColor *screenAddr = 0;
static AColor *screenBuf = 0;
static AColor *screenContent = 0;
struct spinlock screenLock;

struct ADc character_shape;
AHdc character = &character_shape;


AColor character_img[GRID_WIDTH][GRID_WIDTH] =
{
    {{0xff,0xff,0xff},{0xff,0xff,0xff},{0xff,0x00,0x00},{0xff,0xff,0xff},{0xff,0xff,0xff}},
    {{0xff,0xff,0xff},{0xff,0x00,0x00},{0xff,0xff,0xff},{0xff,0x00,0x00},{0xff,0xff,0xff}},
    {{0xff,0x00,0x00},{0xff,0xff,0xff},{0xff,0xff,0xff},{0xff,0xff,0xff},{0xff,0x00,0x00}},
    {{0xff,0xff,0xff},{0xff,0x00,0x00},{0xff,0xff,0xff},{0xff,0x00,0x00},{0xff,0xff,0xff}},
    {{0xff,0xff,0xff},{0xff,0xff,0xff},{0xff,0x00,0x00},{0xff,0xff,0xff},{0xff,0xff,0xff}}
};
//index of character in the grid
int character_pre_x = 1, character_pre_y = 1;
int character_x = 1,character_y = 1;

//character_move
void APDrawCharacter(int is_grid)
{
    acquire(&screenLock);
    if (is_grid)
    {
        int off = character_pre_y * GRID_WIDTH * screenWidth + character_pre_x * GRID_WIDTH;
        int size = sizeof(AColor) * GRID_WIDTH;
        for (int j = 0; j < GRID_WIDTH; j++)
        {
            memmove(screenBuf + off, screenContent + off,size);
            memmove(screenAddr + off,screenContent + off,size);
            off += screenWidth;
        }
        off = character_y * GRID_WIDTH * screenWidth + character_x * GRID_WIDTH;
        for (int j = 0; j < GRID_WIDTH; j++)
        {
            for (int i = 0; i < GRID_WIDTH; i++)
            {
                screenBuf[off + i] = character_img[i][j];
                screenAddr[off + i] = character_img[i][j];
            }
            off += screenWidth;
        }
    }
    release(&screenLock);
}


AWndList wndList;

ARect screenRect;

ATimerList timerList;

int timerListReady = 0;

void APCharacterInit(void)
{
    character_shape.size.cx = GRID_WIDTH;
    character_shape.size.cy = GRID_WIDTH;
    character_shape.content = (AColor*)malloc(sizeof(AColor)*character_shape.size.cx*character_shape.size.cy);
    if (character_shape.content == 0)
        cprintf("character_shape init failed!\n");
}

void APGuiInit(void)
{
    screenAddr = (AColor *)(*((uint*)P2V(0x1028)));
    screenWidth = *((ushort *)P2V(0x1012));
    screenHeight = *((ushort *)P2V(0x1014));
    bitsPerPixel = *((uchar*)P2V(0x1019));
    screenBuf = screenAddr + screenWidth * screenHeight;
    screenContent = screenBuf + screenWidth * screenHeight;
    
    
    cprintf("screen addr : %x, screen width : %d, screen height : %d, bitsPerPixel: %d \n",
            screenAddr, screenWidth,screenHeight,bitsPerPixel);
    
    initlock(&screenLock,"sreenLock");
    APCharacterInit();
    
}

//将左上角坐标为(x1,y1),右下角坐标为(x2,y2)的矩形区域从Buf绘制到屏幕上
void APBufPaint(int x1,int y1,int x2,int y2,int is_grid)
{
    acquire(&screenLock);
    x2 -= x1;
    x2 *= sizeof(AColor);
    int off = x1 + y1 * screenWidth;
    for (int y = y1 ; y < y2; y++)
    {
        memmove(screenBuf + off , screenContent + off, x2);
        memmove(screenAddr + off, screenContent + off, x2);
        off += screenWidth;
    }
    
    if (is_grid)
    {
        if (x1 <= character_x * GRID_WIDTH + GRID_WIDTH && x2 >= character_x * GRID_WIDTH
            && y1 <= character_y * GRID_WIDTH + GRID_WIDTH && y2 >= character_y * GRID_WIDTH)
        {
            for (int j = 0; j < GRID_WIDTH ; j++)
            {
                off = (character_y * GRID_WIDTH + j) * screenWidth + character_x * GRID_WIDTH;
                if (character_y * GRID_WIDTH + j < y1)
                    continue;
                if (character_y * GRID_WIDTH + j > y2)
                    break;
                for (int i = 0; i < GRID_WIDTH; i++)
                {
                    if (character_x * GRID_WIDTH + i < x1)
                        continue;
                    if (character_x * GRID_WIDTH + i > x2)
                        break;
                    screenBuf [off + i] = character_img[i][j];
                    screenAddr[off + i] = character_img[i][j];
                }
                off += screenWidth;
            }
        }
    }
    //cprintf("arbitrary set window color!\n");
    //memset(screenAddr, DEFAULT_WINDOW_COLOR, sizeof(AColor) * screenWidth * screenHeight);
    release(&screenLock);
}

//paintwindow: (hwnd,wx,wy,hdc,sx,sy,w,h,is_grid)
int sys_paintWindow(void)
{
    //cprintf("in paintWindow function:---- 1  \n");
    AHwnd hwnd = 0;
    AHdc hdc = 0;
    int wx,wy,sx,sy,w,h,is_grid;
    //从控制台获取数据，并检验值是否合法
    if (argstr(0, (char **)&hwnd) < 0 || argint(1, &wx) < 0 || argint(2, &wy) < 0
        || argstr(3, (char **)&hdc) < 0 || argint(4, &sx) < 0
        || argint(5, &sy) < 0 || argint(6, &w) < 0 || argint(7, &h) < 0
        || argint(8, &is_grid) < 0)
        return -1;
    
    if (sx < 0 || sy < 0 || h <= 0 || w <= 0 || sx + w > hdc->size.cx || sy + h > hdc->size.cy)
        return 0;
    
    if (wx < 0 || wy < 0 || wx + w > screenWidth || wy + h > screenHeight)
        return 0;
    
    //wx,wy是window重绘左上角坐标
    
    //int id = hwnd ->id;
    //cprintf("in paintWindow function:-----2  \n");
    AColor *data = hdc->content;
    
    int j;
    for (int i = 0; i < h;i++)
    {
        if (wy + i < 0)
        {
            i = -wy - 1;
            continue;
        }
        else if (wy + i >= screenHeight)
            break;
        int off_x = (sy + i) * hdc->size.cx + sx;
        int screen_off_x = (wy + i) * screenWidth + wx;
        for (j = 0; j < w; ++j)
        {
            if (wx + j < 0)
            {
                j = -wx - 1;
                continue;
            }
            else if (wx + j >= screenWidth)
                break;
            
            AColor c = data[off_x + j];
            if (c != COLOR_NULL)
                screenContent[screen_off_x + j] = c;
        }
    }
    w += wx;
    h += wy;
    if (wx < 0)
        wx = 0;
    if (wy < 0)
        wy = 0;
    if (h > screenHeight)
        h = screenHeight;
    if (w > screenWidth)
        w = screenWidth;
    //release(&videoLock);
    APBufPaint(wx, wy, w, h,is_grid);
    return 0;
}

    

char GBK2312[GBK2312_SIZE];
char ASCII[ASCII_SIZE];

int sys_initStringFigure(void)
{
    char * gbk2312 = 0;
    int n1;
    char * ascii = 0;
    int n2;
    if (argstr(0, (char **)&gbk2312) < 0 || argint(1, &n1) < 0 || argstr(2, (char **)&ascii) < 0 || argint(3, &n2) < 0)
        return -1;
    for (int i = 0; i < n1; i += 32)
    {
        for (int j = 0; j < 16; ++j)
        {
            GBK2312[i + j] = gbk2312[i + 2 * j];
            GBK2312[i + 16 + j] = gbk2312[i + 2 * j + 1];
        }
    }
    memmove(ASCII, ascii, sizeof(char) * n2);
    return 0;
}

int sys_sendMessage(void)
{
    int wndId = 0;
    AMessage * msg = 0;
    if (argint(0, &wndId) < 0 || argstr(1, (char**)&msg) < 0)
        return -1;
    sendMessage(wndId, msg);
    return 0;
}

int sys_registWindow(void)
{
    AHwnd hwnd = 0;
    if (argstr(0, (char **)&hwnd) < 0)
        return -1;
    APWndListAddToHead(&wndList, hwnd);
    return 0;
}

int sys_getMessage(void)
{

    AHwnd hwnd = 0;
    if (argstr(0, (char **)&hwnd) < 0)
        return -1;
    int wndId = hwnd->id;
    int pid = hwnd->pid;
    
    //cprintf("in function --- getMessage:WndId: %d\n",wndId);
    
    acquire(&wndList.data[wndId].lock);
    AMsgQueue * queue = &wndList.data[wndId].msgQueue;
    
    //cprintf("head:%d,tail:%d \n",queue->head,queue->tail);
    if (queue->head == queue->tail)
    {
       // cprintf("sleeping\n");
        sleep((void *)pid,&wndList.data[wndId].lock);
    }
    if (wndList.data[wndId].hwnd->msg.type == MSG_NULL)
    {
      //  cprintf("poping msg!\n");
        wndList.data[wndId].hwnd->msg = APMsgQueueDeQueue(queue);
    }
    
    release(&wndList.data[wndId].lock);
    return 0;
}


void sendMessage(int wndId, AMessage *msg)
{
    if (wndId == -1 || wndList.data[wndId].hwnd == 0)
        return;
    //cprintf("send message: WndID:%d \n",wndId);
    switch (msg->type)
    {

    }


    AMsgQueue * queue = &wndList.data[wndId].msgQueue;
    msg->wndID = wndId;
    APMsgQueueEnQueue(queue, *msg);
    wakeup((void *)wndList.data[wndId].hwnd->pid);
}

//------------------------------------------------------------------------------------
//WndList

//space--insert_position
void APWndListInit(AWndList * list)
{
    int i = 0;
    for (i = 0; i < MAX_WND_NUM; ++i)
    {
        list->data[i].hwnd = 0;
        list->data[i].prev = -1;
        list->data[i].next = i + 1;
        APMsgQueueInit(&list->data[i].msgQueue);
        initlock(&list->data[i].lock, "msglock");
    }
    list->data[i - 1].next = -1;
    initlock(&list->lock, "wndListLock");
    list->head = list->tail  = -1;
    list->desktop = 0;
    list->space = 0;
}

void APWndListAddToHead(AWndList * list, AHwnd hwnd)
{
    acquire(&list->lock);
    int p = list->space;
    if (p == -1)
    {
        cprintf("too much window\n");
        return;
    }
    list->space = list->data[list->space].next;
    list->data[p].hwnd = hwnd;
    
    hwnd->id = p;
    
    //desktop ---- id = 0
    list->data[p].next = list->head;
    list->data[p].prev = -1;
    if (list->head == -1)
        list->tail = p;
    else
        list->data[list->head].prev = p;
    
    list->head = p;
    release(&list->lock);
}

void APWndListMoveToHead(AWndList * list, int wndId)
{
    if (wndId < 0)
        return;
    acquire(&list->lock);
    if (wndId != list->head)
    {
        list->data[list->data[wndId].prev].next = list->data[wndId].next;
        if (list->data[wndId].next == -1)
            list->tail = list->data[wndId].prev;
        else
            list->data[list->data[wndId].next].prev = list->data[wndId].prev;

        list->data[list->head].prev = wndId;
        list->data[wndId].prev = -1;
        list->data[wndId].next = list->head;
        list->head = wndId;
    }
    release(&list->lock);
}

void APWndListRemove(AWndList * list, int wndId)
{
    if (wndId < 0)
        return;
    acquire(&list->lock);
    if (wndId == list->head)
    {
        if (list->data[wndId].next == -1)
            list->head = list->tail = -1;
        else
        {
            list->head = list->data[list->head].next;
            list->data[list->head].prev = -1;
        }
    }
    else if (wndId == list->tail)
    {
        list->tail = list->data[list->tail].prev;
        list->data[list->tail].next = -1;
    }
    list->data[wndId].prev = -1;
    list->data[wndId].next = list->space;
    list->data[wndId].hwnd = 0;
    list->space = wndId;

    APMsgQueueInit(&list->data[wndId].msgQueue);
    
    release(&list->lock);
}

void APWndListDestroy(AWndList * list)
{
    acquire(&list->lock);
    release(&list->lock);
}



//------------------------------------------------------------------------------------
//Msg

//Msg Queue
//head = start, tail = end next

void APMsgQueueInit(AMsgQueue * queue)
{
    // as an array
    queue->head = queue->tail = 0;
}

void APMsgQueueEnQueue(AMsgQueue * queue, AMessage msg)
{
    if ((queue->tail + 1) % MESSAGE_QUEUE_SIZE == queue->head)
    {
        cprintf("Error! Message Queue is full\n");
        return;
    }
    
    switch (msg.type)
    {
        default:
            break;
    }
    //cprintf("MsgQueue-En-Queue:tail %d \n",queue->tail);
    queue->data[queue->tail] = msg;
    queue->tail = (queue->tail + 1) % MESSAGE_QUEUE_SIZE;
    //cprintf("MsgQueue-En-Queue:after add tail %d \n",queue->tail);
}

//弹出消息队列顶端
AMessage APMsgQueueDeQueue(AMsgQueue * queue)
{
    if (queue->head == queue->tail)
    {
        AMessage msg;
        msg.type = MSG_NULL;
        return msg;
    }
    int p = queue->head;
    queue->head = (queue->head + 1) % MESSAGE_QUEUE_SIZE;
    return queue->data[p];
}

//-----------------------------------------------------------------------------
//Timer
void TimerCount()
{
    if (!timerListReady)
        return;
    acquire(&timerList.lock);
    int p = timerList.head;
    while(p != -1)
    {
        timerList.data[p].count ++;
        if (timerList.data[p].count >= timerList.data[p].interval)
        {
            timerList.data[p].count = 0;
            AMessage msg;
            msg.type = MSG_TIMEOUT;
            sendMessage(timerList.data[p].wndId,&msg);
        }
        p = timerList.data[p].next;
    }
    release(&timerList.lock);
}


void APTimerListInit(ATimerList * list)
{
    int i;
    for (i = 0; i < MAX_TIMER_NUM; i++)
        list->data[i].next = i + 1;
    list->head = -1;
    list->space = 0;
    list->data[i].next = -1;
    initlock(&list->lock, "timerLock");
    timerListReady = 1;
}

void APTimerListAddToHead(ATimerList * list, int wndId, int id, int interval)
{
    acquire(&list->lock);
    int p = list->space;
    if (p == -1)
    {
        cprintf("Error! Too much Timer!\n");
        return;
    }
    list->space = list->data[p].next;
    list->data[p].next = list->head;
    list->head = p;
    list->data[p].wndId = wndId;
    list->data[p].id = id;
    list->data[p].interval = interval;
    list->data[p].count = 0;
    release(&list->lock);
    
}

void APTimerListRemoveWnd(ATimerList * list, int wndId)
{
    acquire(&list->lock);
    int p = list->head;
    int q = p;
    while (p != -1)
    {
        if (list->data[p].wndId == wndId)
        {
            if (p == list->head)
            {
                list->head = list->data[p].next;
                list->data[p].next = list->space;
                list->space = p;
                p = list->head;
                q = p;
            }
            else
            {
                list->data[q].next = list->data[p].next;
                list->data[p].next = list->space;
                list->space = p;
                p = list->data[q].next;
            }
        }
        else
        {
            q = p;
            p = list->data[p].next;
        }
    }
    release(&list->lock);
}

void APTimerListRemoveID(ATimerList * list, int wndId, int id)
{
    acquire(&list->lock);
    int p = list->head;
    int q = p;
    while (p != -1)
    {
        if (list->data[p].wndId == wndId && list->data[p].id == id)
        {
            if (p == list->head)
            {
                list->head = list->data[p].next;
                list->data[p].next = list->space;
                list->space = p;
                p = list->head;
                q = p;
            }
            else
            {
                list->data[q].next = list->data[p].next;
                list->data[p].next = list->space;
                list->space = p;
                p = list->data[q].next;
            }
        }
        else
        {
            q = p;
            p = list->data[p].next;
        }
    }
    release(&list->lock);
}

void setuptimer(AHwnd hwnd,int id, int interval)
{
    APTimerListAddToHead(&timerList,hwnd->id,id,interval/10);
}
void deletetimer(AHwnd hwnd, int id)
{
    APTimerListRemoveID(&timerList,hwnd->id,id);
}








