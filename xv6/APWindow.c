//
//  APWindow.c
//  
//
//  Created by Poo Lei on 2018/6/5.
//
#include "types.h"
#include "user.h"
#include "APWindow.h"

int APError(int index)
{
    return index;
}


void pvcSendMessage(AHwnd hwnd, AMessage msg)
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
    if (r->dc.content == 0)
        APError(0);
    memset(r->Dc.content, 0x0, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    
    r->msg.type = MSG_NULL;
    r->state = 0;
    r->pid = getpid();
    r->msgQueueID = -1;
    
    if (parent)
        r->parentId = parent->id;
    else
        r->parentId = -1;
    
    //r->focusState = WFS_LOSE_FOCUS;
    r->childFocusId = -1;
    return r;
}

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    AMessage m;
    switch (msg.type)
    {
            
    }
    return FINISH;
}

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    hwnd->wndProc = wndProc;
    AMessage msg;
    msg.type = MSG_CREATE;
    APSendMessage(hwnd, msg);
    msg.type = MSG_HAS_FOCUS;
    msg.param = MSG_CREATE;
    APSendMessage(hwnd, msg);
    while (1)
    {
        getMessage(hwnd);
        if (pvcWndPreTranslateMessage(hwnd, &hwnd->msg))
            if (pvcDispatchMsgToCtrlLst(&hwnd->ctrlLst, hwnd->msg))
                if (pvcWndTranslateMessage(hwnd, &hwnd->msg))
                    if (wndProc(hwnd, hwnd->msg))
                    {
                        break;
                    }
        hwnd->msg.type = MSG_NULL;
    }
}
