
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
      e3:	8b 04 85 fc 36 00 00 	mov    0x36fc(,%eax,4),%eax
      ea:	ff e0                	jmp    *%eax
{
	case VK_UP:
		temp = nextpoint(position,Up);
      ec:	8d 45 f0             	lea    -0x10(%ebp),%eax
      ef:	6a 00                	push   $0x0
      f1:	ff 35 58 7e 00 00    	pushl  0x7e58
      f7:	ff 35 54 7e 00 00    	pushl  0x7e54
      fd:	50                   	push   %eax
      fe:	e8 42 ff ff ff       	call   45 <nextpoint>
     103:	83 c4 0c             	add    $0xc,%esp
		break;
     106:	eb 79                	jmp    181 <keyDown+0xb1>
	case VK_DOWN:

		temp = nextpoint(position,Down);
     108:	8d 45 d0             	lea    -0x30(%ebp),%eax
     10b:	6a 01                	push   $0x1
     10d:	ff 35 58 7e 00 00    	pushl  0x7e58
     113:	ff 35 54 7e 00 00    	pushl  0x7e54
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
     135:	ff 35 58 7e 00 00    	pushl  0x7e58
     13b:	ff 35 54 7e 00 00    	pushl  0x7e54
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
     15d:	ff 35 58 7e 00 00    	pushl  0x7e58
     163:	ff 35 54 7e 00 00    	pushl  0x7e54
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
     181:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     187:	8b 15 54 7e 00 00    	mov    0x7e54,%edx
     18d:	8b 0d 58 7e 00 00    	mov    0x7e58,%ecx
     193:	89 d0                	mov    %edx,%eax
     195:	c1 e0 02             	shl    $0x2,%eax
     198:	01 d0                	add    %edx,%eax
     19a:	01 c0                	add    %eax,%eax
     19c:	6b d3 64             	imul   $0x64,%ebx,%edx
     19f:	01 d0                	add    %edx,%eax
     1a1:	01 c8                	add    %ecx,%eax
     1a3:	c7 04 85 60 7f 00 00 	movl   $0x0,0x7f60(,%eax,4)
     1aa:	00 00 00 00 
AMessage ms;
ms.type = MSG_PAINT;
     1ae:	c7 45 e0 03 00 00 00 	movl   $0x3,-0x20(%ebp)
ms.param = 1;
     1b5:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
position_old = position;
     1bc:	a1 54 7e 00 00       	mov    0x7e54,%eax
     1c1:	8b 15 58 7e 00 00    	mov    0x7e58,%edx
     1c7:	a3 40 7e 00 00       	mov    %eax,0x7e40
     1cc:	89 15 44 7e 00 00    	mov    %edx,0x7e44
switch(my_tower[floor][temp.x][temp.y])
     1d2:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     1d8:	8b 55 f0             	mov    -0x10(%ebp),%edx
     1db:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     1de:	89 d0                	mov    %edx,%eax
     1e0:	c1 e0 02             	shl    $0x2,%eax
     1e3:	01 d0                	add    %edx,%eax
     1e5:	01 c0                	add    %eax,%eax
     1e7:	6b d3 64             	imul   $0x64,%ebx,%edx
     1ea:	01 d0                	add    %edx,%eax
     1ec:	01 c8                	add    %ecx,%eax
     1ee:	8b 04 85 60 7f 00 00 	mov    0x7f60(,%eax,4),%eax
     1f5:	83 f8 11             	cmp    $0x11,%eax
     1f8:	0f 87 d4 03 00 00    	ja     5d2 <keyDown+0x502>
     1fe:	8b 04 85 14 37 00 00 	mov    0x3714(,%eax,4),%eax
     205:	ff e0                	jmp    *%eax
{
	case Background:

		position = temp;
     207:	8b 45 f0             	mov    -0x10(%ebp),%eax
     20a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     20d:	a3 54 7e 00 00       	mov    %eax,0x7e54
     212:	89 15 58 7e 00 00    	mov    %edx,0x7e58
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
     223:	a3 54 7e 00 00       	mov    %eax,0x7e54
     228:	89 15 58 7e 00 00    	mov    %edx,0x7e58
		if(!fight())
     22e:	e8 bc 08 00 00       	call   aef <fight>
     233:	84 c0                	test   %al,%al
     235:	0f 85 9a 03 00 00    	jne    5d5 <keyDown+0x505>
		{
		printf(1,"Dead");
     23b:	83 ec 08             	sub    $0x8,%esp
     23e:	68 d0 36 00 00       	push   $0x36d0
     243:	6a 01                	push   $0x1
     245:	e8 52 13 00 00       	call   159c <printf>
     24a:	83 c4 10             	add    $0x10,%esp
		}
		break;
     24d:	e9 83 03 00 00       	jmp    5d5 <keyDown+0x505>
	case YellowDoor:
		if (my_key[0] > 0)
     252:	a1 10 84 00 00       	mov    0x8410,%eax
     257:	85 c0                	test   %eax,%eax
     259:	7e 4a                	jle    2a5 <keyDown+0x1d5>
		{
		my_key[0]--;
     25b:	a1 10 84 00 00       	mov    0x8410,%eax
     260:	83 e8 01             	sub    $0x1,%eax
     263:	a3 10 84 00 00       	mov    %eax,0x8410
		position = temp;
     268:	8b 45 f0             	mov    -0x10(%ebp),%eax
     26b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     26e:	a3 54 7e 00 00       	mov    %eax,0x7e54
     273:	89 15 58 7e 00 00    	mov    %edx,0x7e58
		my_tower[floor][temp.x][temp.y] = Background;
     279:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     27f:	8b 55 f0             	mov    -0x10(%ebp),%edx
     282:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     285:	89 d0                	mov    %edx,%eax
     287:	c1 e0 02             	shl    $0x2,%eax
     28a:	01 d0                	add    %edx,%eax
     28c:	01 c0                	add    %eax,%eax
     28e:	6b d3 64             	imul   $0x64,%ebx,%edx
     291:	01 d0                	add    %edx,%eax
     293:	01 c8                	add    %ecx,%eax
     295:	c7 04 85 60 7f 00 00 	movl   $0x0,0x7f60(,%eax,4)
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
     2a8:	68 d5 36 00 00       	push   $0x36d5
     2ad:	6a 01                	push   $0x1
     2af:	e8 e8 12 00 00       	call   159c <printf>
     2b4:	83 c4 10             	add    $0x10,%esp
		}
		break;
     2b7:	e9 1a 03 00 00       	jmp    5d6 <keyDown+0x506>
	case BlueDoor:
		if (my_key[1] > 0)
     2bc:	a1 14 84 00 00       	mov    0x8414,%eax
     2c1:	85 c0                	test   %eax,%eax
     2c3:	7e 4a                	jle    30f <keyDown+0x23f>
		{
		my_key[1]--;
     2c5:	a1 14 84 00 00       	mov    0x8414,%eax
     2ca:	83 e8 01             	sub    $0x1,%eax
     2cd:	a3 14 84 00 00       	mov    %eax,0x8414
		position = temp;
     2d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     2d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     2d8:	a3 54 7e 00 00       	mov    %eax,0x7e54
     2dd:	89 15 58 7e 00 00    	mov    %edx,0x7e58
		my_tower[floor][temp.x][temp.y] = Background;
     2e3:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     2e9:	8b 55 f0             	mov    -0x10(%ebp),%edx
     2ec:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     2ef:	89 d0                	mov    %edx,%eax
     2f1:	c1 e0 02             	shl    $0x2,%eax
     2f4:	01 d0                	add    %edx,%eax
     2f6:	01 c0                	add    %eax,%eax
     2f8:	6b d3 64             	imul   $0x64,%ebx,%edx
     2fb:	01 d0                	add    %edx,%eax
     2fd:	01 c8                	add    %ecx,%eax
     2ff:	c7 04 85 60 7f 00 00 	movl   $0x0,0x7f60(,%eax,4)
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
     312:	68 e3 36 00 00       	push   $0x36e3
     317:	6a 01                	push   $0x1
     319:	e8 7e 12 00 00       	call   159c <printf>
     31e:	83 c4 10             	add    $0x10,%esp
		}
		break;
     321:	e9 b0 02 00 00       	jmp    5d6 <keyDown+0x506>
	case RedDoor:
		if (my_key[1] > 0)
     326:	a1 14 84 00 00       	mov    0x8414,%eax
     32b:	85 c0                	test   %eax,%eax
     32d:	7e 4a                	jle    379 <keyDown+0x2a9>
		{
		my_key[1]--;
     32f:	a1 14 84 00 00       	mov    0x8414,%eax
     334:	83 e8 01             	sub    $0x1,%eax
     337:	a3 14 84 00 00       	mov    %eax,0x8414
		position = temp;
     33c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     33f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     342:	a3 54 7e 00 00       	mov    %eax,0x7e54
     347:	89 15 58 7e 00 00    	mov    %edx,0x7e58
		my_tower[floor][temp.x][temp.y] = Background;
     34d:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     353:	8b 55 f0             	mov    -0x10(%ebp),%edx
     356:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     359:	89 d0                	mov    %edx,%eax
     35b:	c1 e0 02             	shl    $0x2,%eax
     35e:	01 d0                	add    %edx,%eax
     360:	01 c0                	add    %eax,%eax
     362:	6b d3 64             	imul   $0x64,%ebx,%edx
     365:	01 d0                	add    %edx,%eax
     367:	01 c8                	add    %ecx,%eax
     369:	c7 04 85 60 7f 00 00 	movl   $0x0,0x7f60(,%eax,4)
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
     37c:	68 ef 36 00 00       	push   $0x36ef
     381:	6a 01                	push   $0x1
     383:	e8 14 12 00 00       	call   159c <printf>
     388:	83 c4 10             	add    $0x10,%esp
		}
		break;
     38b:	e9 46 02 00 00       	jmp    5d6 <keyDown+0x506>
	case UpStair:
		floor++;
     390:	a1 24 7e 00 00       	mov    0x7e24,%eax
     395:	83 c0 01             	add    $0x1,%eax
     398:	a3 24 7e 00 00       	mov    %eax,0x7e24
		draw(hwnd);
     39d:	83 ec 0c             	sub    $0xc,%esp
     3a0:	ff 75 08             	pushl  0x8(%ebp)
     3a3:	e8 7f 08 00 00       	call   c27 <draw>
     3a8:	83 c4 10             	add    $0x10,%esp
		break;
     3ab:	e9 26 02 00 00       	jmp    5d6 <keyDown+0x506>
	case DownStair:
		floor--;
     3b0:	a1 24 7e 00 00       	mov    0x7e24,%eax
     3b5:	83 e8 01             	sub    $0x1,%eax
     3b8:	a3 24 7e 00 00       	mov    %eax,0x7e24
		draw(hwnd);
     3bd:	83 ec 0c             	sub    $0xc,%esp
     3c0:	ff 75 08             	pushl  0x8(%ebp)
     3c3:	e8 5f 08 00 00       	call   c27 <draw>
     3c8:	83 c4 10             	add    $0x10,%esp
		break;
     3cb:	e9 06 02 00 00       	jmp    5d6 <keyDown+0x506>
	case YellowKey:
		my_key[0]++;
     3d0:	a1 10 84 00 00       	mov    0x8410,%eax
     3d5:	83 c0 01             	add    $0x1,%eax
     3d8:	a3 10 84 00 00       	mov    %eax,0x8410
		my_tower[floor][temp.x][temp.y] = Background;
     3dd:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     3e3:	8b 55 f0             	mov    -0x10(%ebp),%edx
     3e6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3e9:	89 d0                	mov    %edx,%eax
     3eb:	c1 e0 02             	shl    $0x2,%eax
     3ee:	01 d0                	add    %edx,%eax
     3f0:	01 c0                	add    %eax,%eax
     3f2:	6b d3 64             	imul   $0x64,%ebx,%edx
     3f5:	01 d0                	add    %edx,%eax
     3f7:	01 c8                	add    %ecx,%eax
     3f9:	c7 04 85 60 7f 00 00 	movl   $0x0,0x7f60(,%eax,4)
     400:	00 00 00 00 
		position = temp;
     404:	8b 45 f0             	mov    -0x10(%ebp),%eax
     407:	8b 55 f4             	mov    -0xc(%ebp),%edx
     40a:	a3 54 7e 00 00       	mov    %eax,0x7e54
     40f:	89 15 58 7e 00 00    	mov    %edx,0x7e58
		break;
     415:	e9 bc 01 00 00       	jmp    5d6 <keyDown+0x506>
	case BlueKey:
		my_key[1]++;
     41a:	a1 14 84 00 00       	mov    0x8414,%eax
     41f:	83 c0 01             	add    $0x1,%eax
     422:	a3 14 84 00 00       	mov    %eax,0x8414
		my_tower[floor][temp.x][temp.y] = Background;
     427:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     42d:	8b 55 f0             	mov    -0x10(%ebp),%edx
     430:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     433:	89 d0                	mov    %edx,%eax
     435:	c1 e0 02             	shl    $0x2,%eax
     438:	01 d0                	add    %edx,%eax
     43a:	01 c0                	add    %eax,%eax
     43c:	6b d3 64             	imul   $0x64,%ebx,%edx
     43f:	01 d0                	add    %edx,%eax
     441:	01 c8                	add    %ecx,%eax
     443:	c7 04 85 60 7f 00 00 	movl   $0x0,0x7f60(,%eax,4)
     44a:	00 00 00 00 
		position = temp;
     44e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     451:	8b 55 f4             	mov    -0xc(%ebp),%edx
     454:	a3 54 7e 00 00       	mov    %eax,0x7e54
     459:	89 15 58 7e 00 00    	mov    %edx,0x7e58
		break;
     45f:	e9 72 01 00 00       	jmp    5d6 <keyDown+0x506>
	case RedKey:
		my_key[2]++;
     464:	a1 18 84 00 00       	mov    0x8418,%eax
     469:	83 c0 01             	add    $0x1,%eax
     46c:	a3 18 84 00 00       	mov    %eax,0x8418
		my_tower[floor][temp.x][temp.y] = Background;
     471:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     477:	8b 55 f0             	mov    -0x10(%ebp),%edx
     47a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     47d:	89 d0                	mov    %edx,%eax
     47f:	c1 e0 02             	shl    $0x2,%eax
     482:	01 d0                	add    %edx,%eax
     484:	01 c0                	add    %eax,%eax
     486:	6b d3 64             	imul   $0x64,%ebx,%edx
     489:	01 d0                	add    %edx,%eax
     48b:	01 c8                	add    %ecx,%eax
     48d:	c7 04 85 60 7f 00 00 	movl   $0x0,0x7f60(,%eax,4)
     494:	00 00 00 00 
		position = temp;
     498:	8b 45 f0             	mov    -0x10(%ebp),%eax
     49b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     49e:	a3 54 7e 00 00       	mov    %eax,0x7e54
     4a3:	89 15 58 7e 00 00    	mov    %edx,0x7e58
		break;
     4a9:	e9 28 01 00 00       	jmp    5d6 <keyDown+0x506>
	case SBlood:
		hp += 100;
     4ae:	a1 50 7f 00 00       	mov    0x7f50,%eax
     4b3:	83 c0 64             	add    $0x64,%eax
     4b6:	a3 50 7f 00 00       	mov    %eax,0x7f50
		my_tower[floor][temp.x][temp.y] = Background;
     4bb:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     4c1:	8b 55 f0             	mov    -0x10(%ebp),%edx
     4c4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     4c7:	89 d0                	mov    %edx,%eax
     4c9:	c1 e0 02             	shl    $0x2,%eax
     4cc:	01 d0                	add    %edx,%eax
     4ce:	01 c0                	add    %eax,%eax
     4d0:	6b d3 64             	imul   $0x64,%ebx,%edx
     4d3:	01 d0                	add    %edx,%eax
     4d5:	01 c8                	add    %ecx,%eax
     4d7:	c7 04 85 60 7f 00 00 	movl   $0x0,0x7f60(,%eax,4)
     4de:	00 00 00 00 
		position = temp;
     4e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     4e8:	a3 54 7e 00 00       	mov    %eax,0x7e54
     4ed:	89 15 58 7e 00 00    	mov    %edx,0x7e58
		break;
     4f3:	e9 de 00 00 00       	jmp    5d6 <keyDown+0x506>
	case LBlood:
		hp += 500;
     4f8:	a1 50 7f 00 00       	mov    0x7f50,%eax
     4fd:	05 f4 01 00 00       	add    $0x1f4,%eax
     502:	a3 50 7f 00 00       	mov    %eax,0x7f50
		my_tower[floor][temp.x][temp.y] = Background;
     507:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     50d:	8b 55 f0             	mov    -0x10(%ebp),%edx
     510:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     513:	89 d0                	mov    %edx,%eax
     515:	c1 e0 02             	shl    $0x2,%eax
     518:	01 d0                	add    %edx,%eax
     51a:	01 c0                	add    %eax,%eax
     51c:	6b d3 64             	imul   $0x64,%ebx,%edx
     51f:	01 d0                	add    %edx,%eax
     521:	01 c8                	add    %ecx,%eax
     523:	c7 04 85 60 7f 00 00 	movl   $0x0,0x7f60(,%eax,4)
     52a:	00 00 00 00 
		position = temp;
     52e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     531:	8b 55 f4             	mov    -0xc(%ebp),%edx
     534:	a3 54 7e 00 00       	mov    %eax,0x7e54
     539:	89 15 58 7e 00 00    	mov    %edx,0x7e58
		break;
     53f:	e9 92 00 00 00       	jmp    5d6 <keyDown+0x506>
	case Attack:
		atk += 1;
     544:	a1 0c 7e 00 00       	mov    0x7e0c,%eax
     549:	83 c0 01             	add    $0x1,%eax
     54c:	a3 0c 7e 00 00       	mov    %eax,0x7e0c
		my_tower[floor][temp.x][temp.y] = Background;
     551:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     557:	8b 55 f0             	mov    -0x10(%ebp),%edx
     55a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     55d:	89 d0                	mov    %edx,%eax
     55f:	c1 e0 02             	shl    $0x2,%eax
     562:	01 d0                	add    %edx,%eax
     564:	01 c0                	add    %eax,%eax
     566:	6b d3 64             	imul   $0x64,%ebx,%edx
     569:	01 d0                	add    %edx,%eax
     56b:	01 c8                	add    %ecx,%eax
     56d:	c7 04 85 60 7f 00 00 	movl   $0x0,0x7f60(,%eax,4)
     574:	00 00 00 00 
		position = temp;
     578:	8b 45 f0             	mov    -0x10(%ebp),%eax
     57b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     57e:	a3 54 7e 00 00       	mov    %eax,0x7e54
     583:	89 15 58 7e 00 00    	mov    %edx,0x7e58
		break;
     589:	eb 4b                	jmp    5d6 <keyDown+0x506>
	case Defend:
		def += 1;
     58b:	a1 10 7e 00 00       	mov    0x7e10,%eax
     590:	83 c0 01             	add    $0x1,%eax
     593:	a3 10 7e 00 00       	mov    %eax,0x7e10
		my_tower[floor][temp.x][temp.y] = Background;
     598:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     59e:	8b 55 f0             	mov    -0x10(%ebp),%edx
     5a1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     5a4:	89 d0                	mov    %edx,%eax
     5a6:	c1 e0 02             	shl    $0x2,%eax
     5a9:	01 d0                	add    %edx,%eax
     5ab:	01 c0                	add    %eax,%eax
     5ad:	6b d3 64             	imul   $0x64,%ebx,%edx
     5b0:	01 d0                	add    %edx,%eax
     5b2:	01 c8                	add    %ecx,%eax
     5b4:	c7 04 85 60 7f 00 00 	movl   $0x0,0x7f60(,%eax,4)
     5bb:	00 00 00 00 
		position = temp;
     5bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
     5c5:	a3 54 7e 00 00       	mov    %eax,0x7e54
     5ca:	89 15 58 7e 00 00    	mov    %edx,0x7e58
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
     5d6:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     5dc:	8b 15 54 7e 00 00    	mov    0x7e54,%edx
     5e2:	8b 0d 58 7e 00 00    	mov    0x7e58,%ecx
     5e8:	89 d0                	mov    %edx,%eax
     5ea:	c1 e0 02             	shl    $0x2,%eax
     5ed:	01 d0                	add    %edx,%eax
     5ef:	01 c0                	add    %eax,%eax
     5f1:	6b d3 64             	imul   $0x64,%ebx,%edx
     5f4:	01 d0                	add    %edx,%eax
     5f6:	01 c8                	add    %ecx,%eax
     5f8:	c7 04 85 60 7f 00 00 	movl   $0x5,0x7f60(,%eax,4)
     5ff:	05 00 00 00 
APSendMessage(hwnd,ms);
     603:	83 ec 0c             	sub    $0xc,%esp
     606:	ff 75 ec             	pushl  -0x14(%ebp)
     609:	ff 75 e8             	pushl  -0x18(%ebp)
     60c:	ff 75 e4             	pushl  -0x1c(%ebp)
     60f:	ff 75 e0             	pushl  -0x20(%ebp)
     612:	ff 75 08             	pushl  0x8(%ebp)
     615:	e8 2f 20 00 00       	call   2649 <APSendMessage>
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
     659:	c7 04 85 60 7f 00 00 	movl   $0x0,0x7f60(,%eax,4)
     660:	00 00 00 00 
     664:	8b 55 fc             	mov    -0x4(%ebp),%edx
     667:	89 d0                	mov    %edx,%eax
     669:	c1 e0 02             	shl    $0x2,%eax
     66c:	01 d0                	add    %edx,%eax
     66e:	01 c0                	add    %eax,%eax
     670:	8b 55 f8             	mov    -0x8(%ebp),%edx
     673:	01 d0                	add    %edx,%eax
     675:	05 c8 00 00 00       	add    $0xc8,%eax
     67a:	8b 0c 85 60 7f 00 00 	mov    0x7f60(,%eax,4),%ecx
     681:	8b 55 fc             	mov    -0x4(%ebp),%edx
     684:	89 d0                	mov    %edx,%eax
     686:	c1 e0 02             	shl    $0x2,%eax
     689:	01 d0                	add    %edx,%eax
     68b:	01 c0                	add    %eax,%eax
     68d:	8b 55 f8             	mov    -0x8(%ebp),%edx
     690:	01 d0                	add    %edx,%eax
     692:	83 c0 64             	add    $0x64,%eax
     695:	89 0c 85 60 7f 00 00 	mov    %ecx,0x7f60(,%eax,4)
     69c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     69f:	89 d0                	mov    %edx,%eax
     6a1:	c1 e0 02             	shl    $0x2,%eax
     6a4:	01 d0                	add    %edx,%eax
     6a6:	01 c0                	add    %eax,%eax
     6a8:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6ab:	01 d0                	add    %edx,%eax
     6ad:	83 c0 64             	add    $0x64,%eax
     6b0:	8b 0c 85 60 7f 00 00 	mov    0x7f60(,%eax,4),%ecx
     6b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
     6ba:	89 d0                	mov    %edx,%eax
     6bc:	c1 e0 02             	shl    $0x2,%eax
     6bf:	01 d0                	add    %edx,%eax
     6c1:	01 c0                	add    %eax,%eax
     6c3:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6c6:	01 d0                	add    %edx,%eax
     6c8:	89 0c 85 60 7f 00 00 	mov    %ecx,0x7f60(,%eax,4)

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
my_tower[0][0][1] = Wall; 
     6eb:	c7 05 64 7f 00 00 01 	movl   $0x1,0x7f64
     6f2:	00 00 00 
my_tower[0][1][1] = Monster1; 
     6f5:	c7 05 8c 7f 00 00 02 	movl   $0x2,0x7f8c
     6fc:	00 00 00 
my_tower[0][2][2] = UpStair;
     6ff:	c7 05 b8 7f 00 00 09 	movl   $0x9,0x7fb8
     706:	00 00 00 
my_tower[1][2][2] = DownStair;
     709:	c7 05 48 81 00 00 0a 	movl   $0xa,0x8148
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
     722:	c7 05 50 7f 00 00 f4 	movl   $0x1f4,0x7f50
     729:	01 00 00 
	atk = START_ATK;
     72c:	c7 05 0c 7e 00 00 0a 	movl   $0xa,0x7e0c
     733:	00 00 00 
	def = START_DEF;
     736:	c7 05 10 7e 00 00 0a 	movl   $0xa,0x7e10
     73d:	00 00 00 
	//init the Viliant

	floor = 0;
     740:	c7 05 24 7e 00 00 00 	movl   $0x0,0x7e24
     747:	00 00 00 
	position.x = position.y = 0;
     74a:	c7 05 58 7e 00 00 00 	movl   $0x0,0x7e58
     751:	00 00 00 
     754:	a1 58 7e 00 00       	mov    0x7e58,%eax
     759:	a3 54 7e 00 00       	mov    %eax,0x7e54
	my_tower[floor][position.x][position.y] = Valiant;
     75e:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     764:	8b 15 54 7e 00 00    	mov    0x7e54,%edx
     76a:	8b 0d 58 7e 00 00    	mov    0x7e58,%ecx
     770:	89 d0                	mov    %edx,%eax
     772:	c1 e0 02             	shl    $0x2,%eax
     775:	01 d0                	add    %edx,%eax
     777:	01 c0                	add    %eax,%eax
     779:	6b d3 64             	imul   $0x64,%ebx,%edx
     77c:	01 d0                	add    %edx,%eax
     77e:	01 c8                	add    %ecx,%eax
     780:	c7 04 85 60 7f 00 00 	movl   $0x5,0x7f60(,%eax,4)
     787:	05 00 00 00 
	my_key[0] = 3;
     78b:	c7 05 10 84 00 00 03 	movl   $0x3,0x8410
     792:	00 00 00 
	my_key[1] = my_key[2] = 0;
     795:	c7 05 18 84 00 00 00 	movl   $0x0,0x8418
     79c:	00 00 00 
     79f:	a1 18 84 00 00       	mov    0x8418,%eax
     7a4:	a3 14 84 00 00       	mov    %eax,0x8414

 background = APLoadBitmap ("background.bmp");
     7a9:	8d 45 d8             	lea    -0x28(%ebp),%eax
     7ac:	83 ec 08             	sub    $0x8,%esp
     7af:	68 5c 37 00 00       	push   $0x375c
     7b4:	50                   	push   %eax
     7b5:	e8 68 12 00 00       	call   1a22 <APLoadBitmap>
     7ba:	83 c4 0c             	add    $0xc,%esp
     7bd:	8b 45 d8             	mov    -0x28(%ebp),%eax
     7c0:	a3 34 7e 00 00       	mov    %eax,0x7e34
     7c5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     7c8:	a3 38 7e 00 00       	mov    %eax,0x7e38
     7cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7d0:	a3 3c 7e 00 00       	mov    %eax,0x7e3c
 wall = APLoadBitmap ("wall.bmp");
     7d5:	8d 45 d8             	lea    -0x28(%ebp),%eax
     7d8:	83 ec 08             	sub    $0x8,%esp
     7db:	68 6b 37 00 00       	push   $0x376b
     7e0:	50                   	push   %eax
     7e1:	e8 3c 12 00 00       	call   1a22 <APLoadBitmap>
     7e6:	83 c4 0c             	add    $0xc,%esp
     7e9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     7ec:	a3 38 7f 00 00       	mov    %eax,0x7f38
     7f1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     7f4:	a3 3c 7f 00 00       	mov    %eax,0x7f3c
     7f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7fc:	a3 40 7f 00 00       	mov    %eax,0x7f40
 monster1 = APLoadBitmap ("monster1.bmp");
     801:	8d 45 d8             	lea    -0x28(%ebp),%eax
     804:	83 ec 08             	sub    $0x8,%esp
     807:	68 74 37 00 00       	push   $0x3774
     80c:	50                   	push   %eax
     80d:	e8 10 12 00 00       	call   1a22 <APLoadBitmap>
     812:	83 c4 0c             	add    $0xc,%esp
     815:	8b 45 d8             	mov    -0x28(%ebp),%eax
     818:	a3 44 7f 00 00       	mov    %eax,0x7f44
     81d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     820:	a3 48 7f 00 00       	mov    %eax,0x7f48
     825:	8b 45 e0             	mov    -0x20(%ebp),%eax
     828:	a3 4c 7f 00 00       	mov    %eax,0x7f4c
 monster2 = APLoadBitmap ("monster2.bmp");
     82d:	8d 45 d8             	lea    -0x28(%ebp),%eax
     830:	83 ec 08             	sub    $0x8,%esp
     833:	68 81 37 00 00       	push   $0x3781
     838:	50                   	push   %eax
     839:	e8 e4 11 00 00       	call   1a22 <APLoadBitmap>
     83e:	83 c4 0c             	add    $0xc,%esp
     841:	8b 45 d8             	mov    -0x28(%ebp),%eax
     844:	a3 a0 7e 00 00       	mov    %eax,0x7ea0
     849:	8b 45 dc             	mov    -0x24(%ebp),%eax
     84c:	a3 a4 7e 00 00       	mov    %eax,0x7ea4
     851:	8b 45 e0             	mov    -0x20(%ebp),%eax
     854:	a3 a8 7e 00 00       	mov    %eax,0x7ea8
 monster3 = APLoadBitmap ("monster3.bmp");
     859:	8d 45 d8             	lea    -0x28(%ebp),%eax
     85c:	83 ec 08             	sub    $0x8,%esp
     85f:	68 8e 37 00 00       	push   $0x378e
     864:	50                   	push   %eax
     865:	e8 b8 11 00 00       	call   1a22 <APLoadBitmap>
     86a:	83 c4 0c             	add    $0xc,%esp
     86d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     870:	a3 d8 7e 00 00       	mov    %eax,0x7ed8
     875:	8b 45 dc             	mov    -0x24(%ebp),%eax
     878:	a3 dc 7e 00 00       	mov    %eax,0x7edc
     87d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     880:	a3 e0 7e 00 00       	mov    %eax,0x7ee0
 valiant = APLoadBitmap ("valiant.bmp");
     885:	8d 45 d8             	lea    -0x28(%ebp),%eax
     888:	83 ec 08             	sub    $0x8,%esp
     88b:	68 9b 37 00 00       	push   $0x379b
     890:	50                   	push   %eax
     891:	e8 8c 11 00 00       	call   1a22 <APLoadBitmap>
     896:	83 c4 0c             	add    $0xc,%esp
     899:	8b 45 d8             	mov    -0x28(%ebp),%eax
     89c:	a3 20 84 00 00       	mov    %eax,0x8420
     8a1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     8a4:	a3 24 84 00 00       	mov    %eax,0x8424
     8a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     8ac:	a3 28 84 00 00       	mov    %eax,0x8428
 yellowdoor = APLoadBitmap ("yellowdoor.bmp");
     8b1:	8d 45 d8             	lea    -0x28(%ebp),%eax
     8b4:	83 ec 08             	sub    $0x8,%esp
     8b7:	68 a7 37 00 00       	push   $0x37a7
     8bc:	50                   	push   %eax
     8bd:	e8 60 11 00 00       	call   1a22 <APLoadBitmap>
     8c2:	83 c4 0c             	add    $0xc,%esp
     8c5:	8b 45 d8             	mov    -0x28(%ebp),%eax
     8c8:	a3 68 7e 00 00       	mov    %eax,0x7e68
     8cd:	8b 45 dc             	mov    -0x24(%ebp),%eax
     8d0:	a3 6c 7e 00 00       	mov    %eax,0x7e6c
     8d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
     8d8:	a3 70 7e 00 00       	mov    %eax,0x7e70
 bluedoor = APLoadBitmap ("bluedoor.bmp");
     8dd:	8d 45 d8             	lea    -0x28(%ebp),%eax
     8e0:	83 ec 08             	sub    $0x8,%esp
     8e3:	68 b6 37 00 00       	push   $0x37b6
     8e8:	50                   	push   %eax
     8e9:	e8 34 11 00 00       	call   1a22 <APLoadBitmap>
     8ee:	83 c4 0c             	add    $0xc,%esp
     8f1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     8f4:	a3 00 7e 00 00       	mov    %eax,0x7e00
     8f9:	8b 45 dc             	mov    -0x24(%ebp),%eax
     8fc:	a3 04 7e 00 00       	mov    %eax,0x7e04
     901:	8b 45 e0             	mov    -0x20(%ebp),%eax
     904:	a3 08 7e 00 00       	mov    %eax,0x7e08
 reddoor = APLoadBitmap ("reddoor.bmp");
     909:	8d 45 d8             	lea    -0x28(%ebp),%eax
     90c:	83 ec 08             	sub    $0x8,%esp
     90f:	68 c3 37 00 00       	push   $0x37c3
     914:	50                   	push   %eax
     915:	e8 08 11 00 00       	call   1a22 <APLoadBitmap>
     91a:	83 c4 0c             	add    $0xc,%esp
     91d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     920:	a3 54 7f 00 00       	mov    %eax,0x7f54
     925:	8b 45 dc             	mov    -0x24(%ebp),%eax
     928:	a3 58 7f 00 00       	mov    %eax,0x7f58
     92d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     930:	a3 5c 7f 00 00       	mov    %eax,0x7f5c
 upstair = APLoadBitmap ("upstair.bmp");
     935:	8d 45 d8             	lea    -0x28(%ebp),%eax
     938:	83 ec 08             	sub    $0x8,%esp
     93b:	68 cf 37 00 00       	push   $0x37cf
     940:	50                   	push   %eax
     941:	e8 dc 10 00 00       	call   1a22 <APLoadBitmap>
     946:	83 c4 0c             	add    $0xc,%esp
     949:	8b 45 d8             	mov    -0x28(%ebp),%eax
     94c:	a3 0c 7f 00 00       	mov    %eax,0x7f0c
     951:	8b 45 dc             	mov    -0x24(%ebp),%eax
     954:	a3 10 7f 00 00       	mov    %eax,0x7f10
     959:	8b 45 e0             	mov    -0x20(%ebp),%eax
     95c:	a3 14 7f 00 00       	mov    %eax,0x7f14
 downstair = APLoadBitmap ("downstair.bmp");
     961:	8d 45 d8             	lea    -0x28(%ebp),%eax
     964:	83 ec 08             	sub    $0x8,%esp
     967:	68 db 37 00 00       	push   $0x37db
     96c:	50                   	push   %eax
     96d:	e8 b0 10 00 00       	call   1a22 <APLoadBitmap>
     972:	83 c4 0c             	add    $0xc,%esp
     975:	8b 45 d8             	mov    -0x28(%ebp),%eax
     978:	a3 1c 7f 00 00       	mov    %eax,0x7f1c
     97d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     980:	a3 20 7f 00 00       	mov    %eax,0x7f20
     985:	8b 45 e0             	mov    -0x20(%ebp),%eax
     988:	a3 24 7f 00 00       	mov    %eax,0x7f24
 yellowkey = APLoadBitmap ("yellowkey.bmp");
     98d:	8d 45 d8             	lea    -0x28(%ebp),%eax
     990:	83 ec 08             	sub    $0x8,%esp
     993:	68 e9 37 00 00       	push   $0x37e9
     998:	50                   	push   %eax
     999:	e8 84 10 00 00       	call   1a22 <APLoadBitmap>
     99e:	83 c4 0c             	add    $0xc,%esp
     9a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     9a4:	a3 2c 84 00 00       	mov    %eax,0x842c
     9a9:	8b 45 dc             	mov    -0x24(%ebp),%eax
     9ac:	a3 30 84 00 00       	mov    %eax,0x8430
     9b1:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9b4:	a3 34 84 00 00       	mov    %eax,0x8434
 bluekey = APLoadBitmap ("bluekey.bmp");
     9b9:	8d 45 d8             	lea    -0x28(%ebp),%eax
     9bc:	83 ec 08             	sub    $0x8,%esp
     9bf:	68 f7 37 00 00       	push   $0x37f7
     9c4:	50                   	push   %eax
     9c5:	e8 58 10 00 00       	call   1a22 <APLoadBitmap>
     9ca:	83 c4 0c             	add    $0xc,%esp
     9cd:	8b 45 d8             	mov    -0x28(%ebp),%eax
     9d0:	a3 5c 7e 00 00       	mov    %eax,0x7e5c
     9d5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     9d8:	a3 60 7e 00 00       	mov    %eax,0x7e60
     9dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9e0:	a3 64 7e 00 00       	mov    %eax,0x7e64
 redkey = APLoadBitmap ("redkey.bmp");
     9e5:	8d 45 d8             	lea    -0x28(%ebp),%eax
     9e8:	83 ec 08             	sub    $0x8,%esp
     9eb:	68 03 38 00 00       	push   $0x3803
     9f0:	50                   	push   %eax
     9f1:	e8 2c 10 00 00       	call   1a22 <APLoadBitmap>
     9f6:	83 c4 0c             	add    $0xc,%esp
     9f9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     9fc:	a3 cc 7e 00 00       	mov    %eax,0x7ecc
     a01:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a04:	a3 d0 7e 00 00       	mov    %eax,0x7ed0
     a09:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a0c:	a3 d4 7e 00 00       	mov    %eax,0x7ed4
 sblood = APLoadBitmap ("sblood.bmp");
     a11:	8d 45 d8             	lea    -0x28(%ebp),%eax
     a14:	83 ec 08             	sub    $0x8,%esp
     a17:	68 0e 38 00 00       	push   $0x380e
     a1c:	50                   	push   %eax
     a1d:	e8 00 10 00 00       	call   1a22 <APLoadBitmap>
     a22:	83 c4 0c             	add    $0xc,%esp
     a25:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a28:	a3 3c 84 00 00       	mov    %eax,0x843c
     a2d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a30:	a3 40 84 00 00       	mov    %eax,0x8440
     a35:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a38:	a3 44 84 00 00       	mov    %eax,0x8444
 lblood = APLoadBitmap ("lblood.bmp");
     a3d:	8d 45 d8             	lea    -0x28(%ebp),%eax
     a40:	83 ec 08             	sub    $0x8,%esp
     a43:	68 19 38 00 00       	push   $0x3819
     a48:	50                   	push   %eax
     a49:	e8 d4 0f 00 00       	call   1a22 <APLoadBitmap>
     a4e:	83 c4 0c             	add    $0xc,%esp
     a51:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a54:	a3 28 7f 00 00       	mov    %eax,0x7f28
     a59:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a5c:	a3 2c 7f 00 00       	mov    %eax,0x7f2c
     a61:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a64:	a3 30 7f 00 00       	mov    %eax,0x7f30
 attack = APLoadBitmap ("attack.bmp");
     a69:	8d 45 d8             	lea    -0x28(%ebp),%eax
     a6c:	83 ec 08             	sub    $0x8,%esp
     a6f:	68 24 38 00 00       	push   $0x3824
     a74:	50                   	push   %eax
     a75:	e8 a8 0f 00 00       	call   1a22 <APLoadBitmap>
     a7a:	83 c4 0c             	add    $0xc,%esp
     a7d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a80:	a3 74 7e 00 00       	mov    %eax,0x7e74
     a85:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a88:	a3 78 7e 00 00       	mov    %eax,0x7e78
     a8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a90:	a3 7c 7e 00 00       	mov    %eax,0x7e7c
 defend = APLoadBitmap ("defend.bmp");
     a95:	8d 45 d8             	lea    -0x28(%ebp),%eax
     a98:	83 ec 08             	sub    $0x8,%esp
     a9b:	68 2f 38 00 00       	push   $0x382f
     aa0:	50                   	push   %eax
     aa1:	e8 7c 0f 00 00       	call   1a22 <APLoadBitmap>
     aa6:	83 c4 0c             	add    $0xc,%esp
     aa9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aac:	a3 18 7e 00 00       	mov    %eax,0x7e18
     ab1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ab4:	a3 1c 7e 00 00       	mov    %eax,0x7e1c
     ab9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     abc:	a3 20 7e 00 00       	mov    %eax,0x7e20
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
     ae1:	e8 63 1b 00 00       	call   2649 <APSendMessage>
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
     af6:	a1 50 7f 00 00       	mov    0x7f50,%eax
     afb:	83 ec 04             	sub    $0x4,%esp
     afe:	50                   	push   %eax
     aff:	68 3a 38 00 00       	push   $0x383a
     b04:	6a 01                	push   $0x1
     b06:	e8 91 0a 00 00       	call   159c <printf>
     b0b:	83 c4 10             	add    $0x10,%esp
int mhp,matk,mdef,mid;
switch(my_tower[floor][position.x][position.y])
     b0e:	8b 1d 24 7e 00 00    	mov    0x7e24,%ebx
     b14:	8b 15 54 7e 00 00    	mov    0x7e54,%edx
     b1a:	8b 0d 58 7e 00 00    	mov    0x7e58,%ecx
     b20:	89 d0                	mov    %edx,%eax
     b22:	c1 e0 02             	shl    $0x2,%eax
     b25:	01 d0                	add    %edx,%eax
     b27:	01 c0                	add    %eax,%eax
     b29:	6b d3 64             	imul   $0x64,%ebx,%edx
     b2c:	01 d0                	add    %edx,%eax
     b2e:	01 c8                	add    %ecx,%eax
     b30:	8b 04 85 60 7f 00 00 	mov    0x7f60(,%eax,4),%eax
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
     b75:	05 60 41 00 00       	add    $0x4160,%eax
     b7a:	8b 00                	mov    (%eax),%eax
     b7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
matk = monster_info[mid][1];
     b7f:	8b 55 f0             	mov    -0x10(%ebp),%edx
     b82:	89 d0                	mov    %edx,%eax
     b84:	01 c0                	add    %eax,%eax
     b86:	01 d0                	add    %edx,%eax
     b88:	c1 e0 02             	shl    $0x2,%eax
     b8b:	05 64 41 00 00       	add    $0x4164,%eax
     b90:	8b 00                	mov    (%eax),%eax
     b92:	89 45 ec             	mov    %eax,-0x14(%ebp)
mdef = monster_info[mid][2];//load monster info
     b95:	8b 55 f0             	mov    -0x10(%ebp),%edx
     b98:	89 d0                	mov    %edx,%eax
     b9a:	01 c0                	add    %eax,%eax
     b9c:	01 d0                	add    %edx,%eax
     b9e:	c1 e0 02             	shl    $0x2,%eax
     ba1:	05 68 41 00 00       	add    $0x4168,%eax
     ba6:	8b 00                	mov    (%eax),%eax
     ba8:	89 45 e8             	mov    %eax,-0x18(%ebp)
if (atk <= mdef)
     bab:	a1 0c 7e 00 00       	mov    0x7e0c,%eax
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
     bbc:	a1 0c 7e 00 00       	mov    0x7e0c,%eax
     bc1:	2b 45 e8             	sub    -0x18(%ebp),%eax
     bc4:	29 45 f4             	sub    %eax,-0xc(%ebp)
	if (mhp <= 0)
     bc7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     bcb:	7f 1f                	jg     bec <fight+0xfd>
	{
		
printf(1,"hp after:%d\n",hp);
     bcd:	a1 50 7f 00 00       	mov    0x7f50,%eax
     bd2:	83 ec 04             	sub    $0x4,%esp
     bd5:	50                   	push   %eax
     bd6:	68 48 38 00 00       	push   $0x3848
     bdb:	6a 01                	push   $0x1
     bdd:	e8 ba 09 00 00       	call   159c <printf>
     be2:	83 c4 10             	add    $0x10,%esp
		return true;
     be5:	b8 01 00 00 00       	mov    $0x1,%eax
     bea:	eb 36                	jmp    c22 <fight+0x133>
	}
	if (matk < def)
     bec:	a1 10 7e 00 00       	mov    0x7e10,%eax
     bf1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     bf4:	7c 29                	jl     c1f <fight+0x130>
	{
		continue;
	}
	hp -= (matk - def);
     bf6:	a1 50 7f 00 00       	mov    0x7f50,%eax
     bfb:	8b 15 10 7e 00 00    	mov    0x7e10,%edx
     c01:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     c04:	29 d1                	sub    %edx,%ecx
     c06:	89 ca                	mov    %ecx,%edx
     c08:	29 d0                	sub    %edx,%eax
     c0a:	a3 50 7f 00 00       	mov    %eax,0x7f50
	if (hp <= 0)
     c0f:	a1 50 7f 00 00       	mov    0x7f50,%eax
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
     c73:	a1 e0 7d 00 00       	mov    0x7de0,%eax
     c78:	83 c0 01             	add    $0x1,%eax
     c7b:	a3 e0 7d 00 00       	mov    %eax,0x7de0
     c80:	a1 e0 7d 00 00       	mov    0x7de0,%eax
     c85:	83 ec 04             	sub    $0x4,%esp
     c88:	50                   	push   %eax
     c89:	68 55 38 00 00       	push   $0x3855
     c8e:	6a 01                	push   $0x1
     c90:	e8 07 09 00 00       	call   159c <printf>
     c95:	83 c4 10             	add    $0x10,%esp
ABitmap temp;
switch(my_tower[floor][i][j])
     c98:	8b 0d 24 7e 00 00    	mov    0x7e24,%ecx
     c9e:	8b 55 0c             	mov    0xc(%ebp),%edx
     ca1:	89 d0                	mov    %edx,%eax
     ca3:	c1 e0 02             	shl    $0x2,%eax
     ca6:	01 d0                	add    %edx,%eax
     ca8:	01 c0                	add    %eax,%eax
     caa:	6b d1 64             	imul   $0x64,%ecx,%edx
     cad:	01 c2                	add    %eax,%edx
     caf:	8b 45 10             	mov    0x10(%ebp),%eax
     cb2:	01 d0                	add    %edx,%eax
     cb4:	8b 04 85 60 7f 00 00 	mov    0x7f60(,%eax,4),%eax
     cbb:	83 f8 11             	cmp    $0x11,%eax
     cbe:	0f 87 87 02 00 00    	ja     f4b <drawone+0x2e1>
     cc4:	8b 04 85 64 38 00 00 	mov    0x3864(,%eax,4),%eax
     ccb:	ff e0                	jmp    *%eax
{
case Background:
	temp = background;
     ccd:	a1 34 7e 00 00       	mov    0x7e34,%eax
     cd2:	89 45 d0             	mov    %eax,-0x30(%ebp)
     cd5:	a1 38 7e 00 00       	mov    0x7e38,%eax
     cda:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     cdd:	a1 3c 7e 00 00       	mov    0x7e3c,%eax
     ce2:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("background.bmp");
	break;
     ce5:	e9 7a 02 00 00       	jmp    f64 <drawone+0x2fa>
case Wall:
	temp = wall;
     cea:	a1 38 7f 00 00       	mov    0x7f38,%eax
     cef:	89 45 d0             	mov    %eax,-0x30(%ebp)
     cf2:	a1 3c 7f 00 00       	mov    0x7f3c,%eax
     cf7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     cfa:	a1 40 7f 00 00       	mov    0x7f40,%eax
     cff:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("wall.bmp");
	break;
     d02:	e9 5d 02 00 00       	jmp    f64 <drawone+0x2fa>
case Monster1:
	temp = monster1;
     d07:	a1 44 7f 00 00       	mov    0x7f44,%eax
     d0c:	89 45 d0             	mov    %eax,-0x30(%ebp)
     d0f:	a1 48 7f 00 00       	mov    0x7f48,%eax
     d14:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     d17:	a1 4c 7f 00 00       	mov    0x7f4c,%eax
     d1c:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("monster1.bmp");
	break;
     d1f:	e9 40 02 00 00       	jmp    f64 <drawone+0x2fa>
case Monster2:
	temp = monster2;	
     d24:	a1 a0 7e 00 00       	mov    0x7ea0,%eax
     d29:	89 45 d0             	mov    %eax,-0x30(%ebp)
     d2c:	a1 a4 7e 00 00       	mov    0x7ea4,%eax
     d31:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     d34:	a1 a8 7e 00 00       	mov    0x7ea8,%eax
     d39:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("monster2.bmp");
	break;
     d3c:	e9 23 02 00 00       	jmp    f64 <drawone+0x2fa>
case Monster3:
	temp = monster3;
     d41:	a1 d8 7e 00 00       	mov    0x7ed8,%eax
     d46:	89 45 d0             	mov    %eax,-0x30(%ebp)
     d49:	a1 dc 7e 00 00       	mov    0x7edc,%eax
     d4e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     d51:	a1 e0 7e 00 00       	mov    0x7ee0,%eax
     d56:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("monster3.bmp");
	break;
     d59:	e9 06 02 00 00       	jmp    f64 <drawone+0x2fa>
case Valiant:
	
	//temp = APLoadBitmap ("background.bmp");
temp = background;
     d5e:	a1 34 7e 00 00       	mov    0x7e34,%eax
     d63:	89 45 d0             	mov    %eax,-0x30(%ebp)
     d66:	a1 38 7e 00 00       	mov    0x7e38,%eax
     d6b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     d6e:	a1 3c 7e 00 00       	mov    0x7e3c,%eax
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
     d94:	e8 c3 0e 00 00       	call   1c5c <APCreateCompatibleDCFromBitmap>
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
     dd6:	e8 85 16 00 00       	call   2460 <APDcCopy>
     ddb:	83 c4 30             	add    $0x30,%esp
	//temp = APLoadBitmap ("valiant.bmp");
temp = valiant;
     dde:	a1 20 84 00 00       	mov    0x8420,%eax
     de3:	89 45 d0             	mov    %eax,-0x30(%ebp)
     de6:	a1 24 84 00 00       	mov    0x8424,%eax
     deb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     dee:	a1 28 84 00 00       	mov    0x8428,%eax
     df3:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     df6:	e9 69 01 00 00       	jmp    f64 <drawone+0x2fa>
case YellowDoor:
	temp = yellowdoor;
     dfb:	a1 68 7e 00 00       	mov    0x7e68,%eax
     e00:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e03:	a1 6c 7e 00 00       	mov    0x7e6c,%eax
     e08:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e0b:	a1 70 7e 00 00       	mov    0x7e70,%eax
     e10:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("yellowdoor.bmp");
	break;
     e13:	e9 4c 01 00 00       	jmp    f64 <drawone+0x2fa>
case BlueDoor:
	temp = bluedoor;
     e18:	a1 00 7e 00 00       	mov    0x7e00,%eax
     e1d:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e20:	a1 04 7e 00 00       	mov    0x7e04,%eax
     e25:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e28:	a1 08 7e 00 00       	mov    0x7e08,%eax
     e2d:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("bluedoor.bmp");
	break;
     e30:	e9 2f 01 00 00       	jmp    f64 <drawone+0x2fa>
case RedDoor:
	temp = reddoor;
     e35:	a1 54 7f 00 00       	mov    0x7f54,%eax
     e3a:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e3d:	a1 58 7f 00 00       	mov    0x7f58,%eax
     e42:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e45:	a1 5c 7f 00 00       	mov    0x7f5c,%eax
     e4a:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("reddoor.bmp");
	break;
     e4d:	e9 12 01 00 00       	jmp    f64 <drawone+0x2fa>
case UpStair:
	temp = upstair;
     e52:	a1 0c 7f 00 00       	mov    0x7f0c,%eax
     e57:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e5a:	a1 10 7f 00 00       	mov    0x7f10,%eax
     e5f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e62:	a1 14 7f 00 00       	mov    0x7f14,%eax
     e67:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("upstair.bmp");
	break;
     e6a:	e9 f5 00 00 00       	jmp    f64 <drawone+0x2fa>
case DownStair:
	temp = downstair;
     e6f:	a1 1c 7f 00 00       	mov    0x7f1c,%eax
     e74:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e77:	a1 20 7f 00 00       	mov    0x7f20,%eax
     e7c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e7f:	a1 24 7f 00 00       	mov    0x7f24,%eax
     e84:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("downstair.bmp");
	break;
     e87:	e9 d8 00 00 00       	jmp    f64 <drawone+0x2fa>
case YellowKey:
	temp = yellowkey;
     e8c:	a1 2c 84 00 00       	mov    0x842c,%eax
     e91:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e94:	a1 30 84 00 00       	mov    0x8430,%eax
     e99:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e9c:	a1 34 84 00 00       	mov    0x8434,%eax
     ea1:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("yellowkey.bmp");
	break;
     ea4:	e9 bb 00 00 00       	jmp    f64 <drawone+0x2fa>
case BlueKey:
	temp = bluekey;
     ea9:	a1 5c 7e 00 00       	mov    0x7e5c,%eax
     eae:	89 45 d0             	mov    %eax,-0x30(%ebp)
     eb1:	a1 60 7e 00 00       	mov    0x7e60,%eax
     eb6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     eb9:	a1 64 7e 00 00       	mov    0x7e64,%eax
     ebe:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("bluekey.bmp");
	break;
     ec1:	e9 9e 00 00 00       	jmp    f64 <drawone+0x2fa>
case RedKey:
	temp = redkey;
     ec6:	a1 cc 7e 00 00       	mov    0x7ecc,%eax
     ecb:	89 45 d0             	mov    %eax,-0x30(%ebp)
     ece:	a1 d0 7e 00 00       	mov    0x7ed0,%eax
     ed3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     ed6:	a1 d4 7e 00 00       	mov    0x7ed4,%eax
     edb:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("redkey.bmp");
	break;
     ede:	e9 81 00 00 00       	jmp    f64 <drawone+0x2fa>
case SBlood:
	temp = sblood;
     ee3:	a1 3c 84 00 00       	mov    0x843c,%eax
     ee8:	89 45 d0             	mov    %eax,-0x30(%ebp)
     eeb:	a1 40 84 00 00       	mov    0x8440,%eax
     ef0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     ef3:	a1 44 84 00 00       	mov    0x8444,%eax
     ef8:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("sblood.bmp");
	break;
     efb:	eb 67                	jmp    f64 <drawone+0x2fa>
case LBlood:
	temp = lblood;
     efd:	a1 28 7f 00 00       	mov    0x7f28,%eax
     f02:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f05:	a1 2c 7f 00 00       	mov    0x7f2c,%eax
     f0a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f0d:	a1 30 7f 00 00       	mov    0x7f30,%eax
     f12:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("lblood.bmp");
	break;
     f15:	eb 4d                	jmp    f64 <drawone+0x2fa>
case Attack:
	temp = attack;
     f17:	a1 74 7e 00 00       	mov    0x7e74,%eax
     f1c:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f1f:	a1 78 7e 00 00       	mov    0x7e78,%eax
     f24:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f27:	a1 7c 7e 00 00       	mov    0x7e7c,%eax
     f2c:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("attack1.bmp");
	break;
     f2f:	eb 33                	jmp    f64 <drawone+0x2fa>
case Defend:
	temp = defend;
     f31:	a1 18 7e 00 00       	mov    0x7e18,%eax
     f36:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f39:	a1 1c 7e 00 00       	mov    0x7e1c,%eax
     f3e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f41:	a1 20 7e 00 00       	mov    0x7e20,%eax
     f46:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("defend.bmp");
	break;
     f49:	eb 19                	jmp    f64 <drawone+0x2fa>
default:
	temp = background;
     f4b:	a1 34 7e 00 00       	mov    0x7e34,%eax
     f50:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f53:	a1 38 7e 00 00       	mov    0x7e38,%eax
     f58:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f5b:	a1 3c 7e 00 00       	mov    0x7e3c,%eax
     f60:	89 45 d8             	mov    %eax,-0x28(%ebp)
	//temp = APLoadBitmap ("background.bmp");
break;
     f63:	90                   	nop
}
		if(my_tower[floor][i][j] == Valiant)
     f64:	8b 0d 24 7e 00 00    	mov    0x7e24,%ecx
     f6a:	8b 55 0c             	mov    0xc(%ebp),%edx
     f6d:	89 d0                	mov    %edx,%eax
     f6f:	c1 e0 02             	shl    $0x2,%eax
     f72:	01 d0                	add    %edx,%eax
     f74:	01 c0                	add    %eax,%eax
     f76:	6b d1 64             	imul   $0x64,%ecx,%edx
     f79:	01 c2                	add    %eax,%edx
     f7b:	8b 45 10             	mov    0x10(%ebp),%eax
     f7e:	01 d0                	add    %edx,%eax
     f80:	8b 04 85 60 7f 00 00 	mov    0x7f60(,%eax,4),%eax
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
     faa:	e8 ad 0c 00 00       	call   1c5c <APCreateCompatibleDCFromBitmap>
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
     fec:	e8 6f 14 00 00       	call   2460 <APDcCopy>
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
    1014:	e8 43 0c 00 00       	call   1c5c <APCreateCompatibleDCFromBitmap>
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
    1056:	e8 05 14 00 00       	call   2460 <APDcCopy>
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
    106a:	83 ec 08             	sub    $0x8,%esp
	switch(msg.type)
    106d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1070:	83 f8 03             	cmp    $0x3,%eax
    1073:	74 55                	je     10ca <wndProc+0x63>
    1075:	83 f8 06             	cmp    $0x6,%eax
    1078:	74 34                	je     10ae <wndProc+0x47>
    107a:	83 f8 02             	cmp    $0x2,%eax
    107d:	74 05                	je     1084 <wndProc+0x1d>
drawone(hwnd,position.x,position.y);
drawone(hwnd,position_old.x,position_old.y);
}
		break;
		default:
		break;
    107f:	e9 94 00 00 00       	jmp    1118 <wndProc+0xb1>
{
	switch(msg.type)
	{
		    case MSG_INIT:
			
		    init(hwnd);
    1084:	83 ec 0c             	sub    $0xc,%esp
    1087:	ff 75 08             	pushl  0x8(%ebp)
    108a:	e8 87 f6 ff ff       	call   716 <init>
    108f:	83 c4 10             	add    $0x10,%esp
			printf(1,"init finished");
    1092:	83 ec 08             	sub    $0x8,%esp
    1095:	68 ac 38 00 00       	push   $0x38ac
    109a:	6a 01                	push   $0x1
    109c:	e8 fb 04 00 00       	call   159c <printf>
    10a1:	83 c4 10             	add    $0x10,%esp
		
		    return False;
    10a4:	b8 00 00 00 00       	mov    $0x0,%eax
    10a9:	e9 84 00 00 00       	jmp    1132 <wndProc+0xcb>
		case MSG_KEY_DOWN:
		keyDown(hwnd,msg);
    10ae:	83 ec 0c             	sub    $0xc,%esp
    10b1:	ff 75 18             	pushl  0x18(%ebp)
    10b4:	ff 75 14             	pushl  0x14(%ebp)
    10b7:	ff 75 10             	pushl  0x10(%ebp)
    10ba:	ff 75 0c             	pushl  0xc(%ebp)
    10bd:	ff 75 08             	pushl  0x8(%ebp)
    10c0:	e8 0b f0 ff ff       	call   d0 <keyDown>
    10c5:	83 c4 20             	add    $0x20,%esp
		break;
    10c8:	eb 4e                	jmp    1118 <wndProc+0xb1>
		case MSG_PAINT:
	    	//msg.type = MSG_WORD;
            	//sprintf(msg.word,"Floor:%d,Hp:%d,ATK:%d,DEF:%d,Yellow:%d,Blue:%d,Red:%d",floor+1,hp,atk,def,my_key[0],my_key[1],my_key[2]);
           	 //APSendMessage(hwnd,msg);
if (msg.param == 0)
    10ca:	8b 45 10             	mov    0x10(%ebp),%eax
    10cd:	85 c0                	test   %eax,%eax
    10cf:	75 10                	jne    10e1 <wndProc+0x7a>
		draw(hwnd);
    10d1:	83 ec 0c             	sub    $0xc,%esp
    10d4:	ff 75 08             	pushl  0x8(%ebp)
    10d7:	e8 4b fb ff ff       	call   c27 <draw>
    10dc:	83 c4 10             	add    $0x10,%esp
else
{
drawone(hwnd,position.x,position.y);
drawone(hwnd,position_old.x,position_old.y);
}
		break;
    10df:	eb 36                	jmp    1117 <wndProc+0xb0>
           	 //APSendMessage(hwnd,msg);
if (msg.param == 0)
		draw(hwnd);
else
{
drawone(hwnd,position.x,position.y);
    10e1:	8b 15 58 7e 00 00    	mov    0x7e58,%edx
    10e7:	a1 54 7e 00 00       	mov    0x7e54,%eax
    10ec:	83 ec 04             	sub    $0x4,%esp
    10ef:	52                   	push   %edx
    10f0:	50                   	push   %eax
    10f1:	ff 75 08             	pushl  0x8(%ebp)
    10f4:	e8 71 fb ff ff       	call   c6a <drawone>
    10f9:	83 c4 10             	add    $0x10,%esp
drawone(hwnd,position_old.x,position_old.y);
    10fc:	8b 15 44 7e 00 00    	mov    0x7e44,%edx
    1102:	a1 40 7e 00 00       	mov    0x7e40,%eax
    1107:	83 ec 04             	sub    $0x4,%esp
    110a:	52                   	push   %edx
    110b:	50                   	push   %eax
    110c:	ff 75 08             	pushl  0x8(%ebp)
    110f:	e8 56 fb ff ff       	call   c6a <drawone>
    1114:	83 c4 10             	add    $0x10,%esp
}
		break;
    1117:	90                   	nop
		default:
		break;
	}
	return APWndProc(hwnd,msg);
    1118:	83 ec 0c             	sub    $0xc,%esp
    111b:	ff 75 18             	pushl  0x18(%ebp)
    111e:	ff 75 14             	pushl  0x14(%ebp)
    1121:	ff 75 10             	pushl  0x10(%ebp)
    1124:	ff 75 0c             	pushl  0xc(%ebp)
    1127:	ff 75 08             	pushl  0x8(%ebp)
    112a:	e8 9e 17 00 00       	call   28cd <APWndProc>
    112f:	83 c4 20             	add    $0x20,%esp

}
    1132:	c9                   	leave  
    1133:	c3                   	ret    

00001134 <main>:


int main(void)
{
    1134:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1138:	83 e4 f0             	and    $0xfffffff0,%esp
    113b:	ff 71 fc             	pushl  -0x4(%ecx)
    113e:	55                   	push   %ebp
    113f:	89 e5                	mov    %esp,%ebp
    1141:	51                   	push   %ecx
    1142:	83 ec 14             	sub    $0x14,%esp
	
	AHwnd hwnd = APCreateWindow("magictower",False,0);
    1145:	83 ec 04             	sub    $0x4,%esp
    1148:	6a 00                	push   $0x0
    114a:	6a 00                	push   $0x0
    114c:	68 ba 38 00 00       	push   $0x38ba
    1151:	e8 11 15 00 00       	call   2667 <APCreateWindow>
    1156:	83 c4 10             	add    $0x10,%esp
    1159:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf(1,"magic tower created.\n");
    115c:	83 ec 08             	sub    $0x8,%esp
    115f:	68 c5 38 00 00       	push   $0x38c5
    1164:	6a 01                	push   $0x1
    1166:	e8 31 04 00 00       	call   159c <printf>
    116b:	83 c4 10             	add    $0x10,%esp
	APWndExec(hwnd,wndProc);
    116e:	83 ec 08             	sub    $0x8,%esp
    1171:	68 67 10 00 00       	push   $0x1067
    1176:	ff 75 f4             	pushl  -0xc(%ebp)
    1179:	e8 66 18 00 00       	call   29e4 <APWndExec>
    117e:	83 c4 10             	add    $0x10,%esp
	exit();
    1181:	e8 57 02 00 00       	call   13dd <exit>

00001186 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1186:	55                   	push   %ebp
    1187:	89 e5                	mov    %esp,%ebp
    1189:	57                   	push   %edi
    118a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    118b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    118e:	8b 55 10             	mov    0x10(%ebp),%edx
    1191:	8b 45 0c             	mov    0xc(%ebp),%eax
    1194:	89 cb                	mov    %ecx,%ebx
    1196:	89 df                	mov    %ebx,%edi
    1198:	89 d1                	mov    %edx,%ecx
    119a:	fc                   	cld    
    119b:	f3 aa                	rep stos %al,%es:(%edi)
    119d:	89 ca                	mov    %ecx,%edx
    119f:	89 fb                	mov    %edi,%ebx
    11a1:	89 5d 08             	mov    %ebx,0x8(%ebp)
    11a4:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    11a7:	90                   	nop
    11a8:	5b                   	pop    %ebx
    11a9:	5f                   	pop    %edi
    11aa:	5d                   	pop    %ebp
    11ab:	c3                   	ret    

000011ac <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    11ac:	55                   	push   %ebp
    11ad:	89 e5                	mov    %esp,%ebp
    11af:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    11b2:	8b 45 08             	mov    0x8(%ebp),%eax
    11b5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    11b8:	90                   	nop
    11b9:	8b 45 08             	mov    0x8(%ebp),%eax
    11bc:	8d 50 01             	lea    0x1(%eax),%edx
    11bf:	89 55 08             	mov    %edx,0x8(%ebp)
    11c2:	8b 55 0c             	mov    0xc(%ebp),%edx
    11c5:	8d 4a 01             	lea    0x1(%edx),%ecx
    11c8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    11cb:	0f b6 12             	movzbl (%edx),%edx
    11ce:	88 10                	mov    %dl,(%eax)
    11d0:	0f b6 00             	movzbl (%eax),%eax
    11d3:	84 c0                	test   %al,%al
    11d5:	75 e2                	jne    11b9 <strcpy+0xd>
    ;
  return os;
    11d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    11da:	c9                   	leave  
    11db:	c3                   	ret    

000011dc <strcmp>:

int
strcmp(const char *p, const char *q)
{
    11dc:	55                   	push   %ebp
    11dd:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    11df:	eb 08                	jmp    11e9 <strcmp+0xd>
    p++, q++;
    11e1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    11e5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11e9:	8b 45 08             	mov    0x8(%ebp),%eax
    11ec:	0f b6 00             	movzbl (%eax),%eax
    11ef:	84 c0                	test   %al,%al
    11f1:	74 10                	je     1203 <strcmp+0x27>
    11f3:	8b 45 08             	mov    0x8(%ebp),%eax
    11f6:	0f b6 10             	movzbl (%eax),%edx
    11f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    11fc:	0f b6 00             	movzbl (%eax),%eax
    11ff:	38 c2                	cmp    %al,%dl
    1201:	74 de                	je     11e1 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1203:	8b 45 08             	mov    0x8(%ebp),%eax
    1206:	0f b6 00             	movzbl (%eax),%eax
    1209:	0f b6 d0             	movzbl %al,%edx
    120c:	8b 45 0c             	mov    0xc(%ebp),%eax
    120f:	0f b6 00             	movzbl (%eax),%eax
    1212:	0f b6 c0             	movzbl %al,%eax
    1215:	29 c2                	sub    %eax,%edx
    1217:	89 d0                	mov    %edx,%eax
}
    1219:	5d                   	pop    %ebp
    121a:	c3                   	ret    

0000121b <strlen>:

uint
strlen(char *s)
{
    121b:	55                   	push   %ebp
    121c:	89 e5                	mov    %esp,%ebp
    121e:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1221:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1228:	eb 04                	jmp    122e <strlen+0x13>
    122a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    122e:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1231:	8b 45 08             	mov    0x8(%ebp),%eax
    1234:	01 d0                	add    %edx,%eax
    1236:	0f b6 00             	movzbl (%eax),%eax
    1239:	84 c0                	test   %al,%al
    123b:	75 ed                	jne    122a <strlen+0xf>
    ;
  return n;
    123d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1240:	c9                   	leave  
    1241:	c3                   	ret    

00001242 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1242:	55                   	push   %ebp
    1243:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1245:	8b 45 10             	mov    0x10(%ebp),%eax
    1248:	50                   	push   %eax
    1249:	ff 75 0c             	pushl  0xc(%ebp)
    124c:	ff 75 08             	pushl  0x8(%ebp)
    124f:	e8 32 ff ff ff       	call   1186 <stosb>
    1254:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1257:	8b 45 08             	mov    0x8(%ebp),%eax
}
    125a:	c9                   	leave  
    125b:	c3                   	ret    

0000125c <strchr>:

char*
strchr(const char *s, char c)
{
    125c:	55                   	push   %ebp
    125d:	89 e5                	mov    %esp,%ebp
    125f:	83 ec 04             	sub    $0x4,%esp
    1262:	8b 45 0c             	mov    0xc(%ebp),%eax
    1265:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1268:	eb 14                	jmp    127e <strchr+0x22>
    if(*s == c)
    126a:	8b 45 08             	mov    0x8(%ebp),%eax
    126d:	0f b6 00             	movzbl (%eax),%eax
    1270:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1273:	75 05                	jne    127a <strchr+0x1e>
      return (char*)s;
    1275:	8b 45 08             	mov    0x8(%ebp),%eax
    1278:	eb 13                	jmp    128d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    127a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    127e:	8b 45 08             	mov    0x8(%ebp),%eax
    1281:	0f b6 00             	movzbl (%eax),%eax
    1284:	84 c0                	test   %al,%al
    1286:	75 e2                	jne    126a <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1288:	b8 00 00 00 00       	mov    $0x0,%eax
}
    128d:	c9                   	leave  
    128e:	c3                   	ret    

0000128f <gets>:

char*
gets(char *buf, int max)
{
    128f:	55                   	push   %ebp
    1290:	89 e5                	mov    %esp,%ebp
    1292:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1295:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    129c:	eb 42                	jmp    12e0 <gets+0x51>
    cc = read(0, &c, 1);
    129e:	83 ec 04             	sub    $0x4,%esp
    12a1:	6a 01                	push   $0x1
    12a3:	8d 45 ef             	lea    -0x11(%ebp),%eax
    12a6:	50                   	push   %eax
    12a7:	6a 00                	push   $0x0
    12a9:	e8 47 01 00 00       	call   13f5 <read>
    12ae:	83 c4 10             	add    $0x10,%esp
    12b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    12b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    12b8:	7e 33                	jle    12ed <gets+0x5e>
      break;
    buf[i++] = c;
    12ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12bd:	8d 50 01             	lea    0x1(%eax),%edx
    12c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
    12c3:	89 c2                	mov    %eax,%edx
    12c5:	8b 45 08             	mov    0x8(%ebp),%eax
    12c8:	01 c2                	add    %eax,%edx
    12ca:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    12ce:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    12d0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    12d4:	3c 0a                	cmp    $0xa,%al
    12d6:	74 16                	je     12ee <gets+0x5f>
    12d8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    12dc:	3c 0d                	cmp    $0xd,%al
    12de:	74 0e                	je     12ee <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12e3:	83 c0 01             	add    $0x1,%eax
    12e6:	3b 45 0c             	cmp    0xc(%ebp),%eax
    12e9:	7c b3                	jl     129e <gets+0xf>
    12eb:	eb 01                	jmp    12ee <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    12ed:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    12ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12f1:	8b 45 08             	mov    0x8(%ebp),%eax
    12f4:	01 d0                	add    %edx,%eax
    12f6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    12f9:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12fc:	c9                   	leave  
    12fd:	c3                   	ret    

000012fe <stat>:

int
stat(char *n, struct stat *st)
{
    12fe:	55                   	push   %ebp
    12ff:	89 e5                	mov    %esp,%ebp
    1301:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1304:	83 ec 08             	sub    $0x8,%esp
    1307:	6a 00                	push   $0x0
    1309:	ff 75 08             	pushl  0x8(%ebp)
    130c:	e8 0c 01 00 00       	call   141d <open>
    1311:	83 c4 10             	add    $0x10,%esp
    1314:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1317:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    131b:	79 07                	jns    1324 <stat+0x26>
    return -1;
    131d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1322:	eb 25                	jmp    1349 <stat+0x4b>
  r = fstat(fd, st);
    1324:	83 ec 08             	sub    $0x8,%esp
    1327:	ff 75 0c             	pushl  0xc(%ebp)
    132a:	ff 75 f4             	pushl  -0xc(%ebp)
    132d:	e8 03 01 00 00       	call   1435 <fstat>
    1332:	83 c4 10             	add    $0x10,%esp
    1335:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1338:	83 ec 0c             	sub    $0xc,%esp
    133b:	ff 75 f4             	pushl  -0xc(%ebp)
    133e:	e8 c2 00 00 00       	call   1405 <close>
    1343:	83 c4 10             	add    $0x10,%esp
  return r;
    1346:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1349:	c9                   	leave  
    134a:	c3                   	ret    

0000134b <atoi>:

int
atoi(const char *s)
{
    134b:	55                   	push   %ebp
    134c:	89 e5                	mov    %esp,%ebp
    134e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1351:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1358:	eb 25                	jmp    137f <atoi+0x34>
    n = n*10 + *s++ - '0';
    135a:	8b 55 fc             	mov    -0x4(%ebp),%edx
    135d:	89 d0                	mov    %edx,%eax
    135f:	c1 e0 02             	shl    $0x2,%eax
    1362:	01 d0                	add    %edx,%eax
    1364:	01 c0                	add    %eax,%eax
    1366:	89 c1                	mov    %eax,%ecx
    1368:	8b 45 08             	mov    0x8(%ebp),%eax
    136b:	8d 50 01             	lea    0x1(%eax),%edx
    136e:	89 55 08             	mov    %edx,0x8(%ebp)
    1371:	0f b6 00             	movzbl (%eax),%eax
    1374:	0f be c0             	movsbl %al,%eax
    1377:	01 c8                	add    %ecx,%eax
    1379:	83 e8 30             	sub    $0x30,%eax
    137c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    137f:	8b 45 08             	mov    0x8(%ebp),%eax
    1382:	0f b6 00             	movzbl (%eax),%eax
    1385:	3c 2f                	cmp    $0x2f,%al
    1387:	7e 0a                	jle    1393 <atoi+0x48>
    1389:	8b 45 08             	mov    0x8(%ebp),%eax
    138c:	0f b6 00             	movzbl (%eax),%eax
    138f:	3c 39                	cmp    $0x39,%al
    1391:	7e c7                	jle    135a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1393:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1396:	c9                   	leave  
    1397:	c3                   	ret    

00001398 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1398:	55                   	push   %ebp
    1399:	89 e5                	mov    %esp,%ebp
    139b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    139e:	8b 45 08             	mov    0x8(%ebp),%eax
    13a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    13a4:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    13aa:	eb 17                	jmp    13c3 <memmove+0x2b>
    *dst++ = *src++;
    13ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13af:	8d 50 01             	lea    0x1(%eax),%edx
    13b2:	89 55 fc             	mov    %edx,-0x4(%ebp)
    13b5:	8b 55 f8             	mov    -0x8(%ebp),%edx
    13b8:	8d 4a 01             	lea    0x1(%edx),%ecx
    13bb:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    13be:	0f b6 12             	movzbl (%edx),%edx
    13c1:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    13c3:	8b 45 10             	mov    0x10(%ebp),%eax
    13c6:	8d 50 ff             	lea    -0x1(%eax),%edx
    13c9:	89 55 10             	mov    %edx,0x10(%ebp)
    13cc:	85 c0                	test   %eax,%eax
    13ce:	7f dc                	jg     13ac <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    13d0:	8b 45 08             	mov    0x8(%ebp),%eax
}
    13d3:	c9                   	leave  
    13d4:	c3                   	ret    

000013d5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13d5:	b8 01 00 00 00       	mov    $0x1,%eax
    13da:	cd 40                	int    $0x40
    13dc:	c3                   	ret    

000013dd <exit>:
SYSCALL(exit)
    13dd:	b8 02 00 00 00       	mov    $0x2,%eax
    13e2:	cd 40                	int    $0x40
    13e4:	c3                   	ret    

000013e5 <wait>:
SYSCALL(wait)
    13e5:	b8 03 00 00 00       	mov    $0x3,%eax
    13ea:	cd 40                	int    $0x40
    13ec:	c3                   	ret    

000013ed <pipe>:
SYSCALL(pipe)
    13ed:	b8 04 00 00 00       	mov    $0x4,%eax
    13f2:	cd 40                	int    $0x40
    13f4:	c3                   	ret    

000013f5 <read>:
SYSCALL(read)
    13f5:	b8 05 00 00 00       	mov    $0x5,%eax
    13fa:	cd 40                	int    $0x40
    13fc:	c3                   	ret    

000013fd <write>:
SYSCALL(write)
    13fd:	b8 10 00 00 00       	mov    $0x10,%eax
    1402:	cd 40                	int    $0x40
    1404:	c3                   	ret    

00001405 <close>:
SYSCALL(close)
    1405:	b8 15 00 00 00       	mov    $0x15,%eax
    140a:	cd 40                	int    $0x40
    140c:	c3                   	ret    

0000140d <kill>:
SYSCALL(kill)
    140d:	b8 06 00 00 00       	mov    $0x6,%eax
    1412:	cd 40                	int    $0x40
    1414:	c3                   	ret    

00001415 <exec>:
SYSCALL(exec)
    1415:	b8 07 00 00 00       	mov    $0x7,%eax
    141a:	cd 40                	int    $0x40
    141c:	c3                   	ret    

0000141d <open>:
SYSCALL(open)
    141d:	b8 0f 00 00 00       	mov    $0xf,%eax
    1422:	cd 40                	int    $0x40
    1424:	c3                   	ret    

00001425 <mknod>:
SYSCALL(mknod)
    1425:	b8 11 00 00 00       	mov    $0x11,%eax
    142a:	cd 40                	int    $0x40
    142c:	c3                   	ret    

0000142d <unlink>:
SYSCALL(unlink)
    142d:	b8 12 00 00 00       	mov    $0x12,%eax
    1432:	cd 40                	int    $0x40
    1434:	c3                   	ret    

00001435 <fstat>:
SYSCALL(fstat)
    1435:	b8 08 00 00 00       	mov    $0x8,%eax
    143a:	cd 40                	int    $0x40
    143c:	c3                   	ret    

0000143d <link>:
SYSCALL(link)
    143d:	b8 13 00 00 00       	mov    $0x13,%eax
    1442:	cd 40                	int    $0x40
    1444:	c3                   	ret    

00001445 <mkdir>:
SYSCALL(mkdir)
    1445:	b8 14 00 00 00       	mov    $0x14,%eax
    144a:	cd 40                	int    $0x40
    144c:	c3                   	ret    

0000144d <chdir>:
SYSCALL(chdir)
    144d:	b8 09 00 00 00       	mov    $0x9,%eax
    1452:	cd 40                	int    $0x40
    1454:	c3                   	ret    

00001455 <dup>:
SYSCALL(dup)
    1455:	b8 0a 00 00 00       	mov    $0xa,%eax
    145a:	cd 40                	int    $0x40
    145c:	c3                   	ret    

0000145d <getpid>:
SYSCALL(getpid)
    145d:	b8 0b 00 00 00       	mov    $0xb,%eax
    1462:	cd 40                	int    $0x40
    1464:	c3                   	ret    

00001465 <sbrk>:
SYSCALL(sbrk)
    1465:	b8 0c 00 00 00       	mov    $0xc,%eax
    146a:	cd 40                	int    $0x40
    146c:	c3                   	ret    

0000146d <sleep>:
SYSCALL(sleep)
    146d:	b8 0d 00 00 00       	mov    $0xd,%eax
    1472:	cd 40                	int    $0x40
    1474:	c3                   	ret    

00001475 <uptime>:
SYSCALL(uptime)
    1475:	b8 0e 00 00 00       	mov    $0xe,%eax
    147a:	cd 40                	int    $0x40
    147c:	c3                   	ret    

0000147d <paintWindow>:

SYSCALL(paintWindow)
    147d:	b8 16 00 00 00       	mov    $0x16,%eax
    1482:	cd 40                	int    $0x40
    1484:	c3                   	ret    

00001485 <sendMessage>:
SYSCALL(sendMessage)
    1485:	b8 17 00 00 00       	mov    $0x17,%eax
    148a:	cd 40                	int    $0x40
    148c:	c3                   	ret    

0000148d <getMessage>:
SYSCALL(getMessage)
    148d:	b8 19 00 00 00       	mov    $0x19,%eax
    1492:	cd 40                	int    $0x40
    1494:	c3                   	ret    

00001495 <registWindow>:
SYSCALL(registWindow)
    1495:	b8 18 00 00 00       	mov    $0x18,%eax
    149a:	cd 40                	int    $0x40
    149c:	c3                   	ret    

0000149d <changePosition>:
SYSCALL(changePosition)
    149d:	b8 1a 00 00 00       	mov    $0x1a,%eax
    14a2:	cd 40                	int    $0x40
    14a4:	c3                   	ret    

000014a5 <setupTimer>:
SYSCALL(setupTimer)
    14a5:	b8 1b 00 00 00       	mov    $0x1b,%eax
    14aa:	cd 40                	int    $0x40
    14ac:	c3                   	ret    

000014ad <deleteTimer>:
SYSCALL(deleteTimer)
    14ad:	b8 1c 00 00 00       	mov    $0x1c,%eax
    14b2:	cd 40                	int    $0x40
    14b4:	c3                   	ret    

000014b5 <getCurrentTime>:
SYSCALL(getCurrentTime)
    14b5:	b8 1d 00 00 00       	mov    $0x1d,%eax
    14ba:	cd 40                	int    $0x40
    14bc:	c3                   	ret    

000014bd <removeWindow>:
SYSCALL(removeWindow)
    14bd:	b8 1e 00 00 00       	mov    $0x1e,%eax
    14c2:	cd 40                	int    $0x40
    14c4:	c3                   	ret    

000014c5 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    14c5:	55                   	push   %ebp
    14c6:	89 e5                	mov    %esp,%ebp
    14c8:	83 ec 18             	sub    $0x18,%esp
    14cb:	8b 45 0c             	mov    0xc(%ebp),%eax
    14ce:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    14d1:	83 ec 04             	sub    $0x4,%esp
    14d4:	6a 01                	push   $0x1
    14d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
    14d9:	50                   	push   %eax
    14da:	ff 75 08             	pushl  0x8(%ebp)
    14dd:	e8 1b ff ff ff       	call   13fd <write>
    14e2:	83 c4 10             	add    $0x10,%esp
}
    14e5:	90                   	nop
    14e6:	c9                   	leave  
    14e7:	c3                   	ret    

000014e8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    14e8:	55                   	push   %ebp
    14e9:	89 e5                	mov    %esp,%ebp
    14eb:	53                   	push   %ebx
    14ec:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    14ef:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    14f6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    14fa:	74 17                	je     1513 <printint+0x2b>
    14fc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1500:	79 11                	jns    1513 <printint+0x2b>
    neg = 1;
    1502:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1509:	8b 45 0c             	mov    0xc(%ebp),%eax
    150c:	f7 d8                	neg    %eax
    150e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1511:	eb 06                	jmp    1519 <printint+0x31>
  } else {
    x = xx;
    1513:	8b 45 0c             	mov    0xc(%ebp),%eax
    1516:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1519:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1520:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1523:	8d 41 01             	lea    0x1(%ecx),%eax
    1526:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1529:	8b 5d 10             	mov    0x10(%ebp),%ebx
    152c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    152f:	ba 00 00 00 00       	mov    $0x0,%edx
    1534:	f7 f3                	div    %ebx
    1536:	89 d0                	mov    %edx,%eax
    1538:	0f b6 80 84 41 00 00 	movzbl 0x4184(%eax),%eax
    153f:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1543:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1546:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1549:	ba 00 00 00 00       	mov    $0x0,%edx
    154e:	f7 f3                	div    %ebx
    1550:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1553:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1557:	75 c7                	jne    1520 <printint+0x38>
  if(neg)
    1559:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    155d:	74 2d                	je     158c <printint+0xa4>
    buf[i++] = '-';
    155f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1562:	8d 50 01             	lea    0x1(%eax),%edx
    1565:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1568:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    156d:	eb 1d                	jmp    158c <printint+0xa4>
    putc(fd, buf[i]);
    156f:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1572:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1575:	01 d0                	add    %edx,%eax
    1577:	0f b6 00             	movzbl (%eax),%eax
    157a:	0f be c0             	movsbl %al,%eax
    157d:	83 ec 08             	sub    $0x8,%esp
    1580:	50                   	push   %eax
    1581:	ff 75 08             	pushl  0x8(%ebp)
    1584:	e8 3c ff ff ff       	call   14c5 <putc>
    1589:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    158c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1590:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1594:	79 d9                	jns    156f <printint+0x87>
    putc(fd, buf[i]);
}
    1596:	90                   	nop
    1597:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    159a:	c9                   	leave  
    159b:	c3                   	ret    

0000159c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    159c:	55                   	push   %ebp
    159d:	89 e5                	mov    %esp,%ebp
    159f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    15a2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    15a9:	8d 45 0c             	lea    0xc(%ebp),%eax
    15ac:	83 c0 04             	add    $0x4,%eax
    15af:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    15b2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15b9:	e9 59 01 00 00       	jmp    1717 <printf+0x17b>
    c = fmt[i] & 0xff;
    15be:	8b 55 0c             	mov    0xc(%ebp),%edx
    15c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15c4:	01 d0                	add    %edx,%eax
    15c6:	0f b6 00             	movzbl (%eax),%eax
    15c9:	0f be c0             	movsbl %al,%eax
    15cc:	25 ff 00 00 00       	and    $0xff,%eax
    15d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    15d4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    15d8:	75 2c                	jne    1606 <printf+0x6a>
      if(c == '%'){
    15da:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15de:	75 0c                	jne    15ec <printf+0x50>
        state = '%';
    15e0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    15e7:	e9 27 01 00 00       	jmp    1713 <printf+0x177>
      } else {
        putc(fd, c);
    15ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15ef:	0f be c0             	movsbl %al,%eax
    15f2:	83 ec 08             	sub    $0x8,%esp
    15f5:	50                   	push   %eax
    15f6:	ff 75 08             	pushl  0x8(%ebp)
    15f9:	e8 c7 fe ff ff       	call   14c5 <putc>
    15fe:	83 c4 10             	add    $0x10,%esp
    1601:	e9 0d 01 00 00       	jmp    1713 <printf+0x177>
      }
    } else if(state == '%'){
    1606:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    160a:	0f 85 03 01 00 00    	jne    1713 <printf+0x177>
      if(c == 'd'){
    1610:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1614:	75 1e                	jne    1634 <printf+0x98>
        printint(fd, *ap, 10, 1);
    1616:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1619:	8b 00                	mov    (%eax),%eax
    161b:	6a 01                	push   $0x1
    161d:	6a 0a                	push   $0xa
    161f:	50                   	push   %eax
    1620:	ff 75 08             	pushl  0x8(%ebp)
    1623:	e8 c0 fe ff ff       	call   14e8 <printint>
    1628:	83 c4 10             	add    $0x10,%esp
        ap++;
    162b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    162f:	e9 d8 00 00 00       	jmp    170c <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1634:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1638:	74 06                	je     1640 <printf+0xa4>
    163a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    163e:	75 1e                	jne    165e <printf+0xc2>
        printint(fd, *ap, 16, 0);
    1640:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1643:	8b 00                	mov    (%eax),%eax
    1645:	6a 00                	push   $0x0
    1647:	6a 10                	push   $0x10
    1649:	50                   	push   %eax
    164a:	ff 75 08             	pushl  0x8(%ebp)
    164d:	e8 96 fe ff ff       	call   14e8 <printint>
    1652:	83 c4 10             	add    $0x10,%esp
        ap++;
    1655:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1659:	e9 ae 00 00 00       	jmp    170c <printf+0x170>
      } else if(c == 's'){
    165e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1662:	75 43                	jne    16a7 <printf+0x10b>
        s = (char*)*ap;
    1664:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1667:	8b 00                	mov    (%eax),%eax
    1669:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    166c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1670:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1674:	75 25                	jne    169b <printf+0xff>
          s = "(null)";
    1676:	c7 45 f4 db 38 00 00 	movl   $0x38db,-0xc(%ebp)
        while(*s != 0){
    167d:	eb 1c                	jmp    169b <printf+0xff>
          putc(fd, *s);
    167f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1682:	0f b6 00             	movzbl (%eax),%eax
    1685:	0f be c0             	movsbl %al,%eax
    1688:	83 ec 08             	sub    $0x8,%esp
    168b:	50                   	push   %eax
    168c:	ff 75 08             	pushl  0x8(%ebp)
    168f:	e8 31 fe ff ff       	call   14c5 <putc>
    1694:	83 c4 10             	add    $0x10,%esp
          s++;
    1697:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    169b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169e:	0f b6 00             	movzbl (%eax),%eax
    16a1:	84 c0                	test   %al,%al
    16a3:	75 da                	jne    167f <printf+0xe3>
    16a5:	eb 65                	jmp    170c <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16a7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    16ab:	75 1d                	jne    16ca <printf+0x12e>
        putc(fd, *ap);
    16ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16b0:	8b 00                	mov    (%eax),%eax
    16b2:	0f be c0             	movsbl %al,%eax
    16b5:	83 ec 08             	sub    $0x8,%esp
    16b8:	50                   	push   %eax
    16b9:	ff 75 08             	pushl  0x8(%ebp)
    16bc:	e8 04 fe ff ff       	call   14c5 <putc>
    16c1:	83 c4 10             	add    $0x10,%esp
        ap++;
    16c4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    16c8:	eb 42                	jmp    170c <printf+0x170>
      } else if(c == '%'){
    16ca:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    16ce:	75 17                	jne    16e7 <printf+0x14b>
        putc(fd, c);
    16d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16d3:	0f be c0             	movsbl %al,%eax
    16d6:	83 ec 08             	sub    $0x8,%esp
    16d9:	50                   	push   %eax
    16da:	ff 75 08             	pushl  0x8(%ebp)
    16dd:	e8 e3 fd ff ff       	call   14c5 <putc>
    16e2:	83 c4 10             	add    $0x10,%esp
    16e5:	eb 25                	jmp    170c <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    16e7:	83 ec 08             	sub    $0x8,%esp
    16ea:	6a 25                	push   $0x25
    16ec:	ff 75 08             	pushl  0x8(%ebp)
    16ef:	e8 d1 fd ff ff       	call   14c5 <putc>
    16f4:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    16f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16fa:	0f be c0             	movsbl %al,%eax
    16fd:	83 ec 08             	sub    $0x8,%esp
    1700:	50                   	push   %eax
    1701:	ff 75 08             	pushl  0x8(%ebp)
    1704:	e8 bc fd ff ff       	call   14c5 <putc>
    1709:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    170c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1713:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1717:	8b 55 0c             	mov    0xc(%ebp),%edx
    171a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    171d:	01 d0                	add    %edx,%eax
    171f:	0f b6 00             	movzbl (%eax),%eax
    1722:	84 c0                	test   %al,%al
    1724:	0f 85 94 fe ff ff    	jne    15be <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    172a:	90                   	nop
    172b:	c9                   	leave  
    172c:	c3                   	ret    

0000172d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    172d:	55                   	push   %ebp
    172e:	89 e5                	mov    %esp,%ebp
    1730:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1733:	8b 45 08             	mov    0x8(%ebp),%eax
    1736:	83 e8 08             	sub    $0x8,%eax
    1739:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    173c:	a1 ec 7d 00 00       	mov    0x7dec,%eax
    1741:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1744:	eb 24                	jmp    176a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1746:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1749:	8b 00                	mov    (%eax),%eax
    174b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    174e:	77 12                	ja     1762 <free+0x35>
    1750:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1753:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1756:	77 24                	ja     177c <free+0x4f>
    1758:	8b 45 fc             	mov    -0x4(%ebp),%eax
    175b:	8b 00                	mov    (%eax),%eax
    175d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1760:	77 1a                	ja     177c <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1762:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1765:	8b 00                	mov    (%eax),%eax
    1767:	89 45 fc             	mov    %eax,-0x4(%ebp)
    176a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    176d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1770:	76 d4                	jbe    1746 <free+0x19>
    1772:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1775:	8b 00                	mov    (%eax),%eax
    1777:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    177a:	76 ca                	jbe    1746 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    177c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    177f:	8b 40 04             	mov    0x4(%eax),%eax
    1782:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1789:	8b 45 f8             	mov    -0x8(%ebp),%eax
    178c:	01 c2                	add    %eax,%edx
    178e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1791:	8b 00                	mov    (%eax),%eax
    1793:	39 c2                	cmp    %eax,%edx
    1795:	75 24                	jne    17bb <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1797:	8b 45 f8             	mov    -0x8(%ebp),%eax
    179a:	8b 50 04             	mov    0x4(%eax),%edx
    179d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17a0:	8b 00                	mov    (%eax),%eax
    17a2:	8b 40 04             	mov    0x4(%eax),%eax
    17a5:	01 c2                	add    %eax,%edx
    17a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17aa:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    17ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17b0:	8b 00                	mov    (%eax),%eax
    17b2:	8b 10                	mov    (%eax),%edx
    17b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17b7:	89 10                	mov    %edx,(%eax)
    17b9:	eb 0a                	jmp    17c5 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    17bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17be:	8b 10                	mov    (%eax),%edx
    17c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17c3:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    17c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17c8:	8b 40 04             	mov    0x4(%eax),%eax
    17cb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    17d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17d5:	01 d0                	add    %edx,%eax
    17d7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17da:	75 20                	jne    17fc <free+0xcf>
    p->s.size += bp->s.size;
    17dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17df:	8b 50 04             	mov    0x4(%eax),%edx
    17e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17e5:	8b 40 04             	mov    0x4(%eax),%eax
    17e8:	01 c2                	add    %eax,%edx
    17ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ed:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    17f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17f3:	8b 10                	mov    (%eax),%edx
    17f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17f8:	89 10                	mov    %edx,(%eax)
    17fa:	eb 08                	jmp    1804 <free+0xd7>
  } else
    p->s.ptr = bp;
    17fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ff:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1802:	89 10                	mov    %edx,(%eax)
  freep = p;
    1804:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1807:	a3 ec 7d 00 00       	mov    %eax,0x7dec
}
    180c:	90                   	nop
    180d:	c9                   	leave  
    180e:	c3                   	ret    

0000180f <morecore>:

static Header*
morecore(uint nu)
{
    180f:	55                   	push   %ebp
    1810:	89 e5                	mov    %esp,%ebp
    1812:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1815:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    181c:	77 07                	ja     1825 <morecore+0x16>
    nu = 4096;
    181e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1825:	8b 45 08             	mov    0x8(%ebp),%eax
    1828:	c1 e0 03             	shl    $0x3,%eax
    182b:	83 ec 0c             	sub    $0xc,%esp
    182e:	50                   	push   %eax
    182f:	e8 31 fc ff ff       	call   1465 <sbrk>
    1834:	83 c4 10             	add    $0x10,%esp
    1837:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    183a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    183e:	75 07                	jne    1847 <morecore+0x38>
    return 0;
    1840:	b8 00 00 00 00       	mov    $0x0,%eax
    1845:	eb 26                	jmp    186d <morecore+0x5e>
  hp = (Header*)p;
    1847:	8b 45 f4             	mov    -0xc(%ebp),%eax
    184a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    184d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1850:	8b 55 08             	mov    0x8(%ebp),%edx
    1853:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1856:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1859:	83 c0 08             	add    $0x8,%eax
    185c:	83 ec 0c             	sub    $0xc,%esp
    185f:	50                   	push   %eax
    1860:	e8 c8 fe ff ff       	call   172d <free>
    1865:	83 c4 10             	add    $0x10,%esp
  return freep;
    1868:	a1 ec 7d 00 00       	mov    0x7dec,%eax
}
    186d:	c9                   	leave  
    186e:	c3                   	ret    

0000186f <malloc>:

void*
malloc(uint nbytes)
{
    186f:	55                   	push   %ebp
    1870:	89 e5                	mov    %esp,%ebp
    1872:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1875:	8b 45 08             	mov    0x8(%ebp),%eax
    1878:	83 c0 07             	add    $0x7,%eax
    187b:	c1 e8 03             	shr    $0x3,%eax
    187e:	83 c0 01             	add    $0x1,%eax
    1881:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1884:	a1 ec 7d 00 00       	mov    0x7dec,%eax
    1889:	89 45 f0             	mov    %eax,-0x10(%ebp)
    188c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1890:	75 23                	jne    18b5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1892:	c7 45 f0 e4 7d 00 00 	movl   $0x7de4,-0x10(%ebp)
    1899:	8b 45 f0             	mov    -0x10(%ebp),%eax
    189c:	a3 ec 7d 00 00       	mov    %eax,0x7dec
    18a1:	a1 ec 7d 00 00       	mov    0x7dec,%eax
    18a6:	a3 e4 7d 00 00       	mov    %eax,0x7de4
    base.s.size = 0;
    18ab:	c7 05 e8 7d 00 00 00 	movl   $0x0,0x7de8
    18b2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    18b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18b8:	8b 00                	mov    (%eax),%eax
    18ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    18bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c0:	8b 40 04             	mov    0x4(%eax),%eax
    18c3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    18c6:	72 4d                	jb     1915 <malloc+0xa6>
      if(p->s.size == nunits)
    18c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18cb:	8b 40 04             	mov    0x4(%eax),%eax
    18ce:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    18d1:	75 0c                	jne    18df <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    18d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d6:	8b 10                	mov    (%eax),%edx
    18d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18db:	89 10                	mov    %edx,(%eax)
    18dd:	eb 26                	jmp    1905 <malloc+0x96>
      else {
        p->s.size -= nunits;
    18df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e2:	8b 40 04             	mov    0x4(%eax),%eax
    18e5:	2b 45 ec             	sub    -0x14(%ebp),%eax
    18e8:	89 c2                	mov    %eax,%edx
    18ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ed:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    18f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f3:	8b 40 04             	mov    0x4(%eax),%eax
    18f6:	c1 e0 03             	shl    $0x3,%eax
    18f9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    18fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ff:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1902:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1905:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1908:	a3 ec 7d 00 00       	mov    %eax,0x7dec
      return (void*)(p + 1);
    190d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1910:	83 c0 08             	add    $0x8,%eax
    1913:	eb 3b                	jmp    1950 <malloc+0xe1>
    }
    if(p == freep)
    1915:	a1 ec 7d 00 00       	mov    0x7dec,%eax
    191a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    191d:	75 1e                	jne    193d <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    191f:	83 ec 0c             	sub    $0xc,%esp
    1922:	ff 75 ec             	pushl  -0x14(%ebp)
    1925:	e8 e5 fe ff ff       	call   180f <morecore>
    192a:	83 c4 10             	add    $0x10,%esp
    192d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1930:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1934:	75 07                	jne    193d <malloc+0xce>
        return 0;
    1936:	b8 00 00 00 00       	mov    $0x0,%eax
    193b:	eb 13                	jmp    1950 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    193d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1940:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1943:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1946:	8b 00                	mov    (%eax),%eax
    1948:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    194b:	e9 6d ff ff ff       	jmp    18bd <malloc+0x4e>
}
    1950:	c9                   	leave  
    1951:	c3                   	ret    

00001952 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1952:	55                   	push   %ebp
    1953:	89 e5                	mov    %esp,%ebp
    1955:	83 ec 1c             	sub    $0x1c,%esp
    1958:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    195b:	8b 55 10             	mov    0x10(%ebp),%edx
    195e:	8b 45 14             	mov    0x14(%ebp),%eax
    1961:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1964:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1967:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    196a:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    196e:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1971:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1975:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1978:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    197c:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    197f:	8b 45 08             	mov    0x8(%ebp),%eax
    1982:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1986:	66 89 10             	mov    %dx,(%eax)
    1989:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    198d:	88 50 02             	mov    %dl,0x2(%eax)
}
    1990:	8b 45 08             	mov    0x8(%ebp),%eax
    1993:	c9                   	leave  
    1994:	c2 04 00             	ret    $0x4

00001997 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    1997:	55                   	push   %ebp
    1998:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
    199a:	8b 45 08             	mov    0x8(%ebp),%eax
    199d:	2b 45 10             	sub    0x10(%ebp),%eax
    19a0:	89 c2                	mov    %eax,%edx
    19a2:	8b 45 08             	mov    0x8(%ebp),%eax
    19a5:	2b 45 10             	sub    0x10(%ebp),%eax
    19a8:	0f af d0             	imul   %eax,%edx
    19ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    19ae:	2b 45 14             	sub    0x14(%ebp),%eax
    19b1:	89 c1                	mov    %eax,%ecx
    19b3:	8b 45 0c             	mov    0xc(%ebp),%eax
    19b6:	2b 45 14             	sub    0x14(%ebp),%eax
    19b9:	0f af c1             	imul   %ecx,%eax
    19bc:	01 d0                	add    %edx,%eax
}
    19be:	5d                   	pop    %ebp
    19bf:	c3                   	ret    

