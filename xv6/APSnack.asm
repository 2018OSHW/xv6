
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
printf(1,"current_direction:%d\n",current_direction);
      d7:	a1 80 78 00 00       	mov    0x7880,%eax
      dc:	83 ec 04             	sub    $0x4,%esp
      df:	50                   	push   %eax
      e0:	68 b8 2a 00 00       	push   $0x2ab8
      e5:	6a 01                	push   $0x1
      e7:	e8 08 0c 00 00       	call   cf4 <printf>
      ec:	83 c4 10             	add    $0x10,%esp
	my_block[head.x][head.y] = current_direction;//head
      ef:	8b 0d cc 78 00 00    	mov    0x78cc,%ecx
      f5:	8b 15 d0 78 00 00    	mov    0x78d0,%edx
      fb:	a1 80 78 00 00       	mov    0x7880,%eax
     100:	6b c9 37             	imul   $0x37,%ecx,%ecx
     103:	01 ca                	add    %ecx,%edx
     105:	89 04 95 c0 33 00 00 	mov    %eax,0x33c0(,%edx,4)
	head  = nextpoint(head,current_direction);
     10c:	8b 15 80 78 00 00    	mov    0x7880,%edx
     112:	8d 45 e0             	lea    -0x20(%ebp),%eax
     115:	52                   	push   %edx
     116:	ff 35 d0 78 00 00    	pushl  0x78d0
     11c:	ff 35 cc 78 00 00    	pushl  0x78cc
     122:	50                   	push   %eax
     123:	e8 1d ff ff ff       	call   45 <nextpoint>
     128:	83 c4 0c             	add    $0xc,%esp
     12b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     12e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     131:	a3 cc 78 00 00       	mov    %eax,0x78cc
     136:	89 15 d0 78 00 00    	mov    %edx,0x78d0
	my_block[head.x][head.y] = current_direction;//head
     13c:	8b 0d cc 78 00 00    	mov    0x78cc,%ecx
     142:	8b 15 d0 78 00 00    	mov    0x78d0,%edx
     148:	a1 80 78 00 00       	mov    0x7880,%eax
     14d:	6b c9 37             	imul   $0x37,%ecx,%ecx
     150:	01 ca                	add    %ecx,%edx
     152:	89 04 95 c0 33 00 00 	mov    %eax,0x33c0(,%edx,4)
	if (my_food[head.x][head.y] == 0)
     159:	8b 15 cc 78 00 00    	mov    0x78cc,%edx
     15f:	a1 d0 78 00 00       	mov    0x78d0,%eax
     164:	6b d2 37             	imul   $0x37,%edx,%edx
     167:	01 d0                	add    %edx,%eax
     169:	05 e0 78 00 00       	add    $0x78e0,%eax
     16e:	0f b6 00             	movzbl (%eax),%eax
     171:	84 c0                	test   %al,%al
     173:	75 63                	jne    1d8 <Move+0x107>
	{
		int tem = my_block[tail.x][tail.y];
     175:	8b 15 b0 78 00 00    	mov    0x78b0,%edx
     17b:	a1 b4 78 00 00       	mov    0x78b4,%eax
     180:	6b d2 37             	imul   $0x37,%edx,%edx
     183:	01 d0                	add    %edx,%eax
     185:	8b 04 85 c0 33 00 00 	mov    0x33c0(,%eax,4),%eax
     18c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		my_block[tail.x][tail.y] = NoDir;
     18f:	8b 15 b0 78 00 00    	mov    0x78b0,%edx
     195:	a1 b4 78 00 00       	mov    0x78b4,%eax
     19a:	6b d2 37             	imul   $0x37,%edx,%edx
     19d:	01 d0                	add    %edx,%eax
     19f:	c7 04 85 c0 33 00 00 	movl   $0x0,0x33c0(,%eax,4)
     1a6:	00 00 00 00 
		tail = nextpoint(tail,tem);	
     1aa:	8d 45 e0             	lea    -0x20(%ebp),%eax
     1ad:	ff 75 f4             	pushl  -0xc(%ebp)
     1b0:	ff 35 b4 78 00 00    	pushl  0x78b4
     1b6:	ff 35 b0 78 00 00    	pushl  0x78b0
     1bc:	50                   	push   %eax
     1bd:	e8 83 fe ff ff       	call   45 <nextpoint>
     1c2:	83 c4 0c             	add    $0xc,%esp
     1c5:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     1cb:	a3 b0 78 00 00       	mov    %eax,0x78b0
     1d0:	89 15 b4 78 00 00    	mov    %edx,0x78b4
     1d6:	eb 1d                	jmp    1f5 <Move+0x124>
	}//no food
	else
	{
		my_food[head.x][head.y] = 0;
     1d8:	8b 15 cc 78 00 00    	mov    0x78cc,%edx
     1de:	a1 d0 78 00 00       	mov    0x78d0,%eax
     1e3:	6b d2 37             	imul   $0x37,%edx,%edx
     1e6:	01 d0                	add    %edx,%eax
     1e8:	05 e0 78 00 00       	add    $0x78e0,%eax
     1ed:	c6 00 00             	movb   $0x0,(%eax)
		updateFood();
     1f0:	e8 03 05 00 00       	call   6f8 <updateFood>
	}
	current_direction_copy = current_direction;
     1f5:	a1 80 78 00 00       	mov    0x7880,%eax
     1fa:	a3 d4 78 00 00       	mov    %eax,0x78d4

//tail
}
     1ff:	90                   	nop
     200:	c9                   	leave  
     201:	c3                   	ret    

00000202 <main>:



int main(void)
{
     202:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     206:	83 e4 f0             	and    $0xfffffff0,%esp
     209:	ff 71 fc             	pushl  -0x4(%ecx)
     20c:	55                   	push   %ebp
     20d:	89 e5                	mov    %esp,%ebp
     20f:	51                   	push   %ecx
     210:	83 ec 14             	sub    $0x14,%esp
	
	AHwnd hwnd = APCreateWindow("snack",False,0);
     213:	83 ec 04             	sub    $0x4,%esp
     216:	6a 00                	push   $0x0
     218:	6a 00                	push   $0x0
     21a:	68 ce 2a 00 00       	push   $0x2ace
     21f:	e8 58 1a 00 00       	call   1c7c <APCreateWindow>
     224:	83 c4 10             	add    $0x10,%esp
     227:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf(1,"snack created.\n");
     22a:	83 ec 08             	sub    $0x8,%esp
     22d:	68 d4 2a 00 00       	push   $0x2ad4
     232:	6a 01                	push   $0x1
     234:	e8 bb 0a 00 00       	call   cf4 <printf>
     239:	83 c4 10             	add    $0x10,%esp
	APWndExec(hwnd,wndProc);
     23c:	83 ec 08             	sub    $0x8,%esp
     23f:	68 16 08 00 00       	push   $0x816
     244:	ff 75 f4             	pushl  -0xc(%ebp)
     247:	e8 52 1d 00 00       	call   1f9e <APWndExec>
     24c:	83 c4 10             	add    $0x10,%esp
	exit();
     24f:	e8 f1 08 00 00       	call   b45 <exit>

00000254 <init>:
}

void init(AHwnd hwnd)
{
     254:	55                   	push   %ebp
     255:	89 e5                	mov    %esp,%ebp
     257:	83 ec 28             	sub    $0x28,%esp
	random(10);
     25a:	83 ec 0c             	sub    $0xc,%esp
     25d:	6a 0a                	push   $0xa
     25f:	e8 da 24 00 00       	call   273e <random>
     264:	83 c4 10             	add    $0x10,%esp
	for (int i = 0;i < BLOCK_NUM_X;i++)
     267:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     26e:	eb 40                	jmp    2b0 <init+0x5c>
	{
		for (int j = 0;j <BLOCK_NUM_Y;j++)
     270:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     277:	eb 2d                	jmp    2a6 <init+0x52>
		{
			my_block[i][j] = NoDir;
     279:	8b 45 f4             	mov    -0xc(%ebp),%eax
     27c:	6b d0 37             	imul   $0x37,%eax,%edx
     27f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     282:	01 d0                	add    %edx,%eax
     284:	c7 04 85 c0 33 00 00 	movl   $0x0,0x33c0(,%eax,4)
     28b:	00 00 00 00 
			my_food[i][j] = 0;
     28f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     292:	6b d0 37             	imul   $0x37,%eax,%edx
     295:	8b 45 f0             	mov    -0x10(%ebp),%eax
     298:	01 d0                	add    %edx,%eax
     29a:	05 e0 78 00 00       	add    $0x78e0,%eax
     29f:	c6 00 00             	movb   $0x0,(%eax)
void init(AHwnd hwnd)
{
	random(10);
	for (int i = 0;i < BLOCK_NUM_X;i++)
	{
		for (int j = 0;j <BLOCK_NUM_Y;j++)
     2a2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     2a6:	83 7d f0 36          	cmpl   $0x36,-0x10(%ebp)
     2aa:	7e cd                	jle    279 <init+0x25>
}

void init(AHwnd hwnd)
{
	random(10);
	for (int i = 0;i < BLOCK_NUM_X;i++)
     2ac:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     2b0:	83 7d f4 4f          	cmpl   $0x4f,-0xc(%ebp)
     2b4:	7e ba                	jle    270 <init+0x1c>
			my_food[i][j] = 0;

		}

	}
	for (int i = 0;i < 5;i++)
     2b6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     2bd:	eb 18                	jmp    2d7 <init+0x83>
	{
		my_block[i][0] = Right;
     2bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
     2c2:	69 c0 dc 00 00 00    	imul   $0xdc,%eax,%eax
     2c8:	05 c0 33 00 00       	add    $0x33c0,%eax
     2cd:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
			my_food[i][j] = 0;

		}

	}
	for (int i = 0;i < 5;i++)
     2d3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     2d7:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     2db:	7e e2                	jle    2bf <init+0x6b>
	{
		my_block[i][0] = Right;
	}
	updateFood();updateFood();updateFood();updateFood();updateFood();
     2dd:	e8 16 04 00 00       	call   6f8 <updateFood>
     2e2:	e8 11 04 00 00       	call   6f8 <updateFood>
     2e7:	e8 0c 04 00 00       	call   6f8 <updateFood>
     2ec:	e8 07 04 00 00       	call   6f8 <updateFood>
     2f1:	e8 02 04 00 00       	call   6f8 <updateFood>
	head.x = 4;
     2f6:	c7 05 cc 78 00 00 04 	movl   $0x4,0x78cc
     2fd:	00 00 00 
	head.y = 0;
     300:	c7 05 d0 78 00 00 00 	movl   $0x0,0x78d0
     307:	00 00 00 
	tail.x = tail.y = 0;
     30a:	c7 05 b4 78 00 00 00 	movl   $0x0,0x78b4
     311:	00 00 00 
     314:	a1 b4 78 00 00       	mov    0x78b4,%eax
     319:	a3 b0 78 00 00       	mov    %eax,0x78b0
	current_direction = current_direction_copy = Right;
     31e:	c7 05 d4 78 00 00 04 	movl   $0x4,0x78d4
     325:	00 00 00 
     328:	a1 d4 78 00 00       	mov    0x78d4,%eax
     32d:	a3 80 78 00 00       	mov    %eax,0x7880
    	status = Run;
     332:	c7 05 40 8a 00 00 00 	movl   $0x0,0x8a40
     339:	00 00 00 
	updateFood();
     33c:	e8 b7 03 00 00       	call   6f8 <updateFood>
	AMessage msg;
	msg.type = MSG_PAINT;
     341:	c7 45 e0 03 00 00 00 	movl   $0x3,-0x20(%ebp)
	msg.param = 0;
     348:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	setupTimer(hwnd,1,800);
     34f:	83 ec 04             	sub    $0x4,%esp
     352:	68 20 03 00 00       	push   $0x320
     357:	6a 01                	push   $0x1
     359:	ff 75 08             	pushl  0x8(%ebp)
     35c:	e8 ac 08 00 00       	call   c0d <setupTimer>
     361:	83 c4 10             	add    $0x10,%esp
	APSendMessage(hwnd,msg);
     364:	ff 75 e8             	pushl  -0x18(%ebp)
     367:	ff 75 e4             	pushl  -0x1c(%ebp)
     36a:	ff 75 e0             	pushl  -0x20(%ebp)
     36d:	ff 75 08             	pushl  0x8(%ebp)
     370:	e8 e9 18 00 00       	call   1c5e <APSendMessage>
     375:	83 c4 10             	add    $0x10,%esp

}
     378:	90                   	nop
     379:	c9                   	leave  
     37a:	c3                   	ret    

0000037b <timerUpdate>:

void timerUpdate(AHwnd hwnd)
{
     37b:	55                   	push   %ebp
     37c:	89 e5                	mov    %esp,%ebp
     37e:	83 ec 08             	sub    $0x8,%esp
	if (Is_Dead())
     381:	e8 04 03 00 00       	call   68a <Is_Dead>
     386:	84 c0                	test   %al,%al
     388:	74 2e                	je     3b8 <timerUpdate+0x3d>
	{
		status = Dead;
     38a:	c7 05 40 8a 00 00 02 	movl   $0x2,0x8a40
     391:	00 00 00 
		printf(1,"Dead!");
     394:	83 ec 08             	sub    $0x8,%esp
     397:	68 e4 2a 00 00       	push   $0x2ae4
     39c:	6a 01                	push   $0x1
     39e:	e8 51 09 00 00       	call   cf4 <printf>
     3a3:	83 c4 10             	add    $0x10,%esp
		deleteTimer(hwnd,1);
     3a6:	83 ec 08             	sub    $0x8,%esp
     3a9:	6a 01                	push   $0x1
     3ab:	ff 75 08             	pushl  0x8(%ebp)
     3ae:	e8 62 08 00 00       	call   c15 <deleteTimer>
     3b3:	83 c4 10             	add    $0x10,%esp
	else
	{
		Move();
	}

}
     3b6:	eb 05                	jmp    3bd <timerUpdate+0x42>
		printf(1,"Dead!");
		deleteTimer(hwnd,1);
	}
	else
	{
		Move();
     3b8:	e8 14 fd ff ff       	call   d1 <Move>
	}

}
     3bd:	90                   	nop
     3be:	c9                   	leave  
     3bf:	c3                   	ret    

000003c0 <keyDown>:

