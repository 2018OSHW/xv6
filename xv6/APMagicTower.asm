
_APMagicTower：     文件格式 elf32-i386


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
#include "APMagicTower.h"


APoint nextpoint(APoint p,int direction)
{
      45:	55                   	push   %ebp
      46:	89 e5                	mov    %esp,%ebp
      48:	83 ec 10             	sub    $0x10,%esp
APoint output;
switch(direction)
      4b:	8b 45 14             	mov    0x14(%ebp),%eax
      4e:	83 f8 01             	cmp    $0x1,%eax
      51:	74 28                	je     7b <nextpoint+0x36>
      53:	83 f8 01             	cmp    $0x1,%eax
      56:	7f 06                	jg     5e <nextpoint+0x19>
      58:	85 c0                	test   %eax,%eax
      5a:	74 0e                	je     6a <nextpoint+0x25>
      5c:	eb 50                	jmp    ae <nextpoint+0x69>
      5e:	83 f8 02             	cmp    $0x2,%eax
      61:	74 29                	je     8c <nextpoint+0x47>
      63:	83 f8 03             	cmp    $0x3,%eax
      66:	74 35                	je     9d <nextpoint+0x58>
      68:	eb 44                	jmp    ae <nextpoint+0x69>
{
	case Up:
		output.x = p.x;
      6a:	8b 45 0c             	mov    0xc(%ebp),%eax
      6d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		output.y = p.y - 1;
      70:	8b 45 10             	mov    0x10(%ebp),%eax
      73:	83 e8 01             	sub    $0x1,%eax
      76:	89 45 fc             	mov    %eax,-0x4(%ebp)
		break;
      79:	eb 40                	jmp    bb <nextpoint+0x76>
	case Down:
		output.x = p.x;
      7b:	8b 45 0c             	mov    0xc(%ebp),%eax
      7e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		output.y = p.y + 1;
      81:	8b 45 10             	mov    0x10(%ebp),%eax
      84:	83 c0 01             	add    $0x1,%eax
      87:	89 45 fc             	mov    %eax,-0x4(%ebp)
		break;
      8a:	eb 2f                	jmp    bb <nextpoint+0x76>

	case Left:
		output.x = p.x - 1;
      8c:	8b 45 0c             	mov    0xc(%ebp),%eax
      8f:	83 e8 01             	sub    $0x1,%eax
      92:	89 45 f8             	mov    %eax,-0x8(%ebp)
		output.y = p.y;
      95:	8b 45 10             	mov    0x10(%ebp),%eax
      98:	89 45 fc             	mov    %eax,-0x4(%ebp)
		break;
      9b:	eb 1e                	jmp    bb <nextpoint+0x76>

	case Right:
		output.x = p.x + 1;
      9d:	8b 45 0c             	mov    0xc(%ebp),%eax
      a0:	83 c0 01             	add    $0x1,%eax
      a3:	89 45 f8             	mov    %eax,-0x8(%ebp)
		output.y = p.y;
      a6:	8b 45 10             	mov    0x10(%ebp),%eax
      a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
		break;
      ac:	eb 0d                	jmp    bb <nextpoint+0x76>
	default:
		output = p;
      ae:	8b 45 0c             	mov    0xc(%ebp),%eax
      b1:	8b 55 10             	mov    0x10(%ebp),%edx
      b4:	89 45 f8             	mov    %eax,-0x8(%ebp)
      b7:	89 55 fc             	mov    %edx,-0x4(%ebp)
		break;
      ba:	90                   	nop
}
return output;
      bb:	8b 4d 08             	mov    0x8(%ebp),%ecx
      be:	8b 45 f8             	mov    -0x8(%ebp),%eax
      c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
      c4:	89 01                	mov    %eax,(%ecx)
      c6:	89 51 04             	mov    %edx,0x4(%ecx)
}
      c9:	8b 45 08             	mov    0x8(%ebp),%eax
      cc:	c9                   	leave  
      cd:	c2 04 00             	ret    $0x4

000000d0 <keyDown>:


void keyDown(AHwnd hwnd,AMessage msg)
{
      d0:	55                   	push   %ebp
      d1:	89 e5                	mov    %esp,%ebp
      d3:	53                   	push   %ebx
      d4:	83 ec 34             	sub    $0x34,%esp
APoint temp;
switch(msg.param)
      d7:	8b 45 10             	mov    0x10(%ebp),%eax
      da:	83 f8 05             	cmp    $0x5,%eax
      dd:	0f 87 9d 00 00 00    	ja     180 <keyDown+0xb0>
      e3:	8b 04 85 8c 37 00 00 	mov    0x378c(,%eax,4),%eax
      ea:	ff e0                	jmp    *%eax
{
	case VK_UP:
		temp = nextpoint(position,Up);
      ec:	8d 45 f0             	lea    -0x10(%ebp),%eax
      ef:	6a 00                	push   $0x0
      f1:	ff 35 38 7f 00 00    	pushl  0x7f38
      f7:	ff 35 34 7f 00 00    	pushl  0x7f34
      fd:	50                   	push   %eax
      fe:	e8 42 ff ff ff       	call   45 <nextpoint>
     103:	83 c4 0c             	add    $0xc,%esp
		break;
     106:	eb 79                	jmp    181 <keyDown+0xb1>
	case VK_DOWN:

		temp = nextpoint(position,Down);
     108:	8d 45 d0             	lea    -0x30(%ebp),%eax
     10b:	6a 01                	push   $0x1
     10d:	ff 35 38 7f 00 00    	pushl  0x7f38
     113:	ff 35 34 7f 00 00    	pushl  0x7f34
     119:	50                   	push   %eax
     11a:	e8 26 ff ff ff       	call   45 <nextpoint>
     11f:	83 c4 0c             	add    $0xc,%esp
     122:	8b 45 d0             	mov    -0x30(%ebp),%eax
     125:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     128:	89 45 f0             	mov    %eax,-0x10(%ebp)
     12b:	89 55 f4             	mov    %edx,-0xc(%ebp)
		break;
     12e:	eb 51                	jmp    181 <keyDown+0xb1>

	case VK_LEFT:

		temp = nextpoint(position,Left);
     130:	8d 45 d0             	lea    -0x30(%ebp),%eax
     133:	6a 02                	push   $0x2
     135:	ff 35 38 7f 00 00    	pushl  0x7f38
     13b:	ff 35 34 7f 00 00    	pushl  0x7f34
     141:	50                   	push   %eax
     142:	e8 fe fe ff ff       	call   45 <nextpoint>
     147:	83 c4 0c             	add    $0xc,%esp
     14a:	8b 45 d0             	mov    -0x30(%ebp),%eax
     14d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     150:	89 45 f0             	mov    %eax,-0x10(%ebp)
     153:	89 55 f4             	mov    %edx,-0xc(%ebp)
		break;
     156:	eb 29                	jmp    181 <keyDown+0xb1>

	case VK_RIGHT:

		temp = nextpoint(position,Right);
     158:	8d 45 d0             	lea    -0x30(%ebp),%eax
     15b:	6a 03                	push   $0x3
     15d:	ff 35 38 7f 00 00    	pushl  0x7f38
     163:	ff 35 34 7f 00 00    	pushl  0x7f34
     169:	50                   	push   %eax
     16a:	e8 d6 fe ff ff       	call   45 <nextpoint>
     16f:	83 c4 0c             	add    $0xc,%esp
     172:	8b 45 d0             	mov    -0x30(%ebp),%eax
     175:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     178:	89 45 f0             	mov    %eax,-0x10(%ebp)
     17b:	89 55 f4             	mov    %edx,-0xc(%ebp)
		break;
     17e:	eb 01                	jmp    181 <keyDown+0xb1>
	case VK_ESC:

		return ;
	default:
		break;
     180:	90                   	nop
}
my_tower[floor][position.x][position.y] = Background;
     181:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     187:	8b 15 34 7f 00 00    	mov    0x7f34,%edx
     18d:	8b 0d 38 7f 00 00    	mov    0x7f38,%ecx
     193:	89 d0                	mov    %edx,%eax
     195:	c1 e0 02             	shl    $0x2,%eax
     198:	01 d0                	add    %edx,%eax
     19a:	01 c0                	add    %eax,%eax
     19c:	6b d3 64             	imul   $0x64,%ebx,%edx
     19f:	01 d0                	add    %edx,%eax
     1a1:	01 c8                	add    %ecx,%eax
     1a3:	c7 04 85 40 80 00 00 	movl   $0x0,0x8040(,%eax,4)
     1aa:	00 00 00 00 
AMessage ms;
ms.type = MSG_PAINT;
     1ae:	c7 45 e0 03 00 00 00 	movl   $0x3,-0x20(%ebp)
ms.param = 1;
     1b5:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
position_old = position;
     1bc:	a1 34 7f 00 00       	mov    0x7f34,%eax
     1c1:	8b 15 38 7f 00 00    	mov    0x7f38,%edx
     1c7:	a3 20 7f 00 00       	mov    %eax,0x7f20
     1cc:	89 15 24 7f 00 00    	mov    %edx,0x7f24
switch(my_tower[floor][temp.x][temp.y])
     1d2:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     1d8:	8b 55 f0             	mov    -0x10(%ebp),%edx
     1db:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     1de:	89 d0                	mov    %edx,%eax
     1e0:	c1 e0 02             	shl    $0x2,%eax
     1e3:	01 d0                	add    %edx,%eax
     1e5:	01 c0                	add    %eax,%eax
     1e7:	6b d3 64             	imul   $0x64,%ebx,%edx
     1ea:	01 d0                	add    %edx,%eax
     1ec:	01 c8                	add    %ecx,%eax
     1ee:	8b 04 85 40 80 00 00 	mov    0x8040(,%eax,4),%eax
     1f5:	83 f8 11             	cmp    $0x11,%eax
     1f8:	0f 87 d4 03 00 00    	ja     5d2 <keyDown+0x502>
     1fe:	8b 04 85 a4 37 00 00 	mov    0x37a4(,%eax,4),%eax
     205:	ff e0                	jmp    *%eax
{
	case Background:

		position = temp;
     207:	8b 45 f0             	mov    -0x10(%ebp),%eax
     20a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     20d:	a3 34 7f 00 00       	mov    %eax,0x7f34
     212:	89 15 38 7f 00 00    	mov    %edx,0x7f38
		break;
     218:	e9 b9 03 00 00       	jmp    5d6 <keyDown+0x506>
	case Wall:
		break;
	case Monster1:
	case Monster2:
	case Monster3:
		position = temp;
     21d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     220:	8b 55 f4             	mov    -0xc(%ebp),%edx
     223:	a3 34 7f 00 00       	mov    %eax,0x7f34
     228:	89 15 38 7f 00 00    	mov    %edx,0x7f38
		if(!fight())
     22e:	e8 bc 08 00 00       	call   aef <fight>
     233:	84 c0                	test   %al,%al
     235:	0f 85 9a 03 00 00    	jne    5d5 <keyDown+0x505>
		{
		printf(1,"Dead");
     23b:	83 ec 08             	sub    $0x8,%esp
     23e:	68 60 37 00 00       	push   $0x3760
     243:	6a 01                	push   $0x1
     245:	e8 e2 13 00 00       	call   162c <printf>
     24a:	83 c4 10             	add    $0x10,%esp
		}
		break;
     24d:	e9 83 03 00 00       	jmp    5d5 <keyDown+0x505>
	case YellowDoor:
		if (my_key[0] > 0)
     252:	a1 f0 84 00 00       	mov    0x84f0,%eax
     257:	85 c0                	test   %eax,%eax
     259:	7e 4a                	jle    2a5 <keyDown+0x1d5>
		{
		my_key[0]--;
     25b:	a1 f0 84 00 00       	mov    0x84f0,%eax
     260:	83 e8 01             	sub    $0x1,%eax
     263:	a3 f0 84 00 00       	mov    %eax,0x84f0
		position = temp;
     268:	8b 45 f0             	mov    -0x10(%ebp),%eax
     26b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     26e:	a3 34 7f 00 00       	mov    %eax,0x7f34
     273:	89 15 38 7f 00 00    	mov    %edx,0x7f38
		my_tower[floor][temp.x][temp.y] = Background;
     279:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     27f:	8b 55 f0             	mov    -0x10(%ebp),%edx
     282:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     285:	89 d0                	mov    %edx,%eax
     287:	c1 e0 02             	shl    $0x2,%eax
     28a:	01 d0                	add    %edx,%eax
     28c:	01 c0                	add    %eax,%eax
     28e:	6b d3 64             	imul   $0x64,%ebx,%edx
     291:	01 d0                	add    %edx,%eax
     293:	01 c8                	add    %ecx,%eax
     295:	c7 04 85 40 80 00 00 	movl   $0x0,0x8040(,%eax,4)
     29c:	00 00 00 00 
		}
		else
		{
		printf(1,"No Yellow Key");
		}
		break;
     2a0:	e9 31 03 00 00       	jmp    5d6 <keyDown+0x506>
		position = temp;
		my_tower[floor][temp.x][temp.y] = Background;
		}
		else
		{
		printf(1,"No Yellow Key");
     2a5:	83 ec 08             	sub    $0x8,%esp
     2a8:	68 65 37 00 00       	push   $0x3765
     2ad:	6a 01                	push   $0x1
     2af:	e8 78 13 00 00       	call   162c <printf>
     2b4:	83 c4 10             	add    $0x10,%esp
		}
		break;
     2b7:	e9 1a 03 00 00       	jmp    5d6 <keyDown+0x506>
	case BlueDoor:
		if (my_key[1] > 0)
     2bc:	a1 f4 84 00 00       	mov    0x84f4,%eax
     2c1:	85 c0                	test   %eax,%eax
     2c3:	7e 4a                	jle    30f <keyDown+0x23f>
		{
		my_key[1]--;
     2c5:	a1 f4 84 00 00       	mov    0x84f4,%eax
     2ca:	83 e8 01             	sub    $0x1,%eax
     2cd:	a3 f4 84 00 00       	mov    %eax,0x84f4
		position = temp;
     2d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     2d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     2d8:	a3 34 7f 00 00       	mov    %eax,0x7f34
     2dd:	89 15 38 7f 00 00    	mov    %edx,0x7f38
		my_tower[floor][temp.x][temp.y] = Background;
     2e3:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     2e9:	8b 55 f0             	mov    -0x10(%ebp),%edx
     2ec:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     2ef:	89 d0                	mov    %edx,%eax
     2f1:	c1 e0 02             	shl    $0x2,%eax
     2f4:	01 d0                	add    %edx,%eax
     2f6:	01 c0                	add    %eax,%eax
     2f8:	6b d3 64             	imul   $0x64,%ebx,%edx
     2fb:	01 d0                	add    %edx,%eax
     2fd:	01 c8                	add    %ecx,%eax
     2ff:	c7 04 85 40 80 00 00 	movl   $0x0,0x8040(,%eax,4)
     306:	00 00 00 00 
		}
		else
		{
		printf(1,"No Blue Key");
		}
		break;
     30a:	e9 c7 02 00 00       	jmp    5d6 <keyDown+0x506>
		position = temp;
		my_tower[floor][temp.x][temp.y] = Background;
		}
		else
		{
		printf(1,"No Blue Key");
     30f:	83 ec 08             	sub    $0x8,%esp
     312:	68 73 37 00 00       	push   $0x3773
     317:	6a 01                	push   $0x1
     319:	e8 0e 13 00 00       	call   162c <printf>
     31e:	83 c4 10             	add    $0x10,%esp
		}
		break;
     321:	e9 b0 02 00 00       	jmp    5d6 <keyDown+0x506>
	case RedDoor:
		if (my_key[1] > 0)
     326:	a1 f4 84 00 00       	mov    0x84f4,%eax
     32b:	85 c0                	test   %eax,%eax
     32d:	7e 4a                	jle    379 <keyDown+0x2a9>
		{
		my_key[1]--;
     32f:	a1 f4 84 00 00       	mov    0x84f4,%eax
     334:	83 e8 01             	sub    $0x1,%eax
     337:	a3 f4 84 00 00       	mov    %eax,0x84f4
		position = temp;
     33c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     33f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     342:	a3 34 7f 00 00       	mov    %eax,0x7f34
     347:	89 15 38 7f 00 00    	mov    %edx,0x7f38
		my_tower[floor][temp.x][temp.y] = Background;
     34d:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     353:	8b 55 f0             	mov    -0x10(%ebp),%edx
     356:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     359:	89 d0                	mov    %edx,%eax
     35b:	c1 e0 02             	shl    $0x2,%eax
     35e:	01 d0                	add    %edx,%eax
     360:	01 c0                	add    %eax,%eax
     362:	6b d3 64             	imul   $0x64,%ebx,%edx
     365:	01 d0                	add    %edx,%eax
     367:	01 c8                	add    %ecx,%eax
     369:	c7 04 85 40 80 00 00 	movl   $0x0,0x8040(,%eax,4)
     370:	00 00 00 00 
		}
		else
		{
		printf(1,"No red Key");
		}
		break;
     374:	e9 5d 02 00 00       	jmp    5d6 <keyDown+0x506>
		position = temp;
		my_tower[floor][temp.x][temp.y] = Background;
		}
		else
		{
		printf(1,"No red Key");
     379:	83 ec 08             	sub    $0x8,%esp
     37c:	68 7f 37 00 00       	push   $0x377f
     381:	6a 01                	push   $0x1
     383:	e8 a4 12 00 00       	call   162c <printf>
     388:	83 c4 10             	add    $0x10,%esp
		}
		break;
     38b:	e9 46 02 00 00       	jmp    5d6 <keyDown+0x506>
	case UpStair:
		floor++;
     390:	a1 04 7f 00 00       	mov    0x7f04,%eax
     395:	83 c0 01             	add    $0x1,%eax
     398:	a3 04 7f 00 00       	mov    %eax,0x7f04
		draw(hwnd);
     39d:	83 ec 0c             	sub    $0xc,%esp
     3a0:	ff 75 08             	pushl  0x8(%ebp)
     3a3:	e8 7f 08 00 00       	call   c27 <draw>
     3a8:	83 c4 10             	add    $0x10,%esp
		break;
     3ab:	e9 26 02 00 00       	jmp    5d6 <keyDown+0x506>
	case DownStair:
		floor--;
     3b0:	a1 04 7f 00 00       	mov    0x7f04,%eax
     3b5:	83 e8 01             	sub    $0x1,%eax
     3b8:	a3 04 7f 00 00       	mov    %eax,0x7f04
		draw(hwnd);
     3bd:	83 ec 0c             	sub    $0xc,%esp
     3c0:	ff 75 08             	pushl  0x8(%ebp)
     3c3:	e8 5f 08 00 00       	call   c27 <draw>
     3c8:	83 c4 10             	add    $0x10,%esp
		break;
     3cb:	e9 06 02 00 00       	jmp    5d6 <keyDown+0x506>
	case YellowKey:
		my_key[0]++;
     3d0:	a1 f0 84 00 00       	mov    0x84f0,%eax
     3d5:	83 c0 01             	add    $0x1,%eax
     3d8:	a3 f0 84 00 00       	mov    %eax,0x84f0
		my_tower[floor][temp.x][temp.y] = Background;
     3dd:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     3e3:	8b 55 f0             	mov    -0x10(%ebp),%edx
     3e6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3e9:	89 d0                	mov    %edx,%eax
     3eb:	c1 e0 02             	shl    $0x2,%eax
     3ee:	01 d0                	add    %edx,%eax
     3f0:	01 c0                	add    %eax,%eax
     3f2:	6b d3 64             	imul   $0x64,%ebx,%edx
     3f5:	01 d0                	add    %edx,%eax
     3f7:	01 c8                	add    %ecx,%eax
     3f9:	c7 04 85 40 80 00 00 	movl   $0x0,0x8040(,%eax,4)
     400:	00 00 00 00 
		position = temp;
     404:	8b 45 f0             	mov    -0x10(%ebp),%eax
     407:	8b 55 f4             	mov    -0xc(%ebp),%edx
     40a:	a3 34 7f 00 00       	mov    %eax,0x7f34
     40f:	89 15 38 7f 00 00    	mov    %edx,0x7f38
		break;
     415:	e9 bc 01 00 00       	jmp    5d6 <keyDown+0x506>
	case BlueKey:
		my_key[1]++;
     41a:	a1 f4 84 00 00       	mov    0x84f4,%eax
     41f:	83 c0 01             	add    $0x1,%eax
     422:	a3 f4 84 00 00       	mov    %eax,0x84f4
		my_tower[floor][temp.x][temp.y] = Background;
     427:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     42d:	8b 55 f0             	mov    -0x10(%ebp),%edx
     430:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     433:	89 d0                	mov    %edx,%eax
     435:	c1 e0 02             	shl    $0x2,%eax
     438:	01 d0                	add    %edx,%eax
     43a:	01 c0                	add    %eax,%eax
     43c:	6b d3 64             	imul   $0x64,%ebx,%edx
     43f:	01 d0                	add    %edx,%eax
     441:	01 c8                	add    %ecx,%eax
     443:	c7 04 85 40 80 00 00 	movl   $0x0,0x8040(,%eax,4)
     44a:	00 00 00 00 
		position = temp;
     44e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     451:	8b 55 f4             	mov    -0xc(%ebp),%edx
     454:	a3 34 7f 00 00       	mov    %eax,0x7f34
     459:	89 15 38 7f 00 00    	mov    %edx,0x7f38
		break;
     45f:	e9 72 01 00 00       	jmp    5d6 <keyDown+0x506>
	case RedKey:
		my_key[2]++;
     464:	a1 f8 84 00 00       	mov    0x84f8,%eax
     469:	83 c0 01             	add    $0x1,%eax
     46c:	a3 f8 84 00 00       	mov    %eax,0x84f8
		my_tower[floor][temp.x][temp.y] = Background;
     471:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     477:	8b 55 f0             	mov    -0x10(%ebp),%edx
     47a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     47d:	89 d0                	mov    %edx,%eax
     47f:	c1 e0 02             	shl    $0x2,%eax
     482:	01 d0                	add    %edx,%eax
     484:	01 c0                	add    %eax,%eax
     486:	6b d3 64             	imul   $0x64,%ebx,%edx
     489:	01 d0                	add    %edx,%eax
     48b:	01 c8                	add    %ecx,%eax
     48d:	c7 04 85 40 80 00 00 	movl   $0x0,0x8040(,%eax,4)
     494:	00 00 00 00 
		position = temp;
     498:	8b 45 f0             	mov    -0x10(%ebp),%eax
     49b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     49e:	a3 34 7f 00 00       	mov    %eax,0x7f34
     4a3:	89 15 38 7f 00 00    	mov    %edx,0x7f38
		break;
     4a9:	e9 28 01 00 00       	jmp    5d6 <keyDown+0x506>
	case SBlood:
		hp += 100;
     4ae:	a1 30 80 00 00       	mov    0x8030,%eax
     4b3:	83 c0 64             	add    $0x64,%eax
     4b6:	a3 30 80 00 00       	mov    %eax,0x8030
		my_tower[floor][temp.x][temp.y] = Background;
     4bb:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     4c1:	8b 55 f0             	mov    -0x10(%ebp),%edx
     4c4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     4c7:	89 d0                	mov    %edx,%eax
     4c9:	c1 e0 02             	shl    $0x2,%eax
     4cc:	01 d0                	add    %edx,%eax
     4ce:	01 c0                	add    %eax,%eax
     4d0:	6b d3 64             	imul   $0x64,%ebx,%edx
     4d3:	01 d0                	add    %edx,%eax
     4d5:	01 c8                	add    %ecx,%eax
     4d7:	c7 04 85 40 80 00 00 	movl   $0x0,0x8040(,%eax,4)
     4de:	00 00 00 00 
		position = temp;
     4e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     4e8:	a3 34 7f 00 00       	mov    %eax,0x7f34
     4ed:	89 15 38 7f 00 00    	mov    %edx,0x7f38
		break;
     4f3:	e9 de 00 00 00       	jmp    5d6 <keyDown+0x506>
	case LBlood:
		hp += 500;
     4f8:	a1 30 80 00 00       	mov    0x8030,%eax
     4fd:	05 f4 01 00 00       	add    $0x1f4,%eax
     502:	a3 30 80 00 00       	mov    %eax,0x8030
		my_tower[floor][temp.x][temp.y] = Background;
     507:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     50d:	8b 55 f0             	mov    -0x10(%ebp),%edx
     510:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     513:	89 d0                	mov    %edx,%eax
     515:	c1 e0 02             	shl    $0x2,%eax
     518:	01 d0                	add    %edx,%eax
     51a:	01 c0                	add    %eax,%eax
     51c:	6b d3 64             	imul   $0x64,%ebx,%edx
     51f:	01 d0                	add    %edx,%eax
     521:	01 c8                	add    %ecx,%eax
     523:	c7 04 85 40 80 00 00 	movl   $0x0,0x8040(,%eax,4)
     52a:	00 00 00 00 
		position = temp;
     52e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     531:	8b 55 f4             	mov    -0xc(%ebp),%edx
     534:	a3 34 7f 00 00       	mov    %eax,0x7f34
     539:	89 15 38 7f 00 00    	mov    %edx,0x7f38
		break;
     53f:	e9 92 00 00 00       	jmp    5d6 <keyDown+0x506>
	case Attack:
		atk += 1;
     544:	a1 ec 7e 00 00       	mov    0x7eec,%eax
     549:	83 c0 01             	add    $0x1,%eax
     54c:	a3 ec 7e 00 00       	mov    %eax,0x7eec
		my_tower[floor][temp.x][temp.y] = Background;
     551:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     557:	8b 55 f0             	mov    -0x10(%ebp),%edx
     55a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     55d:	89 d0                	mov    %edx,%eax
     55f:	c1 e0 02             	shl    $0x2,%eax
     562:	01 d0                	add    %edx,%eax
     564:	01 c0                	add    %eax,%eax
     566:	6b d3 64             	imul   $0x64,%ebx,%edx
     569:	01 d0                	add    %edx,%eax
     56b:	01 c8                	add    %ecx,%eax
     56d:	c7 04 85 40 80 00 00 	movl   $0x0,0x8040(,%eax,4)
     574:	00 00 00 00 
		position = temp;
     578:	8b 45 f0             	mov    -0x10(%ebp),%eax
     57b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     57e:	a3 34 7f 00 00       	mov    %eax,0x7f34
     583:	89 15 38 7f 00 00    	mov    %edx,0x7f38
		break;
     589:	eb 4b                	jmp    5d6 <keyDown+0x506>
	case Defend:
		def += 1;
     58b:	a1 f0 7e 00 00       	mov    0x7ef0,%eax
     590:	83 c0 01             	add    $0x1,%eax
     593:	a3 f0 7e 00 00       	mov    %eax,0x7ef0
		my_tower[floor][temp.x][temp.y] = Background;
     598:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     59e:	8b 55 f0             	mov    -0x10(%ebp),%edx
     5a1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     5a4:	89 d0                	mov    %edx,%eax
     5a6:	c1 e0 02             	shl    $0x2,%eax
     5a9:	01 d0                	add    %edx,%eax
     5ab:	01 c0                	add    %eax,%eax
     5ad:	6b d3 64             	imul   $0x64,%ebx,%edx
     5b0:	01 d0                	add    %edx,%eax
     5b2:	01 c8                	add    %ecx,%eax
     5b4:	c7 04 85 40 80 00 00 	movl   $0x0,0x8040(,%eax,4)
     5bb:	00 00 00 00 
		position = temp;
     5bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
     5c5:	a3 34 7f 00 00       	mov    %eax,0x7f34
     5ca:	89 15 38 7f 00 00    	mov    %edx,0x7f38
		break;	
     5d0:	eb 04                	jmp    5d6 <keyDown+0x506>
	default:
		break;
     5d2:	90                   	nop
     5d3:	eb 01                	jmp    5d6 <keyDown+0x506>
		position = temp;
		if(!fight())
		{
		printf(1,"Dead");
		}
		break;
     5d5:	90                   	nop
		position = temp;
		break;	
	default:
		break;
}
my_tower[floor][position.x][position.y] = Valiant;
     5d6:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     5dc:	8b 15 34 7f 00 00    	mov    0x7f34,%edx
     5e2:	8b 0d 38 7f 00 00    	mov    0x7f38,%ecx
     5e8:	89 d0                	mov    %edx,%eax
     5ea:	c1 e0 02             	shl    $0x2,%eax
     5ed:	01 d0                	add    %edx,%eax
     5ef:	01 c0                	add    %eax,%eax
     5f1:	6b d3 64             	imul   $0x64,%ebx,%edx
     5f4:	01 d0                	add    %edx,%eax
     5f6:	01 c8                	add    %ecx,%eax
     5f8:	c7 04 85 40 80 00 00 	movl   $0x5,0x8040(,%eax,4)
     5ff:	05 00 00 00 
APSendMessage(hwnd,ms);
     603:	83 ec 0c             	sub    $0xc,%esp
     606:	ff 75 ec             	pushl  -0x14(%ebp)
     609:	ff 75 e8             	pushl  -0x18(%ebp)
     60c:	ff 75 e4             	pushl  -0x1c(%ebp)
     60f:	ff 75 e0             	pushl  -0x20(%ebp)
     612:	ff 75 08             	pushl  0x8(%ebp)
     615:	e8 bf 20 00 00       	call   26d9 <APSendMessage>
     61a:	83 c4 20             	add    $0x20,%esp
     61d:	eb 01                	jmp    620 <keyDown+0x550>

		temp = nextpoint(position,Right);
		break;
	case VK_ESC:

		return ;
     61f:	90                   	nop
	default:
		break;
}
my_tower[floor][position.x][position.y] = Valiant;
APSendMessage(hwnd,ms);
}
     620:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     623:	c9                   	leave  
     624:	c3                   	ret    

00000625 <TowerInit>:

