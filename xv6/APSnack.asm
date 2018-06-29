
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
     1d8:	e8 ba 04 00 00       	call   697 <updateFood>
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
     202:	68 b4 2c 00 00       	push   $0x2cb4
     207:	e8 5a 1b 00 00       	call   1d66 <APCreateWindow>
     20c:	83 c4 10             	add    $0x10,%esp
     20f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf(1,"snack created.\n");
     212:	83 ec 08             	sub    $0x8,%esp
     215:	68 ba 2c 00 00       	push   $0x2cba
     21a:	6a 01                	push   $0x1
     21c:	e8 7a 0a 00 00       	call   c9b <printf>
     221:	83 c4 10             	add    $0x10,%esp
	APWndExec(hwnd,wndProc);
     224:	83 ec 08             	sub    $0x8,%esp
     227:	68 b5 07 00 00       	push   $0x7b5
     22c:	ff 75 f4             	pushl  -0xc(%ebp)
     22f:	e8 54 1e 00 00       	call   2088 <APWndExec>
     234:	83 c4 10             	add    $0x10,%esp
	exit();
     237:	e8 a0 08 00 00       	call   adc <exit>

0000023c <init>:
}

void init(AHwnd hwnd)
{
     23c:	55                   	push   %ebp
     23d:	89 e5                	mov    %esp,%ebp
     23f:	83 ec 28             	sub    $0x28,%esp
	random(getCurrentTime());
     242:	e8 6d 09 00 00       	call   bb4 <getCurrentTime>
     247:	83 ec 0c             	sub    $0xc,%esp
     24a:	50                   	push   %eax
     24b:	e8 eb 26 00 00       	call   293b <random>
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
     2c9:	e8 c9 03 00 00       	call   697 <updateFood>
     2ce:	e8 c4 03 00 00       	call   697 <updateFood>
     2d3:	e8 bf 03 00 00       	call   697 <updateFood>
     2d8:	e8 ba 03 00 00       	call   697 <updateFood>
     2dd:	e8 b5 03 00 00       	call   697 <updateFood>
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
     328:	e8 6a 03 00 00       	call   697 <updateFood>
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
     348:	e8 57 08 00 00       	call   ba4 <setupTimer>
     34d:	83 c4 10             	add    $0x10,%esp
	APSendMessage(hwnd,msg);
     350:	ff 75 e8             	pushl  -0x18(%ebp)
     353:	ff 75 e4             	pushl  -0x1c(%ebp)
     356:	ff 75 e0             	pushl  -0x20(%ebp)
     359:	ff 75 08             	pushl  0x8(%ebp)
     35c:	e8 e7 19 00 00       	call   1d48 <APSendMessage>
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
     36d:	e8 b7 02 00 00       	call   629 <Is_Dead>
     372:	84 c0                	test   %al,%al
     374:	74 2e                	je     3a4 <timerUpdate+0x3d>
	{
		status = Dead;
     376:	c7 05 84 c8 00 00 02 	movl   $0x2,0xc884
     37d:	00 00 00 
		printf(1,"Dead!");
     380:	83 ec 08             	sub    $0x8,%esp
     383:	68 ca 2c 00 00       	push   $0x2cca
     388:	6a 01                	push   $0x1
     38a:	e8 0c 09 00 00       	call   c9b <printf>
     38f:	83 c4 10             	add    $0x10,%esp
		deleteTimer(hwnd,1);
     392:	83 ec 08             	sub    $0x8,%esp
     395:	6a 01                	push   $0x1
     397:	ff 75 08             	pushl  0x8(%ebp)
     39a:	e8 0d 08 00 00       	call   bac <deleteTimer>
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
     3b8:	0f 87 ea 00 00 00    	ja     4a8 <keyDown+0xfc>
     3be:	8b 04 85 d0 2c 00 00 	mov    0x2cd0(,%eax,4),%eax
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
     3d9:	0f 85 cc 00 00 00    	jne    4ab <keyDown+0xff>
	current_direction = Up;
     3df:	c7 05 a0 b6 00 00 01 	movl   $0x1,0xb6a0
     3e6:	00 00 00 
break;
     3e9:	e9 bd 00 00 00       	jmp    4ab <keyDown+0xff>
case VK_DOWN:
//printf(1,"Down Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
     3ee:	a1 00 b7 00 00       	mov    0xb700,%eax
     3f3:	83 f8 03             	cmp    $0x3,%eax
     3f6:	74 0e                	je     406 <keyDown+0x5a>
     3f8:	a1 00 b7 00 00       	mov    0xb700,%eax
     3fd:	83 f8 04             	cmp    $0x4,%eax
     400:	0f 85 a8 00 00 00    	jne    4ae <keyDown+0x102>
	current_direction = Down;
     406:	c7 05 a0 b6 00 00 02 	movl   $0x2,0xb6a0
     40d:	00 00 00 
break;
     410:	e9 99 00 00 00       	jmp    4ae <keyDown+0x102>
case VK_LEFT:
//printf(1,"Left Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
     415:	a1 00 b7 00 00       	mov    0xb700,%eax
     41a:	83 f8 01             	cmp    $0x1,%eax
     41d:	74 0e                	je     42d <keyDown+0x81>
     41f:	a1 00 b7 00 00       	mov    0xb700,%eax
     424:	83 f8 02             	cmp    $0x2,%eax
     427:	0f 85 84 00 00 00    	jne    4b1 <keyDown+0x105>
	current_direction = Left;
     42d:	c7 05 a0 b6 00 00 03 	movl   $0x3,0xb6a0
     434:	00 00 00 
break;
     437:	eb 78                	jmp    4b1 <keyDown+0x105>
case VK_RIGHT:
//printf(1,"Right Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
     439:	a1 00 b7 00 00       	mov    0xb700,%eax
     43e:	83 f8 01             	cmp    $0x1,%eax
     441:	74 0a                	je     44d <keyDown+0xa1>
     443:	a1 00 b7 00 00       	mov    0xb700,%eax
     448:	83 f8 02             	cmp    $0x2,%eax
     44b:	75 67                	jne    4b4 <keyDown+0x108>
	current_direction = Right;
     44d:	c7 05 a0 b6 00 00 04 	movl   $0x4,0xb6a0
     454:	00 00 00 
break;
     457:	eb 5b                	jmp    4b4 <keyDown+0x108>
case VK_ENTER:
switch(status)
     459:	a1 84 c8 00 00       	mov    0xc884,%eax
     45e:	83 f8 01             	cmp    $0x1,%eax
     461:	74 17                	je     47a <keyDown+0xce>
     463:	83 f8 02             	cmp    $0x2,%eax
     466:	74 1e                	je     486 <keyDown+0xda>
     468:	85 c0                	test   %eax,%eax
     46a:	74 02                	je     46e <keyDown+0xc2>
break;
case Dead:
init(hwnd);
break;
default:
break;
     46c:	eb 27                	jmp    495 <keyDown+0xe9>
break;
case VK_ENTER:
switch(status)
{
case Run:
status = Pause;
     46e:	c7 05 84 c8 00 00 01 	movl   $0x1,0xc884
     475:	00 00 00 
break;
     478:	eb 1b                	jmp    495 <keyDown+0xe9>
case Pause:
status = Run;
     47a:	c7 05 84 c8 00 00 00 	movl   $0x0,0xc884
     481:	00 00 00 
break;
     484:	eb 0f                	jmp    495 <keyDown+0xe9>
case Dead:
init(hwnd);
     486:	83 ec 0c             	sub    $0xc,%esp
     489:	ff 75 08             	pushl  0x8(%ebp)
     48c:	e8 ab fd ff ff       	call   23c <init>
     491:	83 c4 10             	add    $0x10,%esp
break;
     494:	90                   	nop
default:
break;
}
break;
     495:	eb 1e                	jmp    4b5 <keyDown+0x109>
case VK_ESC:
        removeWindow(hwnd->id);
     497:	8b 45 08             	mov    0x8(%ebp),%eax
     49a:	8b 00                	mov    (%eax),%eax
     49c:	83 ec 0c             	sub    $0xc,%esp
     49f:	50                   	push   %eax
     4a0:	e8 17 07 00 00       	call   bbc <removeWindow>
     4a5:	83 c4 10             	add    $0x10,%esp
default:
break;
     4a8:	90                   	nop
     4a9:	eb 0a                	jmp    4b5 <keyDown+0x109>
{
case VK_UP:
//printf(1,"Up Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
	current_direction = Up;
break;
     4ab:	90                   	nop
     4ac:	eb 07                	jmp    4b5 <keyDown+0x109>
case VK_DOWN:
//printf(1,"Down Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
	current_direction = Down;
break;
     4ae:	90                   	nop
     4af:	eb 04                	jmp    4b5 <keyDown+0x109>
case VK_LEFT:
//printf(1,"Left Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
	current_direction = Left;
break;
     4b1:	90                   	nop
     4b2:	eb 01                	jmp    4b5 <keyDown+0x109>
case VK_RIGHT:
//printf(1,"Right Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
	current_direction = Right;
break;
     4b4:	90                   	nop
default:
break;

}

}
     4b5:	90                   	nop
     4b6:	c9                   	leave  
     4b7:	c3                   	ret    

000004b8 <draw>:

void draw(AHwnd hwnd)
{
     4b8:	55                   	push   %ebp
     4b9:	89 e5                	mov    %esp,%ebp
     4bb:	83 ec 28             	sub    $0x28,%esp
	AHdc hdc = &(hwnd->Dc);
     4be:	8b 45 08             	mov    0x8(%ebp),%eax
     4c1:	83 c0 3c             	add    $0x3c,%eax
     4c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
     4c7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4ce:	e9 49 01 00 00       	jmp    61c <draw+0x164>
	{

		for (int j = 0;j < BLOCK_NUM_Y;j++)
     4d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4da:	e9 2f 01 00 00       	jmp    60e <draw+0x156>
		{
			if (my_block[i][j] == NoDir)
     4df:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4e2:	6b d0 37             	imul   $0x37,%eax,%edx
     4e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4e8:	01 d0                	add    %edx,%eax
     4ea:	8b 04 85 e0 71 00 00 	mov    0x71e0(,%eax,4),%eax
     4f1:	85 c0                	test   %eax,%eax
     4f3:	75 26                	jne    51b <draw+0x63>
			{
				brush.color = COLOR_BACK;
     4f5:	8d 45 d8             	lea    -0x28(%ebp),%eax
     4f8:	6a 00                	push   $0x0
     4fa:	68 ff 00 00 00       	push   $0xff
     4ff:	6a 00                	push   $0x0
     501:	50                   	push   %eax
     502:	e8 f9 fa ff ff       	call   0 <RGB>
     507:	83 c4 0c             	add    $0xc,%esp
     50a:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     50e:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     512:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     516:	88 45 eb             	mov    %al,-0x15(%ebp)
     519:	eb 61                	jmp    57c <draw+0xc4>

			}//background
			else
			{
				if (head.x == i && head.y == j)
     51b:	a1 ec b6 00 00       	mov    0xb6ec,%eax
     520:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     523:	75 30                	jne    555 <draw+0x9d>
     525:	a1 f0 b6 00 00       	mov    0xb6f0,%eax
     52a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     52d:	75 26                	jne    555 <draw+0x9d>
					brush.color = COLOR_HEAD;
     52f:	8d 45 d8             	lea    -0x28(%ebp),%eax
     532:	6a 00                	push   $0x0
     534:	68 80 00 00 00       	push   $0x80
     539:	6a 00                	push   $0x0
     53b:	50                   	push   %eax
     53c:	e8 bf fa ff ff       	call   0 <RGB>
     541:	83 c4 0c             	add    $0xc,%esp
     544:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     548:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     54c:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     550:	88 45 eb             	mov    %al,-0x15(%ebp)
     553:	eb 27                	jmp    57c <draw+0xc4>
				else
					brush.color = COLOR_BODY;
     555:	8d 45 d8             	lea    -0x28(%ebp),%eax
     558:	68 ff 00 00 00       	push   $0xff
     55d:	68 ff 00 00 00       	push   $0xff
     562:	6a 00                	push   $0x0
     564:	50                   	push   %eax
     565:	e8 96 fa ff ff       	call   0 <RGB>
     56a:	83 c4 0c             	add    $0xc,%esp
     56d:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     571:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     575:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     579:	88 45 eb             	mov    %al,-0x15(%ebp)
			}
			if (my_food[i][j] == 1)
     57c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     57f:	6b d0 37             	imul   $0x37,%eax,%edx
     582:	8b 45 f0             	mov    -0x10(%ebp),%eax
     585:	01 d0                	add    %edx,%eax
     587:	05 20 b7 00 00       	add    $0xb720,%eax
     58c:	0f b6 00             	movzbl (%eax),%eax
     58f:	3c 01                	cmp    $0x1,%al
     591:	75 24                	jne    5b7 <draw+0xff>
			{
				brush.color = COLOR_FOOD;
     593:	8d 45 d8             	lea    -0x28(%ebp),%eax
     596:	6a 00                	push   $0x0
     598:	6a 00                	push   $0x0
     59a:	68 ff 00 00 00       	push   $0xff
     59f:	50                   	push   %eax
     5a0:	e8 5b fa ff ff       	call   0 <RGB>
     5a5:	83 c4 0c             	add    $0xc,%esp
     5a8:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     5ac:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     5b0:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     5b4:	88 45 eb             	mov    %al,-0x15(%ebp)
			}
			APSetBrush(hdc,brush);
     5b7:	8d 55 d8             	lea    -0x28(%ebp),%edx
     5ba:	83 ec 04             	sub    $0x4,%esp
     5bd:	83 ec 04             	sub    $0x4,%esp
     5c0:	89 e0                	mov    %esp,%eax
     5c2:	0f b7 4d e9          	movzwl -0x17(%ebp),%ecx
     5c6:	66 89 08             	mov    %cx,(%eax)
     5c9:	0f b6 4d eb          	movzbl -0x15(%ebp),%ecx
     5cd:	88 48 02             	mov    %cl,0x2(%eax)
     5d0:	ff 75 ec             	pushl  -0x14(%ebp)
     5d3:	52                   	push   %edx
     5d4:	e8 50 0e 00 00       	call   1429 <APSetBrush>
     5d9:	83 c4 0c             	add    $0xc,%esp
			APDrawRect(hdc,i * BLOCK_WIDTH,j*BLOCK_WIDTH,BLOCK_WIDTH,BLOCK_WIDTH);
     5dc:	8b 55 f0             	mov    -0x10(%ebp),%edx
     5df:	89 d0                	mov    %edx,%eax
     5e1:	c1 e0 02             	shl    $0x2,%eax
     5e4:	01 d0                	add    %edx,%eax
     5e6:	01 c0                	add    %eax,%eax
     5e8:	89 c1                	mov    %eax,%ecx
     5ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
     5ed:	89 d0                	mov    %edx,%eax
     5ef:	c1 e0 02             	shl    $0x2,%eax
     5f2:	01 d0                	add    %edx,%eax
     5f4:	01 c0                	add    %eax,%eax
     5f6:	83 ec 0c             	sub    $0xc,%esp
     5f9:	6a 0a                	push   $0xa
     5fb:	6a 0a                	push   $0xa
     5fd:	51                   	push   %ecx
     5fe:	50                   	push   %eax
     5ff:	ff 75 ec             	pushl  -0x14(%ebp)
     602:	e8 4c 12 00 00       	call   1853 <APDrawRect>
     607:	83 c4 20             	add    $0x20,%esp
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
	{

		for (int j = 0;j < BLOCK_NUM_Y;j++)
     60a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     60e:	83 7d f0 36          	cmpl   $0x36,-0x10(%ebp)
     612:	0f 8e c7 fe ff ff    	jle    4df <draw+0x27>
void draw(AHwnd hwnd)
{
	AHdc hdc = &(hwnd->Dc);
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
     618:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     61c:	83 7d f4 4f          	cmpl   $0x4f,-0xc(%ebp)
     620:	0f 8e ad fe ff ff    	jle    4d3 <draw+0x1b>
			}
			APSetBrush(hdc,brush);
			APDrawRect(hdc,i * BLOCK_WIDTH,j*BLOCK_WIDTH,BLOCK_WIDTH,BLOCK_WIDTH);
		}
	}
}
     626:	90                   	nop
     627:	c9                   	leave  
     628:	c3                   	ret    

00000629 <Is_Dead>:

bool Is_Dead()
{
     629:	55                   	push   %ebp
     62a:	89 e5                	mov    %esp,%ebp
     62c:	83 ec 10             	sub    $0x10,%esp
	APoint p = nextpoint(head,current_direction);
     62f:	8b 15 a0 b6 00 00    	mov    0xb6a0,%edx
     635:	8d 45 f8             	lea    -0x8(%ebp),%eax
     638:	52                   	push   %edx
     639:	ff 35 f0 b6 00 00    	pushl  0xb6f0
     63f:	ff 35 ec b6 00 00    	pushl  0xb6ec
     645:	50                   	push   %eax
     646:	e8 fa f9 ff ff       	call   45 <nextpoint>
     64b:	83 c4 0c             	add    $0xc,%esp
    if (p.x >= BLOCK_NUM_X || p.y > BLOCK_NUM_Y || p.x < 0 || p.y < 0)
     64e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     651:	83 f8 4f             	cmp    $0x4f,%eax
     654:	7f 16                	jg     66c <Is_Dead+0x43>
     656:	8b 45 fc             	mov    -0x4(%ebp),%eax
     659:	83 f8 37             	cmp    $0x37,%eax
     65c:	7f 0e                	jg     66c <Is_Dead+0x43>
     65e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     661:	85 c0                	test   %eax,%eax
     663:	78 07                	js     66c <Is_Dead+0x43>
     665:	8b 45 fc             	mov    -0x4(%ebp),%eax
     668:	85 c0                	test   %eax,%eax
     66a:	79 07                	jns    673 <Is_Dead+0x4a>
        return True;
     66c:	b8 01 00 00 00       	mov    $0x1,%eax
     671:	eb 22                	jmp    695 <Is_Dead+0x6c>
	if (my_block[p.x][p.y] != NoDir)
     673:	8b 55 f8             	mov    -0x8(%ebp),%edx
     676:	8b 45 fc             	mov    -0x4(%ebp),%eax
     679:	6b d2 37             	imul   $0x37,%edx,%edx
     67c:	01 d0                	add    %edx,%eax
     67e:	8b 04 85 e0 71 00 00 	mov    0x71e0(,%eax,4),%eax
     685:	85 c0                	test   %eax,%eax
     687:	74 07                	je     690 <Is_Dead+0x67>
        return True;
     689:	b8 01 00 00 00       	mov    $0x1,%eax
     68e:	eb 05                	jmp    695 <Is_Dead+0x6c>
    else
        return False;
     690:	b8 00 00 00 00       	mov    $0x0,%eax
}
     695:	c9                   	leave  
     696:	c3                   	ret    

00000697 <updateFood>:

bool updateFood()
{
     697:	55                   	push   %ebp
     698:	89 e5                	mov    %esp,%ebp
     69a:	83 ec 28             	sub    $0x28,%esp
bool sta = false;
     69d:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
for (int i = 0;i < BLOCK_NUM_X;i++)
     6a1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     6a8:	eb 50                	jmp    6fa <updateFood+0x63>
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
     6aa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     6b1:	eb 37                	jmp    6ea <updateFood+0x53>
	{
		if (my_block[i][j] == NoDir && my_food[i][j] == NoDir)
     6b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6b6:	6b d0 37             	imul   $0x37,%eax,%edx
     6b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6bc:	01 d0                	add    %edx,%eax
     6be:	8b 04 85 e0 71 00 00 	mov    0x71e0(,%eax,4),%eax
     6c5:	85 c0                	test   %eax,%eax
     6c7:	75 1d                	jne    6e6 <updateFood+0x4f>
     6c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6cc:	6b d0 37             	imul   $0x37,%eax,%edx
     6cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6d2:	01 d0                	add    %edx,%eax
     6d4:	05 20 b7 00 00       	add    $0xb720,%eax
     6d9:	0f b6 00             	movzbl (%eax),%eax
     6dc:	84 c0                	test   %al,%al
     6de:	75 06                	jne    6e6 <updateFood+0x4f>
		{
			sta = true;
     6e0:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
			break;
     6e4:	eb 0a                	jmp    6f0 <updateFood+0x59>
bool updateFood()
{
bool sta = false;
for (int i = 0;i < BLOCK_NUM_X;i++)
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
     6e6:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     6ea:	83 7d ec 36          	cmpl   $0x36,-0x14(%ebp)
     6ee:	7e c3                	jle    6b3 <updateFood+0x1c>
		{
			sta = true;
			break;
		}
	}
	if (sta == true)
     6f0:	80 7d f7 01          	cmpb   $0x1,-0x9(%ebp)
     6f4:	74 0c                	je     702 <updateFood+0x6b>
}

bool updateFood()
{
bool sta = false;
for (int i = 0;i < BLOCK_NUM_X;i++)
     6f6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6fa:	83 7d f0 4f          	cmpl   $0x4f,-0x10(%ebp)
     6fe:	7e aa                	jle    6aa <updateFood+0x13>
     700:	eb 01                	jmp    703 <updateFood+0x6c>
			break;
		}
	}
	if (sta == true)
	{
		break;
     702:	90                   	nop
	}
}
if (sta == false)
     703:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
     707:	75 09                	jne    712 <updateFood+0x7b>
{
return sta;
     709:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
     70d:	e9 a1 00 00 00       	jmp    7b3 <updateFood+0x11c>
}
while(true)
{
int i = random(0) % BLOCK_NUM_X;
     712:	83 ec 0c             	sub    $0xc,%esp
     715:	6a 00                	push   $0x0
     717:	e8 1f 22 00 00       	call   293b <random>
     71c:	83 c4 10             	add    $0x10,%esp
     71f:	89 c1                	mov    %eax,%ecx
     721:	ba 67 66 66 66       	mov    $0x66666667,%edx
     726:	89 c8                	mov    %ecx,%eax
     728:	f7 ea                	imul   %edx
     72a:	c1 fa 05             	sar    $0x5,%edx
     72d:	89 c8                	mov    %ecx,%eax
     72f:	c1 f8 1f             	sar    $0x1f,%eax
     732:	29 c2                	sub    %eax,%edx
     734:	89 d0                	mov    %edx,%eax
     736:	89 45 e8             	mov    %eax,-0x18(%ebp)
     739:	8b 55 e8             	mov    -0x18(%ebp),%edx
     73c:	89 d0                	mov    %edx,%eax
     73e:	c1 e0 02             	shl    $0x2,%eax
     741:	01 d0                	add    %edx,%eax
     743:	c1 e0 04             	shl    $0x4,%eax
     746:	29 c1                	sub    %eax,%ecx
     748:	89 c8                	mov    %ecx,%eax
     74a:	89 45 e8             	mov    %eax,-0x18(%ebp)
int j = random(0) % BLOCK_NUM_Y;
     74d:	83 ec 0c             	sub    $0xc,%esp
     750:	6a 00                	push   $0x0
     752:	e8 e4 21 00 00       	call   293b <random>
     757:	83 c4 10             	add    $0x10,%esp
     75a:	89 c1                	mov    %eax,%ecx
     75c:	ba 95 20 4f 09       	mov    $0x94f2095,%edx
     761:	89 c8                	mov    %ecx,%eax
     763:	f7 ea                	imul   %edx
     765:	d1 fa                	sar    %edx
     767:	89 c8                	mov    %ecx,%eax
     769:	c1 f8 1f             	sar    $0x1f,%eax
     76c:	29 c2                	sub    %eax,%edx
     76e:	89 d0                	mov    %edx,%eax
     770:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     773:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     776:	6b c0 37             	imul   $0x37,%eax,%eax
     779:	29 c1                	sub    %eax,%ecx
     77b:	89 c8                	mov    %ecx,%eax
     77d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
if (my_food[i][j] == 0)
     780:	8b 45 e8             	mov    -0x18(%ebp),%eax
     783:	6b d0 37             	imul   $0x37,%eax,%edx
     786:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     789:	01 d0                	add    %edx,%eax
     78b:	05 20 b7 00 00       	add    $0xb720,%eax
     790:	0f b6 00             	movzbl (%eax),%eax
     793:	84 c0                	test   %al,%al
     795:	0f 85 77 ff ff ff    	jne    712 <updateFood+0x7b>
{
	my_food[i][j] = 1;
     79b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     79e:	6b d0 37             	imul   $0x37,%eax,%edx
     7a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7a4:	01 d0                	add    %edx,%eax
     7a6:	05 20 b7 00 00       	add    $0xb720,%eax
     7ab:	c6 00 01             	movb   $0x1,(%eax)
return true;
     7ae:	b8 01 00 00 00       	mov    $0x1,%eax
}

}


}
     7b3:	c9                   	leave  
     7b4:	c3                   	ret    

000007b5 <wndProc>:

bool wndProc(AHwnd hwnd,AMessage msg)
{
     7b5:	55                   	push   %ebp
     7b6:	89 e5                	mov    %esp,%ebp
     7b8:	83 ec 28             	sub    $0x28,%esp
switch(msg.type)
     7bb:	8b 45 0c             	mov    0xc(%ebp),%eax
     7be:	83 f8 09             	cmp    $0x9,%eax
     7c1:	0f 87 a4 00 00 00    	ja     86b <wndProc+0xb6>
     7c7:	8b 04 85 ec 2c 00 00 	mov    0x2cec(,%eax,4),%eax
     7ce:	ff e0                	jmp    *%eax
{
    case MSG_ESC:
        return True;
     7d0:	b8 01 00 00 00       	mov    $0x1,%eax
     7d5:	e9 a9 00 00 00       	jmp    883 <wndProc+0xce>
    case MSG_INIT:
    init(hwnd);
     7da:	83 ec 0c             	sub    $0xc,%esp
     7dd:	ff 75 08             	pushl  0x8(%ebp)
     7e0:	e8 57 fa ff ff       	call   23c <init>
     7e5:	83 c4 10             	add    $0x10,%esp
    AMessage ms;
    ms.type = MSG_PAINT;
     7e8:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
    APSendMessage(hwnd,ms);
     7ef:	ff 75 f4             	pushl  -0xc(%ebp)
     7f2:	ff 75 f0             	pushl  -0x10(%ebp)
     7f5:	ff 75 ec             	pushl  -0x14(%ebp)
     7f8:	ff 75 08             	pushl  0x8(%ebp)
     7fb:	e8 48 15 00 00       	call   1d48 <APSendMessage>
     800:	83 c4 10             	add    $0x10,%esp
    
    return False;
     803:	b8 00 00 00 00       	mov    $0x0,%eax
     808:	eb 79                	jmp    883 <wndProc+0xce>
	case MSG_TIMEOUT:
if (status != Run)
     80a:	a1 84 c8 00 00       	mov    0xc884,%eax
     80f:	85 c0                	test   %eax,%eax
     811:	75 5b                	jne    86e <wndProc+0xb9>
	break;
	timerUpdate(hwnd);
     813:	83 ec 0c             	sub    $0xc,%esp
     816:	ff 75 08             	pushl  0x8(%ebp)
     819:	e8 49 fb ff ff       	call   367 <timerUpdate>
     81e:	83 c4 10             	add    $0x10,%esp
	AMessage msg1;
	msg1.type = MSG_PAINT;
     821:	c7 45 e0 03 00 00 00 	movl   $0x3,-0x20(%ebp)
	msg1.param = 0;
     828:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	APSendMessage(hwnd,msg1);
     82f:	ff 75 e8             	pushl  -0x18(%ebp)
     832:	ff 75 e4             	pushl  -0x1c(%ebp)
     835:	ff 75 e0             	pushl  -0x20(%ebp)
     838:	ff 75 08             	pushl  0x8(%ebp)
     83b:	e8 08 15 00 00       	call   1d48 <APSendMessage>
     840:	83 c4 10             	add    $0x10,%esp
	break;
     843:	eb 2a                	jmp    86f <wndProc+0xba>
	case MSG_KEY_DOWN:
	keyDown(hwnd,msg);
     845:	ff 75 14             	pushl  0x14(%ebp)
     848:	ff 75 10             	pushl  0x10(%ebp)
     84b:	ff 75 0c             	pushl  0xc(%ebp)
     84e:	ff 75 08             	pushl  0x8(%ebp)
     851:	e8 56 fb ff ff       	call   3ac <keyDown>
     856:	83 c4 10             	add    $0x10,%esp
	break;
     859:	eb 14                	jmp    86f <wndProc+0xba>
	case MSG_PAINT:
	draw(hwnd);
     85b:	83 ec 0c             	sub    $0xc,%esp
     85e:	ff 75 08             	pushl  0x8(%ebp)
     861:	e8 52 fc ff ff       	call   4b8 <draw>
     866:	83 c4 10             	add    $0x10,%esp
	break;
     869:	eb 04                	jmp    86f <wndProc+0xba>
	default:
	break;
     86b:	90                   	nop
     86c:	eb 01                	jmp    86f <wndProc+0xba>
    APSendMessage(hwnd,ms);
    
    return False;
	case MSG_TIMEOUT:
if (status != Run)
	break;
     86e:	90                   	nop
	draw(hwnd);
	break;
	default:
	break;
}
return APWndProc(hwnd,msg);
     86f:	ff 75 14             	pushl  0x14(%ebp)
     872:	ff 75 10             	pushl  0x10(%ebp)
     875:	ff 75 0c             	pushl  0xc(%ebp)
     878:	ff 75 08             	pushl  0x8(%ebp)
     87b:	e8 4c 17 00 00       	call   1fcc <APWndProc>
     880:	83 c4 10             	add    $0x10,%esp

}
     883:	c9                   	leave  
     884:	c3                   	ret    

00000885 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     885:	55                   	push   %ebp
     886:	89 e5                	mov    %esp,%ebp
     888:	57                   	push   %edi
     889:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     88a:	8b 4d 08             	mov    0x8(%ebp),%ecx
     88d:	8b 55 10             	mov    0x10(%ebp),%edx
     890:	8b 45 0c             	mov    0xc(%ebp),%eax
     893:	89 cb                	mov    %ecx,%ebx
     895:	89 df                	mov    %ebx,%edi
     897:	89 d1                	mov    %edx,%ecx
     899:	fc                   	cld    
     89a:	f3 aa                	rep stos %al,%es:(%edi)
     89c:	89 ca                	mov    %ecx,%edx
     89e:	89 fb                	mov    %edi,%ebx
     8a0:	89 5d 08             	mov    %ebx,0x8(%ebp)
     8a3:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     8a6:	90                   	nop
     8a7:	5b                   	pop    %ebx
     8a8:	5f                   	pop    %edi
     8a9:	5d                   	pop    %ebp
     8aa:	c3                   	ret    

000008ab <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     8ab:	55                   	push   %ebp
     8ac:	89 e5                	mov    %esp,%ebp
     8ae:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     8b1:	8b 45 08             	mov    0x8(%ebp),%eax
     8b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     8b7:	90                   	nop
     8b8:	8b 45 08             	mov    0x8(%ebp),%eax
     8bb:	8d 50 01             	lea    0x1(%eax),%edx
     8be:	89 55 08             	mov    %edx,0x8(%ebp)
     8c1:	8b 55 0c             	mov    0xc(%ebp),%edx
     8c4:	8d 4a 01             	lea    0x1(%edx),%ecx
     8c7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     8ca:	0f b6 12             	movzbl (%edx),%edx
     8cd:	88 10                	mov    %dl,(%eax)
     8cf:	0f b6 00             	movzbl (%eax),%eax
     8d2:	84 c0                	test   %al,%al
     8d4:	75 e2                	jne    8b8 <strcpy+0xd>
    ;
  return os;
     8d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     8d9:	c9                   	leave  
     8da:	c3                   	ret    

000008db <strcmp>:

int
strcmp(const char *p, const char *q)
{
     8db:	55                   	push   %ebp
     8dc:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     8de:	eb 08                	jmp    8e8 <strcmp+0xd>
    p++, q++;
     8e0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     8e4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     8e8:	8b 45 08             	mov    0x8(%ebp),%eax
     8eb:	0f b6 00             	movzbl (%eax),%eax
     8ee:	84 c0                	test   %al,%al
     8f0:	74 10                	je     902 <strcmp+0x27>
     8f2:	8b 45 08             	mov    0x8(%ebp),%eax
     8f5:	0f b6 10             	movzbl (%eax),%edx
     8f8:	8b 45 0c             	mov    0xc(%ebp),%eax
     8fb:	0f b6 00             	movzbl (%eax),%eax
     8fe:	38 c2                	cmp    %al,%dl
     900:	74 de                	je     8e0 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     902:	8b 45 08             	mov    0x8(%ebp),%eax
     905:	0f b6 00             	movzbl (%eax),%eax
     908:	0f b6 d0             	movzbl %al,%edx
     90b:	8b 45 0c             	mov    0xc(%ebp),%eax
     90e:	0f b6 00             	movzbl (%eax),%eax
     911:	0f b6 c0             	movzbl %al,%eax
     914:	29 c2                	sub    %eax,%edx
     916:	89 d0                	mov    %edx,%eax
}
     918:	5d                   	pop    %ebp
     919:	c3                   	ret    

0000091a <strlen>:

uint
strlen(char *s)
{
     91a:	55                   	push   %ebp
     91b:	89 e5                	mov    %esp,%ebp
     91d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     920:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     927:	eb 04                	jmp    92d <strlen+0x13>
     929:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     92d:	8b 55 fc             	mov    -0x4(%ebp),%edx
     930:	8b 45 08             	mov    0x8(%ebp),%eax
     933:	01 d0                	add    %edx,%eax
     935:	0f b6 00             	movzbl (%eax),%eax
     938:	84 c0                	test   %al,%al
     93a:	75 ed                	jne    929 <strlen+0xf>
    ;
  return n;
     93c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     93f:	c9                   	leave  
     940:	c3                   	ret    

00000941 <memset>:

void*
memset(void *dst, int c, uint n)
{
     941:	55                   	push   %ebp
     942:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     944:	8b 45 10             	mov    0x10(%ebp),%eax
     947:	50                   	push   %eax
     948:	ff 75 0c             	pushl  0xc(%ebp)
     94b:	ff 75 08             	pushl  0x8(%ebp)
     94e:	e8 32 ff ff ff       	call   885 <stosb>
     953:	83 c4 0c             	add    $0xc,%esp
  return dst;
     956:	8b 45 08             	mov    0x8(%ebp),%eax
}
     959:	c9                   	leave  
     95a:	c3                   	ret    

0000095b <strchr>:

char*
strchr(const char *s, char c)
{
     95b:	55                   	push   %ebp
     95c:	89 e5                	mov    %esp,%ebp
     95e:	83 ec 04             	sub    $0x4,%esp
     961:	8b 45 0c             	mov    0xc(%ebp),%eax
     964:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     967:	eb 14                	jmp    97d <strchr+0x22>
    if(*s == c)
     969:	8b 45 08             	mov    0x8(%ebp),%eax
     96c:	0f b6 00             	movzbl (%eax),%eax
     96f:	3a 45 fc             	cmp    -0x4(%ebp),%al
     972:	75 05                	jne    979 <strchr+0x1e>
      return (char*)s;
     974:	8b 45 08             	mov    0x8(%ebp),%eax
     977:	eb 13                	jmp    98c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     979:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     97d:	8b 45 08             	mov    0x8(%ebp),%eax
     980:	0f b6 00             	movzbl (%eax),%eax
     983:	84 c0                	test   %al,%al
     985:	75 e2                	jne    969 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     987:	b8 00 00 00 00       	mov    $0x0,%eax
}
     98c:	c9                   	leave  
     98d:	c3                   	ret    

0000098e <gets>:

char*
gets(char *buf, int max)
{
     98e:	55                   	push   %ebp
     98f:	89 e5                	mov    %esp,%ebp
     991:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     994:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     99b:	eb 42                	jmp    9df <gets+0x51>
    cc = read(0, &c, 1);
     99d:	83 ec 04             	sub    $0x4,%esp
     9a0:	6a 01                	push   $0x1
     9a2:	8d 45 ef             	lea    -0x11(%ebp),%eax
     9a5:	50                   	push   %eax
     9a6:	6a 00                	push   $0x0
     9a8:	e8 47 01 00 00       	call   af4 <read>
     9ad:	83 c4 10             	add    $0x10,%esp
     9b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     9b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     9b7:	7e 33                	jle    9ec <gets+0x5e>
      break;
    buf[i++] = c;
     9b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9bc:	8d 50 01             	lea    0x1(%eax),%edx
     9bf:	89 55 f4             	mov    %edx,-0xc(%ebp)
     9c2:	89 c2                	mov    %eax,%edx
     9c4:	8b 45 08             	mov    0x8(%ebp),%eax
     9c7:	01 c2                	add    %eax,%edx
     9c9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     9cd:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     9cf:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     9d3:	3c 0a                	cmp    $0xa,%al
     9d5:	74 16                	je     9ed <gets+0x5f>
     9d7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     9db:	3c 0d                	cmp    $0xd,%al
     9dd:	74 0e                	je     9ed <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     9df:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9e2:	83 c0 01             	add    $0x1,%eax
     9e5:	3b 45 0c             	cmp    0xc(%ebp),%eax
     9e8:	7c b3                	jl     99d <gets+0xf>
     9ea:	eb 01                	jmp    9ed <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     9ec:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     9ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
     9f0:	8b 45 08             	mov    0x8(%ebp),%eax
     9f3:	01 d0                	add    %edx,%eax
     9f5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     9f8:	8b 45 08             	mov    0x8(%ebp),%eax
}
     9fb:	c9                   	leave  
     9fc:	c3                   	ret    

000009fd <stat>:

int
stat(char *n, struct stat *st)
{
     9fd:	55                   	push   %ebp
     9fe:	89 e5                	mov    %esp,%ebp
     a00:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     a03:	83 ec 08             	sub    $0x8,%esp
     a06:	6a 00                	push   $0x0
     a08:	ff 75 08             	pushl  0x8(%ebp)
     a0b:	e8 0c 01 00 00       	call   b1c <open>
     a10:	83 c4 10             	add    $0x10,%esp
     a13:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     a16:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a1a:	79 07                	jns    a23 <stat+0x26>
    return -1;
     a1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a21:	eb 25                	jmp    a48 <stat+0x4b>
  r = fstat(fd, st);
     a23:	83 ec 08             	sub    $0x8,%esp
     a26:	ff 75 0c             	pushl  0xc(%ebp)
     a29:	ff 75 f4             	pushl  -0xc(%ebp)
     a2c:	e8 03 01 00 00       	call   b34 <fstat>
     a31:	83 c4 10             	add    $0x10,%esp
     a34:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     a37:	83 ec 0c             	sub    $0xc,%esp
     a3a:	ff 75 f4             	pushl  -0xc(%ebp)
     a3d:	e8 c2 00 00 00       	call   b04 <close>
     a42:	83 c4 10             	add    $0x10,%esp
  return r;
     a45:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     a48:	c9                   	leave  
     a49:	c3                   	ret    

00000a4a <atoi>:

int
atoi(const char *s)
{
     a4a:	55                   	push   %ebp
     a4b:	89 e5                	mov    %esp,%ebp
     a4d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     a50:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     a57:	eb 25                	jmp    a7e <atoi+0x34>
    n = n*10 + *s++ - '0';
     a59:	8b 55 fc             	mov    -0x4(%ebp),%edx
     a5c:	89 d0                	mov    %edx,%eax
     a5e:	c1 e0 02             	shl    $0x2,%eax
     a61:	01 d0                	add    %edx,%eax
     a63:	01 c0                	add    %eax,%eax
     a65:	89 c1                	mov    %eax,%ecx
     a67:	8b 45 08             	mov    0x8(%ebp),%eax
     a6a:	8d 50 01             	lea    0x1(%eax),%edx
     a6d:	89 55 08             	mov    %edx,0x8(%ebp)
     a70:	0f b6 00             	movzbl (%eax),%eax
     a73:	0f be c0             	movsbl %al,%eax
     a76:	01 c8                	add    %ecx,%eax
     a78:	83 e8 30             	sub    $0x30,%eax
     a7b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     a7e:	8b 45 08             	mov    0x8(%ebp),%eax
     a81:	0f b6 00             	movzbl (%eax),%eax
     a84:	3c 2f                	cmp    $0x2f,%al
     a86:	7e 0a                	jle    a92 <atoi+0x48>
     a88:	8b 45 08             	mov    0x8(%ebp),%eax
     a8b:	0f b6 00             	movzbl (%eax),%eax
     a8e:	3c 39                	cmp    $0x39,%al
     a90:	7e c7                	jle    a59 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     a92:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     a95:	c9                   	leave  
     a96:	c3                   	ret    

00000a97 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     a97:	55                   	push   %ebp
     a98:	89 e5                	mov    %esp,%ebp
     a9a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     a9d:	8b 45 08             	mov    0x8(%ebp),%eax
     aa0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     aa3:	8b 45 0c             	mov    0xc(%ebp),%eax
     aa6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     aa9:	eb 17                	jmp    ac2 <memmove+0x2b>
    *dst++ = *src++;
     aab:	8b 45 fc             	mov    -0x4(%ebp),%eax
     aae:	8d 50 01             	lea    0x1(%eax),%edx
     ab1:	89 55 fc             	mov    %edx,-0x4(%ebp)
     ab4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ab7:	8d 4a 01             	lea    0x1(%edx),%ecx
     aba:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     abd:	0f b6 12             	movzbl (%edx),%edx
     ac0:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     ac2:	8b 45 10             	mov    0x10(%ebp),%eax
     ac5:	8d 50 ff             	lea    -0x1(%eax),%edx
     ac8:	89 55 10             	mov    %edx,0x10(%ebp)
     acb:	85 c0                	test   %eax,%eax
     acd:	7f dc                	jg     aab <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     acf:	8b 45 08             	mov    0x8(%ebp),%eax
}
     ad2:	c9                   	leave  
     ad3:	c3                   	ret    

00000ad4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     ad4:	b8 01 00 00 00       	mov    $0x1,%eax
     ad9:	cd 40                	int    $0x40
     adb:	c3                   	ret    

00000adc <exit>:
SYSCALL(exit)
     adc:	b8 02 00 00 00       	mov    $0x2,%eax
     ae1:	cd 40                	int    $0x40
     ae3:	c3                   	ret    

00000ae4 <wait>:
SYSCALL(wait)
     ae4:	b8 03 00 00 00       	mov    $0x3,%eax
     ae9:	cd 40                	int    $0x40
     aeb:	c3                   	ret    

00000aec <pipe>:
SYSCALL(pipe)
     aec:	b8 04 00 00 00       	mov    $0x4,%eax
     af1:	cd 40                	int    $0x40
     af3:	c3                   	ret    

00000af4 <read>:
SYSCALL(read)
     af4:	b8 05 00 00 00       	mov    $0x5,%eax
     af9:	cd 40                	int    $0x40
     afb:	c3                   	ret    

00000afc <write>:
SYSCALL(write)
     afc:	b8 10 00 00 00       	mov    $0x10,%eax
     b01:	cd 40                	int    $0x40
     b03:	c3                   	ret    

00000b04 <close>:
SYSCALL(close)
     b04:	b8 15 00 00 00       	mov    $0x15,%eax
     b09:	cd 40                	int    $0x40
     b0b:	c3                   	ret    

00000b0c <kill>:
SYSCALL(kill)
     b0c:	b8 06 00 00 00       	mov    $0x6,%eax
     b11:	cd 40                	int    $0x40
     b13:	c3                   	ret    

00000b14 <exec>:
SYSCALL(exec)
     b14:	b8 07 00 00 00       	mov    $0x7,%eax
     b19:	cd 40                	int    $0x40
     b1b:	c3                   	ret    

00000b1c <open>:
SYSCALL(open)
     b1c:	b8 0f 00 00 00       	mov    $0xf,%eax
     b21:	cd 40                	int    $0x40
     b23:	c3                   	ret    

00000b24 <mknod>:
SYSCALL(mknod)
     b24:	b8 11 00 00 00       	mov    $0x11,%eax
     b29:	cd 40                	int    $0x40
     b2b:	c3                   	ret    

00000b2c <unlink>:
SYSCALL(unlink)
     b2c:	b8 12 00 00 00       	mov    $0x12,%eax
     b31:	cd 40                	int    $0x40
     b33:	c3                   	ret    

00000b34 <fstat>:
SYSCALL(fstat)
     b34:	b8 08 00 00 00       	mov    $0x8,%eax
     b39:	cd 40                	int    $0x40
     b3b:	c3                   	ret    

00000b3c <link>:
SYSCALL(link)
     b3c:	b8 13 00 00 00       	mov    $0x13,%eax
     b41:	cd 40                	int    $0x40
     b43:	c3                   	ret    

00000b44 <mkdir>:
SYSCALL(mkdir)
     b44:	b8 14 00 00 00       	mov    $0x14,%eax
     b49:	cd 40                	int    $0x40
     b4b:	c3                   	ret    

00000b4c <chdir>:
SYSCALL(chdir)
     b4c:	b8 09 00 00 00       	mov    $0x9,%eax
     b51:	cd 40                	int    $0x40
     b53:	c3                   	ret    

00000b54 <dup>:
SYSCALL(dup)
     b54:	b8 0a 00 00 00       	mov    $0xa,%eax
     b59:	cd 40                	int    $0x40
     b5b:	c3                   	ret    

00000b5c <getpid>:
SYSCALL(getpid)
     b5c:	b8 0b 00 00 00       	mov    $0xb,%eax
     b61:	cd 40                	int    $0x40
     b63:	c3                   	ret    

00000b64 <sbrk>:
SYSCALL(sbrk)
     b64:	b8 0c 00 00 00       	mov    $0xc,%eax
     b69:	cd 40                	int    $0x40
     b6b:	c3                   	ret    

00000b6c <sleep>:
SYSCALL(sleep)
     b6c:	b8 0d 00 00 00       	mov    $0xd,%eax
     b71:	cd 40                	int    $0x40
     b73:	c3                   	ret    

00000b74 <uptime>:
SYSCALL(uptime)
     b74:	b8 0e 00 00 00       	mov    $0xe,%eax
     b79:	cd 40                	int    $0x40
     b7b:	c3                   	ret    

00000b7c <paintWindow>:

SYSCALL(paintWindow)
     b7c:	b8 16 00 00 00       	mov    $0x16,%eax
     b81:	cd 40                	int    $0x40
     b83:	c3                   	ret    

00000b84 <sendMessage>:
SYSCALL(sendMessage)
     b84:	b8 17 00 00 00       	mov    $0x17,%eax
     b89:	cd 40                	int    $0x40
     b8b:	c3                   	ret    

00000b8c <getMessage>:
SYSCALL(getMessage)
     b8c:	b8 19 00 00 00       	mov    $0x19,%eax
     b91:	cd 40                	int    $0x40
     b93:	c3                   	ret    

00000b94 <registWindow>:
SYSCALL(registWindow)
     b94:	b8 18 00 00 00       	mov    $0x18,%eax
     b99:	cd 40                	int    $0x40
     b9b:	c3                   	ret    

00000b9c <changePosition>:
SYSCALL(changePosition)
     b9c:	b8 1a 00 00 00       	mov    $0x1a,%eax
     ba1:	cd 40                	int    $0x40
     ba3:	c3                   	ret    

00000ba4 <setupTimer>:
SYSCALL(setupTimer)
     ba4:	b8 1b 00 00 00       	mov    $0x1b,%eax
     ba9:	cd 40                	int    $0x40
     bab:	c3                   	ret    

00000bac <deleteTimer>:
SYSCALL(deleteTimer)
     bac:	b8 1c 00 00 00       	mov    $0x1c,%eax
     bb1:	cd 40                	int    $0x40
     bb3:	c3                   	ret    

00000bb4 <getCurrentTime>:
SYSCALL(getCurrentTime)
     bb4:	b8 1d 00 00 00       	mov    $0x1d,%eax
     bb9:	cd 40                	int    $0x40
     bbb:	c3                   	ret    

00000bbc <removeWindow>:
SYSCALL(removeWindow)
     bbc:	b8 1e 00 00 00       	mov    $0x1e,%eax
     bc1:	cd 40                	int    $0x40
     bc3:	c3                   	ret    

00000bc4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     bc4:	55                   	push   %ebp
     bc5:	89 e5                	mov    %esp,%ebp
     bc7:	83 ec 18             	sub    $0x18,%esp
     bca:	8b 45 0c             	mov    0xc(%ebp),%eax
     bcd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     bd0:	83 ec 04             	sub    $0x4,%esp
     bd3:	6a 01                	push   $0x1
     bd5:	8d 45 f4             	lea    -0xc(%ebp),%eax
     bd8:	50                   	push   %eax
     bd9:	ff 75 08             	pushl  0x8(%ebp)
     bdc:	e8 1b ff ff ff       	call   afc <write>
     be1:	83 c4 10             	add    $0x10,%esp
}
     be4:	90                   	nop
     be5:	c9                   	leave  
     be6:	c3                   	ret    

00000be7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     be7:	55                   	push   %ebp
     be8:	89 e5                	mov    %esp,%ebp
     bea:	53                   	push   %ebx
     beb:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     bee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     bf5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     bf9:	74 17                	je     c12 <printint+0x2b>
     bfb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     bff:	79 11                	jns    c12 <printint+0x2b>
    neg = 1;
     c01:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     c08:	8b 45 0c             	mov    0xc(%ebp),%eax
     c0b:	f7 d8                	neg    %eax
     c0d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     c10:	eb 06                	jmp    c18 <printint+0x31>
  } else {
    x = xx;
     c12:	8b 45 0c             	mov    0xc(%ebp),%eax
     c15:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     c18:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     c1f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     c22:	8d 41 01             	lea    0x1(%ecx),%eax
     c25:	89 45 f4             	mov    %eax,-0xc(%ebp)
     c28:	8b 5d 10             	mov    0x10(%ebp),%ebx
     c2b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c2e:	ba 00 00 00 00       	mov    $0x0,%edx
     c33:	f7 f3                	div    %ebx
     c35:	89 d0                	mov    %edx,%eax
     c37:	0f b6 80 60 35 00 00 	movzbl 0x3560(%eax),%eax
     c3e:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     c42:	8b 5d 10             	mov    0x10(%ebp),%ebx
     c45:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c48:	ba 00 00 00 00       	mov    $0x0,%edx
     c4d:	f7 f3                	div    %ebx
     c4f:	89 45 ec             	mov    %eax,-0x14(%ebp)
     c52:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     c56:	75 c7                	jne    c1f <printint+0x38>
  if(neg)
     c58:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     c5c:	74 2d                	je     c8b <printint+0xa4>
    buf[i++] = '-';
     c5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c61:	8d 50 01             	lea    0x1(%eax),%edx
     c64:	89 55 f4             	mov    %edx,-0xc(%ebp)
     c67:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     c6c:	eb 1d                	jmp    c8b <printint+0xa4>
    putc(fd, buf[i]);
     c6e:	8d 55 dc             	lea    -0x24(%ebp),%edx
     c71:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c74:	01 d0                	add    %edx,%eax
     c76:	0f b6 00             	movzbl (%eax),%eax
     c79:	0f be c0             	movsbl %al,%eax
     c7c:	83 ec 08             	sub    $0x8,%esp
     c7f:	50                   	push   %eax
     c80:	ff 75 08             	pushl  0x8(%ebp)
     c83:	e8 3c ff ff ff       	call   bc4 <putc>
     c88:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     c8b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     c8f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c93:	79 d9                	jns    c6e <printint+0x87>
    putc(fd, buf[i]);
}
     c95:	90                   	nop
     c96:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c99:	c9                   	leave  
     c9a:	c3                   	ret    

00000c9b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     c9b:	55                   	push   %ebp
     c9c:	89 e5                	mov    %esp,%ebp
     c9e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     ca1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     ca8:	8d 45 0c             	lea    0xc(%ebp),%eax
     cab:	83 c0 04             	add    $0x4,%eax
     cae:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     cb1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     cb8:	e9 59 01 00 00       	jmp    e16 <printf+0x17b>
    c = fmt[i] & 0xff;
     cbd:	8b 55 0c             	mov    0xc(%ebp),%edx
     cc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cc3:	01 d0                	add    %edx,%eax
     cc5:	0f b6 00             	movzbl (%eax),%eax
     cc8:	0f be c0             	movsbl %al,%eax
     ccb:	25 ff 00 00 00       	and    $0xff,%eax
     cd0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     cd3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     cd7:	75 2c                	jne    d05 <printf+0x6a>
      if(c == '%'){
     cd9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     cdd:	75 0c                	jne    ceb <printf+0x50>
        state = '%';
     cdf:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     ce6:	e9 27 01 00 00       	jmp    e12 <printf+0x177>
      } else {
        putc(fd, c);
     ceb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cee:	0f be c0             	movsbl %al,%eax
     cf1:	83 ec 08             	sub    $0x8,%esp
     cf4:	50                   	push   %eax
     cf5:	ff 75 08             	pushl  0x8(%ebp)
     cf8:	e8 c7 fe ff ff       	call   bc4 <putc>
     cfd:	83 c4 10             	add    $0x10,%esp
     d00:	e9 0d 01 00 00       	jmp    e12 <printf+0x177>
      }
    } else if(state == '%'){
     d05:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     d09:	0f 85 03 01 00 00    	jne    e12 <printf+0x177>
      if(c == 'd'){
     d0f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     d13:	75 1e                	jne    d33 <printf+0x98>
        printint(fd, *ap, 10, 1);
     d15:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d18:	8b 00                	mov    (%eax),%eax
     d1a:	6a 01                	push   $0x1
     d1c:	6a 0a                	push   $0xa
     d1e:	50                   	push   %eax
     d1f:	ff 75 08             	pushl  0x8(%ebp)
     d22:	e8 c0 fe ff ff       	call   be7 <printint>
     d27:	83 c4 10             	add    $0x10,%esp
        ap++;
     d2a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     d2e:	e9 d8 00 00 00       	jmp    e0b <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     d33:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     d37:	74 06                	je     d3f <printf+0xa4>
     d39:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     d3d:	75 1e                	jne    d5d <printf+0xc2>
        printint(fd, *ap, 16, 0);
     d3f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d42:	8b 00                	mov    (%eax),%eax
     d44:	6a 00                	push   $0x0
     d46:	6a 10                	push   $0x10
     d48:	50                   	push   %eax
     d49:	ff 75 08             	pushl  0x8(%ebp)
     d4c:	e8 96 fe ff ff       	call   be7 <printint>
     d51:	83 c4 10             	add    $0x10,%esp
        ap++;
     d54:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     d58:	e9 ae 00 00 00       	jmp    e0b <printf+0x170>
      } else if(c == 's'){
     d5d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     d61:	75 43                	jne    da6 <printf+0x10b>
        s = (char*)*ap;
     d63:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d66:	8b 00                	mov    (%eax),%eax
     d68:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     d6b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     d6f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     d73:	75 25                	jne    d9a <printf+0xff>
          s = "(null)";
     d75:	c7 45 f4 14 2d 00 00 	movl   $0x2d14,-0xc(%ebp)
        while(*s != 0){
     d7c:	eb 1c                	jmp    d9a <printf+0xff>
          putc(fd, *s);
     d7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d81:	0f b6 00             	movzbl (%eax),%eax
     d84:	0f be c0             	movsbl %al,%eax
     d87:	83 ec 08             	sub    $0x8,%esp
     d8a:	50                   	push   %eax
     d8b:	ff 75 08             	pushl  0x8(%ebp)
     d8e:	e8 31 fe ff ff       	call   bc4 <putc>
     d93:	83 c4 10             	add    $0x10,%esp
          s++;
     d96:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     d9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d9d:	0f b6 00             	movzbl (%eax),%eax
     da0:	84 c0                	test   %al,%al
     da2:	75 da                	jne    d7e <printf+0xe3>
     da4:	eb 65                	jmp    e0b <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     da6:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     daa:	75 1d                	jne    dc9 <printf+0x12e>
        putc(fd, *ap);
     dac:	8b 45 e8             	mov    -0x18(%ebp),%eax
     daf:	8b 00                	mov    (%eax),%eax
     db1:	0f be c0             	movsbl %al,%eax
     db4:	83 ec 08             	sub    $0x8,%esp
     db7:	50                   	push   %eax
     db8:	ff 75 08             	pushl  0x8(%ebp)
     dbb:	e8 04 fe ff ff       	call   bc4 <putc>
     dc0:	83 c4 10             	add    $0x10,%esp
        ap++;
     dc3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     dc7:	eb 42                	jmp    e0b <printf+0x170>
      } else if(c == '%'){
     dc9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     dcd:	75 17                	jne    de6 <printf+0x14b>
        putc(fd, c);
     dcf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     dd2:	0f be c0             	movsbl %al,%eax
     dd5:	83 ec 08             	sub    $0x8,%esp
     dd8:	50                   	push   %eax
     dd9:	ff 75 08             	pushl  0x8(%ebp)
     ddc:	e8 e3 fd ff ff       	call   bc4 <putc>
     de1:	83 c4 10             	add    $0x10,%esp
     de4:	eb 25                	jmp    e0b <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     de6:	83 ec 08             	sub    $0x8,%esp
     de9:	6a 25                	push   $0x25
     deb:	ff 75 08             	pushl  0x8(%ebp)
     dee:	e8 d1 fd ff ff       	call   bc4 <putc>
     df3:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     df6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     df9:	0f be c0             	movsbl %al,%eax
     dfc:	83 ec 08             	sub    $0x8,%esp
     dff:	50                   	push   %eax
     e00:	ff 75 08             	pushl  0x8(%ebp)
     e03:	e8 bc fd ff ff       	call   bc4 <putc>
     e08:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     e0b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e12:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e16:	8b 55 0c             	mov    0xc(%ebp),%edx
     e19:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e1c:	01 d0                	add    %edx,%eax
     e1e:	0f b6 00             	movzbl (%eax),%eax
     e21:	84 c0                	test   %al,%al
     e23:	0f 85 94 fe ff ff    	jne    cbd <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     e29:	90                   	nop
     e2a:	c9                   	leave  
     e2b:	c3                   	ret    

00000e2c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e2c:	55                   	push   %ebp
     e2d:	89 e5                	mov    %esp,%ebp
     e2f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e32:	8b 45 08             	mov    0x8(%ebp),%eax
     e35:	83 e8 08             	sub    $0x8,%eax
     e38:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e3b:	a1 c8 71 00 00       	mov    0x71c8,%eax
     e40:	89 45 fc             	mov    %eax,-0x4(%ebp)
     e43:	eb 24                	jmp    e69 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e45:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e48:	8b 00                	mov    (%eax),%eax
     e4a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e4d:	77 12                	ja     e61 <free+0x35>
     e4f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e52:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e55:	77 24                	ja     e7b <free+0x4f>
     e57:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e5a:	8b 00                	mov    (%eax),%eax
     e5c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     e5f:	77 1a                	ja     e7b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e61:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e64:	8b 00                	mov    (%eax),%eax
     e66:	89 45 fc             	mov    %eax,-0x4(%ebp)
     e69:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e6c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e6f:	76 d4                	jbe    e45 <free+0x19>
     e71:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e74:	8b 00                	mov    (%eax),%eax
     e76:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     e79:	76 ca                	jbe    e45 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     e7b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e7e:	8b 40 04             	mov    0x4(%eax),%eax
     e81:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     e88:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e8b:	01 c2                	add    %eax,%edx
     e8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e90:	8b 00                	mov    (%eax),%eax
     e92:	39 c2                	cmp    %eax,%edx
     e94:	75 24                	jne    eba <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     e96:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e99:	8b 50 04             	mov    0x4(%eax),%edx
     e9c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e9f:	8b 00                	mov    (%eax),%eax
     ea1:	8b 40 04             	mov    0x4(%eax),%eax
     ea4:	01 c2                	add    %eax,%edx
     ea6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ea9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     eac:	8b 45 fc             	mov    -0x4(%ebp),%eax
     eaf:	8b 00                	mov    (%eax),%eax
     eb1:	8b 10                	mov    (%eax),%edx
     eb3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     eb6:	89 10                	mov    %edx,(%eax)
     eb8:	eb 0a                	jmp    ec4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     eba:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ebd:	8b 10                	mov    (%eax),%edx
     ebf:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ec2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     ec4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ec7:	8b 40 04             	mov    0x4(%eax),%eax
     eca:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     ed1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ed4:	01 d0                	add    %edx,%eax
     ed6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     ed9:	75 20                	jne    efb <free+0xcf>
    p->s.size += bp->s.size;
     edb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ede:	8b 50 04             	mov    0x4(%eax),%edx
     ee1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ee4:	8b 40 04             	mov    0x4(%eax),%eax
     ee7:	01 c2                	add    %eax,%edx
     ee9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     eec:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     eef:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ef2:	8b 10                	mov    (%eax),%edx
     ef4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ef7:	89 10                	mov    %edx,(%eax)
     ef9:	eb 08                	jmp    f03 <free+0xd7>
  } else
    p->s.ptr = bp;
     efb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     efe:	8b 55 f8             	mov    -0x8(%ebp),%edx
     f01:	89 10                	mov    %edx,(%eax)
  freep = p;
     f03:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f06:	a3 c8 71 00 00       	mov    %eax,0x71c8
}
     f0b:	90                   	nop
     f0c:	c9                   	leave  
     f0d:	c3                   	ret    

00000f0e <morecore>:

static Header*
morecore(uint nu)
{
     f0e:	55                   	push   %ebp
     f0f:	89 e5                	mov    %esp,%ebp
     f11:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     f14:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     f1b:	77 07                	ja     f24 <morecore+0x16>
    nu = 4096;
     f1d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     f24:	8b 45 08             	mov    0x8(%ebp),%eax
     f27:	c1 e0 03             	shl    $0x3,%eax
     f2a:	83 ec 0c             	sub    $0xc,%esp
     f2d:	50                   	push   %eax
     f2e:	e8 31 fc ff ff       	call   b64 <sbrk>
     f33:	83 c4 10             	add    $0x10,%esp
     f36:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     f39:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     f3d:	75 07                	jne    f46 <morecore+0x38>
    return 0;
     f3f:	b8 00 00 00 00       	mov    $0x0,%eax
     f44:	eb 26                	jmp    f6c <morecore+0x5e>
  hp = (Header*)p;
     f46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f49:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     f4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f4f:	8b 55 08             	mov    0x8(%ebp),%edx
     f52:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     f55:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f58:	83 c0 08             	add    $0x8,%eax
     f5b:	83 ec 0c             	sub    $0xc,%esp
     f5e:	50                   	push   %eax
     f5f:	e8 c8 fe ff ff       	call   e2c <free>
     f64:	83 c4 10             	add    $0x10,%esp
  return freep;
     f67:	a1 c8 71 00 00       	mov    0x71c8,%eax
}
     f6c:	c9                   	leave  
     f6d:	c3                   	ret    

00000f6e <malloc>:

void*
malloc(uint nbytes)
{
     f6e:	55                   	push   %ebp
     f6f:	89 e5                	mov    %esp,%ebp
     f71:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f74:	8b 45 08             	mov    0x8(%ebp),%eax
     f77:	83 c0 07             	add    $0x7,%eax
     f7a:	c1 e8 03             	shr    $0x3,%eax
     f7d:	83 c0 01             	add    $0x1,%eax
     f80:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     f83:	a1 c8 71 00 00       	mov    0x71c8,%eax
     f88:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f8b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     f8f:	75 23                	jne    fb4 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     f91:	c7 45 f0 c0 71 00 00 	movl   $0x71c0,-0x10(%ebp)
     f98:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f9b:	a3 c8 71 00 00       	mov    %eax,0x71c8
     fa0:	a1 c8 71 00 00       	mov    0x71c8,%eax
     fa5:	a3 c0 71 00 00       	mov    %eax,0x71c0
    base.s.size = 0;
     faa:	c7 05 c4 71 00 00 00 	movl   $0x0,0x71c4
     fb1:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fb4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fb7:	8b 00                	mov    (%eax),%eax
     fb9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     fbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fbf:	8b 40 04             	mov    0x4(%eax),%eax
     fc2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     fc5:	72 4d                	jb     1014 <malloc+0xa6>
      if(p->s.size == nunits)
     fc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fca:	8b 40 04             	mov    0x4(%eax),%eax
     fcd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     fd0:	75 0c                	jne    fde <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     fd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fd5:	8b 10                	mov    (%eax),%edx
     fd7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fda:	89 10                	mov    %edx,(%eax)
     fdc:	eb 26                	jmp    1004 <malloc+0x96>
      else {
        p->s.size -= nunits;
     fde:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fe1:	8b 40 04             	mov    0x4(%eax),%eax
     fe4:	2b 45 ec             	sub    -0x14(%ebp),%eax
     fe7:	89 c2                	mov    %eax,%edx
     fe9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fec:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     fef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ff2:	8b 40 04             	mov    0x4(%eax),%eax
     ff5:	c1 e0 03             	shl    $0x3,%eax
     ff8:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     ffb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ffe:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1001:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1004:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1007:	a3 c8 71 00 00       	mov    %eax,0x71c8
      return (void*)(p + 1);
    100c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    100f:	83 c0 08             	add    $0x8,%eax
    1012:	eb 3b                	jmp    104f <malloc+0xe1>
    }
    if(p == freep)
    1014:	a1 c8 71 00 00       	mov    0x71c8,%eax
    1019:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    101c:	75 1e                	jne    103c <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    101e:	83 ec 0c             	sub    $0xc,%esp
    1021:	ff 75 ec             	pushl  -0x14(%ebp)
    1024:	e8 e5 fe ff ff       	call   f0e <morecore>
    1029:	83 c4 10             	add    $0x10,%esp
    102c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    102f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1033:	75 07                	jne    103c <malloc+0xce>
        return 0;
    1035:	b8 00 00 00 00       	mov    $0x0,%eax
    103a:	eb 13                	jmp    104f <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    103c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    103f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1042:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1045:	8b 00                	mov    (%eax),%eax
    1047:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    104a:	e9 6d ff ff ff       	jmp    fbc <malloc+0x4e>
}
    104f:	c9                   	leave  
    1050:	c3                   	ret    

00001051 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1051:	55                   	push   %ebp
    1052:	89 e5                	mov    %esp,%ebp
    1054:	83 ec 1c             	sub    $0x1c,%esp
    1057:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    105a:	8b 55 10             	mov    0x10(%ebp),%edx
    105d:	8b 45 14             	mov    0x14(%ebp),%eax
    1060:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1063:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1066:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1069:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    106d:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1070:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1074:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1077:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    107b:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    107e:	8b 45 08             	mov    0x8(%ebp),%eax
    1081:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1085:	66 89 10             	mov    %dx,(%eax)
    1088:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    108c:	88 50 02             	mov    %dl,0x2(%eax)
}
    108f:	8b 45 08             	mov    0x8(%ebp),%eax
    1092:	c9                   	leave  
    1093:	c2 04 00             	ret    $0x4

