#pragma once
#include "types.h"
#include "x86.h"
#include "defs.h"
#include "traps.h"
#include "memlayout.h"
#define HANDLEATAP 0x60

#define TICKS_INTERVAL1 40//间隔多长时间判定一次

#define TICKS_INTERVAL2 20

enum BtnState
{
	BtnDown,
	BtnUp,
	Null
};


enum BtnMessage
{
	BtnWDown,
	BtnWUp,
	BtnSDown,
	BtnSUp,
	BtnDDown,
	BtnDUp,
	BtnADown,
	BtnAUp,
	Btn1Down,
	Btn1Up,
	Btn2Down,
	Btn2Up,
	Btn3Down,
	Btn3Up,
	Btn4Down,
	Btn4Up,
};

enum BtnType
{
	BtnD,
	BtnA,
	BtnS,
	BtnD,
	Btn1,
	Btn2,
	Btn3,
	Btn4,
};

#define BtnNum 8

typedef struct Handle
{
	int state;
	int param;
	int time;
}Handle;

Handle my_btn[BtnNum];

void InitHandle(void);

void HandleInterupt(void );

void DealHandleMessage(int);

