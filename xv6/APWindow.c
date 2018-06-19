//
//  APWindow.c
//  
//
//  Created by Poo Lei on 2018/6/5.
//
#include "types.h"
#include "user.h"
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
      sendMessage(hwnd->id, &msg);
}



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    if (r == 0)
        printf(1,"%s - window creation failed!\n",title);
    
    //title init
    strcpy(r->title, title);
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    if (r->Dc.content == 0)
        printf(1,"$s window - Dc creation failed!\n",title);
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    
    r->msg.type = MSG_NULL;
    r->pid = getpid();
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    if (r->TitleDc.content == 0)
        printf(1,"%s window - Title DC creation failed!\n",title);
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    
    r->is_grid = is_map;
    //if is Grid Mode
    if (is_map)
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
        r->total_page = page;
        r->cur_page = 0;
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
        if (r->wholeDc.content == 0)
            printf(1,"%s window - whole DC creation failed!\n",title);
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    }
    return r;
}

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
            
            
    }
    return False;
}

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    if (msg->wndID != hwnd->id)
        return False;
    return True;
}

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    hwnd->wndProc = wndProc;
    //--------add window to list
    registWindow(hwnd);
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    msg.wndID = hwnd->id;
    APSendMessage(hwnd,msg);
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
        hwnd->msg.type = MSG_NULL;
    }
}

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    if (!iconReady)
    {
        iconReady = 1;
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    {
        printf(1,"error! paint non-Grid Mode program! \n");
        return;
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    {
        printf(1,"Grid mode page error!");
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
        {
            index = start + GRID_W_NUMBER * j + i;
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
            {
                case GRID_WALL:
                    //printf(1,"Grid_Wall");
                    /*pen.color = RGB(0xd2,0x69,0x1e);
                    pen.size = 1;
                    brush.color = RGB(0xd2,0x69,0x1e);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);*/
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
                    break;
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
                    pen.size = 1;
                    brush.color = RGB(0x69,0x69,0x69);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
                    break;
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    pen.color = RGB(0x00,0x80,0x00);
                    pen.size = 1;
                    brush.color = RGB(0x00,0x80,0x00);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
                    break;
                case GRID_RIVER:
                    //printf(1,"Grid_River");
                    pen.color = RGB(0x00,0xbf,0xff);
                    pen.size = 1;
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
            }
        }
    }
}
