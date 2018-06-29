
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

int FirstTime = 1;

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
      d7:	8b 0d 9c ba 00 00    	mov    0xba9c,%ecx
      dd:	8b 15 a0 ba 00 00    	mov    0xbaa0,%edx
      e3:	a1 40 ba 00 00       	mov    0xba40,%eax
      e8:	6b c9 37             	imul   $0x37,%ecx,%ecx
      eb:	01 ca                	add    %ecx,%edx
      ed:	89 04 95 80 75 00 00 	mov    %eax,0x7580(,%edx,4)
	head  = nextpoint(head,current_direction);
      f4:	8b 15 40 ba 00 00    	mov    0xba40,%edx
      fa:	8d 45 e0             	lea    -0x20(%ebp),%eax
      fd:	52                   	push   %edx
      fe:	ff 35 a0 ba 00 00    	pushl  0xbaa0
     104:	ff 35 9c ba 00 00    	pushl  0xba9c
     10a:	50                   	push   %eax
     10b:	e8 35 ff ff ff       	call   45 <nextpoint>
     110:	83 c4 0c             	add    $0xc,%esp
     113:	8b 45 e0             	mov    -0x20(%ebp),%eax
     116:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     119:	a3 9c ba 00 00       	mov    %eax,0xba9c
     11e:	89 15 a0 ba 00 00    	mov    %edx,0xbaa0
	my_block[head.x][head.y] = current_direction;//head
     124:	8b 0d 9c ba 00 00    	mov    0xba9c,%ecx
     12a:	8b 15 a0 ba 00 00    	mov    0xbaa0,%edx
     130:	a1 40 ba 00 00       	mov    0xba40,%eax
     135:	6b c9 37             	imul   $0x37,%ecx,%ecx
     138:	01 ca                	add    %ecx,%edx
     13a:	89 04 95 80 75 00 00 	mov    %eax,0x7580(,%edx,4)
	if (my_food[head.x][head.y] == 0)
     141:	8b 15 9c ba 00 00    	mov    0xba9c,%edx
     147:	a1 a0 ba 00 00       	mov    0xbaa0,%eax
     14c:	6b d2 37             	imul   $0x37,%edx,%edx
     14f:	01 d0                	add    %edx,%eax
     151:	05 c0 ba 00 00       	add    $0xbac0,%eax
     156:	0f b6 00             	movzbl (%eax),%eax
     159:	84 c0                	test   %al,%al
     15b:	75 63                	jne    1c0 <Move+0xef>
	{
		int tem = my_block[tail.x][tail.y];
     15d:	8b 15 7c ba 00 00    	mov    0xba7c,%edx
     163:	a1 80 ba 00 00       	mov    0xba80,%eax
     168:	6b d2 37             	imul   $0x37,%edx,%edx
     16b:	01 d0                	add    %edx,%eax
     16d:	8b 04 85 80 75 00 00 	mov    0x7580(,%eax,4),%eax
     174:	89 45 f4             	mov    %eax,-0xc(%ebp)
		my_block[tail.x][tail.y] = NoDir;
     177:	8b 15 7c ba 00 00    	mov    0xba7c,%edx
     17d:	a1 80 ba 00 00       	mov    0xba80,%eax
     182:	6b d2 37             	imul   $0x37,%edx,%edx
     185:	01 d0                	add    %edx,%eax
     187:	c7 04 85 80 75 00 00 	movl   $0x0,0x7580(,%eax,4)
     18e:	00 00 00 00 
		tail = nextpoint(tail,tem);	
     192:	8d 45 e0             	lea    -0x20(%ebp),%eax
     195:	ff 75 f4             	pushl  -0xc(%ebp)
     198:	ff 35 80 ba 00 00    	pushl  0xba80
     19e:	ff 35 7c ba 00 00    	pushl  0xba7c
     1a4:	50                   	push   %eax
     1a5:	e8 9b fe ff ff       	call   45 <nextpoint>
     1aa:	83 c4 0c             	add    $0xc,%esp
     1ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     1b3:	a3 7c ba 00 00       	mov    %eax,0xba7c
     1b8:	89 15 80 ba 00 00    	mov    %edx,0xba80
     1be:	eb 1d                	jmp    1dd <Move+0x10c>
	}//no food
	else
	{
		my_food[head.x][head.y] = 0;
     1c0:	8b 15 9c ba 00 00    	mov    0xba9c,%edx
     1c6:	a1 a0 ba 00 00       	mov    0xbaa0,%eax
     1cb:	6b d2 37             	imul   $0x37,%edx,%edx
     1ce:	01 d0                	add    %edx,%eax
     1d0:	05 c0 ba 00 00       	add    $0xbac0,%eax
     1d5:	c6 00 00             	movb   $0x0,(%eax)
		updateFood();
     1d8:	e8 63 06 00 00       	call   840 <updateFood>
	}
	current_direction_copy = current_direction;
     1dd:	a1 40 ba 00 00       	mov    0xba40,%eax
     1e2:	a3 b0 ba 00 00       	mov    %eax,0xbab0

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
	AHwnd hwnd = APCreateWindow("snake",False,0);
     1fb:	83 ec 04             	sub    $0x4,%esp
     1fe:	6a 00                	push   $0x0
     200:	6a 00                	push   $0x0
     202:	68 c0 2f 00 00       	push   $0x2fc0
     207:	e8 4a 1d 00 00       	call   1f56 <APCreateWindow>
     20c:	83 c4 10             	add    $0x10,%esp
     20f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf(1,"snack created.\n");
     212:	83 ec 08             	sub    $0x8,%esp
     215:	68 c6 2f 00 00       	push   $0x2fc6
     21a:	6a 01                	push   $0x1
     21c:	e8 6a 0c 00 00       	call   e8b <printf>
     221:	83 c4 10             	add    $0x10,%esp
	APWndExec(hwnd,wndProc);
     224:	83 ec 08             	sub    $0x8,%esp
     227:	68 5e 09 00 00       	push   $0x95e
     22c:	ff 75 f4             	pushl  -0xc(%ebp)
     22f:	e8 9f 20 00 00       	call   22d3 <APWndExec>
     234:	83 c4 10             	add    $0x10,%esp
	exit();
     237:	e8 90 0a 00 00       	call   ccc <exit>

0000023c <init>:
}

void init(AHwnd hwnd)
{
     23c:	55                   	push   %ebp
     23d:	89 e5                	mov    %esp,%ebp
     23f:	83 ec 28             	sub    $0x28,%esp
	random(getCurrentTime());
     242:	e8 5d 0b 00 00       	call   da4 <getCurrentTime>
     247:	83 ec 0c             	sub    $0xc,%esp
     24a:	50                   	push   %eax
     24b:	e8 f7 29 00 00       	call   2c47 <random>
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
     270:	c7 04 85 80 75 00 00 	movl   $0x0,0x7580(,%eax,4)
     277:	00 00 00 00 
			my_food[i][j] = 0;
     27b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     27e:	6b d0 37             	imul   $0x37,%eax,%edx
     281:	8b 45 f0             	mov    -0x10(%ebp),%eax
     284:	01 d0                	add    %edx,%eax
     286:	05 c0 ba 00 00       	add    $0xbac0,%eax
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
     2b4:	05 80 75 00 00       	add    $0x7580,%eax
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
     2c9:	e8 72 05 00 00       	call   840 <updateFood>
     2ce:	e8 6d 05 00 00       	call   840 <updateFood>
     2d3:	e8 68 05 00 00       	call   840 <updateFood>
     2d8:	e8 63 05 00 00       	call   840 <updateFood>
     2dd:	e8 5e 05 00 00       	call   840 <updateFood>
	head.x = 4;
     2e2:	c7 05 9c ba 00 00 04 	movl   $0x4,0xba9c
     2e9:	00 00 00 
	head.y = 0;
     2ec:	c7 05 a0 ba 00 00 00 	movl   $0x0,0xbaa0
     2f3:	00 00 00 
	tail.x = tail.y = 0;
     2f6:	c7 05 80 ba 00 00 00 	movl   $0x0,0xba80
     2fd:	00 00 00 
     300:	a1 80 ba 00 00       	mov    0xba80,%eax
     305:	a3 7c ba 00 00       	mov    %eax,0xba7c
	current_direction = current_direction_copy = Right;
     30a:	c7 05 b0 ba 00 00 04 	movl   $0x4,0xbab0
     311:	00 00 00 
     314:	a1 b0 ba 00 00       	mov    0xbab0,%eax
     319:	a3 40 ba 00 00       	mov    %eax,0xba40
    	status = Run;
     31e:	c7 05 24 cc 00 00 00 	movl   $0x0,0xcc24
     325:	00 00 00 
	updateFood();
     328:	e8 13 05 00 00       	call   840 <updateFood>
	AMessage msg;
	msg.type = MSG_PAINT;
     32d:	c7 45 dc 03 00 00 00 	movl   $0x3,-0x24(%ebp)
	msg.param = 0;
     334:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	setupTimer(hwnd,1,800);
     33b:	83 ec 04             	sub    $0x4,%esp
     33e:	68 20 03 00 00       	push   $0x320
     343:	6a 01                	push   $0x1
     345:	ff 75 08             	pushl  0x8(%ebp)
     348:	e8 47 0a 00 00       	call   d94 <setupTimer>
     34d:	83 c4 10             	add    $0x10,%esp
	APSendMessage(hwnd,msg);
     350:	83 ec 0c             	sub    $0xc,%esp
     353:	ff 75 e8             	pushl  -0x18(%ebp)
     356:	ff 75 e4             	pushl  -0x1c(%ebp)
     359:	ff 75 e0             	pushl  -0x20(%ebp)
     35c:	ff 75 dc             	pushl  -0x24(%ebp)
     35f:	ff 75 08             	pushl  0x8(%ebp)
     362:	e8 d1 1b 00 00       	call   1f38 <APSendMessage>
     367:	83 c4 20             	add    $0x20,%esp

}
     36a:	90                   	nop
     36b:	c9                   	leave  
     36c:	c3                   	ret    

0000036d <timerUpdate>:

void timerUpdate(AHwnd hwnd)
{
     36d:	55                   	push   %ebp
     36e:	89 e5                	mov    %esp,%ebp
     370:	83 ec 18             	sub    $0x18,%esp
	if (Is_Dead())
     373:	e8 5a 04 00 00       	call   7d2 <Is_Dead>
     378:	84 c0                	test   %al,%al
     37a:	74 44                	je     3c0 <timerUpdate+0x53>
	{
		status = Dead;
     37c:	c7 05 24 cc 00 00 02 	movl   $0x2,0xcc24
     383:	00 00 00 
		//printf(1,"Dead!");
        AMessage msg_word;
        msg_word.type = MSG_WORD;
     386:	c7 45 e8 0a 00 00 00 	movl   $0xa,-0x18(%ebp)
        msg_word.word = "You are dead!";
     38d:	c7 45 f4 d6 2f 00 00 	movl   $0x2fd6,-0xc(%ebp)
        APSendMessage(hwnd,msg_word);
     394:	83 ec 0c             	sub    $0xc,%esp
     397:	ff 75 f4             	pushl  -0xc(%ebp)
     39a:	ff 75 f0             	pushl  -0x10(%ebp)
     39d:	ff 75 ec             	pushl  -0x14(%ebp)
     3a0:	ff 75 e8             	pushl  -0x18(%ebp)
     3a3:	ff 75 08             	pushl  0x8(%ebp)
     3a6:	e8 8d 1b 00 00       	call   1f38 <APSendMessage>
     3ab:	83 c4 20             	add    $0x20,%esp
		deleteTimer(hwnd,1);
     3ae:	83 ec 08             	sub    $0x8,%esp
     3b1:	6a 01                	push   $0x1
     3b3:	ff 75 08             	pushl  0x8(%ebp)
     3b6:	e8 e1 09 00 00       	call   d9c <deleteTimer>
     3bb:	83 c4 10             	add    $0x10,%esp
	else
	{
		Move();
	}

}
     3be:	eb 05                	jmp    3c5 <timerUpdate+0x58>
        APSendMessage(hwnd,msg_word);
		deleteTimer(hwnd,1);
	}
	else
	{
		Move();
     3c0:	e8 0c fd ff ff       	call   d1 <Move>
	}

}
     3c5:	90                   	nop
     3c6:	c9                   	leave  
     3c7:	c3                   	ret    

000003c8 <keyDown>:

