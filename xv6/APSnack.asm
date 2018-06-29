
_APSnack：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 1c             	sub    $0x1c,%esp
       6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
       9:	8b 55 10             	mov    0x10(%ebp),%edx
       c:	8b 45 14             	mov    0x14(%ebp),%eax
       f:	88 4d ec             	mov    %cl,-0x14(%ebp)
      12:	88 55 e8             	mov    %dl,-0x18(%ebp)
      15:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
      18:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
      1c:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
      1f:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
      23:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
      26:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
      2a:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
      2d:	8b 45 08             	mov    0x8(%ebp),%eax
      30:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
      34:	66 89 10             	mov    %dx,(%eax)
      37:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
      3b:	88 50 02             	mov    %dl,0x2(%eax)
}
      3e:	8b 45 08             	mov    0x8(%ebp),%eax
      41:	c9                   	leave  
      42:	c2 04 00             	ret    $0x4

00000045 <nextpoint>:
#include "APSnack.h"

APoint nextpoint(APoint p,int direction)
{
      45:	55                   	push   %ebp
      46:	89 e5                	mov    %esp,%ebp
      48:	83 ec 10             	sub    $0x10,%esp
APoint output;
switch(direction)
      4b:	8b 45 14             	mov    0x14(%ebp),%eax
      4e:	83 f8 02             	cmp    $0x2,%eax
      51:	74 29                	je     7c <nextpoint+0x37>
      53:	83 f8 02             	cmp    $0x2,%eax
      56:	7f 07                	jg     5f <nextpoint+0x1a>
      58:	83 f8 01             	cmp    $0x1,%eax
      5b:	74 0e                	je     6b <nextpoint+0x26>
      5d:	eb 50                	jmp    af <nextpoint+0x6a>
      5f:	83 f8 03             	cmp    $0x3,%eax
      62:	74 29                	je     8d <nextpoint+0x48>
      64:	83 f8 04             	cmp    $0x4,%eax
      67:	74 35                	je     9e <nextpoint+0x59>
      69:	eb 44                	jmp    af <nextpoint+0x6a>
{
	case Up:
		output.x = p.x;
      6b:	8b 45 0c             	mov    0xc(%ebp),%eax
      6e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		output.y = p.y - 1;
      71:	8b 45 10             	mov    0x10(%ebp),%eax
      74:	83 e8 01             	sub    $0x1,%eax
      77:	89 45 fc             	mov    %eax,-0x4(%ebp)
		break;
      7a:	eb 40                	jmp    bc <nextpoint+0x77>
	case Down:
		output.x = p.x;
      7c:	8b 45 0c             	mov    0xc(%ebp),%eax
      7f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		output.y = p.y + 1;
      82:	8b 45 10             	mov    0x10(%ebp),%eax
      85:	83 c0 01             	add    $0x1,%eax
      88:	89 45 fc             	mov    %eax,-0x4(%ebp)
		break;
      8b:	eb 2f                	jmp    bc <nextpoint+0x77>

	case Left:
		output.x = p.x - 1;
      8d:	8b 45 0c             	mov    0xc(%ebp),%eax
      90:	83 e8 01             	sub    $0x1,%eax
      93:	89 45 f8             	mov    %eax,-0x8(%ebp)
		output.y = p.y;
      96:	8b 45 10             	mov    0x10(%ebp),%eax
      99:	89 45 fc             	mov    %eax,-0x4(%ebp)
		break;
      9c:	eb 1e                	jmp    bc <nextpoint+0x77>

	case Right:
		output.x = p.x + 1;
      9e:	8b 45 0c             	mov    0xc(%ebp),%eax
      a1:	83 c0 01             	add    $0x1,%eax
      a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
		output.y = p.y;
      a7:	8b 45 10             	mov    0x10(%ebp),%eax
      aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
		break;
      ad:	eb 0d                	jmp    bc <nextpoint+0x77>
	default:
		output = p;
      af:	8b 45 0c             	mov    0xc(%ebp),%eax
      b2:	8b 55 10             	mov    0x10(%ebp),%edx
      b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
      b8:	89 55 fc             	mov    %edx,-0x4(%ebp)
		break;
      bb:	90                   	nop
}
return output;
      bc:	8b 4d 08             	mov    0x8(%ebp),%ecx
      bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
      c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
      c5:	89 01                	mov    %eax,(%ecx)
      c7:	89 51 04             	mov    %edx,0x4(%ecx)
}
      ca:	8b 45 08             	mov    0x8(%ebp),%eax
      cd:	c9                   	leave  
      ce:	c2 04 00             	ret    $0x4

000000d1 <Move>:

void Move()
{
      d1:	55                   	push   %ebp
      d2:	89 e5                	mov    %esp,%ebp
      d4:	83 ec 28             	sub    $0x28,%esp
//printf(1,"current_direction:%d\n",current_direction);
	my_block[head.x][head.y] = current_direction;//head
      d7:	8b 0d ec b6 00 00    	mov    0xb6ec,%ecx
      dd:	8b 15 f0 b6 00 00    	mov    0xb6f0,%edx
      e3:	a1 a0 b6 00 00       	mov    0xb6a0,%eax
      e8:	6b c9 37             	imul   $0x37,%ecx,%ecx
      eb:	01 ca                	add    %ecx,%edx
      ed:	89 04 95 e0 71 00 00 	mov    %eax,0x71e0(,%edx,4)
	head  = nextpoint(head,current_direction);
      f4:	8b 15 a0 b6 00 00    	mov    0xb6a0,%edx
      fa:	8d 45 e0             	lea    -0x20(%ebp),%eax
      fd:	52                   	push   %edx
      fe:	ff 35 f0 b6 00 00    	pushl  0xb6f0
     104:	ff 35 ec b6 00 00    	pushl  0xb6ec
     10a:	50                   	push   %eax
     10b:	e8 35 ff ff ff       	call   45 <nextpoint>
     110:	83 c4 0c             	add    $0xc,%esp
     113:	8b 45 e0             	mov    -0x20(%ebp),%eax
     116:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     119:	a3 ec b6 00 00       	mov    %eax,0xb6ec
     11e:	89 15 f0 b6 00 00    	mov    %edx,0xb6f0
	my_block[head.x][head.y] = current_direction;//head
     124:	8b 0d ec b6 00 00    	mov    0xb6ec,%ecx
     12a:	8b 15 f0 b6 00 00    	mov    0xb6f0,%edx
     130:	a1 a0 b6 00 00       	mov    0xb6a0,%eax
     135:	6b c9 37             	imul   $0x37,%ecx,%ecx
     138:	01 ca                	add    %ecx,%edx
     13a:	89 04 95 e0 71 00 00 	mov    %eax,0x71e0(,%edx,4)
	if (my_food[head.x][head.y] == 0)
     141:	8b 15 ec b6 00 00    	mov    0xb6ec,%edx
     147:	a1 f0 b6 00 00       	mov    0xb6f0,%eax
     14c:	6b d2 37             	imul   $0x37,%edx,%edx
     14f:	01 d0                	add    %edx,%eax
     151:	05 20 b7 00 00       	add    $0xb720,%eax
     156:	0f b6 00             	movzbl (%eax),%eax
     159:	84 c0                	test   %al,%al
     15b:	75 63                	jne    1c0 <Move+0xef>
	{
		int tem = my_block[tail.x][tail.y];
     15d:	8b 15 d0 b6 00 00    	mov    0xb6d0,%edx
     163:	a1 d4 b6 00 00       	mov    0xb6d4,%eax
     168:	6b d2 37             	imul   $0x37,%edx,%edx
     16b:	01 d0                	add    %edx,%eax
     16d:	8b 04 85 e0 71 00 00 	mov    0x71e0(,%eax,4),%eax
     174:	89 45 f4             	mov    %eax,-0xc(%ebp)
		my_block[tail.x][tail.y] = NoDir;
     177:	8b 15 d0 b6 00 00    	mov    0xb6d0,%edx
     17d:	a1 d4 b6 00 00       	mov    0xb6d4,%eax
     182:	6b d2 37             	imul   $0x37,%edx,%edx
     185:	01 d0                	add    %edx,%eax
     187:	c7 04 85 e0 71 00 00 	movl   $0x0,0x71e0(,%eax,4)
     18e:	00 00 00 00 
		tail = nextpoint(tail,tem);	
     192:	8d 45 e0             	lea    -0x20(%ebp),%eax
     195:	ff 75 f4             	pushl  -0xc(%ebp)
     198:	ff 35 d4 b6 00 00    	pushl  0xb6d4
     19e:	ff 35 d0 b6 00 00    	pushl  0xb6d0
     1a4:	50                   	push   %eax
     1a5:	e8 9b fe ff ff       	call   45 <nextpoint>
     1aa:	83 c4 0c             	add    $0xc,%esp
     1ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     1b3:	a3 d0 b6 00 00       	mov    %eax,0xb6d0
     1b8:	89 15 d4 b6 00 00    	mov    %edx,0xb6d4
     1be:	eb 1d                	jmp    1dd <Move+0x10c>
	}//no food
	else
	{
		my_food[head.x][head.y] = 0;
     1c0:	8b 15 ec b6 00 00    	mov    0xb6ec,%edx
     1c6:	a1 f0 b6 00 00       	mov    0xb6f0,%eax
     1cb:	6b d2 37             	imul   $0x37,%edx,%edx
     1ce:	01 d0                	add    %edx,%eax
     1d0:	05 20 b7 00 00       	add    $0xb720,%eax
     1d5:	c6 00 00             	movb   $0x0,(%eax)
		updateFood();
     1d8:	e8 a5 04 00 00       	call   682 <updateFood>
	}
	current_direction_copy = current_direction;
     1dd:	a1 a0 b6 00 00       	mov    0xb6a0,%eax
     1e2:	a3 00 b7 00 00       	mov    %eax,0xb700

//tail
}
     1e7:	90                   	nop
     1e8:	c9                   	leave  
     1e9:	c3                   	ret    

000001ea <main>:



int main(void)
{
     1ea:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     1ee:	83 e4 f0             	and    $0xfffffff0,%esp
     1f1:	ff 71 fc             	pushl  -0x4(%ecx)
     1f4:	55                   	push   %ebp
     1f5:	89 e5                	mov    %esp,%ebp
     1f7:	51                   	push   %ecx
     1f8:	83 ec 14             	sub    $0x14,%esp
	
	AHwnd hwnd = APCreateWindow("snack",False,0);
     1fb:	83 ec 04             	sub    $0x4,%esp
     1fe:	6a 00                	push   $0x0
     200:	6a 00                	push   $0x0
     202:	68 b0 2c 00 00       	push   $0x2cb0
     207:	e8 56 1b 00 00       	call   1d62 <APCreateWindow>
     20c:	83 c4 10             	add    $0x10,%esp
     20f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf(1,"snack created.\n");
     212:	83 ec 08             	sub    $0x8,%esp
     215:	68 b6 2c 00 00       	push   $0x2cb6
     21a:	6a 01                	push   $0x1
     21c:	e8 76 0a 00 00       	call   c97 <printf>
     221:	83 c4 10             	add    $0x10,%esp
	APWndExec(hwnd,wndProc);
     224:	83 ec 08             	sub    $0x8,%esp
     227:	68 a0 07 00 00       	push   $0x7a0
     22c:	ff 75 f4             	pushl  -0xc(%ebp)
     22f:	e8 50 1e 00 00       	call   2084 <APWndExec>
     234:	83 c4 10             	add    $0x10,%esp
	exit();
     237:	e8 9c 08 00 00       	call   ad8 <exit>

0000023c <init>:
}

void init(AHwnd hwnd)
{
     23c:	55                   	push   %ebp
     23d:	89 e5                	mov    %esp,%ebp
     23f:	83 ec 28             	sub    $0x28,%esp
	random(getCurrentTime());
     242:	e8 69 09 00 00       	call   bb0 <getCurrentTime>
     247:	83 ec 0c             	sub    $0xc,%esp
     24a:	50                   	push   %eax
     24b:	e8 e7 26 00 00       	call   2937 <random>
     250:	83 c4 10             	add    $0x10,%esp
	for (int i = 0;i < BLOCK_NUM_X;i++)
     253:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     25a:	eb 40                	jmp    29c <init+0x60>
	{
		for (int j = 0;j <BLOCK_NUM_Y;j++)
     25c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     263:	eb 2d                	jmp    292 <init+0x56>
		{
			my_block[i][j] = NoDir;
     265:	8b 45 f4             	mov    -0xc(%ebp),%eax
     268:	6b d0 37             	imul   $0x37,%eax,%edx
     26b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     26e:	01 d0                	add    %edx,%eax
     270:	c7 04 85 e0 71 00 00 	movl   $0x0,0x71e0(,%eax,4)
     277:	00 00 00 00 
			my_food[i][j] = 0;
     27b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     27e:	6b d0 37             	imul   $0x37,%eax,%edx
     281:	8b 45 f0             	mov    -0x10(%ebp),%eax
     284:	01 d0                	add    %edx,%eax
     286:	05 20 b7 00 00       	add    $0xb720,%eax
     28b:	c6 00 00             	movb   $0x0,(%eax)
void init(AHwnd hwnd)
{
	random(getCurrentTime());
	for (int i = 0;i < BLOCK_NUM_X;i++)
	{
		for (int j = 0;j <BLOCK_NUM_Y;j++)
     28e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     292:	83 7d f0 36          	cmpl   $0x36,-0x10(%ebp)
     296:	7e cd                	jle    265 <init+0x29>
}

void init(AHwnd hwnd)
{
	random(getCurrentTime());
	for (int i = 0;i < BLOCK_NUM_X;i++)
     298:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     29c:	83 7d f4 4f          	cmpl   $0x4f,-0xc(%ebp)
     2a0:	7e ba                	jle    25c <init+0x20>
			my_food[i][j] = 0;

		}

	}
	for (int i = 0;i < 5;i++)
     2a2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     2a9:	eb 18                	jmp    2c3 <init+0x87>
	{
		my_block[i][0] = Right;
     2ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
     2ae:	69 c0 dc 00 00 00    	imul   $0xdc,%eax,%eax
     2b4:	05 e0 71 00 00       	add    $0x71e0,%eax
     2b9:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
			my_food[i][j] = 0;

		}

	}
	for (int i = 0;i < 5;i++)
     2bf:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     2c3:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     2c7:	7e e2                	jle    2ab <init+0x6f>
	{
		my_block[i][0] = Right;
	}
	updateFood();updateFood();updateFood();updateFood();updateFood();
     2c9:	e8 b4 03 00 00       	call   682 <updateFood>
     2ce:	e8 af 03 00 00       	call   682 <updateFood>
     2d3:	e8 aa 03 00 00       	call   682 <updateFood>
     2d8:	e8 a5 03 00 00       	call   682 <updateFood>
     2dd:	e8 a0 03 00 00       	call   682 <updateFood>
	head.x = 4;
     2e2:	c7 05 ec b6 00 00 04 	movl   $0x4,0xb6ec
     2e9:	00 00 00 
	head.y = 0;
     2ec:	c7 05 f0 b6 00 00 00 	movl   $0x0,0xb6f0
     2f3:	00 00 00 
	tail.x = tail.y = 0;
     2f6:	c7 05 d4 b6 00 00 00 	movl   $0x0,0xb6d4
     2fd:	00 00 00 
     300:	a1 d4 b6 00 00       	mov    0xb6d4,%eax
     305:	a3 d0 b6 00 00       	mov    %eax,0xb6d0
	current_direction = current_direction_copy = Right;
     30a:	c7 05 00 b7 00 00 04 	movl   $0x4,0xb700
     311:	00 00 00 
     314:	a1 00 b7 00 00       	mov    0xb700,%eax
     319:	a3 a0 b6 00 00       	mov    %eax,0xb6a0
    	status = Run;
     31e:	c7 05 84 c8 00 00 00 	movl   $0x0,0xc884
     325:	00 00 00 
	updateFood();
     328:	e8 55 03 00 00       	call   682 <updateFood>
	AMessage msg;
	msg.type = MSG_PAINT;
     32d:	c7 45 e0 03 00 00 00 	movl   $0x3,-0x20(%ebp)
	msg.param = 0;
     334:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	setupTimer(hwnd,1,800);
     33b:	83 ec 04             	sub    $0x4,%esp
     33e:	68 20 03 00 00       	push   $0x320
     343:	6a 01                	push   $0x1
     345:	ff 75 08             	pushl  0x8(%ebp)
     348:	e8 53 08 00 00       	call   ba0 <setupTimer>
     34d:	83 c4 10             	add    $0x10,%esp
	APSendMessage(hwnd,msg);
     350:	ff 75 e8             	pushl  -0x18(%ebp)
     353:	ff 75 e4             	pushl  -0x1c(%ebp)
     356:	ff 75 e0             	pushl  -0x20(%ebp)
     359:	ff 75 08             	pushl  0x8(%ebp)
     35c:	e8 e3 19 00 00       	call   1d44 <APSendMessage>
     361:	83 c4 10             	add    $0x10,%esp

}
     364:	90                   	nop
     365:	c9                   	leave  
     366:	c3                   	ret    

00000367 <timerUpdate>:

void timerUpdate(AHwnd hwnd)
{
     367:	55                   	push   %ebp
     368:	89 e5                	mov    %esp,%ebp
     36a:	83 ec 08             	sub    $0x8,%esp
	if (Is_Dead())
     36d:	e8 a2 02 00 00       	call   614 <Is_Dead>
     372:	84 c0                	test   %al,%al
     374:	74 2e                	je     3a4 <timerUpdate+0x3d>
	{
		status = Dead;
     376:	c7 05 84 c8 00 00 02 	movl   $0x2,0xc884
     37d:	00 00 00 
		printf(1,"Dead!");
     380:	83 ec 08             	sub    $0x8,%esp
     383:	68 c6 2c 00 00       	push   $0x2cc6
     388:	6a 01                	push   $0x1
     38a:	e8 08 09 00 00       	call   c97 <printf>
     38f:	83 c4 10             	add    $0x10,%esp
		deleteTimer(hwnd,1);
     392:	83 ec 08             	sub    $0x8,%esp
     395:	6a 01                	push   $0x1
     397:	ff 75 08             	pushl  0x8(%ebp)
     39a:	e8 09 08 00 00       	call   ba8 <deleteTimer>
     39f:	83 c4 10             	add    $0x10,%esp
	else
	{
		Move();
	}

}
     3a2:	eb 05                	jmp    3a9 <timerUpdate+0x42>
		printf(1,"Dead!");
		deleteTimer(hwnd,1);
	}
	else
	{
		Move();
     3a4:	e8 28 fd ff ff       	call   d1 <Move>
	}

}
     3a9:	90                   	nop
     3aa:	c9                   	leave  
     3ab:	c3                   	ret    

000003ac <keyDown>:

