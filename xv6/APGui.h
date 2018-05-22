#ifndef APGUI_H_
#define APGUI_H_

#include "APObject.h"

void APGuiInit(void);

static inline bool contain(PRect rect, int x, int y)
{
    if (x >= rect.x && x < rect.x + rect.w && y >= rect.y && y < rect.y + rect.h)
        return true;
    return false;
}

#endif