void keyDown(AHwnd hwnd,AMessage msg)
{
     3c8:	55                   	push   %ebp
     3c9:	89 e5                	mov    %esp,%ebp
     3cb:	83 ec 08             	sub    $0x8,%esp
//printf(1,"msg.param received:%d\n",msg.param);
switch (msg.param)
     3ce:	8b 45 10             	mov    0x10(%ebp),%eax
     3d1:	83 f8 06             	cmp    $0x6,%eax
     3d4:	0f 87 46 01 00 00    	ja     520 <keyDown+0x158>
     3da:	8b 04 85 24 30 00 00 	mov    0x3024(,%eax,4),%eax
     3e1:	ff e0                	jmp    *%eax
{
case VK_UP:
//printf(1,"Up Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
     3e3:	a1 b0 ba 00 00       	mov    0xbab0,%eax
     3e8:	83 f8 03             	cmp    $0x3,%eax
     3eb:	74 0e                	je     3fb <keyDown+0x33>
     3ed:	a1 b0 ba 00 00       	mov    0xbab0,%eax
     3f2:	83 f8 04             	cmp    $0x4,%eax
     3f5:	0f 85 28 01 00 00    	jne    523 <keyDown+0x15b>
	current_direction = Up;
     3fb:	c7 05 40 ba 00 00 01 	movl   $0x1,0xba40
     402:	00 00 00 
break;
     405:	e9 19 01 00 00       	jmp    523 <keyDown+0x15b>
case VK_DOWN:
//printf(1,"Down Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
     40a:	a1 b0 ba 00 00       	mov    0xbab0,%eax
     40f:	83 f8 03             	cmp    $0x3,%eax
     412:	74 0e                	je     422 <keyDown+0x5a>
     414:	a1 b0 ba 00 00       	mov    0xbab0,%eax
     419:	83 f8 04             	cmp    $0x4,%eax
     41c:	0f 85 04 01 00 00    	jne    526 <keyDown+0x15e>
	current_direction = Down;
     422:	c7 05 40 ba 00 00 02 	movl   $0x2,0xba40
     429:	00 00 00 
break;
     42c:	e9 f5 00 00 00       	jmp    526 <keyDown+0x15e>
case VK_LEFT:
//printf(1,"Left Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
     431:	a1 b0 ba 00 00       	mov    0xbab0,%eax
     436:	83 f8 01             	cmp    $0x1,%eax
     439:	74 0e                	je     449 <keyDown+0x81>
     43b:	a1 b0 ba 00 00       	mov    0xbab0,%eax
     440:	83 f8 02             	cmp    $0x2,%eax
     443:	0f 85 e0 00 00 00    	jne    529 <keyDown+0x161>
	current_direction = Left;
     449:	c7 05 40 ba 00 00 03 	movl   $0x3,0xba40
     450:	00 00 00 
break;
     453:	e9 d1 00 00 00       	jmp    529 <keyDown+0x161>
case VK_RIGHT:
//printf(1,"Right Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
     458:	a1 b0 ba 00 00       	mov    0xbab0,%eax
     45d:	83 f8 01             	cmp    $0x1,%eax
     460:	74 0e                	je     470 <keyDown+0xa8>
     462:	a1 b0 ba 00 00       	mov    0xbab0,%eax
     467:	83 f8 02             	cmp    $0x2,%eax
     46a:	0f 85 bc 00 00 00    	jne    52c <keyDown+0x164>
	current_direction = Right;
     470:	c7 05 40 ba 00 00 04 	movl   $0x4,0xba40
     477:	00 00 00 
break;
     47a:	e9 ad 00 00 00       	jmp    52c <keyDown+0x164>
case VK_ENTER:
        switch(status)
     47f:	a1 24 cc 00 00       	mov    0xcc24,%eax
     484:	83 f8 01             	cmp    $0x1,%eax
     487:	74 3f                	je     4c8 <keyDown+0x100>
     489:	83 f8 02             	cmp    $0x2,%eax
     48c:	74 6e                	je     4fc <keyDown+0x134>
     48e:	85 c0                	test   %eax,%eax
     490:	74 02                	je     494 <keyDown+0xcc>
            APSendMessage(hwnd,msg);
            break;
        case Dead:
            init(hwnd);
            break;
        default:break;
     492:	eb 77                	jmp    50b <keyDown+0x143>
break;
case VK_ENTER:
        switch(status)
    {
        case Run:
            status = Pause;
     494:	c7 05 24 cc 00 00 01 	movl   $0x1,0xcc24
     49b:	00 00 00 
            msg.type = MSG_WORD;
     49e:	c7 45 0c 0a 00 00 00 	movl   $0xa,0xc(%ebp)
            msg.word = "Pause! Press ENTER to continue";
     4a5:	c7 45 18 e4 2f 00 00 	movl   $0x2fe4,0x18(%ebp)
            APSendMessage(hwnd,msg);
     4ac:	83 ec 0c             	sub    $0xc,%esp
     4af:	ff 75 18             	pushl  0x18(%ebp)
     4b2:	ff 75 14             	pushl  0x14(%ebp)
     4b5:	ff 75 10             	pushl  0x10(%ebp)
     4b8:	ff 75 0c             	pushl  0xc(%ebp)
     4bb:	ff 75 08             	pushl  0x8(%ebp)
     4be:	e8 75 1a 00 00       	call   1f38 <APSendMessage>
     4c3:	83 c4 20             	add    $0x20,%esp
            break;
     4c6:	eb 43                	jmp    50b <keyDown+0x143>
        case Pause:
            status = Run;
     4c8:	c7 05 24 cc 00 00 00 	movl   $0x0,0xcc24
     4cf:	00 00 00 
            msg.type = MSG_WORD;
     4d2:	c7 45 0c 0a 00 00 00 	movl   $0xa,0xc(%ebp)
            msg.word = "Running! Press ENTER to pause";
     4d9:	c7 45 18 03 30 00 00 	movl   $0x3003,0x18(%ebp)
            APSendMessage(hwnd,msg);
     4e0:	83 ec 0c             	sub    $0xc,%esp
     4e3:	ff 75 18             	pushl  0x18(%ebp)
     4e6:	ff 75 14             	pushl  0x14(%ebp)
     4e9:	ff 75 10             	pushl  0x10(%ebp)
     4ec:	ff 75 0c             	pushl  0xc(%ebp)
     4ef:	ff 75 08             	pushl  0x8(%ebp)
     4f2:	e8 41 1a 00 00       	call   1f38 <APSendMessage>
     4f7:	83 c4 20             	add    $0x20,%esp
            break;
     4fa:	eb 0f                	jmp    50b <keyDown+0x143>
        case Dead:
            init(hwnd);
     4fc:	83 ec 0c             	sub    $0xc,%esp
     4ff:	ff 75 08             	pushl  0x8(%ebp)
     502:	e8 35 fd ff ff       	call   23c <init>
     507:	83 c4 10             	add    $0x10,%esp
            break;
     50a:	90                   	nop
        default:break;
    }
        break;
     50b:	eb 20                	jmp    52d <keyDown+0x165>
case VK_ESC:
        removeWindow(hwnd->id);
     50d:	8b 45 08             	mov    0x8(%ebp),%eax
     510:	8b 00                	mov    (%eax),%eax
     512:	83 ec 0c             	sub    $0xc,%esp
     515:	50                   	push   %eax
     516:	e8 91 08 00 00       	call   dac <removeWindow>
     51b:	83 c4 10             	add    $0x10,%esp
        break;
     51e:	eb 0d                	jmp    52d <keyDown+0x165>
default:break;
     520:	90                   	nop
     521:	eb 0a                	jmp    52d <keyDown+0x165>
{
case VK_UP:
//printf(1,"Up Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
	current_direction = Up;
break;
     523:	90                   	nop
     524:	eb 07                	jmp    52d <keyDown+0x165>
case VK_DOWN:
//printf(1,"Down Key pressed");
if (current_direction_copy == Left || current_direction_copy == Right)
	current_direction = Down;
break;
     526:	90                   	nop
     527:	eb 04                	jmp    52d <keyDown+0x165>
case VK_LEFT:
//printf(1,"Left Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
	current_direction = Left;
break;
     529:	90                   	nop
     52a:	eb 01                	jmp    52d <keyDown+0x165>
case VK_RIGHT:
//printf(1,"Right Key pressed");
if (current_direction_copy == Up || current_direction_copy == Down)
	current_direction = Right;
break;
     52c:	90                   	nop
        break;
default:break;

}

}
     52d:	90                   	nop
     52e:	c9                   	leave  
     52f:	c3                   	ret    

00000530 <draw>:

void draw(AHwnd hwnd)
{
     530:	55                   	push   %ebp
     531:	89 e5                	mov    %esp,%ebp
     533:	53                   	push   %ebx
     534:	83 ec 34             	sub    $0x34,%esp
	AHdc hdc = &(hwnd->Dc);
     537:	8b 45 08             	mov    0x8(%ebp),%eax
     53a:	83 c0 3c             	add    $0x3c,%eax
     53d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
     540:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     547:	e9 49 01 00 00       	jmp    695 <draw+0x165>
	{

		for (int j = 0;j < BLOCK_NUM_Y;j++)
     54c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     553:	e9 2f 01 00 00       	jmp    687 <draw+0x157>
		{
			if (my_block[i][j] == NoDir)
     558:	8b 45 f4             	mov    -0xc(%ebp),%eax
     55b:	6b d0 37             	imul   $0x37,%eax,%edx
     55e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     561:	01 d0                	add    %edx,%eax
     563:	8b 04 85 80 75 00 00 	mov    0x7580(,%eax,4),%eax
     56a:	85 c0                	test   %eax,%eax
     56c:	75 26                	jne    594 <draw+0x64>
			{
				brush.color = COLOR_BACK;
     56e:	8d 45 c8             	lea    -0x38(%ebp),%eax
     571:	6a 00                	push   $0x0
     573:	68 ff 00 00 00       	push   $0xff
     578:	6a 00                	push   $0x0
     57a:	50                   	push   %eax
     57b:	e8 80 fa ff ff       	call   0 <RGB>
     580:	83 c4 0c             	add    $0xc,%esp
     583:	0f b7 45 c8          	movzwl -0x38(%ebp),%eax
     587:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     58b:	0f b6 45 ca          	movzbl -0x36(%ebp),%eax
     58f:	88 45 eb             	mov    %al,-0x15(%ebp)
     592:	eb 61                	jmp    5f5 <draw+0xc5>

			}//background
			else
			{
				if (head.x == i && head.y == j)
     594:	a1 9c ba 00 00       	mov    0xba9c,%eax
     599:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     59c:	75 30                	jne    5ce <draw+0x9e>
     59e:	a1 a0 ba 00 00       	mov    0xbaa0,%eax
     5a3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     5a6:	75 26                	jne    5ce <draw+0x9e>
					brush.color = COLOR_HEAD;
     5a8:	8d 45 c8             	lea    -0x38(%ebp),%eax
     5ab:	6a 00                	push   $0x0
     5ad:	68 80 00 00 00       	push   $0x80
     5b2:	6a 00                	push   $0x0
     5b4:	50                   	push   %eax
     5b5:	e8 46 fa ff ff       	call   0 <RGB>
     5ba:	83 c4 0c             	add    $0xc,%esp
     5bd:	0f b7 45 c8          	movzwl -0x38(%ebp),%eax
     5c1:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     5c5:	0f b6 45 ca          	movzbl -0x36(%ebp),%eax
     5c9:	88 45 eb             	mov    %al,-0x15(%ebp)
     5cc:	eb 27                	jmp    5f5 <draw+0xc5>
				else
					brush.color = COLOR_BODY;
     5ce:	8d 45 c8             	lea    -0x38(%ebp),%eax
     5d1:	68 ff 00 00 00       	push   $0xff
     5d6:	68 ff 00 00 00       	push   $0xff
     5db:	6a 00                	push   $0x0
     5dd:	50                   	push   %eax
     5de:	e8 1d fa ff ff       	call   0 <RGB>
     5e3:	83 c4 0c             	add    $0xc,%esp
     5e6:	0f b7 45 c8          	movzwl -0x38(%ebp),%eax
     5ea:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     5ee:	0f b6 45 ca          	movzbl -0x36(%ebp),%eax
     5f2:	88 45 eb             	mov    %al,-0x15(%ebp)
			}
			if (my_food[i][j] == 1)
     5f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5f8:	6b d0 37             	imul   $0x37,%eax,%edx
     5fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5fe:	01 d0                	add    %edx,%eax
     600:	05 c0 ba 00 00       	add    $0xbac0,%eax
     605:	0f b6 00             	movzbl (%eax),%eax
     608:	3c 01                	cmp    $0x1,%al
     60a:	75 24                	jne    630 <draw+0x100>
			{
				brush.color = COLOR_FOOD;
     60c:	8d 45 c8             	lea    -0x38(%ebp),%eax
     60f:	6a 00                	push   $0x0
     611:	6a 00                	push   $0x0
     613:	68 ff 00 00 00       	push   $0xff
     618:	50                   	push   %eax
     619:	e8 e2 f9 ff ff       	call   0 <RGB>
     61e:	83 c4 0c             	add    $0xc,%esp
     621:	0f b7 45 c8          	movzwl -0x38(%ebp),%eax
     625:	66 89 45 e9          	mov    %ax,-0x17(%ebp)
     629:	0f b6 45 ca          	movzbl -0x36(%ebp),%eax
     62d:	88 45 eb             	mov    %al,-0x15(%ebp)
			}
			APSetBrush(hdc,brush);
     630:	8d 55 c8             	lea    -0x38(%ebp),%edx
     633:	83 ec 04             	sub    $0x4,%esp
     636:	83 ec 04             	sub    $0x4,%esp
     639:	89 e0                	mov    %esp,%eax
     63b:	0f b7 4d e9          	movzwl -0x17(%ebp),%ecx
     63f:	66 89 08             	mov    %cx,(%eax)
     642:	0f b6 4d eb          	movzbl -0x15(%ebp),%ecx
     646:	88 48 02             	mov    %cl,0x2(%eax)
     649:	ff 75 ec             	pushl  -0x14(%ebp)
     64c:	52                   	push   %edx
     64d:	e8 c7 0f 00 00       	call   1619 <APSetBrush>
     652:	83 c4 0c             	add    $0xc,%esp
			APDrawRect(hdc,i * BLOCK_WIDTH,j*BLOCK_WIDTH,BLOCK_WIDTH,BLOCK_WIDTH);
     655:	8b 55 f0             	mov    -0x10(%ebp),%edx
     658:	89 d0                	mov    %edx,%eax
     65a:	c1 e0 02             	shl    $0x2,%eax
     65d:	01 d0                	add    %edx,%eax
     65f:	01 c0                	add    %eax,%eax
     661:	89 c1                	mov    %eax,%ecx
     663:	8b 55 f4             	mov    -0xc(%ebp),%edx
     666:	89 d0                	mov    %edx,%eax
     668:	c1 e0 02             	shl    $0x2,%eax
     66b:	01 d0                	add    %edx,%eax
     66d:	01 c0                	add    %eax,%eax
     66f:	83 ec 0c             	sub    $0xc,%esp
     672:	6a 0a                	push   $0xa
     674:	6a 0a                	push   $0xa
     676:	51                   	push   %ecx
     677:	50                   	push   %eax
     678:	ff 75 ec             	pushl  -0x14(%ebp)
     67b:	e8 c3 13 00 00       	call   1a43 <APDrawRect>
     680:	83 c4 20             	add    $0x20,%esp
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
	{

		for (int j = 0;j < BLOCK_NUM_Y;j++)
     683:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     687:	83 7d f0 36          	cmpl   $0x36,-0x10(%ebp)
     68b:	0f 8e c7 fe ff ff    	jle    558 <draw+0x28>
void draw(AHwnd hwnd)
{
	AHdc hdc = &(hwnd->Dc);
	ABrush brush;

	for (int i = 0;i <BLOCK_NUM_X;i++)
     691:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     695:	83 7d f4 4f          	cmpl   $0x4f,-0xc(%ebp)
     699:	0f 8e ad fe ff ff    	jle    54c <draw+0x1c>
			APSetBrush(hdc,brush);
			APDrawRect(hdc,i * BLOCK_WIDTH,j*BLOCK_WIDTH,BLOCK_WIDTH,BLOCK_WIDTH);
		}
	}
    
    if (FirstTime == 1)
     69f:	a1 00 39 00 00       	mov    0x3900,%eax
     6a4:	83 f8 01             	cmp    $0x1,%eax
     6a7:	0f 85 1f 01 00 00    	jne    7cc <draw+0x29c>
    {
        FirstTime = 0;
     6ad:	c7 05 00 39 00 00 00 	movl   $0x0,0x3900
     6b4:	00 00 00 
        APen pen;
        ABrush brush;
        pen.color = RGB(0x18,0x74,0xcd);
     6b7:	8d 45 c8             	lea    -0x38(%ebp),%eax
     6ba:	68 cd 00 00 00       	push   $0xcd
     6bf:	6a 74                	push   $0x74
     6c1:	6a 18                	push   $0x18
     6c3:	50                   	push   %eax
     6c4:	e8 37 f9 ff ff       	call   0 <RGB>
     6c9:	83 c4 0c             	add    $0xc,%esp
     6cc:	0f b7 45 c8          	movzwl -0x38(%ebp),%eax
     6d0:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
     6d4:	0f b6 45 ca          	movzbl -0x36(%ebp),%eax
     6d8:	88 45 e2             	mov    %al,-0x1e(%ebp)
        pen.size = 1;
     6db:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
        brush.color = RGB(0x18,0x74,0xcd);
     6e2:	8d 45 c8             	lea    -0x38(%ebp),%eax
     6e5:	68 cd 00 00 00       	push   $0xcd
     6ea:	6a 74                	push   $0x74
     6ec:	6a 18                	push   $0x18
     6ee:	50                   	push   %eax
     6ef:	e8 0c f9 ff ff       	call   0 <RGB>
     6f4:	83 c4 0c             	add    $0xc,%esp
     6f7:	0f b7 45 c8          	movzwl -0x38(%ebp),%eax
     6fb:	66 89 45 dd          	mov    %ax,-0x23(%ebp)
     6ff:	0f b6 45 ca          	movzbl -0x36(%ebp),%eax
     703:	88 45 df             	mov    %al,-0x21(%ebp)
        APSetPen(&hwnd->TitleDc,pen);
     706:	8b 45 08             	mov    0x8(%ebp),%eax
     709:	8d 50 58             	lea    0x58(%eax),%edx
     70c:	8d 45 c8             	lea    -0x38(%ebp),%eax
     70f:	ff 75 e4             	pushl  -0x1c(%ebp)
     712:	ff 75 e0             	pushl  -0x20(%ebp)
     715:	52                   	push   %edx
     716:	50                   	push   %eax
     717:	e8 c4 0e 00 00       	call   15e0 <APSetPen>
     71c:	83 c4 0c             	add    $0xc,%esp
        APSetBrush(&hwnd->TitleDc,brush);
     71f:	8b 45 08             	mov    0x8(%ebp),%eax
     722:	8d 58 58             	lea    0x58(%eax),%ebx
     725:	8d 55 c8             	lea    -0x38(%ebp),%edx
     728:	83 ec 04             	sub    $0x4,%esp
     72b:	83 ec 04             	sub    $0x4,%esp
     72e:	89 e0                	mov    %esp,%eax
     730:	0f b7 4d dd          	movzwl -0x23(%ebp),%ecx
     734:	66 89 08             	mov    %cx,(%eax)
     737:	0f b6 4d df          	movzbl -0x21(%ebp),%ecx
     73b:	88 48 02             	mov    %cl,0x2(%eax)
     73e:	53                   	push   %ebx
     73f:	52                   	push   %edx
     740:	e8 d4 0e 00 00       	call   1619 <APSetBrush>
     745:	83 c4 0c             	add    $0xc,%esp
        APDrawRect(&hwnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
     748:	8b 45 08             	mov    0x8(%ebp),%eax
     74b:	83 c0 58             	add    $0x58,%eax
     74e:	83 ec 0c             	sub    $0xc,%esp
     751:	6a 32                	push   $0x32
     753:	68 20 03 00 00       	push   $0x320
     758:	6a 00                	push   $0x0
     75a:	6a 00                	push   $0x0
     75c:	50                   	push   %eax
     75d:	e8 e1 12 00 00       	call   1a43 <APDrawRect>
     762:	83 c4 20             	add    $0x20,%esp
        AFont font;
        font.color = RGB(0x08,0x08,0x08);
     765:	8d 45 c8             	lea    -0x38(%ebp),%eax
     768:	6a 08                	push   $0x8
     76a:	6a 08                	push   $0x8
     76c:	6a 08                	push   $0x8
     76e:	50                   	push   %eax
     76f:	e8 8c f8 ff ff       	call   0 <RGB>
     774:	83 c4 0c             	add    $0xc,%esp
     777:	0f b7 45 c8          	movzwl -0x38(%ebp),%eax
     77b:	66 89 45 da          	mov    %ax,-0x26(%ebp)
     77f:	0f b6 45 ca          	movzbl -0x36(%ebp),%eax
     783:	88 45 dc             	mov    %al,-0x24(%ebp)
        APSetFont(&hwnd->TitleDc,font);
     786:	8b 45 08             	mov    0x8(%ebp),%eax
     789:	8d 58 58             	lea    0x58(%eax),%ebx
     78c:	8d 55 c8             	lea    -0x38(%ebp),%edx
     78f:	83 ec 04             	sub    $0x4,%esp
     792:	83 ec 04             	sub    $0x4,%esp
     795:	89 e0                	mov    %esp,%eax
     797:	0f b7 4d da          	movzwl -0x26(%ebp),%ecx
     79b:	66 89 08             	mov    %cx,(%eax)
     79e:	0f b6 4d dc          	movzbl -0x24(%ebp),%ecx
     7a2:	88 48 02             	mov    %cl,0x2(%eax)
     7a5:	53                   	push   %ebx
     7a6:	52                   	push   %edx
     7a7:	e8 af 0e 00 00       	call   165b <APSetFont>
     7ac:	83 c4 0c             	add    $0xc,%esp
        APDrawText(&hwnd->TitleDc,hwnd->title,20,20);
     7af:	8b 45 08             	mov    0x8(%ebp),%eax
     7b2:	8d 90 88 00 00 00    	lea    0x88(%eax),%edx
     7b8:	8b 45 08             	mov    0x8(%ebp),%eax
     7bb:	83 c0 58             	add    $0x58,%eax
     7be:	6a 14                	push   $0x14
     7c0:	6a 14                	push   $0x14
     7c2:	52                   	push   %edx
     7c3:	50                   	push   %eax
     7c4:	e8 7f 14 00 00       	call   1c48 <APDrawText>
     7c9:	83 c4 10             	add    $0x10,%esp
    }
}
     7cc:	90                   	nop
     7cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7d0:	c9                   	leave  
     7d1:	c3                   	ret    

000007d2 <Is_Dead>:

bool Is_Dead()
{
     7d2:	55                   	push   %ebp
     7d3:	89 e5                	mov    %esp,%ebp
     7d5:	83 ec 10             	sub    $0x10,%esp
	APoint p = nextpoint(head,current_direction);
     7d8:	8b 15 40 ba 00 00    	mov    0xba40,%edx
     7de:	8d 45 f8             	lea    -0x8(%ebp),%eax
     7e1:	52                   	push   %edx
     7e2:	ff 35 a0 ba 00 00    	pushl  0xbaa0
     7e8:	ff 35 9c ba 00 00    	pushl  0xba9c
     7ee:	50                   	push   %eax
     7ef:	e8 51 f8 ff ff       	call   45 <nextpoint>
     7f4:	83 c4 0c             	add    $0xc,%esp
    if (p.x >= BLOCK_NUM_X || p.y > BLOCK_NUM_Y || p.x < 0 || p.y < 0)
     7f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7fa:	83 f8 4f             	cmp    $0x4f,%eax
     7fd:	7f 16                	jg     815 <Is_Dead+0x43>
     7ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
     802:	83 f8 37             	cmp    $0x37,%eax
     805:	7f 0e                	jg     815 <Is_Dead+0x43>
     807:	8b 45 f8             	mov    -0x8(%ebp),%eax
     80a:	85 c0                	test   %eax,%eax
     80c:	78 07                	js     815 <Is_Dead+0x43>
     80e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     811:	85 c0                	test   %eax,%eax
     813:	79 07                	jns    81c <Is_Dead+0x4a>
        return True;
     815:	b8 01 00 00 00       	mov    $0x1,%eax
     81a:	eb 22                	jmp    83e <Is_Dead+0x6c>
	if (my_block[p.x][p.y] != NoDir)
     81c:	8b 55 f8             	mov    -0x8(%ebp),%edx
     81f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     822:	6b d2 37             	imul   $0x37,%edx,%edx
     825:	01 d0                	add    %edx,%eax
     827:	8b 04 85 80 75 00 00 	mov    0x7580(,%eax,4),%eax
     82e:	85 c0                	test   %eax,%eax
     830:	74 07                	je     839 <Is_Dead+0x67>
        return True;
     832:	b8 01 00 00 00       	mov    $0x1,%eax
     837:	eb 05                	jmp    83e <Is_Dead+0x6c>
    else
        return False;
     839:	b8 00 00 00 00       	mov    $0x0,%eax
}
     83e:	c9                   	leave  
     83f:	c3                   	ret    

00000840 <updateFood>:

bool updateFood()
{
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	83 ec 28             	sub    $0x28,%esp
bool sta = false;
     846:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
for (int i = 0;i < BLOCK_NUM_X;i++)
     84a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     851:	eb 50                	jmp    8a3 <updateFood+0x63>
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
     853:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     85a:	eb 37                	jmp    893 <updateFood+0x53>
	{
		if (my_block[i][j] == NoDir && my_food[i][j] == NoDir)
     85c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     85f:	6b d0 37             	imul   $0x37,%eax,%edx
     862:	8b 45 ec             	mov    -0x14(%ebp),%eax
     865:	01 d0                	add    %edx,%eax
     867:	8b 04 85 80 75 00 00 	mov    0x7580(,%eax,4),%eax
     86e:	85 c0                	test   %eax,%eax
     870:	75 1d                	jne    88f <updateFood+0x4f>
     872:	8b 45 f0             	mov    -0x10(%ebp),%eax
     875:	6b d0 37             	imul   $0x37,%eax,%edx
     878:	8b 45 ec             	mov    -0x14(%ebp),%eax
     87b:	01 d0                	add    %edx,%eax
     87d:	05 c0 ba 00 00       	add    $0xbac0,%eax
     882:	0f b6 00             	movzbl (%eax),%eax
     885:	84 c0                	test   %al,%al
     887:	75 06                	jne    88f <updateFood+0x4f>
		{
			sta = true;
     889:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
			break;
     88d:	eb 0a                	jmp    899 <updateFood+0x59>
bool updateFood()
{
bool sta = false;
for (int i = 0;i < BLOCK_NUM_X;i++)
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
     88f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     893:	83 7d ec 36          	cmpl   $0x36,-0x14(%ebp)
     897:	7e c3                	jle    85c <updateFood+0x1c>
		{
			sta = true;
			break;
		}
	}
	if (sta == true)
     899:	80 7d f7 01          	cmpb   $0x1,-0x9(%ebp)
     89d:	74 0c                	je     8ab <updateFood+0x6b>
}

bool updateFood()
{
bool sta = false;
for (int i = 0;i < BLOCK_NUM_X;i++)
     89f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8a3:	83 7d f0 4f          	cmpl   $0x4f,-0x10(%ebp)
     8a7:	7e aa                	jle    853 <updateFood+0x13>
     8a9:	eb 01                	jmp    8ac <updateFood+0x6c>
			break;
		}
	}
	if (sta == true)
	{
		break;
     8ab:	90                   	nop
	}
}
if (sta == false)
     8ac:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
     8b0:	75 09                	jne    8bb <updateFood+0x7b>
{
return sta;
     8b2:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
     8b6:	e9 a1 00 00 00       	jmp    95c <updateFood+0x11c>
}
while(true)
{
int i = random(0) % BLOCK_NUM_X;
     8bb:	83 ec 0c             	sub    $0xc,%esp
     8be:	6a 00                	push   $0x0
     8c0:	e8 82 23 00 00       	call   2c47 <random>
     8c5:	83 c4 10             	add    $0x10,%esp
     8c8:	89 c1                	mov    %eax,%ecx
     8ca:	ba 67 66 66 66       	mov    $0x66666667,%edx
     8cf:	89 c8                	mov    %ecx,%eax
     8d1:	f7 ea                	imul   %edx
     8d3:	c1 fa 05             	sar    $0x5,%edx
     8d6:	89 c8                	mov    %ecx,%eax
     8d8:	c1 f8 1f             	sar    $0x1f,%eax
     8db:	29 c2                	sub    %eax,%edx
     8dd:	89 d0                	mov    %edx,%eax
     8df:	89 45 e8             	mov    %eax,-0x18(%ebp)
     8e2:	8b 55 e8             	mov    -0x18(%ebp),%edx
     8e5:	89 d0                	mov    %edx,%eax
     8e7:	c1 e0 02             	shl    $0x2,%eax
     8ea:	01 d0                	add    %edx,%eax
     8ec:	c1 e0 04             	shl    $0x4,%eax
     8ef:	29 c1                	sub    %eax,%ecx
     8f1:	89 c8                	mov    %ecx,%eax
     8f3:	89 45 e8             	mov    %eax,-0x18(%ebp)
int j = random(0) % BLOCK_NUM_Y;
     8f6:	83 ec 0c             	sub    $0xc,%esp
     8f9:	6a 00                	push   $0x0
     8fb:	e8 47 23 00 00       	call   2c47 <random>
     900:	83 c4 10             	add    $0x10,%esp
     903:	89 c1                	mov    %eax,%ecx
     905:	ba 95 20 4f 09       	mov    $0x94f2095,%edx
     90a:	89 c8                	mov    %ecx,%eax
     90c:	f7 ea                	imul   %edx
     90e:	d1 fa                	sar    %edx
     910:	89 c8                	mov    %ecx,%eax
     912:	c1 f8 1f             	sar    $0x1f,%eax
     915:	29 c2                	sub    %eax,%edx
     917:	89 d0                	mov    %edx,%eax
     919:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     91c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     91f:	6b c0 37             	imul   $0x37,%eax,%eax
     922:	29 c1                	sub    %eax,%ecx
     924:	89 c8                	mov    %ecx,%eax
     926:	89 45 e4             	mov    %eax,-0x1c(%ebp)
if (my_food[i][j] == 0)
     929:	8b 45 e8             	mov    -0x18(%ebp),%eax
     92c:	6b d0 37             	imul   $0x37,%eax,%edx
     92f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     932:	01 d0                	add    %edx,%eax
     934:	05 c0 ba 00 00       	add    $0xbac0,%eax
     939:	0f b6 00             	movzbl (%eax),%eax
     93c:	84 c0                	test   %al,%al
     93e:	0f 85 77 ff ff ff    	jne    8bb <updateFood+0x7b>
{
	my_food[i][j] = 1;
     944:	8b 45 e8             	mov    -0x18(%ebp),%eax
     947:	6b d0 37             	imul   $0x37,%eax,%edx
     94a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     94d:	01 d0                	add    %edx,%eax
     94f:	05 c0 ba 00 00       	add    $0xbac0,%eax
     954:	c6 00 01             	movb   $0x1,(%eax)
return true;
     957:	b8 01 00 00 00       	mov    $0x1,%eax
}

}


}
     95c:	c9                   	leave  
     95d:	c3                   	ret    

0000095e <wndProc>:

bool wndProc(AHwnd hwnd,AMessage msg)
{
     95e:	55                   	push   %ebp
     95f:	89 e5                	mov    %esp,%ebp
     961:	83 ec 38             	sub    $0x38,%esp
switch(msg.type)
     964:	8b 45 0c             	mov    0xc(%ebp),%eax
     967:	83 f8 09             	cmp    $0x9,%eax
     96a:	0f 87 e5 00 00 00    	ja     a55 <wndProc+0xf7>
     970:	8b 04 85 40 30 00 00 	mov    0x3040(,%eax,4),%eax
     977:	ff e0                	jmp    *%eax
{
    case MSG_ESC:
        return True;
     979:	b8 01 00 00 00       	mov    $0x1,%eax
     97e:	e9 f0 00 00 00       	jmp    a73 <wndProc+0x115>
    case MSG_INIT:
    init(hwnd);
     983:	83 ec 0c             	sub    $0xc,%esp
     986:	ff 75 08             	pushl  0x8(%ebp)
     989:	e8 ae f8 ff ff       	call   23c <init>
     98e:	83 c4 10             	add    $0x10,%esp
    AMessage ms;
    ms.type = MSG_PAINT;
     991:	c7 45 e8 03 00 00 00 	movl   $0x3,-0x18(%ebp)
    APSendMessage(hwnd,ms);
     998:	83 ec 0c             	sub    $0xc,%esp
     99b:	ff 75 f4             	pushl  -0xc(%ebp)
     99e:	ff 75 f0             	pushl  -0x10(%ebp)
     9a1:	ff 75 ec             	pushl  -0x14(%ebp)
     9a4:	ff 75 e8             	pushl  -0x18(%ebp)
     9a7:	ff 75 08             	pushl  0x8(%ebp)
     9aa:	e8 89 15 00 00       	call   1f38 <APSendMessage>
     9af:	83 c4 20             	add    $0x20,%esp
    
    return False;
     9b2:	b8 00 00 00 00       	mov    $0x0,%eax
     9b7:	e9 b7 00 00 00       	jmp    a73 <wndProc+0x115>
	case MSG_TIMEOUT:
if (status != Run)
     9bc:	a1 24 cc 00 00       	mov    0xcc24,%eax
     9c1:	85 c0                	test   %eax,%eax
     9c3:	0f 85 8f 00 00 00    	jne    a58 <wndProc+0xfa>
	break;
	timerUpdate(hwnd);
     9c9:	83 ec 0c             	sub    $0xc,%esp
     9cc:	ff 75 08             	pushl  0x8(%ebp)
     9cf:	e8 99 f9 ff ff       	call   36d <timerUpdate>
     9d4:	83 c4 10             	add    $0x10,%esp
	AMessage msg1;
	msg1.type = MSG_PAINT;
     9d7:	c7 45 d8 03 00 00 00 	movl   $0x3,-0x28(%ebp)
	msg1.param = 0;
     9de:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	APSendMessage(hwnd,msg1);
     9e5:	83 ec 0c             	sub    $0xc,%esp
     9e8:	ff 75 e4             	pushl  -0x1c(%ebp)
     9eb:	ff 75 e0             	pushl  -0x20(%ebp)
     9ee:	ff 75 dc             	pushl  -0x24(%ebp)
     9f1:	ff 75 d8             	pushl  -0x28(%ebp)
     9f4:	ff 75 08             	pushl  0x8(%ebp)
     9f7:	e8 3c 15 00 00       	call   1f38 <APSendMessage>
     9fc:	83 c4 20             	add    $0x20,%esp
	break;
     9ff:	eb 58                	jmp    a59 <wndProc+0xfb>
	case MSG_KEY_DOWN:
	keyDown(hwnd,msg);
     a01:	83 ec 0c             	sub    $0xc,%esp
     a04:	ff 75 18             	pushl  0x18(%ebp)
     a07:	ff 75 14             	pushl  0x14(%ebp)
     a0a:	ff 75 10             	pushl  0x10(%ebp)
     a0d:	ff 75 0c             	pushl  0xc(%ebp)
     a10:	ff 75 08             	pushl  0x8(%ebp)
     a13:	e8 b0 f9 ff ff       	call   3c8 <keyDown>
     a18:	83 c4 20             	add    $0x20,%esp
	break;
     a1b:	eb 3c                	jmp    a59 <wndProc+0xfb>
	case MSG_PAINT:
        draw(hwnd);
     a1d:	83 ec 0c             	sub    $0xc,%esp
     a20:	ff 75 08             	pushl  0x8(%ebp)
     a23:	e8 08 fb ff ff       	call   530 <draw>
     a28:	83 c4 10             	add    $0x10,%esp
        AMessage msg_word;
        msg_word.type = MSG_WORD;
     a2b:	c7 45 c8 0a 00 00 00 	movl   $0xa,-0x38(%ebp)
        msg_word.word = "Running! Press ENTER to pause";
     a32:	c7 45 d4 03 30 00 00 	movl   $0x3003,-0x2c(%ebp)
        APSendMessage(hwnd,msg_word);
     a39:	83 ec 0c             	sub    $0xc,%esp
     a3c:	ff 75 d4             	pushl  -0x2c(%ebp)
     a3f:	ff 75 d0             	pushl  -0x30(%ebp)
     a42:	ff 75 cc             	pushl  -0x34(%ebp)
     a45:	ff 75 c8             	pushl  -0x38(%ebp)
     a48:	ff 75 08             	pushl  0x8(%ebp)
     a4b:	e8 e8 14 00 00       	call   1f38 <APSendMessage>
     a50:	83 c4 20             	add    $0x20,%esp
	break;
     a53:	eb 04                	jmp    a59 <wndProc+0xfb>
	default:
	break;
     a55:	90                   	nop
     a56:	eb 01                	jmp    a59 <wndProc+0xfb>
    APSendMessage(hwnd,ms);
    
    return False;
	case MSG_TIMEOUT:
if (status != Run)
	break;
     a58:	90                   	nop
        APSendMessage(hwnd,msg_word);
	break;
	default:
	break;
}
return APWndProc(hwnd,msg);
     a59:	83 ec 0c             	sub    $0xc,%esp
     a5c:	ff 75 18             	pushl  0x18(%ebp)
     a5f:	ff 75 14             	pushl  0x14(%ebp)
     a62:	ff 75 10             	pushl  0x10(%ebp)
     a65:	ff 75 0c             	pushl  0xc(%ebp)
     a68:	ff 75 08             	pushl  0x8(%ebp)
     a6b:	e8 4c 17 00 00       	call   21bc <APWndProc>
     a70:	83 c4 20             	add    $0x20,%esp

}
     a73:	c9                   	leave  
     a74:	c3                   	ret    

00000a75 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     a75:	55                   	push   %ebp
     a76:	89 e5                	mov    %esp,%ebp
     a78:	57                   	push   %edi
     a79:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     a7a:	8b 4d 08             	mov    0x8(%ebp),%ecx
     a7d:	8b 55 10             	mov    0x10(%ebp),%edx
     a80:	8b 45 0c             	mov    0xc(%ebp),%eax
     a83:	89 cb                	mov    %ecx,%ebx
     a85:	89 df                	mov    %ebx,%edi
     a87:	89 d1                	mov    %edx,%ecx
     a89:	fc                   	cld    
     a8a:	f3 aa                	rep stos %al,%es:(%edi)
     a8c:	89 ca                	mov    %ecx,%edx
     a8e:	89 fb                	mov    %edi,%ebx
     a90:	89 5d 08             	mov    %ebx,0x8(%ebp)
     a93:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     a96:	90                   	nop
     a97:	5b                   	pop    %ebx
     a98:	5f                   	pop    %edi
     a99:	5d                   	pop    %ebp
     a9a:	c3                   	ret    

00000a9b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     a9b:	55                   	push   %ebp
     a9c:	89 e5                	mov    %esp,%ebp
     a9e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     aa1:	8b 45 08             	mov    0x8(%ebp),%eax
     aa4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     aa7:	90                   	nop
     aa8:	8b 45 08             	mov    0x8(%ebp),%eax
     aab:	8d 50 01             	lea    0x1(%eax),%edx
     aae:	89 55 08             	mov    %edx,0x8(%ebp)
     ab1:	8b 55 0c             	mov    0xc(%ebp),%edx
     ab4:	8d 4a 01             	lea    0x1(%edx),%ecx
     ab7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     aba:	0f b6 12             	movzbl (%edx),%edx
     abd:	88 10                	mov    %dl,(%eax)
     abf:	0f b6 00             	movzbl (%eax),%eax
     ac2:	84 c0                	test   %al,%al
     ac4:	75 e2                	jne    aa8 <strcpy+0xd>
    ;
  return os;
     ac6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     ac9:	c9                   	leave  
     aca:	c3                   	ret    

00000acb <strcmp>:

int
strcmp(const char *p, const char *q)
{
     acb:	55                   	push   %ebp
     acc:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     ace:	eb 08                	jmp    ad8 <strcmp+0xd>
    p++, q++;
     ad0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     ad4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     ad8:	8b 45 08             	mov    0x8(%ebp),%eax
     adb:	0f b6 00             	movzbl (%eax),%eax
     ade:	84 c0                	test   %al,%al
     ae0:	74 10                	je     af2 <strcmp+0x27>
     ae2:	8b 45 08             	mov    0x8(%ebp),%eax
     ae5:	0f b6 10             	movzbl (%eax),%edx
     ae8:	8b 45 0c             	mov    0xc(%ebp),%eax
     aeb:	0f b6 00             	movzbl (%eax),%eax
     aee:	38 c2                	cmp    %al,%dl
     af0:	74 de                	je     ad0 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     af2:	8b 45 08             	mov    0x8(%ebp),%eax
     af5:	0f b6 00             	movzbl (%eax),%eax
     af8:	0f b6 d0             	movzbl %al,%edx
     afb:	8b 45 0c             	mov    0xc(%ebp),%eax
     afe:	0f b6 00             	movzbl (%eax),%eax
     b01:	0f b6 c0             	movzbl %al,%eax
     b04:	29 c2                	sub    %eax,%edx
     b06:	89 d0                	mov    %edx,%eax
}
     b08:	5d                   	pop    %ebp
     b09:	c3                   	ret    

00000b0a <strlen>:

uint
strlen(char *s)
{
     b0a:	55                   	push   %ebp
     b0b:	89 e5                	mov    %esp,%ebp
     b0d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     b10:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     b17:	eb 04                	jmp    b1d <strlen+0x13>
     b19:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     b1d:	8b 55 fc             	mov    -0x4(%ebp),%edx
     b20:	8b 45 08             	mov    0x8(%ebp),%eax
     b23:	01 d0                	add    %edx,%eax
     b25:	0f b6 00             	movzbl (%eax),%eax
     b28:	84 c0                	test   %al,%al
     b2a:	75 ed                	jne    b19 <strlen+0xf>
    ;
  return n;
     b2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     b2f:	c9                   	leave  
     b30:	c3                   	ret    

00000b31 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b31:	55                   	push   %ebp
     b32:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     b34:	8b 45 10             	mov    0x10(%ebp),%eax
     b37:	50                   	push   %eax
     b38:	ff 75 0c             	pushl  0xc(%ebp)
     b3b:	ff 75 08             	pushl  0x8(%ebp)
     b3e:	e8 32 ff ff ff       	call   a75 <stosb>
     b43:	83 c4 0c             	add    $0xc,%esp
  return dst;
     b46:	8b 45 08             	mov    0x8(%ebp),%eax
}
     b49:	c9                   	leave  
     b4a:	c3                   	ret    

00000b4b <strchr>:

char*
strchr(const char *s, char c)
{
     b4b:	55                   	push   %ebp
     b4c:	89 e5                	mov    %esp,%ebp
     b4e:	83 ec 04             	sub    $0x4,%esp
     b51:	8b 45 0c             	mov    0xc(%ebp),%eax
     b54:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     b57:	eb 14                	jmp    b6d <strchr+0x22>
    if(*s == c)
     b59:	8b 45 08             	mov    0x8(%ebp),%eax
     b5c:	0f b6 00             	movzbl (%eax),%eax
     b5f:	3a 45 fc             	cmp    -0x4(%ebp),%al
     b62:	75 05                	jne    b69 <strchr+0x1e>
      return (char*)s;
     b64:	8b 45 08             	mov    0x8(%ebp),%eax
     b67:	eb 13                	jmp    b7c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     b69:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     b6d:	8b 45 08             	mov    0x8(%ebp),%eax
     b70:	0f b6 00             	movzbl (%eax),%eax
     b73:	84 c0                	test   %al,%al
     b75:	75 e2                	jne    b59 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     b77:	b8 00 00 00 00       	mov    $0x0,%eax
}
     b7c:	c9                   	leave  
     b7d:	c3                   	ret    

00000b7e <gets>:

char*
gets(char *buf, int max)
{
     b7e:	55                   	push   %ebp
     b7f:	89 e5                	mov    %esp,%ebp
     b81:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     b84:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b8b:	eb 42                	jmp    bcf <gets+0x51>
    cc = read(0, &c, 1);
     b8d:	83 ec 04             	sub    $0x4,%esp
     b90:	6a 01                	push   $0x1
     b92:	8d 45 ef             	lea    -0x11(%ebp),%eax
     b95:	50                   	push   %eax
     b96:	6a 00                	push   $0x0
     b98:	e8 47 01 00 00       	call   ce4 <read>
     b9d:	83 c4 10             	add    $0x10,%esp
     ba0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     ba3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     ba7:	7e 33                	jle    bdc <gets+0x5e>
      break;
    buf[i++] = c;
     ba9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bac:	8d 50 01             	lea    0x1(%eax),%edx
     baf:	89 55 f4             	mov    %edx,-0xc(%ebp)
     bb2:	89 c2                	mov    %eax,%edx
     bb4:	8b 45 08             	mov    0x8(%ebp),%eax
     bb7:	01 c2                	add    %eax,%edx
     bb9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     bbd:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     bbf:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     bc3:	3c 0a                	cmp    $0xa,%al
     bc5:	74 16                	je     bdd <gets+0x5f>
     bc7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     bcb:	3c 0d                	cmp    $0xd,%al
     bcd:	74 0e                	je     bdd <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd2:	83 c0 01             	add    $0x1,%eax
     bd5:	3b 45 0c             	cmp    0xc(%ebp),%eax
     bd8:	7c b3                	jl     b8d <gets+0xf>
     bda:	eb 01                	jmp    bdd <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     bdc:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     bdd:	8b 55 f4             	mov    -0xc(%ebp),%edx
     be0:	8b 45 08             	mov    0x8(%ebp),%eax
     be3:	01 d0                	add    %edx,%eax
     be5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     be8:	8b 45 08             	mov    0x8(%ebp),%eax
}
     beb:	c9                   	leave  
     bec:	c3                   	ret    

00000bed <stat>:

int
stat(char *n, struct stat *st)
{
     bed:	55                   	push   %ebp
     bee:	89 e5                	mov    %esp,%ebp
     bf0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     bf3:	83 ec 08             	sub    $0x8,%esp
     bf6:	6a 00                	push   $0x0
     bf8:	ff 75 08             	pushl  0x8(%ebp)
     bfb:	e8 0c 01 00 00       	call   d0c <open>
     c00:	83 c4 10             	add    $0x10,%esp
     c03:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     c06:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c0a:	79 07                	jns    c13 <stat+0x26>
    return -1;
     c0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c11:	eb 25                	jmp    c38 <stat+0x4b>
  r = fstat(fd, st);
     c13:	83 ec 08             	sub    $0x8,%esp
     c16:	ff 75 0c             	pushl  0xc(%ebp)
     c19:	ff 75 f4             	pushl  -0xc(%ebp)
     c1c:	e8 03 01 00 00       	call   d24 <fstat>
     c21:	83 c4 10             	add    $0x10,%esp
     c24:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     c27:	83 ec 0c             	sub    $0xc,%esp
     c2a:	ff 75 f4             	pushl  -0xc(%ebp)
     c2d:	e8 c2 00 00 00       	call   cf4 <close>
     c32:	83 c4 10             	add    $0x10,%esp
  return r;
     c35:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     c38:	c9                   	leave  
     c39:	c3                   	ret    

00000c3a <atoi>:

int
atoi(const char *s)
{
     c3a:	55                   	push   %ebp
     c3b:	89 e5                	mov    %esp,%ebp
     c3d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     c40:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     c47:	eb 25                	jmp    c6e <atoi+0x34>
    n = n*10 + *s++ - '0';
     c49:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c4c:	89 d0                	mov    %edx,%eax
     c4e:	c1 e0 02             	shl    $0x2,%eax
     c51:	01 d0                	add    %edx,%eax
     c53:	01 c0                	add    %eax,%eax
     c55:	89 c1                	mov    %eax,%ecx
     c57:	8b 45 08             	mov    0x8(%ebp),%eax
     c5a:	8d 50 01             	lea    0x1(%eax),%edx
     c5d:	89 55 08             	mov    %edx,0x8(%ebp)
     c60:	0f b6 00             	movzbl (%eax),%eax
     c63:	0f be c0             	movsbl %al,%eax
     c66:	01 c8                	add    %ecx,%eax
     c68:	83 e8 30             	sub    $0x30,%eax
     c6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c6e:	8b 45 08             	mov    0x8(%ebp),%eax
     c71:	0f b6 00             	movzbl (%eax),%eax
     c74:	3c 2f                	cmp    $0x2f,%al
     c76:	7e 0a                	jle    c82 <atoi+0x48>
     c78:	8b 45 08             	mov    0x8(%ebp),%eax
     c7b:	0f b6 00             	movzbl (%eax),%eax
     c7e:	3c 39                	cmp    $0x39,%al
     c80:	7e c7                	jle    c49 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     c82:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     c85:	c9                   	leave  
     c86:	c3                   	ret    

00000c87 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     c87:	55                   	push   %ebp
     c88:	89 e5                	mov    %esp,%ebp
     c8a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     c8d:	8b 45 08             	mov    0x8(%ebp),%eax
     c90:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     c93:	8b 45 0c             	mov    0xc(%ebp),%eax
     c96:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     c99:	eb 17                	jmp    cb2 <memmove+0x2b>
    *dst++ = *src++;
     c9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c9e:	8d 50 01             	lea    0x1(%eax),%edx
     ca1:	89 55 fc             	mov    %edx,-0x4(%ebp)
     ca4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ca7:	8d 4a 01             	lea    0x1(%edx),%ecx
     caa:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     cad:	0f b6 12             	movzbl (%edx),%edx
     cb0:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     cb2:	8b 45 10             	mov    0x10(%ebp),%eax
     cb5:	8d 50 ff             	lea    -0x1(%eax),%edx
     cb8:	89 55 10             	mov    %edx,0x10(%ebp)
     cbb:	85 c0                	test   %eax,%eax
     cbd:	7f dc                	jg     c9b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     cbf:	8b 45 08             	mov    0x8(%ebp),%eax
}
     cc2:	c9                   	leave  
     cc3:	c3                   	ret    

00000cc4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     cc4:	b8 01 00 00 00       	mov    $0x1,%eax
     cc9:	cd 40                	int    $0x40
     ccb:	c3                   	ret    

00000ccc <exit>:
SYSCALL(exit)
     ccc:	b8 02 00 00 00       	mov    $0x2,%eax
     cd1:	cd 40                	int    $0x40
     cd3:	c3                   	ret    

00000cd4 <wait>:
SYSCALL(wait)
     cd4:	b8 03 00 00 00       	mov    $0x3,%eax
     cd9:	cd 40                	int    $0x40
     cdb:	c3                   	ret    

00000cdc <pipe>:
SYSCALL(pipe)
     cdc:	b8 04 00 00 00       	mov    $0x4,%eax
     ce1:	cd 40                	int    $0x40
     ce3:	c3                   	ret    

00000ce4 <read>:
SYSCALL(read)
     ce4:	b8 05 00 00 00       	mov    $0x5,%eax
     ce9:	cd 40                	int    $0x40
     ceb:	c3                   	ret    

00000cec <write>:
SYSCALL(write)
     cec:	b8 10 00 00 00       	mov    $0x10,%eax
     cf1:	cd 40                	int    $0x40
     cf3:	c3                   	ret    

00000cf4 <close>:
SYSCALL(close)
     cf4:	b8 15 00 00 00       	mov    $0x15,%eax
     cf9:	cd 40                	int    $0x40
     cfb:	c3                   	ret    

00000cfc <kill>:
SYSCALL(kill)
     cfc:	b8 06 00 00 00       	mov    $0x6,%eax
     d01:	cd 40                	int    $0x40
     d03:	c3                   	ret    

00000d04 <exec>:
SYSCALL(exec)
     d04:	b8 07 00 00 00       	mov    $0x7,%eax
     d09:	cd 40                	int    $0x40
     d0b:	c3                   	ret    

00000d0c <open>:
SYSCALL(open)
     d0c:	b8 0f 00 00 00       	mov    $0xf,%eax
     d11:	cd 40                	int    $0x40
     d13:	c3                   	ret    

00000d14 <mknod>:
SYSCALL(mknod)
     d14:	b8 11 00 00 00       	mov    $0x11,%eax
     d19:	cd 40                	int    $0x40
     d1b:	c3                   	ret    

00000d1c <unlink>:
SYSCALL(unlink)
     d1c:	b8 12 00 00 00       	mov    $0x12,%eax
     d21:	cd 40                	int    $0x40
     d23:	c3                   	ret    

00000d24 <fstat>:
SYSCALL(fstat)
     d24:	b8 08 00 00 00       	mov    $0x8,%eax
     d29:	cd 40                	int    $0x40
     d2b:	c3                   	ret    

00000d2c <link>:
SYSCALL(link)
     d2c:	b8 13 00 00 00       	mov    $0x13,%eax
     d31:	cd 40                	int    $0x40
     d33:	c3                   	ret    

00000d34 <mkdir>:
SYSCALL(mkdir)
     d34:	b8 14 00 00 00       	mov    $0x14,%eax
     d39:	cd 40                	int    $0x40
     d3b:	c3                   	ret    

00000d3c <chdir>:
SYSCALL(chdir)
     d3c:	b8 09 00 00 00       	mov    $0x9,%eax
     d41:	cd 40                	int    $0x40
     d43:	c3                   	ret    

00000d44 <dup>:
SYSCALL(dup)
     d44:	b8 0a 00 00 00       	mov    $0xa,%eax
     d49:	cd 40                	int    $0x40
     d4b:	c3                   	ret    

00000d4c <getpid>:
SYSCALL(getpid)
     d4c:	b8 0b 00 00 00       	mov    $0xb,%eax
     d51:	cd 40                	int    $0x40
     d53:	c3                   	ret    

00000d54 <sbrk>:
SYSCALL(sbrk)
     d54:	b8 0c 00 00 00       	mov    $0xc,%eax
     d59:	cd 40                	int    $0x40
     d5b:	c3                   	ret    

00000d5c <sleep>:
SYSCALL(sleep)
     d5c:	b8 0d 00 00 00       	mov    $0xd,%eax
     d61:	cd 40                	int    $0x40
     d63:	c3                   	ret    

00000d64 <uptime>:
SYSCALL(uptime)
     d64:	b8 0e 00 00 00       	mov    $0xe,%eax
     d69:	cd 40                	int    $0x40
     d6b:	c3                   	ret    

00000d6c <paintWindow>:

SYSCALL(paintWindow)
     d6c:	b8 16 00 00 00       	mov    $0x16,%eax
     d71:	cd 40                	int    $0x40
     d73:	c3                   	ret    

00000d74 <sendMessage>:
SYSCALL(sendMessage)
     d74:	b8 17 00 00 00       	mov    $0x17,%eax
     d79:	cd 40                	int    $0x40
     d7b:	c3                   	ret    

00000d7c <getMessage>:
SYSCALL(getMessage)
     d7c:	b8 19 00 00 00       	mov    $0x19,%eax
     d81:	cd 40                	int    $0x40
     d83:	c3                   	ret    

00000d84 <registWindow>:
SYSCALL(registWindow)
     d84:	b8 18 00 00 00       	mov    $0x18,%eax
     d89:	cd 40                	int    $0x40
     d8b:	c3                   	ret    

00000d8c <changePosition>:
SYSCALL(changePosition)
     d8c:	b8 1a 00 00 00       	mov    $0x1a,%eax
     d91:	cd 40                	int    $0x40
     d93:	c3                   	ret    

00000d94 <setupTimer>:
SYSCALL(setupTimer)
     d94:	b8 1b 00 00 00       	mov    $0x1b,%eax
     d99:	cd 40                	int    $0x40
     d9b:	c3                   	ret    

00000d9c <deleteTimer>:
SYSCALL(deleteTimer)
     d9c:	b8 1c 00 00 00       	mov    $0x1c,%eax
     da1:	cd 40                	int    $0x40
     da3:	c3                   	ret    

00000da4 <getCurrentTime>:
SYSCALL(getCurrentTime)
     da4:	b8 1d 00 00 00       	mov    $0x1d,%eax
     da9:	cd 40                	int    $0x40
     dab:	c3                   	ret    

00000dac <removeWindow>:
SYSCALL(removeWindow)
     dac:	b8 1e 00 00 00       	mov    $0x1e,%eax
     db1:	cd 40                	int    $0x40
     db3:	c3                   	ret    

00000db4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     db4:	55                   	push   %ebp
     db5:	89 e5                	mov    %esp,%ebp
     db7:	83 ec 18             	sub    $0x18,%esp
     dba:	8b 45 0c             	mov    0xc(%ebp),%eax
     dbd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     dc0:	83 ec 04             	sub    $0x4,%esp
     dc3:	6a 01                	push   $0x1
     dc5:	8d 45 f4             	lea    -0xc(%ebp),%eax
     dc8:	50                   	push   %eax
     dc9:	ff 75 08             	pushl  0x8(%ebp)
     dcc:	e8 1b ff ff ff       	call   cec <write>
     dd1:	83 c4 10             	add    $0x10,%esp
}
     dd4:	90                   	nop
     dd5:	c9                   	leave  
     dd6:	c3                   	ret    

00000dd7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     dd7:	55                   	push   %ebp
     dd8:	89 e5                	mov    %esp,%ebp
     dda:	53                   	push   %ebx
     ddb:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     dde:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     de5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     de9:	74 17                	je     e02 <printint+0x2b>
     deb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     def:	79 11                	jns    e02 <printint+0x2b>
    neg = 1;
     df1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     df8:	8b 45 0c             	mov    0xc(%ebp),%eax
     dfb:	f7 d8                	neg    %eax
     dfd:	89 45 ec             	mov    %eax,-0x14(%ebp)
     e00:	eb 06                	jmp    e08 <printint+0x31>
  } else {
    x = xx;
     e02:	8b 45 0c             	mov    0xc(%ebp),%eax
     e05:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     e08:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     e0f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     e12:	8d 41 01             	lea    0x1(%ecx),%eax
     e15:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e18:	8b 5d 10             	mov    0x10(%ebp),%ebx
     e1b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e1e:	ba 00 00 00 00       	mov    $0x0,%edx
     e23:	f7 f3                	div    %ebx
     e25:	89 d0                	mov    %edx,%eax
     e27:	0f b6 80 04 39 00 00 	movzbl 0x3904(%eax),%eax
     e2e:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     e32:	8b 5d 10             	mov    0x10(%ebp),%ebx
     e35:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e38:	ba 00 00 00 00       	mov    $0x0,%edx
     e3d:	f7 f3                	div    %ebx
     e3f:	89 45 ec             	mov    %eax,-0x14(%ebp)
     e42:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     e46:	75 c7                	jne    e0f <printint+0x38>
  if(neg)
     e48:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     e4c:	74 2d                	je     e7b <printint+0xa4>
    buf[i++] = '-';
     e4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e51:	8d 50 01             	lea    0x1(%eax),%edx
     e54:	89 55 f4             	mov    %edx,-0xc(%ebp)
     e57:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     e5c:	eb 1d                	jmp    e7b <printint+0xa4>
    putc(fd, buf[i]);
     e5e:	8d 55 dc             	lea    -0x24(%ebp),%edx
     e61:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e64:	01 d0                	add    %edx,%eax
     e66:	0f b6 00             	movzbl (%eax),%eax
     e69:	0f be c0             	movsbl %al,%eax
     e6c:	83 ec 08             	sub    $0x8,%esp
     e6f:	50                   	push   %eax
     e70:	ff 75 08             	pushl  0x8(%ebp)
     e73:	e8 3c ff ff ff       	call   db4 <putc>
     e78:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     e7b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     e7f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e83:	79 d9                	jns    e5e <printint+0x87>
    putc(fd, buf[i]);
}
     e85:	90                   	nop
     e86:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e89:	c9                   	leave  
     e8a:	c3                   	ret    

00000e8b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     e8b:	55                   	push   %ebp
     e8c:	89 e5                	mov    %esp,%ebp
     e8e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     e91:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     e98:	8d 45 0c             	lea    0xc(%ebp),%eax
     e9b:	83 c0 04             	add    $0x4,%eax
     e9e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     ea1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ea8:	e9 59 01 00 00       	jmp    1006 <printf+0x17b>
    c = fmt[i] & 0xff;
     ead:	8b 55 0c             	mov    0xc(%ebp),%edx
     eb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     eb3:	01 d0                	add    %edx,%eax
     eb5:	0f b6 00             	movzbl (%eax),%eax
     eb8:	0f be c0             	movsbl %al,%eax
     ebb:	25 ff 00 00 00       	and    $0xff,%eax
     ec0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     ec3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ec7:	75 2c                	jne    ef5 <printf+0x6a>
      if(c == '%'){
     ec9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     ecd:	75 0c                	jne    edb <printf+0x50>
        state = '%';
     ecf:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     ed6:	e9 27 01 00 00       	jmp    1002 <printf+0x177>
      } else {
        putc(fd, c);
     edb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ede:	0f be c0             	movsbl %al,%eax
     ee1:	83 ec 08             	sub    $0x8,%esp
     ee4:	50                   	push   %eax
     ee5:	ff 75 08             	pushl  0x8(%ebp)
     ee8:	e8 c7 fe ff ff       	call   db4 <putc>
     eed:	83 c4 10             	add    $0x10,%esp
     ef0:	e9 0d 01 00 00       	jmp    1002 <printf+0x177>
      }
    } else if(state == '%'){
     ef5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     ef9:	0f 85 03 01 00 00    	jne    1002 <printf+0x177>
      if(c == 'd'){
     eff:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     f03:	75 1e                	jne    f23 <printf+0x98>
        printint(fd, *ap, 10, 1);
     f05:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f08:	8b 00                	mov    (%eax),%eax
     f0a:	6a 01                	push   $0x1
     f0c:	6a 0a                	push   $0xa
     f0e:	50                   	push   %eax
     f0f:	ff 75 08             	pushl  0x8(%ebp)
     f12:	e8 c0 fe ff ff       	call   dd7 <printint>
     f17:	83 c4 10             	add    $0x10,%esp
        ap++;
     f1a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     f1e:	e9 d8 00 00 00       	jmp    ffb <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     f23:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     f27:	74 06                	je     f2f <printf+0xa4>
     f29:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     f2d:	75 1e                	jne    f4d <printf+0xc2>
        printint(fd, *ap, 16, 0);
     f2f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f32:	8b 00                	mov    (%eax),%eax
     f34:	6a 00                	push   $0x0
     f36:	6a 10                	push   $0x10
     f38:	50                   	push   %eax
     f39:	ff 75 08             	pushl  0x8(%ebp)
     f3c:	e8 96 fe ff ff       	call   dd7 <printint>
     f41:	83 c4 10             	add    $0x10,%esp
        ap++;
     f44:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     f48:	e9 ae 00 00 00       	jmp    ffb <printf+0x170>
      } else if(c == 's'){
     f4d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     f51:	75 43                	jne    f96 <printf+0x10b>
        s = (char*)*ap;
     f53:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f56:	8b 00                	mov    (%eax),%eax
     f58:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     f5b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     f5f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     f63:	75 25                	jne    f8a <printf+0xff>
          s = "(null)";
     f65:	c7 45 f4 68 30 00 00 	movl   $0x3068,-0xc(%ebp)
        while(*s != 0){
     f6c:	eb 1c                	jmp    f8a <printf+0xff>
          putc(fd, *s);
     f6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f71:	0f b6 00             	movzbl (%eax),%eax
     f74:	0f be c0             	movsbl %al,%eax
     f77:	83 ec 08             	sub    $0x8,%esp
     f7a:	50                   	push   %eax
     f7b:	ff 75 08             	pushl  0x8(%ebp)
     f7e:	e8 31 fe ff ff       	call   db4 <putc>
     f83:	83 c4 10             	add    $0x10,%esp
          s++;
     f86:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     f8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f8d:	0f b6 00             	movzbl (%eax),%eax
     f90:	84 c0                	test   %al,%al
     f92:	75 da                	jne    f6e <printf+0xe3>
     f94:	eb 65                	jmp    ffb <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     f96:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     f9a:	75 1d                	jne    fb9 <printf+0x12e>
        putc(fd, *ap);
     f9c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f9f:	8b 00                	mov    (%eax),%eax
     fa1:	0f be c0             	movsbl %al,%eax
     fa4:	83 ec 08             	sub    $0x8,%esp
     fa7:	50                   	push   %eax
     fa8:	ff 75 08             	pushl  0x8(%ebp)
     fab:	e8 04 fe ff ff       	call   db4 <putc>
     fb0:	83 c4 10             	add    $0x10,%esp
        ap++;
     fb3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     fb7:	eb 42                	jmp    ffb <printf+0x170>
      } else if(c == '%'){
     fb9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     fbd:	75 17                	jne    fd6 <printf+0x14b>
        putc(fd, c);
     fbf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fc2:	0f be c0             	movsbl %al,%eax
     fc5:	83 ec 08             	sub    $0x8,%esp
     fc8:	50                   	push   %eax
     fc9:	ff 75 08             	pushl  0x8(%ebp)
     fcc:	e8 e3 fd ff ff       	call   db4 <putc>
     fd1:	83 c4 10             	add    $0x10,%esp
     fd4:	eb 25                	jmp    ffb <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     fd6:	83 ec 08             	sub    $0x8,%esp
     fd9:	6a 25                	push   $0x25
     fdb:	ff 75 08             	pushl  0x8(%ebp)
     fde:	e8 d1 fd ff ff       	call   db4 <putc>
     fe3:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     fe6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fe9:	0f be c0             	movsbl %al,%eax
     fec:	83 ec 08             	sub    $0x8,%esp
     fef:	50                   	push   %eax
     ff0:	ff 75 08             	pushl  0x8(%ebp)
     ff3:	e8 bc fd ff ff       	call   db4 <putc>
     ff8:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     ffb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1002:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1006:	8b 55 0c             	mov    0xc(%ebp),%edx
    1009:	8b 45 f0             	mov    -0x10(%ebp),%eax
    100c:	01 d0                	add    %edx,%eax
    100e:	0f b6 00             	movzbl (%eax),%eax
    1011:	84 c0                	test   %al,%al
    1013:	0f 85 94 fe ff ff    	jne    ead <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1019:	90                   	nop
    101a:	c9                   	leave  
    101b:	c3                   	ret    

0000101c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    101c:	55                   	push   %ebp
    101d:	89 e5                	mov    %esp,%ebp
    101f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1022:	8b 45 08             	mov    0x8(%ebp),%eax
    1025:	83 e8 08             	sub    $0x8,%eax
    1028:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    102b:	a1 68 75 00 00       	mov    0x7568,%eax
    1030:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1033:	eb 24                	jmp    1059 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1035:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1038:	8b 00                	mov    (%eax),%eax
    103a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    103d:	77 12                	ja     1051 <free+0x35>
    103f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1042:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1045:	77 24                	ja     106b <free+0x4f>
    1047:	8b 45 fc             	mov    -0x4(%ebp),%eax
    104a:	8b 00                	mov    (%eax),%eax
    104c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    104f:	77 1a                	ja     106b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1051:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1054:	8b 00                	mov    (%eax),%eax
    1056:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1059:	8b 45 f8             	mov    -0x8(%ebp),%eax
    105c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    105f:	76 d4                	jbe    1035 <free+0x19>
    1061:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1064:	8b 00                	mov    (%eax),%eax
    1066:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1069:	76 ca                	jbe    1035 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    106b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    106e:	8b 40 04             	mov    0x4(%eax),%eax
    1071:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1078:	8b 45 f8             	mov    -0x8(%ebp),%eax
    107b:	01 c2                	add    %eax,%edx
    107d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1080:	8b 00                	mov    (%eax),%eax
    1082:	39 c2                	cmp    %eax,%edx
    1084:	75 24                	jne    10aa <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1086:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1089:	8b 50 04             	mov    0x4(%eax),%edx
    108c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    108f:	8b 00                	mov    (%eax),%eax
    1091:	8b 40 04             	mov    0x4(%eax),%eax
    1094:	01 c2                	add    %eax,%edx
    1096:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1099:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    109c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    109f:	8b 00                	mov    (%eax),%eax
    10a1:	8b 10                	mov    (%eax),%edx
    10a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    10a6:	89 10                	mov    %edx,(%eax)
    10a8:	eb 0a                	jmp    10b4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    10aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10ad:	8b 10                	mov    (%eax),%edx
    10af:	8b 45 f8             	mov    -0x8(%ebp),%eax
    10b2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    10b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10b7:	8b 40 04             	mov    0x4(%eax),%eax
    10ba:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    10c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10c4:	01 d0                	add    %edx,%eax
    10c6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    10c9:	75 20                	jne    10eb <free+0xcf>
    p->s.size += bp->s.size;
    10cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10ce:	8b 50 04             	mov    0x4(%eax),%edx
    10d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    10d4:	8b 40 04             	mov    0x4(%eax),%eax
    10d7:	01 c2                	add    %eax,%edx
    10d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10dc:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    10df:	8b 45 f8             	mov    -0x8(%ebp),%eax
    10e2:	8b 10                	mov    (%eax),%edx
    10e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10e7:	89 10                	mov    %edx,(%eax)
    10e9:	eb 08                	jmp    10f3 <free+0xd7>
  } else
    p->s.ptr = bp;
    10eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10ee:	8b 55 f8             	mov    -0x8(%ebp),%edx
    10f1:	89 10                	mov    %edx,(%eax)
  freep = p;
    10f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10f6:	a3 68 75 00 00       	mov    %eax,0x7568
}
    10fb:	90                   	nop
    10fc:	c9                   	leave  
    10fd:	c3                   	ret    

000010fe <morecore>:

static Header*
morecore(uint nu)
{
    10fe:	55                   	push   %ebp
    10ff:	89 e5                	mov    %esp,%ebp
    1101:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1104:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    110b:	77 07                	ja     1114 <morecore+0x16>
    nu = 4096;
    110d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1114:	8b 45 08             	mov    0x8(%ebp),%eax
    1117:	c1 e0 03             	shl    $0x3,%eax
    111a:	83 ec 0c             	sub    $0xc,%esp
    111d:	50                   	push   %eax
    111e:	e8 31 fc ff ff       	call   d54 <sbrk>
    1123:	83 c4 10             	add    $0x10,%esp
    1126:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1129:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    112d:	75 07                	jne    1136 <morecore+0x38>
    return 0;
    112f:	b8 00 00 00 00       	mov    $0x0,%eax
    1134:	eb 26                	jmp    115c <morecore+0x5e>
  hp = (Header*)p;
    1136:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1139:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    113c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    113f:	8b 55 08             	mov    0x8(%ebp),%edx
    1142:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1145:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1148:	83 c0 08             	add    $0x8,%eax
    114b:	83 ec 0c             	sub    $0xc,%esp
    114e:	50                   	push   %eax
    114f:	e8 c8 fe ff ff       	call   101c <free>
    1154:	83 c4 10             	add    $0x10,%esp
  return freep;
    1157:	a1 68 75 00 00       	mov    0x7568,%eax
}
    115c:	c9                   	leave  
    115d:	c3                   	ret    

0000115e <malloc>:

void*
malloc(uint nbytes)
{
    115e:	55                   	push   %ebp
    115f:	89 e5                	mov    %esp,%ebp
    1161:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1164:	8b 45 08             	mov    0x8(%ebp),%eax
    1167:	83 c0 07             	add    $0x7,%eax
    116a:	c1 e8 03             	shr    $0x3,%eax
    116d:	83 c0 01             	add    $0x1,%eax
    1170:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1173:	a1 68 75 00 00       	mov    0x7568,%eax
    1178:	89 45 f0             	mov    %eax,-0x10(%ebp)
    117b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    117f:	75 23                	jne    11a4 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1181:	c7 45 f0 60 75 00 00 	movl   $0x7560,-0x10(%ebp)
    1188:	8b 45 f0             	mov    -0x10(%ebp),%eax
    118b:	a3 68 75 00 00       	mov    %eax,0x7568
    1190:	a1 68 75 00 00       	mov    0x7568,%eax
    1195:	a3 60 75 00 00       	mov    %eax,0x7560
    base.s.size = 0;
    119a:	c7 05 64 75 00 00 00 	movl   $0x0,0x7564
    11a1:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11a7:	8b 00                	mov    (%eax),%eax
    11a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    11ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11af:	8b 40 04             	mov    0x4(%eax),%eax
    11b2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    11b5:	72 4d                	jb     1204 <malloc+0xa6>
      if(p->s.size == nunits)
    11b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ba:	8b 40 04             	mov    0x4(%eax),%eax
    11bd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    11c0:	75 0c                	jne    11ce <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    11c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11c5:	8b 10                	mov    (%eax),%edx
    11c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11ca:	89 10                	mov    %edx,(%eax)
    11cc:	eb 26                	jmp    11f4 <malloc+0x96>
      else {
        p->s.size -= nunits;
    11ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11d1:	8b 40 04             	mov    0x4(%eax),%eax
    11d4:	2b 45 ec             	sub    -0x14(%ebp),%eax
    11d7:	89 c2                	mov    %eax,%edx
    11d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11dc:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    11df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11e2:	8b 40 04             	mov    0x4(%eax),%eax
    11e5:	c1 e0 03             	shl    $0x3,%eax
    11e8:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    11eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ee:	8b 55 ec             	mov    -0x14(%ebp),%edx
    11f1:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    11f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11f7:	a3 68 75 00 00       	mov    %eax,0x7568
      return (void*)(p + 1);
    11fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ff:	83 c0 08             	add    $0x8,%eax
    1202:	eb 3b                	jmp    123f <malloc+0xe1>
    }
    if(p == freep)
    1204:	a1 68 75 00 00       	mov    0x7568,%eax
    1209:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    120c:	75 1e                	jne    122c <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    120e:	83 ec 0c             	sub    $0xc,%esp
    1211:	ff 75 ec             	pushl  -0x14(%ebp)
    1214:	e8 e5 fe ff ff       	call   10fe <morecore>
    1219:	83 c4 10             	add    $0x10,%esp
    121c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    121f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1223:	75 07                	jne    122c <malloc+0xce>
        return 0;
    1225:	b8 00 00 00 00       	mov    $0x0,%eax
    122a:	eb 13                	jmp    123f <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    122c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    122f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1232:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1235:	8b 00                	mov    (%eax),%eax
    1237:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    123a:	e9 6d ff ff ff       	jmp    11ac <malloc+0x4e>
}
    123f:	c9                   	leave  
    1240:	c3                   	ret    

00001241 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1241:	55                   	push   %ebp
    1242:	89 e5                	mov    %esp,%ebp
    1244:	83 ec 1c             	sub    $0x1c,%esp
    1247:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    124a:	8b 55 10             	mov    0x10(%ebp),%edx
    124d:	8b 45 14             	mov    0x14(%ebp),%eax
    1250:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1253:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1256:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1259:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    125d:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1260:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1264:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1267:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    126b:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    126e:	8b 45 08             	mov    0x8(%ebp),%eax
    1271:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1275:	66 89 10             	mov    %dx,(%eax)
    1278:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    127c:	88 50 02             	mov    %dl,0x2(%eax)
}
    127f:	8b 45 08             	mov    0x8(%ebp),%eax
    1282:	c9                   	leave  
    1283:	c2 04 00             	ret    $0x4

00001286 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    1286:	55                   	push   %ebp
    1287:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
    1289:	8b 45 08             	mov    0x8(%ebp),%eax
    128c:	2b 45 10             	sub    0x10(%ebp),%eax
    128f:	89 c2                	mov    %eax,%edx
    1291:	8b 45 08             	mov    0x8(%ebp),%eax
    1294:	2b 45 10             	sub    0x10(%ebp),%eax
    1297:	0f af d0             	imul   %eax,%edx
    129a:	8b 45 0c             	mov    0xc(%ebp),%eax
    129d:	2b 45 14             	sub    0x14(%ebp),%eax
    12a0:	89 c1                	mov    %eax,%ecx
    12a2:	8b 45 0c             	mov    0xc(%ebp),%eax
    12a5:	2b 45 14             	sub    0x14(%ebp),%eax
    12a8:	0f af c1             	imul   %ecx,%eax
    12ab:	01 d0                	add    %edx,%eax
}
    12ad:	5d                   	pop    %ebp
    12ae:	c3                   	ret    

