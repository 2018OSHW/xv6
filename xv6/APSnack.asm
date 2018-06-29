
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
      d7:	8b 0d ac af 00 00    	mov    0xafac,%ecx
      dd:	8b 15 b0 af 00 00    	mov    0xafb0,%edx
      e3:	a1 60 af 00 00       	mov    0xaf60,%eax
      e8:	6b c9 32             	imul   $0x32,%ecx,%ecx
      eb:	01 ca                	add    %ecx,%edx
      ed:	89 04 95 e0 70 00 00 	mov    %eax,0x70e0(,%edx,4)
	head  = nextpoint(head,current_direction);
      f4:	8b 15 60 af 00 00    	mov    0xaf60,%edx
      fa:	8d 45 e0             	lea    -0x20(%ebp),%eax
      fd:	52                   	push   %edx
      fe:	ff 35 b0 af 00 00    	pushl  0xafb0
     104:	ff 35 ac af 00 00    	pushl  0xafac
     10a:	50                   	push   %eax
     10b:	e8 35 ff ff ff       	call   45 <nextpoint>
     110:	83 c4 0c             	add    $0xc,%esp
     113:	8b 45 e0             	mov    -0x20(%ebp),%eax
     116:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     119:	a3 ac af 00 00       	mov    %eax,0xafac
     11e:	89 15 b0 af 00 00    	mov    %edx,0xafb0
	my_block[head.x][head.y] = current_direction;//head
     124:	8b 0d ac af 00 00    	mov    0xafac,%ecx
     12a:	8b 15 b0 af 00 00    	mov    0xafb0,%edx
     130:	a1 60 af 00 00       	mov    0xaf60,%eax
     135:	6b c9 32             	imul   $0x32,%ecx,%ecx
     138:	01 ca                	add    %ecx,%edx
     13a:	89 04 95 e0 70 00 00 	mov    %eax,0x70e0(,%edx,4)
	if (my_food[head.x][head.y] == 0)
     141:	8b 15 ac af 00 00    	mov    0xafac,%edx
     147:	a1 b0 af 00 00       	mov    0xafb0,%eax
     14c:	6b d2 32             	imul   $0x32,%edx,%edx
     14f:	01 d0                	add    %edx,%eax
     151:	05 c0 af 00 00       	add    $0xafc0,%eax
     156:	0f b6 00             	movzbl (%eax),%eax
     159:	84 c0                	test   %al,%al
     15b:	75 63                	jne    1c0 <Move+0xef>
	{
		int tem = my_block[tail.x][tail.y];
     15d:	8b 15 90 af 00 00    	mov    0xaf90,%edx
     163:	a1 94 af 00 00       	mov    0xaf94,%eax
     168:	6b d2 32             	imul   $0x32,%edx,%edx
     16b:	01 d0                	add    %edx,%eax
     16d:	8b 04 85 e0 70 00 00 	mov    0x70e0(,%eax,4),%eax
     174:	89 45 f4             	mov    %eax,-0xc(%ebp)
		my_block[tail.x][tail.y] = NoDir;
     177:	8b 15 90 af 00 00    	mov    0xaf90,%edx
     17d:	a1 94 af 00 00       	mov    0xaf94,%eax
     182:	6b d2 32             	imul   $0x32,%edx,%edx
     185:	01 d0                	add    %edx,%eax
     187:	c7 04 85 e0 70 00 00 	movl   $0x0,0x70e0(,%eax,4)
     18e:	00 00 00 00 
		tail = nextpoint(tail,tem);	
     192:	8d 45 e0             	lea    -0x20(%ebp),%eax
     195:	ff 75 f4             	pushl  -0xc(%ebp)
     198:	ff 35 94 af 00 00    	pushl  0xaf94
     19e:	ff 35 90 af 00 00    	pushl  0xaf90
     1a4:	50                   	push   %eax
     1a5:	e8 9b fe ff ff       	call   45 <nextpoint>
     1aa:	83 c4 0c             	add    $0xc,%esp
     1ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     1b3:	a3 90 af 00 00       	mov    %eax,0xaf90
     1b8:	89 15 94 af 00 00    	mov    %edx,0xaf94
     1be:	eb 1d                	jmp    1dd <Move+0x10c>
	}//no food
	else
	{
		my_food[head.x][head.y] = 0;
     1c0:	8b 15 ac af 00 00    	mov    0xafac,%edx
     1c6:	a1 b0 af 00 00       	mov    0xafb0,%eax
     1cb:	6b d2 32             	imul   $0x32,%edx,%edx
     1ce:	01 d0                	add    %edx,%eax
     1d0:	05 c0 af 00 00       	add    $0xafc0,%eax
     1d5:	c6 00 00             	movb   $0x0,(%eax)
		updateFood();
     1d8:	e8 a1 04 00 00       	call   67e <updateFood>
	}
	current_direction_copy = current_direction;
     1dd:	a1 60 af 00 00       	mov    0xaf60,%eax
     1e2:	a3 b4 af 00 00       	mov    %eax,0xafb4

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
     202:	68 e8 2b 00 00       	push   $0x2be8
     207:	e8 3a 1b 00 00       	call   1d46 <APCreateWindow>
     20c:	83 c4 10             	add    $0x10,%esp
     20f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf(1,"snack created.\n");
     212:	83 ec 08             	sub    $0x8,%esp
     215:	68 ee 2b 00 00       	push   $0x2bee
     21a:	6a 01                	push   $0x1
     21c:	e8 5a 0a 00 00       	call   c7b <printf>
     221:	83 c4 10             	add    $0x10,%esp
	APWndExec(hwnd,wndProc);
     224:	83 ec 08             	sub    $0x8,%esp
     227:	68 9d 07 00 00       	push   $0x79d
     22c:	ff 75 f4             	pushl  -0xc(%ebp)
     22f:	e8 34 1e 00 00       	call   2068 <APWndExec>
     234:	83 c4 10             	add    $0x10,%esp
	exit();
     237:	e8 90 08 00 00       	call   acc <exit>

0000023c <init>:
}

void init(AHwnd hwnd)
{
     23c:	55                   	push   %ebp
     23d:	89 e5                	mov    %esp,%ebp
     23f:	83 ec 28             	sub    $0x28,%esp
	random(10);
     242:	83 ec 0c             	sub    $0xc,%esp
     245:	6a 0a                	push   $0xa
     247:	e8 23 26 00 00       	call   286f <random>
     24c:	83 c4 10             	add    $0x10,%esp
	for (int i = 0;i < BLOCK_NUM_X;i++)
     24f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     256:	eb 40                	jmp    298 <init+0x5c>
	{
		for (int j = 0;j <BLOCK_NUM_Y;j++)
     258:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     25f:	eb 2d                	jmp    28e <init+0x52>
		{
			my_block[i][j] = NoDir;
     261:	8b 45 f4             	mov    -0xc(%ebp),%eax
     264:	6b d0 32             	imul   $0x32,%eax,%edx
     267:	8b 45 f0             	mov    -0x10(%ebp),%eax
     26a:	01 d0                	add    %edx,%eax
     26c:	c7 04 85 e0 70 00 00 	movl   $0x0,0x70e0(,%eax,4)
     273:	00 00 00 00 
			my_food[i][j] = 0;
     277:	8b 45 f4             	mov    -0xc(%ebp),%eax
     27a:	6b d0 32             	imul   $0x32,%eax,%edx
     27d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     280:	01 d0                	add    %edx,%eax
     282:	05 c0 af 00 00       	add    $0xafc0,%eax
     287:	c6 00 00             	movb   $0x0,(%eax)
void init(AHwnd hwnd)
{
	random(10);
	for (int i = 0;i < BLOCK_NUM_X;i++)
	{
		for (int j = 0;j <BLOCK_NUM_Y;j++)
     28a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     28e:	83 7d f0 31          	cmpl   $0x31,-0x10(%ebp)
     292:	7e cd                	jle    261 <init+0x25>
}

void init(AHwnd hwnd)
{
	random(10);
	for (int i = 0;i < BLOCK_NUM_X;i++)
     294:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     298:	83 7d f4 4f          	cmpl   $0x4f,-0xc(%ebp)
     29c:	7e ba                	jle    258 <init+0x1c>
			my_food[i][j] = 0;

		}

	}
	for (int i = 0;i < 5;i++)
     29e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     2a5:	eb 18                	jmp    2bf <init+0x83>
	{
		my_block[i][0] = Right;
     2a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     2aa:	69 c0 c8 00 00 00    	imul   $0xc8,%eax,%eax
     2b0:	05 e0 70 00 00       	add    $0x70e0,%eax
     2b5:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
			my_food[i][j] = 0;

		}

	}
	for (int i = 0;i < 5;i++)
     2bb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     2bf:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     2c3:	7e e2                	jle    2a7 <init+0x6b>
	{
		my_block[i][0] = Right;
	}
	updateFood();updateFood();updateFood();updateFood();updateFood();
     2c5:	e8 b4 03 00 00       	call   67e <updateFood>
     2ca:	e8 af 03 00 00       	call   67e <updateFood>
     2cf:	e8 aa 03 00 00       	call   67e <updateFood>
     2d4:	e8 a5 03 00 00       	call   67e <updateFood>
     2d9:	e8 a0 03 00 00       	call   67e <updateFood>
	head.x = 4;
     2de:	c7 05 ac af 00 00 04 	movl   $0x4,0xafac
     2e5:	00 00 00 
	head.y = 0;
     2e8:	c7 05 b0 af 00 00 00 	movl   $0x0,0xafb0
     2ef:	00 00 00 
	tail.x = tail.y = 0;
     2f2:	c7 05 94 af 00 00 00 	movl   $0x0,0xaf94
     2f9:	00 00 00 
     2fc:	a1 94 af 00 00       	mov    0xaf94,%eax
     301:	a3 90 af 00 00       	mov    %eax,0xaf90
	current_direction = current_direction_copy = Right;
     306:	c7 05 b4 af 00 00 04 	movl   $0x4,0xafb4
     30d:	00 00 00 
     310:	a1 b4 af 00 00       	mov    0xafb4,%eax
     315:	a3 60 af 00 00       	mov    %eax,0xaf60
    	status = Run;
     31a:	c7 05 90 bf 00 00 00 	movl   $0x0,0xbf90
     321:	00 00 00 
	updateFood();
     324:	e8 55 03 00 00       	call   67e <updateFood>
	AMessage msg;
	msg.type = MSG_PAINT;
     329:	c7 45 e0 03 00 00 00 	movl   $0x3,-0x20(%ebp)
	msg.param = 0;
     330:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	setupTimer(hwnd,1,800);
     337:	83 ec 04             	sub    $0x4,%esp
     33a:	68 20 03 00 00       	push   $0x320
     33f:	6a 01                	push   $0x1
     341:	ff 75 08             	pushl  0x8(%ebp)
     344:	e8 4b 08 00 00       	call   b94 <setupTimer>
     349:	83 c4 10             	add    $0x10,%esp
	APSendMessage(hwnd,msg);
     34c:	ff 75 e8             	pushl  -0x18(%ebp)
     34f:	ff 75 e4             	pushl  -0x1c(%ebp)
     352:	ff 75 e0             	pushl  -0x20(%ebp)
     355:	ff 75 08             	pushl  0x8(%ebp)
     358:	e8 cb 19 00 00       	call   1d28 <APSendMessage>
     35d:	83 c4 10             	add    $0x10,%esp

}
     360:	90                   	nop
     361:	c9                   	leave  
     362:	c3                   	ret    

00000363 <timerUpdate>:

void timerUpdate(AHwnd hwnd)
{
     363:	55                   	push   %ebp
     364:	89 e5                	mov    %esp,%ebp
     366:	83 ec 08             	sub    $0x8,%esp
	if (Is_Dead())
     369:	e8 a2 02 00 00       	call   610 <Is_Dead>
     36e:	84 c0                	test   %al,%al
     370:	74 2e                	je     3a0 <timerUpdate+0x3d>
	{
		status = Dead;
     372:	c7 05 90 bf 00 00 02 	movl   $0x2,0xbf90
     379:	00 00 00 
		printf(1,"Dead!");
     37c:	83 ec 08             	sub    $0x8,%esp
     37f:	68 fe 2b 00 00       	push   $0x2bfe
     384:	6a 01                	push   $0x1
     386:	e8 f0 08 00 00       	call   c7b <printf>
     38b:	83 c4 10             	add    $0x10,%esp
		deleteTimer(hwnd,1);
     38e:	83 ec 08             	sub    $0x8,%esp
     391:	6a 01                	push   $0x1
     393:	ff 75 08             	pushl  0x8(%ebp)
     396:	e8 01 08 00 00       	call   b9c <deleteTimer>
     39b:	83 c4 10             	add    $0x10,%esp
	else
	{
		Move();
	}

}
     39e:	eb 05                	jmp    3a5 <timerUpdate+0x42>
		printf(1,"Dead!");
		deleteTimer(hwnd,1);
	}
	else
	{
		Move();
     3a0:	e8 2c fd ff ff       	call   d1 <Move>
	}

}
     3a5:	90                   	nop
     3a6:	c9                   	leave  
     3a7:	c3                   	ret    

000003a8 <keyDown>:

