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


AWndList wndList;

ARect screenRect;

ATimerList timerList;

int timerListReady = 0;

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
    
}

//将左上角坐标为(x1,y1),右下角坐标为(x2,y2)的矩形区域从Buf绘制到屏幕上
void APBufPaint(int x1,int y1,int x2,int y2)
{
    acquire(&screenLock);
    x2 -= x1;
    x2 *= sizeof(AColor);
    int off = x1 + y1 * screenWidth;
    for (int y = y1 ; y < y2; y++)
    {
        memmove(screenAddr + off , screenBuf + off, x2);
        off += screenWidth;
    }
    release(&screenLock);
}

int sys_paintWindow(void)
{
    AHwnd hwnd = 0;
    AHdc hdc = 0;
    int wx,wy,sx,sy,w,h;
    //从控制台获取数据，并检验值是否合法
    if (argstr(0, (char **)&hwnd) < 0 || argint(1, &wx) < 0 || argint(2, &wy) < 0
        || argstr(3, (char **)&hdc) < 0 || argint(4, &sx) < 0
        || argint(5, &sy) < 0 || argint(6, &w) < 0 || argint(7, &h) < 0)
        return -1;
    
    if (sx < 0 || sy < 0 || h <= 0 || w <= 0 || sx + w > hdc->size.cx || sy + h > hdc->size.cy)
        return 0;
    
    if (wx < 0 || wy < 0 || wx + w > hwnd->wholeDc.size.cx || wy + h > hwnd->wholeDc.size.cy)
        return 0;
    
    //wx,wy相对于window的位置，hwnd->pos是window的左上角在屏幕的坐标
    wx += hwnd->pos.x;
    wy += hwnd->pos.y;
    
    int id = hwnd ->id;
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
            int p = wndList.data[id].prev;
            
            //前面有程序，被遮挡，不需要画
            while (p != -1)
            {
                //　改点在前面程序的数据区中
                if (contain(wndList.data[p].rect, wx + j, wy + i))
                    break;
                p = wndList.data[p].prev;
            }
            if (p != -1)
                continue;
            //假如父窗口未显示，则不显示该点
            p = hwnd->parentID;
            while (p != -1)
            {
                if (!contain(wndList.data[p].clientRect, wx + j, wy + i))
                    break;
                p = wndList.data[p].parentID;
            }
            if (p != -1)
                continue;
            
            AColor c = data[off_x + j];
            if (c.r != COLOR_NULL_ALPHA || c.g != COLOR_NULL_ALPHA || c.b != COLOR_NULL_ALPHA)
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
    APBufPaint(wx, wy, w, h);
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
    int msgQueueId = hwnd->msgQueueID;
    int pid = hwnd->pid;
    
    acquire(&wndList.data[msgQueueId].lock);
    AMsgQueue * queue = &wndList.data[msgQueueId].msgQueue;
    
    if (queue->head == queue->tail)
        sleep((void *)pid,&wndList.data[msgQueueId].lock);
    
    if (wndList.data[wndId].hwnd->msg.type == MSG_NULL)
        wndList.data[wndId].hwnd->msg = APMsgQueueDeQueue(queue);
    
    release(&wndList.data[msgQueueId].lock);
    return 0;
}


void sendMessage(int wndId, AMessage *msg)
{
    if (wndId == -1 || wndList.data[wndId].hwnd == 0)
        return;
    switch (msg->type)
    {

    }

    int msgQueueId = wndList.data[wndId].msgQueueID;
    AMsgQueue * queue = &wndList.data[msgQueueId].msgQueue;
    msg->wndID = wndId;
    APMsgQueueEnQueue(queue, *msg);
    wakeup((void *)wndList.data[wndId].pid);
}

//------------------------------------------------------------------------------------
//WndList
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
    list->head = list->tail = list->desktop = -1;
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
    list->data[p].pid = hwnd->pid;
    if (hwnd->msgQueueID >= 0)
        list->data[p].msgQueueID = hwnd->msgQueueID;
    else
        list->data[p].msgQueueID = hwnd->msgQueueID = p;
    
    list->data[p].rect.x = hwnd->pos.x;
    list->data[p].rect.y = hwnd->pos.y;
    list->data[p].rect.w = hwnd->wholeDc.size.cx;
    list->data[p].rect.h = hwnd->wholeDc.size.cy;
    
    list->data[p].clientRect.x = hwnd->clientPos.x + hwnd->pos.x;
    list->data[p].clientRect.y = hwnd->clientPos.y + hwnd->pos.y;
    list->data[p].clientRect.w = hwnd->Dc.size.cx;
    list->data[p].clientRect.h = hwnd->Dc.size.cy;
    if (hwnd->parentID < 0)
        hwnd->parentID = list->desktop;
    list->data[p].parentID = hwnd->parentID;
    
    for (int i = 0; hwnd->title[i]; ++i)
        list->data[p].title[i] = hwnd->title[i];
    list->data[p].title[i] = '\0';
    
    //desktop ---- id = -1
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


void APMsgQueueInit(AMsgQueue * queue)
{
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
    queue->data[queue->tail] = msg;
    queue->tail = (queue->tail + 1) % MESSAGE_QUEUE_SIZE;
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