void keyDown(AHwnd hwnd,AMessage msg)
{
     3c0:	55                   	push   %ebp
     3c1:	89 e5                	mov    %esp,%ebp
     3c3:	83 ec 08             	sub    $0x8,%esp
printf(1,"msg.param received:%d\n",msg.param);
     3c6:	8b 45 10             	mov    0x10(%ebp),%eax
     3c9:	83 ec 04             	sub    $0x4,%esp
     3cc:	50                   	push   %eax
     3cd:	68 ea 2a 00 00       	push   $0x2aea
     3d2:	6a 01                	push   $0x1
     3d4:	e8 1b 09 00 00       	call   cf4 <printf>
     3d9:	83 c4 10             	add    $0x10,%esp
switch (msg.param)
     3dc:	8b 45 10             	mov    0x10(%ebp),%eax
     3df:	83 f8 05             	cmp    $0x5,%eax
     3e2:	0f 87 21 01 00 00    	ja     509 <keyDown+0x149>
     3e8:	8b 04 85 44 2b 00 00 	mov    0x2b44(,%eax,4),%eax
     3ef:	ff e0                	jmp    *%eax
{
case VK_UP:
printf(1,"Up Key pressed");
     3f1:	83 ec 08             	sub    $0x8,%esp
     3f4:	68 01 2b 00 00       	push   $0x2b01
     3f9:	6a 01                	push   $0x1
     3fb:	e8 f4 08 00 00       	call   cf4 <printf>
     400:	83 c4 10             	add    $0x10,%esp
if (current_direction_copy == Left || current_direction_copy == Right)
     403:	a1 d4 78 00 00       	mov    0x78d4,%eax
     408:	83 f8 03             	cmp    $0x3,%eax
     40b:	74 0e                	je     41b <keyDown+0x5b>
     40d:	a1 d4 78 00 00       	mov    0x78d4,%eax
     412:	83 f8 04             	cmp    $0x4,%eax
     415:	0f 85 f1 00 00 00    	jne    50c <keyDown+0x14c>
	current_direction = Up;
     41b:	c7 05 80 78 00 00 01 	movl   $0x1,0x7880
     422:	00 00 00 
break;
     425:	e9 e2 00 00 00       	jmp    50c <keyDown+0x14c>
case VK_DOWN:
printf(1,"Down Key pressed");
     42a:	83 ec 08             	sub    $0x8,%esp
     42d:	68 10 2b 00 00       	push   $0x2b10
     432:	6a 01                	push   $0x1
     434:	e8 bb 08 00 00       	call   cf4 <printf>
     439:	83 c4 10             	add    $0x10,%esp
if (current_direction_copy == Left || current_direction_copy == Right)
     43c:	a1 d4 78 00 00       	mov    0x78d4,%eax
     441:	83 f8 03             	cmp    $0x3,%eax
     444:	74 0e                	je     454 <keyDown+0x94>
     446:	a1 d4 78 00 00       	mov    0x78d4,%eax
     44b:	83 f8 04             	cmp    $0x4,%eax
     44e:	0f 85 bb 00 00 00    	jne    50f <keyDown+0x14f>
	current_direction = Down;
     454:	c7 05 80 78 00 00 02 	movl   $0x2,0x7880
     45b:	00 00 00 
break;
     45e:	e9 ac 00 00 00       	jmp    50f <keyDown+0x14f>
case VK_LEFT:
printf(1,"Left Key pressed");
     463:	83 ec 08             	sub    $0x8,%esp
     466:	68 21 2b 00 00       	push   $0x2b21
     46b:	6a 01                	push   $0x1
     46d:	e8 82 08 00 00       	call   cf4 <printf>
     472:	83 c4 10             	add    $0x10,%esp
if (current_direction_copy == Up || current_direction_copy == Down)
     475:	a1 d4 78 00 00       	mov    0x78d4,%eax
     47a:	83 f8 01             	cmp    $0x1,%eax
     47d:	74 0e                	je     48d <keyDown+0xcd>
     47f:	a1 d4 78 00 00       	mov    0x78d4,%eax
     484:	83 f8 02             	cmp    $0x2,%eax
     487:	0f 85 85 00 00 00    	jne    512 <keyDown+0x152>
	current_direction = Left;
     48d:	c7 05 80 78 00 00 03 	movl   $0x3,0x7880
     494:	00 00 00 
break;
     497:	eb 79                	jmp    512 <keyDown+0x152>
case VK_RIGHT:
printf(1,"Right Key pressed");
     499:	83 ec 08             	sub    $0x8,%esp
     49c:	68 32 2b 00 00       	push   $0x2b32
     4a1:	6a 01                	push   $0x1
     4a3:	e8 4c 08 00 00       	call   cf4 <printf>
     4a8:	83 c4 10             	add    $0x10,%esp
if (current_direction_copy == Up || current_direction_copy == Down)
     4ab:	a1 d4 78 00 00       	mov    0x78d4,%eax
     4b0:	83 f8 01             	cmp    $0x1,%eax
     4b3:	74 0a                	je     4bf <keyDown+0xff>
     4b5:	a1 d4 78 00 00       	mov    0x78d4,%eax
     4ba:	83 f8 02             	cmp    $0x2,%eax
     4bd:	75 56                	jne    515 <keyDown+0x155>
	current_direction = Right;
     4bf:	c7 05 80 78 00 00 04 	movl   $0x4,0x7880
     4c6:	00 00 00 
break;
     4c9:	eb 4a                	jmp    515 <keyDown+0x155>
case VK_ESC:
switch(status)
     4cb:	a1 40 8a 00 00       	mov    0x8a40,%eax
     4d0:	83 f8 01             	cmp    $0x1,%eax
     4d3:	74 17                	je     4ec <keyDown+0x12c>
     4d5:	83 f8 02             	cmp    $0x2,%eax
     4d8:	74 1e                	je     4f8 <keyDown+0x138>
     4da:	85 c0                	test   %eax,%eax
     4dc:	74 02                	je     4e0 <keyDown+0x120>
break;
case Dead:
init(hwnd);
break;
default:
break;
     4de:	eb 27                	jmp    507 <keyDown+0x147>
break;
case VK_ESC:
switch(status)
{
case Run:
status = Pause;
     4e0:	c7 05 40 8a 00 00 01 	movl   $0x1,0x8a40
     4e7:	00 00 00 
break;
     4ea:	eb 1b                	jmp    507 <keyDown+0x147>
case Pause:
status = Run;
     4ec:	c7 05 40 8a 00 00 00 	movl   $0x0,0x8a40
     4f3:	00 00 00 
break;
     4f6:	eb 0f                	jmp    507 <keyDown+0x147>
case Dead:
init(hwnd);
     4f8:	83 ec 0c             	sub    $0xc,%esp
     4fb:	ff 75 08             	pushl  0x8(%ebp)
     4fe:	e8 51 fd ff ff       	call   254 <init>
     503:	83 c4 10             	add    $0x10,%esp
break;
     506:	90                   	nop
default:
break;

}
break;
     507:	eb 0d                	jmp    516 <keyDown+0x156>
default:
break;
     509:	90                   	nop
     50a:	eb 0a                	jmp    516 <keyDown+0x156>
{
case VK_UP:
printf(1,"Up Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
	current_direction = Up;
break;
     50c:	90                   	nop
     50d:	eb 07                	jmp    516 <keyDown+0x156>
case VK_DOWN:
printf(1,"Down Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
	current_direction = Down;
break;
     50f:	90                   	nop
     510:	eb 04                	jmp    516 <keyDown+0x156>
case VK_LEFT:
printf(1,"Left Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
	current_direction = Left;
break;
     512:	90                   	nop
     513:	eb 01                	jmp    516 <keyDown+0x156>
case VK_RIGHT:
printf(1,"Right Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
	current_direction = Right;
break;
     515:	90                   	nop
default:
break;

}

}
     516:	90                   	nop
     517:	c9                   	leave  
     518:	c3                   	ret    

00000519 <draw>:

void draw(AHwnd hwnd)
{
     519:	55                   	push   %ebp
     51a:	89 e5                	mov    %esp,%ebp
     51c:	83 ec 28             	sub    $0x28,%esp
	AHdc hdc = &(hwnd->Dc);
     51f:	8b 45 08             	mov    0x8(%ebp),%eax
     522:	83 c0 3c             	add    $0x3c,%eax
     525:	89 45 ec             	mov    %eax,-0x14(%ebp)
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
     528:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     52f:	e9 49 01 00 00       	jmp    67d <draw+0x164>
	{

		for (int j = 0;j < BLOCK_NUM_Y;j++)
     534:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     53b:	e9 2f 01 00 00       	jmp    66f <draw+0x156>
		{
			if (my_block[i][j] == NoDir)
     540:	8b 45 f4             	mov    -0xc(%ebp),%eax
     543:	6b d0 37             	imul   $0x37,%eax,%edx
     546:	8b 45 f0             	mov    -0x10(%ebp),%eax
     549:	01 d0                	add    %edx,%eax
     54b:	8b 04 85 c0 33 00 00 	mov    0x33c0(,%eax,4),%eax
     552:	85 c0                	test   %eax,%eax
     554:	75 26                	jne    57c <draw+0x63>
			{
				brush.color = COLOR_BACK;
     556:	8d 45 d8             	lea    -0x28(%ebp),%eax
     559:	6a 00                	push   $0x0
     55b:	68 ff 00 00 00       	push   $0xff
     560:	6a 00                	push   $0x0
     562:	50                   	push   %eax
     563:	e8 98 fa ff ff       	call   0 <RGB>
     568:	83 c4 0c             	add    $0xc,%esp
     56b:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     56f:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     573:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     577:	88 45 eb             	mov    %al,-0x15(%ebp)
     57a:	eb 61                	jmp    5dd <draw+0xc4>

			}//background
			else
			{
				if (head.x == i && head.y == j)
     57c:	a1 cc 78 00 00       	mov    0x78cc,%eax
     581:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     584:	75 30                	jne    5b6 <draw+0x9d>
     586:	a1 d0 78 00 00       	mov    0x78d0,%eax
     58b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     58e:	75 26                	jne    5b6 <draw+0x9d>
					brush.color = COLOR_HEAD;
     590:	8d 45 d8             	lea    -0x28(%ebp),%eax
     593:	6a 00                	push   $0x0
     595:	68 80 00 00 00       	push   $0x80
     59a:	6a 00                	push   $0x0
     59c:	50                   	push   %eax
     59d:	e8 5e fa ff ff       	call   0 <RGB>
     5a2:	83 c4 0c             	add    $0xc,%esp
     5a5:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     5a9:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     5ad:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     5b1:	88 45 eb             	mov    %al,-0x15(%ebp)
     5b4:	eb 27                	jmp    5dd <draw+0xc4>
				else
					brush.color = COLOR_BODY;
     5b6:	8d 45 d8             	lea    -0x28(%ebp),%eax
     5b9:	68 ff 00 00 00       	push   $0xff
     5be:	68 ff 00 00 00       	push   $0xff
     5c3:	6a 00                	push   $0x0
     5c5:	50                   	push   %eax
     5c6:	e8 35 fa ff ff       	call   0 <RGB>
     5cb:	83 c4 0c             	add    $0xc,%esp
     5ce:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     5d2:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     5d6:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     5da:	88 45 eb             	mov    %al,-0x15(%ebp)
			}
			if (my_food[i][j] == 1)
     5dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e0:	6b d0 37             	imul   $0x37,%eax,%edx
     5e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5e6:	01 d0                	add    %edx,%eax
     5e8:	05 e0 78 00 00       	add    $0x78e0,%eax
     5ed:	0f b6 00             	movzbl (%eax),%eax
     5f0:	3c 01                	cmp    $0x1,%al
     5f2:	75 24                	jne    618 <draw+0xff>
			{
				brush.color = COLOR_FOOD;
     5f4:	8d 45 d8             	lea    -0x28(%ebp),%eax
     5f7:	6a 00                	push   $0x0
     5f9:	6a 00                	push   $0x0
     5fb:	68 ff 00 00 00       	push   $0xff
     600:	50                   	push   %eax
     601:	e8 fa f9 ff ff       	call   0 <RGB>
     606:	83 c4 0c             	add    $0xc,%esp
     609:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     60d:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     611:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     615:	88 45 eb             	mov    %al,-0x15(%ebp)
			}
			APSetBrush(hdc,brush);
     618:	8d 55 d8             	lea    -0x28(%ebp),%edx
     61b:	83 ec 04             	sub    $0x4,%esp
     61e:	83 ec 04             	sub    $0x4,%esp
     621:	89 e0                	mov    %esp,%eax
     623:	0f b7 4d e9          	movzwl -0x17(%ebp),%ecx
     627:	66 89 08             	mov    %cx,(%eax)
     62a:	0f b6 4d eb          	movzbl -0x15(%ebp),%ecx
     62e:	88 48 02             	mov    %cl,0x2(%eax)
     631:	ff 75 ec             	pushl  -0x14(%ebp)
     634:	52                   	push   %edx
     635:	e8 48 0e 00 00       	call   1482 <APSetBrush>
     63a:	83 c4 0c             	add    $0xc,%esp
			APDrawRect(hdc,i * BLOCK_WIDTH,j*BLOCK_WIDTH,BLOCK_WIDTH,BLOCK_WIDTH);
     63d:	8b 55 f0             	mov    -0x10(%ebp),%edx
     640:	89 d0                	mov    %edx,%eax
     642:	c1 e0 02             	shl    $0x2,%eax
     645:	01 d0                	add    %edx,%eax
     647:	01 c0                	add    %eax,%eax
     649:	89 c1                	mov    %eax,%ecx
     64b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     64e:	89 d0                	mov    %edx,%eax
     650:	c1 e0 02             	shl    $0x2,%eax
     653:	01 d0                	add    %edx,%eax
     655:	01 c0                	add    %eax,%eax
     657:	83 ec 0c             	sub    $0xc,%esp
     65a:	6a 0a                	push   $0xa
     65c:	6a 0a                	push   $0xa
     65e:	51                   	push   %ecx
     65f:	50                   	push   %eax
     660:	ff 75 ec             	pushl  -0x14(%ebp)
     663:	e8 02 12 00 00       	call   186a <APDrawRect>
     668:	83 c4 20             	add    $0x20,%esp
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
	{

		for (int j = 0;j < BLOCK_NUM_Y;j++)
     66b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     66f:	83 7d f0 36          	cmpl   $0x36,-0x10(%ebp)
     673:	0f 8e c7 fe ff ff    	jle    540 <draw+0x27>
void draw(AHwnd hwnd)
{
	AHdc hdc = &(hwnd->Dc);
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
     679:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     67d:	83 7d f4 4f          	cmpl   $0x4f,-0xc(%ebp)
     681:	0f 8e ad fe ff ff    	jle    534 <draw+0x1b>
			}
			APSetBrush(hdc,brush);
			APDrawRect(hdc,i * BLOCK_WIDTH,j*BLOCK_WIDTH,BLOCK_WIDTH,BLOCK_WIDTH);
		}
	}
}
     687:	90                   	nop
     688:	c9                   	leave  
     689:	c3                   	ret    

0000068a <Is_Dead>:

bool Is_Dead()
{
     68a:	55                   	push   %ebp
     68b:	89 e5                	mov    %esp,%ebp
     68d:	83 ec 10             	sub    $0x10,%esp
	APoint p = nextpoint(head,current_direction);
     690:	8b 15 80 78 00 00    	mov    0x7880,%edx
     696:	8d 45 f8             	lea    -0x8(%ebp),%eax
     699:	52                   	push   %edx
     69a:	ff 35 d0 78 00 00    	pushl  0x78d0
     6a0:	ff 35 cc 78 00 00    	pushl  0x78cc
     6a6:	50                   	push   %eax
     6a7:	e8 99 f9 ff ff       	call   45 <nextpoint>
     6ac:	83 c4 0c             	add    $0xc,%esp
    if (p.x >= BLOCK_NUM_X || p.y > BLOCK_NUM_Y || p.x < 0 || p.y < 0)
     6af:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b2:	83 f8 4f             	cmp    $0x4f,%eax
     6b5:	7f 16                	jg     6cd <Is_Dead+0x43>
     6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ba:	83 f8 37             	cmp    $0x37,%eax
     6bd:	7f 0e                	jg     6cd <Is_Dead+0x43>
     6bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c2:	85 c0                	test   %eax,%eax
     6c4:	78 07                	js     6cd <Is_Dead+0x43>
     6c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c9:	85 c0                	test   %eax,%eax
     6cb:	79 07                	jns    6d4 <Is_Dead+0x4a>
        return True;
     6cd:	b8 01 00 00 00       	mov    $0x1,%eax
     6d2:	eb 22                	jmp    6f6 <Is_Dead+0x6c>
	if (my_block[p.x][p.y] != NoDir)
     6d4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6da:	6b d2 37             	imul   $0x37,%edx,%edx
     6dd:	01 d0                	add    %edx,%eax
     6df:	8b 04 85 c0 33 00 00 	mov    0x33c0(,%eax,4),%eax
     6e6:	85 c0                	test   %eax,%eax
     6e8:	74 07                	je     6f1 <Is_Dead+0x67>
        return True;
     6ea:	b8 01 00 00 00       	mov    $0x1,%eax
     6ef:	eb 05                	jmp    6f6 <Is_Dead+0x6c>
    else
        return False;
     6f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
     6f6:	c9                   	leave  
     6f7:	c3                   	ret    

000006f8 <updateFood>:

bool updateFood()
{
     6f8:	55                   	push   %ebp
     6f9:	89 e5                	mov    %esp,%ebp
     6fb:	83 ec 28             	sub    $0x28,%esp
bool sta = false;
     6fe:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
for (int i = 0;i < BLOCK_NUM_X;i++)
     702:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     709:	eb 50                	jmp    75b <updateFood+0x63>
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
     70b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     712:	eb 37                	jmp    74b <updateFood+0x53>
	{
		if (my_block[i][j] == NoDir && my_food[i][j] == NoDir)
     714:	8b 45 f0             	mov    -0x10(%ebp),%eax
     717:	6b d0 37             	imul   $0x37,%eax,%edx
     71a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     71d:	01 d0                	add    %edx,%eax
     71f:	8b 04 85 c0 33 00 00 	mov    0x33c0(,%eax,4),%eax
     726:	85 c0                	test   %eax,%eax
     728:	75 1d                	jne    747 <updateFood+0x4f>
     72a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     72d:	6b d0 37             	imul   $0x37,%eax,%edx
     730:	8b 45 ec             	mov    -0x14(%ebp),%eax
     733:	01 d0                	add    %edx,%eax
     735:	05 e0 78 00 00       	add    $0x78e0,%eax
     73a:	0f b6 00             	movzbl (%eax),%eax
     73d:	84 c0                	test   %al,%al
     73f:	75 06                	jne    747 <updateFood+0x4f>
		{
			sta = true;
     741:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
			break;
     745:	eb 0a                	jmp    751 <updateFood+0x59>
bool updateFood()
{
bool sta = false;
for (int i = 0;i < BLOCK_NUM_X;i++)
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
     747:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     74b:	83 7d ec 36          	cmpl   $0x36,-0x14(%ebp)
     74f:	7e c3                	jle    714 <updateFood+0x1c>
		{
			sta = true;
			break;
		}
	}
	if (sta == true)
     751:	80 7d f7 01          	cmpb   $0x1,-0x9(%ebp)
     755:	74 0c                	je     763 <updateFood+0x6b>
}

bool updateFood()
{
bool sta = false;
for (int i = 0;i < BLOCK_NUM_X;i++)
     757:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     75b:	83 7d f0 4f          	cmpl   $0x4f,-0x10(%ebp)
     75f:	7e aa                	jle    70b <updateFood+0x13>
     761:	eb 01                	jmp    764 <updateFood+0x6c>
			break;
		}
	}
	if (sta == true)
	{
		break;
     763:	90                   	nop
	}
}
if (sta == false)
     764:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
     768:	75 09                	jne    773 <updateFood+0x7b>
{
return sta;
     76a:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
     76e:	e9 a1 00 00 00       	jmp    814 <updateFood+0x11c>
}
while(true)
{
int i = random(0) % BLOCK_NUM_X;
     773:	83 ec 0c             	sub    $0xc,%esp
     776:	6a 00                	push   $0x0
     778:	e8 c1 1f 00 00       	call   273e <random>
     77d:	83 c4 10             	add    $0x10,%esp
     780:	89 c1                	mov    %eax,%ecx
     782:	ba 67 66 66 66       	mov    $0x66666667,%edx
     787:	89 c8                	mov    %ecx,%eax
     789:	f7 ea                	imul   %edx
     78b:	c1 fa 05             	sar    $0x5,%edx
     78e:	89 c8                	mov    %ecx,%eax
     790:	c1 f8 1f             	sar    $0x1f,%eax
     793:	29 c2                	sub    %eax,%edx
     795:	89 d0                	mov    %edx,%eax
     797:	89 45 e8             	mov    %eax,-0x18(%ebp)
     79a:	8b 55 e8             	mov    -0x18(%ebp),%edx
     79d:	89 d0                	mov    %edx,%eax
     79f:	c1 e0 02             	shl    $0x2,%eax
     7a2:	01 d0                	add    %edx,%eax
     7a4:	c1 e0 04             	shl    $0x4,%eax
     7a7:	29 c1                	sub    %eax,%ecx
     7a9:	89 c8                	mov    %ecx,%eax
     7ab:	89 45 e8             	mov    %eax,-0x18(%ebp)
int j = random(0) % BLOCK_NUM_Y;
     7ae:	83 ec 0c             	sub    $0xc,%esp
     7b1:	6a 00                	push   $0x0
     7b3:	e8 86 1f 00 00       	call   273e <random>
     7b8:	83 c4 10             	add    $0x10,%esp
     7bb:	89 c1                	mov    %eax,%ecx
     7bd:	ba 95 20 4f 09       	mov    $0x94f2095,%edx
     7c2:	89 c8                	mov    %ecx,%eax
     7c4:	f7 ea                	imul   %edx
     7c6:	d1 fa                	sar    %edx
     7c8:	89 c8                	mov    %ecx,%eax
     7ca:	c1 f8 1f             	sar    $0x1f,%eax
     7cd:	29 c2                	sub    %eax,%edx
     7cf:	89 d0                	mov    %edx,%eax
     7d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     7d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7d7:	6b c0 37             	imul   $0x37,%eax,%eax
     7da:	29 c1                	sub    %eax,%ecx
     7dc:	89 c8                	mov    %ecx,%eax
     7de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
if (my_food[i][j] == 0)
     7e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7e4:	6b d0 37             	imul   $0x37,%eax,%edx
     7e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7ea:	01 d0                	add    %edx,%eax
     7ec:	05 e0 78 00 00       	add    $0x78e0,%eax
     7f1:	0f b6 00             	movzbl (%eax),%eax
     7f4:	84 c0                	test   %al,%al
     7f6:	0f 85 77 ff ff ff    	jne    773 <updateFood+0x7b>
{
	my_food[i][j] = 1;
     7fc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7ff:	6b d0 37             	imul   $0x37,%eax,%edx
     802:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     805:	01 d0                	add    %edx,%eax
     807:	05 e0 78 00 00       	add    $0x78e0,%eax
     80c:	c6 00 01             	movb   $0x1,(%eax)
return true;
     80f:	b8 01 00 00 00       	mov    $0x1,%eax
}

}


}
     814:	c9                   	leave  
     815:	c3                   	ret    

00000816 <wndProc>:

bool wndProc(AHwnd hwnd,AMessage msg)
{
     816:	55                   	push   %ebp
     817:	89 e5                	mov    %esp,%ebp
     819:	83 ec 28             	sub    $0x28,%esp
switch(msg.type)
     81c:	8b 45 0c             	mov    0xc(%ebp),%eax
     81f:	83 f8 03             	cmp    $0x3,%eax
     822:	0f 84 9f 00 00 00    	je     8c7 <wndProc+0xb1>
     828:	83 f8 03             	cmp    $0x3,%eax
     82b:	77 0a                	ja     837 <wndProc+0x21>
     82d:	83 f8 02             	cmp    $0x2,%eax
     830:	74 14                	je     846 <wndProc+0x30>
	break;
	case MSG_PAINT:
	draw(hwnd);
	break;
	default:
	break;
     832:	e9 a1 00 00 00       	jmp    8d8 <wndProc+0xc2>

}

bool wndProc(AHwnd hwnd,AMessage msg)
{
switch(msg.type)
     837:	83 f8 04             	cmp    $0x4,%eax
     83a:	74 3a                	je     876 <wndProc+0x60>
     83c:	83 f8 06             	cmp    $0x6,%eax
     83f:	74 70                	je     8b1 <wndProc+0x9b>
	break;
	case MSG_PAINT:
	draw(hwnd);
	break;
	default:
	break;
     841:	e9 92 00 00 00       	jmp    8d8 <wndProc+0xc2>
bool wndProc(AHwnd hwnd,AMessage msg)
{
switch(msg.type)
{
    case MSG_INIT:
    init(hwnd);
     846:	83 ec 0c             	sub    $0xc,%esp
     849:	ff 75 08             	pushl  0x8(%ebp)
     84c:	e8 03 fa ff ff       	call   254 <init>
     851:	83 c4 10             	add    $0x10,%esp
    AMessage ms;
    ms.type = MSG_PAINT;
     854:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
    APSendMessage(hwnd,ms);
     85b:	ff 75 f4             	pushl  -0xc(%ebp)
     85e:	ff 75 f0             	pushl  -0x10(%ebp)
     861:	ff 75 ec             	pushl  -0x14(%ebp)
     864:	ff 75 08             	pushl  0x8(%ebp)
     867:	e8 f2 13 00 00       	call   1c5e <APSendMessage>
     86c:	83 c4 10             	add    $0x10,%esp
    
    return False;
     86f:	b8 00 00 00 00       	mov    $0x0,%eax
     874:	eb 76                	jmp    8ec <wndProc+0xd6>
	case MSG_TIMEOUT:
if (status != Run)
     876:	a1 40 8a 00 00       	mov    0x8a40,%eax
     87b:	85 c0                	test   %eax,%eax
     87d:	75 58                	jne    8d7 <wndProc+0xc1>
	break;
	timerUpdate(hwnd);
     87f:	83 ec 0c             	sub    $0xc,%esp
     882:	ff 75 08             	pushl  0x8(%ebp)
     885:	e8 f1 fa ff ff       	call   37b <timerUpdate>
     88a:	83 c4 10             	add    $0x10,%esp
	AMessage msg1;
	msg1.type = MSG_PAINT;
     88d:	c7 45 e0 03 00 00 00 	movl   $0x3,-0x20(%ebp)
	msg1.param = 0;
     894:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	APSendMessage(hwnd,msg1);
     89b:	ff 75 e8             	pushl  -0x18(%ebp)
     89e:	ff 75 e4             	pushl  -0x1c(%ebp)
     8a1:	ff 75 e0             	pushl  -0x20(%ebp)
     8a4:	ff 75 08             	pushl  0x8(%ebp)
     8a7:	e8 b2 13 00 00       	call   1c5e <APSendMessage>
     8ac:	83 c4 10             	add    $0x10,%esp
	break;
     8af:	eb 27                	jmp    8d8 <wndProc+0xc2>
	case MSG_KEY_DOWN:
	keyDown(hwnd,msg);
     8b1:	ff 75 14             	pushl  0x14(%ebp)
     8b4:	ff 75 10             	pushl  0x10(%ebp)
     8b7:	ff 75 0c             	pushl  0xc(%ebp)
     8ba:	ff 75 08             	pushl  0x8(%ebp)
     8bd:	e8 fe fa ff ff       	call   3c0 <keyDown>
     8c2:	83 c4 10             	add    $0x10,%esp
	break;
     8c5:	eb 11                	jmp    8d8 <wndProc+0xc2>
	case MSG_PAINT:
	draw(hwnd);
     8c7:	83 ec 0c             	sub    $0xc,%esp
     8ca:	ff 75 08             	pushl  0x8(%ebp)
     8cd:	e8 47 fc ff ff       	call   519 <draw>
     8d2:	83 c4 10             	add    $0x10,%esp
	break;
     8d5:	eb 01                	jmp    8d8 <wndProc+0xc2>
    APSendMessage(hwnd,ms);
    
    return False;
	case MSG_TIMEOUT:
if (status != Run)
	break;
     8d7:	90                   	nop
	draw(hwnd);
	break;
	default:
	break;
}
return APWndProc(hwnd,msg);
     8d8:	ff 75 14             	pushl  0x14(%ebp)
     8db:	ff 75 10             	pushl  0x10(%ebp)
     8de:	ff 75 0c             	pushl  0xc(%ebp)
     8e1:	ff 75 08             	pushl  0x8(%ebp)
     8e4:	e8 f9 15 00 00       	call   1ee2 <APWndProc>
     8e9:	83 c4 10             	add    $0x10,%esp

}
     8ec:	c9                   	leave  
     8ed:	c3                   	ret    

000008ee <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     8ee:	55                   	push   %ebp
     8ef:	89 e5                	mov    %esp,%ebp
     8f1:	57                   	push   %edi
     8f2:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     8f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     8f6:	8b 55 10             	mov    0x10(%ebp),%edx
     8f9:	8b 45 0c             	mov    0xc(%ebp),%eax
     8fc:	89 cb                	mov    %ecx,%ebx
     8fe:	89 df                	mov    %ebx,%edi
     900:	89 d1                	mov    %edx,%ecx
     902:	fc                   	cld    
     903:	f3 aa                	rep stos %al,%es:(%edi)
     905:	89 ca                	mov    %ecx,%edx
     907:	89 fb                	mov    %edi,%ebx
     909:	89 5d 08             	mov    %ebx,0x8(%ebp)
     90c:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     90f:	90                   	nop
     910:	5b                   	pop    %ebx
     911:	5f                   	pop    %edi
     912:	5d                   	pop    %ebp
     913:	c3                   	ret    

00000914 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     914:	55                   	push   %ebp
     915:	89 e5                	mov    %esp,%ebp
     917:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     91a:	8b 45 08             	mov    0x8(%ebp),%eax
     91d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     920:	90                   	nop
     921:	8b 45 08             	mov    0x8(%ebp),%eax
     924:	8d 50 01             	lea    0x1(%eax),%edx
     927:	89 55 08             	mov    %edx,0x8(%ebp)
     92a:	8b 55 0c             	mov    0xc(%ebp),%edx
     92d:	8d 4a 01             	lea    0x1(%edx),%ecx
     930:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     933:	0f b6 12             	movzbl (%edx),%edx
     936:	88 10                	mov    %dl,(%eax)
     938:	0f b6 00             	movzbl (%eax),%eax
     93b:	84 c0                	test   %al,%al
     93d:	75 e2                	jne    921 <strcpy+0xd>
    ;
  return os;
     93f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     942:	c9                   	leave  
     943:	c3                   	ret    

00000944 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     944:	55                   	push   %ebp
     945:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     947:	eb 08                	jmp    951 <strcmp+0xd>
    p++, q++;
     949:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     94d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     951:	8b 45 08             	mov    0x8(%ebp),%eax
     954:	0f b6 00             	movzbl (%eax),%eax
     957:	84 c0                	test   %al,%al
     959:	74 10                	je     96b <strcmp+0x27>
     95b:	8b 45 08             	mov    0x8(%ebp),%eax
     95e:	0f b6 10             	movzbl (%eax),%edx
     961:	8b 45 0c             	mov    0xc(%ebp),%eax
     964:	0f b6 00             	movzbl (%eax),%eax
     967:	38 c2                	cmp    %al,%dl
     969:	74 de                	je     949 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     96b:	8b 45 08             	mov    0x8(%ebp),%eax
     96e:	0f b6 00             	movzbl (%eax),%eax
     971:	0f b6 d0             	movzbl %al,%edx
     974:	8b 45 0c             	mov    0xc(%ebp),%eax
     977:	0f b6 00             	movzbl (%eax),%eax
     97a:	0f b6 c0             	movzbl %al,%eax
     97d:	29 c2                	sub    %eax,%edx
     97f:	89 d0                	mov    %edx,%eax
}
     981:	5d                   	pop    %ebp
     982:	c3                   	ret    

00000983 <strlen>:

uint
strlen(char *s)
{
     983:	55                   	push   %ebp
     984:	89 e5                	mov    %esp,%ebp
     986:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     989:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     990:	eb 04                	jmp    996 <strlen+0x13>
     992:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     996:	8b 55 fc             	mov    -0x4(%ebp),%edx
     999:	8b 45 08             	mov    0x8(%ebp),%eax
     99c:	01 d0                	add    %edx,%eax
     99e:	0f b6 00             	movzbl (%eax),%eax
     9a1:	84 c0                	test   %al,%al
     9a3:	75 ed                	jne    992 <strlen+0xf>
    ;
  return n;
     9a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     9a8:	c9                   	leave  
     9a9:	c3                   	ret    

000009aa <memset>:

void*
memset(void *dst, int c, uint n)
{
     9aa:	55                   	push   %ebp
     9ab:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     9ad:	8b 45 10             	mov    0x10(%ebp),%eax
     9b0:	50                   	push   %eax
     9b1:	ff 75 0c             	pushl  0xc(%ebp)
     9b4:	ff 75 08             	pushl  0x8(%ebp)
     9b7:	e8 32 ff ff ff       	call   8ee <stosb>
     9bc:	83 c4 0c             	add    $0xc,%esp
  return dst;
     9bf:	8b 45 08             	mov    0x8(%ebp),%eax
}
     9c2:	c9                   	leave  
     9c3:	c3                   	ret    

000009c4 <strchr>:

char*
strchr(const char *s, char c)
{
     9c4:	55                   	push   %ebp
     9c5:	89 e5                	mov    %esp,%ebp
     9c7:	83 ec 04             	sub    $0x4,%esp
     9ca:	8b 45 0c             	mov    0xc(%ebp),%eax
     9cd:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     9d0:	eb 14                	jmp    9e6 <strchr+0x22>
    if(*s == c)
     9d2:	8b 45 08             	mov    0x8(%ebp),%eax
     9d5:	0f b6 00             	movzbl (%eax),%eax
     9d8:	3a 45 fc             	cmp    -0x4(%ebp),%al
     9db:	75 05                	jne    9e2 <strchr+0x1e>
      return (char*)s;
     9dd:	8b 45 08             	mov    0x8(%ebp),%eax
     9e0:	eb 13                	jmp    9f5 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     9e2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     9e6:	8b 45 08             	mov    0x8(%ebp),%eax
     9e9:	0f b6 00             	movzbl (%eax),%eax
     9ec:	84 c0                	test   %al,%al
     9ee:	75 e2                	jne    9d2 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     9f0:	b8 00 00 00 00       	mov    $0x0,%eax
}
     9f5:	c9                   	leave  
     9f6:	c3                   	ret    

000009f7 <gets>:

char*
gets(char *buf, int max)
{
     9f7:	55                   	push   %ebp
     9f8:	89 e5                	mov    %esp,%ebp
     9fa:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     9fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a04:	eb 42                	jmp    a48 <gets+0x51>
    cc = read(0, &c, 1);
     a06:	83 ec 04             	sub    $0x4,%esp
     a09:	6a 01                	push   $0x1
     a0b:	8d 45 ef             	lea    -0x11(%ebp),%eax
     a0e:	50                   	push   %eax
     a0f:	6a 00                	push   $0x0
     a11:	e8 47 01 00 00       	call   b5d <read>
     a16:	83 c4 10             	add    $0x10,%esp
     a19:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     a1c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a20:	7e 33                	jle    a55 <gets+0x5e>
      break;
    buf[i++] = c;
     a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a25:	8d 50 01             	lea    0x1(%eax),%edx
     a28:	89 55 f4             	mov    %edx,-0xc(%ebp)
     a2b:	89 c2                	mov    %eax,%edx
     a2d:	8b 45 08             	mov    0x8(%ebp),%eax
     a30:	01 c2                	add    %eax,%edx
     a32:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     a36:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     a38:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     a3c:	3c 0a                	cmp    $0xa,%al
     a3e:	74 16                	je     a56 <gets+0x5f>
     a40:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     a44:	3c 0d                	cmp    $0xd,%al
     a46:	74 0e                	je     a56 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     a48:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a4b:	83 c0 01             	add    $0x1,%eax
     a4e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     a51:	7c b3                	jl     a06 <gets+0xf>
     a53:	eb 01                	jmp    a56 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     a55:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     a56:	8b 55 f4             	mov    -0xc(%ebp),%edx
     a59:	8b 45 08             	mov    0x8(%ebp),%eax
     a5c:	01 d0                	add    %edx,%eax
     a5e:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     a61:	8b 45 08             	mov    0x8(%ebp),%eax
}
     a64:	c9                   	leave  
     a65:	c3                   	ret    

00000a66 <stat>:

int
stat(char *n, struct stat *st)
{
     a66:	55                   	push   %ebp
     a67:	89 e5                	mov    %esp,%ebp
     a69:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     a6c:	83 ec 08             	sub    $0x8,%esp
     a6f:	6a 00                	push   $0x0
     a71:	ff 75 08             	pushl  0x8(%ebp)
     a74:	e8 0c 01 00 00       	call   b85 <open>
     a79:	83 c4 10             	add    $0x10,%esp
     a7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     a7f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a83:	79 07                	jns    a8c <stat+0x26>
    return -1;
     a85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a8a:	eb 25                	jmp    ab1 <stat+0x4b>
  r = fstat(fd, st);
     a8c:	83 ec 08             	sub    $0x8,%esp
     a8f:	ff 75 0c             	pushl  0xc(%ebp)
     a92:	ff 75 f4             	pushl  -0xc(%ebp)
     a95:	e8 03 01 00 00       	call   b9d <fstat>
     a9a:	83 c4 10             	add    $0x10,%esp
     a9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     aa0:	83 ec 0c             	sub    $0xc,%esp
     aa3:	ff 75 f4             	pushl  -0xc(%ebp)
     aa6:	e8 c2 00 00 00       	call   b6d <close>
     aab:	83 c4 10             	add    $0x10,%esp
  return r;
     aae:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     ab1:	c9                   	leave  
     ab2:	c3                   	ret    

00000ab3 <atoi>:

int
atoi(const char *s)
{
     ab3:	55                   	push   %ebp
     ab4:	89 e5                	mov    %esp,%ebp
     ab6:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     ab9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     ac0:	eb 25                	jmp    ae7 <atoi+0x34>
    n = n*10 + *s++ - '0';
     ac2:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ac5:	89 d0                	mov    %edx,%eax
     ac7:	c1 e0 02             	shl    $0x2,%eax
     aca:	01 d0                	add    %edx,%eax
     acc:	01 c0                	add    %eax,%eax
     ace:	89 c1                	mov    %eax,%ecx
     ad0:	8b 45 08             	mov    0x8(%ebp),%eax
     ad3:	8d 50 01             	lea    0x1(%eax),%edx
     ad6:	89 55 08             	mov    %edx,0x8(%ebp)
     ad9:	0f b6 00             	movzbl (%eax),%eax
     adc:	0f be c0             	movsbl %al,%eax
     adf:	01 c8                	add    %ecx,%eax
     ae1:	83 e8 30             	sub    $0x30,%eax
     ae4:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     ae7:	8b 45 08             	mov    0x8(%ebp),%eax
     aea:	0f b6 00             	movzbl (%eax),%eax
     aed:	3c 2f                	cmp    $0x2f,%al
     aef:	7e 0a                	jle    afb <atoi+0x48>
     af1:	8b 45 08             	mov    0x8(%ebp),%eax
     af4:	0f b6 00             	movzbl (%eax),%eax
     af7:	3c 39                	cmp    $0x39,%al
     af9:	7e c7                	jle    ac2 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     afb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     afe:	c9                   	leave  
     aff:	c3                   	ret    

00000b00 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     b00:	55                   	push   %ebp
     b01:	89 e5                	mov    %esp,%ebp
     b03:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     b06:	8b 45 08             	mov    0x8(%ebp),%eax
     b09:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     b0c:	8b 45 0c             	mov    0xc(%ebp),%eax
     b0f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     b12:	eb 17                	jmp    b2b <memmove+0x2b>
    *dst++ = *src++;
     b14:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b17:	8d 50 01             	lea    0x1(%eax),%edx
     b1a:	89 55 fc             	mov    %edx,-0x4(%ebp)
     b1d:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b20:	8d 4a 01             	lea    0x1(%edx),%ecx
     b23:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     b26:	0f b6 12             	movzbl (%edx),%edx
     b29:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     b2b:	8b 45 10             	mov    0x10(%ebp),%eax
     b2e:	8d 50 ff             	lea    -0x1(%eax),%edx
     b31:	89 55 10             	mov    %edx,0x10(%ebp)
     b34:	85 c0                	test   %eax,%eax
     b36:	7f dc                	jg     b14 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     b38:	8b 45 08             	mov    0x8(%ebp),%eax
}
     b3b:	c9                   	leave  
     b3c:	c3                   	ret    

00000b3d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     b3d:	b8 01 00 00 00       	mov    $0x1,%eax
     b42:	cd 40                	int    $0x40
     b44:	c3                   	ret    

00000b45 <exit>:
SYSCALL(exit)
     b45:	b8 02 00 00 00       	mov    $0x2,%eax
     b4a:	cd 40                	int    $0x40
     b4c:	c3                   	ret    

00000b4d <wait>:
SYSCALL(wait)
     b4d:	b8 03 00 00 00       	mov    $0x3,%eax
     b52:	cd 40                	int    $0x40
     b54:	c3                   	ret    

00000b55 <pipe>:
SYSCALL(pipe)
     b55:	b8 04 00 00 00       	mov    $0x4,%eax
     b5a:	cd 40                	int    $0x40
     b5c:	c3                   	ret    

00000b5d <read>:
SYSCALL(read)
     b5d:	b8 05 00 00 00       	mov    $0x5,%eax
     b62:	cd 40                	int    $0x40
     b64:	c3                   	ret    

00000b65 <write>:
SYSCALL(write)
     b65:	b8 10 00 00 00       	mov    $0x10,%eax
     b6a:	cd 40                	int    $0x40
     b6c:	c3                   	ret    

00000b6d <close>:
SYSCALL(close)
     b6d:	b8 15 00 00 00       	mov    $0x15,%eax
     b72:	cd 40                	int    $0x40
     b74:	c3                   	ret    

00000b75 <kill>:
SYSCALL(kill)
     b75:	b8 06 00 00 00       	mov    $0x6,%eax
     b7a:	cd 40                	int    $0x40
     b7c:	c3                   	ret    

00000b7d <exec>:
SYSCALL(exec)
     b7d:	b8 07 00 00 00       	mov    $0x7,%eax
     b82:	cd 40                	int    $0x40
     b84:	c3                   	ret    

00000b85 <open>:
SYSCALL(open)
     b85:	b8 0f 00 00 00       	mov    $0xf,%eax
     b8a:	cd 40                	int    $0x40
     b8c:	c3                   	ret    

00000b8d <mknod>:
SYSCALL(mknod)
     b8d:	b8 11 00 00 00       	mov    $0x11,%eax
     b92:	cd 40                	int    $0x40
     b94:	c3                   	ret    

00000b95 <unlink>:
SYSCALL(unlink)
     b95:	b8 12 00 00 00       	mov    $0x12,%eax
     b9a:	cd 40                	int    $0x40
     b9c:	c3                   	ret    

00000b9d <fstat>:
SYSCALL(fstat)
     b9d:	b8 08 00 00 00       	mov    $0x8,%eax
     ba2:	cd 40                	int    $0x40
     ba4:	c3                   	ret    

00000ba5 <link>:
SYSCALL(link)
     ba5:	b8 13 00 00 00       	mov    $0x13,%eax
     baa:	cd 40                	int    $0x40
     bac:	c3                   	ret    

00000bad <mkdir>:
SYSCALL(mkdir)
     bad:	b8 14 00 00 00       	mov    $0x14,%eax
     bb2:	cd 40                	int    $0x40
     bb4:	c3                   	ret    

00000bb5 <chdir>:
SYSCALL(chdir)
     bb5:	b8 09 00 00 00       	mov    $0x9,%eax
     bba:	cd 40                	int    $0x40
     bbc:	c3                   	ret    

00000bbd <dup>:
SYSCALL(dup)
     bbd:	b8 0a 00 00 00       	mov    $0xa,%eax
     bc2:	cd 40                	int    $0x40
     bc4:	c3                   	ret    

00000bc5 <getpid>:
SYSCALL(getpid)
     bc5:	b8 0b 00 00 00       	mov    $0xb,%eax
     bca:	cd 40                	int    $0x40
     bcc:	c3                   	ret    

00000bcd <sbrk>:
SYSCALL(sbrk)
     bcd:	b8 0c 00 00 00       	mov    $0xc,%eax
     bd2:	cd 40                	int    $0x40
     bd4:	c3                   	ret    

00000bd5 <sleep>:
SYSCALL(sleep)
     bd5:	b8 0d 00 00 00       	mov    $0xd,%eax
     bda:	cd 40                	int    $0x40
     bdc:	c3                   	ret    

00000bdd <uptime>:
SYSCALL(uptime)
     bdd:	b8 0e 00 00 00       	mov    $0xe,%eax
     be2:	cd 40                	int    $0x40
     be4:	c3                   	ret    

00000be5 <paintWindow>:

SYSCALL(paintWindow)
     be5:	b8 16 00 00 00       	mov    $0x16,%eax
     bea:	cd 40                	int    $0x40
     bec:	c3                   	ret    

00000bed <sendMessage>:
SYSCALL(sendMessage)
     bed:	b8 17 00 00 00       	mov    $0x17,%eax
     bf2:	cd 40                	int    $0x40
     bf4:	c3                   	ret    

00000bf5 <getMessage>:
SYSCALL(getMessage)
     bf5:	b8 19 00 00 00       	mov    $0x19,%eax
     bfa:	cd 40                	int    $0x40
     bfc:	c3                   	ret    

00000bfd <registWindow>:
SYSCALL(registWindow)
     bfd:	b8 18 00 00 00       	mov    $0x18,%eax
     c02:	cd 40                	int    $0x40
     c04:	c3                   	ret    

00000c05 <changePosition>:
SYSCALL(changePosition)
     c05:	b8 1a 00 00 00       	mov    $0x1a,%eax
     c0a:	cd 40                	int    $0x40
     c0c:	c3                   	ret    

00000c0d <setupTimer>:
SYSCALL(setupTimer)
     c0d:	b8 1b 00 00 00       	mov    $0x1b,%eax
     c12:	cd 40                	int    $0x40
     c14:	c3                   	ret    

00000c15 <deleteTimer>:
SYSCALL(deleteTimer)
     c15:	b8 1c 00 00 00       	mov    $0x1c,%eax
     c1a:	cd 40                	int    $0x40
     c1c:	c3                   	ret    

00000c1d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     c1d:	55                   	push   %ebp
     c1e:	89 e5                	mov    %esp,%ebp
     c20:	83 ec 18             	sub    $0x18,%esp
     c23:	8b 45 0c             	mov    0xc(%ebp),%eax
     c26:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     c29:	83 ec 04             	sub    $0x4,%esp
     c2c:	6a 01                	push   $0x1
     c2e:	8d 45 f4             	lea    -0xc(%ebp),%eax
     c31:	50                   	push   %eax
     c32:	ff 75 08             	pushl  0x8(%ebp)
     c35:	e8 2b ff ff ff       	call   b65 <write>
     c3a:	83 c4 10             	add    $0x10,%esp
}
     c3d:	90                   	nop
     c3e:	c9                   	leave  
     c3f:	c3                   	ret    

00000c40 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	53                   	push   %ebx
     c44:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     c47:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     c4e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     c52:	74 17                	je     c6b <printint+0x2b>
     c54:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     c58:	79 11                	jns    c6b <printint+0x2b>
    neg = 1;
     c5a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     c61:	8b 45 0c             	mov    0xc(%ebp),%eax
     c64:	f7 d8                	neg    %eax
     c66:	89 45 ec             	mov    %eax,-0x14(%ebp)
     c69:	eb 06                	jmp    c71 <printint+0x31>
  } else {
    x = xx;
     c6b:	8b 45 0c             	mov    0xc(%ebp),%eax
     c6e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     c71:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     c78:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     c7b:	8d 41 01             	lea    0x1(%ecx),%eax
     c7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
     c81:	8b 5d 10             	mov    0x10(%ebp),%ebx
     c84:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c87:	ba 00 00 00 00       	mov    $0x0,%edx
     c8c:	f7 f3                	div    %ebx
     c8e:	89 d0                	mov    %edx,%eax
     c90:	0f b6 80 6c 33 00 00 	movzbl 0x336c(%eax),%eax
     c97:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     c9b:	8b 5d 10             	mov    0x10(%ebp),%ebx
     c9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ca1:	ba 00 00 00 00       	mov    $0x0,%edx
     ca6:	f7 f3                	div    %ebx
     ca8:	89 45 ec             	mov    %eax,-0x14(%ebp)
     cab:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     caf:	75 c7                	jne    c78 <printint+0x38>
  if(neg)
     cb1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     cb5:	74 2d                	je     ce4 <printint+0xa4>
    buf[i++] = '-';
     cb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cba:	8d 50 01             	lea    0x1(%eax),%edx
     cbd:	89 55 f4             	mov    %edx,-0xc(%ebp)
     cc0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     cc5:	eb 1d                	jmp    ce4 <printint+0xa4>
    putc(fd, buf[i]);
     cc7:	8d 55 dc             	lea    -0x24(%ebp),%edx
     cca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ccd:	01 d0                	add    %edx,%eax
     ccf:	0f b6 00             	movzbl (%eax),%eax
     cd2:	0f be c0             	movsbl %al,%eax
     cd5:	83 ec 08             	sub    $0x8,%esp
     cd8:	50                   	push   %eax
     cd9:	ff 75 08             	pushl  0x8(%ebp)
     cdc:	e8 3c ff ff ff       	call   c1d <putc>
     ce1:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     ce4:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     ce8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     cec:	79 d9                	jns    cc7 <printint+0x87>
    putc(fd, buf[i]);
}
     cee:	90                   	nop
     cef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cf2:	c9                   	leave  
     cf3:	c3                   	ret    

00000cf4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     cf4:	55                   	push   %ebp
     cf5:	89 e5                	mov    %esp,%ebp
     cf7:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     cfa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     d01:	8d 45 0c             	lea    0xc(%ebp),%eax
     d04:	83 c0 04             	add    $0x4,%eax
     d07:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     d0a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     d11:	e9 59 01 00 00       	jmp    e6f <printf+0x17b>
    c = fmt[i] & 0xff;
     d16:	8b 55 0c             	mov    0xc(%ebp),%edx
     d19:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d1c:	01 d0                	add    %edx,%eax
     d1e:	0f b6 00             	movzbl (%eax),%eax
     d21:	0f be c0             	movsbl %al,%eax
     d24:	25 ff 00 00 00       	and    $0xff,%eax
     d29:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     d2c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     d30:	75 2c                	jne    d5e <printf+0x6a>
      if(c == '%'){
     d32:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     d36:	75 0c                	jne    d44 <printf+0x50>
        state = '%';
     d38:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     d3f:	e9 27 01 00 00       	jmp    e6b <printf+0x177>
      } else {
        putc(fd, c);
     d44:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d47:	0f be c0             	movsbl %al,%eax
     d4a:	83 ec 08             	sub    $0x8,%esp
     d4d:	50                   	push   %eax
     d4e:	ff 75 08             	pushl  0x8(%ebp)
     d51:	e8 c7 fe ff ff       	call   c1d <putc>
     d56:	83 c4 10             	add    $0x10,%esp
     d59:	e9 0d 01 00 00       	jmp    e6b <printf+0x177>
      }
    } else if(state == '%'){
     d5e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     d62:	0f 85 03 01 00 00    	jne    e6b <printf+0x177>
      if(c == 'd'){
     d68:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     d6c:	75 1e                	jne    d8c <printf+0x98>
        printint(fd, *ap, 10, 1);
     d6e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d71:	8b 00                	mov    (%eax),%eax
     d73:	6a 01                	push   $0x1
     d75:	6a 0a                	push   $0xa
     d77:	50                   	push   %eax
     d78:	ff 75 08             	pushl  0x8(%ebp)
     d7b:	e8 c0 fe ff ff       	call   c40 <printint>
     d80:	83 c4 10             	add    $0x10,%esp
        ap++;
     d83:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     d87:	e9 d8 00 00 00       	jmp    e64 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     d8c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     d90:	74 06                	je     d98 <printf+0xa4>
     d92:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     d96:	75 1e                	jne    db6 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     d98:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d9b:	8b 00                	mov    (%eax),%eax
     d9d:	6a 00                	push   $0x0
     d9f:	6a 10                	push   $0x10
     da1:	50                   	push   %eax
     da2:	ff 75 08             	pushl  0x8(%ebp)
     da5:	e8 96 fe ff ff       	call   c40 <printint>
     daa:	83 c4 10             	add    $0x10,%esp
        ap++;
     dad:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     db1:	e9 ae 00 00 00       	jmp    e64 <printf+0x170>
      } else if(c == 's'){
     db6:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     dba:	75 43                	jne    dff <printf+0x10b>
        s = (char*)*ap;
     dbc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     dbf:	8b 00                	mov    (%eax),%eax
     dc1:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     dc4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     dc8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     dcc:	75 25                	jne    df3 <printf+0xff>
          s = "(null)";
     dce:	c7 45 f4 5c 2b 00 00 	movl   $0x2b5c,-0xc(%ebp)
        while(*s != 0){
     dd5:	eb 1c                	jmp    df3 <printf+0xff>
          putc(fd, *s);
     dd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dda:	0f b6 00             	movzbl (%eax),%eax
     ddd:	0f be c0             	movsbl %al,%eax
     de0:	83 ec 08             	sub    $0x8,%esp
     de3:	50                   	push   %eax
     de4:	ff 75 08             	pushl  0x8(%ebp)
     de7:	e8 31 fe ff ff       	call   c1d <putc>
     dec:	83 c4 10             	add    $0x10,%esp
          s++;
     def:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     df3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df6:	0f b6 00             	movzbl (%eax),%eax
     df9:	84 c0                	test   %al,%al
     dfb:	75 da                	jne    dd7 <printf+0xe3>
     dfd:	eb 65                	jmp    e64 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     dff:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     e03:	75 1d                	jne    e22 <printf+0x12e>
        putc(fd, *ap);
     e05:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e08:	8b 00                	mov    (%eax),%eax
     e0a:	0f be c0             	movsbl %al,%eax
     e0d:	83 ec 08             	sub    $0x8,%esp
     e10:	50                   	push   %eax
     e11:	ff 75 08             	pushl  0x8(%ebp)
     e14:	e8 04 fe ff ff       	call   c1d <putc>
     e19:	83 c4 10             	add    $0x10,%esp
        ap++;
     e1c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     e20:	eb 42                	jmp    e64 <printf+0x170>
      } else if(c == '%'){
     e22:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     e26:	75 17                	jne    e3f <printf+0x14b>
        putc(fd, c);
     e28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e2b:	0f be c0             	movsbl %al,%eax
     e2e:	83 ec 08             	sub    $0x8,%esp
     e31:	50                   	push   %eax
     e32:	ff 75 08             	pushl  0x8(%ebp)
     e35:	e8 e3 fd ff ff       	call   c1d <putc>
     e3a:	83 c4 10             	add    $0x10,%esp
     e3d:	eb 25                	jmp    e64 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     e3f:	83 ec 08             	sub    $0x8,%esp
     e42:	6a 25                	push   $0x25
     e44:	ff 75 08             	pushl  0x8(%ebp)
     e47:	e8 d1 fd ff ff       	call   c1d <putc>
     e4c:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     e4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e52:	0f be c0             	movsbl %al,%eax
     e55:	83 ec 08             	sub    $0x8,%esp
     e58:	50                   	push   %eax
     e59:	ff 75 08             	pushl  0x8(%ebp)
     e5c:	e8 bc fd ff ff       	call   c1d <putc>
     e61:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     e64:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e6b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e6f:	8b 55 0c             	mov    0xc(%ebp),%edx
     e72:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e75:	01 d0                	add    %edx,%eax
     e77:	0f b6 00             	movzbl (%eax),%eax
     e7a:	84 c0                	test   %al,%al
     e7c:	0f 85 94 fe ff ff    	jne    d16 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     e82:	90                   	nop
     e83:	c9                   	leave  
     e84:	c3                   	ret    

00000e85 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e85:	55                   	push   %ebp
     e86:	89 e5                	mov    %esp,%ebp
     e88:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     e8b:	8b 45 08             	mov    0x8(%ebp),%eax
     e8e:	83 e8 08             	sub    $0x8,%eax
     e91:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e94:	a1 a8 33 00 00       	mov    0x33a8,%eax
     e99:	89 45 fc             	mov    %eax,-0x4(%ebp)
     e9c:	eb 24                	jmp    ec2 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ea1:	8b 00                	mov    (%eax),%eax
     ea3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     ea6:	77 12                	ja     eba <free+0x35>
     ea8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     eab:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     eae:	77 24                	ja     ed4 <free+0x4f>
     eb0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     eb3:	8b 00                	mov    (%eax),%eax
     eb5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     eb8:	77 1a                	ja     ed4 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     eba:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ebd:	8b 00                	mov    (%eax),%eax
     ebf:	89 45 fc             	mov    %eax,-0x4(%ebp)
     ec2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ec5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     ec8:	76 d4                	jbe    e9e <free+0x19>
     eca:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ecd:	8b 00                	mov    (%eax),%eax
     ecf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     ed2:	76 ca                	jbe    e9e <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     ed4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ed7:	8b 40 04             	mov    0x4(%eax),%eax
     eda:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     ee1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ee4:	01 c2                	add    %eax,%edx
     ee6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ee9:	8b 00                	mov    (%eax),%eax
     eeb:	39 c2                	cmp    %eax,%edx
     eed:	75 24                	jne    f13 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     eef:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ef2:	8b 50 04             	mov    0x4(%eax),%edx
     ef5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ef8:	8b 00                	mov    (%eax),%eax
     efa:	8b 40 04             	mov    0x4(%eax),%eax
     efd:	01 c2                	add    %eax,%edx
     eff:	8b 45 f8             	mov    -0x8(%ebp),%eax
     f02:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     f05:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f08:	8b 00                	mov    (%eax),%eax
     f0a:	8b 10                	mov    (%eax),%edx
     f0c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     f0f:	89 10                	mov    %edx,(%eax)
     f11:	eb 0a                	jmp    f1d <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     f13:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f16:	8b 10                	mov    (%eax),%edx
     f18:	8b 45 f8             	mov    -0x8(%ebp),%eax
     f1b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     f1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f20:	8b 40 04             	mov    0x4(%eax),%eax
     f23:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     f2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f2d:	01 d0                	add    %edx,%eax
     f2f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     f32:	75 20                	jne    f54 <free+0xcf>
    p->s.size += bp->s.size;
     f34:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f37:	8b 50 04             	mov    0x4(%eax),%edx
     f3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     f3d:	8b 40 04             	mov    0x4(%eax),%eax
     f40:	01 c2                	add    %eax,%edx
     f42:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f45:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     f48:	8b 45 f8             	mov    -0x8(%ebp),%eax
     f4b:	8b 10                	mov    (%eax),%edx
     f4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f50:	89 10                	mov    %edx,(%eax)
     f52:	eb 08                	jmp    f5c <free+0xd7>
  } else
    p->s.ptr = bp;
     f54:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f57:	8b 55 f8             	mov    -0x8(%ebp),%edx
     f5a:	89 10                	mov    %edx,(%eax)
  freep = p;
     f5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f5f:	a3 a8 33 00 00       	mov    %eax,0x33a8
}
     f64:	90                   	nop
     f65:	c9                   	leave  
     f66:	c3                   	ret    

00000f67 <morecore>:

static Header*
morecore(uint nu)
{
     f67:	55                   	push   %ebp
     f68:	89 e5                	mov    %esp,%ebp
     f6a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     f6d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     f74:	77 07                	ja     f7d <morecore+0x16>
    nu = 4096;
     f76:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     f7d:	8b 45 08             	mov    0x8(%ebp),%eax
     f80:	c1 e0 03             	shl    $0x3,%eax
     f83:	83 ec 0c             	sub    $0xc,%esp
     f86:	50                   	push   %eax
     f87:	e8 41 fc ff ff       	call   bcd <sbrk>
     f8c:	83 c4 10             	add    $0x10,%esp
     f8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     f92:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     f96:	75 07                	jne    f9f <morecore+0x38>
    return 0;
     f98:	b8 00 00 00 00       	mov    $0x0,%eax
     f9d:	eb 26                	jmp    fc5 <morecore+0x5e>
  hp = (Header*)p;
     f9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fa2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     fa5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fa8:	8b 55 08             	mov    0x8(%ebp),%edx
     fab:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     fae:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fb1:	83 c0 08             	add    $0x8,%eax
     fb4:	83 ec 0c             	sub    $0xc,%esp
     fb7:	50                   	push   %eax
     fb8:	e8 c8 fe ff ff       	call   e85 <free>
     fbd:	83 c4 10             	add    $0x10,%esp
  return freep;
     fc0:	a1 a8 33 00 00       	mov    0x33a8,%eax
}
     fc5:	c9                   	leave  
     fc6:	c3                   	ret    

00000fc7 <malloc>:

void*
malloc(uint nbytes)
{
     fc7:	55                   	push   %ebp
     fc8:	89 e5                	mov    %esp,%ebp
     fca:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fcd:	8b 45 08             	mov    0x8(%ebp),%eax
     fd0:	83 c0 07             	add    $0x7,%eax
     fd3:	c1 e8 03             	shr    $0x3,%eax
     fd6:	83 c0 01             	add    $0x1,%eax
     fd9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     fdc:	a1 a8 33 00 00       	mov    0x33a8,%eax
     fe1:	89 45 f0             	mov    %eax,-0x10(%ebp)
     fe4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     fe8:	75 23                	jne    100d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     fea:	c7 45 f0 a0 33 00 00 	movl   $0x33a0,-0x10(%ebp)
     ff1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ff4:	a3 a8 33 00 00       	mov    %eax,0x33a8
     ff9:	a1 a8 33 00 00       	mov    0x33a8,%eax
     ffe:	a3 a0 33 00 00       	mov    %eax,0x33a0
    base.s.size = 0;
    1003:	c7 05 a4 33 00 00 00 	movl   $0x0,0x33a4
    100a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    100d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1010:	8b 00                	mov    (%eax),%eax
    1012:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1015:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1018:	8b 40 04             	mov    0x4(%eax),%eax
    101b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    101e:	72 4d                	jb     106d <malloc+0xa6>
      if(p->s.size == nunits)
    1020:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1023:	8b 40 04             	mov    0x4(%eax),%eax
    1026:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1029:	75 0c                	jne    1037 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    102b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    102e:	8b 10                	mov    (%eax),%edx
    1030:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1033:	89 10                	mov    %edx,(%eax)
    1035:	eb 26                	jmp    105d <malloc+0x96>
      else {
        p->s.size -= nunits;
    1037:	8b 45 f4             	mov    -0xc(%ebp),%eax
    103a:	8b 40 04             	mov    0x4(%eax),%eax
    103d:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1040:	89 c2                	mov    %eax,%edx
    1042:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1045:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1048:	8b 45 f4             	mov    -0xc(%ebp),%eax
    104b:	8b 40 04             	mov    0x4(%eax),%eax
    104e:	c1 e0 03             	shl    $0x3,%eax
    1051:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1054:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1057:	8b 55 ec             	mov    -0x14(%ebp),%edx
    105a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    105d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1060:	a3 a8 33 00 00       	mov    %eax,0x33a8
      return (void*)(p + 1);
    1065:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1068:	83 c0 08             	add    $0x8,%eax
    106b:	eb 3b                	jmp    10a8 <malloc+0xe1>
    }
    if(p == freep)
    106d:	a1 a8 33 00 00       	mov    0x33a8,%eax
    1072:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1075:	75 1e                	jne    1095 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    1077:	83 ec 0c             	sub    $0xc,%esp
    107a:	ff 75 ec             	pushl  -0x14(%ebp)
    107d:	e8 e5 fe ff ff       	call   f67 <morecore>
    1082:	83 c4 10             	add    $0x10,%esp
    1085:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1088:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    108c:	75 07                	jne    1095 <malloc+0xce>
        return 0;
    108e:	b8 00 00 00 00       	mov    $0x0,%eax
    1093:	eb 13                	jmp    10a8 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1095:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1098:	89 45 f0             	mov    %eax,-0x10(%ebp)
    109b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    109e:	8b 00                	mov    (%eax),%eax
    10a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    10a3:	e9 6d ff ff ff       	jmp    1015 <malloc+0x4e>
}
    10a8:	c9                   	leave  
    10a9:	c3                   	ret    

000010aa <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    10aa:	55                   	push   %ebp
    10ab:	89 e5                	mov    %esp,%ebp
    10ad:	83 ec 1c             	sub    $0x1c,%esp
    10b0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    10b3:	8b 55 10             	mov    0x10(%ebp),%edx
    10b6:	8b 45 14             	mov    0x14(%ebp),%eax
    10b9:	88 4d ec             	mov    %cl,-0x14(%ebp)
    10bc:	88 55 e8             	mov    %dl,-0x18(%ebp)
    10bf:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    10c2:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    10c6:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    10c9:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    10cd:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    10d0:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    10d4:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    10d7:	8b 45 08             	mov    0x8(%ebp),%eax
    10da:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    10de:	66 89 10             	mov    %dx,(%eax)
    10e1:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    10e5:	88 50 02             	mov    %dl,0x2(%eax)
}
    10e8:	8b 45 08             	mov    0x8(%ebp),%eax
    10eb:	c9                   	leave  
    10ec:	c2 04 00             	ret    $0x4

000010ef <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    10ef:	55                   	push   %ebp
    10f0:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
    10f2:	8b 45 08             	mov    0x8(%ebp),%eax
    10f5:	2b 45 10             	sub    0x10(%ebp),%eax
    10f8:	89 c2                	mov    %eax,%edx
    10fa:	8b 45 08             	mov    0x8(%ebp),%eax
    10fd:	2b 45 10             	sub    0x10(%ebp),%eax
    1100:	0f af d0             	imul   %eax,%edx
    1103:	8b 45 0c             	mov    0xc(%ebp),%eax
    1106:	2b 45 14             	sub    0x14(%ebp),%eax
    1109:	89 c1                	mov    %eax,%ecx
    110b:	8b 45 0c             	mov    0xc(%ebp),%eax
    110e:	2b 45 14             	sub    0x14(%ebp),%eax
    1111:	0f af c1             	imul   %ecx,%eax
    1114:	01 d0                	add    %edx,%eax
}
    1116:	5d                   	pop    %ebp
    1117:	c3                   	ret    

00001118 <abs_int>:

static inline int abs_int(int x)
{
    1118:	55                   	push   %ebp
    1119:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
    111b:	8b 45 08             	mov    0x8(%ebp),%eax
    111e:	99                   	cltd   
    111f:	89 d0                	mov    %edx,%eax
    1121:	33 45 08             	xor    0x8(%ebp),%eax
    1124:	29 d0                	sub    %edx,%eax
}
    1126:	5d                   	pop    %ebp
    1127:	c3                   	ret    

00001128 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    1128:	55                   	push   %ebp
    1129:	89 e5                	mov    %esp,%ebp
    if (x < 0)
    112b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    112f:	79 07                	jns    1138 <APGetIndex+0x10>
        return X_SMALLER;
    1131:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    1136:	eb 40                	jmp    1178 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
    1138:	8b 45 08             	mov    0x8(%ebp),%eax
    113b:	8b 00                	mov    (%eax),%eax
    113d:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1140:	7f 07                	jg     1149 <APGetIndex+0x21>
        return X_BIGGER;
    1142:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1147:	eb 2f                	jmp    1178 <APGetIndex+0x50>
    if (y < 0)
    1149:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    114d:	79 07                	jns    1156 <APGetIndex+0x2e>
        return Y_SMALLER;
    114f:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
    1154:	eb 22                	jmp    1178 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
    1156:	8b 45 08             	mov    0x8(%ebp),%eax
    1159:	8b 40 04             	mov    0x4(%eax),%eax
    115c:	3b 45 10             	cmp    0x10(%ebp),%eax
    115f:	7f 07                	jg     1168 <APGetIndex+0x40>
        return Y_BIGGER;
    1161:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    1166:	eb 10                	jmp    1178 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
    1168:	8b 45 08             	mov    0x8(%ebp),%eax
    116b:	8b 00                	mov    (%eax),%eax
    116d:	0f af 45 10          	imul   0x10(%ebp),%eax
    1171:	89 c2                	mov    %eax,%edx
    1173:	8b 45 0c             	mov    0xc(%ebp),%eax
    1176:	01 d0                	add    %edx,%eax
}
    1178:	5d                   	pop    %ebp
    1179:	c3                   	ret    

0000117a <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    117a:	55                   	push   %ebp
    117b:	89 e5                	mov    %esp,%ebp
    117d:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    1180:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    1187:	8b 45 cc             	mov    -0x34(%ebp),%eax
    118a:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    118d:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    1194:	83 ec 08             	sub    $0x8,%esp
    1197:	6a 00                	push   $0x0
    1199:	ff 75 0c             	pushl  0xc(%ebp)
    119c:	e8 e4 f9 ff ff       	call   b85 <open>
    11a1:	83 c4 10             	add    $0x10,%esp
    11a4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    11a7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11ab:	79 2e                	jns    11db <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
    11ad:	83 ec 04             	sub    $0x4,%esp
    11b0:	ff 75 0c             	pushl  0xc(%ebp)
    11b3:	68 63 2b 00 00       	push   $0x2b63
    11b8:	6a 01                	push   $0x1
    11ba:	e8 35 fb ff ff       	call   cf4 <printf>
    11bf:	83 c4 10             	add    $0x10,%esp
        return bmp;
    11c2:	8b 45 08             	mov    0x8(%ebp),%eax
    11c5:	8b 55 c8             	mov    -0x38(%ebp),%edx
    11c8:	89 10                	mov    %edx,(%eax)
    11ca:	8b 55 cc             	mov    -0x34(%ebp),%edx
    11cd:	89 50 04             	mov    %edx,0x4(%eax)
    11d0:	8b 55 d0             	mov    -0x30(%ebp),%edx
    11d3:	89 50 08             	mov    %edx,0x8(%eax)
    11d6:	e9 d2 01 00 00       	jmp    13ad <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    11db:	83 ec 04             	sub    $0x4,%esp
    11de:	6a 0e                	push   $0xe
    11e0:	8d 45 ba             	lea    -0x46(%ebp),%eax
    11e3:	50                   	push   %eax
    11e4:	ff 75 ec             	pushl  -0x14(%ebp)
    11e7:	e8 71 f9 ff ff       	call   b5d <read>
    11ec:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    11ef:	83 ec 04             	sub    $0x4,%esp
    11f2:	6a 28                	push   $0x28
    11f4:	8d 45 92             	lea    -0x6e(%ebp),%eax
    11f7:	50                   	push   %eax
    11f8:	ff 75 ec             	pushl  -0x14(%ebp)
    11fb:	e8 5d f9 ff ff       	call   b5d <read>
    1200:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    1203:	8b 45 96             	mov    -0x6a(%ebp),%eax
    1206:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    1209:	8b 45 9a             	mov    -0x66(%ebp),%eax
    120c:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    120f:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1212:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1215:	0f af d0             	imul   %eax,%edx
    1218:	89 d0                	mov    %edx,%eax
    121a:	01 c0                	add    %eax,%eax
    121c:	01 d0                	add    %edx,%eax
    121e:	83 ec 0c             	sub    $0xc,%esp
    1221:	50                   	push   %eax
    1222:	e8 a0 fd ff ff       	call   fc7 <malloc>
    1227:	83 c4 10             	add    $0x10,%esp
    122a:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    122d:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    1231:	0f b7 c0             	movzwl %ax,%eax
    1234:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    1237:	8b 55 c8             	mov    -0x38(%ebp),%edx
    123a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    123d:	0f af c2             	imul   %edx,%eax
    1240:	83 c0 1f             	add    $0x1f,%eax
    1243:	c1 e8 05             	shr    $0x5,%eax
    1246:	c1 e0 02             	shl    $0x2,%eax
    1249:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    124c:	8b 55 cc             	mov    -0x34(%ebp),%edx
    124f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1252:	0f af c2             	imul   %edx,%eax
    1255:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    1258:	8b 45 e0             	mov    -0x20(%ebp),%eax
    125b:	83 ec 0c             	sub    $0xc,%esp
    125e:	50                   	push   %eax
    125f:	e8 63 fd ff ff       	call   fc7 <malloc>
    1264:	83 c4 10             	add    $0x10,%esp
    1267:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    126a:	83 ec 04             	sub    $0x4,%esp
    126d:	ff 75 e0             	pushl  -0x20(%ebp)
    1270:	ff 75 dc             	pushl  -0x24(%ebp)
    1273:	ff 75 ec             	pushl  -0x14(%ebp)
    1276:	e8 e2 f8 ff ff       	call   b5d <read>
    127b:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    127e:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    1282:	66 c1 e8 03          	shr    $0x3,%ax
    1286:	0f b7 c0             	movzwl %ax,%eax
    1289:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    128c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1293:	e9 e5 00 00 00       	jmp    137d <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    1298:	8b 55 cc             	mov    -0x34(%ebp),%edx
    129b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    129e:	29 c2                	sub    %eax,%edx
    12a0:	89 d0                	mov    %edx,%eax
    12a2:	8d 50 ff             	lea    -0x1(%eax),%edx
    12a5:	8b 45 c8             	mov    -0x38(%ebp),%eax
    12a8:	0f af c2             	imul   %edx,%eax
    12ab:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    12ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12b5:	e9 b1 00 00 00       	jmp    136b <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    12ba:	8b 55 d0             	mov    -0x30(%ebp),%edx
    12bd:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    12c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12c3:	01 c8                	add    %ecx,%eax
    12c5:	89 c1                	mov    %eax,%ecx
    12c7:	89 c8                	mov    %ecx,%eax
    12c9:	01 c0                	add    %eax,%eax
    12cb:	01 c8                	add    %ecx,%eax
    12cd:	01 c2                	add    %eax,%edx
    12cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12d2:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    12d6:	89 c1                	mov    %eax,%ecx
    12d8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    12db:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    12df:	01 c1                	add    %eax,%ecx
    12e1:	8b 45 d8             	mov    -0x28(%ebp),%eax
    12e4:	01 c8                	add    %ecx,%eax
    12e6:	8d 48 ff             	lea    -0x1(%eax),%ecx
    12e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
    12ec:	01 c8                	add    %ecx,%eax
    12ee:	0f b6 00             	movzbl (%eax),%eax
    12f1:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    12f4:	8b 55 d0             	mov    -0x30(%ebp),%edx
    12f7:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    12fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12fd:	01 c8                	add    %ecx,%eax
    12ff:	89 c1                	mov    %eax,%ecx
    1301:	89 c8                	mov    %ecx,%eax
    1303:	01 c0                	add    %eax,%eax
    1305:	01 c8                	add    %ecx,%eax
    1307:	01 c2                	add    %eax,%edx
    1309:	8b 45 f4             	mov    -0xc(%ebp),%eax
    130c:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1310:	89 c1                	mov    %eax,%ecx
    1312:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1315:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1319:	01 c1                	add    %eax,%ecx
    131b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    131e:	01 c8                	add    %ecx,%eax
    1320:	8d 48 fe             	lea    -0x2(%eax),%ecx
    1323:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1326:	01 c8                	add    %ecx,%eax
    1328:	0f b6 00             	movzbl (%eax),%eax
    132b:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    132e:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1331:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1334:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1337:	01 c8                	add    %ecx,%eax
    1339:	89 c1                	mov    %eax,%ecx
    133b:	89 c8                	mov    %ecx,%eax
    133d:	01 c0                	add    %eax,%eax
    133f:	01 c8                	add    %ecx,%eax
    1341:	01 c2                	add    %eax,%edx
    1343:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1346:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    134a:	89 c1                	mov    %eax,%ecx
    134c:	8b 45 d8             	mov    -0x28(%ebp),%eax
    134f:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1353:	01 c1                	add    %eax,%ecx
    1355:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1358:	01 c8                	add    %ecx,%eax
    135a:	8d 48 fd             	lea    -0x3(%eax),%ecx
    135d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1360:	01 c8                	add    %ecx,%eax
    1362:	0f b6 00             	movzbl (%eax),%eax
    1365:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    1367:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    136b:	8b 55 c8             	mov    -0x38(%ebp),%edx
    136e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1371:	39 c2                	cmp    %eax,%edx
    1373:	0f 87 41 ff ff ff    	ja     12ba <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    1379:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    137d:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1380:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1383:	39 c2                	cmp    %eax,%edx
    1385:	0f 87 0d ff ff ff    	ja     1298 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    138b:	83 ec 0c             	sub    $0xc,%esp
    138e:	ff 75 ec             	pushl  -0x14(%ebp)
    1391:	e8 d7 f7 ff ff       	call   b6d <close>
    1396:	83 c4 10             	add    $0x10,%esp
    return bmp;
    1399:	8b 45 08             	mov    0x8(%ebp),%eax
    139c:	8b 55 c8             	mov    -0x38(%ebp),%edx
    139f:	89 10                	mov    %edx,(%eax)
    13a1:	8b 55 cc             	mov    -0x34(%ebp),%edx
    13a4:	89 50 04             	mov    %edx,0x4(%eax)
    13a7:	8b 55 d0             	mov    -0x30(%ebp),%edx
    13aa:	89 50 08             	mov    %edx,0x8(%eax)
}
    13ad:	8b 45 08             	mov    0x8(%ebp),%eax
    13b0:	c9                   	leave  
    13b1:	c2 04 00             	ret    $0x4

000013b4 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    13b4:	55                   	push   %ebp
    13b5:	89 e5                	mov    %esp,%ebp
    13b7:	53                   	push   %ebx
    13b8:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    13bb:	83 ec 0c             	sub    $0xc,%esp
    13be:	6a 1c                	push   $0x1c
    13c0:	e8 02 fc ff ff       	call   fc7 <malloc>
    13c5:	83 c4 10             	add    $0x10,%esp
    13c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    13cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13ce:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    13d5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    13d8:	8d 45 d8             	lea    -0x28(%ebp),%eax
    13db:	6a 0c                	push   $0xc
    13dd:	6a 0c                	push   $0xc
    13df:	6a 0c                	push   $0xc
    13e1:	50                   	push   %eax
    13e2:	e8 c3 fc ff ff       	call   10aa <RGB>
    13e7:	83 c4 0c             	add    $0xc,%esp
    13ea:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    13ee:	66 89 43 13          	mov    %ax,0x13(%ebx)
    13f2:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    13f6:	88 43 15             	mov    %al,0x15(%ebx)
    13f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13ff:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    1403:	66 89 48 10          	mov    %cx,0x10(%eax)
    1407:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    140b:	88 50 12             	mov    %dl,0x12(%eax)
    140e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1411:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1414:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    1418:	66 89 48 08          	mov    %cx,0x8(%eax)
    141c:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    1420:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    1423:	8b 45 08             	mov    0x8(%ebp),%eax
    1426:	89 c2                	mov    %eax,%edx
    1428:	8b 45 f4             	mov    -0xc(%ebp),%eax
    142b:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    142d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1430:	89 c2                	mov    %eax,%edx
    1432:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1435:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    1438:	8b 55 10             	mov    0x10(%ebp),%edx
    143b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143e:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    1441:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1444:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1447:	c9                   	leave  
    1448:	c3                   	ret    

00001449 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    1449:	55                   	push   %ebp
    144a:	89 e5                	mov    %esp,%ebp
    144c:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    144f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1452:	8b 50 08             	mov    0x8(%eax),%edx
    1455:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1458:	8b 40 0c             	mov    0xc(%eax),%eax
    145b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    145e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1461:	8b 55 10             	mov    0x10(%ebp),%edx
    1464:	89 50 08             	mov    %edx,0x8(%eax)
    1467:	8b 55 14             	mov    0x14(%ebp),%edx
    146a:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    146d:	8b 45 08             	mov    0x8(%ebp),%eax
    1470:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1473:	89 10                	mov    %edx,(%eax)
    1475:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1478:	89 50 04             	mov    %edx,0x4(%eax)
}
    147b:	8b 45 08             	mov    0x8(%ebp),%eax
    147e:	c9                   	leave  
    147f:	c2 04 00             	ret    $0x4

00001482 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    1482:	55                   	push   %ebp
    1483:	89 e5                	mov    %esp,%ebp
    1485:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    1488:	8b 45 0c             	mov    0xc(%ebp),%eax
    148b:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    148f:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1493:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1497:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    149a:	8b 45 0c             	mov    0xc(%ebp),%eax
    149d:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    14a1:	66 89 50 10          	mov    %dx,0x10(%eax)
    14a5:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    14a9:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    14ac:	8b 45 08             	mov    0x8(%ebp),%eax
    14af:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    14b3:	66 89 10             	mov    %dx,(%eax)
    14b6:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    14ba:	88 50 02             	mov    %dl,0x2(%eax)
}
    14bd:	8b 45 08             	mov    0x8(%ebp),%eax
    14c0:	c9                   	leave  
    14c1:	c2 04 00             	ret    $0x4