000012af <abs_int>:

static inline int abs_int(int x)
{
    12af:	55                   	push   %ebp
    12b0:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
    12b2:	8b 45 08             	mov    0x8(%ebp),%eax
    12b5:	99                   	cltd   
    12b6:	89 d0                	mov    %edx,%eax
    12b8:	33 45 08             	xor    0x8(%ebp),%eax
    12bb:	29 d0                	sub    %edx,%eax
}
    12bd:	5d                   	pop    %ebp
    12be:	c3                   	ret    

000012bf <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    12bf:	55                   	push   %ebp
    12c0:	89 e5                	mov    %esp,%ebp
    if (x < 0)
    12c2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12c6:	79 07                	jns    12cf <APGetIndex+0x10>
        return X_SMALLER;
    12c8:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    12cd:	eb 40                	jmp    130f <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
    12cf:	8b 45 08             	mov    0x8(%ebp),%eax
    12d2:	8b 00                	mov    (%eax),%eax
    12d4:	3b 45 0c             	cmp    0xc(%ebp),%eax
    12d7:	7f 07                	jg     12e0 <APGetIndex+0x21>
        return X_BIGGER;
    12d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12de:	eb 2f                	jmp    130f <APGetIndex+0x50>
    if (y < 0)
    12e0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12e4:	79 07                	jns    12ed <APGetIndex+0x2e>
        return Y_SMALLER;
    12e6:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
    12eb:	eb 22                	jmp    130f <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
    12ed:	8b 45 08             	mov    0x8(%ebp),%eax
    12f0:	8b 40 04             	mov    0x4(%eax),%eax
    12f3:	3b 45 10             	cmp    0x10(%ebp),%eax
    12f6:	7f 07                	jg     12ff <APGetIndex+0x40>
        return Y_BIGGER;
    12f8:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    12fd:	eb 10                	jmp    130f <APGetIndex+0x50>
    return y * hdc->size.cx + x;
    12ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1302:	8b 00                	mov    (%eax),%eax
    1304:	0f af 45 10          	imul   0x10(%ebp),%eax
    1308:	89 c2                	mov    %eax,%edx
    130a:	8b 45 0c             	mov    0xc(%ebp),%eax
    130d:	01 d0                	add    %edx,%eax
}
    130f:	5d                   	pop    %ebp
    1310:	c3                   	ret    