000019c0 <abs_int>:

static inline int abs_int(int x)
{
    19c0:	55                   	push   %ebp
    19c1:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
    19c3:	8b 45 08             	mov    0x8(%ebp),%eax
    19c6:	99                   	cltd   
    19c7:	89 d0                	mov    %edx,%eax
    19c9:	33 45 08             	xor    0x8(%ebp),%eax
    19cc:	29 d0                	sub    %edx,%eax
}
    19ce:	5d                   	pop    %ebp
    19cf:	c3                   	ret    

000019d0 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    19d0:	55                   	push   %ebp
    19d1:	89 e5                	mov    %esp,%ebp
    if (x < 0)
    19d3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    19d7:	79 07                	jns    19e0 <APGetIndex+0x10>
        return X_SMALLER;
    19d9:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    19de:	eb 40                	jmp    1a20 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
    19e0:	8b 45 08             	mov    0x8(%ebp),%eax
    19e3:	8b 00                	mov    (%eax),%eax
    19e5:	3b 45 0c             	cmp    0xc(%ebp),%eax
    19e8:	7f 07                	jg     19f1 <APGetIndex+0x21>
        return X_BIGGER;
    19ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    19ef:	eb 2f                	jmp    1a20 <APGetIndex+0x50>
    if (y < 0)
    19f1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    19f5:	79 07                	jns    19fe <APGetIndex+0x2e>
        return Y_SMALLER;
    19f7:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
    19fc:	eb 22                	jmp    1a20 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
    19fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1a01:	8b 40 04             	mov    0x4(%eax),%eax
    1a04:	3b 45 10             	cmp    0x10(%ebp),%eax
    1a07:	7f 07                	jg     1a10 <APGetIndex+0x40>
        return Y_BIGGER;
    1a09:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    1a0e:	eb 10                	jmp    1a20 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
    1a10:	8b 45 08             	mov    0x8(%ebp),%eax
    1a13:	8b 00                	mov    (%eax),%eax
    1a15:	0f af 45 10          	imul   0x10(%ebp),%eax
    1a19:	89 c2                	mov    %eax,%edx
    1a1b:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a1e:	01 d0                	add    %edx,%eax
}
    1a20:	5d                   	pop    %ebp
    1a21:	c3                   	ret    

