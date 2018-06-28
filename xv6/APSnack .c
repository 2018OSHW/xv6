#include "APSnack.h"



void Move(SnackBody *head,bool eat)
{
SnackBofy *temp;
temp = head;
temp->length ++;
while(temp->next != NULL)
{
	temp = temp->next;
}
if (eat == False)
	temp->length--;
if (temp->length == 0)
{
	SnackBody *temp1 = head;
	while (temp1->next != temp)
	{
		temp1 = temp1->next;
	}
	delete temp;
	temp1->next = NULL;
	return ;
	}
}
switch(temp->direction)
{
case UP:
temp->begin_y--;
break;
case DOWN:
temp->begin_y++;
break;
case LEFT:
temp->begin_x--;
break;
case RIGHT:
temp->begin_x++;
break;
default:
break;
}

}
void ChangeDirection(SnackBody *head,int direction)
{


}

bool wndProc(AHwnd hwnd,AMessage msg)
{
switch(msg.type)
{
case MSG_TIMEOUT:
timeUpdate(hwnd);
break;
case MSG_KEY_DOWN:
keydown(hwnd);
break;
case MSG_PAINT:
draw(hwnd);
break;
case MSG_CREATE:
init(hwnd);
break;
default:
break;
}
return APWndExec(hwnd,msg);

}

int main(void)
{
if (my_snack != NULL)
{
	free my_snack;

}
	my_snack = (SnackBody*)malloc(sizeof(SnackBody));
my_snack->begin_x = 0;
my_snack->begin_y = 0;
my_snack->length = 5;
my_snack->direction = RIGHT;
my_snack->next = NULL;
	AHwnd hwnd = APCreateWindow("snack",False,3);
	printf("snack created.\n");
APWndExec(hwnd,wndProc);
exit();


}

void init(AHwnd hwnd)
{
	

//AP


}

void draw(AHwnd hwnd)
{
AHdc hdc = APGetDc(hwnd);
APen pen;


}