00001311 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    1311:	55                   	push   %ebp
    1312:	89 e5                	mov    %esp,%ebp
    1314:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    1317:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    131e:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1321:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    1324:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    132b:	83 ec 08             	sub    $0x8,%esp
    132e:	6a 00                	push   $0x0
    1330:	ff 75 0c             	pushl  0xc(%ebp)
    1333:	e8 d4 f9 ff ff       	call   d0c <open>
    1338:	83 c4 10             	add    $0x10,%esp
    133b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    133e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1342:	79 2e                	jns    1372 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
    1344:	83 ec 04             	sub    $0x4,%esp
    1347:	ff 75 0c             	pushl  0xc(%ebp)
    134a:	68 6f 30 00 00       	push   $0x306f
    134f:	6a 01                	push   $0x1
    1351:	e8 35 fb ff ff       	call   e8b <printf>
    1356:	83 c4 10             	add    $0x10,%esp
        return bmp;
    1359:	8b 45 08             	mov    0x8(%ebp),%eax
    135c:	8b 55 c8             	mov    -0x38(%ebp),%edx
    135f:	89 10                	mov    %edx,(%eax)
    1361:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1364:	89 50 04             	mov    %edx,0x4(%eax)
    1367:	8b 55 d0             	mov    -0x30(%ebp),%edx
    136a:	89 50 08             	mov    %edx,0x8(%eax)
    136d:	e9 d2 01 00 00       	jmp    1544 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    1372:	83 ec 04             	sub    $0x4,%esp
    1375:	6a 0e                	push   $0xe
    1377:	8d 45 ba             	lea    -0x46(%ebp),%eax
    137a:	50                   	push   %eax
    137b:	ff 75 ec             	pushl  -0x14(%ebp)
    137e:	e8 61 f9 ff ff       	call   ce4 <read>
    1383:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    1386:	83 ec 04             	sub    $0x4,%esp
    1389:	6a 28                	push   $0x28
    138b:	8d 45 92             	lea    -0x6e(%ebp),%eax
    138e:	50                   	push   %eax
    138f:	ff 75 ec             	pushl  -0x14(%ebp)
    1392:	e8 4d f9 ff ff       	call   ce4 <read>
    1397:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    139a:	8b 45 96             	mov    -0x6a(%ebp),%eax
    139d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    13a0:	8b 45 9a             	mov    -0x66(%ebp),%eax
    13a3:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    13a6:	8b 55 c8             	mov    -0x38(%ebp),%edx
    13a9:	8b 45 cc             	mov    -0x34(%ebp),%eax
    13ac:	0f af d0             	imul   %eax,%edx
    13af:	89 d0                	mov    %edx,%eax
    13b1:	01 c0                	add    %eax,%eax
    13b3:	01 d0                	add    %edx,%eax
    13b5:	83 ec 0c             	sub    $0xc,%esp
    13b8:	50                   	push   %eax
    13b9:	e8 a0 fd ff ff       	call   115e <malloc>
    13be:	83 c4 10             	add    $0x10,%esp
    13c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    13c4:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    13c8:	0f b7 c0             	movzwl %ax,%eax
    13cb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    13ce:	8b 55 c8             	mov    -0x38(%ebp),%edx
    13d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13d4:	0f af c2             	imul   %edx,%eax
    13d7:	83 c0 1f             	add    $0x1f,%eax
    13da:	c1 e8 05             	shr    $0x5,%eax
    13dd:	c1 e0 02             	shl    $0x2,%eax
    13e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    13e3:	8b 55 cc             	mov    -0x34(%ebp),%edx
    13e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    13e9:	0f af c2             	imul   %edx,%eax
    13ec:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    13ef:	8b 45 e0             	mov    -0x20(%ebp),%eax
    13f2:	83 ec 0c             	sub    $0xc,%esp
    13f5:	50                   	push   %eax
    13f6:	e8 63 fd ff ff       	call   115e <malloc>
    13fb:	83 c4 10             	add    $0x10,%esp
    13fe:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    1401:	83 ec 04             	sub    $0x4,%esp
    1404:	ff 75 e0             	pushl  -0x20(%ebp)
    1407:	ff 75 dc             	pushl  -0x24(%ebp)
    140a:	ff 75 ec             	pushl  -0x14(%ebp)
    140d:	e8 d2 f8 ff ff       	call   ce4 <read>
    1412:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    1415:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    1419:	66 c1 e8 03          	shr    $0x3,%ax
    141d:	0f b7 c0             	movzwl %ax,%eax
    1420:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    1423:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    142a:	e9 e5 00 00 00       	jmp    1514 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    142f:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1432:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1435:	29 c2                	sub    %eax,%edx
    1437:	89 d0                	mov    %edx,%eax
    1439:	8d 50 ff             	lea    -0x1(%eax),%edx
    143c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    143f:	0f af c2             	imul   %edx,%eax
    1442:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    1445:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    144c:	e9 b1 00 00 00       	jmp    1502 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    1451:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1454:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1457:	8b 45 f0             	mov    -0x10(%ebp),%eax
    145a:	01 c8                	add    %ecx,%eax
    145c:	89 c1                	mov    %eax,%ecx
    145e:	89 c8                	mov    %ecx,%eax
    1460:	01 c0                	add    %eax,%eax
    1462:	01 c8                	add    %ecx,%eax
    1464:	01 c2                	add    %eax,%edx
    1466:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1469:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    146d:	89 c1                	mov    %eax,%ecx
    146f:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1472:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1476:	01 c1                	add    %eax,%ecx
    1478:	8b 45 d8             	mov    -0x28(%ebp),%eax
    147b:	01 c8                	add    %ecx,%eax
    147d:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1480:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1483:	01 c8                	add    %ecx,%eax
    1485:	0f b6 00             	movzbl (%eax),%eax
    1488:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    148b:	8b 55 d0             	mov    -0x30(%ebp),%edx
    148e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1491:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1494:	01 c8                	add    %ecx,%eax
    1496:	89 c1                	mov    %eax,%ecx
    1498:	89 c8                	mov    %ecx,%eax
    149a:	01 c0                	add    %eax,%eax
    149c:	01 c8                	add    %ecx,%eax
    149e:	01 c2                	add    %eax,%edx
    14a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a3:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    14a7:	89 c1                	mov    %eax,%ecx
    14a9:	8b 45 d8             	mov    -0x28(%ebp),%eax
    14ac:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    14b0:	01 c1                	add    %eax,%ecx
    14b2:	8b 45 d8             	mov    -0x28(%ebp),%eax
    14b5:	01 c8                	add    %ecx,%eax
    14b7:	8d 48 fe             	lea    -0x2(%eax),%ecx
    14ba:	8b 45 dc             	mov    -0x24(%ebp),%eax
    14bd:	01 c8                	add    %ecx,%eax
    14bf:	0f b6 00             	movzbl (%eax),%eax
    14c2:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    14c5:	8b 55 d0             	mov    -0x30(%ebp),%edx
    14c8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    14cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14ce:	01 c8                	add    %ecx,%eax
    14d0:	89 c1                	mov    %eax,%ecx
    14d2:	89 c8                	mov    %ecx,%eax
    14d4:	01 c0                	add    %eax,%eax
    14d6:	01 c8                	add    %ecx,%eax
    14d8:	01 c2                	add    %eax,%edx
    14da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14dd:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    14e1:	89 c1                	mov    %eax,%ecx
    14e3:	8b 45 d8             	mov    -0x28(%ebp),%eax
    14e6:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    14ea:	01 c1                	add    %eax,%ecx
    14ec:	8b 45 d8             	mov    -0x28(%ebp),%eax
    14ef:	01 c8                	add    %ecx,%eax
    14f1:	8d 48 fd             	lea    -0x3(%eax),%ecx
    14f4:	8b 45 dc             	mov    -0x24(%ebp),%eax
    14f7:	01 c8                	add    %ecx,%eax
    14f9:	0f b6 00             	movzbl (%eax),%eax
    14fc:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    14fe:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1502:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1505:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1508:	39 c2                	cmp    %eax,%edx
    150a:	0f 87 41 ff ff ff    	ja     1451 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    1510:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1514:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1517:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151a:	39 c2                	cmp    %eax,%edx
    151c:	0f 87 0d ff ff ff    	ja     142f <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    1522:	83 ec 0c             	sub    $0xc,%esp
    1525:	ff 75 ec             	pushl  -0x14(%ebp)
    1528:	e8 c7 f7 ff ff       	call   cf4 <close>
    152d:	83 c4 10             	add    $0x10,%esp
    return bmp;
    1530:	8b 45 08             	mov    0x8(%ebp),%eax
    1533:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1536:	89 10                	mov    %edx,(%eax)
    1538:	8b 55 cc             	mov    -0x34(%ebp),%edx
    153b:	89 50 04             	mov    %edx,0x4(%eax)
    153e:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1541:	89 50 08             	mov    %edx,0x8(%eax)
}
    1544:	8b 45 08             	mov    0x8(%ebp),%eax
    1547:	c9                   	leave  
    1548:	c2 04 00             	ret    $0x4

0000154b <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    154b:	55                   	push   %ebp
    154c:	89 e5                	mov    %esp,%ebp
    154e:	53                   	push   %ebx
    154f:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    1552:	83 ec 0c             	sub    $0xc,%esp
    1555:	6a 1c                	push   $0x1c
    1557:	e8 02 fc ff ff       	call   115e <malloc>
    155c:	83 c4 10             	add    $0x10,%esp
    155f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    1562:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1565:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    156c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    156f:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1572:	6a 0c                	push   $0xc
    1574:	6a 0c                	push   $0xc
    1576:	6a 0c                	push   $0xc
    1578:	50                   	push   %eax
    1579:	e8 c3 fc ff ff       	call   1241 <RGB>
    157e:	83 c4 0c             	add    $0xc,%esp
    1581:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    1585:	66 89 43 13          	mov    %ax,0x13(%ebx)
    1589:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    158d:	88 43 15             	mov    %al,0x15(%ebx)
    1590:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1593:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1596:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    159a:	66 89 48 10          	mov    %cx,0x10(%eax)
    159e:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    15a2:	88 50 12             	mov    %dl,0x12(%eax)
    15a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
    15ab:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    15af:	66 89 48 08          	mov    %cx,0x8(%eax)
    15b3:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    15b7:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    15ba:	8b 45 08             	mov    0x8(%ebp),%eax
    15bd:	89 c2                	mov    %eax,%edx
    15bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c2:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    15c4:	8b 45 0c             	mov    0xc(%ebp),%eax
    15c7:	89 c2                	mov    %eax,%edx
    15c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cc:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    15cf:	8b 55 10             	mov    0x10(%ebp),%edx
    15d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d5:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    15d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    15db:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15de:	c9                   	leave  
    15df:	c3                   	ret    

000015e0 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    15e0:	55                   	push   %ebp
    15e1:	89 e5                	mov    %esp,%ebp
    15e3:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    15e6:	8b 45 0c             	mov    0xc(%ebp),%eax
    15e9:	8b 50 08             	mov    0x8(%eax),%edx
    15ec:	89 55 f8             	mov    %edx,-0x8(%ebp)
    15ef:	8b 40 0c             	mov    0xc(%eax),%eax
    15f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    15f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    15f8:	8b 55 10             	mov    0x10(%ebp),%edx
    15fb:	89 50 08             	mov    %edx,0x8(%eax)
    15fe:	8b 55 14             	mov    0x14(%ebp),%edx
    1601:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    1604:	8b 45 08             	mov    0x8(%ebp),%eax
    1607:	8b 55 f8             	mov    -0x8(%ebp),%edx
    160a:	89 10                	mov    %edx,(%eax)
    160c:	8b 55 fc             	mov    -0x4(%ebp),%edx
    160f:	89 50 04             	mov    %edx,0x4(%eax)
}
    1612:	8b 45 08             	mov    0x8(%ebp),%eax
    1615:	c9                   	leave  
    1616:	c2 04 00             	ret    $0x4

00001619 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    1619:	55                   	push   %ebp
    161a:	89 e5                	mov    %esp,%ebp
    161c:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    161f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1622:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    1626:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    162a:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    162e:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    1631:	8b 45 0c             	mov    0xc(%ebp),%eax
    1634:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1638:	66 89 50 10          	mov    %dx,0x10(%eax)
    163c:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1640:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    1643:	8b 45 08             	mov    0x8(%ebp),%eax
    1646:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    164a:	66 89 10             	mov    %dx,(%eax)
    164d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1651:	88 50 02             	mov    %dl,0x2(%eax)
}
    1654:	8b 45 08             	mov    0x8(%ebp),%eax
    1657:	c9                   	leave  
    1658:	c2 04 00             	ret    $0x4

0000165b <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
    165b:	55                   	push   %ebp
    165c:	89 e5                	mov    %esp,%ebp
    165e:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
    1661:	8b 45 0c             	mov    0xc(%ebp),%eax
    1664:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1668:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    166c:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1670:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
    1673:	8b 45 0c             	mov    0xc(%ebp),%eax
    1676:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    167a:	66 89 50 13          	mov    %dx,0x13(%eax)
    167e:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1682:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
    1685:	8b 45 08             	mov    0x8(%ebp),%eax
    1688:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    168c:	66 89 10             	mov    %dx,(%eax)
    168f:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1693:	88 50 02             	mov    %dl,0x2(%eax)
}
    1696:	8b 45 08             	mov    0x8(%ebp),%eax
    1699:	c9                   	leave  
    169a:	c2 04 00             	ret    $0x4