void TowerInit()
{
     625:	55                   	push   %ebp
     626:	89 e5                	mov    %esp,%ebp
     628:	83 ec 10             	sub    $0x10,%esp
for (int i = 0;i < BLOCK_NUM_X;i++)
     62b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     632:	e9 aa 00 00 00       	jmp    6e1 <TowerInit+0xbc>
{
for (int j = 0;j < BLOCK_NUM_Y;j++)
     637:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
     63e:	e9 90 00 00 00       	jmp    6d3 <TowerInit+0xae>
{
my_tower[0][i][j] =my_tower[1][i][j] =my_tower[2][i][j] = Background;
     643:	8b 55 fc             	mov    -0x4(%ebp),%edx
     646:	89 d0                	mov    %edx,%eax
     648:	c1 e0 02             	shl    $0x2,%eax
     64b:	01 d0                	add    %edx,%eax
     64d:	01 c0                	add    %eax,%eax
     64f:	8b 55 f8             	mov    -0x8(%ebp),%edx
     652:	01 d0                	add    %edx,%eax
     654:	05 c8 00 00 00       	add    $0xc8,%eax
     659:	c7 04 85 40 80 00 00 	movl   $0x0,0x8040(,%eax,4)
     660:	00 00 00 00 
     664:	8b 55 fc             	mov    -0x4(%ebp),%edx
     667:	89 d0                	mov    %edx,%eax
     669:	c1 e0 02             	shl    $0x2,%eax
     66c:	01 d0                	add    %edx,%eax
     66e:	01 c0                	add    %eax,%eax
     670:	8b 55 f8             	mov    -0x8(%ebp),%edx
     673:	01 d0                	add    %edx,%eax
     675:	05 c8 00 00 00       	add    $0xc8,%eax
     67a:	8b 0c 85 40 80 00 00 	mov    0x8040(,%eax,4),%ecx
     681:	8b 55 fc             	mov    -0x4(%ebp),%edx
     684:	89 d0                	mov    %edx,%eax
     686:	c1 e0 02             	shl    $0x2,%eax
     689:	01 d0                	add    %edx,%eax
     68b:	01 c0                	add    %eax,%eax
     68d:	8b 55 f8             	mov    -0x8(%ebp),%edx
     690:	01 d0                	add    %edx,%eax
     692:	83 c0 64             	add    $0x64,%eax
     695:	89 0c 85 40 80 00 00 	mov    %ecx,0x8040(,%eax,4)
     69c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     69f:	89 d0                	mov    %edx,%eax
     6a1:	c1 e0 02             	shl    $0x2,%eax
     6a4:	01 d0                	add    %edx,%eax
     6a6:	01 c0                	add    %eax,%eax
     6a8:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6ab:	01 d0                	add    %edx,%eax
     6ad:	83 c0 64             	add    $0x64,%eax
     6b0:	8b 0c 85 40 80 00 00 	mov    0x8040(,%eax,4),%ecx
     6b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
     6ba:	89 d0                	mov    %edx,%eax
     6bc:	c1 e0 02             	shl    $0x2,%eax
     6bf:	01 d0                	add    %edx,%eax
     6c1:	01 c0                	add    %eax,%eax
     6c3:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6c6:	01 d0                	add    %edx,%eax
     6c8:	89 0c 85 40 80 00 00 	mov    %ecx,0x8040(,%eax,4)

void TowerInit()
{
for (int i = 0;i < BLOCK_NUM_X;i++)
{
for (int j = 0;j < BLOCK_NUM_Y;j++)
     6cf:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     6d3:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
     6d7:	0f 8e 66 ff ff ff    	jle    643 <TowerInit+0x1e>
APSendMessage(hwnd,ms);
}

void TowerInit()
{
for (int i = 0;i < BLOCK_NUM_X;i++)
     6dd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     6e1:	83 7d fc 09          	cmpl   $0x9,-0x4(%ebp)
     6e5:	0f 8e 4c ff ff ff    	jle    637 <TowerInit+0x12>
for (int j = 0;j < BLOCK_NUM_Y;j++)
{
my_tower[0][i][j] =my_tower[1][i][j] =my_tower[2][i][j] = Background;
}
}
my_tower[0][0][1] = BlueKey; 
     6eb:	c7 05 44 80 00 00 0c 	movl   $0xc,0x8044
     6f2:	00 00 00 
my_tower[0][1][1] = Monster1; 
     6f5:	c7 05 6c 80 00 00 02 	movl   $0x2,0x806c
     6fc:	00 00 00 
my_tower[0][2][2] = UpStair;
     6ff:	c7 05 98 80 00 00 09 	movl   $0x9,0x8098
     706:	00 00 00 
my_tower[1][2][2] = DownStair;
     709:	c7 05 28 82 00 00 0a 	movl   $0xa,0x8228
     710:	00 00 00 
//init my_tower


}//init the tower
     713:	90                   	nop
     714:	c9                   	leave  
     715:	c3                   	ret    

00000716 <init>:

void init(AHwnd hwnd)
{
     716:	55                   	push   %ebp
     717:	89 e5                	mov    %esp,%ebp
     719:	53                   	push   %ebx
     71a:	83 ec 24             	sub    $0x24,%esp

	TowerInit();
     71d:	e8 03 ff ff ff       	call   625 <TowerInit>

	hp = START_HP;
     722:	c7 05 30 80 00 00 f4 	movl   $0x1f4,0x8030
     729:	01 00 00 
	atk = START_ATK;
     72c:	c7 05 ec 7e 00 00 0a 	movl   $0xa,0x7eec
     733:	00 00 00 
	def = START_DEF;
     736:	c7 05 f0 7e 00 00 0a 	movl   $0xa,0x7ef0
     73d:	00 00 00 
	//init the Viliant

	floor = 0;
     740:	c7 05 04 7f 00 00 00 	movl   $0x0,0x7f04
     747:	00 00 00 
	position.x = position.y = 0;
     74a:	c7 05 38 7f 00 00 00 	movl   $0x0,0x7f38
     751:	00 00 00 
     754:	a1 38 7f 00 00       	mov    0x7f38,%eax
     759:	a3 34 7f 00 00       	mov    %eax,0x7f34
	my_tower[floor][position.x][position.y] = Valiant;
     75e:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     764:	8b 15 34 7f 00 00    	mov    0x7f34,%edx
     76a:	8b 0d 38 7f 00 00    	mov    0x7f38,%ecx
     770:	89 d0                	mov    %edx,%eax
     772:	c1 e0 02             	shl    $0x2,%eax
     775:	01 d0                	add    %edx,%eax
     777:	01 c0                	add    %eax,%eax
     779:	6b d3 64             	imul   $0x64,%ebx,%edx
     77c:	01 d0                	add    %edx,%eax
     77e:	01 c8                	add    %ecx,%eax
     780:	c7 04 85 40 80 00 00 	movl   $0x5,0x8040(,%eax,4)
     787:	05 00 00 00 
	my_key[0] = 3;
     78b:	c7 05 f0 84 00 00 03 	movl   $0x3,0x84f0
     792:	00 00 00 
	my_key[1] = my_key[2] = 0;
     795:	c7 05 f8 84 00 00 00 	movl   $0x0,0x84f8
     79c:	00 00 00 
     79f:	a1 f8 84 00 00       	mov    0x84f8,%eax
     7a4:	a3 f4 84 00 00       	mov    %eax,0x84f4
 background = APLoadBitmap ("background.bmp");
     7a9:	8d 45 d8             	lea    -0x28(%ebp),%eax
     7ac:	83 ec 08             	sub    $0x8,%esp
     7af:	68 ec 37 00 00       	push   $0x37ec
     7b4:	50                   	push   %eax
     7b5:	e8 f8 12 00 00       	call   1ab2 <APLoadBitmap>
     7ba:	83 c4 0c             	add    $0xc,%esp
     7bd:	8b 45 d8             	mov    -0x28(%ebp),%eax
     7c0:	a3 14 7f 00 00       	mov    %eax,0x7f14
     7c5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     7c8:	a3 18 7f 00 00       	mov    %eax,0x7f18
     7cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7d0:	a3 1c 7f 00 00       	mov    %eax,0x7f1c
 wall = APLoadBitmap ("wall.bmp");
     7d5:	8d 45 d8             	lea    -0x28(%ebp),%eax
     7d8:	83 ec 08             	sub    $0x8,%esp
     7db:	68 fb 37 00 00       	push   $0x37fb
     7e0:	50                   	push   %eax
     7e1:	e8 cc 12 00 00       	call   1ab2 <APLoadBitmap>
     7e6:	83 c4 0c             	add    $0xc,%esp
     7e9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     7ec:	a3 18 80 00 00       	mov    %eax,0x8018
     7f1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     7f4:	a3 1c 80 00 00       	mov    %eax,0x801c
     7f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7fc:	a3 20 80 00 00       	mov    %eax,0x8020
 monster1 = APLoadBitmap ("monster1.bmp");
     801:	8d 45 d8             	lea    -0x28(%ebp),%eax
     804:	83 ec 08             	sub    $0x8,%esp
     807:	68 04 38 00 00       	push   $0x3804
     80c:	50                   	push   %eax
     80d:	e8 a0 12 00 00       	call   1ab2 <APLoadBitmap>
     812:	83 c4 0c             	add    $0xc,%esp
     815:	8b 45 d8             	mov    -0x28(%ebp),%eax
     818:	a3 24 80 00 00       	mov    %eax,0x8024
     81d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     820:	a3 28 80 00 00       	mov    %eax,0x8028
     825:	8b 45 e0             	mov    -0x20(%ebp),%eax
     828:	a3 2c 80 00 00       	mov    %eax,0x802c
 monster2 = APLoadBitmap ("monster2.bmp");
     82d:	8d 45 d8             	lea    -0x28(%ebp),%eax
     830:	83 ec 08             	sub    $0x8,%esp
     833:	68 11 38 00 00       	push   $0x3811
     838:	50                   	push   %eax
     839:	e8 74 12 00 00       	call   1ab2 <APLoadBitmap>
     83e:	83 c4 0c             	add    $0xc,%esp
     841:	8b 45 d8             	mov    -0x28(%ebp),%eax
     844:	a3 80 7f 00 00       	mov    %eax,0x7f80
     849:	8b 45 dc             	mov    -0x24(%ebp),%eax
     84c:	a3 84 7f 00 00       	mov    %eax,0x7f84
     851:	8b 45 e0             	mov    -0x20(%ebp),%eax
     854:	a3 88 7f 00 00       	mov    %eax,0x7f88
 monster3 = APLoadBitmap ("monster3.bmp");
     859:	8d 45 d8             	lea    -0x28(%ebp),%eax
     85c:	83 ec 08             	sub    $0x8,%esp
     85f:	68 1e 38 00 00       	push   $0x381e
     864:	50                   	push   %eax
     865:	e8 48 12 00 00       	call   1ab2 <APLoadBitmap>
     86a:	83 c4 0c             	add    $0xc,%esp
     86d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     870:	a3 b8 7f 00 00       	mov    %eax,0x7fb8
     875:	8b 45 dc             	mov    -0x24(%ebp),%eax
     878:	a3 bc 7f 00 00       	mov    %eax,0x7fbc
     87d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     880:	a3 c0 7f 00 00       	mov    %eax,0x7fc0
 valiant = APLoadBitmap ("valiant.bmp");
     885:	8d 45 d8             	lea    -0x28(%ebp),%eax
     888:	83 ec 08             	sub    $0x8,%esp
     88b:	68 2b 38 00 00       	push   $0x382b
     890:	50                   	push   %eax
     891:	e8 1c 12 00 00       	call   1ab2 <APLoadBitmap>
     896:	83 c4 0c             	add    $0xc,%esp
     899:	8b 45 d8             	mov    -0x28(%ebp),%eax
     89c:	a3 00 85 00 00       	mov    %eax,0x8500
     8a1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     8a4:	a3 04 85 00 00       	mov    %eax,0x8504
     8a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     8ac:	a3 08 85 00 00       	mov    %eax,0x8508
 yellowdoor = APLoadBitmap ("yellowdoor.bmp");
     8b1:	8d 45 d8             	lea    -0x28(%ebp),%eax
     8b4:	83 ec 08             	sub    $0x8,%esp
     8b7:	68 37 38 00 00       	push   $0x3837
     8bc:	50                   	push   %eax
     8bd:	e8 f0 11 00 00       	call   1ab2 <APLoadBitmap>
     8c2:	83 c4 0c             	add    $0xc,%esp
     8c5:	8b 45 d8             	mov    -0x28(%ebp),%eax
     8c8:	a3 48 7f 00 00       	mov    %eax,0x7f48
     8cd:	8b 45 dc             	mov    -0x24(%ebp),%eax
     8d0:	a3 4c 7f 00 00       	mov    %eax,0x7f4c
     8d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
     8d8:	a3 50 7f 00 00       	mov    %eax,0x7f50
 bluedoor = APLoadBitmap ("bluedoor.bmp");
     8dd:	8d 45 d8             	lea    -0x28(%ebp),%eax
     8e0:	83 ec 08             	sub    $0x8,%esp
     8e3:	68 46 38 00 00       	push   $0x3846
     8e8:	50                   	push   %eax
     8e9:	e8 c4 11 00 00       	call   1ab2 <APLoadBitmap>
     8ee:	83 c4 0c             	add    $0xc,%esp
     8f1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     8f4:	a3 e0 7e 00 00       	mov    %eax,0x7ee0
     8f9:	8b 45 dc             	mov    -0x24(%ebp),%eax
     8fc:	a3 e4 7e 00 00       	mov    %eax,0x7ee4
     901:	8b 45 e0             	mov    -0x20(%ebp),%eax
     904:	a3 e8 7e 00 00       	mov    %eax,0x7ee8
 reddoor = APLoadBitmap ("reddoor.bmp");
     909:	8d 45 d8             	lea    -0x28(%ebp),%eax
     90c:	83 ec 08             	sub    $0x8,%esp
     90f:	68 53 38 00 00       	push   $0x3853
     914:	50                   	push   %eax
     915:	e8 98 11 00 00       	call   1ab2 <APLoadBitmap>
     91a:	83 c4 0c             	add    $0xc,%esp
     91d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     920:	a3 34 80 00 00       	mov    %eax,0x8034
     925:	8b 45 dc             	mov    -0x24(%ebp),%eax
     928:	a3 38 80 00 00       	mov    %eax,0x8038
     92d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     930:	a3 3c 80 00 00       	mov    %eax,0x803c
 upstair = APLoadBitmap ("upstair.bmp");
     935:	8d 45 d8             	lea    -0x28(%ebp),%eax
     938:	83 ec 08             	sub    $0x8,%esp
     93b:	68 5f 38 00 00       	push   $0x385f
     940:	50                   	push   %eax
     941:	e8 6c 11 00 00       	call   1ab2 <APLoadBitmap>
     946:	83 c4 0c             	add    $0xc,%esp
     949:	8b 45 d8             	mov    -0x28(%ebp),%eax
     94c:	a3 ec 7f 00 00       	mov    %eax,0x7fec
     951:	8b 45 dc             	mov    -0x24(%ebp),%eax
     954:	a3 f0 7f 00 00       	mov    %eax,0x7ff0
     959:	8b 45 e0             	mov    -0x20(%ebp),%eax
     95c:	a3 f4 7f 00 00       	mov    %eax,0x7ff4
 downstair = APLoadBitmap ("downstair.bmp");
     961:	8d 45 d8             	lea    -0x28(%ebp),%eax
     964:	83 ec 08             	sub    $0x8,%esp
     967:	68 6b 38 00 00       	push   $0x386b
     96c:	50                   	push   %eax
     96d:	e8 40 11 00 00       	call   1ab2 <APLoadBitmap>
     972:	83 c4 0c             	add    $0xc,%esp
     975:	8b 45 d8             	mov    -0x28(%ebp),%eax
     978:	a3 fc 7f 00 00       	mov    %eax,0x7ffc
     97d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     980:	a3 00 80 00 00       	mov    %eax,0x8000
     985:	8b 45 e0             	mov    -0x20(%ebp),%eax
     988:	a3 04 80 00 00       	mov    %eax,0x8004
 yellowkey = APLoadBitmap ("yellowkey.bmp");
     98d:	8d 45 d8             	lea    -0x28(%ebp),%eax
     990:	83 ec 08             	sub    $0x8,%esp
     993:	68 79 38 00 00       	push   $0x3879
     998:	50                   	push   %eax
     999:	e8 14 11 00 00       	call   1ab2 <APLoadBitmap>
     99e:	83 c4 0c             	add    $0xc,%esp
     9a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     9a4:	a3 0c 85 00 00       	mov    %eax,0x850c
     9a9:	8b 45 dc             	mov    -0x24(%ebp),%eax
     9ac:	a3 10 85 00 00       	mov    %eax,0x8510
     9b1:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9b4:	a3 14 85 00 00       	mov    %eax,0x8514
 bluekey = APLoadBitmap ("bluekey.bmp");
     9b9:	8d 45 d8             	lea    -0x28(%ebp),%eax
     9bc:	83 ec 08             	sub    $0x8,%esp
     9bf:	68 87 38 00 00       	push   $0x3887
     9c4:	50                   	push   %eax
     9c5:	e8 e8 10 00 00       	call   1ab2 <APLoadBitmap>
     9ca:	83 c4 0c             	add    $0xc,%esp
     9cd:	8b 45 d8             	mov    -0x28(%ebp),%eax
     9d0:	a3 3c 7f 00 00       	mov    %eax,0x7f3c
     9d5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     9d8:	a3 40 7f 00 00       	mov    %eax,0x7f40
     9dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9e0:	a3 44 7f 00 00       	mov    %eax,0x7f44
 redkey = APLoadBitmap ("redkey.bmp");
     9e5:	8d 45 d8             	lea    -0x28(%ebp),%eax
     9e8:	83 ec 08             	sub    $0x8,%esp
     9eb:	68 93 38 00 00       	push   $0x3893
     9f0:	50                   	push   %eax
     9f1:	e8 bc 10 00 00       	call   1ab2 <APLoadBitmap>
     9f6:	83 c4 0c             	add    $0xc,%esp
     9f9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     9fc:	a3 ac 7f 00 00       	mov    %eax,0x7fac
     a01:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a04:	a3 b0 7f 00 00       	mov    %eax,0x7fb0
     a09:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a0c:	a3 b4 7f 00 00       	mov    %eax,0x7fb4
 sblood = APLoadBitmap ("sblood.bmp");
     a11:	8d 45 d8             	lea    -0x28(%ebp),%eax
     a14:	83 ec 08             	sub    $0x8,%esp
     a17:	68 9e 38 00 00       	push   $0x389e
     a1c:	50                   	push   %eax
     a1d:	e8 90 10 00 00       	call   1ab2 <APLoadBitmap>
     a22:	83 c4 0c             	add    $0xc,%esp
     a25:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a28:	a3 1c 85 00 00       	mov    %eax,0x851c
     a2d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a30:	a3 20 85 00 00       	mov    %eax,0x8520
     a35:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a38:	a3 24 85 00 00       	mov    %eax,0x8524
 lblood = APLoadBitmap ("lblood.bmp");
     a3d:	8d 45 d8             	lea    -0x28(%ebp),%eax
     a40:	83 ec 08             	sub    $0x8,%esp
     a43:	68 a9 38 00 00       	push   $0x38a9
     a48:	50                   	push   %eax
     a49:	e8 64 10 00 00       	call   1ab2 <APLoadBitmap>
     a4e:	83 c4 0c             	add    $0xc,%esp
     a51:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a54:	a3 08 80 00 00       	mov    %eax,0x8008
     a59:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a5c:	a3 0c 80 00 00       	mov    %eax,0x800c
     a61:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a64:	a3 10 80 00 00       	mov    %eax,0x8010
 attack = APLoadBitmap ("attack.bmp");
     a69:	8d 45 d8             	lea    -0x28(%ebp),%eax
     a6c:	83 ec 08             	sub    $0x8,%esp
     a6f:	68 b4 38 00 00       	push   $0x38b4
     a74:	50                   	push   %eax
     a75:	e8 38 10 00 00       	call   1ab2 <APLoadBitmap>
     a7a:	83 c4 0c             	add    $0xc,%esp
     a7d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a80:	a3 54 7f 00 00       	mov    %eax,0x7f54
     a85:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a88:	a3 58 7f 00 00       	mov    %eax,0x7f58
     a8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a90:	a3 5c 7f 00 00       	mov    %eax,0x7f5c
 defend = APLoadBitmap ("defend.bmp");
     a95:	8d 45 d8             	lea    -0x28(%ebp),%eax
     a98:	83 ec 08             	sub    $0x8,%esp
     a9b:	68 bf 38 00 00       	push   $0x38bf
     aa0:	50                   	push   %eax
     aa1:	e8 0c 10 00 00       	call   1ab2 <APLoadBitmap>
     aa6:	83 c4 0c             	add    $0xc,%esp
     aa9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aac:	a3 f8 7e 00 00       	mov    %eax,0x7ef8
     ab1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ab4:	a3 fc 7e 00 00       	mov    %eax,0x7efc
     ab9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     abc:	a3 00 7f 00 00       	mov    %eax,0x7f00
	//bitmap init	
	AMessage msg;
	msg.type = MSG_PAINT;
     ac1:	c7 45 e8 03 00 00 00 	movl   $0x3,-0x18(%ebp)
	msg.param = 0;
     ac8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	APSendMessage(hwnd,msg);
     acf:	83 ec 0c             	sub    $0xc,%esp
     ad2:	ff 75 f4             	pushl  -0xc(%ebp)
     ad5:	ff 75 f0             	pushl  -0x10(%ebp)
     ad8:	ff 75 ec             	pushl  -0x14(%ebp)
     adb:	ff 75 e8             	pushl  -0x18(%ebp)
     ade:	ff 75 08             	pushl  0x8(%ebp)
     ae1:	e8 f3 1b 00 00       	call   26d9 <APSendMessage>
     ae6:	83 c4 20             	add    $0x20,%esp

}
     ae9:	90                   	nop
     aea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     aed:	c9                   	leave  
     aee:	c3                   	ret    

00000aef <fight>:


bool fight()
{
     aef:	55                   	push   %ebp
     af0:	89 e5                	mov    %esp,%ebp
     af2:	53                   	push   %ebx
     af3:	83 ec 14             	sub    $0x14,%esp
printf(1,"hp before:%d\n",hp);
     af6:	a1 30 80 00 00       	mov    0x8030,%eax
     afb:	83 ec 04             	sub    $0x4,%esp
     afe:	50                   	push   %eax
     aff:	68 ca 38 00 00       	push   $0x38ca
     b04:	6a 01                	push   $0x1
     b06:	e8 21 0b 00 00       	call   162c <printf>
     b0b:	83 c4 10             	add    $0x10,%esp
int mhp,matk,mdef,mid;
switch(my_tower[floor][position.x][position.y])
     b0e:	8b 1d 04 7f 00 00    	mov    0x7f04,%ebx
     b14:	8b 15 34 7f 00 00    	mov    0x7f34,%edx
     b1a:	8b 0d 38 7f 00 00    	mov    0x7f38,%ecx
     b20:	89 d0                	mov    %edx,%eax
     b22:	c1 e0 02             	shl    $0x2,%eax
     b25:	01 d0                	add    %edx,%eax
     b27:	01 c0                	add    %eax,%eax
     b29:	6b d3 64             	imul   $0x64,%ebx,%edx
     b2c:	01 d0                	add    %edx,%eax
     b2e:	01 c8                	add    %ecx,%eax
     b30:	8b 04 85 40 80 00 00 	mov    0x8040(,%eax,4),%eax
     b37:	83 f8 03             	cmp    $0x3,%eax
     b3a:	74 13                	je     b4f <fight+0x60>
     b3c:	83 f8 04             	cmp    $0x4,%eax
     b3f:	74 17                	je     b58 <fight+0x69>
     b41:	83 f8 02             	cmp    $0x2,%eax
     b44:	75 1b                	jne    b61 <fight+0x72>
{
	case Monster1:
	mid = 0;
     b46:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	break;
     b4d:	eb 1a                	jmp    b69 <fight+0x7a>
	case Monster2:
	mid = 1;
     b4f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
	break;
     b56:	eb 11                	jmp    b69 <fight+0x7a>
	case Monster3:
	mid = 2;
     b58:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%ebp)
	break;
     b5f:	eb 08                	jmp    b69 <fight+0x7a>
	default:
	mid = 0;
     b61:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	break;
     b68:	90                   	nop
}
mhp = monster_info[mid][0];
     b69:	8b 55 f0             	mov    -0x10(%ebp),%edx
     b6c:	89 d0                	mov    %edx,%eax
     b6e:	01 c0                	add    %eax,%eax
     b70:	01 d0                	add    %edx,%eax
     b72:	c1 e0 02             	shl    $0x2,%eax
     b75:	05 40 42 00 00       	add    $0x4240,%eax
     b7a:	8b 00                	mov    (%eax),%eax
     b7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
matk = monster_info[mid][1];
     b7f:	8b 55 f0             	mov    -0x10(%ebp),%edx
     b82:	89 d0                	mov    %edx,%eax
     b84:	01 c0                	add    %eax,%eax
     b86:	01 d0                	add    %edx,%eax
     b88:	c1 e0 02             	shl    $0x2,%eax
     b8b:	05 44 42 00 00       	add    $0x4244,%eax
     b90:	8b 00                	mov    (%eax),%eax
     b92:	89 45 ec             	mov    %eax,-0x14(%ebp)
mdef = monster_info[mid][2];//load monster info
     b95:	8b 55 f0             	mov    -0x10(%ebp),%edx
     b98:	89 d0                	mov    %edx,%eax
     b9a:	01 c0                	add    %eax,%eax
     b9c:	01 d0                	add    %edx,%eax
     b9e:	c1 e0 02             	shl    $0x2,%eax
     ba1:	05 48 42 00 00       	add    $0x4248,%eax
     ba6:	8b 00                	mov    (%eax),%eax
     ba8:	89 45 e8             	mov    %eax,-0x18(%ebp)
if (atk <= mdef)
     bab:	a1 ec 7e 00 00       	mov    0x7eec,%eax
     bb0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     bb3:	7f 07                	jg     bbc <fight+0xcd>
{
	return false;
     bb5:	b8 00 00 00 00       	mov    $0x0,%eax
     bba:	eb 66                	jmp    c22 <fight+0x133>
}//cannot win
while(true)
{
	mhp -= (atk - mdef);
     bbc:	a1 ec 7e 00 00       	mov    0x7eec,%eax
     bc1:	2b 45 e8             	sub    -0x18(%ebp),%eax
     bc4:	29 45 f4             	sub    %eax,-0xc(%ebp)
	if (mhp <= 0)
     bc7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     bcb:	7f 1f                	jg     bec <fight+0xfd>
	{
		
printf(1,"hp after:%d\n",hp);
     bcd:	a1 30 80 00 00       	mov    0x8030,%eax
     bd2:	83 ec 04             	sub    $0x4,%esp
     bd5:	50                   	push   %eax
     bd6:	68 d8 38 00 00       	push   $0x38d8
     bdb:	6a 01                	push   $0x1
     bdd:	e8 4a 0a 00 00       	call   162c <printf>
     be2:	83 c4 10             	add    $0x10,%esp
		return true;
     be5:	b8 01 00 00 00       	mov    $0x1,%eax
     bea:	eb 36                	jmp    c22 <fight+0x133>
	}
	if (matk < def)
     bec:	a1 f0 7e 00 00       	mov    0x7ef0,%eax
     bf1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     bf4:	7c 29                	jl     c1f <fight+0x130>
	{
		continue;
	}
	hp -= (matk - def);
     bf6:	a1 30 80 00 00       	mov    0x8030,%eax
     bfb:	8b 15 f0 7e 00 00    	mov    0x7ef0,%edx
     c01:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     c04:	29 d1                	sub    %edx,%ecx
     c06:	89 ca                	mov    %ecx,%edx
     c08:	29 d0                	sub    %edx,%eax
     c0a:	a3 30 80 00 00       	mov    %eax,0x8030
	if (hp <= 0)
     c0f:	a1 30 80 00 00       	mov    0x8030,%eax
     c14:	85 c0                	test   %eax,%eax
     c16:	7f a4                	jg     bbc <fight+0xcd>
	{
		return false;
     c18:	b8 00 00 00 00       	mov    $0x0,%eax
     c1d:	eb 03                	jmp    c22 <fight+0x133>
printf(1,"hp after:%d\n",hp);
		return true;
	}
	if (matk < def)
	{
		continue;
     c1f:	90                   	nop
	hp -= (matk - def);
	if (hp <= 0)
	{
		return false;
	}
}
     c20:	eb 9a                	jmp    bbc <fight+0xcd>

//
}
     c22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c25:	c9                   	leave  
     c26:	c3                   	ret    

00000c27 <draw>:

void draw(AHwnd hwnd)
{
     c27:	55                   	push   %ebp
     c28:	89 e5                	mov    %esp,%ebp
     c2a:	83 ec 18             	sub    $0x18,%esp
for (int i = 0;i < BLOCK_NUM_X;i++)
     c2d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c34:	eb 2b                	jmp    c61 <draw+0x3a>
{
for (int j = 0;j < BLOCK_NUM_Y;j++)
     c36:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     c3d:	eb 18                	jmp    c57 <draw+0x30>
{
drawone(hwnd,i,j);
     c3f:	83 ec 04             	sub    $0x4,%esp
     c42:	ff 75 f0             	pushl  -0x10(%ebp)
     c45:	ff 75 f4             	pushl  -0xc(%ebp)
     c48:	ff 75 08             	pushl  0x8(%ebp)
     c4b:	e8 1a 00 00 00       	call   c6a <drawone>
     c50:	83 c4 10             	add    $0x10,%esp

void draw(AHwnd hwnd)
{
for (int i = 0;i < BLOCK_NUM_X;i++)
{
for (int j = 0;j < BLOCK_NUM_Y;j++)
     c53:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     c57:	83 7d f0 09          	cmpl   $0x9,-0x10(%ebp)
     c5b:	7e e2                	jle    c3f <draw+0x18>
//
}

void draw(AHwnd hwnd)
{
for (int i = 0;i < BLOCK_NUM_X;i++)
     c5d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c61:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     c65:	7e cf                	jle    c36 <draw+0xf>
{
drawone(hwnd,i,j);
}
}

}
     c67:	90                   	nop
     c68:	c9                   	leave  
     c69:	c3                   	ret    

00000c6a <drawone>:

void drawone(AHwnd hwnd,int i,int j)
{
     c6a:	55                   	push   %ebp
     c6b:	89 e5                	mov    %esp,%ebp
     c6d:	57                   	push   %edi
     c6e:	56                   	push   %esi
     c6f:	53                   	push   %ebx
     c70:	83 ec 2c             	sub    $0x2c,%esp
printf(1,"draw one:%d\n",++con);
     c73:	a1 c0 7e 00 00       	mov    0x7ec0,%eax
     c78:	83 c0 01             	add    $0x1,%eax
     c7b:	a3 c0 7e 00 00       	mov    %eax,0x7ec0
     c80:	a1 c0 7e 00 00       	mov    0x7ec0,%eax
     c85:	83 ec 04             	sub    $0x4,%esp
     c88:	50                   	push   %eax
     c89:	68 e5 38 00 00       	push   $0x38e5
     c8e:	6a 01                	push   $0x1
     c90:	e8 97 09 00 00       	call   162c <printf>
     c95:	83 c4 10             	add    $0x10,%esp
ABitmap temp;
switch(my_tower[floor][i][j])
     c98:	8b 0d 04 7f 00 00    	mov    0x7f04,%ecx
     c9e:	8b 55 0c             	mov    0xc(%ebp),%edx
     ca1:	89 d0                	mov    %edx,%eax
     ca3:	c1 e0 02             	shl    $0x2,%eax
     ca6:	01 d0                	add    %edx,%eax
     ca8:	01 c0                	add    %eax,%eax
     caa:	6b d1 64             	imul   $0x64,%ecx,%edx
     cad:	01 c2                	add    %eax,%edx
     caf:	8b 45 10             	mov    0x10(%ebp),%eax
     cb2:	01 d0                	add    %edx,%eax
     cb4:	8b 04 85 40 80 00 00 	mov    0x8040(,%eax,4),%eax
     cbb:	83 f8 11             	cmp    $0x11,%eax
     cbe:	0f 87 87 02 00 00    	ja     f4b <drawone+0x2e1>
     cc4:	8b 04 85 f4 38 00 00 	mov    0x38f4(,%eax,4),%eax
     ccb:	ff e0                	jmp    *%eax
{
case Background:
	temp = background;
     ccd:	a1 14 7f 00 00       	mov    0x7f14,%eax
     cd2:	89 45 d0             	mov    %eax,-0x30(%ebp)
     cd5:	a1 18 7f 00 00       	mov    0x7f18,%eax
     cda:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     cdd:	a1 1c 7f 00 00       	mov    0x7f1c,%eax
     ce2:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("background.bmp");
	break;
     ce5:	e9 7a 02 00 00       	jmp    f64 <drawone+0x2fa>
case Wall:
	temp = wall;
     cea:	a1 18 80 00 00       	mov    0x8018,%eax
     cef:	89 45 d0             	mov    %eax,-0x30(%ebp)
     cf2:	a1 1c 80 00 00       	mov    0x801c,%eax
     cf7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     cfa:	a1 20 80 00 00       	mov    0x8020,%eax
     cff:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("wall.bmp");
	break;
     d02:	e9 5d 02 00 00       	jmp    f64 <drawone+0x2fa>
case Monster1:
	temp = monster1;
     d07:	a1 24 80 00 00       	mov    0x8024,%eax
     d0c:	89 45 d0             	mov    %eax,-0x30(%ebp)
     d0f:	a1 28 80 00 00       	mov    0x8028,%eax
     d14:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     d17:	a1 2c 80 00 00       	mov    0x802c,%eax
     d1c:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("monster1.bmp");
	break;
     d1f:	e9 40 02 00 00       	jmp    f64 <drawone+0x2fa>
case Monster2:
	temp = monster2;	
     d24:	a1 80 7f 00 00       	mov    0x7f80,%eax
     d29:	89 45 d0             	mov    %eax,-0x30(%ebp)
     d2c:	a1 84 7f 00 00       	mov    0x7f84,%eax
     d31:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     d34:	a1 88 7f 00 00       	mov    0x7f88,%eax
     d39:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("monster2.bmp");
	break;
     d3c:	e9 23 02 00 00       	jmp    f64 <drawone+0x2fa>
case Monster3:
	temp = monster3;
     d41:	a1 b8 7f 00 00       	mov    0x7fb8,%eax
     d46:	89 45 d0             	mov    %eax,-0x30(%ebp)
     d49:	a1 bc 7f 00 00       	mov    0x7fbc,%eax
     d4e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     d51:	a1 c0 7f 00 00       	mov    0x7fc0,%eax
     d56:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("monster3.bmp");
	break;
     d59:	e9 06 02 00 00       	jmp    f64 <drawone+0x2fa>
case Valiant:	
	//temp = APLoadBitmap ("background.bmp");
	temp = background;
     d5e:	a1 14 7f 00 00       	mov    0x7f14,%eax
     d63:	89 45 d0             	mov    %eax,-0x30(%ebp)
     d66:	a1 18 7f 00 00       	mov    0x7f18,%eax
     d6b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     d6e:	a1 1c 7f 00 00       	mov    0x7f1c,%eax
     d73:	89 45 d8             	mov    %eax,-0x28(%ebp)
	APDcCopy(&hwnd->Dc,i * BLOCK_WIDTH ,j * BLOCK_WIDTH,APCreateCompatibleDCFromBitmap(temp),0,0,BLOCK_WIDTH,BLOCK_WIDTH,COLOR_NULL);
     d76:	8d 45 df             	lea    -0x21(%ebp),%eax
     d79:	6a 0c                	push   $0xc
     d7b:	6a 0c                	push   $0xc
     d7d:	6a 0c                	push   $0xc
     d7f:	50                   	push   %eax
     d80:	e8 7b f2 ff ff       	call   0 <RGB>
     d85:	83 c4 0c             	add    $0xc,%esp
     d88:	83 ec 04             	sub    $0x4,%esp
     d8b:	ff 75 d8             	pushl  -0x28(%ebp)
     d8e:	ff 75 d4             	pushl  -0x2c(%ebp)
     d91:	ff 75 d0             	pushl  -0x30(%ebp)
     d94:	e8 53 0f 00 00       	call   1cec <APCreateCompatibleDCFromBitmap>
     d99:	83 c4 10             	add    $0x10,%esp
     d9c:	89 c7                	mov    %eax,%edi
     d9e:	8b 45 10             	mov    0x10(%ebp),%eax
     da1:	c1 e0 05             	shl    $0x5,%eax
     da4:	89 c6                	mov    %eax,%esi
     da6:	8b 45 0c             	mov    0xc(%ebp),%eax
     da9:	c1 e0 05             	shl    $0x5,%eax
     dac:	89 c3                	mov    %eax,%ebx
     dae:	8b 45 08             	mov    0x8(%ebp),%eax
     db1:	8d 48 3c             	lea    0x3c(%eax),%ecx
     db4:	83 ec 0c             	sub    $0xc,%esp
     db7:	83 ec 04             	sub    $0x4,%esp
     dba:	89 e0                	mov    %esp,%eax
     dbc:	0f b7 55 df          	movzwl -0x21(%ebp),%edx
     dc0:	66 89 10             	mov    %dx,(%eax)
     dc3:	0f b6 55 e1          	movzbl -0x1f(%ebp),%edx
     dc7:	88 50 02             	mov    %dl,0x2(%eax)
     dca:	6a 20                	push   $0x20
     dcc:	6a 20                	push   $0x20
     dce:	6a 00                	push   $0x0
     dd0:	6a 00                	push   $0x0
     dd2:	57                   	push   %edi
     dd3:	56                   	push   %esi
     dd4:	53                   	push   %ebx
     dd5:	51                   	push   %ecx
     dd6:	e8 15 17 00 00       	call   24f0 <APDcCopy>
     ddb:	83 c4 30             	add    $0x30,%esp
	//temp = APLoadBitmap ("valiant.bmp");
	temp = valiant;
     dde:	a1 00 85 00 00       	mov    0x8500,%eax
     de3:	89 45 d0             	mov    %eax,-0x30(%ebp)
     de6:	a1 04 85 00 00       	mov    0x8504,%eax
     deb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     dee:	a1 08 85 00 00       	mov    0x8508,%eax
     df3:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     df6:	e9 69 01 00 00       	jmp    f64 <drawone+0x2fa>
case YellowDoor:
	temp = yellowdoor;
     dfb:	a1 48 7f 00 00       	mov    0x7f48,%eax
     e00:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e03:	a1 4c 7f 00 00       	mov    0x7f4c,%eax
     e08:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e0b:	a1 50 7f 00 00       	mov    0x7f50,%eax
     e10:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("yellowdoor.bmp");
	break;
     e13:	e9 4c 01 00 00       	jmp    f64 <drawone+0x2fa>
case BlueDoor:
	temp = bluedoor;
     e18:	a1 e0 7e 00 00       	mov    0x7ee0,%eax
     e1d:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e20:	a1 e4 7e 00 00       	mov    0x7ee4,%eax
     e25:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e28:	a1 e8 7e 00 00       	mov    0x7ee8,%eax
     e2d:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("bluedoor.bmp");
	break;
     e30:	e9 2f 01 00 00       	jmp    f64 <drawone+0x2fa>
case RedDoor:
	temp = reddoor;
     e35:	a1 34 80 00 00       	mov    0x8034,%eax
     e3a:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e3d:	a1 38 80 00 00       	mov    0x8038,%eax
     e42:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e45:	a1 3c 80 00 00       	mov    0x803c,%eax
     e4a:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("reddoor.bmp");
	break;
     e4d:	e9 12 01 00 00       	jmp    f64 <drawone+0x2fa>
case UpStair:
	temp = upstair;
     e52:	a1 ec 7f 00 00       	mov    0x7fec,%eax
     e57:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e5a:	a1 f0 7f 00 00       	mov    0x7ff0,%eax
     e5f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e62:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     e67:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("upstair.bmp");
	break;
     e6a:	e9 f5 00 00 00       	jmp    f64 <drawone+0x2fa>
case DownStair:
	temp = downstair;
     e6f:	a1 fc 7f 00 00       	mov    0x7ffc,%eax
     e74:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e77:	a1 00 80 00 00       	mov    0x8000,%eax
     e7c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e7f:	a1 04 80 00 00       	mov    0x8004,%eax
     e84:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("downstair.bmp");
	break;
     e87:	e9 d8 00 00 00       	jmp    f64 <drawone+0x2fa>
case YellowKey:
	temp = yellowkey;
     e8c:	a1 0c 85 00 00       	mov    0x850c,%eax
     e91:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e94:	a1 10 85 00 00       	mov    0x8510,%eax
     e99:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e9c:	a1 14 85 00 00       	mov    0x8514,%eax
     ea1:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("yellowkey.bmp");
	break;
     ea4:	e9 bb 00 00 00       	jmp    f64 <drawone+0x2fa>
case BlueKey:
	temp = bluekey;
     ea9:	a1 3c 7f 00 00       	mov    0x7f3c,%eax
     eae:	89 45 d0             	mov    %eax,-0x30(%ebp)
     eb1:	a1 40 7f 00 00       	mov    0x7f40,%eax
     eb6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     eb9:	a1 44 7f 00 00       	mov    0x7f44,%eax
     ebe:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("bluekey.bmp");
	break;
     ec1:	e9 9e 00 00 00       	jmp    f64 <drawone+0x2fa>
case RedKey:
	temp = redkey;
     ec6:	a1 ac 7f 00 00       	mov    0x7fac,%eax
     ecb:	89 45 d0             	mov    %eax,-0x30(%ebp)
     ece:	a1 b0 7f 00 00       	mov    0x7fb0,%eax
     ed3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     ed6:	a1 b4 7f 00 00       	mov    0x7fb4,%eax
     edb:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("redkey.bmp");
	break;
     ede:	e9 81 00 00 00       	jmp    f64 <drawone+0x2fa>
case SBlood:
	temp = sblood;
     ee3:	a1 1c 85 00 00       	mov    0x851c,%eax
     ee8:	89 45 d0             	mov    %eax,-0x30(%ebp)
     eeb:	a1 20 85 00 00       	mov    0x8520,%eax
     ef0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     ef3:	a1 24 85 00 00       	mov    0x8524,%eax
     ef8:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("sblood.bmp");
	break;
     efb:	eb 67                	jmp    f64 <drawone+0x2fa>
case LBlood:
	temp = lblood;
     efd:	a1 08 80 00 00       	mov    0x8008,%eax
     f02:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f05:	a1 0c 80 00 00       	mov    0x800c,%eax
     f0a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f0d:	a1 10 80 00 00       	mov    0x8010,%eax
     f12:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("lblood.bmp");
	break;
     f15:	eb 4d                	jmp    f64 <drawone+0x2fa>
case Attack:
	temp = attack;
     f17:	a1 54 7f 00 00       	mov    0x7f54,%eax
     f1c:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f1f:	a1 58 7f 00 00       	mov    0x7f58,%eax
     f24:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f27:	a1 5c 7f 00 00       	mov    0x7f5c,%eax
     f2c:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("attack.bmp");
	break;
     f2f:	eb 33                	jmp    f64 <drawone+0x2fa>
case Defend:
	temp = defend;
     f31:	a1 f8 7e 00 00       	mov    0x7ef8,%eax
     f36:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f39:	a1 fc 7e 00 00       	mov    0x7efc,%eax
     f3e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f41:	a1 00 7f 00 00       	mov    0x7f00,%eax
     f46:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("defend.bmp");
	break;
     f49:	eb 19                	jmp    f64 <drawone+0x2fa>
default:
	temp = background;
     f4b:	a1 14 7f 00 00       	mov    0x7f14,%eax
     f50:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f53:	a1 18 7f 00 00       	mov    0x7f18,%eax
     f58:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f5b:	a1 1c 7f 00 00       	mov    0x7f1c,%eax
     f60:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("background.bmp");
break;
     f63:	90                   	nop
}
		if(my_tower[floor][i][j] == Valiant)
     f64:	8b 0d 04 7f 00 00    	mov    0x7f04,%ecx
     f6a:	8b 55 0c             	mov    0xc(%ebp),%edx
     f6d:	89 d0                	mov    %edx,%eax
     f6f:	c1 e0 02             	shl    $0x2,%eax
     f72:	01 d0                	add    %edx,%eax
     f74:	01 c0                	add    %eax,%eax
     f76:	6b d1 64             	imul   $0x64,%ecx,%edx
     f79:	01 c2                	add    %eax,%edx
     f7b:	8b 45 10             	mov    0x10(%ebp),%eax
     f7e:	01 d0                	add    %edx,%eax
     f80:	8b 04 85 40 80 00 00 	mov    0x8040(,%eax,4),%eax
     f87:	83 f8 05             	cmp    $0x5,%eax
     f8a:	75 6a                	jne    ff6 <drawone+0x38c>
		{
			APDcCopy(&hwnd->Dc,i * BLOCK_WIDTH ,j * BLOCK_WIDTH,APCreateCompatibleDCFromBitmap(temp),0,0,BLOCK_WIDTH,BLOCK_WIDTH,RGB(0,0,0));
     f8c:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     f8f:	6a 00                	push   $0x0
     f91:	6a 00                	push   $0x0
     f93:	6a 00                	push   $0x0
     f95:	50                   	push   %eax
     f96:	e8 65 f0 ff ff       	call   0 <RGB>
     f9b:	83 c4 0c             	add    $0xc,%esp
     f9e:	83 ec 04             	sub    $0x4,%esp
     fa1:	ff 75 d8             	pushl  -0x28(%ebp)
     fa4:	ff 75 d4             	pushl  -0x2c(%ebp)
     fa7:	ff 75 d0             	pushl  -0x30(%ebp)
     faa:	e8 3d 0d 00 00       	call   1cec <APCreateCompatibleDCFromBitmap>
     faf:	83 c4 10             	add    $0x10,%esp
     fb2:	89 c7                	mov    %eax,%edi
     fb4:	8b 45 10             	mov    0x10(%ebp),%eax
     fb7:	c1 e0 05             	shl    $0x5,%eax
     fba:	89 c6                	mov    %eax,%esi
     fbc:	8b 45 0c             	mov    0xc(%ebp),%eax
     fbf:	c1 e0 05             	shl    $0x5,%eax
     fc2:	89 c3                	mov    %eax,%ebx
     fc4:	8b 45 08             	mov    0x8(%ebp),%eax
     fc7:	8d 48 3c             	lea    0x3c(%eax),%ecx
     fca:	83 ec 0c             	sub    $0xc,%esp
     fcd:	83 ec 04             	sub    $0x4,%esp
     fd0:	89 e0                	mov    %esp,%eax
     fd2:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
     fd6:	66 89 10             	mov    %dx,(%eax)
     fd9:	0f b6 55 e4          	movzbl -0x1c(%ebp),%edx
     fdd:	88 50 02             	mov    %dl,0x2(%eax)
     fe0:	6a 20                	push   $0x20
     fe2:	6a 20                	push   $0x20
     fe4:	6a 00                	push   $0x0
     fe6:	6a 00                	push   $0x0
     fe8:	57                   	push   %edi
     fe9:	56                   	push   %esi
     fea:	53                   	push   %ebx
     feb:	51                   	push   %ecx
     fec:	e8 ff 14 00 00       	call   24f0 <APDcCopy>
     ff1:	83 c4 30             	add    $0x30,%esp
			APDcCopy(&hwnd->Dc,i * BLOCK_WIDTH ,j * BLOCK_WIDTH,APCreateCompatibleDCFromBitmap(temp),0,0,BLOCK_WIDTH,BLOCK_WIDTH,COLOR_NULL);
	
}//主体

//info
}
     ff4:	eb 68                	jmp    105e <drawone+0x3f4>
			APDcCopy(&hwnd->Dc,i * BLOCK_WIDTH ,j * BLOCK_WIDTH,APCreateCompatibleDCFromBitmap(temp),0,0,BLOCK_WIDTH,BLOCK_WIDTH,RGB(0,0,0));

		}
		else
		{
			APDcCopy(&hwnd->Dc,i * BLOCK_WIDTH ,j * BLOCK_WIDTH,APCreateCompatibleDCFromBitmap(temp),0,0,BLOCK_WIDTH,BLOCK_WIDTH,COLOR_NULL);
     ff6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     ff9:	6a 0c                	push   $0xc
     ffb:	6a 0c                	push   $0xc
     ffd:	6a 0c                	push   $0xc
     fff:	50                   	push   %eax
    1000:	e8 fb ef ff ff       	call   0 <RGB>
    1005:	83 c4 0c             	add    $0xc,%esp
    1008:	83 ec 04             	sub    $0x4,%esp
    100b:	ff 75 d8             	pushl  -0x28(%ebp)
    100e:	ff 75 d4             	pushl  -0x2c(%ebp)
    1011:	ff 75 d0             	pushl  -0x30(%ebp)
    1014:	e8 d3 0c 00 00       	call   1cec <APCreateCompatibleDCFromBitmap>
    1019:	83 c4 10             	add    $0x10,%esp
    101c:	89 c7                	mov    %eax,%edi
    101e:	8b 45 10             	mov    0x10(%ebp),%eax
    1021:	c1 e0 05             	shl    $0x5,%eax
    1024:	89 c6                	mov    %eax,%esi
    1026:	8b 45 0c             	mov    0xc(%ebp),%eax
    1029:	c1 e0 05             	shl    $0x5,%eax
    102c:	89 c3                	mov    %eax,%ebx
    102e:	8b 45 08             	mov    0x8(%ebp),%eax
    1031:	8d 48 3c             	lea    0x3c(%eax),%ecx
    1034:	83 ec 0c             	sub    $0xc,%esp
    1037:	83 ec 04             	sub    $0x4,%esp
    103a:	89 e0                	mov    %esp,%eax
    103c:	0f b7 55 e5          	movzwl -0x1b(%ebp),%edx
    1040:	66 89 10             	mov    %dx,(%eax)
    1043:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
    1047:	88 50 02             	mov    %dl,0x2(%eax)
    104a:	6a 20                	push   $0x20
    104c:	6a 20                	push   $0x20
    104e:	6a 00                	push   $0x0
    1050:	6a 00                	push   $0x0
    1052:	57                   	push   %edi
    1053:	56                   	push   %esi
    1054:	53                   	push   %ebx
    1055:	51                   	push   %ecx
    1056:	e8 95 14 00 00       	call   24f0 <APDcCopy>
    105b:	83 c4 30             	add    $0x30,%esp
	
}//主体

//info
}
    105e:	90                   	nop
    105f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1062:	5b                   	pop    %ebx
    1063:	5e                   	pop    %esi
    1064:	5f                   	pop    %edi
    1065:	5d                   	pop    %ebp
    1066:	c3                   	ret    

00001067 <wndProc>:

bool wndProc(AHwnd hwnd,AMessage msg)
{
    1067:	55                   	push   %ebp
    1068:	89 e5                	mov    %esp,%ebp
    106a:	57                   	push   %edi
    106b:	56                   	push   %esi
    106c:	53                   	push   %ebx
    106d:	83 ec 6c             	sub    $0x6c,%esp
	switch(msg.type)
    1070:	8b 45 0c             	mov    0xc(%ebp),%eax
    1073:	83 f8 03             	cmp    $0x3,%eax
    1076:	74 6a                	je     10e2 <wndProc+0x7b>
    1078:	83 f8 06             	cmp    $0x6,%eax
    107b:	74 46                	je     10c3 <wndProc+0x5c>
    107d:	83 f8 02             	cmp    $0x2,%eax
    1080:	74 05                	je     1087 <wndProc+0x20>
            	sprintf(info,"Floor:%d,Hp:%d,ATK:%d,DEF:%d,Yellow:%d,Blue:%d,Red:%d",floor+1,hp,atk,def,my_key[0],my_key[1],my_key[2]);
		msg1.word = info;           	 
		APSendMessage(hwnd,msg1);
		break;
		default:
		break;
    1082:	e9 1b 01 00 00       	jmp    11a2 <wndProc+0x13b>
bool wndProc(AHwnd hwnd,AMessage msg)
{
	switch(msg.type)
	{
		    case MSG_INIT:
			printf(1,"test\n");
    1087:	83 ec 08             	sub    $0x8,%esp
    108a:	68 3c 39 00 00       	push   $0x393c
    108f:	6a 01                	push   $0x1
    1091:	e8 96 05 00 00       	call   162c <printf>
    1096:	83 c4 10             	add    $0x10,%esp
		    init(hwnd);
    1099:	83 ec 0c             	sub    $0xc,%esp
    109c:	ff 75 08             	pushl  0x8(%ebp)
    109f:	e8 72 f6 ff ff       	call   716 <init>
    10a4:	83 c4 10             	add    $0x10,%esp
			printf(1,"init finished");
    10a7:	83 ec 08             	sub    $0x8,%esp
    10aa:	68 42 39 00 00       	push   $0x3942
    10af:	6a 01                	push   $0x1
    10b1:	e8 76 05 00 00       	call   162c <printf>
    10b6:	83 c4 10             	add    $0x10,%esp
		
		    return False;
    10b9:	b8 00 00 00 00       	mov    $0x0,%eax
    10be:	e9 f9 00 00 00       	jmp    11bc <wndProc+0x155>
		case MSG_KEY_DOWN:
		keyDown(hwnd,msg);
    10c3:	83 ec 0c             	sub    $0xc,%esp
    10c6:	ff 75 18             	pushl  0x18(%ebp)
    10c9:	ff 75 14             	pushl  0x14(%ebp)
    10cc:	ff 75 10             	pushl  0x10(%ebp)
    10cf:	ff 75 0c             	pushl  0xc(%ebp)
    10d2:	ff 75 08             	pushl  0x8(%ebp)
    10d5:	e8 f6 ef ff ff       	call   d0 <keyDown>
    10da:	83 c4 20             	add    $0x20,%esp
		break;
    10dd:	e9 c0 00 00 00       	jmp    11a2 <wndProc+0x13b>
		case MSG_PAINT:
		
if (msg.param == 0)
    10e2:	8b 45 10             	mov    0x10(%ebp),%eax
    10e5:	85 c0                	test   %eax,%eax
    10e7:	75 10                	jne    10f9 <wndProc+0x92>
		draw(hwnd);
    10e9:	83 ec 0c             	sub    $0xc,%esp
    10ec:	ff 75 08             	pushl  0x8(%ebp)
    10ef:	e8 33 fb ff ff       	call   c27 <draw>
    10f4:	83 c4 10             	add    $0x10,%esp
    10f7:	eb 36                	jmp    112f <wndProc+0xc8>
else
{
drawone(hwnd,position.x,position.y);
    10f9:	8b 15 38 7f 00 00    	mov    0x7f38,%edx
    10ff:	a1 34 7f 00 00       	mov    0x7f34,%eax
    1104:	83 ec 04             	sub    $0x4,%esp
    1107:	52                   	push   %edx
    1108:	50                   	push   %eax
    1109:	ff 75 08             	pushl  0x8(%ebp)
    110c:	e8 59 fb ff ff       	call   c6a <drawone>
    1111:	83 c4 10             	add    $0x10,%esp
drawone(hwnd,position_old.x,position_old.y);
    1114:	8b 15 24 7f 00 00    	mov    0x7f24,%edx
    111a:	a1 20 7f 00 00       	mov    0x7f20,%eax
    111f:	83 ec 04             	sub    $0x4,%esp
    1122:	52                   	push   %edx
    1123:	50                   	push   %eax
    1124:	ff 75 08             	pushl  0x8(%ebp)
    1127:	e8 3e fb ff ff       	call   c6a <drawone>
    112c:	83 c4 10             	add    $0x10,%esp
}
		char info[50];
		AMessage msg1;
	    	msg1.type = MSG_WORD;
    112f:	c7 45 d8 0a 00 00 00 	movl   $0xa,-0x28(%ebp)
            	sprintf(info,"Floor:%d,Hp:%d,ATK:%d,DEF:%d,Yellow:%d,Blue:%d,Red:%d",floor+1,hp,atk,def,my_key[0],my_key[1],my_key[2]);
    1136:	a1 f8 84 00 00       	mov    0x84f8,%eax
    113b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    113e:	8b 3d f4 84 00 00    	mov    0x84f4,%edi
    1144:	8b 35 f0 84 00 00    	mov    0x84f0,%esi
    114a:	8b 1d f0 7e 00 00    	mov    0x7ef0,%ebx
    1150:	8b 0d ec 7e 00 00    	mov    0x7eec,%ecx
    1156:	8b 15 30 80 00 00    	mov    0x8030,%edx
    115c:	a1 04 7f 00 00       	mov    0x7f04,%eax
    1161:	83 c0 01             	add    $0x1,%eax
    1164:	83 ec 0c             	sub    $0xc,%esp
    1167:	ff 75 94             	pushl  -0x6c(%ebp)
    116a:	57                   	push   %edi
    116b:	56                   	push   %esi
    116c:	53                   	push   %ebx
    116d:	51                   	push   %ecx
    116e:	52                   	push   %edx
    116f:	50                   	push   %eax
    1170:	68 50 39 00 00       	push   $0x3950
    1175:	8d 45 a6             	lea    -0x5a(%ebp),%eax
    1178:	50                   	push   %eax
    1179:	e8 af 23 00 00       	call   352d <sprintf>
    117e:	83 c4 30             	add    $0x30,%esp
		msg1.word = info;           	 
    1181:	8d 45 a6             	lea    -0x5a(%ebp),%eax
    1184:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		APSendMessage(hwnd,msg1);
    1187:	83 ec 0c             	sub    $0xc,%esp
    118a:	ff 75 e4             	pushl  -0x1c(%ebp)
    118d:	ff 75 e0             	pushl  -0x20(%ebp)
    1190:	ff 75 dc             	pushl  -0x24(%ebp)
    1193:	ff 75 d8             	pushl  -0x28(%ebp)
    1196:	ff 75 08             	pushl  0x8(%ebp)
    1199:	e8 3b 15 00 00       	call   26d9 <APSendMessage>
    119e:	83 c4 20             	add    $0x20,%esp
		break;
    11a1:	90                   	nop
		default:
		break;
	}
	return APWndProc(hwnd,msg);
    11a2:	83 ec 0c             	sub    $0xc,%esp
    11a5:	ff 75 18             	pushl  0x18(%ebp)
    11a8:	ff 75 14             	pushl  0x14(%ebp)
    11ab:	ff 75 10             	pushl  0x10(%ebp)
    11ae:	ff 75 0c             	pushl  0xc(%ebp)
    11b1:	ff 75 08             	pushl  0x8(%ebp)
    11b4:	e8 a4 17 00 00       	call   295d <APWndProc>
    11b9:	83 c4 20             	add    $0x20,%esp

}
    11bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11bf:	5b                   	pop    %ebx
    11c0:	5e                   	pop    %esi
    11c1:	5f                   	pop    %edi
    11c2:	5d                   	pop    %ebp
    11c3:	c3                   	ret    

000011c4 <main>:


int main(void)
{
    11c4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    11c8:	83 e4 f0             	and    $0xfffffff0,%esp
    11cb:	ff 71 fc             	pushl  -0x4(%ecx)
    11ce:	55                   	push   %ebp
    11cf:	89 e5                	mov    %esp,%ebp
    11d1:	51                   	push   %ecx
    11d2:	83 ec 14             	sub    $0x14,%esp
	
	AHwnd hwnd = APCreateWindow("magictower",False,0);
    11d5:	83 ec 04             	sub    $0x4,%esp
    11d8:	6a 00                	push   $0x0
    11da:	6a 00                	push   $0x0
    11dc:	68 86 39 00 00       	push   $0x3986
    11e1:	e8 11 15 00 00       	call   26f7 <APCreateWindow>
    11e6:	83 c4 10             	add    $0x10,%esp
    11e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf(1,"magic tower created.\n");
    11ec:	83 ec 08             	sub    $0x8,%esp
    11ef:	68 91 39 00 00       	push   $0x3991
    11f4:	6a 01                	push   $0x1
    11f6:	e8 31 04 00 00       	call   162c <printf>
    11fb:	83 c4 10             	add    $0x10,%esp
	APWndExec(hwnd,wndProc);
    11fe:	83 ec 08             	sub    $0x8,%esp
    1201:	68 67 10 00 00       	push   $0x1067
    1206:	ff 75 f4             	pushl  -0xc(%ebp)
    1209:	e8 66 18 00 00       	call   2a74 <APWndExec>
    120e:	83 c4 10             	add    $0x10,%esp
	exit();
    1211:	e8 57 02 00 00       	call   146d <exit>

00001216 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1216:	55                   	push   %ebp
    1217:	89 e5                	mov    %esp,%ebp
    1219:	57                   	push   %edi
    121a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    121b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    121e:	8b 55 10             	mov    0x10(%ebp),%edx
    1221:	8b 45 0c             	mov    0xc(%ebp),%eax
    1224:	89 cb                	mov    %ecx,%ebx
    1226:	89 df                	mov    %ebx,%edi
    1228:	89 d1                	mov    %edx,%ecx
    122a:	fc                   	cld    
    122b:	f3 aa                	rep stos %al,%es:(%edi)
    122d:	89 ca                	mov    %ecx,%edx
    122f:	89 fb                	mov    %edi,%ebx
    1231:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1234:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1237:	90                   	nop
    1238:	5b                   	pop    %ebx
    1239:	5f                   	pop    %edi
    123a:	5d                   	pop    %ebp
    123b:	c3                   	ret    

0000123c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    123c:	55                   	push   %ebp
    123d:	89 e5                	mov    %esp,%ebp
    123f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1242:	8b 45 08             	mov    0x8(%ebp),%eax
    1245:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1248:	90                   	nop
    1249:	8b 45 08             	mov    0x8(%ebp),%eax
    124c:	8d 50 01             	lea    0x1(%eax),%edx
    124f:	89 55 08             	mov    %edx,0x8(%ebp)
    1252:	8b 55 0c             	mov    0xc(%ebp),%edx
    1255:	8d 4a 01             	lea    0x1(%edx),%ecx
    1258:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    125b:	0f b6 12             	movzbl (%edx),%edx
    125e:	88 10                	mov    %dl,(%eax)
    1260:	0f b6 00             	movzbl (%eax),%eax
    1263:	84 c0                	test   %al,%al
    1265:	75 e2                	jne    1249 <strcpy+0xd>
    ;
  return os;
    1267:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    126a:	c9                   	leave  
    126b:	c3                   	ret    

0000126c <strcmp>:

int
strcmp(const char *p, const char *q)
{
    126c:	55                   	push   %ebp
    126d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    126f:	eb 08                	jmp    1279 <strcmp+0xd>
    p++, q++;
    1271:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1275:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1279:	8b 45 08             	mov    0x8(%ebp),%eax
    127c:	0f b6 00             	movzbl (%eax),%eax
    127f:	84 c0                	test   %al,%al
    1281:	74 10                	je     1293 <strcmp+0x27>
    1283:	8b 45 08             	mov    0x8(%ebp),%eax
    1286:	0f b6 10             	movzbl (%eax),%edx
    1289:	8b 45 0c             	mov    0xc(%ebp),%eax
    128c:	0f b6 00             	movzbl (%eax),%eax
    128f:	38 c2                	cmp    %al,%dl
    1291:	74 de                	je     1271 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1293:	8b 45 08             	mov    0x8(%ebp),%eax
    1296:	0f b6 00             	movzbl (%eax),%eax
    1299:	0f b6 d0             	movzbl %al,%edx
    129c:	8b 45 0c             	mov    0xc(%ebp),%eax
    129f:	0f b6 00             	movzbl (%eax),%eax
    12a2:	0f b6 c0             	movzbl %al,%eax
    12a5:	29 c2                	sub    %eax,%edx
    12a7:	89 d0                	mov    %edx,%eax
}
    12a9:	5d                   	pop    %ebp
    12aa:	c3                   	ret    

000012ab <strlen>:

uint
strlen(char *s)
{
    12ab:	55                   	push   %ebp
    12ac:	89 e5                	mov    %esp,%ebp
    12ae:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    12b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    12b8:	eb 04                	jmp    12be <strlen+0x13>
    12ba:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    12be:	8b 55 fc             	mov    -0x4(%ebp),%edx
    12c1:	8b 45 08             	mov    0x8(%ebp),%eax
    12c4:	01 d0                	add    %edx,%eax
    12c6:	0f b6 00             	movzbl (%eax),%eax
    12c9:	84 c0                	test   %al,%al
    12cb:	75 ed                	jne    12ba <strlen+0xf>
    ;
  return n;
    12cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12d0:	c9                   	leave  
    12d1:	c3                   	ret    

000012d2 <memset>:

void*
memset(void *dst, int c, uint n)
{
    12d2:	55                   	push   %ebp
    12d3:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    12d5:	8b 45 10             	mov    0x10(%ebp),%eax
    12d8:	50                   	push   %eax
    12d9:	ff 75 0c             	pushl  0xc(%ebp)
    12dc:	ff 75 08             	pushl  0x8(%ebp)
    12df:	e8 32 ff ff ff       	call   1216 <stosb>
    12e4:	83 c4 0c             	add    $0xc,%esp
  return dst;
    12e7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12ea:	c9                   	leave  
    12eb:	c3                   	ret    

000012ec <strchr>:

char*
strchr(const char *s, char c)
{
    12ec:	55                   	push   %ebp
    12ed:	89 e5                	mov    %esp,%ebp
    12ef:	83 ec 04             	sub    $0x4,%esp
    12f2:	8b 45 0c             	mov    0xc(%ebp),%eax
    12f5:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    12f8:	eb 14                	jmp    130e <strchr+0x22>
    if(*s == c)
    12fa:	8b 45 08             	mov    0x8(%ebp),%eax
    12fd:	0f b6 00             	movzbl (%eax),%eax
    1300:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1303:	75 05                	jne    130a <strchr+0x1e>
      return (char*)s;
    1305:	8b 45 08             	mov    0x8(%ebp),%eax
    1308:	eb 13                	jmp    131d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    130a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    130e:	8b 45 08             	mov    0x8(%ebp),%eax
    1311:	0f b6 00             	movzbl (%eax),%eax
    1314:	84 c0                	test   %al,%al
    1316:	75 e2                	jne    12fa <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1318:	b8 00 00 00 00       	mov    $0x0,%eax
}
    131d:	c9                   	leave  
    131e:	c3                   	ret    

0000131f <gets>:

char*
gets(char *buf, int max)
{
    131f:	55                   	push   %ebp
    1320:	89 e5                	mov    %esp,%ebp
    1322:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1325:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    132c:	eb 42                	jmp    1370 <gets+0x51>
    cc = read(0, &c, 1);
    132e:	83 ec 04             	sub    $0x4,%esp
    1331:	6a 01                	push   $0x1
    1333:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1336:	50                   	push   %eax
    1337:	6a 00                	push   $0x0
    1339:	e8 47 01 00 00       	call   1485 <read>
    133e:	83 c4 10             	add    $0x10,%esp
    1341:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1344:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1348:	7e 33                	jle    137d <gets+0x5e>
      break;
    buf[i++] = c;
    134a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    134d:	8d 50 01             	lea    0x1(%eax),%edx
    1350:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1353:	89 c2                	mov    %eax,%edx
    1355:	8b 45 08             	mov    0x8(%ebp),%eax
    1358:	01 c2                	add    %eax,%edx
    135a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    135e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1360:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1364:	3c 0a                	cmp    $0xa,%al
    1366:	74 16                	je     137e <gets+0x5f>
    1368:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    136c:	3c 0d                	cmp    $0xd,%al
    136e:	74 0e                	je     137e <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1370:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1373:	83 c0 01             	add    $0x1,%eax
    1376:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1379:	7c b3                	jl     132e <gets+0xf>
    137b:	eb 01                	jmp    137e <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    137d:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    137e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1381:	8b 45 08             	mov    0x8(%ebp),%eax
    1384:	01 d0                	add    %edx,%eax
    1386:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1389:	8b 45 08             	mov    0x8(%ebp),%eax
}
    138c:	c9                   	leave  
    138d:	c3                   	ret    

0000138e <stat>:

int
stat(char *n, struct stat *st)
{
    138e:	55                   	push   %ebp
    138f:	89 e5                	mov    %esp,%ebp
    1391:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1394:	83 ec 08             	sub    $0x8,%esp
    1397:	6a 00                	push   $0x0
    1399:	ff 75 08             	pushl  0x8(%ebp)
    139c:	e8 0c 01 00 00       	call   14ad <open>
    13a1:	83 c4 10             	add    $0x10,%esp
    13a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    13a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13ab:	79 07                	jns    13b4 <stat+0x26>
    return -1;
    13ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    13b2:	eb 25                	jmp    13d9 <stat+0x4b>
  r = fstat(fd, st);
    13b4:	83 ec 08             	sub    $0x8,%esp
    13b7:	ff 75 0c             	pushl  0xc(%ebp)
    13ba:	ff 75 f4             	pushl  -0xc(%ebp)
    13bd:	e8 03 01 00 00       	call   14c5 <fstat>
    13c2:	83 c4 10             	add    $0x10,%esp
    13c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    13c8:	83 ec 0c             	sub    $0xc,%esp
    13cb:	ff 75 f4             	pushl  -0xc(%ebp)
    13ce:	e8 c2 00 00 00       	call   1495 <close>
    13d3:	83 c4 10             	add    $0x10,%esp
  return r;
    13d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    13d9:	c9                   	leave  
    13da:	c3                   	ret    

000013db <atoi>:

int
atoi(const char *s)
{
    13db:	55                   	push   %ebp
    13dc:	89 e5                	mov    %esp,%ebp
    13de:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    13e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    13e8:	eb 25                	jmp    140f <atoi+0x34>
    n = n*10 + *s++ - '0';
    13ea:	8b 55 fc             	mov    -0x4(%ebp),%edx
    13ed:	89 d0                	mov    %edx,%eax
    13ef:	c1 e0 02             	shl    $0x2,%eax
    13f2:	01 d0                	add    %edx,%eax
    13f4:	01 c0                	add    %eax,%eax
    13f6:	89 c1                	mov    %eax,%ecx
    13f8:	8b 45 08             	mov    0x8(%ebp),%eax
    13fb:	8d 50 01             	lea    0x1(%eax),%edx
    13fe:	89 55 08             	mov    %edx,0x8(%ebp)
    1401:	0f b6 00             	movzbl (%eax),%eax
    1404:	0f be c0             	movsbl %al,%eax
    1407:	01 c8                	add    %ecx,%eax
    1409:	83 e8 30             	sub    $0x30,%eax
    140c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    140f:	8b 45 08             	mov    0x8(%ebp),%eax
    1412:	0f b6 00             	movzbl (%eax),%eax
    1415:	3c 2f                	cmp    $0x2f,%al
    1417:	7e 0a                	jle    1423 <atoi+0x48>
    1419:	8b 45 08             	mov    0x8(%ebp),%eax
    141c:	0f b6 00             	movzbl (%eax),%eax
    141f:	3c 39                	cmp    $0x39,%al
    1421:	7e c7                	jle    13ea <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1423:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1426:	c9                   	leave  
    1427:	c3                   	ret    

00001428 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1428:	55                   	push   %ebp
    1429:	89 e5                	mov    %esp,%ebp
    142b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    142e:	8b 45 08             	mov    0x8(%ebp),%eax
    1431:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1434:	8b 45 0c             	mov    0xc(%ebp),%eax
    1437:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    143a:	eb 17                	jmp    1453 <memmove+0x2b>
    *dst++ = *src++;
    143c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    143f:	8d 50 01             	lea    0x1(%eax),%edx
    1442:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1445:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1448:	8d 4a 01             	lea    0x1(%edx),%ecx
    144b:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    144e:	0f b6 12             	movzbl (%edx),%edx
    1451:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1453:	8b 45 10             	mov    0x10(%ebp),%eax
    1456:	8d 50 ff             	lea    -0x1(%eax),%edx
    1459:	89 55 10             	mov    %edx,0x10(%ebp)
    145c:	85 c0                	test   %eax,%eax
    145e:	7f dc                	jg     143c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1460:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1463:	c9                   	leave  
    1464:	c3                   	ret    

00001465 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1465:	b8 01 00 00 00       	mov    $0x1,%eax
    146a:	cd 40                	int    $0x40
    146c:	c3                   	ret    

0000146d <exit>:
SYSCALL(exit)
    146d:	b8 02 00 00 00       	mov    $0x2,%eax
    1472:	cd 40                	int    $0x40
    1474:	c3                   	ret    

00001475 <wait>:
SYSCALL(wait)
    1475:	b8 03 00 00 00       	mov    $0x3,%eax
    147a:	cd 40                	int    $0x40
    147c:	c3                   	ret    

0000147d <pipe>:
SYSCALL(pipe)
    147d:	b8 04 00 00 00       	mov    $0x4,%eax
    1482:	cd 40                	int    $0x40
    1484:	c3                   	ret    

00001485 <read>:
SYSCALL(read)
    1485:	b8 05 00 00 00       	mov    $0x5,%eax
    148a:	cd 40                	int    $0x40
    148c:	c3                   	ret    

0000148d <write>:
SYSCALL(write)
    148d:	b8 10 00 00 00       	mov    $0x10,%eax
    1492:	cd 40                	int    $0x40
    1494:	c3                   	ret    

00001495 <close>:
SYSCALL(close)
    1495:	b8 15 00 00 00       	mov    $0x15,%eax
    149a:	cd 40                	int    $0x40
    149c:	c3                   	ret    

0000149d <kill>:
SYSCALL(kill)
    149d:	b8 06 00 00 00       	mov    $0x6,%eax
    14a2:	cd 40                	int    $0x40
    14a4:	c3                   	ret    

000014a5 <exec>:
SYSCALL(exec)
    14a5:	b8 07 00 00 00       	mov    $0x7,%eax
    14aa:	cd 40                	int    $0x40
    14ac:	c3                   	ret    

000014ad <open>:
SYSCALL(open)
    14ad:	b8 0f 00 00 00       	mov    $0xf,%eax
    14b2:	cd 40                	int    $0x40
    14b4:	c3                   	ret    

000014b5 <mknod>:
SYSCALL(mknod)
    14b5:	b8 11 00 00 00       	mov    $0x11,%eax
    14ba:	cd 40                	int    $0x40
    14bc:	c3                   	ret    

000014bd <unlink>:
SYSCALL(unlink)
    14bd:	b8 12 00 00 00       	mov    $0x12,%eax
    14c2:	cd 40                	int    $0x40
    14c4:	c3                   	ret    

000014c5 <fstat>:
SYSCALL(fstat)
    14c5:	b8 08 00 00 00       	mov    $0x8,%eax
    14ca:	cd 40                	int    $0x40
    14cc:	c3                   	ret    

000014cd <link>:
SYSCALL(link)
    14cd:	b8 13 00 00 00       	mov    $0x13,%eax
    14d2:	cd 40                	int    $0x40
    14d4:	c3                   	ret    

000014d5 <mkdir>:
SYSCALL(mkdir)
    14d5:	b8 14 00 00 00       	mov    $0x14,%eax
    14da:	cd 40                	int    $0x40
    14dc:	c3                   	ret    

000014dd <chdir>:
SYSCALL(chdir)
    14dd:	b8 09 00 00 00       	mov    $0x9,%eax
    14e2:	cd 40                	int    $0x40
    14e4:	c3                   	ret    

000014e5 <dup>:
SYSCALL(dup)
    14e5:	b8 0a 00 00 00       	mov    $0xa,%eax
    14ea:	cd 40                	int    $0x40
    14ec:	c3                   	ret    

000014ed <getpid>:
SYSCALL(getpid)
    14ed:	b8 0b 00 00 00       	mov    $0xb,%eax
    14f2:	cd 40                	int    $0x40
    14f4:	c3                   	ret    

000014f5 <sbrk>:
SYSCALL(sbrk)
    14f5:	b8 0c 00 00 00       	mov    $0xc,%eax
    14fa:	cd 40                	int    $0x40
    14fc:	c3                   	ret    

000014fd <sleep>:
SYSCALL(sleep)
    14fd:	b8 0d 00 00 00       	mov    $0xd,%eax
    1502:	cd 40                	int    $0x40
    1504:	c3                   	ret    

00001505 <uptime>:
SYSCALL(uptime)
    1505:	b8 0e 00 00 00       	mov    $0xe,%eax
    150a:	cd 40                	int    $0x40
    150c:	c3                   	ret    

0000150d <paintWindow>:

SYSCALL(paintWindow)
    150d:	b8 16 00 00 00       	mov    $0x16,%eax
    1512:	cd 40                	int    $0x40
    1514:	c3                   	ret    

00001515 <sendMessage>:
SYSCALL(sendMessage)
    1515:	b8 17 00 00 00       	mov    $0x17,%eax
    151a:	cd 40                	int    $0x40
    151c:	c3                   	ret    

0000151d <getMessage>:
SYSCALL(getMessage)
    151d:	b8 19 00 00 00       	mov    $0x19,%eax
    1522:	cd 40                	int    $0x40
    1524:	c3                   	ret    

00001525 <registWindow>:
SYSCALL(registWindow)
    1525:	b8 18 00 00 00       	mov    $0x18,%eax
    152a:	cd 40                	int    $0x40
    152c:	c3                   	ret    

0000152d <changePosition>:
SYSCALL(changePosition)
    152d:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1532:	cd 40                	int    $0x40
    1534:	c3                   	ret    

00001535 <setupTimer>:
SYSCALL(setupTimer)
    1535:	b8 1b 00 00 00       	mov    $0x1b,%eax
    153a:	cd 40                	int    $0x40
    153c:	c3                   	ret    

0000153d <deleteTimer>:
SYSCALL(deleteTimer)
    153d:	b8 1c 00 00 00       	mov    $0x1c,%eax
    1542:	cd 40                	int    $0x40
    1544:	c3                   	ret    

00001545 <getCurrentTime>:
SYSCALL(getCurrentTime)
    1545:	b8 1d 00 00 00       	mov    $0x1d,%eax
    154a:	cd 40                	int    $0x40
    154c:	c3                   	ret    

0000154d <removeWindow>:
SYSCALL(removeWindow)
    154d:	b8 1e 00 00 00       	mov    $0x1e,%eax
    1552:	cd 40                	int    $0x40
    1554:	c3                   	ret    

00001555 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1555:	55                   	push   %ebp
    1556:	89 e5                	mov    %esp,%ebp
    1558:	83 ec 18             	sub    $0x18,%esp
    155b:	8b 45 0c             	mov    0xc(%ebp),%eax
    155e:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1561:	83 ec 04             	sub    $0x4,%esp
    1564:	6a 01                	push   $0x1
    1566:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1569:	50                   	push   %eax
    156a:	ff 75 08             	pushl  0x8(%ebp)
    156d:	e8 1b ff ff ff       	call   148d <write>
    1572:	83 c4 10             	add    $0x10,%esp
}
    1575:	90                   	nop
    1576:	c9                   	leave  
    1577:	c3                   	ret    

00001578 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1578:	55                   	push   %ebp
    1579:	89 e5                	mov    %esp,%ebp
    157b:	53                   	push   %ebx
    157c:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    157f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1586:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    158a:	74 17                	je     15a3 <printint+0x2b>
    158c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1590:	79 11                	jns    15a3 <printint+0x2b>
    neg = 1;
    1592:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1599:	8b 45 0c             	mov    0xc(%ebp),%eax
    159c:	f7 d8                	neg    %eax
    159e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    15a1:	eb 06                	jmp    15a9 <printint+0x31>
  } else {
    x = xx;
    15a3:	8b 45 0c             	mov    0xc(%ebp),%eax
    15a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    15a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    15b0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    15b3:	8d 41 01             	lea    0x1(%ecx),%eax
    15b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    15b9:	8b 5d 10             	mov    0x10(%ebp),%ebx
    15bc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15bf:	ba 00 00 00 00       	mov    $0x0,%edx
    15c4:	f7 f3                	div    %ebx
    15c6:	89 d0                	mov    %edx,%eax
    15c8:	0f b6 80 64 42 00 00 	movzbl 0x4264(%eax),%eax
    15cf:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    15d3:	8b 5d 10             	mov    0x10(%ebp),%ebx
    15d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15d9:	ba 00 00 00 00       	mov    $0x0,%edx
    15de:	f7 f3                	div    %ebx
    15e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    15e3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    15e7:	75 c7                	jne    15b0 <printint+0x38>
  if(neg)
    15e9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    15ed:	74 2d                	je     161c <printint+0xa4>
    buf[i++] = '-';
    15ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f2:	8d 50 01             	lea    0x1(%eax),%edx
    15f5:	89 55 f4             	mov    %edx,-0xc(%ebp)
    15f8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    15fd:	eb 1d                	jmp    161c <printint+0xa4>
    putc(fd, buf[i]);
    15ff:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1602:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1605:	01 d0                	add    %edx,%eax
    1607:	0f b6 00             	movzbl (%eax),%eax
    160a:	0f be c0             	movsbl %al,%eax
    160d:	83 ec 08             	sub    $0x8,%esp
    1610:	50                   	push   %eax
    1611:	ff 75 08             	pushl  0x8(%ebp)
    1614:	e8 3c ff ff ff       	call   1555 <putc>
    1619:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    161c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1620:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1624:	79 d9                	jns    15ff <printint+0x87>
    putc(fd, buf[i]);
}
    1626:	90                   	nop
    1627:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    162a:	c9                   	leave  
    162b:	c3                   	ret    

0000162c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    162c:	55                   	push   %ebp
    162d:	89 e5                	mov    %esp,%ebp
    162f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1632:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1639:	8d 45 0c             	lea    0xc(%ebp),%eax
    163c:	83 c0 04             	add    $0x4,%eax
    163f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1642:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1649:	e9 59 01 00 00       	jmp    17a7 <printf+0x17b>
    c = fmt[i] & 0xff;
    164e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1651:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1654:	01 d0                	add    %edx,%eax
    1656:	0f b6 00             	movzbl (%eax),%eax
    1659:	0f be c0             	movsbl %al,%eax
    165c:	25 ff 00 00 00       	and    $0xff,%eax
    1661:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1664:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1668:	75 2c                	jne    1696 <printf+0x6a>
      if(c == '%'){
    166a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    166e:	75 0c                	jne    167c <printf+0x50>
        state = '%';
    1670:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1677:	e9 27 01 00 00       	jmp    17a3 <printf+0x177>
      } else {
        putc(fd, c);
    167c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    167f:	0f be c0             	movsbl %al,%eax
    1682:	83 ec 08             	sub    $0x8,%esp
    1685:	50                   	push   %eax
    1686:	ff 75 08             	pushl  0x8(%ebp)
    1689:	e8 c7 fe ff ff       	call   1555 <putc>
    168e:	83 c4 10             	add    $0x10,%esp
    1691:	e9 0d 01 00 00       	jmp    17a3 <printf+0x177>
      }
    } else if(state == '%'){
    1696:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    169a:	0f 85 03 01 00 00    	jne    17a3 <printf+0x177>
      if(c == 'd'){
    16a0:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    16a4:	75 1e                	jne    16c4 <printf+0x98>
        printint(fd, *ap, 10, 1);
    16a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16a9:	8b 00                	mov    (%eax),%eax
    16ab:	6a 01                	push   $0x1
    16ad:	6a 0a                	push   $0xa
    16af:	50                   	push   %eax
    16b0:	ff 75 08             	pushl  0x8(%ebp)
    16b3:	e8 c0 fe ff ff       	call   1578 <printint>
    16b8:	83 c4 10             	add    $0x10,%esp
        ap++;
    16bb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    16bf:	e9 d8 00 00 00       	jmp    179c <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    16c4:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    16c8:	74 06                	je     16d0 <printf+0xa4>
    16ca:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    16ce:	75 1e                	jne    16ee <printf+0xc2>
        printint(fd, *ap, 16, 0);
    16d0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16d3:	8b 00                	mov    (%eax),%eax
    16d5:	6a 00                	push   $0x0
    16d7:	6a 10                	push   $0x10
    16d9:	50                   	push   %eax
    16da:	ff 75 08             	pushl  0x8(%ebp)
    16dd:	e8 96 fe ff ff       	call   1578 <printint>
    16e2:	83 c4 10             	add    $0x10,%esp
        ap++;
    16e5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    16e9:	e9 ae 00 00 00       	jmp    179c <printf+0x170>
      } else if(c == 's'){
    16ee:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    16f2:	75 43                	jne    1737 <printf+0x10b>
        s = (char*)*ap;
    16f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16f7:	8b 00                	mov    (%eax),%eax
    16f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    16fc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1700:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1704:	75 25                	jne    172b <printf+0xff>
          s = "(null)";
    1706:	c7 45 f4 a7 39 00 00 	movl   $0x39a7,-0xc(%ebp)
        while(*s != 0){
    170d:	eb 1c                	jmp    172b <printf+0xff>
          putc(fd, *s);
    170f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1712:	0f b6 00             	movzbl (%eax),%eax
    1715:	0f be c0             	movsbl %al,%eax
    1718:	83 ec 08             	sub    $0x8,%esp
    171b:	50                   	push   %eax
    171c:	ff 75 08             	pushl  0x8(%ebp)
    171f:	e8 31 fe ff ff       	call   1555 <putc>
    1724:	83 c4 10             	add    $0x10,%esp
          s++;
    1727:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    172b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172e:	0f b6 00             	movzbl (%eax),%eax
    1731:	84 c0                	test   %al,%al
    1733:	75 da                	jne    170f <printf+0xe3>
    1735:	eb 65                	jmp    179c <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1737:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    173b:	75 1d                	jne    175a <printf+0x12e>
        putc(fd, *ap);
    173d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1740:	8b 00                	mov    (%eax),%eax
    1742:	0f be c0             	movsbl %al,%eax
    1745:	83 ec 08             	sub    $0x8,%esp
    1748:	50                   	push   %eax
    1749:	ff 75 08             	pushl  0x8(%ebp)
    174c:	e8 04 fe ff ff       	call   1555 <putc>
    1751:	83 c4 10             	add    $0x10,%esp
        ap++;
    1754:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1758:	eb 42                	jmp    179c <printf+0x170>
      } else if(c == '%'){
    175a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    175e:	75 17                	jne    1777 <printf+0x14b>
        putc(fd, c);
    1760:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1763:	0f be c0             	movsbl %al,%eax
    1766:	83 ec 08             	sub    $0x8,%esp
    1769:	50                   	push   %eax
    176a:	ff 75 08             	pushl  0x8(%ebp)
    176d:	e8 e3 fd ff ff       	call   1555 <putc>
    1772:	83 c4 10             	add    $0x10,%esp
    1775:	eb 25                	jmp    179c <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1777:	83 ec 08             	sub    $0x8,%esp
    177a:	6a 25                	push   $0x25
    177c:	ff 75 08             	pushl  0x8(%ebp)
    177f:	e8 d1 fd ff ff       	call   1555 <putc>
    1784:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1787:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    178a:	0f be c0             	movsbl %al,%eax
    178d:	83 ec 08             	sub    $0x8,%esp
    1790:	50                   	push   %eax
    1791:	ff 75 08             	pushl  0x8(%ebp)
    1794:	e8 bc fd ff ff       	call   1555 <putc>
    1799:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    179c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    17a3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    17a7:	8b 55 0c             	mov    0xc(%ebp),%edx
    17aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ad:	01 d0                	add    %edx,%eax
    17af:	0f b6 00             	movzbl (%eax),%eax
    17b2:	84 c0                	test   %al,%al
    17b4:	0f 85 94 fe ff ff    	jne    164e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    17ba:	90                   	nop
    17bb:	c9                   	leave  
    17bc:	c3                   	ret    

000017bd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    17bd:	55                   	push   %ebp
    17be:	89 e5                	mov    %esp,%ebp
    17c0:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    17c3:	8b 45 08             	mov    0x8(%ebp),%eax
    17c6:	83 e8 08             	sub    $0x8,%eax
    17c9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17cc:	a1 cc 7e 00 00       	mov    0x7ecc,%eax
    17d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17d4:	eb 24                	jmp    17fa <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17d9:	8b 00                	mov    (%eax),%eax
    17db:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17de:	77 12                	ja     17f2 <free+0x35>
    17e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17e3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17e6:	77 24                	ja     180c <free+0x4f>
    17e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17eb:	8b 00                	mov    (%eax),%eax
    17ed:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17f0:	77 1a                	ja     180c <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17f5:	8b 00                	mov    (%eax),%eax
    17f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17fd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1800:	76 d4                	jbe    17d6 <free+0x19>
    1802:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1805:	8b 00                	mov    (%eax),%eax
    1807:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    180a:	76 ca                	jbe    17d6 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    180c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    180f:	8b 40 04             	mov    0x4(%eax),%eax
    1812:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1819:	8b 45 f8             	mov    -0x8(%ebp),%eax
    181c:	01 c2                	add    %eax,%edx
    181e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1821:	8b 00                	mov    (%eax),%eax
    1823:	39 c2                	cmp    %eax,%edx
    1825:	75 24                	jne    184b <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1827:	8b 45 f8             	mov    -0x8(%ebp),%eax
    182a:	8b 50 04             	mov    0x4(%eax),%edx
    182d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1830:	8b 00                	mov    (%eax),%eax
    1832:	8b 40 04             	mov    0x4(%eax),%eax
    1835:	01 c2                	add    %eax,%edx
    1837:	8b 45 f8             	mov    -0x8(%ebp),%eax
    183a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    183d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1840:	8b 00                	mov    (%eax),%eax
    1842:	8b 10                	mov    (%eax),%edx
    1844:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1847:	89 10                	mov    %edx,(%eax)
    1849:	eb 0a                	jmp    1855 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    184b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    184e:	8b 10                	mov    (%eax),%edx
    1850:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1853:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1855:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1858:	8b 40 04             	mov    0x4(%eax),%eax
    185b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1862:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1865:	01 d0                	add    %edx,%eax
    1867:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    186a:	75 20                	jne    188c <free+0xcf>
    p->s.size += bp->s.size;
    186c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    186f:	8b 50 04             	mov    0x4(%eax),%edx
    1872:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1875:	8b 40 04             	mov    0x4(%eax),%eax
    1878:	01 c2                	add    %eax,%edx
    187a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    187d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1880:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1883:	8b 10                	mov    (%eax),%edx
    1885:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1888:	89 10                	mov    %edx,(%eax)
    188a:	eb 08                	jmp    1894 <free+0xd7>
  } else
    p->s.ptr = bp;
    188c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    188f:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1892:	89 10                	mov    %edx,(%eax)
  freep = p;
    1894:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1897:	a3 cc 7e 00 00       	mov    %eax,0x7ecc
}
    189c:	90                   	nop
    189d:	c9                   	leave  
    189e:	c3                   	ret    

0000189f <morecore>:

static Header*
morecore(uint nu)
{
    189f:	55                   	push   %ebp
    18a0:	89 e5                	mov    %esp,%ebp
    18a2:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    18a5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    18ac:	77 07                	ja     18b5 <morecore+0x16>
    nu = 4096;
    18ae:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    18b5:	8b 45 08             	mov    0x8(%ebp),%eax
    18b8:	c1 e0 03             	shl    $0x3,%eax
    18bb:	83 ec 0c             	sub    $0xc,%esp
    18be:	50                   	push   %eax
    18bf:	e8 31 fc ff ff       	call   14f5 <sbrk>
    18c4:	83 c4 10             	add    $0x10,%esp
    18c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    18ca:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    18ce:	75 07                	jne    18d7 <morecore+0x38>
    return 0;
    18d0:	b8 00 00 00 00       	mov    $0x0,%eax
    18d5:	eb 26                	jmp    18fd <morecore+0x5e>
  hp = (Header*)p;
    18d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18da:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    18dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18e0:	8b 55 08             	mov    0x8(%ebp),%edx
    18e3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    18e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18e9:	83 c0 08             	add    $0x8,%eax
    18ec:	83 ec 0c             	sub    $0xc,%esp
    18ef:	50                   	push   %eax
    18f0:	e8 c8 fe ff ff       	call   17bd <free>
    18f5:	83 c4 10             	add    $0x10,%esp
  return freep;
    18f8:	a1 cc 7e 00 00       	mov    0x7ecc,%eax
}
    18fd:	c9                   	leave  
    18fe:	c3                   	ret    

000018ff <malloc>:

void*
malloc(uint nbytes)
{
    18ff:	55                   	push   %ebp
    1900:	89 e5                	mov    %esp,%ebp
    1902:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1905:	8b 45 08             	mov    0x8(%ebp),%eax
    1908:	83 c0 07             	add    $0x7,%eax
    190b:	c1 e8 03             	shr    $0x3,%eax
    190e:	83 c0 01             	add    $0x1,%eax
    1911:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1914:	a1 cc 7e 00 00       	mov    0x7ecc,%eax
    1919:	89 45 f0             	mov    %eax,-0x10(%ebp)
    191c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1920:	75 23                	jne    1945 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1922:	c7 45 f0 c4 7e 00 00 	movl   $0x7ec4,-0x10(%ebp)
    1929:	8b 45 f0             	mov    -0x10(%ebp),%eax
    192c:	a3 cc 7e 00 00       	mov    %eax,0x7ecc
    1931:	a1 cc 7e 00 00       	mov    0x7ecc,%eax
    1936:	a3 c4 7e 00 00       	mov    %eax,0x7ec4
    base.s.size = 0;
    193b:	c7 05 c8 7e 00 00 00 	movl   $0x0,0x7ec8
    1942:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1945:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1948:	8b 00                	mov    (%eax),%eax
    194a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    194d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1950:	8b 40 04             	mov    0x4(%eax),%eax
    1953:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1956:	72 4d                	jb     19a5 <malloc+0xa6>
      if(p->s.size == nunits)
    1958:	8b 45 f4             	mov    -0xc(%ebp),%eax
    195b:	8b 40 04             	mov    0x4(%eax),%eax
    195e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1961:	75 0c                	jne    196f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1963:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1966:	8b 10                	mov    (%eax),%edx
    1968:	8b 45 f0             	mov    -0x10(%ebp),%eax
    196b:	89 10                	mov    %edx,(%eax)
    196d:	eb 26                	jmp    1995 <malloc+0x96>
      else {
        p->s.size -= nunits;
    196f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1972:	8b 40 04             	mov    0x4(%eax),%eax
    1975:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1978:	89 c2                	mov    %eax,%edx
    197a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    197d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1980:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1983:	8b 40 04             	mov    0x4(%eax),%eax
    1986:	c1 e0 03             	shl    $0x3,%eax
    1989:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    198c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    198f:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1992:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1995:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1998:	a3 cc 7e 00 00       	mov    %eax,0x7ecc
      return (void*)(p + 1);
    199d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a0:	83 c0 08             	add    $0x8,%eax
    19a3:	eb 3b                	jmp    19e0 <malloc+0xe1>
    }
    if(p == freep)
    19a5:	a1 cc 7e 00 00       	mov    0x7ecc,%eax
    19aa:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    19ad:	75 1e                	jne    19cd <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    19af:	83 ec 0c             	sub    $0xc,%esp
    19b2:	ff 75 ec             	pushl  -0x14(%ebp)
    19b5:	e8 e5 fe ff ff       	call   189f <morecore>
    19ba:	83 c4 10             	add    $0x10,%esp
    19bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    19c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    19c4:	75 07                	jne    19cd <malloc+0xce>
        return 0;
    19c6:	b8 00 00 00 00       	mov    $0x0,%eax
    19cb:	eb 13                	jmp    19e0 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    19cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d6:	8b 00                	mov    (%eax),%eax
    19d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    19db:	e9 6d ff ff ff       	jmp    194d <malloc+0x4e>
}
    19e0:	c9                   	leave  
    19e1:	c3                   	ret    

000019e2 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    19e2:	55                   	push   %ebp
    19e3:	89 e5                	mov    %esp,%ebp
    19e5:	83 ec 1c             	sub    $0x1c,%esp
    19e8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    19eb:	8b 55 10             	mov    0x10(%ebp),%edx
    19ee:	8b 45 14             	mov    0x14(%ebp),%eax
    19f1:	88 4d ec             	mov    %cl,-0x14(%ebp)
    19f4:	88 55 e8             	mov    %dl,-0x18(%ebp)
    19f7:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    19fa:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    19fe:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1a01:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1a05:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1a08:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1a0c:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1a0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a12:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1a16:	66 89 10             	mov    %dx,(%eax)
    1a19:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1a1d:	88 50 02             	mov    %dl,0x2(%eax)
}
    1a20:	8b 45 08             	mov    0x8(%ebp),%eax
    1a23:	c9                   	leave  
    1a24:	c2 04 00             	ret    $0x4

00001a27 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    1a27:	55                   	push   %ebp
    1a28:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
    1a2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2d:	2b 45 10             	sub    0x10(%ebp),%eax
    1a30:	89 c2                	mov    %eax,%edx
    1a32:	8b 45 08             	mov    0x8(%ebp),%eax
    1a35:	2b 45 10             	sub    0x10(%ebp),%eax
    1a38:	0f af d0             	imul   %eax,%edx
    1a3b:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a3e:	2b 45 14             	sub    0x14(%ebp),%eax
    1a41:	89 c1                	mov    %eax,%ecx
    1a43:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a46:	2b 45 14             	sub    0x14(%ebp),%eax
    1a49:	0f af c1             	imul   %ecx,%eax
    1a4c:	01 d0                	add    %edx,%eax
}
    1a4e:	5d                   	pop    %ebp
    1a4f:	c3                   	ret    

00001a50 <abs_int>:

static inline int abs_int(int x)
{
    1a50:	55                   	push   %ebp
    1a51:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
    1a53:	8b 45 08             	mov    0x8(%ebp),%eax
    1a56:	99                   	cltd   
    1a57:	89 d0                	mov    %edx,%eax
    1a59:	33 45 08             	xor    0x8(%ebp),%eax
    1a5c:	29 d0                	sub    %edx,%eax
}
    1a5e:	5d                   	pop    %ebp
    1a5f:	c3                   	ret    

00001a60 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    1a60:	55                   	push   %ebp
    1a61:	89 e5                	mov    %esp,%ebp
    if (x < 0)
    1a63:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1a67:	79 07                	jns    1a70 <APGetIndex+0x10>
        return X_SMALLER;
    1a69:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    1a6e:	eb 40                	jmp    1ab0 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
    1a70:	8b 45 08             	mov    0x8(%ebp),%eax
    1a73:	8b 00                	mov    (%eax),%eax
    1a75:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1a78:	7f 07                	jg     1a81 <APGetIndex+0x21>
        return X_BIGGER;
    1a7a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1a7f:	eb 2f                	jmp    1ab0 <APGetIndex+0x50>
    if (y < 0)
    1a81:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1a85:	79 07                	jns    1a8e <APGetIndex+0x2e>
        return Y_SMALLER;
    1a87:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
    1a8c:	eb 22                	jmp    1ab0 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
    1a8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a91:	8b 40 04             	mov    0x4(%eax),%eax
    1a94:	3b 45 10             	cmp    0x10(%ebp),%eax
    1a97:	7f 07                	jg     1aa0 <APGetIndex+0x40>
        return Y_BIGGER;
    1a99:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    1a9e:	eb 10                	jmp    1ab0 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
    1aa0:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa3:	8b 00                	mov    (%eax),%eax
    1aa5:	0f af 45 10          	imul   0x10(%ebp),%eax
    1aa9:	89 c2                	mov    %eax,%edx
    1aab:	8b 45 0c             	mov    0xc(%ebp),%eax
    1aae:	01 d0                	add    %edx,%eax
}
    1ab0:	5d                   	pop    %ebp
    1ab1:	c3                   	ret    

00001ab2 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    1ab2:	55                   	push   %ebp
    1ab3:	89 e5                	mov    %esp,%ebp
    1ab5:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    1ab8:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    1abf:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1ac2:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    1ac5:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    1acc:	83 ec 08             	sub    $0x8,%esp
    1acf:	6a 00                	push   $0x0
    1ad1:	ff 75 0c             	pushl  0xc(%ebp)
    1ad4:	e8 d4 f9 ff ff       	call   14ad <open>
    1ad9:	83 c4 10             	add    $0x10,%esp
    1adc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    1adf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ae3:	79 2e                	jns    1b13 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
    1ae5:	83 ec 04             	sub    $0x4,%esp
    1ae8:	ff 75 0c             	pushl  0xc(%ebp)
    1aeb:	68 ae 39 00 00       	push   $0x39ae
    1af0:	6a 01                	push   $0x1
    1af2:	e8 35 fb ff ff       	call   162c <printf>
    1af7:	83 c4 10             	add    $0x10,%esp
        return bmp;
    1afa:	8b 45 08             	mov    0x8(%ebp),%eax
    1afd:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1b00:	89 10                	mov    %edx,(%eax)
    1b02:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1b05:	89 50 04             	mov    %edx,0x4(%eax)
    1b08:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1b0b:	89 50 08             	mov    %edx,0x8(%eax)
    1b0e:	e9 d2 01 00 00       	jmp    1ce5 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    1b13:	83 ec 04             	sub    $0x4,%esp
    1b16:	6a 0e                	push   $0xe
    1b18:	8d 45 ba             	lea    -0x46(%ebp),%eax
    1b1b:	50                   	push   %eax
    1b1c:	ff 75 ec             	pushl  -0x14(%ebp)
    1b1f:	e8 61 f9 ff ff       	call   1485 <read>
    1b24:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    1b27:	83 ec 04             	sub    $0x4,%esp
    1b2a:	6a 28                	push   $0x28
    1b2c:	8d 45 92             	lea    -0x6e(%ebp),%eax
    1b2f:	50                   	push   %eax
    1b30:	ff 75 ec             	pushl  -0x14(%ebp)
    1b33:	e8 4d f9 ff ff       	call   1485 <read>
    1b38:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    1b3b:	8b 45 96             	mov    -0x6a(%ebp),%eax
    1b3e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    1b41:	8b 45 9a             	mov    -0x66(%ebp),%eax
    1b44:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    1b47:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1b4a:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1b4d:	0f af d0             	imul   %eax,%edx
    1b50:	89 d0                	mov    %edx,%eax
    1b52:	01 c0                	add    %eax,%eax
    1b54:	01 d0                	add    %edx,%eax
    1b56:	83 ec 0c             	sub    $0xc,%esp
    1b59:	50                   	push   %eax
    1b5a:	e8 a0 fd ff ff       	call   18ff <malloc>
    1b5f:	83 c4 10             	add    $0x10,%esp
    1b62:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    1b65:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    1b69:	0f b7 c0             	movzwl %ax,%eax
    1b6c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    1b6f:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1b72:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1b75:	0f af c2             	imul   %edx,%eax
    1b78:	83 c0 1f             	add    $0x1f,%eax
    1b7b:	c1 e8 05             	shr    $0x5,%eax
    1b7e:	c1 e0 02             	shl    $0x2,%eax
    1b81:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    1b84:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1b87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b8a:	0f af c2             	imul   %edx,%eax
    1b8d:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    1b90:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b93:	83 ec 0c             	sub    $0xc,%esp
    1b96:	50                   	push   %eax
    1b97:	e8 63 fd ff ff       	call   18ff <malloc>
    1b9c:	83 c4 10             	add    $0x10,%esp
    1b9f:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    1ba2:	83 ec 04             	sub    $0x4,%esp
    1ba5:	ff 75 e0             	pushl  -0x20(%ebp)
    1ba8:	ff 75 dc             	pushl  -0x24(%ebp)
    1bab:	ff 75 ec             	pushl  -0x14(%ebp)
    1bae:	e8 d2 f8 ff ff       	call   1485 <read>
    1bb3:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    1bb6:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    1bba:	66 c1 e8 03          	shr    $0x3,%ax
    1bbe:	0f b7 c0             	movzwl %ax,%eax
    1bc1:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    1bc4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1bcb:	e9 e5 00 00 00       	jmp    1cb5 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    1bd0:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1bd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bd6:	29 c2                	sub    %eax,%edx
    1bd8:	89 d0                	mov    %edx,%eax
    1bda:	8d 50 ff             	lea    -0x1(%eax),%edx
    1bdd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1be0:	0f af c2             	imul   %edx,%eax
    1be3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    1be6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1bed:	e9 b1 00 00 00       	jmp    1ca3 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    1bf2:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1bf5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1bf8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bfb:	01 c8                	add    %ecx,%eax
    1bfd:	89 c1                	mov    %eax,%ecx
    1bff:	89 c8                	mov    %ecx,%eax
    1c01:	01 c0                	add    %eax,%eax
    1c03:	01 c8                	add    %ecx,%eax
    1c05:	01 c2                	add    %eax,%edx
    1c07:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c0a:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1c0e:	89 c1                	mov    %eax,%ecx
    1c10:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1c13:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1c17:	01 c1                	add    %eax,%ecx
    1c19:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1c1c:	01 c8                	add    %ecx,%eax
    1c1e:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1c21:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1c24:	01 c8                	add    %ecx,%eax
    1c26:	0f b6 00             	movzbl (%eax),%eax
    1c29:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    1c2c:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1c2f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1c32:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c35:	01 c8                	add    %ecx,%eax
    1c37:	89 c1                	mov    %eax,%ecx
    1c39:	89 c8                	mov    %ecx,%eax
    1c3b:	01 c0                	add    %eax,%eax
    1c3d:	01 c8                	add    %ecx,%eax
    1c3f:	01 c2                	add    %eax,%edx
    1c41:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c44:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1c48:	89 c1                	mov    %eax,%ecx
    1c4a:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1c4d:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1c51:	01 c1                	add    %eax,%ecx
    1c53:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1c56:	01 c8                	add    %ecx,%eax
    1c58:	8d 48 fe             	lea    -0x2(%eax),%ecx
    1c5b:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1c5e:	01 c8                	add    %ecx,%eax
    1c60:	0f b6 00             	movzbl (%eax),%eax
    1c63:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    1c66:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1c69:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1c6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c6f:	01 c8                	add    %ecx,%eax
    1c71:	89 c1                	mov    %eax,%ecx
    1c73:	89 c8                	mov    %ecx,%eax
    1c75:	01 c0                	add    %eax,%eax
    1c77:	01 c8                	add    %ecx,%eax
    1c79:	01 c2                	add    %eax,%edx
    1c7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c7e:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1c82:	89 c1                	mov    %eax,%ecx
    1c84:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1c87:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1c8b:	01 c1                	add    %eax,%ecx
    1c8d:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1c90:	01 c8                	add    %ecx,%eax
    1c92:	8d 48 fd             	lea    -0x3(%eax),%ecx
    1c95:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1c98:	01 c8                	add    %ecx,%eax
    1c9a:	0f b6 00             	movzbl (%eax),%eax
    1c9d:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    1c9f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1ca3:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1ca6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ca9:	39 c2                	cmp    %eax,%edx
    1cab:	0f 87 41 ff ff ff    	ja     1bf2 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    1cb1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1cb5:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1cb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cbb:	39 c2                	cmp    %eax,%edx
    1cbd:	0f 87 0d ff ff ff    	ja     1bd0 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    1cc3:	83 ec 0c             	sub    $0xc,%esp
    1cc6:	ff 75 ec             	pushl  -0x14(%ebp)
    1cc9:	e8 c7 f7 ff ff       	call   1495 <close>
    1cce:	83 c4 10             	add    $0x10,%esp
    return bmp;
    1cd1:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd4:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1cd7:	89 10                	mov    %edx,(%eax)
    1cd9:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1cdc:	89 50 04             	mov    %edx,0x4(%eax)
    1cdf:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1ce2:	89 50 08             	mov    %edx,0x8(%eax)
}
    1ce5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce8:	c9                   	leave  
    1ce9:	c2 04 00             	ret    $0x4

00001cec <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    1cec:	55                   	push   %ebp
    1ced:	89 e5                	mov    %esp,%ebp
    1cef:	53                   	push   %ebx
    1cf0:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    1cf3:	83 ec 0c             	sub    $0xc,%esp
    1cf6:	6a 1c                	push   $0x1c
    1cf8:	e8 02 fc ff ff       	call   18ff <malloc>
    1cfd:	83 c4 10             	add    $0x10,%esp
    1d00:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    1d03:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d06:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    1d0d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    1d10:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1d13:	6a 0c                	push   $0xc
    1d15:	6a 0c                	push   $0xc
    1d17:	6a 0c                	push   $0xc
    1d19:	50                   	push   %eax
    1d1a:	e8 c3 fc ff ff       	call   19e2 <RGB>
    1d1f:	83 c4 0c             	add    $0xc,%esp
    1d22:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    1d26:	66 89 43 13          	mov    %ax,0x13(%ebx)
    1d2a:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    1d2e:	88 43 15             	mov    %al,0x15(%ebx)
    1d31:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d34:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d37:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    1d3b:	66 89 48 10          	mov    %cx,0x10(%eax)
    1d3f:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    1d43:	88 50 12             	mov    %dl,0x12(%eax)
    1d46:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d49:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d4c:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    1d50:	66 89 48 08          	mov    %cx,0x8(%eax)
    1d54:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    1d58:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    1d5b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d5e:	89 c2                	mov    %eax,%edx
    1d60:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d63:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    1d65:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d68:	89 c2                	mov    %eax,%edx
    1d6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d6d:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    1d70:	8b 55 10             	mov    0x10(%ebp),%edx
    1d73:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d76:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    1d79:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1d7c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1d7f:	c9                   	leave  
    1d80:	c3                   	ret    

00001d81 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    1d81:	55                   	push   %ebp
    1d82:	89 e5                	mov    %esp,%ebp
    1d84:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    1d87:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d8a:	8b 50 08             	mov    0x8(%eax),%edx
    1d8d:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1d90:	8b 40 0c             	mov    0xc(%eax),%eax
    1d93:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    1d96:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d99:	8b 55 10             	mov    0x10(%ebp),%edx
    1d9c:	89 50 08             	mov    %edx,0x8(%eax)
    1d9f:	8b 55 14             	mov    0x14(%ebp),%edx
    1da2:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    1da5:	8b 45 08             	mov    0x8(%ebp),%eax
    1da8:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1dab:	89 10                	mov    %edx,(%eax)
    1dad:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1db0:	89 50 04             	mov    %edx,0x4(%eax)
}
    1db3:	8b 45 08             	mov    0x8(%ebp),%eax
    1db6:	c9                   	leave  
    1db7:	c2 04 00             	ret    $0x4

00001dba <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    1dba:	55                   	push   %ebp
    1dbb:	89 e5                	mov    %esp,%ebp
    1dbd:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    1dc0:	8b 45 0c             	mov    0xc(%ebp),%eax
    1dc3:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    1dc7:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1dcb:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1dcf:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    1dd2:	8b 45 0c             	mov    0xc(%ebp),%eax
    1dd5:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1dd9:	66 89 50 10          	mov    %dx,0x10(%eax)
    1ddd:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1de1:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    1de4:	8b 45 08             	mov    0x8(%ebp),%eax
    1de7:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1deb:	66 89 10             	mov    %dx,(%eax)
    1dee:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1df2:	88 50 02             	mov    %dl,0x2(%eax)
}
    1df5:	8b 45 08             	mov    0x8(%ebp),%eax
    1df8:	c9                   	leave  
    1df9:	c2 04 00             	ret    $0x4

00001dfc <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
    1dfc:	55                   	push   %ebp
    1dfd:	89 e5                	mov    %esp,%ebp
    1dff:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
    1e02:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e05:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1e09:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1e0d:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1e11:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
    1e14:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e17:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1e1b:	66 89 50 13          	mov    %dx,0x13(%eax)
    1e1f:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1e23:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
    1e26:	8b 45 08             	mov    0x8(%ebp),%eax
    1e29:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1e2d:	66 89 10             	mov    %dx,(%eax)
    1e30:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1e34:	88 50 02             	mov    %dl,0x2(%eax)
}
    1e37:	8b 45 08             	mov    0x8(%ebp),%eax
    1e3a:	c9                   	leave  
    1e3b:	c2 04 00             	ret    $0x4

00001e3e <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    1e3e:	55                   	push   %ebp
    1e3f:	89 e5                	mov    %esp,%ebp
    1e41:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    1e44:	8b 45 08             	mov    0x8(%ebp),%eax
    1e47:	8b 40 0c             	mov    0xc(%eax),%eax
    1e4a:	89 c2                	mov    %eax,%edx
    1e4c:	c1 ea 1f             	shr    $0x1f,%edx
    1e4f:	01 d0                	add    %edx,%eax
    1e51:	d1 f8                	sar    %eax
    1e53:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    1e56:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e59:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    1e5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    1e60:	8b 45 10             	mov    0x10(%ebp),%eax
    1e63:	2b 45 f4             	sub    -0xc(%ebp),%eax
    1e66:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    1e69:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    1e6d:	0f 89 98 00 00 00    	jns    1f0b <APDrawPoint+0xcd>
        i = 0;
    1e73:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    1e7a:	e9 8c 00 00 00       	jmp    1f0b <APDrawPoint+0xcd>
    {
        j = x - off;
    1e7f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e82:	2b 45 f4             	sub    -0xc(%ebp),%eax
    1e85:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    1e88:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1e8c:	79 69                	jns    1ef7 <APDrawPoint+0xb9>
            j = 0;
    1e8e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    1e95:	eb 60                	jmp    1ef7 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    1e97:	ff 75 fc             	pushl  -0x4(%ebp)
    1e9a:	ff 75 f8             	pushl  -0x8(%ebp)
    1e9d:	ff 75 08             	pushl  0x8(%ebp)
    1ea0:	e8 bb fb ff ff       	call   1a60 <APGetIndex>
    1ea5:	83 c4 0c             	add    $0xc,%esp
    1ea8:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    1eab:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    1eaf:	74 55                	je     1f06 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    1eb1:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    1eb5:	74 67                	je     1f1e <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    1eb7:	ff 75 10             	pushl  0x10(%ebp)
    1eba:	ff 75 0c             	pushl  0xc(%ebp)
    1ebd:	ff 75 fc             	pushl  -0x4(%ebp)
    1ec0:	ff 75 f8             	pushl  -0x8(%ebp)
    1ec3:	e8 5f fb ff ff       	call   1a27 <distance_2>
    1ec8:	83 c4 10             	add    $0x10,%esp
    1ecb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1ece:	7f 23                	jg     1ef3 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    1ed0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ed3:	8b 48 18             	mov    0x18(%eax),%ecx
    1ed6:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1ed9:	89 d0                	mov    %edx,%eax
    1edb:	01 c0                	add    %eax,%eax
    1edd:	01 d0                	add    %edx,%eax
    1edf:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1ee2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee5:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1ee9:	66 89 0a             	mov    %cx,(%edx)
    1eec:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1ef0:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1ef3:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1ef7:	8b 55 0c             	mov    0xc(%ebp),%edx
    1efa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1efd:	01 d0                	add    %edx,%eax
    1eff:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1f02:	7d 93                	jge    1e97 <APDrawPoint+0x59>
    1f04:	eb 01                	jmp    1f07 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1f06:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1f07:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1f0b:	8b 55 10             	mov    0x10(%ebp),%edx
    1f0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f11:	01 d0                	add    %edx,%eax
    1f13:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1f16:	0f 8d 63 ff ff ff    	jge    1e7f <APDrawPoint+0x41>
    1f1c:	eb 01                	jmp    1f1f <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1f1e:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    1f1f:	c9                   	leave  
    1f20:	c3                   	ret    

00001f21 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1f21:	55                   	push   %ebp
    1f22:	89 e5                	mov    %esp,%ebp
    1f24:	53                   	push   %ebx
    1f25:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1f28:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f2b:	3b 45 14             	cmp    0x14(%ebp),%eax
    1f2e:	0f 85 80 00 00 00    	jne    1fb4 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1f34:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1f38:	0f 88 9d 02 00 00    	js     21db <APDrawLine+0x2ba>
    1f3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f41:	8b 00                	mov    (%eax),%eax
    1f43:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1f46:	0f 8e 8f 02 00 00    	jle    21db <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    1f4c:	8b 45 10             	mov    0x10(%ebp),%eax
    1f4f:	3b 45 18             	cmp    0x18(%ebp),%eax
    1f52:	7e 12                	jle    1f66 <APDrawLine+0x45>
        {
            int tmp = y2;
    1f54:	8b 45 18             	mov    0x18(%ebp),%eax
    1f57:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    1f5a:	8b 45 10             	mov    0x10(%ebp),%eax
    1f5d:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1f60:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1f63:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1f66:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1f6a:	79 07                	jns    1f73 <APDrawLine+0x52>
    1f6c:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1f73:	8b 45 08             	mov    0x8(%ebp),%eax
    1f76:	8b 40 04             	mov    0x4(%eax),%eax
    1f79:	3b 45 18             	cmp    0x18(%ebp),%eax
    1f7c:	7d 0c                	jge    1f8a <APDrawLine+0x69>
    1f7e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f81:	8b 40 04             	mov    0x4(%eax),%eax
    1f84:	83 e8 01             	sub    $0x1,%eax
    1f87:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    1f8a:	8b 45 10             	mov    0x10(%ebp),%eax
    1f8d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1f90:	eb 15                	jmp    1fa7 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1f92:	ff 75 f4             	pushl  -0xc(%ebp)
    1f95:	ff 75 0c             	pushl  0xc(%ebp)
    1f98:	ff 75 08             	pushl  0x8(%ebp)
    1f9b:	e8 9e fe ff ff       	call   1e3e <APDrawPoint>
    1fa0:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1fa3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1fa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1faa:	3b 45 18             	cmp    0x18(%ebp),%eax
    1fad:	7e e3                	jle    1f92 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    1faf:	e9 2b 02 00 00       	jmp    21df <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1fb4:	8b 45 10             	mov    0x10(%ebp),%eax
    1fb7:	3b 45 18             	cmp    0x18(%ebp),%eax
    1fba:	75 7f                	jne    203b <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    1fbc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1fc0:	0f 88 18 02 00 00    	js     21de <APDrawLine+0x2bd>
    1fc6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc9:	8b 40 04             	mov    0x4(%eax),%eax
    1fcc:	3b 45 10             	cmp    0x10(%ebp),%eax
    1fcf:	0f 8e 09 02 00 00    	jle    21de <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1fd5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fd8:	3b 45 14             	cmp    0x14(%ebp),%eax
    1fdb:	7e 12                	jle    1fef <APDrawLine+0xce>
        {
            int tmp = x2;
    1fdd:	8b 45 14             	mov    0x14(%ebp),%eax
    1fe0:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fe6:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1fe9:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1fec:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1fef:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1ff3:	79 07                	jns    1ffc <APDrawLine+0xdb>
    1ff5:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1ffc:	8b 45 08             	mov    0x8(%ebp),%eax
    1fff:	8b 00                	mov    (%eax),%eax
    2001:	3b 45 14             	cmp    0x14(%ebp),%eax
    2004:	7d 0b                	jge    2011 <APDrawLine+0xf0>
    2006:	8b 45 08             	mov    0x8(%ebp),%eax
    2009:	8b 00                	mov    (%eax),%eax
    200b:	83 e8 01             	sub    $0x1,%eax
    200e:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    2011:	8b 45 0c             	mov    0xc(%ebp),%eax
    2014:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2017:	eb 15                	jmp    202e <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    2019:	ff 75 10             	pushl  0x10(%ebp)
    201c:	ff 75 f0             	pushl  -0x10(%ebp)
    201f:	ff 75 08             	pushl  0x8(%ebp)
    2022:	e8 17 fe ff ff       	call   1e3e <APDrawPoint>
    2027:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    202a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    202e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2031:	3b 45 14             	cmp    0x14(%ebp),%eax
    2034:	7e e3                	jle    2019 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    2036:	e9 a4 01 00 00       	jmp    21df <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    203b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2042:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    2049:	8b 45 0c             	mov    0xc(%ebp),%eax
    204c:	2b 45 14             	sub    0x14(%ebp),%eax
    204f:	50                   	push   %eax
    2050:	e8 fb f9 ff ff       	call   1a50 <abs_int>
    2055:	83 c4 04             	add    $0x4,%esp
    2058:	89 c3                	mov    %eax,%ebx
    205a:	8b 45 10             	mov    0x10(%ebp),%eax
    205d:	2b 45 18             	sub    0x18(%ebp),%eax
    2060:	50                   	push   %eax
    2061:	e8 ea f9 ff ff       	call   1a50 <abs_int>
    2066:	83 c4 04             	add    $0x4,%esp
    2069:	39 c3                	cmp    %eax,%ebx
    206b:	0f 8e b5 00 00 00    	jle    2126 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    2071:	8b 45 10             	mov    0x10(%ebp),%eax
    2074:	2b 45 18             	sub    0x18(%ebp),%eax
    2077:	89 45 b0             	mov    %eax,-0x50(%ebp)
    207a:	db 45 b0             	fildl  -0x50(%ebp)
    207d:	8b 45 0c             	mov    0xc(%ebp),%eax
    2080:	2b 45 14             	sub    0x14(%ebp),%eax
    2083:	89 45 b0             	mov    %eax,-0x50(%ebp)
    2086:	db 45 b0             	fildl  -0x50(%ebp)
    2089:	de f9                	fdivrp %st,%st(1)
    208b:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    208e:	8b 45 14             	mov    0x14(%ebp),%eax
    2091:	3b 45 0c             	cmp    0xc(%ebp),%eax
    2094:	7e 0e                	jle    20a4 <APDrawLine+0x183>
        {
            s = x1;
    2096:	8b 45 0c             	mov    0xc(%ebp),%eax
    2099:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    209c:	8b 45 14             	mov    0x14(%ebp),%eax
    209f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    20a2:	eb 0c                	jmp    20b0 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    20a4:	8b 45 14             	mov    0x14(%ebp),%eax
    20a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    20aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    20ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    20b0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    20b4:	79 07                	jns    20bd <APDrawLine+0x19c>
    20b6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    20bd:	8b 45 08             	mov    0x8(%ebp),%eax
    20c0:	8b 00                	mov    (%eax),%eax
    20c2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    20c5:	7f 0b                	jg     20d2 <APDrawLine+0x1b1>
    20c7:	8b 45 08             	mov    0x8(%ebp),%eax
    20ca:	8b 00                	mov    (%eax),%eax
    20cc:	83 e8 01             	sub    $0x1,%eax
    20cf:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    20d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    20d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    20d8:	eb 3f                	jmp    2119 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    20da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20dd:	2b 45 0c             	sub    0xc(%ebp),%eax
    20e0:	89 45 b0             	mov    %eax,-0x50(%ebp)
    20e3:	db 45 b0             	fildl  -0x50(%ebp)
    20e6:	dc 4d d0             	fmull  -0x30(%ebp)
    20e9:	db 45 10             	fildl  0x10(%ebp)
    20ec:	de c1                	faddp  %st,%st(1)
    20ee:	d9 7d b6             	fnstcw -0x4a(%ebp)
    20f1:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    20f5:	b4 0c                	mov    $0xc,%ah
    20f7:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    20fb:	d9 6d b4             	fldcw  -0x4c(%ebp)
    20fe:	db 5d cc             	fistpl -0x34(%ebp)
    2101:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    2104:	ff 75 cc             	pushl  -0x34(%ebp)
    2107:	ff 75 e4             	pushl  -0x1c(%ebp)
    210a:	ff 75 08             	pushl  0x8(%ebp)
    210d:	e8 2c fd ff ff       	call   1e3e <APDrawPoint>
    2112:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    2115:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2119:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    211c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    211f:	7e b9                	jle    20da <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    2121:	e9 b9 00 00 00       	jmp    21df <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    2126:	8b 45 0c             	mov    0xc(%ebp),%eax
    2129:	2b 45 14             	sub    0x14(%ebp),%eax
    212c:	89 45 b0             	mov    %eax,-0x50(%ebp)
    212f:	db 45 b0             	fildl  -0x50(%ebp)
    2132:	8b 45 10             	mov    0x10(%ebp),%eax
    2135:	2b 45 18             	sub    0x18(%ebp),%eax
    2138:	89 45 b0             	mov    %eax,-0x50(%ebp)
    213b:	db 45 b0             	fildl  -0x50(%ebp)
    213e:	de f9                	fdivrp %st,%st(1)
    2140:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    2143:	8b 45 10             	mov    0x10(%ebp),%eax
    2146:	3b 45 18             	cmp    0x18(%ebp),%eax
    2149:	7e 0e                	jle    2159 <APDrawLine+0x238>
    {
        s = y2;
    214b:	8b 45 18             	mov    0x18(%ebp),%eax
    214e:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    2151:	8b 45 10             	mov    0x10(%ebp),%eax
    2154:	89 45 e8             	mov    %eax,-0x18(%ebp)
    2157:	eb 0c                	jmp    2165 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    2159:	8b 45 10             	mov    0x10(%ebp),%eax
    215c:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    215f:	8b 45 18             	mov    0x18(%ebp),%eax
    2162:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    2165:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2169:	79 07                	jns    2172 <APDrawLine+0x251>
    216b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    2172:	8b 45 08             	mov    0x8(%ebp),%eax
    2175:	8b 40 04             	mov    0x4(%eax),%eax
    2178:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    217b:	7f 0c                	jg     2189 <APDrawLine+0x268>
    217d:	8b 45 08             	mov    0x8(%ebp),%eax
    2180:	8b 40 04             	mov    0x4(%eax),%eax
    2183:	83 e8 01             	sub    $0x1,%eax
    2186:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    2189:	8b 45 ec             	mov    -0x14(%ebp),%eax
    218c:	89 45 e0             	mov    %eax,-0x20(%ebp)
    218f:	eb 3f                	jmp    21d0 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    2191:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2194:	2b 45 10             	sub    0x10(%ebp),%eax
    2197:	89 45 b0             	mov    %eax,-0x50(%ebp)
    219a:	db 45 b0             	fildl  -0x50(%ebp)
    219d:	dc 4d c0             	fmull  -0x40(%ebp)
    21a0:	db 45 0c             	fildl  0xc(%ebp)
    21a3:	de c1                	faddp  %st,%st(1)
    21a5:	d9 7d b6             	fnstcw -0x4a(%ebp)
    21a8:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    21ac:	b4 0c                	mov    $0xc,%ah
    21ae:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    21b2:	d9 6d b4             	fldcw  -0x4c(%ebp)
    21b5:	db 5d bc             	fistpl -0x44(%ebp)
    21b8:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    21bb:	ff 75 e0             	pushl  -0x20(%ebp)
    21be:	ff 75 bc             	pushl  -0x44(%ebp)
    21c1:	ff 75 08             	pushl  0x8(%ebp)
    21c4:	e8 75 fc ff ff       	call   1e3e <APDrawPoint>
    21c9:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    21cc:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    21d0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    21d3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    21d6:	7e b9                	jle    2191 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    21d8:	90                   	nop
    21d9:	eb 04                	jmp    21df <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    21db:	90                   	nop
    21dc:	eb 01                	jmp    21df <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    21de:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    21df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    21e2:	c9                   	leave  
    21e3:	c3                   	ret    

000021e4 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    21e4:	55                   	push   %ebp
    21e5:	89 e5                	mov    %esp,%ebp
    21e7:	53                   	push   %ebx
    21e8:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    21eb:	8b 55 10             	mov    0x10(%ebp),%edx
    21ee:	8b 45 18             	mov    0x18(%ebp),%eax
    21f1:	01 d0                	add    %edx,%eax
    21f3:	83 e8 01             	sub    $0x1,%eax
    21f6:	83 ec 04             	sub    $0x4,%esp
    21f9:	50                   	push   %eax
    21fa:	ff 75 0c             	pushl  0xc(%ebp)
    21fd:	ff 75 10             	pushl  0x10(%ebp)
    2200:	ff 75 0c             	pushl  0xc(%ebp)
    2203:	ff 75 08             	pushl  0x8(%ebp)
    2206:	e8 16 fd ff ff       	call   1f21 <APDrawLine>
    220b:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    220e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2211:	8b 45 14             	mov    0x14(%ebp),%eax
    2214:	01 d0                	add    %edx,%eax
    2216:	83 e8 01             	sub    $0x1,%eax
    2219:	83 ec 04             	sub    $0x4,%esp
    221c:	ff 75 10             	pushl  0x10(%ebp)
    221f:	50                   	push   %eax
    2220:	ff 75 10             	pushl  0x10(%ebp)
    2223:	ff 75 0c             	pushl  0xc(%ebp)
    2226:	ff 75 08             	pushl  0x8(%ebp)
    2229:	e8 f3 fc ff ff       	call   1f21 <APDrawLine>
    222e:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    2231:	8b 55 10             	mov    0x10(%ebp),%edx
    2234:	8b 45 18             	mov    0x18(%ebp),%eax
    2237:	01 d0                	add    %edx,%eax
    2239:	8d 48 ff             	lea    -0x1(%eax),%ecx
    223c:	8b 55 0c             	mov    0xc(%ebp),%edx
    223f:	8b 45 14             	mov    0x14(%ebp),%eax
    2242:	01 d0                	add    %edx,%eax
    2244:	8d 50 ff             	lea    -0x1(%eax),%edx
    2247:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    224a:	8b 45 14             	mov    0x14(%ebp),%eax
    224d:	01 d8                	add    %ebx,%eax
    224f:	83 e8 01             	sub    $0x1,%eax
    2252:	83 ec 04             	sub    $0x4,%esp
    2255:	51                   	push   %ecx
    2256:	52                   	push   %edx
    2257:	ff 75 10             	pushl  0x10(%ebp)
    225a:	50                   	push   %eax
    225b:	ff 75 08             	pushl  0x8(%ebp)
    225e:	e8 be fc ff ff       	call   1f21 <APDrawLine>
    2263:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    2266:	8b 55 10             	mov    0x10(%ebp),%edx
    2269:	8b 45 18             	mov    0x18(%ebp),%eax
    226c:	01 d0                	add    %edx,%eax
    226e:	8d 48 ff             	lea    -0x1(%eax),%ecx
    2271:	8b 55 0c             	mov    0xc(%ebp),%edx
    2274:	8b 45 14             	mov    0x14(%ebp),%eax
    2277:	01 d0                	add    %edx,%eax
    2279:	8d 50 ff             	lea    -0x1(%eax),%edx
    227c:	8b 5d 10             	mov    0x10(%ebp),%ebx
    227f:	8b 45 18             	mov    0x18(%ebp),%eax
    2282:	01 d8                	add    %ebx,%eax
    2284:	83 e8 01             	sub    $0x1,%eax
    2287:	83 ec 04             	sub    $0x4,%esp
    228a:	51                   	push   %ecx
    228b:	52                   	push   %edx
    228c:	50                   	push   %eax
    228d:	ff 75 0c             	pushl  0xc(%ebp)
    2290:	ff 75 08             	pushl  0x8(%ebp)
    2293:	e8 89 fc ff ff       	call   1f21 <APDrawLine>
    2298:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    229b:	8b 55 0c             	mov    0xc(%ebp),%edx
    229e:	8b 45 14             	mov    0x14(%ebp),%eax
    22a1:	01 d0                	add    %edx,%eax
    22a3:	8d 50 ff             	lea    -0x1(%eax),%edx
    22a6:	8b 45 08             	mov    0x8(%ebp),%eax
    22a9:	8b 40 0c             	mov    0xc(%eax),%eax
    22ac:	89 c1                	mov    %eax,%ecx
    22ae:	c1 e9 1f             	shr    $0x1f,%ecx
    22b1:	01 c8                	add    %ecx,%eax
    22b3:	d1 f8                	sar    %eax
    22b5:	29 c2                	sub    %eax,%edx
    22b7:	89 d0                	mov    %edx,%eax
    22b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    22bc:	8b 55 10             	mov    0x10(%ebp),%edx
    22bf:	8b 45 18             	mov    0x18(%ebp),%eax
    22c2:	01 d0                	add    %edx,%eax
    22c4:	8d 50 ff             	lea    -0x1(%eax),%edx
    22c7:	8b 45 08             	mov    0x8(%ebp),%eax
    22ca:	8b 40 0c             	mov    0xc(%eax),%eax
    22cd:	89 c1                	mov    %eax,%ecx
    22cf:	c1 e9 1f             	shr    $0x1f,%ecx
    22d2:	01 c8                	add    %ecx,%eax
    22d4:	d1 f8                	sar    %eax
    22d6:	29 c2                	sub    %eax,%edx
    22d8:	89 d0                	mov    %edx,%eax
    22da:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    22dd:	8b 45 08             	mov    0x8(%ebp),%eax
    22e0:	8b 40 0c             	mov    0xc(%eax),%eax
    22e3:	89 c2                	mov    %eax,%edx
    22e5:	c1 ea 1f             	shr    $0x1f,%edx
    22e8:	01 d0                	add    %edx,%eax
    22ea:	d1 f8                	sar    %eax
    22ec:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    22ef:	8b 45 08             	mov    0x8(%ebp),%eax
    22f2:	8b 40 0c             	mov    0xc(%eax),%eax
    22f5:	89 c2                	mov    %eax,%edx
    22f7:	c1 ea 1f             	shr    $0x1f,%edx
    22fa:	01 d0                	add    %edx,%eax
    22fc:	d1 f8                	sar    %eax
    22fe:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    2301:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2305:	0f 88 d8 00 00 00    	js     23e3 <APDrawRect+0x1ff>
    230b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    230f:	0f 88 ce 00 00 00    	js     23e3 <APDrawRect+0x1ff>
    2315:	8b 45 08             	mov    0x8(%ebp),%eax
    2318:	8b 00                	mov    (%eax),%eax
    231a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    231d:	0f 8e c0 00 00 00    	jle    23e3 <APDrawRect+0x1ff>
    2323:	8b 45 08             	mov    0x8(%ebp),%eax
    2326:	8b 40 04             	mov    0x4(%eax),%eax
    2329:	3b 45 10             	cmp    0x10(%ebp),%eax
    232c:	0f 8e b1 00 00 00    	jle    23e3 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    2332:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    2336:	79 07                	jns    233f <APDrawRect+0x15b>
    2338:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    233f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2343:	79 07                	jns    234c <APDrawRect+0x168>
    2345:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    234c:	8b 45 08             	mov    0x8(%ebp),%eax
    234f:	8b 00                	mov    (%eax),%eax
    2351:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2354:	7f 0b                	jg     2361 <APDrawRect+0x17d>
    2356:	8b 45 08             	mov    0x8(%ebp),%eax
    2359:	8b 00                	mov    (%eax),%eax
    235b:	83 e8 01             	sub    $0x1,%eax
    235e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    2361:	8b 45 08             	mov    0x8(%ebp),%eax
    2364:	8b 40 04             	mov    0x4(%eax),%eax
    2367:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    236a:	7f 0c                	jg     2378 <APDrawRect+0x194>
    236c:	8b 45 08             	mov    0x8(%ebp),%eax
    236f:	8b 40 04             	mov    0x4(%eax),%eax
    2372:	83 e8 01             	sub    $0x1,%eax
    2375:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    2378:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    237f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2382:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2385:	eb 52                	jmp    23d9 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    2387:	8b 45 10             	mov    0x10(%ebp),%eax
    238a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    238d:	eb 3e                	jmp    23cd <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    238f:	83 ec 04             	sub    $0x4,%esp
    2392:	ff 75 e8             	pushl  -0x18(%ebp)
    2395:	ff 75 ec             	pushl  -0x14(%ebp)
    2398:	ff 75 08             	pushl  0x8(%ebp)
    239b:	e8 c0 f6 ff ff       	call   1a60 <APGetIndex>
    23a0:	83 c4 10             	add    $0x10,%esp
    23a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    23a6:	8b 45 08             	mov    0x8(%ebp),%eax
    23a9:	8b 48 18             	mov    0x18(%eax),%ecx
    23ac:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    23af:	89 d0                	mov    %edx,%eax
    23b1:	01 c0                	add    %eax,%eax
    23b3:	01 d0                	add    %edx,%eax
    23b5:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    23b8:	8b 45 08             	mov    0x8(%ebp),%eax
    23bb:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    23bf:	66 89 0a             	mov    %cx,(%edx)
    23c2:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    23c6:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    23c9:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    23cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    23d0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    23d3:	7e ba                	jle    238f <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    23d5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    23d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23dc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    23df:	7e a6                	jle    2387 <APDrawRect+0x1a3>
    23e1:	eb 01                	jmp    23e4 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    23e3:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    23e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    23e7:	c9                   	leave  
    23e8:	c3                   	ret    

000023e9 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    23e9:	55                   	push   %ebp
    23ea:	89 e5                	mov    %esp,%ebp
    23ec:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    23ef:	83 ec 0c             	sub    $0xc,%esp
    23f2:	ff 75 0c             	pushl  0xc(%ebp)
    23f5:	e8 b1 ee ff ff       	call   12ab <strlen>
    23fa:	83 c4 10             	add    $0x10,%esp
    23fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    2400:	8b 45 08             	mov    0x8(%ebp),%eax
    2403:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    2407:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    240b:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    240f:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    2412:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    2419:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2420:	e9 bc 00 00 00       	jmp    24e1 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    2425:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2428:	8b 45 0c             	mov    0xc(%ebp),%eax
    242b:	01 d0                	add    %edx,%eax
    242d:	0f b6 00             	movzbl (%eax),%eax
    2430:	0f be c0             	movsbl %al,%eax
    2433:	83 e8 20             	sub    $0x20,%eax
    2436:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    2439:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    243d:	0f 87 9a 00 00 00    	ja     24dd <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    2443:	8b 45 08             	mov    0x8(%ebp),%eax
    2446:	8b 00                	mov    (%eax),%eax
    2448:	0f af 45 14          	imul   0x14(%ebp),%eax
    244c:	89 c2                	mov    %eax,%edx
    244e:	8b 45 10             	mov    0x10(%ebp),%eax
    2451:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    2454:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2457:	89 d0                	mov    %edx,%eax
    2459:	c1 e0 03             	shl    $0x3,%eax
    245c:	01 d0                	add    %edx,%eax
    245e:	01 c8                	add    %ecx,%eax
    2460:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    2463:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    246a:	eb 6b                	jmp    24d7 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    246c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    2473:	eb 50                	jmp    24c5 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    2475:	8b 55 ec             	mov    -0x14(%ebp),%edx
    2478:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    247b:	89 d0                	mov    %edx,%eax
    247d:	c1 e0 03             	shl    $0x3,%eax
    2480:	01 d0                	add    %edx,%eax
    2482:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    2488:	01 c2                	add    %eax,%edx
    248a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    248d:	01 d0                	add    %edx,%eax
    248f:	05 80 42 00 00       	add    $0x4280,%eax
    2494:	0f b6 00             	movzbl (%eax),%eax
    2497:	84 c0                	test   %al,%al
    2499:	74 26                	je     24c1 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    249b:	8b 45 08             	mov    0x8(%ebp),%eax
    249e:	8b 50 18             	mov    0x18(%eax),%edx
    24a1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    24a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    24a7:	01 c8                	add    %ecx,%eax
    24a9:	89 c1                	mov    %eax,%ecx
    24ab:	89 c8                	mov    %ecx,%eax
    24ad:	01 c0                	add    %eax,%eax
    24af:	01 c8                	add    %ecx,%eax
    24b1:	01 d0                	add    %edx,%eax
    24b3:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    24b7:	66 89 10             	mov    %dx,(%eax)
    24ba:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    24be:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    24c1:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    24c5:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    24c9:	7e aa                	jle    2475 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    24cb:	8b 45 08             	mov    0x8(%ebp),%eax
    24ce:	8b 00                	mov    (%eax),%eax
    24d0:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    24d3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    24d7:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    24db:	7e 8f                	jle    246c <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    24dd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    24e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24e4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    24e7:	0f 82 38 ff ff ff    	jb     2425 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    24ed:	90                   	nop
    24ee:	c9                   	leave  
    24ef:	c3                   	ret    

000024f0 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    24f0:	55                   	push   %ebp
    24f1:	89 e5                	mov    %esp,%ebp
    24f3:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    24f6:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    24fa:	0f 88 8e 01 00 00    	js     268e <APDcCopy+0x19e>
    2500:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    2504:	0f 88 84 01 00 00    	js     268e <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    250a:	8b 55 0c             	mov    0xc(%ebp),%edx
    250d:	8b 45 20             	mov    0x20(%ebp),%eax
    2510:	01 d0                	add    %edx,%eax
    2512:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2515:	8b 55 10             	mov    0x10(%ebp),%edx
    2518:	8b 45 24             	mov    0x24(%ebp),%eax
    251b:	01 d0                	add    %edx,%eax
    251d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    2520:	8b 55 18             	mov    0x18(%ebp),%edx
    2523:	8b 45 20             	mov    0x20(%ebp),%eax
    2526:	01 d0                	add    %edx,%eax
    2528:	89 45 ec             	mov    %eax,-0x14(%ebp)
    252b:	8b 55 1c             	mov    0x1c(%ebp),%edx
    252e:	8b 45 24             	mov    0x24(%ebp),%eax
    2531:	01 d0                	add    %edx,%eax
    2533:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    2536:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    253a:	0f 88 51 01 00 00    	js     2691 <APDcCopy+0x1a1>
    2540:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2544:	0f 88 47 01 00 00    	js     2691 <APDcCopy+0x1a1>
    254a:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    254e:	0f 88 3d 01 00 00    	js     2691 <APDcCopy+0x1a1>
    2554:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2558:	0f 88 33 01 00 00    	js     2691 <APDcCopy+0x1a1>
    255e:	8b 45 14             	mov    0x14(%ebp),%eax
    2561:	8b 00                	mov    (%eax),%eax
    2563:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    2566:	0f 8c 25 01 00 00    	jl     2691 <APDcCopy+0x1a1>
    256c:	8b 45 14             	mov    0x14(%ebp),%eax
    256f:	8b 40 04             	mov    0x4(%eax),%eax
    2572:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    2575:	0f 8c 16 01 00 00    	jl     2691 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    257b:	8b 45 08             	mov    0x8(%ebp),%eax
    257e:	8b 00                	mov    (%eax),%eax
    2580:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2583:	7f 0b                	jg     2590 <APDcCopy+0xa0>
    2585:	8b 45 08             	mov    0x8(%ebp),%eax
    2588:	8b 00                	mov    (%eax),%eax
    258a:	83 e8 01             	sub    $0x1,%eax
    258d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    2590:	8b 45 08             	mov    0x8(%ebp),%eax
    2593:	8b 40 04             	mov    0x4(%eax),%eax
    2596:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2599:	7f 0c                	jg     25a7 <APDcCopy+0xb7>
    259b:	8b 45 08             	mov    0x8(%ebp),%eax
    259e:	8b 40 04             	mov    0x4(%eax),%eax
    25a1:	83 e8 01             	sub    $0x1,%eax
    25a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    25a7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    25ae:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    25b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    25bc:	e9 bc 00 00 00       	jmp    267d <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    25c1:	8b 45 08             	mov    0x8(%ebp),%eax
    25c4:	8b 00                	mov    (%eax),%eax
    25c6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    25c9:	8b 55 10             	mov    0x10(%ebp),%edx
    25cc:	01 ca                	add    %ecx,%edx
    25ce:	0f af d0             	imul   %eax,%edx
    25d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    25d4:	01 d0                	add    %edx,%eax
    25d6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    25d9:	8b 45 14             	mov    0x14(%ebp),%eax
    25dc:	8b 00                	mov    (%eax),%eax
    25de:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    25e1:	8b 55 1c             	mov    0x1c(%ebp),%edx
    25e4:	01 ca                	add    %ecx,%edx
    25e6:	0f af d0             	imul   %eax,%edx
    25e9:	8b 45 18             	mov    0x18(%ebp),%eax
    25ec:	01 d0                	add    %edx,%eax
    25ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    25f1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    25f8:	eb 74                	jmp    266e <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    25fa:	8b 45 14             	mov    0x14(%ebp),%eax
    25fd:	8b 50 18             	mov    0x18(%eax),%edx
    2600:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    2603:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2606:	01 c8                	add    %ecx,%eax
    2608:	89 c1                	mov    %eax,%ecx
    260a:	89 c8                	mov    %ecx,%eax
    260c:	01 c0                	add    %eax,%eax
    260e:	01 c8                	add    %ecx,%eax
    2610:	01 d0                	add    %edx,%eax
    2612:	0f b7 10             	movzwl (%eax),%edx
    2615:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    2619:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    261d:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    2620:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    2624:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    2628:	38 c2                	cmp    %al,%dl
    262a:	75 18                	jne    2644 <APDcCopy+0x154>
    262c:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    2630:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    2634:	38 c2                	cmp    %al,%dl
    2636:	75 0c                	jne    2644 <APDcCopy+0x154>
    2638:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    263c:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    2640:	38 c2                	cmp    %al,%dl
    2642:	74 26                	je     266a <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    2644:	8b 45 08             	mov    0x8(%ebp),%eax
    2647:	8b 50 18             	mov    0x18(%eax),%edx
    264a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    264d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2650:	01 c8                	add    %ecx,%eax
    2652:	89 c1                	mov    %eax,%ecx
    2654:	89 c8                	mov    %ecx,%eax
    2656:	01 c0                	add    %eax,%eax
    2658:	01 c8                	add    %ecx,%eax
    265a:	01 d0                	add    %edx,%eax
    265c:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    2660:	66 89 10             	mov    %dx,(%eax)
    2663:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    2667:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    266a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    266e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2671:	2b 45 0c             	sub    0xc(%ebp),%eax
    2674:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    2677:	7d 81                	jge    25fa <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    2679:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    267d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2680:	2b 45 10             	sub    0x10(%ebp),%eax
    2683:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2686:	0f 8d 35 ff ff ff    	jge    25c1 <APDcCopy+0xd1>
    268c:	eb 04                	jmp    2692 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    268e:	90                   	nop
    268f:	eb 01                	jmp    2692 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    2691:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    2692:	c9                   	leave  
    2693:	c3                   	ret    

00002694 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    2694:	55                   	push   %ebp
    2695:	89 e5                	mov    %esp,%ebp
    2697:	83 ec 1c             	sub    $0x1c,%esp
    269a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    269d:	8b 55 10             	mov    0x10(%ebp),%edx
    26a0:	8b 45 14             	mov    0x14(%ebp),%eax
    26a3:	88 4d ec             	mov    %cl,-0x14(%ebp)
    26a6:	88 55 e8             	mov    %dl,-0x18(%ebp)
    26a9:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    26ac:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    26b0:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    26b3:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    26b7:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    26ba:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    26be:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    26c1:	8b 45 08             	mov    0x8(%ebp),%eax
    26c4:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    26c8:	66 89 10             	mov    %dx,(%eax)
    26cb:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    26cf:	88 50 02             	mov    %dl,0x2(%eax)
}
    26d2:	8b 45 08             	mov    0x8(%ebp),%eax
    26d5:	c9                   	leave  
    26d6:	c2 04 00             	ret    $0x4

000026d9 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    26d9:	55                   	push   %ebp
    26da:	89 e5                	mov    %esp,%ebp
    26dc:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    26df:	8b 45 08             	mov    0x8(%ebp),%eax
    26e2:	8b 00                	mov    (%eax),%eax
    26e4:	83 ec 08             	sub    $0x8,%esp
    26e7:	8d 55 0c             	lea    0xc(%ebp),%edx
    26ea:	52                   	push   %edx
    26eb:	50                   	push   %eax
    26ec:	e8 24 ee ff ff       	call   1515 <sendMessage>
    26f1:	83 c4 10             	add    $0x10,%esp
}
    26f4:	90                   	nop
    26f5:	c9                   	leave  
    26f6:	c3                   	ret    

000026f7 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    26f7:	55                   	push   %ebp
    26f8:	89 e5                	mov    %esp,%ebp
    26fa:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    26fd:	83 ec 0c             	sub    $0xc,%esp
    2700:	68 9c 00 00 00       	push   $0x9c
    2705:	e8 f5 f1 ff ff       	call   18ff <malloc>
    270a:	83 c4 10             	add    $0x10,%esp
    270d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    2710:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2714:	75 15                	jne    272b <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    2716:	83 ec 04             	sub    $0x4,%esp
    2719:	ff 75 08             	pushl  0x8(%ebp)
    271c:	68 c0 39 00 00       	push   $0x39c0
    2721:	6a 01                	push   $0x1
    2723:	e8 04 ef ff ff       	call   162c <printf>
    2728:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    272b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    272e:	05 88 00 00 00       	add    $0x88,%eax
    2733:	83 ec 08             	sub    $0x8,%esp
    2736:	ff 75 08             	pushl  0x8(%ebp)
    2739:	50                   	push   %eax
    273a:	e8 fd ea ff ff       	call   123c <strcpy>
    273f:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    2742:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2745:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    274c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    274f:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    2756:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2759:	8b 40 3c             	mov    0x3c(%eax),%eax
    275c:	89 c2                	mov    %eax,%edx
    275e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2761:	8b 40 40             	mov    0x40(%eax),%eax
    2764:	0f af d0             	imul   %eax,%edx
    2767:	89 d0                	mov    %edx,%eax
    2769:	01 c0                	add    %eax,%eax
    276b:	01 d0                	add    %edx,%eax
    276d:	83 ec 0c             	sub    $0xc,%esp
    2770:	50                   	push   %eax
    2771:	e8 89 f1 ff ff       	call   18ff <malloc>
    2776:	83 c4 10             	add    $0x10,%esp
    2779:	89 c2                	mov    %eax,%edx
    277b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    277e:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    2781:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2784:	8b 40 54             	mov    0x54(%eax),%eax
    2787:	85 c0                	test   %eax,%eax
    2789:	75 15                	jne    27a0 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    278b:	83 ec 04             	sub    $0x4,%esp
    278e:	ff 75 08             	pushl  0x8(%ebp)
    2791:	68 e0 39 00 00       	push   $0x39e0
    2796:	6a 01                	push   $0x1
    2798:	e8 8f ee ff ff       	call   162c <printf>
    279d:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    27a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27a3:	8b 40 3c             	mov    0x3c(%eax),%eax
    27a6:	89 c2                	mov    %eax,%edx
    27a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27ab:	8b 40 40             	mov    0x40(%eax),%eax
    27ae:	0f af d0             	imul   %eax,%edx
    27b1:	89 d0                	mov    %edx,%eax
    27b3:	01 c0                	add    %eax,%eax
    27b5:	01 c2                	add    %eax,%edx
    27b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27ba:	8b 40 54             	mov    0x54(%eax),%eax
    27bd:	83 ec 04             	sub    $0x4,%esp
    27c0:	52                   	push   %edx
    27c1:	68 ff ff ff 00       	push   $0xffffff
    27c6:	50                   	push   %eax
    27c7:	e8 06 eb ff ff       	call   12d2 <memset>
    27cc:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    27cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27d2:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    27d9:	e8 0f ed ff ff       	call   14ed <getpid>
    27de:	89 c2                	mov    %eax,%edx
    27e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27e3:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    27e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27e9:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    27f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27f3:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    27fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27fd:	8b 40 58             	mov    0x58(%eax),%eax
    2800:	89 c2                	mov    %eax,%edx
    2802:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2805:	8b 40 5c             	mov    0x5c(%eax),%eax
    2808:	0f af d0             	imul   %eax,%edx
    280b:	89 d0                	mov    %edx,%eax
    280d:	01 c0                	add    %eax,%eax
    280f:	01 d0                	add    %edx,%eax
    2811:	83 ec 0c             	sub    $0xc,%esp
    2814:	50                   	push   %eax
    2815:	e8 e5 f0 ff ff       	call   18ff <malloc>
    281a:	83 c4 10             	add    $0x10,%esp
    281d:	89 c2                	mov    %eax,%edx
    281f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2822:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    2825:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2828:	8b 40 70             	mov    0x70(%eax),%eax
    282b:	85 c0                	test   %eax,%eax
    282d:	75 15                	jne    2844 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    282f:	83 ec 04             	sub    $0x4,%esp
    2832:	ff 75 08             	pushl  0x8(%ebp)
    2835:	68 04 3a 00 00       	push   $0x3a04
    283a:	6a 01                	push   $0x1
    283c:	e8 eb ed ff ff       	call   162c <printf>
    2841:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    2844:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2847:	8b 40 3c             	mov    0x3c(%eax),%eax
    284a:	89 c2                	mov    %eax,%edx
    284c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    284f:	8b 40 40             	mov    0x40(%eax),%eax
    2852:	0f af d0             	imul   %eax,%edx
    2855:	89 d0                	mov    %edx,%eax
    2857:	01 c0                	add    %eax,%eax
    2859:	01 c2                	add    %eax,%edx
    285b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    285e:	8b 40 54             	mov    0x54(%eax),%eax
    2861:	83 ec 04             	sub    $0x4,%esp
    2864:	52                   	push   %edx
    2865:	68 ff 00 00 00       	push   $0xff
    286a:	50                   	push   %eax
    286b:	e8 62 ea ff ff       	call   12d2 <memset>
    2870:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    2873:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2876:	8b 55 0c             	mov    0xc(%ebp),%edx
    2879:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    287c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    2880:	74 49                	je     28cb <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    2882:	8b 45 10             	mov    0x10(%ebp),%eax
    2885:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    288b:	83 ec 0c             	sub    $0xc,%esp
    288e:	50                   	push   %eax
    288f:	e8 6b f0 ff ff       	call   18ff <malloc>
    2894:	83 c4 10             	add    $0x10,%esp
    2897:	89 c2                	mov    %eax,%edx
    2899:	8b 45 f4             	mov    -0xc(%ebp),%eax
    289c:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    289f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28a2:	8b 55 10             	mov    0x10(%ebp),%edx
    28a5:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    28a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28ab:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    28b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28b5:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    28bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28bf:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    28c6:	e9 8d 00 00 00       	jmp    2958 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    28cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28ce:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    28d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28d8:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    28df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28e2:	8b 40 20             	mov    0x20(%eax),%eax
    28e5:	89 c2                	mov    %eax,%edx
    28e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28ea:	8b 40 24             	mov    0x24(%eax),%eax
    28ed:	0f af d0             	imul   %eax,%edx
    28f0:	89 d0                	mov    %edx,%eax
    28f2:	01 c0                	add    %eax,%eax
    28f4:	01 d0                	add    %edx,%eax
    28f6:	83 ec 0c             	sub    $0xc,%esp
    28f9:	50                   	push   %eax
    28fa:	e8 00 f0 ff ff       	call   18ff <malloc>
    28ff:	83 c4 10             	add    $0x10,%esp
    2902:	89 c2                	mov    %eax,%edx
    2904:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2907:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    290a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    290d:	8b 40 38             	mov    0x38(%eax),%eax
    2910:	85 c0                	test   %eax,%eax
    2912:	75 15                	jne    2929 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    2914:	83 ec 04             	sub    $0x4,%esp
    2917:	ff 75 08             	pushl  0x8(%ebp)
    291a:	68 2c 3a 00 00       	push   $0x3a2c
    291f:	6a 01                	push   $0x1
    2921:	e8 06 ed ff ff       	call   162c <printf>
    2926:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    2929:	8b 45 f4             	mov    -0xc(%ebp),%eax
    292c:	8b 40 20             	mov    0x20(%eax),%eax
    292f:	89 c2                	mov    %eax,%edx
    2931:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2934:	8b 40 24             	mov    0x24(%eax),%eax
    2937:	0f af d0             	imul   %eax,%edx
    293a:	89 d0                	mov    %edx,%eax
    293c:	01 c0                	add    %eax,%eax
    293e:	01 c2                	add    %eax,%edx
    2940:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2943:	8b 40 38             	mov    0x38(%eax),%eax
    2946:	83 ec 04             	sub    $0x4,%esp
    2949:	52                   	push   %edx
    294a:	68 ff ff ff 00       	push   $0xffffff
    294f:	50                   	push   %eax
    2950:	e8 7d e9 ff ff       	call   12d2 <memset>
    2955:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    2958:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    295b:	c9                   	leave  
    295c:	c3                   	ret    

0000295d <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    295d:	55                   	push   %ebp
    295e:	89 e5                	mov    %esp,%ebp
    2960:	57                   	push   %edi
    2961:	56                   	push   %esi
    2962:	53                   	push   %ebx
    2963:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    2966:	8b 45 0c             	mov    0xc(%ebp),%eax
    2969:	83 f8 03             	cmp    $0x3,%eax
    296c:	74 0e                	je     297c <APWndProc+0x1f>
    296e:	83 f8 0a             	cmp    $0xa,%eax
    2971:	0f 84 82 00 00 00    	je     29f9 <APWndProc+0x9c>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            break;
        default: break;
    2977:	e9 cb 00 00 00       	jmp    2a47 <APWndProc+0xea>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    297c:	8b 45 08             	mov    0x8(%ebp),%eax
    297f:	8b 58 1c             	mov    0x1c(%eax),%ebx
    2982:	8b 45 08             	mov    0x8(%ebp),%eax
    2985:	8b 48 18             	mov    0x18(%eax),%ecx
    2988:	8b 45 08             	mov    0x8(%ebp),%eax
    298b:	8b 50 5c             	mov    0x5c(%eax),%edx
    298e:	8b 45 08             	mov    0x8(%ebp),%eax
    2991:	8b 40 58             	mov    0x58(%eax),%eax
    2994:	8b 75 08             	mov    0x8(%ebp),%esi
    2997:	83 c6 58             	add    $0x58,%esi
    299a:	83 ec 04             	sub    $0x4,%esp
    299d:	53                   	push   %ebx
    299e:	51                   	push   %ecx
    299f:	6a 00                	push   $0x0
    29a1:	52                   	push   %edx
    29a2:	50                   	push   %eax
    29a3:	6a 00                	push   $0x0
    29a5:	6a 00                	push   $0x0
    29a7:	56                   	push   %esi
    29a8:	6a 00                	push   $0x0
    29aa:	6a 00                	push   $0x0
    29ac:	ff 75 08             	pushl  0x8(%ebp)
    29af:	e8 59 eb ff ff       	call   150d <paintWindow>
    29b4:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    29b7:	8b 45 08             	mov    0x8(%ebp),%eax
    29ba:	8b 70 1c             	mov    0x1c(%eax),%esi
    29bd:	8b 45 08             	mov    0x8(%ebp),%eax
    29c0:	8b 58 18             	mov    0x18(%eax),%ebx
    29c3:	8b 45 08             	mov    0x8(%ebp),%eax
    29c6:	8b 48 08             	mov    0x8(%eax),%ecx
    29c9:	8b 45 08             	mov    0x8(%ebp),%eax
    29cc:	8b 50 40             	mov    0x40(%eax),%edx
    29cf:	8b 45 08             	mov    0x8(%ebp),%eax
    29d2:	8b 40 3c             	mov    0x3c(%eax),%eax
    29d5:	8b 7d 08             	mov    0x8(%ebp),%edi
    29d8:	83 c7 3c             	add    $0x3c,%edi
    29db:	83 ec 04             	sub    $0x4,%esp
    29de:	56                   	push   %esi
    29df:	53                   	push   %ebx
    29e0:	51                   	push   %ecx
    29e1:	52                   	push   %edx
    29e2:	50                   	push   %eax
    29e3:	6a 00                	push   $0x0
    29e5:	6a 00                	push   $0x0
    29e7:	57                   	push   %edi
    29e8:	6a 32                	push   $0x32
    29ea:	6a 00                	push   $0x0
    29ec:	ff 75 08             	pushl  0x8(%ebp)
    29ef:	e8 19 eb ff ff       	call   150d <paintWindow>
    29f4:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    29f7:	eb 4e                	jmp    2a47 <APWndProc+0xea>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
    29f9:	8b 45 18             	mov    0x18(%ebp),%eax
    29fc:	83 ec 08             	sub    $0x8,%esp
    29ff:	50                   	push   %eax
    2a00:	ff 75 08             	pushl  0x8(%ebp)
    2a03:	e8 c5 08 00 00       	call   32cd <updateword>
    2a08:	83 c4 10             	add    $0x10,%esp
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    2a0b:	8b 45 08             	mov    0x8(%ebp),%eax
    2a0e:	8b 58 1c             	mov    0x1c(%eax),%ebx
    2a11:	8b 45 08             	mov    0x8(%ebp),%eax
    2a14:	8b 48 18             	mov    0x18(%eax),%ecx
    2a17:	8b 45 08             	mov    0x8(%ebp),%eax
    2a1a:	8b 50 5c             	mov    0x5c(%eax),%edx
    2a1d:	8b 45 08             	mov    0x8(%ebp),%eax
    2a20:	8b 40 58             	mov    0x58(%eax),%eax
    2a23:	8b 75 08             	mov    0x8(%ebp),%esi
    2a26:	83 c6 58             	add    $0x58,%esi
    2a29:	83 ec 04             	sub    $0x4,%esp
    2a2c:	53                   	push   %ebx
    2a2d:	51                   	push   %ecx
    2a2e:	6a 00                	push   $0x0
    2a30:	52                   	push   %edx
    2a31:	50                   	push   %eax
    2a32:	6a 00                	push   $0x0
    2a34:	6a 00                	push   $0x0
    2a36:	56                   	push   %esi
    2a37:	6a 00                	push   $0x0
    2a39:	6a 00                	push   $0x0
    2a3b:	ff 75 08             	pushl  0x8(%ebp)
    2a3e:	e8 ca ea ff ff       	call   150d <paintWindow>
    2a43:	83 c4 30             	add    $0x30,%esp
            break;
    2a46:	90                   	nop
        default: break;
            
            
    }
    return False;
    2a47:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2a4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2a4f:	5b                   	pop    %ebx
    2a50:	5e                   	pop    %esi
    2a51:	5f                   	pop    %edi
    2a52:	5d                   	pop    %ebp
    2a53:	c3                   	ret    

00002a54 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    2a54:	55                   	push   %ebp
    2a55:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    2a57:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a5a:	8b 50 08             	mov    0x8(%eax),%edx
    2a5d:	8b 45 08             	mov    0x8(%ebp),%eax
    2a60:	8b 00                	mov    (%eax),%eax
    2a62:	39 c2                	cmp    %eax,%edx
    2a64:	74 07                	je     2a6d <APPreJudge+0x19>
        return False;
    2a66:	b8 00 00 00 00       	mov    $0x0,%eax
    2a6b:	eb 05                	jmp    2a72 <APPreJudge+0x1e>
    return True;
    2a6d:	b8 01 00 00 00       	mov    $0x1,%eax
}
    2a72:	5d                   	pop    %ebp
    2a73:	c3                   	ret    

00002a74 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    2a74:	55                   	push   %ebp
    2a75:	89 e5                	mov    %esp,%ebp
    2a77:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    2a7a:	8b 45 08             	mov    0x8(%ebp),%eax
    2a7d:	8b 55 0c             	mov    0xc(%ebp),%edx
    2a80:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
    //--------add window to list
    registWindow(hwnd);
    2a86:	83 ec 0c             	sub    $0xc,%esp
    2a89:	ff 75 08             	pushl  0x8(%ebp)
    2a8c:	e8 94 ea ff ff       	call   1525 <registWindow>
    2a91:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    2a94:	c7 45 e8 02 00 00 00 	movl   $0x2,-0x18(%ebp)
    msg.wndID = hwnd->id;
    2a9b:	8b 45 08             	mov    0x8(%ebp),%eax
    2a9e:	8b 00                	mov    (%eax),%eax
    2aa0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    APSendMessage(hwnd,msg);
    2aa3:	83 ec 0c             	sub    $0xc,%esp
    2aa6:	ff 75 f4             	pushl  -0xc(%ebp)
    2aa9:	ff 75 f0             	pushl  -0x10(%ebp)
    2aac:	ff 75 ec             	pushl  -0x14(%ebp)
    2aaf:	ff 75 e8             	pushl  -0x18(%ebp)
    2ab2:	ff 75 08             	pushl  0x8(%ebp)
    2ab5:	e8 1f fc ff ff       	call   26d9 <APSendMessage>
    2aba:	83 c4 20             	add    $0x20,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    2abd:	83 ec 0c             	sub    $0xc,%esp
    2ac0:	ff 75 08             	pushl  0x8(%ebp)
    2ac3:	e8 55 ea ff ff       	call   151d <getMessage>
    2ac8:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    2acb:	8b 45 08             	mov    0x8(%ebp),%eax
    2ace:	83 c0 74             	add    $0x74,%eax
    2ad1:	83 ec 08             	sub    $0x8,%esp
    2ad4:	50                   	push   %eax
    2ad5:	ff 75 08             	pushl  0x8(%ebp)
    2ad8:	e8 77 ff ff ff       	call   2a54 <APPreJudge>
    2add:	83 c4 10             	add    $0x10,%esp
    2ae0:	84 c0                	test   %al,%al
    2ae2:	74 24                	je     2b08 <APWndExec+0x94>
            if (wndProc(hwnd, hwnd->msg))
    2ae4:	83 ec 0c             	sub    $0xc,%esp
    2ae7:	8b 45 08             	mov    0x8(%ebp),%eax
    2aea:	ff b0 80 00 00 00    	pushl  0x80(%eax)
    2af0:	ff 70 7c             	pushl  0x7c(%eax)
    2af3:	ff 70 78             	pushl  0x78(%eax)
    2af6:	ff 70 74             	pushl  0x74(%eax)
    2af9:	ff 75 08             	pushl  0x8(%ebp)
    2afc:	8b 45 0c             	mov    0xc(%ebp),%eax
    2aff:	ff d0                	call   *%eax
    2b01:	83 c4 20             	add    $0x20,%esp
    2b04:	84 c0                	test   %al,%al
    2b06:	75 0c                	jne    2b14 <APWndExec+0xa0>
                break;
        hwnd->msg.type = MSG_NULL;
    2b08:	8b 45 08             	mov    0x8(%ebp),%eax
    2b0b:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    2b12:	eb a9                	jmp    2abd <APWndExec+0x49>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    2b14:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    2b15:	90                   	nop
    2b16:	c9                   	leave  
    2b17:	c3                   	ret    

00002b18 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    2b18:	55                   	push   %ebp
    2b19:	89 e5                	mov    %esp,%ebp
    2b1b:	57                   	push   %edi
    2b1c:	56                   	push   %esi
    2b1d:	53                   	push   %ebx
    2b1e:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    2b21:	a1 d0 7e 00 00       	mov    0x7ed0,%eax
    2b26:	85 c0                	test   %eax,%eax
    2b28:	0f 85 c8 02 00 00    	jne    2df6 <APGridPaint+0x2de>
    {
        iconReady = 1;
    2b2e:	c7 05 d0 7e 00 00 01 	movl   $0x1,0x7ed0
    2b35:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    2b38:	8d 45 98             	lea    -0x68(%ebp),%eax
    2b3b:	83 ec 08             	sub    $0x8,%esp
    2b3e:	68 53 3a 00 00       	push   $0x3a53
    2b43:	50                   	push   %eax
    2b44:	e8 69 ef ff ff       	call   1ab2 <APLoadBitmap>
    2b49:	83 c4 0c             	add    $0xc,%esp
    2b4c:	8b 45 98             	mov    -0x68(%ebp),%eax
    2b4f:	a3 70 7f 00 00       	mov    %eax,0x7f70
    2b54:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2b57:	a3 74 7f 00 00       	mov    %eax,0x7f74
    2b5c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2b5f:	a3 78 7f 00 00       	mov    %eax,0x7f78
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    2b64:	83 ec 04             	sub    $0x4,%esp
    2b67:	ff 35 78 7f 00 00    	pushl  0x7f78
    2b6d:	ff 35 74 7f 00 00    	pushl  0x7f74
    2b73:	ff 35 70 7f 00 00    	pushl  0x7f70
    2b79:	e8 6e f1 ff ff       	call   1cec <APCreateCompatibleDCFromBitmap>
    2b7e:	83 c4 10             	add    $0x10,%esp
    2b81:	a3 7c 7f 00 00       	mov    %eax,0x7f7c
        grid_river = APLoadBitmap ("grid_river.bmp");
    2b86:	8d 45 98             	lea    -0x68(%ebp),%eax
    2b89:	83 ec 08             	sub    $0x8,%esp
    2b8c:	68 61 3a 00 00       	push   $0x3a61
    2b91:	50                   	push   %eax
    2b92:	e8 1b ef ff ff       	call   1ab2 <APLoadBitmap>
    2b97:	83 c4 0c             	add    $0xc,%esp
    2b9a:	8b 45 98             	mov    -0x68(%ebp),%eax
    2b9d:	a3 e0 7f 00 00       	mov    %eax,0x7fe0
    2ba2:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2ba5:	a3 e4 7f 00 00       	mov    %eax,0x7fe4
    2baa:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2bad:	a3 e8 7f 00 00       	mov    %eax,0x7fe8
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    2bb2:	83 ec 04             	sub    $0x4,%esp
    2bb5:	ff 35 e8 7f 00 00    	pushl  0x7fe8
    2bbb:	ff 35 e4 7f 00 00    	pushl  0x7fe4
    2bc1:	ff 35 e0 7f 00 00    	pushl  0x7fe0
    2bc7:	e8 20 f1 ff ff       	call   1cec <APCreateCompatibleDCFromBitmap>
    2bcc:	83 c4 10             	add    $0x10,%esp
    2bcf:	a3 d0 7f 00 00       	mov    %eax,0x7fd0
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    2bd4:	8d 45 98             	lea    -0x68(%ebp),%eax
    2bd7:	83 ec 08             	sub    $0x8,%esp
    2bda:	68 70 3a 00 00       	push   $0x3a70
    2bdf:	50                   	push   %eax
    2be0:	e8 cd ee ff ff       	call   1ab2 <APLoadBitmap>
    2be5:	83 c4 0c             	add    $0xc,%esp
    2be8:	8b 45 98             	mov    -0x68(%ebp),%eax
    2beb:	a3 d4 7f 00 00       	mov    %eax,0x7fd4
    2bf0:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2bf3:	a3 d8 7f 00 00       	mov    %eax,0x7fd8
    2bf8:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2bfb:	a3 dc 7f 00 00       	mov    %eax,0x7fdc
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    2c00:	83 ec 04             	sub    $0x4,%esp
    2c03:	ff 35 dc 7f 00 00    	pushl  0x7fdc
    2c09:	ff 35 d8 7f 00 00    	pushl  0x7fd8
    2c0f:	ff 35 d4 7f 00 00    	pushl  0x7fd4
    2c15:	e8 d2 f0 ff ff       	call   1cec <APCreateCompatibleDCFromBitmap>
    2c1a:	83 c4 10             	add    $0x10,%esp
    2c1d:	a3 f4 7e 00 00       	mov    %eax,0x7ef4
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    2c22:	8d 45 98             	lea    -0x68(%ebp),%eax
    2c25:	83 ec 08             	sub    $0x8,%esp
    2c28:	68 7f 3a 00 00       	push   $0x3a7f
    2c2d:	50                   	push   %eax
    2c2e:	e8 7f ee ff ff       	call   1ab2 <APLoadBitmap>
    2c33:	83 c4 0c             	add    $0xc,%esp
    2c36:	8b 45 98             	mov    -0x68(%ebp),%eax
    2c39:	a3 08 7f 00 00       	mov    %eax,0x7f08
    2c3e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2c41:	a3 0c 7f 00 00       	mov    %eax,0x7f0c
    2c46:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2c49:	a3 10 7f 00 00       	mov    %eax,0x7f10
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    2c4e:	83 ec 04             	sub    $0x4,%esp
    2c51:	ff 35 10 7f 00 00    	pushl  0x7f10
    2c57:	ff 35 0c 7f 00 00    	pushl  0x7f0c
    2c5d:	ff 35 08 7f 00 00    	pushl  0x7f08
    2c63:	e8 84 f0 ff ff       	call   1cec <APCreateCompatibleDCFromBitmap>
    2c68:	83 c4 10             	add    $0x10,%esp
    2c6b:	a3 6c 7f 00 00       	mov    %eax,0x7f6c
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    2c70:	8d 45 98             	lea    -0x68(%ebp),%eax
    2c73:	83 ec 08             	sub    $0x8,%esp
    2c76:	68 91 3a 00 00       	push   $0x3a91
    2c7b:	50                   	push   %eax
    2c7c:	e8 31 ee ff ff       	call   1ab2 <APLoadBitmap>
    2c81:	83 c4 0c             	add    $0xc,%esp
    2c84:	8b 45 98             	mov    -0x68(%ebp),%eax
    2c87:	a3 94 7f 00 00       	mov    %eax,0x7f94
    2c8c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2c8f:	a3 98 7f 00 00       	mov    %eax,0x7f98
    2c94:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2c97:	a3 9c 7f 00 00       	mov    %eax,0x7f9c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    2c9c:	83 ec 04             	sub    $0x4,%esp
    2c9f:	ff 35 9c 7f 00 00    	pushl  0x7f9c
    2ca5:	ff 35 98 7f 00 00    	pushl  0x7f98
    2cab:	ff 35 94 7f 00 00    	pushl  0x7f94
    2cb1:	e8 36 f0 ff ff       	call   1cec <APCreateCompatibleDCFromBitmap>
    2cb6:	83 c4 10             	add    $0x10,%esp
    2cb9:	a3 14 80 00 00       	mov    %eax,0x8014
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    2cbe:	8d 45 98             	lea    -0x68(%ebp),%eax
    2cc1:	83 ec 08             	sub    $0x8,%esp
    2cc4:	68 9f 3a 00 00       	push   $0x3a9f
    2cc9:	50                   	push   %eax
    2cca:	e8 e3 ed ff ff       	call   1ab2 <APLoadBitmap>
    2ccf:	83 c4 0c             	add    $0xc,%esp
    2cd2:	8b 45 98             	mov    -0x68(%ebp),%eax
    2cd5:	a3 60 7f 00 00       	mov    %eax,0x7f60
    2cda:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2cdd:	a3 64 7f 00 00       	mov    %eax,0x7f64
    2ce2:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2ce5:	a3 68 7f 00 00       	mov    %eax,0x7f68
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    2cea:	83 ec 04             	sub    $0x4,%esp
    2ced:	ff 35 68 7f 00 00    	pushl  0x7f68
    2cf3:	ff 35 64 7f 00 00    	pushl  0x7f64
    2cf9:	ff 35 60 7f 00 00    	pushl  0x7f60
    2cff:	e8 e8 ef ff ff       	call   1cec <APCreateCompatibleDCFromBitmap>
    2d04:	83 c4 10             	add    $0x10,%esp
    2d07:	a3 8c 7f 00 00       	mov    %eax,0x7f8c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    2d0c:	8d 45 98             	lea    -0x68(%ebp),%eax
    2d0f:	83 ec 08             	sub    $0x8,%esp
    2d12:	68 af 3a 00 00       	push   $0x3aaf
    2d17:	50                   	push   %eax
    2d18:	e8 95 ed ff ff       	call   1ab2 <APLoadBitmap>
    2d1d:	83 c4 0c             	add    $0xc,%esp
    2d20:	8b 45 98             	mov    -0x68(%ebp),%eax
    2d23:	a3 c4 7f 00 00       	mov    %eax,0x7fc4
    2d28:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2d2b:	a3 c8 7f 00 00       	mov    %eax,0x7fc8
    2d30:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2d33:	a3 cc 7f 00 00       	mov    %eax,0x7fcc
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    2d38:	83 ec 04             	sub    $0x4,%esp
    2d3b:	ff 35 cc 7f 00 00    	pushl  0x7fcc
    2d41:	ff 35 c8 7f 00 00    	pushl  0x7fc8
    2d47:	ff 35 c4 7f 00 00    	pushl  0x7fc4
    2d4d:	e8 9a ef ff ff       	call   1cec <APCreateCompatibleDCFromBitmap>
    2d52:	83 c4 10             	add    $0x10,%esp
    2d55:	a3 fc 84 00 00       	mov    %eax,0x84fc
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    2d5a:	8d 45 98             	lea    -0x68(%ebp),%eax
    2d5d:	83 ec 08             	sub    $0x8,%esp
    2d60:	68 be 3a 00 00       	push   $0x3abe
    2d65:	50                   	push   %eax
    2d66:	e8 47 ed ff ff       	call   1ab2 <APLoadBitmap>
    2d6b:	83 c4 0c             	add    $0xc,%esp
    2d6e:	8b 45 98             	mov    -0x68(%ebp),%eax
    2d71:	a3 a0 7f 00 00       	mov    %eax,0x7fa0
    2d76:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2d79:	a3 a4 7f 00 00       	mov    %eax,0x7fa4
    2d7e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2d81:	a3 a8 7f 00 00       	mov    %eax,0x7fa8
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    2d86:	83 ec 04             	sub    $0x4,%esp
    2d89:	ff 35 a8 7f 00 00    	pushl  0x7fa8
    2d8f:	ff 35 a4 7f 00 00    	pushl  0x7fa4
    2d95:	ff 35 a0 7f 00 00    	pushl  0x7fa0
    2d9b:	e8 4c ef ff ff       	call   1cec <APCreateCompatibleDCFromBitmap>
    2da0:	83 c4 10             	add    $0x10,%esp
    2da3:	a3 f8 7f 00 00       	mov    %eax,0x7ff8
        grid_tower = APLoadBitmap ("grid_tower.bmp");
    2da8:	8d 45 98             	lea    -0x68(%ebp),%eax
    2dab:	83 ec 08             	sub    $0x8,%esp
    2dae:	68 cd 3a 00 00       	push   $0x3acd
    2db3:	50                   	push   %eax
    2db4:	e8 f9 ec ff ff       	call   1ab2 <APLoadBitmap>
    2db9:	83 c4 0c             	add    $0xc,%esp
    2dbc:	8b 45 98             	mov    -0x68(%ebp),%eax
    2dbf:	a3 28 7f 00 00       	mov    %eax,0x7f28
    2dc4:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2dc7:	a3 2c 7f 00 00       	mov    %eax,0x7f2c
    2dcc:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2dcf:	a3 30 7f 00 00       	mov    %eax,0x7f30
        g_tower = APCreateCompatibleDCFromBitmap(grid_tower);
    2dd4:	83 ec 04             	sub    $0x4,%esp
    2dd7:	ff 35 30 7f 00 00    	pushl  0x7f30
    2ddd:	ff 35 2c 7f 00 00    	pushl  0x7f2c
    2de3:	ff 35 28 7f 00 00    	pushl  0x7f28
    2de9:	e8 fe ee ff ff       	call   1cec <APCreateCompatibleDCFromBitmap>
    2dee:	83 c4 10             	add    $0x10,%esp
    2df1:	a3 90 7f 00 00       	mov    %eax,0x7f90
   
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    2df6:	8b 45 08             	mov    0x8(%ebp),%eax
    2df9:	8b 40 08             	mov    0x8(%eax),%eax
    2dfc:	85 c0                	test   %eax,%eax
    2dfe:	75 17                	jne    2e17 <APGridPaint+0x2ff>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    2e00:	83 ec 08             	sub    $0x8,%esp
    2e03:	68 dc 3a 00 00       	push   $0x3adc
    2e08:	6a 01                	push   $0x1
    2e0a:	e8 1d e8 ff ff       	call   162c <printf>
    2e0f:	83 c4 10             	add    $0x10,%esp
        return;
    2e12:	e9 ae 04 00 00       	jmp    32c5 <APGridPaint+0x7ad>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    2e17:	8b 45 08             	mov    0x8(%ebp),%eax
    2e1a:	8b 40 10             	mov    0x10(%eax),%eax
    2e1d:	85 c0                	test   %eax,%eax
    2e1f:	7e 10                	jle    2e31 <APGridPaint+0x319>
    2e21:	8b 45 08             	mov    0x8(%ebp),%eax
    2e24:	8b 50 14             	mov    0x14(%eax),%edx
    2e27:	8b 45 08             	mov    0x8(%ebp),%eax
    2e2a:	8b 40 10             	mov    0x10(%eax),%eax
    2e2d:	39 c2                	cmp    %eax,%edx
    2e2f:	7c 17                	jl     2e48 <APGridPaint+0x330>
    {
        printf(1,"Grid mode page error!");
    2e31:	83 ec 08             	sub    $0x8,%esp
    2e34:	68 02 3b 00 00       	push   $0x3b02
    2e39:	6a 01                	push   $0x1
    2e3b:	e8 ec e7 ff ff       	call   162c <printf>
    2e40:	83 c4 10             	add    $0x10,%esp
        return;
    2e43:	e9 7d 04 00 00       	jmp    32c5 <APGridPaint+0x7ad>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    2e48:	8b 45 08             	mov    0x8(%ebp),%eax
    2e4b:	8b 40 14             	mov    0x14(%eax),%eax
    2e4e:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    2e54:	89 45 dc             	mov    %eax,-0x24(%ebp)
    2e57:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2e5a:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2e5d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    2e64:	e9 52 04 00 00       	jmp    32bb <APGridPaint+0x7a3>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2e69:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    2e70:	e9 38 04 00 00       	jmp    32ad <APGridPaint+0x795>
        {
            index = start + GRID_W_NUMBER * j + i;
    2e75:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2e78:	c1 e0 04             	shl    $0x4,%eax
    2e7b:	89 c2                	mov    %eax,%edx
    2e7d:	8b 45 d8             	mov    -0x28(%ebp),%eax
    2e80:	01 c2                	add    %eax,%edx
    2e82:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2e85:	01 d0                	add    %edx,%eax
    2e87:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    2e8a:	8b 45 08             	mov    0x8(%ebp),%eax
    2e8d:	8b 40 0c             	mov    0xc(%eax),%eax
    2e90:	8b 55 dc             	mov    -0x24(%ebp),%edx
    2e93:	c1 e2 02             	shl    $0x2,%edx
    2e96:	01 d0                	add    %edx,%eax
    2e98:	8b 00                	mov    (%eax),%eax
    2e9a:	83 f8 0b             	cmp    $0xb,%eax
    2e9d:	0f 87 05 04 00 00    	ja     32a8 <APGridPaint+0x790>
    2ea3:	8b 04 85 18 3b 00 00 	mov    0x3b18(,%eax,4),%eax
    2eaa:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2eac:	8d 45 bd             	lea    -0x43(%ebp),%eax
    2eaf:	6a 0c                	push   $0xc
    2eb1:	6a 0c                	push   $0xc
    2eb3:	6a 0c                	push   $0xc
    2eb5:	50                   	push   %eax
    2eb6:	e8 d9 f7 ff ff       	call   2694 <RGB>
    2ebb:	83 c4 0c             	add    $0xc,%esp
    2ebe:	8b 1d 7c 7f 00 00    	mov    0x7f7c,%ebx
    2ec4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2ec7:	6b c8 32             	imul   $0x32,%eax,%ecx
    2eca:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2ecd:	6b c0 32             	imul   $0x32,%eax,%eax
    2ed0:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2ed3:	8b 45 08             	mov    0x8(%ebp),%eax
    2ed6:	8d 78 3c             	lea    0x3c(%eax),%edi
    2ed9:	83 ec 0c             	sub    $0xc,%esp
    2edc:	83 ec 04             	sub    $0x4,%esp
    2edf:	89 e0                	mov    %esp,%eax
    2ee1:	0f b7 75 bd          	movzwl -0x43(%ebp),%esi
    2ee5:	66 89 30             	mov    %si,(%eax)
    2ee8:	0f b6 55 bf          	movzbl -0x41(%ebp),%edx
    2eec:	88 50 02             	mov    %dl,0x2(%eax)
    2eef:	6a 32                	push   $0x32
    2ef1:	6a 32                	push   $0x32
    2ef3:	6a 00                	push   $0x0
    2ef5:	6a 00                	push   $0x0
    2ef7:	53                   	push   %ebx
    2ef8:	51                   	push   %ecx
    2ef9:	ff 75 94             	pushl  -0x6c(%ebp)
    2efc:	57                   	push   %edi
    2efd:	e8 ee f5 ff ff       	call   24f0 <APDcCopy>
    2f02:	83 c4 30             	add    $0x30,%esp
                    break;
    2f05:	e9 9f 03 00 00       	jmp    32a9 <APGridPaint+0x791>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    2f0a:	8d 45 98             	lea    -0x68(%ebp),%eax
    2f0d:	6a 69                	push   $0x69
    2f0f:	6a 69                	push   $0x69
    2f11:	6a 69                	push   $0x69
    2f13:	50                   	push   %eax
    2f14:	e8 7b f7 ff ff       	call   2694 <RGB>
    2f19:	83 c4 0c             	add    $0xc,%esp
    2f1c:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2f20:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    2f24:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2f28:	88 45 b6             	mov    %al,-0x4a(%ebp)
                    pen.size = 1;
    2f2b:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    2f32:	8d 45 98             	lea    -0x68(%ebp),%eax
    2f35:	6a 69                	push   $0x69
    2f37:	6a 69                	push   $0x69
    2f39:	6a 69                	push   $0x69
    2f3b:	50                   	push   %eax
    2f3c:	e8 53 f7 ff ff       	call   2694 <RGB>
    2f41:	83 c4 0c             	add    $0xc,%esp
    2f44:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2f48:	66 89 45 b1          	mov    %ax,-0x4f(%ebp)
    2f4c:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2f50:	88 45 b3             	mov    %al,-0x4d(%ebp)
                    APSetPen(&wnd->Dc,pen);
    2f53:	8b 45 08             	mov    0x8(%ebp),%eax
    2f56:	8d 50 3c             	lea    0x3c(%eax),%edx
    2f59:	8d 45 98             	lea    -0x68(%ebp),%eax
    2f5c:	ff 75 b8             	pushl  -0x48(%ebp)
    2f5f:	ff 75 b4             	pushl  -0x4c(%ebp)
    2f62:	52                   	push   %edx
    2f63:	50                   	push   %eax
    2f64:	e8 18 ee ff ff       	call   1d81 <APSetPen>
    2f69:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    2f6c:	8b 45 08             	mov    0x8(%ebp),%eax
    2f6f:	8d 58 3c             	lea    0x3c(%eax),%ebx
    2f72:	8d 55 98             	lea    -0x68(%ebp),%edx
    2f75:	83 ec 04             	sub    $0x4,%esp
    2f78:	83 ec 04             	sub    $0x4,%esp
    2f7b:	89 e0                	mov    %esp,%eax
    2f7d:	0f b7 4d b1          	movzwl -0x4f(%ebp),%ecx
    2f81:	66 89 08             	mov    %cx,(%eax)
    2f84:	0f b6 4d b3          	movzbl -0x4d(%ebp),%ecx
    2f88:	88 48 02             	mov    %cl,0x2(%eax)
    2f8b:	53                   	push   %ebx
    2f8c:	52                   	push   %edx
    2f8d:	e8 28 ee ff ff       	call   1dba <APSetBrush>
    2f92:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    2f95:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2f98:	6b d0 32             	imul   $0x32,%eax,%edx
    2f9b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2f9e:	6b c0 32             	imul   $0x32,%eax,%eax
    2fa1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2fa4:	83 c1 3c             	add    $0x3c,%ecx
    2fa7:	83 ec 0c             	sub    $0xc,%esp
    2faa:	6a 32                	push   $0x32
    2fac:	6a 32                	push   $0x32
    2fae:	52                   	push   %edx
    2faf:	50                   	push   %eax
    2fb0:	51                   	push   %ecx
    2fb1:	e8 2e f2 ff ff       	call   21e4 <APDrawRect>
    2fb6:	83 c4 20             	add    $0x20,%esp
                    break;
    2fb9:	e9 eb 02 00 00       	jmp    32a9 <APGridPaint+0x791>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2fbe:	8d 45 c0             	lea    -0x40(%ebp),%eax
    2fc1:	6a 0c                	push   $0xc
    2fc3:	6a 0c                	push   $0xc
    2fc5:	6a 0c                	push   $0xc
    2fc7:	50                   	push   %eax
    2fc8:	e8 c7 f6 ff ff       	call   2694 <RGB>
    2fcd:	83 c4 0c             	add    $0xc,%esp
    2fd0:	8b 1d fc 84 00 00    	mov    0x84fc,%ebx
    2fd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2fd9:	6b c8 32             	imul   $0x32,%eax,%ecx
    2fdc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2fdf:	6b c0 32             	imul   $0x32,%eax,%eax
    2fe2:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2fe5:	8b 45 08             	mov    0x8(%ebp),%eax
    2fe8:	8d 78 3c             	lea    0x3c(%eax),%edi
    2feb:	83 ec 0c             	sub    $0xc,%esp
    2fee:	83 ec 04             	sub    $0x4,%esp
    2ff1:	89 e0                	mov    %esp,%eax
    2ff3:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    2ff7:	66 89 30             	mov    %si,(%eax)
    2ffa:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    2ffe:	88 50 02             	mov    %dl,0x2(%eax)
    3001:	6a 32                	push   $0x32
    3003:	6a 32                	push   $0x32
    3005:	6a 00                	push   $0x0
    3007:	6a 00                	push   $0x0
    3009:	53                   	push   %ebx
    300a:	51                   	push   %ecx
    300b:	ff 75 94             	pushl  -0x6c(%ebp)
    300e:	57                   	push   %edi
    300f:	e8 dc f4 ff ff       	call   24f0 <APDcCopy>
    3014:	83 c4 30             	add    $0x30,%esp
                    break;
    3017:	e9 8d 02 00 00       	jmp    32a9 <APGridPaint+0x791>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    301c:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    301f:	6a 0c                	push   $0xc
    3021:	6a 0c                	push   $0xc
    3023:	6a 0c                	push   $0xc
    3025:	50                   	push   %eax
    3026:	e8 69 f6 ff ff       	call   2694 <RGB>
    302b:	83 c4 0c             	add    $0xc,%esp
    302e:	8b 1d d0 7f 00 00    	mov    0x7fd0,%ebx
    3034:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3037:	6b c8 32             	imul   $0x32,%eax,%ecx
    303a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    303d:	6b c0 32             	imul   $0x32,%eax,%eax
    3040:	89 45 94             	mov    %eax,-0x6c(%ebp)
    3043:	8b 45 08             	mov    0x8(%ebp),%eax
    3046:	8d 78 3c             	lea    0x3c(%eax),%edi
    3049:	83 ec 0c             	sub    $0xc,%esp
    304c:	83 ec 04             	sub    $0x4,%esp
    304f:	89 e0                	mov    %esp,%eax
    3051:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    3055:	66 89 30             	mov    %si,(%eax)
    3058:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    305c:	88 50 02             	mov    %dl,0x2(%eax)
    305f:	6a 32                	push   $0x32
    3061:	6a 32                	push   $0x32
    3063:	6a 00                	push   $0x0
    3065:	6a 00                	push   $0x0
    3067:	53                   	push   %ebx
    3068:	51                   	push   %ecx
    3069:	ff 75 94             	pushl  -0x6c(%ebp)
    306c:	57                   	push   %edi
    306d:	e8 7e f4 ff ff       	call   24f0 <APDcCopy>
    3072:	83 c4 30             	add    $0x30,%esp
                    break;
    3075:	e9 2f 02 00 00       	jmp    32a9 <APGridPaint+0x791>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    307a:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    307d:	6a 0c                	push   $0xc
    307f:	6a 0c                	push   $0xc
    3081:	6a 0c                	push   $0xc
    3083:	50                   	push   %eax
    3084:	e8 0b f6 ff ff       	call   2694 <RGB>
    3089:	83 c4 0c             	add    $0xc,%esp
    308c:	8b 1d 8c 7f 00 00    	mov    0x7f8c,%ebx
    3092:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3095:	6b c8 32             	imul   $0x32,%eax,%ecx
    3098:	8b 45 e0             	mov    -0x20(%ebp),%eax
    309b:	6b c0 32             	imul   $0x32,%eax,%eax
    309e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    30a1:	8b 45 08             	mov    0x8(%ebp),%eax
    30a4:	8d 78 3c             	lea    0x3c(%eax),%edi
    30a7:	83 ec 0c             	sub    $0xc,%esp
    30aa:	83 ec 04             	sub    $0x4,%esp
    30ad:	89 e0                	mov    %esp,%eax
    30af:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    30b3:	66 89 30             	mov    %si,(%eax)
    30b6:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    30ba:	88 50 02             	mov    %dl,0x2(%eax)
    30bd:	6a 32                	push   $0x32
    30bf:	6a 32                	push   $0x32
    30c1:	6a 00                	push   $0x0
    30c3:	6a 00                	push   $0x0
    30c5:	53                   	push   %ebx
    30c6:	51                   	push   %ecx
    30c7:	ff 75 94             	pushl  -0x6c(%ebp)
    30ca:	57                   	push   %edi
    30cb:	e8 20 f4 ff ff       	call   24f0 <APDcCopy>
    30d0:	83 c4 30             	add    $0x30,%esp
                    break;
    30d3:	e9 d1 01 00 00       	jmp    32a9 <APGridPaint+0x791>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    30d8:	8d 45 c9             	lea    -0x37(%ebp),%eax
    30db:	6a 0c                	push   $0xc
    30dd:	6a 0c                	push   $0xc
    30df:	6a 0c                	push   $0xc
    30e1:	50                   	push   %eax
    30e2:	e8 ad f5 ff ff       	call   2694 <RGB>
    30e7:	83 c4 0c             	add    $0xc,%esp
    30ea:	8b 1d 14 80 00 00    	mov    0x8014,%ebx
    30f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    30f3:	6b c8 32             	imul   $0x32,%eax,%ecx
    30f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    30f9:	6b c0 32             	imul   $0x32,%eax,%eax
    30fc:	89 45 94             	mov    %eax,-0x6c(%ebp)
    30ff:	8b 45 08             	mov    0x8(%ebp),%eax
    3102:	8d 78 3c             	lea    0x3c(%eax),%edi
    3105:	83 ec 0c             	sub    $0xc,%esp
    3108:	83 ec 04             	sub    $0x4,%esp
    310b:	89 e0                	mov    %esp,%eax
    310d:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    3111:	66 89 30             	mov    %si,(%eax)
    3114:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    3118:	88 50 02             	mov    %dl,0x2(%eax)
    311b:	6a 32                	push   $0x32
    311d:	6a 32                	push   $0x32
    311f:	6a 00                	push   $0x0
    3121:	6a 00                	push   $0x0
    3123:	53                   	push   %ebx
    3124:	51                   	push   %ecx
    3125:	ff 75 94             	pushl  -0x6c(%ebp)
    3128:	57                   	push   %edi
    3129:	e8 c2 f3 ff ff       	call   24f0 <APDcCopy>
    312e:	83 c4 30             	add    $0x30,%esp
                    break;
    3131:	e9 73 01 00 00       	jmp    32a9 <APGridPaint+0x791>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    3136:	8d 45 cc             	lea    -0x34(%ebp),%eax
    3139:	6a 0c                	push   $0xc
    313b:	6a 0c                	push   $0xc
    313d:	6a 0c                	push   $0xc
    313f:	50                   	push   %eax
    3140:	e8 4f f5 ff ff       	call   2694 <RGB>
    3145:	83 c4 0c             	add    $0xc,%esp
    3148:	8b 1d f4 7e 00 00    	mov    0x7ef4,%ebx
    314e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3151:	6b c8 32             	imul   $0x32,%eax,%ecx
    3154:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3157:	6b c0 32             	imul   $0x32,%eax,%eax
    315a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    315d:	8b 45 08             	mov    0x8(%ebp),%eax
    3160:	8d 78 3c             	lea    0x3c(%eax),%edi
    3163:	83 ec 0c             	sub    $0xc,%esp
    3166:	83 ec 04             	sub    $0x4,%esp
    3169:	89 e0                	mov    %esp,%eax
    316b:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    316f:	66 89 30             	mov    %si,(%eax)
    3172:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    3176:	88 50 02             	mov    %dl,0x2(%eax)
    3179:	6a 32                	push   $0x32
    317b:	6a 32                	push   $0x32
    317d:	6a 00                	push   $0x0
    317f:	6a 00                	push   $0x0
    3181:	53                   	push   %ebx
    3182:	51                   	push   %ecx
    3183:	ff 75 94             	pushl  -0x6c(%ebp)
    3186:	57                   	push   %edi
    3187:	e8 64 f3 ff ff       	call   24f0 <APDcCopy>
    318c:	83 c4 30             	add    $0x30,%esp
                    break;
    318f:	e9 15 01 00 00       	jmp    32a9 <APGridPaint+0x791>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    3194:	8d 45 cf             	lea    -0x31(%ebp),%eax
    3197:	6a 0c                	push   $0xc
    3199:	6a 0c                	push   $0xc
    319b:	6a 0c                	push   $0xc
    319d:	50                   	push   %eax
    319e:	e8 f1 f4 ff ff       	call   2694 <RGB>
    31a3:	83 c4 0c             	add    $0xc,%esp
    31a6:	8b 1d 6c 7f 00 00    	mov    0x7f6c,%ebx
    31ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    31af:	6b c8 32             	imul   $0x32,%eax,%ecx
    31b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    31b5:	6b c0 32             	imul   $0x32,%eax,%eax
    31b8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    31bb:	8b 45 08             	mov    0x8(%ebp),%eax
    31be:	8d 78 3c             	lea    0x3c(%eax),%edi
    31c1:	83 ec 0c             	sub    $0xc,%esp
    31c4:	83 ec 04             	sub    $0x4,%esp
    31c7:	89 e0                	mov    %esp,%eax
    31c9:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    31cd:	66 89 30             	mov    %si,(%eax)
    31d0:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    31d4:	88 50 02             	mov    %dl,0x2(%eax)
    31d7:	6a 32                	push   $0x32
    31d9:	6a 32                	push   $0x32
    31db:	6a 00                	push   $0x0
    31dd:	6a 00                	push   $0x0
    31df:	53                   	push   %ebx
    31e0:	51                   	push   %ecx
    31e1:	ff 75 94             	pushl  -0x6c(%ebp)
    31e4:	57                   	push   %edi
    31e5:	e8 06 f3 ff ff       	call   24f0 <APDcCopy>
    31ea:	83 c4 30             	add    $0x30,%esp
                    break;
    31ed:	e9 b7 00 00 00       	jmp    32a9 <APGridPaint+0x791>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    31f2:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    31f5:	6a 0c                	push   $0xc
    31f7:	6a 0c                	push   $0xc
    31f9:	6a 0c                	push   $0xc
    31fb:	50                   	push   %eax
    31fc:	e8 93 f4 ff ff       	call   2694 <RGB>
    3201:	83 c4 0c             	add    $0xc,%esp
    3204:	8b 1d f8 7f 00 00    	mov    0x7ff8,%ebx
    320a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    320d:	6b c8 32             	imul   $0x32,%eax,%ecx
    3210:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3213:	6b c0 32             	imul   $0x32,%eax,%eax
    3216:	89 45 94             	mov    %eax,-0x6c(%ebp)
    3219:	8b 45 08             	mov    0x8(%ebp),%eax
    321c:	8d 78 3c             	lea    0x3c(%eax),%edi
    321f:	83 ec 0c             	sub    $0xc,%esp
    3222:	83 ec 04             	sub    $0x4,%esp
    3225:	89 e0                	mov    %esp,%eax
    3227:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    322b:	66 89 30             	mov    %si,(%eax)
    322e:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    3232:	88 50 02             	mov    %dl,0x2(%eax)
    3235:	6a 32                	push   $0x32
    3237:	6a 32                	push   $0x32
    3239:	6a 00                	push   $0x0
    323b:	6a 00                	push   $0x0
    323d:	53                   	push   %ebx
    323e:	51                   	push   %ecx
    323f:	ff 75 94             	pushl  -0x6c(%ebp)
    3242:	57                   	push   %edi
    3243:	e8 a8 f2 ff ff       	call   24f0 <APDcCopy>
    3248:	83 c4 30             	add    $0x30,%esp
                    break;
    324b:	eb 5c                	jmp    32a9 <APGridPaint+0x791>
                case GRID_PROGRAM_TOWER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_tower,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    324d:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    3250:	6a 0c                	push   $0xc
    3252:	6a 0c                	push   $0xc
    3254:	6a 0c                	push   $0xc
    3256:	50                   	push   %eax
    3257:	e8 38 f4 ff ff       	call   2694 <RGB>
    325c:	83 c4 0c             	add    $0xc,%esp
    325f:	8b 1d 90 7f 00 00    	mov    0x7f90,%ebx
    3265:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3268:	6b c8 32             	imul   $0x32,%eax,%ecx
    326b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    326e:	6b c0 32             	imul   $0x32,%eax,%eax
    3271:	89 45 94             	mov    %eax,-0x6c(%ebp)
    3274:	8b 45 08             	mov    0x8(%ebp),%eax
    3277:	8d 78 3c             	lea    0x3c(%eax),%edi
    327a:	83 ec 0c             	sub    $0xc,%esp
    327d:	83 ec 04             	sub    $0x4,%esp
    3280:	89 e0                	mov    %esp,%eax
    3282:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    3286:	66 89 30             	mov    %si,(%eax)
    3289:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    328d:	88 50 02             	mov    %dl,0x2(%eax)
    3290:	6a 32                	push   $0x32
    3292:	6a 32                	push   $0x32
    3294:	6a 00                	push   $0x0
    3296:	6a 00                	push   $0x0
    3298:	53                   	push   %ebx
    3299:	51                   	push   %ecx
    329a:	ff 75 94             	pushl  -0x6c(%ebp)
    329d:	57                   	push   %edi
    329e:	e8 4d f2 ff ff       	call   24f0 <APDcCopy>
    32a3:	83 c4 30             	add    $0x30,%esp
                    break;
    32a6:	eb 01                	jmp    32a9 <APGridPaint+0x791>
                default: break;
    32a8:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    32a9:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    32ad:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    32b1:	0f 8e be fb ff ff    	jle    2e75 <APGridPaint+0x35d>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    32b7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    32bb:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    32bf:	0f 8e a4 fb ff ff    	jle    2e69 <APGridPaint+0x351>
                    break;
                default: break;
            }
        }
    }
}
    32c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
    32c8:	5b                   	pop    %ebx
    32c9:	5e                   	pop    %esi
    32ca:	5f                   	pop    %edi
    32cb:	5d                   	pop    %ebp
    32cc:	c3                   	ret    

000032cd <updateword>:


void updateword(AHwnd hwnd,char* str)
{
    32cd:	55                   	push   %ebp
    32ce:	89 e5                	mov    %esp,%ebp
    32d0:	53                   	push   %ebx
    32d1:	83 ec 24             	sub    $0x24,%esp
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    32d4:	8d 45 d8             	lea    -0x28(%ebp),%eax
    32d7:	68 cd 00 00 00       	push   $0xcd
    32dc:	6a 74                	push   $0x74
    32de:	6a 18                	push   $0x18
    32e0:	50                   	push   %eax
    32e1:	e8 ae f3 ff ff       	call   2694 <RGB>
    32e6:	83 c4 0c             	add    $0xc,%esp
    32e9:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    32ed:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
    32f1:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    32f5:	88 45 f2             	mov    %al,-0xe(%ebp)
    pen.size = 1;
    32f8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    32ff:	8d 45 d8             	lea    -0x28(%ebp),%eax
    3302:	68 cd 00 00 00       	push   $0xcd
    3307:	6a 74                	push   $0x74
    3309:	6a 18                	push   $0x18
    330b:	50                   	push   %eax
    330c:	e8 83 f3 ff ff       	call   2694 <RGB>
    3311:	83 c4 0c             	add    $0xc,%esp
    3314:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    3318:	66 89 45 ed          	mov    %ax,-0x13(%ebp)
    331c:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    3320:	88 45 ef             	mov    %al,-0x11(%ebp)
    APSetPen(&hwnd->TitleDc,pen);
    3323:	8b 45 08             	mov    0x8(%ebp),%eax
    3326:	8d 50 58             	lea    0x58(%eax),%edx
    3329:	8d 45 d8             	lea    -0x28(%ebp),%eax
    332c:	ff 75 f4             	pushl  -0xc(%ebp)
    332f:	ff 75 f0             	pushl  -0x10(%ebp)
    3332:	52                   	push   %edx
    3333:	50                   	push   %eax
    3334:	e8 48 ea ff ff       	call   1d81 <APSetPen>
    3339:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&hwnd->TitleDc,brush);
    333c:	8b 45 08             	mov    0x8(%ebp),%eax
    333f:	8d 58 58             	lea    0x58(%eax),%ebx
    3342:	8d 55 d8             	lea    -0x28(%ebp),%edx
    3345:	83 ec 04             	sub    $0x4,%esp
    3348:	83 ec 04             	sub    $0x4,%esp
    334b:	89 e0                	mov    %esp,%eax
    334d:	0f b7 4d ed          	movzwl -0x13(%ebp),%ecx
    3351:	66 89 08             	mov    %cx,(%eax)
    3354:	0f b6 4d ef          	movzbl -0x11(%ebp),%ecx
    3358:	88 48 02             	mov    %cl,0x2(%eax)
    335b:	53                   	push   %ebx
    335c:	52                   	push   %edx
    335d:	e8 58 ea ff ff       	call   1dba <APSetBrush>
    3362:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&hwnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    3365:	8b 45 08             	mov    0x8(%ebp),%eax
    3368:	83 c0 58             	add    $0x58,%eax
    336b:	83 ec 0c             	sub    $0xc,%esp
    336e:	6a 32                	push   $0x32
    3370:	68 20 03 00 00       	push   $0x320
    3375:	6a 00                	push   $0x0
    3377:	6a 00                	push   $0x0
    3379:	50                   	push   %eax
    337a:	e8 65 ee ff ff       	call   21e4 <APDrawRect>
    337f:	83 c4 20             	add    $0x20,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    3382:	8d 45 d8             	lea    -0x28(%ebp),%eax
    3385:	6a 08                	push   $0x8
    3387:	6a 08                	push   $0x8
    3389:	6a 08                	push   $0x8
    338b:	50                   	push   %eax
    338c:	e8 03 f3 ff ff       	call   2694 <RGB>
    3391:	83 c4 0c             	add    $0xc,%esp
    3394:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    3398:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    339c:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    33a0:	88 45 ec             	mov    %al,-0x14(%ebp)
    APSetFont(&hwnd->TitleDc,font);
    33a3:	8b 45 08             	mov    0x8(%ebp),%eax
    33a6:	8d 58 58             	lea    0x58(%eax),%ebx
    33a9:	8d 55 d8             	lea    -0x28(%ebp),%edx
    33ac:	83 ec 04             	sub    $0x4,%esp
    33af:	83 ec 04             	sub    $0x4,%esp
    33b2:	89 e0                	mov    %esp,%eax
    33b4:	0f b7 4d ea          	movzwl -0x16(%ebp),%ecx
    33b8:	66 89 08             	mov    %cx,(%eax)
    33bb:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
    33bf:	88 48 02             	mov    %cl,0x2(%eax)
    33c2:	53                   	push   %ebx
    33c3:	52                   	push   %edx
    33c4:	e8 33 ea ff ff       	call   1dfc <APSetFont>
    33c9:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&hwnd->TitleDc,str,10,20);
    33cc:	8b 45 08             	mov    0x8(%ebp),%eax
    33cf:	83 c0 58             	add    $0x58,%eax
    33d2:	6a 14                	push   $0x14
    33d4:	6a 0a                	push   $0xa
    33d6:	ff 75 0c             	pushl  0xc(%ebp)
    33d9:	50                   	push   %eax
    33da:	e8 0a f0 ff ff       	call   23e9 <APDrawText>
    33df:	83 c4 10             	add    $0x10,%esp
}
    33e2:	90                   	nop
    33e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    33e6:	c9                   	leave  
    33e7:	c3                   	ret    