void keyDown(AHwnd hwnd,AMessage msg)
{
     3ac:	55                   	push   %ebp
     3ad:	89 e5                	mov    %esp,%ebp
     3af:	83 ec 08             	sub    $0x8,%esp
//printf(1,"msg.param received:%d\n",msg.param);
switch (msg.param)
     3b2:	8b 45 10             	mov    0x10(%ebp),%eax
     3b5:	83 f8 06             	cmp    $0x6,%eax
     3b8:	0f 87 d5 00 00 00    	ja     493 <keyDown+0xe7>
     3be:	8b 04 85 cc 2c 00 00 	mov    0x2ccc(,%eax,4),%eax
     3c5:	ff e0                	jmp    *%eax
{
case VK_UP:
//printf(1,"Up Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
     3c7:	a1 00 b7 00 00       	mov    0xb700,%eax
     3cc:	83 f8 03             	cmp    $0x3,%eax
     3cf:	74 0e                	je     3df <keyDown+0x33>
     3d1:	a1 00 b7 00 00       	mov    0xb700,%eax
     3d6:	83 f8 04             	cmp    $0x4,%eax
     3d9:	0f 85 b7 00 00 00    	jne    496 <keyDown+0xea>
	current_direction = Up;
     3df:	c7 05 a0 b6 00 00 01 	movl   $0x1,0xb6a0
     3e6:	00 00 00 
break;
     3e9:	e9 a8 00 00 00       	jmp    496 <keyDown+0xea>
case VK_DOWN:
//printf(1,"Down Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
     3ee:	a1 00 b7 00 00       	mov    0xb700,%eax
     3f3:	83 f8 03             	cmp    $0x3,%eax
     3f6:	74 0e                	je     406 <keyDown+0x5a>
     3f8:	a1 00 b7 00 00       	mov    0xb700,%eax
     3fd:	83 f8 04             	cmp    $0x4,%eax
     400:	0f 85 93 00 00 00    	jne    499 <keyDown+0xed>
	current_direction = Down;
     406:	c7 05 a0 b6 00 00 02 	movl   $0x2,0xb6a0
     40d:	00 00 00 
break;
     410:	e9 84 00 00 00       	jmp    499 <keyDown+0xed>
case VK_LEFT:
//printf(1,"Left Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
     415:	a1 00 b7 00 00       	mov    0xb700,%eax
     41a:	83 f8 01             	cmp    $0x1,%eax
     41d:	74 0a                	je     429 <keyDown+0x7d>
     41f:	a1 00 b7 00 00       	mov    0xb700,%eax
     424:	83 f8 02             	cmp    $0x2,%eax
     427:	75 73                	jne    49c <keyDown+0xf0>
	current_direction = Left;
     429:	c7 05 a0 b6 00 00 03 	movl   $0x3,0xb6a0
     430:	00 00 00 
break;
     433:	eb 67                	jmp    49c <keyDown+0xf0>
case VK_RIGHT:
//printf(1,"Right Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
     435:	a1 00 b7 00 00       	mov    0xb700,%eax
     43a:	83 f8 01             	cmp    $0x1,%eax
     43d:	74 0a                	je     449 <keyDown+0x9d>
     43f:	a1 00 b7 00 00       	mov    0xb700,%eax
     444:	83 f8 02             	cmp    $0x2,%eax
     447:	75 56                	jne    49f <keyDown+0xf3>
	current_direction = Right;
     449:	c7 05 a0 b6 00 00 04 	movl   $0x4,0xb6a0
     450:	00 00 00 
break;
     453:	eb 4a                	jmp    49f <keyDown+0xf3>
case VK_ENTER:
switch(status)
     455:	a1 84 c8 00 00       	mov    0xc884,%eax
     45a:	83 f8 01             	cmp    $0x1,%eax
     45d:	74 17                	je     476 <keyDown+0xca>
     45f:	83 f8 02             	cmp    $0x2,%eax
     462:	74 1e                	je     482 <keyDown+0xd6>
     464:	85 c0                	test   %eax,%eax
     466:	74 02                	je     46a <keyDown+0xbe>
break;
case Dead:
init(hwnd);
break;
default:
break;
     468:	eb 27                	jmp    491 <keyDown+0xe5>
break;
case VK_ENTER:
switch(status)
{
case Run:
status = Pause;
     46a:	c7 05 84 c8 00 00 01 	movl   $0x1,0xc884
     471:	00 00 00 
break;
     474:	eb 1b                	jmp    491 <keyDown+0xe5>
case Pause:
status = Run;
     476:	c7 05 84 c8 00 00 00 	movl   $0x0,0xc884
     47d:	00 00 00 
break;
     480:	eb 0f                	jmp    491 <keyDown+0xe5>
case Dead:
init(hwnd);
     482:	83 ec 0c             	sub    $0xc,%esp
     485:	ff 75 08             	pushl  0x8(%ebp)
     488:	e8 af fd ff ff       	call   23c <init>
     48d:	83 c4 10             	add    $0x10,%esp
break;
     490:	90                   	nop
default:
break;
}
break;
     491:	eb 0d                	jmp    4a0 <keyDown+0xf4>
case VK_ESC:
        
        
break;
default:
break;
     493:	90                   	nop
     494:	eb 0a                	jmp    4a0 <keyDown+0xf4>
{
case VK_UP:
//printf(1,"Up Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
	current_direction = Up;
break;
     496:	90                   	nop
     497:	eb 07                	jmp    4a0 <keyDown+0xf4>
case VK_DOWN:
//printf(1,"Down Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
	current_direction = Down;
break;
     499:	90                   	nop
     49a:	eb 04                	jmp    4a0 <keyDown+0xf4>
case VK_LEFT:
//printf(1,"Left Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
	current_direction = Left;
break;
     49c:	90                   	nop
     49d:	eb 01                	jmp    4a0 <keyDown+0xf4>
case VK_RIGHT:
//printf(1,"Right Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
	current_direction = Right;
break;
     49f:	90                   	nop
default:
break;

}

}
     4a0:	90                   	nop
     4a1:	c9                   	leave  
     4a2:	c3                   	ret    

000004a3 <draw>:

void draw(AHwnd hwnd)
{
     4a3:	55                   	push   %ebp
     4a4:	89 e5                	mov    %esp,%ebp
     4a6:	83 ec 28             	sub    $0x28,%esp
	AHdc hdc = &(hwnd->Dc);
     4a9:	8b 45 08             	mov    0x8(%ebp),%eax
     4ac:	83 c0 3c             	add    $0x3c,%eax
     4af:	89 45 ec             	mov    %eax,-0x14(%ebp)
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
     4b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4b9:	e9 49 01 00 00       	jmp    607 <draw+0x164>
	{

		for (int j = 0;j < BLOCK_NUM_Y;j++)
     4be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4c5:	e9 2f 01 00 00       	jmp    5f9 <draw+0x156>
		{
			if (my_block[i][j] == NoDir)
     4ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4cd:	6b d0 37             	imul   $0x37,%eax,%edx
     4d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4d3:	01 d0                	add    %edx,%eax
     4d5:	8b 04 85 e0 71 00 00 	mov    0x71e0(,%eax,4),%eax
     4dc:	85 c0                	test   %eax,%eax
     4de:	75 26                	jne    506 <draw+0x63>
			{
				brush.color = COLOR_BACK;
     4e0:	8d 45 d8             	lea    -0x28(%ebp),%eax
     4e3:	6a 00                	push   $0x0
     4e5:	68 ff 00 00 00       	push   $0xff
     4ea:	6a 00                	push   $0x0
     4ec:	50                   	push   %eax
     4ed:	e8 0e fb ff ff       	call   0 <RGB>
     4f2:	83 c4 0c             	add    $0xc,%esp
     4f5:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     4f9:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     4fd:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     501:	88 45 eb             	mov    %al,-0x15(%ebp)
     504:	eb 61                	jmp    567 <draw+0xc4>

			}//background
			else
			{
				if (head.x == i && head.y == j)
     506:	a1 ec b6 00 00       	mov    0xb6ec,%eax
     50b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     50e:	75 30                	jne    540 <draw+0x9d>
     510:	a1 f0 b6 00 00       	mov    0xb6f0,%eax
     515:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     518:	75 26                	jne    540 <draw+0x9d>
					brush.color = COLOR_HEAD;
     51a:	8d 45 d8             	lea    -0x28(%ebp),%eax
     51d:	6a 00                	push   $0x0
     51f:	68 80 00 00 00       	push   $0x80
     524:	6a 00                	push   $0x0
     526:	50                   	push   %eax
     527:	e8 d4 fa ff ff       	call   0 <RGB>
     52c:	83 c4 0c             	add    $0xc,%esp
     52f:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     533:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     537:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     53b:	88 45 eb             	mov    %al,-0x15(%ebp)
     53e:	eb 27                	jmp    567 <draw+0xc4>
				else
					brush.color = COLOR_BODY;
     540:	8d 45 d8             	lea    -0x28(%ebp),%eax
     543:	68 ff 00 00 00       	push   $0xff
     548:	68 ff 00 00 00       	push   $0xff
     54d:	6a 00                	push   $0x0
     54f:	50                   	push   %eax
     550:	e8 ab fa ff ff       	call   0 <RGB>
     555:	83 c4 0c             	add    $0xc,%esp
     558:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     55c:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     560:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     564:	88 45 eb             	mov    %al,-0x15(%ebp)
			}
			if (my_food[i][j] == 1)
     567:	8b 45 f4             	mov    -0xc(%ebp),%eax
     56a:	6b d0 37             	imul   $0x37,%eax,%edx
     56d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     570:	01 d0                	add    %edx,%eax
     572:	05 20 b7 00 00       	add    $0xb720,%eax
     577:	0f b6 00             	movzbl (%eax),%eax
     57a:	3c 01                	cmp    $0x1,%al
     57c:	75 24                	jne    5a2 <draw+0xff>
			{
				brush.color = COLOR_FOOD;
     57e:	8d 45 d8             	lea    -0x28(%ebp),%eax
     581:	6a 00                	push   $0x0
     583:	6a 00                	push   $0x0
     585:	68 ff 00 00 00       	push   $0xff
     58a:	50                   	push   %eax
     58b:	e8 70 fa ff ff       	call   0 <RGB>
     590:	83 c4 0c             	add    $0xc,%esp
     593:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     597:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     59b:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     59f:	88 45 eb             	mov    %al,-0x15(%ebp)
			}
			APSetBrush(hdc,brush);
     5a2:	8d 55 d8             	lea    -0x28(%ebp),%edx
     5a5:	83 ec 04             	sub    $0x4,%esp
     5a8:	83 ec 04             	sub    $0x4,%esp
     5ab:	89 e0                	mov    %esp,%eax
     5ad:	0f b7 4d e9          	movzwl -0x17(%ebp),%ecx
     5b1:	66 89 08             	mov    %cx,(%eax)
     5b4:	0f b6 4d eb          	movzbl -0x15(%ebp),%ecx
     5b8:	88 48 02             	mov    %cl,0x2(%eax)
     5bb:	ff 75 ec             	pushl  -0x14(%ebp)
     5be:	52                   	push   %edx
     5bf:	e8 61 0e 00 00       	call   1425 <APSetBrush>
     5c4:	83 c4 0c             	add    $0xc,%esp
			APDrawRect(hdc,i * BLOCK_WIDTH,j*BLOCK_WIDTH,BLOCK_WIDTH,BLOCK_WIDTH);
     5c7:	8b 55 f0             	mov    -0x10(%ebp),%edx
     5ca:	89 d0                	mov    %edx,%eax
     5cc:	c1 e0 02             	shl    $0x2,%eax
     5cf:	01 d0                	add    %edx,%eax
     5d1:	01 c0                	add    %eax,%eax
     5d3:	89 c1                	mov    %eax,%ecx
     5d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     5d8:	89 d0                	mov    %edx,%eax
     5da:	c1 e0 02             	shl    $0x2,%eax
     5dd:	01 d0                	add    %edx,%eax
     5df:	01 c0                	add    %eax,%eax
     5e1:	83 ec 0c             	sub    $0xc,%esp
     5e4:	6a 0a                	push   $0xa
     5e6:	6a 0a                	push   $0xa
     5e8:	51                   	push   %ecx
     5e9:	50                   	push   %eax
     5ea:	ff 75 ec             	pushl  -0x14(%ebp)
     5ed:	e8 5d 12 00 00       	call   184f <APDrawRect>
     5f2:	83 c4 20             	add    $0x20,%esp
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
	{

		for (int j = 0;j < BLOCK_NUM_Y;j++)
     5f5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5f9:	83 7d f0 36          	cmpl   $0x36,-0x10(%ebp)
     5fd:	0f 8e c7 fe ff ff    	jle    4ca <draw+0x27>
void draw(AHwnd hwnd)
{
	AHdc hdc = &(hwnd->Dc);
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
     603:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     607:	83 7d f4 4f          	cmpl   $0x4f,-0xc(%ebp)
     60b:	0f 8e ad fe ff ff    	jle    4be <draw+0x1b>
			}
			APSetBrush(hdc,brush);
			APDrawRect(hdc,i * BLOCK_WIDTH,j*BLOCK_WIDTH,BLOCK_WIDTH,BLOCK_WIDTH);
		}
	}
}
     611:	90                   	nop
     612:	c9                   	leave  
     613:	c3                   	ret    

00000614 <Is_Dead>:

bool Is_Dead()
{
     614:	55                   	push   %ebp
     615:	89 e5                	mov    %esp,%ebp
     617:	83 ec 10             	sub    $0x10,%esp
	APoint p = nextpoint(head,current_direction);
     61a:	8b 15 a0 b6 00 00    	mov    0xb6a0,%edx
     620:	8d 45 f8             	lea    -0x8(%ebp),%eax
     623:	52                   	push   %edx
     624:	ff 35 f0 b6 00 00    	pushl  0xb6f0
     62a:	ff 35 ec b6 00 00    	pushl  0xb6ec
     630:	50                   	push   %eax
     631:	e8 0f fa ff ff       	call   45 <nextpoint>
     636:	83 c4 0c             	add    $0xc,%esp
    if (p.x >= BLOCK_NUM_X || p.y > BLOCK_NUM_Y || p.x < 0 || p.y < 0)
     639:	8b 45 f8             	mov    -0x8(%ebp),%eax
     63c:	83 f8 4f             	cmp    $0x4f,%eax
     63f:	7f 16                	jg     657 <Is_Dead+0x43>
     641:	8b 45 fc             	mov    -0x4(%ebp),%eax
     644:	83 f8 37             	cmp    $0x37,%eax
     647:	7f 0e                	jg     657 <Is_Dead+0x43>
     649:	8b 45 f8             	mov    -0x8(%ebp),%eax
     64c:	85 c0                	test   %eax,%eax
     64e:	78 07                	js     657 <Is_Dead+0x43>
     650:	8b 45 fc             	mov    -0x4(%ebp),%eax
     653:	85 c0                	test   %eax,%eax
     655:	79 07                	jns    65e <Is_Dead+0x4a>
        return True;
     657:	b8 01 00 00 00       	mov    $0x1,%eax
     65c:	eb 22                	jmp    680 <Is_Dead+0x6c>
	if (my_block[p.x][p.y] != NoDir)
     65e:	8b 55 f8             	mov    -0x8(%ebp),%edx
     661:	8b 45 fc             	mov    -0x4(%ebp),%eax
     664:	6b d2 37             	imul   $0x37,%edx,%edx
     667:	01 d0                	add    %edx,%eax
     669:	8b 04 85 e0 71 00 00 	mov    0x71e0(,%eax,4),%eax
     670:	85 c0                	test   %eax,%eax
     672:	74 07                	je     67b <Is_Dead+0x67>
        return True;
     674:	b8 01 00 00 00       	mov    $0x1,%eax
     679:	eb 05                	jmp    680 <Is_Dead+0x6c>
    else
        return False;
     67b:	b8 00 00 00 00       	mov    $0x0,%eax
}
     680:	c9                   	leave  
     681:	c3                   	ret    

00000682 <updateFood>:

bool updateFood()
{
     682:	55                   	push   %ebp
     683:	89 e5                	mov    %esp,%ebp
     685:	83 ec 28             	sub    $0x28,%esp
bool sta = false;
     688:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
for (int i = 0;i < BLOCK_NUM_X;i++)
     68c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     693:	eb 50                	jmp    6e5 <updateFood+0x63>
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
     695:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     69c:	eb 37                	jmp    6d5 <updateFood+0x53>
	{
		if (my_block[i][j] == NoDir && my_food[i][j] == NoDir)
     69e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6a1:	6b d0 37             	imul   $0x37,%eax,%edx
     6a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6a7:	01 d0                	add    %edx,%eax
     6a9:	8b 04 85 e0 71 00 00 	mov    0x71e0(,%eax,4),%eax
     6b0:	85 c0                	test   %eax,%eax
     6b2:	75 1d                	jne    6d1 <updateFood+0x4f>
     6b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6b7:	6b d0 37             	imul   $0x37,%eax,%edx
     6ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6bd:	01 d0                	add    %edx,%eax
     6bf:	05 20 b7 00 00       	add    $0xb720,%eax
     6c4:	0f b6 00             	movzbl (%eax),%eax
     6c7:	84 c0                	test   %al,%al
     6c9:	75 06                	jne    6d1 <updateFood+0x4f>
		{
			sta = true;
     6cb:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
			break;
     6cf:	eb 0a                	jmp    6db <updateFood+0x59>
bool updateFood()
{
bool sta = false;
for (int i = 0;i < BLOCK_NUM_X;i++)
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
     6d1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     6d5:	83 7d ec 36          	cmpl   $0x36,-0x14(%ebp)
     6d9:	7e c3                	jle    69e <updateFood+0x1c>
		{
			sta = true;
			break;
		}
	}
	if (sta == true)
     6db:	80 7d f7 01          	cmpb   $0x1,-0x9(%ebp)
     6df:	74 0c                	je     6ed <updateFood+0x6b>
}

bool updateFood()
{
bool sta = false;
for (int i = 0;i < BLOCK_NUM_X;i++)
     6e1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6e5:	83 7d f0 4f          	cmpl   $0x4f,-0x10(%ebp)
     6e9:	7e aa                	jle    695 <updateFood+0x13>
     6eb:	eb 01                	jmp    6ee <updateFood+0x6c>
			break;
		}
	}
	if (sta == true)
	{
		break;
     6ed:	90                   	nop
	}
}
if (sta == false)
     6ee:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
     6f2:	75 09                	jne    6fd <updateFood+0x7b>
{
return sta;
     6f4:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
     6f8:	e9 a1 00 00 00       	jmp    79e <updateFood+0x11c>
}
while(true)
{
int i = random(0) % BLOCK_NUM_X;
     6fd:	83 ec 0c             	sub    $0xc,%esp
     700:	6a 00                	push   $0x0
     702:	e8 30 22 00 00       	call   2937 <random>
     707:	83 c4 10             	add    $0x10,%esp
     70a:	89 c1                	mov    %eax,%ecx
     70c:	ba 67 66 66 66       	mov    $0x66666667,%edx
     711:	89 c8                	mov    %ecx,%eax
     713:	f7 ea                	imul   %edx
     715:	c1 fa 05             	sar    $0x5,%edx
     718:	89 c8                	mov    %ecx,%eax
     71a:	c1 f8 1f             	sar    $0x1f,%eax
     71d:	29 c2                	sub    %eax,%edx
     71f:	89 d0                	mov    %edx,%eax
     721:	89 45 e8             	mov    %eax,-0x18(%ebp)
     724:	8b 55 e8             	mov    -0x18(%ebp),%edx
     727:	89 d0                	mov    %edx,%eax
     729:	c1 e0 02             	shl    $0x2,%eax
     72c:	01 d0                	add    %edx,%eax
     72e:	c1 e0 04             	shl    $0x4,%eax
     731:	29 c1                	sub    %eax,%ecx
     733:	89 c8                	mov    %ecx,%eax
     735:	89 45 e8             	mov    %eax,-0x18(%ebp)
int j = random(0) % BLOCK_NUM_Y;
     738:	83 ec 0c             	sub    $0xc,%esp
     73b:	6a 00                	push   $0x0
     73d:	e8 f5 21 00 00       	call   2937 <random>
     742:	83 c4 10             	add    $0x10,%esp
     745:	89 c1                	mov    %eax,%ecx
     747:	ba 95 20 4f 09       	mov    $0x94f2095,%edx
     74c:	89 c8                	mov    %ecx,%eax
     74e:	f7 ea                	imul   %edx
     750:	d1 fa                	sar    %edx
     752:	89 c8                	mov    %ecx,%eax
     754:	c1 f8 1f             	sar    $0x1f,%eax
     757:	29 c2                	sub    %eax,%edx
     759:	89 d0                	mov    %edx,%eax
     75b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     75e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     761:	6b c0 37             	imul   $0x37,%eax,%eax
     764:	29 c1                	sub    %eax,%ecx
     766:	89 c8                	mov    %ecx,%eax
     768:	89 45 e4             	mov    %eax,-0x1c(%ebp)
if (my_food[i][j] == 0)
     76b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     76e:	6b d0 37             	imul   $0x37,%eax,%edx
     771:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     774:	01 d0                	add    %edx,%eax
     776:	05 20 b7 00 00       	add    $0xb720,%eax
     77b:	0f b6 00             	movzbl (%eax),%eax
     77e:	84 c0                	test   %al,%al
     780:	0f 85 77 ff ff ff    	jne    6fd <updateFood+0x7b>
{
	my_food[i][j] = 1;
     786:	8b 45 e8             	mov    -0x18(%ebp),%eax
     789:	6b d0 37             	imul   $0x37,%eax,%edx
     78c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     78f:	01 d0                	add    %edx,%eax
     791:	05 20 b7 00 00       	add    $0xb720,%eax
     796:	c6 00 01             	movb   $0x1,(%eax)
return true;
     799:	b8 01 00 00 00       	mov    $0x1,%eax
}

}


}
     79e:	c9                   	leave  
     79f:	c3                   	ret    

000007a0 <wndProc>:

bool wndProc(AHwnd hwnd,AMessage msg)
{
     7a0:	55                   	push   %ebp
     7a1:	89 e5                	mov    %esp,%ebp
     7a3:	83 ec 28             	sub    $0x28,%esp
switch(msg.type)
     7a6:	8b 45 0c             	mov    0xc(%ebp),%eax
     7a9:	83 f8 09             	cmp    $0x9,%eax
     7ac:	0f 87 b5 00 00 00    	ja     867 <wndProc+0xc7>
     7b2:	8b 04 85 e8 2c 00 00 	mov    0x2ce8(,%eax,4),%eax
     7b9:	ff e0                	jmp    *%eax
{
    case MSG_ESC:
        removeWindow(hwnd->id);
     7bb:	8b 45 08             	mov    0x8(%ebp),%eax
     7be:	8b 00                	mov    (%eax),%eax
     7c0:	83 ec 0c             	sub    $0xc,%esp
     7c3:	50                   	push   %eax
     7c4:	e8 ef 03 00 00       	call   bb8 <removeWindow>
     7c9:	83 c4 10             	add    $0x10,%esp
        return True;
     7cc:	b8 01 00 00 00       	mov    $0x1,%eax
     7d1:	e9 a9 00 00 00       	jmp    87f <wndProc+0xdf>
    case MSG_INIT:
    init(hwnd);
     7d6:	83 ec 0c             	sub    $0xc,%esp
     7d9:	ff 75 08             	pushl  0x8(%ebp)
     7dc:	e8 5b fa ff ff       	call   23c <init>
     7e1:	83 c4 10             	add    $0x10,%esp
    AMessage ms;
    ms.type = MSG_PAINT;
     7e4:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
    APSendMessage(hwnd,ms);
     7eb:	ff 75 f4             	pushl  -0xc(%ebp)
     7ee:	ff 75 f0             	pushl  -0x10(%ebp)
     7f1:	ff 75 ec             	pushl  -0x14(%ebp)
     7f4:	ff 75 08             	pushl  0x8(%ebp)
     7f7:	e8 48 15 00 00       	call   1d44 <APSendMessage>
     7fc:	83 c4 10             	add    $0x10,%esp
    
    return False;
     7ff:	b8 00 00 00 00       	mov    $0x0,%eax
     804:	eb 79                	jmp    87f <wndProc+0xdf>
	case MSG_TIMEOUT:
if (status != Run)
     806:	a1 84 c8 00 00       	mov    0xc884,%eax
     80b:	85 c0                	test   %eax,%eax
     80d:	75 5b                	jne    86a <wndProc+0xca>
	break;
	timerUpdate(hwnd);
     80f:	83 ec 0c             	sub    $0xc,%esp
     812:	ff 75 08             	pushl  0x8(%ebp)
     815:	e8 4d fb ff ff       	call   367 <timerUpdate>
     81a:	83 c4 10             	add    $0x10,%esp
	AMessage msg1;
	msg1.type = MSG_PAINT;
     81d:	c7 45 e0 03 00 00 00 	movl   $0x3,-0x20(%ebp)
	msg1.param = 0;
     824:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	APSendMessage(hwnd,msg1);
     82b:	ff 75 e8             	pushl  -0x18(%ebp)
     82e:	ff 75 e4             	pushl  -0x1c(%ebp)
     831:	ff 75 e0             	pushl  -0x20(%ebp)
     834:	ff 75 08             	pushl  0x8(%ebp)
     837:	e8 08 15 00 00       	call   1d44 <APSendMessage>
     83c:	83 c4 10             	add    $0x10,%esp
	break;
     83f:	eb 2a                	jmp    86b <wndProc+0xcb>
	case MSG_KEY_DOWN:
	keyDown(hwnd,msg);
     841:	ff 75 14             	pushl  0x14(%ebp)
     844:	ff 75 10             	pushl  0x10(%ebp)
     847:	ff 75 0c             	pushl  0xc(%ebp)
     84a:	ff 75 08             	pushl  0x8(%ebp)
     84d:	e8 5a fb ff ff       	call   3ac <keyDown>
     852:	83 c4 10             	add    $0x10,%esp
	break;
     855:	eb 14                	jmp    86b <wndProc+0xcb>
	case MSG_PAINT:
	draw(hwnd);
     857:	83 ec 0c             	sub    $0xc,%esp
     85a:	ff 75 08             	pushl  0x8(%ebp)
     85d:	e8 41 fc ff ff       	call   4a3 <draw>
     862:	83 c4 10             	add    $0x10,%esp
	break;
     865:	eb 04                	jmp    86b <wndProc+0xcb>
	default:
	break;
     867:	90                   	nop
     868:	eb 01                	jmp    86b <wndProc+0xcb>
    APSendMessage(hwnd,ms);
    
    return False;
	case MSG_TIMEOUT:
if (status != Run)
	break;
     86a:	90                   	nop
	draw(hwnd);
	break;
	default:
	break;
}
return APWndProc(hwnd,msg);
     86b:	ff 75 14             	pushl  0x14(%ebp)
     86e:	ff 75 10             	pushl  0x10(%ebp)
     871:	ff 75 0c             	pushl  0xc(%ebp)
     874:	ff 75 08             	pushl  0x8(%ebp)
     877:	e8 4c 17 00 00       	call   1fc8 <APWndProc>
     87c:	83 c4 10             	add    $0x10,%esp

}
     87f:	c9                   	leave  
     880:	c3                   	ret    

00000881 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     881:	55                   	push   %ebp
     882:	89 e5                	mov    %esp,%ebp
     884:	57                   	push   %edi
     885:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     886:	8b 4d 08             	mov    0x8(%ebp),%ecx
     889:	8b 55 10             	mov    0x10(%ebp),%edx
     88c:	8b 45 0c             	mov    0xc(%ebp),%eax
     88f:	89 cb                	mov    %ecx,%ebx
     891:	89 df                	mov    %ebx,%edi
     893:	89 d1                	mov    %edx,%ecx
     895:	fc                   	cld    
     896:	f3 aa                	rep stos %al,%es:(%edi)
     898:	89 ca                	mov    %ecx,%edx
     89a:	89 fb                	mov    %edi,%ebx
     89c:	89 5d 08             	mov    %ebx,0x8(%ebp)
     89f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     8a2:	90                   	nop
     8a3:	5b                   	pop    %ebx
     8a4:	5f                   	pop    %edi
     8a5:	5d                   	pop    %ebp
     8a6:	c3                   	ret    

000008a7 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     8a7:	55                   	push   %ebp
     8a8:	89 e5                	mov    %esp,%ebp
     8aa:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     8ad:	8b 45 08             	mov    0x8(%ebp),%eax
     8b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     8b3:	90                   	nop
     8b4:	8b 45 08             	mov    0x8(%ebp),%eax
     8b7:	8d 50 01             	lea    0x1(%eax),%edx
     8ba:	89 55 08             	mov    %edx,0x8(%ebp)
     8bd:	8b 55 0c             	mov    0xc(%ebp),%edx
     8c0:	8d 4a 01             	lea    0x1(%edx),%ecx
     8c3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     8c6:	0f b6 12             	movzbl (%edx),%edx
     8c9:	88 10                	mov    %dl,(%eax)
     8cb:	0f b6 00             	movzbl (%eax),%eax
     8ce:	84 c0                	test   %al,%al
     8d0:	75 e2                	jne    8b4 <strcpy+0xd>
    ;
  return os;
     8d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     8d5:	c9                   	leave  
     8d6:	c3                   	ret    

000008d7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     8d7:	55                   	push   %ebp
     8d8:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     8da:	eb 08                	jmp    8e4 <strcmp+0xd>
    p++, q++;
     8dc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     8e0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     8e4:	8b 45 08             	mov    0x8(%ebp),%eax
     8e7:	0f b6 00             	movzbl (%eax),%eax
     8ea:	84 c0                	test   %al,%al
     8ec:	74 10                	je     8fe <strcmp+0x27>
     8ee:	8b 45 08             	mov    0x8(%ebp),%eax
     8f1:	0f b6 10             	movzbl (%eax),%edx
     8f4:	8b 45 0c             	mov    0xc(%ebp),%eax
     8f7:	0f b6 00             	movzbl (%eax),%eax
     8fa:	38 c2                	cmp    %al,%dl
     8fc:	74 de                	je     8dc <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     8fe:	8b 45 08             	mov    0x8(%ebp),%eax
     901:	0f b6 00             	movzbl (%eax),%eax
     904:	0f b6 d0             	movzbl %al,%edx
     907:	8b 45 0c             	mov    0xc(%ebp),%eax
     90a:	0f b6 00             	movzbl (%eax),%eax
     90d:	0f b6 c0             	movzbl %al,%eax
     910:	29 c2                	sub    %eax,%edx
     912:	89 d0                	mov    %edx,%eax
}
     914:	5d                   	pop    %ebp
     915:	c3                   	ret    

00000916 <strlen>:

uint
strlen(char *s)
{
     916:	55                   	push   %ebp
     917:	89 e5                	mov    %esp,%ebp
     919:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     91c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     923:	eb 04                	jmp    929 <strlen+0x13>
     925:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     929:	8b 55 fc             	mov    -0x4(%ebp),%edx
     92c:	8b 45 08             	mov    0x8(%ebp),%eax
     92f:	01 d0                	add    %edx,%eax
     931:	0f b6 00             	movzbl (%eax),%eax
     934:	84 c0                	test   %al,%al
     936:	75 ed                	jne    925 <strlen+0xf>
    ;
  return n;
     938:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     93b:	c9                   	leave  
     93c:	c3                   	ret    

0000093d <memset>:

void*
memset(void *dst, int c, uint n)
{
     93d:	55                   	push   %ebp
     93e:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     940:	8b 45 10             	mov    0x10(%ebp),%eax
     943:	50                   	push   %eax
     944:	ff 75 0c             	pushl  0xc(%ebp)
     947:	ff 75 08             	pushl  0x8(%ebp)
     94a:	e8 32 ff ff ff       	call   881 <stosb>
     94f:	83 c4 0c             	add    $0xc,%esp
  return dst;
     952:	8b 45 08             	mov    0x8(%ebp),%eax
}
     955:	c9                   	leave  
     956:	c3                   	ret    

00000957 <strchr>:

char*
strchr(const char *s, char c)
{
     957:	55                   	push   %ebp
     958:	89 e5                	mov    %esp,%ebp
     95a:	83 ec 04             	sub    $0x4,%esp
     95d:	8b 45 0c             	mov    0xc(%ebp),%eax
     960:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     963:	eb 14                	jmp    979 <strchr+0x22>
    if(*s == c)
     965:	8b 45 08             	mov    0x8(%ebp),%eax
     968:	0f b6 00             	movzbl (%eax),%eax
     96b:	3a 45 fc             	cmp    -0x4(%ebp),%al
     96e:	75 05                	jne    975 <strchr+0x1e>
      return (char*)s;
     970:	8b 45 08             	mov    0x8(%ebp),%eax
     973:	eb 13                	jmp    988 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     975:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     979:	8b 45 08             	mov    0x8(%ebp),%eax
     97c:	0f b6 00             	movzbl (%eax),%eax
     97f:	84 c0                	test   %al,%al
     981:	75 e2                	jne    965 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     983:	b8 00 00 00 00       	mov    $0x0,%eax
}
     988:	c9                   	leave  
     989:	c3                   	ret    

0000098a <gets>:

char*
gets(char *buf, int max)
{
     98a:	55                   	push   %ebp
     98b:	89 e5                	mov    %esp,%ebp
     98d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     990:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     997:	eb 42                	jmp    9db <gets+0x51>
    cc = read(0, &c, 1);
     999:	83 ec 04             	sub    $0x4,%esp
     99c:	6a 01                	push   $0x1
     99e:	8d 45 ef             	lea    -0x11(%ebp),%eax
     9a1:	50                   	push   %eax
     9a2:	6a 00                	push   $0x0
     9a4:	e8 47 01 00 00       	call   af0 <read>
     9a9:	83 c4 10             	add    $0x10,%esp
     9ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     9af:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     9b3:	7e 33                	jle    9e8 <gets+0x5e>
      break;
    buf[i++] = c;
     9b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9b8:	8d 50 01             	lea    0x1(%eax),%edx
     9bb:	89 55 f4             	mov    %edx,-0xc(%ebp)
     9be:	89 c2                	mov    %eax,%edx
     9c0:	8b 45 08             	mov    0x8(%ebp),%eax
     9c3:	01 c2                	add    %eax,%edx
     9c5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     9c9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     9cb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     9cf:	3c 0a                	cmp    $0xa,%al
     9d1:	74 16                	je     9e9 <gets+0x5f>
     9d3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     9d7:	3c 0d                	cmp    $0xd,%al
     9d9:	74 0e                	je     9e9 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     9db:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9de:	83 c0 01             	add    $0x1,%eax
     9e1:	3b 45 0c             	cmp    0xc(%ebp),%eax
     9e4:	7c b3                	jl     999 <gets+0xf>
     9e6:	eb 01                	jmp    9e9 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     9e8:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     9e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     9ec:	8b 45 08             	mov    0x8(%ebp),%eax
     9ef:	01 d0                	add    %edx,%eax
     9f1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     9f4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     9f7:	c9                   	leave  
     9f8:	c3                   	ret    

000009f9 <stat>:

int
stat(char *n, struct stat *st)
{
     9f9:	55                   	push   %ebp
     9fa:	89 e5                	mov    %esp,%ebp
     9fc:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     9ff:	83 ec 08             	sub    $0x8,%esp
     a02:	6a 00                	push   $0x0
     a04:	ff 75 08             	pushl  0x8(%ebp)
     a07:	e8 0c 01 00 00       	call   b18 <open>
     a0c:	83 c4 10             	add    $0x10,%esp
     a0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     a12:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a16:	79 07                	jns    a1f <stat+0x26>
    return -1;
     a18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a1d:	eb 25                	jmp    a44 <stat+0x4b>
  r = fstat(fd, st);
     a1f:	83 ec 08             	sub    $0x8,%esp
     a22:	ff 75 0c             	pushl  0xc(%ebp)
     a25:	ff 75 f4             	pushl  -0xc(%ebp)
     a28:	e8 03 01 00 00       	call   b30 <fstat>
     a2d:	83 c4 10             	add    $0x10,%esp
     a30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     a33:	83 ec 0c             	sub    $0xc,%esp
     a36:	ff 75 f4             	pushl  -0xc(%ebp)
     a39:	e8 c2 00 00 00       	call   b00 <close>
     a3e:	83 c4 10             	add    $0x10,%esp
  return r;
     a41:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     a44:	c9                   	leave  
     a45:	c3                   	ret    

00000a46 <atoi>:

int
atoi(const char *s)
{
     a46:	55                   	push   %ebp
     a47:	89 e5                	mov    %esp,%ebp
     a49:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     a4c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     a53:	eb 25                	jmp    a7a <atoi+0x34>
    n = n*10 + *s++ - '0';
     a55:	8b 55 fc             	mov    -0x4(%ebp),%edx
     a58:	89 d0                	mov    %edx,%eax
     a5a:	c1 e0 02             	shl    $0x2,%eax
     a5d:	01 d0                	add    %edx,%eax
     a5f:	01 c0                	add    %eax,%eax
     a61:	89 c1                	mov    %eax,%ecx
     a63:	8b 45 08             	mov    0x8(%ebp),%eax
     a66:	8d 50 01             	lea    0x1(%eax),%edx
     a69:	89 55 08             	mov    %edx,0x8(%ebp)
     a6c:	0f b6 00             	movzbl (%eax),%eax
     a6f:	0f be c0             	movsbl %al,%eax
     a72:	01 c8                	add    %ecx,%eax
     a74:	83 e8 30             	sub    $0x30,%eax
     a77:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     a7a:	8b 45 08             	mov    0x8(%ebp),%eax
     a7d:	0f b6 00             	movzbl (%eax),%eax
     a80:	3c 2f                	cmp    $0x2f,%al
     a82:	7e 0a                	jle    a8e <atoi+0x48>
     a84:	8b 45 08             	mov    0x8(%ebp),%eax
     a87:	0f b6 00             	movzbl (%eax),%eax
     a8a:	3c 39                	cmp    $0x39,%al
     a8c:	7e c7                	jle    a55 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     a8e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     a91:	c9                   	leave  
     a92:	c3                   	ret    

00000a93 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     a93:	55                   	push   %ebp
     a94:	89 e5                	mov    %esp,%ebp
     a96:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     a99:	8b 45 08             	mov    0x8(%ebp),%eax
     a9c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     a9f:	8b 45 0c             	mov    0xc(%ebp),%eax
     aa2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     aa5:	eb 17                	jmp    abe <memmove+0x2b>
    *dst++ = *src++;
     aa7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     aaa:	8d 50 01             	lea    0x1(%eax),%edx
     aad:	89 55 fc             	mov    %edx,-0x4(%ebp)
     ab0:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ab3:	8d 4a 01             	lea    0x1(%edx),%ecx
     ab6:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     ab9:	0f b6 12             	movzbl (%edx),%edx
     abc:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     abe:	8b 45 10             	mov    0x10(%ebp),%eax
     ac1:	8d 50 ff             	lea    -0x1(%eax),%edx
     ac4:	89 55 10             	mov    %edx,0x10(%ebp)
     ac7:	85 c0                	test   %eax,%eax
     ac9:	7f dc                	jg     aa7 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     acb:	8b 45 08             	mov    0x8(%ebp),%eax
}
     ace:	c9                   	leave  
     acf:	c3                   	ret    

00000ad0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     ad0:	b8 01 00 00 00       	mov    $0x1,%eax
     ad5:	cd 40                	int    $0x40
     ad7:	c3                   	ret    

00000ad8 <exit>:
SYSCALL(exit)
     ad8:	b8 02 00 00 00       	mov    $0x2,%eax
     add:	cd 40                	int    $0x40
     adf:	c3                   	ret    

00000ae0 <wait>:
SYSCALL(wait)
     ae0:	b8 03 00 00 00       	mov    $0x3,%eax
     ae5:	cd 40                	int    $0x40
     ae7:	c3                   	ret    

00000ae8 <pipe>:
SYSCALL(pipe)
     ae8:	b8 04 00 00 00       	mov    $0x4,%eax
     aed:	cd 40                	int    $0x40
     aef:	c3                   	ret    

00000af0 <read>:
SYSCALL(read)
     af0:	b8 05 00 00 00       	mov    $0x5,%eax
     af5:	cd 40                	int    $0x40
     af7:	c3                   	ret    

00000af8 <write>:
SYSCALL(write)
     af8:	b8 10 00 00 00       	mov    $0x10,%eax
     afd:	cd 40                	int    $0x40
     aff:	c3                   	ret    

00000b00 <close>:
SYSCALL(close)
     b00:	b8 15 00 00 00       	mov    $0x15,%eax
     b05:	cd 40                	int    $0x40
     b07:	c3                   	ret    

00000b08 <kill>:
SYSCALL(kill)
     b08:	b8 06 00 00 00       	mov    $0x6,%eax
     b0d:	cd 40                	int    $0x40
     b0f:	c3                   	ret    

00000b10 <exec>:
SYSCALL(exec)
     b10:	b8 07 00 00 00       	mov    $0x7,%eax
     b15:	cd 40                	int    $0x40
     b17:	c3                   	ret    

00000b18 <open>:
SYSCALL(open)
     b18:	b8 0f 00 00 00       	mov    $0xf,%eax
     b1d:	cd 40                	int    $0x40
     b1f:	c3                   	ret    

00000b20 <mknod>:
SYSCALL(mknod)
     b20:	b8 11 00 00 00       	mov    $0x11,%eax
     b25:	cd 40                	int    $0x40
     b27:	c3                   	ret    

00000b28 <unlink>:
SYSCALL(unlink)
     b28:	b8 12 00 00 00       	mov    $0x12,%eax
     b2d:	cd 40                	int    $0x40
     b2f:	c3                   	ret    

00000b30 <fstat>:
SYSCALL(fstat)
     b30:	b8 08 00 00 00       	mov    $0x8,%eax
     b35:	cd 40                	int    $0x40
     b37:	c3                   	ret    

00000b38 <link>:
SYSCALL(link)
     b38:	b8 13 00 00 00       	mov    $0x13,%eax
     b3d:	cd 40                	int    $0x40
     b3f:	c3                   	ret    

00000b40 <mkdir>:
SYSCALL(mkdir)
     b40:	b8 14 00 00 00       	mov    $0x14,%eax
     b45:	cd 40                	int    $0x40
     b47:	c3                   	ret    

00000b48 <chdir>:
SYSCALL(chdir)
     b48:	b8 09 00 00 00       	mov    $0x9,%eax
     b4d:	cd 40                	int    $0x40
     b4f:	c3                   	ret    

00000b50 <dup>:
SYSCALL(dup)
     b50:	b8 0a 00 00 00       	mov    $0xa,%eax
     b55:	cd 40                	int    $0x40
     b57:	c3                   	ret    

00000b58 <getpid>:
SYSCALL(getpid)
     b58:	b8 0b 00 00 00       	mov    $0xb,%eax
     b5d:	cd 40                	int    $0x40
     b5f:	c3                   	ret    

00000b60 <sbrk>:
SYSCALL(sbrk)
     b60:	b8 0c 00 00 00       	mov    $0xc,%eax
     b65:	cd 40                	int    $0x40
     b67:	c3                   	ret    

00000b68 <sleep>:
SYSCALL(sleep)
     b68:	b8 0d 00 00 00       	mov    $0xd,%eax
     b6d:	cd 40                	int    $0x40
     b6f:	c3                   	ret    

00000b70 <uptime>:
SYSCALL(uptime)
     b70:	b8 0e 00 00 00       	mov    $0xe,%eax
     b75:	cd 40                	int    $0x40
     b77:	c3                   	ret    

00000b78 <paintWindow>:

SYSCALL(paintWindow)
     b78:	b8 16 00 00 00       	mov    $0x16,%eax
     b7d:	cd 40                	int    $0x40
     b7f:	c3                   	ret    

00000b80 <sendMessage>:
SYSCALL(sendMessage)
     b80:	b8 17 00 00 00       	mov    $0x17,%eax
     b85:	cd 40                	int    $0x40
     b87:	c3                   	ret    

00000b88 <getMessage>:
SYSCALL(getMessage)
     b88:	b8 19 00 00 00       	mov    $0x19,%eax
     b8d:	cd 40                	int    $0x40
     b8f:	c3                   	ret    

00000b90 <registWindow>:
SYSCALL(registWindow)
     b90:	b8 18 00 00 00       	mov    $0x18,%eax
     b95:	cd 40                	int    $0x40
     b97:	c3                   	ret    

00000b98 <changePosition>:
SYSCALL(changePosition)
     b98:	b8 1a 00 00 00       	mov    $0x1a,%eax
     b9d:	cd 40                	int    $0x40
     b9f:	c3                   	ret    

00000ba0 <setupTimer>:
SYSCALL(setupTimer)
     ba0:	b8 1b 00 00 00       	mov    $0x1b,%eax
     ba5:	cd 40                	int    $0x40
     ba7:	c3                   	ret    

00000ba8 <deleteTimer>:
SYSCALL(deleteTimer)
     ba8:	b8 1c 00 00 00       	mov    $0x1c,%eax
     bad:	cd 40                	int    $0x40
     baf:	c3                   	ret    

00000bb0 <getCurrentTime>:
SYSCALL(getCurrentTime)
     bb0:	b8 1d 00 00 00       	mov    $0x1d,%eax
     bb5:	cd 40                	int    $0x40
     bb7:	c3                   	ret    

00000bb8 <removeWindow>:
SYSCALL(removeWindow)
     bb8:	b8 1e 00 00 00       	mov    $0x1e,%eax
     bbd:	cd 40                	int    $0x40
     bbf:	c3                   	ret    

00000bc0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	83 ec 18             	sub    $0x18,%esp
     bc6:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     bcc:	83 ec 04             	sub    $0x4,%esp
     bcf:	6a 01                	push   $0x1
     bd1:	8d 45 f4             	lea    -0xc(%ebp),%eax
     bd4:	50                   	push   %eax
     bd5:	ff 75 08             	pushl  0x8(%ebp)
     bd8:	e8 1b ff ff ff       	call   af8 <write>
     bdd:	83 c4 10             	add    $0x10,%esp
}
     be0:	90                   	nop
     be1:	c9                   	leave  
     be2:	c3                   	ret    

00000be3 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     be3:	55                   	push   %ebp
     be4:	89 e5                	mov    %esp,%ebp
     be6:	53                   	push   %ebx
     be7:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     bea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     bf1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     bf5:	74 17                	je     c0e <printint+0x2b>
     bf7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     bfb:	79 11                	jns    c0e <printint+0x2b>
    neg = 1;
     bfd:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     c04:	8b 45 0c             	mov    0xc(%ebp),%eax
     c07:	f7 d8                	neg    %eax
     c09:	89 45 ec             	mov    %eax,-0x14(%ebp)
     c0c:	eb 06                	jmp    c14 <printint+0x31>
  } else {
    x = xx;
     c0e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c11:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     c14:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     c1b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     c1e:	8d 41 01             	lea    0x1(%ecx),%eax
     c21:	89 45 f4             	mov    %eax,-0xc(%ebp)
     c24:	8b 5d 10             	mov    0x10(%ebp),%ebx
     c27:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c2a:	ba 00 00 00 00       	mov    $0x0,%edx
     c2f:	f7 f3                	div    %ebx
     c31:	89 d0                	mov    %edx,%eax
     c33:	0f b6 80 60 35 00 00 	movzbl 0x3560(%eax),%eax
     c3a:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     c3e:	8b 5d 10             	mov    0x10(%ebp),%ebx
     c41:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c44:	ba 00 00 00 00       	mov    $0x0,%edx
     c49:	f7 f3                	div    %ebx
     c4b:	89 45 ec             	mov    %eax,-0x14(%ebp)
     c4e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     c52:	75 c7                	jne    c1b <printint+0x38>
  if(neg)
     c54:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     c58:	74 2d                	je     c87 <printint+0xa4>
    buf[i++] = '-';
     c5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5d:	8d 50 01             	lea    0x1(%eax),%edx
     c60:	89 55 f4             	mov    %edx,-0xc(%ebp)
     c63:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     c68:	eb 1d                	jmp    c87 <printint+0xa4>
    putc(fd, buf[i]);
     c6a:	8d 55 dc             	lea    -0x24(%ebp),%edx
     c6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c70:	01 d0                	add    %edx,%eax
     c72:	0f b6 00             	movzbl (%eax),%eax
     c75:	0f be c0             	movsbl %al,%eax
     c78:	83 ec 08             	sub    $0x8,%esp
     c7b:	50                   	push   %eax
     c7c:	ff 75 08             	pushl  0x8(%ebp)
     c7f:	e8 3c ff ff ff       	call   bc0 <putc>
     c84:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     c87:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     c8b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c8f:	79 d9                	jns    c6a <printint+0x87>
    putc(fd, buf[i]);
}
     c91:	90                   	nop
     c92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c95:	c9                   	leave  
     c96:	c3                   	ret    

00000c97 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     c97:	55                   	push   %ebp
     c98:	89 e5                	mov    %esp,%ebp
     c9a:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     c9d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     ca4:	8d 45 0c             	lea    0xc(%ebp),%eax
     ca7:	83 c0 04             	add    $0x4,%eax
     caa:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     cad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     cb4:	e9 59 01 00 00       	jmp    e12 <printf+0x17b>
    c = fmt[i] & 0xff;
     cb9:	8b 55 0c             	mov    0xc(%ebp),%edx
     cbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cbf:	01 d0                	add    %edx,%eax
     cc1:	0f b6 00             	movzbl (%eax),%eax
     cc4:	0f be c0             	movsbl %al,%eax
     cc7:	25 ff 00 00 00       	and    $0xff,%eax
     ccc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     ccf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     cd3:	75 2c                	jne    d01 <printf+0x6a>
      if(c == '%'){
     cd5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     cd9:	75 0c                	jne    ce7 <printf+0x50>
        state = '%';
     cdb:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     ce2:	e9 27 01 00 00       	jmp    e0e <printf+0x177>
      } else {
        putc(fd, c);
     ce7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cea:	0f be c0             	movsbl %al,%eax
     ced:	83 ec 08             	sub    $0x8,%esp
     cf0:	50                   	push   %eax
     cf1:	ff 75 08             	pushl  0x8(%ebp)
     cf4:	e8 c7 fe ff ff       	call   bc0 <putc>
     cf9:	83 c4 10             	add    $0x10,%esp
     cfc:	e9 0d 01 00 00       	jmp    e0e <printf+0x177>
      }
    } else if(state == '%'){
     d01:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     d05:	0f 85 03 01 00 00    	jne    e0e <printf+0x177>
      if(c == 'd'){
     d0b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     d0f:	75 1e                	jne    d2f <printf+0x98>
        printint(fd, *ap, 10, 1);
     d11:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d14:	8b 00                	mov    (%eax),%eax
     d16:	6a 01                	push   $0x1
     d18:	6a 0a                	push   $0xa
     d1a:	50                   	push   %eax
     d1b:	ff 75 08             	pushl  0x8(%ebp)
     d1e:	e8 c0 fe ff ff       	call   be3 <printint>
     d23:	83 c4 10             	add    $0x10,%esp
        ap++;
     d26:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     d2a:	e9 d8 00 00 00       	jmp    e07 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     d2f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     d33:	74 06                	je     d3b <printf+0xa4>
     d35:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     d39:	75 1e                	jne    d59 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     d3b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d3e:	8b 00                	mov    (%eax),%eax
     d40:	6a 00                	push   $0x0
     d42:	6a 10                	push   $0x10
     d44:	50                   	push   %eax
     d45:	ff 75 08             	pushl  0x8(%ebp)
     d48:	e8 96 fe ff ff       	call   be3 <printint>
     d4d:	83 c4 10             	add    $0x10,%esp
        ap++;
     d50:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     d54:	e9 ae 00 00 00       	jmp    e07 <printf+0x170>
      } else if(c == 's'){
     d59:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     d5d:	75 43                	jne    da2 <printf+0x10b>
        s = (char*)*ap;
     d5f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d62:	8b 00                	mov    (%eax),%eax
     d64:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     d67:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     d6b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     d6f:	75 25                	jne    d96 <printf+0xff>
          s = "(null)";
     d71:	c7 45 f4 10 2d 00 00 	movl   $0x2d10,-0xc(%ebp)
        while(*s != 0){
     d78:	eb 1c                	jmp    d96 <printf+0xff>
          putc(fd, *s);
     d7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d7d:	0f b6 00             	movzbl (%eax),%eax
     d80:	0f be c0             	movsbl %al,%eax
     d83:	83 ec 08             	sub    $0x8,%esp
     d86:	50                   	push   %eax
     d87:	ff 75 08             	pushl  0x8(%ebp)
     d8a:	e8 31 fe ff ff       	call   bc0 <putc>
     d8f:	83 c4 10             	add    $0x10,%esp
          s++;
     d92:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     d96:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d99:	0f b6 00             	movzbl (%eax),%eax
     d9c:	84 c0                	test   %al,%al
     d9e:	75 da                	jne    d7a <printf+0xe3>
     da0:	eb 65                	jmp    e07 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     da2:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     da6:	75 1d                	jne    dc5 <printf+0x12e>
        putc(fd, *ap);
     da8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     dab:	8b 00                	mov    (%eax),%eax
     dad:	0f be c0             	movsbl %al,%eax
     db0:	83 ec 08             	sub    $0x8,%esp
     db3:	50                   	push   %eax
     db4:	ff 75 08             	pushl  0x8(%ebp)
     db7:	e8 04 fe ff ff       	call   bc0 <putc>
     dbc:	83 c4 10             	add    $0x10,%esp
        ap++;
     dbf:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     dc3:	eb 42                	jmp    e07 <printf+0x170>
      } else if(c == '%'){
     dc5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     dc9:	75 17                	jne    de2 <printf+0x14b>
        putc(fd, c);
     dcb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     dce:	0f be c0             	movsbl %al,%eax
     dd1:	83 ec 08             	sub    $0x8,%esp
     dd4:	50                   	push   %eax
     dd5:	ff 75 08             	pushl  0x8(%ebp)
     dd8:	e8 e3 fd ff ff       	call   bc0 <putc>
     ddd:	83 c4 10             	add    $0x10,%esp
     de0:	eb 25                	jmp    e07 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     de2:	83 ec 08             	sub    $0x8,%esp
     de5:	6a 25                	push   $0x25
     de7:	ff 75 08             	pushl  0x8(%ebp)
     dea:	e8 d1 fd ff ff       	call   bc0 <putc>
     def:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     df2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     df5:	0f be c0             	movsbl %al,%eax
     df8:	83 ec 08             	sub    $0x8,%esp
     dfb:	50                   	push   %eax
     dfc:	ff 75 08             	pushl  0x8(%ebp)
     dff:	e8 bc fd ff ff       	call   bc0 <putc>
     e04:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     e07:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e0e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e12:	8b 55 0c             	mov    0xc(%ebp),%edx
     e15:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e18:	01 d0                	add    %edx,%eax
     e1a:	0f b6 00             	movzbl (%eax),%eax
     e1d:	84 c0                	test   %al,%al
     e1f:	0f 85 94 fe ff ff    	jne    cb9 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     e25:	90                   	nop
     e26:	c9                   	leave  
     e27:	c3                   	ret    

00000e28 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e28:	55                   	push   %ebp
     e29:	89 e5                	mov    %esp,%ebp
     e2b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e2e:	8b 45 08             	mov    0x8(%ebp),%eax
     e31:	83 e8 08             	sub    $0x8,%eax
     e34:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e37:	a1 c8 71 00 00       	mov    0x71c8,%eax
     e3c:	89 45 fc             	mov    %eax,-0x4(%ebp)
     e3f:	eb 24                	jmp    e65 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e41:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e44:	8b 00                	mov    (%eax),%eax
     e46:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e49:	77 12                	ja     e5d <free+0x35>
     e4b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e4e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e51:	77 24                	ja     e77 <free+0x4f>
     e53:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e56:	8b 00                	mov    (%eax),%eax
     e58:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     e5b:	77 1a                	ja     e77 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e60:	8b 00                	mov    (%eax),%eax
     e62:	89 45 fc             	mov    %eax,-0x4(%ebp)
     e65:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e68:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e6b:	76 d4                	jbe    e41 <free+0x19>
     e6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e70:	8b 00                	mov    (%eax),%eax
     e72:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     e75:	76 ca                	jbe    e41 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     e77:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e7a:	8b 40 04             	mov    0x4(%eax),%eax
     e7d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     e84:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e87:	01 c2                	add    %eax,%edx
     e89:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e8c:	8b 00                	mov    (%eax),%eax
     e8e:	39 c2                	cmp    %eax,%edx
     e90:	75 24                	jne    eb6 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     e92:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e95:	8b 50 04             	mov    0x4(%eax),%edx
     e98:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e9b:	8b 00                	mov    (%eax),%eax
     e9d:	8b 40 04             	mov    0x4(%eax),%eax
     ea0:	01 c2                	add    %eax,%edx
     ea2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ea5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     ea8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     eab:	8b 00                	mov    (%eax),%eax
     ead:	8b 10                	mov    (%eax),%edx
     eaf:	8b 45 f8             	mov    -0x8(%ebp),%eax
     eb2:	89 10                	mov    %edx,(%eax)
     eb4:	eb 0a                	jmp    ec0 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     eb6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     eb9:	8b 10                	mov    (%eax),%edx
     ebb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ebe:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     ec0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ec3:	8b 40 04             	mov    0x4(%eax),%eax
     ec6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     ecd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ed0:	01 d0                	add    %edx,%eax
     ed2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     ed5:	75 20                	jne    ef7 <free+0xcf>
    p->s.size += bp->s.size;
     ed7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     eda:	8b 50 04             	mov    0x4(%eax),%edx
     edd:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ee0:	8b 40 04             	mov    0x4(%eax),%eax
     ee3:	01 c2                	add    %eax,%edx
     ee5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ee8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     eeb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     eee:	8b 10                	mov    (%eax),%edx
     ef0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ef3:	89 10                	mov    %edx,(%eax)
     ef5:	eb 08                	jmp    eff <free+0xd7>
  } else
    p->s.ptr = bp;
     ef7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     efa:	8b 55 f8             	mov    -0x8(%ebp),%edx
     efd:	89 10                	mov    %edx,(%eax)
  freep = p;
     eff:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f02:	a3 c8 71 00 00       	mov    %eax,0x71c8
}
     f07:	90                   	nop
     f08:	c9                   	leave  
     f09:	c3                   	ret    

00000f0a <morecore>:

static Header*
morecore(uint nu)
{
     f0a:	55                   	push   %ebp
     f0b:	89 e5                	mov    %esp,%ebp
     f0d:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     f10:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     f17:	77 07                	ja     f20 <morecore+0x16>
    nu = 4096;
     f19:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     f20:	8b 45 08             	mov    0x8(%ebp),%eax
     f23:	c1 e0 03             	shl    $0x3,%eax
     f26:	83 ec 0c             	sub    $0xc,%esp
     f29:	50                   	push   %eax
     f2a:	e8 31 fc ff ff       	call   b60 <sbrk>
     f2f:	83 c4 10             	add    $0x10,%esp
     f32:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     f35:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     f39:	75 07                	jne    f42 <morecore+0x38>
    return 0;
     f3b:	b8 00 00 00 00       	mov    $0x0,%eax
     f40:	eb 26                	jmp    f68 <morecore+0x5e>
  hp = (Header*)p;
     f42:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f45:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     f48:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f4b:	8b 55 08             	mov    0x8(%ebp),%edx
     f4e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     f51:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f54:	83 c0 08             	add    $0x8,%eax
     f57:	83 ec 0c             	sub    $0xc,%esp
     f5a:	50                   	push   %eax
     f5b:	e8 c8 fe ff ff       	call   e28 <free>
     f60:	83 c4 10             	add    $0x10,%esp
  return freep;
     f63:	a1 c8 71 00 00       	mov    0x71c8,%eax
}
     f68:	c9                   	leave  
     f69:	c3                   	ret    

00000f6a <malloc>:

void*
malloc(uint nbytes)
{
     f6a:	55                   	push   %ebp
     f6b:	89 e5                	mov    %esp,%ebp
     f6d:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f70:	8b 45 08             	mov    0x8(%ebp),%eax
     f73:	83 c0 07             	add    $0x7,%eax
     f76:	c1 e8 03             	shr    $0x3,%eax
     f79:	83 c0 01             	add    $0x1,%eax
     f7c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     f7f:	a1 c8 71 00 00       	mov    0x71c8,%eax
     f84:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f87:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     f8b:	75 23                	jne    fb0 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     f8d:	c7 45 f0 c0 71 00 00 	movl   $0x71c0,-0x10(%ebp)
     f94:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f97:	a3 c8 71 00 00       	mov    %eax,0x71c8
     f9c:	a1 c8 71 00 00       	mov    0x71c8,%eax
     fa1:	a3 c0 71 00 00       	mov    %eax,0x71c0
    base.s.size = 0;
     fa6:	c7 05 c4 71 00 00 00 	movl   $0x0,0x71c4
     fad:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fb3:	8b 00                	mov    (%eax),%eax
     fb5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     fb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fbb:	8b 40 04             	mov    0x4(%eax),%eax
     fbe:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     fc1:	72 4d                	jb     1010 <malloc+0xa6>
      if(p->s.size == nunits)
     fc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fc6:	8b 40 04             	mov    0x4(%eax),%eax
     fc9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     fcc:	75 0c                	jne    fda <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     fce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fd1:	8b 10                	mov    (%eax),%edx
     fd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fd6:	89 10                	mov    %edx,(%eax)
     fd8:	eb 26                	jmp    1000 <malloc+0x96>
      else {
        p->s.size -= nunits;
     fda:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fdd:	8b 40 04             	mov    0x4(%eax),%eax
     fe0:	2b 45 ec             	sub    -0x14(%ebp),%eax
     fe3:	89 c2                	mov    %eax,%edx
     fe5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fe8:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     feb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fee:	8b 40 04             	mov    0x4(%eax),%eax
     ff1:	c1 e0 03             	shl    $0x3,%eax
     ff4:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     ff7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ffa:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ffd:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1000:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1003:	a3 c8 71 00 00       	mov    %eax,0x71c8
      return (void*)(p + 1);
    1008:	8b 45 f4             	mov    -0xc(%ebp),%eax
    100b:	83 c0 08             	add    $0x8,%eax
    100e:	eb 3b                	jmp    104b <malloc+0xe1>
    }
    if(p == freep)
    1010:	a1 c8 71 00 00       	mov    0x71c8,%eax
    1015:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1018:	75 1e                	jne    1038 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    101a:	83 ec 0c             	sub    $0xc,%esp
    101d:	ff 75 ec             	pushl  -0x14(%ebp)
    1020:	e8 e5 fe ff ff       	call   f0a <morecore>
    1025:	83 c4 10             	add    $0x10,%esp
    1028:	89 45 f4             	mov    %eax,-0xc(%ebp)
    102b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    102f:	75 07                	jne    1038 <malloc+0xce>
        return 0;
    1031:	b8 00 00 00 00       	mov    $0x0,%eax
    1036:	eb 13                	jmp    104b <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1038:	8b 45 f4             	mov    -0xc(%ebp),%eax
    103b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    103e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1041:	8b 00                	mov    (%eax),%eax
    1043:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1046:	e9 6d ff ff ff       	jmp    fb8 <malloc+0x4e>
}
    104b:	c9                   	leave  
    104c:	c3                   	ret    

0000104d <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    104d:	55                   	push   %ebp
    104e:	89 e5                	mov    %esp,%ebp
    1050:	83 ec 1c             	sub    $0x1c,%esp
    1053:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1056:	8b 55 10             	mov    0x10(%ebp),%edx
    1059:	8b 45 14             	mov    0x14(%ebp),%eax
    105c:	88 4d ec             	mov    %cl,-0x14(%ebp)
    105f:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1062:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1065:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1069:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    106c:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1070:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1073:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1077:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    107a:	8b 45 08             	mov    0x8(%ebp),%eax
    107d:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1081:	66 89 10             	mov    %dx,(%eax)
    1084:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1088:	88 50 02             	mov    %dl,0x2(%eax)
}
    108b:	8b 45 08             	mov    0x8(%ebp),%eax
    108e:	c9                   	leave  
    108f:	c2 04 00             	ret    $0x4

