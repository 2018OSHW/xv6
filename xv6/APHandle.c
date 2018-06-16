#include "types.h"
#include "x86.h"
#include "defs.h"
#include "traps.h"
#include "memlayout.h"
#include "APHandle.h"
#include "APInclude.h"
#include "APObject.h"

void InitHandle()
{
	for (int i = 0; i < BtnNum; i++)
	{
		my_btn[i].state = Null;
		my_btn[i].time = 0;
	}

	picenable(IRQ_HANDLE);
	ioapicenable(IRQ_HANDLE, 0);
}

void HandleInterupt()
{
	uint state;
	uint data;

	state = inb(HANDLESTAP);
	if ((state & 0x01) == 0 || (state & 0x20) != 0)
	{
		//cprintf("kbdInterupt return : %d\n", st);
		return;
	}
	data = inb(HANDLEATAP);
	cprintf("%d",data);
	AMessage msg;
	switch (data)
	{
		

	}


}

void DealHandleMessage(int ticks)
{
	for (int i = 0; i < BtnNum; i++)
	{
		if (my_btn[i].state != Null)
		{

		}
	}
}