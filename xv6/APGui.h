#ifndef APGUI_H_
#define APGUI_H_

#include "APObject.h"

void APGuiInit(void);


void sendMessage(int wndId, PMessage msg);

static inline bool contain(ARect rect, int x, int y)
{
    if (x >= rect.x && x < rect.x + rect.w && y >= rect.y && y < rect.y + rect.h)
        return true;
    return false;
}

#endif