void keyDown(AHwnd hwnd,AMessage msg)
{
     3a8:	55                   	push   %ebp
     3a9:	89 e5                	mov    %esp,%ebp
     3ab:	83 ec 08             	sub    $0x8,%esp
//printf(1,"msg.param received:%d\n",msg.param);
switch (msg.param)
     3ae:	8b 45 10             	mov    0x10(%ebp),%eax
     3b1:	83 f8 05             	cmp    $0x5,%eax
     3b4:	0f 87 d5 00 00 00    	ja     48f <keyDown+0xe7>
     3ba:	8b 04 85 04 2c 00 00 	mov    0x2c04(,%eax,4),%eax
     3c1:	ff e0                	jmp    *%eax
{
case VK_UP:
//printf(1,"Up Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
     3c3:	a1 b4 af 00 00       	mov    0xafb4,%eax
     3c8:	83 f8 03             	cmp    $0x3,%eax
     3cb:	74 0e                	je     3db <keyDown+0x33>
     3cd:	a1 b4 af 00 00       	mov    0xafb4,%eax
     3d2:	83 f8 04             	cmp    $0x4,%eax
     3d5:	0f 85 b7 00 00 00    	jne    492 <keyDown+0xea>
	current_direction = Up;
     3db:	c7 05 60 af 00 00 01 	movl   $0x1,0xaf60
     3e2:	00 00 00 
break;
     3e5:	e9 a8 00 00 00       	jmp    492 <keyDown+0xea>
case VK_DOWN:
//printf(1,"Down Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
     3ea:	a1 b4 af 00 00       	mov    0xafb4,%eax
     3ef:	83 f8 03             	cmp    $0x3,%eax
     3f2:	74 0e                	je     402 <keyDown+0x5a>
     3f4:	a1 b4 af 00 00       	mov    0xafb4,%eax
     3f9:	83 f8 04             	cmp    $0x4,%eax
     3fc:	0f 85 93 00 00 00    	jne    495 <keyDown+0xed>
	current_direction = Down;
     402:	c7 05 60 af 00 00 02 	movl   $0x2,0xaf60
     409:	00 00 00 
break;
     40c:	e9 84 00 00 00       	jmp    495 <keyDown+0xed>
case VK_LEFT:
//printf(1,"Left Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
     411:	a1 b4 af 00 00       	mov    0xafb4,%eax
     416:	83 f8 01             	cmp    $0x1,%eax
     419:	74 0a                	je     425 <keyDown+0x7d>
     41b:	a1 b4 af 00 00       	mov    0xafb4,%eax
     420:	83 f8 02             	cmp    $0x2,%eax
     423:	75 73                	jne    498 <keyDown+0xf0>
	current_direction = Left;
     425:	c7 05 60 af 00 00 03 	movl   $0x3,0xaf60
     42c:	00 00 00 
break;
     42f:	eb 67                	jmp    498 <keyDown+0xf0>
case VK_RIGHT:
//printf(1,"Right Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
     431:	a1 b4 af 00 00       	mov    0xafb4,%eax
     436:	83 f8 01             	cmp    $0x1,%eax
     439:	74 0a                	je     445 <keyDown+0x9d>
     43b:	a1 b4 af 00 00       	mov    0xafb4,%eax
     440:	83 f8 02             	cmp    $0x2,%eax
     443:	75 56                	jne    49b <keyDown+0xf3>
	current_direction = Right;
     445:	c7 05 60 af 00 00 04 	movl   $0x4,0xaf60
     44c:	00 00 00 
break;
     44f:	eb 4a                	jmp    49b <keyDown+0xf3>
case VK_ESC:
switch(status)
     451:	a1 90 bf 00 00       	mov    0xbf90,%eax
     456:	83 f8 01             	cmp    $0x1,%eax
     459:	74 17                	je     472 <keyDown+0xca>
     45b:	83 f8 02             	cmp    $0x2,%eax
     45e:	74 1e                	je     47e <keyDown+0xd6>
     460:	85 c0                	test   %eax,%eax
     462:	74 02                	je     466 <keyDown+0xbe>
break;
case Dead:
init(hwnd);
break;
default:
break;
     464:	eb 27                	jmp    48d <keyDown+0xe5>
break;
case VK_ESC:
switch(status)
{
case Run:
status = Pause;
     466:	c7 05 90 bf 00 00 01 	movl   $0x1,0xbf90
     46d:	00 00 00 
break;
     470:	eb 1b                	jmp    48d <keyDown+0xe5>
case Pause:
status = Run;
     472:	c7 05 90 bf 00 00 00 	movl   $0x0,0xbf90
     479:	00 00 00 
break;
     47c:	eb 0f                	jmp    48d <keyDown+0xe5>
case Dead:
init(hwnd);
     47e:	83 ec 0c             	sub    $0xc,%esp
     481:	ff 75 08             	pushl  0x8(%ebp)
     484:	e8 b3 fd ff ff       	call   23c <init>
     489:	83 c4 10             	add    $0x10,%esp
break;
     48c:	90                   	nop
default:
break;

}
break;
     48d:	eb 0d                	jmp    49c <keyDown+0xf4>
default:
break;
     48f:	90                   	nop
     490:	eb 0a                	jmp    49c <keyDown+0xf4>
{
case VK_UP:
//printf(1,"Up Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
	current_direction = Up;
break;
     492:	90                   	nop
     493:	eb 07                	jmp    49c <keyDown+0xf4>
case VK_DOWN:
//printf(1,"Down Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
	current_direction = Down;
break;
     495:	90                   	nop
     496:	eb 04                	jmp    49c <keyDown+0xf4>
case VK_LEFT:
//printf(1,"Left Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
	current_direction = Left;
break;
     498:	90                   	nop
     499:	eb 01                	jmp    49c <keyDown+0xf4>
case VK_RIGHT:
//printf(1,"Right Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
	current_direction = Right;
break;
     49b:	90                   	nop
default:
break;

}

}
     49c:	90                   	nop
     49d:	c9                   	leave  
     49e:	c3                   	ret    

0000049f <draw>:

void draw(AHwnd hwnd)
{
     49f:	55                   	push   %ebp
     4a0:	89 e5                	mov    %esp,%ebp
     4a2:	83 ec 28             	sub    $0x28,%esp
	AHdc hdc = &(hwnd->Dc);
     4a5:	8b 45 08             	mov    0x8(%ebp),%eax
     4a8:	83 c0 3c             	add    $0x3c,%eax
     4ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
     4ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4b5:	e9 49 01 00 00       	jmp    603 <draw+0x164>
	{

		for (int j = 0;j < BLOCK_NUM_Y;j++)
     4ba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4c1:	e9 2f 01 00 00       	jmp    5f5 <draw+0x156>
		{
			if (my_block[i][j] == NoDir)
     4c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4c9:	6b d0 32             	imul   $0x32,%eax,%edx
     4cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4cf:	01 d0                	add    %edx,%eax
     4d1:	8b 04 85 e0 70 00 00 	mov    0x70e0(,%eax,4),%eax
     4d8:	85 c0                	test   %eax,%eax
     4da:	75 26                	jne    502 <draw+0x63>
			{
				brush.color = COLOR_BACK;
     4dc:	8d 45 d8             	lea    -0x28(%ebp),%eax
     4df:	6a 00                	push   $0x0
     4e1:	68 ff 00 00 00       	push   $0xff
     4e6:	6a 00                	push   $0x0
     4e8:	50                   	push   %eax
     4e9:	e8 12 fb ff ff       	call   0 <RGB>
     4ee:	83 c4 0c             	add    $0xc,%esp
     4f1:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     4f5:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     4f9:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     4fd:	88 45 eb             	mov    %al,-0x15(%ebp)
     500:	eb 61                	jmp    563 <draw+0xc4>

			}//background
			else
			{
				if (head.x == i && head.y == j)
     502:	a1 ac af 00 00       	mov    0xafac,%eax
     507:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     50a:	75 30                	jne    53c <draw+0x9d>
     50c:	a1 b0 af 00 00       	mov    0xafb0,%eax
     511:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     514:	75 26                	jne    53c <draw+0x9d>
					brush.color = COLOR_HEAD;
     516:	8d 45 d8             	lea    -0x28(%ebp),%eax
     519:	6a 00                	push   $0x0
     51b:	68 80 00 00 00       	push   $0x80
     520:	6a 00                	push   $0x0
     522:	50                   	push   %eax
     523:	e8 d8 fa ff ff       	call   0 <RGB>
     528:	83 c4 0c             	add    $0xc,%esp
     52b:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     52f:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     533:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     537:	88 45 eb             	mov    %al,-0x15(%ebp)
     53a:	eb 27                	jmp    563 <draw+0xc4>
				else
					brush.color = COLOR_BODY;
     53c:	8d 45 d8             	lea    -0x28(%ebp),%eax
     53f:	68 ff 00 00 00       	push   $0xff
     544:	68 ff 00 00 00       	push   $0xff
     549:	6a 00                	push   $0x0
     54b:	50                   	push   %eax
     54c:	e8 af fa ff ff       	call   0 <RGB>
     551:	83 c4 0c             	add    $0xc,%esp
     554:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     558:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     55c:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     560:	88 45 eb             	mov    %al,-0x15(%ebp)
			}
			if (my_food[i][j] == 1)
     563:	8b 45 f4             	mov    -0xc(%ebp),%eax
     566:	6b d0 32             	imul   $0x32,%eax,%edx
     569:	8b 45 f0             	mov    -0x10(%ebp),%eax
     56c:	01 d0                	add    %edx,%eax
     56e:	05 c0 af 00 00       	add    $0xafc0,%eax
     573:	0f b6 00             	movzbl (%eax),%eax
     576:	3c 01                	cmp    $0x1,%al
     578:	75 24                	jne    59e <draw+0xff>
			{
				brush.color = COLOR_FOOD;
     57a:	8d 45 d8             	lea    -0x28(%ebp),%eax
     57d:	6a 00                	push   $0x0
     57f:	6a 00                	push   $0x0
     581:	68 ff 00 00 00       	push   $0xff
     586:	50                   	push   %eax
     587:	e8 74 fa ff ff       	call   0 <RGB>
     58c:	83 c4 0c             	add    $0xc,%esp
     58f:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     593:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     597:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     59b:	88 45 eb             	mov    %al,-0x15(%ebp)
			}
			APSetBrush(hdc,brush);
     59e:	8d 55 d8             	lea    -0x28(%ebp),%edx
     5a1:	83 ec 04             	sub    $0x4,%esp
     5a4:	83 ec 04             	sub    $0x4,%esp
     5a7:	89 e0                	mov    %esp,%eax
     5a9:	0f b7 4d e9          	movzwl -0x17(%ebp),%ecx
     5ad:	66 89 08             	mov    %cx,(%eax)
     5b0:	0f b6 4d eb          	movzbl -0x15(%ebp),%ecx
     5b4:	88 48 02             	mov    %cl,0x2(%eax)
     5b7:	ff 75 ec             	pushl  -0x14(%ebp)
     5ba:	52                   	push   %edx
     5bb:	e8 49 0e 00 00       	call   1409 <APSetBrush>
     5c0:	83 c4 0c             	add    $0xc,%esp
			APDrawRect(hdc,i * BLOCK_WIDTH,j*BLOCK_WIDTH,BLOCK_WIDTH,BLOCK_WIDTH);
     5c3:	8b 55 f0             	mov    -0x10(%ebp),%edx
     5c6:	89 d0                	mov    %edx,%eax
     5c8:	c1 e0 02             	shl    $0x2,%eax
     5cb:	01 d0                	add    %edx,%eax
     5cd:	01 c0                	add    %eax,%eax
     5cf:	89 c1                	mov    %eax,%ecx
     5d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     5d4:	89 d0                	mov    %edx,%eax
     5d6:	c1 e0 02             	shl    $0x2,%eax
     5d9:	01 d0                	add    %edx,%eax
     5db:	01 c0                	add    %eax,%eax
     5dd:	83 ec 0c             	sub    $0xc,%esp
     5e0:	6a 0a                	push   $0xa
     5e2:	6a 0a                	push   $0xa
     5e4:	51                   	push   %ecx
     5e5:	50                   	push   %eax
     5e6:	ff 75 ec             	pushl  -0x14(%ebp)
     5e9:	e8 45 12 00 00       	call   1833 <APDrawRect>
     5ee:	83 c4 20             	add    $0x20,%esp
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
	{

		for (int j = 0;j < BLOCK_NUM_Y;j++)
     5f1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5f5:	83 7d f0 31          	cmpl   $0x31,-0x10(%ebp)
     5f9:	0f 8e c7 fe ff ff    	jle    4c6 <draw+0x27>
void draw(AHwnd hwnd)
{
	AHdc hdc = &(hwnd->Dc);
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
     5ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     603:	83 7d f4 4f          	cmpl   $0x4f,-0xc(%ebp)
     607:	0f 8e ad fe ff ff    	jle    4ba <draw+0x1b>
			}
			APSetBrush(hdc,brush);
			APDrawRect(hdc,i * BLOCK_WIDTH,j*BLOCK_WIDTH,BLOCK_WIDTH,BLOCK_WIDTH);
		}
	}
}
     60d:	90                   	nop
     60e:	c9                   	leave  
     60f:	c3                   	ret    

00000610 <Is_Dead>:

bool Is_Dead()
{
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	83 ec 10             	sub    $0x10,%esp
	APoint p = nextpoint(head,current_direction);
     616:	8b 15 60 af 00 00    	mov    0xaf60,%edx
     61c:	8d 45 f8             	lea    -0x8(%ebp),%eax
     61f:	52                   	push   %edx
     620:	ff 35 b0 af 00 00    	pushl  0xafb0
     626:	ff 35 ac af 00 00    	pushl  0xafac
     62c:	50                   	push   %eax
     62d:	e8 13 fa ff ff       	call   45 <nextpoint>
     632:	83 c4 0c             	add    $0xc,%esp
    if (p.x >= BLOCK_NUM_X || p.y > BLOCK_NUM_Y || p.x < 0 || p.y < 0)
     635:	8b 45 f8             	mov    -0x8(%ebp),%eax
     638:	83 f8 4f             	cmp    $0x4f,%eax
     63b:	7f 16                	jg     653 <Is_Dead+0x43>
     63d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     640:	83 f8 32             	cmp    $0x32,%eax
     643:	7f 0e                	jg     653 <Is_Dead+0x43>
     645:	8b 45 f8             	mov    -0x8(%ebp),%eax
     648:	85 c0                	test   %eax,%eax
     64a:	78 07                	js     653 <Is_Dead+0x43>
     64c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     64f:	85 c0                	test   %eax,%eax
     651:	79 07                	jns    65a <Is_Dead+0x4a>
        return True;
     653:	b8 01 00 00 00       	mov    $0x1,%eax
     658:	eb 22                	jmp    67c <Is_Dead+0x6c>
	if (my_block[p.x][p.y] != NoDir)
     65a:	8b 55 f8             	mov    -0x8(%ebp),%edx
     65d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     660:	6b d2 32             	imul   $0x32,%edx,%edx
     663:	01 d0                	add    %edx,%eax
     665:	8b 04 85 e0 70 00 00 	mov    0x70e0(,%eax,4),%eax
     66c:	85 c0                	test   %eax,%eax
     66e:	74 07                	je     677 <Is_Dead+0x67>
        return True;
     670:	b8 01 00 00 00       	mov    $0x1,%eax
     675:	eb 05                	jmp    67c <Is_Dead+0x6c>
    else
        return False;
     677:	b8 00 00 00 00       	mov    $0x0,%eax
}
     67c:	c9                   	leave  
     67d:	c3                   	ret    

0000067e <updateFood>:

bool updateFood()
{
     67e:	55                   	push   %ebp
     67f:	89 e5                	mov    %esp,%ebp
     681:	83 ec 28             	sub    $0x28,%esp
bool sta = false;
     684:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
for (int i = 0;i < BLOCK_NUM_X;i++)
     688:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     68f:	eb 50                	jmp    6e1 <updateFood+0x63>
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
     691:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     698:	eb 37                	jmp    6d1 <updateFood+0x53>
	{
		if (my_block[i][j] == NoDir && my_food[i][j] == NoDir)
     69a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     69d:	6b d0 32             	imul   $0x32,%eax,%edx
     6a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6a3:	01 d0                	add    %edx,%eax
     6a5:	8b 04 85 e0 70 00 00 	mov    0x70e0(,%eax,4),%eax
     6ac:	85 c0                	test   %eax,%eax
     6ae:	75 1d                	jne    6cd <updateFood+0x4f>
     6b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6b3:	6b d0 32             	imul   $0x32,%eax,%edx
     6b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6b9:	01 d0                	add    %edx,%eax
     6bb:	05 c0 af 00 00       	add    $0xafc0,%eax
     6c0:	0f b6 00             	movzbl (%eax),%eax
     6c3:	84 c0                	test   %al,%al
     6c5:	75 06                	jne    6cd <updateFood+0x4f>
		{
			sta = true;
     6c7:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
			break;
     6cb:	eb 0a                	jmp    6d7 <updateFood+0x59>
bool updateFood()
{
bool sta = false;
for (int i = 0;i < BLOCK_NUM_X;i++)
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
     6cd:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     6d1:	83 7d ec 31          	cmpl   $0x31,-0x14(%ebp)
     6d5:	7e c3                	jle    69a <updateFood+0x1c>
		{
			sta = true;
			break;
		}
	}
	if (sta == true)
     6d7:	80 7d f7 01          	cmpb   $0x1,-0x9(%ebp)
     6db:	74 0c                	je     6e9 <updateFood+0x6b>
}

bool updateFood()
{
bool sta = false;
for (int i = 0;i < BLOCK_NUM_X;i++)
     6dd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6e1:	83 7d f0 4f          	cmpl   $0x4f,-0x10(%ebp)
     6e5:	7e aa                	jle    691 <updateFood+0x13>
     6e7:	eb 01                	jmp    6ea <updateFood+0x6c>
			break;
		}
	}
	if (sta == true)
	{
		break;
     6e9:	90                   	nop
	}
}
if (sta == false)
     6ea:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
     6ee:	75 09                	jne    6f9 <updateFood+0x7b>
{
return sta;
     6f0:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
     6f4:	e9 a2 00 00 00       	jmp    79b <updateFood+0x11d>
}
while(true)
{
int i = random(0) % BLOCK_NUM_X;
     6f9:	83 ec 0c             	sub    $0xc,%esp
     6fc:	6a 00                	push   $0x0
     6fe:	e8 6c 21 00 00       	call   286f <random>
     703:	83 c4 10             	add    $0x10,%esp
     706:	89 c1                	mov    %eax,%ecx
     708:	ba 67 66 66 66       	mov    $0x66666667,%edx
     70d:	89 c8                	mov    %ecx,%eax
     70f:	f7 ea                	imul   %edx
     711:	c1 fa 05             	sar    $0x5,%edx
     714:	89 c8                	mov    %ecx,%eax
     716:	c1 f8 1f             	sar    $0x1f,%eax
     719:	29 c2                	sub    %eax,%edx
     71b:	89 d0                	mov    %edx,%eax
     71d:	89 45 e8             	mov    %eax,-0x18(%ebp)
     720:	8b 55 e8             	mov    -0x18(%ebp),%edx
     723:	89 d0                	mov    %edx,%eax
     725:	c1 e0 02             	shl    $0x2,%eax
     728:	01 d0                	add    %edx,%eax
     72a:	c1 e0 04             	shl    $0x4,%eax
     72d:	29 c1                	sub    %eax,%ecx
     72f:	89 c8                	mov    %ecx,%eax
     731:	89 45 e8             	mov    %eax,-0x18(%ebp)
int j = random(0) % BLOCK_NUM_Y;
     734:	83 ec 0c             	sub    $0xc,%esp
     737:	6a 00                	push   $0x0
     739:	e8 31 21 00 00       	call   286f <random>
     73e:	83 c4 10             	add    $0x10,%esp
     741:	89 c1                	mov    %eax,%ecx
     743:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
     748:	89 c8                	mov    %ecx,%eax
     74a:	f7 ea                	imul   %edx
     74c:	c1 fa 04             	sar    $0x4,%edx
     74f:	89 c8                	mov    %ecx,%eax
     751:	c1 f8 1f             	sar    $0x1f,%eax
     754:	29 c2                	sub    %eax,%edx
     756:	89 d0                	mov    %edx,%eax
     758:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     75b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     75e:	6b c0 32             	imul   $0x32,%eax,%eax
     761:	29 c1                	sub    %eax,%ecx
     763:	89 c8                	mov    %ecx,%eax
     765:	89 45 e4             	mov    %eax,-0x1c(%ebp)
if (my_food[i][j] == 0)
     768:	8b 45 e8             	mov    -0x18(%ebp),%eax
     76b:	6b d0 32             	imul   $0x32,%eax,%edx
     76e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     771:	01 d0                	add    %edx,%eax
     773:	05 c0 af 00 00       	add    $0xafc0,%eax
     778:	0f b6 00             	movzbl (%eax),%eax
     77b:	84 c0                	test   %al,%al
     77d:	0f 85 76 ff ff ff    	jne    6f9 <updateFood+0x7b>
{
	my_food[i][j] = 1;
     783:	8b 45 e8             	mov    -0x18(%ebp),%eax
     786:	6b d0 32             	imul   $0x32,%eax,%edx
     789:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     78c:	01 d0                	add    %edx,%eax
     78e:	05 c0 af 00 00       	add    $0xafc0,%eax
     793:	c6 00 01             	movb   $0x1,(%eax)
return true;
     796:	b8 01 00 00 00       	mov    $0x1,%eax
}

}


}
     79b:	c9                   	leave  
     79c:	c3                   	ret    

0000079d <wndProc>:

bool wndProc(AHwnd hwnd,AMessage msg)
{
     79d:	55                   	push   %ebp
     79e:	89 e5                	mov    %esp,%ebp
     7a0:	83 ec 28             	sub    $0x28,%esp
switch(msg.type)
     7a3:	8b 45 0c             	mov    0xc(%ebp),%eax
     7a6:	83 f8 03             	cmp    $0x3,%eax
     7a9:	0f 84 9f 00 00 00    	je     84e <wndProc+0xb1>
     7af:	83 f8 03             	cmp    $0x3,%eax
     7b2:	77 0a                	ja     7be <wndProc+0x21>
     7b4:	83 f8 02             	cmp    $0x2,%eax
     7b7:	74 14                	je     7cd <wndProc+0x30>
	break;
	case MSG_PAINT:
	draw(hwnd);
	break;
	default:
	break;
     7b9:	e9 a1 00 00 00       	jmp    85f <wndProc+0xc2>

}

bool wndProc(AHwnd hwnd,AMessage msg)
{
switch(msg.type)
     7be:	83 f8 04             	cmp    $0x4,%eax
     7c1:	74 3a                	je     7fd <wndProc+0x60>
     7c3:	83 f8 06             	cmp    $0x6,%eax
     7c6:	74 70                	je     838 <wndProc+0x9b>
	break;
	case MSG_PAINT:
	draw(hwnd);
	break;
	default:
	break;
     7c8:	e9 92 00 00 00       	jmp    85f <wndProc+0xc2>
bool wndProc(AHwnd hwnd,AMessage msg)
{
switch(msg.type)
{
    case MSG_INIT:
    init(hwnd);
     7cd:	83 ec 0c             	sub    $0xc,%esp
     7d0:	ff 75 08             	pushl  0x8(%ebp)
     7d3:	e8 64 fa ff ff       	call   23c <init>
     7d8:	83 c4 10             	add    $0x10,%esp
    AMessage ms;
    ms.type = MSG_PAINT;
     7db:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
    APSendMessage(hwnd,ms);
     7e2:	ff 75 f4             	pushl  -0xc(%ebp)
     7e5:	ff 75 f0             	pushl  -0x10(%ebp)
     7e8:	ff 75 ec             	pushl  -0x14(%ebp)
     7eb:	ff 75 08             	pushl  0x8(%ebp)
     7ee:	e8 35 15 00 00       	call   1d28 <APSendMessage>
     7f3:	83 c4 10             	add    $0x10,%esp
    
    return False;
     7f6:	b8 00 00 00 00       	mov    $0x0,%eax
     7fb:	eb 76                	jmp    873 <wndProc+0xd6>
	case MSG_TIMEOUT:
if (status != Run)
     7fd:	a1 90 bf 00 00       	mov    0xbf90,%eax
     802:	85 c0                	test   %eax,%eax
     804:	75 58                	jne    85e <wndProc+0xc1>
	break;
	timerUpdate(hwnd);
     806:	83 ec 0c             	sub    $0xc,%esp
     809:	ff 75 08             	pushl  0x8(%ebp)
     80c:	e8 52 fb ff ff       	call   363 <timerUpdate>
     811:	83 c4 10             	add    $0x10,%esp
	AMessage msg1;
	msg1.type = MSG_PAINT;
     814:	c7 45 e0 03 00 00 00 	movl   $0x3,-0x20(%ebp)
	msg1.param = 0;
     81b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	APSendMessage(hwnd,msg1);
     822:	ff 75 e8             	pushl  -0x18(%ebp)
     825:	ff 75 e4             	pushl  -0x1c(%ebp)
     828:	ff 75 e0             	pushl  -0x20(%ebp)
     82b:	ff 75 08             	pushl  0x8(%ebp)
     82e:	e8 f5 14 00 00       	call   1d28 <APSendMessage>
     833:	83 c4 10             	add    $0x10,%esp
	break;
     836:	eb 27                	jmp    85f <wndProc+0xc2>
	case MSG_KEY_DOWN:
	keyDown(hwnd,msg);
     838:	ff 75 14             	pushl  0x14(%ebp)
     83b:	ff 75 10             	pushl  0x10(%ebp)
     83e:	ff 75 0c             	pushl  0xc(%ebp)
     841:	ff 75 08             	pushl  0x8(%ebp)
     844:	e8 5f fb ff ff       	call   3a8 <keyDown>
     849:	83 c4 10             	add    $0x10,%esp
	break;
     84c:	eb 11                	jmp    85f <wndProc+0xc2>
	case MSG_PAINT:
	draw(hwnd);
     84e:	83 ec 0c             	sub    $0xc,%esp
     851:	ff 75 08             	pushl  0x8(%ebp)
     854:	e8 46 fc ff ff       	call   49f <draw>
     859:	83 c4 10             	add    $0x10,%esp
	break;
     85c:	eb 01                	jmp    85f <wndProc+0xc2>
    APSendMessage(hwnd,ms);
    
    return False;
	case MSG_TIMEOUT:
if (status != Run)
	break;
     85e:	90                   	nop
	draw(hwnd);
	break;
	default:
	break;
}
return APWndProc(hwnd,msg);
     85f:	ff 75 14             	pushl  0x14(%ebp)
     862:	ff 75 10             	pushl  0x10(%ebp)
     865:	ff 75 0c             	pushl  0xc(%ebp)
     868:	ff 75 08             	pushl  0x8(%ebp)
     86b:	e8 3c 17 00 00       	call   1fac <APWndProc>
     870:	83 c4 10             	add    $0x10,%esp

}
     873:	c9                   	leave  
     874:	c3                   	ret    

00000875 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     875:	55                   	push   %ebp
     876:	89 e5                	mov    %esp,%ebp
     878:	57                   	push   %edi
     879:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     87a:	8b 4d 08             	mov    0x8(%ebp),%ecx
     87d:	8b 55 10             	mov    0x10(%ebp),%edx
     880:	8b 45 0c             	mov    0xc(%ebp),%eax
     883:	89 cb                	mov    %ecx,%ebx
     885:	89 df                	mov    %ebx,%edi
     887:	89 d1                	mov    %edx,%ecx
     889:	fc                   	cld    
     88a:	f3 aa                	rep stos %al,%es:(%edi)
     88c:	89 ca                	mov    %ecx,%edx
     88e:	89 fb                	mov    %edi,%ebx
     890:	89 5d 08             	mov    %ebx,0x8(%ebp)
     893:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     896:	90                   	nop
     897:	5b                   	pop    %ebx
     898:	5f                   	pop    %edi
     899:	5d                   	pop    %ebp
     89a:	c3                   	ret    

0000089b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     89b:	55                   	push   %ebp
     89c:	89 e5                	mov    %esp,%ebp
     89e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     8a1:	8b 45 08             	mov    0x8(%ebp),%eax
     8a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     8a7:	90                   	nop
     8a8:	8b 45 08             	mov    0x8(%ebp),%eax
     8ab:	8d 50 01             	lea    0x1(%eax),%edx
     8ae:	89 55 08             	mov    %edx,0x8(%ebp)
     8b1:	8b 55 0c             	mov    0xc(%ebp),%edx
     8b4:	8d 4a 01             	lea    0x1(%edx),%ecx
     8b7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     8ba:	0f b6 12             	movzbl (%edx),%edx
     8bd:	88 10                	mov    %dl,(%eax)
     8bf:	0f b6 00             	movzbl (%eax),%eax
     8c2:	84 c0                	test   %al,%al
     8c4:	75 e2                	jne    8a8 <strcpy+0xd>
    ;
  return os;
     8c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     8c9:	c9                   	leave  
     8ca:	c3                   	ret    

000008cb <strcmp>:

int
strcmp(const char *p, const char *q)
{
     8cb:	55                   	push   %ebp
     8cc:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     8ce:	eb 08                	jmp    8d8 <strcmp+0xd>
    p++, q++;
     8d0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     8d4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     8d8:	8b 45 08             	mov    0x8(%ebp),%eax
     8db:	0f b6 00             	movzbl (%eax),%eax
     8de:	84 c0                	test   %al,%al
     8e0:	74 10                	je     8f2 <strcmp+0x27>
     8e2:	8b 45 08             	mov    0x8(%ebp),%eax
     8e5:	0f b6 10             	movzbl (%eax),%edx
     8e8:	8b 45 0c             	mov    0xc(%ebp),%eax
     8eb:	0f b6 00             	movzbl (%eax),%eax
     8ee:	38 c2                	cmp    %al,%dl
     8f0:	74 de                	je     8d0 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     8f2:	8b 45 08             	mov    0x8(%ebp),%eax
     8f5:	0f b6 00             	movzbl (%eax),%eax
     8f8:	0f b6 d0             	movzbl %al,%edx
     8fb:	8b 45 0c             	mov    0xc(%ebp),%eax
     8fe:	0f b6 00             	movzbl (%eax),%eax
     901:	0f b6 c0             	movzbl %al,%eax
     904:	29 c2                	sub    %eax,%edx
     906:	89 d0                	mov    %edx,%eax
}
     908:	5d                   	pop    %ebp
     909:	c3                   	ret    

0000090a <strlen>:

uint
strlen(char *s)
{
     90a:	55                   	push   %ebp
     90b:	89 e5                	mov    %esp,%ebp
     90d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     910:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     917:	eb 04                	jmp    91d <strlen+0x13>
     919:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     91d:	8b 55 fc             	mov    -0x4(%ebp),%edx
     920:	8b 45 08             	mov    0x8(%ebp),%eax
     923:	01 d0                	add    %edx,%eax
     925:	0f b6 00             	movzbl (%eax),%eax
     928:	84 c0                	test   %al,%al
     92a:	75 ed                	jne    919 <strlen+0xf>
    ;
  return n;
     92c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     92f:	c9                   	leave  
     930:	c3                   	ret    

00000931 <memset>:

void*
memset(void *dst, int c, uint n)
{
     931:	55                   	push   %ebp
     932:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     934:	8b 45 10             	mov    0x10(%ebp),%eax
     937:	50                   	push   %eax
     938:	ff 75 0c             	pushl  0xc(%ebp)
     93b:	ff 75 08             	pushl  0x8(%ebp)
     93e:	e8 32 ff ff ff       	call   875 <stosb>
     943:	83 c4 0c             	add    $0xc,%esp
  return dst;
     946:	8b 45 08             	mov    0x8(%ebp),%eax
}
     949:	c9                   	leave  
     94a:	c3                   	ret    

0000094b <strchr>:

char*
strchr(const char *s, char c)
{
     94b:	55                   	push   %ebp
     94c:	89 e5                	mov    %esp,%ebp
     94e:	83 ec 04             	sub    $0x4,%esp
     951:	8b 45 0c             	mov    0xc(%ebp),%eax
     954:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     957:	eb 14                	jmp    96d <strchr+0x22>
    if(*s == c)
     959:	8b 45 08             	mov    0x8(%ebp),%eax
     95c:	0f b6 00             	movzbl (%eax),%eax
     95f:	3a 45 fc             	cmp    -0x4(%ebp),%al
     962:	75 05                	jne    969 <strchr+0x1e>
      return (char*)s;
     964:	8b 45 08             	mov    0x8(%ebp),%eax
     967:	eb 13                	jmp    97c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     969:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     96d:	8b 45 08             	mov    0x8(%ebp),%eax
     970:	0f b6 00             	movzbl (%eax),%eax
     973:	84 c0                	test   %al,%al
     975:	75 e2                	jne    959 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     977:	b8 00 00 00 00       	mov    $0x0,%eax
}
     97c:	c9                   	leave  
     97d:	c3                   	ret    

0000097e <gets>:

char*
gets(char *buf, int max)
{
     97e:	55                   	push   %ebp
     97f:	89 e5                	mov    %esp,%ebp
     981:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     984:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     98b:	eb 42                	jmp    9cf <gets+0x51>
    cc = read(0, &c, 1);
     98d:	83 ec 04             	sub    $0x4,%esp
     990:	6a 01                	push   $0x1
     992:	8d 45 ef             	lea    -0x11(%ebp),%eax
     995:	50                   	push   %eax
     996:	6a 00                	push   $0x0
     998:	e8 47 01 00 00       	call   ae4 <read>
     99d:	83 c4 10             	add    $0x10,%esp
     9a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     9a3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     9a7:	7e 33                	jle    9dc <gets+0x5e>
      break;
    buf[i++] = c;
     9a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9ac:	8d 50 01             	lea    0x1(%eax),%edx
     9af:	89 55 f4             	mov    %edx,-0xc(%ebp)
     9b2:	89 c2                	mov    %eax,%edx
     9b4:	8b 45 08             	mov    0x8(%ebp),%eax
     9b7:	01 c2                	add    %eax,%edx
     9b9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     9bd:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     9bf:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     9c3:	3c 0a                	cmp    $0xa,%al
     9c5:	74 16                	je     9dd <gets+0x5f>
     9c7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     9cb:	3c 0d                	cmp    $0xd,%al
     9cd:	74 0e                	je     9dd <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     9cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9d2:	83 c0 01             	add    $0x1,%eax
     9d5:	3b 45 0c             	cmp    0xc(%ebp),%eax
     9d8:	7c b3                	jl     98d <gets+0xf>
     9da:	eb 01                	jmp    9dd <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     9dc:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     9dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
     9e0:	8b 45 08             	mov    0x8(%ebp),%eax
     9e3:	01 d0                	add    %edx,%eax
     9e5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     9e8:	8b 45 08             	mov    0x8(%ebp),%eax
}
     9eb:	c9                   	leave  
     9ec:	c3                   	ret    

000009ed <stat>:

int
stat(char *n, struct stat *st)
{
     9ed:	55                   	push   %ebp
     9ee:	89 e5                	mov    %esp,%ebp
     9f0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     9f3:	83 ec 08             	sub    $0x8,%esp
     9f6:	6a 00                	push   $0x0
     9f8:	ff 75 08             	pushl  0x8(%ebp)
     9fb:	e8 0c 01 00 00       	call   b0c <open>
     a00:	83 c4 10             	add    $0x10,%esp
     a03:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     a06:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a0a:	79 07                	jns    a13 <stat+0x26>
    return -1;
     a0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a11:	eb 25                	jmp    a38 <stat+0x4b>
  r = fstat(fd, st);
     a13:	83 ec 08             	sub    $0x8,%esp
     a16:	ff 75 0c             	pushl  0xc(%ebp)
     a19:	ff 75 f4             	pushl  -0xc(%ebp)
     a1c:	e8 03 01 00 00       	call   b24 <fstat>
     a21:	83 c4 10             	add    $0x10,%esp
     a24:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     a27:	83 ec 0c             	sub    $0xc,%esp
     a2a:	ff 75 f4             	pushl  -0xc(%ebp)
     a2d:	e8 c2 00 00 00       	call   af4 <close>
     a32:	83 c4 10             	add    $0x10,%esp
  return r;
     a35:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     a38:	c9                   	leave  
     a39:	c3                   	ret    

00000a3a <atoi>:

int
atoi(const char *s)
{
     a3a:	55                   	push   %ebp
     a3b:	89 e5                	mov    %esp,%ebp
     a3d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     a40:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     a47:	eb 25                	jmp    a6e <atoi+0x34>
    n = n*10 + *s++ - '0';
     a49:	8b 55 fc             	mov    -0x4(%ebp),%edx
     a4c:	89 d0                	mov    %edx,%eax
     a4e:	c1 e0 02             	shl    $0x2,%eax
     a51:	01 d0                	add    %edx,%eax
     a53:	01 c0                	add    %eax,%eax
     a55:	89 c1                	mov    %eax,%ecx
     a57:	8b 45 08             	mov    0x8(%ebp),%eax
     a5a:	8d 50 01             	lea    0x1(%eax),%edx
     a5d:	89 55 08             	mov    %edx,0x8(%ebp)
     a60:	0f b6 00             	movzbl (%eax),%eax
     a63:	0f be c0             	movsbl %al,%eax
     a66:	01 c8                	add    %ecx,%eax
     a68:	83 e8 30             	sub    $0x30,%eax
     a6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     a6e:	8b 45 08             	mov    0x8(%ebp),%eax
     a71:	0f b6 00             	movzbl (%eax),%eax
     a74:	3c 2f                	cmp    $0x2f,%al
     a76:	7e 0a                	jle    a82 <atoi+0x48>
     a78:	8b 45 08             	mov    0x8(%ebp),%eax
     a7b:	0f b6 00             	movzbl (%eax),%eax
     a7e:	3c 39                	cmp    $0x39,%al
     a80:	7e c7                	jle    a49 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     a82:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     a85:	c9                   	leave  
     a86:	c3                   	ret    

00000a87 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     a87:	55                   	push   %ebp
     a88:	89 e5                	mov    %esp,%ebp
     a8a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     a8d:	8b 45 08             	mov    0x8(%ebp),%eax
     a90:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     a93:	8b 45 0c             	mov    0xc(%ebp),%eax
     a96:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     a99:	eb 17                	jmp    ab2 <memmove+0x2b>
    *dst++ = *src++;
     a9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a9e:	8d 50 01             	lea    0x1(%eax),%edx
     aa1:	89 55 fc             	mov    %edx,-0x4(%ebp)
     aa4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     aa7:	8d 4a 01             	lea    0x1(%edx),%ecx
     aaa:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     aad:	0f b6 12             	movzbl (%edx),%edx
     ab0:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     ab2:	8b 45 10             	mov    0x10(%ebp),%eax
     ab5:	8d 50 ff             	lea    -0x1(%eax),%edx
     ab8:	89 55 10             	mov    %edx,0x10(%ebp)
     abb:	85 c0                	test   %eax,%eax
     abd:	7f dc                	jg     a9b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     abf:	8b 45 08             	mov    0x8(%ebp),%eax
}
     ac2:	c9                   	leave  
     ac3:	c3                   	ret    

00000ac4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     ac4:	b8 01 00 00 00       	mov    $0x1,%eax
     ac9:	cd 40                	int    $0x40
     acb:	c3                   	ret    

00000acc <exit>:
SYSCALL(exit)
     acc:	b8 02 00 00 00       	mov    $0x2,%eax
     ad1:	cd 40                	int    $0x40
     ad3:	c3                   	ret    

00000ad4 <wait>:
SYSCALL(wait)
     ad4:	b8 03 00 00 00       	mov    $0x3,%eax
     ad9:	cd 40                	int    $0x40
     adb:	c3                   	ret    

00000adc <pipe>:
SYSCALL(pipe)
     adc:	b8 04 00 00 00       	mov    $0x4,%eax
     ae1:	cd 40                	int    $0x40
     ae3:	c3                   	ret    

00000ae4 <read>:
SYSCALL(read)
     ae4:	b8 05 00 00 00       	mov    $0x5,%eax
     ae9:	cd 40                	int    $0x40
     aeb:	c3                   	ret    

00000aec <write>:
SYSCALL(write)
     aec:	b8 10 00 00 00       	mov    $0x10,%eax
     af1:	cd 40                	int    $0x40
     af3:	c3                   	ret    

00000af4 <close>:
SYSCALL(close)
     af4:	b8 15 00 00 00       	mov    $0x15,%eax
     af9:	cd 40                	int    $0x40
     afb:	c3                   	ret    

00000afc <kill>:
SYSCALL(kill)
     afc:	b8 06 00 00 00       	mov    $0x6,%eax
     b01:	cd 40                	int    $0x40
     b03:	c3                   	ret    

00000b04 <exec>:
SYSCALL(exec)
     b04:	b8 07 00 00 00       	mov    $0x7,%eax
     b09:	cd 40                	int    $0x40
     b0b:	c3                   	ret    

00000b0c <open>:
SYSCALL(open)
     b0c:	b8 0f 00 00 00       	mov    $0xf,%eax
     b11:	cd 40                	int    $0x40
     b13:	c3                   	ret    

00000b14 <mknod>:
SYSCALL(mknod)
     b14:	b8 11 00 00 00       	mov    $0x11,%eax
     b19:	cd 40                	int    $0x40
     b1b:	c3                   	ret    

00000b1c <unlink>:
SYSCALL(unlink)
     b1c:	b8 12 00 00 00       	mov    $0x12,%eax
     b21:	cd 40                	int    $0x40
     b23:	c3                   	ret    

00000b24 <fstat>:
SYSCALL(fstat)
     b24:	b8 08 00 00 00       	mov    $0x8,%eax
     b29:	cd 40                	int    $0x40
     b2b:	c3                   	ret    

00000b2c <link>:
SYSCALL(link)
     b2c:	b8 13 00 00 00       	mov    $0x13,%eax
     b31:	cd 40                	int    $0x40
     b33:	c3                   	ret    

00000b34 <mkdir>:
SYSCALL(mkdir)
     b34:	b8 14 00 00 00       	mov    $0x14,%eax
     b39:	cd 40                	int    $0x40
     b3b:	c3                   	ret    

00000b3c <chdir>:
SYSCALL(chdir)
     b3c:	b8 09 00 00 00       	mov    $0x9,%eax
     b41:	cd 40                	int    $0x40
     b43:	c3                   	ret    

00000b44 <dup>:
SYSCALL(dup)
     b44:	b8 0a 00 00 00       	mov    $0xa,%eax
     b49:	cd 40                	int    $0x40
     b4b:	c3                   	ret    

00000b4c <getpid>:
SYSCALL(getpid)
     b4c:	b8 0b 00 00 00       	mov    $0xb,%eax
     b51:	cd 40                	int    $0x40
     b53:	c3                   	ret    

00000b54 <sbrk>:
SYSCALL(sbrk)
     b54:	b8 0c 00 00 00       	mov    $0xc,%eax
     b59:	cd 40                	int    $0x40
     b5b:	c3                   	ret    

00000b5c <sleep>:
SYSCALL(sleep)
     b5c:	b8 0d 00 00 00       	mov    $0xd,%eax
     b61:	cd 40                	int    $0x40
     b63:	c3                   	ret    

00000b64 <uptime>:
SYSCALL(uptime)
     b64:	b8 0e 00 00 00       	mov    $0xe,%eax
     b69:	cd 40                	int    $0x40
     b6b:	c3                   	ret    

00000b6c <paintWindow>:

SYSCALL(paintWindow)
     b6c:	b8 16 00 00 00       	mov    $0x16,%eax
     b71:	cd 40                	int    $0x40
     b73:	c3                   	ret    

00000b74 <sendMessage>:
SYSCALL(sendMessage)
     b74:	b8 17 00 00 00       	mov    $0x17,%eax
     b79:	cd 40                	int    $0x40
     b7b:	c3                   	ret    

00000b7c <getMessage>:
SYSCALL(getMessage)
     b7c:	b8 19 00 00 00       	mov    $0x19,%eax
     b81:	cd 40                	int    $0x40
     b83:	c3                   	ret    

00000b84 <registWindow>:
SYSCALL(registWindow)
     b84:	b8 18 00 00 00       	mov    $0x18,%eax
     b89:	cd 40                	int    $0x40
     b8b:	c3                   	ret    

00000b8c <changePosition>:
SYSCALL(changePosition)
     b8c:	b8 1a 00 00 00       	mov    $0x1a,%eax
     b91:	cd 40                	int    $0x40
     b93:	c3                   	ret    

00000b94 <setupTimer>:
SYSCALL(setupTimer)
     b94:	b8 1b 00 00 00       	mov    $0x1b,%eax
     b99:	cd 40                	int    $0x40
     b9b:	c3                   	ret    

00000b9c <deleteTimer>:
SYSCALL(deleteTimer)
     b9c:	b8 1c 00 00 00       	mov    $0x1c,%eax
     ba1:	cd 40                	int    $0x40
     ba3:	c3                   	ret    

00000ba4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     ba4:	55                   	push   %ebp
     ba5:	89 e5                	mov    %esp,%ebp
     ba7:	83 ec 18             	sub    $0x18,%esp
     baa:	8b 45 0c             	mov    0xc(%ebp),%eax
     bad:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     bb0:	83 ec 04             	sub    $0x4,%esp
     bb3:	6a 01                	push   $0x1
     bb5:	8d 45 f4             	lea    -0xc(%ebp),%eax
     bb8:	50                   	push   %eax
     bb9:	ff 75 08             	pushl  0x8(%ebp)
     bbc:	e8 2b ff ff ff       	call   aec <write>
     bc1:	83 c4 10             	add    $0x10,%esp
}
     bc4:	90                   	nop
     bc5:	c9                   	leave  
     bc6:	c3                   	ret    

00000bc7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     bc7:	55                   	push   %ebp
     bc8:	89 e5                	mov    %esp,%ebp
     bca:	53                   	push   %ebx
     bcb:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     bce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     bd5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     bd9:	74 17                	je     bf2 <printint+0x2b>
     bdb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     bdf:	79 11                	jns    bf2 <printint+0x2b>
    neg = 1;
     be1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     be8:	8b 45 0c             	mov    0xc(%ebp),%eax
     beb:	f7 d8                	neg    %eax
     bed:	89 45 ec             	mov    %eax,-0x14(%ebp)
     bf0:	eb 06                	jmp    bf8 <printint+0x31>
  } else {
    x = xx;
     bf2:	8b 45 0c             	mov    0xc(%ebp),%eax
     bf5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     bf8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     bff:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     c02:	8d 41 01             	lea    0x1(%ecx),%eax
     c05:	89 45 f4             	mov    %eax,-0xc(%ebp)
     c08:	8b 5d 10             	mov    0x10(%ebp),%ebx
     c0b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c0e:	ba 00 00 00 00       	mov    $0x0,%edx
     c13:	f7 f3                	div    %ebx
     c15:	89 d0                	mov    %edx,%eax
     c17:	0f b6 80 60 34 00 00 	movzbl 0x3460(%eax),%eax
     c1e:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     c22:	8b 5d 10             	mov    0x10(%ebp),%ebx
     c25:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c28:	ba 00 00 00 00       	mov    $0x0,%edx
     c2d:	f7 f3                	div    %ebx
     c2f:	89 45 ec             	mov    %eax,-0x14(%ebp)
     c32:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     c36:	75 c7                	jne    bff <printint+0x38>
  if(neg)
     c38:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     c3c:	74 2d                	je     c6b <printint+0xa4>
    buf[i++] = '-';
     c3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c41:	8d 50 01             	lea    0x1(%eax),%edx
     c44:	89 55 f4             	mov    %edx,-0xc(%ebp)
     c47:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     c4c:	eb 1d                	jmp    c6b <printint+0xa4>
    putc(fd, buf[i]);
     c4e:	8d 55 dc             	lea    -0x24(%ebp),%edx
     c51:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c54:	01 d0                	add    %edx,%eax
     c56:	0f b6 00             	movzbl (%eax),%eax
     c59:	0f be c0             	movsbl %al,%eax
     c5c:	83 ec 08             	sub    $0x8,%esp
     c5f:	50                   	push   %eax
     c60:	ff 75 08             	pushl  0x8(%ebp)
     c63:	e8 3c ff ff ff       	call   ba4 <putc>
     c68:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     c6b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     c6f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c73:	79 d9                	jns    c4e <printint+0x87>
    putc(fd, buf[i]);
}
     c75:	90                   	nop
     c76:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c79:	c9                   	leave  
     c7a:	c3                   	ret    

00000c7b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     c7b:	55                   	push   %ebp
     c7c:	89 e5                	mov    %esp,%ebp
     c7e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     c81:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     c88:	8d 45 0c             	lea    0xc(%ebp),%eax
     c8b:	83 c0 04             	add    $0x4,%eax
     c8e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     c91:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     c98:	e9 59 01 00 00       	jmp    df6 <printf+0x17b>
    c = fmt[i] & 0xff;
     c9d:	8b 55 0c             	mov    0xc(%ebp),%edx
     ca0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ca3:	01 d0                	add    %edx,%eax
     ca5:	0f b6 00             	movzbl (%eax),%eax
     ca8:	0f be c0             	movsbl %al,%eax
     cab:	25 ff 00 00 00       	and    $0xff,%eax
     cb0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     cb3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     cb7:	75 2c                	jne    ce5 <printf+0x6a>
      if(c == '%'){
     cb9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     cbd:	75 0c                	jne    ccb <printf+0x50>
        state = '%';
     cbf:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     cc6:	e9 27 01 00 00       	jmp    df2 <printf+0x177>
      } else {
        putc(fd, c);
     ccb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cce:	0f be c0             	movsbl %al,%eax
     cd1:	83 ec 08             	sub    $0x8,%esp
     cd4:	50                   	push   %eax
     cd5:	ff 75 08             	pushl  0x8(%ebp)
     cd8:	e8 c7 fe ff ff       	call   ba4 <putc>
     cdd:	83 c4 10             	add    $0x10,%esp
     ce0:	e9 0d 01 00 00       	jmp    df2 <printf+0x177>
      }
    } else if(state == '%'){
     ce5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     ce9:	0f 85 03 01 00 00    	jne    df2 <printf+0x177>
      if(c == 'd'){
     cef:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     cf3:	75 1e                	jne    d13 <printf+0x98>
        printint(fd, *ap, 10, 1);
     cf5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cf8:	8b 00                	mov    (%eax),%eax
     cfa:	6a 01                	push   $0x1
     cfc:	6a 0a                	push   $0xa
     cfe:	50                   	push   %eax
     cff:	ff 75 08             	pushl  0x8(%ebp)
     d02:	e8 c0 fe ff ff       	call   bc7 <printint>
     d07:	83 c4 10             	add    $0x10,%esp
        ap++;
     d0a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     d0e:	e9 d8 00 00 00       	jmp    deb <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     d13:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     d17:	74 06                	je     d1f <printf+0xa4>
     d19:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     d1d:	75 1e                	jne    d3d <printf+0xc2>
        printint(fd, *ap, 16, 0);
     d1f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d22:	8b 00                	mov    (%eax),%eax
     d24:	6a 00                	push   $0x0
     d26:	6a 10                	push   $0x10
     d28:	50                   	push   %eax
     d29:	ff 75 08             	pushl  0x8(%ebp)
     d2c:	e8 96 fe ff ff       	call   bc7 <printint>
     d31:	83 c4 10             	add    $0x10,%esp
        ap++;
     d34:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     d38:	e9 ae 00 00 00       	jmp    deb <printf+0x170>
      } else if(c == 's'){
     d3d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     d41:	75 43                	jne    d86 <printf+0x10b>
        s = (char*)*ap;
     d43:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d46:	8b 00                	mov    (%eax),%eax
     d48:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     d4b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     d4f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     d53:	75 25                	jne    d7a <printf+0xff>
          s = "(null)";
     d55:	c7 45 f4 1c 2c 00 00 	movl   $0x2c1c,-0xc(%ebp)
        while(*s != 0){
     d5c:	eb 1c                	jmp    d7a <printf+0xff>
          putc(fd, *s);
     d5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d61:	0f b6 00             	movzbl (%eax),%eax
     d64:	0f be c0             	movsbl %al,%eax
     d67:	83 ec 08             	sub    $0x8,%esp
     d6a:	50                   	push   %eax
     d6b:	ff 75 08             	pushl  0x8(%ebp)
     d6e:	e8 31 fe ff ff       	call   ba4 <putc>
     d73:	83 c4 10             	add    $0x10,%esp
          s++;
     d76:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     d7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d7d:	0f b6 00             	movzbl (%eax),%eax
     d80:	84 c0                	test   %al,%al
     d82:	75 da                	jne    d5e <printf+0xe3>
     d84:	eb 65                	jmp    deb <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     d86:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     d8a:	75 1d                	jne    da9 <printf+0x12e>
        putc(fd, *ap);
     d8c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d8f:	8b 00                	mov    (%eax),%eax
     d91:	0f be c0             	movsbl %al,%eax
     d94:	83 ec 08             	sub    $0x8,%esp
     d97:	50                   	push   %eax
     d98:	ff 75 08             	pushl  0x8(%ebp)
     d9b:	e8 04 fe ff ff       	call   ba4 <putc>
     da0:	83 c4 10             	add    $0x10,%esp
        ap++;
     da3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     da7:	eb 42                	jmp    deb <printf+0x170>
      } else if(c == '%'){
     da9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     dad:	75 17                	jne    dc6 <printf+0x14b>
        putc(fd, c);
     daf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     db2:	0f be c0             	movsbl %al,%eax
     db5:	83 ec 08             	sub    $0x8,%esp
     db8:	50                   	push   %eax
     db9:	ff 75 08             	pushl  0x8(%ebp)
     dbc:	e8 e3 fd ff ff       	call   ba4 <putc>
     dc1:	83 c4 10             	add    $0x10,%esp
     dc4:	eb 25                	jmp    deb <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     dc6:	83 ec 08             	sub    $0x8,%esp
     dc9:	6a 25                	push   $0x25
     dcb:	ff 75 08             	pushl  0x8(%ebp)
     dce:	e8 d1 fd ff ff       	call   ba4 <putc>
     dd3:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     dd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     dd9:	0f be c0             	movsbl %al,%eax
     ddc:	83 ec 08             	sub    $0x8,%esp
     ddf:	50                   	push   %eax
     de0:	ff 75 08             	pushl  0x8(%ebp)
     de3:	e8 bc fd ff ff       	call   ba4 <putc>
     de8:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     deb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     df2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     df6:	8b 55 0c             	mov    0xc(%ebp),%edx
     df9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     dfc:	01 d0                	add    %edx,%eax
     dfe:	0f b6 00             	movzbl (%eax),%eax
     e01:	84 c0                	test   %al,%al
     e03:	0f 85 94 fe ff ff    	jne    c9d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     e09:	90                   	nop
     e0a:	c9                   	leave  
     e0b:	c3                   	ret    

00000e0c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e0c:	55                   	push   %ebp
     e0d:	89 e5                	mov    %esp,%ebp
     e0f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e12:	8b 45 08             	mov    0x8(%ebp),%eax
     e15:	83 e8 08             	sub    $0x8,%eax
     e18:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e1b:	a1 c8 70 00 00       	mov    0x70c8,%eax
     e20:	89 45 fc             	mov    %eax,-0x4(%ebp)
     e23:	eb 24                	jmp    e49 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e25:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e28:	8b 00                	mov    (%eax),%eax
     e2a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e2d:	77 12                	ja     e41 <free+0x35>
     e2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e32:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e35:	77 24                	ja     e5b <free+0x4f>
     e37:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e3a:	8b 00                	mov    (%eax),%eax
     e3c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     e3f:	77 1a                	ja     e5b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e41:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e44:	8b 00                	mov    (%eax),%eax
     e46:	89 45 fc             	mov    %eax,-0x4(%ebp)
     e49:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e4c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e4f:	76 d4                	jbe    e25 <free+0x19>
     e51:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e54:	8b 00                	mov    (%eax),%eax
     e56:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     e59:	76 ca                	jbe    e25 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     e5b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e5e:	8b 40 04             	mov    0x4(%eax),%eax
     e61:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     e68:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e6b:	01 c2                	add    %eax,%edx
     e6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e70:	8b 00                	mov    (%eax),%eax
     e72:	39 c2                	cmp    %eax,%edx
     e74:	75 24                	jne    e9a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     e76:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e79:	8b 50 04             	mov    0x4(%eax),%edx
     e7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e7f:	8b 00                	mov    (%eax),%eax
     e81:	8b 40 04             	mov    0x4(%eax),%eax
     e84:	01 c2                	add    %eax,%edx
     e86:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e89:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     e8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e8f:	8b 00                	mov    (%eax),%eax
     e91:	8b 10                	mov    (%eax),%edx
     e93:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e96:	89 10                	mov    %edx,(%eax)
     e98:	eb 0a                	jmp    ea4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     e9a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e9d:	8b 10                	mov    (%eax),%edx
     e9f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ea2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     ea4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ea7:	8b 40 04             	mov    0x4(%eax),%eax
     eaa:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     eb1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     eb4:	01 d0                	add    %edx,%eax
     eb6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     eb9:	75 20                	jne    edb <free+0xcf>
    p->s.size += bp->s.size;
     ebb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ebe:	8b 50 04             	mov    0x4(%eax),%edx
     ec1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ec4:	8b 40 04             	mov    0x4(%eax),%eax
     ec7:	01 c2                	add    %eax,%edx
     ec9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ecc:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     ecf:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ed2:	8b 10                	mov    (%eax),%edx
     ed4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ed7:	89 10                	mov    %edx,(%eax)
     ed9:	eb 08                	jmp    ee3 <free+0xd7>
  } else
    p->s.ptr = bp;
     edb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ede:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ee1:	89 10                	mov    %edx,(%eax)
  freep = p;
     ee3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ee6:	a3 c8 70 00 00       	mov    %eax,0x70c8
}
     eeb:	90                   	nop
     eec:	c9                   	leave  
     eed:	c3                   	ret    

00000eee <morecore>:

static Header*
morecore(uint nu)
{
     eee:	55                   	push   %ebp
     eef:	89 e5                	mov    %esp,%ebp
     ef1:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     ef4:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     efb:	77 07                	ja     f04 <morecore+0x16>
    nu = 4096;
     efd:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     f04:	8b 45 08             	mov    0x8(%ebp),%eax
     f07:	c1 e0 03             	shl    $0x3,%eax
     f0a:	83 ec 0c             	sub    $0xc,%esp
     f0d:	50                   	push   %eax
     f0e:	e8 41 fc ff ff       	call   b54 <sbrk>
     f13:	83 c4 10             	add    $0x10,%esp
     f16:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     f19:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     f1d:	75 07                	jne    f26 <morecore+0x38>
    return 0;
     f1f:	b8 00 00 00 00       	mov    $0x0,%eax
     f24:	eb 26                	jmp    f4c <morecore+0x5e>
  hp = (Header*)p;
     f26:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f29:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     f2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f2f:	8b 55 08             	mov    0x8(%ebp),%edx
     f32:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     f35:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f38:	83 c0 08             	add    $0x8,%eax
     f3b:	83 ec 0c             	sub    $0xc,%esp
     f3e:	50                   	push   %eax
     f3f:	e8 c8 fe ff ff       	call   e0c <free>
     f44:	83 c4 10             	add    $0x10,%esp
  return freep;
     f47:	a1 c8 70 00 00       	mov    0x70c8,%eax
}
     f4c:	c9                   	leave  
     f4d:	c3                   	ret    

00000f4e <malloc>:

void*
malloc(uint nbytes)
{
     f4e:	55                   	push   %ebp
     f4f:	89 e5                	mov    %esp,%ebp
     f51:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f54:	8b 45 08             	mov    0x8(%ebp),%eax
     f57:	83 c0 07             	add    $0x7,%eax
     f5a:	c1 e8 03             	shr    $0x3,%eax
     f5d:	83 c0 01             	add    $0x1,%eax
     f60:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     f63:	a1 c8 70 00 00       	mov    0x70c8,%eax
     f68:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f6b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     f6f:	75 23                	jne    f94 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     f71:	c7 45 f0 c0 70 00 00 	movl   $0x70c0,-0x10(%ebp)
     f78:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f7b:	a3 c8 70 00 00       	mov    %eax,0x70c8
     f80:	a1 c8 70 00 00       	mov    0x70c8,%eax
     f85:	a3 c0 70 00 00       	mov    %eax,0x70c0
    base.s.size = 0;
     f8a:	c7 05 c4 70 00 00 00 	movl   $0x0,0x70c4
     f91:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f94:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f97:	8b 00                	mov    (%eax),%eax
     f99:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     f9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f9f:	8b 40 04             	mov    0x4(%eax),%eax
     fa2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     fa5:	72 4d                	jb     ff4 <malloc+0xa6>
      if(p->s.size == nunits)
     fa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     faa:	8b 40 04             	mov    0x4(%eax),%eax
     fad:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     fb0:	75 0c                	jne    fbe <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     fb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fb5:	8b 10                	mov    (%eax),%edx
     fb7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fba:	89 10                	mov    %edx,(%eax)
     fbc:	eb 26                	jmp    fe4 <malloc+0x96>
      else {
        p->s.size -= nunits;
     fbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fc1:	8b 40 04             	mov    0x4(%eax),%eax
     fc4:	2b 45 ec             	sub    -0x14(%ebp),%eax
     fc7:	89 c2                	mov    %eax,%edx
     fc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fcc:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     fcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fd2:	8b 40 04             	mov    0x4(%eax),%eax
     fd5:	c1 e0 03             	shl    $0x3,%eax
     fd8:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     fdb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fde:	8b 55 ec             	mov    -0x14(%ebp),%edx
     fe1:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     fe4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fe7:	a3 c8 70 00 00       	mov    %eax,0x70c8
      return (void*)(p + 1);
     fec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fef:	83 c0 08             	add    $0x8,%eax
     ff2:	eb 3b                	jmp    102f <malloc+0xe1>
    }
    if(p == freep)
     ff4:	a1 c8 70 00 00       	mov    0x70c8,%eax
     ff9:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     ffc:	75 1e                	jne    101c <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     ffe:	83 ec 0c             	sub    $0xc,%esp
    1001:	ff 75 ec             	pushl  -0x14(%ebp)
    1004:	e8 e5 fe ff ff       	call   eee <morecore>
    1009:	83 c4 10             	add    $0x10,%esp
    100c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    100f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1013:	75 07                	jne    101c <malloc+0xce>
        return 0;
    1015:	b8 00 00 00 00       	mov    $0x0,%eax
    101a:	eb 13                	jmp    102f <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    101c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    101f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1022:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1025:	8b 00                	mov    (%eax),%eax
    1027:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    102a:	e9 6d ff ff ff       	jmp    f9c <malloc+0x4e>
}
    102f:	c9                   	leave  
    1030:	c3                   	ret    

00001031 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1031:	55                   	push   %ebp
    1032:	89 e5                	mov    %esp,%ebp
    1034:	83 ec 1c             	sub    $0x1c,%esp
    1037:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    103a:	8b 55 10             	mov    0x10(%ebp),%edx
    103d:	8b 45 14             	mov    0x14(%ebp),%eax
    1040:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1043:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1046:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1049:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    104d:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1050:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1054:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1057:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    105b:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    105e:	8b 45 08             	mov    0x8(%ebp),%eax
    1061:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1065:	66 89 10             	mov    %dx,(%eax)
    1068:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    106c:	88 50 02             	mov    %dl,0x2(%eax)
}
    106f:	8b 45 08             	mov    0x8(%ebp),%eax
    1072:	c9                   	leave  
    1073:	c2 04 00             	ret    $0x4

00001076 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    1076:	55                   	push   %ebp
    1077:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
    1079:	8b 45 08             	mov    0x8(%ebp),%eax
    107c:	2b 45 10             	sub    0x10(%ebp),%eax
    107f:	89 c2                	mov    %eax,%edx
    1081:	8b 45 08             	mov    0x8(%ebp),%eax
    1084:	2b 45 10             	sub    0x10(%ebp),%eax
    1087:	0f af d0             	imul   %eax,%edx
    108a:	8b 45 0c             	mov    0xc(%ebp),%eax
    108d:	2b 45 14             	sub    0x14(%ebp),%eax
    1090:	89 c1                	mov    %eax,%ecx
    1092:	8b 45 0c             	mov    0xc(%ebp),%eax
    1095:	2b 45 14             	sub    0x14(%ebp),%eax
    1098:	0f af c1             	imul   %ecx,%eax
    109b:	01 d0                	add    %edx,%eax
}
    109d:	5d                   	pop    %ebp
    109e:	c3                   	ret    