00001092 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    1092:	55                   	push   %ebp
    1093:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
    1095:	8b 45 08             	mov    0x8(%ebp),%eax
    1098:	2b 45 10             	sub    0x10(%ebp),%eax
    109b:	89 c2                	mov    %eax,%edx
    109d:	8b 45 08             	mov    0x8(%ebp),%eax
    10a0:	2b 45 10             	sub    0x10(%ebp),%eax
    10a3:	0f af d0             	imul   %eax,%edx
    10a6:	8b 45 0c             	mov    0xc(%ebp),%eax
    10a9:	2b 45 14             	sub    0x14(%ebp),%eax
    10ac:	89 c1                	mov    %eax,%ecx
    10ae:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b1:	2b 45 14             	sub    0x14(%ebp),%eax
    10b4:	0f af c1             	imul   %ecx,%eax
    10b7:	01 d0                	add    %edx,%eax
}
    10b9:	5d                   	pop    %ebp
    10ba:	c3                   	ret    

000010bb <abs_int>:

static inline int abs_int(int x)
{
    10bb:	55                   	push   %ebp
    10bc:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
    10be:	8b 45 08             	mov    0x8(%ebp),%eax
    10c1:	99                   	cltd   
    10c2:	89 d0                	mov    %edx,%eax
    10c4:	33 45 08             	xor    0x8(%ebp),%eax
    10c7:	29 d0                	sub    %edx,%eax
}
    10c9:	5d                   	pop    %ebp
    10ca:	c3                   	ret    

000010cb <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    10cb:	55                   	push   %ebp
    10cc:	89 e5                	mov    %esp,%ebp
    if (x < 0)
    10ce:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10d2:	79 07                	jns    10db <APGetIndex+0x10>
        return X_SMALLER;
    10d4:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    10d9:	eb 40                	jmp    111b <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
    10db:	8b 45 08             	mov    0x8(%ebp),%eax
    10de:	8b 00                	mov    (%eax),%eax
    10e0:	3b 45 0c             	cmp    0xc(%ebp),%eax
    10e3:	7f 07                	jg     10ec <APGetIndex+0x21>
        return X_BIGGER;
    10e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    10ea:	eb 2f                	jmp    111b <APGetIndex+0x50>
    if (y < 0)
    10ec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    10f0:	79 07                	jns    10f9 <APGetIndex+0x2e>
        return Y_SMALLER;
    10f2:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
    10f7:	eb 22                	jmp    111b <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
    10f9:	8b 45 08             	mov    0x8(%ebp),%eax
    10fc:	8b 40 04             	mov    0x4(%eax),%eax
    10ff:	3b 45 10             	cmp    0x10(%ebp),%eax
    1102:	7f 07                	jg     110b <APGetIndex+0x40>
        return Y_BIGGER;
    1104:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    1109:	eb 10                	jmp    111b <APGetIndex+0x50>
    return y * hdc->size.cx + x;
    110b:	8b 45 08             	mov    0x8(%ebp),%eax
    110e:	8b 00                	mov    (%eax),%eax
    1110:	0f af 45 10          	imul   0x10(%ebp),%eax
    1114:	89 c2                	mov    %eax,%edx
    1116:	8b 45 0c             	mov    0xc(%ebp),%eax
    1119:	01 d0                	add    %edx,%eax
}
    111b:	5d                   	pop    %ebp
    111c:	c3                   	ret    

0000111d <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    111d:	55                   	push   %ebp
    111e:	89 e5                	mov    %esp,%ebp
    1120:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    1123:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    112a:	8b 45 cc             	mov    -0x34(%ebp),%eax
    112d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    1130:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    1137:	83 ec 08             	sub    $0x8,%esp
    113a:	6a 00                	push   $0x0
    113c:	ff 75 0c             	pushl  0xc(%ebp)
    113f:	e8 d4 f9 ff ff       	call   b18 <open>
    1144:	83 c4 10             	add    $0x10,%esp
    1147:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    114a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    114e:	79 2e                	jns    117e <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
    1150:	83 ec 04             	sub    $0x4,%esp
    1153:	ff 75 0c             	pushl  0xc(%ebp)
    1156:	68 17 2d 00 00       	push   $0x2d17
    115b:	6a 01                	push   $0x1
    115d:	e8 35 fb ff ff       	call   c97 <printf>
    1162:	83 c4 10             	add    $0x10,%esp
        return bmp;
    1165:	8b 45 08             	mov    0x8(%ebp),%eax
    1168:	8b 55 c8             	mov    -0x38(%ebp),%edx
    116b:	89 10                	mov    %edx,(%eax)
    116d:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1170:	89 50 04             	mov    %edx,0x4(%eax)
    1173:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1176:	89 50 08             	mov    %edx,0x8(%eax)
    1179:	e9 d2 01 00 00       	jmp    1350 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    117e:	83 ec 04             	sub    $0x4,%esp
    1181:	6a 0e                	push   $0xe
    1183:	8d 45 ba             	lea    -0x46(%ebp),%eax
    1186:	50                   	push   %eax
    1187:	ff 75 ec             	pushl  -0x14(%ebp)
    118a:	e8 61 f9 ff ff       	call   af0 <read>
    118f:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    1192:	83 ec 04             	sub    $0x4,%esp
    1195:	6a 28                	push   $0x28
    1197:	8d 45 92             	lea    -0x6e(%ebp),%eax
    119a:	50                   	push   %eax
    119b:	ff 75 ec             	pushl  -0x14(%ebp)
    119e:	e8 4d f9 ff ff       	call   af0 <read>
    11a3:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    11a6:	8b 45 96             	mov    -0x6a(%ebp),%eax
    11a9:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    11ac:	8b 45 9a             	mov    -0x66(%ebp),%eax
    11af:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    11b2:	8b 55 c8             	mov    -0x38(%ebp),%edx
    11b5:	8b 45 cc             	mov    -0x34(%ebp),%eax
    11b8:	0f af d0             	imul   %eax,%edx
    11bb:	89 d0                	mov    %edx,%eax
    11bd:	01 c0                	add    %eax,%eax
    11bf:	01 d0                	add    %edx,%eax
    11c1:	83 ec 0c             	sub    $0xc,%esp
    11c4:	50                   	push   %eax
    11c5:	e8 a0 fd ff ff       	call   f6a <malloc>
    11ca:	83 c4 10             	add    $0x10,%esp
    11cd:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    11d0:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    11d4:	0f b7 c0             	movzwl %ax,%eax
    11d7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    11da:	8b 55 c8             	mov    -0x38(%ebp),%edx
    11dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11e0:	0f af c2             	imul   %edx,%eax
    11e3:	83 c0 1f             	add    $0x1f,%eax
    11e6:	c1 e8 05             	shr    $0x5,%eax
    11e9:	c1 e0 02             	shl    $0x2,%eax
    11ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    11ef:	8b 55 cc             	mov    -0x34(%ebp),%edx
    11f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11f5:	0f af c2             	imul   %edx,%eax
    11f8:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    11fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11fe:	83 ec 0c             	sub    $0xc,%esp
    1201:	50                   	push   %eax
    1202:	e8 63 fd ff ff       	call   f6a <malloc>
    1207:	83 c4 10             	add    $0x10,%esp
    120a:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    120d:	83 ec 04             	sub    $0x4,%esp
    1210:	ff 75 e0             	pushl  -0x20(%ebp)
    1213:	ff 75 dc             	pushl  -0x24(%ebp)
    1216:	ff 75 ec             	pushl  -0x14(%ebp)
    1219:	e8 d2 f8 ff ff       	call   af0 <read>
    121e:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    1221:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    1225:	66 c1 e8 03          	shr    $0x3,%ax
    1229:	0f b7 c0             	movzwl %ax,%eax
    122c:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    122f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1236:	e9 e5 00 00 00       	jmp    1320 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    123b:	8b 55 cc             	mov    -0x34(%ebp),%edx
    123e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1241:	29 c2                	sub    %eax,%edx
    1243:	89 d0                	mov    %edx,%eax
    1245:	8d 50 ff             	lea    -0x1(%eax),%edx
    1248:	8b 45 c8             	mov    -0x38(%ebp),%eax
    124b:	0f af c2             	imul   %edx,%eax
    124e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    1251:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1258:	e9 b1 00 00 00       	jmp    130e <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    125d:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1260:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1263:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1266:	01 c8                	add    %ecx,%eax
    1268:	89 c1                	mov    %eax,%ecx
    126a:	89 c8                	mov    %ecx,%eax
    126c:	01 c0                	add    %eax,%eax
    126e:	01 c8                	add    %ecx,%eax
    1270:	01 c2                	add    %eax,%edx
    1272:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1275:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1279:	89 c1                	mov    %eax,%ecx
    127b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    127e:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1282:	01 c1                	add    %eax,%ecx
    1284:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1287:	01 c8                	add    %ecx,%eax
    1289:	8d 48 ff             	lea    -0x1(%eax),%ecx
    128c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    128f:	01 c8                	add    %ecx,%eax
    1291:	0f b6 00             	movzbl (%eax),%eax
    1294:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    1297:	8b 55 d0             	mov    -0x30(%ebp),%edx
    129a:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    129d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12a0:	01 c8                	add    %ecx,%eax
    12a2:	89 c1                	mov    %eax,%ecx
    12a4:	89 c8                	mov    %ecx,%eax
    12a6:	01 c0                	add    %eax,%eax
    12a8:	01 c8                	add    %ecx,%eax
    12aa:	01 c2                	add    %eax,%edx
    12ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12af:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    12b3:	89 c1                	mov    %eax,%ecx
    12b5:	8b 45 d8             	mov    -0x28(%ebp),%eax
    12b8:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    12bc:	01 c1                	add    %eax,%ecx
    12be:	8b 45 d8             	mov    -0x28(%ebp),%eax
    12c1:	01 c8                	add    %ecx,%eax
    12c3:	8d 48 fe             	lea    -0x2(%eax),%ecx
    12c6:	8b 45 dc             	mov    -0x24(%ebp),%eax
    12c9:	01 c8                	add    %ecx,%eax
    12cb:	0f b6 00             	movzbl (%eax),%eax
    12ce:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    12d1:	8b 55 d0             	mov    -0x30(%ebp),%edx
    12d4:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    12d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12da:	01 c8                	add    %ecx,%eax
    12dc:	89 c1                	mov    %eax,%ecx
    12de:	89 c8                	mov    %ecx,%eax
    12e0:	01 c0                	add    %eax,%eax
    12e2:	01 c8                	add    %ecx,%eax
    12e4:	01 c2                	add    %eax,%edx
    12e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12e9:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    12ed:	89 c1                	mov    %eax,%ecx
    12ef:	8b 45 d8             	mov    -0x28(%ebp),%eax
    12f2:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    12f6:	01 c1                	add    %eax,%ecx
    12f8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    12fb:	01 c8                	add    %ecx,%eax
    12fd:	8d 48 fd             	lea    -0x3(%eax),%ecx
    1300:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1303:	01 c8                	add    %ecx,%eax
    1305:	0f b6 00             	movzbl (%eax),%eax
    1308:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    130a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    130e:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1311:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1314:	39 c2                	cmp    %eax,%edx
    1316:	0f 87 41 ff ff ff    	ja     125d <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    131c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1320:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1323:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1326:	39 c2                	cmp    %eax,%edx
    1328:	0f 87 0d ff ff ff    	ja     123b <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    132e:	83 ec 0c             	sub    $0xc,%esp
    1331:	ff 75 ec             	pushl  -0x14(%ebp)
    1334:	e8 c7 f7 ff ff       	call   b00 <close>
    1339:	83 c4 10             	add    $0x10,%esp
    return bmp;
    133c:	8b 45 08             	mov    0x8(%ebp),%eax
    133f:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1342:	89 10                	mov    %edx,(%eax)
    1344:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1347:	89 50 04             	mov    %edx,0x4(%eax)
    134a:	8b 55 d0             	mov    -0x30(%ebp),%edx
    134d:	89 50 08             	mov    %edx,0x8(%eax)
}
    1350:	8b 45 08             	mov    0x8(%ebp),%eax
    1353:	c9                   	leave  
    1354:	c2 04 00             	ret    $0x4

00001357 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    1357:	55                   	push   %ebp
    1358:	89 e5                	mov    %esp,%ebp
    135a:	53                   	push   %ebx
    135b:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    135e:	83 ec 0c             	sub    $0xc,%esp
    1361:	6a 1c                	push   $0x1c
    1363:	e8 02 fc ff ff       	call   f6a <malloc>
    1368:	83 c4 10             	add    $0x10,%esp
    136b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    136e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1371:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    1378:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    137b:	8d 45 d8             	lea    -0x28(%ebp),%eax
    137e:	6a 0c                	push   $0xc
    1380:	6a 0c                	push   $0xc
    1382:	6a 0c                	push   $0xc
    1384:	50                   	push   %eax
    1385:	e8 c3 fc ff ff       	call   104d <RGB>
    138a:	83 c4 0c             	add    $0xc,%esp
    138d:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    1391:	66 89 43 13          	mov    %ax,0x13(%ebx)
    1395:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    1399:	88 43 15             	mov    %al,0x15(%ebx)
    139c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    139f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13a2:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    13a6:	66 89 48 10          	mov    %cx,0x10(%eax)
    13aa:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    13ae:	88 50 12             	mov    %dl,0x12(%eax)
    13b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13b7:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    13bb:	66 89 48 08          	mov    %cx,0x8(%eax)
    13bf:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    13c3:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    13c6:	8b 45 08             	mov    0x8(%ebp),%eax
    13c9:	89 c2                	mov    %eax,%edx
    13cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13ce:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    13d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    13d3:	89 c2                	mov    %eax,%edx
    13d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13d8:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    13db:	8b 55 10             	mov    0x10(%ebp),%edx
    13de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13e1:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    13e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    13e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13ea:	c9                   	leave  
    13eb:	c3                   	ret    

000013ec <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    13ec:	55                   	push   %ebp
    13ed:	89 e5                	mov    %esp,%ebp
    13ef:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    13f2:	8b 45 0c             	mov    0xc(%ebp),%eax
    13f5:	8b 50 08             	mov    0x8(%eax),%edx
    13f8:	89 55 f8             	mov    %edx,-0x8(%ebp)
    13fb:	8b 40 0c             	mov    0xc(%eax),%eax
    13fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    1401:	8b 45 0c             	mov    0xc(%ebp),%eax
    1404:	8b 55 10             	mov    0x10(%ebp),%edx
    1407:	89 50 08             	mov    %edx,0x8(%eax)
    140a:	8b 55 14             	mov    0x14(%ebp),%edx
    140d:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    1410:	8b 45 08             	mov    0x8(%ebp),%eax
    1413:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1416:	89 10                	mov    %edx,(%eax)
    1418:	8b 55 fc             	mov    -0x4(%ebp),%edx
    141b:	89 50 04             	mov    %edx,0x4(%eax)
}
    141e:	8b 45 08             	mov    0x8(%ebp),%eax
    1421:	c9                   	leave  
    1422:	c2 04 00             	ret    $0x4

00001425 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    1425:	55                   	push   %ebp
    1426:	89 e5                	mov    %esp,%ebp
    1428:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    142b:	8b 45 0c             	mov    0xc(%ebp),%eax
    142e:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    1432:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1436:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    143a:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    143d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1440:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1444:	66 89 50 10          	mov    %dx,0x10(%eax)
    1448:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    144c:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    144f:	8b 45 08             	mov    0x8(%ebp),%eax
    1452:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1456:	66 89 10             	mov    %dx,(%eax)
    1459:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    145d:	88 50 02             	mov    %dl,0x2(%eax)
}
    1460:	8b 45 08             	mov    0x8(%ebp),%eax
    1463:	c9                   	leave  
    1464:	c2 04 00             	ret    $0x4

00001467 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
    1467:	55                   	push   %ebp
    1468:	89 e5                	mov    %esp,%ebp
    146a:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
    146d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1470:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1474:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1478:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    147c:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
    147f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1482:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1486:	66 89 50 13          	mov    %dx,0x13(%eax)
    148a:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    148e:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
    1491:	8b 45 08             	mov    0x8(%ebp),%eax
    1494:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1498:	66 89 10             	mov    %dx,(%eax)
    149b:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    149f:	88 50 02             	mov    %dl,0x2(%eax)
}
    14a2:	8b 45 08             	mov    0x8(%ebp),%eax
    14a5:	c9                   	leave  
    14a6:	c2 04 00             	ret    $0x4

