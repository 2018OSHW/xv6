#include "APSnack.h"

APoint nextpoint(APoint p,int direction)
{
APoint output;
switch(direction)
{
	case UP:
		output.x = p.x;
		output.y = p.y - 1;
		break;
	case DOWN:
		output.x = p.x;
		output.y = p.y + 1;
		break;

	case LEFT:
		output.x = p.x - 1;
		output.y = p.y;
		break;

	case RIGHT:
		output.x = p.x + 1;
		output.y = p.y;
		break;
	default:
		output = p;
		break;


}
return output;
}

void Move()
{
	head  = nextpoint(head,current_direction);
	my_block[head.x][head.y] = current_direction;//head
	if (my_food[head.x][head.y] == 0)
	{
		int tem = my_block[tail.x][tail.y];
		my_block[tail.x][tail.y] = 0;
		tail = nextpoint(tail,tem);
	
	}//no food
	else
	{
		my_food[head.x][head.y] = False;
	}

//tail
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
	for (int i = 0;i < BLOCK_NUM_X;i++)
	{
		for (int j = 0;j <BLOCK_NUM_Y;j++)
		{
			my_block[i][j] = 0;

		}

	}
	for (int i = 0;i < 5;i++)
	{
		my_block[i][0] = RIGHT;
	}
	head.x = 4;
	head.y = 0;
	tail.x = tail.y = 0; 
	AHwnd hwnd = APCreateWindow("snack",false,3);
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
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
	{

		for (int j = 0;j < BLOCK_NUM_Y;j++)
		{
			if (my_block[i][j] == 0)
			{
				brush.color = COLOR_NULL;

			}//background
			else
			{
				if (head->x == i && head->y == j)
				{
					brush.color = COLOR_HEAD;
				}
				else
				{
					brush.color = COLOR_BODY;
				}
		
			}
			APSetBrush(hdc,brush);
			APDrawRect(hdc,i * BLOCK_WIDTH,j*BLOCK_WIDTH,BLOCK_WIDTH,BLOCK_WIDTH);
	
		}
	}
}

bool Is_Dead()
{
	APoint p = nextpoint(head,current_position);
	if (my_block[p.x][p.y] != 0)
{
return true;
}
else
{
retuirn false;
}

}
