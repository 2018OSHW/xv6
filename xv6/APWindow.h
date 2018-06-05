//
//  APWindow.h
//  
//
//  Created by Poo Lei on 2018/6/5.
//

#ifndef APWindow_h
#define APWindow_h
#include "APInclude.h"

bool APWndProc(AHwnd hwnd, AMessage msg);


void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage));


#endif /* APWindow_h */