000014c4 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    14c4:	55                   	push   %ebp
    14c5:	89 e5                	mov    %esp,%ebp
    14c7:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    14ca:	8b 45 08             	mov    0x8(%ebp),%eax
    14cd:	8b 40 0c             	mov    0xc(%eax),%eax
    14d0:	89 c2                	mov    %eax,%edx
    14d2:	c1 ea 1f             	shr    $0x1f,%edx
    14d5:	01 d0                	add    %edx,%eax
    14d7:	d1 f8                	sar    %eax
    14d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    14dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14df:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    14e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    14e6:	8b 45 10             	mov    0x10(%ebp),%eax
    14e9:	2b 45 f4             	sub    -0xc(%ebp),%eax
    14ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    14ef:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    14f3:	0f 89 98 00 00 00    	jns    1591 <APDrawPoint+0xcd>
        i = 0;
    14f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    1500:	e9 8c 00 00 00       	jmp    1591 <APDrawPoint+0xcd>
    {
        j = x - off;
    1505:	8b 45 0c             	mov    0xc(%ebp),%eax
    1508:	2b 45 f4             	sub    -0xc(%ebp),%eax
    150b:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    150e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1512:	79 69                	jns    157d <APDrawPoint+0xb9>
            j = 0;
    1514:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    151b:	eb 60                	jmp    157d <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    151d:	ff 75 fc             	pushl  -0x4(%ebp)
    1520:	ff 75 f8             	pushl  -0x8(%ebp)
    1523:	ff 75 08             	pushl  0x8(%ebp)
    1526:	e8 fd fb ff ff       	call   1128 <APGetIndex>
    152b:	83 c4 0c             	add    $0xc,%esp
    152e:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    1531:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    1535:	74 55                	je     158c <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    1537:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    153b:	74 67                	je     15a4 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    153d:	ff 75 10             	pushl  0x10(%ebp)
    1540:	ff 75 0c             	pushl  0xc(%ebp)
    1543:	ff 75 fc             	pushl  -0x4(%ebp)
    1546:	ff 75 f8             	pushl  -0x8(%ebp)
    1549:	e8 a1 fb ff ff       	call   10ef <distance_2>
    154e:	83 c4 10             	add    $0x10,%esp
    1551:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1554:	7f 23                	jg     1579 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    1556:	8b 45 08             	mov    0x8(%ebp),%eax
    1559:	8b 48 18             	mov    0x18(%eax),%ecx
    155c:	8b 55 ec             	mov    -0x14(%ebp),%edx
    155f:	89 d0                	mov    %edx,%eax
    1561:	01 c0                	add    %eax,%eax
    1563:	01 d0                	add    %edx,%eax
    1565:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1568:	8b 45 08             	mov    0x8(%ebp),%eax
    156b:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    156f:	66 89 0a             	mov    %cx,(%edx)
    1572:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1576:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1579:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    157d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1580:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1583:	01 d0                	add    %edx,%eax
    1585:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1588:	7d 93                	jge    151d <APDrawPoint+0x59>
    158a:	eb 01                	jmp    158d <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    158c:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    158d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1591:	8b 55 10             	mov    0x10(%ebp),%edx
    1594:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1597:	01 d0                	add    %edx,%eax
    1599:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    159c:	0f 8d 63 ff ff ff    	jge    1505 <APDrawPoint+0x41>
    15a2:	eb 01                	jmp    15a5 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    15a4:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    15a5:	c9                   	leave  
    15a6:	c3                   	ret    

000015a7 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    15a7:	55                   	push   %ebp
    15a8:	89 e5                	mov    %esp,%ebp
    15aa:	53                   	push   %ebx
    15ab:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    15ae:	8b 45 0c             	mov    0xc(%ebp),%eax
    15b1:	3b 45 14             	cmp    0x14(%ebp),%eax
    15b4:	0f 85 80 00 00 00    	jne    163a <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    15ba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    15be:	0f 88 9d 02 00 00    	js     1861 <APDrawLine+0x2ba>
    15c4:	8b 45 08             	mov    0x8(%ebp),%eax
    15c7:	8b 00                	mov    (%eax),%eax
    15c9:	3b 45 0c             	cmp    0xc(%ebp),%eax
    15cc:	0f 8e 8f 02 00 00    	jle    1861 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    15d2:	8b 45 10             	mov    0x10(%ebp),%eax
    15d5:	3b 45 18             	cmp    0x18(%ebp),%eax
    15d8:	7e 12                	jle    15ec <APDrawLine+0x45>
        {
            int tmp = y2;
    15da:	8b 45 18             	mov    0x18(%ebp),%eax
    15dd:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    15e0:	8b 45 10             	mov    0x10(%ebp),%eax
    15e3:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    15e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
    15e9:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    15ec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    15f0:	79 07                	jns    15f9 <APDrawLine+0x52>
    15f2:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    15f9:	8b 45 08             	mov    0x8(%ebp),%eax
    15fc:	8b 40 04             	mov    0x4(%eax),%eax
    15ff:	3b 45 18             	cmp    0x18(%ebp),%eax
    1602:	7d 0c                	jge    1610 <APDrawLine+0x69>
    1604:	8b 45 08             	mov    0x8(%ebp),%eax
    1607:	8b 40 04             	mov    0x4(%eax),%eax
    160a:	83 e8 01             	sub    $0x1,%eax
    160d:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    1610:	8b 45 10             	mov    0x10(%ebp),%eax
    1613:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1616:	eb 15                	jmp    162d <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1618:	ff 75 f4             	pushl  -0xc(%ebp)
    161b:	ff 75 0c             	pushl  0xc(%ebp)
    161e:	ff 75 08             	pushl  0x8(%ebp)
    1621:	e8 9e fe ff ff       	call   14c4 <APDrawPoint>
    1626:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1629:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    162d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1630:	3b 45 18             	cmp    0x18(%ebp),%eax
    1633:	7e e3                	jle    1618 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    1635:	e9 2b 02 00 00       	jmp    1865 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    163a:	8b 45 10             	mov    0x10(%ebp),%eax
    163d:	3b 45 18             	cmp    0x18(%ebp),%eax
    1640:	75 7f                	jne    16c1 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    1642:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1646:	0f 88 18 02 00 00    	js     1864 <APDrawLine+0x2bd>
    164c:	8b 45 08             	mov    0x8(%ebp),%eax
    164f:	8b 40 04             	mov    0x4(%eax),%eax
    1652:	3b 45 10             	cmp    0x10(%ebp),%eax
    1655:	0f 8e 09 02 00 00    	jle    1864 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    165b:	8b 45 0c             	mov    0xc(%ebp),%eax
    165e:	3b 45 14             	cmp    0x14(%ebp),%eax
    1661:	7e 12                	jle    1675 <APDrawLine+0xce>
        {
            int tmp = x2;
    1663:	8b 45 14             	mov    0x14(%ebp),%eax
    1666:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1669:	8b 45 0c             	mov    0xc(%ebp),%eax
    166c:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    166f:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1672:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1675:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1679:	79 07                	jns    1682 <APDrawLine+0xdb>
    167b:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1682:	8b 45 08             	mov    0x8(%ebp),%eax
    1685:	8b 00                	mov    (%eax),%eax
    1687:	3b 45 14             	cmp    0x14(%ebp),%eax
    168a:	7d 0b                	jge    1697 <APDrawLine+0xf0>
    168c:	8b 45 08             	mov    0x8(%ebp),%eax
    168f:	8b 00                	mov    (%eax),%eax
    1691:	83 e8 01             	sub    $0x1,%eax
    1694:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1697:	8b 45 0c             	mov    0xc(%ebp),%eax
    169a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    169d:	eb 15                	jmp    16b4 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    169f:	ff 75 10             	pushl  0x10(%ebp)
    16a2:	ff 75 f0             	pushl  -0x10(%ebp)
    16a5:	ff 75 08             	pushl  0x8(%ebp)
    16a8:	e8 17 fe ff ff       	call   14c4 <APDrawPoint>
    16ad:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    16b0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    16b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16b7:	3b 45 14             	cmp    0x14(%ebp),%eax
    16ba:	7e e3                	jle    169f <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    16bc:	e9 a4 01 00 00       	jmp    1865 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    16c1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    16c8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    16cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    16d2:	2b 45 14             	sub    0x14(%ebp),%eax
    16d5:	50                   	push   %eax
    16d6:	e8 3d fa ff ff       	call   1118 <abs_int>
    16db:	83 c4 04             	add    $0x4,%esp
    16de:	89 c3                	mov    %eax,%ebx
    16e0:	8b 45 10             	mov    0x10(%ebp),%eax
    16e3:	2b 45 18             	sub    0x18(%ebp),%eax
    16e6:	50                   	push   %eax
    16e7:	e8 2c fa ff ff       	call   1118 <abs_int>
    16ec:	83 c4 04             	add    $0x4,%esp
    16ef:	39 c3                	cmp    %eax,%ebx
    16f1:	0f 8e b5 00 00 00    	jle    17ac <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    16f7:	8b 45 10             	mov    0x10(%ebp),%eax
    16fa:	2b 45 18             	sub    0x18(%ebp),%eax
    16fd:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1700:	db 45 b0             	fildl  -0x50(%ebp)
    1703:	8b 45 0c             	mov    0xc(%ebp),%eax
    1706:	2b 45 14             	sub    0x14(%ebp),%eax
    1709:	89 45 b0             	mov    %eax,-0x50(%ebp)
    170c:	db 45 b0             	fildl  -0x50(%ebp)
    170f:	de f9                	fdivrp %st,%st(1)
    1711:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1714:	8b 45 14             	mov    0x14(%ebp),%eax
    1717:	3b 45 0c             	cmp    0xc(%ebp),%eax
    171a:	7e 0e                	jle    172a <APDrawLine+0x183>
        {
            s = x1;
    171c:	8b 45 0c             	mov    0xc(%ebp),%eax
    171f:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1722:	8b 45 14             	mov    0x14(%ebp),%eax
    1725:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1728:	eb 0c                	jmp    1736 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    172a:	8b 45 14             	mov    0x14(%ebp),%eax
    172d:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1730:	8b 45 0c             	mov    0xc(%ebp),%eax
    1733:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1736:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    173a:	79 07                	jns    1743 <APDrawLine+0x19c>
    173c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1743:	8b 45 08             	mov    0x8(%ebp),%eax
    1746:	8b 00                	mov    (%eax),%eax
    1748:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    174b:	7f 0b                	jg     1758 <APDrawLine+0x1b1>
    174d:	8b 45 08             	mov    0x8(%ebp),%eax
    1750:	8b 00                	mov    (%eax),%eax
    1752:	83 e8 01             	sub    $0x1,%eax
    1755:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1758:	8b 45 ec             	mov    -0x14(%ebp),%eax
    175b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    175e:	eb 3f                	jmp    179f <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1760:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1763:	2b 45 0c             	sub    0xc(%ebp),%eax
    1766:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1769:	db 45 b0             	fildl  -0x50(%ebp)
    176c:	dc 4d d0             	fmull  -0x30(%ebp)
    176f:	db 45 10             	fildl  0x10(%ebp)
    1772:	de c1                	faddp  %st,%st(1)
    1774:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1777:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    177b:	b4 0c                	mov    $0xc,%ah
    177d:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1781:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1784:	db 5d cc             	fistpl -0x34(%ebp)
    1787:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    178a:	ff 75 cc             	pushl  -0x34(%ebp)
    178d:	ff 75 e4             	pushl  -0x1c(%ebp)
    1790:	ff 75 08             	pushl  0x8(%ebp)
    1793:	e8 2c fd ff ff       	call   14c4 <APDrawPoint>
    1798:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    179b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    179f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17a2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    17a5:	7e b9                	jle    1760 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    17a7:	e9 b9 00 00 00       	jmp    1865 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    17ac:	8b 45 0c             	mov    0xc(%ebp),%eax
    17af:	2b 45 14             	sub    0x14(%ebp),%eax
    17b2:	89 45 b0             	mov    %eax,-0x50(%ebp)
    17b5:	db 45 b0             	fildl  -0x50(%ebp)
    17b8:	8b 45 10             	mov    0x10(%ebp),%eax
    17bb:	2b 45 18             	sub    0x18(%ebp),%eax
    17be:	89 45 b0             	mov    %eax,-0x50(%ebp)
    17c1:	db 45 b0             	fildl  -0x50(%ebp)
    17c4:	de f9                	fdivrp %st,%st(1)
    17c6:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    17c9:	8b 45 10             	mov    0x10(%ebp),%eax
    17cc:	3b 45 18             	cmp    0x18(%ebp),%eax
    17cf:	7e 0e                	jle    17df <APDrawLine+0x238>
    {
        s = y2;
    17d1:	8b 45 18             	mov    0x18(%ebp),%eax
    17d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    17d7:	8b 45 10             	mov    0x10(%ebp),%eax
    17da:	89 45 e8             	mov    %eax,-0x18(%ebp)
    17dd:	eb 0c                	jmp    17eb <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    17df:	8b 45 10             	mov    0x10(%ebp),%eax
    17e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    17e5:	8b 45 18             	mov    0x18(%ebp),%eax
    17e8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    17eb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17ef:	79 07                	jns    17f8 <APDrawLine+0x251>
    17f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    17f8:	8b 45 08             	mov    0x8(%ebp),%eax
    17fb:	8b 40 04             	mov    0x4(%eax),%eax
    17fe:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1801:	7f 0c                	jg     180f <APDrawLine+0x268>
    1803:	8b 45 08             	mov    0x8(%ebp),%eax
    1806:	8b 40 04             	mov    0x4(%eax),%eax
    1809:	83 e8 01             	sub    $0x1,%eax
    180c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    180f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1812:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1815:	eb 3f                	jmp    1856 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1817:	8b 45 e0             	mov    -0x20(%ebp),%eax
    181a:	2b 45 10             	sub    0x10(%ebp),%eax
    181d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1820:	db 45 b0             	fildl  -0x50(%ebp)
    1823:	dc 4d c0             	fmull  -0x40(%ebp)
    1826:	db 45 0c             	fildl  0xc(%ebp)
    1829:	de c1                	faddp  %st,%st(1)
    182b:	d9 7d b6             	fnstcw -0x4a(%ebp)
    182e:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1832:	b4 0c                	mov    $0xc,%ah
    1834:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1838:	d9 6d b4             	fldcw  -0x4c(%ebp)
    183b:	db 5d bc             	fistpl -0x44(%ebp)
    183e:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1841:	ff 75 e0             	pushl  -0x20(%ebp)
    1844:	ff 75 bc             	pushl  -0x44(%ebp)
    1847:	ff 75 08             	pushl  0x8(%ebp)
    184a:	e8 75 fc ff ff       	call   14c4 <APDrawPoint>
    184f:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1852:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1856:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1859:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    185c:	7e b9                	jle    1817 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    185e:	90                   	nop
    185f:	eb 04                	jmp    1865 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1861:	90                   	nop
    1862:	eb 01                	jmp    1865 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1864:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1865:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1868:	c9                   	leave  
    1869:	c3                   	ret    

0000186a <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    186a:	55                   	push   %ebp
    186b:	89 e5                	mov    %esp,%ebp
    186d:	53                   	push   %ebx
    186e:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1871:	8b 55 10             	mov    0x10(%ebp),%edx
    1874:	8b 45 18             	mov    0x18(%ebp),%eax
    1877:	01 d0                	add    %edx,%eax
    1879:	83 e8 01             	sub    $0x1,%eax
    187c:	83 ec 04             	sub    $0x4,%esp
    187f:	50                   	push   %eax
    1880:	ff 75 0c             	pushl  0xc(%ebp)
    1883:	ff 75 10             	pushl  0x10(%ebp)
    1886:	ff 75 0c             	pushl  0xc(%ebp)
    1889:	ff 75 08             	pushl  0x8(%ebp)
    188c:	e8 16 fd ff ff       	call   15a7 <APDrawLine>
    1891:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1894:	8b 55 0c             	mov    0xc(%ebp),%edx
    1897:	8b 45 14             	mov    0x14(%ebp),%eax
    189a:	01 d0                	add    %edx,%eax
    189c:	83 e8 01             	sub    $0x1,%eax
    189f:	83 ec 04             	sub    $0x4,%esp
    18a2:	ff 75 10             	pushl  0x10(%ebp)
    18a5:	50                   	push   %eax
    18a6:	ff 75 10             	pushl  0x10(%ebp)
    18a9:	ff 75 0c             	pushl  0xc(%ebp)
    18ac:	ff 75 08             	pushl  0x8(%ebp)
    18af:	e8 f3 fc ff ff       	call   15a7 <APDrawLine>
    18b4:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    18b7:	8b 55 10             	mov    0x10(%ebp),%edx
    18ba:	8b 45 18             	mov    0x18(%ebp),%eax
    18bd:	01 d0                	add    %edx,%eax
    18bf:	8d 48 ff             	lea    -0x1(%eax),%ecx
    18c2:	8b 55 0c             	mov    0xc(%ebp),%edx
    18c5:	8b 45 14             	mov    0x14(%ebp),%eax
    18c8:	01 d0                	add    %edx,%eax
    18ca:	8d 50 ff             	lea    -0x1(%eax),%edx
    18cd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    18d0:	8b 45 14             	mov    0x14(%ebp),%eax
    18d3:	01 d8                	add    %ebx,%eax
    18d5:	83 e8 01             	sub    $0x1,%eax
    18d8:	83 ec 04             	sub    $0x4,%esp
    18db:	51                   	push   %ecx
    18dc:	52                   	push   %edx
    18dd:	ff 75 10             	pushl  0x10(%ebp)
    18e0:	50                   	push   %eax
    18e1:	ff 75 08             	pushl  0x8(%ebp)
    18e4:	e8 be fc ff ff       	call   15a7 <APDrawLine>
    18e9:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    18ec:	8b 55 10             	mov    0x10(%ebp),%edx
    18ef:	8b 45 18             	mov    0x18(%ebp),%eax
    18f2:	01 d0                	add    %edx,%eax
    18f4:	8d 48 ff             	lea    -0x1(%eax),%ecx
    18f7:	8b 55 0c             	mov    0xc(%ebp),%edx
    18fa:	8b 45 14             	mov    0x14(%ebp),%eax
    18fd:	01 d0                	add    %edx,%eax
    18ff:	8d 50 ff             	lea    -0x1(%eax),%edx
    1902:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1905:	8b 45 18             	mov    0x18(%ebp),%eax
    1908:	01 d8                	add    %ebx,%eax
    190a:	83 e8 01             	sub    $0x1,%eax
    190d:	83 ec 04             	sub    $0x4,%esp
    1910:	51                   	push   %ecx
    1911:	52                   	push   %edx
    1912:	50                   	push   %eax
    1913:	ff 75 0c             	pushl  0xc(%ebp)
    1916:	ff 75 08             	pushl  0x8(%ebp)
    1919:	e8 89 fc ff ff       	call   15a7 <APDrawLine>
    191e:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1921:	8b 55 0c             	mov    0xc(%ebp),%edx
    1924:	8b 45 14             	mov    0x14(%ebp),%eax
    1927:	01 d0                	add    %edx,%eax
    1929:	8d 50 ff             	lea    -0x1(%eax),%edx
    192c:	8b 45 08             	mov    0x8(%ebp),%eax
    192f:	8b 40 0c             	mov    0xc(%eax),%eax
    1932:	89 c1                	mov    %eax,%ecx
    1934:	c1 e9 1f             	shr    $0x1f,%ecx
    1937:	01 c8                	add    %ecx,%eax
    1939:	d1 f8                	sar    %eax
    193b:	29 c2                	sub    %eax,%edx
    193d:	89 d0                	mov    %edx,%eax
    193f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1942:	8b 55 10             	mov    0x10(%ebp),%edx
    1945:	8b 45 18             	mov    0x18(%ebp),%eax
    1948:	01 d0                	add    %edx,%eax
    194a:	8d 50 ff             	lea    -0x1(%eax),%edx
    194d:	8b 45 08             	mov    0x8(%ebp),%eax
    1950:	8b 40 0c             	mov    0xc(%eax),%eax
    1953:	89 c1                	mov    %eax,%ecx
    1955:	c1 e9 1f             	shr    $0x1f,%ecx
    1958:	01 c8                	add    %ecx,%eax
    195a:	d1 f8                	sar    %eax
    195c:	29 c2                	sub    %eax,%edx
    195e:	89 d0                	mov    %edx,%eax
    1960:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1963:	8b 45 08             	mov    0x8(%ebp),%eax
    1966:	8b 40 0c             	mov    0xc(%eax),%eax
    1969:	89 c2                	mov    %eax,%edx
    196b:	c1 ea 1f             	shr    $0x1f,%edx
    196e:	01 d0                	add    %edx,%eax
    1970:	d1 f8                	sar    %eax
    1972:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1975:	8b 45 08             	mov    0x8(%ebp),%eax
    1978:	8b 40 0c             	mov    0xc(%eax),%eax
    197b:	89 c2                	mov    %eax,%edx
    197d:	c1 ea 1f             	shr    $0x1f,%edx
    1980:	01 d0                	add    %edx,%eax
    1982:	d1 f8                	sar    %eax
    1984:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1987:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    198b:	0f 88 d8 00 00 00    	js     1a69 <APDrawRect+0x1ff>
    1991:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1995:	0f 88 ce 00 00 00    	js     1a69 <APDrawRect+0x1ff>
    199b:	8b 45 08             	mov    0x8(%ebp),%eax
    199e:	8b 00                	mov    (%eax),%eax
    19a0:	3b 45 0c             	cmp    0xc(%ebp),%eax
    19a3:	0f 8e c0 00 00 00    	jle    1a69 <APDrawRect+0x1ff>
    19a9:	8b 45 08             	mov    0x8(%ebp),%eax
    19ac:	8b 40 04             	mov    0x4(%eax),%eax
    19af:	3b 45 10             	cmp    0x10(%ebp),%eax
    19b2:	0f 8e b1 00 00 00    	jle    1a69 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    19b8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    19bc:	79 07                	jns    19c5 <APDrawRect+0x15b>
    19be:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    19c5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    19c9:	79 07                	jns    19d2 <APDrawRect+0x168>
    19cb:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    19d2:	8b 45 08             	mov    0x8(%ebp),%eax
    19d5:	8b 00                	mov    (%eax),%eax
    19d7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    19da:	7f 0b                	jg     19e7 <APDrawRect+0x17d>
    19dc:	8b 45 08             	mov    0x8(%ebp),%eax
    19df:	8b 00                	mov    (%eax),%eax
    19e1:	83 e8 01             	sub    $0x1,%eax
    19e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    19e7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ea:	8b 40 04             	mov    0x4(%eax),%eax
    19ed:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    19f0:	7f 0c                	jg     19fe <APDrawRect+0x194>
    19f2:	8b 45 08             	mov    0x8(%ebp),%eax
    19f5:	8b 40 04             	mov    0x4(%eax),%eax
    19f8:	83 e8 01             	sub    $0x1,%eax
    19fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    19fe:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1a05:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a08:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1a0b:	eb 52                	jmp    1a5f <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1a0d:	8b 45 10             	mov    0x10(%ebp),%eax
    1a10:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1a13:	eb 3e                	jmp    1a53 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1a15:	83 ec 04             	sub    $0x4,%esp
    1a18:	ff 75 e8             	pushl  -0x18(%ebp)
    1a1b:	ff 75 ec             	pushl  -0x14(%ebp)
    1a1e:	ff 75 08             	pushl  0x8(%ebp)
    1a21:	e8 02 f7 ff ff       	call   1128 <APGetIndex>
    1a26:	83 c4 10             	add    $0x10,%esp
    1a29:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1a2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2f:	8b 48 18             	mov    0x18(%eax),%ecx
    1a32:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1a35:	89 d0                	mov    %edx,%eax
    1a37:	01 c0                	add    %eax,%eax
    1a39:	01 d0                	add    %edx,%eax
    1a3b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1a3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a41:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1a45:	66 89 0a             	mov    %cx,(%edx)
    1a48:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1a4c:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1a4f:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1a53:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a56:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1a59:	7e ba                	jle    1a15 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1a5b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1a5f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a62:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1a65:	7e a6                	jle    1a0d <APDrawRect+0x1a3>
    1a67:	eb 01                	jmp    1a6a <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1a69:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1a6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1a6d:	c9                   	leave  
    1a6e:	c3                   	ret    

00001a6f <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1a6f:	55                   	push   %ebp
    1a70:	89 e5                	mov    %esp,%ebp
}
    1a72:	90                   	nop
    1a73:	5d                   	pop    %ebp
    1a74:	c3                   	ret    

00001a75 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1a75:	55                   	push   %ebp
    1a76:	89 e5                	mov    %esp,%ebp
    1a78:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1a7b:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1a7f:	0f 88 8e 01 00 00    	js     1c13 <APDcCopy+0x19e>
    1a85:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1a89:	0f 88 84 01 00 00    	js     1c13 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1a8f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a92:	8b 45 20             	mov    0x20(%ebp),%eax
    1a95:	01 d0                	add    %edx,%eax
    1a97:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1a9a:	8b 55 10             	mov    0x10(%ebp),%edx
    1a9d:	8b 45 24             	mov    0x24(%ebp),%eax
    1aa0:	01 d0                	add    %edx,%eax
    1aa2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1aa5:	8b 55 18             	mov    0x18(%ebp),%edx
    1aa8:	8b 45 20             	mov    0x20(%ebp),%eax
    1aab:	01 d0                	add    %edx,%eax
    1aad:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1ab0:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1ab3:	8b 45 24             	mov    0x24(%ebp),%eax
    1ab6:	01 d0                	add    %edx,%eax
    1ab8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1abb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1abf:	0f 88 51 01 00 00    	js     1c16 <APDcCopy+0x1a1>
    1ac5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1ac9:	0f 88 47 01 00 00    	js     1c16 <APDcCopy+0x1a1>
    1acf:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1ad3:	0f 88 3d 01 00 00    	js     1c16 <APDcCopy+0x1a1>
    1ad9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1add:	0f 88 33 01 00 00    	js     1c16 <APDcCopy+0x1a1>
    1ae3:	8b 45 14             	mov    0x14(%ebp),%eax
    1ae6:	8b 00                	mov    (%eax),%eax
    1ae8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1aeb:	0f 8c 25 01 00 00    	jl     1c16 <APDcCopy+0x1a1>
    1af1:	8b 45 14             	mov    0x14(%ebp),%eax
    1af4:	8b 40 04             	mov    0x4(%eax),%eax
    1af7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1afa:	0f 8c 16 01 00 00    	jl     1c16 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1b00:	8b 45 08             	mov    0x8(%ebp),%eax
    1b03:	8b 00                	mov    (%eax),%eax
    1b05:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1b08:	7f 0b                	jg     1b15 <APDcCopy+0xa0>
    1b0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0d:	8b 00                	mov    (%eax),%eax
    1b0f:	83 e8 01             	sub    $0x1,%eax
    1b12:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1b15:	8b 45 08             	mov    0x8(%ebp),%eax
    1b18:	8b 40 04             	mov    0x4(%eax),%eax
    1b1b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1b1e:	7f 0c                	jg     1b2c <APDcCopy+0xb7>
    1b20:	8b 45 08             	mov    0x8(%ebp),%eax
    1b23:	8b 40 04             	mov    0x4(%eax),%eax
    1b26:	83 e8 01             	sub    $0x1,%eax
    1b29:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1b2c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1b33:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1b3a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1b41:	e9 bc 00 00 00       	jmp    1c02 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1b46:	8b 45 08             	mov    0x8(%ebp),%eax
    1b49:	8b 00                	mov    (%eax),%eax
    1b4b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1b4e:	8b 55 10             	mov    0x10(%ebp),%edx
    1b51:	01 ca                	add    %ecx,%edx
    1b53:	0f af d0             	imul   %eax,%edx
    1b56:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b59:	01 d0                	add    %edx,%eax
    1b5b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1b5e:	8b 45 14             	mov    0x14(%ebp),%eax
    1b61:	8b 00                	mov    (%eax),%eax
    1b63:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1b66:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1b69:	01 ca                	add    %ecx,%edx
    1b6b:	0f af d0             	imul   %eax,%edx
    1b6e:	8b 45 18             	mov    0x18(%ebp),%eax
    1b71:	01 d0                	add    %edx,%eax
    1b73:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1b76:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1b7d:	eb 74                	jmp    1bf3 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1b7f:	8b 45 14             	mov    0x14(%ebp),%eax
    1b82:	8b 50 18             	mov    0x18(%eax),%edx
    1b85:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1b88:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b8b:	01 c8                	add    %ecx,%eax
    1b8d:	89 c1                	mov    %eax,%ecx
    1b8f:	89 c8                	mov    %ecx,%eax
    1b91:	01 c0                	add    %eax,%eax
    1b93:	01 c8                	add    %ecx,%eax
    1b95:	01 d0                	add    %edx,%eax
    1b97:	0f b7 10             	movzwl (%eax),%edx
    1b9a:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1b9e:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1ba2:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1ba5:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1ba9:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1bad:	38 c2                	cmp    %al,%dl
    1baf:	75 18                	jne    1bc9 <APDcCopy+0x154>
    1bb1:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1bb5:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1bb9:	38 c2                	cmp    %al,%dl
    1bbb:	75 0c                	jne    1bc9 <APDcCopy+0x154>
    1bbd:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1bc1:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1bc5:	38 c2                	cmp    %al,%dl
    1bc7:	74 26                	je     1bef <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1bc9:	8b 45 08             	mov    0x8(%ebp),%eax
    1bcc:	8b 50 18             	mov    0x18(%eax),%edx
    1bcf:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1bd2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bd5:	01 c8                	add    %ecx,%eax
    1bd7:	89 c1                	mov    %eax,%ecx
    1bd9:	89 c8                	mov    %ecx,%eax
    1bdb:	01 c0                	add    %eax,%eax
    1bdd:	01 c8                	add    %ecx,%eax
    1bdf:	01 d0                	add    %edx,%eax
    1be1:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1be5:	66 89 10             	mov    %dx,(%eax)
    1be8:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1bec:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1bef:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1bf3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bf6:	2b 45 0c             	sub    0xc(%ebp),%eax
    1bf9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1bfc:	7d 81                	jge    1b7f <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1bfe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c02:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c05:	2b 45 10             	sub    0x10(%ebp),%eax
    1c08:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1c0b:	0f 8d 35 ff ff ff    	jge    1b46 <APDcCopy+0xd1>
    1c11:	eb 04                	jmp    1c17 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1c13:	90                   	nop
    1c14:	eb 01                	jmp    1c17 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1c16:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1c17:	c9                   	leave  
    1c18:	c3                   	ret    

00001c19 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1c19:	55                   	push   %ebp
    1c1a:	89 e5                	mov    %esp,%ebp
    1c1c:	83 ec 1c             	sub    $0x1c,%esp
    1c1f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1c22:	8b 55 10             	mov    0x10(%ebp),%edx
    1c25:	8b 45 14             	mov    0x14(%ebp),%eax
    1c28:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1c2b:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1c2e:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1c31:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1c35:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1c38:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1c3c:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1c3f:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1c43:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1c46:	8b 45 08             	mov    0x8(%ebp),%eax
    1c49:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1c4d:	66 89 10             	mov    %dx,(%eax)
    1c50:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1c54:	88 50 02             	mov    %dl,0x2(%eax)
}
    1c57:	8b 45 08             	mov    0x8(%ebp),%eax
    1c5a:	c9                   	leave  
    1c5b:	c2 04 00             	ret    $0x4

00001c5e <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1c5e:	55                   	push   %ebp
    1c5f:	89 e5                	mov    %esp,%ebp
    1c61:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1c64:	8b 45 08             	mov    0x8(%ebp),%eax
    1c67:	8b 00                	mov    (%eax),%eax
    1c69:	83 ec 08             	sub    $0x8,%esp
    1c6c:	8d 55 0c             	lea    0xc(%ebp),%edx
    1c6f:	52                   	push   %edx
    1c70:	50                   	push   %eax
    1c71:	e8 77 ef ff ff       	call   bed <sendMessage>
    1c76:	83 c4 10             	add    $0x10,%esp
}
    1c79:	90                   	nop
    1c7a:	c9                   	leave  
    1c7b:	c3                   	ret    

00001c7c <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1c7c:	55                   	push   %ebp
    1c7d:	89 e5                	mov    %esp,%ebp
    1c7f:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1c82:	83 ec 0c             	sub    $0xc,%esp
    1c85:	68 98 00 00 00       	push   $0x98
    1c8a:	e8 38 f3 ff ff       	call   fc7 <malloc>
    1c8f:	83 c4 10             	add    $0x10,%esp
    1c92:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1c95:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1c99:	75 15                	jne    1cb0 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1c9b:	83 ec 04             	sub    $0x4,%esp
    1c9e:	ff 75 08             	pushl  0x8(%ebp)
    1ca1:	68 74 2b 00 00       	push   $0x2b74
    1ca6:	6a 01                	push   $0x1
    1ca8:	e8 47 f0 ff ff       	call   cf4 <printf>
    1cad:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1cb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cb3:	05 84 00 00 00       	add    $0x84,%eax
    1cb8:	83 ec 08             	sub    $0x8,%esp
    1cbb:	ff 75 08             	pushl  0x8(%ebp)
    1cbe:	50                   	push   %eax
    1cbf:	e8 50 ec ff ff       	call   914 <strcpy>
    1cc4:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1cc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cca:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1cd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cd4:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1cdb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cde:	8b 40 3c             	mov    0x3c(%eax),%eax
    1ce1:	89 c2                	mov    %eax,%edx
    1ce3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ce6:	8b 40 40             	mov    0x40(%eax),%eax
    1ce9:	0f af d0             	imul   %eax,%edx
    1cec:	89 d0                	mov    %edx,%eax
    1cee:	01 c0                	add    %eax,%eax
    1cf0:	01 d0                	add    %edx,%eax
    1cf2:	83 ec 0c             	sub    $0xc,%esp
    1cf5:	50                   	push   %eax
    1cf6:	e8 cc f2 ff ff       	call   fc7 <malloc>
    1cfb:	83 c4 10             	add    $0x10,%esp
    1cfe:	89 c2                	mov    %eax,%edx
    1d00:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d03:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1d06:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d09:	8b 40 54             	mov    0x54(%eax),%eax
    1d0c:	85 c0                	test   %eax,%eax
    1d0e:	75 15                	jne    1d25 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1d10:	83 ec 04             	sub    $0x4,%esp
    1d13:	ff 75 08             	pushl  0x8(%ebp)
    1d16:	68 94 2b 00 00       	push   $0x2b94
    1d1b:	6a 01                	push   $0x1
    1d1d:	e8 d2 ef ff ff       	call   cf4 <printf>
    1d22:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1d25:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d28:	8b 40 3c             	mov    0x3c(%eax),%eax
    1d2b:	89 c2                	mov    %eax,%edx
    1d2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d30:	8b 40 40             	mov    0x40(%eax),%eax
    1d33:	0f af d0             	imul   %eax,%edx
    1d36:	89 d0                	mov    %edx,%eax
    1d38:	01 c0                	add    %eax,%eax
    1d3a:	01 c2                	add    %eax,%edx
    1d3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d3f:	8b 40 54             	mov    0x54(%eax),%eax
    1d42:	83 ec 04             	sub    $0x4,%esp
    1d45:	52                   	push   %edx
    1d46:	68 ff ff ff 00       	push   $0xffffff
    1d4b:	50                   	push   %eax
    1d4c:	e8 59 ec ff ff       	call   9aa <memset>
    1d51:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1d54:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d57:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1d5e:	e8 62 ee ff ff       	call   bc5 <getpid>
    1d63:	89 c2                	mov    %eax,%edx
    1d65:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d68:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1d6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d6e:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1d75:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d78:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1d7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d82:	8b 40 58             	mov    0x58(%eax),%eax
    1d85:	89 c2                	mov    %eax,%edx
    1d87:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d8a:	8b 40 5c             	mov    0x5c(%eax),%eax
    1d8d:	0f af d0             	imul   %eax,%edx
    1d90:	89 d0                	mov    %edx,%eax
    1d92:	01 c0                	add    %eax,%eax
    1d94:	01 d0                	add    %edx,%eax
    1d96:	83 ec 0c             	sub    $0xc,%esp
    1d99:	50                   	push   %eax
    1d9a:	e8 28 f2 ff ff       	call   fc7 <malloc>
    1d9f:	83 c4 10             	add    $0x10,%esp
    1da2:	89 c2                	mov    %eax,%edx
    1da4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1da7:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1daa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dad:	8b 40 70             	mov    0x70(%eax),%eax
    1db0:	85 c0                	test   %eax,%eax
    1db2:	75 15                	jne    1dc9 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1db4:	83 ec 04             	sub    $0x4,%esp
    1db7:	ff 75 08             	pushl  0x8(%ebp)
    1dba:	68 b8 2b 00 00       	push   $0x2bb8
    1dbf:	6a 01                	push   $0x1
    1dc1:	e8 2e ef ff ff       	call   cf4 <printf>
    1dc6:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1dc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dcc:	8b 40 3c             	mov    0x3c(%eax),%eax
    1dcf:	89 c2                	mov    %eax,%edx
    1dd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dd4:	8b 40 40             	mov    0x40(%eax),%eax
    1dd7:	0f af d0             	imul   %eax,%edx
    1dda:	89 d0                	mov    %edx,%eax
    1ddc:	01 c0                	add    %eax,%eax
    1dde:	01 c2                	add    %eax,%edx
    1de0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1de3:	8b 40 54             	mov    0x54(%eax),%eax
    1de6:	83 ec 04             	sub    $0x4,%esp
    1de9:	52                   	push   %edx
    1dea:	68 ff 00 00 00       	push   $0xff
    1def:	50                   	push   %eax
    1df0:	e8 b5 eb ff ff       	call   9aa <memset>
    1df5:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1df8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dfb:	8b 55 0c             	mov    0xc(%ebp),%edx
    1dfe:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1e01:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1e05:	74 49                	je     1e50 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1e07:	8b 45 10             	mov    0x10(%ebp),%eax
    1e0a:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1e10:	83 ec 0c             	sub    $0xc,%esp
    1e13:	50                   	push   %eax
    1e14:	e8 ae f1 ff ff       	call   fc7 <malloc>
    1e19:	83 c4 10             	add    $0x10,%esp
    1e1c:	89 c2                	mov    %eax,%edx
    1e1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e21:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1e24:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e27:	8b 55 10             	mov    0x10(%ebp),%edx
    1e2a:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1e2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e30:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1e37:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e3a:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1e41:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e44:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1e4b:	e9 8d 00 00 00       	jmp    1edd <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1e50:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e53:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1e5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e5d:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1e64:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e67:	8b 40 20             	mov    0x20(%eax),%eax
    1e6a:	89 c2                	mov    %eax,%edx
    1e6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e6f:	8b 40 24             	mov    0x24(%eax),%eax
    1e72:	0f af d0             	imul   %eax,%edx
    1e75:	89 d0                	mov    %edx,%eax
    1e77:	01 c0                	add    %eax,%eax
    1e79:	01 d0                	add    %edx,%eax
    1e7b:	83 ec 0c             	sub    $0xc,%esp
    1e7e:	50                   	push   %eax
    1e7f:	e8 43 f1 ff ff       	call   fc7 <malloc>
    1e84:	83 c4 10             	add    $0x10,%esp
    1e87:	89 c2                	mov    %eax,%edx
    1e89:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e8c:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1e8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e92:	8b 40 38             	mov    0x38(%eax),%eax
    1e95:	85 c0                	test   %eax,%eax
    1e97:	75 15                	jne    1eae <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1e99:	83 ec 04             	sub    $0x4,%esp
    1e9c:	ff 75 08             	pushl  0x8(%ebp)
    1e9f:	68 e0 2b 00 00       	push   $0x2be0
    1ea4:	6a 01                	push   $0x1
    1ea6:	e8 49 ee ff ff       	call   cf4 <printf>
    1eab:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1eae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1eb1:	8b 40 20             	mov    0x20(%eax),%eax
    1eb4:	89 c2                	mov    %eax,%edx
    1eb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1eb9:	8b 40 24             	mov    0x24(%eax),%eax
    1ebc:	0f af d0             	imul   %eax,%edx
    1ebf:	89 d0                	mov    %edx,%eax
    1ec1:	01 c0                	add    %eax,%eax
    1ec3:	01 c2                	add    %eax,%edx
    1ec5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ec8:	8b 40 38             	mov    0x38(%eax),%eax
    1ecb:	83 ec 04             	sub    $0x4,%esp
    1ece:	52                   	push   %edx
    1ecf:	68 ff ff ff 00       	push   $0xffffff
    1ed4:	50                   	push   %eax
    1ed5:	e8 d0 ea ff ff       	call   9aa <memset>
    1eda:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1edd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1ee0:	c9                   	leave  
    1ee1:	c3                   	ret    

00001ee2 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1ee2:	55                   	push   %ebp
    1ee3:	89 e5                	mov    %esp,%ebp
    1ee5:	57                   	push   %edi
    1ee6:	56                   	push   %esi
    1ee7:	53                   	push   %ebx
    1ee8:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1eeb:	8b 45 0c             	mov    0xc(%ebp),%eax
    1eee:	83 f8 03             	cmp    $0x3,%eax
    1ef1:	74 02                	je     1ef5 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1ef3:	eb 7c                	jmp    1f71 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1ef5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef8:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1efb:	8b 45 08             	mov    0x8(%ebp),%eax
    1efe:	8b 48 18             	mov    0x18(%eax),%ecx
    1f01:	8b 45 08             	mov    0x8(%ebp),%eax
    1f04:	8b 50 5c             	mov    0x5c(%eax),%edx
    1f07:	8b 45 08             	mov    0x8(%ebp),%eax
    1f0a:	8b 40 58             	mov    0x58(%eax),%eax
    1f0d:	8b 75 08             	mov    0x8(%ebp),%esi
    1f10:	83 c6 58             	add    $0x58,%esi
    1f13:	83 ec 04             	sub    $0x4,%esp
    1f16:	53                   	push   %ebx
    1f17:	51                   	push   %ecx
    1f18:	6a 00                	push   $0x0
    1f1a:	52                   	push   %edx
    1f1b:	50                   	push   %eax
    1f1c:	6a 00                	push   $0x0
    1f1e:	6a 00                	push   $0x0
    1f20:	56                   	push   %esi
    1f21:	6a 00                	push   $0x0
    1f23:	6a 00                	push   $0x0
    1f25:	ff 75 08             	pushl  0x8(%ebp)
    1f28:	e8 b8 ec ff ff       	call   be5 <paintWindow>
    1f2d:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1f30:	8b 45 08             	mov    0x8(%ebp),%eax
    1f33:	8b 70 1c             	mov    0x1c(%eax),%esi
    1f36:	8b 45 08             	mov    0x8(%ebp),%eax
    1f39:	8b 58 18             	mov    0x18(%eax),%ebx
    1f3c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f3f:	8b 48 08             	mov    0x8(%eax),%ecx
    1f42:	8b 45 08             	mov    0x8(%ebp),%eax
    1f45:	8b 50 40             	mov    0x40(%eax),%edx
    1f48:	8b 45 08             	mov    0x8(%ebp),%eax
    1f4b:	8b 40 3c             	mov    0x3c(%eax),%eax
    1f4e:	8b 7d 08             	mov    0x8(%ebp),%edi
    1f51:	83 c7 3c             	add    $0x3c,%edi
    1f54:	83 ec 04             	sub    $0x4,%esp
    1f57:	56                   	push   %esi
    1f58:	53                   	push   %ebx
    1f59:	51                   	push   %ecx
    1f5a:	52                   	push   %edx
    1f5b:	50                   	push   %eax
    1f5c:	6a 00                	push   $0x0
    1f5e:	6a 00                	push   $0x0
    1f60:	57                   	push   %edi
    1f61:	6a 32                	push   $0x32
    1f63:	6a 00                	push   $0x0
    1f65:	ff 75 08             	pushl  0x8(%ebp)
    1f68:	e8 78 ec ff ff       	call   be5 <paintWindow>
    1f6d:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1f70:	90                   	nop
        default: break;
            
            
    }
    return False;
    1f71:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1f76:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1f79:	5b                   	pop    %ebx
    1f7a:	5e                   	pop    %esi
    1f7b:	5f                   	pop    %edi
    1f7c:	5d                   	pop    %ebp
    1f7d:	c3                   	ret    

00001f7e <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1f7e:	55                   	push   %ebp
    1f7f:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1f81:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f84:	8b 50 08             	mov    0x8(%eax),%edx
    1f87:	8b 45 08             	mov    0x8(%ebp),%eax
    1f8a:	8b 00                	mov    (%eax),%eax
    1f8c:	39 c2                	cmp    %eax,%edx
    1f8e:	74 07                	je     1f97 <APPreJudge+0x19>
        return False;
    1f90:	b8 00 00 00 00       	mov    $0x0,%eax
    1f95:	eb 05                	jmp    1f9c <APPreJudge+0x1e>
    return True;
    1f97:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1f9c:	5d                   	pop    %ebp
    1f9d:	c3                   	ret    

00001f9e <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1f9e:	55                   	push   %ebp
    1f9f:	89 e5                	mov    %esp,%ebp
    1fa1:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1fa4:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa7:	8b 55 0c             	mov    0xc(%ebp),%edx
    1faa:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1fb0:	83 ec 0c             	sub    $0xc,%esp
    1fb3:	ff 75 08             	pushl  0x8(%ebp)
    1fb6:	e8 42 ec ff ff       	call   bfd <registWindow>
    1fbb:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1fbe:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1fc5:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc8:	8b 00                	mov    (%eax),%eax
    1fca:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1fcd:	ff 75 f4             	pushl  -0xc(%ebp)
    1fd0:	ff 75 f0             	pushl  -0x10(%ebp)
    1fd3:	ff 75 ec             	pushl  -0x14(%ebp)
    1fd6:	ff 75 08             	pushl  0x8(%ebp)
    1fd9:	e8 80 fc ff ff       	call   1c5e <APSendMessage>
    1fde:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1fe1:	83 ec 0c             	sub    $0xc,%esp
    1fe4:	ff 75 08             	pushl  0x8(%ebp)
    1fe7:	e8 09 ec ff ff       	call   bf5 <getMessage>
    1fec:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1fef:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff2:	83 c0 74             	add    $0x74,%eax
    1ff5:	83 ec 08             	sub    $0x8,%esp
    1ff8:	50                   	push   %eax
    1ff9:	ff 75 08             	pushl  0x8(%ebp)
    1ffc:	e8 7d ff ff ff       	call   1f7e <APPreJudge>
    2001:	83 c4 10             	add    $0x10,%esp
    2004:	84 c0                	test   %al,%al
    2006:	74 1b                	je     2023 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    2008:	8b 45 08             	mov    0x8(%ebp),%eax
    200b:	ff 70 7c             	pushl  0x7c(%eax)
    200e:	ff 70 78             	pushl  0x78(%eax)
    2011:	ff 70 74             	pushl  0x74(%eax)
    2014:	ff 75 08             	pushl  0x8(%ebp)
    2017:	8b 45 0c             	mov    0xc(%ebp),%eax
    201a:	ff d0                	call   *%eax
    201c:	83 c4 10             	add    $0x10,%esp
    201f:	84 c0                	test   %al,%al
    2021:	75 0c                	jne    202f <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    2023:	8b 45 08             	mov    0x8(%ebp),%eax
    2026:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    202d:	eb b2                	jmp    1fe1 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    202f:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    2030:	90                   	nop
    2031:	c9                   	leave  
    2032:	c3                   	ret    

00002033 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    2033:	55                   	push   %ebp
    2034:	89 e5                	mov    %esp,%ebp
    2036:	57                   	push   %edi
    2037:	56                   	push   %esi
    2038:	53                   	push   %ebx
    2039:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    203c:	a1 ac 33 00 00       	mov    0x33ac,%eax
    2041:	85 c0                	test   %eax,%eax
    2043:	0f 85 2c 02 00 00    	jne    2275 <APGridPaint+0x242>
    {
        iconReady = 1;
    2049:	c7 05 ac 33 00 00 01 	movl   $0x1,0x33ac
    2050:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    2053:	8d 45 98             	lea    -0x68(%ebp),%eax
    2056:	83 ec 08             	sub    $0x8,%esp
    2059:	68 07 2c 00 00       	push   $0x2c07
    205e:	50                   	push   %eax
    205f:	e8 16 f1 ff ff       	call   117a <APLoadBitmap>
    2064:	83 c4 0c             	add    $0xc,%esp
    2067:	8b 45 98             	mov    -0x68(%ebp),%eax
    206a:	a3 a4 78 00 00       	mov    %eax,0x78a4
    206f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2072:	a3 a8 78 00 00       	mov    %eax,0x78a8
    2077:	8b 45 a0             	mov    -0x60(%ebp),%eax
    207a:	a3 ac 78 00 00       	mov    %eax,0x78ac
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    207f:	83 ec 04             	sub    $0x4,%esp
    2082:	ff 35 ac 78 00 00    	pushl  0x78ac
    2088:	ff 35 a8 78 00 00    	pushl  0x78a8
    208e:	ff 35 a4 78 00 00    	pushl  0x78a4
    2094:	e8 1b f3 ff ff       	call   13b4 <APCreateCompatibleDCFromBitmap>
    2099:	83 c4 10             	add    $0x10,%esp
    209c:	a3 b8 78 00 00       	mov    %eax,0x78b8
        grid_river = APLoadBitmap ("grid_river.bmp");
    20a1:	8d 45 98             	lea    -0x68(%ebp),%eax
    20a4:	83 ec 08             	sub    $0x8,%esp
    20a7:	68 15 2c 00 00       	push   $0x2c15
    20ac:	50                   	push   %eax
    20ad:	e8 c8 f0 ff ff       	call   117a <APLoadBitmap>
    20b2:	83 c4 0c             	add    $0xc,%esp
    20b5:	8b 45 98             	mov    -0x68(%ebp),%eax
    20b8:	a3 2c 8a 00 00       	mov    %eax,0x8a2c
    20bd:	8b 45 9c             	mov    -0x64(%ebp),%eax
    20c0:	a3 30 8a 00 00       	mov    %eax,0x8a30
    20c5:	8b 45 a0             	mov    -0x60(%ebp),%eax
    20c8:	a3 34 8a 00 00       	mov    %eax,0x8a34
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    20cd:	83 ec 04             	sub    $0x4,%esp
    20d0:	ff 35 34 8a 00 00    	pushl  0x8a34
    20d6:	ff 35 30 8a 00 00    	pushl  0x8a30
    20dc:	ff 35 2c 8a 00 00    	pushl  0x8a2c
    20e2:	e8 cd f2 ff ff       	call   13b4 <APCreateCompatibleDCFromBitmap>
    20e7:	83 c4 10             	add    $0x10,%esp
    20ea:	a3 1c 8a 00 00       	mov    %eax,0x8a1c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    20ef:	8d 45 98             	lea    -0x68(%ebp),%eax
    20f2:	83 ec 08             	sub    $0x8,%esp
    20f5:	68 24 2c 00 00       	push   $0x2c24
    20fa:	50                   	push   %eax
    20fb:	e8 7a f0 ff ff       	call   117a <APLoadBitmap>
    2100:	83 c4 0c             	add    $0xc,%esp
    2103:	8b 45 98             	mov    -0x68(%ebp),%eax
    2106:	a3 20 8a 00 00       	mov    %eax,0x8a20
    210b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    210e:	a3 24 8a 00 00       	mov    %eax,0x8a24
    2113:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2116:	a3 28 8a 00 00       	mov    %eax,0x8a28
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    211b:	83 ec 04             	sub    $0x4,%esp
    211e:	ff 35 28 8a 00 00    	pushl  0x8a28
    2124:	ff 35 24 8a 00 00    	pushl  0x8a24
    212a:	ff 35 20 8a 00 00    	pushl  0x8a20
    2130:	e8 7f f2 ff ff       	call   13b4 <APCreateCompatibleDCFromBitmap>
    2135:	83 c4 10             	add    $0x10,%esp
    2138:	a3 84 78 00 00       	mov    %eax,0x7884
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    213d:	8d 45 98             	lea    -0x68(%ebp),%eax
    2140:	83 ec 08             	sub    $0x8,%esp
    2143:	68 33 2c 00 00       	push   $0x2c33
    2148:	50                   	push   %eax
    2149:	e8 2c f0 ff ff       	call   117a <APLoadBitmap>
    214e:	83 c4 0c             	add    $0xc,%esp
    2151:	8b 45 98             	mov    -0x68(%ebp),%eax
    2154:	a3 c0 78 00 00       	mov    %eax,0x78c0
    2159:	8b 45 9c             	mov    -0x64(%ebp),%eax
    215c:	a3 c4 78 00 00       	mov    %eax,0x78c4
    2161:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2164:	a3 c8 78 00 00       	mov    %eax,0x78c8
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    2169:	83 ec 04             	sub    $0x4,%esp
    216c:	ff 35 c8 78 00 00    	pushl  0x78c8
    2172:	ff 35 c4 78 00 00    	pushl  0x78c4
    2178:	ff 35 c0 78 00 00    	pushl  0x78c0
    217e:	e8 31 f2 ff ff       	call   13b4 <APCreateCompatibleDCFromBitmap>
    2183:	83 c4 10             	add    $0x10,%esp
    2186:	a3 38 8a 00 00       	mov    %eax,0x8a38
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    218b:	8d 45 98             	lea    -0x68(%ebp),%eax
    218e:	83 ec 08             	sub    $0x8,%esp
    2191:	68 41 2c 00 00       	push   $0x2c41
    2196:	50                   	push   %eax
    2197:	e8 de ef ff ff       	call   117a <APLoadBitmap>
    219c:	83 c4 0c             	add    $0xc,%esp
    219f:	8b 45 98             	mov    -0x68(%ebp),%eax
    21a2:	a3 94 78 00 00       	mov    %eax,0x7894
    21a7:	8b 45 9c             	mov    -0x64(%ebp),%eax
    21aa:	a3 98 78 00 00       	mov    %eax,0x7898
    21af:	8b 45 a0             	mov    -0x60(%ebp),%eax
    21b2:	a3 9c 78 00 00       	mov    %eax,0x789c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    21b7:	83 ec 04             	sub    $0x4,%esp
    21ba:	ff 35 9c 78 00 00    	pushl  0x789c
    21c0:	ff 35 98 78 00 00    	pushl  0x7898
    21c6:	ff 35 94 78 00 00    	pushl  0x7894
    21cc:	e8 e3 f1 ff ff       	call   13b4 <APCreateCompatibleDCFromBitmap>
    21d1:	83 c4 10             	add    $0x10,%esp
    21d4:	a3 bc 78 00 00       	mov    %eax,0x78bc
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    21d9:	8d 45 98             	lea    -0x68(%ebp),%eax
    21dc:	83 ec 08             	sub    $0x8,%esp
    21df:	68 51 2c 00 00       	push   $0x2c51
    21e4:	50                   	push   %eax
    21e5:	e8 90 ef ff ff       	call   117a <APLoadBitmap>
    21ea:	83 c4 0c             	add    $0xc,%esp
    21ed:	8b 45 98             	mov    -0x68(%ebp),%eax
    21f0:	a3 88 78 00 00       	mov    %eax,0x7888
    21f5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    21f8:	a3 8c 78 00 00       	mov    %eax,0x788c
    21fd:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2200:	a3 90 78 00 00       	mov    %eax,0x7890
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    2205:	83 ec 04             	sub    $0x4,%esp
    2208:	ff 35 90 78 00 00    	pushl  0x7890
    220e:	ff 35 8c 78 00 00    	pushl  0x788c
    2214:	ff 35 88 78 00 00    	pushl  0x7888
    221a:	e8 95 f1 ff ff       	call   13b4 <APCreateCompatibleDCFromBitmap>
    221f:	83 c4 10             	add    $0x10,%esp
    2222:	a3 a0 78 00 00       	mov    %eax,0x78a0
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    2227:	8d 45 98             	lea    -0x68(%ebp),%eax
    222a:	83 ec 08             	sub    $0x8,%esp
    222d:	68 63 2c 00 00       	push   $0x2c63
    2232:	50                   	push   %eax
    2233:	e8 42 ef ff ff       	call   117a <APLoadBitmap>
    2238:	83 c4 0c             	add    $0xc,%esp
    223b:	8b 45 98             	mov    -0x68(%ebp),%eax
    223e:	a3 10 8a 00 00       	mov    %eax,0x8a10
    2243:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2246:	a3 14 8a 00 00       	mov    %eax,0x8a14
    224b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    224e:	a3 18 8a 00 00       	mov    %eax,0x8a18
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    2253:	83 ec 04             	sub    $0x4,%esp
    2256:	ff 35 18 8a 00 00    	pushl  0x8a18
    225c:	ff 35 14 8a 00 00    	pushl  0x8a14
    2262:	ff 35 10 8a 00 00    	pushl  0x8a10
    2268:	e8 47 f1 ff ff       	call   13b4 <APCreateCompatibleDCFromBitmap>
    226d:	83 c4 10             	add    $0x10,%esp
    2270:	a3 3c 8a 00 00       	mov    %eax,0x8a3c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    2275:	8b 45 08             	mov    0x8(%ebp),%eax
    2278:	8b 40 08             	mov    0x8(%eax),%eax
    227b:	85 c0                	test   %eax,%eax
    227d:	75 17                	jne    2296 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    227f:	83 ec 08             	sub    $0x8,%esp
    2282:	68 74 2c 00 00       	push   $0x2c74
    2287:	6a 01                	push   $0x1
    2289:	e8 66 ea ff ff       	call   cf4 <printf>
    228e:	83 c4 10             	add    $0x10,%esp
        return;
    2291:	e9 a0 04 00 00       	jmp    2736 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    2296:	8b 45 08             	mov    0x8(%ebp),%eax
    2299:	8b 40 10             	mov    0x10(%eax),%eax
    229c:	85 c0                	test   %eax,%eax
    229e:	7e 10                	jle    22b0 <APGridPaint+0x27d>
    22a0:	8b 45 08             	mov    0x8(%ebp),%eax
    22a3:	8b 50 14             	mov    0x14(%eax),%edx
    22a6:	8b 45 08             	mov    0x8(%ebp),%eax
    22a9:	8b 40 10             	mov    0x10(%eax),%eax
    22ac:	39 c2                	cmp    %eax,%edx
    22ae:	7c 17                	jl     22c7 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    22b0:	83 ec 08             	sub    $0x8,%esp
    22b3:	68 9a 2c 00 00       	push   $0x2c9a
    22b8:	6a 01                	push   $0x1
    22ba:	e8 35 ea ff ff       	call   cf4 <printf>
    22bf:	83 c4 10             	add    $0x10,%esp
        return;
    22c2:	e9 6f 04 00 00       	jmp    2736 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    22c7:	8b 45 08             	mov    0x8(%ebp),%eax
    22ca:	8b 40 14             	mov    0x14(%eax),%eax
    22cd:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    22d3:	89 45 dc             	mov    %eax,-0x24(%ebp)
    22d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
    22d9:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    22dc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    22e3:	e9 96 03 00 00       	jmp    267e <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    22e8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    22ef:	e9 7c 03 00 00       	jmp    2670 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    22f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22f7:	c1 e0 04             	shl    $0x4,%eax
    22fa:	89 c2                	mov    %eax,%edx
    22fc:	8b 45 d8             	mov    -0x28(%ebp),%eax
    22ff:	01 c2                	add    %eax,%edx
    2301:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2304:	01 d0                	add    %edx,%eax
    2306:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    2309:	8b 45 08             	mov    0x8(%ebp),%eax
    230c:	8b 40 0c             	mov    0xc(%eax),%eax
    230f:	8b 55 dc             	mov    -0x24(%ebp),%edx
    2312:	c1 e2 02             	shl    $0x2,%edx
    2315:	01 d0                	add    %edx,%eax
    2317:	8b 00                	mov    (%eax),%eax
    2319:	83 f8 07             	cmp    $0x7,%eax
    231c:	0f 87 49 03 00 00    	ja     266b <APGridPaint+0x638>
    2322:	8b 04 85 b0 2c 00 00 	mov    0x2cb0(,%eax,4),%eax
    2329:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    232b:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    232e:	6a 0c                	push   $0xc
    2330:	6a 0c                	push   $0xc
    2332:	6a 0c                	push   $0xc
    2334:	50                   	push   %eax
    2335:	e8 df f8 ff ff       	call   1c19 <RGB>
    233a:	83 c4 0c             	add    $0xc,%esp
    233d:	8b 1d b8 78 00 00    	mov    0x78b8,%ebx
    2343:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2346:	6b c8 32             	imul   $0x32,%eax,%ecx
    2349:	8b 45 e0             	mov    -0x20(%ebp),%eax
    234c:	6b c0 32             	imul   $0x32,%eax,%eax
    234f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2352:	8b 45 08             	mov    0x8(%ebp),%eax
    2355:	8d 78 3c             	lea    0x3c(%eax),%edi
    2358:	83 ec 0c             	sub    $0xc,%esp
    235b:	83 ec 04             	sub    $0x4,%esp
    235e:	89 e0                	mov    %esp,%eax
    2360:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    2364:	66 89 30             	mov    %si,(%eax)
    2367:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    236b:	88 50 02             	mov    %dl,0x2(%eax)
    236e:	6a 32                	push   $0x32
    2370:	6a 32                	push   $0x32
    2372:	6a 00                	push   $0x0
    2374:	6a 00                	push   $0x0
    2376:	53                   	push   %ebx
    2377:	51                   	push   %ecx
    2378:	ff 75 94             	pushl  -0x6c(%ebp)
    237b:	57                   	push   %edi
    237c:	e8 f4 f6 ff ff       	call   1a75 <APDcCopy>
    2381:	83 c4 30             	add    $0x30,%esp
                    break;
    2384:	e9 e3 02 00 00       	jmp    266c <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    2389:	8d 45 98             	lea    -0x68(%ebp),%eax
    238c:	6a 69                	push   $0x69
    238e:	6a 69                	push   $0x69
    2390:	6a 69                	push   $0x69
    2392:	50                   	push   %eax
    2393:	e8 81 f8 ff ff       	call   1c19 <RGB>
    2398:	83 c4 0c             	add    $0xc,%esp
    239b:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    239f:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    23a3:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    23a7:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    23aa:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    23b1:	8d 45 98             	lea    -0x68(%ebp),%eax
    23b4:	6a 69                	push   $0x69
    23b6:	6a 69                	push   $0x69
    23b8:	6a 69                	push   $0x69
    23ba:	50                   	push   %eax
    23bb:	e8 59 f8 ff ff       	call   1c19 <RGB>
    23c0:	83 c4 0c             	add    $0xc,%esp
    23c3:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    23c7:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    23cb:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    23cf:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    23d2:	8b 45 08             	mov    0x8(%ebp),%eax
    23d5:	8d 50 3c             	lea    0x3c(%eax),%edx
    23d8:	8d 45 98             	lea    -0x68(%ebp),%eax
    23db:	ff 75 b0             	pushl  -0x50(%ebp)
    23de:	ff 75 ac             	pushl  -0x54(%ebp)
    23e1:	52                   	push   %edx
    23e2:	50                   	push   %eax
    23e3:	e8 61 f0 ff ff       	call   1449 <APSetPen>
    23e8:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    23eb:	8b 45 08             	mov    0x8(%ebp),%eax
    23ee:	8d 58 3c             	lea    0x3c(%eax),%ebx
    23f1:	8d 55 98             	lea    -0x68(%ebp),%edx
    23f4:	83 ec 04             	sub    $0x4,%esp
    23f7:	83 ec 04             	sub    $0x4,%esp
    23fa:	89 e0                	mov    %esp,%eax
    23fc:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    2400:	66 89 08             	mov    %cx,(%eax)
    2403:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    2407:	88 48 02             	mov    %cl,0x2(%eax)
    240a:	53                   	push   %ebx
    240b:	52                   	push   %edx
    240c:	e8 71 f0 ff ff       	call   1482 <APSetBrush>
    2411:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    2414:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2417:	6b d0 32             	imul   $0x32,%eax,%edx
    241a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    241d:	6b c0 32             	imul   $0x32,%eax,%eax
    2420:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2423:	83 c1 3c             	add    $0x3c,%ecx
    2426:	83 ec 0c             	sub    $0xc,%esp
    2429:	6a 32                	push   $0x32
    242b:	6a 32                	push   $0x32
    242d:	52                   	push   %edx
    242e:	50                   	push   %eax
    242f:	51                   	push   %ecx
    2430:	e8 35 f4 ff ff       	call   186a <APDrawRect>
    2435:	83 c4 20             	add    $0x20,%esp
                    break;
    2438:	e9 2f 02 00 00       	jmp    266c <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    243d:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    2440:	6a 0c                	push   $0xc
    2442:	6a 0c                	push   $0xc
    2444:	6a 0c                	push   $0xc
    2446:	50                   	push   %eax
    2447:	e8 cd f7 ff ff       	call   1c19 <RGB>
    244c:	83 c4 0c             	add    $0xc,%esp
    244f:	8b 1d 3c 8a 00 00    	mov    0x8a3c,%ebx
    2455:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2458:	6b c8 32             	imul   $0x32,%eax,%ecx
    245b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    245e:	6b c0 32             	imul   $0x32,%eax,%eax
    2461:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2464:	8b 45 08             	mov    0x8(%ebp),%eax
    2467:	8d 78 3c             	lea    0x3c(%eax),%edi
    246a:	83 ec 0c             	sub    $0xc,%esp
    246d:	83 ec 04             	sub    $0x4,%esp
    2470:	89 e0                	mov    %esp,%eax
    2472:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2476:	66 89 30             	mov    %si,(%eax)
    2479:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    247d:	88 50 02             	mov    %dl,0x2(%eax)
    2480:	6a 32                	push   $0x32
    2482:	6a 32                	push   $0x32
    2484:	6a 00                	push   $0x0
    2486:	6a 00                	push   $0x0
    2488:	53                   	push   %ebx
    2489:	51                   	push   %ecx
    248a:	ff 75 94             	pushl  -0x6c(%ebp)
    248d:	57                   	push   %edi
    248e:	e8 e2 f5 ff ff       	call   1a75 <APDcCopy>
    2493:	83 c4 30             	add    $0x30,%esp
                    break;
    2496:	e9 d1 01 00 00       	jmp    266c <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    249b:	8d 45 c9             	lea    -0x37(%ebp),%eax
    249e:	6a 0c                	push   $0xc
    24a0:	6a 0c                	push   $0xc
    24a2:	6a 0c                	push   $0xc
    24a4:	50                   	push   %eax
    24a5:	e8 6f f7 ff ff       	call   1c19 <RGB>
    24aa:	83 c4 0c             	add    $0xc,%esp
    24ad:	8b 1d 1c 8a 00 00    	mov    0x8a1c,%ebx
    24b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24b6:	6b c8 32             	imul   $0x32,%eax,%ecx
    24b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    24bc:	6b c0 32             	imul   $0x32,%eax,%eax
    24bf:	89 45 94             	mov    %eax,-0x6c(%ebp)
    24c2:	8b 45 08             	mov    0x8(%ebp),%eax
    24c5:	8d 78 3c             	lea    0x3c(%eax),%edi
    24c8:	83 ec 0c             	sub    $0xc,%esp
    24cb:	83 ec 04             	sub    $0x4,%esp
    24ce:	89 e0                	mov    %esp,%eax
    24d0:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    24d4:	66 89 30             	mov    %si,(%eax)
    24d7:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    24db:	88 50 02             	mov    %dl,0x2(%eax)
    24de:	6a 32                	push   $0x32
    24e0:	6a 32                	push   $0x32
    24e2:	6a 00                	push   $0x0
    24e4:	6a 00                	push   $0x0
    24e6:	53                   	push   %ebx
    24e7:	51                   	push   %ecx
    24e8:	ff 75 94             	pushl  -0x6c(%ebp)
    24eb:	57                   	push   %edi
    24ec:	e8 84 f5 ff ff       	call   1a75 <APDcCopy>
    24f1:	83 c4 30             	add    $0x30,%esp
                    break;
    24f4:	e9 73 01 00 00       	jmp    266c <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    24f9:	8d 45 cc             	lea    -0x34(%ebp),%eax
    24fc:	6a 0c                	push   $0xc
    24fe:	6a 0c                	push   $0xc
    2500:	6a 0c                	push   $0xc
    2502:	50                   	push   %eax
    2503:	e8 11 f7 ff ff       	call   1c19 <RGB>
    2508:	83 c4 0c             	add    $0xc,%esp
    250b:	8b 1d bc 78 00 00    	mov    0x78bc,%ebx
    2511:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2514:	6b c8 32             	imul   $0x32,%eax,%ecx
    2517:	8b 45 e0             	mov    -0x20(%ebp),%eax
    251a:	6b c0 32             	imul   $0x32,%eax,%eax
    251d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2520:	8b 45 08             	mov    0x8(%ebp),%eax
    2523:	8d 78 3c             	lea    0x3c(%eax),%edi
    2526:	83 ec 0c             	sub    $0xc,%esp
    2529:	83 ec 04             	sub    $0x4,%esp
    252c:	89 e0                	mov    %esp,%eax
    252e:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    2532:	66 89 30             	mov    %si,(%eax)
    2535:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    2539:	88 50 02             	mov    %dl,0x2(%eax)
    253c:	6a 32                	push   $0x32
    253e:	6a 32                	push   $0x32
    2540:	6a 00                	push   $0x0
    2542:	6a 00                	push   $0x0
    2544:	53                   	push   %ebx
    2545:	51                   	push   %ecx
    2546:	ff 75 94             	pushl  -0x6c(%ebp)
    2549:	57                   	push   %edi
    254a:	e8 26 f5 ff ff       	call   1a75 <APDcCopy>
    254f:	83 c4 30             	add    $0x30,%esp
                    break;
    2552:	e9 15 01 00 00       	jmp    266c <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2557:	8d 45 cf             	lea    -0x31(%ebp),%eax
    255a:	6a 0c                	push   $0xc
    255c:	6a 0c                	push   $0xc
    255e:	6a 0c                	push   $0xc
    2560:	50                   	push   %eax
    2561:	e8 b3 f6 ff ff       	call   1c19 <RGB>
    2566:	83 c4 0c             	add    $0xc,%esp
    2569:	8b 1d 38 8a 00 00    	mov    0x8a38,%ebx
    256f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2572:	6b c8 32             	imul   $0x32,%eax,%ecx
    2575:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2578:	6b c0 32             	imul   $0x32,%eax,%eax
    257b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    257e:	8b 45 08             	mov    0x8(%ebp),%eax
    2581:	8d 78 3c             	lea    0x3c(%eax),%edi
    2584:	83 ec 0c             	sub    $0xc,%esp
    2587:	83 ec 04             	sub    $0x4,%esp
    258a:	89 e0                	mov    %esp,%eax
    258c:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2590:	66 89 30             	mov    %si,(%eax)
    2593:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2597:	88 50 02             	mov    %dl,0x2(%eax)
    259a:	6a 32                	push   $0x32
    259c:	6a 32                	push   $0x32
    259e:	6a 00                	push   $0x0
    25a0:	6a 00                	push   $0x0
    25a2:	53                   	push   %ebx
    25a3:	51                   	push   %ecx
    25a4:	ff 75 94             	pushl  -0x6c(%ebp)
    25a7:	57                   	push   %edi
    25a8:	e8 c8 f4 ff ff       	call   1a75 <APDcCopy>
    25ad:	83 c4 30             	add    $0x30,%esp
                    break;
    25b0:	e9 b7 00 00 00       	jmp    266c <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    25b5:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    25b8:	6a 0c                	push   $0xc
    25ba:	6a 0c                	push   $0xc
    25bc:	6a 0c                	push   $0xc
    25be:	50                   	push   %eax
    25bf:	e8 55 f6 ff ff       	call   1c19 <RGB>
    25c4:	83 c4 0c             	add    $0xc,%esp
    25c7:	8b 1d 84 78 00 00    	mov    0x7884,%ebx
    25cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    25d0:	6b c8 32             	imul   $0x32,%eax,%ecx
    25d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    25d6:	6b c0 32             	imul   $0x32,%eax,%eax
    25d9:	89 45 94             	mov    %eax,-0x6c(%ebp)
    25dc:	8b 45 08             	mov    0x8(%ebp),%eax
    25df:	8d 78 3c             	lea    0x3c(%eax),%edi
    25e2:	83 ec 0c             	sub    $0xc,%esp
    25e5:	83 ec 04             	sub    $0x4,%esp
    25e8:	89 e0                	mov    %esp,%eax
    25ea:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    25ee:	66 89 30             	mov    %si,(%eax)
    25f1:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    25f5:	88 50 02             	mov    %dl,0x2(%eax)
    25f8:	6a 32                	push   $0x32
    25fa:	6a 32                	push   $0x32
    25fc:	6a 00                	push   $0x0
    25fe:	6a 00                	push   $0x0
    2600:	53                   	push   %ebx
    2601:	51                   	push   %ecx
    2602:	ff 75 94             	pushl  -0x6c(%ebp)
    2605:	57                   	push   %edi
    2606:	e8 6a f4 ff ff       	call   1a75 <APDcCopy>
    260b:	83 c4 30             	add    $0x30,%esp
                    break;
    260e:	eb 5c                	jmp    266c <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2610:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    2613:	6a 0c                	push   $0xc
    2615:	6a 0c                	push   $0xc
    2617:	6a 0c                	push   $0xc
    2619:	50                   	push   %eax
    261a:	e8 fa f5 ff ff       	call   1c19 <RGB>
    261f:	83 c4 0c             	add    $0xc,%esp
    2622:	8b 1d a0 78 00 00    	mov    0x78a0,%ebx
    2628:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    262b:	6b c8 32             	imul   $0x32,%eax,%ecx
    262e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2631:	6b c0 32             	imul   $0x32,%eax,%eax
    2634:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2637:	8b 45 08             	mov    0x8(%ebp),%eax
    263a:	8d 78 3c             	lea    0x3c(%eax),%edi
    263d:	83 ec 0c             	sub    $0xc,%esp
    2640:	83 ec 04             	sub    $0x4,%esp
    2643:	89 e0                	mov    %esp,%eax
    2645:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2649:	66 89 30             	mov    %si,(%eax)
    264c:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2650:	88 50 02             	mov    %dl,0x2(%eax)
    2653:	6a 32                	push   $0x32
    2655:	6a 32                	push   $0x32
    2657:	6a 00                	push   $0x0
    2659:	6a 00                	push   $0x0
    265b:	53                   	push   %ebx
    265c:	51                   	push   %ecx
    265d:	ff 75 94             	pushl  -0x6c(%ebp)
    2660:	57                   	push   %edi
    2661:	e8 0f f4 ff ff       	call   1a75 <APDcCopy>
    2666:	83 c4 30             	add    $0x30,%esp
                    break;
    2669:	eb 01                	jmp    266c <APGridPaint+0x639>
                default: break;
    266b:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    266c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2670:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2674:	0f 8e 7a fc ff ff    	jle    22f4 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    267a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    267e:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2682:	0f 8e 60 fc ff ff    	jle    22e8 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2688:	8d 45 98             	lea    -0x68(%ebp),%eax
    268b:	68 cd 00 00 00       	push   $0xcd
    2690:	6a 74                	push   $0x74
    2692:	6a 18                	push   $0x18
    2694:	50                   	push   %eax
    2695:	e8 7f f5 ff ff       	call   1c19 <RGB>
    269a:	83 c4 0c             	add    $0xc,%esp
    269d:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    26a1:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    26a5:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    26a9:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    26ac:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    26b3:	8d 45 98             	lea    -0x68(%ebp),%eax
    26b6:	68 cd 00 00 00       	push   $0xcd
    26bb:	6a 74                	push   $0x74
    26bd:	6a 18                	push   $0x18
    26bf:	50                   	push   %eax
    26c0:	e8 54 f5 ff ff       	call   1c19 <RGB>
    26c5:	83 c4 0c             	add    $0xc,%esp
    26c8:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    26cc:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    26d0:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    26d4:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    26d7:	8b 45 08             	mov    0x8(%ebp),%eax
    26da:	8d 50 58             	lea    0x58(%eax),%edx
    26dd:	8d 45 98             	lea    -0x68(%ebp),%eax
    26e0:	ff 75 bc             	pushl  -0x44(%ebp)
    26e3:	ff 75 b8             	pushl  -0x48(%ebp)
    26e6:	52                   	push   %edx
    26e7:	50                   	push   %eax
    26e8:	e8 5c ed ff ff       	call   1449 <APSetPen>
    26ed:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    26f0:	8b 45 08             	mov    0x8(%ebp),%eax
    26f3:	8d 58 58             	lea    0x58(%eax),%ebx
    26f6:	8d 55 98             	lea    -0x68(%ebp),%edx
    26f9:	83 ec 04             	sub    $0x4,%esp
    26fc:	83 ec 04             	sub    $0x4,%esp
    26ff:	89 e0                	mov    %esp,%eax
    2701:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    2705:	66 89 08             	mov    %cx,(%eax)
    2708:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    270c:	88 48 02             	mov    %cl,0x2(%eax)
    270f:	53                   	push   %ebx
    2710:	52                   	push   %edx
    2711:	e8 6c ed ff ff       	call   1482 <APSetBrush>
    2716:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2719:	8b 45 08             	mov    0x8(%ebp),%eax
    271c:	83 c0 58             	add    $0x58,%eax
    271f:	83 ec 0c             	sub    $0xc,%esp
    2722:	6a 32                	push   $0x32
    2724:	68 20 03 00 00       	push   $0x320
    2729:	6a 00                	push   $0x0
    272b:	6a 00                	push   $0x0
    272d:	50                   	push   %eax
    272e:	e8 37 f1 ff ff       	call   186a <APDrawRect>
    2733:	83 c4 20             	add    $0x20,%esp
}
    2736:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2739:	5b                   	pop    %ebx
    273a:	5e                   	pop    %esi
    273b:	5f                   	pop    %edi
    273c:	5d                   	pop    %ebp
    273d:	c3                   	ret    

0000273e <random>:
//

#include "APLib.h"

int random(int seed)
{
    273e:	55                   	push   %ebp
    273f:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2741:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2745:	7e 08                	jle    274f <random+0x11>
{
rand_num = seed;
    2747:	8b 45 08             	mov    0x8(%ebp),%eax
    274a:	a3 80 33 00 00       	mov    %eax,0x3380
}
rand_num *= 3;
    274f:	8b 15 80 33 00 00    	mov    0x3380,%edx
    2755:	89 d0                	mov    %edx,%eax
    2757:	01 c0                	add    %eax,%eax
    2759:	01 d0                	add    %edx,%eax
    275b:	a3 80 33 00 00       	mov    %eax,0x3380
if (rand_num < 0)
    2760:	a1 80 33 00 00       	mov    0x3380,%eax
    2765:	85 c0                	test   %eax,%eax
    2767:	79 0c                	jns    2775 <random+0x37>
{
rand_num *= (-1);
    2769:	a1 80 33 00 00       	mov    0x3380,%eax
    276e:	f7 d8                	neg    %eax
    2770:	a3 80 33 00 00       	mov    %eax,0x3380
}
return rand_num % 997;
    2775:	8b 0d 80 33 00 00    	mov    0x3380,%ecx
    277b:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2780:	89 c8                	mov    %ecx,%eax
    2782:	f7 ea                	imul   %edx
    2784:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2787:	c1 f8 09             	sar    $0x9,%eax
    278a:	89 c2                	mov    %eax,%edx
    278c:	89 c8                	mov    %ecx,%eax
    278e:	c1 f8 1f             	sar    $0x1f,%eax
    2791:	29 c2                	sub    %eax,%edx
    2793:	89 d0                	mov    %edx,%eax
    2795:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    279b:	29 c1                	sub    %eax,%ecx
    279d:	89 c8                	mov    %ecx,%eax
}
    279f:	5d                   	pop    %ebp
    27a0:	c3                   	ret    

000027a1 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    27a1:	55                   	push   %ebp
    27a2:	89 e5                	mov    %esp,%ebp
    27a4:	53                   	push   %ebx
    27a5:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    27a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    27af:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    27b3:	74 17                	je     27cc <sprintint+0x2b>
    27b5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    27b9:	79 11                	jns    27cc <sprintint+0x2b>
        neg = 1;
    27bb:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    27c2:	8b 45 10             	mov    0x10(%ebp),%eax
    27c5:	f7 d8                	neg    %eax
    27c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    27ca:	eb 06                	jmp    27d2 <sprintint+0x31>
    } else {
        x = xx;
    27cc:	8b 45 10             	mov    0x10(%ebp),%eax
    27cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    27d2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    27d9:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    27dc:	8d 41 01             	lea    0x1(%ecx),%eax
    27df:	89 45 f8             	mov    %eax,-0x8(%ebp)
    27e2:	8b 5d 14             	mov    0x14(%ebp),%ebx
    27e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    27e8:	ba 00 00 00 00       	mov    $0x0,%edx
    27ed:	f7 f3                	div    %ebx
    27ef:	89 d0                	mov    %edx,%eax
    27f1:	0f b6 80 84 33 00 00 	movzbl 0x3384(%eax),%eax
    27f8:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    27fc:	8b 5d 14             	mov    0x14(%ebp),%ebx
    27ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2802:	ba 00 00 00 00       	mov    $0x0,%edx
    2807:	f7 f3                	div    %ebx
    2809:	89 45 f0             	mov    %eax,-0x10(%ebp)
    280c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2810:	75 c7                	jne    27d9 <sprintint+0x38>
    if(neg)
    2812:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2816:	74 0e                	je     2826 <sprintint+0x85>
        buf[i++] = '-';
    2818:	8b 45 f8             	mov    -0x8(%ebp),%eax
    281b:	8d 50 01             	lea    0x1(%eax),%edx
    281e:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2821:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2826:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2829:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    282c:	eb 1b                	jmp    2849 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    282e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2831:	8b 00                	mov    (%eax),%eax
    2833:	8d 48 01             	lea    0x1(%eax),%ecx
    2836:	8b 55 0c             	mov    0xc(%ebp),%edx
    2839:	89 0a                	mov    %ecx,(%edx)
    283b:	89 c2                	mov    %eax,%edx
    283d:	8b 45 08             	mov    0x8(%ebp),%eax
    2840:	01 d0                	add    %edx,%eax
    2842:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2845:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2849:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    284d:	7f df                	jg     282e <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    284f:	eb 21                	jmp    2872 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2851:	8b 45 0c             	mov    0xc(%ebp),%eax
    2854:	8b 00                	mov    (%eax),%eax
    2856:	8d 48 01             	lea    0x1(%eax),%ecx
    2859:	8b 55 0c             	mov    0xc(%ebp),%edx
    285c:	89 0a                	mov    %ecx,(%edx)
    285e:	89 c2                	mov    %eax,%edx
    2860:	8b 45 08             	mov    0x8(%ebp),%eax
    2863:	01 c2                	add    %eax,%edx
    2865:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2868:	8b 45 f8             	mov    -0x8(%ebp),%eax
    286b:	01 c8                	add    %ecx,%eax
    286d:	0f b6 00             	movzbl (%eax),%eax
    2870:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2872:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2876:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    287a:	79 d5                	jns    2851 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    287c:	90                   	nop
    287d:	83 c4 20             	add    $0x20,%esp
    2880:	5b                   	pop    %ebx
    2881:	5d                   	pop    %ebp
    2882:	c3                   	ret    

00002883 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2883:	55                   	push   %ebp
    2884:	89 e5                	mov    %esp,%ebp
    2886:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2889:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2890:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2897:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    289e:	8d 45 0c             	lea    0xc(%ebp),%eax
    28a1:	83 c0 04             	add    $0x4,%eax
    28a4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    28a7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    28ae:	e9 d9 01 00 00       	jmp    2a8c <sprintf+0x209>
        c = fmt[i] & 0xff;
    28b3:	8b 55 0c             	mov    0xc(%ebp),%edx
    28b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    28b9:	01 d0                	add    %edx,%eax
    28bb:	0f b6 00             	movzbl (%eax),%eax
    28be:	0f be c0             	movsbl %al,%eax
    28c1:	25 ff 00 00 00       	and    $0xff,%eax
    28c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    28c9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    28cd:	75 2c                	jne    28fb <sprintf+0x78>
            if(c == '%'){
    28cf:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    28d3:	75 0c                	jne    28e1 <sprintf+0x5e>
                state = '%';
    28d5:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    28dc:	e9 a7 01 00 00       	jmp    2a88 <sprintf+0x205>
            } else {
                dst[j++] = c;
    28e1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    28e4:	8d 50 01             	lea    0x1(%eax),%edx
    28e7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    28ea:	89 c2                	mov    %eax,%edx
    28ec:	8b 45 08             	mov    0x8(%ebp),%eax
    28ef:	01 d0                	add    %edx,%eax
    28f1:	8b 55 e0             	mov    -0x20(%ebp),%edx
    28f4:	88 10                	mov    %dl,(%eax)
    28f6:	e9 8d 01 00 00       	jmp    2a88 <sprintf+0x205>
            }
        } else if(state == '%'){
    28fb:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    28ff:	0f 85 83 01 00 00    	jne    2a88 <sprintf+0x205>
            if(c == 'd'){
    2905:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2909:	75 4c                	jne    2957 <sprintf+0xd4>
                buf[bi] = '\0';
    290b:	8d 55 ce             	lea    -0x32(%ebp),%edx
    290e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2911:	01 d0                	add    %edx,%eax
    2913:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2916:	83 ec 0c             	sub    $0xc,%esp
    2919:	8d 45 ce             	lea    -0x32(%ebp),%eax
    291c:	50                   	push   %eax
    291d:	e8 91 e1 ff ff       	call   ab3 <atoi>
    2922:	83 c4 10             	add    $0x10,%esp
    2925:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2928:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    292f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2932:	8b 00                	mov    (%eax),%eax
    2934:	83 ec 08             	sub    $0x8,%esp
    2937:	ff 75 d8             	pushl  -0x28(%ebp)
    293a:	6a 01                	push   $0x1
    293c:	6a 0a                	push   $0xa
    293e:	50                   	push   %eax
    293f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2942:	50                   	push   %eax
    2943:	ff 75 08             	pushl  0x8(%ebp)
    2946:	e8 56 fe ff ff       	call   27a1 <sprintint>
    294b:	83 c4 20             	add    $0x20,%esp
                ap++;
    294e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2952:	e9 2a 01 00 00       	jmp    2a81 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2957:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    295b:	74 06                	je     2963 <sprintf+0xe0>
    295d:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2961:	75 4c                	jne    29af <sprintf+0x12c>
                buf[bi] = '\0';
    2963:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2966:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2969:	01 d0                	add    %edx,%eax
    296b:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    296e:	83 ec 0c             	sub    $0xc,%esp
    2971:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2974:	50                   	push   %eax
    2975:	e8 39 e1 ff ff       	call   ab3 <atoi>
    297a:	83 c4 10             	add    $0x10,%esp
    297d:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2980:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2987:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    298a:	8b 00                	mov    (%eax),%eax
    298c:	83 ec 08             	sub    $0x8,%esp
    298f:	ff 75 dc             	pushl  -0x24(%ebp)
    2992:	6a 00                	push   $0x0
    2994:	6a 10                	push   $0x10
    2996:	50                   	push   %eax
    2997:	8d 45 c8             	lea    -0x38(%ebp),%eax
    299a:	50                   	push   %eax
    299b:	ff 75 08             	pushl  0x8(%ebp)
    299e:	e8 fe fd ff ff       	call   27a1 <sprintint>
    29a3:	83 c4 20             	add    $0x20,%esp
                ap++;
    29a6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    29aa:	e9 d2 00 00 00       	jmp    2a81 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    29af:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    29b3:	75 46                	jne    29fb <sprintf+0x178>
                s = (char*)*ap;
    29b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    29b8:	8b 00                	mov    (%eax),%eax
    29ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    29bd:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    29c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    29c5:	75 25                	jne    29ec <sprintf+0x169>
                    s = "(null)";
    29c7:	c7 45 f4 d0 2c 00 00 	movl   $0x2cd0,-0xc(%ebp)
                while(*s != 0){
    29ce:	eb 1c                	jmp    29ec <sprintf+0x169>
                    dst[j++] = *s;
    29d0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    29d3:	8d 50 01             	lea    0x1(%eax),%edx
    29d6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    29d9:	89 c2                	mov    %eax,%edx
    29db:	8b 45 08             	mov    0x8(%ebp),%eax
    29de:	01 c2                	add    %eax,%edx
    29e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    29e3:	0f b6 00             	movzbl (%eax),%eax
    29e6:	88 02                	mov    %al,(%edx)
                    s++;
    29e8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    29ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    29ef:	0f b6 00             	movzbl (%eax),%eax
    29f2:	84 c0                	test   %al,%al
    29f4:	75 da                	jne    29d0 <sprintf+0x14d>
    29f6:	e9 86 00 00 00       	jmp    2a81 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    29fb:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    29ff:	75 1d                	jne    2a1e <sprintf+0x19b>
                dst[j++] = *ap;
    2a01:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2a04:	8d 50 01             	lea    0x1(%eax),%edx
    2a07:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2a0a:	89 c2                	mov    %eax,%edx
    2a0c:	8b 45 08             	mov    0x8(%ebp),%eax
    2a0f:	01 c2                	add    %eax,%edx
    2a11:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2a14:	8b 00                	mov    (%eax),%eax
    2a16:	88 02                	mov    %al,(%edx)
                ap++;
    2a18:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2a1c:	eb 63                	jmp    2a81 <sprintf+0x1fe>
            } else if(c == '%'){
    2a1e:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2a22:	75 17                	jne    2a3b <sprintf+0x1b8>
                dst[j++] = c;
    2a24:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2a27:	8d 50 01             	lea    0x1(%eax),%edx
    2a2a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2a2d:	89 c2                	mov    %eax,%edx
    2a2f:	8b 45 08             	mov    0x8(%ebp),%eax
    2a32:	01 d0                	add    %edx,%eax
    2a34:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2a37:	88 10                	mov    %dl,(%eax)
    2a39:	eb 46                	jmp    2a81 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2a3b:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2a3f:	7e 18                	jle    2a59 <sprintf+0x1d6>
    2a41:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2a45:	7f 12                	jg     2a59 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2a47:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2a4a:	8d 50 01             	lea    0x1(%eax),%edx
    2a4d:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2a50:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2a53:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2a57:	eb 2f                	jmp    2a88 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2a59:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2a5c:	8d 50 01             	lea    0x1(%eax),%edx
    2a5f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2a62:	89 c2                	mov    %eax,%edx
    2a64:	8b 45 08             	mov    0x8(%ebp),%eax
    2a67:	01 d0                	add    %edx,%eax
    2a69:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2a6c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2a6f:	8d 50 01             	lea    0x1(%eax),%edx
    2a72:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2a75:	89 c2                	mov    %eax,%edx
    2a77:	8b 45 08             	mov    0x8(%ebp),%eax
    2a7a:	01 d0                	add    %edx,%eax
    2a7c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2a7f:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2a81:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2a88:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2a8c:	8b 55 0c             	mov    0xc(%ebp),%edx
    2a8f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2a92:	01 d0                	add    %edx,%eax
    2a94:	0f b6 00             	movzbl (%eax),%eax
    2a97:	84 c0                	test   %al,%al
    2a99:	0f 85 14 fe ff ff    	jne    28b3 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2a9f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2aa2:	8d 50 01             	lea    0x1(%eax),%edx
    2aa5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2aa8:	89 c2                	mov    %eax,%edx
    2aaa:	8b 45 08             	mov    0x8(%ebp),%eax
    2aad:	01 d0                	add    %edx,%eax
    2aaf:	c6 00 00             	movb   $0x0,(%eax)
}
    2ab2:	90                   	nop
    2ab3:	c9                   	leave  
    2ab4:	c3                   	ret    