0000169d <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    169d:	55                   	push   %ebp
    169e:	89 e5                	mov    %esp,%ebp
    16a0:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    16a3:	8b 45 08             	mov    0x8(%ebp),%eax
    16a6:	8b 40 0c             	mov    0xc(%eax),%eax
    16a9:	89 c2                	mov    %eax,%edx
    16ab:	c1 ea 1f             	shr    $0x1f,%edx
    16ae:	01 d0                	add    %edx,%eax
    16b0:	d1 f8                	sar    %eax
    16b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    16b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b8:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    16bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    16bf:	8b 45 10             	mov    0x10(%ebp),%eax
    16c2:	2b 45 f4             	sub    -0xc(%ebp),%eax
    16c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    16c8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    16cc:	0f 89 98 00 00 00    	jns    176a <APDrawPoint+0xcd>
        i = 0;
    16d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    16d9:	e9 8c 00 00 00       	jmp    176a <APDrawPoint+0xcd>
    {
        j = x - off;
    16de:	8b 45 0c             	mov    0xc(%ebp),%eax
    16e1:	2b 45 f4             	sub    -0xc(%ebp),%eax
    16e4:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    16e7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    16eb:	79 69                	jns    1756 <APDrawPoint+0xb9>
            j = 0;
    16ed:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    16f4:	eb 60                	jmp    1756 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    16f6:	ff 75 fc             	pushl  -0x4(%ebp)
    16f9:	ff 75 f8             	pushl  -0x8(%ebp)
    16fc:	ff 75 08             	pushl  0x8(%ebp)
    16ff:	e8 bb fb ff ff       	call   12bf <APGetIndex>
    1704:	83 c4 0c             	add    $0xc,%esp
    1707:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    170a:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    170e:	74 55                	je     1765 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    1710:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    1714:	74 67                	je     177d <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    1716:	ff 75 10             	pushl  0x10(%ebp)
    1719:	ff 75 0c             	pushl  0xc(%ebp)
    171c:	ff 75 fc             	pushl  -0x4(%ebp)
    171f:	ff 75 f8             	pushl  -0x8(%ebp)
    1722:	e8 5f fb ff ff       	call   1286 <distance_2>
    1727:	83 c4 10             	add    $0x10,%esp
    172a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    172d:	7f 23                	jg     1752 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    172f:	8b 45 08             	mov    0x8(%ebp),%eax
    1732:	8b 48 18             	mov    0x18(%eax),%ecx
    1735:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1738:	89 d0                	mov    %edx,%eax
    173a:	01 c0                	add    %eax,%eax
    173c:	01 d0                	add    %edx,%eax
    173e:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1741:	8b 45 08             	mov    0x8(%ebp),%eax
    1744:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1748:	66 89 0a             	mov    %cx,(%edx)
    174b:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    174f:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1752:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1756:	8b 55 0c             	mov    0xc(%ebp),%edx
    1759:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175c:	01 d0                	add    %edx,%eax
    175e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1761:	7d 93                	jge    16f6 <APDrawPoint+0x59>
    1763:	eb 01                	jmp    1766 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1765:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1766:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    176a:	8b 55 10             	mov    0x10(%ebp),%edx
    176d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1770:	01 d0                	add    %edx,%eax
    1772:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1775:	0f 8d 63 ff ff ff    	jge    16de <APDrawPoint+0x41>
    177b:	eb 01                	jmp    177e <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    177d:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    177e:	c9                   	leave  
    177f:	c3                   	ret    

00001780 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1780:	55                   	push   %ebp
    1781:	89 e5                	mov    %esp,%ebp
    1783:	53                   	push   %ebx
    1784:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1787:	8b 45 0c             	mov    0xc(%ebp),%eax
    178a:	3b 45 14             	cmp    0x14(%ebp),%eax
    178d:	0f 85 80 00 00 00    	jne    1813 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1793:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1797:	0f 88 9d 02 00 00    	js     1a3a <APDrawLine+0x2ba>
    179d:	8b 45 08             	mov    0x8(%ebp),%eax
    17a0:	8b 00                	mov    (%eax),%eax
    17a2:	3b 45 0c             	cmp    0xc(%ebp),%eax
    17a5:	0f 8e 8f 02 00 00    	jle    1a3a <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    17ab:	8b 45 10             	mov    0x10(%ebp),%eax
    17ae:	3b 45 18             	cmp    0x18(%ebp),%eax
    17b1:	7e 12                	jle    17c5 <APDrawLine+0x45>
        {
            int tmp = y2;
    17b3:	8b 45 18             	mov    0x18(%ebp),%eax
    17b6:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    17b9:	8b 45 10             	mov    0x10(%ebp),%eax
    17bc:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    17bf:	8b 45 dc             	mov    -0x24(%ebp),%eax
    17c2:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    17c5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    17c9:	79 07                	jns    17d2 <APDrawLine+0x52>
    17cb:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    17d2:	8b 45 08             	mov    0x8(%ebp),%eax
    17d5:	8b 40 04             	mov    0x4(%eax),%eax
    17d8:	3b 45 18             	cmp    0x18(%ebp),%eax
    17db:	7d 0c                	jge    17e9 <APDrawLine+0x69>
    17dd:	8b 45 08             	mov    0x8(%ebp),%eax
    17e0:	8b 40 04             	mov    0x4(%eax),%eax
    17e3:	83 e8 01             	sub    $0x1,%eax
    17e6:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    17e9:	8b 45 10             	mov    0x10(%ebp),%eax
    17ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
    17ef:	eb 15                	jmp    1806 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    17f1:	ff 75 f4             	pushl  -0xc(%ebp)
    17f4:	ff 75 0c             	pushl  0xc(%ebp)
    17f7:	ff 75 08             	pushl  0x8(%ebp)
    17fa:	e8 9e fe ff ff       	call   169d <APDrawPoint>
    17ff:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1802:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1806:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1809:	3b 45 18             	cmp    0x18(%ebp),%eax
    180c:	7e e3                	jle    17f1 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    180e:	e9 2b 02 00 00       	jmp    1a3e <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1813:	8b 45 10             	mov    0x10(%ebp),%eax
    1816:	3b 45 18             	cmp    0x18(%ebp),%eax
    1819:	75 7f                	jne    189a <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    181b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    181f:	0f 88 18 02 00 00    	js     1a3d <APDrawLine+0x2bd>
    1825:	8b 45 08             	mov    0x8(%ebp),%eax
    1828:	8b 40 04             	mov    0x4(%eax),%eax
    182b:	3b 45 10             	cmp    0x10(%ebp),%eax
    182e:	0f 8e 09 02 00 00    	jle    1a3d <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1834:	8b 45 0c             	mov    0xc(%ebp),%eax
    1837:	3b 45 14             	cmp    0x14(%ebp),%eax
    183a:	7e 12                	jle    184e <APDrawLine+0xce>
        {
            int tmp = x2;
    183c:	8b 45 14             	mov    0x14(%ebp),%eax
    183f:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1842:	8b 45 0c             	mov    0xc(%ebp),%eax
    1845:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1848:	8b 45 d8             	mov    -0x28(%ebp),%eax
    184b:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    184e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1852:	79 07                	jns    185b <APDrawLine+0xdb>
    1854:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    185b:	8b 45 08             	mov    0x8(%ebp),%eax
    185e:	8b 00                	mov    (%eax),%eax
    1860:	3b 45 14             	cmp    0x14(%ebp),%eax
    1863:	7d 0b                	jge    1870 <APDrawLine+0xf0>
    1865:	8b 45 08             	mov    0x8(%ebp),%eax
    1868:	8b 00                	mov    (%eax),%eax
    186a:	83 e8 01             	sub    $0x1,%eax
    186d:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1870:	8b 45 0c             	mov    0xc(%ebp),%eax
    1873:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1876:	eb 15                	jmp    188d <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1878:	ff 75 10             	pushl  0x10(%ebp)
    187b:	ff 75 f0             	pushl  -0x10(%ebp)
    187e:	ff 75 08             	pushl  0x8(%ebp)
    1881:	e8 17 fe ff ff       	call   169d <APDrawPoint>
    1886:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1889:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    188d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1890:	3b 45 14             	cmp    0x14(%ebp),%eax
    1893:	7e e3                	jle    1878 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1895:	e9 a4 01 00 00       	jmp    1a3e <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    189a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    18a1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    18a8:	8b 45 0c             	mov    0xc(%ebp),%eax
    18ab:	2b 45 14             	sub    0x14(%ebp),%eax
    18ae:	50                   	push   %eax
    18af:	e8 fb f9 ff ff       	call   12af <abs_int>
    18b4:	83 c4 04             	add    $0x4,%esp
    18b7:	89 c3                	mov    %eax,%ebx
    18b9:	8b 45 10             	mov    0x10(%ebp),%eax
    18bc:	2b 45 18             	sub    0x18(%ebp),%eax
    18bf:	50                   	push   %eax
    18c0:	e8 ea f9 ff ff       	call   12af <abs_int>
    18c5:	83 c4 04             	add    $0x4,%esp
    18c8:	39 c3                	cmp    %eax,%ebx
    18ca:	0f 8e b5 00 00 00    	jle    1985 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    18d0:	8b 45 10             	mov    0x10(%ebp),%eax
    18d3:	2b 45 18             	sub    0x18(%ebp),%eax
    18d6:	89 45 b0             	mov    %eax,-0x50(%ebp)
    18d9:	db 45 b0             	fildl  -0x50(%ebp)
    18dc:	8b 45 0c             	mov    0xc(%ebp),%eax
    18df:	2b 45 14             	sub    0x14(%ebp),%eax
    18e2:	89 45 b0             	mov    %eax,-0x50(%ebp)
    18e5:	db 45 b0             	fildl  -0x50(%ebp)
    18e8:	de f9                	fdivrp %st,%st(1)
    18ea:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    18ed:	8b 45 14             	mov    0x14(%ebp),%eax
    18f0:	3b 45 0c             	cmp    0xc(%ebp),%eax
    18f3:	7e 0e                	jle    1903 <APDrawLine+0x183>
        {
            s = x1;
    18f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    18f8:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    18fb:	8b 45 14             	mov    0x14(%ebp),%eax
    18fe:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1901:	eb 0c                	jmp    190f <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1903:	8b 45 14             	mov    0x14(%ebp),%eax
    1906:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1909:	8b 45 0c             	mov    0xc(%ebp),%eax
    190c:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    190f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1913:	79 07                	jns    191c <APDrawLine+0x19c>
    1915:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    191c:	8b 45 08             	mov    0x8(%ebp),%eax
    191f:	8b 00                	mov    (%eax),%eax
    1921:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1924:	7f 0b                	jg     1931 <APDrawLine+0x1b1>
    1926:	8b 45 08             	mov    0x8(%ebp),%eax
    1929:	8b 00                	mov    (%eax),%eax
    192b:	83 e8 01             	sub    $0x1,%eax
    192e:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1931:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1934:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1937:	eb 3f                	jmp    1978 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1939:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    193c:	2b 45 0c             	sub    0xc(%ebp),%eax
    193f:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1942:	db 45 b0             	fildl  -0x50(%ebp)
    1945:	dc 4d d0             	fmull  -0x30(%ebp)
    1948:	db 45 10             	fildl  0x10(%ebp)
    194b:	de c1                	faddp  %st,%st(1)
    194d:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1950:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1954:	b4 0c                	mov    $0xc,%ah
    1956:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    195a:	d9 6d b4             	fldcw  -0x4c(%ebp)
    195d:	db 5d cc             	fistpl -0x34(%ebp)
    1960:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1963:	ff 75 cc             	pushl  -0x34(%ebp)
    1966:	ff 75 e4             	pushl  -0x1c(%ebp)
    1969:	ff 75 08             	pushl  0x8(%ebp)
    196c:	e8 2c fd ff ff       	call   169d <APDrawPoint>
    1971:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1974:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1978:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    197b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    197e:	7e b9                	jle    1939 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1980:	e9 b9 00 00 00       	jmp    1a3e <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1985:	8b 45 0c             	mov    0xc(%ebp),%eax
    1988:	2b 45 14             	sub    0x14(%ebp),%eax
    198b:	89 45 b0             	mov    %eax,-0x50(%ebp)
    198e:	db 45 b0             	fildl  -0x50(%ebp)
    1991:	8b 45 10             	mov    0x10(%ebp),%eax
    1994:	2b 45 18             	sub    0x18(%ebp),%eax
    1997:	89 45 b0             	mov    %eax,-0x50(%ebp)
    199a:	db 45 b0             	fildl  -0x50(%ebp)
    199d:	de f9                	fdivrp %st,%st(1)
    199f:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    19a2:	8b 45 10             	mov    0x10(%ebp),%eax
    19a5:	3b 45 18             	cmp    0x18(%ebp),%eax
    19a8:	7e 0e                	jle    19b8 <APDrawLine+0x238>
    {
        s = y2;
    19aa:	8b 45 18             	mov    0x18(%ebp),%eax
    19ad:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    19b0:	8b 45 10             	mov    0x10(%ebp),%eax
    19b3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    19b6:	eb 0c                	jmp    19c4 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    19b8:	8b 45 10             	mov    0x10(%ebp),%eax
    19bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    19be:	8b 45 18             	mov    0x18(%ebp),%eax
    19c1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    19c4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19c8:	79 07                	jns    19d1 <APDrawLine+0x251>
    19ca:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    19d1:	8b 45 08             	mov    0x8(%ebp),%eax
    19d4:	8b 40 04             	mov    0x4(%eax),%eax
    19d7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    19da:	7f 0c                	jg     19e8 <APDrawLine+0x268>
    19dc:	8b 45 08             	mov    0x8(%ebp),%eax
    19df:	8b 40 04             	mov    0x4(%eax),%eax
    19e2:	83 e8 01             	sub    $0x1,%eax
    19e5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    19e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19eb:	89 45 e0             	mov    %eax,-0x20(%ebp)
    19ee:	eb 3f                	jmp    1a2f <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    19f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    19f3:	2b 45 10             	sub    0x10(%ebp),%eax
    19f6:	89 45 b0             	mov    %eax,-0x50(%ebp)
    19f9:	db 45 b0             	fildl  -0x50(%ebp)
    19fc:	dc 4d c0             	fmull  -0x40(%ebp)
    19ff:	db 45 0c             	fildl  0xc(%ebp)
    1a02:	de c1                	faddp  %st,%st(1)
    1a04:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1a07:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1a0b:	b4 0c                	mov    $0xc,%ah
    1a0d:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1a11:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1a14:	db 5d bc             	fistpl -0x44(%ebp)
    1a17:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1a1a:	ff 75 e0             	pushl  -0x20(%ebp)
    1a1d:	ff 75 bc             	pushl  -0x44(%ebp)
    1a20:	ff 75 08             	pushl  0x8(%ebp)
    1a23:	e8 75 fc ff ff       	call   169d <APDrawPoint>
    1a28:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1a2b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1a2f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a32:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1a35:	7e b9                	jle    19f0 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1a37:	90                   	nop
    1a38:	eb 04                	jmp    1a3e <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1a3a:	90                   	nop
    1a3b:	eb 01                	jmp    1a3e <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1a3d:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1a3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1a41:	c9                   	leave  
    1a42:	c3                   	ret    

00001a43 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1a43:	55                   	push   %ebp
    1a44:	89 e5                	mov    %esp,%ebp
    1a46:	53                   	push   %ebx
    1a47:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1a4a:	8b 55 10             	mov    0x10(%ebp),%edx
    1a4d:	8b 45 18             	mov    0x18(%ebp),%eax
    1a50:	01 d0                	add    %edx,%eax
    1a52:	83 e8 01             	sub    $0x1,%eax
    1a55:	83 ec 04             	sub    $0x4,%esp
    1a58:	50                   	push   %eax
    1a59:	ff 75 0c             	pushl  0xc(%ebp)
    1a5c:	ff 75 10             	pushl  0x10(%ebp)
    1a5f:	ff 75 0c             	pushl  0xc(%ebp)
    1a62:	ff 75 08             	pushl  0x8(%ebp)
    1a65:	e8 16 fd ff ff       	call   1780 <APDrawLine>
    1a6a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1a6d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a70:	8b 45 14             	mov    0x14(%ebp),%eax
    1a73:	01 d0                	add    %edx,%eax
    1a75:	83 e8 01             	sub    $0x1,%eax
    1a78:	83 ec 04             	sub    $0x4,%esp
    1a7b:	ff 75 10             	pushl  0x10(%ebp)
    1a7e:	50                   	push   %eax
    1a7f:	ff 75 10             	pushl  0x10(%ebp)
    1a82:	ff 75 0c             	pushl  0xc(%ebp)
    1a85:	ff 75 08             	pushl  0x8(%ebp)
    1a88:	e8 f3 fc ff ff       	call   1780 <APDrawLine>
    1a8d:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1a90:	8b 55 10             	mov    0x10(%ebp),%edx
    1a93:	8b 45 18             	mov    0x18(%ebp),%eax
    1a96:	01 d0                	add    %edx,%eax
    1a98:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1a9b:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a9e:	8b 45 14             	mov    0x14(%ebp),%eax
    1aa1:	01 d0                	add    %edx,%eax
    1aa3:	8d 50 ff             	lea    -0x1(%eax),%edx
    1aa6:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1aa9:	8b 45 14             	mov    0x14(%ebp),%eax
    1aac:	01 d8                	add    %ebx,%eax
    1aae:	83 e8 01             	sub    $0x1,%eax
    1ab1:	83 ec 04             	sub    $0x4,%esp
    1ab4:	51                   	push   %ecx
    1ab5:	52                   	push   %edx
    1ab6:	ff 75 10             	pushl  0x10(%ebp)
    1ab9:	50                   	push   %eax
    1aba:	ff 75 08             	pushl  0x8(%ebp)
    1abd:	e8 be fc ff ff       	call   1780 <APDrawLine>
    1ac2:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1ac5:	8b 55 10             	mov    0x10(%ebp),%edx
    1ac8:	8b 45 18             	mov    0x18(%ebp),%eax
    1acb:	01 d0                	add    %edx,%eax
    1acd:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1ad0:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ad3:	8b 45 14             	mov    0x14(%ebp),%eax
    1ad6:	01 d0                	add    %edx,%eax
    1ad8:	8d 50 ff             	lea    -0x1(%eax),%edx
    1adb:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1ade:	8b 45 18             	mov    0x18(%ebp),%eax
    1ae1:	01 d8                	add    %ebx,%eax
    1ae3:	83 e8 01             	sub    $0x1,%eax
    1ae6:	83 ec 04             	sub    $0x4,%esp
    1ae9:	51                   	push   %ecx
    1aea:	52                   	push   %edx
    1aeb:	50                   	push   %eax
    1aec:	ff 75 0c             	pushl  0xc(%ebp)
    1aef:	ff 75 08             	pushl  0x8(%ebp)
    1af2:	e8 89 fc ff ff       	call   1780 <APDrawLine>
    1af7:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1afa:	8b 55 0c             	mov    0xc(%ebp),%edx
    1afd:	8b 45 14             	mov    0x14(%ebp),%eax
    1b00:	01 d0                	add    %edx,%eax
    1b02:	8d 50 ff             	lea    -0x1(%eax),%edx
    1b05:	8b 45 08             	mov    0x8(%ebp),%eax
    1b08:	8b 40 0c             	mov    0xc(%eax),%eax
    1b0b:	89 c1                	mov    %eax,%ecx
    1b0d:	c1 e9 1f             	shr    $0x1f,%ecx
    1b10:	01 c8                	add    %ecx,%eax
    1b12:	d1 f8                	sar    %eax
    1b14:	29 c2                	sub    %eax,%edx
    1b16:	89 d0                	mov    %edx,%eax
    1b18:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1b1b:	8b 55 10             	mov    0x10(%ebp),%edx
    1b1e:	8b 45 18             	mov    0x18(%ebp),%eax
    1b21:	01 d0                	add    %edx,%eax
    1b23:	8d 50 ff             	lea    -0x1(%eax),%edx
    1b26:	8b 45 08             	mov    0x8(%ebp),%eax
    1b29:	8b 40 0c             	mov    0xc(%eax),%eax
    1b2c:	89 c1                	mov    %eax,%ecx
    1b2e:	c1 e9 1f             	shr    $0x1f,%ecx
    1b31:	01 c8                	add    %ecx,%eax
    1b33:	d1 f8                	sar    %eax
    1b35:	29 c2                	sub    %eax,%edx
    1b37:	89 d0                	mov    %edx,%eax
    1b39:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1b3c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3f:	8b 40 0c             	mov    0xc(%eax),%eax
    1b42:	89 c2                	mov    %eax,%edx
    1b44:	c1 ea 1f             	shr    $0x1f,%edx
    1b47:	01 d0                	add    %edx,%eax
    1b49:	d1 f8                	sar    %eax
    1b4b:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1b4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b51:	8b 40 0c             	mov    0xc(%eax),%eax
    1b54:	89 c2                	mov    %eax,%edx
    1b56:	c1 ea 1f             	shr    $0x1f,%edx
    1b59:	01 d0                	add    %edx,%eax
    1b5b:	d1 f8                	sar    %eax
    1b5d:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1b60:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1b64:	0f 88 d8 00 00 00    	js     1c42 <APDrawRect+0x1ff>
    1b6a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1b6e:	0f 88 ce 00 00 00    	js     1c42 <APDrawRect+0x1ff>
    1b74:	8b 45 08             	mov    0x8(%ebp),%eax
    1b77:	8b 00                	mov    (%eax),%eax
    1b79:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1b7c:	0f 8e c0 00 00 00    	jle    1c42 <APDrawRect+0x1ff>
    1b82:	8b 45 08             	mov    0x8(%ebp),%eax
    1b85:	8b 40 04             	mov    0x4(%eax),%eax
    1b88:	3b 45 10             	cmp    0x10(%ebp),%eax
    1b8b:	0f 8e b1 00 00 00    	jle    1c42 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1b91:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1b95:	79 07                	jns    1b9e <APDrawRect+0x15b>
    1b97:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1b9e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1ba2:	79 07                	jns    1bab <APDrawRect+0x168>
    1ba4:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1bab:	8b 45 08             	mov    0x8(%ebp),%eax
    1bae:	8b 00                	mov    (%eax),%eax
    1bb0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1bb3:	7f 0b                	jg     1bc0 <APDrawRect+0x17d>
    1bb5:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb8:	8b 00                	mov    (%eax),%eax
    1bba:	83 e8 01             	sub    $0x1,%eax
    1bbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1bc0:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc3:	8b 40 04             	mov    0x4(%eax),%eax
    1bc6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1bc9:	7f 0c                	jg     1bd7 <APDrawRect+0x194>
    1bcb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bce:	8b 40 04             	mov    0x4(%eax),%eax
    1bd1:	83 e8 01             	sub    $0x1,%eax
    1bd4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1bd7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1bde:	8b 45 0c             	mov    0xc(%ebp),%eax
    1be1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1be4:	eb 52                	jmp    1c38 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1be6:	8b 45 10             	mov    0x10(%ebp),%eax
    1be9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1bec:	eb 3e                	jmp    1c2c <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1bee:	83 ec 04             	sub    $0x4,%esp
    1bf1:	ff 75 e8             	pushl  -0x18(%ebp)
    1bf4:	ff 75 ec             	pushl  -0x14(%ebp)
    1bf7:	ff 75 08             	pushl  0x8(%ebp)
    1bfa:	e8 c0 f6 ff ff       	call   12bf <APGetIndex>
    1bff:	83 c4 10             	add    $0x10,%esp
    1c02:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1c05:	8b 45 08             	mov    0x8(%ebp),%eax
    1c08:	8b 48 18             	mov    0x18(%eax),%ecx
    1c0b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1c0e:	89 d0                	mov    %edx,%eax
    1c10:	01 c0                	add    %eax,%eax
    1c12:	01 d0                	add    %edx,%eax
    1c14:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1c17:	8b 45 08             	mov    0x8(%ebp),%eax
    1c1a:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1c1e:	66 89 0a             	mov    %cx,(%edx)
    1c21:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1c25:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1c28:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1c2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1c2f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1c32:	7e ba                	jle    1bee <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1c34:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1c38:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c3b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1c3e:	7e a6                	jle    1be6 <APDrawRect+0x1a3>
    1c40:	eb 01                	jmp    1c43 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1c42:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1c43:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1c46:	c9                   	leave  
    1c47:	c3                   	ret    

00001c48 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1c48:	55                   	push   %ebp
    1c49:	89 e5                	mov    %esp,%ebp
    1c4b:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    1c4e:	83 ec 0c             	sub    $0xc,%esp
    1c51:	ff 75 0c             	pushl  0xc(%ebp)
    1c54:	e8 b1 ee ff ff       	call   b0a <strlen>
    1c59:	83 c4 10             	add    $0x10,%esp
    1c5c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1c5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c62:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1c66:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1c6a:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1c6e:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1c71:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1c78:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c7f:	e9 bc 00 00 00       	jmp    1d40 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1c84:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c87:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c8a:	01 d0                	add    %edx,%eax
    1c8c:	0f b6 00             	movzbl (%eax),%eax
    1c8f:	0f be c0             	movsbl %al,%eax
    1c92:	83 e8 20             	sub    $0x20,%eax
    1c95:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1c98:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1c9c:	0f 87 9a 00 00 00    	ja     1d3c <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1ca2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca5:	8b 00                	mov    (%eax),%eax
    1ca7:	0f af 45 14          	imul   0x14(%ebp),%eax
    1cab:	89 c2                	mov    %eax,%edx
    1cad:	8b 45 10             	mov    0x10(%ebp),%eax
    1cb0:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1cb3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1cb6:	89 d0                	mov    %edx,%eax
    1cb8:	c1 e0 03             	shl    $0x3,%eax
    1cbb:	01 d0                	add    %edx,%eax
    1cbd:	01 c8                	add    %ecx,%eax
    1cbf:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1cc2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1cc9:	eb 6b                	jmp    1d36 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1ccb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1cd2:	eb 50                	jmp    1d24 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    1cd4:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1cd7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1cda:	89 d0                	mov    %edx,%eax
    1cdc:	c1 e0 03             	shl    $0x3,%eax
    1cdf:	01 d0                	add    %edx,%eax
    1ce1:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    1ce7:	01 c2                	add    %eax,%edx
    1ce9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1cec:	01 d0                	add    %edx,%eax
    1cee:	05 20 39 00 00       	add    $0x3920,%eax
    1cf3:	0f b6 00             	movzbl (%eax),%eax
    1cf6:	84 c0                	test   %al,%al
    1cf8:	74 26                	je     1d20 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1cfa:	8b 45 08             	mov    0x8(%ebp),%eax
    1cfd:	8b 50 18             	mov    0x18(%eax),%edx
    1d00:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1d03:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1d06:	01 c8                	add    %ecx,%eax
    1d08:	89 c1                	mov    %eax,%ecx
    1d0a:	89 c8                	mov    %ecx,%eax
    1d0c:	01 c0                	add    %eax,%eax
    1d0e:	01 c8                	add    %ecx,%eax
    1d10:	01 d0                	add    %edx,%eax
    1d12:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1d16:	66 89 10             	mov    %dx,(%eax)
    1d19:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1d1d:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1d20:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1d24:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1d28:	7e aa                	jle    1cd4 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1d2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d2d:	8b 00                	mov    (%eax),%eax
    1d2f:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1d32:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1d36:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1d3a:	7e 8f                	jle    1ccb <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1d3c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1d40:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d43:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1d46:	0f 82 38 ff ff ff    	jb     1c84 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1d4c:	90                   	nop
    1d4d:	c9                   	leave  
    1d4e:	c3                   	ret    

00001d4f <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1d4f:	55                   	push   %ebp
    1d50:	89 e5                	mov    %esp,%ebp
    1d52:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1d55:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1d59:	0f 88 8e 01 00 00    	js     1eed <APDcCopy+0x19e>
    1d5f:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1d63:	0f 88 84 01 00 00    	js     1eed <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1d69:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d6c:	8b 45 20             	mov    0x20(%ebp),%eax
    1d6f:	01 d0                	add    %edx,%eax
    1d71:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1d74:	8b 55 10             	mov    0x10(%ebp),%edx
    1d77:	8b 45 24             	mov    0x24(%ebp),%eax
    1d7a:	01 d0                	add    %edx,%eax
    1d7c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1d7f:	8b 55 18             	mov    0x18(%ebp),%edx
    1d82:	8b 45 20             	mov    0x20(%ebp),%eax
    1d85:	01 d0                	add    %edx,%eax
    1d87:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1d8a:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1d8d:	8b 45 24             	mov    0x24(%ebp),%eax
    1d90:	01 d0                	add    %edx,%eax
    1d92:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1d95:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1d99:	0f 88 51 01 00 00    	js     1ef0 <APDcCopy+0x1a1>
    1d9f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1da3:	0f 88 47 01 00 00    	js     1ef0 <APDcCopy+0x1a1>
    1da9:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1dad:	0f 88 3d 01 00 00    	js     1ef0 <APDcCopy+0x1a1>
    1db3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1db7:	0f 88 33 01 00 00    	js     1ef0 <APDcCopy+0x1a1>
    1dbd:	8b 45 14             	mov    0x14(%ebp),%eax
    1dc0:	8b 00                	mov    (%eax),%eax
    1dc2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1dc5:	0f 8c 25 01 00 00    	jl     1ef0 <APDcCopy+0x1a1>
    1dcb:	8b 45 14             	mov    0x14(%ebp),%eax
    1dce:	8b 40 04             	mov    0x4(%eax),%eax
    1dd1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1dd4:	0f 8c 16 01 00 00    	jl     1ef0 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1dda:	8b 45 08             	mov    0x8(%ebp),%eax
    1ddd:	8b 00                	mov    (%eax),%eax
    1ddf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1de2:	7f 0b                	jg     1def <APDcCopy+0xa0>
    1de4:	8b 45 08             	mov    0x8(%ebp),%eax
    1de7:	8b 00                	mov    (%eax),%eax
    1de9:	83 e8 01             	sub    $0x1,%eax
    1dec:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1def:	8b 45 08             	mov    0x8(%ebp),%eax
    1df2:	8b 40 04             	mov    0x4(%eax),%eax
    1df5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1df8:	7f 0c                	jg     1e06 <APDcCopy+0xb7>
    1dfa:	8b 45 08             	mov    0x8(%ebp),%eax
    1dfd:	8b 40 04             	mov    0x4(%eax),%eax
    1e00:	83 e8 01             	sub    $0x1,%eax
    1e03:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1e06:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1e0d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1e14:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1e1b:	e9 bc 00 00 00       	jmp    1edc <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1e20:	8b 45 08             	mov    0x8(%ebp),%eax
    1e23:	8b 00                	mov    (%eax),%eax
    1e25:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1e28:	8b 55 10             	mov    0x10(%ebp),%edx
    1e2b:	01 ca                	add    %ecx,%edx
    1e2d:	0f af d0             	imul   %eax,%edx
    1e30:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e33:	01 d0                	add    %edx,%eax
    1e35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1e38:	8b 45 14             	mov    0x14(%ebp),%eax
    1e3b:	8b 00                	mov    (%eax),%eax
    1e3d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1e40:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1e43:	01 ca                	add    %ecx,%edx
    1e45:	0f af d0             	imul   %eax,%edx
    1e48:	8b 45 18             	mov    0x18(%ebp),%eax
    1e4b:	01 d0                	add    %edx,%eax
    1e4d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1e50:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1e57:	eb 74                	jmp    1ecd <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1e59:	8b 45 14             	mov    0x14(%ebp),%eax
    1e5c:	8b 50 18             	mov    0x18(%eax),%edx
    1e5f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1e62:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e65:	01 c8                	add    %ecx,%eax
    1e67:	89 c1                	mov    %eax,%ecx
    1e69:	89 c8                	mov    %ecx,%eax
    1e6b:	01 c0                	add    %eax,%eax
    1e6d:	01 c8                	add    %ecx,%eax
    1e6f:	01 d0                	add    %edx,%eax
    1e71:	0f b7 10             	movzwl (%eax),%edx
    1e74:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1e78:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1e7c:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1e7f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1e83:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1e87:	38 c2                	cmp    %al,%dl
    1e89:	75 18                	jne    1ea3 <APDcCopy+0x154>
    1e8b:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1e8f:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1e93:	38 c2                	cmp    %al,%dl
    1e95:	75 0c                	jne    1ea3 <APDcCopy+0x154>
    1e97:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1e9b:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1e9f:	38 c2                	cmp    %al,%dl
    1ea1:	74 26                	je     1ec9 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1ea3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea6:	8b 50 18             	mov    0x18(%eax),%edx
    1ea9:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1eac:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1eaf:	01 c8                	add    %ecx,%eax
    1eb1:	89 c1                	mov    %eax,%ecx
    1eb3:	89 c8                	mov    %ecx,%eax
    1eb5:	01 c0                	add    %eax,%eax
    1eb7:	01 c8                	add    %ecx,%eax
    1eb9:	01 d0                	add    %edx,%eax
    1ebb:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1ebf:	66 89 10             	mov    %dx,(%eax)
    1ec2:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1ec6:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1ec9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1ecd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ed0:	2b 45 0c             	sub    0xc(%ebp),%eax
    1ed3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1ed6:	7d 81                	jge    1e59 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1ed8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1edc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1edf:	2b 45 10             	sub    0x10(%ebp),%eax
    1ee2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1ee5:	0f 8d 35 ff ff ff    	jge    1e20 <APDcCopy+0xd1>
    1eeb:	eb 04                	jmp    1ef1 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1eed:	90                   	nop
    1eee:	eb 01                	jmp    1ef1 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1ef0:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1ef1:	c9                   	leave  
    1ef2:	c3                   	ret    

00001ef3 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1ef3:	55                   	push   %ebp
    1ef4:	89 e5                	mov    %esp,%ebp
    1ef6:	83 ec 1c             	sub    $0x1c,%esp
    1ef9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1efc:	8b 55 10             	mov    0x10(%ebp),%edx
    1eff:	8b 45 14             	mov    0x14(%ebp),%eax
    1f02:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1f05:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1f08:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1f0b:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1f0f:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1f12:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1f16:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1f19:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1f1d:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1f20:	8b 45 08             	mov    0x8(%ebp),%eax
    1f23:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1f27:	66 89 10             	mov    %dx,(%eax)
    1f2a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1f2e:	88 50 02             	mov    %dl,0x2(%eax)
}
    1f31:	8b 45 08             	mov    0x8(%ebp),%eax
    1f34:	c9                   	leave  
    1f35:	c2 04 00             	ret    $0x4

00001f38 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1f38:	55                   	push   %ebp
    1f39:	89 e5                	mov    %esp,%ebp
    1f3b:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1f3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f41:	8b 00                	mov    (%eax),%eax
    1f43:	83 ec 08             	sub    $0x8,%esp
    1f46:	8d 55 0c             	lea    0xc(%ebp),%edx
    1f49:	52                   	push   %edx
    1f4a:	50                   	push   %eax
    1f4b:	e8 24 ee ff ff       	call   d74 <sendMessage>
    1f50:	83 c4 10             	add    $0x10,%esp
}
    1f53:	90                   	nop
    1f54:	c9                   	leave  
    1f55:	c3                   	ret    

00001f56 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1f56:	55                   	push   %ebp
    1f57:	89 e5                	mov    %esp,%ebp
    1f59:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1f5c:	83 ec 0c             	sub    $0xc,%esp
    1f5f:	68 9c 00 00 00       	push   $0x9c
    1f64:	e8 f5 f1 ff ff       	call   115e <malloc>
    1f69:	83 c4 10             	add    $0x10,%esp
    1f6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1f6f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f73:	75 15                	jne    1f8a <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1f75:	83 ec 04             	sub    $0x4,%esp
    1f78:	ff 75 08             	pushl  0x8(%ebp)
    1f7b:	68 80 30 00 00       	push   $0x3080
    1f80:	6a 01                	push   $0x1
    1f82:	e8 04 ef ff ff       	call   e8b <printf>
    1f87:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1f8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f8d:	05 88 00 00 00       	add    $0x88,%eax
    1f92:	83 ec 08             	sub    $0x8,%esp
    1f95:	ff 75 08             	pushl  0x8(%ebp)
    1f98:	50                   	push   %eax
    1f99:	e8 fd ea ff ff       	call   a9b <strcpy>
    1f9e:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1fa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fa4:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1fab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fae:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1fb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fb8:	8b 40 3c             	mov    0x3c(%eax),%eax
    1fbb:	89 c2                	mov    %eax,%edx
    1fbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fc0:	8b 40 40             	mov    0x40(%eax),%eax
    1fc3:	0f af d0             	imul   %eax,%edx
    1fc6:	89 d0                	mov    %edx,%eax
    1fc8:	01 c0                	add    %eax,%eax
    1fca:	01 d0                	add    %edx,%eax
    1fcc:	83 ec 0c             	sub    $0xc,%esp
    1fcf:	50                   	push   %eax
    1fd0:	e8 89 f1 ff ff       	call   115e <malloc>
    1fd5:	83 c4 10             	add    $0x10,%esp
    1fd8:	89 c2                	mov    %eax,%edx
    1fda:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fdd:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1fe0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fe3:	8b 40 54             	mov    0x54(%eax),%eax
    1fe6:	85 c0                	test   %eax,%eax
    1fe8:	75 15                	jne    1fff <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1fea:	83 ec 04             	sub    $0x4,%esp
    1fed:	ff 75 08             	pushl  0x8(%ebp)
    1ff0:	68 a0 30 00 00       	push   $0x30a0
    1ff5:	6a 01                	push   $0x1
    1ff7:	e8 8f ee ff ff       	call   e8b <printf>
    1ffc:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1fff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2002:	8b 40 3c             	mov    0x3c(%eax),%eax
    2005:	89 c2                	mov    %eax,%edx
    2007:	8b 45 f4             	mov    -0xc(%ebp),%eax
    200a:	8b 40 40             	mov    0x40(%eax),%eax
    200d:	0f af d0             	imul   %eax,%edx
    2010:	89 d0                	mov    %edx,%eax
    2012:	01 c0                	add    %eax,%eax
    2014:	01 c2                	add    %eax,%edx
    2016:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2019:	8b 40 54             	mov    0x54(%eax),%eax
    201c:	83 ec 04             	sub    $0x4,%esp
    201f:	52                   	push   %edx
    2020:	68 ff ff ff 00       	push   $0xffffff
    2025:	50                   	push   %eax
    2026:	e8 06 eb ff ff       	call   b31 <memset>
    202b:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    202e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2031:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    2038:	e8 0f ed ff ff       	call   d4c <getpid>
    203d:	89 c2                	mov    %eax,%edx
    203f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2042:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    2045:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2048:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    204f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2052:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    2059:	8b 45 f4             	mov    -0xc(%ebp),%eax
    205c:	8b 40 58             	mov    0x58(%eax),%eax
    205f:	89 c2                	mov    %eax,%edx
    2061:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2064:	8b 40 5c             	mov    0x5c(%eax),%eax
    2067:	0f af d0             	imul   %eax,%edx
    206a:	89 d0                	mov    %edx,%eax
    206c:	01 c0                	add    %eax,%eax
    206e:	01 d0                	add    %edx,%eax
    2070:	83 ec 0c             	sub    $0xc,%esp
    2073:	50                   	push   %eax
    2074:	e8 e5 f0 ff ff       	call   115e <malloc>
    2079:	83 c4 10             	add    $0x10,%esp
    207c:	89 c2                	mov    %eax,%edx
    207e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2081:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    2084:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2087:	8b 40 70             	mov    0x70(%eax),%eax
    208a:	85 c0                	test   %eax,%eax
    208c:	75 15                	jne    20a3 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    208e:	83 ec 04             	sub    $0x4,%esp
    2091:	ff 75 08             	pushl  0x8(%ebp)
    2094:	68 c4 30 00 00       	push   $0x30c4
    2099:	6a 01                	push   $0x1
    209b:	e8 eb ed ff ff       	call   e8b <printf>
    20a0:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    20a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20a6:	8b 40 3c             	mov    0x3c(%eax),%eax
    20a9:	89 c2                	mov    %eax,%edx
    20ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20ae:	8b 40 40             	mov    0x40(%eax),%eax
    20b1:	0f af d0             	imul   %eax,%edx
    20b4:	89 d0                	mov    %edx,%eax
    20b6:	01 c0                	add    %eax,%eax
    20b8:	01 c2                	add    %eax,%edx
    20ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20bd:	8b 40 54             	mov    0x54(%eax),%eax
    20c0:	83 ec 04             	sub    $0x4,%esp
    20c3:	52                   	push   %edx
    20c4:	68 ff 00 00 00       	push   $0xff
    20c9:	50                   	push   %eax
    20ca:	e8 62 ea ff ff       	call   b31 <memset>
    20cf:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    20d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20d5:	8b 55 0c             	mov    0xc(%ebp),%edx
    20d8:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    20db:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    20df:	74 49                	je     212a <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    20e1:	8b 45 10             	mov    0x10(%ebp),%eax
    20e4:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    20ea:	83 ec 0c             	sub    $0xc,%esp
    20ed:	50                   	push   %eax
    20ee:	e8 6b f0 ff ff       	call   115e <malloc>
    20f3:	83 c4 10             	add    $0x10,%esp
    20f6:	89 c2                	mov    %eax,%edx
    20f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20fb:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    20fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2101:	8b 55 10             	mov    0x10(%ebp),%edx
    2104:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    2107:	8b 45 f4             	mov    -0xc(%ebp),%eax
    210a:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    2111:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2114:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    211b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    211e:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    2125:	e9 8d 00 00 00       	jmp    21b7 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    212a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    212d:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    2134:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2137:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    213e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2141:	8b 40 20             	mov    0x20(%eax),%eax
    2144:	89 c2                	mov    %eax,%edx
    2146:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2149:	8b 40 24             	mov    0x24(%eax),%eax
    214c:	0f af d0             	imul   %eax,%edx
    214f:	89 d0                	mov    %edx,%eax
    2151:	01 c0                	add    %eax,%eax
    2153:	01 d0                	add    %edx,%eax
    2155:	83 ec 0c             	sub    $0xc,%esp
    2158:	50                   	push   %eax
    2159:	e8 00 f0 ff ff       	call   115e <malloc>
    215e:	83 c4 10             	add    $0x10,%esp
    2161:	89 c2                	mov    %eax,%edx
    2163:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2166:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    2169:	8b 45 f4             	mov    -0xc(%ebp),%eax
    216c:	8b 40 38             	mov    0x38(%eax),%eax
    216f:	85 c0                	test   %eax,%eax
    2171:	75 15                	jne    2188 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    2173:	83 ec 04             	sub    $0x4,%esp
    2176:	ff 75 08             	pushl  0x8(%ebp)
    2179:	68 ec 30 00 00       	push   $0x30ec
    217e:	6a 01                	push   $0x1
    2180:	e8 06 ed ff ff       	call   e8b <printf>
    2185:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    2188:	8b 45 f4             	mov    -0xc(%ebp),%eax
    218b:	8b 40 20             	mov    0x20(%eax),%eax
    218e:	89 c2                	mov    %eax,%edx
    2190:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2193:	8b 40 24             	mov    0x24(%eax),%eax
    2196:	0f af d0             	imul   %eax,%edx
    2199:	89 d0                	mov    %edx,%eax
    219b:	01 c0                	add    %eax,%eax
    219d:	01 c2                	add    %eax,%edx
    219f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21a2:	8b 40 38             	mov    0x38(%eax),%eax
    21a5:	83 ec 04             	sub    $0x4,%esp
    21a8:	52                   	push   %edx
    21a9:	68 ff ff ff 00       	push   $0xffffff
    21ae:	50                   	push   %eax
    21af:	e8 7d e9 ff ff       	call   b31 <memset>
    21b4:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    21b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    21ba:	c9                   	leave  
    21bb:	c3                   	ret    

000021bc <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    21bc:	55                   	push   %ebp
    21bd:	89 e5                	mov    %esp,%ebp
    21bf:	57                   	push   %edi
    21c0:	56                   	push   %esi
    21c1:	53                   	push   %ebx
    21c2:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    21c5:	8b 45 0c             	mov    0xc(%ebp),%eax
    21c8:	83 f8 03             	cmp    $0x3,%eax
    21cb:	74 0e                	je     21db <APWndProc+0x1f>
    21cd:	83 f8 0a             	cmp    $0xa,%eax
    21d0:	0f 84 82 00 00 00    	je     2258 <APWndProc+0x9c>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            break;
        default: break;
    21d6:	e9 cb 00 00 00       	jmp    22a6 <APWndProc+0xea>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    21db:	8b 45 08             	mov    0x8(%ebp),%eax
    21de:	8b 58 1c             	mov    0x1c(%eax),%ebx
    21e1:	8b 45 08             	mov    0x8(%ebp),%eax
    21e4:	8b 48 18             	mov    0x18(%eax),%ecx
    21e7:	8b 45 08             	mov    0x8(%ebp),%eax
    21ea:	8b 50 5c             	mov    0x5c(%eax),%edx
    21ed:	8b 45 08             	mov    0x8(%ebp),%eax
    21f0:	8b 40 58             	mov    0x58(%eax),%eax
    21f3:	8b 75 08             	mov    0x8(%ebp),%esi
    21f6:	83 c6 58             	add    $0x58,%esi
    21f9:	83 ec 04             	sub    $0x4,%esp
    21fc:	53                   	push   %ebx
    21fd:	51                   	push   %ecx
    21fe:	6a 00                	push   $0x0
    2200:	52                   	push   %edx
    2201:	50                   	push   %eax
    2202:	6a 00                	push   $0x0
    2204:	6a 00                	push   $0x0
    2206:	56                   	push   %esi
    2207:	6a 00                	push   $0x0
    2209:	6a 00                	push   $0x0
    220b:	ff 75 08             	pushl  0x8(%ebp)
    220e:	e8 59 eb ff ff       	call   d6c <paintWindow>
    2213:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    2216:	8b 45 08             	mov    0x8(%ebp),%eax
    2219:	8b 70 1c             	mov    0x1c(%eax),%esi
    221c:	8b 45 08             	mov    0x8(%ebp),%eax
    221f:	8b 58 18             	mov    0x18(%eax),%ebx
    2222:	8b 45 08             	mov    0x8(%ebp),%eax
    2225:	8b 48 08             	mov    0x8(%eax),%ecx
    2228:	8b 45 08             	mov    0x8(%ebp),%eax
    222b:	8b 50 40             	mov    0x40(%eax),%edx
    222e:	8b 45 08             	mov    0x8(%ebp),%eax
    2231:	8b 40 3c             	mov    0x3c(%eax),%eax
    2234:	8b 7d 08             	mov    0x8(%ebp),%edi
    2237:	83 c7 3c             	add    $0x3c,%edi
    223a:	83 ec 04             	sub    $0x4,%esp
    223d:	56                   	push   %esi
    223e:	53                   	push   %ebx
    223f:	51                   	push   %ecx
    2240:	52                   	push   %edx
    2241:	50                   	push   %eax
    2242:	6a 00                	push   $0x0
    2244:	6a 00                	push   $0x0
    2246:	57                   	push   %edi
    2247:	6a 32                	push   $0x32
    2249:	6a 00                	push   $0x0
    224b:	ff 75 08             	pushl  0x8(%ebp)
    224e:	e8 19 eb ff ff       	call   d6c <paintWindow>
    2253:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    2256:	eb 4e                	jmp    22a6 <APWndProc+0xea>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
    2258:	8b 45 18             	mov    0x18(%ebp),%eax
    225b:	83 ec 08             	sub    $0x8,%esp
    225e:	50                   	push   %eax
    225f:	ff 75 08             	pushl  0x8(%ebp)
    2262:	e8 c5 08 00 00       	call   2b2c <updateword>
    2267:	83 c4 10             	add    $0x10,%esp
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    226a:	8b 45 08             	mov    0x8(%ebp),%eax
    226d:	8b 58 1c             	mov    0x1c(%eax),%ebx
    2270:	8b 45 08             	mov    0x8(%ebp),%eax
    2273:	8b 48 18             	mov    0x18(%eax),%ecx
    2276:	8b 45 08             	mov    0x8(%ebp),%eax
    2279:	8b 50 5c             	mov    0x5c(%eax),%edx
    227c:	8b 45 08             	mov    0x8(%ebp),%eax
    227f:	8b 40 58             	mov    0x58(%eax),%eax
    2282:	8b 75 08             	mov    0x8(%ebp),%esi
    2285:	83 c6 58             	add    $0x58,%esi
    2288:	83 ec 04             	sub    $0x4,%esp
    228b:	53                   	push   %ebx
    228c:	51                   	push   %ecx
    228d:	6a 00                	push   $0x0
    228f:	52                   	push   %edx
    2290:	50                   	push   %eax
    2291:	6a 00                	push   $0x0
    2293:	6a 00                	push   $0x0
    2295:	56                   	push   %esi
    2296:	6a 00                	push   $0x0
    2298:	6a 00                	push   $0x0
    229a:	ff 75 08             	pushl  0x8(%ebp)
    229d:	e8 ca ea ff ff       	call   d6c <paintWindow>
    22a2:	83 c4 30             	add    $0x30,%esp
            break;
    22a5:	90                   	nop
        default: break;
            
            
    }
    return False;
    22a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
    22ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
    22ae:	5b                   	pop    %ebx
    22af:	5e                   	pop    %esi
    22b0:	5f                   	pop    %edi
    22b1:	5d                   	pop    %ebp
    22b2:	c3                   	ret    

000022b3 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    22b3:	55                   	push   %ebp
    22b4:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    22b6:	8b 45 0c             	mov    0xc(%ebp),%eax
    22b9:	8b 50 08             	mov    0x8(%eax),%edx
    22bc:	8b 45 08             	mov    0x8(%ebp),%eax
    22bf:	8b 00                	mov    (%eax),%eax
    22c1:	39 c2                	cmp    %eax,%edx
    22c3:	74 07                	je     22cc <APPreJudge+0x19>
        return False;
    22c5:	b8 00 00 00 00       	mov    $0x0,%eax
    22ca:	eb 05                	jmp    22d1 <APPreJudge+0x1e>
    return True;
    22cc:	b8 01 00 00 00       	mov    $0x1,%eax
}
    22d1:	5d                   	pop    %ebp
    22d2:	c3                   	ret    

000022d3 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    22d3:	55                   	push   %ebp
    22d4:	89 e5                	mov    %esp,%ebp
    22d6:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    22d9:	8b 45 08             	mov    0x8(%ebp),%eax
    22dc:	8b 55 0c             	mov    0xc(%ebp),%edx
    22df:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
    //--------add window to list
    registWindow(hwnd);
    22e5:	83 ec 0c             	sub    $0xc,%esp
    22e8:	ff 75 08             	pushl  0x8(%ebp)
    22eb:	e8 94 ea ff ff       	call   d84 <registWindow>
    22f0:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    22f3:	c7 45 e8 02 00 00 00 	movl   $0x2,-0x18(%ebp)
    msg.wndID = hwnd->id;
    22fa:	8b 45 08             	mov    0x8(%ebp),%eax
    22fd:	8b 00                	mov    (%eax),%eax
    22ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
    APSendMessage(hwnd,msg);
    2302:	83 ec 0c             	sub    $0xc,%esp
    2305:	ff 75 f4             	pushl  -0xc(%ebp)
    2308:	ff 75 f0             	pushl  -0x10(%ebp)
    230b:	ff 75 ec             	pushl  -0x14(%ebp)
    230e:	ff 75 e8             	pushl  -0x18(%ebp)
    2311:	ff 75 08             	pushl  0x8(%ebp)
    2314:	e8 1f fc ff ff       	call   1f38 <APSendMessage>
    2319:	83 c4 20             	add    $0x20,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    231c:	83 ec 0c             	sub    $0xc,%esp
    231f:	ff 75 08             	pushl  0x8(%ebp)
    2322:	e8 55 ea ff ff       	call   d7c <getMessage>
    2327:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    232a:	8b 45 08             	mov    0x8(%ebp),%eax
    232d:	83 c0 74             	add    $0x74,%eax
    2330:	83 ec 08             	sub    $0x8,%esp
    2333:	50                   	push   %eax
    2334:	ff 75 08             	pushl  0x8(%ebp)
    2337:	e8 77 ff ff ff       	call   22b3 <APPreJudge>
    233c:	83 c4 10             	add    $0x10,%esp
    233f:	84 c0                	test   %al,%al
    2341:	74 24                	je     2367 <APWndExec+0x94>
            if (wndProc(hwnd, hwnd->msg))
    2343:	83 ec 0c             	sub    $0xc,%esp
    2346:	8b 45 08             	mov    0x8(%ebp),%eax
    2349:	ff b0 80 00 00 00    	pushl  0x80(%eax)
    234f:	ff 70 7c             	pushl  0x7c(%eax)
    2352:	ff 70 78             	pushl  0x78(%eax)
    2355:	ff 70 74             	pushl  0x74(%eax)
    2358:	ff 75 08             	pushl  0x8(%ebp)
    235b:	8b 45 0c             	mov    0xc(%ebp),%eax
    235e:	ff d0                	call   *%eax
    2360:	83 c4 20             	add    $0x20,%esp
    2363:	84 c0                	test   %al,%al
    2365:	75 0c                	jne    2373 <APWndExec+0xa0>
                break;
        hwnd->msg.type = MSG_NULL;
    2367:	8b 45 08             	mov    0x8(%ebp),%eax
    236a:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    2371:	eb a9                	jmp    231c <APWndExec+0x49>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    2373:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    2374:	90                   	nop
    2375:	c9                   	leave  
    2376:	c3                   	ret    

00002377 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    2377:	55                   	push   %ebp
    2378:	89 e5                	mov    %esp,%ebp
    237a:	57                   	push   %edi
    237b:	56                   	push   %esi
    237c:	53                   	push   %ebx
    237d:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    2380:	a1 6c 75 00 00       	mov    0x756c,%eax
    2385:	85 c0                	test   %eax,%eax
    2387:	0f 85 c8 02 00 00    	jne    2655 <APGridPaint+0x2de>
    {
        iconReady = 1;
    238d:	c7 05 6c 75 00 00 01 	movl   $0x1,0x756c
    2394:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    2397:	8d 45 98             	lea    -0x68(%ebp),%eax
    239a:	83 ec 08             	sub    $0x8,%esp
    239d:	68 13 31 00 00       	push   $0x3113
    23a2:	50                   	push   %eax
    23a3:	e8 69 ef ff ff       	call   1311 <APLoadBitmap>
    23a8:	83 c4 0c             	add    $0xc,%esp
    23ab:	8b 45 98             	mov    -0x68(%ebp),%eax
    23ae:	a3 70 ba 00 00       	mov    %eax,0xba70
    23b3:	8b 45 9c             	mov    -0x64(%ebp),%eax
    23b6:	a3 74 ba 00 00       	mov    %eax,0xba74
    23bb:	8b 45 a0             	mov    -0x60(%ebp),%eax
    23be:	a3 78 ba 00 00       	mov    %eax,0xba78
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    23c3:	83 ec 04             	sub    $0x4,%esp
    23c6:	ff 35 78 ba 00 00    	pushl  0xba78
    23cc:	ff 35 74 ba 00 00    	pushl  0xba74
    23d2:	ff 35 70 ba 00 00    	pushl  0xba70
    23d8:	e8 6e f1 ff ff       	call   154b <APCreateCompatibleDCFromBitmap>
    23dd:	83 c4 10             	add    $0x10,%esp
    23e0:	a3 84 ba 00 00       	mov    %eax,0xba84
        grid_river = APLoadBitmap ("grid_river.bmp");
    23e5:	8d 45 98             	lea    -0x68(%ebp),%eax
    23e8:	83 ec 08             	sub    $0x8,%esp
    23eb:	68 21 31 00 00       	push   $0x3121
    23f0:	50                   	push   %eax
    23f1:	e8 1b ef ff ff       	call   1311 <APLoadBitmap>
    23f6:	83 c4 0c             	add    $0xc,%esp
    23f9:	8b 45 98             	mov    -0x68(%ebp),%eax
    23fc:	a3 0c cc 00 00       	mov    %eax,0xcc0c
    2401:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2404:	a3 10 cc 00 00       	mov    %eax,0xcc10
    2409:	8b 45 a0             	mov    -0x60(%ebp),%eax
    240c:	a3 14 cc 00 00       	mov    %eax,0xcc14
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    2411:	83 ec 04             	sub    $0x4,%esp
    2414:	ff 35 14 cc 00 00    	pushl  0xcc14
    241a:	ff 35 10 cc 00 00    	pushl  0xcc10
    2420:	ff 35 0c cc 00 00    	pushl  0xcc0c
    2426:	e8 20 f1 ff ff       	call   154b <APCreateCompatibleDCFromBitmap>
    242b:	83 c4 10             	add    $0x10,%esp
    242e:	a3 fc cb 00 00       	mov    %eax,0xcbfc
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    2433:	8d 45 98             	lea    -0x68(%ebp),%eax
    2436:	83 ec 08             	sub    $0x8,%esp
    2439:	68 30 31 00 00       	push   $0x3130
    243e:	50                   	push   %eax
    243f:	e8 cd ee ff ff       	call   1311 <APLoadBitmap>
    2444:	83 c4 0c             	add    $0xc,%esp
    2447:	8b 45 98             	mov    -0x68(%ebp),%eax
    244a:	a3 00 cc 00 00       	mov    %eax,0xcc00
    244f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2452:	a3 04 cc 00 00       	mov    %eax,0xcc04
    2457:	8b 45 a0             	mov    -0x60(%ebp),%eax
    245a:	a3 08 cc 00 00       	mov    %eax,0xcc08
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    245f:	83 ec 04             	sub    $0x4,%esp
    2462:	ff 35 08 cc 00 00    	pushl  0xcc08
    2468:	ff 35 04 cc 00 00    	pushl  0xcc04
    246e:	ff 35 00 cc 00 00    	pushl  0xcc00
    2474:	e8 d2 f0 ff ff       	call   154b <APCreateCompatibleDCFromBitmap>
    2479:	83 c4 10             	add    $0x10,%esp
    247c:	a3 44 ba 00 00       	mov    %eax,0xba44
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    2481:	8d 45 98             	lea    -0x68(%ebp),%eax
    2484:	83 ec 08             	sub    $0x8,%esp
    2487:	68 3f 31 00 00       	push   $0x313f
    248c:	50                   	push   %eax
    248d:	e8 7f ee ff ff       	call   1311 <APLoadBitmap>
    2492:	83 c4 0c             	add    $0xc,%esp
    2495:	8b 45 98             	mov    -0x68(%ebp),%eax
    2498:	a3 48 ba 00 00       	mov    %eax,0xba48
    249d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    24a0:	a3 4c ba 00 00       	mov    %eax,0xba4c
    24a5:	8b 45 a0             	mov    -0x60(%ebp),%eax
    24a8:	a3 50 ba 00 00       	mov    %eax,0xba50
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    24ad:	83 ec 04             	sub    $0x4,%esp
    24b0:	ff 35 50 ba 00 00    	pushl  0xba50
    24b6:	ff 35 4c ba 00 00    	pushl  0xba4c
    24bc:	ff 35 48 ba 00 00    	pushl  0xba48
    24c2:	e8 84 f0 ff ff       	call   154b <APCreateCompatibleDCFromBitmap>
    24c7:	83 c4 10             	add    $0x10,%esp
    24ca:	a3 6c ba 00 00       	mov    %eax,0xba6c
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    24cf:	8d 45 98             	lea    -0x68(%ebp),%eax
    24d2:	83 ec 08             	sub    $0x8,%esp
    24d5:	68 51 31 00 00       	push   $0x3151
    24da:	50                   	push   %eax
    24db:	e8 31 ee ff ff       	call   1311 <APLoadBitmap>
    24e0:	83 c4 0c             	add    $0xc,%esp
    24e3:	8b 45 98             	mov    -0x68(%ebp),%eax
    24e6:	a3 90 ba 00 00       	mov    %eax,0xba90
    24eb:	8b 45 9c             	mov    -0x64(%ebp),%eax
    24ee:	a3 94 ba 00 00       	mov    %eax,0xba94
    24f3:	8b 45 a0             	mov    -0x60(%ebp),%eax
    24f6:	a3 98 ba 00 00       	mov    %eax,0xba98
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    24fb:	83 ec 04             	sub    $0x4,%esp
    24fe:	ff 35 98 ba 00 00    	pushl  0xba98
    2504:	ff 35 94 ba 00 00    	pushl  0xba94
    250a:	ff 35 90 ba 00 00    	pushl  0xba90
    2510:	e8 36 f0 ff ff       	call   154b <APCreateCompatibleDCFromBitmap>
    2515:	83 c4 10             	add    $0x10,%esp
    2518:	a3 1c cc 00 00       	mov    %eax,0xcc1c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    251d:	8d 45 98             	lea    -0x68(%ebp),%eax
    2520:	83 ec 08             	sub    $0x8,%esp
    2523:	68 5f 31 00 00       	push   $0x315f
    2528:	50                   	push   %eax
    2529:	e8 e3 ed ff ff       	call   1311 <APLoadBitmap>
    252e:	83 c4 0c             	add    $0xc,%esp
    2531:	8b 45 98             	mov    -0x68(%ebp),%eax
    2534:	a3 60 ba 00 00       	mov    %eax,0xba60
    2539:	8b 45 9c             	mov    -0x64(%ebp),%eax
    253c:	a3 64 ba 00 00       	mov    %eax,0xba64
    2541:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2544:	a3 68 ba 00 00       	mov    %eax,0xba68
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    2549:	83 ec 04             	sub    $0x4,%esp
    254c:	ff 35 68 ba 00 00    	pushl  0xba68
    2552:	ff 35 64 ba 00 00    	pushl  0xba64
    2558:	ff 35 60 ba 00 00    	pushl  0xba60
    255e:	e8 e8 ef ff ff       	call   154b <APCreateCompatibleDCFromBitmap>
    2563:	83 c4 10             	add    $0x10,%esp
    2566:	a3 88 ba 00 00       	mov    %eax,0xba88
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    256b:	8d 45 98             	lea    -0x68(%ebp),%eax
    256e:	83 ec 08             	sub    $0x8,%esp
    2571:	68 6f 31 00 00       	push   $0x316f
    2576:	50                   	push   %eax
    2577:	e8 95 ed ff ff       	call   1311 <APLoadBitmap>
    257c:	83 c4 0c             	add    $0xc,%esp
    257f:	8b 45 98             	mov    -0x68(%ebp),%eax
    2582:	a3 f0 cb 00 00       	mov    %eax,0xcbf0
    2587:	8b 45 9c             	mov    -0x64(%ebp),%eax
    258a:	a3 f4 cb 00 00       	mov    %eax,0xcbf4
    258f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2592:	a3 f8 cb 00 00       	mov    %eax,0xcbf8
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    2597:	83 ec 04             	sub    $0x4,%esp
    259a:	ff 35 f8 cb 00 00    	pushl  0xcbf8
    25a0:	ff 35 f4 cb 00 00    	pushl  0xcbf4
    25a6:	ff 35 f0 cb 00 00    	pushl  0xcbf0
    25ac:	e8 9a ef ff ff       	call   154b <APCreateCompatibleDCFromBitmap>
    25b1:	83 c4 10             	add    $0x10,%esp
    25b4:	a3 20 cc 00 00       	mov    %eax,0xcc20
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    25b9:	8d 45 98             	lea    -0x68(%ebp),%eax
    25bc:	83 ec 08             	sub    $0x8,%esp
    25bf:	68 7e 31 00 00       	push   $0x317e
    25c4:	50                   	push   %eax
    25c5:	e8 47 ed ff ff       	call   1311 <APLoadBitmap>
    25ca:	83 c4 0c             	add    $0xc,%esp
    25cd:	8b 45 98             	mov    -0x68(%ebp),%eax
    25d0:	a3 a4 ba 00 00       	mov    %eax,0xbaa4
    25d5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    25d8:	a3 a8 ba 00 00       	mov    %eax,0xbaa8
    25dd:	8b 45 a0             	mov    -0x60(%ebp),%eax
    25e0:	a3 ac ba 00 00       	mov    %eax,0xbaac
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    25e5:	83 ec 04             	sub    $0x4,%esp
    25e8:	ff 35 ac ba 00 00    	pushl  0xbaac
    25ee:	ff 35 a8 ba 00 00    	pushl  0xbaa8
    25f4:	ff 35 a4 ba 00 00    	pushl  0xbaa4
    25fa:	e8 4c ef ff ff       	call   154b <APCreateCompatibleDCFromBitmap>
    25ff:	83 c4 10             	add    $0x10,%esp
    2602:	a3 18 cc 00 00       	mov    %eax,0xcc18
        grid_tower = APLoadBitmap ("grid_tower.bmp");
    2607:	8d 45 98             	lea    -0x68(%ebp),%eax
    260a:	83 ec 08             	sub    $0x8,%esp
    260d:	68 8d 31 00 00       	push   $0x318d
    2612:	50                   	push   %eax
    2613:	e8 f9 ec ff ff       	call   1311 <APLoadBitmap>
    2618:	83 c4 0c             	add    $0xc,%esp
    261b:	8b 45 98             	mov    -0x68(%ebp),%eax
    261e:	a3 54 ba 00 00       	mov    %eax,0xba54
    2623:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2626:	a3 58 ba 00 00       	mov    %eax,0xba58
    262b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    262e:	a3 5c ba 00 00       	mov    %eax,0xba5c
        g_tower = APCreateCompatibleDCFromBitmap(grid_tower);
    2633:	83 ec 04             	sub    $0x4,%esp
    2636:	ff 35 5c ba 00 00    	pushl  0xba5c
    263c:	ff 35 58 ba 00 00    	pushl  0xba58
    2642:	ff 35 54 ba 00 00    	pushl  0xba54
    2648:	e8 fe ee ff ff       	call   154b <APCreateCompatibleDCFromBitmap>
    264d:	83 c4 10             	add    $0x10,%esp
    2650:	a3 8c ba 00 00       	mov    %eax,0xba8c
   
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    2655:	8b 45 08             	mov    0x8(%ebp),%eax
    2658:	8b 40 08             	mov    0x8(%eax),%eax
    265b:	85 c0                	test   %eax,%eax
    265d:	75 17                	jne    2676 <APGridPaint+0x2ff>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    265f:	83 ec 08             	sub    $0x8,%esp
    2662:	68 9c 31 00 00       	push   $0x319c
    2667:	6a 01                	push   $0x1
    2669:	e8 1d e8 ff ff       	call   e8b <printf>
    266e:	83 c4 10             	add    $0x10,%esp
        return;
    2671:	e9 ae 04 00 00       	jmp    2b24 <APGridPaint+0x7ad>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    2676:	8b 45 08             	mov    0x8(%ebp),%eax
    2679:	8b 40 10             	mov    0x10(%eax),%eax
    267c:	85 c0                	test   %eax,%eax
    267e:	7e 10                	jle    2690 <APGridPaint+0x319>
    2680:	8b 45 08             	mov    0x8(%ebp),%eax
    2683:	8b 50 14             	mov    0x14(%eax),%edx
    2686:	8b 45 08             	mov    0x8(%ebp),%eax
    2689:	8b 40 10             	mov    0x10(%eax),%eax
    268c:	39 c2                	cmp    %eax,%edx
    268e:	7c 17                	jl     26a7 <APGridPaint+0x330>
    {
        printf(1,"Grid mode page error!");
    2690:	83 ec 08             	sub    $0x8,%esp
    2693:	68 c2 31 00 00       	push   $0x31c2
    2698:	6a 01                	push   $0x1
    269a:	e8 ec e7 ff ff       	call   e8b <printf>
    269f:	83 c4 10             	add    $0x10,%esp
        return;
    26a2:	e9 7d 04 00 00       	jmp    2b24 <APGridPaint+0x7ad>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    26a7:	8b 45 08             	mov    0x8(%ebp),%eax
    26aa:	8b 40 14             	mov    0x14(%eax),%eax
    26ad:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    26b3:	89 45 dc             	mov    %eax,-0x24(%ebp)
    26b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
    26b9:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    26bc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    26c3:	e9 52 04 00 00       	jmp    2b1a <APGridPaint+0x7a3>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    26c8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    26cf:	e9 38 04 00 00       	jmp    2b0c <APGridPaint+0x795>
        {
            index = start + GRID_W_NUMBER * j + i;
    26d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    26d7:	c1 e0 04             	shl    $0x4,%eax
    26da:	89 c2                	mov    %eax,%edx
    26dc:	8b 45 d8             	mov    -0x28(%ebp),%eax
    26df:	01 c2                	add    %eax,%edx
    26e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    26e4:	01 d0                	add    %edx,%eax
    26e6:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    26e9:	8b 45 08             	mov    0x8(%ebp),%eax
    26ec:	8b 40 0c             	mov    0xc(%eax),%eax
    26ef:	8b 55 dc             	mov    -0x24(%ebp),%edx
    26f2:	c1 e2 02             	shl    $0x2,%edx
    26f5:	01 d0                	add    %edx,%eax
    26f7:	8b 00                	mov    (%eax),%eax
    26f9:	83 f8 0b             	cmp    $0xb,%eax
    26fc:	0f 87 05 04 00 00    	ja     2b07 <APGridPaint+0x790>
    2702:	8b 04 85 d8 31 00 00 	mov    0x31d8(,%eax,4),%eax
    2709:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    270b:	8d 45 bd             	lea    -0x43(%ebp),%eax
    270e:	6a 0c                	push   $0xc
    2710:	6a 0c                	push   $0xc
    2712:	6a 0c                	push   $0xc
    2714:	50                   	push   %eax
    2715:	e8 d9 f7 ff ff       	call   1ef3 <RGB>
    271a:	83 c4 0c             	add    $0xc,%esp
    271d:	8b 1d 84 ba 00 00    	mov    0xba84,%ebx
    2723:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2726:	6b c8 32             	imul   $0x32,%eax,%ecx
    2729:	8b 45 e0             	mov    -0x20(%ebp),%eax
    272c:	6b c0 32             	imul   $0x32,%eax,%eax
    272f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2732:	8b 45 08             	mov    0x8(%ebp),%eax
    2735:	8d 78 3c             	lea    0x3c(%eax),%edi
    2738:	83 ec 0c             	sub    $0xc,%esp
    273b:	83 ec 04             	sub    $0x4,%esp
    273e:	89 e0                	mov    %esp,%eax
    2740:	0f b7 75 bd          	movzwl -0x43(%ebp),%esi
    2744:	66 89 30             	mov    %si,(%eax)
    2747:	0f b6 55 bf          	movzbl -0x41(%ebp),%edx
    274b:	88 50 02             	mov    %dl,0x2(%eax)
    274e:	6a 32                	push   $0x32
    2750:	6a 32                	push   $0x32
    2752:	6a 00                	push   $0x0
    2754:	6a 00                	push   $0x0
    2756:	53                   	push   %ebx
    2757:	51                   	push   %ecx
    2758:	ff 75 94             	pushl  -0x6c(%ebp)
    275b:	57                   	push   %edi
    275c:	e8 ee f5 ff ff       	call   1d4f <APDcCopy>
    2761:	83 c4 30             	add    $0x30,%esp
                    break;
    2764:	e9 9f 03 00 00       	jmp    2b08 <APGridPaint+0x791>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    2769:	8d 45 98             	lea    -0x68(%ebp),%eax
    276c:	6a 69                	push   $0x69
    276e:	6a 69                	push   $0x69
    2770:	6a 69                	push   $0x69
    2772:	50                   	push   %eax
    2773:	e8 7b f7 ff ff       	call   1ef3 <RGB>
    2778:	83 c4 0c             	add    $0xc,%esp
    277b:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    277f:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    2783:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2787:	88 45 b6             	mov    %al,-0x4a(%ebp)
                    pen.size = 1;
    278a:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    2791:	8d 45 98             	lea    -0x68(%ebp),%eax
    2794:	6a 69                	push   $0x69
    2796:	6a 69                	push   $0x69
    2798:	6a 69                	push   $0x69
    279a:	50                   	push   %eax
    279b:	e8 53 f7 ff ff       	call   1ef3 <RGB>
    27a0:	83 c4 0c             	add    $0xc,%esp
    27a3:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    27a7:	66 89 45 b1          	mov    %ax,-0x4f(%ebp)
    27ab:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    27af:	88 45 b3             	mov    %al,-0x4d(%ebp)
                    APSetPen(&wnd->Dc,pen);
    27b2:	8b 45 08             	mov    0x8(%ebp),%eax
    27b5:	8d 50 3c             	lea    0x3c(%eax),%edx
    27b8:	8d 45 98             	lea    -0x68(%ebp),%eax
    27bb:	ff 75 b8             	pushl  -0x48(%ebp)
    27be:	ff 75 b4             	pushl  -0x4c(%ebp)
    27c1:	52                   	push   %edx
    27c2:	50                   	push   %eax
    27c3:	e8 18 ee ff ff       	call   15e0 <APSetPen>
    27c8:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    27cb:	8b 45 08             	mov    0x8(%ebp),%eax
    27ce:	8d 58 3c             	lea    0x3c(%eax),%ebx
    27d1:	8d 55 98             	lea    -0x68(%ebp),%edx
    27d4:	83 ec 04             	sub    $0x4,%esp
    27d7:	83 ec 04             	sub    $0x4,%esp
    27da:	89 e0                	mov    %esp,%eax
    27dc:	0f b7 4d b1          	movzwl -0x4f(%ebp),%ecx
    27e0:	66 89 08             	mov    %cx,(%eax)
    27e3:	0f b6 4d b3          	movzbl -0x4d(%ebp),%ecx
    27e7:	88 48 02             	mov    %cl,0x2(%eax)
    27ea:	53                   	push   %ebx
    27eb:	52                   	push   %edx
    27ec:	e8 28 ee ff ff       	call   1619 <APSetBrush>
    27f1:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    27f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    27f7:	6b d0 32             	imul   $0x32,%eax,%edx
    27fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
    27fd:	6b c0 32             	imul   $0x32,%eax,%eax
    2800:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2803:	83 c1 3c             	add    $0x3c,%ecx
    2806:	83 ec 0c             	sub    $0xc,%esp
    2809:	6a 32                	push   $0x32
    280b:	6a 32                	push   $0x32
    280d:	52                   	push   %edx
    280e:	50                   	push   %eax
    280f:	51                   	push   %ecx
    2810:	e8 2e f2 ff ff       	call   1a43 <APDrawRect>
    2815:	83 c4 20             	add    $0x20,%esp
                    break;
    2818:	e9 eb 02 00 00       	jmp    2b08 <APGridPaint+0x791>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    281d:	8d 45 c0             	lea    -0x40(%ebp),%eax
    2820:	6a 0c                	push   $0xc
    2822:	6a 0c                	push   $0xc
    2824:	6a 0c                	push   $0xc
    2826:	50                   	push   %eax
    2827:	e8 c7 f6 ff ff       	call   1ef3 <RGB>
    282c:	83 c4 0c             	add    $0xc,%esp
    282f:	8b 1d 20 cc 00 00    	mov    0xcc20,%ebx
    2835:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2838:	6b c8 32             	imul   $0x32,%eax,%ecx
    283b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    283e:	6b c0 32             	imul   $0x32,%eax,%eax
    2841:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2844:	8b 45 08             	mov    0x8(%ebp),%eax
    2847:	8d 78 3c             	lea    0x3c(%eax),%edi
    284a:	83 ec 0c             	sub    $0xc,%esp
    284d:	83 ec 04             	sub    $0x4,%esp
    2850:	89 e0                	mov    %esp,%eax
    2852:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    2856:	66 89 30             	mov    %si,(%eax)
    2859:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    285d:	88 50 02             	mov    %dl,0x2(%eax)
    2860:	6a 32                	push   $0x32
    2862:	6a 32                	push   $0x32
    2864:	6a 00                	push   $0x0
    2866:	6a 00                	push   $0x0
    2868:	53                   	push   %ebx
    2869:	51                   	push   %ecx
    286a:	ff 75 94             	pushl  -0x6c(%ebp)
    286d:	57                   	push   %edi
    286e:	e8 dc f4 ff ff       	call   1d4f <APDcCopy>
    2873:	83 c4 30             	add    $0x30,%esp
                    break;
    2876:	e9 8d 02 00 00       	jmp    2b08 <APGridPaint+0x791>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    287b:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    287e:	6a 0c                	push   $0xc
    2880:	6a 0c                	push   $0xc
    2882:	6a 0c                	push   $0xc
    2884:	50                   	push   %eax
    2885:	e8 69 f6 ff ff       	call   1ef3 <RGB>
    288a:	83 c4 0c             	add    $0xc,%esp
    288d:	8b 1d fc cb 00 00    	mov    0xcbfc,%ebx
    2893:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2896:	6b c8 32             	imul   $0x32,%eax,%ecx
    2899:	8b 45 e0             	mov    -0x20(%ebp),%eax
    289c:	6b c0 32             	imul   $0x32,%eax,%eax
    289f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    28a2:	8b 45 08             	mov    0x8(%ebp),%eax
    28a5:	8d 78 3c             	lea    0x3c(%eax),%edi
    28a8:	83 ec 0c             	sub    $0xc,%esp
    28ab:	83 ec 04             	sub    $0x4,%esp
    28ae:	89 e0                	mov    %esp,%eax
    28b0:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    28b4:	66 89 30             	mov    %si,(%eax)
    28b7:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    28bb:	88 50 02             	mov    %dl,0x2(%eax)
    28be:	6a 32                	push   $0x32
    28c0:	6a 32                	push   $0x32
    28c2:	6a 00                	push   $0x0
    28c4:	6a 00                	push   $0x0
    28c6:	53                   	push   %ebx
    28c7:	51                   	push   %ecx
    28c8:	ff 75 94             	pushl  -0x6c(%ebp)
    28cb:	57                   	push   %edi
    28cc:	e8 7e f4 ff ff       	call   1d4f <APDcCopy>
    28d1:	83 c4 30             	add    $0x30,%esp
                    break;
    28d4:	e9 2f 02 00 00       	jmp    2b08 <APGridPaint+0x791>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    28d9:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    28dc:	6a 0c                	push   $0xc
    28de:	6a 0c                	push   $0xc
    28e0:	6a 0c                	push   $0xc
    28e2:	50                   	push   %eax
    28e3:	e8 0b f6 ff ff       	call   1ef3 <RGB>
    28e8:	83 c4 0c             	add    $0xc,%esp
    28eb:	8b 1d 88 ba 00 00    	mov    0xba88,%ebx
    28f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    28f4:	6b c8 32             	imul   $0x32,%eax,%ecx
    28f7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    28fa:	6b c0 32             	imul   $0x32,%eax,%eax
    28fd:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2900:	8b 45 08             	mov    0x8(%ebp),%eax
    2903:	8d 78 3c             	lea    0x3c(%eax),%edi
    2906:	83 ec 0c             	sub    $0xc,%esp
    2909:	83 ec 04             	sub    $0x4,%esp
    290c:	89 e0                	mov    %esp,%eax
    290e:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2912:	66 89 30             	mov    %si,(%eax)
    2915:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    2919:	88 50 02             	mov    %dl,0x2(%eax)
    291c:	6a 32                	push   $0x32
    291e:	6a 32                	push   $0x32
    2920:	6a 00                	push   $0x0
    2922:	6a 00                	push   $0x0
    2924:	53                   	push   %ebx
    2925:	51                   	push   %ecx
    2926:	ff 75 94             	pushl  -0x6c(%ebp)
    2929:	57                   	push   %edi
    292a:	e8 20 f4 ff ff       	call   1d4f <APDcCopy>
    292f:	83 c4 30             	add    $0x30,%esp
                    break;
    2932:	e9 d1 01 00 00       	jmp    2b08 <APGridPaint+0x791>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2937:	8d 45 c9             	lea    -0x37(%ebp),%eax
    293a:	6a 0c                	push   $0xc
    293c:	6a 0c                	push   $0xc
    293e:	6a 0c                	push   $0xc
    2940:	50                   	push   %eax
    2941:	e8 ad f5 ff ff       	call   1ef3 <RGB>
    2946:	83 c4 0c             	add    $0xc,%esp
    2949:	8b 1d 1c cc 00 00    	mov    0xcc1c,%ebx
    294f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2952:	6b c8 32             	imul   $0x32,%eax,%ecx
    2955:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2958:	6b c0 32             	imul   $0x32,%eax,%eax
    295b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    295e:	8b 45 08             	mov    0x8(%ebp),%eax
    2961:	8d 78 3c             	lea    0x3c(%eax),%edi
    2964:	83 ec 0c             	sub    $0xc,%esp
    2967:	83 ec 04             	sub    $0x4,%esp
    296a:	89 e0                	mov    %esp,%eax
    296c:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    2970:	66 89 30             	mov    %si,(%eax)
    2973:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    2977:	88 50 02             	mov    %dl,0x2(%eax)
    297a:	6a 32                	push   $0x32
    297c:	6a 32                	push   $0x32
    297e:	6a 00                	push   $0x0
    2980:	6a 00                	push   $0x0
    2982:	53                   	push   %ebx
    2983:	51                   	push   %ecx
    2984:	ff 75 94             	pushl  -0x6c(%ebp)
    2987:	57                   	push   %edi
    2988:	e8 c2 f3 ff ff       	call   1d4f <APDcCopy>
    298d:	83 c4 30             	add    $0x30,%esp
                    break;
    2990:	e9 73 01 00 00       	jmp    2b08 <APGridPaint+0x791>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2995:	8d 45 cc             	lea    -0x34(%ebp),%eax
    2998:	6a 0c                	push   $0xc
    299a:	6a 0c                	push   $0xc
    299c:	6a 0c                	push   $0xc
    299e:	50                   	push   %eax
    299f:	e8 4f f5 ff ff       	call   1ef3 <RGB>
    29a4:	83 c4 0c             	add    $0xc,%esp
    29a7:	8b 1d 44 ba 00 00    	mov    0xba44,%ebx
    29ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    29b0:	6b c8 32             	imul   $0x32,%eax,%ecx
    29b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    29b6:	6b c0 32             	imul   $0x32,%eax,%eax
    29b9:	89 45 94             	mov    %eax,-0x6c(%ebp)
    29bc:	8b 45 08             	mov    0x8(%ebp),%eax
    29bf:	8d 78 3c             	lea    0x3c(%eax),%edi
    29c2:	83 ec 0c             	sub    $0xc,%esp
    29c5:	83 ec 04             	sub    $0x4,%esp
    29c8:	89 e0                	mov    %esp,%eax
    29ca:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    29ce:	66 89 30             	mov    %si,(%eax)
    29d1:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    29d5:	88 50 02             	mov    %dl,0x2(%eax)
    29d8:	6a 32                	push   $0x32
    29da:	6a 32                	push   $0x32
    29dc:	6a 00                	push   $0x0
    29de:	6a 00                	push   $0x0
    29e0:	53                   	push   %ebx
    29e1:	51                   	push   %ecx
    29e2:	ff 75 94             	pushl  -0x6c(%ebp)
    29e5:	57                   	push   %edi
    29e6:	e8 64 f3 ff ff       	call   1d4f <APDcCopy>
    29eb:	83 c4 30             	add    $0x30,%esp
                    break;
    29ee:	e9 15 01 00 00       	jmp    2b08 <APGridPaint+0x791>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    29f3:	8d 45 cf             	lea    -0x31(%ebp),%eax
    29f6:	6a 0c                	push   $0xc
    29f8:	6a 0c                	push   $0xc
    29fa:	6a 0c                	push   $0xc
    29fc:	50                   	push   %eax
    29fd:	e8 f1 f4 ff ff       	call   1ef3 <RGB>
    2a02:	83 c4 0c             	add    $0xc,%esp
    2a05:	8b 1d 6c ba 00 00    	mov    0xba6c,%ebx
    2a0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2a0e:	6b c8 32             	imul   $0x32,%eax,%ecx
    2a11:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2a14:	6b c0 32             	imul   $0x32,%eax,%eax
    2a17:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2a1a:	8b 45 08             	mov    0x8(%ebp),%eax
    2a1d:	8d 78 3c             	lea    0x3c(%eax),%edi
    2a20:	83 ec 0c             	sub    $0xc,%esp
    2a23:	83 ec 04             	sub    $0x4,%esp
    2a26:	89 e0                	mov    %esp,%eax
    2a28:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2a2c:	66 89 30             	mov    %si,(%eax)
    2a2f:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2a33:	88 50 02             	mov    %dl,0x2(%eax)
    2a36:	6a 32                	push   $0x32
    2a38:	6a 32                	push   $0x32
    2a3a:	6a 00                	push   $0x0
    2a3c:	6a 00                	push   $0x0
    2a3e:	53                   	push   %ebx
    2a3f:	51                   	push   %ecx
    2a40:	ff 75 94             	pushl  -0x6c(%ebp)
    2a43:	57                   	push   %edi
    2a44:	e8 06 f3 ff ff       	call   1d4f <APDcCopy>
    2a49:	83 c4 30             	add    $0x30,%esp
                    break;
    2a4c:	e9 b7 00 00 00       	jmp    2b08 <APGridPaint+0x791>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2a51:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2a54:	6a 0c                	push   $0xc
    2a56:	6a 0c                	push   $0xc
    2a58:	6a 0c                	push   $0xc
    2a5a:	50                   	push   %eax
    2a5b:	e8 93 f4 ff ff       	call   1ef3 <RGB>
    2a60:	83 c4 0c             	add    $0xc,%esp
    2a63:	8b 1d 18 cc 00 00    	mov    0xcc18,%ebx
    2a69:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2a6c:	6b c8 32             	imul   $0x32,%eax,%ecx
    2a6f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2a72:	6b c0 32             	imul   $0x32,%eax,%eax
    2a75:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2a78:	8b 45 08             	mov    0x8(%ebp),%eax
    2a7b:	8d 78 3c             	lea    0x3c(%eax),%edi
    2a7e:	83 ec 0c             	sub    $0xc,%esp
    2a81:	83 ec 04             	sub    $0x4,%esp
    2a84:	89 e0                	mov    %esp,%eax
    2a86:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2a8a:	66 89 30             	mov    %si,(%eax)
    2a8d:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2a91:	88 50 02             	mov    %dl,0x2(%eax)
    2a94:	6a 32                	push   $0x32
    2a96:	6a 32                	push   $0x32
    2a98:	6a 00                	push   $0x0
    2a9a:	6a 00                	push   $0x0
    2a9c:	53                   	push   %ebx
    2a9d:	51                   	push   %ecx
    2a9e:	ff 75 94             	pushl  -0x6c(%ebp)
    2aa1:	57                   	push   %edi
    2aa2:	e8 a8 f2 ff ff       	call   1d4f <APDcCopy>
    2aa7:	83 c4 30             	add    $0x30,%esp
                    break;
    2aaa:	eb 5c                	jmp    2b08 <APGridPaint+0x791>
                case GRID_PROGRAM_TOWER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_tower,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2aac:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    2aaf:	6a 0c                	push   $0xc
    2ab1:	6a 0c                	push   $0xc
    2ab3:	6a 0c                	push   $0xc
    2ab5:	50                   	push   %eax
    2ab6:	e8 38 f4 ff ff       	call   1ef3 <RGB>
    2abb:	83 c4 0c             	add    $0xc,%esp
    2abe:	8b 1d 8c ba 00 00    	mov    0xba8c,%ebx
    2ac4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2ac7:	6b c8 32             	imul   $0x32,%eax,%ecx
    2aca:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2acd:	6b c0 32             	imul   $0x32,%eax,%eax
    2ad0:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2ad3:	8b 45 08             	mov    0x8(%ebp),%eax
    2ad6:	8d 78 3c             	lea    0x3c(%eax),%edi
    2ad9:	83 ec 0c             	sub    $0xc,%esp
    2adc:	83 ec 04             	sub    $0x4,%esp
    2adf:	89 e0                	mov    %esp,%eax
    2ae1:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2ae5:	66 89 30             	mov    %si,(%eax)
    2ae8:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2aec:	88 50 02             	mov    %dl,0x2(%eax)
    2aef:	6a 32                	push   $0x32
    2af1:	6a 32                	push   $0x32
    2af3:	6a 00                	push   $0x0
    2af5:	6a 00                	push   $0x0
    2af7:	53                   	push   %ebx
    2af8:	51                   	push   %ecx
    2af9:	ff 75 94             	pushl  -0x6c(%ebp)
    2afc:	57                   	push   %edi
    2afd:	e8 4d f2 ff ff       	call   1d4f <APDcCopy>
    2b02:	83 c4 30             	add    $0x30,%esp
                    break;
    2b05:	eb 01                	jmp    2b08 <APGridPaint+0x791>
                default: break;
    2b07:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2b08:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2b0c:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2b10:	0f 8e be fb ff ff    	jle    26d4 <APGridPaint+0x35d>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2b16:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2b1a:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2b1e:	0f 8e a4 fb ff ff    	jle    26c8 <APGridPaint+0x351>
                    break;
                default: break;
            }
        }
    }
}
    2b24:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2b27:	5b                   	pop    %ebx
    2b28:	5e                   	pop    %esi
    2b29:	5f                   	pop    %edi
    2b2a:	5d                   	pop    %ebp
    2b2b:	c3                   	ret    

