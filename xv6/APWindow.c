//
//  APWindow.c
//  
//
//  Created by Poo Lei on 2018/6/5.
//
#include "types.h"
#include "user.h"
#include "APWindow.h"


void APSendMessage(AHwnd hwnd, AMessage msg)
{
      sendMessage(hwnd->id, &msg);
}


AHwnd APCreateWindow(char * title, AHwnd parent, int x, int y, int width, int height)
{
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    if (r == 0)
        APError(0);
    
    strcpy(r->title, title);
    
    r->pos.x = x;
    r->pos.y = y;
    
    r->wholeDc.size.cx = width;
    r->wholeDc.size.cy = height;
    r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    if (r->wholeDc.content == 0)
        APError(0);
    memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    
    r->clientPos.x = WND_EDGE_SIZE;
    r->clientPos.y = WND_TITLE_HEIGHT;
    r->Dc.size.cx = width - WND_EDGE_SIZE * 2;
    r->Dc.size.cy = height - WND_TITLE_HEIGHT - WND_EDGE_SIZE;
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    if (r->Dc.content == 0)
        APError(0);
    memset(r->Dc.content, 0x0, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    
    r->msg.type = MSG_NULL;
    r->state = 0;
    r->pid = getpid();
    r->msgQueueID = -1;
    
    if (parent)
        r->parentID = parent->id;
    else
        r->parentID = -1;
    return r;
}

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    switch (msg.type)
    {
        case MSG_PAINT:
            paintWindow(hwnd, 0, 0, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy);
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
    registWindow(hwnd)
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    msg.wndID = hwnd->id;
    APSendMessage(hwnd,msg);
    //--------process window
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
        hwnd->msg.type = MSG_NULL;
    }
}
