//
//  APWindow.h
//  
//
//  Created by Poo Lei on 2018/6/5.
//

#ifndef APWindow_h
#define APWindow_h
#include "APInclude.h"
#include "APObject.h"
#include "APPaint.h"

//Icon on the desktop
ABitmap grid_wall;
AHdc g_wall = &grid_wall_Dc;

//start a program
AHwnd APCreateWindow(char * title,int is_map,int page);

//Grid_Mode Translate
void APGridPaint(AHwnd wnd);
bool APPreJudge(AHwnd hwnd, AMessage * msg);
bool APWndProc(AHwnd hwnd, AMessage msg);
void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage));
void APSendMessage(AHwnd hwnd, AMessage msg);



#endif /* APWindow_h */