0000109f <abs_int>:

static inline int abs_int(int x)
{
    109f:	55                   	push   %ebp
    10a0:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
    10a2:	8b 45 08             	mov    0x8(%ebp),%eax
    10a5:	99                   	cltd   
    10a6:	89 d0                	mov    %edx,%eax
    10a8:	33 45 08             	xor    0x8(%ebp),%eax
    10ab:	29 d0                	sub    %edx,%eax
}
    10ad:	5d                   	pop    %ebp
    10ae:	c3                   	ret    

000010af <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    10af:	55                   	push   %ebp
    10b0:	89 e5                	mov    %esp,%ebp
    if (x < 0)
    10b2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10b6:	79 07                	jns    10bf <APGetIndex+0x10>
        return X_SMALLER;
    10b8:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    10bd:	eb 40                	jmp    10ff <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
    10bf:	8b 45 08             	mov    0x8(%ebp),%eax
    10c2:	8b 00                	mov    (%eax),%eax
    10c4:	3b 45 0c             	cmp    0xc(%ebp),%eax
    10c7:	7f 07                	jg     10d0 <APGetIndex+0x21>
        return X_BIGGER;
    10c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    10ce:	eb 2f                	jmp    10ff <APGetIndex+0x50>
    if (y < 0)
    10d0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    10d4:	79 07                	jns    10dd <APGetIndex+0x2e>
        return Y_SMALLER;
    10d6:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
    10db:	eb 22                	jmp    10ff <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
    10dd:	8b 45 08             	mov    0x8(%ebp),%eax
    10e0:	8b 40 04             	mov    0x4(%eax),%eax
    10e3:	3b 45 10             	cmp    0x10(%ebp),%eax
    10e6:	7f 07                	jg     10ef <APGetIndex+0x40>
        return Y_BIGGER;
    10e8:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    10ed:	eb 10                	jmp    10ff <APGetIndex+0x50>
    return y * hdc->size.cx + x;
    10ef:	8b 45 08             	mov    0x8(%ebp),%eax
    10f2:	8b 00                	mov    (%eax),%eax
    10f4:	0f af 45 10          	imul   0x10(%ebp),%eax
    10f8:	89 c2                	mov    %eax,%edx
    10fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    10fd:	01 d0                	add    %edx,%eax
}
    10ff:	5d                   	pop    %ebp
    1100:	c3                   	ret    