00001096 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    1096:	55                   	push   %ebp
    1097:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
    1099:	8b 45 08             	mov    0x8(%ebp),%eax
    109c:	2b 45 10             	sub    0x10(%ebp),%eax
    109f:	89 c2                	mov    %eax,%edx
    10a1:	8b 45 08             	mov    0x8(%ebp),%eax
    10a4:	2b 45 10             	sub    0x10(%ebp),%eax
    10a7:	0f af d0             	imul   %eax,%edx
    10aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ad:	2b 45 14             	sub    0x14(%ebp),%eax
    10b0:	89 c1                	mov    %eax,%ecx
    10b2:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b5:	2b 45 14             	sub    0x14(%ebp),%eax
    10b8:	0f af c1             	imul   %ecx,%eax
    10bb:	01 d0                	add    %edx,%eax
}
    10bd:	5d                   	pop    %ebp
    10be:	c3                   	ret    

000010bf <abs_int>:

static inline int abs_int(int x)
{
    10bf:	55                   	push   %ebp
    10c0:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
    10c2:	8b 45 08             	mov    0x8(%ebp),%eax
    10c5:	99                   	cltd   
    10c6:	89 d0                	mov    %edx,%eax
    10c8:	33 45 08             	xor    0x8(%ebp),%eax
    10cb:	29 d0                	sub    %edx,%eax
}
    10cd:	5d                   	pop    %ebp
    10ce:	c3                   	ret    