00001a22 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    1a22:	55                   	push   %ebp
    1a23:	89 e5                	mov    %esp,%ebp
    1a25:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    1a28:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    1a2f:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1a32:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    1a35:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    1a3c:	83 ec 08             	sub    $0x8,%esp
    1a3f:	6a 00                	push   $0x0
    1a41:	ff 75 0c             	pushl  0xc(%ebp)
    1a44:	e8 d4 f9 ff ff       	call   141d <open>
    1a49:	83 c4 10             	add    $0x10,%esp
    1a4c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    1a4f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a53:	79 2e                	jns    1a83 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
    1a55:	83 ec 04             	sub    $0x4,%esp
    1a58:	ff 75 0c             	pushl  0xc(%ebp)
    1a5b:	68 e2 38 00 00       	push   $0x38e2
    1a60:	6a 01                	push   $0x1
    1a62:	e8 35 fb ff ff       	call   159c <printf>
    1a67:	83 c4 10             	add    $0x10,%esp
        return bmp;
    1a6a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6d:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1a70:	89 10                	mov    %edx,(%eax)
    1a72:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1a75:	89 50 04             	mov    %edx,0x4(%eax)
    1a78:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1a7b:	89 50 08             	mov    %edx,0x8(%eax)
    1a7e:	e9 d2 01 00 00       	jmp    1c55 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    1a83:	83 ec 04             	sub    $0x4,%esp
    1a86:	6a 0e                	push   $0xe
    1a88:	8d 45 ba             	lea    -0x46(%ebp),%eax
    1a8b:	50                   	push   %eax
    1a8c:	ff 75 ec             	pushl  -0x14(%ebp)
    1a8f:	e8 61 f9 ff ff       	call   13f5 <read>
    1a94:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    1a97:	83 ec 04             	sub    $0x4,%esp
    1a9a:	6a 28                	push   $0x28
    1a9c:	8d 45 92             	lea    -0x6e(%ebp),%eax
    1a9f:	50                   	push   %eax
    1aa0:	ff 75 ec             	pushl  -0x14(%ebp)
    1aa3:	e8 4d f9 ff ff       	call   13f5 <read>
    1aa8:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    1aab:	8b 45 96             	mov    -0x6a(%ebp),%eax
    1aae:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    1ab1:	8b 45 9a             	mov    -0x66(%ebp),%eax
    1ab4:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    1ab7:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1aba:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1abd:	0f af d0             	imul   %eax,%edx
    1ac0:	89 d0                	mov    %edx,%eax
    1ac2:	01 c0                	add    %eax,%eax
    1ac4:	01 d0                	add    %edx,%eax
    1ac6:	83 ec 0c             	sub    $0xc,%esp
    1ac9:	50                   	push   %eax
    1aca:	e8 a0 fd ff ff       	call   186f <malloc>
    1acf:	83 c4 10             	add    $0x10,%esp
    1ad2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    1ad5:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    1ad9:	0f b7 c0             	movzwl %ax,%eax
    1adc:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    1adf:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1ae2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1ae5:	0f af c2             	imul   %edx,%eax
    1ae8:	83 c0 1f             	add    $0x1f,%eax
    1aeb:	c1 e8 05             	shr    $0x5,%eax
    1aee:	c1 e0 02             	shl    $0x2,%eax
    1af1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    1af4:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1af7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1afa:	0f af c2             	imul   %edx,%eax
    1afd:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    1b00:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b03:	83 ec 0c             	sub    $0xc,%esp
    1b06:	50                   	push   %eax
    1b07:	e8 63 fd ff ff       	call   186f <malloc>
    1b0c:	83 c4 10             	add    $0x10,%esp
    1b0f:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    1b12:	83 ec 04             	sub    $0x4,%esp
    1b15:	ff 75 e0             	pushl  -0x20(%ebp)
    1b18:	ff 75 dc             	pushl  -0x24(%ebp)
    1b1b:	ff 75 ec             	pushl  -0x14(%ebp)
    1b1e:	e8 d2 f8 ff ff       	call   13f5 <read>
    1b23:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    1b26:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    1b2a:	66 c1 e8 03          	shr    $0x3,%ax
    1b2e:	0f b7 c0             	movzwl %ax,%eax
    1b31:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    1b34:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1b3b:	e9 e5 00 00 00       	jmp    1c25 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    1b40:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1b43:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b46:	29 c2                	sub    %eax,%edx
    1b48:	89 d0                	mov    %edx,%eax
    1b4a:	8d 50 ff             	lea    -0x1(%eax),%edx
    1b4d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1b50:	0f af c2             	imul   %edx,%eax
    1b53:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    1b56:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1b5d:	e9 b1 00 00 00       	jmp    1c13 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    1b62:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1b65:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1b68:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b6b:	01 c8                	add    %ecx,%eax
    1b6d:	89 c1                	mov    %eax,%ecx
    1b6f:	89 c8                	mov    %ecx,%eax
    1b71:	01 c0                	add    %eax,%eax
    1b73:	01 c8                	add    %ecx,%eax
    1b75:	01 c2                	add    %eax,%edx
    1b77:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b7a:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1b7e:	89 c1                	mov    %eax,%ecx
    1b80:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b83:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1b87:	01 c1                	add    %eax,%ecx
    1b89:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b8c:	01 c8                	add    %ecx,%eax
    1b8e:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1b91:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1b94:	01 c8                	add    %ecx,%eax
    1b96:	0f b6 00             	movzbl (%eax),%eax
    1b99:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    1b9c:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1b9f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1ba2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ba5:	01 c8                	add    %ecx,%eax
    1ba7:	89 c1                	mov    %eax,%ecx
    1ba9:	89 c8                	mov    %ecx,%eax
    1bab:	01 c0                	add    %eax,%eax
    1bad:	01 c8                	add    %ecx,%eax
    1baf:	01 c2                	add    %eax,%edx
    1bb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bb4:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1bb8:	89 c1                	mov    %eax,%ecx
    1bba:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1bbd:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1bc1:	01 c1                	add    %eax,%ecx
    1bc3:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1bc6:	01 c8                	add    %ecx,%eax
    1bc8:	8d 48 fe             	lea    -0x2(%eax),%ecx
    1bcb:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1bce:	01 c8                	add    %ecx,%eax
    1bd0:	0f b6 00             	movzbl (%eax),%eax
    1bd3:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    1bd6:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1bd9:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1bdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bdf:	01 c8                	add    %ecx,%eax
    1be1:	89 c1                	mov    %eax,%ecx
    1be3:	89 c8                	mov    %ecx,%eax
    1be5:	01 c0                	add    %eax,%eax
    1be7:	01 c8                	add    %ecx,%eax
    1be9:	01 c2                	add    %eax,%edx
    1beb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bee:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1bf2:	89 c1                	mov    %eax,%ecx
    1bf4:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1bf7:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1bfb:	01 c1                	add    %eax,%ecx
    1bfd:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1c00:	01 c8                	add    %ecx,%eax
    1c02:	8d 48 fd             	lea    -0x3(%eax),%ecx
    1c05:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1c08:	01 c8                	add    %ecx,%eax
    1c0a:	0f b6 00             	movzbl (%eax),%eax
    1c0d:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    1c0f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1c13:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1c16:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c19:	39 c2                	cmp    %eax,%edx
    1c1b:	0f 87 41 ff ff ff    	ja     1b62 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    1c21:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c25:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1c28:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c2b:	39 c2                	cmp    %eax,%edx
    1c2d:	0f 87 0d ff ff ff    	ja     1b40 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    1c33:	83 ec 0c             	sub    $0xc,%esp
    1c36:	ff 75 ec             	pushl  -0x14(%ebp)
    1c39:	e8 c7 f7 ff ff       	call   1405 <close>
    1c3e:	83 c4 10             	add    $0x10,%esp
    return bmp;
    1c41:	8b 45 08             	mov    0x8(%ebp),%eax
    1c44:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1c47:	89 10                	mov    %edx,(%eax)
    1c49:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1c4c:	89 50 04             	mov    %edx,0x4(%eax)
    1c4f:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1c52:	89 50 08             	mov    %edx,0x8(%eax)
}
    1c55:	8b 45 08             	mov    0x8(%ebp),%eax
    1c58:	c9                   	leave  
    1c59:	c2 04 00             	ret    $0x4