000014a9 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    14a9:	55                   	push   %ebp
    14aa:	89 e5                	mov    %esp,%ebp
    14ac:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    14af:	8b 45 08             	mov    0x8(%ebp),%eax
    14b2:	8b 40 0c             	mov    0xc(%eax),%eax
    14b5:	89 c2                	mov    %eax,%edx
    14b7:	c1 ea 1f             	shr    $0x1f,%edx
    14ba:	01 d0                	add    %edx,%eax
    14bc:	d1 f8                	sar    %eax
    14be:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    14c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c4:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    14c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    14cb:	8b 45 10             	mov    0x10(%ebp),%eax
    14ce:	2b 45 f4             	sub    -0xc(%ebp),%eax
    14d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    14d4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    14d8:	0f 89 98 00 00 00    	jns    1576 <APDrawPoint+0xcd>
        i = 0;
    14de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    14e5:	e9 8c 00 00 00       	jmp    1576 <APDrawPoint+0xcd>
    {
        j = x - off;
    14ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    14ed:	2b 45 f4             	sub    -0xc(%ebp),%eax
    14f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    14f3:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    14f7:	79 69                	jns    1562 <APDrawPoint+0xb9>
            j = 0;
    14f9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    1500:	eb 60                	jmp    1562 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    1502:	ff 75 fc             	pushl  -0x4(%ebp)
    1505:	ff 75 f8             	pushl  -0x8(%ebp)
    1508:	ff 75 08             	pushl  0x8(%ebp)
    150b:	e8 bb fb ff ff       	call   10cb <APGetIndex>
    1510:	83 c4 0c             	add    $0xc,%esp
    1513:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    1516:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    151a:	74 55                	je     1571 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    151c:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    1520:	74 67                	je     1589 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    1522:	ff 75 10             	pushl  0x10(%ebp)
    1525:	ff 75 0c             	pushl  0xc(%ebp)
    1528:	ff 75 fc             	pushl  -0x4(%ebp)
    152b:	ff 75 f8             	pushl  -0x8(%ebp)
    152e:	e8 5f fb ff ff       	call   1092 <distance_2>
    1533:	83 c4 10             	add    $0x10,%esp
    1536:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1539:	7f 23                	jg     155e <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    153b:	8b 45 08             	mov    0x8(%ebp),%eax
    153e:	8b 48 18             	mov    0x18(%eax),%ecx
    1541:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1544:	89 d0                	mov    %edx,%eax
    1546:	01 c0                	add    %eax,%eax
    1548:	01 d0                	add    %edx,%eax
    154a:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    154d:	8b 45 08             	mov    0x8(%ebp),%eax
    1550:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1554:	66 89 0a             	mov    %cx,(%edx)
    1557:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    155b:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    155e:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1562:	8b 55 0c             	mov    0xc(%ebp),%edx
    1565:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1568:	01 d0                	add    %edx,%eax
    156a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    156d:	7d 93                	jge    1502 <APDrawPoint+0x59>
    156f:	eb 01                	jmp    1572 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1571:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1572:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1576:	8b 55 10             	mov    0x10(%ebp),%edx
    1579:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157c:	01 d0                	add    %edx,%eax
    157e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1581:	0f 8d 63 ff ff ff    	jge    14ea <APDrawPoint+0x41>
    1587:	eb 01                	jmp    158a <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1589:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    158a:	c9                   	leave  
    158b:	c3                   	ret    

0000158c <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    158c:	55                   	push   %ebp
    158d:	89 e5                	mov    %esp,%ebp
    158f:	53                   	push   %ebx
    1590:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1593:	8b 45 0c             	mov    0xc(%ebp),%eax
    1596:	3b 45 14             	cmp    0x14(%ebp),%eax
    1599:	0f 85 80 00 00 00    	jne    161f <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    159f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    15a3:	0f 88 9d 02 00 00    	js     1846 <APDrawLine+0x2ba>
    15a9:	8b 45 08             	mov    0x8(%ebp),%eax
    15ac:	8b 00                	mov    (%eax),%eax
    15ae:	3b 45 0c             	cmp    0xc(%ebp),%eax
    15b1:	0f 8e 8f 02 00 00    	jle    1846 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    15b7:	8b 45 10             	mov    0x10(%ebp),%eax
    15ba:	3b 45 18             	cmp    0x18(%ebp),%eax
    15bd:	7e 12                	jle    15d1 <APDrawLine+0x45>
        {
            int tmp = y2;
    15bf:	8b 45 18             	mov    0x18(%ebp),%eax
    15c2:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    15c5:	8b 45 10             	mov    0x10(%ebp),%eax
    15c8:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    15cb:	8b 45 dc             	mov    -0x24(%ebp),%eax
    15ce:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    15d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    15d5:	79 07                	jns    15de <APDrawLine+0x52>
    15d7:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    15de:	8b 45 08             	mov    0x8(%ebp),%eax
    15e1:	8b 40 04             	mov    0x4(%eax),%eax
    15e4:	3b 45 18             	cmp    0x18(%ebp),%eax
    15e7:	7d 0c                	jge    15f5 <APDrawLine+0x69>
    15e9:	8b 45 08             	mov    0x8(%ebp),%eax
    15ec:	8b 40 04             	mov    0x4(%eax),%eax
    15ef:	83 e8 01             	sub    $0x1,%eax
    15f2:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    15f5:	8b 45 10             	mov    0x10(%ebp),%eax
    15f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    15fb:	eb 15                	jmp    1612 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    15fd:	ff 75 f4             	pushl  -0xc(%ebp)
    1600:	ff 75 0c             	pushl  0xc(%ebp)
    1603:	ff 75 08             	pushl  0x8(%ebp)
    1606:	e8 9e fe ff ff       	call   14a9 <APDrawPoint>
    160b:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    160e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1612:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1615:	3b 45 18             	cmp    0x18(%ebp),%eax
    1618:	7e e3                	jle    15fd <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    161a:	e9 2b 02 00 00       	jmp    184a <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    161f:	8b 45 10             	mov    0x10(%ebp),%eax
    1622:	3b 45 18             	cmp    0x18(%ebp),%eax
    1625:	75 7f                	jne    16a6 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    1627:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    162b:	0f 88 18 02 00 00    	js     1849 <APDrawLine+0x2bd>
    1631:	8b 45 08             	mov    0x8(%ebp),%eax
    1634:	8b 40 04             	mov    0x4(%eax),%eax
    1637:	3b 45 10             	cmp    0x10(%ebp),%eax
    163a:	0f 8e 09 02 00 00    	jle    1849 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1640:	8b 45 0c             	mov    0xc(%ebp),%eax
    1643:	3b 45 14             	cmp    0x14(%ebp),%eax
    1646:	7e 12                	jle    165a <APDrawLine+0xce>
        {
            int tmp = x2;
    1648:	8b 45 14             	mov    0x14(%ebp),%eax
    164b:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    164e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1651:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1654:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1657:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    165a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    165e:	79 07                	jns    1667 <APDrawLine+0xdb>
    1660:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1667:	8b 45 08             	mov    0x8(%ebp),%eax
    166a:	8b 00                	mov    (%eax),%eax
    166c:	3b 45 14             	cmp    0x14(%ebp),%eax
    166f:	7d 0b                	jge    167c <APDrawLine+0xf0>
    1671:	8b 45 08             	mov    0x8(%ebp),%eax
    1674:	8b 00                	mov    (%eax),%eax
    1676:	83 e8 01             	sub    $0x1,%eax
    1679:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    167c:	8b 45 0c             	mov    0xc(%ebp),%eax
    167f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1682:	eb 15                	jmp    1699 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1684:	ff 75 10             	pushl  0x10(%ebp)
    1687:	ff 75 f0             	pushl  -0x10(%ebp)
    168a:	ff 75 08             	pushl  0x8(%ebp)
    168d:	e8 17 fe ff ff       	call   14a9 <APDrawPoint>
    1692:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1695:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1699:	8b 45 f0             	mov    -0x10(%ebp),%eax
    169c:	3b 45 14             	cmp    0x14(%ebp),%eax
    169f:	7e e3                	jle    1684 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    16a1:	e9 a4 01 00 00       	jmp    184a <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    16a6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    16ad:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    16b4:	8b 45 0c             	mov    0xc(%ebp),%eax
    16b7:	2b 45 14             	sub    0x14(%ebp),%eax
    16ba:	50                   	push   %eax
    16bb:	e8 fb f9 ff ff       	call   10bb <abs_int>
    16c0:	83 c4 04             	add    $0x4,%esp
    16c3:	89 c3                	mov    %eax,%ebx
    16c5:	8b 45 10             	mov    0x10(%ebp),%eax
    16c8:	2b 45 18             	sub    0x18(%ebp),%eax
    16cb:	50                   	push   %eax
    16cc:	e8 ea f9 ff ff       	call   10bb <abs_int>
    16d1:	83 c4 04             	add    $0x4,%esp
    16d4:	39 c3                	cmp    %eax,%ebx
    16d6:	0f 8e b5 00 00 00    	jle    1791 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    16dc:	8b 45 10             	mov    0x10(%ebp),%eax
    16df:	2b 45 18             	sub    0x18(%ebp),%eax
    16e2:	89 45 b0             	mov    %eax,-0x50(%ebp)
    16e5:	db 45 b0             	fildl  -0x50(%ebp)
    16e8:	8b 45 0c             	mov    0xc(%ebp),%eax
    16eb:	2b 45 14             	sub    0x14(%ebp),%eax
    16ee:	89 45 b0             	mov    %eax,-0x50(%ebp)
    16f1:	db 45 b0             	fildl  -0x50(%ebp)
    16f4:	de f9                	fdivrp %st,%st(1)
    16f6:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    16f9:	8b 45 14             	mov    0x14(%ebp),%eax
    16fc:	3b 45 0c             	cmp    0xc(%ebp),%eax
    16ff:	7e 0e                	jle    170f <APDrawLine+0x183>
        {
            s = x1;
    1701:	8b 45 0c             	mov    0xc(%ebp),%eax
    1704:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1707:	8b 45 14             	mov    0x14(%ebp),%eax
    170a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    170d:	eb 0c                	jmp    171b <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    170f:	8b 45 14             	mov    0x14(%ebp),%eax
    1712:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1715:	8b 45 0c             	mov    0xc(%ebp),%eax
    1718:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    171b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    171f:	79 07                	jns    1728 <APDrawLine+0x19c>
    1721:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1728:	8b 45 08             	mov    0x8(%ebp),%eax
    172b:	8b 00                	mov    (%eax),%eax
    172d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1730:	7f 0b                	jg     173d <APDrawLine+0x1b1>
    1732:	8b 45 08             	mov    0x8(%ebp),%eax
    1735:	8b 00                	mov    (%eax),%eax
    1737:	83 e8 01             	sub    $0x1,%eax
    173a:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    173d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1740:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1743:	eb 3f                	jmp    1784 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1745:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1748:	2b 45 0c             	sub    0xc(%ebp),%eax
    174b:	89 45 b0             	mov    %eax,-0x50(%ebp)
    174e:	db 45 b0             	fildl  -0x50(%ebp)
    1751:	dc 4d d0             	fmull  -0x30(%ebp)
    1754:	db 45 10             	fildl  0x10(%ebp)
    1757:	de c1                	faddp  %st,%st(1)
    1759:	d9 7d b6             	fnstcw -0x4a(%ebp)
    175c:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1760:	b4 0c                	mov    $0xc,%ah
    1762:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1766:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1769:	db 5d cc             	fistpl -0x34(%ebp)
    176c:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    176f:	ff 75 cc             	pushl  -0x34(%ebp)
    1772:	ff 75 e4             	pushl  -0x1c(%ebp)
    1775:	ff 75 08             	pushl  0x8(%ebp)
    1778:	e8 2c fd ff ff       	call   14a9 <APDrawPoint>
    177d:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1780:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1784:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1787:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    178a:	7e b9                	jle    1745 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    178c:	e9 b9 00 00 00       	jmp    184a <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1791:	8b 45 0c             	mov    0xc(%ebp),%eax
    1794:	2b 45 14             	sub    0x14(%ebp),%eax
    1797:	89 45 b0             	mov    %eax,-0x50(%ebp)
    179a:	db 45 b0             	fildl  -0x50(%ebp)
    179d:	8b 45 10             	mov    0x10(%ebp),%eax
    17a0:	2b 45 18             	sub    0x18(%ebp),%eax
    17a3:	89 45 b0             	mov    %eax,-0x50(%ebp)
    17a6:	db 45 b0             	fildl  -0x50(%ebp)
    17a9:	de f9                	fdivrp %st,%st(1)
    17ab:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    17ae:	8b 45 10             	mov    0x10(%ebp),%eax
    17b1:	3b 45 18             	cmp    0x18(%ebp),%eax
    17b4:	7e 0e                	jle    17c4 <APDrawLine+0x238>
    {
        s = y2;
    17b6:	8b 45 18             	mov    0x18(%ebp),%eax
    17b9:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    17bc:	8b 45 10             	mov    0x10(%ebp),%eax
    17bf:	89 45 e8             	mov    %eax,-0x18(%ebp)
    17c2:	eb 0c                	jmp    17d0 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    17c4:	8b 45 10             	mov    0x10(%ebp),%eax
    17c7:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    17ca:	8b 45 18             	mov    0x18(%ebp),%eax
    17cd:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    17d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17d4:	79 07                	jns    17dd <APDrawLine+0x251>
    17d6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    17dd:	8b 45 08             	mov    0x8(%ebp),%eax
    17e0:	8b 40 04             	mov    0x4(%eax),%eax
    17e3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    17e6:	7f 0c                	jg     17f4 <APDrawLine+0x268>
    17e8:	8b 45 08             	mov    0x8(%ebp),%eax
    17eb:	8b 40 04             	mov    0x4(%eax),%eax
    17ee:	83 e8 01             	sub    $0x1,%eax
    17f1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    17f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
    17fa:	eb 3f                	jmp    183b <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    17fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    17ff:	2b 45 10             	sub    0x10(%ebp),%eax
    1802:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1805:	db 45 b0             	fildl  -0x50(%ebp)
    1808:	dc 4d c0             	fmull  -0x40(%ebp)
    180b:	db 45 0c             	fildl  0xc(%ebp)
    180e:	de c1                	faddp  %st,%st(1)
    1810:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1813:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1817:	b4 0c                	mov    $0xc,%ah
    1819:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    181d:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1820:	db 5d bc             	fistpl -0x44(%ebp)
    1823:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1826:	ff 75 e0             	pushl  -0x20(%ebp)
    1829:	ff 75 bc             	pushl  -0x44(%ebp)
    182c:	ff 75 08             	pushl  0x8(%ebp)
    182f:	e8 75 fc ff ff       	call   14a9 <APDrawPoint>
    1834:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1837:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    183b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    183e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1841:	7e b9                	jle    17fc <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1843:	90                   	nop
    1844:	eb 04                	jmp    184a <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1846:	90                   	nop
    1847:	eb 01                	jmp    184a <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1849:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    184a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    184d:	c9                   	leave  
    184e:	c3                   	ret    

0000184f <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    184f:	55                   	push   %ebp
    1850:	89 e5                	mov    %esp,%ebp
    1852:	53                   	push   %ebx
    1853:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1856:	8b 55 10             	mov    0x10(%ebp),%edx
    1859:	8b 45 18             	mov    0x18(%ebp),%eax
    185c:	01 d0                	add    %edx,%eax
    185e:	83 e8 01             	sub    $0x1,%eax
    1861:	83 ec 04             	sub    $0x4,%esp
    1864:	50                   	push   %eax
    1865:	ff 75 0c             	pushl  0xc(%ebp)
    1868:	ff 75 10             	pushl  0x10(%ebp)
    186b:	ff 75 0c             	pushl  0xc(%ebp)
    186e:	ff 75 08             	pushl  0x8(%ebp)
    1871:	e8 16 fd ff ff       	call   158c <APDrawLine>
    1876:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1879:	8b 55 0c             	mov    0xc(%ebp),%edx
    187c:	8b 45 14             	mov    0x14(%ebp),%eax
    187f:	01 d0                	add    %edx,%eax
    1881:	83 e8 01             	sub    $0x1,%eax
    1884:	83 ec 04             	sub    $0x4,%esp
    1887:	ff 75 10             	pushl  0x10(%ebp)
    188a:	50                   	push   %eax
    188b:	ff 75 10             	pushl  0x10(%ebp)
    188e:	ff 75 0c             	pushl  0xc(%ebp)
    1891:	ff 75 08             	pushl  0x8(%ebp)
    1894:	e8 f3 fc ff ff       	call   158c <APDrawLine>
    1899:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    189c:	8b 55 10             	mov    0x10(%ebp),%edx
    189f:	8b 45 18             	mov    0x18(%ebp),%eax
    18a2:	01 d0                	add    %edx,%eax
    18a4:	8d 48 ff             	lea    -0x1(%eax),%ecx
    18a7:	8b 55 0c             	mov    0xc(%ebp),%edx
    18aa:	8b 45 14             	mov    0x14(%ebp),%eax
    18ad:	01 d0                	add    %edx,%eax
    18af:	8d 50 ff             	lea    -0x1(%eax),%edx
    18b2:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    18b5:	8b 45 14             	mov    0x14(%ebp),%eax
    18b8:	01 d8                	add    %ebx,%eax
    18ba:	83 e8 01             	sub    $0x1,%eax
    18bd:	83 ec 04             	sub    $0x4,%esp
    18c0:	51                   	push   %ecx
    18c1:	52                   	push   %edx
    18c2:	ff 75 10             	pushl  0x10(%ebp)
    18c5:	50                   	push   %eax
    18c6:	ff 75 08             	pushl  0x8(%ebp)
    18c9:	e8 be fc ff ff       	call   158c <APDrawLine>
    18ce:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    18d1:	8b 55 10             	mov    0x10(%ebp),%edx
    18d4:	8b 45 18             	mov    0x18(%ebp),%eax
    18d7:	01 d0                	add    %edx,%eax
    18d9:	8d 48 ff             	lea    -0x1(%eax),%ecx
    18dc:	8b 55 0c             	mov    0xc(%ebp),%edx
    18df:	8b 45 14             	mov    0x14(%ebp),%eax
    18e2:	01 d0                	add    %edx,%eax
    18e4:	8d 50 ff             	lea    -0x1(%eax),%edx
    18e7:	8b 5d 10             	mov    0x10(%ebp),%ebx
    18ea:	8b 45 18             	mov    0x18(%ebp),%eax
    18ed:	01 d8                	add    %ebx,%eax
    18ef:	83 e8 01             	sub    $0x1,%eax
    18f2:	83 ec 04             	sub    $0x4,%esp
    18f5:	51                   	push   %ecx
    18f6:	52                   	push   %edx
    18f7:	50                   	push   %eax
    18f8:	ff 75 0c             	pushl  0xc(%ebp)
    18fb:	ff 75 08             	pushl  0x8(%ebp)
    18fe:	e8 89 fc ff ff       	call   158c <APDrawLine>
    1903:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1906:	8b 55 0c             	mov    0xc(%ebp),%edx
    1909:	8b 45 14             	mov    0x14(%ebp),%eax
    190c:	01 d0                	add    %edx,%eax
    190e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1911:	8b 45 08             	mov    0x8(%ebp),%eax
    1914:	8b 40 0c             	mov    0xc(%eax),%eax
    1917:	89 c1                	mov    %eax,%ecx
    1919:	c1 e9 1f             	shr    $0x1f,%ecx
    191c:	01 c8                	add    %ecx,%eax
    191e:	d1 f8                	sar    %eax
    1920:	29 c2                	sub    %eax,%edx
    1922:	89 d0                	mov    %edx,%eax
    1924:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1927:	8b 55 10             	mov    0x10(%ebp),%edx
    192a:	8b 45 18             	mov    0x18(%ebp),%eax
    192d:	01 d0                	add    %edx,%eax
    192f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1932:	8b 45 08             	mov    0x8(%ebp),%eax
    1935:	8b 40 0c             	mov    0xc(%eax),%eax
    1938:	89 c1                	mov    %eax,%ecx
    193a:	c1 e9 1f             	shr    $0x1f,%ecx
    193d:	01 c8                	add    %ecx,%eax
    193f:	d1 f8                	sar    %eax
    1941:	29 c2                	sub    %eax,%edx
    1943:	89 d0                	mov    %edx,%eax
    1945:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1948:	8b 45 08             	mov    0x8(%ebp),%eax
    194b:	8b 40 0c             	mov    0xc(%eax),%eax
    194e:	89 c2                	mov    %eax,%edx
    1950:	c1 ea 1f             	shr    $0x1f,%edx
    1953:	01 d0                	add    %edx,%eax
    1955:	d1 f8                	sar    %eax
    1957:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    195a:	8b 45 08             	mov    0x8(%ebp),%eax
    195d:	8b 40 0c             	mov    0xc(%eax),%eax
    1960:	89 c2                	mov    %eax,%edx
    1962:	c1 ea 1f             	shr    $0x1f,%edx
    1965:	01 d0                	add    %edx,%eax
    1967:	d1 f8                	sar    %eax
    1969:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    196c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1970:	0f 88 d8 00 00 00    	js     1a4e <APDrawRect+0x1ff>
    1976:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    197a:	0f 88 ce 00 00 00    	js     1a4e <APDrawRect+0x1ff>
    1980:	8b 45 08             	mov    0x8(%ebp),%eax
    1983:	8b 00                	mov    (%eax),%eax
    1985:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1988:	0f 8e c0 00 00 00    	jle    1a4e <APDrawRect+0x1ff>
    198e:	8b 45 08             	mov    0x8(%ebp),%eax
    1991:	8b 40 04             	mov    0x4(%eax),%eax
    1994:	3b 45 10             	cmp    0x10(%ebp),%eax
    1997:	0f 8e b1 00 00 00    	jle    1a4e <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    199d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    19a1:	79 07                	jns    19aa <APDrawRect+0x15b>
    19a3:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    19aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    19ae:	79 07                	jns    19b7 <APDrawRect+0x168>
    19b0:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    19b7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ba:	8b 00                	mov    (%eax),%eax
    19bc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    19bf:	7f 0b                	jg     19cc <APDrawRect+0x17d>
    19c1:	8b 45 08             	mov    0x8(%ebp),%eax
    19c4:	8b 00                	mov    (%eax),%eax
    19c6:	83 e8 01             	sub    $0x1,%eax
    19c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    19cc:	8b 45 08             	mov    0x8(%ebp),%eax
    19cf:	8b 40 04             	mov    0x4(%eax),%eax
    19d2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    19d5:	7f 0c                	jg     19e3 <APDrawRect+0x194>
    19d7:	8b 45 08             	mov    0x8(%ebp),%eax
    19da:	8b 40 04             	mov    0x4(%eax),%eax
    19dd:	83 e8 01             	sub    $0x1,%eax
    19e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    19e3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    19ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    19ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
    19f0:	eb 52                	jmp    1a44 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    19f2:	8b 45 10             	mov    0x10(%ebp),%eax
    19f5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    19f8:	eb 3e                	jmp    1a38 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    19fa:	83 ec 04             	sub    $0x4,%esp
    19fd:	ff 75 e8             	pushl  -0x18(%ebp)
    1a00:	ff 75 ec             	pushl  -0x14(%ebp)
    1a03:	ff 75 08             	pushl  0x8(%ebp)
    1a06:	e8 c0 f6 ff ff       	call   10cb <APGetIndex>
    1a0b:	83 c4 10             	add    $0x10,%esp
    1a0e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1a11:	8b 45 08             	mov    0x8(%ebp),%eax
    1a14:	8b 48 18             	mov    0x18(%eax),%ecx
    1a17:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1a1a:	89 d0                	mov    %edx,%eax
    1a1c:	01 c0                	add    %eax,%eax
    1a1e:	01 d0                	add    %edx,%eax
    1a20:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1a23:	8b 45 08             	mov    0x8(%ebp),%eax
    1a26:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1a2a:	66 89 0a             	mov    %cx,(%edx)
    1a2d:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1a31:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1a34:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1a38:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a3b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1a3e:	7e ba                	jle    19fa <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1a40:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1a44:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a47:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1a4a:	7e a6                	jle    19f2 <APDrawRect+0x1a3>
    1a4c:	eb 01                	jmp    1a4f <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1a4e:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1a4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1a52:	c9                   	leave  
    1a53:	c3                   	ret    

00001a54 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1a54:	55                   	push   %ebp
    1a55:	89 e5                	mov    %esp,%ebp
    1a57:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    1a5a:	83 ec 0c             	sub    $0xc,%esp
    1a5d:	ff 75 0c             	pushl  0xc(%ebp)
    1a60:	e8 b1 ee ff ff       	call   916 <strlen>
    1a65:	83 c4 10             	add    $0x10,%esp
    1a68:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1a6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6e:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1a72:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1a76:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1a7a:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1a7d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1a84:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1a8b:	e9 bc 00 00 00       	jmp    1b4c <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1a90:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a93:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a96:	01 d0                	add    %edx,%eax
    1a98:	0f b6 00             	movzbl (%eax),%eax
    1a9b:	0f be c0             	movsbl %al,%eax
    1a9e:	83 e8 20             	sub    $0x20,%eax
    1aa1:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1aa4:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1aa8:	0f 87 9a 00 00 00    	ja     1b48 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1aae:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab1:	8b 00                	mov    (%eax),%eax
    1ab3:	0f af 45 14          	imul   0x14(%ebp),%eax
    1ab7:	89 c2                	mov    %eax,%edx
    1ab9:	8b 45 10             	mov    0x10(%ebp),%eax
    1abc:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1abf:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ac2:	89 d0                	mov    %edx,%eax
    1ac4:	c1 e0 03             	shl    $0x3,%eax
    1ac7:	01 d0                	add    %edx,%eax
    1ac9:	01 c8                	add    %ecx,%eax
    1acb:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1ace:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1ad5:	eb 6b                	jmp    1b42 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1ad7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1ade:	eb 50                	jmp    1b30 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    1ae0:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1ae3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1ae6:	89 d0                	mov    %edx,%eax
    1ae8:	c1 e0 03             	shl    $0x3,%eax
    1aeb:	01 d0                	add    %edx,%eax
    1aed:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    1af3:	01 c2                	add    %eax,%edx
    1af5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1af8:	01 d0                	add    %edx,%eax
    1afa:	05 80 35 00 00       	add    $0x3580,%eax
    1aff:	0f b6 00             	movzbl (%eax),%eax
    1b02:	84 c0                	test   %al,%al
    1b04:	74 26                	je     1b2c <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1b06:	8b 45 08             	mov    0x8(%ebp),%eax
    1b09:	8b 50 18             	mov    0x18(%eax),%edx
    1b0c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1b0f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1b12:	01 c8                	add    %ecx,%eax
    1b14:	89 c1                	mov    %eax,%ecx
    1b16:	89 c8                	mov    %ecx,%eax
    1b18:	01 c0                	add    %eax,%eax
    1b1a:	01 c8                	add    %ecx,%eax
    1b1c:	01 d0                	add    %edx,%eax
    1b1e:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1b22:	66 89 10             	mov    %dx,(%eax)
    1b25:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1b29:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1b2c:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1b30:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1b34:	7e aa                	jle    1ae0 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1b36:	8b 45 08             	mov    0x8(%ebp),%eax
    1b39:	8b 00                	mov    (%eax),%eax
    1b3b:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1b3e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1b42:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1b46:	7e 8f                	jle    1ad7 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1b48:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b4f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1b52:	0f 82 38 ff ff ff    	jb     1a90 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1b58:	90                   	nop
    1b59:	c9                   	leave  
    1b5a:	c3                   	ret    

00001b5b <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1b5b:	55                   	push   %ebp
    1b5c:	89 e5                	mov    %esp,%ebp
    1b5e:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1b61:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1b65:	0f 88 8e 01 00 00    	js     1cf9 <APDcCopy+0x19e>
    1b6b:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1b6f:	0f 88 84 01 00 00    	js     1cf9 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1b75:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b78:	8b 45 20             	mov    0x20(%ebp),%eax
    1b7b:	01 d0                	add    %edx,%eax
    1b7d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1b80:	8b 55 10             	mov    0x10(%ebp),%edx
    1b83:	8b 45 24             	mov    0x24(%ebp),%eax
    1b86:	01 d0                	add    %edx,%eax
    1b88:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1b8b:	8b 55 18             	mov    0x18(%ebp),%edx
    1b8e:	8b 45 20             	mov    0x20(%ebp),%eax
    1b91:	01 d0                	add    %edx,%eax
    1b93:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b96:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1b99:	8b 45 24             	mov    0x24(%ebp),%eax
    1b9c:	01 d0                	add    %edx,%eax
    1b9e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1ba1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1ba5:	0f 88 51 01 00 00    	js     1cfc <APDcCopy+0x1a1>
    1bab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1baf:	0f 88 47 01 00 00    	js     1cfc <APDcCopy+0x1a1>
    1bb5:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1bb9:	0f 88 3d 01 00 00    	js     1cfc <APDcCopy+0x1a1>
    1bbf:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1bc3:	0f 88 33 01 00 00    	js     1cfc <APDcCopy+0x1a1>
    1bc9:	8b 45 14             	mov    0x14(%ebp),%eax
    1bcc:	8b 00                	mov    (%eax),%eax
    1bce:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1bd1:	0f 8c 25 01 00 00    	jl     1cfc <APDcCopy+0x1a1>
    1bd7:	8b 45 14             	mov    0x14(%ebp),%eax
    1bda:	8b 40 04             	mov    0x4(%eax),%eax
    1bdd:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1be0:	0f 8c 16 01 00 00    	jl     1cfc <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1be6:	8b 45 08             	mov    0x8(%ebp),%eax
    1be9:	8b 00                	mov    (%eax),%eax
    1beb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1bee:	7f 0b                	jg     1bfb <APDcCopy+0xa0>
    1bf0:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf3:	8b 00                	mov    (%eax),%eax
    1bf5:	83 e8 01             	sub    $0x1,%eax
    1bf8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1bfb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bfe:	8b 40 04             	mov    0x4(%eax),%eax
    1c01:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1c04:	7f 0c                	jg     1c12 <APDcCopy+0xb7>
    1c06:	8b 45 08             	mov    0x8(%ebp),%eax
    1c09:	8b 40 04             	mov    0x4(%eax),%eax
    1c0c:	83 e8 01             	sub    $0x1,%eax
    1c0f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1c12:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1c19:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1c20:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c27:	e9 bc 00 00 00       	jmp    1ce8 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1c2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c2f:	8b 00                	mov    (%eax),%eax
    1c31:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1c34:	8b 55 10             	mov    0x10(%ebp),%edx
    1c37:	01 ca                	add    %ecx,%edx
    1c39:	0f af d0             	imul   %eax,%edx
    1c3c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c3f:	01 d0                	add    %edx,%eax
    1c41:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1c44:	8b 45 14             	mov    0x14(%ebp),%eax
    1c47:	8b 00                	mov    (%eax),%eax
    1c49:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1c4c:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1c4f:	01 ca                	add    %ecx,%edx
    1c51:	0f af d0             	imul   %eax,%edx
    1c54:	8b 45 18             	mov    0x18(%ebp),%eax
    1c57:	01 d0                	add    %edx,%eax
    1c59:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1c5c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1c63:	eb 74                	jmp    1cd9 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1c65:	8b 45 14             	mov    0x14(%ebp),%eax
    1c68:	8b 50 18             	mov    0x18(%eax),%edx
    1c6b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1c6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c71:	01 c8                	add    %ecx,%eax
    1c73:	89 c1                	mov    %eax,%ecx
    1c75:	89 c8                	mov    %ecx,%eax
    1c77:	01 c0                	add    %eax,%eax
    1c79:	01 c8                	add    %ecx,%eax
    1c7b:	01 d0                	add    %edx,%eax
    1c7d:	0f b7 10             	movzwl (%eax),%edx
    1c80:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1c84:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1c88:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1c8b:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1c8f:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1c93:	38 c2                	cmp    %al,%dl
    1c95:	75 18                	jne    1caf <APDcCopy+0x154>
    1c97:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1c9b:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1c9f:	38 c2                	cmp    %al,%dl
    1ca1:	75 0c                	jne    1caf <APDcCopy+0x154>
    1ca3:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1ca7:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1cab:	38 c2                	cmp    %al,%dl
    1cad:	74 26                	je     1cd5 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1caf:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb2:	8b 50 18             	mov    0x18(%eax),%edx
    1cb5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1cb8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cbb:	01 c8                	add    %ecx,%eax
    1cbd:	89 c1                	mov    %eax,%ecx
    1cbf:	89 c8                	mov    %ecx,%eax
    1cc1:	01 c0                	add    %eax,%eax
    1cc3:	01 c8                	add    %ecx,%eax
    1cc5:	01 d0                	add    %edx,%eax
    1cc7:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1ccb:	66 89 10             	mov    %dx,(%eax)
    1cce:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1cd2:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1cd5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1cd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1cdc:	2b 45 0c             	sub    0xc(%ebp),%eax
    1cdf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1ce2:	7d 81                	jge    1c65 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1ce4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ce8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ceb:	2b 45 10             	sub    0x10(%ebp),%eax
    1cee:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1cf1:	0f 8d 35 ff ff ff    	jge    1c2c <APDcCopy+0xd1>
    1cf7:	eb 04                	jmp    1cfd <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1cf9:	90                   	nop
    1cfa:	eb 01                	jmp    1cfd <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1cfc:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1cfd:	c9                   	leave  
    1cfe:	c3                   	ret    

00001cff <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1cff:	55                   	push   %ebp
    1d00:	89 e5                	mov    %esp,%ebp
    1d02:	83 ec 1c             	sub    $0x1c,%esp
    1d05:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1d08:	8b 55 10             	mov    0x10(%ebp),%edx
    1d0b:	8b 45 14             	mov    0x14(%ebp),%eax
    1d0e:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1d11:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1d14:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1d17:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1d1b:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1d1e:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1d22:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1d25:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1d29:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1d2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d2f:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1d33:	66 89 10             	mov    %dx,(%eax)
    1d36:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1d3a:	88 50 02             	mov    %dl,0x2(%eax)
}
    1d3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d40:	c9                   	leave  
    1d41:	c2 04 00             	ret    $0x4

00001d44 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1d44:	55                   	push   %ebp
    1d45:	89 e5                	mov    %esp,%ebp
    1d47:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1d4a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d4d:	8b 00                	mov    (%eax),%eax
    1d4f:	83 ec 08             	sub    $0x8,%esp
    1d52:	8d 55 0c             	lea    0xc(%ebp),%edx
    1d55:	52                   	push   %edx
    1d56:	50                   	push   %eax
    1d57:	e8 24 ee ff ff       	call   b80 <sendMessage>
    1d5c:	83 c4 10             	add    $0x10,%esp
}
    1d5f:	90                   	nop
    1d60:	c9                   	leave  
    1d61:	c3                   	ret    

00001d62 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1d62:	55                   	push   %ebp
    1d63:	89 e5                	mov    %esp,%ebp
    1d65:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1d68:	83 ec 0c             	sub    $0xc,%esp
    1d6b:	68 98 00 00 00       	push   $0x98
    1d70:	e8 f5 f1 ff ff       	call   f6a <malloc>
    1d75:	83 c4 10             	add    $0x10,%esp
    1d78:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1d7b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d7f:	75 15                	jne    1d96 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1d81:	83 ec 04             	sub    $0x4,%esp
    1d84:	ff 75 08             	pushl  0x8(%ebp)
    1d87:	68 28 2d 00 00       	push   $0x2d28
    1d8c:	6a 01                	push   $0x1
    1d8e:	e8 04 ef ff ff       	call   c97 <printf>
    1d93:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1d96:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d99:	05 84 00 00 00       	add    $0x84,%eax
    1d9e:	83 ec 08             	sub    $0x8,%esp
    1da1:	ff 75 08             	pushl  0x8(%ebp)
    1da4:	50                   	push   %eax
    1da5:	e8 fd ea ff ff       	call   8a7 <strcpy>
    1daa:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1dad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1db0:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1db7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dba:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1dc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dc4:	8b 40 3c             	mov    0x3c(%eax),%eax
    1dc7:	89 c2                	mov    %eax,%edx
    1dc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dcc:	8b 40 40             	mov    0x40(%eax),%eax
    1dcf:	0f af d0             	imul   %eax,%edx
    1dd2:	89 d0                	mov    %edx,%eax
    1dd4:	01 c0                	add    %eax,%eax
    1dd6:	01 d0                	add    %edx,%eax
    1dd8:	83 ec 0c             	sub    $0xc,%esp
    1ddb:	50                   	push   %eax
    1ddc:	e8 89 f1 ff ff       	call   f6a <malloc>
    1de1:	83 c4 10             	add    $0x10,%esp
    1de4:	89 c2                	mov    %eax,%edx
    1de6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1de9:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1dec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1def:	8b 40 54             	mov    0x54(%eax),%eax
    1df2:	85 c0                	test   %eax,%eax
    1df4:	75 15                	jne    1e0b <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1df6:	83 ec 04             	sub    $0x4,%esp
    1df9:	ff 75 08             	pushl  0x8(%ebp)
    1dfc:	68 48 2d 00 00       	push   $0x2d48
    1e01:	6a 01                	push   $0x1
    1e03:	e8 8f ee ff ff       	call   c97 <printf>
    1e08:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1e0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e0e:	8b 40 3c             	mov    0x3c(%eax),%eax
    1e11:	89 c2                	mov    %eax,%edx
    1e13:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e16:	8b 40 40             	mov    0x40(%eax),%eax
    1e19:	0f af d0             	imul   %eax,%edx
    1e1c:	89 d0                	mov    %edx,%eax
    1e1e:	01 c0                	add    %eax,%eax
    1e20:	01 c2                	add    %eax,%edx
    1e22:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e25:	8b 40 54             	mov    0x54(%eax),%eax
    1e28:	83 ec 04             	sub    $0x4,%esp
    1e2b:	52                   	push   %edx
    1e2c:	68 ff ff ff 00       	push   $0xffffff
    1e31:	50                   	push   %eax
    1e32:	e8 06 eb ff ff       	call   93d <memset>
    1e37:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1e3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e3d:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1e44:	e8 0f ed ff ff       	call   b58 <getpid>
    1e49:	89 c2                	mov    %eax,%edx
    1e4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e4e:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1e51:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e54:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1e5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e5e:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1e65:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e68:	8b 40 58             	mov    0x58(%eax),%eax
    1e6b:	89 c2                	mov    %eax,%edx
    1e6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e70:	8b 40 5c             	mov    0x5c(%eax),%eax
    1e73:	0f af d0             	imul   %eax,%edx
    1e76:	89 d0                	mov    %edx,%eax
    1e78:	01 c0                	add    %eax,%eax
    1e7a:	01 d0                	add    %edx,%eax
    1e7c:	83 ec 0c             	sub    $0xc,%esp
    1e7f:	50                   	push   %eax
    1e80:	e8 e5 f0 ff ff       	call   f6a <malloc>
    1e85:	83 c4 10             	add    $0x10,%esp
    1e88:	89 c2                	mov    %eax,%edx
    1e8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e8d:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1e90:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e93:	8b 40 70             	mov    0x70(%eax),%eax
    1e96:	85 c0                	test   %eax,%eax
    1e98:	75 15                	jne    1eaf <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1e9a:	83 ec 04             	sub    $0x4,%esp
    1e9d:	ff 75 08             	pushl  0x8(%ebp)
    1ea0:	68 6c 2d 00 00       	push   $0x2d6c
    1ea5:	6a 01                	push   $0x1
    1ea7:	e8 eb ed ff ff       	call   c97 <printf>
    1eac:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1eaf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1eb2:	8b 40 3c             	mov    0x3c(%eax),%eax
    1eb5:	89 c2                	mov    %eax,%edx
    1eb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1eba:	8b 40 40             	mov    0x40(%eax),%eax
    1ebd:	0f af d0             	imul   %eax,%edx
    1ec0:	89 d0                	mov    %edx,%eax
    1ec2:	01 c0                	add    %eax,%eax
    1ec4:	01 c2                	add    %eax,%edx
    1ec6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ec9:	8b 40 54             	mov    0x54(%eax),%eax
    1ecc:	83 ec 04             	sub    $0x4,%esp
    1ecf:	52                   	push   %edx
    1ed0:	68 ff 00 00 00       	push   $0xff
    1ed5:	50                   	push   %eax
    1ed6:	e8 62 ea ff ff       	call   93d <memset>
    1edb:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1ede:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ee1:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ee4:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1ee7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1eeb:	74 49                	je     1f36 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1eed:	8b 45 10             	mov    0x10(%ebp),%eax
    1ef0:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1ef6:	83 ec 0c             	sub    $0xc,%esp
    1ef9:	50                   	push   %eax
    1efa:	e8 6b f0 ff ff       	call   f6a <malloc>
    1eff:	83 c4 10             	add    $0x10,%esp
    1f02:	89 c2                	mov    %eax,%edx
    1f04:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f07:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1f0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f0d:	8b 55 10             	mov    0x10(%ebp),%edx
    1f10:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1f13:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f16:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1f1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f20:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1f27:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f2a:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1f31:	e9 8d 00 00 00       	jmp    1fc3 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1f36:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f39:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1f40:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f43:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1f4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f4d:	8b 40 20             	mov    0x20(%eax),%eax
    1f50:	89 c2                	mov    %eax,%edx
    1f52:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f55:	8b 40 24             	mov    0x24(%eax),%eax
    1f58:	0f af d0             	imul   %eax,%edx
    1f5b:	89 d0                	mov    %edx,%eax
    1f5d:	01 c0                	add    %eax,%eax
    1f5f:	01 d0                	add    %edx,%eax
    1f61:	83 ec 0c             	sub    $0xc,%esp
    1f64:	50                   	push   %eax
    1f65:	e8 00 f0 ff ff       	call   f6a <malloc>
    1f6a:	83 c4 10             	add    $0x10,%esp
    1f6d:	89 c2                	mov    %eax,%edx
    1f6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f72:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1f75:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f78:	8b 40 38             	mov    0x38(%eax),%eax
    1f7b:	85 c0                	test   %eax,%eax
    1f7d:	75 15                	jne    1f94 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1f7f:	83 ec 04             	sub    $0x4,%esp
    1f82:	ff 75 08             	pushl  0x8(%ebp)
    1f85:	68 94 2d 00 00       	push   $0x2d94
    1f8a:	6a 01                	push   $0x1
    1f8c:	e8 06 ed ff ff       	call   c97 <printf>
    1f91:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1f94:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f97:	8b 40 20             	mov    0x20(%eax),%eax
    1f9a:	89 c2                	mov    %eax,%edx
    1f9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f9f:	8b 40 24             	mov    0x24(%eax),%eax
    1fa2:	0f af d0             	imul   %eax,%edx
    1fa5:	89 d0                	mov    %edx,%eax
    1fa7:	01 c0                	add    %eax,%eax
    1fa9:	01 c2                	add    %eax,%edx
    1fab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fae:	8b 40 38             	mov    0x38(%eax),%eax
    1fb1:	83 ec 04             	sub    $0x4,%esp
    1fb4:	52                   	push   %edx
    1fb5:	68 ff ff ff 00       	push   $0xffffff
    1fba:	50                   	push   %eax
    1fbb:	e8 7d e9 ff ff       	call   93d <memset>
    1fc0:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1fc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1fc6:	c9                   	leave  
    1fc7:	c3                   	ret    

00001fc8 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1fc8:	55                   	push   %ebp
    1fc9:	89 e5                	mov    %esp,%ebp
    1fcb:	57                   	push   %edi
    1fcc:	56                   	push   %esi
    1fcd:	53                   	push   %ebx
    1fce:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1fd1:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fd4:	83 f8 03             	cmp    $0x3,%eax
    1fd7:	74 02                	je     1fdb <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1fd9:	eb 7c                	jmp    2057 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1fdb:	8b 45 08             	mov    0x8(%ebp),%eax
    1fde:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1fe1:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe4:	8b 48 18             	mov    0x18(%eax),%ecx
    1fe7:	8b 45 08             	mov    0x8(%ebp),%eax
    1fea:	8b 50 5c             	mov    0x5c(%eax),%edx
    1fed:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff0:	8b 40 58             	mov    0x58(%eax),%eax
    1ff3:	8b 75 08             	mov    0x8(%ebp),%esi
    1ff6:	83 c6 58             	add    $0x58,%esi
    1ff9:	83 ec 04             	sub    $0x4,%esp
    1ffc:	53                   	push   %ebx
    1ffd:	51                   	push   %ecx
    1ffe:	6a 00                	push   $0x0
    2000:	52                   	push   %edx
    2001:	50                   	push   %eax
    2002:	6a 00                	push   $0x0
    2004:	6a 00                	push   $0x0
    2006:	56                   	push   %esi
    2007:	6a 00                	push   $0x0
    2009:	6a 00                	push   $0x0
    200b:	ff 75 08             	pushl  0x8(%ebp)
    200e:	e8 65 eb ff ff       	call   b78 <paintWindow>
    2013:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    2016:	8b 45 08             	mov    0x8(%ebp),%eax
    2019:	8b 70 1c             	mov    0x1c(%eax),%esi
    201c:	8b 45 08             	mov    0x8(%ebp),%eax
    201f:	8b 58 18             	mov    0x18(%eax),%ebx
    2022:	8b 45 08             	mov    0x8(%ebp),%eax
    2025:	8b 48 08             	mov    0x8(%eax),%ecx
    2028:	8b 45 08             	mov    0x8(%ebp),%eax
    202b:	8b 50 40             	mov    0x40(%eax),%edx
    202e:	8b 45 08             	mov    0x8(%ebp),%eax
    2031:	8b 40 3c             	mov    0x3c(%eax),%eax
    2034:	8b 7d 08             	mov    0x8(%ebp),%edi
    2037:	83 c7 3c             	add    $0x3c,%edi
    203a:	83 ec 04             	sub    $0x4,%esp
    203d:	56                   	push   %esi
    203e:	53                   	push   %ebx
    203f:	51                   	push   %ecx
    2040:	52                   	push   %edx
    2041:	50                   	push   %eax
    2042:	6a 00                	push   $0x0
    2044:	6a 00                	push   $0x0
    2046:	57                   	push   %edi
    2047:	6a 32                	push   $0x32
    2049:	6a 00                	push   $0x0
    204b:	ff 75 08             	pushl  0x8(%ebp)
    204e:	e8 25 eb ff ff       	call   b78 <paintWindow>
    2053:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    2056:	90                   	nop
        default: break;
            
            
    }
    return False;
    2057:	b8 00 00 00 00       	mov    $0x0,%eax
}
    205c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    205f:	5b                   	pop    %ebx
    2060:	5e                   	pop    %esi
    2061:	5f                   	pop    %edi
    2062:	5d                   	pop    %ebp
    2063:	c3                   	ret    

00002064 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    2064:	55                   	push   %ebp
    2065:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    2067:	8b 45 0c             	mov    0xc(%ebp),%eax
    206a:	8b 50 08             	mov    0x8(%eax),%edx
    206d:	8b 45 08             	mov    0x8(%ebp),%eax
    2070:	8b 00                	mov    (%eax),%eax
    2072:	39 c2                	cmp    %eax,%edx
    2074:	74 07                	je     207d <APPreJudge+0x19>
        return False;
    2076:	b8 00 00 00 00       	mov    $0x0,%eax
    207b:	eb 05                	jmp    2082 <APPreJudge+0x1e>
    return True;
    207d:	b8 01 00 00 00       	mov    $0x1,%eax
}
    2082:	5d                   	pop    %ebp
    2083:	c3                   	ret    