00001101 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    1101:	55                   	push   %ebp
    1102:	89 e5                	mov    %esp,%ebp
    1104:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    1107:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    110e:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1111:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    1114:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    111b:	83 ec 08             	sub    $0x8,%esp
    111e:	6a 00                	push   $0x0
    1120:	ff 75 0c             	pushl  0xc(%ebp)
    1123:	e8 e4 f9 ff ff       	call   b0c <open>
    1128:	83 c4 10             	add    $0x10,%esp
    112b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    112e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1132:	79 2e                	jns    1162 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
    1134:	83 ec 04             	sub    $0x4,%esp
    1137:	ff 75 0c             	pushl  0xc(%ebp)
    113a:	68 23 2c 00 00       	push   $0x2c23
    113f:	6a 01                	push   $0x1
    1141:	e8 35 fb ff ff       	call   c7b <printf>
    1146:	83 c4 10             	add    $0x10,%esp
        return bmp;
    1149:	8b 45 08             	mov    0x8(%ebp),%eax
    114c:	8b 55 c8             	mov    -0x38(%ebp),%edx
    114f:	89 10                	mov    %edx,(%eax)
    1151:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1154:	89 50 04             	mov    %edx,0x4(%eax)
    1157:	8b 55 d0             	mov    -0x30(%ebp),%edx
    115a:	89 50 08             	mov    %edx,0x8(%eax)
    115d:	e9 d2 01 00 00       	jmp    1334 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    1162:	83 ec 04             	sub    $0x4,%esp
    1165:	6a 0e                	push   $0xe
    1167:	8d 45 ba             	lea    -0x46(%ebp),%eax
    116a:	50                   	push   %eax
    116b:	ff 75 ec             	pushl  -0x14(%ebp)
    116e:	e8 71 f9 ff ff       	call   ae4 <read>
    1173:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    1176:	83 ec 04             	sub    $0x4,%esp
    1179:	6a 28                	push   $0x28
    117b:	8d 45 92             	lea    -0x6e(%ebp),%eax
    117e:	50                   	push   %eax
    117f:	ff 75 ec             	pushl  -0x14(%ebp)
    1182:	e8 5d f9 ff ff       	call   ae4 <read>
    1187:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    118a:	8b 45 96             	mov    -0x6a(%ebp),%eax
    118d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    1190:	8b 45 9a             	mov    -0x66(%ebp),%eax
    1193:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    1196:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1199:	8b 45 cc             	mov    -0x34(%ebp),%eax
    119c:	0f af d0             	imul   %eax,%edx
    119f:	89 d0                	mov    %edx,%eax
    11a1:	01 c0                	add    %eax,%eax
    11a3:	01 d0                	add    %edx,%eax
    11a5:	83 ec 0c             	sub    $0xc,%esp
    11a8:	50                   	push   %eax
    11a9:	e8 a0 fd ff ff       	call   f4e <malloc>
    11ae:	83 c4 10             	add    $0x10,%esp
    11b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    11b4:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    11b8:	0f b7 c0             	movzwl %ax,%eax
    11bb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    11be:	8b 55 c8             	mov    -0x38(%ebp),%edx
    11c1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11c4:	0f af c2             	imul   %edx,%eax
    11c7:	83 c0 1f             	add    $0x1f,%eax
    11ca:	c1 e8 05             	shr    $0x5,%eax
    11cd:	c1 e0 02             	shl    $0x2,%eax
    11d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    11d3:	8b 55 cc             	mov    -0x34(%ebp),%edx
    11d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11d9:	0f af c2             	imul   %edx,%eax
    11dc:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    11df:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11e2:	83 ec 0c             	sub    $0xc,%esp
    11e5:	50                   	push   %eax
    11e6:	e8 63 fd ff ff       	call   f4e <malloc>
    11eb:	83 c4 10             	add    $0x10,%esp
    11ee:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    11f1:	83 ec 04             	sub    $0x4,%esp
    11f4:	ff 75 e0             	pushl  -0x20(%ebp)
    11f7:	ff 75 dc             	pushl  -0x24(%ebp)
    11fa:	ff 75 ec             	pushl  -0x14(%ebp)
    11fd:	e8 e2 f8 ff ff       	call   ae4 <read>
    1202:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    1205:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    1209:	66 c1 e8 03          	shr    $0x3,%ax
    120d:	0f b7 c0             	movzwl %ax,%eax
    1210:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    1213:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    121a:	e9 e5 00 00 00       	jmp    1304 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    121f:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1222:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1225:	29 c2                	sub    %eax,%edx
    1227:	89 d0                	mov    %edx,%eax
    1229:	8d 50 ff             	lea    -0x1(%eax),%edx
    122c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    122f:	0f af c2             	imul   %edx,%eax
    1232:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    1235:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    123c:	e9 b1 00 00 00       	jmp    12f2 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    1241:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1244:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1247:	8b 45 f0             	mov    -0x10(%ebp),%eax
    124a:	01 c8                	add    %ecx,%eax
    124c:	89 c1                	mov    %eax,%ecx
    124e:	89 c8                	mov    %ecx,%eax
    1250:	01 c0                	add    %eax,%eax
    1252:	01 c8                	add    %ecx,%eax
    1254:	01 c2                	add    %eax,%edx
    1256:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1259:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    125d:	89 c1                	mov    %eax,%ecx
    125f:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1262:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1266:	01 c1                	add    %eax,%ecx
    1268:	8b 45 d8             	mov    -0x28(%ebp),%eax
    126b:	01 c8                	add    %ecx,%eax
    126d:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1270:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1273:	01 c8                	add    %ecx,%eax
    1275:	0f b6 00             	movzbl (%eax),%eax
    1278:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    127b:	8b 55 d0             	mov    -0x30(%ebp),%edx
    127e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1281:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1284:	01 c8                	add    %ecx,%eax
    1286:	89 c1                	mov    %eax,%ecx
    1288:	89 c8                	mov    %ecx,%eax
    128a:	01 c0                	add    %eax,%eax
    128c:	01 c8                	add    %ecx,%eax
    128e:	01 c2                	add    %eax,%edx
    1290:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1293:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1297:	89 c1                	mov    %eax,%ecx
    1299:	8b 45 d8             	mov    -0x28(%ebp),%eax
    129c:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    12a0:	01 c1                	add    %eax,%ecx
    12a2:	8b 45 d8             	mov    -0x28(%ebp),%eax
    12a5:	01 c8                	add    %ecx,%eax
    12a7:	8d 48 fe             	lea    -0x2(%eax),%ecx
    12aa:	8b 45 dc             	mov    -0x24(%ebp),%eax
    12ad:	01 c8                	add    %ecx,%eax
    12af:	0f b6 00             	movzbl (%eax),%eax
    12b2:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    12b5:	8b 55 d0             	mov    -0x30(%ebp),%edx
    12b8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    12bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12be:	01 c8                	add    %ecx,%eax
    12c0:	89 c1                	mov    %eax,%ecx
    12c2:	89 c8                	mov    %ecx,%eax
    12c4:	01 c0                	add    %eax,%eax
    12c6:	01 c8                	add    %ecx,%eax
    12c8:	01 c2                	add    %eax,%edx
    12ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12cd:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    12d1:	89 c1                	mov    %eax,%ecx
    12d3:	8b 45 d8             	mov    -0x28(%ebp),%eax
    12d6:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    12da:	01 c1                	add    %eax,%ecx
    12dc:	8b 45 d8             	mov    -0x28(%ebp),%eax
    12df:	01 c8                	add    %ecx,%eax
    12e1:	8d 48 fd             	lea    -0x3(%eax),%ecx
    12e4:	8b 45 dc             	mov    -0x24(%ebp),%eax
    12e7:	01 c8                	add    %ecx,%eax
    12e9:	0f b6 00             	movzbl (%eax),%eax
    12ec:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    12ee:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    12f2:	8b 55 c8             	mov    -0x38(%ebp),%edx
    12f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12f8:	39 c2                	cmp    %eax,%edx
    12fa:	0f 87 41 ff ff ff    	ja     1241 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    1300:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1304:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1307:	8b 45 f4             	mov    -0xc(%ebp),%eax
    130a:	39 c2                	cmp    %eax,%edx
    130c:	0f 87 0d ff ff ff    	ja     121f <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    1312:	83 ec 0c             	sub    $0xc,%esp
    1315:	ff 75 ec             	pushl  -0x14(%ebp)
    1318:	e8 d7 f7 ff ff       	call   af4 <close>
    131d:	83 c4 10             	add    $0x10,%esp
    return bmp;
    1320:	8b 45 08             	mov    0x8(%ebp),%eax
    1323:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1326:	89 10                	mov    %edx,(%eax)
    1328:	8b 55 cc             	mov    -0x34(%ebp),%edx
    132b:	89 50 04             	mov    %edx,0x4(%eax)
    132e:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1331:	89 50 08             	mov    %edx,0x8(%eax)
}
    1334:	8b 45 08             	mov    0x8(%ebp),%eax
    1337:	c9                   	leave  
    1338:	c2 04 00             	ret    $0x4

0000133b <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    133b:	55                   	push   %ebp
    133c:	89 e5                	mov    %esp,%ebp
    133e:	53                   	push   %ebx
    133f:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    1342:	83 ec 0c             	sub    $0xc,%esp
    1345:	6a 1c                	push   $0x1c
    1347:	e8 02 fc ff ff       	call   f4e <malloc>
    134c:	83 c4 10             	add    $0x10,%esp
    134f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    1352:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1355:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    135c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    135f:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1362:	6a 0c                	push   $0xc
    1364:	6a 0c                	push   $0xc
    1366:	6a 0c                	push   $0xc
    1368:	50                   	push   %eax
    1369:	e8 c3 fc ff ff       	call   1031 <RGB>
    136e:	83 c4 0c             	add    $0xc,%esp
    1371:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    1375:	66 89 43 13          	mov    %ax,0x13(%ebx)
    1379:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    137d:	88 43 15             	mov    %al,0x15(%ebx)
    1380:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1383:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1386:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    138a:	66 89 48 10          	mov    %cx,0x10(%eax)
    138e:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    1392:	88 50 12             	mov    %dl,0x12(%eax)
    1395:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1398:	8b 55 f4             	mov    -0xc(%ebp),%edx
    139b:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    139f:	66 89 48 08          	mov    %cx,0x8(%eax)
    13a3:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    13a7:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    13aa:	8b 45 08             	mov    0x8(%ebp),%eax
    13ad:	89 c2                	mov    %eax,%edx
    13af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13b2:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    13b4:	8b 45 0c             	mov    0xc(%ebp),%eax
    13b7:	89 c2                	mov    %eax,%edx
    13b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13bc:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    13bf:	8b 55 10             	mov    0x10(%ebp),%edx
    13c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13c5:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    13c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    13cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13ce:	c9                   	leave  
    13cf:	c3                   	ret    

000013d0 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    13d0:	55                   	push   %ebp
    13d1:	89 e5                	mov    %esp,%ebp
    13d3:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    13d6:	8b 45 0c             	mov    0xc(%ebp),%eax
    13d9:	8b 50 08             	mov    0x8(%eax),%edx
    13dc:	89 55 f8             	mov    %edx,-0x8(%ebp)
    13df:	8b 40 0c             	mov    0xc(%eax),%eax
    13e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    13e5:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e8:	8b 55 10             	mov    0x10(%ebp),%edx
    13eb:	89 50 08             	mov    %edx,0x8(%eax)
    13ee:	8b 55 14             	mov    0x14(%ebp),%edx
    13f1:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    13f4:	8b 45 08             	mov    0x8(%ebp),%eax
    13f7:	8b 55 f8             	mov    -0x8(%ebp),%edx
    13fa:	89 10                	mov    %edx,(%eax)
    13fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
    13ff:	89 50 04             	mov    %edx,0x4(%eax)
}
    1402:	8b 45 08             	mov    0x8(%ebp),%eax
    1405:	c9                   	leave  
    1406:	c2 04 00             	ret    $0x4

00001409 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    1409:	55                   	push   %ebp
    140a:	89 e5                	mov    %esp,%ebp
    140c:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    140f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1412:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    1416:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    141a:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    141e:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    1421:	8b 45 0c             	mov    0xc(%ebp),%eax
    1424:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1428:	66 89 50 10          	mov    %dx,0x10(%eax)
    142c:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1430:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    1433:	8b 45 08             	mov    0x8(%ebp),%eax
    1436:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    143a:	66 89 10             	mov    %dx,(%eax)
    143d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1441:	88 50 02             	mov    %dl,0x2(%eax)
}
    1444:	8b 45 08             	mov    0x8(%ebp),%eax
    1447:	c9                   	leave  
    1448:	c2 04 00             	ret    $0x4

0000144b <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
    144b:	55                   	push   %ebp
    144c:	89 e5                	mov    %esp,%ebp
    144e:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
    1451:	8b 45 0c             	mov    0xc(%ebp),%eax
    1454:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1458:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    145c:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1460:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
    1463:	8b 45 0c             	mov    0xc(%ebp),%eax
    1466:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    146a:	66 89 50 13          	mov    %dx,0x13(%eax)
    146e:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1472:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
    1475:	8b 45 08             	mov    0x8(%ebp),%eax
    1478:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    147c:	66 89 10             	mov    %dx,(%eax)
    147f:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1483:	88 50 02             	mov    %dl,0x2(%eax)
}
    1486:	8b 45 08             	mov    0x8(%ebp),%eax
    1489:	c9                   	leave  
    148a:	c2 04 00             	ret    $0x4