00002b2c <updateword>:


void updateword(AHwnd hwnd,char* str)
{
    2b2c:	55                   	push   %ebp
    2b2d:	89 e5                	mov    %esp,%ebp
    2b2f:	53                   	push   %ebx
    2b30:	83 ec 24             	sub    $0x24,%esp
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2b33:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2b36:	68 cd 00 00 00       	push   $0xcd
    2b3b:	6a 74                	push   $0x74
    2b3d:	6a 18                	push   $0x18
    2b3f:	50                   	push   %eax
    2b40:	e8 ae f3 ff ff       	call   1ef3 <RGB>
    2b45:	83 c4 0c             	add    $0xc,%esp
    2b48:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2b4c:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
    2b50:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    2b54:	88 45 f2             	mov    %al,-0xe(%ebp)
    pen.size = 1;
    2b57:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2b5e:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2b61:	68 cd 00 00 00       	push   $0xcd
    2b66:	6a 74                	push   $0x74
    2b68:	6a 18                	push   $0x18
    2b6a:	50                   	push   %eax
    2b6b:	e8 83 f3 ff ff       	call   1ef3 <RGB>
    2b70:	83 c4 0c             	add    $0xc,%esp
    2b73:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2b77:	66 89 45 ed          	mov    %ax,-0x13(%ebp)
    2b7b:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    2b7f:	88 45 ef             	mov    %al,-0x11(%ebp)
    APSetPen(&hwnd->TitleDc,pen);
    2b82:	8b 45 08             	mov    0x8(%ebp),%eax
    2b85:	8d 50 58             	lea    0x58(%eax),%edx
    2b88:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2b8b:	ff 75 f4             	pushl  -0xc(%ebp)
    2b8e:	ff 75 f0             	pushl  -0x10(%ebp)
    2b91:	52                   	push   %edx
    2b92:	50                   	push   %eax
    2b93:	e8 48 ea ff ff       	call   15e0 <APSetPen>
    2b98:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&hwnd->TitleDc,brush);
    2b9b:	8b 45 08             	mov    0x8(%ebp),%eax
    2b9e:	8d 58 58             	lea    0x58(%eax),%ebx
    2ba1:	8d 55 d8             	lea    -0x28(%ebp),%edx
    2ba4:	83 ec 04             	sub    $0x4,%esp
    2ba7:	83 ec 04             	sub    $0x4,%esp
    2baa:	89 e0                	mov    %esp,%eax
    2bac:	0f b7 4d ed          	movzwl -0x13(%ebp),%ecx
    2bb0:	66 89 08             	mov    %cx,(%eax)
    2bb3:	0f b6 4d ef          	movzbl -0x11(%ebp),%ecx
    2bb7:	88 48 02             	mov    %cl,0x2(%eax)
    2bba:	53                   	push   %ebx
    2bbb:	52                   	push   %edx
    2bbc:	e8 58 ea ff ff       	call   1619 <APSetBrush>
    2bc1:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&hwnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2bc4:	8b 45 08             	mov    0x8(%ebp),%eax
    2bc7:	83 c0 58             	add    $0x58,%eax
    2bca:	83 ec 0c             	sub    $0xc,%esp
    2bcd:	6a 32                	push   $0x32
    2bcf:	68 20 03 00 00       	push   $0x320
    2bd4:	6a 00                	push   $0x0
    2bd6:	6a 00                	push   $0x0
    2bd8:	50                   	push   %eax
    2bd9:	e8 65 ee ff ff       	call   1a43 <APDrawRect>
    2bde:	83 c4 20             	add    $0x20,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    2be1:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2be4:	6a 08                	push   $0x8
    2be6:	6a 08                	push   $0x8
    2be8:	6a 08                	push   $0x8
    2bea:	50                   	push   %eax
    2beb:	e8 03 f3 ff ff       	call   1ef3 <RGB>
    2bf0:	83 c4 0c             	add    $0xc,%esp
    2bf3:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2bf7:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    2bfb:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    2bff:	88 45 ec             	mov    %al,-0x14(%ebp)
    APSetFont(&hwnd->TitleDc,font);
    2c02:	8b 45 08             	mov    0x8(%ebp),%eax
    2c05:	8d 58 58             	lea    0x58(%eax),%ebx
    2c08:	8d 55 d8             	lea    -0x28(%ebp),%edx
    2c0b:	83 ec 04             	sub    $0x4,%esp
    2c0e:	83 ec 04             	sub    $0x4,%esp
    2c11:	89 e0                	mov    %esp,%eax
    2c13:	0f b7 4d ea          	movzwl -0x16(%ebp),%ecx
    2c17:	66 89 08             	mov    %cx,(%eax)
    2c1a:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
    2c1e:	88 48 02             	mov    %cl,0x2(%eax)
    2c21:	53                   	push   %ebx
    2c22:	52                   	push   %edx
    2c23:	e8 33 ea ff ff       	call   165b <APSetFont>
    2c28:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&hwnd->TitleDc,str,10,20);
    2c2b:	8b 45 08             	mov    0x8(%ebp),%eax
    2c2e:	83 c0 58             	add    $0x58,%eax
    2c31:	6a 14                	push   $0x14
    2c33:	6a 0a                	push   $0xa
    2c35:	ff 75 0c             	pushl  0xc(%ebp)
    2c38:	50                   	push   %eax
    2c39:	e8 0a f0 ff ff       	call   1c48 <APDrawText>
    2c3e:	83 c4 10             	add    $0x10,%esp
}
    2c41:	90                   	nop
    2c42:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c45:	c9                   	leave  
    2c46:	c3                   	ret    