00002084 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    2084:	55                   	push   %ebp
    2085:	89 e5                	mov    %esp,%ebp
    2087:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    208a:	8b 45 08             	mov    0x8(%ebp),%eax
    208d:	8b 55 0c             	mov    0xc(%ebp),%edx
    2090:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    2096:	83 ec 0c             	sub    $0xc,%esp
    2099:	ff 75 08             	pushl  0x8(%ebp)
    209c:	e8 ef ea ff ff       	call   b90 <registWindow>
    20a1:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    20a4:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    20ab:	8b 45 08             	mov    0x8(%ebp),%eax
    20ae:	8b 00                	mov    (%eax),%eax
    20b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    20b3:	ff 75 f4             	pushl  -0xc(%ebp)
    20b6:	ff 75 f0             	pushl  -0x10(%ebp)
    20b9:	ff 75 ec             	pushl  -0x14(%ebp)
    20bc:	ff 75 08             	pushl  0x8(%ebp)
    20bf:	e8 80 fc ff ff       	call   1d44 <APSendMessage>
    20c4:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    20c7:	83 ec 0c             	sub    $0xc,%esp
    20ca:	ff 75 08             	pushl  0x8(%ebp)
    20cd:	e8 b6 ea ff ff       	call   b88 <getMessage>
    20d2:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    20d5:	8b 45 08             	mov    0x8(%ebp),%eax
    20d8:	83 c0 74             	add    $0x74,%eax
    20db:	83 ec 08             	sub    $0x8,%esp
    20de:	50                   	push   %eax
    20df:	ff 75 08             	pushl  0x8(%ebp)
    20e2:	e8 7d ff ff ff       	call   2064 <APPreJudge>
    20e7:	83 c4 10             	add    $0x10,%esp
    20ea:	84 c0                	test   %al,%al
    20ec:	74 1b                	je     2109 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    20ee:	8b 45 08             	mov    0x8(%ebp),%eax
    20f1:	ff 70 7c             	pushl  0x7c(%eax)
    20f4:	ff 70 78             	pushl  0x78(%eax)
    20f7:	ff 70 74             	pushl  0x74(%eax)
    20fa:	ff 75 08             	pushl  0x8(%ebp)
    20fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    2100:	ff d0                	call   *%eax
    2102:	83 c4 10             	add    $0x10,%esp
    2105:	84 c0                	test   %al,%al
    2107:	75 0c                	jne    2115 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    2109:	8b 45 08             	mov    0x8(%ebp),%eax
    210c:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    2113:	eb b2                	jmp    20c7 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    2115:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    2116:	90                   	nop
    2117:	c9                   	leave  
    2118:	c3                   	ret    

