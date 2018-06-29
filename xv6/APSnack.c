#include "APSnack.h"

APoint nextpoint(APoint p,int direction)
{
APoint output;
switch(direction)
{
	case Up:
		output.x = p.x;
		output.y = p.y - 1;
		break;
	case Down:
		output.x = p.x;
		output.y = p.y + 1;
		break;

	case Left:
		output.x = p.x - 1;
		output.y = p.y;
		break;

	case Right:
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
//printf(1,"current_direction:%d\n",current_direction);
	my_block[head.x][head.y] = current_direction;//head
	head  = nextpoint(head,current_direction);
	my_block[head.x][head.y] = current_direction;//head
	if (my_food[head.x][head.y] == 0)
	{
		int tem = my_block[tail.x][tail.y];
		my_block[tail.x][tail.y] = NoDir;
		tail = nextpoint(tail,tem);	
	}//no food
	else
	{
		my_food[head.x][head.y] = 0;
		updateFood();
	}
	current_direction_copy = current_direction;

//tail
}



int main(void)
{
	
	AHwnd hwnd = APCreateWindow("snack",False,0);
	printf(1,"snack created.\n");
	APWndExec(hwnd,wndProc);
	exit();
}

void init(AHwnd hwnd)
{
	random(10);
	for (int i = 0;i < BLOCK_NUM_X;i++)
	{
		for (int j = 0;j <BLOCK_NUM_Y;j++)
		{
			my_block[i][j] = NoDir;
			my_food[i][j] = 0;

		}

	}
	for (int i = 0;i < 5;i++)
	{
		my_block[i][0] = Right;
	}
	updateFood();updateFood();updateFood();updateFood();updateFood();
	head.x = 4;
	head.y = 0;
	tail.x = tail.y = 0;
	current_direction = current_direction_copy = Right;
    	status = Run;
	updateFood();
	AMessage msg;
	msg.type = MSG_PAINT;
	msg.param = 0;
	setupTimer(hwnd,1,800);
	APSendMessage(hwnd,msg);

}

void timerUpdate(AHwnd hwnd)
{
	if (Is_Dead())
	{
		status = Dead;
		printf(1,"Dead!");
		deleteTimer(hwnd,1);
	}
	else
	{
		Move();
	}

}

void keyDown(AHwnd hwnd,AMessage msg)
{
//printf(1,"msg.param received:%d\n",msg.param);
switch (msg.param)
{
case VK_UP:
//printf(1,"Up Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
	current_direction = Up;
break;
case VK_DOWN:
//printf(1,"Down Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
	current_direction = Down;
break;
case VK_LEFT:
//printf(1,"Left Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
	current_direction = Left;
break;
case VK_RIGHT:
//printf(1,"Right Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
	current_direction = Right;
break;
case VK_ESC:
switch(status)
{
case Run:
status = Pause;
break;
case Pause:
status = Run;
break;
case Dead:
init(hwnd);
break;
default:
break;

}
break;
default:
break;

}

}

void draw(AHwnd hwnd)
{
	AHdc hdc = &(hwnd->Dc);
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
	{

		for (int j = 0;j < BLOCK_NUM_Y;j++)
		{
			if (my_block[i][j] == NoDir)
			{
				brush.color = COLOR_BACK;

			}//background
			else
			{
				if (head.x == i && head.y == j)
					brush.color = COLOR_HEAD;
				else
					brush.color = COLOR_BODY;
			}
			if (my_food[i][j] == 1)
			{
				brush.color = COLOR_FOOD;
			}
			APSetBrush(hdc,brush);
			APDrawRect(hdc,i * BLOCK_WIDTH,j*BLOCK_WIDTH,BLOCK_WIDTH,BLOCK_WIDTH);
		}
	}
}

bool Is_Dead()
{
	APoint p = nextpoint(head,current_direction);
    if (p.x >= BLOCK_NUM_X || p.y > BLOCK_NUM_Y || p.x < 0 || p.y < 0)
        return True;
	if (my_block[p.x][p.y] != NoDir)
        return True;
    else
        return False;
}

bool updateFood()
{
bool sta = false;
for (int i = 0;i < BLOCK_NUM_X;i++)
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
	{
		if (my_block[i][j] == NoDir && my_food[i][j] == NoDir)
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
if (my_food[i][j] == 0)
{
	my_food[i][j] = 1;
return true;
}

}


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
if (status != Run)
	break;
	timerUpdate(hwnd);
	AMessage msg1;
	msg1.type = MSG_PAINT;
	msg1.param = 0;
	APSendMessage(hwnd,msg1);
	break;
	case MSG_KEY_DOWN:
	keyDown(hwnd,msg);
	break;
	case MSG_PAINT:
	draw(hwnd);
	break;
	default:
	break;
}
return APWndProc(hwnd,msg);

}