000010cf <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    10cf:	55                   	push   %ebp
    10d0:	89 e5                	mov    %esp,%ebp
    if (x < 0)
    10d2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10d6:	79 07                	jns    10df <APGetIndex+0x10>
        return X_SMALLER;
    10d8:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    10dd:	eb 40                	jmp    111f <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
    10df:	8b 45 08             	mov    0x8(%ebp),%eax
    10e2:	8b 00                	mov    (%eax),%eax
    10e4:	3b 45 0c             	cmp    0xc(%ebp),%eax
    10e7:	7f 07                	jg     10f0 <APGetIndex+0x21>
        return X_BIGGER;
    10e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    10ee:	eb 2f                	jmp    111f <APGetIndex+0x50>
    if (y < 0)
    10f0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    10f4:	79 07                	jns    10fd <APGetIndex+0x2e>
        return Y_SMALLER;
    10f6:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
    10fb:	eb 22                	jmp    111f <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
    10fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1100:	8b 40 04             	mov    0x4(%eax),%eax
    1103:	3b 45 10             	cmp    0x10(%ebp),%eax
    1106:	7f 07                	jg     110f <APGetIndex+0x40>
        return Y_BIGGER;
    1108:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    110d:	eb 10                	jmp    111f <APGetIndex+0x50>
    return y * hdc->size.cx + x;
    110f:	8b 45 08             	mov    0x8(%ebp),%eax
    1112:	8b 00                	mov    (%eax),%eax
    1114:	0f af 45 10          	imul   0x10(%ebp),%eax
    1118:	89 c2                	mov    %eax,%edx
    111a:	8b 45 0c             	mov    0xc(%ebp),%eax
    111d:	01 d0                	add    %edx,%eax
}
    111f:	5d                   	pop    %ebp
    1120:	c3                   	ret    