00002c47 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2c47:	55                   	push   %ebp
    2c48:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2c4a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2c4e:	7e 08                	jle    2c58 <random+0x11>
{
rand_num = seed;
    2c50:	8b 45 08             	mov    0x8(%ebp),%eax
    2c53:	a3 40 75 00 00       	mov    %eax,0x7540
}
rand_num *= 3;
    2c58:	8b 15 40 75 00 00    	mov    0x7540,%edx
    2c5e:	89 d0                	mov    %edx,%eax
    2c60:	01 c0                	add    %eax,%eax
    2c62:	01 d0                	add    %edx,%eax
    2c64:	a3 40 75 00 00       	mov    %eax,0x7540
if (rand_num < 0)
    2c69:	a1 40 75 00 00       	mov    0x7540,%eax
    2c6e:	85 c0                	test   %eax,%eax
    2c70:	79 0c                	jns    2c7e <random+0x37>
{
rand_num *= (-1);
    2c72:	a1 40 75 00 00       	mov    0x7540,%eax
    2c77:	f7 d8                	neg    %eax
    2c79:	a3 40 75 00 00       	mov    %eax,0x7540
}
return rand_num % 997;
    2c7e:	8b 0d 40 75 00 00    	mov    0x7540,%ecx
    2c84:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2c89:	89 c8                	mov    %ecx,%eax
    2c8b:	f7 ea                	imul   %edx
    2c8d:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2c90:	c1 f8 09             	sar    $0x9,%eax
    2c93:	89 c2                	mov    %eax,%edx
    2c95:	89 c8                	mov    %ecx,%eax
    2c97:	c1 f8 1f             	sar    $0x1f,%eax
    2c9a:	29 c2                	sub    %eax,%edx
    2c9c:	89 d0                	mov    %edx,%eax
    2c9e:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2ca4:	29 c1                	sub    %eax,%ecx
    2ca6:	89 c8                	mov    %ecx,%eax
}
    2ca8:	5d                   	pop    %ebp
    2ca9:	c3                   	ret    

