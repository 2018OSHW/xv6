#ifndef APDESKTOP_H
#define APDESKTOP_H

#include "APInclude.h"



typedef struct Item
{
	int wndId;
	char title[MAX_ITEM_TITLE];
	struct Item *next;


};


typedef struct ItemData
{

	struct Item *selected;
	struct Item *head;
	struct Item *tail;


};

ItemData itemData;




#endif