00001121 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    1121:	55                   	push   %ebp
    1122:	89 e5                	mov    %esp,%ebp
    1124:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    1127:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    112e:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1131:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    1134:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    113b:	83 ec 08             	sub    $0x8,%esp
    113e:	6a 00                	push   $0x0
    1140:	ff 75 0c             	pushl  0xc(%ebp)
    1143:	e8 d4 f9 ff ff       	call   b1c <open>
    1148:	83 c4 10             	add    $0x10,%esp
    114b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    114e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1152:	79 2e                	jns    1182 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
    1154:	83 ec 04             	sub    $0x4,%esp
    1157:	ff 75 0c             	pushl  0xc(%ebp)
    115a:	68 1b 2d 00 00       	push   $0x2d1b
    115f:	6a 01                	push   $0x1
    1161:	e8 35 fb ff ff       	call   c9b <printf>
    1166:	83 c4 10             	add    $0x10,%esp
        return bmp;
    1169:	8b 45 08             	mov    0x8(%ebp),%eax
    116c:	8b 55 c8             	mov    -0x38(%ebp),%edx
    116f:	89 10                	mov    %edx,(%eax)
    1171:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1174:	89 50 04             	mov    %edx,0x4(%eax)
    1177:	8b 55 d0             	mov    -0x30(%ebp),%edx
    117a:	89 50 08             	mov    %edx,0x8(%eax)
    117d:	e9 d2 01 00 00       	jmp    1354 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    1182:	83 ec 04             	sub    $0x4,%esp
    1185:	6a 0e                	push   $0xe
    1187:	8d 45 ba             	lea    -0x46(%ebp),%eax
    118a:	50                   	push   %eax
    118b:	ff 75 ec             	pushl  -0x14(%ebp)
    118e:	e8 61 f9 ff ff       	call   af4 <read>
    1193:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    1196:	83 ec 04             	sub    $0x4,%esp
    1199:	6a 28                	push   $0x28
    119b:	8d 45 92             	lea    -0x6e(%ebp),%eax
    119e:	50                   	push   %eax
    119f:	ff 75 ec             	pushl  -0x14(%ebp)
    11a2:	e8 4d f9 ff ff       	call   af4 <read>
    11a7:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    11aa:	8b 45 96             	mov    -0x6a(%ebp),%eax
    11ad:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    11b0:	8b 45 9a             	mov    -0x66(%ebp),%eax
    11b3:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    11b6:	8b 55 c8             	mov    -0x38(%ebp),%edx
    11b9:	8b 45 cc             	mov    -0x34(%ebp),%eax
    11bc:	0f af d0             	imul   %eax,%edx
    11bf:	89 d0                	mov    %edx,%eax
    11c1:	01 c0                	add    %eax,%eax
    11c3:	01 d0                	add    %edx,%eax
    11c5:	83 ec 0c             	sub    $0xc,%esp
    11c8:	50                   	push   %eax
    11c9:	e8 a0 fd ff ff       	call   f6e <malloc>
    11ce:	83 c4 10             	add    $0x10,%esp
    11d1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    11d4:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    11d8:	0f b7 c0             	movzwl %ax,%eax
    11db:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    11de:	8b 55 c8             	mov    -0x38(%ebp),%edx
    11e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11e4:	0f af c2             	imul   %edx,%eax
    11e7:	83 c0 1f             	add    $0x1f,%eax
    11ea:	c1 e8 05             	shr    $0x5,%eax
    11ed:	c1 e0 02             	shl    $0x2,%eax
    11f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    11f3:	8b 55 cc             	mov    -0x34(%ebp),%edx
    11f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11f9:	0f af c2             	imul   %edx,%eax
    11fc:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    11ff:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1202:	83 ec 0c             	sub    $0xc,%esp
    1205:	50                   	push   %eax
    1206:	e8 63 fd ff ff       	call   f6e <malloc>
    120b:	83 c4 10             	add    $0x10,%esp
    120e:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    1211:	83 ec 04             	sub    $0x4,%esp
    1214:	ff 75 e0             	pushl  -0x20(%ebp)
    1217:	ff 75 dc             	pushl  -0x24(%ebp)
    121a:	ff 75 ec             	pushl  -0x14(%ebp)
    121d:	e8 d2 f8 ff ff       	call   af4 <read>
    1222:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    1225:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    1229:	66 c1 e8 03          	shr    $0x3,%ax
    122d:	0f b7 c0             	movzwl %ax,%eax
    1230:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    1233:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    123a:	e9 e5 00 00 00       	jmp    1324 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    123f:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1242:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1245:	29 c2                	sub    %eax,%edx
    1247:	89 d0                	mov    %edx,%eax
    1249:	8d 50 ff             	lea    -0x1(%eax),%edx
    124c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    124f:	0f af c2             	imul   %edx,%eax
    1252:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    1255:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    125c:	e9 b1 00 00 00       	jmp    1312 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    1261:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1264:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1267:	8b 45 f0             	mov    -0x10(%ebp),%eax
    126a:	01 c8                	add    %ecx,%eax
    126c:	89 c1                	mov    %eax,%ecx
    126e:	89 c8                	mov    %ecx,%eax
    1270:	01 c0                	add    %eax,%eax
    1272:	01 c8                	add    %ecx,%eax
    1274:	01 c2                	add    %eax,%edx
    1276:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1279:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    127d:	89 c1                	mov    %eax,%ecx
    127f:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1282:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1286:	01 c1                	add    %eax,%ecx
    1288:	8b 45 d8             	mov    -0x28(%ebp),%eax
    128b:	01 c8                	add    %ecx,%eax
    128d:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1290:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1293:	01 c8                	add    %ecx,%eax
    1295:	0f b6 00             	movzbl (%eax),%eax
    1298:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    129b:	8b 55 d0             	mov    -0x30(%ebp),%edx
    129e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    12a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12a4:	01 c8                	add    %ecx,%eax
    12a6:	89 c1                	mov    %eax,%ecx
    12a8:	89 c8                	mov    %ecx,%eax
    12aa:	01 c0                	add    %eax,%eax
    12ac:	01 c8                	add    %ecx,%eax
    12ae:	01 c2                	add    %eax,%edx
    12b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12b3:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    12b7:	89 c1                	mov    %eax,%ecx
    12b9:	8b 45 d8             	mov    -0x28(%ebp),%eax
    12bc:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    12c0:	01 c1                	add    %eax,%ecx
    12c2:	8b 45 d8             	mov    -0x28(%ebp),%eax
    12c5:	01 c8                	add    %ecx,%eax
    12c7:	8d 48 fe             	lea    -0x2(%eax),%ecx
    12ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
    12cd:	01 c8                	add    %ecx,%eax
    12cf:	0f b6 00             	movzbl (%eax),%eax
    12d2:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    12d5:	8b 55 d0             	mov    -0x30(%ebp),%edx
    12d8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    12db:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12de:	01 c8                	add    %ecx,%eax
    12e0:	89 c1                	mov    %eax,%ecx
    12e2:	89 c8                	mov    %ecx,%eax
    12e4:	01 c0                	add    %eax,%eax
    12e6:	01 c8                	add    %ecx,%eax
    12e8:	01 c2                	add    %eax,%edx
    12ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12ed:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    12f1:	89 c1                	mov    %eax,%ecx
    12f3:	8b 45 d8             	mov    -0x28(%ebp),%eax
    12f6:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    12fa:	01 c1                	add    %eax,%ecx
    12fc:	8b 45 d8             	mov    -0x28(%ebp),%eax
    12ff:	01 c8                	add    %ecx,%eax
    1301:	8d 48 fd             	lea    -0x3(%eax),%ecx
    1304:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1307:	01 c8                	add    %ecx,%eax
    1309:	0f b6 00             	movzbl (%eax),%eax
    130c:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    130e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1312:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1315:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1318:	39 c2                	cmp    %eax,%edx
    131a:	0f 87 41 ff ff ff    	ja     1261 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    1320:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1324:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1327:	8b 45 f4             	mov    -0xc(%ebp),%eax
    132a:	39 c2                	cmp    %eax,%edx
    132c:	0f 87 0d ff ff ff    	ja     123f <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    1332:	83 ec 0c             	sub    $0xc,%esp
    1335:	ff 75 ec             	pushl  -0x14(%ebp)
    1338:	e8 c7 f7 ff ff       	call   b04 <close>
    133d:	83 c4 10             	add    $0x10,%esp
    return bmp;
    1340:	8b 45 08             	mov    0x8(%ebp),%eax
    1343:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1346:	89 10                	mov    %edx,(%eax)
    1348:	8b 55 cc             	mov    -0x34(%ebp),%edx
    134b:	89 50 04             	mov    %edx,0x4(%eax)
    134e:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1351:	89 50 08             	mov    %edx,0x8(%eax)
}
    1354:	8b 45 08             	mov    0x8(%ebp),%eax
    1357:	c9                   	leave  
    1358:	c2 04 00             	ret    $0x4

0000135b <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    135b:	55                   	push   %ebp
    135c:	89 e5                	mov    %esp,%ebp
    135e:	53                   	push   %ebx
    135f:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    1362:	83 ec 0c             	sub    $0xc,%esp
    1365:	6a 1c                	push   $0x1c
    1367:	e8 02 fc ff ff       	call   f6e <malloc>
    136c:	83 c4 10             	add    $0x10,%esp
    136f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    1372:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1375:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    137c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    137f:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1382:	6a 0c                	push   $0xc
    1384:	6a 0c                	push   $0xc
    1386:	6a 0c                	push   $0xc
    1388:	50                   	push   %eax
    1389:	e8 c3 fc ff ff       	call   1051 <RGB>
    138e:	83 c4 0c             	add    $0xc,%esp
    1391:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    1395:	66 89 43 13          	mov    %ax,0x13(%ebx)
    1399:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    139d:	88 43 15             	mov    %al,0x15(%ebx)
    13a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13a6:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    13aa:	66 89 48 10          	mov    %cx,0x10(%eax)
    13ae:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    13b2:	88 50 12             	mov    %dl,0x12(%eax)
    13b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13b8:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13bb:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    13bf:	66 89 48 08          	mov    %cx,0x8(%eax)
    13c3:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    13c7:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    13ca:	8b 45 08             	mov    0x8(%ebp),%eax
    13cd:	89 c2                	mov    %eax,%edx
    13cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13d2:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    13d4:	8b 45 0c             	mov    0xc(%ebp),%eax
    13d7:	89 c2                	mov    %eax,%edx
    13d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13dc:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    13df:	8b 55 10             	mov    0x10(%ebp),%edx
    13e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13e5:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    13e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    13eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13ee:	c9                   	leave  
    13ef:	c3                   	ret    

000013f0 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    13f0:	55                   	push   %ebp
    13f1:	89 e5                	mov    %esp,%ebp
    13f3:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    13f6:	8b 45 0c             	mov    0xc(%ebp),%eax
    13f9:	8b 50 08             	mov    0x8(%eax),%edx
    13fc:	89 55 f8             	mov    %edx,-0x8(%ebp)
    13ff:	8b 40 0c             	mov    0xc(%eax),%eax
    1402:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    1405:	8b 45 0c             	mov    0xc(%ebp),%eax
    1408:	8b 55 10             	mov    0x10(%ebp),%edx
    140b:	89 50 08             	mov    %edx,0x8(%eax)
    140e:	8b 55 14             	mov    0x14(%ebp),%edx
    1411:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    1414:	8b 45 08             	mov    0x8(%ebp),%eax
    1417:	8b 55 f8             	mov    -0x8(%ebp),%edx
    141a:	89 10                	mov    %edx,(%eax)
    141c:	8b 55 fc             	mov    -0x4(%ebp),%edx
    141f:	89 50 04             	mov    %edx,0x4(%eax)
}
    1422:	8b 45 08             	mov    0x8(%ebp),%eax
    1425:	c9                   	leave  
    1426:	c2 04 00             	ret    $0x4

00001429 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    1429:	55                   	push   %ebp
    142a:	89 e5                	mov    %esp,%ebp
    142c:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    142f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1432:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    1436:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    143a:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    143e:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    1441:	8b 45 0c             	mov    0xc(%ebp),%eax
    1444:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1448:	66 89 50 10          	mov    %dx,0x10(%eax)
    144c:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1450:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    1453:	8b 45 08             	mov    0x8(%ebp),%eax
    1456:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    145a:	66 89 10             	mov    %dx,(%eax)
    145d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1461:	88 50 02             	mov    %dl,0x2(%eax)
}
    1464:	8b 45 08             	mov    0x8(%ebp),%eax
    1467:	c9                   	leave  
    1468:	c2 04 00             	ret    $0x4

0000146b <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
    146b:	55                   	push   %ebp
    146c:	89 e5                	mov    %esp,%ebp
    146e:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
    1471:	8b 45 0c             	mov    0xc(%ebp),%eax
    1474:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1478:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    147c:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1480:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
    1483:	8b 45 0c             	mov    0xc(%ebp),%eax
    1486:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    148a:	66 89 50 13          	mov    %dx,0x13(%eax)
    148e:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1492:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
    1495:	8b 45 08             	mov    0x8(%ebp),%eax
    1498:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    149c:	66 89 10             	mov    %dx,(%eax)
    149f:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    14a3:	88 50 02             	mov    %dl,0x2(%eax)
}
    14a6:	8b 45 08             	mov    0x8(%ebp),%eax
    14a9:	c9                   	leave  
    14aa:	c2 04 00             	ret    $0x4

