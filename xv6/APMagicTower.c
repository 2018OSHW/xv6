#include "APMagicTower.h"


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


void TowerInit()
{

//init my_tower


}//init the tower

void init(AHwnd hwnd)
{
	TowerInit();

	hp = START_HP;
	atk = START_ATK;
	def = START_DEF;
	//init the Viliant

	floor = 0;
	position.x = position.y = 0;
	my_key = {3,0,0};
	
	

}


bool fight()
{
int mhp,matk,mdef,mid;
switch(my_tower[floor][position.x][position.y])
{
	case MONSTER1:
	mid = 0;
	break;
	case MONSTER2:
	mid = 1;
	break;
	case MONSTER3:
	mid = 2;
	break;
	default:
	mid = 0;
	break;
}
mhp = monster_info[mid][0];
matk = monster_info[mid][1];
mdef = monster_info[mid][2];//load monster info
if (atk <= mdef)
{
	return false;
}//cannot win
while(true)
{
	mhp -= (atk - mdef);
	if (mhp <= 0)
	{
		return true;
	}
	if (matk < def)
	{
		continue;
	}
	hp -= (matk - def);
	if (hp <= 0)
	{
		return false;
	}
}

//
}


void KeyDown(AHwnd hwnd,AMessage msg)
{
APoint temp;
switch(msg.param)
{
case VK_UP:
temp = nextpoint(position,Up);
break;
case VK_DOWN:

temp = nextpoint(position,Down);
break;

case VK_LEFT:

temp = nextpoint(position,Left);
break;

case VK_RIGHT:

temp = nextpoint(position,Right);
break;
case VK_ESC:

return ;
default:
break;
}
switch(my_tower[floor][temp.x][temp.y])
{
case Backgroud:

position = temp;
break;
case Wall:
break;
case Monster1:
case Monster2:
case Monster3:
position = temp;
if(!fight())
{
printf(1,"Dead");
}
break;
case YellowDoor:
if (my_key[0] > 0)
{
my_key[0]--;
position = temp;
my_tower[floor][temp.x][temp.y] = Background;
}
else
{
printf(1,"No Yellow Key");
}
break;
case BlueDoor:
if (my_key[1] > 0)
{
my_key[1]--;
position = temp;
my_tower[floor][temp.x][temp.y] = Background;
}
else
{
printf(1,"No Blue Key");
}
break;
case redDoor:
if (my_key[1] > 0)
{
my_key[1]--;
position = temp;
my_tower[floor][temp.x][temp.y] = Background;
}
else
{
printf(1,"No red Key");
}
break;
case UpStair:
floor++;
position = temp;
break;
case DownStair:
floor--;
position = temp;
break;
case YellowKey:
my_key[0]++;
position = temp;
break;
case BlueKey:
my_key[1]++;
position = temp;
break;
case RedKey:
my_key[2]++;
position = temp;
break;
default:
break;
}

}

void draw(AHwnd hwnd)
{
ABitmap temp;
for (int i = 0;i < BLOCK_NUM_X;i++)
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
	{
		switch(my_tower[floor][position.x][position.y])
		{
		case Backgroud:
			temp = background;
			break;
		case Wall:
			temp = wall;
			break;
		case Monster1:
			temp = monster1;
			break;
		case Monster2:
			temp = monster2;
			break;
		case Monster3:
			temp = monster3;
			break;
		case Valiant:
			temp = valiant;
			break;
		case YellowDoor;
			temp = yellowdoor;
			break;
		case BlueDoor:
			temp = bluedoor;
			break;
		case RedDoor:
			temp = reddoor;
			break;
		case UpStair:
			temp = upstair;
			break;
		case DownStair:
			temp = downstair;
			break;
		case YellowKey:
			temp = yellowkey;
			break;
		case BlueKey:
			temp = bluekey;
			break;
		case RedKey:
			temp = redkey;
			break;
		default:
			temp = background;
		break;
		}
		APDcCopy(&hwnd->Dc,i * BLOCK_WIDTH ,j * BLOCK_WIDTH,temp,0,0,BLOCK_WIDTH,BLOCK_WIDTH,COLOR_NULL);

	}
}//主体



//info
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
	case MSG_KEY_DOWN:
	keyDown(hwnd,msg);
	AMessage msg1;
    msg1.type = MSG_PAINT;
    APSendMessage(hwnd,msg1);  
	break;
	case MSG_PAINT:
	draw(hwnd);
	break;
	default:
	break;
}
return APWndProc(hwnd,msg);

}