000033e8 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    33e8:	55                   	push   %ebp
    33e9:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    33eb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    33ef:	7e 08                	jle    33f9 <random+0x11>
{
rand_num = seed;
    33f1:	8b 45 08             	mov    0x8(%ebp),%eax
    33f4:	a3 a0 7e 00 00       	mov    %eax,0x7ea0
}
rand_num *= 3;
    33f9:	8b 15 a0 7e 00 00    	mov    0x7ea0,%edx
    33ff:	89 d0                	mov    %edx,%eax
    3401:	01 c0                	add    %eax,%eax
    3403:	01 d0                	add    %edx,%eax
    3405:	a3 a0 7e 00 00       	mov    %eax,0x7ea0
if (rand_num < 0)
    340a:	a1 a0 7e 00 00       	mov    0x7ea0,%eax
    340f:	85 c0                	test   %eax,%eax
    3411:	79 0c                	jns    341f <random+0x37>
{
rand_num *= (-1);
    3413:	a1 a0 7e 00 00       	mov    0x7ea0,%eax
    3418:	f7 d8                	neg    %eax
    341a:	a3 a0 7e 00 00       	mov    %eax,0x7ea0
}
return rand_num % 997;
    341f:	8b 0d a0 7e 00 00    	mov    0x7ea0,%ecx
    3425:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    342a:	89 c8                	mov    %ecx,%eax
    342c:	f7 ea                	imul   %edx
    342e:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    3431:	c1 f8 09             	sar    $0x9,%eax
    3434:	89 c2                	mov    %eax,%edx
    3436:	89 c8                	mov    %ecx,%eax
    3438:	c1 f8 1f             	sar    $0x1f,%eax
    343b:	29 c2                	sub    %eax,%edx
    343d:	89 d0                	mov    %edx,%eax
    343f:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    3445:	29 c1                	sub    %eax,%ecx
    3447:	89 c8                	mov    %ecx,%eax
}
    3449:	5d                   	pop    %ebp
    344a:	c3                   	ret    