00001c5c <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    1c5c:	55                   	push   %ebp
    1c5d:	89 e5                	mov    %esp,%ebp
    1c5f:	53                   	push   %ebx
    1c60:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    1c63:	83 ec 0c             	sub    $0xc,%esp
    1c66:	6a 1c                	push   $0x1c
    1c68:	e8 02 fc ff ff       	call   186f <malloc>
    1c6d:	83 c4 10             	add    $0x10,%esp
    1c70:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    1c73:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c76:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    1c7d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    1c80:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1c83:	6a 0c                	push   $0xc
    1c85:	6a 0c                	push   $0xc
    1c87:	6a 0c                	push   $0xc
    1c89:	50                   	push   %eax
    1c8a:	e8 c3 fc ff ff       	call   1952 <RGB>
    1c8f:	83 c4 0c             	add    $0xc,%esp
    1c92:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    1c96:	66 89 43 13          	mov    %ax,0x13(%ebx)
    1c9a:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    1c9e:	88 43 15             	mov    %al,0x15(%ebx)
    1ca1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ca4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ca7:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    1cab:	66 89 48 10          	mov    %cx,0x10(%eax)
    1caf:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    1cb3:	88 50 12             	mov    %dl,0x12(%eax)
    1cb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cb9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1cbc:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    1cc0:	66 89 48 08          	mov    %cx,0x8(%eax)
    1cc4:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    1cc8:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    1ccb:	8b 45 08             	mov    0x8(%ebp),%eax
    1cce:	89 c2                	mov    %eax,%edx
    1cd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cd3:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    1cd5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cd8:	89 c2                	mov    %eax,%edx
    1cda:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cdd:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    1ce0:	8b 55 10             	mov    0x10(%ebp),%edx
    1ce3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ce6:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    1ce9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1cec:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1cef:	c9                   	leave  
    1cf0:	c3                   	ret    