0000148d <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    148d:	55                   	push   %ebp
    148e:	89 e5                	mov    %esp,%ebp
    1490:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    1493:	8b 45 08             	mov    0x8(%ebp),%eax
    1496:	8b 40 0c             	mov    0xc(%eax),%eax
    1499:	89 c2                	mov    %eax,%edx
    149b:	c1 ea 1f             	shr    $0x1f,%edx
    149e:	01 d0                	add    %edx,%eax
    14a0:	d1 f8                	sar    %eax
    14a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    14a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a8:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    14ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    14af:	8b 45 10             	mov    0x10(%ebp),%eax
    14b2:	2b 45 f4             	sub    -0xc(%ebp),%eax
    14b5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    14b8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    14bc:	0f 89 98 00 00 00    	jns    155a <APDrawPoint+0xcd>
        i = 0;
    14c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    14c9:	e9 8c 00 00 00       	jmp    155a <APDrawPoint+0xcd>
    {
        j = x - off;
    14ce:	8b 45 0c             	mov    0xc(%ebp),%eax
    14d1:	2b 45 f4             	sub    -0xc(%ebp),%eax
    14d4:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    14d7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    14db:	79 69                	jns    1546 <APDrawPoint+0xb9>
            j = 0;
    14dd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    14e4:	eb 60                	jmp    1546 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    14e6:	ff 75 fc             	pushl  -0x4(%ebp)
    14e9:	ff 75 f8             	pushl  -0x8(%ebp)
    14ec:	ff 75 08             	pushl  0x8(%ebp)
    14ef:	e8 bb fb ff ff       	call   10af <APGetIndex>
    14f4:	83 c4 0c             	add    $0xc,%esp
    14f7:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    14fa:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    14fe:	74 55                	je     1555 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    1500:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    1504:	74 67                	je     156d <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    1506:	ff 75 10             	pushl  0x10(%ebp)
    1509:	ff 75 0c             	pushl  0xc(%ebp)
    150c:	ff 75 fc             	pushl  -0x4(%ebp)
    150f:	ff 75 f8             	pushl  -0x8(%ebp)
    1512:	e8 5f fb ff ff       	call   1076 <distance_2>
    1517:	83 c4 10             	add    $0x10,%esp
    151a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    151d:	7f 23                	jg     1542 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    151f:	8b 45 08             	mov    0x8(%ebp),%eax
    1522:	8b 48 18             	mov    0x18(%eax),%ecx
    1525:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1528:	89 d0                	mov    %edx,%eax
    152a:	01 c0                	add    %eax,%eax
    152c:	01 d0                	add    %edx,%eax
    152e:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1531:	8b 45 08             	mov    0x8(%ebp),%eax
    1534:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1538:	66 89 0a             	mov    %cx,(%edx)
    153b:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    153f:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1542:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1546:	8b 55 0c             	mov    0xc(%ebp),%edx
    1549:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154c:	01 d0                	add    %edx,%eax
    154e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1551:	7d 93                	jge    14e6 <APDrawPoint+0x59>
    1553:	eb 01                	jmp    1556 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1555:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1556:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    155a:	8b 55 10             	mov    0x10(%ebp),%edx
    155d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1560:	01 d0                	add    %edx,%eax
    1562:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1565:	0f 8d 63 ff ff ff    	jge    14ce <APDrawPoint+0x41>
    156b:	eb 01                	jmp    156e <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    156d:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    156e:	c9                   	leave  
    156f:	c3                   	ret    

00001570 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1570:	55                   	push   %ebp
    1571:	89 e5                	mov    %esp,%ebp
    1573:	53                   	push   %ebx
    1574:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1577:	8b 45 0c             	mov    0xc(%ebp),%eax
    157a:	3b 45 14             	cmp    0x14(%ebp),%eax
    157d:	0f 85 80 00 00 00    	jne    1603 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1583:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1587:	0f 88 9d 02 00 00    	js     182a <APDrawLine+0x2ba>
    158d:	8b 45 08             	mov    0x8(%ebp),%eax
    1590:	8b 00                	mov    (%eax),%eax
    1592:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1595:	0f 8e 8f 02 00 00    	jle    182a <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    159b:	8b 45 10             	mov    0x10(%ebp),%eax
    159e:	3b 45 18             	cmp    0x18(%ebp),%eax
    15a1:	7e 12                	jle    15b5 <APDrawLine+0x45>
        {
            int tmp = y2;
    15a3:	8b 45 18             	mov    0x18(%ebp),%eax
    15a6:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    15a9:	8b 45 10             	mov    0x10(%ebp),%eax
    15ac:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    15af:	8b 45 dc             	mov    -0x24(%ebp),%eax
    15b2:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    15b5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    15b9:	79 07                	jns    15c2 <APDrawLine+0x52>
    15bb:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    15c2:	8b 45 08             	mov    0x8(%ebp),%eax
    15c5:	8b 40 04             	mov    0x4(%eax),%eax
    15c8:	3b 45 18             	cmp    0x18(%ebp),%eax
    15cb:	7d 0c                	jge    15d9 <APDrawLine+0x69>
    15cd:	8b 45 08             	mov    0x8(%ebp),%eax
    15d0:	8b 40 04             	mov    0x4(%eax),%eax
    15d3:	83 e8 01             	sub    $0x1,%eax
    15d6:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    15d9:	8b 45 10             	mov    0x10(%ebp),%eax
    15dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    15df:	eb 15                	jmp    15f6 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    15e1:	ff 75 f4             	pushl  -0xc(%ebp)
    15e4:	ff 75 0c             	pushl  0xc(%ebp)
    15e7:	ff 75 08             	pushl  0x8(%ebp)
    15ea:	e8 9e fe ff ff       	call   148d <APDrawPoint>
    15ef:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    15f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    15f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f9:	3b 45 18             	cmp    0x18(%ebp),%eax
    15fc:	7e e3                	jle    15e1 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    15fe:	e9 2b 02 00 00       	jmp    182e <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1603:	8b 45 10             	mov    0x10(%ebp),%eax
    1606:	3b 45 18             	cmp    0x18(%ebp),%eax
    1609:	75 7f                	jne    168a <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    160b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    160f:	0f 88 18 02 00 00    	js     182d <APDrawLine+0x2bd>
    1615:	8b 45 08             	mov    0x8(%ebp),%eax
    1618:	8b 40 04             	mov    0x4(%eax),%eax
    161b:	3b 45 10             	cmp    0x10(%ebp),%eax
    161e:	0f 8e 09 02 00 00    	jle    182d <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1624:	8b 45 0c             	mov    0xc(%ebp),%eax
    1627:	3b 45 14             	cmp    0x14(%ebp),%eax
    162a:	7e 12                	jle    163e <APDrawLine+0xce>
        {
            int tmp = x2;
    162c:	8b 45 14             	mov    0x14(%ebp),%eax
    162f:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1632:	8b 45 0c             	mov    0xc(%ebp),%eax
    1635:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1638:	8b 45 d8             	mov    -0x28(%ebp),%eax
    163b:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    163e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1642:	79 07                	jns    164b <APDrawLine+0xdb>
    1644:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    164b:	8b 45 08             	mov    0x8(%ebp),%eax
    164e:	8b 00                	mov    (%eax),%eax
    1650:	3b 45 14             	cmp    0x14(%ebp),%eax
    1653:	7d 0b                	jge    1660 <APDrawLine+0xf0>
    1655:	8b 45 08             	mov    0x8(%ebp),%eax
    1658:	8b 00                	mov    (%eax),%eax
    165a:	83 e8 01             	sub    $0x1,%eax
    165d:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1660:	8b 45 0c             	mov    0xc(%ebp),%eax
    1663:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1666:	eb 15                	jmp    167d <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1668:	ff 75 10             	pushl  0x10(%ebp)
    166b:	ff 75 f0             	pushl  -0x10(%ebp)
    166e:	ff 75 08             	pushl  0x8(%ebp)
    1671:	e8 17 fe ff ff       	call   148d <APDrawPoint>
    1676:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1679:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    167d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1680:	3b 45 14             	cmp    0x14(%ebp),%eax
    1683:	7e e3                	jle    1668 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1685:	e9 a4 01 00 00       	jmp    182e <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    168a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1691:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1698:	8b 45 0c             	mov    0xc(%ebp),%eax
    169b:	2b 45 14             	sub    0x14(%ebp),%eax
    169e:	50                   	push   %eax
    169f:	e8 fb f9 ff ff       	call   109f <abs_int>
    16a4:	83 c4 04             	add    $0x4,%esp
    16a7:	89 c3                	mov    %eax,%ebx
    16a9:	8b 45 10             	mov    0x10(%ebp),%eax
    16ac:	2b 45 18             	sub    0x18(%ebp),%eax
    16af:	50                   	push   %eax
    16b0:	e8 ea f9 ff ff       	call   109f <abs_int>
    16b5:	83 c4 04             	add    $0x4,%esp
    16b8:	39 c3                	cmp    %eax,%ebx
    16ba:	0f 8e b5 00 00 00    	jle    1775 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    16c0:	8b 45 10             	mov    0x10(%ebp),%eax
    16c3:	2b 45 18             	sub    0x18(%ebp),%eax
    16c6:	89 45 b0             	mov    %eax,-0x50(%ebp)
    16c9:	db 45 b0             	fildl  -0x50(%ebp)
    16cc:	8b 45 0c             	mov    0xc(%ebp),%eax
    16cf:	2b 45 14             	sub    0x14(%ebp),%eax
    16d2:	89 45 b0             	mov    %eax,-0x50(%ebp)
    16d5:	db 45 b0             	fildl  -0x50(%ebp)
    16d8:	de f9                	fdivrp %st,%st(1)
    16da:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    16dd:	8b 45 14             	mov    0x14(%ebp),%eax
    16e0:	3b 45 0c             	cmp    0xc(%ebp),%eax
    16e3:	7e 0e                	jle    16f3 <APDrawLine+0x183>
        {
            s = x1;
    16e5:	8b 45 0c             	mov    0xc(%ebp),%eax
    16e8:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    16eb:	8b 45 14             	mov    0x14(%ebp),%eax
    16ee:	89 45 e8             	mov    %eax,-0x18(%ebp)
    16f1:	eb 0c                	jmp    16ff <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    16f3:	8b 45 14             	mov    0x14(%ebp),%eax
    16f6:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    16f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    16fc:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    16ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1703:	79 07                	jns    170c <APDrawLine+0x19c>
    1705:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    170c:	8b 45 08             	mov    0x8(%ebp),%eax
    170f:	8b 00                	mov    (%eax),%eax
    1711:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1714:	7f 0b                	jg     1721 <APDrawLine+0x1b1>
    1716:	8b 45 08             	mov    0x8(%ebp),%eax
    1719:	8b 00                	mov    (%eax),%eax
    171b:	83 e8 01             	sub    $0x1,%eax
    171e:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1721:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1724:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1727:	eb 3f                	jmp    1768 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1729:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    172c:	2b 45 0c             	sub    0xc(%ebp),%eax
    172f:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1732:	db 45 b0             	fildl  -0x50(%ebp)
    1735:	dc 4d d0             	fmull  -0x30(%ebp)
    1738:	db 45 10             	fildl  0x10(%ebp)
    173b:	de c1                	faddp  %st,%st(1)
    173d:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1740:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1744:	b4 0c                	mov    $0xc,%ah
    1746:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    174a:	d9 6d b4             	fldcw  -0x4c(%ebp)
    174d:	db 5d cc             	fistpl -0x34(%ebp)
    1750:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1753:	ff 75 cc             	pushl  -0x34(%ebp)
    1756:	ff 75 e4             	pushl  -0x1c(%ebp)
    1759:	ff 75 08             	pushl  0x8(%ebp)
    175c:	e8 2c fd ff ff       	call   148d <APDrawPoint>
    1761:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1764:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1768:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    176b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    176e:	7e b9                	jle    1729 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1770:	e9 b9 00 00 00       	jmp    182e <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1775:	8b 45 0c             	mov    0xc(%ebp),%eax
    1778:	2b 45 14             	sub    0x14(%ebp),%eax
    177b:	89 45 b0             	mov    %eax,-0x50(%ebp)
    177e:	db 45 b0             	fildl  -0x50(%ebp)
    1781:	8b 45 10             	mov    0x10(%ebp),%eax
    1784:	2b 45 18             	sub    0x18(%ebp),%eax
    1787:	89 45 b0             	mov    %eax,-0x50(%ebp)
    178a:	db 45 b0             	fildl  -0x50(%ebp)
    178d:	de f9                	fdivrp %st,%st(1)
    178f:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1792:	8b 45 10             	mov    0x10(%ebp),%eax
    1795:	3b 45 18             	cmp    0x18(%ebp),%eax
    1798:	7e 0e                	jle    17a8 <APDrawLine+0x238>
    {
        s = y2;
    179a:	8b 45 18             	mov    0x18(%ebp),%eax
    179d:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    17a0:	8b 45 10             	mov    0x10(%ebp),%eax
    17a3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    17a6:	eb 0c                	jmp    17b4 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    17a8:	8b 45 10             	mov    0x10(%ebp),%eax
    17ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    17ae:	8b 45 18             	mov    0x18(%ebp),%eax
    17b1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    17b4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17b8:	79 07                	jns    17c1 <APDrawLine+0x251>
    17ba:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    17c1:	8b 45 08             	mov    0x8(%ebp),%eax
    17c4:	8b 40 04             	mov    0x4(%eax),%eax
    17c7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    17ca:	7f 0c                	jg     17d8 <APDrawLine+0x268>
    17cc:	8b 45 08             	mov    0x8(%ebp),%eax
    17cf:	8b 40 04             	mov    0x4(%eax),%eax
    17d2:	83 e8 01             	sub    $0x1,%eax
    17d5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    17d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17db:	89 45 e0             	mov    %eax,-0x20(%ebp)
    17de:	eb 3f                	jmp    181f <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    17e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    17e3:	2b 45 10             	sub    0x10(%ebp),%eax
    17e6:	89 45 b0             	mov    %eax,-0x50(%ebp)
    17e9:	db 45 b0             	fildl  -0x50(%ebp)
    17ec:	dc 4d c0             	fmull  -0x40(%ebp)
    17ef:	db 45 0c             	fildl  0xc(%ebp)
    17f2:	de c1                	faddp  %st,%st(1)
    17f4:	d9 7d b6             	fnstcw -0x4a(%ebp)
    17f7:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    17fb:	b4 0c                	mov    $0xc,%ah
    17fd:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1801:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1804:	db 5d bc             	fistpl -0x44(%ebp)
    1807:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    180a:	ff 75 e0             	pushl  -0x20(%ebp)
    180d:	ff 75 bc             	pushl  -0x44(%ebp)
    1810:	ff 75 08             	pushl  0x8(%ebp)
    1813:	e8 75 fc ff ff       	call   148d <APDrawPoint>
    1818:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    181b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    181f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1822:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1825:	7e b9                	jle    17e0 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1827:	90                   	nop
    1828:	eb 04                	jmp    182e <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    182a:	90                   	nop
    182b:	eb 01                	jmp    182e <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    182d:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    182e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1831:	c9                   	leave  
    1832:	c3                   	ret    

00001833 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1833:	55                   	push   %ebp
    1834:	89 e5                	mov    %esp,%ebp
    1836:	53                   	push   %ebx
    1837:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    183a:	8b 55 10             	mov    0x10(%ebp),%edx
    183d:	8b 45 18             	mov    0x18(%ebp),%eax
    1840:	01 d0                	add    %edx,%eax
    1842:	83 e8 01             	sub    $0x1,%eax
    1845:	83 ec 04             	sub    $0x4,%esp
    1848:	50                   	push   %eax
    1849:	ff 75 0c             	pushl  0xc(%ebp)
    184c:	ff 75 10             	pushl  0x10(%ebp)
    184f:	ff 75 0c             	pushl  0xc(%ebp)
    1852:	ff 75 08             	pushl  0x8(%ebp)
    1855:	e8 16 fd ff ff       	call   1570 <APDrawLine>
    185a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    185d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1860:	8b 45 14             	mov    0x14(%ebp),%eax
    1863:	01 d0                	add    %edx,%eax
    1865:	83 e8 01             	sub    $0x1,%eax
    1868:	83 ec 04             	sub    $0x4,%esp
    186b:	ff 75 10             	pushl  0x10(%ebp)
    186e:	50                   	push   %eax
    186f:	ff 75 10             	pushl  0x10(%ebp)
    1872:	ff 75 0c             	pushl  0xc(%ebp)
    1875:	ff 75 08             	pushl  0x8(%ebp)
    1878:	e8 f3 fc ff ff       	call   1570 <APDrawLine>
    187d:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1880:	8b 55 10             	mov    0x10(%ebp),%edx
    1883:	8b 45 18             	mov    0x18(%ebp),%eax
    1886:	01 d0                	add    %edx,%eax
    1888:	8d 48 ff             	lea    -0x1(%eax),%ecx
    188b:	8b 55 0c             	mov    0xc(%ebp),%edx
    188e:	8b 45 14             	mov    0x14(%ebp),%eax
    1891:	01 d0                	add    %edx,%eax
    1893:	8d 50 ff             	lea    -0x1(%eax),%edx
    1896:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1899:	8b 45 14             	mov    0x14(%ebp),%eax
    189c:	01 d8                	add    %ebx,%eax
    189e:	83 e8 01             	sub    $0x1,%eax
    18a1:	83 ec 04             	sub    $0x4,%esp
    18a4:	51                   	push   %ecx
    18a5:	52                   	push   %edx
    18a6:	ff 75 10             	pushl  0x10(%ebp)
    18a9:	50                   	push   %eax
    18aa:	ff 75 08             	pushl  0x8(%ebp)
    18ad:	e8 be fc ff ff       	call   1570 <APDrawLine>
    18b2:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    18b5:	8b 55 10             	mov    0x10(%ebp),%edx
    18b8:	8b 45 18             	mov    0x18(%ebp),%eax
    18bb:	01 d0                	add    %edx,%eax
    18bd:	8d 48 ff             	lea    -0x1(%eax),%ecx
    18c0:	8b 55 0c             	mov    0xc(%ebp),%edx
    18c3:	8b 45 14             	mov    0x14(%ebp),%eax
    18c6:	01 d0                	add    %edx,%eax
    18c8:	8d 50 ff             	lea    -0x1(%eax),%edx
    18cb:	8b 5d 10             	mov    0x10(%ebp),%ebx
    18ce:	8b 45 18             	mov    0x18(%ebp),%eax
    18d1:	01 d8                	add    %ebx,%eax
    18d3:	83 e8 01             	sub    $0x1,%eax
    18d6:	83 ec 04             	sub    $0x4,%esp
    18d9:	51                   	push   %ecx
    18da:	52                   	push   %edx
    18db:	50                   	push   %eax
    18dc:	ff 75 0c             	pushl  0xc(%ebp)
    18df:	ff 75 08             	pushl  0x8(%ebp)
    18e2:	e8 89 fc ff ff       	call   1570 <APDrawLine>
    18e7:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    18ea:	8b 55 0c             	mov    0xc(%ebp),%edx
    18ed:	8b 45 14             	mov    0x14(%ebp),%eax
    18f0:	01 d0                	add    %edx,%eax
    18f2:	8d 50 ff             	lea    -0x1(%eax),%edx
    18f5:	8b 45 08             	mov    0x8(%ebp),%eax
    18f8:	8b 40 0c             	mov    0xc(%eax),%eax
    18fb:	89 c1                	mov    %eax,%ecx
    18fd:	c1 e9 1f             	shr    $0x1f,%ecx
    1900:	01 c8                	add    %ecx,%eax
    1902:	d1 f8                	sar    %eax
    1904:	29 c2                	sub    %eax,%edx
    1906:	89 d0                	mov    %edx,%eax
    1908:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    190b:	8b 55 10             	mov    0x10(%ebp),%edx
    190e:	8b 45 18             	mov    0x18(%ebp),%eax
    1911:	01 d0                	add    %edx,%eax
    1913:	8d 50 ff             	lea    -0x1(%eax),%edx
    1916:	8b 45 08             	mov    0x8(%ebp),%eax
    1919:	8b 40 0c             	mov    0xc(%eax),%eax
    191c:	89 c1                	mov    %eax,%ecx
    191e:	c1 e9 1f             	shr    $0x1f,%ecx
    1921:	01 c8                	add    %ecx,%eax
    1923:	d1 f8                	sar    %eax
    1925:	29 c2                	sub    %eax,%edx
    1927:	89 d0                	mov    %edx,%eax
    1929:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    192c:	8b 45 08             	mov    0x8(%ebp),%eax
    192f:	8b 40 0c             	mov    0xc(%eax),%eax
    1932:	89 c2                	mov    %eax,%edx
    1934:	c1 ea 1f             	shr    $0x1f,%edx
    1937:	01 d0                	add    %edx,%eax
    1939:	d1 f8                	sar    %eax
    193b:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    193e:	8b 45 08             	mov    0x8(%ebp),%eax
    1941:	8b 40 0c             	mov    0xc(%eax),%eax
    1944:	89 c2                	mov    %eax,%edx
    1946:	c1 ea 1f             	shr    $0x1f,%edx
    1949:	01 d0                	add    %edx,%eax
    194b:	d1 f8                	sar    %eax
    194d:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1950:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1954:	0f 88 d8 00 00 00    	js     1a32 <APDrawRect+0x1ff>
    195a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    195e:	0f 88 ce 00 00 00    	js     1a32 <APDrawRect+0x1ff>
    1964:	8b 45 08             	mov    0x8(%ebp),%eax
    1967:	8b 00                	mov    (%eax),%eax
    1969:	3b 45 0c             	cmp    0xc(%ebp),%eax
    196c:	0f 8e c0 00 00 00    	jle    1a32 <APDrawRect+0x1ff>
    1972:	8b 45 08             	mov    0x8(%ebp),%eax
    1975:	8b 40 04             	mov    0x4(%eax),%eax
    1978:	3b 45 10             	cmp    0x10(%ebp),%eax
    197b:	0f 8e b1 00 00 00    	jle    1a32 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1981:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1985:	79 07                	jns    198e <APDrawRect+0x15b>
    1987:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    198e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1992:	79 07                	jns    199b <APDrawRect+0x168>
    1994:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    199b:	8b 45 08             	mov    0x8(%ebp),%eax
    199e:	8b 00                	mov    (%eax),%eax
    19a0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    19a3:	7f 0b                	jg     19b0 <APDrawRect+0x17d>
    19a5:	8b 45 08             	mov    0x8(%ebp),%eax
    19a8:	8b 00                	mov    (%eax),%eax
    19aa:	83 e8 01             	sub    $0x1,%eax
    19ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    19b0:	8b 45 08             	mov    0x8(%ebp),%eax
    19b3:	8b 40 04             	mov    0x4(%eax),%eax
    19b6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    19b9:	7f 0c                	jg     19c7 <APDrawRect+0x194>
    19bb:	8b 45 08             	mov    0x8(%ebp),%eax
    19be:	8b 40 04             	mov    0x4(%eax),%eax
    19c1:	83 e8 01             	sub    $0x1,%eax
    19c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    19c7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    19ce:	8b 45 0c             	mov    0xc(%ebp),%eax
    19d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    19d4:	eb 52                	jmp    1a28 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    19d6:	8b 45 10             	mov    0x10(%ebp),%eax
    19d9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    19dc:	eb 3e                	jmp    1a1c <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    19de:	83 ec 04             	sub    $0x4,%esp
    19e1:	ff 75 e8             	pushl  -0x18(%ebp)
    19e4:	ff 75 ec             	pushl  -0x14(%ebp)
    19e7:	ff 75 08             	pushl  0x8(%ebp)
    19ea:	e8 c0 f6 ff ff       	call   10af <APGetIndex>
    19ef:	83 c4 10             	add    $0x10,%esp
    19f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    19f5:	8b 45 08             	mov    0x8(%ebp),%eax
    19f8:	8b 48 18             	mov    0x18(%eax),%ecx
    19fb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    19fe:	89 d0                	mov    %edx,%eax
    1a00:	01 c0                	add    %eax,%eax
    1a02:	01 d0                	add    %edx,%eax
    1a04:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1a07:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0a:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1a0e:	66 89 0a             	mov    %cx,(%edx)
    1a11:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1a15:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1a18:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1a1c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a1f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1a22:	7e ba                	jle    19de <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1a24:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1a28:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a2b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1a2e:	7e a6                	jle    19d6 <APDrawRect+0x1a3>
    1a30:	eb 01                	jmp    1a33 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1a32:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1a33:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1a36:	c9                   	leave  
    1a37:	c3                   	ret    

00001a38 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1a38:	55                   	push   %ebp
    1a39:	89 e5                	mov    %esp,%ebp
    1a3b:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    1a3e:	83 ec 0c             	sub    $0xc,%esp
    1a41:	ff 75 0c             	pushl  0xc(%ebp)
    1a44:	e8 c1 ee ff ff       	call   90a <strlen>
    1a49:	83 c4 10             	add    $0x10,%esp
    1a4c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1a4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a52:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1a56:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1a5a:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1a5e:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1a61:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1a68:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1a6f:	e9 bc 00 00 00       	jmp    1b30 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1a74:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a77:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a7a:	01 d0                	add    %edx,%eax
    1a7c:	0f b6 00             	movzbl (%eax),%eax
    1a7f:	0f be c0             	movsbl %al,%eax
    1a82:	83 e8 20             	sub    $0x20,%eax
    1a85:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1a88:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1a8c:	0f 87 9a 00 00 00    	ja     1b2c <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1a92:	8b 45 08             	mov    0x8(%ebp),%eax
    1a95:	8b 00                	mov    (%eax),%eax
    1a97:	0f af 45 14          	imul   0x14(%ebp),%eax
    1a9b:	89 c2                	mov    %eax,%edx
    1a9d:	8b 45 10             	mov    0x10(%ebp),%eax
    1aa0:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1aa3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1aa6:	89 d0                	mov    %edx,%eax
    1aa8:	c1 e0 03             	shl    $0x3,%eax
    1aab:	01 d0                	add    %edx,%eax
    1aad:	01 c8                	add    %ecx,%eax
    1aaf:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1ab2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1ab9:	eb 6b                	jmp    1b26 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1abb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1ac2:	eb 50                	jmp    1b14 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    1ac4:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1ac7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1aca:	89 d0                	mov    %edx,%eax
    1acc:	c1 e0 03             	shl    $0x3,%eax
    1acf:	01 d0                	add    %edx,%eax
    1ad1:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    1ad7:	01 c2                	add    %eax,%edx
    1ad9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1adc:	01 d0                	add    %edx,%eax
    1ade:	05 80 34 00 00       	add    $0x3480,%eax
    1ae3:	0f b6 00             	movzbl (%eax),%eax
    1ae6:	84 c0                	test   %al,%al
    1ae8:	74 26                	je     1b10 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1aea:	8b 45 08             	mov    0x8(%ebp),%eax
    1aed:	8b 50 18             	mov    0x18(%eax),%edx
    1af0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1af3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1af6:	01 c8                	add    %ecx,%eax
    1af8:	89 c1                	mov    %eax,%ecx
    1afa:	89 c8                	mov    %ecx,%eax
    1afc:	01 c0                	add    %eax,%eax
    1afe:	01 c8                	add    %ecx,%eax
    1b00:	01 d0                	add    %edx,%eax
    1b02:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1b06:	66 89 10             	mov    %dx,(%eax)
    1b09:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1b0d:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1b10:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1b14:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1b18:	7e aa                	jle    1ac4 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1b1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1d:	8b 00                	mov    (%eax),%eax
    1b1f:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1b22:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1b26:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1b2a:	7e 8f                	jle    1abb <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1b2c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b30:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b33:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1b36:	0f 82 38 ff ff ff    	jb     1a74 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1b3c:	90                   	nop
    1b3d:	c9                   	leave  
    1b3e:	c3                   	ret    

00001b3f <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1b3f:	55                   	push   %ebp
    1b40:	89 e5                	mov    %esp,%ebp
    1b42:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1b45:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1b49:	0f 88 8e 01 00 00    	js     1cdd <APDcCopy+0x19e>
    1b4f:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1b53:	0f 88 84 01 00 00    	js     1cdd <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1b59:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b5c:	8b 45 20             	mov    0x20(%ebp),%eax
    1b5f:	01 d0                	add    %edx,%eax
    1b61:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1b64:	8b 55 10             	mov    0x10(%ebp),%edx
    1b67:	8b 45 24             	mov    0x24(%ebp),%eax
    1b6a:	01 d0                	add    %edx,%eax
    1b6c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1b6f:	8b 55 18             	mov    0x18(%ebp),%edx
    1b72:	8b 45 20             	mov    0x20(%ebp),%eax
    1b75:	01 d0                	add    %edx,%eax
    1b77:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b7a:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1b7d:	8b 45 24             	mov    0x24(%ebp),%eax
    1b80:	01 d0                	add    %edx,%eax
    1b82:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1b85:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1b89:	0f 88 51 01 00 00    	js     1ce0 <APDcCopy+0x1a1>
    1b8f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1b93:	0f 88 47 01 00 00    	js     1ce0 <APDcCopy+0x1a1>
    1b99:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1b9d:	0f 88 3d 01 00 00    	js     1ce0 <APDcCopy+0x1a1>
    1ba3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1ba7:	0f 88 33 01 00 00    	js     1ce0 <APDcCopy+0x1a1>
    1bad:	8b 45 14             	mov    0x14(%ebp),%eax
    1bb0:	8b 00                	mov    (%eax),%eax
    1bb2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1bb5:	0f 8c 25 01 00 00    	jl     1ce0 <APDcCopy+0x1a1>
    1bbb:	8b 45 14             	mov    0x14(%ebp),%eax
    1bbe:	8b 40 04             	mov    0x4(%eax),%eax
    1bc1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1bc4:	0f 8c 16 01 00 00    	jl     1ce0 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1bca:	8b 45 08             	mov    0x8(%ebp),%eax
    1bcd:	8b 00                	mov    (%eax),%eax
    1bcf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1bd2:	7f 0b                	jg     1bdf <APDcCopy+0xa0>
    1bd4:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd7:	8b 00                	mov    (%eax),%eax
    1bd9:	83 e8 01             	sub    $0x1,%eax
    1bdc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1bdf:	8b 45 08             	mov    0x8(%ebp),%eax
    1be2:	8b 40 04             	mov    0x4(%eax),%eax
    1be5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1be8:	7f 0c                	jg     1bf6 <APDcCopy+0xb7>
    1bea:	8b 45 08             	mov    0x8(%ebp),%eax
    1bed:	8b 40 04             	mov    0x4(%eax),%eax
    1bf0:	83 e8 01             	sub    $0x1,%eax
    1bf3:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1bf6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1bfd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1c04:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c0b:	e9 bc 00 00 00       	jmp    1ccc <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1c10:	8b 45 08             	mov    0x8(%ebp),%eax
    1c13:	8b 00                	mov    (%eax),%eax
    1c15:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1c18:	8b 55 10             	mov    0x10(%ebp),%edx
    1c1b:	01 ca                	add    %ecx,%edx
    1c1d:	0f af d0             	imul   %eax,%edx
    1c20:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c23:	01 d0                	add    %edx,%eax
    1c25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1c28:	8b 45 14             	mov    0x14(%ebp),%eax
    1c2b:	8b 00                	mov    (%eax),%eax
    1c2d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1c30:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1c33:	01 ca                	add    %ecx,%edx
    1c35:	0f af d0             	imul   %eax,%edx
    1c38:	8b 45 18             	mov    0x18(%ebp),%eax
    1c3b:	01 d0                	add    %edx,%eax
    1c3d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1c40:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1c47:	eb 74                	jmp    1cbd <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1c49:	8b 45 14             	mov    0x14(%ebp),%eax
    1c4c:	8b 50 18             	mov    0x18(%eax),%edx
    1c4f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1c52:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c55:	01 c8                	add    %ecx,%eax
    1c57:	89 c1                	mov    %eax,%ecx
    1c59:	89 c8                	mov    %ecx,%eax
    1c5b:	01 c0                	add    %eax,%eax
    1c5d:	01 c8                	add    %ecx,%eax
    1c5f:	01 d0                	add    %edx,%eax
    1c61:	0f b7 10             	movzwl (%eax),%edx
    1c64:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1c68:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1c6c:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1c6f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1c73:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1c77:	38 c2                	cmp    %al,%dl
    1c79:	75 18                	jne    1c93 <APDcCopy+0x154>
    1c7b:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1c7f:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1c83:	38 c2                	cmp    %al,%dl
    1c85:	75 0c                	jne    1c93 <APDcCopy+0x154>
    1c87:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1c8b:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1c8f:	38 c2                	cmp    %al,%dl
    1c91:	74 26                	je     1cb9 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1c93:	8b 45 08             	mov    0x8(%ebp),%eax
    1c96:	8b 50 18             	mov    0x18(%eax),%edx
    1c99:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1c9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c9f:	01 c8                	add    %ecx,%eax
    1ca1:	89 c1                	mov    %eax,%ecx
    1ca3:	89 c8                	mov    %ecx,%eax
    1ca5:	01 c0                	add    %eax,%eax
    1ca7:	01 c8                	add    %ecx,%eax
    1ca9:	01 d0                	add    %edx,%eax
    1cab:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1caf:	66 89 10             	mov    %dx,(%eax)
    1cb2:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1cb6:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1cb9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1cbd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1cc0:	2b 45 0c             	sub    0xc(%ebp),%eax
    1cc3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1cc6:	7d 81                	jge    1c49 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1cc8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ccc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ccf:	2b 45 10             	sub    0x10(%ebp),%eax
    1cd2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1cd5:	0f 8d 35 ff ff ff    	jge    1c10 <APDcCopy+0xd1>
    1cdb:	eb 04                	jmp    1ce1 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1cdd:	90                   	nop
    1cde:	eb 01                	jmp    1ce1 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1ce0:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1ce1:	c9                   	leave  
    1ce2:	c3                   	ret    

00001ce3 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1ce3:	55                   	push   %ebp
    1ce4:	89 e5                	mov    %esp,%ebp
    1ce6:	83 ec 1c             	sub    $0x1c,%esp
    1ce9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1cec:	8b 55 10             	mov    0x10(%ebp),%edx
    1cef:	8b 45 14             	mov    0x14(%ebp),%eax
    1cf2:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1cf5:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1cf8:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1cfb:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1cff:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1d02:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1d06:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1d09:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1d0d:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1d10:	8b 45 08             	mov    0x8(%ebp),%eax
    1d13:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1d17:	66 89 10             	mov    %dx,(%eax)
    1d1a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1d1e:	88 50 02             	mov    %dl,0x2(%eax)
}
    1d21:	8b 45 08             	mov    0x8(%ebp),%eax
    1d24:	c9                   	leave  
    1d25:	c2 04 00             	ret    $0x4

00001d28 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1d28:	55                   	push   %ebp
    1d29:	89 e5                	mov    %esp,%ebp
    1d2b:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1d2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d31:	8b 00                	mov    (%eax),%eax
    1d33:	83 ec 08             	sub    $0x8,%esp
    1d36:	8d 55 0c             	lea    0xc(%ebp),%edx
    1d39:	52                   	push   %edx
    1d3a:	50                   	push   %eax
    1d3b:	e8 34 ee ff ff       	call   b74 <sendMessage>
    1d40:	83 c4 10             	add    $0x10,%esp
}
    1d43:	90                   	nop
    1d44:	c9                   	leave  
    1d45:	c3                   	ret    

00001d46 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1d46:	55                   	push   %ebp
    1d47:	89 e5                	mov    %esp,%ebp
    1d49:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1d4c:	83 ec 0c             	sub    $0xc,%esp
    1d4f:	68 98 00 00 00       	push   $0x98
    1d54:	e8 f5 f1 ff ff       	call   f4e <malloc>
    1d59:	83 c4 10             	add    $0x10,%esp
    1d5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1d5f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d63:	75 15                	jne    1d7a <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1d65:	83 ec 04             	sub    $0x4,%esp
    1d68:	ff 75 08             	pushl  0x8(%ebp)
    1d6b:	68 34 2c 00 00       	push   $0x2c34
    1d70:	6a 01                	push   $0x1
    1d72:	e8 04 ef ff ff       	call   c7b <printf>
    1d77:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1d7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d7d:	05 84 00 00 00       	add    $0x84,%eax
    1d82:	83 ec 08             	sub    $0x8,%esp
    1d85:	ff 75 08             	pushl  0x8(%ebp)
    1d88:	50                   	push   %eax
    1d89:	e8 0d eb ff ff       	call   89b <strcpy>
    1d8e:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1d91:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d94:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1d9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d9e:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1da5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1da8:	8b 40 3c             	mov    0x3c(%eax),%eax
    1dab:	89 c2                	mov    %eax,%edx
    1dad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1db0:	8b 40 40             	mov    0x40(%eax),%eax
    1db3:	0f af d0             	imul   %eax,%edx
    1db6:	89 d0                	mov    %edx,%eax
    1db8:	01 c0                	add    %eax,%eax
    1dba:	01 d0                	add    %edx,%eax
    1dbc:	83 ec 0c             	sub    $0xc,%esp
    1dbf:	50                   	push   %eax
    1dc0:	e8 89 f1 ff ff       	call   f4e <malloc>
    1dc5:	83 c4 10             	add    $0x10,%esp
    1dc8:	89 c2                	mov    %eax,%edx
    1dca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dcd:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1dd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dd3:	8b 40 54             	mov    0x54(%eax),%eax
    1dd6:	85 c0                	test   %eax,%eax
    1dd8:	75 15                	jne    1def <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1dda:	83 ec 04             	sub    $0x4,%esp
    1ddd:	ff 75 08             	pushl  0x8(%ebp)
    1de0:	68 54 2c 00 00       	push   $0x2c54
    1de5:	6a 01                	push   $0x1
    1de7:	e8 8f ee ff ff       	call   c7b <printf>
    1dec:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1def:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1df2:	8b 40 3c             	mov    0x3c(%eax),%eax
    1df5:	89 c2                	mov    %eax,%edx
    1df7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dfa:	8b 40 40             	mov    0x40(%eax),%eax
    1dfd:	0f af d0             	imul   %eax,%edx
    1e00:	89 d0                	mov    %edx,%eax
    1e02:	01 c0                	add    %eax,%eax
    1e04:	01 c2                	add    %eax,%edx
    1e06:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e09:	8b 40 54             	mov    0x54(%eax),%eax
    1e0c:	83 ec 04             	sub    $0x4,%esp
    1e0f:	52                   	push   %edx
    1e10:	68 ff ff ff 00       	push   $0xffffff
    1e15:	50                   	push   %eax
    1e16:	e8 16 eb ff ff       	call   931 <memset>
    1e1b:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1e1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e21:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1e28:	e8 1f ed ff ff       	call   b4c <getpid>
    1e2d:	89 c2                	mov    %eax,%edx
    1e2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e32:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1e35:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e38:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1e3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e42:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1e49:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e4c:	8b 40 58             	mov    0x58(%eax),%eax
    1e4f:	89 c2                	mov    %eax,%edx
    1e51:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e54:	8b 40 5c             	mov    0x5c(%eax),%eax
    1e57:	0f af d0             	imul   %eax,%edx
    1e5a:	89 d0                	mov    %edx,%eax
    1e5c:	01 c0                	add    %eax,%eax
    1e5e:	01 d0                	add    %edx,%eax
    1e60:	83 ec 0c             	sub    $0xc,%esp
    1e63:	50                   	push   %eax
    1e64:	e8 e5 f0 ff ff       	call   f4e <malloc>
    1e69:	83 c4 10             	add    $0x10,%esp
    1e6c:	89 c2                	mov    %eax,%edx
    1e6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e71:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1e74:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e77:	8b 40 70             	mov    0x70(%eax),%eax
    1e7a:	85 c0                	test   %eax,%eax
    1e7c:	75 15                	jne    1e93 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1e7e:	83 ec 04             	sub    $0x4,%esp
    1e81:	ff 75 08             	pushl  0x8(%ebp)
    1e84:	68 78 2c 00 00       	push   $0x2c78
    1e89:	6a 01                	push   $0x1
    1e8b:	e8 eb ed ff ff       	call   c7b <printf>
    1e90:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1e93:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e96:	8b 40 3c             	mov    0x3c(%eax),%eax
    1e99:	89 c2                	mov    %eax,%edx
    1e9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e9e:	8b 40 40             	mov    0x40(%eax),%eax
    1ea1:	0f af d0             	imul   %eax,%edx
    1ea4:	89 d0                	mov    %edx,%eax
    1ea6:	01 c0                	add    %eax,%eax
    1ea8:	01 c2                	add    %eax,%edx
    1eaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ead:	8b 40 54             	mov    0x54(%eax),%eax
    1eb0:	83 ec 04             	sub    $0x4,%esp
    1eb3:	52                   	push   %edx
    1eb4:	68 ff 00 00 00       	push   $0xff
    1eb9:	50                   	push   %eax
    1eba:	e8 72 ea ff ff       	call   931 <memset>
    1ebf:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1ec2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ec5:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ec8:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1ecb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1ecf:	74 49                	je     1f1a <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1ed1:	8b 45 10             	mov    0x10(%ebp),%eax
    1ed4:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1eda:	83 ec 0c             	sub    $0xc,%esp
    1edd:	50                   	push   %eax
    1ede:	e8 6b f0 ff ff       	call   f4e <malloc>
    1ee3:	83 c4 10             	add    $0x10,%esp
    1ee6:	89 c2                	mov    %eax,%edx
    1ee8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1eeb:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1eee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ef1:	8b 55 10             	mov    0x10(%ebp),%edx
    1ef4:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1ef7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1efa:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1f01:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f04:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1f0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f0e:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1f15:	e9 8d 00 00 00       	jmp    1fa7 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1f1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f1d:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1f24:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f27:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1f2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f31:	8b 40 20             	mov    0x20(%eax),%eax
    1f34:	89 c2                	mov    %eax,%edx
    1f36:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f39:	8b 40 24             	mov    0x24(%eax),%eax
    1f3c:	0f af d0             	imul   %eax,%edx
    1f3f:	89 d0                	mov    %edx,%eax
    1f41:	01 c0                	add    %eax,%eax
    1f43:	01 d0                	add    %edx,%eax
    1f45:	83 ec 0c             	sub    $0xc,%esp
    1f48:	50                   	push   %eax
    1f49:	e8 00 f0 ff ff       	call   f4e <malloc>
    1f4e:	83 c4 10             	add    $0x10,%esp
    1f51:	89 c2                	mov    %eax,%edx
    1f53:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f56:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1f59:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f5c:	8b 40 38             	mov    0x38(%eax),%eax
    1f5f:	85 c0                	test   %eax,%eax
    1f61:	75 15                	jne    1f78 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1f63:	83 ec 04             	sub    $0x4,%esp
    1f66:	ff 75 08             	pushl  0x8(%ebp)
    1f69:	68 a0 2c 00 00       	push   $0x2ca0
    1f6e:	6a 01                	push   $0x1
    1f70:	e8 06 ed ff ff       	call   c7b <printf>
    1f75:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1f78:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f7b:	8b 40 20             	mov    0x20(%eax),%eax
    1f7e:	89 c2                	mov    %eax,%edx
    1f80:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f83:	8b 40 24             	mov    0x24(%eax),%eax
    1f86:	0f af d0             	imul   %eax,%edx
    1f89:	89 d0                	mov    %edx,%eax
    1f8b:	01 c0                	add    %eax,%eax
    1f8d:	01 c2                	add    %eax,%edx
    1f8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f92:	8b 40 38             	mov    0x38(%eax),%eax
    1f95:	83 ec 04             	sub    $0x4,%esp
    1f98:	52                   	push   %edx
    1f99:	68 ff ff ff 00       	push   $0xffffff
    1f9e:	50                   	push   %eax
    1f9f:	e8 8d e9 ff ff       	call   931 <memset>
    1fa4:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1fa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1faa:	c9                   	leave  
    1fab:	c3                   	ret    

00001fac <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1fac:	55                   	push   %ebp
    1fad:	89 e5                	mov    %esp,%ebp
    1faf:	57                   	push   %edi
    1fb0:	56                   	push   %esi
    1fb1:	53                   	push   %ebx
    1fb2:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fb8:	83 f8 03             	cmp    $0x3,%eax
    1fbb:	74 02                	je     1fbf <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1fbd:	eb 7c                	jmp    203b <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1fbf:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc2:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1fc5:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc8:	8b 48 18             	mov    0x18(%eax),%ecx
    1fcb:	8b 45 08             	mov    0x8(%ebp),%eax
    1fce:	8b 50 5c             	mov    0x5c(%eax),%edx
    1fd1:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd4:	8b 40 58             	mov    0x58(%eax),%eax
    1fd7:	8b 75 08             	mov    0x8(%ebp),%esi
    1fda:	83 c6 58             	add    $0x58,%esi
    1fdd:	83 ec 04             	sub    $0x4,%esp
    1fe0:	53                   	push   %ebx
    1fe1:	51                   	push   %ecx
    1fe2:	6a 00                	push   $0x0
    1fe4:	52                   	push   %edx
    1fe5:	50                   	push   %eax
    1fe6:	6a 00                	push   $0x0
    1fe8:	6a 00                	push   $0x0
    1fea:	56                   	push   %esi
    1feb:	6a 00                	push   $0x0
    1fed:	6a 00                	push   $0x0
    1fef:	ff 75 08             	pushl  0x8(%ebp)
    1ff2:	e8 75 eb ff ff       	call   b6c <paintWindow>
    1ff7:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1ffa:	8b 45 08             	mov    0x8(%ebp),%eax
    1ffd:	8b 70 1c             	mov    0x1c(%eax),%esi
    2000:	8b 45 08             	mov    0x8(%ebp),%eax
    2003:	8b 58 18             	mov    0x18(%eax),%ebx
    2006:	8b 45 08             	mov    0x8(%ebp),%eax
    2009:	8b 48 08             	mov    0x8(%eax),%ecx
    200c:	8b 45 08             	mov    0x8(%ebp),%eax
    200f:	8b 50 40             	mov    0x40(%eax),%edx
    2012:	8b 45 08             	mov    0x8(%ebp),%eax
    2015:	8b 40 3c             	mov    0x3c(%eax),%eax
    2018:	8b 7d 08             	mov    0x8(%ebp),%edi
    201b:	83 c7 3c             	add    $0x3c,%edi
    201e:	83 ec 04             	sub    $0x4,%esp
    2021:	56                   	push   %esi
    2022:	53                   	push   %ebx
    2023:	51                   	push   %ecx
    2024:	52                   	push   %edx
    2025:	50                   	push   %eax
    2026:	6a 00                	push   $0x0
    2028:	6a 00                	push   $0x0
    202a:	57                   	push   %edi
    202b:	6a 32                	push   $0x32
    202d:	6a 00                	push   $0x0
    202f:	ff 75 08             	pushl  0x8(%ebp)
    2032:	e8 35 eb ff ff       	call   b6c <paintWindow>
    2037:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    203a:	90                   	nop
        default: break;
            
            
    }
    return False;
    203b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2040:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2043:	5b                   	pop    %ebx
    2044:	5e                   	pop    %esi
    2045:	5f                   	pop    %edi
    2046:	5d                   	pop    %ebp
    2047:	c3                   	ret    

00002048 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    2048:	55                   	push   %ebp
    2049:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    204b:	8b 45 0c             	mov    0xc(%ebp),%eax
    204e:	8b 50 08             	mov    0x8(%eax),%edx
    2051:	8b 45 08             	mov    0x8(%ebp),%eax
    2054:	8b 00                	mov    (%eax),%eax
    2056:	39 c2                	cmp    %eax,%edx
    2058:	74 07                	je     2061 <APPreJudge+0x19>
        return False;
    205a:	b8 00 00 00 00       	mov    $0x0,%eax
    205f:	eb 05                	jmp    2066 <APPreJudge+0x1e>
    return True;
    2061:	b8 01 00 00 00       	mov    $0x1,%eax
}
    2066:	5d                   	pop    %ebp
    2067:	c3                   	ret    

00002068 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    2068:	55                   	push   %ebp
    2069:	89 e5                	mov    %esp,%ebp
    206b:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    206e:	8b 45 08             	mov    0x8(%ebp),%eax
    2071:	8b 55 0c             	mov    0xc(%ebp),%edx
    2074:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    207a:	83 ec 0c             	sub    $0xc,%esp
    207d:	ff 75 08             	pushl  0x8(%ebp)
    2080:	e8 ff ea ff ff       	call   b84 <registWindow>
    2085:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    2088:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    208f:	8b 45 08             	mov    0x8(%ebp),%eax
    2092:	8b 00                	mov    (%eax),%eax
    2094:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    2097:	ff 75 f4             	pushl  -0xc(%ebp)
    209a:	ff 75 f0             	pushl  -0x10(%ebp)
    209d:	ff 75 ec             	pushl  -0x14(%ebp)
    20a0:	ff 75 08             	pushl  0x8(%ebp)
    20a3:	e8 80 fc ff ff       	call   1d28 <APSendMessage>
    20a8:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    20ab:	83 ec 0c             	sub    $0xc,%esp
    20ae:	ff 75 08             	pushl  0x8(%ebp)
    20b1:	e8 c6 ea ff ff       	call   b7c <getMessage>
    20b6:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    20b9:	8b 45 08             	mov    0x8(%ebp),%eax
    20bc:	83 c0 74             	add    $0x74,%eax
    20bf:	83 ec 08             	sub    $0x8,%esp
    20c2:	50                   	push   %eax
    20c3:	ff 75 08             	pushl  0x8(%ebp)
    20c6:	e8 7d ff ff ff       	call   2048 <APPreJudge>
    20cb:	83 c4 10             	add    $0x10,%esp
    20ce:	84 c0                	test   %al,%al
    20d0:	74 1b                	je     20ed <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    20d2:	8b 45 08             	mov    0x8(%ebp),%eax
    20d5:	ff 70 7c             	pushl  0x7c(%eax)
    20d8:	ff 70 78             	pushl  0x78(%eax)
    20db:	ff 70 74             	pushl  0x74(%eax)
    20de:	ff 75 08             	pushl  0x8(%ebp)
    20e1:	8b 45 0c             	mov    0xc(%ebp),%eax
    20e4:	ff d0                	call   *%eax
    20e6:	83 c4 10             	add    $0x10,%esp
    20e9:	84 c0                	test   %al,%al
    20eb:	75 0c                	jne    20f9 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    20ed:	8b 45 08             	mov    0x8(%ebp),%eax
    20f0:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    20f7:	eb b2                	jmp    20ab <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    20f9:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    20fa:	90                   	nop
    20fb:	c9                   	leave  
    20fc:	c3                   	ret    

000020fd <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    20fd:	55                   	push   %ebp
    20fe:	89 e5                	mov    %esp,%ebp
    2100:	57                   	push   %edi
    2101:	56                   	push   %esi
    2102:	53                   	push   %ebx
    2103:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    2106:	a1 cc 70 00 00       	mov    0x70cc,%eax
    210b:	85 c0                	test   %eax,%eax
    210d:	0f 85 2c 02 00 00    	jne    233f <APGridPaint+0x242>
    {
        iconReady = 1;
    2113:	c7 05 cc 70 00 00 01 	movl   $0x1,0x70cc
    211a:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    211d:	8d 45 88             	lea    -0x78(%ebp),%eax
    2120:	83 ec 08             	sub    $0x8,%esp
    2123:	68 c7 2c 00 00       	push   $0x2cc7
    2128:	50                   	push   %eax
    2129:	e8 d3 ef ff ff       	call   1101 <APLoadBitmap>
    212e:	83 c4 0c             	add    $0xc,%esp
    2131:	8b 45 88             	mov    -0x78(%ebp),%eax
    2134:	a3 84 af 00 00       	mov    %eax,0xaf84
    2139:	8b 45 8c             	mov    -0x74(%ebp),%eax
    213c:	a3 88 af 00 00       	mov    %eax,0xaf88
    2141:	8b 45 90             	mov    -0x70(%ebp),%eax
    2144:	a3 8c af 00 00       	mov    %eax,0xaf8c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    2149:	83 ec 04             	sub    $0x4,%esp
    214c:	ff 35 8c af 00 00    	pushl  0xaf8c
    2152:	ff 35 88 af 00 00    	pushl  0xaf88
    2158:	ff 35 84 af 00 00    	pushl  0xaf84
    215e:	e8 d8 f1 ff ff       	call   133b <APCreateCompatibleDCFromBitmap>
    2163:	83 c4 10             	add    $0x10,%esp
    2166:	a3 98 af 00 00       	mov    %eax,0xaf98
        grid_river = APLoadBitmap ("grid_river.bmp");
    216b:	8d 45 88             	lea    -0x78(%ebp),%eax
    216e:	83 ec 08             	sub    $0x8,%esp
    2171:	68 d5 2c 00 00       	push   $0x2cd5
    2176:	50                   	push   %eax
    2177:	e8 85 ef ff ff       	call   1101 <APLoadBitmap>
    217c:	83 c4 0c             	add    $0xc,%esp
    217f:	8b 45 88             	mov    -0x78(%ebp),%eax
    2182:	a3 7c bf 00 00       	mov    %eax,0xbf7c
    2187:	8b 45 8c             	mov    -0x74(%ebp),%eax
    218a:	a3 80 bf 00 00       	mov    %eax,0xbf80
    218f:	8b 45 90             	mov    -0x70(%ebp),%eax
    2192:	a3 84 bf 00 00       	mov    %eax,0xbf84
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    2197:	83 ec 04             	sub    $0x4,%esp
    219a:	ff 35 84 bf 00 00    	pushl  0xbf84
    21a0:	ff 35 80 bf 00 00    	pushl  0xbf80
    21a6:	ff 35 7c bf 00 00    	pushl  0xbf7c
    21ac:	e8 8a f1 ff ff       	call   133b <APCreateCompatibleDCFromBitmap>
    21b1:	83 c4 10             	add    $0x10,%esp
    21b4:	a3 6c bf 00 00       	mov    %eax,0xbf6c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    21b9:	8d 45 88             	lea    -0x78(%ebp),%eax
    21bc:	83 ec 08             	sub    $0x8,%esp
    21bf:	68 e4 2c 00 00       	push   $0x2ce4
    21c4:	50                   	push   %eax
    21c5:	e8 37 ef ff ff       	call   1101 <APLoadBitmap>
    21ca:	83 c4 0c             	add    $0xc,%esp
    21cd:	8b 45 88             	mov    -0x78(%ebp),%eax
    21d0:	a3 70 bf 00 00       	mov    %eax,0xbf70
    21d5:	8b 45 8c             	mov    -0x74(%ebp),%eax
    21d8:	a3 74 bf 00 00       	mov    %eax,0xbf74
    21dd:	8b 45 90             	mov    -0x70(%ebp),%eax
    21e0:	a3 78 bf 00 00       	mov    %eax,0xbf78
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    21e5:	83 ec 04             	sub    $0x4,%esp
    21e8:	ff 35 78 bf 00 00    	pushl  0xbf78
    21ee:	ff 35 74 bf 00 00    	pushl  0xbf74
    21f4:	ff 35 70 bf 00 00    	pushl  0xbf70
    21fa:	e8 3c f1 ff ff       	call   133b <APCreateCompatibleDCFromBitmap>
    21ff:	83 c4 10             	add    $0x10,%esp
    2202:	a3 64 af 00 00       	mov    %eax,0xaf64
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    2207:	8d 45 88             	lea    -0x78(%ebp),%eax
    220a:	83 ec 08             	sub    $0x8,%esp
    220d:	68 f3 2c 00 00       	push   $0x2cf3
    2212:	50                   	push   %eax
    2213:	e8 e9 ee ff ff       	call   1101 <APLoadBitmap>
    2218:	83 c4 0c             	add    $0xc,%esp
    221b:	8b 45 88             	mov    -0x78(%ebp),%eax
    221e:	a3 a0 af 00 00       	mov    %eax,0xafa0
    2223:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2226:	a3 a4 af 00 00       	mov    %eax,0xafa4
    222b:	8b 45 90             	mov    -0x70(%ebp),%eax
    222e:	a3 a8 af 00 00       	mov    %eax,0xafa8
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    2233:	83 ec 04             	sub    $0x4,%esp
    2236:	ff 35 a8 af 00 00    	pushl  0xafa8
    223c:	ff 35 a4 af 00 00    	pushl  0xafa4
    2242:	ff 35 a0 af 00 00    	pushl  0xafa0
    2248:	e8 ee f0 ff ff       	call   133b <APCreateCompatibleDCFromBitmap>
    224d:	83 c4 10             	add    $0x10,%esp
    2250:	a3 88 bf 00 00       	mov    %eax,0xbf88
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    2255:	8d 45 88             	lea    -0x78(%ebp),%eax
    2258:	83 ec 08             	sub    $0x8,%esp
    225b:	68 01 2d 00 00       	push   $0x2d01
    2260:	50                   	push   %eax
    2261:	e8 9b ee ff ff       	call   1101 <APLoadBitmap>
    2266:	83 c4 0c             	add    $0xc,%esp
    2269:	8b 45 88             	mov    -0x78(%ebp),%eax
    226c:	a3 74 af 00 00       	mov    %eax,0xaf74
    2271:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2274:	a3 78 af 00 00       	mov    %eax,0xaf78
    2279:	8b 45 90             	mov    -0x70(%ebp),%eax
    227c:	a3 7c af 00 00       	mov    %eax,0xaf7c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    2281:	83 ec 04             	sub    $0x4,%esp
    2284:	ff 35 7c af 00 00    	pushl  0xaf7c
    228a:	ff 35 78 af 00 00    	pushl  0xaf78
    2290:	ff 35 74 af 00 00    	pushl  0xaf74
    2296:	e8 a0 f0 ff ff       	call   133b <APCreateCompatibleDCFromBitmap>
    229b:	83 c4 10             	add    $0x10,%esp
    229e:	a3 9c af 00 00       	mov    %eax,0xaf9c
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    22a3:	8d 45 88             	lea    -0x78(%ebp),%eax
    22a6:	83 ec 08             	sub    $0x8,%esp
    22a9:	68 11 2d 00 00       	push   $0x2d11
    22ae:	50                   	push   %eax
    22af:	e8 4d ee ff ff       	call   1101 <APLoadBitmap>
    22b4:	83 c4 0c             	add    $0xc,%esp
    22b7:	8b 45 88             	mov    -0x78(%ebp),%eax
    22ba:	a3 68 af 00 00       	mov    %eax,0xaf68
    22bf:	8b 45 8c             	mov    -0x74(%ebp),%eax
    22c2:	a3 6c af 00 00       	mov    %eax,0xaf6c
    22c7:	8b 45 90             	mov    -0x70(%ebp),%eax
    22ca:	a3 70 af 00 00       	mov    %eax,0xaf70
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    22cf:	83 ec 04             	sub    $0x4,%esp
    22d2:	ff 35 70 af 00 00    	pushl  0xaf70
    22d8:	ff 35 6c af 00 00    	pushl  0xaf6c
    22de:	ff 35 68 af 00 00    	pushl  0xaf68
    22e4:	e8 52 f0 ff ff       	call   133b <APCreateCompatibleDCFromBitmap>
    22e9:	83 c4 10             	add    $0x10,%esp
    22ec:	a3 80 af 00 00       	mov    %eax,0xaf80
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    22f1:	8d 45 88             	lea    -0x78(%ebp),%eax
    22f4:	83 ec 08             	sub    $0x8,%esp
    22f7:	68 23 2d 00 00       	push   $0x2d23
    22fc:	50                   	push   %eax
    22fd:	e8 ff ed ff ff       	call   1101 <APLoadBitmap>
    2302:	83 c4 0c             	add    $0xc,%esp
    2305:	8b 45 88             	mov    -0x78(%ebp),%eax
    2308:	a3 60 bf 00 00       	mov    %eax,0xbf60
    230d:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2310:	a3 64 bf 00 00       	mov    %eax,0xbf64
    2315:	8b 45 90             	mov    -0x70(%ebp),%eax
    2318:	a3 68 bf 00 00       	mov    %eax,0xbf68
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    231d:	83 ec 04             	sub    $0x4,%esp
    2320:	ff 35 68 bf 00 00    	pushl  0xbf68
    2326:	ff 35 64 bf 00 00    	pushl  0xbf64
    232c:	ff 35 60 bf 00 00    	pushl  0xbf60
    2332:	e8 04 f0 ff ff       	call   133b <APCreateCompatibleDCFromBitmap>
    2337:	83 c4 10             	add    $0x10,%esp
    233a:	a3 8c bf 00 00       	mov    %eax,0xbf8c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    233f:	8b 45 08             	mov    0x8(%ebp),%eax
    2342:	8b 40 08             	mov    0x8(%eax),%eax
    2345:	85 c0                	test   %eax,%eax
    2347:	75 17                	jne    2360 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    2349:	83 ec 08             	sub    $0x8,%esp
    234c:	68 34 2d 00 00       	push   $0x2d34
    2351:	6a 01                	push   $0x1
    2353:	e8 23 e9 ff ff       	call   c7b <printf>
    2358:	83 c4 10             	add    $0x10,%esp
        return;
    235b:	e9 07 05 00 00       	jmp    2867 <APGridPaint+0x76a>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    2360:	8b 45 08             	mov    0x8(%ebp),%eax
    2363:	8b 40 10             	mov    0x10(%eax),%eax
    2366:	85 c0                	test   %eax,%eax
    2368:	7e 10                	jle    237a <APGridPaint+0x27d>
    236a:	8b 45 08             	mov    0x8(%ebp),%eax
    236d:	8b 50 14             	mov    0x14(%eax),%edx
    2370:	8b 45 08             	mov    0x8(%ebp),%eax
    2373:	8b 40 10             	mov    0x10(%eax),%eax
    2376:	39 c2                	cmp    %eax,%edx
    2378:	7c 17                	jl     2391 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    237a:	83 ec 08             	sub    $0x8,%esp
    237d:	68 5a 2d 00 00       	push   $0x2d5a
    2382:	6a 01                	push   $0x1
    2384:	e8 f2 e8 ff ff       	call   c7b <printf>
    2389:	83 c4 10             	add    $0x10,%esp
        return;
    238c:	e9 d6 04 00 00       	jmp    2867 <APGridPaint+0x76a>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    2391:	8b 45 08             	mov    0x8(%ebp),%eax
    2394:	8b 40 14             	mov    0x14(%eax),%eax
    2397:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    239d:	89 45 dc             	mov    %eax,-0x24(%ebp)
    23a0:	8b 45 dc             	mov    -0x24(%ebp),%eax
    23a3:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    23a6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    23ad:	e9 96 03 00 00       	jmp    2748 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    23b2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    23b9:	e9 7c 03 00 00       	jmp    273a <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    23be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23c1:	c1 e0 04             	shl    $0x4,%eax
    23c4:	89 c2                	mov    %eax,%edx
    23c6:	8b 45 d8             	mov    -0x28(%ebp),%eax
    23c9:	01 c2                	add    %eax,%edx
    23cb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    23ce:	01 d0                	add    %edx,%eax
    23d0:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    23d3:	8b 45 08             	mov    0x8(%ebp),%eax
    23d6:	8b 40 0c             	mov    0xc(%eax),%eax
    23d9:	8b 55 dc             	mov    -0x24(%ebp),%edx
    23dc:	c1 e2 02             	shl    $0x2,%edx
    23df:	01 d0                	add    %edx,%eax
    23e1:	8b 00                	mov    (%eax),%eax
    23e3:	83 f8 07             	cmp    $0x7,%eax
    23e6:	0f 87 49 03 00 00    	ja     2735 <APGridPaint+0x638>
    23ec:	8b 04 85 70 2d 00 00 	mov    0x2d70(,%eax,4),%eax
    23f3:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    23f5:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    23f8:	6a 0c                	push   $0xc
    23fa:	6a 0c                	push   $0xc
    23fc:	6a 0c                	push   $0xc
    23fe:	50                   	push   %eax
    23ff:	e8 df f8 ff ff       	call   1ce3 <RGB>
    2404:	83 c4 0c             	add    $0xc,%esp
    2407:	8b 1d 98 af 00 00    	mov    0xaf98,%ebx
    240d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2410:	6b c8 32             	imul   $0x32,%eax,%ecx
    2413:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2416:	6b c0 32             	imul   $0x32,%eax,%eax
    2419:	89 45 84             	mov    %eax,-0x7c(%ebp)
    241c:	8b 45 08             	mov    0x8(%ebp),%eax
    241f:	8d 78 3c             	lea    0x3c(%eax),%edi
    2422:	83 ec 0c             	sub    $0xc,%esp
    2425:	83 ec 04             	sub    $0x4,%esp
    2428:	89 e0                	mov    %esp,%eax
    242a:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    242e:	66 89 30             	mov    %si,(%eax)
    2431:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    2435:	88 50 02             	mov    %dl,0x2(%eax)
    2438:	6a 32                	push   $0x32
    243a:	6a 32                	push   $0x32
    243c:	6a 00                	push   $0x0
    243e:	6a 00                	push   $0x0
    2440:	53                   	push   %ebx
    2441:	51                   	push   %ecx
    2442:	ff 75 84             	pushl  -0x7c(%ebp)
    2445:	57                   	push   %edi
    2446:	e8 f4 f6 ff ff       	call   1b3f <APDcCopy>
    244b:	83 c4 30             	add    $0x30,%esp
                    break;
    244e:	e9 e3 02 00 00       	jmp    2736 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    2453:	8d 45 88             	lea    -0x78(%ebp),%eax
    2456:	6a 69                	push   $0x69
    2458:	6a 69                	push   $0x69
    245a:	6a 69                	push   $0x69
    245c:	50                   	push   %eax
    245d:	e8 81 f8 ff ff       	call   1ce3 <RGB>
    2462:	83 c4 0c             	add    $0xc,%esp
    2465:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2469:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    246d:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2471:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    2474:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    247b:	8d 45 88             	lea    -0x78(%ebp),%eax
    247e:	6a 69                	push   $0x69
    2480:	6a 69                	push   $0x69
    2482:	6a 69                	push   $0x69
    2484:	50                   	push   %eax
    2485:	e8 59 f8 ff ff       	call   1ce3 <RGB>
    248a:	83 c4 0c             	add    $0xc,%esp
    248d:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2491:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    2495:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2499:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    249c:	8b 45 08             	mov    0x8(%ebp),%eax
    249f:	8d 50 3c             	lea    0x3c(%eax),%edx
    24a2:	8d 45 88             	lea    -0x78(%ebp),%eax
    24a5:	ff 75 ac             	pushl  -0x54(%ebp)
    24a8:	ff 75 a8             	pushl  -0x58(%ebp)
    24ab:	52                   	push   %edx
    24ac:	50                   	push   %eax
    24ad:	e8 1e ef ff ff       	call   13d0 <APSetPen>
    24b2:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    24b5:	8b 45 08             	mov    0x8(%ebp),%eax
    24b8:	8d 58 3c             	lea    0x3c(%eax),%ebx
    24bb:	8d 55 88             	lea    -0x78(%ebp),%edx
    24be:	83 ec 04             	sub    $0x4,%esp
    24c1:	83 ec 04             	sub    $0x4,%esp
    24c4:	89 e0                	mov    %esp,%eax
    24c6:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    24ca:	66 89 08             	mov    %cx,(%eax)
    24cd:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    24d1:	88 48 02             	mov    %cl,0x2(%eax)
    24d4:	53                   	push   %ebx
    24d5:	52                   	push   %edx
    24d6:	e8 2e ef ff ff       	call   1409 <APSetBrush>
    24db:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    24de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24e1:	6b d0 32             	imul   $0x32,%eax,%edx
    24e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    24e7:	6b c0 32             	imul   $0x32,%eax,%eax
    24ea:	8b 4d 08             	mov    0x8(%ebp),%ecx
    24ed:	83 c1 3c             	add    $0x3c,%ecx
    24f0:	83 ec 0c             	sub    $0xc,%esp
    24f3:	6a 32                	push   $0x32
    24f5:	6a 32                	push   $0x32
    24f7:	52                   	push   %edx
    24f8:	50                   	push   %eax
    24f9:	51                   	push   %ecx
    24fa:	e8 34 f3 ff ff       	call   1833 <APDrawRect>
    24ff:	83 c4 20             	add    $0x20,%esp
                    break;
    2502:	e9 2f 02 00 00       	jmp    2736 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2507:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    250a:	6a 0c                	push   $0xc
    250c:	6a 0c                	push   $0xc
    250e:	6a 0c                	push   $0xc
    2510:	50                   	push   %eax
    2511:	e8 cd f7 ff ff       	call   1ce3 <RGB>
    2516:	83 c4 0c             	add    $0xc,%esp
    2519:	8b 1d 8c bf 00 00    	mov    0xbf8c,%ebx
    251f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2522:	6b c8 32             	imul   $0x32,%eax,%ecx
    2525:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2528:	6b c0 32             	imul   $0x32,%eax,%eax
    252b:	89 45 84             	mov    %eax,-0x7c(%ebp)
    252e:	8b 45 08             	mov    0x8(%ebp),%eax
    2531:	8d 78 3c             	lea    0x3c(%eax),%edi
    2534:	83 ec 0c             	sub    $0xc,%esp
    2537:	83 ec 04             	sub    $0x4,%esp
    253a:	89 e0                	mov    %esp,%eax
    253c:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2540:	66 89 30             	mov    %si,(%eax)
    2543:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    2547:	88 50 02             	mov    %dl,0x2(%eax)
    254a:	6a 32                	push   $0x32
    254c:	6a 32                	push   $0x32
    254e:	6a 00                	push   $0x0
    2550:	6a 00                	push   $0x0
    2552:	53                   	push   %ebx
    2553:	51                   	push   %ecx
    2554:	ff 75 84             	pushl  -0x7c(%ebp)
    2557:	57                   	push   %edi
    2558:	e8 e2 f5 ff ff       	call   1b3f <APDcCopy>
    255d:	83 c4 30             	add    $0x30,%esp
                    break;
    2560:	e9 d1 01 00 00       	jmp    2736 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2565:	8d 45 c9             	lea    -0x37(%ebp),%eax
    2568:	6a 0c                	push   $0xc
    256a:	6a 0c                	push   $0xc
    256c:	6a 0c                	push   $0xc
    256e:	50                   	push   %eax
    256f:	e8 6f f7 ff ff       	call   1ce3 <RGB>
    2574:	83 c4 0c             	add    $0xc,%esp
    2577:	8b 1d 6c bf 00 00    	mov    0xbf6c,%ebx
    257d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2580:	6b c8 32             	imul   $0x32,%eax,%ecx
    2583:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2586:	6b c0 32             	imul   $0x32,%eax,%eax
    2589:	89 45 84             	mov    %eax,-0x7c(%ebp)
    258c:	8b 45 08             	mov    0x8(%ebp),%eax
    258f:	8d 78 3c             	lea    0x3c(%eax),%edi
    2592:	83 ec 0c             	sub    $0xc,%esp
    2595:	83 ec 04             	sub    $0x4,%esp
    2598:	89 e0                	mov    %esp,%eax
    259a:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    259e:	66 89 30             	mov    %si,(%eax)
    25a1:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    25a5:	88 50 02             	mov    %dl,0x2(%eax)
    25a8:	6a 32                	push   $0x32
    25aa:	6a 32                	push   $0x32
    25ac:	6a 00                	push   $0x0
    25ae:	6a 00                	push   $0x0
    25b0:	53                   	push   %ebx
    25b1:	51                   	push   %ecx
    25b2:	ff 75 84             	pushl  -0x7c(%ebp)
    25b5:	57                   	push   %edi
    25b6:	e8 84 f5 ff ff       	call   1b3f <APDcCopy>
    25bb:	83 c4 30             	add    $0x30,%esp
                    break;
    25be:	e9 73 01 00 00       	jmp    2736 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    25c3:	8d 45 cc             	lea    -0x34(%ebp),%eax
    25c6:	6a 0c                	push   $0xc
    25c8:	6a 0c                	push   $0xc
    25ca:	6a 0c                	push   $0xc
    25cc:	50                   	push   %eax
    25cd:	e8 11 f7 ff ff       	call   1ce3 <RGB>
    25d2:	83 c4 0c             	add    $0xc,%esp
    25d5:	8b 1d 9c af 00 00    	mov    0xaf9c,%ebx
    25db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    25de:	6b c8 32             	imul   $0x32,%eax,%ecx
    25e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    25e4:	6b c0 32             	imul   $0x32,%eax,%eax
    25e7:	89 45 84             	mov    %eax,-0x7c(%ebp)
    25ea:	8b 45 08             	mov    0x8(%ebp),%eax
    25ed:	8d 78 3c             	lea    0x3c(%eax),%edi
    25f0:	83 ec 0c             	sub    $0xc,%esp
    25f3:	83 ec 04             	sub    $0x4,%esp
    25f6:	89 e0                	mov    %esp,%eax
    25f8:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    25fc:	66 89 30             	mov    %si,(%eax)
    25ff:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    2603:	88 50 02             	mov    %dl,0x2(%eax)
    2606:	6a 32                	push   $0x32
    2608:	6a 32                	push   $0x32
    260a:	6a 00                	push   $0x0
    260c:	6a 00                	push   $0x0
    260e:	53                   	push   %ebx
    260f:	51                   	push   %ecx
    2610:	ff 75 84             	pushl  -0x7c(%ebp)
    2613:	57                   	push   %edi
    2614:	e8 26 f5 ff ff       	call   1b3f <APDcCopy>
    2619:	83 c4 30             	add    $0x30,%esp
                    break;
    261c:	e9 15 01 00 00       	jmp    2736 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2621:	8d 45 cf             	lea    -0x31(%ebp),%eax
    2624:	6a 0c                	push   $0xc
    2626:	6a 0c                	push   $0xc
    2628:	6a 0c                	push   $0xc
    262a:	50                   	push   %eax
    262b:	e8 b3 f6 ff ff       	call   1ce3 <RGB>
    2630:	83 c4 0c             	add    $0xc,%esp
    2633:	8b 1d 88 bf 00 00    	mov    0xbf88,%ebx
    2639:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    263c:	6b c8 32             	imul   $0x32,%eax,%ecx
    263f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2642:	6b c0 32             	imul   $0x32,%eax,%eax
    2645:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2648:	8b 45 08             	mov    0x8(%ebp),%eax
    264b:	8d 78 3c             	lea    0x3c(%eax),%edi
    264e:	83 ec 0c             	sub    $0xc,%esp
    2651:	83 ec 04             	sub    $0x4,%esp
    2654:	89 e0                	mov    %esp,%eax
    2656:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    265a:	66 89 30             	mov    %si,(%eax)
    265d:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2661:	88 50 02             	mov    %dl,0x2(%eax)
    2664:	6a 32                	push   $0x32
    2666:	6a 32                	push   $0x32
    2668:	6a 00                	push   $0x0
    266a:	6a 00                	push   $0x0
    266c:	53                   	push   %ebx
    266d:	51                   	push   %ecx
    266e:	ff 75 84             	pushl  -0x7c(%ebp)
    2671:	57                   	push   %edi
    2672:	e8 c8 f4 ff ff       	call   1b3f <APDcCopy>
    2677:	83 c4 30             	add    $0x30,%esp
                    break;
    267a:	e9 b7 00 00 00       	jmp    2736 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    267f:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2682:	6a 0c                	push   $0xc
    2684:	6a 0c                	push   $0xc
    2686:	6a 0c                	push   $0xc
    2688:	50                   	push   %eax
    2689:	e8 55 f6 ff ff       	call   1ce3 <RGB>
    268e:	83 c4 0c             	add    $0xc,%esp
    2691:	8b 1d 64 af 00 00    	mov    0xaf64,%ebx
    2697:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    269a:	6b c8 32             	imul   $0x32,%eax,%ecx
    269d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    26a0:	6b c0 32             	imul   $0x32,%eax,%eax
    26a3:	89 45 84             	mov    %eax,-0x7c(%ebp)
    26a6:	8b 45 08             	mov    0x8(%ebp),%eax
    26a9:	8d 78 3c             	lea    0x3c(%eax),%edi
    26ac:	83 ec 0c             	sub    $0xc,%esp
    26af:	83 ec 04             	sub    $0x4,%esp
    26b2:	89 e0                	mov    %esp,%eax
    26b4:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    26b8:	66 89 30             	mov    %si,(%eax)
    26bb:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    26bf:	88 50 02             	mov    %dl,0x2(%eax)
    26c2:	6a 32                	push   $0x32
    26c4:	6a 32                	push   $0x32
    26c6:	6a 00                	push   $0x0
    26c8:	6a 00                	push   $0x0
    26ca:	53                   	push   %ebx
    26cb:	51                   	push   %ecx
    26cc:	ff 75 84             	pushl  -0x7c(%ebp)
    26cf:	57                   	push   %edi
    26d0:	e8 6a f4 ff ff       	call   1b3f <APDcCopy>
    26d5:	83 c4 30             	add    $0x30,%esp
                    break;
    26d8:	eb 5c                	jmp    2736 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    26da:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    26dd:	6a 0c                	push   $0xc
    26df:	6a 0c                	push   $0xc
    26e1:	6a 0c                	push   $0xc
    26e3:	50                   	push   %eax
    26e4:	e8 fa f5 ff ff       	call   1ce3 <RGB>
    26e9:	83 c4 0c             	add    $0xc,%esp
    26ec:	8b 1d 80 af 00 00    	mov    0xaf80,%ebx
    26f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    26f5:	6b c8 32             	imul   $0x32,%eax,%ecx
    26f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    26fb:	6b c0 32             	imul   $0x32,%eax,%eax
    26fe:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2701:	8b 45 08             	mov    0x8(%ebp),%eax
    2704:	8d 78 3c             	lea    0x3c(%eax),%edi
    2707:	83 ec 0c             	sub    $0xc,%esp
    270a:	83 ec 04             	sub    $0x4,%esp
    270d:	89 e0                	mov    %esp,%eax
    270f:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2713:	66 89 30             	mov    %si,(%eax)
    2716:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    271a:	88 50 02             	mov    %dl,0x2(%eax)
    271d:	6a 32                	push   $0x32
    271f:	6a 32                	push   $0x32
    2721:	6a 00                	push   $0x0
    2723:	6a 00                	push   $0x0
    2725:	53                   	push   %ebx
    2726:	51                   	push   %ecx
    2727:	ff 75 84             	pushl  -0x7c(%ebp)
    272a:	57                   	push   %edi
    272b:	e8 0f f4 ff ff       	call   1b3f <APDcCopy>
    2730:	83 c4 30             	add    $0x30,%esp
                    break;
    2733:	eb 01                	jmp    2736 <APGridPaint+0x639>
                default: break;
    2735:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2736:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    273a:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    273e:	0f 8e 7a fc ff ff    	jle    23be <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2744:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2748:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    274c:	0f 8e 60 fc ff ff    	jle    23b2 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2752:	8d 45 88             	lea    -0x78(%ebp),%eax
    2755:	68 cd 00 00 00       	push   $0xcd
    275a:	6a 74                	push   $0x74
    275c:	6a 18                	push   $0x18
    275e:	50                   	push   %eax
    275f:	e8 7f f5 ff ff       	call   1ce3 <RGB>
    2764:	83 c4 0c             	add    $0xc,%esp
    2767:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    276b:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    276f:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2773:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    2776:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    277d:	8d 45 88             	lea    -0x78(%ebp),%eax
    2780:	68 cd 00 00 00       	push   $0xcd
    2785:	6a 74                	push   $0x74
    2787:	6a 18                	push   $0x18
    2789:	50                   	push   %eax
    278a:	e8 54 f5 ff ff       	call   1ce3 <RGB>
    278f:	83 c4 0c             	add    $0xc,%esp
    2792:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2796:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    279a:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    279e:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    27a1:	8b 45 08             	mov    0x8(%ebp),%eax
    27a4:	8d 50 58             	lea    0x58(%eax),%edx
    27a7:	8d 45 88             	lea    -0x78(%ebp),%eax
    27aa:	ff 75 bc             	pushl  -0x44(%ebp)
    27ad:	ff 75 b8             	pushl  -0x48(%ebp)
    27b0:	52                   	push   %edx
    27b1:	50                   	push   %eax
    27b2:	e8 19 ec ff ff       	call   13d0 <APSetPen>
    27b7:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    27ba:	8b 45 08             	mov    0x8(%ebp),%eax
    27bd:	8d 58 58             	lea    0x58(%eax),%ebx
    27c0:	8d 55 88             	lea    -0x78(%ebp),%edx
    27c3:	83 ec 04             	sub    $0x4,%esp
    27c6:	83 ec 04             	sub    $0x4,%esp
    27c9:	89 e0                	mov    %esp,%eax
    27cb:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    27cf:	66 89 08             	mov    %cx,(%eax)
    27d2:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    27d6:	88 48 02             	mov    %cl,0x2(%eax)
    27d9:	53                   	push   %ebx
    27da:	52                   	push   %edx
    27db:	e8 29 ec ff ff       	call   1409 <APSetBrush>
    27e0:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    27e3:	8b 45 08             	mov    0x8(%ebp),%eax
    27e6:	83 c0 58             	add    $0x58,%eax
    27e9:	83 ec 0c             	sub    $0xc,%esp
    27ec:	6a 32                	push   $0x32
    27ee:	68 20 03 00 00       	push   $0x320
    27f3:	6a 00                	push   $0x0
    27f5:	6a 00                	push   $0x0
    27f7:	50                   	push   %eax
    27f8:	e8 36 f0 ff ff       	call   1833 <APDrawRect>
    27fd:	83 c4 20             	add    $0x20,%esp
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    2800:	8d 45 88             	lea    -0x78(%ebp),%eax
    2803:	6a 08                	push   $0x8
    2805:	6a 08                	push   $0x8
    2807:	6a 08                	push   $0x8
    2809:	50                   	push   %eax
    280a:	e8 d4 f4 ff ff       	call   1ce3 <RGB>
    280f:	83 c4 0c             	add    $0xc,%esp
    2812:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2816:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    281a:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    281e:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    2821:	8b 45 08             	mov    0x8(%ebp),%eax
    2824:	8d 58 58             	lea    0x58(%eax),%ebx
    2827:	8d 55 88             	lea    -0x78(%ebp),%edx
    282a:	83 ec 04             	sub    $0x4,%esp
    282d:	83 ec 04             	sub    $0x4,%esp
    2830:	89 e0                	mov    %esp,%eax
    2832:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    2836:	66 89 08             	mov    %cx,(%eax)
    2839:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    283d:	88 48 02             	mov    %cl,0x2(%eax)
    2840:	53                   	push   %ebx
    2841:	52                   	push   %edx
    2842:	e8 04 ec ff ff       	call   144b <APSetFont>
    2847:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    284a:	8b 45 08             	mov    0x8(%ebp),%eax
    284d:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    2853:	8b 45 08             	mov    0x8(%ebp),%eax
    2856:	83 c0 58             	add    $0x58,%eax
    2859:	6a 14                	push   $0x14
    285b:	6a 14                	push   $0x14
    285d:	52                   	push   %edx
    285e:	50                   	push   %eax
    285f:	e8 d4 f1 ff ff       	call   1a38 <APDrawText>
    2864:	83 c4 10             	add    $0x10,%esp
}
    2867:	8d 65 f4             	lea    -0xc(%ebp),%esp
    286a:	5b                   	pop    %ebx
    286b:	5e                   	pop    %esi
    286c:	5f                   	pop    %edi
    286d:	5d                   	pop    %ebp
    286e:	c3                   	ret    

0000286f <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    286f:	55                   	push   %ebp
    2870:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2872:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2876:	7e 08                	jle    2880 <random+0x11>
{
rand_num = seed;
    2878:	8b 45 08             	mov    0x8(%ebp),%eax
    287b:	a3 a0 70 00 00       	mov    %eax,0x70a0
}
rand_num *= 3;
    2880:	8b 15 a0 70 00 00    	mov    0x70a0,%edx
    2886:	89 d0                	mov    %edx,%eax
    2888:	01 c0                	add    %eax,%eax
    288a:	01 d0                	add    %edx,%eax
    288c:	a3 a0 70 00 00       	mov    %eax,0x70a0
if (rand_num < 0)
    2891:	a1 a0 70 00 00       	mov    0x70a0,%eax
    2896:	85 c0                	test   %eax,%eax
    2898:	79 0c                	jns    28a6 <random+0x37>
{
rand_num *= (-1);
    289a:	a1 a0 70 00 00       	mov    0x70a0,%eax
    289f:	f7 d8                	neg    %eax
    28a1:	a3 a0 70 00 00       	mov    %eax,0x70a0
}
return rand_num % 997;
    28a6:	8b 0d a0 70 00 00    	mov    0x70a0,%ecx
    28ac:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    28b1:	89 c8                	mov    %ecx,%eax
    28b3:	f7 ea                	imul   %edx
    28b5:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    28b8:	c1 f8 09             	sar    $0x9,%eax
    28bb:	89 c2                	mov    %eax,%edx
    28bd:	89 c8                	mov    %ecx,%eax
    28bf:	c1 f8 1f             	sar    $0x1f,%eax
    28c2:	29 c2                	sub    %eax,%edx
    28c4:	89 d0                	mov    %edx,%eax
    28c6:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    28cc:	29 c1                	sub    %eax,%ecx
    28ce:	89 c8                	mov    %ecx,%eax
}
    28d0:	5d                   	pop    %ebp
    28d1:	c3                   	ret    

