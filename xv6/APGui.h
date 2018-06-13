#ifndef APGUI_H_
#define APGUI_H_

#include "APObject.h"
#include "APInclude.h"

void APGuiInit(void);

//void sendMessage(int wndId, struct AMessage *msg);

static inline bool contain(ARect rect, int x, int y)
{
    if (x >= rect.x && x < rect.x + rect.w && y >= rect.y && y < rect.y + rect.h)
        return true;
    return false;
}

//Window
void APWndListAddToHead(AWndList * list, AHwnd hwnd);
void APWndListAddToHead(AWndList * list, AHwnd hwnd);
void APWndListMoveToHead(AWndList * list, int wndId);
void APWndListRemove(AWndList * list, int wndId);
void APWndListDestroy(AWndList * list);


//Msg
void APPreJudge(AHwnd hwnd, AMessage * msg);
void APMsgQueueInit(AMsgQueue * queue);
void APMsgQueueEnQueue(AMsgQueue * queue, AMessage msg);
AMessage APMsgQueueDeQueue(AMsgQueue * queue);

#endif