00001cf1 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    1cf1:	55                   	push   %ebp
    1cf2:	89 e5                	mov    %esp,%ebp
    1cf4:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    1cf7:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cfa:	8b 50 08             	mov    0x8(%eax),%edx
    1cfd:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1d00:	8b 40 0c             	mov    0xc(%eax),%eax
    1d03:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    1d06:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d09:	8b 55 10             	mov    0x10(%ebp),%edx
    1d0c:	89 50 08             	mov    %edx,0x8(%eax)
    1d0f:	8b 55 14             	mov    0x14(%ebp),%edx
    1d12:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    1d15:	8b 45 08             	mov    0x8(%ebp),%eax
    1d18:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1d1b:	89 10                	mov    %edx,(%eax)
    1d1d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1d20:	89 50 04             	mov    %edx,0x4(%eax)
}
    1d23:	8b 45 08             	mov    0x8(%ebp),%eax
    1d26:	c9                   	leave  
    1d27:	c2 04 00             	ret    $0x4

00001d2a <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    1d2a:	55                   	push   %ebp
    1d2b:	89 e5                	mov    %esp,%ebp
    1d2d:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    1d30:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d33:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    1d37:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1d3b:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1d3f:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    1d42:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d45:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1d49:	66 89 50 10          	mov    %dx,0x10(%eax)
    1d4d:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1d51:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    1d54:	8b 45 08             	mov    0x8(%ebp),%eax
    1d57:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1d5b:	66 89 10             	mov    %dx,(%eax)
    1d5e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1d62:	88 50 02             	mov    %dl,0x2(%eax)
}
    1d65:	8b 45 08             	mov    0x8(%ebp),%eax
    1d68:	c9                   	leave  
    1d69:	c2 04 00             	ret    $0x4

00001d6c <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
    1d6c:	55                   	push   %ebp
    1d6d:	89 e5                	mov    %esp,%ebp
    1d6f:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
    1d72:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d75:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1d79:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1d7d:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1d81:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
    1d84:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d87:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1d8b:	66 89 50 13          	mov    %dx,0x13(%eax)
    1d8f:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1d93:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
    1d96:	8b 45 08             	mov    0x8(%ebp),%eax
    1d99:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1d9d:	66 89 10             	mov    %dx,(%eax)
    1da0:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1da4:	88 50 02             	mov    %dl,0x2(%eax)
}
    1da7:	8b 45 08             	mov    0x8(%ebp),%eax
    1daa:	c9                   	leave  
    1dab:	c2 04 00             	ret    $0x4

