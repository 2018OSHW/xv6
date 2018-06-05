#include "APGui.h"
#include "types.h"
#include "x86.h"
#include "memlayout.h"
#include "defs.h"
#include "APObject.h"

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
    
    initlock(&sreenLock,"sreenLock");
    
    
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
    
    int i,j;
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
            p = hwnd->parentId;
            while (p != -1)
            {
                if (!contain(wndList.data[p].clientRect, wx + j, wy + i))
                    break;
                p = wndList.data[p].parentId;
            }
            if (p != -1)
                continue;
            
            PColor c = data[off_x + j];
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
    ABufPaint(wx, wy, w, h);
    return 0;
}
    
    
    