000028d2 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    28d2:	55                   	push   %ebp
    28d3:	89 e5                	mov    %esp,%ebp
    28d5:	53                   	push   %ebx
    28d6:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    28d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    28e0:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    28e4:	74 17                	je     28fd <sprintint+0x2b>
    28e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    28ea:	79 11                	jns    28fd <sprintint+0x2b>
        neg = 1;
    28ec:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    28f3:	8b 45 10             	mov    0x10(%ebp),%eax
    28f6:	f7 d8                	neg    %eax
    28f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    28fb:	eb 06                	jmp    2903 <sprintint+0x31>
    } else {
        x = xx;
    28fd:	8b 45 10             	mov    0x10(%ebp),%eax
    2900:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2903:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    290a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    290d:	8d 41 01             	lea    0x1(%ecx),%eax
    2910:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2913:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2916:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2919:	ba 00 00 00 00       	mov    $0x0,%edx
    291e:	f7 f3                	div    %ebx
    2920:	89 d0                	mov    %edx,%eax
    2922:	0f b6 80 a4 70 00 00 	movzbl 0x70a4(%eax),%eax
    2929:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    292d:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2930:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2933:	ba 00 00 00 00       	mov    $0x0,%edx
    2938:	f7 f3                	div    %ebx
    293a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    293d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2941:	75 c7                	jne    290a <sprintint+0x38>
    if(neg)
    2943:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2947:	74 0e                	je     2957 <sprintint+0x85>
        buf[i++] = '-';
    2949:	8b 45 f8             	mov    -0x8(%ebp),%eax
    294c:	8d 50 01             	lea    0x1(%eax),%edx
    294f:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2952:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2957:	8b 45 f8             	mov    -0x8(%ebp),%eax
    295a:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    295d:	eb 1b                	jmp    297a <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    295f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2962:	8b 00                	mov    (%eax),%eax
    2964:	8d 48 01             	lea    0x1(%eax),%ecx
    2967:	8b 55 0c             	mov    0xc(%ebp),%edx
    296a:	89 0a                	mov    %ecx,(%edx)
    296c:	89 c2                	mov    %eax,%edx
    296e:	8b 45 08             	mov    0x8(%ebp),%eax
    2971:	01 d0                	add    %edx,%eax
    2973:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2976:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    297a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    297e:	7f df                	jg     295f <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2980:	eb 21                	jmp    29a3 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2982:	8b 45 0c             	mov    0xc(%ebp),%eax
    2985:	8b 00                	mov    (%eax),%eax
    2987:	8d 48 01             	lea    0x1(%eax),%ecx
    298a:	8b 55 0c             	mov    0xc(%ebp),%edx
    298d:	89 0a                	mov    %ecx,(%edx)
    298f:	89 c2                	mov    %eax,%edx
    2991:	8b 45 08             	mov    0x8(%ebp),%eax
    2994:	01 c2                	add    %eax,%edx
    2996:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2999:	8b 45 f8             	mov    -0x8(%ebp),%eax
    299c:	01 c8                	add    %ecx,%eax
    299e:	0f b6 00             	movzbl (%eax),%eax
    29a1:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    29a3:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    29a7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    29ab:	79 d5                	jns    2982 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    29ad:	90                   	nop
    29ae:	83 c4 20             	add    $0x20,%esp
    29b1:	5b                   	pop    %ebx
    29b2:	5d                   	pop    %ebp
    29b3:	c3                   	ret    

000029b4 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    29b4:	55                   	push   %ebp
    29b5:	89 e5                	mov    %esp,%ebp
    29b7:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    29ba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    29c1:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    29c8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    29cf:	8d 45 0c             	lea    0xc(%ebp),%eax
    29d2:	83 c0 04             	add    $0x4,%eax
    29d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    29d8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    29df:	e9 d9 01 00 00       	jmp    2bbd <sprintf+0x209>
        c = fmt[i] & 0xff;
    29e4:	8b 55 0c             	mov    0xc(%ebp),%edx
    29e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    29ea:	01 d0                	add    %edx,%eax
    29ec:	0f b6 00             	movzbl (%eax),%eax
    29ef:	0f be c0             	movsbl %al,%eax
    29f2:	25 ff 00 00 00       	and    $0xff,%eax
    29f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    29fa:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    29fe:	75 2c                	jne    2a2c <sprintf+0x78>
            if(c == '%'){
    2a00:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2a04:	75 0c                	jne    2a12 <sprintf+0x5e>
                state = '%';
    2a06:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2a0d:	e9 a7 01 00 00       	jmp    2bb9 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2a12:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2a15:	8d 50 01             	lea    0x1(%eax),%edx
    2a18:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2a1b:	89 c2                	mov    %eax,%edx
    2a1d:	8b 45 08             	mov    0x8(%ebp),%eax
    2a20:	01 d0                	add    %edx,%eax
    2a22:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2a25:	88 10                	mov    %dl,(%eax)
    2a27:	e9 8d 01 00 00       	jmp    2bb9 <sprintf+0x205>
            }
        } else if(state == '%'){
    2a2c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2a30:	0f 85 83 01 00 00    	jne    2bb9 <sprintf+0x205>
            if(c == 'd'){
    2a36:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2a3a:	75 4c                	jne    2a88 <sprintf+0xd4>
                buf[bi] = '\0';
    2a3c:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2a3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2a42:	01 d0                	add    %edx,%eax
    2a44:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2a47:	83 ec 0c             	sub    $0xc,%esp
    2a4a:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2a4d:	50                   	push   %eax
    2a4e:	e8 e7 df ff ff       	call   a3a <atoi>
    2a53:	83 c4 10             	add    $0x10,%esp
    2a56:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2a59:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2a60:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2a63:	8b 00                	mov    (%eax),%eax
    2a65:	83 ec 08             	sub    $0x8,%esp
    2a68:	ff 75 d8             	pushl  -0x28(%ebp)
    2a6b:	6a 01                	push   $0x1
    2a6d:	6a 0a                	push   $0xa
    2a6f:	50                   	push   %eax
    2a70:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2a73:	50                   	push   %eax
    2a74:	ff 75 08             	pushl  0x8(%ebp)
    2a77:	e8 56 fe ff ff       	call   28d2 <sprintint>
    2a7c:	83 c4 20             	add    $0x20,%esp
                ap++;
    2a7f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2a83:	e9 2a 01 00 00       	jmp    2bb2 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2a88:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2a8c:	74 06                	je     2a94 <sprintf+0xe0>
    2a8e:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2a92:	75 4c                	jne    2ae0 <sprintf+0x12c>
                buf[bi] = '\0';
    2a94:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2a97:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2a9a:	01 d0                	add    %edx,%eax
    2a9c:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2a9f:	83 ec 0c             	sub    $0xc,%esp
    2aa2:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2aa5:	50                   	push   %eax
    2aa6:	e8 8f df ff ff       	call   a3a <atoi>
    2aab:	83 c4 10             	add    $0x10,%esp
    2aae:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2ab1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2ab8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2abb:	8b 00                	mov    (%eax),%eax
    2abd:	83 ec 08             	sub    $0x8,%esp
    2ac0:	ff 75 dc             	pushl  -0x24(%ebp)
    2ac3:	6a 00                	push   $0x0
    2ac5:	6a 10                	push   $0x10
    2ac7:	50                   	push   %eax
    2ac8:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2acb:	50                   	push   %eax
    2acc:	ff 75 08             	pushl  0x8(%ebp)
    2acf:	e8 fe fd ff ff       	call   28d2 <sprintint>
    2ad4:	83 c4 20             	add    $0x20,%esp
                ap++;
    2ad7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2adb:	e9 d2 00 00 00       	jmp    2bb2 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2ae0:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2ae4:	75 46                	jne    2b2c <sprintf+0x178>
                s = (char*)*ap;
    2ae6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2ae9:	8b 00                	mov    (%eax),%eax
    2aeb:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2aee:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2af2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2af6:	75 25                	jne    2b1d <sprintf+0x169>
                    s = "(null)";
    2af8:	c7 45 f4 90 2d 00 00 	movl   $0x2d90,-0xc(%ebp)
                while(*s != 0){
    2aff:	eb 1c                	jmp    2b1d <sprintf+0x169>
                    dst[j++] = *s;
    2b01:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2b04:	8d 50 01             	lea    0x1(%eax),%edx
    2b07:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2b0a:	89 c2                	mov    %eax,%edx
    2b0c:	8b 45 08             	mov    0x8(%ebp),%eax
    2b0f:	01 c2                	add    %eax,%edx
    2b11:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2b14:	0f b6 00             	movzbl (%eax),%eax
    2b17:	88 02                	mov    %al,(%edx)
                    s++;
    2b19:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2b20:	0f b6 00             	movzbl (%eax),%eax
    2b23:	84 c0                	test   %al,%al
    2b25:	75 da                	jne    2b01 <sprintf+0x14d>
    2b27:	e9 86 00 00 00       	jmp    2bb2 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2b2c:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2b30:	75 1d                	jne    2b4f <sprintf+0x19b>
                dst[j++] = *ap;
    2b32:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2b35:	8d 50 01             	lea    0x1(%eax),%edx
    2b38:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2b3b:	89 c2                	mov    %eax,%edx
    2b3d:	8b 45 08             	mov    0x8(%ebp),%eax
    2b40:	01 c2                	add    %eax,%edx
    2b42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2b45:	8b 00                	mov    (%eax),%eax
    2b47:	88 02                	mov    %al,(%edx)
                ap++;
    2b49:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2b4d:	eb 63                	jmp    2bb2 <sprintf+0x1fe>
            } else if(c == '%'){
    2b4f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2b53:	75 17                	jne    2b6c <sprintf+0x1b8>
                dst[j++] = c;
    2b55:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2b58:	8d 50 01             	lea    0x1(%eax),%edx
    2b5b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2b5e:	89 c2                	mov    %eax,%edx
    2b60:	8b 45 08             	mov    0x8(%ebp),%eax
    2b63:	01 d0                	add    %edx,%eax
    2b65:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2b68:	88 10                	mov    %dl,(%eax)
    2b6a:	eb 46                	jmp    2bb2 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2b6c:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2b70:	7e 18                	jle    2b8a <sprintf+0x1d6>
    2b72:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2b76:	7f 12                	jg     2b8a <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2b78:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2b7b:	8d 50 01             	lea    0x1(%eax),%edx
    2b7e:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2b81:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2b84:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2b88:	eb 2f                	jmp    2bb9 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2b8a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2b8d:	8d 50 01             	lea    0x1(%eax),%edx
    2b90:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2b93:	89 c2                	mov    %eax,%edx
    2b95:	8b 45 08             	mov    0x8(%ebp),%eax
    2b98:	01 d0                	add    %edx,%eax
    2b9a:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2b9d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2ba0:	8d 50 01             	lea    0x1(%eax),%edx
    2ba3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2ba6:	89 c2                	mov    %eax,%edx
    2ba8:	8b 45 08             	mov    0x8(%ebp),%eax
    2bab:	01 d0                	add    %edx,%eax
    2bad:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2bb0:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2bb2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2bb9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2bbd:	8b 55 0c             	mov    0xc(%ebp),%edx
    2bc0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2bc3:	01 d0                	add    %edx,%eax
    2bc5:	0f b6 00             	movzbl (%eax),%eax
    2bc8:	84 c0                	test   %al,%al
    2bca:	0f 85 14 fe ff ff    	jne    29e4 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2bd0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2bd3:	8d 50 01             	lea    0x1(%eax),%edx
    2bd6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2bd9:	89 c2                	mov    %eax,%edx
    2bdb:	8b 45 08             	mov    0x8(%ebp),%eax
    2bde:	01 d0                	add    %edx,%eax
    2be0:	c6 00 00             	movb   $0x0,(%eax)
}
    2be3:	90                   	nop
    2be4:	c9                   	leave  
    2be5:	c3                   	ret    