00001dae <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    1dae:	55                   	push   %ebp
    1daf:	89 e5                	mov    %esp,%ebp
    1db1:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    1db4:	8b 45 08             	mov    0x8(%ebp),%eax
    1db7:	8b 40 0c             	mov    0xc(%eax),%eax
    1dba:	89 c2                	mov    %eax,%edx
    1dbc:	c1 ea 1f             	shr    $0x1f,%edx
    1dbf:	01 d0                	add    %edx,%eax
    1dc1:	d1 f8                	sar    %eax
    1dc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    1dc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dc9:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    1dcd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    1dd0:	8b 45 10             	mov    0x10(%ebp),%eax
    1dd3:	2b 45 f4             	sub    -0xc(%ebp),%eax
    1dd6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    1dd9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    1ddd:	0f 89 98 00 00 00    	jns    1e7b <APDrawPoint+0xcd>
        i = 0;
    1de3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    1dea:	e9 8c 00 00 00       	jmp    1e7b <APDrawPoint+0xcd>
    {
        j = x - off;
    1def:	8b 45 0c             	mov    0xc(%ebp),%eax
    1df2:	2b 45 f4             	sub    -0xc(%ebp),%eax
    1df5:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    1df8:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1dfc:	79 69                	jns    1e67 <APDrawPoint+0xb9>
            j = 0;
    1dfe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    1e05:	eb 60                	jmp    1e67 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    1e07:	ff 75 fc             	pushl  -0x4(%ebp)
    1e0a:	ff 75 f8             	pushl  -0x8(%ebp)
    1e0d:	ff 75 08             	pushl  0x8(%ebp)
    1e10:	e8 bb fb ff ff       	call   19d0 <APGetIndex>
    1e15:	83 c4 0c             	add    $0xc,%esp
    1e18:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    1e1b:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    1e1f:	74 55                	je     1e76 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    1e21:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    1e25:	74 67                	je     1e8e <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    1e27:	ff 75 10             	pushl  0x10(%ebp)
    1e2a:	ff 75 0c             	pushl  0xc(%ebp)
    1e2d:	ff 75 fc             	pushl  -0x4(%ebp)
    1e30:	ff 75 f8             	pushl  -0x8(%ebp)
    1e33:	e8 5f fb ff ff       	call   1997 <distance_2>
    1e38:	83 c4 10             	add    $0x10,%esp
    1e3b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1e3e:	7f 23                	jg     1e63 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    1e40:	8b 45 08             	mov    0x8(%ebp),%eax
    1e43:	8b 48 18             	mov    0x18(%eax),%ecx
    1e46:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1e49:	89 d0                	mov    %edx,%eax
    1e4b:	01 c0                	add    %eax,%eax
    1e4d:	01 d0                	add    %edx,%eax
    1e4f:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1e52:	8b 45 08             	mov    0x8(%ebp),%eax
    1e55:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1e59:	66 89 0a             	mov    %cx,(%edx)
    1e5c:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1e60:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1e63:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1e67:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e6d:	01 d0                	add    %edx,%eax
    1e6f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1e72:	7d 93                	jge    1e07 <APDrawPoint+0x59>
    1e74:	eb 01                	jmp    1e77 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1e76:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1e77:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1e7b:	8b 55 10             	mov    0x10(%ebp),%edx
    1e7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e81:	01 d0                	add    %edx,%eax
    1e83:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1e86:	0f 8d 63 ff ff ff    	jge    1def <APDrawPoint+0x41>
    1e8c:	eb 01                	jmp    1e8f <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1e8e:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    1e8f:	c9                   	leave  
    1e90:	c3                   	ret    

00001e91 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1e91:	55                   	push   %ebp
    1e92:	89 e5                	mov    %esp,%ebp
    1e94:	53                   	push   %ebx
    1e95:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1e98:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e9b:	3b 45 14             	cmp    0x14(%ebp),%eax
    1e9e:	0f 85 80 00 00 00    	jne    1f24 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1ea4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1ea8:	0f 88 9d 02 00 00    	js     214b <APDrawLine+0x2ba>
    1eae:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb1:	8b 00                	mov    (%eax),%eax
    1eb3:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1eb6:	0f 8e 8f 02 00 00    	jle    214b <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    1ebc:	8b 45 10             	mov    0x10(%ebp),%eax
    1ebf:	3b 45 18             	cmp    0x18(%ebp),%eax
    1ec2:	7e 12                	jle    1ed6 <APDrawLine+0x45>
        {
            int tmp = y2;
    1ec4:	8b 45 18             	mov    0x18(%ebp),%eax
    1ec7:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    1eca:	8b 45 10             	mov    0x10(%ebp),%eax
    1ecd:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1ed0:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1ed3:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1ed6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1eda:	79 07                	jns    1ee3 <APDrawLine+0x52>
    1edc:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1ee3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee6:	8b 40 04             	mov    0x4(%eax),%eax
    1ee9:	3b 45 18             	cmp    0x18(%ebp),%eax
    1eec:	7d 0c                	jge    1efa <APDrawLine+0x69>
    1eee:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef1:	8b 40 04             	mov    0x4(%eax),%eax
    1ef4:	83 e8 01             	sub    $0x1,%eax
    1ef7:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    1efa:	8b 45 10             	mov    0x10(%ebp),%eax
    1efd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1f00:	eb 15                	jmp    1f17 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1f02:	ff 75 f4             	pushl  -0xc(%ebp)
    1f05:	ff 75 0c             	pushl  0xc(%ebp)
    1f08:	ff 75 08             	pushl  0x8(%ebp)
    1f0b:	e8 9e fe ff ff       	call   1dae <APDrawPoint>
    1f10:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1f13:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1f17:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f1a:	3b 45 18             	cmp    0x18(%ebp),%eax
    1f1d:	7e e3                	jle    1f02 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    1f1f:	e9 2b 02 00 00       	jmp    214f <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1f24:	8b 45 10             	mov    0x10(%ebp),%eax
    1f27:	3b 45 18             	cmp    0x18(%ebp),%eax
    1f2a:	75 7f                	jne    1fab <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    1f2c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1f30:	0f 88 18 02 00 00    	js     214e <APDrawLine+0x2bd>
    1f36:	8b 45 08             	mov    0x8(%ebp),%eax
    1f39:	8b 40 04             	mov    0x4(%eax),%eax
    1f3c:	3b 45 10             	cmp    0x10(%ebp),%eax
    1f3f:	0f 8e 09 02 00 00    	jle    214e <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1f45:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f48:	3b 45 14             	cmp    0x14(%ebp),%eax
    1f4b:	7e 12                	jle    1f5f <APDrawLine+0xce>
        {
            int tmp = x2;
    1f4d:	8b 45 14             	mov    0x14(%ebp),%eax
    1f50:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1f53:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f56:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1f59:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1f5c:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1f5f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1f63:	79 07                	jns    1f6c <APDrawLine+0xdb>
    1f65:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1f6c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f6f:	8b 00                	mov    (%eax),%eax
    1f71:	3b 45 14             	cmp    0x14(%ebp),%eax
    1f74:	7d 0b                	jge    1f81 <APDrawLine+0xf0>
    1f76:	8b 45 08             	mov    0x8(%ebp),%eax
    1f79:	8b 00                	mov    (%eax),%eax
    1f7b:	83 e8 01             	sub    $0x1,%eax
    1f7e:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1f81:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f84:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f87:	eb 15                	jmp    1f9e <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1f89:	ff 75 10             	pushl  0x10(%ebp)
    1f8c:	ff 75 f0             	pushl  -0x10(%ebp)
    1f8f:	ff 75 08             	pushl  0x8(%ebp)
    1f92:	e8 17 fe ff ff       	call   1dae <APDrawPoint>
    1f97:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1f9a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1f9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fa1:	3b 45 14             	cmp    0x14(%ebp),%eax
    1fa4:	7e e3                	jle    1f89 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1fa6:	e9 a4 01 00 00       	jmp    214f <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1fab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1fb2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1fb9:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fbc:	2b 45 14             	sub    0x14(%ebp),%eax
    1fbf:	50                   	push   %eax
    1fc0:	e8 fb f9 ff ff       	call   19c0 <abs_int>
    1fc5:	83 c4 04             	add    $0x4,%esp
    1fc8:	89 c3                	mov    %eax,%ebx
    1fca:	8b 45 10             	mov    0x10(%ebp),%eax
    1fcd:	2b 45 18             	sub    0x18(%ebp),%eax
    1fd0:	50                   	push   %eax
    1fd1:	e8 ea f9 ff ff       	call   19c0 <abs_int>
    1fd6:	83 c4 04             	add    $0x4,%esp
    1fd9:	39 c3                	cmp    %eax,%ebx
    1fdb:	0f 8e b5 00 00 00    	jle    2096 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1fe1:	8b 45 10             	mov    0x10(%ebp),%eax
    1fe4:	2b 45 18             	sub    0x18(%ebp),%eax
    1fe7:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1fea:	db 45 b0             	fildl  -0x50(%ebp)
    1fed:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ff0:	2b 45 14             	sub    0x14(%ebp),%eax
    1ff3:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1ff6:	db 45 b0             	fildl  -0x50(%ebp)
    1ff9:	de f9                	fdivrp %st,%st(1)
    1ffb:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1ffe:	8b 45 14             	mov    0x14(%ebp),%eax
    2001:	3b 45 0c             	cmp    0xc(%ebp),%eax
    2004:	7e 0e                	jle    2014 <APDrawLine+0x183>
        {
            s = x1;
    2006:	8b 45 0c             	mov    0xc(%ebp),%eax
    2009:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    200c:	8b 45 14             	mov    0x14(%ebp),%eax
    200f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    2012:	eb 0c                	jmp    2020 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    2014:	8b 45 14             	mov    0x14(%ebp),%eax
    2017:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    201a:	8b 45 0c             	mov    0xc(%ebp),%eax
    201d:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    2020:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2024:	79 07                	jns    202d <APDrawLine+0x19c>
    2026:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    202d:	8b 45 08             	mov    0x8(%ebp),%eax
    2030:	8b 00                	mov    (%eax),%eax
    2032:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    2035:	7f 0b                	jg     2042 <APDrawLine+0x1b1>
    2037:	8b 45 08             	mov    0x8(%ebp),%eax
    203a:	8b 00                	mov    (%eax),%eax
    203c:	83 e8 01             	sub    $0x1,%eax
    203f:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    2042:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2045:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    2048:	eb 3f                	jmp    2089 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    204a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    204d:	2b 45 0c             	sub    0xc(%ebp),%eax
    2050:	89 45 b0             	mov    %eax,-0x50(%ebp)
    2053:	db 45 b0             	fildl  -0x50(%ebp)
    2056:	dc 4d d0             	fmull  -0x30(%ebp)
    2059:	db 45 10             	fildl  0x10(%ebp)
    205c:	de c1                	faddp  %st,%st(1)
    205e:	d9 7d b6             	fnstcw -0x4a(%ebp)
    2061:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    2065:	b4 0c                	mov    $0xc,%ah
    2067:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    206b:	d9 6d b4             	fldcw  -0x4c(%ebp)
    206e:	db 5d cc             	fistpl -0x34(%ebp)
    2071:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    2074:	ff 75 cc             	pushl  -0x34(%ebp)
    2077:	ff 75 e4             	pushl  -0x1c(%ebp)
    207a:	ff 75 08             	pushl  0x8(%ebp)
    207d:	e8 2c fd ff ff       	call   1dae <APDrawPoint>
    2082:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    2085:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2089:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    208c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    208f:	7e b9                	jle    204a <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    2091:	e9 b9 00 00 00       	jmp    214f <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    2096:	8b 45 0c             	mov    0xc(%ebp),%eax
    2099:	2b 45 14             	sub    0x14(%ebp),%eax
    209c:	89 45 b0             	mov    %eax,-0x50(%ebp)
    209f:	db 45 b0             	fildl  -0x50(%ebp)
    20a2:	8b 45 10             	mov    0x10(%ebp),%eax
    20a5:	2b 45 18             	sub    0x18(%ebp),%eax
    20a8:	89 45 b0             	mov    %eax,-0x50(%ebp)
    20ab:	db 45 b0             	fildl  -0x50(%ebp)
    20ae:	de f9                	fdivrp %st,%st(1)
    20b0:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    20b3:	8b 45 10             	mov    0x10(%ebp),%eax
    20b6:	3b 45 18             	cmp    0x18(%ebp),%eax
    20b9:	7e 0e                	jle    20c9 <APDrawLine+0x238>
    {
        s = y2;
    20bb:	8b 45 18             	mov    0x18(%ebp),%eax
    20be:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    20c1:	8b 45 10             	mov    0x10(%ebp),%eax
    20c4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    20c7:	eb 0c                	jmp    20d5 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    20c9:	8b 45 10             	mov    0x10(%ebp),%eax
    20cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    20cf:	8b 45 18             	mov    0x18(%ebp),%eax
    20d2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    20d5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    20d9:	79 07                	jns    20e2 <APDrawLine+0x251>
    20db:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    20e2:	8b 45 08             	mov    0x8(%ebp),%eax
    20e5:	8b 40 04             	mov    0x4(%eax),%eax
    20e8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    20eb:	7f 0c                	jg     20f9 <APDrawLine+0x268>
    20ed:	8b 45 08             	mov    0x8(%ebp),%eax
    20f0:	8b 40 04             	mov    0x4(%eax),%eax
    20f3:	83 e8 01             	sub    $0x1,%eax
    20f6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    20f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    20fc:	89 45 e0             	mov    %eax,-0x20(%ebp)
    20ff:	eb 3f                	jmp    2140 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    2101:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2104:	2b 45 10             	sub    0x10(%ebp),%eax
    2107:	89 45 b0             	mov    %eax,-0x50(%ebp)
    210a:	db 45 b0             	fildl  -0x50(%ebp)
    210d:	dc 4d c0             	fmull  -0x40(%ebp)
    2110:	db 45 0c             	fildl  0xc(%ebp)
    2113:	de c1                	faddp  %st,%st(1)
    2115:	d9 7d b6             	fnstcw -0x4a(%ebp)
    2118:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    211c:	b4 0c                	mov    $0xc,%ah
    211e:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    2122:	d9 6d b4             	fldcw  -0x4c(%ebp)
    2125:	db 5d bc             	fistpl -0x44(%ebp)
    2128:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    212b:	ff 75 e0             	pushl  -0x20(%ebp)
    212e:	ff 75 bc             	pushl  -0x44(%ebp)
    2131:	ff 75 08             	pushl  0x8(%ebp)
    2134:	e8 75 fc ff ff       	call   1dae <APDrawPoint>
    2139:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    213c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2140:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2143:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    2146:	7e b9                	jle    2101 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    2148:	90                   	nop
    2149:	eb 04                	jmp    214f <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    214b:	90                   	nop
    214c:	eb 01                	jmp    214f <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    214e:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    214f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2152:	c9                   	leave  
    2153:	c3                   	ret    

00002154 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    2154:	55                   	push   %ebp
    2155:	89 e5                	mov    %esp,%ebp
    2157:	53                   	push   %ebx
    2158:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    215b:	8b 55 10             	mov    0x10(%ebp),%edx
    215e:	8b 45 18             	mov    0x18(%ebp),%eax
    2161:	01 d0                	add    %edx,%eax
    2163:	83 e8 01             	sub    $0x1,%eax
    2166:	83 ec 04             	sub    $0x4,%esp
    2169:	50                   	push   %eax
    216a:	ff 75 0c             	pushl  0xc(%ebp)
    216d:	ff 75 10             	pushl  0x10(%ebp)
    2170:	ff 75 0c             	pushl  0xc(%ebp)
    2173:	ff 75 08             	pushl  0x8(%ebp)
    2176:	e8 16 fd ff ff       	call   1e91 <APDrawLine>
    217b:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    217e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2181:	8b 45 14             	mov    0x14(%ebp),%eax
    2184:	01 d0                	add    %edx,%eax
    2186:	83 e8 01             	sub    $0x1,%eax
    2189:	83 ec 04             	sub    $0x4,%esp
    218c:	ff 75 10             	pushl  0x10(%ebp)
    218f:	50                   	push   %eax
    2190:	ff 75 10             	pushl  0x10(%ebp)
    2193:	ff 75 0c             	pushl  0xc(%ebp)
    2196:	ff 75 08             	pushl  0x8(%ebp)
    2199:	e8 f3 fc ff ff       	call   1e91 <APDrawLine>
    219e:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    21a1:	8b 55 10             	mov    0x10(%ebp),%edx
    21a4:	8b 45 18             	mov    0x18(%ebp),%eax
    21a7:	01 d0                	add    %edx,%eax
    21a9:	8d 48 ff             	lea    -0x1(%eax),%ecx
    21ac:	8b 55 0c             	mov    0xc(%ebp),%edx
    21af:	8b 45 14             	mov    0x14(%ebp),%eax
    21b2:	01 d0                	add    %edx,%eax
    21b4:	8d 50 ff             	lea    -0x1(%eax),%edx
    21b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    21ba:	8b 45 14             	mov    0x14(%ebp),%eax
    21bd:	01 d8                	add    %ebx,%eax
    21bf:	83 e8 01             	sub    $0x1,%eax
    21c2:	83 ec 04             	sub    $0x4,%esp
    21c5:	51                   	push   %ecx
    21c6:	52                   	push   %edx
    21c7:	ff 75 10             	pushl  0x10(%ebp)
    21ca:	50                   	push   %eax
    21cb:	ff 75 08             	pushl  0x8(%ebp)
    21ce:	e8 be fc ff ff       	call   1e91 <APDrawLine>
    21d3:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    21d6:	8b 55 10             	mov    0x10(%ebp),%edx
    21d9:	8b 45 18             	mov    0x18(%ebp),%eax
    21dc:	01 d0                	add    %edx,%eax
    21de:	8d 48 ff             	lea    -0x1(%eax),%ecx
    21e1:	8b 55 0c             	mov    0xc(%ebp),%edx
    21e4:	8b 45 14             	mov    0x14(%ebp),%eax
    21e7:	01 d0                	add    %edx,%eax
    21e9:	8d 50 ff             	lea    -0x1(%eax),%edx
    21ec:	8b 5d 10             	mov    0x10(%ebp),%ebx
    21ef:	8b 45 18             	mov    0x18(%ebp),%eax
    21f2:	01 d8                	add    %ebx,%eax
    21f4:	83 e8 01             	sub    $0x1,%eax
    21f7:	83 ec 04             	sub    $0x4,%esp
    21fa:	51                   	push   %ecx
    21fb:	52                   	push   %edx
    21fc:	50                   	push   %eax
    21fd:	ff 75 0c             	pushl  0xc(%ebp)
    2200:	ff 75 08             	pushl  0x8(%ebp)
    2203:	e8 89 fc ff ff       	call   1e91 <APDrawLine>
    2208:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    220b:	8b 55 0c             	mov    0xc(%ebp),%edx
    220e:	8b 45 14             	mov    0x14(%ebp),%eax
    2211:	01 d0                	add    %edx,%eax
    2213:	8d 50 ff             	lea    -0x1(%eax),%edx
    2216:	8b 45 08             	mov    0x8(%ebp),%eax
    2219:	8b 40 0c             	mov    0xc(%eax),%eax
    221c:	89 c1                	mov    %eax,%ecx
    221e:	c1 e9 1f             	shr    $0x1f,%ecx
    2221:	01 c8                	add    %ecx,%eax
    2223:	d1 f8                	sar    %eax
    2225:	29 c2                	sub    %eax,%edx
    2227:	89 d0                	mov    %edx,%eax
    2229:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    222c:	8b 55 10             	mov    0x10(%ebp),%edx
    222f:	8b 45 18             	mov    0x18(%ebp),%eax
    2232:	01 d0                	add    %edx,%eax
    2234:	8d 50 ff             	lea    -0x1(%eax),%edx
    2237:	8b 45 08             	mov    0x8(%ebp),%eax
    223a:	8b 40 0c             	mov    0xc(%eax),%eax
    223d:	89 c1                	mov    %eax,%ecx
    223f:	c1 e9 1f             	shr    $0x1f,%ecx
    2242:	01 c8                	add    %ecx,%eax
    2244:	d1 f8                	sar    %eax
    2246:	29 c2                	sub    %eax,%edx
    2248:	89 d0                	mov    %edx,%eax
    224a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    224d:	8b 45 08             	mov    0x8(%ebp),%eax
    2250:	8b 40 0c             	mov    0xc(%eax),%eax
    2253:	89 c2                	mov    %eax,%edx
    2255:	c1 ea 1f             	shr    $0x1f,%edx
    2258:	01 d0                	add    %edx,%eax
    225a:	d1 f8                	sar    %eax
    225c:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    225f:	8b 45 08             	mov    0x8(%ebp),%eax
    2262:	8b 40 0c             	mov    0xc(%eax),%eax
    2265:	89 c2                	mov    %eax,%edx
    2267:	c1 ea 1f             	shr    $0x1f,%edx
    226a:	01 d0                	add    %edx,%eax
    226c:	d1 f8                	sar    %eax
    226e:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    2271:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2275:	0f 88 d8 00 00 00    	js     2353 <APDrawRect+0x1ff>
    227b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    227f:	0f 88 ce 00 00 00    	js     2353 <APDrawRect+0x1ff>
    2285:	8b 45 08             	mov    0x8(%ebp),%eax
    2288:	8b 00                	mov    (%eax),%eax
    228a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    228d:	0f 8e c0 00 00 00    	jle    2353 <APDrawRect+0x1ff>
    2293:	8b 45 08             	mov    0x8(%ebp),%eax
    2296:	8b 40 04             	mov    0x4(%eax),%eax
    2299:	3b 45 10             	cmp    0x10(%ebp),%eax
    229c:	0f 8e b1 00 00 00    	jle    2353 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    22a2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    22a6:	79 07                	jns    22af <APDrawRect+0x15b>
    22a8:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    22af:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    22b3:	79 07                	jns    22bc <APDrawRect+0x168>
    22b5:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    22bc:	8b 45 08             	mov    0x8(%ebp),%eax
    22bf:	8b 00                	mov    (%eax),%eax
    22c1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    22c4:	7f 0b                	jg     22d1 <APDrawRect+0x17d>
    22c6:	8b 45 08             	mov    0x8(%ebp),%eax
    22c9:	8b 00                	mov    (%eax),%eax
    22cb:	83 e8 01             	sub    $0x1,%eax
    22ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    22d1:	8b 45 08             	mov    0x8(%ebp),%eax
    22d4:	8b 40 04             	mov    0x4(%eax),%eax
    22d7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    22da:	7f 0c                	jg     22e8 <APDrawRect+0x194>
    22dc:	8b 45 08             	mov    0x8(%ebp),%eax
    22df:	8b 40 04             	mov    0x4(%eax),%eax
    22e2:	83 e8 01             	sub    $0x1,%eax
    22e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    22e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    22ef:	8b 45 0c             	mov    0xc(%ebp),%eax
    22f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    22f5:	eb 52                	jmp    2349 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    22f7:	8b 45 10             	mov    0x10(%ebp),%eax
    22fa:	89 45 e8             	mov    %eax,-0x18(%ebp)
    22fd:	eb 3e                	jmp    233d <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    22ff:	83 ec 04             	sub    $0x4,%esp
    2302:	ff 75 e8             	pushl  -0x18(%ebp)
    2305:	ff 75 ec             	pushl  -0x14(%ebp)
    2308:	ff 75 08             	pushl  0x8(%ebp)
    230b:	e8 c0 f6 ff ff       	call   19d0 <APGetIndex>
    2310:	83 c4 10             	add    $0x10,%esp
    2313:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    2316:	8b 45 08             	mov    0x8(%ebp),%eax
    2319:	8b 48 18             	mov    0x18(%eax),%ecx
    231c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    231f:	89 d0                	mov    %edx,%eax
    2321:	01 c0                	add    %eax,%eax
    2323:	01 d0                	add    %edx,%eax
    2325:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    2328:	8b 45 08             	mov    0x8(%ebp),%eax
    232b:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    232f:	66 89 0a             	mov    %cx,(%edx)
    2332:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    2336:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    2339:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    233d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2340:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    2343:	7e ba                	jle    22ff <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    2345:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2349:	8b 45 ec             	mov    -0x14(%ebp),%eax
    234c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    234f:	7e a6                	jle    22f7 <APDrawRect+0x1a3>
    2351:	eb 01                	jmp    2354 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    2353:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    2354:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2357:	c9                   	leave  
    2358:	c3                   	ret    

00002359 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    2359:	55                   	push   %ebp
    235a:	89 e5                	mov    %esp,%ebp
    235c:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    235f:	83 ec 0c             	sub    $0xc,%esp
    2362:	ff 75 0c             	pushl  0xc(%ebp)
    2365:	e8 b1 ee ff ff       	call   121b <strlen>
    236a:	83 c4 10             	add    $0x10,%esp
    236d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    2370:	8b 45 08             	mov    0x8(%ebp),%eax
    2373:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    2377:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    237b:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    237f:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    2382:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    2389:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2390:	e9 bc 00 00 00       	jmp    2451 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    2395:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2398:	8b 45 0c             	mov    0xc(%ebp),%eax
    239b:	01 d0                	add    %edx,%eax
    239d:	0f b6 00             	movzbl (%eax),%eax
    23a0:	0f be c0             	movsbl %al,%eax
    23a3:	83 e8 20             	sub    $0x20,%eax
    23a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    23a9:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    23ad:	0f 87 9a 00 00 00    	ja     244d <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    23b3:	8b 45 08             	mov    0x8(%ebp),%eax
    23b6:	8b 00                	mov    (%eax),%eax
    23b8:	0f af 45 14          	imul   0x14(%ebp),%eax
    23bc:	89 c2                	mov    %eax,%edx
    23be:	8b 45 10             	mov    0x10(%ebp),%eax
    23c1:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    23c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    23c7:	89 d0                	mov    %edx,%eax
    23c9:	c1 e0 03             	shl    $0x3,%eax
    23cc:	01 d0                	add    %edx,%eax
    23ce:	01 c8                	add    %ecx,%eax
    23d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    23d3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    23da:	eb 6b                	jmp    2447 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    23dc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    23e3:	eb 50                	jmp    2435 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    23e5:	8b 55 ec             	mov    -0x14(%ebp),%edx
    23e8:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    23eb:	89 d0                	mov    %edx,%eax
    23ed:	c1 e0 03             	shl    $0x3,%eax
    23f0:	01 d0                	add    %edx,%eax
    23f2:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    23f8:	01 c2                	add    %eax,%edx
    23fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
    23fd:	01 d0                	add    %edx,%eax
    23ff:	05 a0 41 00 00       	add    $0x41a0,%eax
    2404:	0f b6 00             	movzbl (%eax),%eax
    2407:	84 c0                	test   %al,%al
    2409:	74 26                	je     2431 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    240b:	8b 45 08             	mov    0x8(%ebp),%eax
    240e:	8b 50 18             	mov    0x18(%eax),%edx
    2411:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    2414:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2417:	01 c8                	add    %ecx,%eax
    2419:	89 c1                	mov    %eax,%ecx
    241b:	89 c8                	mov    %ecx,%eax
    241d:	01 c0                	add    %eax,%eax
    241f:	01 c8                	add    %ecx,%eax
    2421:	01 d0                	add    %edx,%eax
    2423:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    2427:	66 89 10             	mov    %dx,(%eax)
    242a:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    242e:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    2431:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    2435:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    2439:	7e aa                	jle    23e5 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    243b:	8b 45 08             	mov    0x8(%ebp),%eax
    243e:	8b 00                	mov    (%eax),%eax
    2440:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    2443:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2447:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    244b:	7e 8f                	jle    23dc <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    244d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2451:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2454:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    2457:	0f 82 38 ff ff ff    	jb     2395 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    245d:	90                   	nop
    245e:	c9                   	leave  
    245f:	c3                   	ret    

00002460 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    2460:	55                   	push   %ebp
    2461:	89 e5                	mov    %esp,%ebp
    2463:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    2466:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    246a:	0f 88 8e 01 00 00    	js     25fe <APDcCopy+0x19e>
    2470:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    2474:	0f 88 84 01 00 00    	js     25fe <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    247a:	8b 55 0c             	mov    0xc(%ebp),%edx
    247d:	8b 45 20             	mov    0x20(%ebp),%eax
    2480:	01 d0                	add    %edx,%eax
    2482:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2485:	8b 55 10             	mov    0x10(%ebp),%edx
    2488:	8b 45 24             	mov    0x24(%ebp),%eax
    248b:	01 d0                	add    %edx,%eax
    248d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    2490:	8b 55 18             	mov    0x18(%ebp),%edx
    2493:	8b 45 20             	mov    0x20(%ebp),%eax
    2496:	01 d0                	add    %edx,%eax
    2498:	89 45 ec             	mov    %eax,-0x14(%ebp)
    249b:	8b 55 1c             	mov    0x1c(%ebp),%edx
    249e:	8b 45 24             	mov    0x24(%ebp),%eax
    24a1:	01 d0                	add    %edx,%eax
    24a3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    24a6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    24aa:	0f 88 51 01 00 00    	js     2601 <APDcCopy+0x1a1>
    24b0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    24b4:	0f 88 47 01 00 00    	js     2601 <APDcCopy+0x1a1>
    24ba:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    24be:	0f 88 3d 01 00 00    	js     2601 <APDcCopy+0x1a1>
    24c4:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    24c8:	0f 88 33 01 00 00    	js     2601 <APDcCopy+0x1a1>
    24ce:	8b 45 14             	mov    0x14(%ebp),%eax
    24d1:	8b 00                	mov    (%eax),%eax
    24d3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    24d6:	0f 8c 25 01 00 00    	jl     2601 <APDcCopy+0x1a1>
    24dc:	8b 45 14             	mov    0x14(%ebp),%eax
    24df:	8b 40 04             	mov    0x4(%eax),%eax
    24e2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    24e5:	0f 8c 16 01 00 00    	jl     2601 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    24eb:	8b 45 08             	mov    0x8(%ebp),%eax
    24ee:	8b 00                	mov    (%eax),%eax
    24f0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    24f3:	7f 0b                	jg     2500 <APDcCopy+0xa0>
    24f5:	8b 45 08             	mov    0x8(%ebp),%eax
    24f8:	8b 00                	mov    (%eax),%eax
    24fa:	83 e8 01             	sub    $0x1,%eax
    24fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    2500:	8b 45 08             	mov    0x8(%ebp),%eax
    2503:	8b 40 04             	mov    0x4(%eax),%eax
    2506:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2509:	7f 0c                	jg     2517 <APDcCopy+0xb7>
    250b:	8b 45 08             	mov    0x8(%ebp),%eax
    250e:	8b 40 04             	mov    0x4(%eax),%eax
    2511:	83 e8 01             	sub    $0x1,%eax
    2514:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    2517:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    251e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    2525:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    252c:	e9 bc 00 00 00       	jmp    25ed <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    2531:	8b 45 08             	mov    0x8(%ebp),%eax
    2534:	8b 00                	mov    (%eax),%eax
    2536:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2539:	8b 55 10             	mov    0x10(%ebp),%edx
    253c:	01 ca                	add    %ecx,%edx
    253e:	0f af d0             	imul   %eax,%edx
    2541:	8b 45 0c             	mov    0xc(%ebp),%eax
    2544:	01 d0                	add    %edx,%eax
    2546:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    2549:	8b 45 14             	mov    0x14(%ebp),%eax
    254c:	8b 00                	mov    (%eax),%eax
    254e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2551:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2554:	01 ca                	add    %ecx,%edx
    2556:	0f af d0             	imul   %eax,%edx
    2559:	8b 45 18             	mov    0x18(%ebp),%eax
    255c:	01 d0                	add    %edx,%eax
    255e:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    2561:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2568:	eb 74                	jmp    25de <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    256a:	8b 45 14             	mov    0x14(%ebp),%eax
    256d:	8b 50 18             	mov    0x18(%eax),%edx
    2570:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    2573:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2576:	01 c8                	add    %ecx,%eax
    2578:	89 c1                	mov    %eax,%ecx
    257a:	89 c8                	mov    %ecx,%eax
    257c:	01 c0                	add    %eax,%eax
    257e:	01 c8                	add    %ecx,%eax
    2580:	01 d0                	add    %edx,%eax
    2582:	0f b7 10             	movzwl (%eax),%edx
    2585:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    2589:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    258d:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    2590:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    2594:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    2598:	38 c2                	cmp    %al,%dl
    259a:	75 18                	jne    25b4 <APDcCopy+0x154>
    259c:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    25a0:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    25a4:	38 c2                	cmp    %al,%dl
    25a6:	75 0c                	jne    25b4 <APDcCopy+0x154>
    25a8:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    25ac:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    25b0:	38 c2                	cmp    %al,%dl
    25b2:	74 26                	je     25da <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    25b4:	8b 45 08             	mov    0x8(%ebp),%eax
    25b7:	8b 50 18             	mov    0x18(%eax),%edx
    25ba:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    25bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    25c0:	01 c8                	add    %ecx,%eax
    25c2:	89 c1                	mov    %eax,%ecx
    25c4:	89 c8                	mov    %ecx,%eax
    25c6:	01 c0                	add    %eax,%eax
    25c8:	01 c8                	add    %ecx,%eax
    25ca:	01 d0                	add    %edx,%eax
    25cc:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    25d0:	66 89 10             	mov    %dx,(%eax)
    25d3:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    25d7:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    25da:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    25de:	8b 45 fc             	mov    -0x4(%ebp),%eax
    25e1:	2b 45 0c             	sub    0xc(%ebp),%eax
    25e4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    25e7:	7d 81                	jge    256a <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    25e9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    25ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
    25f0:	2b 45 10             	sub    0x10(%ebp),%eax
    25f3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    25f6:	0f 8d 35 ff ff ff    	jge    2531 <APDcCopy+0xd1>
    25fc:	eb 04                	jmp    2602 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    25fe:	90                   	nop
    25ff:	eb 01                	jmp    2602 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    2601:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    2602:	c9                   	leave  
    2603:	c3                   	ret    

00002604 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    2604:	55                   	push   %ebp
    2605:	89 e5                	mov    %esp,%ebp
    2607:	83 ec 1c             	sub    $0x1c,%esp
    260a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    260d:	8b 55 10             	mov    0x10(%ebp),%edx
    2610:	8b 45 14             	mov    0x14(%ebp),%eax
    2613:	88 4d ec             	mov    %cl,-0x14(%ebp)
    2616:	88 55 e8             	mov    %dl,-0x18(%ebp)
    2619:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    261c:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    2620:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    2623:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    2627:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    262a:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    262e:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    2631:	8b 45 08             	mov    0x8(%ebp),%eax
    2634:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    2638:	66 89 10             	mov    %dx,(%eax)
    263b:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    263f:	88 50 02             	mov    %dl,0x2(%eax)
}
    2642:	8b 45 08             	mov    0x8(%ebp),%eax
    2645:	c9                   	leave  
    2646:	c2 04 00             	ret    $0x4

00002649 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    2649:	55                   	push   %ebp
    264a:	89 e5                	mov    %esp,%ebp
    264c:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    264f:	8b 45 08             	mov    0x8(%ebp),%eax
    2652:	8b 00                	mov    (%eax),%eax
    2654:	83 ec 08             	sub    $0x8,%esp
    2657:	8d 55 0c             	lea    0xc(%ebp),%edx
    265a:	52                   	push   %edx
    265b:	50                   	push   %eax
    265c:	e8 24 ee ff ff       	call   1485 <sendMessage>
    2661:	83 c4 10             	add    $0x10,%esp
}
    2664:	90                   	nop
    2665:	c9                   	leave  
    2666:	c3                   	ret    

00002667 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    2667:	55                   	push   %ebp
    2668:	89 e5                	mov    %esp,%ebp
    266a:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    266d:	83 ec 0c             	sub    $0xc,%esp
    2670:	68 9c 00 00 00       	push   $0x9c
    2675:	e8 f5 f1 ff ff       	call   186f <malloc>
    267a:	83 c4 10             	add    $0x10,%esp
    267d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    2680:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2684:	75 15                	jne    269b <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    2686:	83 ec 04             	sub    $0x4,%esp
    2689:	ff 75 08             	pushl  0x8(%ebp)
    268c:	68 f4 38 00 00       	push   $0x38f4
    2691:	6a 01                	push   $0x1
    2693:	e8 04 ef ff ff       	call   159c <printf>
    2698:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    269b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    269e:	05 88 00 00 00       	add    $0x88,%eax
    26a3:	83 ec 08             	sub    $0x8,%esp
    26a6:	ff 75 08             	pushl  0x8(%ebp)
    26a9:	50                   	push   %eax
    26aa:	e8 fd ea ff ff       	call   11ac <strcpy>
    26af:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    26b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26b5:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    26bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26bf:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    26c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26c9:	8b 40 3c             	mov    0x3c(%eax),%eax
    26cc:	89 c2                	mov    %eax,%edx
    26ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26d1:	8b 40 40             	mov    0x40(%eax),%eax
    26d4:	0f af d0             	imul   %eax,%edx
    26d7:	89 d0                	mov    %edx,%eax
    26d9:	01 c0                	add    %eax,%eax
    26db:	01 d0                	add    %edx,%eax
    26dd:	83 ec 0c             	sub    $0xc,%esp
    26e0:	50                   	push   %eax
    26e1:	e8 89 f1 ff ff       	call   186f <malloc>
    26e6:	83 c4 10             	add    $0x10,%esp
    26e9:	89 c2                	mov    %eax,%edx
    26eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26ee:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    26f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26f4:	8b 40 54             	mov    0x54(%eax),%eax
    26f7:	85 c0                	test   %eax,%eax
    26f9:	75 15                	jne    2710 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    26fb:	83 ec 04             	sub    $0x4,%esp
    26fe:	ff 75 08             	pushl  0x8(%ebp)
    2701:	68 14 39 00 00       	push   $0x3914
    2706:	6a 01                	push   $0x1
    2708:	e8 8f ee ff ff       	call   159c <printf>
    270d:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    2710:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2713:	8b 40 3c             	mov    0x3c(%eax),%eax
    2716:	89 c2                	mov    %eax,%edx
    2718:	8b 45 f4             	mov    -0xc(%ebp),%eax
    271b:	8b 40 40             	mov    0x40(%eax),%eax
    271e:	0f af d0             	imul   %eax,%edx
    2721:	89 d0                	mov    %edx,%eax
    2723:	01 c0                	add    %eax,%eax
    2725:	01 c2                	add    %eax,%edx
    2727:	8b 45 f4             	mov    -0xc(%ebp),%eax
    272a:	8b 40 54             	mov    0x54(%eax),%eax
    272d:	83 ec 04             	sub    $0x4,%esp
    2730:	52                   	push   %edx
    2731:	68 ff ff ff 00       	push   $0xffffff
    2736:	50                   	push   %eax
    2737:	e8 06 eb ff ff       	call   1242 <memset>
    273c:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    273f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2742:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    2749:	e8 0f ed ff ff       	call   145d <getpid>
    274e:	89 c2                	mov    %eax,%edx
    2750:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2753:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    2756:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2759:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    2760:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2763:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    276a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    276d:	8b 40 58             	mov    0x58(%eax),%eax
    2770:	89 c2                	mov    %eax,%edx
    2772:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2775:	8b 40 5c             	mov    0x5c(%eax),%eax
    2778:	0f af d0             	imul   %eax,%edx
    277b:	89 d0                	mov    %edx,%eax
    277d:	01 c0                	add    %eax,%eax
    277f:	01 d0                	add    %edx,%eax
    2781:	83 ec 0c             	sub    $0xc,%esp
    2784:	50                   	push   %eax
    2785:	e8 e5 f0 ff ff       	call   186f <malloc>
    278a:	83 c4 10             	add    $0x10,%esp
    278d:	89 c2                	mov    %eax,%edx
    278f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2792:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    2795:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2798:	8b 40 70             	mov    0x70(%eax),%eax
    279b:	85 c0                	test   %eax,%eax
    279d:	75 15                	jne    27b4 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    279f:	83 ec 04             	sub    $0x4,%esp
    27a2:	ff 75 08             	pushl  0x8(%ebp)
    27a5:	68 38 39 00 00       	push   $0x3938
    27aa:	6a 01                	push   $0x1
    27ac:	e8 eb ed ff ff       	call   159c <printf>
    27b1:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    27b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27b7:	8b 40 3c             	mov    0x3c(%eax),%eax
    27ba:	89 c2                	mov    %eax,%edx
    27bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27bf:	8b 40 40             	mov    0x40(%eax),%eax
    27c2:	0f af d0             	imul   %eax,%edx
    27c5:	89 d0                	mov    %edx,%eax
    27c7:	01 c0                	add    %eax,%eax
    27c9:	01 c2                	add    %eax,%edx
    27cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27ce:	8b 40 54             	mov    0x54(%eax),%eax
    27d1:	83 ec 04             	sub    $0x4,%esp
    27d4:	52                   	push   %edx
    27d5:	68 ff 00 00 00       	push   $0xff
    27da:	50                   	push   %eax
    27db:	e8 62 ea ff ff       	call   1242 <memset>
    27e0:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    27e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27e6:	8b 55 0c             	mov    0xc(%ebp),%edx
    27e9:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    27ec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    27f0:	74 49                	je     283b <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    27f2:	8b 45 10             	mov    0x10(%ebp),%eax
    27f5:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    27fb:	83 ec 0c             	sub    $0xc,%esp
    27fe:	50                   	push   %eax
    27ff:	e8 6b f0 ff ff       	call   186f <malloc>
    2804:	83 c4 10             	add    $0x10,%esp
    2807:	89 c2                	mov    %eax,%edx
    2809:	8b 45 f4             	mov    -0xc(%ebp),%eax
    280c:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    280f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2812:	8b 55 10             	mov    0x10(%ebp),%edx
    2815:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    2818:	8b 45 f4             	mov    -0xc(%ebp),%eax
    281b:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    2822:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2825:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    282c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    282f:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    2836:	e9 8d 00 00 00       	jmp    28c8 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    283b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    283e:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    2845:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2848:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    284f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2852:	8b 40 20             	mov    0x20(%eax),%eax
    2855:	89 c2                	mov    %eax,%edx
    2857:	8b 45 f4             	mov    -0xc(%ebp),%eax
    285a:	8b 40 24             	mov    0x24(%eax),%eax
    285d:	0f af d0             	imul   %eax,%edx
    2860:	89 d0                	mov    %edx,%eax
    2862:	01 c0                	add    %eax,%eax
    2864:	01 d0                	add    %edx,%eax
    2866:	83 ec 0c             	sub    $0xc,%esp
    2869:	50                   	push   %eax
    286a:	e8 00 f0 ff ff       	call   186f <malloc>
    286f:	83 c4 10             	add    $0x10,%esp
    2872:	89 c2                	mov    %eax,%edx
    2874:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2877:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    287a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    287d:	8b 40 38             	mov    0x38(%eax),%eax
    2880:	85 c0                	test   %eax,%eax
    2882:	75 15                	jne    2899 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    2884:	83 ec 04             	sub    $0x4,%esp
    2887:	ff 75 08             	pushl  0x8(%ebp)
    288a:	68 60 39 00 00       	push   $0x3960
    288f:	6a 01                	push   $0x1
    2891:	e8 06 ed ff ff       	call   159c <printf>
    2896:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    2899:	8b 45 f4             	mov    -0xc(%ebp),%eax
    289c:	8b 40 20             	mov    0x20(%eax),%eax
    289f:	89 c2                	mov    %eax,%edx
    28a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28a4:	8b 40 24             	mov    0x24(%eax),%eax
    28a7:	0f af d0             	imul   %eax,%edx
    28aa:	89 d0                	mov    %edx,%eax
    28ac:	01 c0                	add    %eax,%eax
    28ae:	01 c2                	add    %eax,%edx
    28b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28b3:	8b 40 38             	mov    0x38(%eax),%eax
    28b6:	83 ec 04             	sub    $0x4,%esp
    28b9:	52                   	push   %edx
    28ba:	68 ff ff ff 00       	push   $0xffffff
    28bf:	50                   	push   %eax
    28c0:	e8 7d e9 ff ff       	call   1242 <memset>
    28c5:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    28c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    28cb:	c9                   	leave  
    28cc:	c3                   	ret    

000028cd <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    28cd:	55                   	push   %ebp
    28ce:	89 e5                	mov    %esp,%ebp
    28d0:	57                   	push   %edi
    28d1:	56                   	push   %esi
    28d2:	53                   	push   %ebx
    28d3:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    28d6:	8b 45 0c             	mov    0xc(%ebp),%eax
    28d9:	83 f8 03             	cmp    $0x3,%eax
    28dc:	74 0e                	je     28ec <APWndProc+0x1f>
    28de:	83 f8 0a             	cmp    $0xa,%eax
    28e1:	0f 84 82 00 00 00    	je     2969 <APWndProc+0x9c>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            break;
        default: break;
    28e7:	e9 cb 00 00 00       	jmp    29b7 <APWndProc+0xea>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    28ec:	8b 45 08             	mov    0x8(%ebp),%eax
    28ef:	8b 58 1c             	mov    0x1c(%eax),%ebx
    28f2:	8b 45 08             	mov    0x8(%ebp),%eax
    28f5:	8b 48 18             	mov    0x18(%eax),%ecx
    28f8:	8b 45 08             	mov    0x8(%ebp),%eax
    28fb:	8b 50 5c             	mov    0x5c(%eax),%edx
    28fe:	8b 45 08             	mov    0x8(%ebp),%eax
    2901:	8b 40 58             	mov    0x58(%eax),%eax
    2904:	8b 75 08             	mov    0x8(%ebp),%esi
    2907:	83 c6 58             	add    $0x58,%esi
    290a:	83 ec 04             	sub    $0x4,%esp
    290d:	53                   	push   %ebx
    290e:	51                   	push   %ecx
    290f:	6a 00                	push   $0x0
    2911:	52                   	push   %edx
    2912:	50                   	push   %eax
    2913:	6a 00                	push   $0x0
    2915:	6a 00                	push   $0x0
    2917:	56                   	push   %esi
    2918:	6a 00                	push   $0x0
    291a:	6a 00                	push   $0x0
    291c:	ff 75 08             	pushl  0x8(%ebp)
    291f:	e8 59 eb ff ff       	call   147d <paintWindow>
    2924:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    2927:	8b 45 08             	mov    0x8(%ebp),%eax
    292a:	8b 70 1c             	mov    0x1c(%eax),%esi
    292d:	8b 45 08             	mov    0x8(%ebp),%eax
    2930:	8b 58 18             	mov    0x18(%eax),%ebx
    2933:	8b 45 08             	mov    0x8(%ebp),%eax
    2936:	8b 48 08             	mov    0x8(%eax),%ecx
    2939:	8b 45 08             	mov    0x8(%ebp),%eax
    293c:	8b 50 40             	mov    0x40(%eax),%edx
    293f:	8b 45 08             	mov    0x8(%ebp),%eax
    2942:	8b 40 3c             	mov    0x3c(%eax),%eax
    2945:	8b 7d 08             	mov    0x8(%ebp),%edi
    2948:	83 c7 3c             	add    $0x3c,%edi
    294b:	83 ec 04             	sub    $0x4,%esp
    294e:	56                   	push   %esi
    294f:	53                   	push   %ebx
    2950:	51                   	push   %ecx
    2951:	52                   	push   %edx
    2952:	50                   	push   %eax
    2953:	6a 00                	push   $0x0
    2955:	6a 00                	push   $0x0
    2957:	57                   	push   %edi
    2958:	6a 32                	push   $0x32
    295a:	6a 00                	push   $0x0
    295c:	ff 75 08             	pushl  0x8(%ebp)
    295f:	e8 19 eb ff ff       	call   147d <paintWindow>
    2964:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    2967:	eb 4e                	jmp    29b7 <APWndProc+0xea>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
    2969:	8b 45 18             	mov    0x18(%ebp),%eax
    296c:	83 ec 08             	sub    $0x8,%esp
    296f:	50                   	push   %eax
    2970:	ff 75 08             	pushl  0x8(%ebp)
    2973:	e8 c5 08 00 00       	call   323d <updateword>
    2978:	83 c4 10             	add    $0x10,%esp
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    297b:	8b 45 08             	mov    0x8(%ebp),%eax
    297e:	8b 58 1c             	mov    0x1c(%eax),%ebx
    2981:	8b 45 08             	mov    0x8(%ebp),%eax
    2984:	8b 48 18             	mov    0x18(%eax),%ecx
    2987:	8b 45 08             	mov    0x8(%ebp),%eax
    298a:	8b 50 5c             	mov    0x5c(%eax),%edx
    298d:	8b 45 08             	mov    0x8(%ebp),%eax
    2990:	8b 40 58             	mov    0x58(%eax),%eax
    2993:	8b 75 08             	mov    0x8(%ebp),%esi
    2996:	83 c6 58             	add    $0x58,%esi
    2999:	83 ec 04             	sub    $0x4,%esp
    299c:	53                   	push   %ebx
    299d:	51                   	push   %ecx
    299e:	6a 00                	push   $0x0
    29a0:	52                   	push   %edx
    29a1:	50                   	push   %eax
    29a2:	6a 00                	push   $0x0
    29a4:	6a 00                	push   $0x0
    29a6:	56                   	push   %esi
    29a7:	6a 00                	push   $0x0
    29a9:	6a 00                	push   $0x0
    29ab:	ff 75 08             	pushl  0x8(%ebp)
    29ae:	e8 ca ea ff ff       	call   147d <paintWindow>
    29b3:	83 c4 30             	add    $0x30,%esp
            break;
    29b6:	90                   	nop
        default: break;
            
            
    }
    return False;
    29b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
    29bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    29bf:	5b                   	pop    %ebx
    29c0:	5e                   	pop    %esi
    29c1:	5f                   	pop    %edi
    29c2:	5d                   	pop    %ebp
    29c3:	c3                   	ret    

000029c4 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    29c4:	55                   	push   %ebp
    29c5:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    29c7:	8b 45 0c             	mov    0xc(%ebp),%eax
    29ca:	8b 50 08             	mov    0x8(%eax),%edx
    29cd:	8b 45 08             	mov    0x8(%ebp),%eax
    29d0:	8b 00                	mov    (%eax),%eax
    29d2:	39 c2                	cmp    %eax,%edx
    29d4:	74 07                	je     29dd <APPreJudge+0x19>
        return False;
    29d6:	b8 00 00 00 00       	mov    $0x0,%eax
    29db:	eb 05                	jmp    29e2 <APPreJudge+0x1e>
    return True;
    29dd:	b8 01 00 00 00       	mov    $0x1,%eax
}
    29e2:	5d                   	pop    %ebp
    29e3:	c3                   	ret    

000029e4 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    29e4:	55                   	push   %ebp
    29e5:	89 e5                	mov    %esp,%ebp
    29e7:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    29ea:	8b 45 08             	mov    0x8(%ebp),%eax
    29ed:	8b 55 0c             	mov    0xc(%ebp),%edx
    29f0:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
    //--------add window to list
    registWindow(hwnd);
    29f6:	83 ec 0c             	sub    $0xc,%esp
    29f9:	ff 75 08             	pushl  0x8(%ebp)
    29fc:	e8 94 ea ff ff       	call   1495 <registWindow>
    2a01:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    2a04:	c7 45 e8 02 00 00 00 	movl   $0x2,-0x18(%ebp)
    msg.wndID = hwnd->id;
    2a0b:	8b 45 08             	mov    0x8(%ebp),%eax
    2a0e:	8b 00                	mov    (%eax),%eax
    2a10:	89 45 f0             	mov    %eax,-0x10(%ebp)
    APSendMessage(hwnd,msg);
    2a13:	83 ec 0c             	sub    $0xc,%esp
    2a16:	ff 75 f4             	pushl  -0xc(%ebp)
    2a19:	ff 75 f0             	pushl  -0x10(%ebp)
    2a1c:	ff 75 ec             	pushl  -0x14(%ebp)
    2a1f:	ff 75 e8             	pushl  -0x18(%ebp)
    2a22:	ff 75 08             	pushl  0x8(%ebp)
    2a25:	e8 1f fc ff ff       	call   2649 <APSendMessage>
    2a2a:	83 c4 20             	add    $0x20,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    2a2d:	83 ec 0c             	sub    $0xc,%esp
    2a30:	ff 75 08             	pushl  0x8(%ebp)
    2a33:	e8 55 ea ff ff       	call   148d <getMessage>
    2a38:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    2a3b:	8b 45 08             	mov    0x8(%ebp),%eax
    2a3e:	83 c0 74             	add    $0x74,%eax
    2a41:	83 ec 08             	sub    $0x8,%esp
    2a44:	50                   	push   %eax
    2a45:	ff 75 08             	pushl  0x8(%ebp)
    2a48:	e8 77 ff ff ff       	call   29c4 <APPreJudge>
    2a4d:	83 c4 10             	add    $0x10,%esp
    2a50:	84 c0                	test   %al,%al
    2a52:	74 24                	je     2a78 <APWndExec+0x94>
            if (wndProc(hwnd, hwnd->msg))
    2a54:	83 ec 0c             	sub    $0xc,%esp
    2a57:	8b 45 08             	mov    0x8(%ebp),%eax
    2a5a:	ff b0 80 00 00 00    	pushl  0x80(%eax)
    2a60:	ff 70 7c             	pushl  0x7c(%eax)
    2a63:	ff 70 78             	pushl  0x78(%eax)
    2a66:	ff 70 74             	pushl  0x74(%eax)
    2a69:	ff 75 08             	pushl  0x8(%ebp)
    2a6c:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a6f:	ff d0                	call   *%eax
    2a71:	83 c4 20             	add    $0x20,%esp
    2a74:	84 c0                	test   %al,%al
    2a76:	75 0c                	jne    2a84 <APWndExec+0xa0>
                break;
        hwnd->msg.type = MSG_NULL;
    2a78:	8b 45 08             	mov    0x8(%ebp),%eax
    2a7b:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    2a82:	eb a9                	jmp    2a2d <APWndExec+0x49>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    2a84:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    2a85:	90                   	nop
    2a86:	c9                   	leave  
    2a87:	c3                   	ret    

00002a88 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    2a88:	55                   	push   %ebp
    2a89:	89 e5                	mov    %esp,%ebp
    2a8b:	57                   	push   %edi
    2a8c:	56                   	push   %esi
    2a8d:	53                   	push   %ebx
    2a8e:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    2a91:	a1 f0 7d 00 00       	mov    0x7df0,%eax
    2a96:	85 c0                	test   %eax,%eax
    2a98:	0f 85 c8 02 00 00    	jne    2d66 <APGridPaint+0x2de>
    {
        iconReady = 1;
    2a9e:	c7 05 f0 7d 00 00 01 	movl   $0x1,0x7df0
    2aa5:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    2aa8:	8d 45 98             	lea    -0x68(%ebp),%eax
    2aab:	83 ec 08             	sub    $0x8,%esp
    2aae:	68 87 39 00 00       	push   $0x3987
    2ab3:	50                   	push   %eax
    2ab4:	e8 69 ef ff ff       	call   1a22 <APLoadBitmap>
    2ab9:	83 c4 0c             	add    $0xc,%esp
    2abc:	8b 45 98             	mov    -0x68(%ebp),%eax
    2abf:	a3 90 7e 00 00       	mov    %eax,0x7e90
    2ac4:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2ac7:	a3 94 7e 00 00       	mov    %eax,0x7e94
    2acc:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2acf:	a3 98 7e 00 00       	mov    %eax,0x7e98
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    2ad4:	83 ec 04             	sub    $0x4,%esp
    2ad7:	ff 35 98 7e 00 00    	pushl  0x7e98
    2add:	ff 35 94 7e 00 00    	pushl  0x7e94
    2ae3:	ff 35 90 7e 00 00    	pushl  0x7e90
    2ae9:	e8 6e f1 ff ff       	call   1c5c <APCreateCompatibleDCFromBitmap>
    2aee:	83 c4 10             	add    $0x10,%esp
    2af1:	a3 9c 7e 00 00       	mov    %eax,0x7e9c
        grid_river = APLoadBitmap ("grid_river.bmp");
    2af6:	8d 45 98             	lea    -0x68(%ebp),%eax
    2af9:	83 ec 08             	sub    $0x8,%esp
    2afc:	68 95 39 00 00       	push   $0x3995
    2b01:	50                   	push   %eax
    2b02:	e8 1b ef ff ff       	call   1a22 <APLoadBitmap>
    2b07:	83 c4 0c             	add    $0xc,%esp
    2b0a:	8b 45 98             	mov    -0x68(%ebp),%eax
    2b0d:	a3 00 7f 00 00       	mov    %eax,0x7f00
    2b12:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2b15:	a3 04 7f 00 00       	mov    %eax,0x7f04
    2b1a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2b1d:	a3 08 7f 00 00       	mov    %eax,0x7f08
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    2b22:	83 ec 04             	sub    $0x4,%esp
    2b25:	ff 35 08 7f 00 00    	pushl  0x7f08
    2b2b:	ff 35 04 7f 00 00    	pushl  0x7f04
    2b31:	ff 35 00 7f 00 00    	pushl  0x7f00
    2b37:	e8 20 f1 ff ff       	call   1c5c <APCreateCompatibleDCFromBitmap>
    2b3c:	83 c4 10             	add    $0x10,%esp
    2b3f:	a3 f0 7e 00 00       	mov    %eax,0x7ef0
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    2b44:	8d 45 98             	lea    -0x68(%ebp),%eax
    2b47:	83 ec 08             	sub    $0x8,%esp
    2b4a:	68 a4 39 00 00       	push   $0x39a4
    2b4f:	50                   	push   %eax
    2b50:	e8 cd ee ff ff       	call   1a22 <APLoadBitmap>
    2b55:	83 c4 0c             	add    $0xc,%esp
    2b58:	8b 45 98             	mov    -0x68(%ebp),%eax
    2b5b:	a3 f4 7e 00 00       	mov    %eax,0x7ef4
    2b60:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2b63:	a3 f8 7e 00 00       	mov    %eax,0x7ef8
    2b68:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2b6b:	a3 fc 7e 00 00       	mov    %eax,0x7efc
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    2b70:	83 ec 04             	sub    $0x4,%esp
    2b73:	ff 35 fc 7e 00 00    	pushl  0x7efc
    2b79:	ff 35 f8 7e 00 00    	pushl  0x7ef8
    2b7f:	ff 35 f4 7e 00 00    	pushl  0x7ef4
    2b85:	e8 d2 f0 ff ff       	call   1c5c <APCreateCompatibleDCFromBitmap>
    2b8a:	83 c4 10             	add    $0x10,%esp
    2b8d:	a3 14 7e 00 00       	mov    %eax,0x7e14
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    2b92:	8d 45 98             	lea    -0x68(%ebp),%eax
    2b95:	83 ec 08             	sub    $0x8,%esp
    2b98:	68 b3 39 00 00       	push   $0x39b3
    2b9d:	50                   	push   %eax
    2b9e:	e8 7f ee ff ff       	call   1a22 <APLoadBitmap>
    2ba3:	83 c4 0c             	add    $0xc,%esp
    2ba6:	8b 45 98             	mov    -0x68(%ebp),%eax
    2ba9:	a3 28 7e 00 00       	mov    %eax,0x7e28
    2bae:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2bb1:	a3 2c 7e 00 00       	mov    %eax,0x7e2c
    2bb6:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2bb9:	a3 30 7e 00 00       	mov    %eax,0x7e30
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    2bbe:	83 ec 04             	sub    $0x4,%esp
    2bc1:	ff 35 30 7e 00 00    	pushl  0x7e30
    2bc7:	ff 35 2c 7e 00 00    	pushl  0x7e2c
    2bcd:	ff 35 28 7e 00 00    	pushl  0x7e28
    2bd3:	e8 84 f0 ff ff       	call   1c5c <APCreateCompatibleDCFromBitmap>
    2bd8:	83 c4 10             	add    $0x10,%esp
    2bdb:	a3 8c 7e 00 00       	mov    %eax,0x7e8c
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    2be0:	8d 45 98             	lea    -0x68(%ebp),%eax
    2be3:	83 ec 08             	sub    $0x8,%esp
    2be6:	68 c5 39 00 00       	push   $0x39c5
    2beb:	50                   	push   %eax
    2bec:	e8 31 ee ff ff       	call   1a22 <APLoadBitmap>
    2bf1:	83 c4 0c             	add    $0xc,%esp
    2bf4:	8b 45 98             	mov    -0x68(%ebp),%eax
    2bf7:	a3 b4 7e 00 00       	mov    %eax,0x7eb4
    2bfc:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2bff:	a3 b8 7e 00 00       	mov    %eax,0x7eb8
    2c04:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2c07:	a3 bc 7e 00 00       	mov    %eax,0x7ebc
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    2c0c:	83 ec 04             	sub    $0x4,%esp
    2c0f:	ff 35 bc 7e 00 00    	pushl  0x7ebc
    2c15:	ff 35 b8 7e 00 00    	pushl  0x7eb8
    2c1b:	ff 35 b4 7e 00 00    	pushl  0x7eb4
    2c21:	e8 36 f0 ff ff       	call   1c5c <APCreateCompatibleDCFromBitmap>
    2c26:	83 c4 10             	add    $0x10,%esp
    2c29:	a3 34 7f 00 00       	mov    %eax,0x7f34
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    2c2e:	8d 45 98             	lea    -0x68(%ebp),%eax
    2c31:	83 ec 08             	sub    $0x8,%esp
    2c34:	68 d3 39 00 00       	push   $0x39d3
    2c39:	50                   	push   %eax
    2c3a:	e8 e3 ed ff ff       	call   1a22 <APLoadBitmap>
    2c3f:	83 c4 0c             	add    $0xc,%esp
    2c42:	8b 45 98             	mov    -0x68(%ebp),%eax
    2c45:	a3 80 7e 00 00       	mov    %eax,0x7e80
    2c4a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2c4d:	a3 84 7e 00 00       	mov    %eax,0x7e84
    2c52:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2c55:	a3 88 7e 00 00       	mov    %eax,0x7e88
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    2c5a:	83 ec 04             	sub    $0x4,%esp
    2c5d:	ff 35 88 7e 00 00    	pushl  0x7e88
    2c63:	ff 35 84 7e 00 00    	pushl  0x7e84
    2c69:	ff 35 80 7e 00 00    	pushl  0x7e80
    2c6f:	e8 e8 ef ff ff       	call   1c5c <APCreateCompatibleDCFromBitmap>
    2c74:	83 c4 10             	add    $0x10,%esp
    2c77:	a3 ac 7e 00 00       	mov    %eax,0x7eac
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    2c7c:	8d 45 98             	lea    -0x68(%ebp),%eax
    2c7f:	83 ec 08             	sub    $0x8,%esp
    2c82:	68 e3 39 00 00       	push   $0x39e3
    2c87:	50                   	push   %eax
    2c88:	e8 95 ed ff ff       	call   1a22 <APLoadBitmap>
    2c8d:	83 c4 0c             	add    $0xc,%esp
    2c90:	8b 45 98             	mov    -0x68(%ebp),%eax
    2c93:	a3 e4 7e 00 00       	mov    %eax,0x7ee4
    2c98:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2c9b:	a3 e8 7e 00 00       	mov    %eax,0x7ee8
    2ca0:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2ca3:	a3 ec 7e 00 00       	mov    %eax,0x7eec
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    2ca8:	83 ec 04             	sub    $0x4,%esp
    2cab:	ff 35 ec 7e 00 00    	pushl  0x7eec
    2cb1:	ff 35 e8 7e 00 00    	pushl  0x7ee8
    2cb7:	ff 35 e4 7e 00 00    	pushl  0x7ee4
    2cbd:	e8 9a ef ff ff       	call   1c5c <APCreateCompatibleDCFromBitmap>
    2cc2:	83 c4 10             	add    $0x10,%esp
    2cc5:	a3 1c 84 00 00       	mov    %eax,0x841c
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    2cca:	8d 45 98             	lea    -0x68(%ebp),%eax
    2ccd:	83 ec 08             	sub    $0x8,%esp
    2cd0:	68 f2 39 00 00       	push   $0x39f2
    2cd5:	50                   	push   %eax
    2cd6:	e8 47 ed ff ff       	call   1a22 <APLoadBitmap>
    2cdb:	83 c4 0c             	add    $0xc,%esp
    2cde:	8b 45 98             	mov    -0x68(%ebp),%eax
    2ce1:	a3 c0 7e 00 00       	mov    %eax,0x7ec0
    2ce6:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2ce9:	a3 c4 7e 00 00       	mov    %eax,0x7ec4
    2cee:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2cf1:	a3 c8 7e 00 00       	mov    %eax,0x7ec8
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    2cf6:	83 ec 04             	sub    $0x4,%esp
    2cf9:	ff 35 c8 7e 00 00    	pushl  0x7ec8
    2cff:	ff 35 c4 7e 00 00    	pushl  0x7ec4
    2d05:	ff 35 c0 7e 00 00    	pushl  0x7ec0
    2d0b:	e8 4c ef ff ff       	call   1c5c <APCreateCompatibleDCFromBitmap>
    2d10:	83 c4 10             	add    $0x10,%esp
    2d13:	a3 18 7f 00 00       	mov    %eax,0x7f18
        grid_tower = APLoadBitmap ("grid_tower.bmp");
    2d18:	8d 45 98             	lea    -0x68(%ebp),%eax
    2d1b:	83 ec 08             	sub    $0x8,%esp
    2d1e:	68 01 3a 00 00       	push   $0x3a01
    2d23:	50                   	push   %eax
    2d24:	e8 f9 ec ff ff       	call   1a22 <APLoadBitmap>
    2d29:	83 c4 0c             	add    $0xc,%esp
    2d2c:	8b 45 98             	mov    -0x68(%ebp),%eax
    2d2f:	a3 48 7e 00 00       	mov    %eax,0x7e48
    2d34:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2d37:	a3 4c 7e 00 00       	mov    %eax,0x7e4c
    2d3c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2d3f:	a3 50 7e 00 00       	mov    %eax,0x7e50
        g_tower = APCreateCompatibleDCFromBitmap(grid_tower);
    2d44:	83 ec 04             	sub    $0x4,%esp
    2d47:	ff 35 50 7e 00 00    	pushl  0x7e50
    2d4d:	ff 35 4c 7e 00 00    	pushl  0x7e4c
    2d53:	ff 35 48 7e 00 00    	pushl  0x7e48
    2d59:	e8 fe ee ff ff       	call   1c5c <APCreateCompatibleDCFromBitmap>
    2d5e:	83 c4 10             	add    $0x10,%esp
    2d61:	a3 b0 7e 00 00       	mov    %eax,0x7eb0
   
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    2d66:	8b 45 08             	mov    0x8(%ebp),%eax
    2d69:	8b 40 08             	mov    0x8(%eax),%eax
    2d6c:	85 c0                	test   %eax,%eax
    2d6e:	75 17                	jne    2d87 <APGridPaint+0x2ff>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    2d70:	83 ec 08             	sub    $0x8,%esp
    2d73:	68 10 3a 00 00       	push   $0x3a10
    2d78:	6a 01                	push   $0x1
    2d7a:	e8 1d e8 ff ff       	call   159c <printf>
    2d7f:	83 c4 10             	add    $0x10,%esp
        return;
    2d82:	e9 ae 04 00 00       	jmp    3235 <APGridPaint+0x7ad>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    2d87:	8b 45 08             	mov    0x8(%ebp),%eax
    2d8a:	8b 40 10             	mov    0x10(%eax),%eax
    2d8d:	85 c0                	test   %eax,%eax
    2d8f:	7e 10                	jle    2da1 <APGridPaint+0x319>
    2d91:	8b 45 08             	mov    0x8(%ebp),%eax
    2d94:	8b 50 14             	mov    0x14(%eax),%edx
    2d97:	8b 45 08             	mov    0x8(%ebp),%eax
    2d9a:	8b 40 10             	mov    0x10(%eax),%eax
    2d9d:	39 c2                	cmp    %eax,%edx
    2d9f:	7c 17                	jl     2db8 <APGridPaint+0x330>
    {
        printf(1,"Grid mode page error!");
    2da1:	83 ec 08             	sub    $0x8,%esp
    2da4:	68 36 3a 00 00       	push   $0x3a36
    2da9:	6a 01                	push   $0x1
    2dab:	e8 ec e7 ff ff       	call   159c <printf>
    2db0:	83 c4 10             	add    $0x10,%esp
        return;
    2db3:	e9 7d 04 00 00       	jmp    3235 <APGridPaint+0x7ad>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    2db8:	8b 45 08             	mov    0x8(%ebp),%eax
    2dbb:	8b 40 14             	mov    0x14(%eax),%eax
    2dbe:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    2dc4:	89 45 dc             	mov    %eax,-0x24(%ebp)
    2dc7:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2dca:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2dcd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    2dd4:	e9 52 04 00 00       	jmp    322b <APGridPaint+0x7a3>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2dd9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    2de0:	e9 38 04 00 00       	jmp    321d <APGridPaint+0x795>
        {
            index = start + GRID_W_NUMBER * j + i;
    2de5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2de8:	c1 e0 04             	shl    $0x4,%eax
    2deb:	89 c2                	mov    %eax,%edx
    2ded:	8b 45 d8             	mov    -0x28(%ebp),%eax
    2df0:	01 c2                	add    %eax,%edx
    2df2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2df5:	01 d0                	add    %edx,%eax
    2df7:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    2dfa:	8b 45 08             	mov    0x8(%ebp),%eax
    2dfd:	8b 40 0c             	mov    0xc(%eax),%eax
    2e00:	8b 55 dc             	mov    -0x24(%ebp),%edx
    2e03:	c1 e2 02             	shl    $0x2,%edx
    2e06:	01 d0                	add    %edx,%eax
    2e08:	8b 00                	mov    (%eax),%eax
    2e0a:	83 f8 0b             	cmp    $0xb,%eax
    2e0d:	0f 87 05 04 00 00    	ja     3218 <APGridPaint+0x790>
    2e13:	8b 04 85 4c 3a 00 00 	mov    0x3a4c(,%eax,4),%eax
    2e1a:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2e1c:	8d 45 bd             	lea    -0x43(%ebp),%eax
    2e1f:	6a 0c                	push   $0xc
    2e21:	6a 0c                	push   $0xc
    2e23:	6a 0c                	push   $0xc
    2e25:	50                   	push   %eax
    2e26:	e8 d9 f7 ff ff       	call   2604 <RGB>
    2e2b:	83 c4 0c             	add    $0xc,%esp
    2e2e:	8b 1d 9c 7e 00 00    	mov    0x7e9c,%ebx
    2e34:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2e37:	6b c8 32             	imul   $0x32,%eax,%ecx
    2e3a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2e3d:	6b c0 32             	imul   $0x32,%eax,%eax
    2e40:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2e43:	8b 45 08             	mov    0x8(%ebp),%eax
    2e46:	8d 78 3c             	lea    0x3c(%eax),%edi
    2e49:	83 ec 0c             	sub    $0xc,%esp
    2e4c:	83 ec 04             	sub    $0x4,%esp
    2e4f:	89 e0                	mov    %esp,%eax
    2e51:	0f b7 75 bd          	movzwl -0x43(%ebp),%esi
    2e55:	66 89 30             	mov    %si,(%eax)
    2e58:	0f b6 55 bf          	movzbl -0x41(%ebp),%edx
    2e5c:	88 50 02             	mov    %dl,0x2(%eax)
    2e5f:	6a 32                	push   $0x32
    2e61:	6a 32                	push   $0x32
    2e63:	6a 00                	push   $0x0
    2e65:	6a 00                	push   $0x0
    2e67:	53                   	push   %ebx
    2e68:	51                   	push   %ecx
    2e69:	ff 75 94             	pushl  -0x6c(%ebp)
    2e6c:	57                   	push   %edi
    2e6d:	e8 ee f5 ff ff       	call   2460 <APDcCopy>
    2e72:	83 c4 30             	add    $0x30,%esp
                    break;
    2e75:	e9 9f 03 00 00       	jmp    3219 <APGridPaint+0x791>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    2e7a:	8d 45 98             	lea    -0x68(%ebp),%eax
    2e7d:	6a 69                	push   $0x69
    2e7f:	6a 69                	push   $0x69
    2e81:	6a 69                	push   $0x69
    2e83:	50                   	push   %eax
    2e84:	e8 7b f7 ff ff       	call   2604 <RGB>
    2e89:	83 c4 0c             	add    $0xc,%esp
    2e8c:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2e90:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    2e94:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2e98:	88 45 b6             	mov    %al,-0x4a(%ebp)
                    pen.size = 1;
    2e9b:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    2ea2:	8d 45 98             	lea    -0x68(%ebp),%eax
    2ea5:	6a 69                	push   $0x69
    2ea7:	6a 69                	push   $0x69
    2ea9:	6a 69                	push   $0x69
    2eab:	50                   	push   %eax
    2eac:	e8 53 f7 ff ff       	call   2604 <RGB>
    2eb1:	83 c4 0c             	add    $0xc,%esp
    2eb4:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2eb8:	66 89 45 b1          	mov    %ax,-0x4f(%ebp)
    2ebc:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2ec0:	88 45 b3             	mov    %al,-0x4d(%ebp)
                    APSetPen(&wnd->Dc,pen);
    2ec3:	8b 45 08             	mov    0x8(%ebp),%eax
    2ec6:	8d 50 3c             	lea    0x3c(%eax),%edx
    2ec9:	8d 45 98             	lea    -0x68(%ebp),%eax
    2ecc:	ff 75 b8             	pushl  -0x48(%ebp)
    2ecf:	ff 75 b4             	pushl  -0x4c(%ebp)
    2ed2:	52                   	push   %edx
    2ed3:	50                   	push   %eax
    2ed4:	e8 18 ee ff ff       	call   1cf1 <APSetPen>
    2ed9:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    2edc:	8b 45 08             	mov    0x8(%ebp),%eax
    2edf:	8d 58 3c             	lea    0x3c(%eax),%ebx
    2ee2:	8d 55 98             	lea    -0x68(%ebp),%edx
    2ee5:	83 ec 04             	sub    $0x4,%esp
    2ee8:	83 ec 04             	sub    $0x4,%esp
    2eeb:	89 e0                	mov    %esp,%eax
    2eed:	0f b7 4d b1          	movzwl -0x4f(%ebp),%ecx
    2ef1:	66 89 08             	mov    %cx,(%eax)
    2ef4:	0f b6 4d b3          	movzbl -0x4d(%ebp),%ecx
    2ef8:	88 48 02             	mov    %cl,0x2(%eax)
    2efb:	53                   	push   %ebx
    2efc:	52                   	push   %edx
    2efd:	e8 28 ee ff ff       	call   1d2a <APSetBrush>
    2f02:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    2f05:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2f08:	6b d0 32             	imul   $0x32,%eax,%edx
    2f0b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2f0e:	6b c0 32             	imul   $0x32,%eax,%eax
    2f11:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2f14:	83 c1 3c             	add    $0x3c,%ecx
    2f17:	83 ec 0c             	sub    $0xc,%esp
    2f1a:	6a 32                	push   $0x32
    2f1c:	6a 32                	push   $0x32
    2f1e:	52                   	push   %edx
    2f1f:	50                   	push   %eax
    2f20:	51                   	push   %ecx
    2f21:	e8 2e f2 ff ff       	call   2154 <APDrawRect>
    2f26:	83 c4 20             	add    $0x20,%esp
                    break;
    2f29:	e9 eb 02 00 00       	jmp    3219 <APGridPaint+0x791>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2f2e:	8d 45 c0             	lea    -0x40(%ebp),%eax
    2f31:	6a 0c                	push   $0xc
    2f33:	6a 0c                	push   $0xc
    2f35:	6a 0c                	push   $0xc
    2f37:	50                   	push   %eax
    2f38:	e8 c7 f6 ff ff       	call   2604 <RGB>
    2f3d:	83 c4 0c             	add    $0xc,%esp
    2f40:	8b 1d 1c 84 00 00    	mov    0x841c,%ebx
    2f46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2f49:	6b c8 32             	imul   $0x32,%eax,%ecx
    2f4c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2f4f:	6b c0 32             	imul   $0x32,%eax,%eax
    2f52:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2f55:	8b 45 08             	mov    0x8(%ebp),%eax
    2f58:	8d 78 3c             	lea    0x3c(%eax),%edi
    2f5b:	83 ec 0c             	sub    $0xc,%esp
    2f5e:	83 ec 04             	sub    $0x4,%esp
    2f61:	89 e0                	mov    %esp,%eax
    2f63:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    2f67:	66 89 30             	mov    %si,(%eax)
    2f6a:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    2f6e:	88 50 02             	mov    %dl,0x2(%eax)
    2f71:	6a 32                	push   $0x32
    2f73:	6a 32                	push   $0x32
    2f75:	6a 00                	push   $0x0
    2f77:	6a 00                	push   $0x0
    2f79:	53                   	push   %ebx
    2f7a:	51                   	push   %ecx
    2f7b:	ff 75 94             	pushl  -0x6c(%ebp)
    2f7e:	57                   	push   %edi
    2f7f:	e8 dc f4 ff ff       	call   2460 <APDcCopy>
    2f84:	83 c4 30             	add    $0x30,%esp
                    break;
    2f87:	e9 8d 02 00 00       	jmp    3219 <APGridPaint+0x791>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2f8c:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    2f8f:	6a 0c                	push   $0xc
    2f91:	6a 0c                	push   $0xc
    2f93:	6a 0c                	push   $0xc
    2f95:	50                   	push   %eax
    2f96:	e8 69 f6 ff ff       	call   2604 <RGB>
    2f9b:	83 c4 0c             	add    $0xc,%esp
    2f9e:	8b 1d f0 7e 00 00    	mov    0x7ef0,%ebx
    2fa4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2fa7:	6b c8 32             	imul   $0x32,%eax,%ecx
    2faa:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2fad:	6b c0 32             	imul   $0x32,%eax,%eax
    2fb0:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2fb3:	8b 45 08             	mov    0x8(%ebp),%eax
    2fb6:	8d 78 3c             	lea    0x3c(%eax),%edi
    2fb9:	83 ec 0c             	sub    $0xc,%esp
    2fbc:	83 ec 04             	sub    $0x4,%esp
    2fbf:	89 e0                	mov    %esp,%eax
    2fc1:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    2fc5:	66 89 30             	mov    %si,(%eax)
    2fc8:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    2fcc:	88 50 02             	mov    %dl,0x2(%eax)
    2fcf:	6a 32                	push   $0x32
    2fd1:	6a 32                	push   $0x32
    2fd3:	6a 00                	push   $0x0
    2fd5:	6a 00                	push   $0x0
    2fd7:	53                   	push   %ebx
    2fd8:	51                   	push   %ecx
    2fd9:	ff 75 94             	pushl  -0x6c(%ebp)
    2fdc:	57                   	push   %edi
    2fdd:	e8 7e f4 ff ff       	call   2460 <APDcCopy>
    2fe2:	83 c4 30             	add    $0x30,%esp
                    break;
    2fe5:	e9 2f 02 00 00       	jmp    3219 <APGridPaint+0x791>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2fea:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    2fed:	6a 0c                	push   $0xc
    2fef:	6a 0c                	push   $0xc
    2ff1:	6a 0c                	push   $0xc
    2ff3:	50                   	push   %eax
    2ff4:	e8 0b f6 ff ff       	call   2604 <RGB>
    2ff9:	83 c4 0c             	add    $0xc,%esp
    2ffc:	8b 1d ac 7e 00 00    	mov    0x7eac,%ebx
    3002:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3005:	6b c8 32             	imul   $0x32,%eax,%ecx
    3008:	8b 45 e0             	mov    -0x20(%ebp),%eax
    300b:	6b c0 32             	imul   $0x32,%eax,%eax
    300e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    3011:	8b 45 08             	mov    0x8(%ebp),%eax
    3014:	8d 78 3c             	lea    0x3c(%eax),%edi
    3017:	83 ec 0c             	sub    $0xc,%esp
    301a:	83 ec 04             	sub    $0x4,%esp
    301d:	89 e0                	mov    %esp,%eax
    301f:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    3023:	66 89 30             	mov    %si,(%eax)
    3026:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    302a:	88 50 02             	mov    %dl,0x2(%eax)
    302d:	6a 32                	push   $0x32
    302f:	6a 32                	push   $0x32
    3031:	6a 00                	push   $0x0
    3033:	6a 00                	push   $0x0
    3035:	53                   	push   %ebx
    3036:	51                   	push   %ecx
    3037:	ff 75 94             	pushl  -0x6c(%ebp)
    303a:	57                   	push   %edi
    303b:	e8 20 f4 ff ff       	call   2460 <APDcCopy>
    3040:	83 c4 30             	add    $0x30,%esp
                    break;
    3043:	e9 d1 01 00 00       	jmp    3219 <APGridPaint+0x791>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    3048:	8d 45 c9             	lea    -0x37(%ebp),%eax
    304b:	6a 0c                	push   $0xc
    304d:	6a 0c                	push   $0xc
    304f:	6a 0c                	push   $0xc
    3051:	50                   	push   %eax
    3052:	e8 ad f5 ff ff       	call   2604 <RGB>
    3057:	83 c4 0c             	add    $0xc,%esp
    305a:	8b 1d 34 7f 00 00    	mov    0x7f34,%ebx
    3060:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3063:	6b c8 32             	imul   $0x32,%eax,%ecx
    3066:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3069:	6b c0 32             	imul   $0x32,%eax,%eax
    306c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    306f:	8b 45 08             	mov    0x8(%ebp),%eax
    3072:	8d 78 3c             	lea    0x3c(%eax),%edi
    3075:	83 ec 0c             	sub    $0xc,%esp
    3078:	83 ec 04             	sub    $0x4,%esp
    307b:	89 e0                	mov    %esp,%eax
    307d:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    3081:	66 89 30             	mov    %si,(%eax)
    3084:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    3088:	88 50 02             	mov    %dl,0x2(%eax)
    308b:	6a 32                	push   $0x32
    308d:	6a 32                	push   $0x32
    308f:	6a 00                	push   $0x0
    3091:	6a 00                	push   $0x0
    3093:	53                   	push   %ebx
    3094:	51                   	push   %ecx
    3095:	ff 75 94             	pushl  -0x6c(%ebp)
    3098:	57                   	push   %edi
    3099:	e8 c2 f3 ff ff       	call   2460 <APDcCopy>
    309e:	83 c4 30             	add    $0x30,%esp
                    break;
    30a1:	e9 73 01 00 00       	jmp    3219 <APGridPaint+0x791>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    30a6:	8d 45 cc             	lea    -0x34(%ebp),%eax
    30a9:	6a 0c                	push   $0xc
    30ab:	6a 0c                	push   $0xc
    30ad:	6a 0c                	push   $0xc
    30af:	50                   	push   %eax
    30b0:	e8 4f f5 ff ff       	call   2604 <RGB>
    30b5:	83 c4 0c             	add    $0xc,%esp
    30b8:	8b 1d 14 7e 00 00    	mov    0x7e14,%ebx
    30be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    30c1:	6b c8 32             	imul   $0x32,%eax,%ecx
    30c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    30c7:	6b c0 32             	imul   $0x32,%eax,%eax
    30ca:	89 45 94             	mov    %eax,-0x6c(%ebp)
    30cd:	8b 45 08             	mov    0x8(%ebp),%eax
    30d0:	8d 78 3c             	lea    0x3c(%eax),%edi
    30d3:	83 ec 0c             	sub    $0xc,%esp
    30d6:	83 ec 04             	sub    $0x4,%esp
    30d9:	89 e0                	mov    %esp,%eax
    30db:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    30df:	66 89 30             	mov    %si,(%eax)
    30e2:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    30e6:	88 50 02             	mov    %dl,0x2(%eax)
    30e9:	6a 32                	push   $0x32
    30eb:	6a 32                	push   $0x32
    30ed:	6a 00                	push   $0x0
    30ef:	6a 00                	push   $0x0
    30f1:	53                   	push   %ebx
    30f2:	51                   	push   %ecx
    30f3:	ff 75 94             	pushl  -0x6c(%ebp)
    30f6:	57                   	push   %edi
    30f7:	e8 64 f3 ff ff       	call   2460 <APDcCopy>
    30fc:	83 c4 30             	add    $0x30,%esp
                    break;
    30ff:	e9 15 01 00 00       	jmp    3219 <APGridPaint+0x791>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    3104:	8d 45 cf             	lea    -0x31(%ebp),%eax
    3107:	6a 0c                	push   $0xc
    3109:	6a 0c                	push   $0xc
    310b:	6a 0c                	push   $0xc
    310d:	50                   	push   %eax
    310e:	e8 f1 f4 ff ff       	call   2604 <RGB>
    3113:	83 c4 0c             	add    $0xc,%esp
    3116:	8b 1d 8c 7e 00 00    	mov    0x7e8c,%ebx
    311c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    311f:	6b c8 32             	imul   $0x32,%eax,%ecx
    3122:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3125:	6b c0 32             	imul   $0x32,%eax,%eax
    3128:	89 45 94             	mov    %eax,-0x6c(%ebp)
    312b:	8b 45 08             	mov    0x8(%ebp),%eax
    312e:	8d 78 3c             	lea    0x3c(%eax),%edi
    3131:	83 ec 0c             	sub    $0xc,%esp
    3134:	83 ec 04             	sub    $0x4,%esp
    3137:	89 e0                	mov    %esp,%eax
    3139:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    313d:	66 89 30             	mov    %si,(%eax)
    3140:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    3144:	88 50 02             	mov    %dl,0x2(%eax)
    3147:	6a 32                	push   $0x32
    3149:	6a 32                	push   $0x32
    314b:	6a 00                	push   $0x0
    314d:	6a 00                	push   $0x0
    314f:	53                   	push   %ebx
    3150:	51                   	push   %ecx
    3151:	ff 75 94             	pushl  -0x6c(%ebp)
    3154:	57                   	push   %edi
    3155:	e8 06 f3 ff ff       	call   2460 <APDcCopy>
    315a:	83 c4 30             	add    $0x30,%esp
                    break;
    315d:	e9 b7 00 00 00       	jmp    3219 <APGridPaint+0x791>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    3162:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    3165:	6a 0c                	push   $0xc
    3167:	6a 0c                	push   $0xc
    3169:	6a 0c                	push   $0xc
    316b:	50                   	push   %eax
    316c:	e8 93 f4 ff ff       	call   2604 <RGB>
    3171:	83 c4 0c             	add    $0xc,%esp
    3174:	8b 1d 18 7f 00 00    	mov    0x7f18,%ebx
    317a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    317d:	6b c8 32             	imul   $0x32,%eax,%ecx
    3180:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3183:	6b c0 32             	imul   $0x32,%eax,%eax
    3186:	89 45 94             	mov    %eax,-0x6c(%ebp)
    3189:	8b 45 08             	mov    0x8(%ebp),%eax
    318c:	8d 78 3c             	lea    0x3c(%eax),%edi
    318f:	83 ec 0c             	sub    $0xc,%esp
    3192:	83 ec 04             	sub    $0x4,%esp
    3195:	89 e0                	mov    %esp,%eax
    3197:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    319b:	66 89 30             	mov    %si,(%eax)
    319e:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    31a2:	88 50 02             	mov    %dl,0x2(%eax)
    31a5:	6a 32                	push   $0x32
    31a7:	6a 32                	push   $0x32
    31a9:	6a 00                	push   $0x0
    31ab:	6a 00                	push   $0x0
    31ad:	53                   	push   %ebx
    31ae:	51                   	push   %ecx
    31af:	ff 75 94             	pushl  -0x6c(%ebp)
    31b2:	57                   	push   %edi
    31b3:	e8 a8 f2 ff ff       	call   2460 <APDcCopy>
    31b8:	83 c4 30             	add    $0x30,%esp
                    break;
    31bb:	eb 5c                	jmp    3219 <APGridPaint+0x791>
                case GRID_PROGRAM_TOWER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_tower,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    31bd:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    31c0:	6a 0c                	push   $0xc
    31c2:	6a 0c                	push   $0xc
    31c4:	6a 0c                	push   $0xc
    31c6:	50                   	push   %eax
    31c7:	e8 38 f4 ff ff       	call   2604 <RGB>
    31cc:	83 c4 0c             	add    $0xc,%esp
    31cf:	8b 1d b0 7e 00 00    	mov    0x7eb0,%ebx
    31d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    31d8:	6b c8 32             	imul   $0x32,%eax,%ecx
    31db:	8b 45 e0             	mov    -0x20(%ebp),%eax
    31de:	6b c0 32             	imul   $0x32,%eax,%eax
    31e1:	89 45 94             	mov    %eax,-0x6c(%ebp)
    31e4:	8b 45 08             	mov    0x8(%ebp),%eax
    31e7:	8d 78 3c             	lea    0x3c(%eax),%edi
    31ea:	83 ec 0c             	sub    $0xc,%esp
    31ed:	83 ec 04             	sub    $0x4,%esp
    31f0:	89 e0                	mov    %esp,%eax
    31f2:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    31f6:	66 89 30             	mov    %si,(%eax)
    31f9:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    31fd:	88 50 02             	mov    %dl,0x2(%eax)
    3200:	6a 32                	push   $0x32
    3202:	6a 32                	push   $0x32
    3204:	6a 00                	push   $0x0
    3206:	6a 00                	push   $0x0
    3208:	53                   	push   %ebx
    3209:	51                   	push   %ecx
    320a:	ff 75 94             	pushl  -0x6c(%ebp)
    320d:	57                   	push   %edi
    320e:	e8 4d f2 ff ff       	call   2460 <APDcCopy>
    3213:	83 c4 30             	add    $0x30,%esp
                    break;
    3216:	eb 01                	jmp    3219 <APGridPaint+0x791>
                default: break;
    3218:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    3219:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    321d:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    3221:	0f 8e be fb ff ff    	jle    2de5 <APGridPaint+0x35d>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    3227:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    322b:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    322f:	0f 8e a4 fb ff ff    	jle    2dd9 <APGridPaint+0x351>
                    break;
                default: break;
            }
        }
    }
}
    3235:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3238:	5b                   	pop    %ebx
    3239:	5e                   	pop    %esi
    323a:	5f                   	pop    %edi
    323b:	5d                   	pop    %ebp
    323c:	c3                   	ret    

