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
	current_direction_copy = current_direction;

//tail
}

bool wndProc(AHwnd hwnd,AMessage msg)
{
switch(msg.type)
{
case MSG_INIT:
init(hwnd);
AMessage ms;
ms.type = MSG_PAINT;
            APSendMessage(hwnd,ms);

return False;
	case MSG_TIMEOUT:
	timerUpdate(hwnd);
	break;
	case MSG_KEY_DOWN:
	keydown(hwnd);
	break;
	case MSG_PAINT:
	draw(hwnd);
	break;
	default:
	break;
}
return APWndExec(hwnd,msg);

}

int main(void)
{
	
	AHwnd hwnd = APCreateWindow("snack",False,0);
	printf("snack created.\n");
	APWndExec(hwnd,wndProc);
	exit();
}

void init(AHwnd hwnd)
{
	random(getTime());
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
	current_position = current_position_copy = RIGHT;
	updateStart();
	APInvalidate(hwnd);

}

void timerUpdate(AHwnd hwnd)
{
	if (Is_Dead)
	{
		cprintf("Dead!");
		killTimer(hwnd,2);

	}
	else
	{
		Move();
		updateFood();

	}


}

void keyDown(AHwnd hwnd,AMessage msg)
{
switch (msg.param)
{
case VK_UP:
if (current_direction_copy == LEFT || current_direction_copy == RIGHT)
	current_direction = UP;
break;
case VK_DOWN:
if (current_direction_copy == LEFT || current_direction_copy == RIGHT)
	current_direction = DOWN;
break;
case VK_LEFT:
if (current_direction_copy == UP || current_direction_copy == DOWN)
	current_direction = LEFT;
break;
case VK_RIGHT:
if (current_direction_copy == UP || current_direction_copy == DOWN)
	current_direction = RIGHT;
break;
case VK_ESC:

break;
default:
break;

}

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
if (p.x >= BLOCK_NUM_X || p.y > BLOCK_NUM_Y || p.x < 0 || p.y < 0)
{
return True;
}
	if (my_block[p.x][p.y] != 0)
{
return True;
}
else
{
retuirn False;
}

}

bool updateStart()
{
bool sta = false;
for (int i = 0;i < BLOCK_NUM_X;i++)
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
	{
		if (my_block[i][j] == 0 && my_food[i][j] == 0)
		{
			sta = true;
			break;
		}
	}
	if (sta == true)
	{
		break;
	}
}
if (sta == false)
{
return sta;
}
while(true)
{
int i = random(0) % BLOCK_NUM_X;
int j = random(0) % BLOCK_NUM_Y;

}


}