0000344b <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    344b:	55                   	push   %ebp
    344c:	89 e5                	mov    %esp,%ebp
    344e:	53                   	push   %ebx
    344f:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    3452:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    3459:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    345d:	74 17                	je     3476 <sprintint+0x2b>
    345f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    3463:	79 11                	jns    3476 <sprintint+0x2b>
        neg = 1;
    3465:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    346c:	8b 45 10             	mov    0x10(%ebp),%eax
    346f:	f7 d8                	neg    %eax
    3471:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3474:	eb 06                	jmp    347c <sprintint+0x31>
    } else {
        x = xx;
    3476:	8b 45 10             	mov    0x10(%ebp),%eax
    3479:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    347c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    3483:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    3486:	8d 41 01             	lea    0x1(%ecx),%eax
    3489:	89 45 f8             	mov    %eax,-0x8(%ebp)
    348c:	8b 5d 14             	mov    0x14(%ebp),%ebx
    348f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3492:	ba 00 00 00 00       	mov    $0x0,%edx
    3497:	f7 f3                	div    %ebx
    3499:	89 d0                	mov    %edx,%eax
    349b:	0f b6 80 a4 7e 00 00 	movzbl 0x7ea4(%eax),%eax
    34a2:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    34a6:	8b 5d 14             	mov    0x14(%ebp),%ebx
    34a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    34ac:	ba 00 00 00 00       	mov    $0x0,%edx
    34b1:	f7 f3                	div    %ebx
    34b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    34b6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    34ba:	75 c7                	jne    3483 <sprintint+0x38>
    if(neg)
    34bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    34c0:	74 0e                	je     34d0 <sprintint+0x85>
        buf[i++] = '-';
    34c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    34c5:	8d 50 01             	lea    0x1(%eax),%edx
    34c8:	89 55 f8             	mov    %edx,-0x8(%ebp)
    34cb:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    34d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    34d3:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    34d6:	eb 1b                	jmp    34f3 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    34d8:	8b 45 0c             	mov    0xc(%ebp),%eax
    34db:	8b 00                	mov    (%eax),%eax
    34dd:	8d 48 01             	lea    0x1(%eax),%ecx
    34e0:	8b 55 0c             	mov    0xc(%ebp),%edx
    34e3:	89 0a                	mov    %ecx,(%edx)
    34e5:	89 c2                	mov    %eax,%edx
    34e7:	8b 45 08             	mov    0x8(%ebp),%eax
    34ea:	01 d0                	add    %edx,%eax
    34ec:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    34ef:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    34f3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    34f7:	7f df                	jg     34d8 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    34f9:	eb 21                	jmp    351c <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    34fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    34fe:	8b 00                	mov    (%eax),%eax
    3500:	8d 48 01             	lea    0x1(%eax),%ecx
    3503:	8b 55 0c             	mov    0xc(%ebp),%edx
    3506:	89 0a                	mov    %ecx,(%edx)
    3508:	89 c2                	mov    %eax,%edx
    350a:	8b 45 08             	mov    0x8(%ebp),%eax
    350d:	01 c2                	add    %eax,%edx
    350f:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    3512:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3515:	01 c8                	add    %ecx,%eax
    3517:	0f b6 00             	movzbl (%eax),%eax
    351a:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    351c:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    3520:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    3524:	79 d5                	jns    34fb <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    3526:	90                   	nop
    3527:	83 c4 20             	add    $0x20,%esp
    352a:	5b                   	pop    %ebx
    352b:	5d                   	pop    %ebp
    352c:	c3                   	ret    

0000352d <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    352d:	55                   	push   %ebp
    352e:	89 e5                	mov    %esp,%ebp
    3530:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    3533:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    353a:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    3541:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    3548:	8d 45 0c             	lea    0xc(%ebp),%eax
    354b:	83 c0 04             	add    $0x4,%eax
    354e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    3551:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    3558:	e9 d9 01 00 00       	jmp    3736 <sprintf+0x209>
        c = fmt[i] & 0xff;
    355d:	8b 55 0c             	mov    0xc(%ebp),%edx
    3560:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3563:	01 d0                	add    %edx,%eax
    3565:	0f b6 00             	movzbl (%eax),%eax
    3568:	0f be c0             	movsbl %al,%eax
    356b:	25 ff 00 00 00       	and    $0xff,%eax
    3570:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    3573:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    3577:	75 2c                	jne    35a5 <sprintf+0x78>
            if(c == '%'){
    3579:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    357d:	75 0c                	jne    358b <sprintf+0x5e>
                state = '%';
    357f:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    3586:	e9 a7 01 00 00       	jmp    3732 <sprintf+0x205>
            } else {
                dst[j++] = c;
    358b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    358e:	8d 50 01             	lea    0x1(%eax),%edx
    3591:	89 55 c8             	mov    %edx,-0x38(%ebp)
    3594:	89 c2                	mov    %eax,%edx
    3596:	8b 45 08             	mov    0x8(%ebp),%eax
    3599:	01 d0                	add    %edx,%eax
    359b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    359e:	88 10                	mov    %dl,(%eax)
    35a0:	e9 8d 01 00 00       	jmp    3732 <sprintf+0x205>
            }
        } else if(state == '%'){
    35a5:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    35a9:	0f 85 83 01 00 00    	jne    3732 <sprintf+0x205>
            if(c == 'd'){
    35af:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    35b3:	75 4c                	jne    3601 <sprintf+0xd4>
                buf[bi] = '\0';
    35b5:	8d 55 ce             	lea    -0x32(%ebp),%edx
    35b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    35bb:	01 d0                	add    %edx,%eax
    35bd:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    35c0:	83 ec 0c             	sub    $0xc,%esp
    35c3:	8d 45 ce             	lea    -0x32(%ebp),%eax
    35c6:	50                   	push   %eax
    35c7:	e8 0f de ff ff       	call   13db <atoi>
    35cc:	83 c4 10             	add    $0x10,%esp
    35cf:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    35d2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    35d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    35dc:	8b 00                	mov    (%eax),%eax
    35de:	83 ec 08             	sub    $0x8,%esp
    35e1:	ff 75 d8             	pushl  -0x28(%ebp)
    35e4:	6a 01                	push   $0x1
    35e6:	6a 0a                	push   $0xa
    35e8:	50                   	push   %eax
    35e9:	8d 45 c8             	lea    -0x38(%ebp),%eax
    35ec:	50                   	push   %eax
    35ed:	ff 75 08             	pushl  0x8(%ebp)
    35f0:	e8 56 fe ff ff       	call   344b <sprintint>
    35f5:	83 c4 20             	add    $0x20,%esp
                ap++;
    35f8:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    35fc:	e9 2a 01 00 00       	jmp    372b <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    3601:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    3605:	74 06                	je     360d <sprintf+0xe0>
    3607:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    360b:	75 4c                	jne    3659 <sprintf+0x12c>
                buf[bi] = '\0';
    360d:	8d 55 ce             	lea    -0x32(%ebp),%edx
    3610:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3613:	01 d0                	add    %edx,%eax
    3615:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    3618:	83 ec 0c             	sub    $0xc,%esp
    361b:	8d 45 ce             	lea    -0x32(%ebp),%eax
    361e:	50                   	push   %eax
    361f:	e8 b7 dd ff ff       	call   13db <atoi>
    3624:	83 c4 10             	add    $0x10,%esp
    3627:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    362a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    3631:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3634:	8b 00                	mov    (%eax),%eax
    3636:	83 ec 08             	sub    $0x8,%esp
    3639:	ff 75 dc             	pushl  -0x24(%ebp)
    363c:	6a 00                	push   $0x0
    363e:	6a 10                	push   $0x10
    3640:	50                   	push   %eax
    3641:	8d 45 c8             	lea    -0x38(%ebp),%eax
    3644:	50                   	push   %eax
    3645:	ff 75 08             	pushl  0x8(%ebp)
    3648:	e8 fe fd ff ff       	call   344b <sprintint>
    364d:	83 c4 20             	add    $0x20,%esp
                ap++;
    3650:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    3654:	e9 d2 00 00 00       	jmp    372b <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    3659:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    365d:	75 46                	jne    36a5 <sprintf+0x178>
                s = (char*)*ap;
    365f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3662:	8b 00                	mov    (%eax),%eax
    3664:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    3667:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    366b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    366f:	75 25                	jne    3696 <sprintf+0x169>
                    s = "(null)";
    3671:	c7 45 f4 48 3b 00 00 	movl   $0x3b48,-0xc(%ebp)
                while(*s != 0){
    3678:	eb 1c                	jmp    3696 <sprintf+0x169>
                    dst[j++] = *s;
    367a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    367d:	8d 50 01             	lea    0x1(%eax),%edx
    3680:	89 55 c8             	mov    %edx,-0x38(%ebp)
    3683:	89 c2                	mov    %eax,%edx
    3685:	8b 45 08             	mov    0x8(%ebp),%eax
    3688:	01 c2                	add    %eax,%edx
    368a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    368d:	0f b6 00             	movzbl (%eax),%eax
    3690:	88 02                	mov    %al,(%edx)
                    s++;
    3692:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    3696:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3699:	0f b6 00             	movzbl (%eax),%eax
    369c:	84 c0                	test   %al,%al
    369e:	75 da                	jne    367a <sprintf+0x14d>
    36a0:	e9 86 00 00 00       	jmp    372b <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    36a5:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    36a9:	75 1d                	jne    36c8 <sprintf+0x19b>
                dst[j++] = *ap;
    36ab:	8b 45 c8             	mov    -0x38(%ebp),%eax
    36ae:	8d 50 01             	lea    0x1(%eax),%edx
    36b1:	89 55 c8             	mov    %edx,-0x38(%ebp)
    36b4:	89 c2                	mov    %eax,%edx
    36b6:	8b 45 08             	mov    0x8(%ebp),%eax
    36b9:	01 c2                	add    %eax,%edx
    36bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    36be:	8b 00                	mov    (%eax),%eax
    36c0:	88 02                	mov    %al,(%edx)
                ap++;
    36c2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    36c6:	eb 63                	jmp    372b <sprintf+0x1fe>
            } else if(c == '%'){
    36c8:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    36cc:	75 17                	jne    36e5 <sprintf+0x1b8>
                dst[j++] = c;
    36ce:	8b 45 c8             	mov    -0x38(%ebp),%eax
    36d1:	8d 50 01             	lea    0x1(%eax),%edx
    36d4:	89 55 c8             	mov    %edx,-0x38(%ebp)
    36d7:	89 c2                	mov    %eax,%edx
    36d9:	8b 45 08             	mov    0x8(%ebp),%eax
    36dc:	01 d0                	add    %edx,%eax
    36de:	8b 55 e0             	mov    -0x20(%ebp),%edx
    36e1:	88 10                	mov    %dl,(%eax)
    36e3:	eb 46                	jmp    372b <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    36e5:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    36e9:	7e 18                	jle    3703 <sprintf+0x1d6>
    36eb:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    36ef:	7f 12                	jg     3703 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    36f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    36f4:	8d 50 01             	lea    0x1(%eax),%edx
    36f7:	89 55 f0             	mov    %edx,-0x10(%ebp)
    36fa:	8b 55 e0             	mov    -0x20(%ebp),%edx
    36fd:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    3701:	eb 2f                	jmp    3732 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    3703:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3706:	8d 50 01             	lea    0x1(%eax),%edx
    3709:	89 55 c8             	mov    %edx,-0x38(%ebp)
    370c:	89 c2                	mov    %eax,%edx
    370e:	8b 45 08             	mov    0x8(%ebp),%eax
    3711:	01 d0                	add    %edx,%eax
    3713:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    3716:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3719:	8d 50 01             	lea    0x1(%eax),%edx
    371c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    371f:	89 c2                	mov    %eax,%edx
    3721:	8b 45 08             	mov    0x8(%ebp),%eax
    3724:	01 d0                	add    %edx,%eax
    3726:	8b 55 e0             	mov    -0x20(%ebp),%edx
    3729:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    372b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    3732:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    3736:	8b 55 0c             	mov    0xc(%ebp),%edx
    3739:	8b 45 ec             	mov    -0x14(%ebp),%eax
    373c:	01 d0                	add    %edx,%eax
    373e:	0f b6 00             	movzbl (%eax),%eax
    3741:	84 c0                	test   %al,%al
    3743:	0f 85 14 fe ff ff    	jne    355d <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    3749:	8b 45 c8             	mov    -0x38(%ebp),%eax
    374c:	8d 50 01             	lea    0x1(%eax),%edx
    374f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    3752:	89 c2                	mov    %eax,%edx
    3754:	8b 45 08             	mov    0x8(%ebp),%eax
    3757:	01 d0                	add    %edx,%eax
    3759:	c6 00 00             	movb   $0x0,(%eax)
}
    375c:	90                   	nop
    375d:	c9                   	leave  
    375e:	c3                   	ret    