0000323d <updateword>:


void updateword(AHwnd hwnd,char* str)
{
    323d:	55                   	push   %ebp
    323e:	89 e5                	mov    %esp,%ebp
    3240:	53                   	push   %ebx
    3241:	83 ec 24             	sub    $0x24,%esp
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    3244:	8d 45 d8             	lea    -0x28(%ebp),%eax
    3247:	68 cd 00 00 00       	push   $0xcd
    324c:	6a 74                	push   $0x74
    324e:	6a 18                	push   $0x18
    3250:	50                   	push   %eax
    3251:	e8 ae f3 ff ff       	call   2604 <RGB>
    3256:	83 c4 0c             	add    $0xc,%esp
    3259:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    325d:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
    3261:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    3265:	88 45 f2             	mov    %al,-0xe(%ebp)
    pen.size = 1;
    3268:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    326f:	8d 45 d8             	lea    -0x28(%ebp),%eax
    3272:	68 cd 00 00 00       	push   $0xcd
    3277:	6a 74                	push   $0x74
    3279:	6a 18                	push   $0x18
    327b:	50                   	push   %eax
    327c:	e8 83 f3 ff ff       	call   2604 <RGB>
    3281:	83 c4 0c             	add    $0xc,%esp
    3284:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    3288:	66 89 45 ed          	mov    %ax,-0x13(%ebp)
    328c:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    3290:	88 45 ef             	mov    %al,-0x11(%ebp)
    APSetPen(&hwnd->TitleDc,pen);
    3293:	8b 45 08             	mov    0x8(%ebp),%eax
    3296:	8d 50 58             	lea    0x58(%eax),%edx
    3299:	8d 45 d8             	lea    -0x28(%ebp),%eax
    329c:	ff 75 f4             	pushl  -0xc(%ebp)
    329f:	ff 75 f0             	pushl  -0x10(%ebp)
    32a2:	52                   	push   %edx
    32a3:	50                   	push   %eax
    32a4:	e8 48 ea ff ff       	call   1cf1 <APSetPen>
    32a9:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&hwnd->TitleDc,brush);
    32ac:	8b 45 08             	mov    0x8(%ebp),%eax
    32af:	8d 58 58             	lea    0x58(%eax),%ebx
    32b2:	8d 55 d8             	lea    -0x28(%ebp),%edx
    32b5:	83 ec 04             	sub    $0x4,%esp
    32b8:	83 ec 04             	sub    $0x4,%esp
    32bb:	89 e0                	mov    %esp,%eax
    32bd:	0f b7 4d ed          	movzwl -0x13(%ebp),%ecx
    32c1:	66 89 08             	mov    %cx,(%eax)
    32c4:	0f b6 4d ef          	movzbl -0x11(%ebp),%ecx
    32c8:	88 48 02             	mov    %cl,0x2(%eax)
    32cb:	53                   	push   %ebx
    32cc:	52                   	push   %edx
    32cd:	e8 58 ea ff ff       	call   1d2a <APSetBrush>
    32d2:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&hwnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    32d5:	8b 45 08             	mov    0x8(%ebp),%eax
    32d8:	83 c0 58             	add    $0x58,%eax
    32db:	83 ec 0c             	sub    $0xc,%esp
    32de:	6a 32                	push   $0x32
    32e0:	68 20 03 00 00       	push   $0x320
    32e5:	6a 00                	push   $0x0
    32e7:	6a 00                	push   $0x0
    32e9:	50                   	push   %eax
    32ea:	e8 65 ee ff ff       	call   2154 <APDrawRect>
    32ef:	83 c4 20             	add    $0x20,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    32f2:	8d 45 d8             	lea    -0x28(%ebp),%eax
    32f5:	6a 08                	push   $0x8
    32f7:	6a 08                	push   $0x8
    32f9:	6a 08                	push   $0x8
    32fb:	50                   	push   %eax
    32fc:	e8 03 f3 ff ff       	call   2604 <RGB>
    3301:	83 c4 0c             	add    $0xc,%esp
    3304:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    3308:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    330c:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    3310:	88 45 ec             	mov    %al,-0x14(%ebp)
    APSetFont(&hwnd->TitleDc,font);
    3313:	8b 45 08             	mov    0x8(%ebp),%eax
    3316:	8d 58 58             	lea    0x58(%eax),%ebx
    3319:	8d 55 d8             	lea    -0x28(%ebp),%edx
    331c:	83 ec 04             	sub    $0x4,%esp
    331f:	83 ec 04             	sub    $0x4,%esp
    3322:	89 e0                	mov    %esp,%eax
    3324:	0f b7 4d ea          	movzwl -0x16(%ebp),%ecx
    3328:	66 89 08             	mov    %cx,(%eax)
    332b:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
    332f:	88 48 02             	mov    %cl,0x2(%eax)
    3332:	53                   	push   %ebx
    3333:	52                   	push   %edx
    3334:	e8 33 ea ff ff       	call   1d6c <APSetFont>
    3339:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&hwnd->TitleDc,str,10,20);
    333c:	8b 45 08             	mov    0x8(%ebp),%eax
    333f:	83 c0 58             	add    $0x58,%eax
    3342:	6a 14                	push   $0x14
    3344:	6a 0a                	push   $0xa
    3346:	ff 75 0c             	pushl  0xc(%ebp)
    3349:	50                   	push   %eax
    334a:	e8 0a f0 ff ff       	call   2359 <APDrawText>
    334f:	83 c4 10             	add    $0x10,%esp
}
    3352:	90                   	nop
    3353:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3356:	c9                   	leave  
    3357:	c3                   	ret    