00002119 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    2119:	55                   	push   %ebp
    211a:	89 e5                	mov    %esp,%ebp
    211c:	57                   	push   %edi
    211d:	56                   	push   %esi
    211e:	53                   	push   %ebx
    211f:	83 ec 7c             	sub    $0x7c,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    2122:	8d 45 88             	lea    -0x78(%ebp),%eax
    2125:	6a 08                	push   $0x8
    2127:	6a 08                	push   $0x8
    2129:	6a 08                	push   $0x8
    212b:	50                   	push   %eax
    212c:	e8 ce fb ff ff       	call   1cff <RGB>
    2131:	83 c4 0c             	add    $0xc,%esp
    2134:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2138:	66 89 45 bd          	mov    %ax,-0x43(%ebp)
    213c:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2140:	88 45 bf             	mov    %al,-0x41(%ebp)
    APSetFont(&wnd->TitleDc,font);
    2143:	8b 45 08             	mov    0x8(%ebp),%eax
    2146:	8d 58 58             	lea    0x58(%eax),%ebx
    2149:	8d 55 88             	lea    -0x78(%ebp),%edx
    214c:	83 ec 04             	sub    $0x4,%esp
    214f:	83 ec 04             	sub    $0x4,%esp
    2152:	89 e0                	mov    %esp,%eax
    2154:	0f b7 4d bd          	movzwl -0x43(%ebp),%ecx
    2158:	66 89 08             	mov    %cx,(%eax)
    215b:	0f b6 4d bf          	movzbl -0x41(%ebp),%ecx
    215f:	88 48 02             	mov    %cl,0x2(%eax)
    2162:	53                   	push   %ebx
    2163:	52                   	push   %edx
    2164:	e8 fe f2 ff ff       	call   1467 <APSetFont>
    2169:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    216c:	8b 45 08             	mov    0x8(%ebp),%eax
    216f:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    2175:	8b 45 08             	mov    0x8(%ebp),%eax
    2178:	83 c0 58             	add    $0x58,%eax
    217b:	6a 14                	push   $0x14
    217d:	6a 14                	push   $0x14
    217f:	52                   	push   %edx
    2180:	50                   	push   %eax
    2181:	e8 ce f8 ff ff       	call   1a54 <APDrawText>
    2186:	83 c4 10             	add    $0x10,%esp
    
    if (!iconReady)
    2189:	a1 cc 71 00 00       	mov    0x71cc,%eax
    218e:	85 c0                	test   %eax,%eax
    2190:	0f 85 7a 02 00 00    	jne    2410 <APGridPaint+0x2f7>
    {
        iconReady = 1;
    2196:	c7 05 cc 71 00 00 01 	movl   $0x1,0x71cc
    219d:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    21a0:	8d 45 88             	lea    -0x78(%ebp),%eax
    21a3:	83 ec 08             	sub    $0x8,%esp
    21a6:	68 bb 2d 00 00       	push   $0x2dbb
    21ab:	50                   	push   %eax
    21ac:	e8 6c ef ff ff       	call   111d <APLoadBitmap>
    21b1:	83 c4 0c             	add    $0xc,%esp
    21b4:	8b 45 88             	mov    -0x78(%ebp),%eax
    21b7:	a3 c4 b6 00 00       	mov    %eax,0xb6c4
    21bc:	8b 45 8c             	mov    -0x74(%ebp),%eax
    21bf:	a3 c8 b6 00 00       	mov    %eax,0xb6c8
    21c4:	8b 45 90             	mov    -0x70(%ebp),%eax
    21c7:	a3 cc b6 00 00       	mov    %eax,0xb6cc
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    21cc:	83 ec 04             	sub    $0x4,%esp
    21cf:	ff 35 cc b6 00 00    	pushl  0xb6cc
    21d5:	ff 35 c8 b6 00 00    	pushl  0xb6c8
    21db:	ff 35 c4 b6 00 00    	pushl  0xb6c4
    21e1:	e8 71 f1 ff ff       	call   1357 <APCreateCompatibleDCFromBitmap>
    21e6:	83 c4 10             	add    $0x10,%esp
    21e9:	a3 d8 b6 00 00       	mov    %eax,0xb6d8
        grid_river = APLoadBitmap ("grid_river.bmp");
    21ee:	8d 45 88             	lea    -0x78(%ebp),%eax
    21f1:	83 ec 08             	sub    $0x8,%esp
    21f4:	68 c9 2d 00 00       	push   $0x2dc9
    21f9:	50                   	push   %eax
    21fa:	e8 1e ef ff ff       	call   111d <APLoadBitmap>
    21ff:	83 c4 0c             	add    $0xc,%esp
    2202:	8b 45 88             	mov    -0x78(%ebp),%eax
    2205:	a3 6c c8 00 00       	mov    %eax,0xc86c
    220a:	8b 45 8c             	mov    -0x74(%ebp),%eax
    220d:	a3 70 c8 00 00       	mov    %eax,0xc870
    2212:	8b 45 90             	mov    -0x70(%ebp),%eax
    2215:	a3 74 c8 00 00       	mov    %eax,0xc874
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    221a:	83 ec 04             	sub    $0x4,%esp
    221d:	ff 35 74 c8 00 00    	pushl  0xc874
    2223:	ff 35 70 c8 00 00    	pushl  0xc870
    2229:	ff 35 6c c8 00 00    	pushl  0xc86c
    222f:	e8 23 f1 ff ff       	call   1357 <APCreateCompatibleDCFromBitmap>
    2234:	83 c4 10             	add    $0x10,%esp
    2237:	a3 5c c8 00 00       	mov    %eax,0xc85c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    223c:	8d 45 88             	lea    -0x78(%ebp),%eax
    223f:	83 ec 08             	sub    $0x8,%esp
    2242:	68 d8 2d 00 00       	push   $0x2dd8
    2247:	50                   	push   %eax
    2248:	e8 d0 ee ff ff       	call   111d <APLoadBitmap>
    224d:	83 c4 0c             	add    $0xc,%esp
    2250:	8b 45 88             	mov    -0x78(%ebp),%eax
    2253:	a3 60 c8 00 00       	mov    %eax,0xc860
    2258:	8b 45 8c             	mov    -0x74(%ebp),%eax
    225b:	a3 64 c8 00 00       	mov    %eax,0xc864
    2260:	8b 45 90             	mov    -0x70(%ebp),%eax
    2263:	a3 68 c8 00 00       	mov    %eax,0xc868
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    2268:	83 ec 04             	sub    $0x4,%esp
    226b:	ff 35 68 c8 00 00    	pushl  0xc868
    2271:	ff 35 64 c8 00 00    	pushl  0xc864
    2277:	ff 35 60 c8 00 00    	pushl  0xc860
    227d:	e8 d5 f0 ff ff       	call   1357 <APCreateCompatibleDCFromBitmap>
    2282:	83 c4 10             	add    $0x10,%esp
    2285:	a3 a4 b6 00 00       	mov    %eax,0xb6a4
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    228a:	8d 45 88             	lea    -0x78(%ebp),%eax
    228d:	83 ec 08             	sub    $0x8,%esp
    2290:	68 e7 2d 00 00       	push   $0x2de7
    2295:	50                   	push   %eax
    2296:	e8 82 ee ff ff       	call   111d <APLoadBitmap>
    229b:	83 c4 0c             	add    $0xc,%esp
    229e:	8b 45 88             	mov    -0x78(%ebp),%eax
    22a1:	a3 e0 b6 00 00       	mov    %eax,0xb6e0
    22a6:	8b 45 8c             	mov    -0x74(%ebp),%eax
    22a9:	a3 e4 b6 00 00       	mov    %eax,0xb6e4
    22ae:	8b 45 90             	mov    -0x70(%ebp),%eax
    22b1:	a3 e8 b6 00 00       	mov    %eax,0xb6e8
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    22b6:	83 ec 04             	sub    $0x4,%esp
    22b9:	ff 35 e8 b6 00 00    	pushl  0xb6e8
    22bf:	ff 35 e4 b6 00 00    	pushl  0xb6e4
    22c5:	ff 35 e0 b6 00 00    	pushl  0xb6e0
    22cb:	e8 87 f0 ff ff       	call   1357 <APCreateCompatibleDCFromBitmap>
    22d0:	83 c4 10             	add    $0x10,%esp
    22d3:	a3 7c c8 00 00       	mov    %eax,0xc87c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    22d8:	8d 45 88             	lea    -0x78(%ebp),%eax
    22db:	83 ec 08             	sub    $0x8,%esp
    22de:	68 f5 2d 00 00       	push   $0x2df5
    22e3:	50                   	push   %eax
    22e4:	e8 34 ee ff ff       	call   111d <APLoadBitmap>
    22e9:	83 c4 0c             	add    $0xc,%esp
    22ec:	8b 45 88             	mov    -0x78(%ebp),%eax
    22ef:	a3 b4 b6 00 00       	mov    %eax,0xb6b4
    22f4:	8b 45 8c             	mov    -0x74(%ebp),%eax
    22f7:	a3 b8 b6 00 00       	mov    %eax,0xb6b8
    22fc:	8b 45 90             	mov    -0x70(%ebp),%eax
    22ff:	a3 bc b6 00 00       	mov    %eax,0xb6bc
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    2304:	83 ec 04             	sub    $0x4,%esp
    2307:	ff 35 bc b6 00 00    	pushl  0xb6bc
    230d:	ff 35 b8 b6 00 00    	pushl  0xb6b8
    2313:	ff 35 b4 b6 00 00    	pushl  0xb6b4
    2319:	e8 39 f0 ff ff       	call   1357 <APCreateCompatibleDCFromBitmap>
    231e:	83 c4 10             	add    $0x10,%esp
    2321:	a3 dc b6 00 00       	mov    %eax,0xb6dc
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    2326:	8d 45 88             	lea    -0x78(%ebp),%eax
    2329:	83 ec 08             	sub    $0x8,%esp
    232c:	68 05 2e 00 00       	push   $0x2e05
    2331:	50                   	push   %eax
    2332:	e8 e6 ed ff ff       	call   111d <APLoadBitmap>
    2337:	83 c4 0c             	add    $0xc,%esp
    233a:	8b 45 88             	mov    -0x78(%ebp),%eax
    233d:	a3 a8 b6 00 00       	mov    %eax,0xb6a8
    2342:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2345:	a3 ac b6 00 00       	mov    %eax,0xb6ac
    234a:	8b 45 90             	mov    -0x70(%ebp),%eax
    234d:	a3 b0 b6 00 00       	mov    %eax,0xb6b0
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    2352:	83 ec 04             	sub    $0x4,%esp
    2355:	ff 35 b0 b6 00 00    	pushl  0xb6b0
    235b:	ff 35 ac b6 00 00    	pushl  0xb6ac
    2361:	ff 35 a8 b6 00 00    	pushl  0xb6a8
    2367:	e8 eb ef ff ff       	call   1357 <APCreateCompatibleDCFromBitmap>
    236c:	83 c4 10             	add    $0x10,%esp
    236f:	a3 c0 b6 00 00       	mov    %eax,0xb6c0
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    2374:	8d 45 88             	lea    -0x78(%ebp),%eax
    2377:	83 ec 08             	sub    $0x8,%esp
    237a:	68 17 2e 00 00       	push   $0x2e17
    237f:	50                   	push   %eax
    2380:	e8 98 ed ff ff       	call   111d <APLoadBitmap>
    2385:	83 c4 0c             	add    $0xc,%esp
    2388:	8b 45 88             	mov    -0x78(%ebp),%eax
    238b:	a3 50 c8 00 00       	mov    %eax,0xc850
    2390:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2393:	a3 54 c8 00 00       	mov    %eax,0xc854
    2398:	8b 45 90             	mov    -0x70(%ebp),%eax
    239b:	a3 58 c8 00 00       	mov    %eax,0xc858
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    23a0:	83 ec 04             	sub    $0x4,%esp
    23a3:	ff 35 58 c8 00 00    	pushl  0xc858
    23a9:	ff 35 54 c8 00 00    	pushl  0xc854
    23af:	ff 35 50 c8 00 00    	pushl  0xc850
    23b5:	e8 9d ef ff ff       	call   1357 <APCreateCompatibleDCFromBitmap>
    23ba:	83 c4 10             	add    $0x10,%esp
    23bd:	a3 80 c8 00 00       	mov    %eax,0xc880
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    23c2:	8d 45 88             	lea    -0x78(%ebp),%eax
    23c5:	83 ec 08             	sub    $0x8,%esp
    23c8:	68 26 2e 00 00       	push   $0x2e26
    23cd:	50                   	push   %eax
    23ce:	e8 4a ed ff ff       	call   111d <APLoadBitmap>
    23d3:	83 c4 0c             	add    $0xc,%esp
    23d6:	8b 45 88             	mov    -0x78(%ebp),%eax
    23d9:	a3 f4 b6 00 00       	mov    %eax,0xb6f4
    23de:	8b 45 8c             	mov    -0x74(%ebp),%eax
    23e1:	a3 f8 b6 00 00       	mov    %eax,0xb6f8
    23e6:	8b 45 90             	mov    -0x70(%ebp),%eax
    23e9:	a3 fc b6 00 00       	mov    %eax,0xb6fc
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    23ee:	83 ec 04             	sub    $0x4,%esp
    23f1:	ff 35 fc b6 00 00    	pushl  0xb6fc
    23f7:	ff 35 f8 b6 00 00    	pushl  0xb6f8
    23fd:	ff 35 f4 b6 00 00    	pushl  0xb6f4
    2403:	e8 4f ef ff ff       	call   1357 <APCreateCompatibleDCFromBitmap>
    2408:	83 c4 10             	add    $0x10,%esp
    240b:	a3 78 c8 00 00       	mov    %eax,0xc878
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    2410:	8b 45 08             	mov    0x8(%ebp),%eax
    2413:	8b 40 08             	mov    0x8(%eax),%eax
    2416:	85 c0                	test   %eax,%eax
    2418:	75 17                	jne    2431 <APGridPaint+0x318>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    241a:	83 ec 08             	sub    $0x8,%esp
    241d:	68 38 2e 00 00       	push   $0x2e38
    2422:	6a 01                	push   $0x1
    2424:	e8 6e e8 ff ff       	call   c97 <printf>
    2429:	83 c4 10             	add    $0x10,%esp
        return;
    242c:	e9 fe 04 00 00       	jmp    292f <APGridPaint+0x816>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    2431:	8b 45 08             	mov    0x8(%ebp),%eax
    2434:	8b 40 10             	mov    0x10(%eax),%eax
    2437:	85 c0                	test   %eax,%eax
    2439:	7e 10                	jle    244b <APGridPaint+0x332>
    243b:	8b 45 08             	mov    0x8(%ebp),%eax
    243e:	8b 50 14             	mov    0x14(%eax),%edx
    2441:	8b 45 08             	mov    0x8(%ebp),%eax
    2444:	8b 40 10             	mov    0x10(%eax),%eax
    2447:	39 c2                	cmp    %eax,%edx
    2449:	7c 17                	jl     2462 <APGridPaint+0x349>
    {
        printf(1,"Grid mode page error!");
    244b:	83 ec 08             	sub    $0x8,%esp
    244e:	68 5e 2e 00 00       	push   $0x2e5e
    2453:	6a 01                	push   $0x1
    2455:	e8 3d e8 ff ff       	call   c97 <printf>
    245a:	83 c4 10             	add    $0x10,%esp
        return;
    245d:	e9 cd 04 00 00       	jmp    292f <APGridPaint+0x816>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    2462:	8b 45 08             	mov    0x8(%ebp),%eax
    2465:	8b 40 14             	mov    0x14(%eax),%eax
    2468:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    246e:	89 45 dc             	mov    %eax,-0x24(%ebp)
    2471:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2474:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2477:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    247e:	e9 f4 03 00 00       	jmp    2877 <APGridPaint+0x75e>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2483:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    248a:	e9 da 03 00 00       	jmp    2869 <APGridPaint+0x750>
        {
            index = start + GRID_W_NUMBER * j + i;
    248f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2492:	c1 e0 04             	shl    $0x4,%eax
    2495:	89 c2                	mov    %eax,%edx
    2497:	8b 45 d8             	mov    -0x28(%ebp),%eax
    249a:	01 c2                	add    %eax,%edx
    249c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    249f:	01 d0                	add    %edx,%eax
    24a1:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    24a4:	8b 45 08             	mov    0x8(%ebp),%eax
    24a7:	8b 40 0c             	mov    0xc(%eax),%eax
    24aa:	8b 55 dc             	mov    -0x24(%ebp),%edx
    24ad:	c1 e2 02             	shl    $0x2,%edx
    24b0:	01 d0                	add    %edx,%eax
    24b2:	8b 00                	mov    (%eax),%eax
    24b4:	83 f8 0a             	cmp    $0xa,%eax
    24b7:	0f 87 a7 03 00 00    	ja     2864 <APGridPaint+0x74b>
    24bd:	8b 04 85 74 2e 00 00 	mov    0x2e74(,%eax,4),%eax
    24c4:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    24c6:	8d 45 c0             	lea    -0x40(%ebp),%eax
    24c9:	6a 0c                	push   $0xc
    24cb:	6a 0c                	push   $0xc
    24cd:	6a 0c                	push   $0xc
    24cf:	50                   	push   %eax
    24d0:	e8 2a f8 ff ff       	call   1cff <RGB>
    24d5:	83 c4 0c             	add    $0xc,%esp
    24d8:	8b 1d d8 b6 00 00    	mov    0xb6d8,%ebx
    24de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24e1:	6b c8 32             	imul   $0x32,%eax,%ecx
    24e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    24e7:	6b c0 32             	imul   $0x32,%eax,%eax
    24ea:	89 45 84             	mov    %eax,-0x7c(%ebp)
    24ed:	8b 45 08             	mov    0x8(%ebp),%eax
    24f0:	8d 78 3c             	lea    0x3c(%eax),%edi
    24f3:	83 ec 0c             	sub    $0xc,%esp
    24f6:	83 ec 04             	sub    $0x4,%esp
    24f9:	89 e0                	mov    %esp,%eax
    24fb:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    24ff:	66 89 30             	mov    %si,(%eax)
    2502:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    2506:	88 50 02             	mov    %dl,0x2(%eax)
    2509:	6a 32                	push   $0x32
    250b:	6a 32                	push   $0x32
    250d:	6a 00                	push   $0x0
    250f:	6a 00                	push   $0x0
    2511:	53                   	push   %ebx
    2512:	51                   	push   %ecx
    2513:	ff 75 84             	pushl  -0x7c(%ebp)
    2516:	57                   	push   %edi
    2517:	e8 3f f6 ff ff       	call   1b5b <APDcCopy>
    251c:	83 c4 30             	add    $0x30,%esp
                    break;
    251f:	e9 41 03 00 00       	jmp    2865 <APGridPaint+0x74c>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    2524:	8d 45 88             	lea    -0x78(%ebp),%eax
    2527:	6a 69                	push   $0x69
    2529:	6a 69                	push   $0x69
    252b:	6a 69                	push   $0x69
    252d:	50                   	push   %eax
    252e:	e8 cc f7 ff ff       	call   1cff <RGB>
    2533:	83 c4 0c             	add    $0xc,%esp
    2536:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    253a:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    253e:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2542:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    2545:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    254c:	8d 45 88             	lea    -0x78(%ebp),%eax
    254f:	6a 69                	push   $0x69
    2551:	6a 69                	push   $0x69
    2553:	6a 69                	push   $0x69
    2555:	50                   	push   %eax
    2556:	e8 a4 f7 ff ff       	call   1cff <RGB>
    255b:	83 c4 0c             	add    $0xc,%esp
    255e:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2562:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    2566:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    256a:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    256d:	8b 45 08             	mov    0x8(%ebp),%eax
    2570:	8d 50 3c             	lea    0x3c(%eax),%edx
    2573:	8d 45 88             	lea    -0x78(%ebp),%eax
    2576:	ff 75 ac             	pushl  -0x54(%ebp)
    2579:	ff 75 a8             	pushl  -0x58(%ebp)
    257c:	52                   	push   %edx
    257d:	50                   	push   %eax
    257e:	e8 69 ee ff ff       	call   13ec <APSetPen>
    2583:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    2586:	8b 45 08             	mov    0x8(%ebp),%eax
    2589:	8d 58 3c             	lea    0x3c(%eax),%ebx
    258c:	8d 55 88             	lea    -0x78(%ebp),%edx
    258f:	83 ec 04             	sub    $0x4,%esp
    2592:	83 ec 04             	sub    $0x4,%esp
    2595:	89 e0                	mov    %esp,%eax
    2597:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    259b:	66 89 08             	mov    %cx,(%eax)
    259e:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    25a2:	88 48 02             	mov    %cl,0x2(%eax)
    25a5:	53                   	push   %ebx
    25a6:	52                   	push   %edx
    25a7:	e8 79 ee ff ff       	call   1425 <APSetBrush>
    25ac:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    25af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    25b2:	6b d0 32             	imul   $0x32,%eax,%edx
    25b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    25b8:	6b c0 32             	imul   $0x32,%eax,%eax
    25bb:	8b 4d 08             	mov    0x8(%ebp),%ecx
    25be:	83 c1 3c             	add    $0x3c,%ecx
    25c1:	83 ec 0c             	sub    $0xc,%esp
    25c4:	6a 32                	push   $0x32
    25c6:	6a 32                	push   $0x32
    25c8:	52                   	push   %edx
    25c9:	50                   	push   %eax
    25ca:	51                   	push   %ecx
    25cb:	e8 7f f2 ff ff       	call   184f <APDrawRect>
    25d0:	83 c4 20             	add    $0x20,%esp
                    break;
    25d3:	e9 8d 02 00 00       	jmp    2865 <APGridPaint+0x74c>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    25d8:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    25db:	6a 0c                	push   $0xc
    25dd:	6a 0c                	push   $0xc
    25df:	6a 0c                	push   $0xc
    25e1:	50                   	push   %eax
    25e2:	e8 18 f7 ff ff       	call   1cff <RGB>
    25e7:	83 c4 0c             	add    $0xc,%esp
    25ea:	8b 1d 80 c8 00 00    	mov    0xc880,%ebx
    25f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    25f3:	6b c8 32             	imul   $0x32,%eax,%ecx
    25f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    25f9:	6b c0 32             	imul   $0x32,%eax,%eax
    25fc:	89 45 84             	mov    %eax,-0x7c(%ebp)
    25ff:	8b 45 08             	mov    0x8(%ebp),%eax
    2602:	8d 78 3c             	lea    0x3c(%eax),%edi
    2605:	83 ec 0c             	sub    $0xc,%esp
    2608:	83 ec 04             	sub    $0x4,%esp
    260b:	89 e0                	mov    %esp,%eax
    260d:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    2611:	66 89 30             	mov    %si,(%eax)
    2614:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    2618:	88 50 02             	mov    %dl,0x2(%eax)
    261b:	6a 32                	push   $0x32
    261d:	6a 32                	push   $0x32
    261f:	6a 00                	push   $0x0
    2621:	6a 00                	push   $0x0
    2623:	53                   	push   %ebx
    2624:	51                   	push   %ecx
    2625:	ff 75 84             	pushl  -0x7c(%ebp)
    2628:	57                   	push   %edi
    2629:	e8 2d f5 ff ff       	call   1b5b <APDcCopy>
    262e:	83 c4 30             	add    $0x30,%esp
                    break;
    2631:	e9 2f 02 00 00       	jmp    2865 <APGridPaint+0x74c>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2636:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    2639:	6a 0c                	push   $0xc
    263b:	6a 0c                	push   $0xc
    263d:	6a 0c                	push   $0xc
    263f:	50                   	push   %eax
    2640:	e8 ba f6 ff ff       	call   1cff <RGB>
    2645:	83 c4 0c             	add    $0xc,%esp
    2648:	8b 1d 5c c8 00 00    	mov    0xc85c,%ebx
    264e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2651:	6b c8 32             	imul   $0x32,%eax,%ecx
    2654:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2657:	6b c0 32             	imul   $0x32,%eax,%eax
    265a:	89 45 84             	mov    %eax,-0x7c(%ebp)
    265d:	8b 45 08             	mov    0x8(%ebp),%eax
    2660:	8d 78 3c             	lea    0x3c(%eax),%edi
    2663:	83 ec 0c             	sub    $0xc,%esp
    2666:	83 ec 04             	sub    $0x4,%esp
    2669:	89 e0                	mov    %esp,%eax
    266b:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    266f:	66 89 30             	mov    %si,(%eax)
    2672:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    2676:	88 50 02             	mov    %dl,0x2(%eax)
    2679:	6a 32                	push   $0x32
    267b:	6a 32                	push   $0x32
    267d:	6a 00                	push   $0x0
    267f:	6a 00                	push   $0x0
    2681:	53                   	push   %ebx
    2682:	51                   	push   %ecx
    2683:	ff 75 84             	pushl  -0x7c(%ebp)
    2686:	57                   	push   %edi
    2687:	e8 cf f4 ff ff       	call   1b5b <APDcCopy>
    268c:	83 c4 30             	add    $0x30,%esp
                    break;
    268f:	e9 d1 01 00 00       	jmp    2865 <APGridPaint+0x74c>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2694:	8d 45 c9             	lea    -0x37(%ebp),%eax
    2697:	6a 0c                	push   $0xc
    2699:	6a 0c                	push   $0xc
    269b:	6a 0c                	push   $0xc
    269d:	50                   	push   %eax
    269e:	e8 5c f6 ff ff       	call   1cff <RGB>
    26a3:	83 c4 0c             	add    $0xc,%esp
    26a6:	8b 1d dc b6 00 00    	mov    0xb6dc,%ebx
    26ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    26af:	6b c8 32             	imul   $0x32,%eax,%ecx
    26b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    26b5:	6b c0 32             	imul   $0x32,%eax,%eax
    26b8:	89 45 84             	mov    %eax,-0x7c(%ebp)
    26bb:	8b 45 08             	mov    0x8(%ebp),%eax
    26be:	8d 78 3c             	lea    0x3c(%eax),%edi
    26c1:	83 ec 0c             	sub    $0xc,%esp
    26c4:	83 ec 04             	sub    $0x4,%esp
    26c7:	89 e0                	mov    %esp,%eax
    26c9:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    26cd:	66 89 30             	mov    %si,(%eax)
    26d0:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    26d4:	88 50 02             	mov    %dl,0x2(%eax)
    26d7:	6a 32                	push   $0x32
    26d9:	6a 32                	push   $0x32
    26db:	6a 00                	push   $0x0
    26dd:	6a 00                	push   $0x0
    26df:	53                   	push   %ebx
    26e0:	51                   	push   %ecx
    26e1:	ff 75 84             	pushl  -0x7c(%ebp)
    26e4:	57                   	push   %edi
    26e5:	e8 71 f4 ff ff       	call   1b5b <APDcCopy>
    26ea:	83 c4 30             	add    $0x30,%esp
                    break;
    26ed:	e9 73 01 00 00       	jmp    2865 <APGridPaint+0x74c>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    26f2:	8d 45 cc             	lea    -0x34(%ebp),%eax
    26f5:	6a 0c                	push   $0xc
    26f7:	6a 0c                	push   $0xc
    26f9:	6a 0c                	push   $0xc
    26fb:	50                   	push   %eax
    26fc:	e8 fe f5 ff ff       	call   1cff <RGB>
    2701:	83 c4 0c             	add    $0xc,%esp
    2704:	8b 1d 7c c8 00 00    	mov    0xc87c,%ebx
    270a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    270d:	6b c8 32             	imul   $0x32,%eax,%ecx
    2710:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2713:	6b c0 32             	imul   $0x32,%eax,%eax
    2716:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2719:	8b 45 08             	mov    0x8(%ebp),%eax
    271c:	8d 78 3c             	lea    0x3c(%eax),%edi
    271f:	83 ec 0c             	sub    $0xc,%esp
    2722:	83 ec 04             	sub    $0x4,%esp
    2725:	89 e0                	mov    %esp,%eax
    2727:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    272b:	66 89 30             	mov    %si,(%eax)
    272e:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    2732:	88 50 02             	mov    %dl,0x2(%eax)
    2735:	6a 32                	push   $0x32
    2737:	6a 32                	push   $0x32
    2739:	6a 00                	push   $0x0
    273b:	6a 00                	push   $0x0
    273d:	53                   	push   %ebx
    273e:	51                   	push   %ecx
    273f:	ff 75 84             	pushl  -0x7c(%ebp)
    2742:	57                   	push   %edi
    2743:	e8 13 f4 ff ff       	call   1b5b <APDcCopy>
    2748:	83 c4 30             	add    $0x30,%esp
                    break;
    274b:	e9 15 01 00 00       	jmp    2865 <APGridPaint+0x74c>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2750:	8d 45 cf             	lea    -0x31(%ebp),%eax
    2753:	6a 0c                	push   $0xc
    2755:	6a 0c                	push   $0xc
    2757:	6a 0c                	push   $0xc
    2759:	50                   	push   %eax
    275a:	e8 a0 f5 ff ff       	call   1cff <RGB>
    275f:	83 c4 0c             	add    $0xc,%esp
    2762:	8b 1d a4 b6 00 00    	mov    0xb6a4,%ebx
    2768:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    276b:	6b c8 32             	imul   $0x32,%eax,%ecx
    276e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2771:	6b c0 32             	imul   $0x32,%eax,%eax
    2774:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2777:	8b 45 08             	mov    0x8(%ebp),%eax
    277a:	8d 78 3c             	lea    0x3c(%eax),%edi
    277d:	83 ec 0c             	sub    $0xc,%esp
    2780:	83 ec 04             	sub    $0x4,%esp
    2783:	89 e0                	mov    %esp,%eax
    2785:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2789:	66 89 30             	mov    %si,(%eax)
    278c:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2790:	88 50 02             	mov    %dl,0x2(%eax)
    2793:	6a 32                	push   $0x32
    2795:	6a 32                	push   $0x32
    2797:	6a 00                	push   $0x0
    2799:	6a 00                	push   $0x0
    279b:	53                   	push   %ebx
    279c:	51                   	push   %ecx
    279d:	ff 75 84             	pushl  -0x7c(%ebp)
    27a0:	57                   	push   %edi
    27a1:	e8 b5 f3 ff ff       	call   1b5b <APDcCopy>
    27a6:	83 c4 30             	add    $0x30,%esp
                    break;
    27a9:	e9 b7 00 00 00       	jmp    2865 <APGridPaint+0x74c>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    27ae:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    27b1:	6a 0c                	push   $0xc
    27b3:	6a 0c                	push   $0xc
    27b5:	6a 0c                	push   $0xc
    27b7:	50                   	push   %eax
    27b8:	e8 42 f5 ff ff       	call   1cff <RGB>
    27bd:	83 c4 0c             	add    $0xc,%esp
    27c0:	8b 1d c0 b6 00 00    	mov    0xb6c0,%ebx
    27c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    27c9:	6b c8 32             	imul   $0x32,%eax,%ecx
    27cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    27cf:	6b c0 32             	imul   $0x32,%eax,%eax
    27d2:	89 45 84             	mov    %eax,-0x7c(%ebp)
    27d5:	8b 45 08             	mov    0x8(%ebp),%eax
    27d8:	8d 78 3c             	lea    0x3c(%eax),%edi
    27db:	83 ec 0c             	sub    $0xc,%esp
    27de:	83 ec 04             	sub    $0x4,%esp
    27e1:	89 e0                	mov    %esp,%eax
    27e3:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    27e7:	66 89 30             	mov    %si,(%eax)
    27ea:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    27ee:	88 50 02             	mov    %dl,0x2(%eax)
    27f1:	6a 32                	push   $0x32
    27f3:	6a 32                	push   $0x32
    27f5:	6a 00                	push   $0x0
    27f7:	6a 00                	push   $0x0
    27f9:	53                   	push   %ebx
    27fa:	51                   	push   %ecx
    27fb:	ff 75 84             	pushl  -0x7c(%ebp)
    27fe:	57                   	push   %edi
    27ff:	e8 57 f3 ff ff       	call   1b5b <APDcCopy>
    2804:	83 c4 30             	add    $0x30,%esp
                    break;
    2807:	eb 5c                	jmp    2865 <APGridPaint+0x74c>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2809:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    280c:	6a 0c                	push   $0xc
    280e:	6a 0c                	push   $0xc
    2810:	6a 0c                	push   $0xc
    2812:	50                   	push   %eax
    2813:	e8 e7 f4 ff ff       	call   1cff <RGB>
    2818:	83 c4 0c             	add    $0xc,%esp
    281b:	8b 1d 78 c8 00 00    	mov    0xc878,%ebx
    2821:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2824:	6b c8 32             	imul   $0x32,%eax,%ecx
    2827:	8b 45 e0             	mov    -0x20(%ebp),%eax
    282a:	6b c0 32             	imul   $0x32,%eax,%eax
    282d:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2830:	8b 45 08             	mov    0x8(%ebp),%eax
    2833:	8d 78 3c             	lea    0x3c(%eax),%edi
    2836:	83 ec 0c             	sub    $0xc,%esp
    2839:	83 ec 04             	sub    $0x4,%esp
    283c:	89 e0                	mov    %esp,%eax
    283e:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2842:	66 89 30             	mov    %si,(%eax)
    2845:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2849:	88 50 02             	mov    %dl,0x2(%eax)
    284c:	6a 32                	push   $0x32
    284e:	6a 32                	push   $0x32
    2850:	6a 00                	push   $0x0
    2852:	6a 00                	push   $0x0
    2854:	53                   	push   %ebx
    2855:	51                   	push   %ecx
    2856:	ff 75 84             	pushl  -0x7c(%ebp)
    2859:	57                   	push   %edi
    285a:	e8 fc f2 ff ff       	call   1b5b <APDcCopy>
    285f:	83 c4 30             	add    $0x30,%esp
                    break;
    2862:	eb 01                	jmp    2865 <APGridPaint+0x74c>
                default: break;
    2864:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2865:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2869:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    286d:	0f 8e 1c fc ff ff    	jle    248f <APGridPaint+0x376>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2873:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2877:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    287b:	0f 8e 02 fc ff ff    	jle    2483 <APGridPaint+0x36a>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2881:	8d 45 88             	lea    -0x78(%ebp),%eax
    2884:	68 cd 00 00 00       	push   $0xcd
    2889:	6a 74                	push   $0x74
    288b:	6a 18                	push   $0x18
    288d:	50                   	push   %eax
    288e:	e8 6c f4 ff ff       	call   1cff <RGB>
    2893:	83 c4 0c             	add    $0xc,%esp
    2896:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    289a:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    289e:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    28a2:	88 45 b6             	mov    %al,-0x4a(%ebp)
    pen.size = 1;
    28a5:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    28ac:	8d 45 88             	lea    -0x78(%ebp),%eax
    28af:	68 cd 00 00 00       	push   $0xcd
    28b4:	6a 74                	push   $0x74
    28b6:	6a 18                	push   $0x18
    28b8:	50                   	push   %eax
    28b9:	e8 41 f4 ff ff       	call   1cff <RGB>
    28be:	83 c4 0c             	add    $0xc,%esp
    28c1:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    28c5:	66 89 45 b1          	mov    %ax,-0x4f(%ebp)
    28c9:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    28cd:	88 45 b3             	mov    %al,-0x4d(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    28d0:	8b 45 08             	mov    0x8(%ebp),%eax
    28d3:	8d 50 58             	lea    0x58(%eax),%edx
    28d6:	8d 45 88             	lea    -0x78(%ebp),%eax
    28d9:	ff 75 b8             	pushl  -0x48(%ebp)
    28dc:	ff 75 b4             	pushl  -0x4c(%ebp)
    28df:	52                   	push   %edx
    28e0:	50                   	push   %eax
    28e1:	e8 06 eb ff ff       	call   13ec <APSetPen>
    28e6:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    28e9:	8b 45 08             	mov    0x8(%ebp),%eax
    28ec:	8d 58 58             	lea    0x58(%eax),%ebx
    28ef:	8d 55 88             	lea    -0x78(%ebp),%edx
    28f2:	83 ec 04             	sub    $0x4,%esp
    28f5:	83 ec 04             	sub    $0x4,%esp
    28f8:	89 e0                	mov    %esp,%eax
    28fa:	0f b7 4d b1          	movzwl -0x4f(%ebp),%ecx
    28fe:	66 89 08             	mov    %cx,(%eax)
    2901:	0f b6 4d b3          	movzbl -0x4d(%ebp),%ecx
    2905:	88 48 02             	mov    %cl,0x2(%eax)
    2908:	53                   	push   %ebx
    2909:	52                   	push   %edx
    290a:	e8 16 eb ff ff       	call   1425 <APSetBrush>
    290f:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2912:	8b 45 08             	mov    0x8(%ebp),%eax
    2915:	83 c0 58             	add    $0x58,%eax
    2918:	83 ec 0c             	sub    $0xc,%esp
    291b:	6a 32                	push   $0x32
    291d:	68 20 03 00 00       	push   $0x320
    2922:	6a 00                	push   $0x0
    2924:	6a 00                	push   $0x0
    2926:	50                   	push   %eax
    2927:	e8 23 ef ff ff       	call   184f <APDrawRect>
    292c:	83 c4 20             	add    $0x20,%esp
    
    
}
    292f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2932:	5b                   	pop    %ebx
    2933:	5e                   	pop    %esi
    2934:	5f                   	pop    %edi
    2935:	5d                   	pop    %ebp
    2936:	c3                   	ret    

00002937 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2937:	55                   	push   %ebp
    2938:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    293a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    293e:	7e 08                	jle    2948 <random+0x11>
{
rand_num = seed;
    2940:	8b 45 08             	mov    0x8(%ebp),%eax
    2943:	a3 a0 71 00 00       	mov    %eax,0x71a0
}
rand_num *= 3;
    2948:	8b 15 a0 71 00 00    	mov    0x71a0,%edx
    294e:	89 d0                	mov    %edx,%eax
    2950:	01 c0                	add    %eax,%eax
    2952:	01 d0                	add    %edx,%eax
    2954:	a3 a0 71 00 00       	mov    %eax,0x71a0
if (rand_num < 0)
    2959:	a1 a0 71 00 00       	mov    0x71a0,%eax
    295e:	85 c0                	test   %eax,%eax
    2960:	79 0c                	jns    296e <random+0x37>
{
rand_num *= (-1);
    2962:	a1 a0 71 00 00       	mov    0x71a0,%eax
    2967:	f7 d8                	neg    %eax
    2969:	a3 a0 71 00 00       	mov    %eax,0x71a0
}
return rand_num % 997;
    296e:	8b 0d a0 71 00 00    	mov    0x71a0,%ecx
    2974:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2979:	89 c8                	mov    %ecx,%eax
    297b:	f7 ea                	imul   %edx
    297d:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2980:	c1 f8 09             	sar    $0x9,%eax
    2983:	89 c2                	mov    %eax,%edx
    2985:	89 c8                	mov    %ecx,%eax
    2987:	c1 f8 1f             	sar    $0x1f,%eax
    298a:	29 c2                	sub    %eax,%edx
    298c:	89 d0                	mov    %edx,%eax
    298e:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2994:	29 c1                	sub    %eax,%ecx
    2996:	89 c8                	mov    %ecx,%eax
}
    2998:	5d                   	pop    %ebp
    2999:	c3                   	ret    

0000299a <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    299a:	55                   	push   %ebp
    299b:	89 e5                	mov    %esp,%ebp
    299d:	53                   	push   %ebx
    299e:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    29a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    29a8:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    29ac:	74 17                	je     29c5 <sprintint+0x2b>
    29ae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    29b2:	79 11                	jns    29c5 <sprintint+0x2b>
        neg = 1;
    29b4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    29bb:	8b 45 10             	mov    0x10(%ebp),%eax
    29be:	f7 d8                	neg    %eax
    29c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    29c3:	eb 06                	jmp    29cb <sprintint+0x31>
    } else {
        x = xx;
    29c5:	8b 45 10             	mov    0x10(%ebp),%eax
    29c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    29cb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    29d2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    29d5:	8d 41 01             	lea    0x1(%ecx),%eax
    29d8:	89 45 f8             	mov    %eax,-0x8(%ebp)
    29db:	8b 5d 14             	mov    0x14(%ebp),%ebx
    29de:	8b 45 f0             	mov    -0x10(%ebp),%eax
    29e1:	ba 00 00 00 00       	mov    $0x0,%edx
    29e6:	f7 f3                	div    %ebx
    29e8:	89 d0                	mov    %edx,%eax
    29ea:	0f b6 80 a4 71 00 00 	movzbl 0x71a4(%eax),%eax
    29f1:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    29f5:	8b 5d 14             	mov    0x14(%ebp),%ebx
    29f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    29fb:	ba 00 00 00 00       	mov    $0x0,%edx
    2a00:	f7 f3                	div    %ebx
    2a02:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2a05:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2a09:	75 c7                	jne    29d2 <sprintint+0x38>
    if(neg)
    2a0b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a0f:	74 0e                	je     2a1f <sprintint+0x85>
        buf[i++] = '-';
    2a11:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2a14:	8d 50 01             	lea    0x1(%eax),%edx
    2a17:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2a1a:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2a1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2a22:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2a25:	eb 1b                	jmp    2a42 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2a27:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a2a:	8b 00                	mov    (%eax),%eax
    2a2c:	8d 48 01             	lea    0x1(%eax),%ecx
    2a2f:	8b 55 0c             	mov    0xc(%ebp),%edx
    2a32:	89 0a                	mov    %ecx,(%edx)
    2a34:	89 c2                	mov    %eax,%edx
    2a36:	8b 45 08             	mov    0x8(%ebp),%eax
    2a39:	01 d0                	add    %edx,%eax
    2a3b:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2a3e:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2a42:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2a46:	7f df                	jg     2a27 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2a48:	eb 21                	jmp    2a6b <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2a4a:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a4d:	8b 00                	mov    (%eax),%eax
    2a4f:	8d 48 01             	lea    0x1(%eax),%ecx
    2a52:	8b 55 0c             	mov    0xc(%ebp),%edx
    2a55:	89 0a                	mov    %ecx,(%edx)
    2a57:	89 c2                	mov    %eax,%edx
    2a59:	8b 45 08             	mov    0x8(%ebp),%eax
    2a5c:	01 c2                	add    %eax,%edx
    2a5e:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2a61:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2a64:	01 c8                	add    %ecx,%eax
    2a66:	0f b6 00             	movzbl (%eax),%eax
    2a69:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2a6b:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2a6f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2a73:	79 d5                	jns    2a4a <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2a75:	90                   	nop
    2a76:	83 c4 20             	add    $0x20,%esp
    2a79:	5b                   	pop    %ebx
    2a7a:	5d                   	pop    %ebp
    2a7b:	c3                   	ret    

00002a7c <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2a7c:	55                   	push   %ebp
    2a7d:	89 e5                	mov    %esp,%ebp
    2a7f:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2a82:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2a89:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2a90:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2a97:	8d 45 0c             	lea    0xc(%ebp),%eax
    2a9a:	83 c0 04             	add    $0x4,%eax
    2a9d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2aa0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2aa7:	e9 d9 01 00 00       	jmp    2c85 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2aac:	8b 55 0c             	mov    0xc(%ebp),%edx
    2aaf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2ab2:	01 d0                	add    %edx,%eax
    2ab4:	0f b6 00             	movzbl (%eax),%eax
    2ab7:	0f be c0             	movsbl %al,%eax
    2aba:	25 ff 00 00 00       	and    $0xff,%eax
    2abf:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2ac2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2ac6:	75 2c                	jne    2af4 <sprintf+0x78>
            if(c == '%'){
    2ac8:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2acc:	75 0c                	jne    2ada <sprintf+0x5e>
                state = '%';
    2ace:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2ad5:	e9 a7 01 00 00       	jmp    2c81 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2ada:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2add:	8d 50 01             	lea    0x1(%eax),%edx
    2ae0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2ae3:	89 c2                	mov    %eax,%edx
    2ae5:	8b 45 08             	mov    0x8(%ebp),%eax
    2ae8:	01 d0                	add    %edx,%eax
    2aea:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2aed:	88 10                	mov    %dl,(%eax)
    2aef:	e9 8d 01 00 00       	jmp    2c81 <sprintf+0x205>
            }
        } else if(state == '%'){
    2af4:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2af8:	0f 85 83 01 00 00    	jne    2c81 <sprintf+0x205>
            if(c == 'd'){
    2afe:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2b02:	75 4c                	jne    2b50 <sprintf+0xd4>
                buf[bi] = '\0';
    2b04:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2b07:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2b0a:	01 d0                	add    %edx,%eax
    2b0c:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2b0f:	83 ec 0c             	sub    $0xc,%esp
    2b12:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2b15:	50                   	push   %eax
    2b16:	e8 2b df ff ff       	call   a46 <atoi>
    2b1b:	83 c4 10             	add    $0x10,%esp
    2b1e:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2b21:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2b28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2b2b:	8b 00                	mov    (%eax),%eax
    2b2d:	83 ec 08             	sub    $0x8,%esp
    2b30:	ff 75 d8             	pushl  -0x28(%ebp)
    2b33:	6a 01                	push   $0x1
    2b35:	6a 0a                	push   $0xa
    2b37:	50                   	push   %eax
    2b38:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2b3b:	50                   	push   %eax
    2b3c:	ff 75 08             	pushl  0x8(%ebp)
    2b3f:	e8 56 fe ff ff       	call   299a <sprintint>
    2b44:	83 c4 20             	add    $0x20,%esp
                ap++;
    2b47:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2b4b:	e9 2a 01 00 00       	jmp    2c7a <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2b50:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2b54:	74 06                	je     2b5c <sprintf+0xe0>
    2b56:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2b5a:	75 4c                	jne    2ba8 <sprintf+0x12c>
                buf[bi] = '\0';
    2b5c:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2b5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2b62:	01 d0                	add    %edx,%eax
    2b64:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2b67:	83 ec 0c             	sub    $0xc,%esp
    2b6a:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2b6d:	50                   	push   %eax
    2b6e:	e8 d3 de ff ff       	call   a46 <atoi>
    2b73:	83 c4 10             	add    $0x10,%esp
    2b76:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2b79:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2b80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2b83:	8b 00                	mov    (%eax),%eax
    2b85:	83 ec 08             	sub    $0x8,%esp
    2b88:	ff 75 dc             	pushl  -0x24(%ebp)
    2b8b:	6a 00                	push   $0x0
    2b8d:	6a 10                	push   $0x10
    2b8f:	50                   	push   %eax
    2b90:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2b93:	50                   	push   %eax
    2b94:	ff 75 08             	pushl  0x8(%ebp)
    2b97:	e8 fe fd ff ff       	call   299a <sprintint>
    2b9c:	83 c4 20             	add    $0x20,%esp
                ap++;
    2b9f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2ba3:	e9 d2 00 00 00       	jmp    2c7a <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2ba8:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2bac:	75 46                	jne    2bf4 <sprintf+0x178>
                s = (char*)*ap;
    2bae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2bb1:	8b 00                	mov    (%eax),%eax
    2bb3:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2bb6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2bba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2bbe:	75 25                	jne    2be5 <sprintf+0x169>
                    s = "(null)";
    2bc0:	c7 45 f4 a0 2e 00 00 	movl   $0x2ea0,-0xc(%ebp)
                while(*s != 0){
    2bc7:	eb 1c                	jmp    2be5 <sprintf+0x169>
                    dst[j++] = *s;
    2bc9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2bcc:	8d 50 01             	lea    0x1(%eax),%edx
    2bcf:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2bd2:	89 c2                	mov    %eax,%edx
    2bd4:	8b 45 08             	mov    0x8(%ebp),%eax
    2bd7:	01 c2                	add    %eax,%edx
    2bd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2bdc:	0f b6 00             	movzbl (%eax),%eax
    2bdf:	88 02                	mov    %al,(%edx)
                    s++;
    2be1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2be5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2be8:	0f b6 00             	movzbl (%eax),%eax
    2beb:	84 c0                	test   %al,%al
    2bed:	75 da                	jne    2bc9 <sprintf+0x14d>
    2bef:	e9 86 00 00 00       	jmp    2c7a <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2bf4:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2bf8:	75 1d                	jne    2c17 <sprintf+0x19b>
                dst[j++] = *ap;
    2bfa:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2bfd:	8d 50 01             	lea    0x1(%eax),%edx
    2c00:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2c03:	89 c2                	mov    %eax,%edx
    2c05:	8b 45 08             	mov    0x8(%ebp),%eax
    2c08:	01 c2                	add    %eax,%edx
    2c0a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2c0d:	8b 00                	mov    (%eax),%eax
    2c0f:	88 02                	mov    %al,(%edx)
                ap++;
    2c11:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2c15:	eb 63                	jmp    2c7a <sprintf+0x1fe>
            } else if(c == '%'){
    2c17:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2c1b:	75 17                	jne    2c34 <sprintf+0x1b8>
                dst[j++] = c;
    2c1d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c20:	8d 50 01             	lea    0x1(%eax),%edx
    2c23:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2c26:	89 c2                	mov    %eax,%edx
    2c28:	8b 45 08             	mov    0x8(%ebp),%eax
    2c2b:	01 d0                	add    %edx,%eax
    2c2d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2c30:	88 10                	mov    %dl,(%eax)
    2c32:	eb 46                	jmp    2c7a <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2c34:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2c38:	7e 18                	jle    2c52 <sprintf+0x1d6>
    2c3a:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2c3e:	7f 12                	jg     2c52 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2c40:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2c43:	8d 50 01             	lea    0x1(%eax),%edx
    2c46:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2c49:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2c4c:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2c50:	eb 2f                	jmp    2c81 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2c52:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c55:	8d 50 01             	lea    0x1(%eax),%edx
    2c58:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2c5b:	89 c2                	mov    %eax,%edx
    2c5d:	8b 45 08             	mov    0x8(%ebp),%eax
    2c60:	01 d0                	add    %edx,%eax
    2c62:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2c65:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c68:	8d 50 01             	lea    0x1(%eax),%edx
    2c6b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2c6e:	89 c2                	mov    %eax,%edx
    2c70:	8b 45 08             	mov    0x8(%ebp),%eax
    2c73:	01 d0                	add    %edx,%eax
    2c75:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2c78:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2c7a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2c81:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2c85:	8b 55 0c             	mov    0xc(%ebp),%edx
    2c88:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2c8b:	01 d0                	add    %edx,%eax
    2c8d:	0f b6 00             	movzbl (%eax),%eax
    2c90:	84 c0                	test   %al,%al
    2c92:	0f 85 14 fe ff ff    	jne    2aac <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2c98:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c9b:	8d 50 01             	lea    0x1(%eax),%edx
    2c9e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2ca1:	89 c2                	mov    %eax,%edx
    2ca3:	8b 45 08             	mov    0x8(%ebp),%eax
    2ca6:	01 d0                	add    %edx,%eax
    2ca8:	c6 00 00             	movb   $0x0,(%eax)
}
    2cab:	90                   	nop
    2cac:	c9                   	leave  
    2cad:	c3                   	ret    