00002caa <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2caa:	55                   	push   %ebp
    2cab:	89 e5                	mov    %esp,%ebp
    2cad:	53                   	push   %ebx
    2cae:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2cb1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2cb8:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2cbc:	74 17                	je     2cd5 <sprintint+0x2b>
    2cbe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2cc2:	79 11                	jns    2cd5 <sprintint+0x2b>
        neg = 1;
    2cc4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2ccb:	8b 45 10             	mov    0x10(%ebp),%eax
    2cce:	f7 d8                	neg    %eax
    2cd0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2cd3:	eb 06                	jmp    2cdb <sprintint+0x31>
    } else {
        x = xx;
    2cd5:	8b 45 10             	mov    0x10(%ebp),%eax
    2cd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2cdb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2ce2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2ce5:	8d 41 01             	lea    0x1(%ecx),%eax
    2ce8:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2ceb:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2cee:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2cf1:	ba 00 00 00 00       	mov    $0x0,%edx
    2cf6:	f7 f3                	div    %ebx
    2cf8:	89 d0                	mov    %edx,%eax
    2cfa:	0f b6 80 44 75 00 00 	movzbl 0x7544(%eax),%eax
    2d01:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2d05:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2d08:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2d0b:	ba 00 00 00 00       	mov    $0x0,%edx
    2d10:	f7 f3                	div    %ebx
    2d12:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2d15:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d19:	75 c7                	jne    2ce2 <sprintint+0x38>
    if(neg)
    2d1b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d1f:	74 0e                	je     2d2f <sprintint+0x85>
        buf[i++] = '-';
    2d21:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2d24:	8d 50 01             	lea    0x1(%eax),%edx
    2d27:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2d2a:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2d2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2d32:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2d35:	eb 1b                	jmp    2d52 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2d37:	8b 45 0c             	mov    0xc(%ebp),%eax
    2d3a:	8b 00                	mov    (%eax),%eax
    2d3c:	8d 48 01             	lea    0x1(%eax),%ecx
    2d3f:	8b 55 0c             	mov    0xc(%ebp),%edx
    2d42:	89 0a                	mov    %ecx,(%edx)
    2d44:	89 c2                	mov    %eax,%edx
    2d46:	8b 45 08             	mov    0x8(%ebp),%eax
    2d49:	01 d0                	add    %edx,%eax
    2d4b:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2d4e:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2d52:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2d56:	7f df                	jg     2d37 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2d58:	eb 21                	jmp    2d7b <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2d5a:	8b 45 0c             	mov    0xc(%ebp),%eax
    2d5d:	8b 00                	mov    (%eax),%eax
    2d5f:	8d 48 01             	lea    0x1(%eax),%ecx
    2d62:	8b 55 0c             	mov    0xc(%ebp),%edx
    2d65:	89 0a                	mov    %ecx,(%edx)
    2d67:	89 c2                	mov    %eax,%edx
    2d69:	8b 45 08             	mov    0x8(%ebp),%eax
    2d6c:	01 c2                	add    %eax,%edx
    2d6e:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2d71:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2d74:	01 c8                	add    %ecx,%eax
    2d76:	0f b6 00             	movzbl (%eax),%eax
    2d79:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2d7b:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2d7f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2d83:	79 d5                	jns    2d5a <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2d85:	90                   	nop
    2d86:	83 c4 20             	add    $0x20,%esp
    2d89:	5b                   	pop    %ebx
    2d8a:	5d                   	pop    %ebp
    2d8b:	c3                   	ret    

00002d8c <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2d8c:	55                   	push   %ebp
    2d8d:	89 e5                	mov    %esp,%ebp
    2d8f:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2d92:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2d99:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2da0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2da7:	8d 45 0c             	lea    0xc(%ebp),%eax
    2daa:	83 c0 04             	add    $0x4,%eax
    2dad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2db0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2db7:	e9 d9 01 00 00       	jmp    2f95 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2dbc:	8b 55 0c             	mov    0xc(%ebp),%edx
    2dbf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2dc2:	01 d0                	add    %edx,%eax
    2dc4:	0f b6 00             	movzbl (%eax),%eax
    2dc7:	0f be c0             	movsbl %al,%eax
    2dca:	25 ff 00 00 00       	and    $0xff,%eax
    2dcf:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2dd2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2dd6:	75 2c                	jne    2e04 <sprintf+0x78>
            if(c == '%'){
    2dd8:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2ddc:	75 0c                	jne    2dea <sprintf+0x5e>
                state = '%';
    2dde:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2de5:	e9 a7 01 00 00       	jmp    2f91 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2dea:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2ded:	8d 50 01             	lea    0x1(%eax),%edx
    2df0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2df3:	89 c2                	mov    %eax,%edx
    2df5:	8b 45 08             	mov    0x8(%ebp),%eax
    2df8:	01 d0                	add    %edx,%eax
    2dfa:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2dfd:	88 10                	mov    %dl,(%eax)
    2dff:	e9 8d 01 00 00       	jmp    2f91 <sprintf+0x205>
            }
        } else if(state == '%'){
    2e04:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2e08:	0f 85 83 01 00 00    	jne    2f91 <sprintf+0x205>
            if(c == 'd'){
    2e0e:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2e12:	75 4c                	jne    2e60 <sprintf+0xd4>
                buf[bi] = '\0';
    2e14:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2e17:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2e1a:	01 d0                	add    %edx,%eax
    2e1c:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2e1f:	83 ec 0c             	sub    $0xc,%esp
    2e22:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2e25:	50                   	push   %eax
    2e26:	e8 0f de ff ff       	call   c3a <atoi>
    2e2b:	83 c4 10             	add    $0x10,%esp
    2e2e:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2e31:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2e38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2e3b:	8b 00                	mov    (%eax),%eax
    2e3d:	83 ec 08             	sub    $0x8,%esp
    2e40:	ff 75 d8             	pushl  -0x28(%ebp)
    2e43:	6a 01                	push   $0x1
    2e45:	6a 0a                	push   $0xa
    2e47:	50                   	push   %eax
    2e48:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2e4b:	50                   	push   %eax
    2e4c:	ff 75 08             	pushl  0x8(%ebp)
    2e4f:	e8 56 fe ff ff       	call   2caa <sprintint>
    2e54:	83 c4 20             	add    $0x20,%esp
                ap++;
    2e57:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2e5b:	e9 2a 01 00 00       	jmp    2f8a <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2e60:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2e64:	74 06                	je     2e6c <sprintf+0xe0>
    2e66:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2e6a:	75 4c                	jne    2eb8 <sprintf+0x12c>
                buf[bi] = '\0';
    2e6c:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2e6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2e72:	01 d0                	add    %edx,%eax
    2e74:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2e77:	83 ec 0c             	sub    $0xc,%esp
    2e7a:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2e7d:	50                   	push   %eax
    2e7e:	e8 b7 dd ff ff       	call   c3a <atoi>
    2e83:	83 c4 10             	add    $0x10,%esp
    2e86:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2e89:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2e90:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2e93:	8b 00                	mov    (%eax),%eax
    2e95:	83 ec 08             	sub    $0x8,%esp
    2e98:	ff 75 dc             	pushl  -0x24(%ebp)
    2e9b:	6a 00                	push   $0x0
    2e9d:	6a 10                	push   $0x10
    2e9f:	50                   	push   %eax
    2ea0:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2ea3:	50                   	push   %eax
    2ea4:	ff 75 08             	pushl  0x8(%ebp)
    2ea7:	e8 fe fd ff ff       	call   2caa <sprintint>
    2eac:	83 c4 20             	add    $0x20,%esp
                ap++;
    2eaf:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2eb3:	e9 d2 00 00 00       	jmp    2f8a <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2eb8:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2ebc:	75 46                	jne    2f04 <sprintf+0x178>
                s = (char*)*ap;
    2ebe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2ec1:	8b 00                	mov    (%eax),%eax
    2ec3:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2ec6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2eca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ece:	75 25                	jne    2ef5 <sprintf+0x169>
                    s = "(null)";
    2ed0:	c7 45 f4 08 32 00 00 	movl   $0x3208,-0xc(%ebp)
                while(*s != 0){
    2ed7:	eb 1c                	jmp    2ef5 <sprintf+0x169>
                    dst[j++] = *s;
    2ed9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2edc:	8d 50 01             	lea    0x1(%eax),%edx
    2edf:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2ee2:	89 c2                	mov    %eax,%edx
    2ee4:	8b 45 08             	mov    0x8(%ebp),%eax
    2ee7:	01 c2                	add    %eax,%edx
    2ee9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2eec:	0f b6 00             	movzbl (%eax),%eax
    2eef:	88 02                	mov    %al,(%edx)
                    s++;
    2ef1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2ef5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2ef8:	0f b6 00             	movzbl (%eax),%eax
    2efb:	84 c0                	test   %al,%al
    2efd:	75 da                	jne    2ed9 <sprintf+0x14d>
    2eff:	e9 86 00 00 00       	jmp    2f8a <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2f04:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2f08:	75 1d                	jne    2f27 <sprintf+0x19b>
                dst[j++] = *ap;
    2f0a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2f0d:	8d 50 01             	lea    0x1(%eax),%edx
    2f10:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2f13:	89 c2                	mov    %eax,%edx
    2f15:	8b 45 08             	mov    0x8(%ebp),%eax
    2f18:	01 c2                	add    %eax,%edx
    2f1a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2f1d:	8b 00                	mov    (%eax),%eax
    2f1f:	88 02                	mov    %al,(%edx)
                ap++;
    2f21:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2f25:	eb 63                	jmp    2f8a <sprintf+0x1fe>
            } else if(c == '%'){
    2f27:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2f2b:	75 17                	jne    2f44 <sprintf+0x1b8>
                dst[j++] = c;
    2f2d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2f30:	8d 50 01             	lea    0x1(%eax),%edx
    2f33:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2f36:	89 c2                	mov    %eax,%edx
    2f38:	8b 45 08             	mov    0x8(%ebp),%eax
    2f3b:	01 d0                	add    %edx,%eax
    2f3d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2f40:	88 10                	mov    %dl,(%eax)
    2f42:	eb 46                	jmp    2f8a <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2f44:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2f48:	7e 18                	jle    2f62 <sprintf+0x1d6>
    2f4a:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2f4e:	7f 12                	jg     2f62 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2f50:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2f53:	8d 50 01             	lea    0x1(%eax),%edx
    2f56:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2f59:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2f5c:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2f60:	eb 2f                	jmp    2f91 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2f62:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2f65:	8d 50 01             	lea    0x1(%eax),%edx
    2f68:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2f6b:	89 c2                	mov    %eax,%edx
    2f6d:	8b 45 08             	mov    0x8(%ebp),%eax
    2f70:	01 d0                	add    %edx,%eax
    2f72:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2f75:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2f78:	8d 50 01             	lea    0x1(%eax),%edx
    2f7b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2f7e:	89 c2                	mov    %eax,%edx
    2f80:	8b 45 08             	mov    0x8(%ebp),%eax
    2f83:	01 d0                	add    %edx,%eax
    2f85:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2f88:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2f8a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2f91:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2f95:	8b 55 0c             	mov    0xc(%ebp),%edx
    2f98:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2f9b:	01 d0                	add    %edx,%eax
    2f9d:	0f b6 00             	movzbl (%eax),%eax
    2fa0:	84 c0                	test   %al,%al
    2fa2:	0f 85 14 fe ff ff    	jne    2dbc <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2fa8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2fab:	8d 50 01             	lea    0x1(%eax),%edx
    2fae:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2fb1:	89 c2                	mov    %eax,%edx
    2fb3:	8b 45 08             	mov    0x8(%ebp),%eax
    2fb6:	01 d0                	add    %edx,%eax
    2fb8:	c6 00 00             	movb   $0x0,(%eax)
}
    2fbb:	90                   	nop
    2fbc:	c9                   	leave  
    2fbd:	c3                   	ret    