00003358 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    3358:	55                   	push   %ebp
    3359:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    335b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    335f:	7e 08                	jle    3369 <random+0x11>
{
rand_num = seed;
    3361:	8b 45 08             	mov    0x8(%ebp),%eax
    3364:	a3 c0 7d 00 00       	mov    %eax,0x7dc0
}
rand_num *= 3;
    3369:	8b 15 c0 7d 00 00    	mov    0x7dc0,%edx
    336f:	89 d0                	mov    %edx,%eax
    3371:	01 c0                	add    %eax,%eax
    3373:	01 d0                	add    %edx,%eax
    3375:	a3 c0 7d 00 00       	mov    %eax,0x7dc0
if (rand_num < 0)
    337a:	a1 c0 7d 00 00       	mov    0x7dc0,%eax
    337f:	85 c0                	test   %eax,%eax
    3381:	79 0c                	jns    338f <random+0x37>
{
rand_num *= (-1);
    3383:	a1 c0 7d 00 00       	mov    0x7dc0,%eax
    3388:	f7 d8                	neg    %eax
    338a:	a3 c0 7d 00 00       	mov    %eax,0x7dc0
}
return rand_num % 997;
    338f:	8b 0d c0 7d 00 00    	mov    0x7dc0,%ecx
    3395:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    339a:	89 c8                	mov    %ecx,%eax
    339c:	f7 ea                	imul   %edx
    339e:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    33a1:	c1 f8 09             	sar    $0x9,%eax
    33a4:	89 c2                	mov    %eax,%edx
    33a6:	89 c8                	mov    %ecx,%eax
    33a8:	c1 f8 1f             	sar    $0x1f,%eax
    33ab:	29 c2                	sub    %eax,%edx
    33ad:	89 d0                	mov    %edx,%eax
    33af:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    33b5:	29 c1                	sub    %eax,%ecx
    33b7:	89 c8                	mov    %ecx,%eax
}
    33b9:	5d                   	pop    %ebp
    33ba:	c3                   	ret    

000033bb <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    33bb:	55                   	push   %ebp
    33bc:	89 e5                	mov    %esp,%ebp
    33be:	53                   	push   %ebx
    33bf:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    33c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    33c9:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    33cd:	74 17                	je     33e6 <sprintint+0x2b>
    33cf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    33d3:	79 11                	jns    33e6 <sprintint+0x2b>
        neg = 1;
    33d5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    33dc:	8b 45 10             	mov    0x10(%ebp),%eax
    33df:	f7 d8                	neg    %eax
    33e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    33e4:	eb 06                	jmp    33ec <sprintint+0x31>
    } else {
        x = xx;
    33e6:	8b 45 10             	mov    0x10(%ebp),%eax
    33e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    33ec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    33f3:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    33f6:	8d 41 01             	lea    0x1(%ecx),%eax
    33f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    33fc:	8b 5d 14             	mov    0x14(%ebp),%ebx
    33ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3402:	ba 00 00 00 00       	mov    $0x0,%edx
    3407:	f7 f3                	div    %ebx
    3409:	89 d0                	mov    %edx,%eax
    340b:	0f b6 80 c4 7d 00 00 	movzbl 0x7dc4(%eax),%eax
    3412:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    3416:	8b 5d 14             	mov    0x14(%ebp),%ebx
    3419:	8b 45 f0             	mov    -0x10(%ebp),%eax
    341c:	ba 00 00 00 00       	mov    $0x0,%edx
    3421:	f7 f3                	div    %ebx
    3423:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3426:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    342a:	75 c7                	jne    33f3 <sprintint+0x38>
    if(neg)
    342c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3430:	74 0e                	je     3440 <sprintint+0x85>
        buf[i++] = '-';
    3432:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3435:	8d 50 01             	lea    0x1(%eax),%edx
    3438:	89 55 f8             	mov    %edx,-0x8(%ebp)
    343b:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    3440:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3443:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    3446:	eb 1b                	jmp    3463 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    3448:	8b 45 0c             	mov    0xc(%ebp),%eax
    344b:	8b 00                	mov    (%eax),%eax
    344d:	8d 48 01             	lea    0x1(%eax),%ecx
    3450:	8b 55 0c             	mov    0xc(%ebp),%edx
    3453:	89 0a                	mov    %ecx,(%edx)
    3455:	89 c2                	mov    %eax,%edx
    3457:	8b 45 08             	mov    0x8(%ebp),%eax
    345a:	01 d0                	add    %edx,%eax
    345c:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    345f:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    3463:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    3467:	7f df                	jg     3448 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    3469:	eb 21                	jmp    348c <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    346b:	8b 45 0c             	mov    0xc(%ebp),%eax
    346e:	8b 00                	mov    (%eax),%eax
    3470:	8d 48 01             	lea    0x1(%eax),%ecx
    3473:	8b 55 0c             	mov    0xc(%ebp),%edx
    3476:	89 0a                	mov    %ecx,(%edx)
    3478:	89 c2                	mov    %eax,%edx
    347a:	8b 45 08             	mov    0x8(%ebp),%eax
    347d:	01 c2                	add    %eax,%edx
    347f:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    3482:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3485:	01 c8                	add    %ecx,%eax
    3487:	0f b6 00             	movzbl (%eax),%eax
    348a:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    348c:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    3490:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    3494:	79 d5                	jns    346b <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    3496:	90                   	nop
    3497:	83 c4 20             	add    $0x20,%esp
    349a:	5b                   	pop    %ebx
    349b:	5d                   	pop    %ebp
    349c:	c3                   	ret    

0000349d <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    349d:	55                   	push   %ebp
    349e:	89 e5                	mov    %esp,%ebp
    34a0:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    34a3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    34aa:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    34b1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    34b8:	8d 45 0c             	lea    0xc(%ebp),%eax
    34bb:	83 c0 04             	add    $0x4,%eax
    34be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    34c1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    34c8:	e9 d9 01 00 00       	jmp    36a6 <sprintf+0x209>
        c = fmt[i] & 0xff;
    34cd:	8b 55 0c             	mov    0xc(%ebp),%edx
    34d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    34d3:	01 d0                	add    %edx,%eax
    34d5:	0f b6 00             	movzbl (%eax),%eax
    34d8:	0f be c0             	movsbl %al,%eax
    34db:	25 ff 00 00 00       	and    $0xff,%eax
    34e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    34e3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    34e7:	75 2c                	jne    3515 <sprintf+0x78>
            if(c == '%'){
    34e9:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    34ed:	75 0c                	jne    34fb <sprintf+0x5e>
                state = '%';
    34ef:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    34f6:	e9 a7 01 00 00       	jmp    36a2 <sprintf+0x205>
            } else {
                dst[j++] = c;
    34fb:	8b 45 c8             	mov    -0x38(%ebp),%eax
    34fe:	8d 50 01             	lea    0x1(%eax),%edx
    3501:	89 55 c8             	mov    %edx,-0x38(%ebp)
    3504:	89 c2                	mov    %eax,%edx
    3506:	8b 45 08             	mov    0x8(%ebp),%eax
    3509:	01 d0                	add    %edx,%eax
    350b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    350e:	88 10                	mov    %dl,(%eax)
    3510:	e9 8d 01 00 00       	jmp    36a2 <sprintf+0x205>
            }
        } else if(state == '%'){
    3515:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    3519:	0f 85 83 01 00 00    	jne    36a2 <sprintf+0x205>
            if(c == 'd'){
    351f:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    3523:	75 4c                	jne    3571 <sprintf+0xd4>
                buf[bi] = '\0';
    3525:	8d 55 ce             	lea    -0x32(%ebp),%edx
    3528:	8b 45 f0             	mov    -0x10(%ebp),%eax
    352b:	01 d0                	add    %edx,%eax
    352d:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    3530:	83 ec 0c             	sub    $0xc,%esp
    3533:	8d 45 ce             	lea    -0x32(%ebp),%eax
    3536:	50                   	push   %eax
    3537:	e8 0f de ff ff       	call   134b <atoi>
    353c:	83 c4 10             	add    $0x10,%esp
    353f:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    3542:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    3549:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    354c:	8b 00                	mov    (%eax),%eax
    354e:	83 ec 08             	sub    $0x8,%esp
    3551:	ff 75 d8             	pushl  -0x28(%ebp)
    3554:	6a 01                	push   $0x1
    3556:	6a 0a                	push   $0xa
    3558:	50                   	push   %eax
    3559:	8d 45 c8             	lea    -0x38(%ebp),%eax
    355c:	50                   	push   %eax
    355d:	ff 75 08             	pushl  0x8(%ebp)
    3560:	e8 56 fe ff ff       	call   33bb <sprintint>
    3565:	83 c4 20             	add    $0x20,%esp
                ap++;
    3568:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    356c:	e9 2a 01 00 00       	jmp    369b <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    3571:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    3575:	74 06                	je     357d <sprintf+0xe0>
    3577:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    357b:	75 4c                	jne    35c9 <sprintf+0x12c>
                buf[bi] = '\0';
    357d:	8d 55 ce             	lea    -0x32(%ebp),%edx
    3580:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3583:	01 d0                	add    %edx,%eax
    3585:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    3588:	83 ec 0c             	sub    $0xc,%esp
    358b:	8d 45 ce             	lea    -0x32(%ebp),%eax
    358e:	50                   	push   %eax
    358f:	e8 b7 dd ff ff       	call   134b <atoi>
    3594:	83 c4 10             	add    $0x10,%esp
    3597:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    359a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    35a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    35a4:	8b 00                	mov    (%eax),%eax
    35a6:	83 ec 08             	sub    $0x8,%esp
    35a9:	ff 75 dc             	pushl  -0x24(%ebp)
    35ac:	6a 00                	push   $0x0
    35ae:	6a 10                	push   $0x10
    35b0:	50                   	push   %eax
    35b1:	8d 45 c8             	lea    -0x38(%ebp),%eax
    35b4:	50                   	push   %eax
    35b5:	ff 75 08             	pushl  0x8(%ebp)
    35b8:	e8 fe fd ff ff       	call   33bb <sprintint>
    35bd:	83 c4 20             	add    $0x20,%esp
                ap++;
    35c0:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    35c4:	e9 d2 00 00 00       	jmp    369b <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    35c9:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    35cd:	75 46                	jne    3615 <sprintf+0x178>
                s = (char*)*ap;
    35cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    35d2:	8b 00                	mov    (%eax),%eax
    35d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    35d7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    35db:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    35df:	75 25                	jne    3606 <sprintf+0x169>
                    s = "(null)";
    35e1:	c7 45 f4 7c 3a 00 00 	movl   $0x3a7c,-0xc(%ebp)
                while(*s != 0){
    35e8:	eb 1c                	jmp    3606 <sprintf+0x169>
                    dst[j++] = *s;
    35ea:	8b 45 c8             	mov    -0x38(%ebp),%eax
    35ed:	8d 50 01             	lea    0x1(%eax),%edx
    35f0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    35f3:	89 c2                	mov    %eax,%edx
    35f5:	8b 45 08             	mov    0x8(%ebp),%eax
    35f8:	01 c2                	add    %eax,%edx
    35fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    35fd:	0f b6 00             	movzbl (%eax),%eax
    3600:	88 02                	mov    %al,(%edx)
                    s++;
    3602:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    3606:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3609:	0f b6 00             	movzbl (%eax),%eax
    360c:	84 c0                	test   %al,%al
    360e:	75 da                	jne    35ea <sprintf+0x14d>
    3610:	e9 86 00 00 00       	jmp    369b <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    3615:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    3619:	75 1d                	jne    3638 <sprintf+0x19b>
                dst[j++] = *ap;
    361b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    361e:	8d 50 01             	lea    0x1(%eax),%edx
    3621:	89 55 c8             	mov    %edx,-0x38(%ebp)
    3624:	89 c2                	mov    %eax,%edx
    3626:	8b 45 08             	mov    0x8(%ebp),%eax
    3629:	01 c2                	add    %eax,%edx
    362b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    362e:	8b 00                	mov    (%eax),%eax
    3630:	88 02                	mov    %al,(%edx)
                ap++;
    3632:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    3636:	eb 63                	jmp    369b <sprintf+0x1fe>
            } else if(c == '%'){
    3638:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    363c:	75 17                	jne    3655 <sprintf+0x1b8>
                dst[j++] = c;
    363e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3641:	8d 50 01             	lea    0x1(%eax),%edx
    3644:	89 55 c8             	mov    %edx,-0x38(%ebp)
    3647:	89 c2                	mov    %eax,%edx
    3649:	8b 45 08             	mov    0x8(%ebp),%eax
    364c:	01 d0                	add    %edx,%eax
    364e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    3651:	88 10                	mov    %dl,(%eax)
    3653:	eb 46                	jmp    369b <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    3655:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    3659:	7e 18                	jle    3673 <sprintf+0x1d6>
    365b:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    365f:	7f 12                	jg     3673 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    3661:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3664:	8d 50 01             	lea    0x1(%eax),%edx
    3667:	89 55 f0             	mov    %edx,-0x10(%ebp)
    366a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    366d:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    3671:	eb 2f                	jmp    36a2 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    3673:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3676:	8d 50 01             	lea    0x1(%eax),%edx
    3679:	89 55 c8             	mov    %edx,-0x38(%ebp)
    367c:	89 c2                	mov    %eax,%edx
    367e:	8b 45 08             	mov    0x8(%ebp),%eax
    3681:	01 d0                	add    %edx,%eax
    3683:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    3686:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3689:	8d 50 01             	lea    0x1(%eax),%edx
    368c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    368f:	89 c2                	mov    %eax,%edx
    3691:	8b 45 08             	mov    0x8(%ebp),%eax
    3694:	01 d0                	add    %edx,%eax
    3696:	8b 55 e0             	mov    -0x20(%ebp),%edx
    3699:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    369b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    36a2:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    36a6:	8b 55 0c             	mov    0xc(%ebp),%edx
    36a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    36ac:	01 d0                	add    %edx,%eax
    36ae:	0f b6 00             	movzbl (%eax),%eax
    36b1:	84 c0                	test   %al,%al
    36b3:	0f 85 14 fe ff ff    	jne    34cd <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    36b9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    36bc:	8d 50 01             	lea    0x1(%eax),%edx
    36bf:	89 55 c8             	mov    %edx,-0x38(%ebp)
    36c2:	89 c2                	mov    %eax,%edx
    36c4:	8b 45 08             	mov    0x8(%ebp),%eax
    36c7:	01 d0                	add    %edx,%eax
    36c9:	c6 00 00             	movb   $0x0,(%eax)
}
    36cc:	90                   	nop
    36cd:	c9                   	leave  
    36ce:	c3                   	ret    
