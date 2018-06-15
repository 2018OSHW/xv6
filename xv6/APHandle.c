
#include "APHandle.h"
#include "APInclude.h"

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
	uint data;

	data = inb(HANDLEATAP);
	cprintf("%d",data);
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