#ifndef APDESKTOP_H
#define APDESKTOP_H

#include "fcntl.h"
#include "types.h"
#include "user.h"
#include "stat.h"
#include "fs.h"
#include "APGui.h"
#include "APInclude.h"
#include "APWindow.h"
/*
typedef struct Item
{
	int wndId;
	char title[MAX_ITEM_TITLE]


};


typedef struct ItemData
{
	


};*/


void desktopInitStringFigure();


void runApp(void * param);
#endif