000014ad <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    14ad:	55                   	push   %ebp
    14ae:	89 e5                	mov    %esp,%ebp
    14b0:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    14b3:	8b 45 08             	mov    0x8(%ebp),%eax
    14b6:	8b 40 0c             	mov    0xc(%eax),%eax
    14b9:	89 c2                	mov    %eax,%edx
    14bb:	c1 ea 1f             	shr    $0x1f,%edx
    14be:	01 d0                	add    %edx,%eax
    14c0:	d1 f8                	sar    %eax
    14c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    14c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c8:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    14cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    14cf:	8b 45 10             	mov    0x10(%ebp),%eax
    14d2:	2b 45 f4             	sub    -0xc(%ebp),%eax
    14d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    14d8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    14dc:	0f 89 98 00 00 00    	jns    157a <APDrawPoint+0xcd>
        i = 0;
    14e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    14e9:	e9 8c 00 00 00       	jmp    157a <APDrawPoint+0xcd>
    {
        j = x - off;
    14ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    14f1:	2b 45 f4             	sub    -0xc(%ebp),%eax
    14f4:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    14f7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    14fb:	79 69                	jns    1566 <APDrawPoint+0xb9>
            j = 0;
    14fd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    1504:	eb 60                	jmp    1566 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    1506:	ff 75 fc             	pushl  -0x4(%ebp)
    1509:	ff 75 f8             	pushl  -0x8(%ebp)
    150c:	ff 75 08             	pushl  0x8(%ebp)
    150f:	e8 bb fb ff ff       	call   10cf <APGetIndex>
    1514:	83 c4 0c             	add    $0xc,%esp
    1517:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    151a:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    151e:	74 55                	je     1575 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    1520:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    1524:	74 67                	je     158d <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    1526:	ff 75 10             	pushl  0x10(%ebp)
    1529:	ff 75 0c             	pushl  0xc(%ebp)
    152c:	ff 75 fc             	pushl  -0x4(%ebp)
    152f:	ff 75 f8             	pushl  -0x8(%ebp)
    1532:	e8 5f fb ff ff       	call   1096 <distance_2>
    1537:	83 c4 10             	add    $0x10,%esp
    153a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    153d:	7f 23                	jg     1562 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    153f:	8b 45 08             	mov    0x8(%ebp),%eax
    1542:	8b 48 18             	mov    0x18(%eax),%ecx
    1545:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1548:	89 d0                	mov    %edx,%eax
    154a:	01 c0                	add    %eax,%eax
    154c:	01 d0                	add    %edx,%eax
    154e:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1551:	8b 45 08             	mov    0x8(%ebp),%eax
    1554:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1558:	66 89 0a             	mov    %cx,(%edx)
    155b:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    155f:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1562:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1566:	8b 55 0c             	mov    0xc(%ebp),%edx
    1569:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156c:	01 d0                	add    %edx,%eax
    156e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1571:	7d 93                	jge    1506 <APDrawPoint+0x59>
    1573:	eb 01                	jmp    1576 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1575:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1576:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    157a:	8b 55 10             	mov    0x10(%ebp),%edx
    157d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1580:	01 d0                	add    %edx,%eax
    1582:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1585:	0f 8d 63 ff ff ff    	jge    14ee <APDrawPoint+0x41>
    158b:	eb 01                	jmp    158e <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    158d:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    158e:	c9                   	leave  
    158f:	c3                   	ret    

00001590 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1590:	55                   	push   %ebp
    1591:	89 e5                	mov    %esp,%ebp
    1593:	53                   	push   %ebx
    1594:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1597:	8b 45 0c             	mov    0xc(%ebp),%eax
    159a:	3b 45 14             	cmp    0x14(%ebp),%eax
    159d:	0f 85 80 00 00 00    	jne    1623 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    15a3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    15a7:	0f 88 9d 02 00 00    	js     184a <APDrawLine+0x2ba>
    15ad:	8b 45 08             	mov    0x8(%ebp),%eax
    15b0:	8b 00                	mov    (%eax),%eax
    15b2:	3b 45 0c             	cmp    0xc(%ebp),%eax
    15b5:	0f 8e 8f 02 00 00    	jle    184a <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    15bb:	8b 45 10             	mov    0x10(%ebp),%eax
    15be:	3b 45 18             	cmp    0x18(%ebp),%eax
    15c1:	7e 12                	jle    15d5 <APDrawLine+0x45>
        {
            int tmp = y2;
    15c3:	8b 45 18             	mov    0x18(%ebp),%eax
    15c6:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    15c9:	8b 45 10             	mov    0x10(%ebp),%eax
    15cc:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    15cf:	8b 45 dc             	mov    -0x24(%ebp),%eax
    15d2:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    15d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    15d9:	79 07                	jns    15e2 <APDrawLine+0x52>
    15db:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    15e2:	8b 45 08             	mov    0x8(%ebp),%eax
    15e5:	8b 40 04             	mov    0x4(%eax),%eax
    15e8:	3b 45 18             	cmp    0x18(%ebp),%eax
    15eb:	7d 0c                	jge    15f9 <APDrawLine+0x69>
    15ed:	8b 45 08             	mov    0x8(%ebp),%eax
    15f0:	8b 40 04             	mov    0x4(%eax),%eax
    15f3:	83 e8 01             	sub    $0x1,%eax
    15f6:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    15f9:	8b 45 10             	mov    0x10(%ebp),%eax
    15fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    15ff:	eb 15                	jmp    1616 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1601:	ff 75 f4             	pushl  -0xc(%ebp)
    1604:	ff 75 0c             	pushl  0xc(%ebp)
    1607:	ff 75 08             	pushl  0x8(%ebp)
    160a:	e8 9e fe ff ff       	call   14ad <APDrawPoint>
    160f:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1612:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1616:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1619:	3b 45 18             	cmp    0x18(%ebp),%eax
    161c:	7e e3                	jle    1601 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    161e:	e9 2b 02 00 00       	jmp    184e <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1623:	8b 45 10             	mov    0x10(%ebp),%eax
    1626:	3b 45 18             	cmp    0x18(%ebp),%eax
    1629:	75 7f                	jne    16aa <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    162b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    162f:	0f 88 18 02 00 00    	js     184d <APDrawLine+0x2bd>
    1635:	8b 45 08             	mov    0x8(%ebp),%eax
    1638:	8b 40 04             	mov    0x4(%eax),%eax
    163b:	3b 45 10             	cmp    0x10(%ebp),%eax
    163e:	0f 8e 09 02 00 00    	jle    184d <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1644:	8b 45 0c             	mov    0xc(%ebp),%eax
    1647:	3b 45 14             	cmp    0x14(%ebp),%eax
    164a:	7e 12                	jle    165e <APDrawLine+0xce>
        {
            int tmp = x2;
    164c:	8b 45 14             	mov    0x14(%ebp),%eax
    164f:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1652:	8b 45 0c             	mov    0xc(%ebp),%eax
    1655:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1658:	8b 45 d8             	mov    -0x28(%ebp),%eax
    165b:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    165e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1662:	79 07                	jns    166b <APDrawLine+0xdb>
    1664:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    166b:	8b 45 08             	mov    0x8(%ebp),%eax
    166e:	8b 00                	mov    (%eax),%eax
    1670:	3b 45 14             	cmp    0x14(%ebp),%eax
    1673:	7d 0b                	jge    1680 <APDrawLine+0xf0>
    1675:	8b 45 08             	mov    0x8(%ebp),%eax
    1678:	8b 00                	mov    (%eax),%eax
    167a:	83 e8 01             	sub    $0x1,%eax
    167d:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1680:	8b 45 0c             	mov    0xc(%ebp),%eax
    1683:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1686:	eb 15                	jmp    169d <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1688:	ff 75 10             	pushl  0x10(%ebp)
    168b:	ff 75 f0             	pushl  -0x10(%ebp)
    168e:	ff 75 08             	pushl  0x8(%ebp)
    1691:	e8 17 fe ff ff       	call   14ad <APDrawPoint>
    1696:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1699:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    169d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16a0:	3b 45 14             	cmp    0x14(%ebp),%eax
    16a3:	7e e3                	jle    1688 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    16a5:	e9 a4 01 00 00       	jmp    184e <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    16aa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    16b1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    16b8:	8b 45 0c             	mov    0xc(%ebp),%eax
    16bb:	2b 45 14             	sub    0x14(%ebp),%eax
    16be:	50                   	push   %eax
    16bf:	e8 fb f9 ff ff       	call   10bf <abs_int>
    16c4:	83 c4 04             	add    $0x4,%esp
    16c7:	89 c3                	mov    %eax,%ebx
    16c9:	8b 45 10             	mov    0x10(%ebp),%eax
    16cc:	2b 45 18             	sub    0x18(%ebp),%eax
    16cf:	50                   	push   %eax
    16d0:	e8 ea f9 ff ff       	call   10bf <abs_int>
    16d5:	83 c4 04             	add    $0x4,%esp
    16d8:	39 c3                	cmp    %eax,%ebx
    16da:	0f 8e b5 00 00 00    	jle    1795 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    16e0:	8b 45 10             	mov    0x10(%ebp),%eax
    16e3:	2b 45 18             	sub    0x18(%ebp),%eax
    16e6:	89 45 b0             	mov    %eax,-0x50(%ebp)
    16e9:	db 45 b0             	fildl  -0x50(%ebp)
    16ec:	8b 45 0c             	mov    0xc(%ebp),%eax
    16ef:	2b 45 14             	sub    0x14(%ebp),%eax
    16f2:	89 45 b0             	mov    %eax,-0x50(%ebp)
    16f5:	db 45 b0             	fildl  -0x50(%ebp)
    16f8:	de f9                	fdivrp %st,%st(1)
    16fa:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    16fd:	8b 45 14             	mov    0x14(%ebp),%eax
    1700:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1703:	7e 0e                	jle    1713 <APDrawLine+0x183>
        {
            s = x1;
    1705:	8b 45 0c             	mov    0xc(%ebp),%eax
    1708:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    170b:	8b 45 14             	mov    0x14(%ebp),%eax
    170e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1711:	eb 0c                	jmp    171f <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1713:	8b 45 14             	mov    0x14(%ebp),%eax
    1716:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1719:	8b 45 0c             	mov    0xc(%ebp),%eax
    171c:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    171f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1723:	79 07                	jns    172c <APDrawLine+0x19c>
    1725:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    172c:	8b 45 08             	mov    0x8(%ebp),%eax
    172f:	8b 00                	mov    (%eax),%eax
    1731:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1734:	7f 0b                	jg     1741 <APDrawLine+0x1b1>
    1736:	8b 45 08             	mov    0x8(%ebp),%eax
    1739:	8b 00                	mov    (%eax),%eax
    173b:	83 e8 01             	sub    $0x1,%eax
    173e:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1741:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1744:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1747:	eb 3f                	jmp    1788 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1749:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    174c:	2b 45 0c             	sub    0xc(%ebp),%eax
    174f:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1752:	db 45 b0             	fildl  -0x50(%ebp)
    1755:	dc 4d d0             	fmull  -0x30(%ebp)
    1758:	db 45 10             	fildl  0x10(%ebp)
    175b:	de c1                	faddp  %st,%st(1)
    175d:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1760:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1764:	b4 0c                	mov    $0xc,%ah
    1766:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    176a:	d9 6d b4             	fldcw  -0x4c(%ebp)
    176d:	db 5d cc             	fistpl -0x34(%ebp)
    1770:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1773:	ff 75 cc             	pushl  -0x34(%ebp)
    1776:	ff 75 e4             	pushl  -0x1c(%ebp)
    1779:	ff 75 08             	pushl  0x8(%ebp)
    177c:	e8 2c fd ff ff       	call   14ad <APDrawPoint>
    1781:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1784:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1788:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    178b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    178e:	7e b9                	jle    1749 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1790:	e9 b9 00 00 00       	jmp    184e <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1795:	8b 45 0c             	mov    0xc(%ebp),%eax
    1798:	2b 45 14             	sub    0x14(%ebp),%eax
    179b:	89 45 b0             	mov    %eax,-0x50(%ebp)
    179e:	db 45 b0             	fildl  -0x50(%ebp)
    17a1:	8b 45 10             	mov    0x10(%ebp),%eax
    17a4:	2b 45 18             	sub    0x18(%ebp),%eax
    17a7:	89 45 b0             	mov    %eax,-0x50(%ebp)
    17aa:	db 45 b0             	fildl  -0x50(%ebp)
    17ad:	de f9                	fdivrp %st,%st(1)
    17af:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    17b2:	8b 45 10             	mov    0x10(%ebp),%eax
    17b5:	3b 45 18             	cmp    0x18(%ebp),%eax
    17b8:	7e 0e                	jle    17c8 <APDrawLine+0x238>
    {
        s = y2;
    17ba:	8b 45 18             	mov    0x18(%ebp),%eax
    17bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    17c0:	8b 45 10             	mov    0x10(%ebp),%eax
    17c3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    17c6:	eb 0c                	jmp    17d4 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    17c8:	8b 45 10             	mov    0x10(%ebp),%eax
    17cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    17ce:	8b 45 18             	mov    0x18(%ebp),%eax
    17d1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    17d4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17d8:	79 07                	jns    17e1 <APDrawLine+0x251>
    17da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    17e1:	8b 45 08             	mov    0x8(%ebp),%eax
    17e4:	8b 40 04             	mov    0x4(%eax),%eax
    17e7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    17ea:	7f 0c                	jg     17f8 <APDrawLine+0x268>
    17ec:	8b 45 08             	mov    0x8(%ebp),%eax
    17ef:	8b 40 04             	mov    0x4(%eax),%eax
    17f2:	83 e8 01             	sub    $0x1,%eax
    17f5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    17f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17fb:	89 45 e0             	mov    %eax,-0x20(%ebp)
    17fe:	eb 3f                	jmp    183f <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1800:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1803:	2b 45 10             	sub    0x10(%ebp),%eax
    1806:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1809:	db 45 b0             	fildl  -0x50(%ebp)
    180c:	dc 4d c0             	fmull  -0x40(%ebp)
    180f:	db 45 0c             	fildl  0xc(%ebp)
    1812:	de c1                	faddp  %st,%st(1)
    1814:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1817:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    181b:	b4 0c                	mov    $0xc,%ah
    181d:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1821:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1824:	db 5d bc             	fistpl -0x44(%ebp)
    1827:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    182a:	ff 75 e0             	pushl  -0x20(%ebp)
    182d:	ff 75 bc             	pushl  -0x44(%ebp)
    1830:	ff 75 08             	pushl  0x8(%ebp)
    1833:	e8 75 fc ff ff       	call   14ad <APDrawPoint>
    1838:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    183b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    183f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1842:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1845:	7e b9                	jle    1800 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1847:	90                   	nop
    1848:	eb 04                	jmp    184e <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    184a:	90                   	nop
    184b:	eb 01                	jmp    184e <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    184d:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    184e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1851:	c9                   	leave  
    1852:	c3                   	ret    

00001853 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1853:	55                   	push   %ebp
    1854:	89 e5                	mov    %esp,%ebp
    1856:	53                   	push   %ebx
    1857:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    185a:	8b 55 10             	mov    0x10(%ebp),%edx
    185d:	8b 45 18             	mov    0x18(%ebp),%eax
    1860:	01 d0                	add    %edx,%eax
    1862:	83 e8 01             	sub    $0x1,%eax
    1865:	83 ec 04             	sub    $0x4,%esp
    1868:	50                   	push   %eax
    1869:	ff 75 0c             	pushl  0xc(%ebp)
    186c:	ff 75 10             	pushl  0x10(%ebp)
    186f:	ff 75 0c             	pushl  0xc(%ebp)
    1872:	ff 75 08             	pushl  0x8(%ebp)
    1875:	e8 16 fd ff ff       	call   1590 <APDrawLine>
    187a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    187d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1880:	8b 45 14             	mov    0x14(%ebp),%eax
    1883:	01 d0                	add    %edx,%eax
    1885:	83 e8 01             	sub    $0x1,%eax
    1888:	83 ec 04             	sub    $0x4,%esp
    188b:	ff 75 10             	pushl  0x10(%ebp)
    188e:	50                   	push   %eax
    188f:	ff 75 10             	pushl  0x10(%ebp)
    1892:	ff 75 0c             	pushl  0xc(%ebp)
    1895:	ff 75 08             	pushl  0x8(%ebp)
    1898:	e8 f3 fc ff ff       	call   1590 <APDrawLine>
    189d:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    18a0:	8b 55 10             	mov    0x10(%ebp),%edx
    18a3:	8b 45 18             	mov    0x18(%ebp),%eax
    18a6:	01 d0                	add    %edx,%eax
    18a8:	8d 48 ff             	lea    -0x1(%eax),%ecx
    18ab:	8b 55 0c             	mov    0xc(%ebp),%edx
    18ae:	8b 45 14             	mov    0x14(%ebp),%eax
    18b1:	01 d0                	add    %edx,%eax
    18b3:	8d 50 ff             	lea    -0x1(%eax),%edx
    18b6:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    18b9:	8b 45 14             	mov    0x14(%ebp),%eax
    18bc:	01 d8                	add    %ebx,%eax
    18be:	83 e8 01             	sub    $0x1,%eax
    18c1:	83 ec 04             	sub    $0x4,%esp
    18c4:	51                   	push   %ecx
    18c5:	52                   	push   %edx
    18c6:	ff 75 10             	pushl  0x10(%ebp)
    18c9:	50                   	push   %eax
    18ca:	ff 75 08             	pushl  0x8(%ebp)
    18cd:	e8 be fc ff ff       	call   1590 <APDrawLine>
    18d2:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    18d5:	8b 55 10             	mov    0x10(%ebp),%edx
    18d8:	8b 45 18             	mov    0x18(%ebp),%eax
    18db:	01 d0                	add    %edx,%eax
    18dd:	8d 48 ff             	lea    -0x1(%eax),%ecx
    18e0:	8b 55 0c             	mov    0xc(%ebp),%edx
    18e3:	8b 45 14             	mov    0x14(%ebp),%eax
    18e6:	01 d0                	add    %edx,%eax
    18e8:	8d 50 ff             	lea    -0x1(%eax),%edx
    18eb:	8b 5d 10             	mov    0x10(%ebp),%ebx
    18ee:	8b 45 18             	mov    0x18(%ebp),%eax
    18f1:	01 d8                	add    %ebx,%eax
    18f3:	83 e8 01             	sub    $0x1,%eax
    18f6:	83 ec 04             	sub    $0x4,%esp
    18f9:	51                   	push   %ecx
    18fa:	52                   	push   %edx
    18fb:	50                   	push   %eax
    18fc:	ff 75 0c             	pushl  0xc(%ebp)
    18ff:	ff 75 08             	pushl  0x8(%ebp)
    1902:	e8 89 fc ff ff       	call   1590 <APDrawLine>
    1907:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    190a:	8b 55 0c             	mov    0xc(%ebp),%edx
    190d:	8b 45 14             	mov    0x14(%ebp),%eax
    1910:	01 d0                	add    %edx,%eax
    1912:	8d 50 ff             	lea    -0x1(%eax),%edx
    1915:	8b 45 08             	mov    0x8(%ebp),%eax
    1918:	8b 40 0c             	mov    0xc(%eax),%eax
    191b:	89 c1                	mov    %eax,%ecx
    191d:	c1 e9 1f             	shr    $0x1f,%ecx
    1920:	01 c8                	add    %ecx,%eax
    1922:	d1 f8                	sar    %eax
    1924:	29 c2                	sub    %eax,%edx
    1926:	89 d0                	mov    %edx,%eax
    1928:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    192b:	8b 55 10             	mov    0x10(%ebp),%edx
    192e:	8b 45 18             	mov    0x18(%ebp),%eax
    1931:	01 d0                	add    %edx,%eax
    1933:	8d 50 ff             	lea    -0x1(%eax),%edx
    1936:	8b 45 08             	mov    0x8(%ebp),%eax
    1939:	8b 40 0c             	mov    0xc(%eax),%eax
    193c:	89 c1                	mov    %eax,%ecx
    193e:	c1 e9 1f             	shr    $0x1f,%ecx
    1941:	01 c8                	add    %ecx,%eax
    1943:	d1 f8                	sar    %eax
    1945:	29 c2                	sub    %eax,%edx
    1947:	89 d0                	mov    %edx,%eax
    1949:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    194c:	8b 45 08             	mov    0x8(%ebp),%eax
    194f:	8b 40 0c             	mov    0xc(%eax),%eax
    1952:	89 c2                	mov    %eax,%edx
    1954:	c1 ea 1f             	shr    $0x1f,%edx
    1957:	01 d0                	add    %edx,%eax
    1959:	d1 f8                	sar    %eax
    195b:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    195e:	8b 45 08             	mov    0x8(%ebp),%eax
    1961:	8b 40 0c             	mov    0xc(%eax),%eax
    1964:	89 c2                	mov    %eax,%edx
    1966:	c1 ea 1f             	shr    $0x1f,%edx
    1969:	01 d0                	add    %edx,%eax
    196b:	d1 f8                	sar    %eax
    196d:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1970:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1974:	0f 88 d8 00 00 00    	js     1a52 <APDrawRect+0x1ff>
    197a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    197e:	0f 88 ce 00 00 00    	js     1a52 <APDrawRect+0x1ff>
    1984:	8b 45 08             	mov    0x8(%ebp),%eax
    1987:	8b 00                	mov    (%eax),%eax
    1989:	3b 45 0c             	cmp    0xc(%ebp),%eax
    198c:	0f 8e c0 00 00 00    	jle    1a52 <APDrawRect+0x1ff>
    1992:	8b 45 08             	mov    0x8(%ebp),%eax
    1995:	8b 40 04             	mov    0x4(%eax),%eax
    1998:	3b 45 10             	cmp    0x10(%ebp),%eax
    199b:	0f 8e b1 00 00 00    	jle    1a52 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    19a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    19a5:	79 07                	jns    19ae <APDrawRect+0x15b>
    19a7:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    19ae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    19b2:	79 07                	jns    19bb <APDrawRect+0x168>
    19b4:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    19bb:	8b 45 08             	mov    0x8(%ebp),%eax
    19be:	8b 00                	mov    (%eax),%eax
    19c0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    19c3:	7f 0b                	jg     19d0 <APDrawRect+0x17d>
    19c5:	8b 45 08             	mov    0x8(%ebp),%eax
    19c8:	8b 00                	mov    (%eax),%eax
    19ca:	83 e8 01             	sub    $0x1,%eax
    19cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    19d0:	8b 45 08             	mov    0x8(%ebp),%eax
    19d3:	8b 40 04             	mov    0x4(%eax),%eax
    19d6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    19d9:	7f 0c                	jg     19e7 <APDrawRect+0x194>
    19db:	8b 45 08             	mov    0x8(%ebp),%eax
    19de:	8b 40 04             	mov    0x4(%eax),%eax
    19e1:	83 e8 01             	sub    $0x1,%eax
    19e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    19e7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    19ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    19f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    19f4:	eb 52                	jmp    1a48 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    19f6:	8b 45 10             	mov    0x10(%ebp),%eax
    19f9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    19fc:	eb 3e                	jmp    1a3c <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    19fe:	83 ec 04             	sub    $0x4,%esp
    1a01:	ff 75 e8             	pushl  -0x18(%ebp)
    1a04:	ff 75 ec             	pushl  -0x14(%ebp)
    1a07:	ff 75 08             	pushl  0x8(%ebp)
    1a0a:	e8 c0 f6 ff ff       	call   10cf <APGetIndex>
    1a0f:	83 c4 10             	add    $0x10,%esp
    1a12:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1a15:	8b 45 08             	mov    0x8(%ebp),%eax
    1a18:	8b 48 18             	mov    0x18(%eax),%ecx
    1a1b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1a1e:	89 d0                	mov    %edx,%eax
    1a20:	01 c0                	add    %eax,%eax
    1a22:	01 d0                	add    %edx,%eax
    1a24:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1a27:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2a:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1a2e:	66 89 0a             	mov    %cx,(%edx)
    1a31:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1a35:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1a38:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1a3c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a3f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1a42:	7e ba                	jle    19fe <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1a44:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1a48:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a4b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1a4e:	7e a6                	jle    19f6 <APDrawRect+0x1a3>
    1a50:	eb 01                	jmp    1a53 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1a52:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1a53:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1a56:	c9                   	leave  
    1a57:	c3                   	ret    

00001a58 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1a58:	55                   	push   %ebp
    1a59:	89 e5                	mov    %esp,%ebp
    1a5b:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    1a5e:	83 ec 0c             	sub    $0xc,%esp
    1a61:	ff 75 0c             	pushl  0xc(%ebp)
    1a64:	e8 b1 ee ff ff       	call   91a <strlen>
    1a69:	83 c4 10             	add    $0x10,%esp
    1a6c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1a6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a72:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1a76:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1a7a:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1a7e:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1a81:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1a88:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1a8f:	e9 bc 00 00 00       	jmp    1b50 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1a94:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a97:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a9a:	01 d0                	add    %edx,%eax
    1a9c:	0f b6 00             	movzbl (%eax),%eax
    1a9f:	0f be c0             	movsbl %al,%eax
    1aa2:	83 e8 20             	sub    $0x20,%eax
    1aa5:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1aa8:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1aac:	0f 87 9a 00 00 00    	ja     1b4c <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1ab2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab5:	8b 00                	mov    (%eax),%eax
    1ab7:	0f af 45 14          	imul   0x14(%ebp),%eax
    1abb:	89 c2                	mov    %eax,%edx
    1abd:	8b 45 10             	mov    0x10(%ebp),%eax
    1ac0:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1ac3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ac6:	89 d0                	mov    %edx,%eax
    1ac8:	c1 e0 03             	shl    $0x3,%eax
    1acb:	01 d0                	add    %edx,%eax
    1acd:	01 c8                	add    %ecx,%eax
    1acf:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1ad2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1ad9:	eb 6b                	jmp    1b46 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1adb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1ae2:	eb 50                	jmp    1b34 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    1ae4:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1ae7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1aea:	89 d0                	mov    %edx,%eax
    1aec:	c1 e0 03             	shl    $0x3,%eax
    1aef:	01 d0                	add    %edx,%eax
    1af1:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    1af7:	01 c2                	add    %eax,%edx
    1af9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1afc:	01 d0                	add    %edx,%eax
    1afe:	05 80 35 00 00       	add    $0x3580,%eax
    1b03:	0f b6 00             	movzbl (%eax),%eax
    1b06:	84 c0                	test   %al,%al
    1b08:	74 26                	je     1b30 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1b0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0d:	8b 50 18             	mov    0x18(%eax),%edx
    1b10:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1b13:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1b16:	01 c8                	add    %ecx,%eax
    1b18:	89 c1                	mov    %eax,%ecx
    1b1a:	89 c8                	mov    %ecx,%eax
    1b1c:	01 c0                	add    %eax,%eax
    1b1e:	01 c8                	add    %ecx,%eax
    1b20:	01 d0                	add    %edx,%eax
    1b22:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1b26:	66 89 10             	mov    %dx,(%eax)
    1b29:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1b2d:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1b30:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1b34:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1b38:	7e aa                	jle    1ae4 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1b3a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3d:	8b 00                	mov    (%eax),%eax
    1b3f:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1b42:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1b46:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1b4a:	7e 8f                	jle    1adb <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1b4c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b50:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b53:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1b56:	0f 82 38 ff ff ff    	jb     1a94 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1b5c:	90                   	nop
    1b5d:	c9                   	leave  
    1b5e:	c3                   	ret    

00001b5f <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1b5f:	55                   	push   %ebp
    1b60:	89 e5                	mov    %esp,%ebp
    1b62:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1b65:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1b69:	0f 88 8e 01 00 00    	js     1cfd <APDcCopy+0x19e>
    1b6f:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1b73:	0f 88 84 01 00 00    	js     1cfd <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1b79:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b7c:	8b 45 20             	mov    0x20(%ebp),%eax
    1b7f:	01 d0                	add    %edx,%eax
    1b81:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1b84:	8b 55 10             	mov    0x10(%ebp),%edx
    1b87:	8b 45 24             	mov    0x24(%ebp),%eax
    1b8a:	01 d0                	add    %edx,%eax
    1b8c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1b8f:	8b 55 18             	mov    0x18(%ebp),%edx
    1b92:	8b 45 20             	mov    0x20(%ebp),%eax
    1b95:	01 d0                	add    %edx,%eax
    1b97:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b9a:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1b9d:	8b 45 24             	mov    0x24(%ebp),%eax
    1ba0:	01 d0                	add    %edx,%eax
    1ba2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1ba5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1ba9:	0f 88 51 01 00 00    	js     1d00 <APDcCopy+0x1a1>
    1baf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1bb3:	0f 88 47 01 00 00    	js     1d00 <APDcCopy+0x1a1>
    1bb9:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1bbd:	0f 88 3d 01 00 00    	js     1d00 <APDcCopy+0x1a1>
    1bc3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1bc7:	0f 88 33 01 00 00    	js     1d00 <APDcCopy+0x1a1>
    1bcd:	8b 45 14             	mov    0x14(%ebp),%eax
    1bd0:	8b 00                	mov    (%eax),%eax
    1bd2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1bd5:	0f 8c 25 01 00 00    	jl     1d00 <APDcCopy+0x1a1>
    1bdb:	8b 45 14             	mov    0x14(%ebp),%eax
    1bde:	8b 40 04             	mov    0x4(%eax),%eax
    1be1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1be4:	0f 8c 16 01 00 00    	jl     1d00 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1bea:	8b 45 08             	mov    0x8(%ebp),%eax
    1bed:	8b 00                	mov    (%eax),%eax
    1bef:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1bf2:	7f 0b                	jg     1bff <APDcCopy+0xa0>
    1bf4:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf7:	8b 00                	mov    (%eax),%eax
    1bf9:	83 e8 01             	sub    $0x1,%eax
    1bfc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1bff:	8b 45 08             	mov    0x8(%ebp),%eax
    1c02:	8b 40 04             	mov    0x4(%eax),%eax
    1c05:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1c08:	7f 0c                	jg     1c16 <APDcCopy+0xb7>
    1c0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0d:	8b 40 04             	mov    0x4(%eax),%eax
    1c10:	83 e8 01             	sub    $0x1,%eax
    1c13:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1c16:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1c1d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1c24:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c2b:	e9 bc 00 00 00       	jmp    1cec <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1c30:	8b 45 08             	mov    0x8(%ebp),%eax
    1c33:	8b 00                	mov    (%eax),%eax
    1c35:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1c38:	8b 55 10             	mov    0x10(%ebp),%edx
    1c3b:	01 ca                	add    %ecx,%edx
    1c3d:	0f af d0             	imul   %eax,%edx
    1c40:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c43:	01 d0                	add    %edx,%eax
    1c45:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1c48:	8b 45 14             	mov    0x14(%ebp),%eax
    1c4b:	8b 00                	mov    (%eax),%eax
    1c4d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1c50:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1c53:	01 ca                	add    %ecx,%edx
    1c55:	0f af d0             	imul   %eax,%edx
    1c58:	8b 45 18             	mov    0x18(%ebp),%eax
    1c5b:	01 d0                	add    %edx,%eax
    1c5d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1c60:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1c67:	eb 74                	jmp    1cdd <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1c69:	8b 45 14             	mov    0x14(%ebp),%eax
    1c6c:	8b 50 18             	mov    0x18(%eax),%edx
    1c6f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1c72:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c75:	01 c8                	add    %ecx,%eax
    1c77:	89 c1                	mov    %eax,%ecx
    1c79:	89 c8                	mov    %ecx,%eax
    1c7b:	01 c0                	add    %eax,%eax
    1c7d:	01 c8                	add    %ecx,%eax
    1c7f:	01 d0                	add    %edx,%eax
    1c81:	0f b7 10             	movzwl (%eax),%edx
    1c84:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1c88:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1c8c:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1c8f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1c93:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1c97:	38 c2                	cmp    %al,%dl
    1c99:	75 18                	jne    1cb3 <APDcCopy+0x154>
    1c9b:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1c9f:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1ca3:	38 c2                	cmp    %al,%dl
    1ca5:	75 0c                	jne    1cb3 <APDcCopy+0x154>
    1ca7:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1cab:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1caf:	38 c2                	cmp    %al,%dl
    1cb1:	74 26                	je     1cd9 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1cb3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb6:	8b 50 18             	mov    0x18(%eax),%edx
    1cb9:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1cbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cbf:	01 c8                	add    %ecx,%eax
    1cc1:	89 c1                	mov    %eax,%ecx
    1cc3:	89 c8                	mov    %ecx,%eax
    1cc5:	01 c0                	add    %eax,%eax
    1cc7:	01 c8                	add    %ecx,%eax
    1cc9:	01 d0                	add    %edx,%eax
    1ccb:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1ccf:	66 89 10             	mov    %dx,(%eax)
    1cd2:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1cd6:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1cd9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1cdd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ce0:	2b 45 0c             	sub    0xc(%ebp),%eax
    1ce3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1ce6:	7d 81                	jge    1c69 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1ce8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1cec:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1cef:	2b 45 10             	sub    0x10(%ebp),%eax
    1cf2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1cf5:	0f 8d 35 ff ff ff    	jge    1c30 <APDcCopy+0xd1>
    1cfb:	eb 04                	jmp    1d01 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1cfd:	90                   	nop
    1cfe:	eb 01                	jmp    1d01 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1d00:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1d01:	c9                   	leave  
    1d02:	c3                   	ret    

00001d03 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1d03:	55                   	push   %ebp
    1d04:	89 e5                	mov    %esp,%ebp
    1d06:	83 ec 1c             	sub    $0x1c,%esp
    1d09:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1d0c:	8b 55 10             	mov    0x10(%ebp),%edx
    1d0f:	8b 45 14             	mov    0x14(%ebp),%eax
    1d12:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1d15:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1d18:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1d1b:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1d1f:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1d22:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1d26:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1d29:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1d2d:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1d30:	8b 45 08             	mov    0x8(%ebp),%eax
    1d33:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1d37:	66 89 10             	mov    %dx,(%eax)
    1d3a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1d3e:	88 50 02             	mov    %dl,0x2(%eax)
}
    1d41:	8b 45 08             	mov    0x8(%ebp),%eax
    1d44:	c9                   	leave  
    1d45:	c2 04 00             	ret    $0x4

00001d48 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1d48:	55                   	push   %ebp
    1d49:	89 e5                	mov    %esp,%ebp
    1d4b:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1d4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d51:	8b 00                	mov    (%eax),%eax
    1d53:	83 ec 08             	sub    $0x8,%esp
    1d56:	8d 55 0c             	lea    0xc(%ebp),%edx
    1d59:	52                   	push   %edx
    1d5a:	50                   	push   %eax
    1d5b:	e8 24 ee ff ff       	call   b84 <sendMessage>
    1d60:	83 c4 10             	add    $0x10,%esp
}
    1d63:	90                   	nop
    1d64:	c9                   	leave  
    1d65:	c3                   	ret    

00001d66 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1d66:	55                   	push   %ebp
    1d67:	89 e5                	mov    %esp,%ebp
    1d69:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1d6c:	83 ec 0c             	sub    $0xc,%esp
    1d6f:	68 98 00 00 00       	push   $0x98
    1d74:	e8 f5 f1 ff ff       	call   f6e <malloc>
    1d79:	83 c4 10             	add    $0x10,%esp
    1d7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1d7f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d83:	75 15                	jne    1d9a <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1d85:	83 ec 04             	sub    $0x4,%esp
    1d88:	ff 75 08             	pushl  0x8(%ebp)
    1d8b:	68 2c 2d 00 00       	push   $0x2d2c
    1d90:	6a 01                	push   $0x1
    1d92:	e8 04 ef ff ff       	call   c9b <printf>
    1d97:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1d9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d9d:	05 84 00 00 00       	add    $0x84,%eax
    1da2:	83 ec 08             	sub    $0x8,%esp
    1da5:	ff 75 08             	pushl  0x8(%ebp)
    1da8:	50                   	push   %eax
    1da9:	e8 fd ea ff ff       	call   8ab <strcpy>
    1dae:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1db1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1db4:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1dbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dbe:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1dc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dc8:	8b 40 3c             	mov    0x3c(%eax),%eax
    1dcb:	89 c2                	mov    %eax,%edx
    1dcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dd0:	8b 40 40             	mov    0x40(%eax),%eax
    1dd3:	0f af d0             	imul   %eax,%edx
    1dd6:	89 d0                	mov    %edx,%eax
    1dd8:	01 c0                	add    %eax,%eax
    1dda:	01 d0                	add    %edx,%eax
    1ddc:	83 ec 0c             	sub    $0xc,%esp
    1ddf:	50                   	push   %eax
    1de0:	e8 89 f1 ff ff       	call   f6e <malloc>
    1de5:	83 c4 10             	add    $0x10,%esp
    1de8:	89 c2                	mov    %eax,%edx
    1dea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ded:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1df0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1df3:	8b 40 54             	mov    0x54(%eax),%eax
    1df6:	85 c0                	test   %eax,%eax
    1df8:	75 15                	jne    1e0f <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1dfa:	83 ec 04             	sub    $0x4,%esp
    1dfd:	ff 75 08             	pushl  0x8(%ebp)
    1e00:	68 4c 2d 00 00       	push   $0x2d4c
    1e05:	6a 01                	push   $0x1
    1e07:	e8 8f ee ff ff       	call   c9b <printf>
    1e0c:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1e0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e12:	8b 40 3c             	mov    0x3c(%eax),%eax
    1e15:	89 c2                	mov    %eax,%edx
    1e17:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e1a:	8b 40 40             	mov    0x40(%eax),%eax
    1e1d:	0f af d0             	imul   %eax,%edx
    1e20:	89 d0                	mov    %edx,%eax
    1e22:	01 c0                	add    %eax,%eax
    1e24:	01 c2                	add    %eax,%edx
    1e26:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e29:	8b 40 54             	mov    0x54(%eax),%eax
    1e2c:	83 ec 04             	sub    $0x4,%esp
    1e2f:	52                   	push   %edx
    1e30:	68 ff ff ff 00       	push   $0xffffff
    1e35:	50                   	push   %eax
    1e36:	e8 06 eb ff ff       	call   941 <memset>
    1e3b:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1e3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e41:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1e48:	e8 0f ed ff ff       	call   b5c <getpid>
    1e4d:	89 c2                	mov    %eax,%edx
    1e4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e52:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1e55:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e58:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1e5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e62:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1e69:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e6c:	8b 40 58             	mov    0x58(%eax),%eax
    1e6f:	89 c2                	mov    %eax,%edx
    1e71:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e74:	8b 40 5c             	mov    0x5c(%eax),%eax
    1e77:	0f af d0             	imul   %eax,%edx
    1e7a:	89 d0                	mov    %edx,%eax
    1e7c:	01 c0                	add    %eax,%eax
    1e7e:	01 d0                	add    %edx,%eax
    1e80:	83 ec 0c             	sub    $0xc,%esp
    1e83:	50                   	push   %eax
    1e84:	e8 e5 f0 ff ff       	call   f6e <malloc>
    1e89:	83 c4 10             	add    $0x10,%esp
    1e8c:	89 c2                	mov    %eax,%edx
    1e8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e91:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1e94:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e97:	8b 40 70             	mov    0x70(%eax),%eax
    1e9a:	85 c0                	test   %eax,%eax
    1e9c:	75 15                	jne    1eb3 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1e9e:	83 ec 04             	sub    $0x4,%esp
    1ea1:	ff 75 08             	pushl  0x8(%ebp)
    1ea4:	68 70 2d 00 00       	push   $0x2d70
    1ea9:	6a 01                	push   $0x1
    1eab:	e8 eb ed ff ff       	call   c9b <printf>
    1eb0:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1eb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1eb6:	8b 40 3c             	mov    0x3c(%eax),%eax
    1eb9:	89 c2                	mov    %eax,%edx
    1ebb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ebe:	8b 40 40             	mov    0x40(%eax),%eax
    1ec1:	0f af d0             	imul   %eax,%edx
    1ec4:	89 d0                	mov    %edx,%eax
    1ec6:	01 c0                	add    %eax,%eax
    1ec8:	01 c2                	add    %eax,%edx
    1eca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ecd:	8b 40 54             	mov    0x54(%eax),%eax
    1ed0:	83 ec 04             	sub    $0x4,%esp
    1ed3:	52                   	push   %edx
    1ed4:	68 ff 00 00 00       	push   $0xff
    1ed9:	50                   	push   %eax
    1eda:	e8 62 ea ff ff       	call   941 <memset>
    1edf:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1ee2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ee5:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ee8:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1eeb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1eef:	74 49                	je     1f3a <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1ef1:	8b 45 10             	mov    0x10(%ebp),%eax
    1ef4:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1efa:	83 ec 0c             	sub    $0xc,%esp
    1efd:	50                   	push   %eax
    1efe:	e8 6b f0 ff ff       	call   f6e <malloc>
    1f03:	83 c4 10             	add    $0x10,%esp
    1f06:	89 c2                	mov    %eax,%edx
    1f08:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f0b:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1f0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f11:	8b 55 10             	mov    0x10(%ebp),%edx
    1f14:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1f17:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f1a:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1f21:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f24:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1f2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f2e:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1f35:	e9 8d 00 00 00       	jmp    1fc7 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1f3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f3d:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1f44:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f47:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1f4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f51:	8b 40 20             	mov    0x20(%eax),%eax
    1f54:	89 c2                	mov    %eax,%edx
    1f56:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f59:	8b 40 24             	mov    0x24(%eax),%eax
    1f5c:	0f af d0             	imul   %eax,%edx
    1f5f:	89 d0                	mov    %edx,%eax
    1f61:	01 c0                	add    %eax,%eax
    1f63:	01 d0                	add    %edx,%eax
    1f65:	83 ec 0c             	sub    $0xc,%esp
    1f68:	50                   	push   %eax
    1f69:	e8 00 f0 ff ff       	call   f6e <malloc>
    1f6e:	83 c4 10             	add    $0x10,%esp
    1f71:	89 c2                	mov    %eax,%edx
    1f73:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f76:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1f79:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f7c:	8b 40 38             	mov    0x38(%eax),%eax
    1f7f:	85 c0                	test   %eax,%eax
    1f81:	75 15                	jne    1f98 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1f83:	83 ec 04             	sub    $0x4,%esp
    1f86:	ff 75 08             	pushl  0x8(%ebp)
    1f89:	68 98 2d 00 00       	push   $0x2d98
    1f8e:	6a 01                	push   $0x1
    1f90:	e8 06 ed ff ff       	call   c9b <printf>
    1f95:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1f98:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f9b:	8b 40 20             	mov    0x20(%eax),%eax
    1f9e:	89 c2                	mov    %eax,%edx
    1fa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fa3:	8b 40 24             	mov    0x24(%eax),%eax
    1fa6:	0f af d0             	imul   %eax,%edx
    1fa9:	89 d0                	mov    %edx,%eax
    1fab:	01 c0                	add    %eax,%eax
    1fad:	01 c2                	add    %eax,%edx
    1faf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fb2:	8b 40 38             	mov    0x38(%eax),%eax
    1fb5:	83 ec 04             	sub    $0x4,%esp
    1fb8:	52                   	push   %edx
    1fb9:	68 ff ff ff 00       	push   $0xffffff
    1fbe:	50                   	push   %eax
    1fbf:	e8 7d e9 ff ff       	call   941 <memset>
    1fc4:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1fc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1fca:	c9                   	leave  
    1fcb:	c3                   	ret    

00001fcc <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1fcc:	55                   	push   %ebp
    1fcd:	89 e5                	mov    %esp,%ebp
    1fcf:	57                   	push   %edi
    1fd0:	56                   	push   %esi
    1fd1:	53                   	push   %ebx
    1fd2:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1fd5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fd8:	83 f8 03             	cmp    $0x3,%eax
    1fdb:	74 02                	je     1fdf <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1fdd:	eb 7c                	jmp    205b <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1fdf:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe2:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1fe5:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe8:	8b 48 18             	mov    0x18(%eax),%ecx
    1feb:	8b 45 08             	mov    0x8(%ebp),%eax
    1fee:	8b 50 5c             	mov    0x5c(%eax),%edx
    1ff1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff4:	8b 40 58             	mov    0x58(%eax),%eax
    1ff7:	8b 75 08             	mov    0x8(%ebp),%esi
    1ffa:	83 c6 58             	add    $0x58,%esi
    1ffd:	83 ec 04             	sub    $0x4,%esp
    2000:	53                   	push   %ebx
    2001:	51                   	push   %ecx
    2002:	6a 00                	push   $0x0
    2004:	52                   	push   %edx
    2005:	50                   	push   %eax
    2006:	6a 00                	push   $0x0
    2008:	6a 00                	push   $0x0
    200a:	56                   	push   %esi
    200b:	6a 00                	push   $0x0
    200d:	6a 00                	push   $0x0
    200f:	ff 75 08             	pushl  0x8(%ebp)
    2012:	e8 65 eb ff ff       	call   b7c <paintWindow>
    2017:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    201a:	8b 45 08             	mov    0x8(%ebp),%eax
    201d:	8b 70 1c             	mov    0x1c(%eax),%esi
    2020:	8b 45 08             	mov    0x8(%ebp),%eax
    2023:	8b 58 18             	mov    0x18(%eax),%ebx
    2026:	8b 45 08             	mov    0x8(%ebp),%eax
    2029:	8b 48 08             	mov    0x8(%eax),%ecx
    202c:	8b 45 08             	mov    0x8(%ebp),%eax
    202f:	8b 50 40             	mov    0x40(%eax),%edx
    2032:	8b 45 08             	mov    0x8(%ebp),%eax
    2035:	8b 40 3c             	mov    0x3c(%eax),%eax
    2038:	8b 7d 08             	mov    0x8(%ebp),%edi
    203b:	83 c7 3c             	add    $0x3c,%edi
    203e:	83 ec 04             	sub    $0x4,%esp
    2041:	56                   	push   %esi
    2042:	53                   	push   %ebx
    2043:	51                   	push   %ecx
    2044:	52                   	push   %edx
    2045:	50                   	push   %eax
    2046:	6a 00                	push   $0x0
    2048:	6a 00                	push   $0x0
    204a:	57                   	push   %edi
    204b:	6a 32                	push   $0x32
    204d:	6a 00                	push   $0x0
    204f:	ff 75 08             	pushl  0x8(%ebp)
    2052:	e8 25 eb ff ff       	call   b7c <paintWindow>
    2057:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    205a:	90                   	nop
        default: break;
            
            
    }
    return False;
    205b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2060:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2063:	5b                   	pop    %ebx
    2064:	5e                   	pop    %esi
    2065:	5f                   	pop    %edi
    2066:	5d                   	pop    %ebp
    2067:	c3                   	ret    

00002068 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    2068:	55                   	push   %ebp
    2069:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    206b:	8b 45 0c             	mov    0xc(%ebp),%eax
    206e:	8b 50 08             	mov    0x8(%eax),%edx
    2071:	8b 45 08             	mov    0x8(%ebp),%eax
    2074:	8b 00                	mov    (%eax),%eax
    2076:	39 c2                	cmp    %eax,%edx
    2078:	74 07                	je     2081 <APPreJudge+0x19>
        return False;
    207a:	b8 00 00 00 00       	mov    $0x0,%eax
    207f:	eb 05                	jmp    2086 <APPreJudge+0x1e>
    return True;
    2081:	b8 01 00 00 00       	mov    $0x1,%eax
}
    2086:	5d                   	pop    %ebp
    2087:	c3                   	ret    

00002088 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    2088:	55                   	push   %ebp
    2089:	89 e5                	mov    %esp,%ebp
    208b:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    208e:	8b 45 08             	mov    0x8(%ebp),%eax
    2091:	8b 55 0c             	mov    0xc(%ebp),%edx
    2094:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    209a:	83 ec 0c             	sub    $0xc,%esp
    209d:	ff 75 08             	pushl  0x8(%ebp)
    20a0:	e8 ef ea ff ff       	call   b94 <registWindow>
    20a5:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    20a8:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    20af:	8b 45 08             	mov    0x8(%ebp),%eax
    20b2:	8b 00                	mov    (%eax),%eax
    20b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    20b7:	ff 75 f4             	pushl  -0xc(%ebp)
    20ba:	ff 75 f0             	pushl  -0x10(%ebp)
    20bd:	ff 75 ec             	pushl  -0x14(%ebp)
    20c0:	ff 75 08             	pushl  0x8(%ebp)
    20c3:	e8 80 fc ff ff       	call   1d48 <APSendMessage>
    20c8:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    20cb:	83 ec 0c             	sub    $0xc,%esp
    20ce:	ff 75 08             	pushl  0x8(%ebp)
    20d1:	e8 b6 ea ff ff       	call   b8c <getMessage>
    20d6:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    20d9:	8b 45 08             	mov    0x8(%ebp),%eax
    20dc:	83 c0 74             	add    $0x74,%eax
    20df:	83 ec 08             	sub    $0x8,%esp
    20e2:	50                   	push   %eax
    20e3:	ff 75 08             	pushl  0x8(%ebp)
    20e6:	e8 7d ff ff ff       	call   2068 <APPreJudge>
    20eb:	83 c4 10             	add    $0x10,%esp
    20ee:	84 c0                	test   %al,%al
    20f0:	74 1b                	je     210d <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    20f2:	8b 45 08             	mov    0x8(%ebp),%eax
    20f5:	ff 70 7c             	pushl  0x7c(%eax)
    20f8:	ff 70 78             	pushl  0x78(%eax)
    20fb:	ff 70 74             	pushl  0x74(%eax)
    20fe:	ff 75 08             	pushl  0x8(%ebp)
    2101:	8b 45 0c             	mov    0xc(%ebp),%eax
    2104:	ff d0                	call   *%eax
    2106:	83 c4 10             	add    $0x10,%esp
    2109:	84 c0                	test   %al,%al
    210b:	75 0c                	jne    2119 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    210d:	8b 45 08             	mov    0x8(%ebp),%eax
    2110:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    2117:	eb b2                	jmp    20cb <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    2119:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    211a:	90                   	nop
    211b:	c9                   	leave  
    211c:	c3                   	ret    

0000211d <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    211d:	55                   	push   %ebp
    211e:	89 e5                	mov    %esp,%ebp
    2120:	57                   	push   %edi
    2121:	56                   	push   %esi
    2122:	53                   	push   %ebx
    2123:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    2126:	a1 cc 71 00 00       	mov    0x71cc,%eax
    212b:	85 c0                	test   %eax,%eax
    212d:	0f 85 7a 02 00 00    	jne    23ad <APGridPaint+0x290>
    {
        iconReady = 1;
    2133:	c7 05 cc 71 00 00 01 	movl   $0x1,0x71cc
    213a:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    213d:	8d 45 88             	lea    -0x78(%ebp),%eax
    2140:	83 ec 08             	sub    $0x8,%esp
    2143:	68 bf 2d 00 00       	push   $0x2dbf
    2148:	50                   	push   %eax
    2149:	e8 d3 ef ff ff       	call   1121 <APLoadBitmap>
    214e:	83 c4 0c             	add    $0xc,%esp
    2151:	8b 45 88             	mov    -0x78(%ebp),%eax
    2154:	a3 c4 b6 00 00       	mov    %eax,0xb6c4
    2159:	8b 45 8c             	mov    -0x74(%ebp),%eax
    215c:	a3 c8 b6 00 00       	mov    %eax,0xb6c8
    2161:	8b 45 90             	mov    -0x70(%ebp),%eax
    2164:	a3 cc b6 00 00       	mov    %eax,0xb6cc
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    2169:	83 ec 04             	sub    $0x4,%esp
    216c:	ff 35 cc b6 00 00    	pushl  0xb6cc
    2172:	ff 35 c8 b6 00 00    	pushl  0xb6c8
    2178:	ff 35 c4 b6 00 00    	pushl  0xb6c4
    217e:	e8 d8 f1 ff ff       	call   135b <APCreateCompatibleDCFromBitmap>
    2183:	83 c4 10             	add    $0x10,%esp
    2186:	a3 d8 b6 00 00       	mov    %eax,0xb6d8
        grid_river = APLoadBitmap ("grid_river.bmp");
    218b:	8d 45 88             	lea    -0x78(%ebp),%eax
    218e:	83 ec 08             	sub    $0x8,%esp
    2191:	68 cd 2d 00 00       	push   $0x2dcd
    2196:	50                   	push   %eax
    2197:	e8 85 ef ff ff       	call   1121 <APLoadBitmap>
    219c:	83 c4 0c             	add    $0xc,%esp
    219f:	8b 45 88             	mov    -0x78(%ebp),%eax
    21a2:	a3 6c c8 00 00       	mov    %eax,0xc86c
    21a7:	8b 45 8c             	mov    -0x74(%ebp),%eax
    21aa:	a3 70 c8 00 00       	mov    %eax,0xc870
    21af:	8b 45 90             	mov    -0x70(%ebp),%eax
    21b2:	a3 74 c8 00 00       	mov    %eax,0xc874
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    21b7:	83 ec 04             	sub    $0x4,%esp
    21ba:	ff 35 74 c8 00 00    	pushl  0xc874
    21c0:	ff 35 70 c8 00 00    	pushl  0xc870
    21c6:	ff 35 6c c8 00 00    	pushl  0xc86c
    21cc:	e8 8a f1 ff ff       	call   135b <APCreateCompatibleDCFromBitmap>
    21d1:	83 c4 10             	add    $0x10,%esp
    21d4:	a3 5c c8 00 00       	mov    %eax,0xc85c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    21d9:	8d 45 88             	lea    -0x78(%ebp),%eax
    21dc:	83 ec 08             	sub    $0x8,%esp
    21df:	68 dc 2d 00 00       	push   $0x2ddc
    21e4:	50                   	push   %eax
    21e5:	e8 37 ef ff ff       	call   1121 <APLoadBitmap>
    21ea:	83 c4 0c             	add    $0xc,%esp
    21ed:	8b 45 88             	mov    -0x78(%ebp),%eax
    21f0:	a3 60 c8 00 00       	mov    %eax,0xc860
    21f5:	8b 45 8c             	mov    -0x74(%ebp),%eax
    21f8:	a3 64 c8 00 00       	mov    %eax,0xc864
    21fd:	8b 45 90             	mov    -0x70(%ebp),%eax
    2200:	a3 68 c8 00 00       	mov    %eax,0xc868
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    2205:	83 ec 04             	sub    $0x4,%esp
    2208:	ff 35 68 c8 00 00    	pushl  0xc868
    220e:	ff 35 64 c8 00 00    	pushl  0xc864
    2214:	ff 35 60 c8 00 00    	pushl  0xc860
    221a:	e8 3c f1 ff ff       	call   135b <APCreateCompatibleDCFromBitmap>
    221f:	83 c4 10             	add    $0x10,%esp
    2222:	a3 a4 b6 00 00       	mov    %eax,0xb6a4
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    2227:	8d 45 88             	lea    -0x78(%ebp),%eax
    222a:	83 ec 08             	sub    $0x8,%esp
    222d:	68 eb 2d 00 00       	push   $0x2deb
    2232:	50                   	push   %eax
    2233:	e8 e9 ee ff ff       	call   1121 <APLoadBitmap>
    2238:	83 c4 0c             	add    $0xc,%esp
    223b:	8b 45 88             	mov    -0x78(%ebp),%eax
    223e:	a3 e0 b6 00 00       	mov    %eax,0xb6e0
    2243:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2246:	a3 e4 b6 00 00       	mov    %eax,0xb6e4
    224b:	8b 45 90             	mov    -0x70(%ebp),%eax
    224e:	a3 e8 b6 00 00       	mov    %eax,0xb6e8
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    2253:	83 ec 04             	sub    $0x4,%esp
    2256:	ff 35 e8 b6 00 00    	pushl  0xb6e8
    225c:	ff 35 e4 b6 00 00    	pushl  0xb6e4
    2262:	ff 35 e0 b6 00 00    	pushl  0xb6e0
    2268:	e8 ee f0 ff ff       	call   135b <APCreateCompatibleDCFromBitmap>
    226d:	83 c4 10             	add    $0x10,%esp
    2270:	a3 7c c8 00 00       	mov    %eax,0xc87c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    2275:	8d 45 88             	lea    -0x78(%ebp),%eax
    2278:	83 ec 08             	sub    $0x8,%esp
    227b:	68 f9 2d 00 00       	push   $0x2df9
    2280:	50                   	push   %eax
    2281:	e8 9b ee ff ff       	call   1121 <APLoadBitmap>
    2286:	83 c4 0c             	add    $0xc,%esp
    2289:	8b 45 88             	mov    -0x78(%ebp),%eax
    228c:	a3 b4 b6 00 00       	mov    %eax,0xb6b4
    2291:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2294:	a3 b8 b6 00 00       	mov    %eax,0xb6b8
    2299:	8b 45 90             	mov    -0x70(%ebp),%eax
    229c:	a3 bc b6 00 00       	mov    %eax,0xb6bc
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    22a1:	83 ec 04             	sub    $0x4,%esp
    22a4:	ff 35 bc b6 00 00    	pushl  0xb6bc
    22aa:	ff 35 b8 b6 00 00    	pushl  0xb6b8
    22b0:	ff 35 b4 b6 00 00    	pushl  0xb6b4
    22b6:	e8 a0 f0 ff ff       	call   135b <APCreateCompatibleDCFromBitmap>
    22bb:	83 c4 10             	add    $0x10,%esp
    22be:	a3 dc b6 00 00       	mov    %eax,0xb6dc
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    22c3:	8d 45 88             	lea    -0x78(%ebp),%eax
    22c6:	83 ec 08             	sub    $0x8,%esp
    22c9:	68 09 2e 00 00       	push   $0x2e09
    22ce:	50                   	push   %eax
    22cf:	e8 4d ee ff ff       	call   1121 <APLoadBitmap>
    22d4:	83 c4 0c             	add    $0xc,%esp
    22d7:	8b 45 88             	mov    -0x78(%ebp),%eax
    22da:	a3 a8 b6 00 00       	mov    %eax,0xb6a8
    22df:	8b 45 8c             	mov    -0x74(%ebp),%eax
    22e2:	a3 ac b6 00 00       	mov    %eax,0xb6ac
    22e7:	8b 45 90             	mov    -0x70(%ebp),%eax
    22ea:	a3 b0 b6 00 00       	mov    %eax,0xb6b0
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    22ef:	83 ec 04             	sub    $0x4,%esp
    22f2:	ff 35 b0 b6 00 00    	pushl  0xb6b0
    22f8:	ff 35 ac b6 00 00    	pushl  0xb6ac
    22fe:	ff 35 a8 b6 00 00    	pushl  0xb6a8
    2304:	e8 52 f0 ff ff       	call   135b <APCreateCompatibleDCFromBitmap>
    2309:	83 c4 10             	add    $0x10,%esp
    230c:	a3 c0 b6 00 00       	mov    %eax,0xb6c0
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    2311:	8d 45 88             	lea    -0x78(%ebp),%eax
    2314:	83 ec 08             	sub    $0x8,%esp
    2317:	68 1b 2e 00 00       	push   $0x2e1b
    231c:	50                   	push   %eax
    231d:	e8 ff ed ff ff       	call   1121 <APLoadBitmap>
    2322:	83 c4 0c             	add    $0xc,%esp
    2325:	8b 45 88             	mov    -0x78(%ebp),%eax
    2328:	a3 50 c8 00 00       	mov    %eax,0xc850
    232d:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2330:	a3 54 c8 00 00       	mov    %eax,0xc854
    2335:	8b 45 90             	mov    -0x70(%ebp),%eax
    2338:	a3 58 c8 00 00       	mov    %eax,0xc858
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    233d:	83 ec 04             	sub    $0x4,%esp
    2340:	ff 35 58 c8 00 00    	pushl  0xc858
    2346:	ff 35 54 c8 00 00    	pushl  0xc854
    234c:	ff 35 50 c8 00 00    	pushl  0xc850
    2352:	e8 04 f0 ff ff       	call   135b <APCreateCompatibleDCFromBitmap>
    2357:	83 c4 10             	add    $0x10,%esp
    235a:	a3 80 c8 00 00       	mov    %eax,0xc880
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    235f:	8d 45 88             	lea    -0x78(%ebp),%eax
    2362:	83 ec 08             	sub    $0x8,%esp
    2365:	68 2a 2e 00 00       	push   $0x2e2a
    236a:	50                   	push   %eax
    236b:	e8 b1 ed ff ff       	call   1121 <APLoadBitmap>
    2370:	83 c4 0c             	add    $0xc,%esp
    2373:	8b 45 88             	mov    -0x78(%ebp),%eax
    2376:	a3 f4 b6 00 00       	mov    %eax,0xb6f4
    237b:	8b 45 8c             	mov    -0x74(%ebp),%eax
    237e:	a3 f8 b6 00 00       	mov    %eax,0xb6f8
    2383:	8b 45 90             	mov    -0x70(%ebp),%eax
    2386:	a3 fc b6 00 00       	mov    %eax,0xb6fc
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    238b:	83 ec 04             	sub    $0x4,%esp
    238e:	ff 35 fc b6 00 00    	pushl  0xb6fc
    2394:	ff 35 f8 b6 00 00    	pushl  0xb6f8
    239a:	ff 35 f4 b6 00 00    	pushl  0xb6f4
    23a0:	e8 b6 ef ff ff       	call   135b <APCreateCompatibleDCFromBitmap>
    23a5:	83 c4 10             	add    $0x10,%esp
    23a8:	a3 78 c8 00 00       	mov    %eax,0xc878
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    23ad:	8b 45 08             	mov    0x8(%ebp),%eax
    23b0:	8b 40 08             	mov    0x8(%eax),%eax
    23b3:	85 c0                	test   %eax,%eax
    23b5:	75 17                	jne    23ce <APGridPaint+0x2b1>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    23b7:	83 ec 08             	sub    $0x8,%esp
    23ba:	68 3c 2e 00 00       	push   $0x2e3c
    23bf:	6a 01                	push   $0x1
    23c1:	e8 d5 e8 ff ff       	call   c9b <printf>
    23c6:	83 c4 10             	add    $0x10,%esp
        return;
    23c9:	e9 65 05 00 00       	jmp    2933 <APGridPaint+0x816>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    23ce:	8b 45 08             	mov    0x8(%ebp),%eax
    23d1:	8b 40 10             	mov    0x10(%eax),%eax
    23d4:	85 c0                	test   %eax,%eax
    23d6:	7e 10                	jle    23e8 <APGridPaint+0x2cb>
    23d8:	8b 45 08             	mov    0x8(%ebp),%eax
    23db:	8b 50 14             	mov    0x14(%eax),%edx
    23de:	8b 45 08             	mov    0x8(%ebp),%eax
    23e1:	8b 40 10             	mov    0x10(%eax),%eax
    23e4:	39 c2                	cmp    %eax,%edx
    23e6:	7c 17                	jl     23ff <APGridPaint+0x2e2>
    {
        printf(1,"Grid mode page error!");
    23e8:	83 ec 08             	sub    $0x8,%esp
    23eb:	68 62 2e 00 00       	push   $0x2e62
    23f0:	6a 01                	push   $0x1
    23f2:	e8 a4 e8 ff ff       	call   c9b <printf>
    23f7:	83 c4 10             	add    $0x10,%esp
        return;
    23fa:	e9 34 05 00 00       	jmp    2933 <APGridPaint+0x816>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    23ff:	8b 45 08             	mov    0x8(%ebp),%eax
    2402:	8b 40 14             	mov    0x14(%eax),%eax
    2405:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    240b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    240e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2411:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2414:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    241b:	e9 f4 03 00 00       	jmp    2814 <APGridPaint+0x6f7>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2420:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    2427:	e9 da 03 00 00       	jmp    2806 <APGridPaint+0x6e9>
        {
            index = start + GRID_W_NUMBER * j + i;
    242c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    242f:	c1 e0 04             	shl    $0x4,%eax
    2432:	89 c2                	mov    %eax,%edx
    2434:	8b 45 d8             	mov    -0x28(%ebp),%eax
    2437:	01 c2                	add    %eax,%edx
    2439:	8b 45 e0             	mov    -0x20(%ebp),%eax
    243c:	01 d0                	add    %edx,%eax
    243e:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    2441:	8b 45 08             	mov    0x8(%ebp),%eax
    2444:	8b 40 0c             	mov    0xc(%eax),%eax
    2447:	8b 55 dc             	mov    -0x24(%ebp),%edx
    244a:	c1 e2 02             	shl    $0x2,%edx
    244d:	01 d0                	add    %edx,%eax
    244f:	8b 00                	mov    (%eax),%eax
    2451:	83 f8 0a             	cmp    $0xa,%eax
    2454:	0f 87 a7 03 00 00    	ja     2801 <APGridPaint+0x6e4>
    245a:	8b 04 85 78 2e 00 00 	mov    0x2e78(,%eax,4),%eax
    2461:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2463:	8d 45 c0             	lea    -0x40(%ebp),%eax
    2466:	6a 0c                	push   $0xc
    2468:	6a 0c                	push   $0xc
    246a:	6a 0c                	push   $0xc
    246c:	50                   	push   %eax
    246d:	e8 91 f8 ff ff       	call   1d03 <RGB>
    2472:	83 c4 0c             	add    $0xc,%esp
    2475:	8b 1d d8 b6 00 00    	mov    0xb6d8,%ebx
    247b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    247e:	6b c8 32             	imul   $0x32,%eax,%ecx
    2481:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2484:	6b c0 32             	imul   $0x32,%eax,%eax
    2487:	89 45 84             	mov    %eax,-0x7c(%ebp)
    248a:	8b 45 08             	mov    0x8(%ebp),%eax
    248d:	8d 78 3c             	lea    0x3c(%eax),%edi
    2490:	83 ec 0c             	sub    $0xc,%esp
    2493:	83 ec 04             	sub    $0x4,%esp
    2496:	89 e0                	mov    %esp,%eax
    2498:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    249c:	66 89 30             	mov    %si,(%eax)
    249f:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    24a3:	88 50 02             	mov    %dl,0x2(%eax)
    24a6:	6a 32                	push   $0x32
    24a8:	6a 32                	push   $0x32
    24aa:	6a 00                	push   $0x0
    24ac:	6a 00                	push   $0x0
    24ae:	53                   	push   %ebx
    24af:	51                   	push   %ecx
    24b0:	ff 75 84             	pushl  -0x7c(%ebp)
    24b3:	57                   	push   %edi
    24b4:	e8 a6 f6 ff ff       	call   1b5f <APDcCopy>
    24b9:	83 c4 30             	add    $0x30,%esp
                    break;
    24bc:	e9 41 03 00 00       	jmp    2802 <APGridPaint+0x6e5>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    24c1:	8d 45 88             	lea    -0x78(%ebp),%eax
    24c4:	6a 69                	push   $0x69
    24c6:	6a 69                	push   $0x69
    24c8:	6a 69                	push   $0x69
    24ca:	50                   	push   %eax
    24cb:	e8 33 f8 ff ff       	call   1d03 <RGB>
    24d0:	83 c4 0c             	add    $0xc,%esp
    24d3:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    24d7:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    24db:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    24df:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    24e2:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    24e9:	8d 45 88             	lea    -0x78(%ebp),%eax
    24ec:	6a 69                	push   $0x69
    24ee:	6a 69                	push   $0x69
    24f0:	6a 69                	push   $0x69
    24f2:	50                   	push   %eax
    24f3:	e8 0b f8 ff ff       	call   1d03 <RGB>
    24f8:	83 c4 0c             	add    $0xc,%esp
    24fb:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    24ff:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    2503:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2507:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    250a:	8b 45 08             	mov    0x8(%ebp),%eax
    250d:	8d 50 3c             	lea    0x3c(%eax),%edx
    2510:	8d 45 88             	lea    -0x78(%ebp),%eax
    2513:	ff 75 ac             	pushl  -0x54(%ebp)
    2516:	ff 75 a8             	pushl  -0x58(%ebp)
    2519:	52                   	push   %edx
    251a:	50                   	push   %eax
    251b:	e8 d0 ee ff ff       	call   13f0 <APSetPen>
    2520:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    2523:	8b 45 08             	mov    0x8(%ebp),%eax
    2526:	8d 58 3c             	lea    0x3c(%eax),%ebx
    2529:	8d 55 88             	lea    -0x78(%ebp),%edx
    252c:	83 ec 04             	sub    $0x4,%esp
    252f:	83 ec 04             	sub    $0x4,%esp
    2532:	89 e0                	mov    %esp,%eax
    2534:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    2538:	66 89 08             	mov    %cx,(%eax)
    253b:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    253f:	88 48 02             	mov    %cl,0x2(%eax)
    2542:	53                   	push   %ebx
    2543:	52                   	push   %edx
    2544:	e8 e0 ee ff ff       	call   1429 <APSetBrush>
    2549:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    254c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    254f:	6b d0 32             	imul   $0x32,%eax,%edx
    2552:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2555:	6b c0 32             	imul   $0x32,%eax,%eax
    2558:	8b 4d 08             	mov    0x8(%ebp),%ecx
    255b:	83 c1 3c             	add    $0x3c,%ecx
    255e:	83 ec 0c             	sub    $0xc,%esp
    2561:	6a 32                	push   $0x32
    2563:	6a 32                	push   $0x32
    2565:	52                   	push   %edx
    2566:	50                   	push   %eax
    2567:	51                   	push   %ecx
    2568:	e8 e6 f2 ff ff       	call   1853 <APDrawRect>
    256d:	83 c4 20             	add    $0x20,%esp
                    break;
    2570:	e9 8d 02 00 00       	jmp    2802 <APGridPaint+0x6e5>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2575:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    2578:	6a 0c                	push   $0xc
    257a:	6a 0c                	push   $0xc
    257c:	6a 0c                	push   $0xc
    257e:	50                   	push   %eax
    257f:	e8 7f f7 ff ff       	call   1d03 <RGB>
    2584:	83 c4 0c             	add    $0xc,%esp
    2587:	8b 1d 80 c8 00 00    	mov    0xc880,%ebx
    258d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2590:	6b c8 32             	imul   $0x32,%eax,%ecx
    2593:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2596:	6b c0 32             	imul   $0x32,%eax,%eax
    2599:	89 45 84             	mov    %eax,-0x7c(%ebp)
    259c:	8b 45 08             	mov    0x8(%ebp),%eax
    259f:	8d 78 3c             	lea    0x3c(%eax),%edi
    25a2:	83 ec 0c             	sub    $0xc,%esp
    25a5:	83 ec 04             	sub    $0x4,%esp
    25a8:	89 e0                	mov    %esp,%eax
    25aa:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    25ae:	66 89 30             	mov    %si,(%eax)
    25b1:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    25b5:	88 50 02             	mov    %dl,0x2(%eax)
    25b8:	6a 32                	push   $0x32
    25ba:	6a 32                	push   $0x32
    25bc:	6a 00                	push   $0x0
    25be:	6a 00                	push   $0x0
    25c0:	53                   	push   %ebx
    25c1:	51                   	push   %ecx
    25c2:	ff 75 84             	pushl  -0x7c(%ebp)
    25c5:	57                   	push   %edi
    25c6:	e8 94 f5 ff ff       	call   1b5f <APDcCopy>
    25cb:	83 c4 30             	add    $0x30,%esp
                    break;
    25ce:	e9 2f 02 00 00       	jmp    2802 <APGridPaint+0x6e5>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    25d3:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    25d6:	6a 0c                	push   $0xc
    25d8:	6a 0c                	push   $0xc
    25da:	6a 0c                	push   $0xc
    25dc:	50                   	push   %eax
    25dd:	e8 21 f7 ff ff       	call   1d03 <RGB>
    25e2:	83 c4 0c             	add    $0xc,%esp
    25e5:	8b 1d 5c c8 00 00    	mov    0xc85c,%ebx
    25eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    25ee:	6b c8 32             	imul   $0x32,%eax,%ecx
    25f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    25f4:	6b c0 32             	imul   $0x32,%eax,%eax
    25f7:	89 45 84             	mov    %eax,-0x7c(%ebp)
    25fa:	8b 45 08             	mov    0x8(%ebp),%eax
    25fd:	8d 78 3c             	lea    0x3c(%eax),%edi
    2600:	83 ec 0c             	sub    $0xc,%esp
    2603:	83 ec 04             	sub    $0x4,%esp
    2606:	89 e0                	mov    %esp,%eax
    2608:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    260c:	66 89 30             	mov    %si,(%eax)
    260f:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    2613:	88 50 02             	mov    %dl,0x2(%eax)
    2616:	6a 32                	push   $0x32
    2618:	6a 32                	push   $0x32
    261a:	6a 00                	push   $0x0
    261c:	6a 00                	push   $0x0
    261e:	53                   	push   %ebx
    261f:	51                   	push   %ecx
    2620:	ff 75 84             	pushl  -0x7c(%ebp)
    2623:	57                   	push   %edi
    2624:	e8 36 f5 ff ff       	call   1b5f <APDcCopy>
    2629:	83 c4 30             	add    $0x30,%esp
                    break;
    262c:	e9 d1 01 00 00       	jmp    2802 <APGridPaint+0x6e5>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2631:	8d 45 c9             	lea    -0x37(%ebp),%eax
    2634:	6a 0c                	push   $0xc
    2636:	6a 0c                	push   $0xc
    2638:	6a 0c                	push   $0xc
    263a:	50                   	push   %eax
    263b:	e8 c3 f6 ff ff       	call   1d03 <RGB>
    2640:	83 c4 0c             	add    $0xc,%esp
    2643:	8b 1d dc b6 00 00    	mov    0xb6dc,%ebx
    2649:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    264c:	6b c8 32             	imul   $0x32,%eax,%ecx
    264f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2652:	6b c0 32             	imul   $0x32,%eax,%eax
    2655:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2658:	8b 45 08             	mov    0x8(%ebp),%eax
    265b:	8d 78 3c             	lea    0x3c(%eax),%edi
    265e:	83 ec 0c             	sub    $0xc,%esp
    2661:	83 ec 04             	sub    $0x4,%esp
    2664:	89 e0                	mov    %esp,%eax
    2666:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    266a:	66 89 30             	mov    %si,(%eax)
    266d:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    2671:	88 50 02             	mov    %dl,0x2(%eax)
    2674:	6a 32                	push   $0x32
    2676:	6a 32                	push   $0x32
    2678:	6a 00                	push   $0x0
    267a:	6a 00                	push   $0x0
    267c:	53                   	push   %ebx
    267d:	51                   	push   %ecx
    267e:	ff 75 84             	pushl  -0x7c(%ebp)
    2681:	57                   	push   %edi
    2682:	e8 d8 f4 ff ff       	call   1b5f <APDcCopy>
    2687:	83 c4 30             	add    $0x30,%esp
                    break;
    268a:	e9 73 01 00 00       	jmp    2802 <APGridPaint+0x6e5>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    268f:	8d 45 cc             	lea    -0x34(%ebp),%eax
    2692:	6a 0c                	push   $0xc
    2694:	6a 0c                	push   $0xc
    2696:	6a 0c                	push   $0xc
    2698:	50                   	push   %eax
    2699:	e8 65 f6 ff ff       	call   1d03 <RGB>
    269e:	83 c4 0c             	add    $0xc,%esp
    26a1:	8b 1d 7c c8 00 00    	mov    0xc87c,%ebx
    26a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    26aa:	6b c8 32             	imul   $0x32,%eax,%ecx
    26ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
    26b0:	6b c0 32             	imul   $0x32,%eax,%eax
    26b3:	89 45 84             	mov    %eax,-0x7c(%ebp)
    26b6:	8b 45 08             	mov    0x8(%ebp),%eax
    26b9:	8d 78 3c             	lea    0x3c(%eax),%edi
    26bc:	83 ec 0c             	sub    $0xc,%esp
    26bf:	83 ec 04             	sub    $0x4,%esp
    26c2:	89 e0                	mov    %esp,%eax
    26c4:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    26c8:	66 89 30             	mov    %si,(%eax)
    26cb:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    26cf:	88 50 02             	mov    %dl,0x2(%eax)
    26d2:	6a 32                	push   $0x32
    26d4:	6a 32                	push   $0x32
    26d6:	6a 00                	push   $0x0
    26d8:	6a 00                	push   $0x0
    26da:	53                   	push   %ebx
    26db:	51                   	push   %ecx
    26dc:	ff 75 84             	pushl  -0x7c(%ebp)
    26df:	57                   	push   %edi
    26e0:	e8 7a f4 ff ff       	call   1b5f <APDcCopy>
    26e5:	83 c4 30             	add    $0x30,%esp
                    break;
    26e8:	e9 15 01 00 00       	jmp    2802 <APGridPaint+0x6e5>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    26ed:	8d 45 cf             	lea    -0x31(%ebp),%eax
    26f0:	6a 0c                	push   $0xc
    26f2:	6a 0c                	push   $0xc
    26f4:	6a 0c                	push   $0xc
    26f6:	50                   	push   %eax
    26f7:	e8 07 f6 ff ff       	call   1d03 <RGB>
    26fc:	83 c4 0c             	add    $0xc,%esp
    26ff:	8b 1d a4 b6 00 00    	mov    0xb6a4,%ebx
    2705:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2708:	6b c8 32             	imul   $0x32,%eax,%ecx
    270b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    270e:	6b c0 32             	imul   $0x32,%eax,%eax
    2711:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2714:	8b 45 08             	mov    0x8(%ebp),%eax
    2717:	8d 78 3c             	lea    0x3c(%eax),%edi
    271a:	83 ec 0c             	sub    $0xc,%esp
    271d:	83 ec 04             	sub    $0x4,%esp
    2720:	89 e0                	mov    %esp,%eax
    2722:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2726:	66 89 30             	mov    %si,(%eax)
    2729:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    272d:	88 50 02             	mov    %dl,0x2(%eax)
    2730:	6a 32                	push   $0x32
    2732:	6a 32                	push   $0x32
    2734:	6a 00                	push   $0x0
    2736:	6a 00                	push   $0x0
    2738:	53                   	push   %ebx
    2739:	51                   	push   %ecx
    273a:	ff 75 84             	pushl  -0x7c(%ebp)
    273d:	57                   	push   %edi
    273e:	e8 1c f4 ff ff       	call   1b5f <APDcCopy>
    2743:	83 c4 30             	add    $0x30,%esp
                    break;
    2746:	e9 b7 00 00 00       	jmp    2802 <APGridPaint+0x6e5>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    274b:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    274e:	6a 0c                	push   $0xc
    2750:	6a 0c                	push   $0xc
    2752:	6a 0c                	push   $0xc
    2754:	50                   	push   %eax
    2755:	e8 a9 f5 ff ff       	call   1d03 <RGB>
    275a:	83 c4 0c             	add    $0xc,%esp
    275d:	8b 1d c0 b6 00 00    	mov    0xb6c0,%ebx
    2763:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2766:	6b c8 32             	imul   $0x32,%eax,%ecx
    2769:	8b 45 e0             	mov    -0x20(%ebp),%eax
    276c:	6b c0 32             	imul   $0x32,%eax,%eax
    276f:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2772:	8b 45 08             	mov    0x8(%ebp),%eax
    2775:	8d 78 3c             	lea    0x3c(%eax),%edi
    2778:	83 ec 0c             	sub    $0xc,%esp
    277b:	83 ec 04             	sub    $0x4,%esp
    277e:	89 e0                	mov    %esp,%eax
    2780:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2784:	66 89 30             	mov    %si,(%eax)
    2787:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    278b:	88 50 02             	mov    %dl,0x2(%eax)
    278e:	6a 32                	push   $0x32
    2790:	6a 32                	push   $0x32
    2792:	6a 00                	push   $0x0
    2794:	6a 00                	push   $0x0
    2796:	53                   	push   %ebx
    2797:	51                   	push   %ecx
    2798:	ff 75 84             	pushl  -0x7c(%ebp)
    279b:	57                   	push   %edi
    279c:	e8 be f3 ff ff       	call   1b5f <APDcCopy>
    27a1:	83 c4 30             	add    $0x30,%esp
                    break;
    27a4:	eb 5c                	jmp    2802 <APGridPaint+0x6e5>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    27a6:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    27a9:	6a 0c                	push   $0xc
    27ab:	6a 0c                	push   $0xc
    27ad:	6a 0c                	push   $0xc
    27af:	50                   	push   %eax
    27b0:	e8 4e f5 ff ff       	call   1d03 <RGB>
    27b5:	83 c4 0c             	add    $0xc,%esp
    27b8:	8b 1d 78 c8 00 00    	mov    0xc878,%ebx
    27be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    27c1:	6b c8 32             	imul   $0x32,%eax,%ecx
    27c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    27c7:	6b c0 32             	imul   $0x32,%eax,%eax
    27ca:	89 45 84             	mov    %eax,-0x7c(%ebp)
    27cd:	8b 45 08             	mov    0x8(%ebp),%eax
    27d0:	8d 78 3c             	lea    0x3c(%eax),%edi
    27d3:	83 ec 0c             	sub    $0xc,%esp
    27d6:	83 ec 04             	sub    $0x4,%esp
    27d9:	89 e0                	mov    %esp,%eax
    27db:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    27df:	66 89 30             	mov    %si,(%eax)
    27e2:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    27e6:	88 50 02             	mov    %dl,0x2(%eax)
    27e9:	6a 32                	push   $0x32
    27eb:	6a 32                	push   $0x32
    27ed:	6a 00                	push   $0x0
    27ef:	6a 00                	push   $0x0
    27f1:	53                   	push   %ebx
    27f2:	51                   	push   %ecx
    27f3:	ff 75 84             	pushl  -0x7c(%ebp)
    27f6:	57                   	push   %edi
    27f7:	e8 63 f3 ff ff       	call   1b5f <APDcCopy>
    27fc:	83 c4 30             	add    $0x30,%esp
                    break;
    27ff:	eb 01                	jmp    2802 <APGridPaint+0x6e5>
                default: break;
    2801:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2802:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2806:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    280a:	0f 8e 1c fc ff ff    	jle    242c <APGridPaint+0x30f>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2810:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2814:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2818:	0f 8e 02 fc ff ff    	jle    2420 <APGridPaint+0x303>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    281e:	8d 45 88             	lea    -0x78(%ebp),%eax
    2821:	68 cd 00 00 00       	push   $0xcd
    2826:	6a 74                	push   $0x74
    2828:	6a 18                	push   $0x18
    282a:	50                   	push   %eax
    282b:	e8 d3 f4 ff ff       	call   1d03 <RGB>
    2830:	83 c4 0c             	add    $0xc,%esp
    2833:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2837:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    283b:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    283f:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    2842:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2849:	8d 45 88             	lea    -0x78(%ebp),%eax
    284c:	68 cd 00 00 00       	push   $0xcd
    2851:	6a 74                	push   $0x74
    2853:	6a 18                	push   $0x18
    2855:	50                   	push   %eax
    2856:	e8 a8 f4 ff ff       	call   1d03 <RGB>
    285b:	83 c4 0c             	add    $0xc,%esp
    285e:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2862:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    2866:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    286a:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    286d:	8b 45 08             	mov    0x8(%ebp),%eax
    2870:	8d 50 58             	lea    0x58(%eax),%edx
    2873:	8d 45 88             	lea    -0x78(%ebp),%eax
    2876:	ff 75 bc             	pushl  -0x44(%ebp)
    2879:	ff 75 b8             	pushl  -0x48(%ebp)
    287c:	52                   	push   %edx
    287d:	50                   	push   %eax
    287e:	e8 6d eb ff ff       	call   13f0 <APSetPen>
    2883:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2886:	8b 45 08             	mov    0x8(%ebp),%eax
    2889:	8d 58 58             	lea    0x58(%eax),%ebx
    288c:	8d 55 88             	lea    -0x78(%ebp),%edx
    288f:	83 ec 04             	sub    $0x4,%esp
    2892:	83 ec 04             	sub    $0x4,%esp
    2895:	89 e0                	mov    %esp,%eax
    2897:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    289b:	66 89 08             	mov    %cx,(%eax)
    289e:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    28a2:	88 48 02             	mov    %cl,0x2(%eax)
    28a5:	53                   	push   %ebx
    28a6:	52                   	push   %edx
    28a7:	e8 7d eb ff ff       	call   1429 <APSetBrush>
    28ac:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    28af:	8b 45 08             	mov    0x8(%ebp),%eax
    28b2:	83 c0 58             	add    $0x58,%eax
    28b5:	83 ec 0c             	sub    $0xc,%esp
    28b8:	6a 32                	push   $0x32
    28ba:	68 20 03 00 00       	push   $0x320
    28bf:	6a 00                	push   $0x0
    28c1:	6a 00                	push   $0x0
    28c3:	50                   	push   %eax
    28c4:	e8 8a ef ff ff       	call   1853 <APDrawRect>
    28c9:	83 c4 20             	add    $0x20,%esp


    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    28cc:	8d 45 88             	lea    -0x78(%ebp),%eax
    28cf:	6a 08                	push   $0x8
    28d1:	6a 08                	push   $0x8
    28d3:	6a 08                	push   $0x8
    28d5:	50                   	push   %eax
    28d6:	e8 28 f4 ff ff       	call   1d03 <RGB>
    28db:	83 c4 0c             	add    $0xc,%esp
    28de:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    28e2:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    28e6:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    28ea:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    28ed:	8b 45 08             	mov    0x8(%ebp),%eax
    28f0:	8d 58 58             	lea    0x58(%eax),%ebx
    28f3:	8d 55 88             	lea    -0x78(%ebp),%edx
    28f6:	83 ec 04             	sub    $0x4,%esp
    28f9:	83 ec 04             	sub    $0x4,%esp
    28fc:	89 e0                	mov    %esp,%eax
    28fe:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    2902:	66 89 08             	mov    %cx,(%eax)
    2905:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    2909:	88 48 02             	mov    %cl,0x2(%eax)
    290c:	53                   	push   %ebx
    290d:	52                   	push   %edx
    290e:	e8 58 eb ff ff       	call   146b <APSetFont>
    2913:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    2916:	8b 45 08             	mov    0x8(%ebp),%eax
    2919:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    291f:	8b 45 08             	mov    0x8(%ebp),%eax
    2922:	83 c0 58             	add    $0x58,%eax
    2925:	6a 14                	push   $0x14
    2927:	6a 14                	push   $0x14
    2929:	52                   	push   %edx
    292a:	50                   	push   %eax
    292b:	e8 28 f1 ff ff       	call   1a58 <APDrawText>
    2930:	83 c4 10             	add    $0x10,%esp
    
}
    2933:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2936:	5b                   	pop    %ebx
    2937:	5e                   	pop    %esi
    2938:	5f                   	pop    %edi
    2939:	5d                   	pop    %ebp
    293a:	c3                   	ret    

0000293b <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    293b:	55                   	push   %ebp
    293c:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    293e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2942:	7e 08                	jle    294c <random+0x11>
{
rand_num = seed;
    2944:	8b 45 08             	mov    0x8(%ebp),%eax
    2947:	a3 a0 71 00 00       	mov    %eax,0x71a0
}
rand_num *= 3;
    294c:	8b 15 a0 71 00 00    	mov    0x71a0,%edx
    2952:	89 d0                	mov    %edx,%eax
    2954:	01 c0                	add    %eax,%eax
    2956:	01 d0                	add    %edx,%eax
    2958:	a3 a0 71 00 00       	mov    %eax,0x71a0
if (rand_num < 0)
    295d:	a1 a0 71 00 00       	mov    0x71a0,%eax
    2962:	85 c0                	test   %eax,%eax
    2964:	79 0c                	jns    2972 <random+0x37>
{
rand_num *= (-1);
    2966:	a1 a0 71 00 00       	mov    0x71a0,%eax
    296b:	f7 d8                	neg    %eax
    296d:	a3 a0 71 00 00       	mov    %eax,0x71a0
}
return rand_num % 997;
    2972:	8b 0d a0 71 00 00    	mov    0x71a0,%ecx
    2978:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    297d:	89 c8                	mov    %ecx,%eax
    297f:	f7 ea                	imul   %edx
    2981:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2984:	c1 f8 09             	sar    $0x9,%eax
    2987:	89 c2                	mov    %eax,%edx
    2989:	89 c8                	mov    %ecx,%eax
    298b:	c1 f8 1f             	sar    $0x1f,%eax
    298e:	29 c2                	sub    %eax,%edx
    2990:	89 d0                	mov    %edx,%eax
    2992:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2998:	29 c1                	sub    %eax,%ecx
    299a:	89 c8                	mov    %ecx,%eax
}
    299c:	5d                   	pop    %ebp
    299d:	c3                   	ret    

0000299e <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    299e:	55                   	push   %ebp
    299f:	89 e5                	mov    %esp,%ebp
    29a1:	53                   	push   %ebx
    29a2:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    29a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    29ac:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    29b0:	74 17                	je     29c9 <sprintint+0x2b>
    29b2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    29b6:	79 11                	jns    29c9 <sprintint+0x2b>
        neg = 1;
    29b8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    29bf:	8b 45 10             	mov    0x10(%ebp),%eax
    29c2:	f7 d8                	neg    %eax
    29c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    29c7:	eb 06                	jmp    29cf <sprintint+0x31>
    } else {
        x = xx;
    29c9:	8b 45 10             	mov    0x10(%ebp),%eax
    29cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    29cf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    29d6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    29d9:	8d 41 01             	lea    0x1(%ecx),%eax
    29dc:	89 45 f8             	mov    %eax,-0x8(%ebp)
    29df:	8b 5d 14             	mov    0x14(%ebp),%ebx
    29e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    29e5:	ba 00 00 00 00       	mov    $0x0,%edx
    29ea:	f7 f3                	div    %ebx
    29ec:	89 d0                	mov    %edx,%eax
    29ee:	0f b6 80 a4 71 00 00 	movzbl 0x71a4(%eax),%eax
    29f5:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    29f9:	8b 5d 14             	mov    0x14(%ebp),%ebx
    29fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    29ff:	ba 00 00 00 00       	mov    $0x0,%edx
    2a04:	f7 f3                	div    %ebx
    2a06:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2a09:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2a0d:	75 c7                	jne    29d6 <sprintint+0x38>
    if(neg)
    2a0f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a13:	74 0e                	je     2a23 <sprintint+0x85>
        buf[i++] = '-';
    2a15:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2a18:	8d 50 01             	lea    0x1(%eax),%edx
    2a1b:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2a1e:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2a23:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2a26:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2a29:	eb 1b                	jmp    2a46 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2a2b:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a2e:	8b 00                	mov    (%eax),%eax
    2a30:	8d 48 01             	lea    0x1(%eax),%ecx
    2a33:	8b 55 0c             	mov    0xc(%ebp),%edx
    2a36:	89 0a                	mov    %ecx,(%edx)
    2a38:	89 c2                	mov    %eax,%edx
    2a3a:	8b 45 08             	mov    0x8(%ebp),%eax
    2a3d:	01 d0                	add    %edx,%eax
    2a3f:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2a42:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2a46:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2a4a:	7f df                	jg     2a2b <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2a4c:	eb 21                	jmp    2a6f <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2a4e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a51:	8b 00                	mov    (%eax),%eax
    2a53:	8d 48 01             	lea    0x1(%eax),%ecx
    2a56:	8b 55 0c             	mov    0xc(%ebp),%edx
    2a59:	89 0a                	mov    %ecx,(%edx)
    2a5b:	89 c2                	mov    %eax,%edx
    2a5d:	8b 45 08             	mov    0x8(%ebp),%eax
    2a60:	01 c2                	add    %eax,%edx
    2a62:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2a65:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2a68:	01 c8                	add    %ecx,%eax
    2a6a:	0f b6 00             	movzbl (%eax),%eax
    2a6d:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2a6f:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2a73:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2a77:	79 d5                	jns    2a4e <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2a79:	90                   	nop
    2a7a:	83 c4 20             	add    $0x20,%esp
    2a7d:	5b                   	pop    %ebx
    2a7e:	5d                   	pop    %ebp
    2a7f:	c3                   	ret    

00002a80 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2a80:	55                   	push   %ebp
    2a81:	89 e5                	mov    %esp,%ebp
    2a83:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2a86:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2a8d:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2a94:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2a9b:	8d 45 0c             	lea    0xc(%ebp),%eax
    2a9e:	83 c0 04             	add    $0x4,%eax
    2aa1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2aa4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2aab:	e9 d9 01 00 00       	jmp    2c89 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2ab0:	8b 55 0c             	mov    0xc(%ebp),%edx
    2ab3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2ab6:	01 d0                	add    %edx,%eax
    2ab8:	0f b6 00             	movzbl (%eax),%eax
    2abb:	0f be c0             	movsbl %al,%eax
    2abe:	25 ff 00 00 00       	and    $0xff,%eax
    2ac3:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2ac6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2aca:	75 2c                	jne    2af8 <sprintf+0x78>
            if(c == '%'){
    2acc:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2ad0:	75 0c                	jne    2ade <sprintf+0x5e>
                state = '%';
    2ad2:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2ad9:	e9 a7 01 00 00       	jmp    2c85 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2ade:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2ae1:	8d 50 01             	lea    0x1(%eax),%edx
    2ae4:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2ae7:	89 c2                	mov    %eax,%edx
    2ae9:	8b 45 08             	mov    0x8(%ebp),%eax
    2aec:	01 d0                	add    %edx,%eax
    2aee:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2af1:	88 10                	mov    %dl,(%eax)
    2af3:	e9 8d 01 00 00       	jmp    2c85 <sprintf+0x205>
            }
        } else if(state == '%'){
    2af8:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2afc:	0f 85 83 01 00 00    	jne    2c85 <sprintf+0x205>
            if(c == 'd'){
    2b02:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2b06:	75 4c                	jne    2b54 <sprintf+0xd4>
                buf[bi] = '\0';
    2b08:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2b0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2b0e:	01 d0                	add    %edx,%eax
    2b10:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2b13:	83 ec 0c             	sub    $0xc,%esp
    2b16:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2b19:	50                   	push   %eax
    2b1a:	e8 2b df ff ff       	call   a4a <atoi>
    2b1f:	83 c4 10             	add    $0x10,%esp
    2b22:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2b25:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2b2c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2b2f:	8b 00                	mov    (%eax),%eax
    2b31:	83 ec 08             	sub    $0x8,%esp
    2b34:	ff 75 d8             	pushl  -0x28(%ebp)
    2b37:	6a 01                	push   $0x1
    2b39:	6a 0a                	push   $0xa
    2b3b:	50                   	push   %eax
    2b3c:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2b3f:	50                   	push   %eax
    2b40:	ff 75 08             	pushl  0x8(%ebp)
    2b43:	e8 56 fe ff ff       	call   299e <sprintint>
    2b48:	83 c4 20             	add    $0x20,%esp
                ap++;
    2b4b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2b4f:	e9 2a 01 00 00       	jmp    2c7e <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2b54:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2b58:	74 06                	je     2b60 <sprintf+0xe0>
    2b5a:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2b5e:	75 4c                	jne    2bac <sprintf+0x12c>
                buf[bi] = '\0';
    2b60:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2b63:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2b66:	01 d0                	add    %edx,%eax
    2b68:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2b6b:	83 ec 0c             	sub    $0xc,%esp
    2b6e:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2b71:	50                   	push   %eax
    2b72:	e8 d3 de ff ff       	call   a4a <atoi>
    2b77:	83 c4 10             	add    $0x10,%esp
    2b7a:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2b7d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2b84:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2b87:	8b 00                	mov    (%eax),%eax
    2b89:	83 ec 08             	sub    $0x8,%esp
    2b8c:	ff 75 dc             	pushl  -0x24(%ebp)
    2b8f:	6a 00                	push   $0x0
    2b91:	6a 10                	push   $0x10
    2b93:	50                   	push   %eax
    2b94:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2b97:	50                   	push   %eax
    2b98:	ff 75 08             	pushl  0x8(%ebp)
    2b9b:	e8 fe fd ff ff       	call   299e <sprintint>
    2ba0:	83 c4 20             	add    $0x20,%esp
                ap++;
    2ba3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2ba7:	e9 d2 00 00 00       	jmp    2c7e <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2bac:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2bb0:	75 46                	jne    2bf8 <sprintf+0x178>
                s = (char*)*ap;
    2bb2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2bb5:	8b 00                	mov    (%eax),%eax
    2bb7:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2bba:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2bbe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2bc2:	75 25                	jne    2be9 <sprintf+0x169>
                    s = "(null)";
    2bc4:	c7 45 f4 a4 2e 00 00 	movl   $0x2ea4,-0xc(%ebp)
                while(*s != 0){
    2bcb:	eb 1c                	jmp    2be9 <sprintf+0x169>
                    dst[j++] = *s;
    2bcd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2bd0:	8d 50 01             	lea    0x1(%eax),%edx
    2bd3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2bd6:	89 c2                	mov    %eax,%edx
    2bd8:	8b 45 08             	mov    0x8(%ebp),%eax
    2bdb:	01 c2                	add    %eax,%edx
    2bdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2be0:	0f b6 00             	movzbl (%eax),%eax
    2be3:	88 02                	mov    %al,(%edx)
                    s++;
    2be5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2bec:	0f b6 00             	movzbl (%eax),%eax
    2bef:	84 c0                	test   %al,%al
    2bf1:	75 da                	jne    2bcd <sprintf+0x14d>
    2bf3:	e9 86 00 00 00       	jmp    2c7e <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2bf8:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2bfc:	75 1d                	jne    2c1b <sprintf+0x19b>
                dst[j++] = *ap;
    2bfe:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c01:	8d 50 01             	lea    0x1(%eax),%edx
    2c04:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2c07:	89 c2                	mov    %eax,%edx
    2c09:	8b 45 08             	mov    0x8(%ebp),%eax
    2c0c:	01 c2                	add    %eax,%edx
    2c0e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2c11:	8b 00                	mov    (%eax),%eax
    2c13:	88 02                	mov    %al,(%edx)
                ap++;
    2c15:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2c19:	eb 63                	jmp    2c7e <sprintf+0x1fe>
            } else if(c == '%'){
    2c1b:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2c1f:	75 17                	jne    2c38 <sprintf+0x1b8>
                dst[j++] = c;
    2c21:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c24:	8d 50 01             	lea    0x1(%eax),%edx
    2c27:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2c2a:	89 c2                	mov    %eax,%edx
    2c2c:	8b 45 08             	mov    0x8(%ebp),%eax
    2c2f:	01 d0                	add    %edx,%eax
    2c31:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2c34:	88 10                	mov    %dl,(%eax)
    2c36:	eb 46                	jmp    2c7e <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2c38:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2c3c:	7e 18                	jle    2c56 <sprintf+0x1d6>
    2c3e:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2c42:	7f 12                	jg     2c56 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2c44:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2c47:	8d 50 01             	lea    0x1(%eax),%edx
    2c4a:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2c4d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2c50:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2c54:	eb 2f                	jmp    2c85 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2c56:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c59:	8d 50 01             	lea    0x1(%eax),%edx
    2c5c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2c5f:	89 c2                	mov    %eax,%edx
    2c61:	8b 45 08             	mov    0x8(%ebp),%eax
    2c64:	01 d0                	add    %edx,%eax
    2c66:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2c69:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c6c:	8d 50 01             	lea    0x1(%eax),%edx
    2c6f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2c72:	89 c2                	mov    %eax,%edx
    2c74:	8b 45 08             	mov    0x8(%ebp),%eax
    2c77:	01 d0                	add    %edx,%eax
    2c79:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2c7c:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2c7e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2c85:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2c89:	8b 55 0c             	mov    0xc(%ebp),%edx
    2c8c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2c8f:	01 d0                	add    %edx,%eax
    2c91:	0f b6 00             	movzbl (%eax),%eax
    2c94:	84 c0                	test   %al,%al
    2c96:	0f 85 14 fe ff ff    	jne    2ab0 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2c9c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2c9f:	8d 50 01             	lea    0x1(%eax),%edx
    2ca2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2ca5:	89 c2                	mov    %eax,%edx
    2ca7:	8b 45 08             	mov    0x8(%ebp),%eax
    2caa:	01 d0                	add    %edx,%eax
    2cac:	c6 00 00             	movb   $0x0,(%eax)
}
    2caf:	90                   	nop
    2cb0:	c9                   	leave  
    2cb1:	c3                   	ret    
