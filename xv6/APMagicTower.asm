
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
      d4:	83 ec 24             	sub    $0x24,%esp
APoint temp;
switch(msg.param)
      d7:	8b 45 10             	mov    0x10(%ebp),%eax
      da:	83 f8 05             	cmp    $0x5,%eax
      dd:	0f 87 9d 00 00 00    	ja     180 <keyDown+0xb0>
      e3:	8b 04 85 d4 31 00 00 	mov    0x31d4(,%eax,4),%eax
      ea:	ff e0                	jmp    *%eax
{
	case VK_UP:
		temp = nextpoint(position,Up);
      ec:	8d 45 f0             	lea    -0x10(%ebp),%eax
      ef:	6a 00                	push   $0x0
      f1:	ff 35 60 78 00 00    	pushl  0x7860
      f7:	ff 35 5c 78 00 00    	pushl  0x785c
      fd:	50                   	push   %eax
      fe:	e8 42 ff ff ff       	call   45 <nextpoint>
     103:	83 c4 0c             	add    $0xc,%esp
		break;
     106:	eb 79                	jmp    181 <keyDown+0xb1>
	case VK_DOWN:

		temp = nextpoint(position,Down);
     108:	8d 45 e0             	lea    -0x20(%ebp),%eax
     10b:	6a 01                	push   $0x1
     10d:	ff 35 60 78 00 00    	pushl  0x7860
     113:	ff 35 5c 78 00 00    	pushl  0x785c
     119:	50                   	push   %eax
     11a:	e8 26 ff ff ff       	call   45 <nextpoint>
     11f:	83 c4 0c             	add    $0xc,%esp
     122:	8b 45 e0             	mov    -0x20(%ebp),%eax
     125:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     128:	89 45 f0             	mov    %eax,-0x10(%ebp)
     12b:	89 55 f4             	mov    %edx,-0xc(%ebp)
		break;
     12e:	eb 51                	jmp    181 <keyDown+0xb1>

	case VK_LEFT:

		temp = nextpoint(position,Left);
     130:	8d 45 e0             	lea    -0x20(%ebp),%eax
     133:	6a 02                	push   $0x2
     135:	ff 35 60 78 00 00    	pushl  0x7860
     13b:	ff 35 5c 78 00 00    	pushl  0x785c
     141:	50                   	push   %eax
     142:	e8 fe fe ff ff       	call   45 <nextpoint>
     147:	83 c4 0c             	add    $0xc,%esp
     14a:	8b 45 e0             	mov    -0x20(%ebp),%eax
     14d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     150:	89 45 f0             	mov    %eax,-0x10(%ebp)
     153:	89 55 f4             	mov    %edx,-0xc(%ebp)
		break;
     156:	eb 29                	jmp    181 <keyDown+0xb1>

	case VK_RIGHT:

		temp = nextpoint(position,Right);
     158:	8d 45 e0             	lea    -0x20(%ebp),%eax
     15b:	6a 03                	push   $0x3
     15d:	ff 35 60 78 00 00    	pushl  0x7860
     163:	ff 35 5c 78 00 00    	pushl  0x785c
     169:	50                   	push   %eax
     16a:	e8 d6 fe ff ff       	call   45 <nextpoint>
     16f:	83 c4 0c             	add    $0xc,%esp
     172:	8b 45 e0             	mov    -0x20(%ebp),%eax
     175:	8b 55 e4             	mov    -0x1c(%ebp),%edx
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
     181:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     187:	8b 15 5c 78 00 00    	mov    0x785c,%edx
     18d:	8b 0d 60 78 00 00    	mov    0x7860,%ecx
     193:	89 d0                	mov    %edx,%eax
     195:	c1 e0 02             	shl    $0x2,%eax
     198:	01 d0                	add    %edx,%eax
     19a:	01 c0                	add    %eax,%eax
     19c:	6b d3 64             	imul   $0x64,%ebx,%edx
     19f:	01 d0                	add    %edx,%eax
     1a1:	01 c8                	add    %ecx,%eax
     1a3:	c7 04 85 20 79 00 00 	movl   $0x0,0x7920(,%eax,4)
     1aa:	00 00 00 00 
switch(my_tower[floor][temp.x][temp.y])
     1ae:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     1b4:	8b 55 f0             	mov    -0x10(%ebp),%edx
     1b7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     1ba:	89 d0                	mov    %edx,%eax
     1bc:	c1 e0 02             	shl    $0x2,%eax
     1bf:	01 d0                	add    %edx,%eax
     1c1:	01 c0                	add    %eax,%eax
     1c3:	6b d3 64             	imul   $0x64,%ebx,%edx
     1c6:	01 d0                	add    %edx,%eax
     1c8:	01 c8                	add    %ecx,%eax
     1ca:	8b 04 85 20 79 00 00 	mov    0x7920(,%eax,4),%eax
     1d1:	83 f8 11             	cmp    $0x11,%eax
     1d4:	0f 87 da 03 00 00    	ja     5b4 <keyDown+0x4e4>
     1da:	8b 04 85 ec 31 00 00 	mov    0x31ec(,%eax,4),%eax
     1e1:	ff e0                	jmp    *%eax
{
	case Background:

		position = temp;
     1e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     1e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1e9:	a3 5c 78 00 00       	mov    %eax,0x785c
     1ee:	89 15 60 78 00 00    	mov    %edx,0x7860
		break;
     1f4:	e9 bf 03 00 00       	jmp    5b8 <keyDown+0x4e8>
	case Wall:
		break;
	case Monster1:
	case Monster2:
	case Monster3:
		position = temp;
     1f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     1fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1ff:	a3 5c 78 00 00       	mov    %eax,0x785c
     204:	89 15 60 78 00 00    	mov    %edx,0x7860
		if(!fight())
     20a:	e8 62 05 00 00       	call   771 <fight>
     20f:	84 c0                	test   %al,%al
     211:	0f 85 a0 03 00 00    	jne    5b7 <keyDown+0x4e7>
		{
		printf(1,"Dead");
     217:	83 ec 08             	sub    $0x8,%esp
     21a:	68 a8 31 00 00       	push   $0x31a8
     21f:	6a 01                	push   $0x1
     221:	e8 6a 0f 00 00       	call   1190 <printf>
     226:	83 c4 10             	add    $0x10,%esp
		}
		break;
     229:	e9 89 03 00 00       	jmp    5b7 <keyDown+0x4e7>
	case YellowDoor:
		if (my_key[0] > 0)
     22e:	a1 d0 7d 00 00       	mov    0x7dd0,%eax
     233:	85 c0                	test   %eax,%eax
     235:	7e 4a                	jle    281 <keyDown+0x1b1>
		{
		my_key[0]--;
     237:	a1 d0 7d 00 00       	mov    0x7dd0,%eax
     23c:	83 e8 01             	sub    $0x1,%eax
     23f:	a3 d0 7d 00 00       	mov    %eax,0x7dd0
		position = temp;
     244:	8b 45 f0             	mov    -0x10(%ebp),%eax
     247:	8b 55 f4             	mov    -0xc(%ebp),%edx
     24a:	a3 5c 78 00 00       	mov    %eax,0x785c
     24f:	89 15 60 78 00 00    	mov    %edx,0x7860
		my_tower[floor][temp.x][temp.y] = Background;
     255:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     25b:	8b 55 f0             	mov    -0x10(%ebp),%edx
     25e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     261:	89 d0                	mov    %edx,%eax
     263:	c1 e0 02             	shl    $0x2,%eax
     266:	01 d0                	add    %edx,%eax
     268:	01 c0                	add    %eax,%eax
     26a:	6b d3 64             	imul   $0x64,%ebx,%edx
     26d:	01 d0                	add    %edx,%eax
     26f:	01 c8                	add    %ecx,%eax
     271:	c7 04 85 20 79 00 00 	movl   $0x0,0x7920(,%eax,4)
     278:	00 00 00 00 
		}
		else
		{
		printf(1,"No Yellow Key");
		}
		break;
     27c:	e9 37 03 00 00       	jmp    5b8 <keyDown+0x4e8>
		position = temp;
		my_tower[floor][temp.x][temp.y] = Background;
		}
		else
		{
		printf(1,"No Yellow Key");
     281:	83 ec 08             	sub    $0x8,%esp
     284:	68 ad 31 00 00       	push   $0x31ad
     289:	6a 01                	push   $0x1
     28b:	e8 00 0f 00 00       	call   1190 <printf>
     290:	83 c4 10             	add    $0x10,%esp
		}
		break;
     293:	e9 20 03 00 00       	jmp    5b8 <keyDown+0x4e8>
	case BlueDoor:
		if (my_key[1] > 0)
     298:	a1 d4 7d 00 00       	mov    0x7dd4,%eax
     29d:	85 c0                	test   %eax,%eax
     29f:	7e 4a                	jle    2eb <keyDown+0x21b>
		{
		my_key[1]--;
     2a1:	a1 d4 7d 00 00       	mov    0x7dd4,%eax
     2a6:	83 e8 01             	sub    $0x1,%eax
     2a9:	a3 d4 7d 00 00       	mov    %eax,0x7dd4
		position = temp;
     2ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
     2b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     2b4:	a3 5c 78 00 00       	mov    %eax,0x785c
     2b9:	89 15 60 78 00 00    	mov    %edx,0x7860
		my_tower[floor][temp.x][temp.y] = Background;
     2bf:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     2c5:	8b 55 f0             	mov    -0x10(%ebp),%edx
     2c8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     2cb:	89 d0                	mov    %edx,%eax
     2cd:	c1 e0 02             	shl    $0x2,%eax
     2d0:	01 d0                	add    %edx,%eax
     2d2:	01 c0                	add    %eax,%eax
     2d4:	6b d3 64             	imul   $0x64,%ebx,%edx
     2d7:	01 d0                	add    %edx,%eax
     2d9:	01 c8                	add    %ecx,%eax
     2db:	c7 04 85 20 79 00 00 	movl   $0x0,0x7920(,%eax,4)
     2e2:	00 00 00 00 
		}
		else
		{
		printf(1,"No Blue Key");
		}
		break;
     2e6:	e9 cd 02 00 00       	jmp    5b8 <keyDown+0x4e8>
		position = temp;
		my_tower[floor][temp.x][temp.y] = Background;
		}
		else
		{
		printf(1,"No Blue Key");
     2eb:	83 ec 08             	sub    $0x8,%esp
     2ee:	68 bb 31 00 00       	push   $0x31bb
     2f3:	6a 01                	push   $0x1
     2f5:	e8 96 0e 00 00       	call   1190 <printf>
     2fa:	83 c4 10             	add    $0x10,%esp
		}
		break;
     2fd:	e9 b6 02 00 00       	jmp    5b8 <keyDown+0x4e8>
	case RedDoor:
		if (my_key[1] > 0)
     302:	a1 d4 7d 00 00       	mov    0x7dd4,%eax
     307:	85 c0                	test   %eax,%eax
     309:	7e 4a                	jle    355 <keyDown+0x285>
		{
		my_key[1]--;
     30b:	a1 d4 7d 00 00       	mov    0x7dd4,%eax
     310:	83 e8 01             	sub    $0x1,%eax
     313:	a3 d4 7d 00 00       	mov    %eax,0x7dd4
		position = temp;
     318:	8b 45 f0             	mov    -0x10(%ebp),%eax
     31b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     31e:	a3 5c 78 00 00       	mov    %eax,0x785c
     323:	89 15 60 78 00 00    	mov    %edx,0x7860
		my_tower[floor][temp.x][temp.y] = Background;
     329:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     32f:	8b 55 f0             	mov    -0x10(%ebp),%edx
     332:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     335:	89 d0                	mov    %edx,%eax
     337:	c1 e0 02             	shl    $0x2,%eax
     33a:	01 d0                	add    %edx,%eax
     33c:	01 c0                	add    %eax,%eax
     33e:	6b d3 64             	imul   $0x64,%ebx,%edx
     341:	01 d0                	add    %edx,%eax
     343:	01 c8                	add    %ecx,%eax
     345:	c7 04 85 20 79 00 00 	movl   $0x0,0x7920(,%eax,4)
     34c:	00 00 00 00 
		}
		else
		{
		printf(1,"No red Key");
		}
		break;
     350:	e9 63 02 00 00       	jmp    5b8 <keyDown+0x4e8>
		position = temp;
		my_tower[floor][temp.x][temp.y] = Background;
		}
		else
		{
		printf(1,"No red Key");
     355:	83 ec 08             	sub    $0x8,%esp
     358:	68 c7 31 00 00       	push   $0x31c7
     35d:	6a 01                	push   $0x1
     35f:	e8 2c 0e 00 00       	call   1190 <printf>
     364:	83 c4 10             	add    $0x10,%esp
		}
		break;
     367:	e9 4c 02 00 00       	jmp    5b8 <keyDown+0x4e8>
	case UpStair:
		floor++;
     36c:	a1 4c 78 00 00       	mov    0x784c,%eax
     371:	83 c0 01             	add    $0x1,%eax
     374:	a3 4c 78 00 00       	mov    %eax,0x784c
		position = temp;
     379:	8b 45 f0             	mov    -0x10(%ebp),%eax
     37c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     37f:	a3 5c 78 00 00       	mov    %eax,0x785c
     384:	89 15 60 78 00 00    	mov    %edx,0x7860
		break;
     38a:	e9 29 02 00 00       	jmp    5b8 <keyDown+0x4e8>
	case DownStair:
		floor--;
     38f:	a1 4c 78 00 00       	mov    0x784c,%eax
     394:	83 e8 01             	sub    $0x1,%eax
     397:	a3 4c 78 00 00       	mov    %eax,0x784c
		position = temp;
     39c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     39f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     3a2:	a3 5c 78 00 00       	mov    %eax,0x785c
     3a7:	89 15 60 78 00 00    	mov    %edx,0x7860
		break;
     3ad:	e9 06 02 00 00       	jmp    5b8 <keyDown+0x4e8>
	case YellowKey:
		my_key[0]++;
     3b2:	a1 d0 7d 00 00       	mov    0x7dd0,%eax
     3b7:	83 c0 01             	add    $0x1,%eax
     3ba:	a3 d0 7d 00 00       	mov    %eax,0x7dd0
		my_tower[floor][temp.x][temp.y] = Background;
     3bf:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     3c5:	8b 55 f0             	mov    -0x10(%ebp),%edx
     3c8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3cb:	89 d0                	mov    %edx,%eax
     3cd:	c1 e0 02             	shl    $0x2,%eax
     3d0:	01 d0                	add    %edx,%eax
     3d2:	01 c0                	add    %eax,%eax
     3d4:	6b d3 64             	imul   $0x64,%ebx,%edx
     3d7:	01 d0                	add    %edx,%eax
     3d9:	01 c8                	add    %ecx,%eax
     3db:	c7 04 85 20 79 00 00 	movl   $0x0,0x7920(,%eax,4)
     3e2:	00 00 00 00 
		position = temp;
     3e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     3e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     3ec:	a3 5c 78 00 00       	mov    %eax,0x785c
     3f1:	89 15 60 78 00 00    	mov    %edx,0x7860
		break;
     3f7:	e9 bc 01 00 00       	jmp    5b8 <keyDown+0x4e8>
	case BlueKey:
		my_key[1]++;
     3fc:	a1 d4 7d 00 00       	mov    0x7dd4,%eax
     401:	83 c0 01             	add    $0x1,%eax
     404:	a3 d4 7d 00 00       	mov    %eax,0x7dd4
		my_tower[floor][temp.x][temp.y] = Background;
     409:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     40f:	8b 55 f0             	mov    -0x10(%ebp),%edx
     412:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     415:	89 d0                	mov    %edx,%eax
     417:	c1 e0 02             	shl    $0x2,%eax
     41a:	01 d0                	add    %edx,%eax
     41c:	01 c0                	add    %eax,%eax
     41e:	6b d3 64             	imul   $0x64,%ebx,%edx
     421:	01 d0                	add    %edx,%eax
     423:	01 c8                	add    %ecx,%eax
     425:	c7 04 85 20 79 00 00 	movl   $0x0,0x7920(,%eax,4)
     42c:	00 00 00 00 
		position = temp;
     430:	8b 45 f0             	mov    -0x10(%ebp),%eax
     433:	8b 55 f4             	mov    -0xc(%ebp),%edx
     436:	a3 5c 78 00 00       	mov    %eax,0x785c
     43b:	89 15 60 78 00 00    	mov    %edx,0x7860
		break;
     441:	e9 72 01 00 00       	jmp    5b8 <keyDown+0x4e8>
	case RedKey:
		my_key[2]++;
     446:	a1 d8 7d 00 00       	mov    0x7dd8,%eax
     44b:	83 c0 01             	add    $0x1,%eax
     44e:	a3 d8 7d 00 00       	mov    %eax,0x7dd8
		my_tower[floor][temp.x][temp.y] = Background;
     453:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     459:	8b 55 f0             	mov    -0x10(%ebp),%edx
     45c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     45f:	89 d0                	mov    %edx,%eax
     461:	c1 e0 02             	shl    $0x2,%eax
     464:	01 d0                	add    %edx,%eax
     466:	01 c0                	add    %eax,%eax
     468:	6b d3 64             	imul   $0x64,%ebx,%edx
     46b:	01 d0                	add    %edx,%eax
     46d:	01 c8                	add    %ecx,%eax
     46f:	c7 04 85 20 79 00 00 	movl   $0x0,0x7920(,%eax,4)
     476:	00 00 00 00 
		position = temp;
     47a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     47d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     480:	a3 5c 78 00 00       	mov    %eax,0x785c
     485:	89 15 60 78 00 00    	mov    %edx,0x7860
		break;
     48b:	e9 28 01 00 00       	jmp    5b8 <keyDown+0x4e8>
	case SBlood:
		hp += 100;
     490:	a1 10 79 00 00       	mov    0x7910,%eax
     495:	83 c0 64             	add    $0x64,%eax
     498:	a3 10 79 00 00       	mov    %eax,0x7910
		my_tower[floor][temp.x][temp.y] = Background;
     49d:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     4a3:	8b 55 f0             	mov    -0x10(%ebp),%edx
     4a6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     4a9:	89 d0                	mov    %edx,%eax
     4ab:	c1 e0 02             	shl    $0x2,%eax
     4ae:	01 d0                	add    %edx,%eax
     4b0:	01 c0                	add    %eax,%eax
     4b2:	6b d3 64             	imul   $0x64,%ebx,%edx
     4b5:	01 d0                	add    %edx,%eax
     4b7:	01 c8                	add    %ecx,%eax
     4b9:	c7 04 85 20 79 00 00 	movl   $0x0,0x7920(,%eax,4)
     4c0:	00 00 00 00 
		position = temp;
     4c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
     4ca:	a3 5c 78 00 00       	mov    %eax,0x785c
     4cf:	89 15 60 78 00 00    	mov    %edx,0x7860
		break;
     4d5:	e9 de 00 00 00       	jmp    5b8 <keyDown+0x4e8>
	case LBlood:
		hp += 500;
     4da:	a1 10 79 00 00       	mov    0x7910,%eax
     4df:	05 f4 01 00 00       	add    $0x1f4,%eax
     4e4:	a3 10 79 00 00       	mov    %eax,0x7910
		my_tower[floor][temp.x][temp.y] = Background;
     4e9:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     4ef:	8b 55 f0             	mov    -0x10(%ebp),%edx
     4f2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     4f5:	89 d0                	mov    %edx,%eax
     4f7:	c1 e0 02             	shl    $0x2,%eax
     4fa:	01 d0                	add    %edx,%eax
     4fc:	01 c0                	add    %eax,%eax
     4fe:	6b d3 64             	imul   $0x64,%ebx,%edx
     501:	01 d0                	add    %edx,%eax
     503:	01 c8                	add    %ecx,%eax
     505:	c7 04 85 20 79 00 00 	movl   $0x0,0x7920(,%eax,4)
     50c:	00 00 00 00 
		position = temp;
     510:	8b 45 f0             	mov    -0x10(%ebp),%eax
     513:	8b 55 f4             	mov    -0xc(%ebp),%edx
     516:	a3 5c 78 00 00       	mov    %eax,0x785c
     51b:	89 15 60 78 00 00    	mov    %edx,0x7860
		break;
     521:	e9 92 00 00 00       	jmp    5b8 <keyDown+0x4e8>
	case Attack:
		atk += 1;
     526:	a1 40 78 00 00       	mov    0x7840,%eax
     52b:	83 c0 01             	add    $0x1,%eax
     52e:	a3 40 78 00 00       	mov    %eax,0x7840
		my_tower[floor][temp.x][temp.y] = Background;
     533:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     539:	8b 55 f0             	mov    -0x10(%ebp),%edx
     53c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     53f:	89 d0                	mov    %edx,%eax
     541:	c1 e0 02             	shl    $0x2,%eax
     544:	01 d0                	add    %edx,%eax
     546:	01 c0                	add    %eax,%eax
     548:	6b d3 64             	imul   $0x64,%ebx,%edx
     54b:	01 d0                	add    %edx,%eax
     54d:	01 c8                	add    %ecx,%eax
     54f:	c7 04 85 20 79 00 00 	movl   $0x0,0x7920(,%eax,4)
     556:	00 00 00 00 
		position = temp;
     55a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     55d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     560:	a3 5c 78 00 00       	mov    %eax,0x785c
     565:	89 15 60 78 00 00    	mov    %edx,0x7860
		break;
     56b:	eb 4b                	jmp    5b8 <keyDown+0x4e8>
	case Defend:
		def += 1;
     56d:	a1 44 78 00 00       	mov    0x7844,%eax
     572:	83 c0 01             	add    $0x1,%eax
     575:	a3 44 78 00 00       	mov    %eax,0x7844
		my_tower[floor][temp.x][temp.y] = Background;
     57a:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     580:	8b 55 f0             	mov    -0x10(%ebp),%edx
     583:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     586:	89 d0                	mov    %edx,%eax
     588:	c1 e0 02             	shl    $0x2,%eax
     58b:	01 d0                	add    %edx,%eax
     58d:	01 c0                	add    %eax,%eax
     58f:	6b d3 64             	imul   $0x64,%ebx,%edx
     592:	01 d0                	add    %edx,%eax
     594:	01 c8                	add    %ecx,%eax
     596:	c7 04 85 20 79 00 00 	movl   $0x0,0x7920(,%eax,4)
     59d:	00 00 00 00 
		position = temp;
     5a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
     5a7:	a3 5c 78 00 00       	mov    %eax,0x785c
     5ac:	89 15 60 78 00 00    	mov    %edx,0x7860
		break;	
     5b2:	eb 04                	jmp    5b8 <keyDown+0x4e8>
	default:
		break;
     5b4:	90                   	nop
     5b5:	eb 01                	jmp    5b8 <keyDown+0x4e8>
		position = temp;
		if(!fight())
		{
		printf(1,"Dead");
		}
		break;
     5b7:	90                   	nop
		position = temp;
		break;	
	default:
		break;
}
my_tower[floor][position.x][position.y] = Valiant;
     5b8:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     5be:	8b 15 5c 78 00 00    	mov    0x785c,%edx
     5c4:	8b 0d 60 78 00 00    	mov    0x7860,%ecx
     5ca:	89 d0                	mov    %edx,%eax
     5cc:	c1 e0 02             	shl    $0x2,%eax
     5cf:	01 d0                	add    %edx,%eax
     5d1:	01 c0                	add    %eax,%eax
     5d3:	6b d3 64             	imul   $0x64,%ebx,%edx
     5d6:	01 d0                	add    %edx,%eax
     5d8:	01 c8                	add    %ecx,%eax
     5da:	c7 04 85 20 79 00 00 	movl   $0x5,0x7920(,%eax,4)
     5e1:	05 00 00 00 
     5e5:	eb 01                	jmp    5e8 <keyDown+0x518>

		temp = nextpoint(position,Right);
		break;
	case VK_ESC:

		return ;
     5e7:	90                   	nop
		break;	
	default:
		break;
}
my_tower[floor][position.x][position.y] = Valiant;
}
     5e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5eb:	c9                   	leave  
     5ec:	c3                   	ret    

000005ed <TowerInit>:

void TowerInit()
{
     5ed:	55                   	push   %ebp
     5ee:	89 e5                	mov    %esp,%ebp
     5f0:	83 ec 10             	sub    $0x10,%esp
for (int i = 0;i < BLOCK_NUM_X;i++)
     5f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     5fa:	e9 aa 00 00 00       	jmp    6a9 <TowerInit+0xbc>
{
for (int j = 0;j < BLOCK_NUM_Y;j++)
     5ff:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
     606:	e9 90 00 00 00       	jmp    69b <TowerInit+0xae>
{
my_tower[0][i][j] =my_tower[1][i][j] =my_tower[2][i][j] = Background;
     60b:	8b 55 fc             	mov    -0x4(%ebp),%edx
     60e:	89 d0                	mov    %edx,%eax
     610:	c1 e0 02             	shl    $0x2,%eax
     613:	01 d0                	add    %edx,%eax
     615:	01 c0                	add    %eax,%eax
     617:	8b 55 f8             	mov    -0x8(%ebp),%edx
     61a:	01 d0                	add    %edx,%eax
     61c:	05 c8 00 00 00       	add    $0xc8,%eax
     621:	c7 04 85 20 79 00 00 	movl   $0x0,0x7920(,%eax,4)
     628:	00 00 00 00 
     62c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     62f:	89 d0                	mov    %edx,%eax
     631:	c1 e0 02             	shl    $0x2,%eax
     634:	01 d0                	add    %edx,%eax
     636:	01 c0                	add    %eax,%eax
     638:	8b 55 f8             	mov    -0x8(%ebp),%edx
     63b:	01 d0                	add    %edx,%eax
     63d:	05 c8 00 00 00       	add    $0xc8,%eax
     642:	8b 0c 85 20 79 00 00 	mov    0x7920(,%eax,4),%ecx
     649:	8b 55 fc             	mov    -0x4(%ebp),%edx
     64c:	89 d0                	mov    %edx,%eax
     64e:	c1 e0 02             	shl    $0x2,%eax
     651:	01 d0                	add    %edx,%eax
     653:	01 c0                	add    %eax,%eax
     655:	8b 55 f8             	mov    -0x8(%ebp),%edx
     658:	01 d0                	add    %edx,%eax
     65a:	83 c0 64             	add    $0x64,%eax
     65d:	89 0c 85 20 79 00 00 	mov    %ecx,0x7920(,%eax,4)
     664:	8b 55 fc             	mov    -0x4(%ebp),%edx
     667:	89 d0                	mov    %edx,%eax
     669:	c1 e0 02             	shl    $0x2,%eax
     66c:	01 d0                	add    %edx,%eax
     66e:	01 c0                	add    %eax,%eax
     670:	8b 55 f8             	mov    -0x8(%ebp),%edx
     673:	01 d0                	add    %edx,%eax
     675:	83 c0 64             	add    $0x64,%eax
     678:	8b 0c 85 20 79 00 00 	mov    0x7920(,%eax,4),%ecx
     67f:	8b 55 fc             	mov    -0x4(%ebp),%edx
     682:	89 d0                	mov    %edx,%eax
     684:	c1 e0 02             	shl    $0x2,%eax
     687:	01 d0                	add    %edx,%eax
     689:	01 c0                	add    %eax,%eax
     68b:	8b 55 f8             	mov    -0x8(%ebp),%edx
     68e:	01 d0                	add    %edx,%eax
     690:	89 0c 85 20 79 00 00 	mov    %ecx,0x7920(,%eax,4)

void TowerInit()
{
for (int i = 0;i < BLOCK_NUM_X;i++)
{
for (int j = 0;j < BLOCK_NUM_Y;j++)
     697:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     69b:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
     69f:	0f 8e 66 ff ff ff    	jle    60b <TowerInit+0x1e>
my_tower[floor][position.x][position.y] = Valiant;
}

void TowerInit()
{
for (int i = 0;i < BLOCK_NUM_X;i++)
     6a5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     6a9:	83 7d fc 09          	cmpl   $0x9,-0x4(%ebp)
     6ad:	0f 8e 4c ff ff ff    	jle    5ff <TowerInit+0x12>
}
}
//init my_tower


}//init the tower
     6b3:	90                   	nop
     6b4:	c9                   	leave  
     6b5:	c3                   	ret    

000006b6 <init>:

void init(AHwnd hwnd)
{
     6b6:	55                   	push   %ebp
     6b7:	89 e5                	mov    %esp,%ebp
     6b9:	53                   	push   %ebx
     6ba:	83 ec 14             	sub    $0x14,%esp
	TowerInit();
     6bd:	e8 2b ff ff ff       	call   5ed <TowerInit>

	hp = START_HP;
     6c2:	c7 05 10 79 00 00 f4 	movl   $0x1f4,0x7910
     6c9:	01 00 00 
	atk = START_ATK;
     6cc:	c7 05 40 78 00 00 0a 	movl   $0xa,0x7840
     6d3:	00 00 00 
	def = START_DEF;
     6d6:	c7 05 44 78 00 00 0a 	movl   $0xa,0x7844
     6dd:	00 00 00 
	//init the Viliant

	floor = 0;
     6e0:	c7 05 4c 78 00 00 00 	movl   $0x0,0x784c
     6e7:	00 00 00 
	position.x = position.y = 0;
     6ea:	c7 05 60 78 00 00 00 	movl   $0x0,0x7860
     6f1:	00 00 00 
     6f4:	a1 60 78 00 00       	mov    0x7860,%eax
     6f9:	a3 5c 78 00 00       	mov    %eax,0x785c
	my_tower[floor][position.x][position.y] = Valiant;
     6fe:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     704:	8b 15 5c 78 00 00    	mov    0x785c,%edx
     70a:	8b 0d 60 78 00 00    	mov    0x7860,%ecx
     710:	89 d0                	mov    %edx,%eax
     712:	c1 e0 02             	shl    $0x2,%eax
     715:	01 d0                	add    %edx,%eax
     717:	01 c0                	add    %eax,%eax
     719:	6b d3 64             	imul   $0x64,%ebx,%edx
     71c:	01 d0                	add    %edx,%eax
     71e:	01 c8                	add    %ecx,%eax
     720:	c7 04 85 20 79 00 00 	movl   $0x5,0x7920(,%eax,4)
     727:	05 00 00 00 
	my_key[0] = 3;
     72b:	c7 05 d0 7d 00 00 03 	movl   $0x3,0x7dd0
     732:	00 00 00 
	my_key[1] = my_key[2] = 0;
     735:	c7 05 d8 7d 00 00 00 	movl   $0x0,0x7dd8
     73c:	00 00 00 
     73f:	a1 d8 7d 00 00       	mov    0x7dd8,%eax
     744:	a3 d4 7d 00 00       	mov    %eax,0x7dd4
 lblood = APLoadBitmap ("lblood.bmp");
 attack = APLoadBitmap ("attack1.bmp");
 defend = APLoadBitmap ("defend.bmp");*/
	//bitmap init	
	AMessage msg;
	msg.type = MSG_PAINT;
     749:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
	msg.param = 0;
     750:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	APSendMessage(hwnd,msg);
     757:	ff 75 f4             	pushl  -0xc(%ebp)
     75a:	ff 75 f0             	pushl  -0x10(%ebp)
     75d:	ff 75 ec             	pushl  -0x14(%ebp)
     760:	ff 75 08             	pushl  0x8(%ebp)
     763:	e8 d5 1a 00 00       	call   223d <APSendMessage>
     768:	83 c4 10             	add    $0x10,%esp

}
     76b:	90                   	nop
     76c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     76f:	c9                   	leave  
     770:	c3                   	ret    

00000771 <fight>:


bool fight()
{
     771:	55                   	push   %ebp
     772:	89 e5                	mov    %esp,%ebp
     774:	53                   	push   %ebx
     775:	83 ec 10             	sub    $0x10,%esp
int mhp,matk,mdef,mid;
switch(my_tower[floor][position.x][position.y])
     778:	8b 1d 4c 78 00 00    	mov    0x784c,%ebx
     77e:	8b 15 5c 78 00 00    	mov    0x785c,%edx
     784:	8b 0d 60 78 00 00    	mov    0x7860,%ecx
     78a:	89 d0                	mov    %edx,%eax
     78c:	c1 e0 02             	shl    $0x2,%eax
     78f:	01 d0                	add    %edx,%eax
     791:	01 c0                	add    %eax,%eax
     793:	6b d3 64             	imul   $0x64,%ebx,%edx
     796:	01 d0                	add    %edx,%eax
     798:	01 c8                	add    %ecx,%eax
     79a:	8b 04 85 20 79 00 00 	mov    0x7920(,%eax,4),%eax
     7a1:	83 f8 03             	cmp    $0x3,%eax
     7a4:	74 13                	je     7b9 <fight+0x48>
     7a6:	83 f8 04             	cmp    $0x4,%eax
     7a9:	74 17                	je     7c2 <fight+0x51>
     7ab:	83 f8 02             	cmp    $0x2,%eax
     7ae:	75 1b                	jne    7cb <fight+0x5a>
{
	case Monster1:
	mid = 0;
     7b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	break;
     7b7:	eb 1a                	jmp    7d3 <fight+0x62>
	case Monster2:
	mid = 1;
     7b9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	break;
     7c0:	eb 11                	jmp    7d3 <fight+0x62>
	case Monster3:
	mid = 2;
     7c2:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
	break;
     7c9:	eb 08                	jmp    7d3 <fight+0x62>
	default:
	mid = 0;
     7cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	break;
     7d2:	90                   	nop
}
mhp = monster_info[mid][0];
     7d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
     7d6:	89 d0                	mov    %edx,%eax
     7d8:	01 c0                	add    %eax,%eax
     7da:	01 d0                	add    %edx,%eax
     7dc:	c1 e0 02             	shl    $0x2,%eax
     7df:	05 80 78 00 00       	add    $0x7880,%eax
     7e4:	8b 00                	mov    (%eax),%eax
     7e6:	89 45 f8             	mov    %eax,-0x8(%ebp)
matk = monster_info[mid][1];
     7e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     7ec:	89 d0                	mov    %edx,%eax
     7ee:	01 c0                	add    %eax,%eax
     7f0:	01 d0                	add    %edx,%eax
     7f2:	c1 e0 02             	shl    $0x2,%eax
     7f5:	05 84 78 00 00       	add    $0x7884,%eax
     7fa:	8b 00                	mov    (%eax),%eax
     7fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
mdef = monster_info[mid][2];//load monster info
     7ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
     802:	89 d0                	mov    %edx,%eax
     804:	01 c0                	add    %eax,%eax
     806:	01 d0                	add    %edx,%eax
     808:	c1 e0 02             	shl    $0x2,%eax
     80b:	05 88 78 00 00       	add    $0x7888,%eax
     810:	8b 00                	mov    (%eax),%eax
     812:	89 45 ec             	mov    %eax,-0x14(%ebp)
if (atk <= mdef)
     815:	a1 40 78 00 00       	mov    0x7840,%eax
     81a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     81d:	7f 07                	jg     826 <fight+0xb5>
{
	return false;
     81f:	b8 00 00 00 00       	mov    $0x0,%eax
     824:	eb 4e                	jmp    874 <fight+0x103>
}//cannot win
while(true)
{
	mhp -= (atk - mdef);
     826:	a1 40 78 00 00       	mov    0x7840,%eax
     82b:	2b 45 ec             	sub    -0x14(%ebp),%eax
     82e:	29 45 f8             	sub    %eax,-0x8(%ebp)
	if (mhp <= 0)
     831:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     835:	7f 07                	jg     83e <fight+0xcd>
	{
		return true;
     837:	b8 01 00 00 00       	mov    $0x1,%eax
     83c:	eb 36                	jmp    874 <fight+0x103>
	}
	if (matk < def)
     83e:	a1 44 78 00 00       	mov    0x7844,%eax
     843:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     846:	7c 29                	jl     871 <fight+0x100>
	{
		continue;
	}
	hp -= (matk - def);
     848:	a1 10 79 00 00       	mov    0x7910,%eax
     84d:	8b 15 44 78 00 00    	mov    0x7844,%edx
     853:	8b 4d f0             	mov    -0x10(%ebp),%ecx
     856:	29 d1                	sub    %edx,%ecx
     858:	89 ca                	mov    %ecx,%edx
     85a:	29 d0                	sub    %edx,%eax
     85c:	a3 10 79 00 00       	mov    %eax,0x7910
	if (hp <= 0)
     861:	a1 10 79 00 00       	mov    0x7910,%eax
     866:	85 c0                	test   %eax,%eax
     868:	7f bc                	jg     826 <fight+0xb5>
	{
		return false;
     86a:	b8 00 00 00 00       	mov    $0x0,%eax
     86f:	eb 03                	jmp    874 <fight+0x103>
	{
		return true;
	}
	if (matk < def)
	{
		continue;
     871:	90                   	nop
	hp -= (matk - def);
	if (hp <= 0)
	{
		return false;
	}
}
     872:	eb b2                	jmp    826 <fight+0xb5>

//
}
     874:	83 c4 10             	add    $0x10,%esp
     877:	5b                   	pop    %ebx
     878:	5d                   	pop    %ebp
     879:	c3                   	ret    

0000087a <draw>:



void draw(AHwnd hwnd)
{
     87a:	55                   	push   %ebp
     87b:	89 e5                	mov    %esp,%ebp
     87d:	57                   	push   %edi
     87e:	56                   	push   %esi
     87f:	53                   	push   %ebx
     880:	83 ec 3c             	sub    $0x3c,%esp
ABitmap temp;
for (int i = 0;i < BLOCK_NUM_X;i++)
     883:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
     88a:	e9 cd 03 00 00       	jmp    c5c <draw+0x3e2>
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
     88f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
     896:	e9 b3 03 00 00       	jmp    c4e <draw+0x3d4>
	{
		switch(my_tower[floor][i][j])
     89b:	8b 0d 4c 78 00 00    	mov    0x784c,%ecx
     8a1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     8a4:	89 d0                	mov    %edx,%eax
     8a6:	c1 e0 02             	shl    $0x2,%eax
     8a9:	01 d0                	add    %edx,%eax
     8ab:	01 c0                	add    %eax,%eax
     8ad:	6b d1 64             	imul   $0x64,%ecx,%edx
     8b0:	01 c2                	add    %eax,%edx
     8b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
     8b5:	01 d0                	add    %edx,%eax
     8b7:	8b 04 85 20 79 00 00 	mov    0x7920(,%eax,4),%eax
     8be:	83 f8 11             	cmp    $0x11,%eax
     8c1:	0f 87 f4 02 00 00    	ja     bbb <draw+0x341>
     8c7:	8b 04 85 14 33 00 00 	mov    0x3314(,%eax,4),%eax
     8ce:	ff e0                	jmp    *%eax
		{
		case Background:
			//temp = background;
			temp = APLoadBitmap ("background.bmp");
     8d0:	8d 45 d0             	lea    -0x30(%ebp),%eax
     8d3:	83 ec 08             	sub    $0x8,%esp
     8d6:	68 34 32 00 00       	push   $0x3234
     8db:	50                   	push   %eax
     8dc:	e8 35 0d 00 00       	call   1616 <APLoadBitmap>
     8e1:	83 c4 0c             	add    $0xc,%esp
			break;
     8e4:	e9 f9 02 00 00       	jmp    be2 <draw+0x368>
		case Wall:
			//temp = wall;
			temp = APLoadBitmap ("wall.bmp");
     8e9:	8d 45 b8             	lea    -0x48(%ebp),%eax
     8ec:	83 ec 08             	sub    $0x8,%esp
     8ef:	68 43 32 00 00       	push   $0x3243
     8f4:	50                   	push   %eax
     8f5:	e8 1c 0d 00 00       	call   1616 <APLoadBitmap>
     8fa:	83 c4 0c             	add    $0xc,%esp
     8fd:	8b 45 b8             	mov    -0x48(%ebp),%eax
     900:	89 45 d0             	mov    %eax,-0x30(%ebp)
     903:	8b 45 bc             	mov    -0x44(%ebp),%eax
     906:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     909:	8b 45 c0             	mov    -0x40(%ebp),%eax
     90c:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     90f:	e9 ce 02 00 00       	jmp    be2 <draw+0x368>
		case Monster1:
			//temp = monster1;
			temp = APLoadBitmap ("monster1.bmp");
     914:	8d 45 b8             	lea    -0x48(%ebp),%eax
     917:	83 ec 08             	sub    $0x8,%esp
     91a:	68 4c 32 00 00       	push   $0x324c
     91f:	50                   	push   %eax
     920:	e8 f1 0c 00 00       	call   1616 <APLoadBitmap>
     925:	83 c4 0c             	add    $0xc,%esp
     928:	8b 45 b8             	mov    -0x48(%ebp),%eax
     92b:	89 45 d0             	mov    %eax,-0x30(%ebp)
     92e:	8b 45 bc             	mov    -0x44(%ebp),%eax
     931:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     934:	8b 45 c0             	mov    -0x40(%ebp),%eax
     937:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     93a:	e9 a3 02 00 00       	jmp    be2 <draw+0x368>
		case Monster2:
			//temp = monster2;
			temp = APLoadBitmap ("monster2.bmp");
     93f:	8d 45 b8             	lea    -0x48(%ebp),%eax
     942:	83 ec 08             	sub    $0x8,%esp
     945:	68 59 32 00 00       	push   $0x3259
     94a:	50                   	push   %eax
     94b:	e8 c6 0c 00 00       	call   1616 <APLoadBitmap>
     950:	83 c4 0c             	add    $0xc,%esp
     953:	8b 45 b8             	mov    -0x48(%ebp),%eax
     956:	89 45 d0             	mov    %eax,-0x30(%ebp)
     959:	8b 45 bc             	mov    -0x44(%ebp),%eax
     95c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     95f:	8b 45 c0             	mov    -0x40(%ebp),%eax
     962:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     965:	e9 78 02 00 00       	jmp    be2 <draw+0x368>
		case Monster3:
			//temp = monster3;
			temp = APLoadBitmap ("monster3.bmp");
     96a:	8d 45 b8             	lea    -0x48(%ebp),%eax
     96d:	83 ec 08             	sub    $0x8,%esp
     970:	68 66 32 00 00       	push   $0x3266
     975:	50                   	push   %eax
     976:	e8 9b 0c 00 00       	call   1616 <APLoadBitmap>
     97b:	83 c4 0c             	add    $0xc,%esp
     97e:	8b 45 b8             	mov    -0x48(%ebp),%eax
     981:	89 45 d0             	mov    %eax,-0x30(%ebp)
     984:	8b 45 bc             	mov    -0x44(%ebp),%eax
     987:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     98a:	8b 45 c0             	mov    -0x40(%ebp),%eax
     98d:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     990:	e9 4d 02 00 00       	jmp    be2 <draw+0x368>
		case Valiant:
			//temp = valiant;
			temp = APLoadBitmap ("valiant.bmp");
     995:	8d 45 b8             	lea    -0x48(%ebp),%eax
     998:	83 ec 08             	sub    $0x8,%esp
     99b:	68 73 32 00 00       	push   $0x3273
     9a0:	50                   	push   %eax
     9a1:	e8 70 0c 00 00       	call   1616 <APLoadBitmap>
     9a6:	83 c4 0c             	add    $0xc,%esp
     9a9:	8b 45 b8             	mov    -0x48(%ebp),%eax
     9ac:	89 45 d0             	mov    %eax,-0x30(%ebp)
     9af:	8b 45 bc             	mov    -0x44(%ebp),%eax
     9b2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     9b5:	8b 45 c0             	mov    -0x40(%ebp),%eax
     9b8:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     9bb:	e9 22 02 00 00       	jmp    be2 <draw+0x368>
		case YellowDoor:
			//temp = yellowdoor;
			temp = APLoadBitmap ("yellowdoor.bmp");
     9c0:	8d 45 b8             	lea    -0x48(%ebp),%eax
     9c3:	83 ec 08             	sub    $0x8,%esp
     9c6:	68 7f 32 00 00       	push   $0x327f
     9cb:	50                   	push   %eax
     9cc:	e8 45 0c 00 00       	call   1616 <APLoadBitmap>
     9d1:	83 c4 0c             	add    $0xc,%esp
     9d4:	8b 45 b8             	mov    -0x48(%ebp),%eax
     9d7:	89 45 d0             	mov    %eax,-0x30(%ebp)
     9da:	8b 45 bc             	mov    -0x44(%ebp),%eax
     9dd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     9e0:	8b 45 c0             	mov    -0x40(%ebp),%eax
     9e3:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     9e6:	e9 f7 01 00 00       	jmp    be2 <draw+0x368>
		case BlueDoor:
			//temp = bluedoor;
			temp = APLoadBitmap ("bluedoor.bmp");
     9eb:	8d 45 b8             	lea    -0x48(%ebp),%eax
     9ee:	83 ec 08             	sub    $0x8,%esp
     9f1:	68 8e 32 00 00       	push   $0x328e
     9f6:	50                   	push   %eax
     9f7:	e8 1a 0c 00 00       	call   1616 <APLoadBitmap>
     9fc:	83 c4 0c             	add    $0xc,%esp
     9ff:	8b 45 b8             	mov    -0x48(%ebp),%eax
     a02:	89 45 d0             	mov    %eax,-0x30(%ebp)
     a05:	8b 45 bc             	mov    -0x44(%ebp),%eax
     a08:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     a0b:	8b 45 c0             	mov    -0x40(%ebp),%eax
     a0e:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     a11:	e9 cc 01 00 00       	jmp    be2 <draw+0x368>
		case RedDoor:
			//temp = reddoor;
			temp = APLoadBitmap ("reddoor.bmp");
     a16:	8d 45 b8             	lea    -0x48(%ebp),%eax
     a19:	83 ec 08             	sub    $0x8,%esp
     a1c:	68 9b 32 00 00       	push   $0x329b
     a21:	50                   	push   %eax
     a22:	e8 ef 0b 00 00       	call   1616 <APLoadBitmap>
     a27:	83 c4 0c             	add    $0xc,%esp
     a2a:	8b 45 b8             	mov    -0x48(%ebp),%eax
     a2d:	89 45 d0             	mov    %eax,-0x30(%ebp)
     a30:	8b 45 bc             	mov    -0x44(%ebp),%eax
     a33:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     a36:	8b 45 c0             	mov    -0x40(%ebp),%eax
     a39:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     a3c:	e9 a1 01 00 00       	jmp    be2 <draw+0x368>
		case UpStair:
			//temp = upstair;
			temp = APLoadBitmap ("upstair.bmp");
     a41:	8d 45 b8             	lea    -0x48(%ebp),%eax
     a44:	83 ec 08             	sub    $0x8,%esp
     a47:	68 a7 32 00 00       	push   $0x32a7
     a4c:	50                   	push   %eax
     a4d:	e8 c4 0b 00 00       	call   1616 <APLoadBitmap>
     a52:	83 c4 0c             	add    $0xc,%esp
     a55:	8b 45 b8             	mov    -0x48(%ebp),%eax
     a58:	89 45 d0             	mov    %eax,-0x30(%ebp)
     a5b:	8b 45 bc             	mov    -0x44(%ebp),%eax
     a5e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     a61:	8b 45 c0             	mov    -0x40(%ebp),%eax
     a64:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     a67:	e9 76 01 00 00       	jmp    be2 <draw+0x368>
		case DownStair:
			//temp = downstair;
			temp = APLoadBitmap ("downstair.bmp");
     a6c:	8d 45 b8             	lea    -0x48(%ebp),%eax
     a6f:	83 ec 08             	sub    $0x8,%esp
     a72:	68 b3 32 00 00       	push   $0x32b3
     a77:	50                   	push   %eax
     a78:	e8 99 0b 00 00       	call   1616 <APLoadBitmap>
     a7d:	83 c4 0c             	add    $0xc,%esp
     a80:	8b 45 b8             	mov    -0x48(%ebp),%eax
     a83:	89 45 d0             	mov    %eax,-0x30(%ebp)
     a86:	8b 45 bc             	mov    -0x44(%ebp),%eax
     a89:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     a8c:	8b 45 c0             	mov    -0x40(%ebp),%eax
     a8f:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     a92:	e9 4b 01 00 00       	jmp    be2 <draw+0x368>
		case YellowKey:
			//temp = yellowkey;
			temp = APLoadBitmap ("yellowkey.bmp");
     a97:	8d 45 b8             	lea    -0x48(%ebp),%eax
     a9a:	83 ec 08             	sub    $0x8,%esp
     a9d:	68 c1 32 00 00       	push   $0x32c1
     aa2:	50                   	push   %eax
     aa3:	e8 6e 0b 00 00       	call   1616 <APLoadBitmap>
     aa8:	83 c4 0c             	add    $0xc,%esp
     aab:	8b 45 b8             	mov    -0x48(%ebp),%eax
     aae:	89 45 d0             	mov    %eax,-0x30(%ebp)
     ab1:	8b 45 bc             	mov    -0x44(%ebp),%eax
     ab4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     ab7:	8b 45 c0             	mov    -0x40(%ebp),%eax
     aba:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     abd:	e9 20 01 00 00       	jmp    be2 <draw+0x368>
		case BlueKey:
			//temp = bluekey;
			temp = APLoadBitmap ("bluekey.bmp");
     ac2:	8d 45 b8             	lea    -0x48(%ebp),%eax
     ac5:	83 ec 08             	sub    $0x8,%esp
     ac8:	68 cf 32 00 00       	push   $0x32cf
     acd:	50                   	push   %eax
     ace:	e8 43 0b 00 00       	call   1616 <APLoadBitmap>
     ad3:	83 c4 0c             	add    $0xc,%esp
     ad6:	8b 45 b8             	mov    -0x48(%ebp),%eax
     ad9:	89 45 d0             	mov    %eax,-0x30(%ebp)
     adc:	8b 45 bc             	mov    -0x44(%ebp),%eax
     adf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     ae2:	8b 45 c0             	mov    -0x40(%ebp),%eax
     ae5:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     ae8:	e9 f5 00 00 00       	jmp    be2 <draw+0x368>
		case RedKey:
			//temp = redkey;
			temp = APLoadBitmap ("redkey.bmp");
     aed:	8d 45 b8             	lea    -0x48(%ebp),%eax
     af0:	83 ec 08             	sub    $0x8,%esp
     af3:	68 db 32 00 00       	push   $0x32db
     af8:	50                   	push   %eax
     af9:	e8 18 0b 00 00       	call   1616 <APLoadBitmap>
     afe:	83 c4 0c             	add    $0xc,%esp
     b01:	8b 45 b8             	mov    -0x48(%ebp),%eax
     b04:	89 45 d0             	mov    %eax,-0x30(%ebp)
     b07:	8b 45 bc             	mov    -0x44(%ebp),%eax
     b0a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     b0d:	8b 45 c0             	mov    -0x40(%ebp),%eax
     b10:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     b13:	e9 ca 00 00 00       	jmp    be2 <draw+0x368>
		case SBlood:
			//temp = sblood;
			temp = APLoadBitmap ("sblood.bmp");
     b18:	8d 45 b8             	lea    -0x48(%ebp),%eax
     b1b:	83 ec 08             	sub    $0x8,%esp
     b1e:	68 e6 32 00 00       	push   $0x32e6
     b23:	50                   	push   %eax
     b24:	e8 ed 0a 00 00       	call   1616 <APLoadBitmap>
     b29:	83 c4 0c             	add    $0xc,%esp
     b2c:	8b 45 b8             	mov    -0x48(%ebp),%eax
     b2f:	89 45 d0             	mov    %eax,-0x30(%ebp)
     b32:	8b 45 bc             	mov    -0x44(%ebp),%eax
     b35:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     b38:	8b 45 c0             	mov    -0x40(%ebp),%eax
     b3b:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     b3e:	e9 9f 00 00 00       	jmp    be2 <draw+0x368>
		case LBlood:
			//temp = lblood;
			temp = APLoadBitmap ("lblood.bmp");
     b43:	8d 45 b8             	lea    -0x48(%ebp),%eax
     b46:	83 ec 08             	sub    $0x8,%esp
     b49:	68 f1 32 00 00       	push   $0x32f1
     b4e:	50                   	push   %eax
     b4f:	e8 c2 0a 00 00       	call   1616 <APLoadBitmap>
     b54:	83 c4 0c             	add    $0xc,%esp
     b57:	8b 45 b8             	mov    -0x48(%ebp),%eax
     b5a:	89 45 d0             	mov    %eax,-0x30(%ebp)
     b5d:	8b 45 bc             	mov    -0x44(%ebp),%eax
     b60:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     b63:	8b 45 c0             	mov    -0x40(%ebp),%eax
     b66:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     b69:	eb 77                	jmp    be2 <draw+0x368>
		case Attack:
			//temp = attack;
			temp = APLoadBitmap ("attack1.bmp");
     b6b:	8d 45 b8             	lea    -0x48(%ebp),%eax
     b6e:	83 ec 08             	sub    $0x8,%esp
     b71:	68 fc 32 00 00       	push   $0x32fc
     b76:	50                   	push   %eax
     b77:	e8 9a 0a 00 00       	call   1616 <APLoadBitmap>
     b7c:	83 c4 0c             	add    $0xc,%esp
     b7f:	8b 45 b8             	mov    -0x48(%ebp),%eax
     b82:	89 45 d0             	mov    %eax,-0x30(%ebp)
     b85:	8b 45 bc             	mov    -0x44(%ebp),%eax
     b88:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     b8b:	8b 45 c0             	mov    -0x40(%ebp),%eax
     b8e:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     b91:	eb 4f                	jmp    be2 <draw+0x368>
		case Defend:
			//temp = defend;
			temp = APLoadBitmap ("defend.bmp");
     b93:	8d 45 b8             	lea    -0x48(%ebp),%eax
     b96:	83 ec 08             	sub    $0x8,%esp
     b99:	68 08 33 00 00       	push   $0x3308
     b9e:	50                   	push   %eax
     b9f:	e8 72 0a 00 00       	call   1616 <APLoadBitmap>
     ba4:	83 c4 0c             	add    $0xc,%esp
     ba7:	8b 45 b8             	mov    -0x48(%ebp),%eax
     baa:	89 45 d0             	mov    %eax,-0x30(%ebp)
     bad:	8b 45 bc             	mov    -0x44(%ebp),%eax
     bb0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     bb3:	8b 45 c0             	mov    -0x40(%ebp),%eax
     bb6:	89 45 d8             	mov    %eax,-0x28(%ebp)
			break;
     bb9:	eb 27                	jmp    be2 <draw+0x368>
		default:
			//temp = background;
			temp = APLoadBitmap ("background.bmp");
     bbb:	8d 45 b8             	lea    -0x48(%ebp),%eax
     bbe:	83 ec 08             	sub    $0x8,%esp
     bc1:	68 34 32 00 00       	push   $0x3234
     bc6:	50                   	push   %eax
     bc7:	e8 4a 0a 00 00       	call   1616 <APLoadBitmap>
     bcc:	83 c4 0c             	add    $0xc,%esp
     bcf:	8b 45 b8             	mov    -0x48(%ebp),%eax
     bd2:	89 45 d0             	mov    %eax,-0x30(%ebp)
     bd5:	8b 45 bc             	mov    -0x44(%ebp),%eax
     bd8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     bdb:	8b 45 c0             	mov    -0x40(%ebp),%eax
     bde:	89 45 d8             	mov    %eax,-0x28(%ebp)
		break;
     be1:	90                   	nop
		}
		APDcCopy(&hwnd->Dc,i * BLOCK_WIDTH ,j * BLOCK_WIDTH,APCreateCompatibleDCFromBitmap(temp),0,0,BLOCK_WIDTH,BLOCK_WIDTH,COLOR_NULL);
     be2:	8d 45 dd             	lea    -0x23(%ebp),%eax
     be5:	6a 0c                	push   $0xc
     be7:	6a 0c                	push   $0xc
     be9:	6a 0c                	push   $0xc
     beb:	50                   	push   %eax
     bec:	e8 0f f4 ff ff       	call   0 <RGB>
     bf1:	83 c4 0c             	add    $0xc,%esp
     bf4:	83 ec 04             	sub    $0x4,%esp
     bf7:	ff 75 d8             	pushl  -0x28(%ebp)
     bfa:	ff 75 d4             	pushl  -0x2c(%ebp)
     bfd:	ff 75 d0             	pushl  -0x30(%ebp)
     c00:	e8 4b 0c 00 00       	call   1850 <APCreateCompatibleDCFromBitmap>
     c05:	83 c4 10             	add    $0x10,%esp
     c08:	89 c7                	mov    %eax,%edi
     c0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c0d:	c1 e0 05             	shl    $0x5,%eax
     c10:	89 c6                	mov    %eax,%esi
     c12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c15:	c1 e0 05             	shl    $0x5,%eax
     c18:	89 c3                	mov    %eax,%ebx
     c1a:	8b 45 08             	mov    0x8(%ebp),%eax
     c1d:	8d 48 3c             	lea    0x3c(%eax),%ecx
     c20:	83 ec 0c             	sub    $0xc,%esp
     c23:	83 ec 04             	sub    $0x4,%esp
     c26:	89 e0                	mov    %esp,%eax
     c28:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
     c2c:	66 89 10             	mov    %dx,(%eax)
     c2f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
     c33:	88 50 02             	mov    %dl,0x2(%eax)
     c36:	6a 20                	push   $0x20
     c38:	6a 20                	push   $0x20
     c3a:	6a 00                	push   $0x0
     c3c:	6a 00                	push   $0x0
     c3e:	57                   	push   %edi
     c3f:	56                   	push   %esi
     c40:	53                   	push   %ebx
     c41:	51                   	push   %ecx
     c42:	e8 0d 14 00 00       	call   2054 <APDcCopy>
     c47:	83 c4 30             	add    $0x30,%esp
void draw(AHwnd hwnd)
{
ABitmap temp;
for (int i = 0;i < BLOCK_NUM_X;i++)
{
	for (int j = 0;j < BLOCK_NUM_Y;j++)
     c4a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     c4e:	83 7d e0 09          	cmpl   $0x9,-0x20(%ebp)
     c52:	0f 8e 43 fc ff ff    	jle    89b <draw+0x21>


void draw(AHwnd hwnd)
{
ABitmap temp;
for (int i = 0;i < BLOCK_NUM_X;i++)
     c58:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     c5c:	83 7d e4 09          	cmpl   $0x9,-0x1c(%ebp)
     c60:	0f 8e 29 fc ff ff    	jle    88f <draw+0x15>
}//主体



//info
}
     c66:	90                   	nop
     c67:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c6a:	5b                   	pop    %ebx
     c6b:	5e                   	pop    %esi
     c6c:	5f                   	pop    %edi
     c6d:	5d                   	pop    %ebp
     c6e:	c3                   	ret    

00000c6f <wndProc>:

bool wndProc(AHwnd hwnd,AMessage msg)
{
     c6f:	55                   	push   %ebp
     c70:	89 e5                	mov    %esp,%ebp
     c72:	83 ec 28             	sub    $0x28,%esp
	switch(msg.type)
     c75:	8b 45 0c             	mov    0xc(%ebp),%eax
     c78:	83 f8 03             	cmp    $0x3,%eax
     c7b:	0f 84 82 00 00 00    	je     d03 <wndProc+0x94>
     c81:	83 f8 06             	cmp    $0x6,%eax
     c84:	74 4c                	je     cd2 <wndProc+0x63>
     c86:	83 f8 02             	cmp    $0x2,%eax
     c89:	74 05                	je     c90 <wndProc+0x21>
		break;
		case MSG_PAINT:
		draw(hwnd);
		break;
		default:
		break;
     c8b:	e9 82 00 00 00       	jmp    d12 <wndProc+0xa3>
{
	switch(msg.type)
	{
		    case MSG_INIT:
			
		    init(hwnd);
     c90:	83 ec 0c             	sub    $0xc,%esp
     c93:	ff 75 08             	pushl  0x8(%ebp)
     c96:	e8 1b fa ff ff       	call   6b6 <init>
     c9b:	83 c4 10             	add    $0x10,%esp
			printf(1,"init finished");
     c9e:	83 ec 08             	sub    $0x8,%esp
     ca1:	68 5c 33 00 00       	push   $0x335c
     ca6:	6a 01                	push   $0x1
     ca8:	e8 e3 04 00 00       	call   1190 <printf>
     cad:	83 c4 10             	add    $0x10,%esp
		    AMessage ms;
		    ms.type = MSG_PAINT;
     cb0:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
		    APSendMessage(hwnd,ms);  
     cb7:	ff 75 f4             	pushl  -0xc(%ebp)
     cba:	ff 75 f0             	pushl  -0x10(%ebp)
     cbd:	ff 75 ec             	pushl  -0x14(%ebp)
     cc0:	ff 75 08             	pushl  0x8(%ebp)
     cc3:	e8 75 15 00 00       	call   223d <APSendMessage>
     cc8:	83 c4 10             	add    $0x10,%esp
		    return False;
     ccb:	b8 00 00 00 00       	mov    $0x0,%eax
     cd0:	eb 54                	jmp    d26 <wndProc+0xb7>
		case MSG_KEY_DOWN:
		keyDown(hwnd,msg);
     cd2:	ff 75 14             	pushl  0x14(%ebp)
     cd5:	ff 75 10             	pushl  0x10(%ebp)
     cd8:	ff 75 0c             	pushl  0xc(%ebp)
     cdb:	ff 75 08             	pushl  0x8(%ebp)
     cde:	e8 ed f3 ff ff       	call   d0 <keyDown>
     ce3:	83 c4 10             	add    $0x10,%esp
		AMessage msg1;
		   msg1.type = MSG_PAINT;
     ce6:	c7 45 e0 03 00 00 00 	movl   $0x3,-0x20(%ebp)
		    APSendMessage(hwnd,msg1);  
     ced:	ff 75 e8             	pushl  -0x18(%ebp)
     cf0:	ff 75 e4             	pushl  -0x1c(%ebp)
     cf3:	ff 75 e0             	pushl  -0x20(%ebp)
     cf6:	ff 75 08             	pushl  0x8(%ebp)
     cf9:	e8 3f 15 00 00       	call   223d <APSendMessage>
     cfe:	83 c4 10             	add    $0x10,%esp
		break;
     d01:	eb 0f                	jmp    d12 <wndProc+0xa3>
		case MSG_PAINT:
		draw(hwnd);
     d03:	83 ec 0c             	sub    $0xc,%esp
     d06:	ff 75 08             	pushl  0x8(%ebp)
     d09:	e8 6c fb ff ff       	call   87a <draw>
     d0e:	83 c4 10             	add    $0x10,%esp
		break;
     d11:	90                   	nop
		default:
		break;
	}
	return APWndProc(hwnd,msg);
     d12:	ff 75 14             	pushl  0x14(%ebp)
     d15:	ff 75 10             	pushl  0x10(%ebp)
     d18:	ff 75 0c             	pushl  0xc(%ebp)
     d1b:	ff 75 08             	pushl  0x8(%ebp)
     d1e:	e8 9e 17 00 00       	call   24c1 <APWndProc>
     d23:	83 c4 10             	add    $0x10,%esp

}
     d26:	c9                   	leave  
     d27:	c3                   	ret    

00000d28 <main>:


int main(void)
{
     d28:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     d2c:	83 e4 f0             	and    $0xfffffff0,%esp
     d2f:	ff 71 fc             	pushl  -0x4(%ecx)
     d32:	55                   	push   %ebp
     d33:	89 e5                	mov    %esp,%ebp
     d35:	51                   	push   %ecx
     d36:	83 ec 14             	sub    $0x14,%esp
	
	AHwnd hwnd = APCreateWindow("magictower",False,0);
     d39:	83 ec 04             	sub    $0x4,%esp
     d3c:	6a 00                	push   $0x0
     d3e:	6a 00                	push   $0x0
     d40:	68 6a 33 00 00       	push   $0x336a
     d45:	e8 11 15 00 00       	call   225b <APCreateWindow>
     d4a:	83 c4 10             	add    $0x10,%esp
     d4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf(1,"magic tower created.\n");
     d50:	83 ec 08             	sub    $0x8,%esp
     d53:	68 75 33 00 00       	push   $0x3375
     d58:	6a 01                	push   $0x1
     d5a:	e8 31 04 00 00       	call   1190 <printf>
     d5f:	83 c4 10             	add    $0x10,%esp
	APWndExec(hwnd,wndProc);
     d62:	83 ec 08             	sub    $0x8,%esp
     d65:	68 6f 0c 00 00       	push   $0xc6f
     d6a:	ff 75 f4             	pushl  -0xc(%ebp)
     d6d:	e8 0b 18 00 00       	call   257d <APWndExec>
     d72:	83 c4 10             	add    $0x10,%esp
	exit();
     d75:	e8 57 02 00 00       	call   fd1 <exit>

00000d7a <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     d7a:	55                   	push   %ebp
     d7b:	89 e5                	mov    %esp,%ebp
     d7d:	57                   	push   %edi
     d7e:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     d7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d82:	8b 55 10             	mov    0x10(%ebp),%edx
     d85:	8b 45 0c             	mov    0xc(%ebp),%eax
     d88:	89 cb                	mov    %ecx,%ebx
     d8a:	89 df                	mov    %ebx,%edi
     d8c:	89 d1                	mov    %edx,%ecx
     d8e:	fc                   	cld    
     d8f:	f3 aa                	rep stos %al,%es:(%edi)
     d91:	89 ca                	mov    %ecx,%edx
     d93:	89 fb                	mov    %edi,%ebx
     d95:	89 5d 08             	mov    %ebx,0x8(%ebp)
     d98:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     d9b:	90                   	nop
     d9c:	5b                   	pop    %ebx
     d9d:	5f                   	pop    %edi
     d9e:	5d                   	pop    %ebp
     d9f:	c3                   	ret    

00000da0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     da6:	8b 45 08             	mov    0x8(%ebp),%eax
     da9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     dac:	90                   	nop
     dad:	8b 45 08             	mov    0x8(%ebp),%eax
     db0:	8d 50 01             	lea    0x1(%eax),%edx
     db3:	89 55 08             	mov    %edx,0x8(%ebp)
     db6:	8b 55 0c             	mov    0xc(%ebp),%edx
     db9:	8d 4a 01             	lea    0x1(%edx),%ecx
     dbc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     dbf:	0f b6 12             	movzbl (%edx),%edx
     dc2:	88 10                	mov    %dl,(%eax)
     dc4:	0f b6 00             	movzbl (%eax),%eax
     dc7:	84 c0                	test   %al,%al
     dc9:	75 e2                	jne    dad <strcpy+0xd>
    ;
  return os;
     dcb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     dce:	c9                   	leave  
     dcf:	c3                   	ret    

00000dd0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     dd0:	55                   	push   %ebp
     dd1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     dd3:	eb 08                	jmp    ddd <strcmp+0xd>
    p++, q++;
     dd5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     dd9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     ddd:	8b 45 08             	mov    0x8(%ebp),%eax
     de0:	0f b6 00             	movzbl (%eax),%eax
     de3:	84 c0                	test   %al,%al
     de5:	74 10                	je     df7 <strcmp+0x27>
     de7:	8b 45 08             	mov    0x8(%ebp),%eax
     dea:	0f b6 10             	movzbl (%eax),%edx
     ded:	8b 45 0c             	mov    0xc(%ebp),%eax
     df0:	0f b6 00             	movzbl (%eax),%eax
     df3:	38 c2                	cmp    %al,%dl
     df5:	74 de                	je     dd5 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     df7:	8b 45 08             	mov    0x8(%ebp),%eax
     dfa:	0f b6 00             	movzbl (%eax),%eax
     dfd:	0f b6 d0             	movzbl %al,%edx
     e00:	8b 45 0c             	mov    0xc(%ebp),%eax
     e03:	0f b6 00             	movzbl (%eax),%eax
     e06:	0f b6 c0             	movzbl %al,%eax
     e09:	29 c2                	sub    %eax,%edx
     e0b:	89 d0                	mov    %edx,%eax
}
     e0d:	5d                   	pop    %ebp
     e0e:	c3                   	ret    

00000e0f <strlen>:

uint
strlen(char *s)
{
     e0f:	55                   	push   %ebp
     e10:	89 e5                	mov    %esp,%ebp
     e12:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     e15:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     e1c:	eb 04                	jmp    e22 <strlen+0x13>
     e1e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     e22:	8b 55 fc             	mov    -0x4(%ebp),%edx
     e25:	8b 45 08             	mov    0x8(%ebp),%eax
     e28:	01 d0                	add    %edx,%eax
     e2a:	0f b6 00             	movzbl (%eax),%eax
     e2d:	84 c0                	test   %al,%al
     e2f:	75 ed                	jne    e1e <strlen+0xf>
    ;
  return n;
     e31:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e34:	c9                   	leave  
     e35:	c3                   	ret    

00000e36 <memset>:

void*
memset(void *dst, int c, uint n)
{
     e36:	55                   	push   %ebp
     e37:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     e39:	8b 45 10             	mov    0x10(%ebp),%eax
     e3c:	50                   	push   %eax
     e3d:	ff 75 0c             	pushl  0xc(%ebp)
     e40:	ff 75 08             	pushl  0x8(%ebp)
     e43:	e8 32 ff ff ff       	call   d7a <stosb>
     e48:	83 c4 0c             	add    $0xc,%esp
  return dst;
     e4b:	8b 45 08             	mov    0x8(%ebp),%eax
}
     e4e:	c9                   	leave  
     e4f:	c3                   	ret    

00000e50 <strchr>:

char*
strchr(const char *s, char c)
{
     e50:	55                   	push   %ebp
     e51:	89 e5                	mov    %esp,%ebp
     e53:	83 ec 04             	sub    $0x4,%esp
     e56:	8b 45 0c             	mov    0xc(%ebp),%eax
     e59:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     e5c:	eb 14                	jmp    e72 <strchr+0x22>
    if(*s == c)
     e5e:	8b 45 08             	mov    0x8(%ebp),%eax
     e61:	0f b6 00             	movzbl (%eax),%eax
     e64:	3a 45 fc             	cmp    -0x4(%ebp),%al
     e67:	75 05                	jne    e6e <strchr+0x1e>
      return (char*)s;
     e69:	8b 45 08             	mov    0x8(%ebp),%eax
     e6c:	eb 13                	jmp    e81 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     e6e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     e72:	8b 45 08             	mov    0x8(%ebp),%eax
     e75:	0f b6 00             	movzbl (%eax),%eax
     e78:	84 c0                	test   %al,%al
     e7a:	75 e2                	jne    e5e <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     e7c:	b8 00 00 00 00       	mov    $0x0,%eax
}
     e81:	c9                   	leave  
     e82:	c3                   	ret    

00000e83 <gets>:

char*
gets(char *buf, int max)
{
     e83:	55                   	push   %ebp
     e84:	89 e5                	mov    %esp,%ebp
     e86:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e89:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e90:	eb 42                	jmp    ed4 <gets+0x51>
    cc = read(0, &c, 1);
     e92:	83 ec 04             	sub    $0x4,%esp
     e95:	6a 01                	push   $0x1
     e97:	8d 45 ef             	lea    -0x11(%ebp),%eax
     e9a:	50                   	push   %eax
     e9b:	6a 00                	push   $0x0
     e9d:	e8 47 01 00 00       	call   fe9 <read>
     ea2:	83 c4 10             	add    $0x10,%esp
     ea5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     ea8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     eac:	7e 33                	jle    ee1 <gets+0x5e>
      break;
    buf[i++] = c;
     eae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eb1:	8d 50 01             	lea    0x1(%eax),%edx
     eb4:	89 55 f4             	mov    %edx,-0xc(%ebp)
     eb7:	89 c2                	mov    %eax,%edx
     eb9:	8b 45 08             	mov    0x8(%ebp),%eax
     ebc:	01 c2                	add    %eax,%edx
     ebe:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     ec2:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     ec4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     ec8:	3c 0a                	cmp    $0xa,%al
     eca:	74 16                	je     ee2 <gets+0x5f>
     ecc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     ed0:	3c 0d                	cmp    $0xd,%al
     ed2:	74 0e                	je     ee2 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ed4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ed7:	83 c0 01             	add    $0x1,%eax
     eda:	3b 45 0c             	cmp    0xc(%ebp),%eax
     edd:	7c b3                	jl     e92 <gets+0xf>
     edf:	eb 01                	jmp    ee2 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     ee1:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     ee2:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ee5:	8b 45 08             	mov    0x8(%ebp),%eax
     ee8:	01 d0                	add    %edx,%eax
     eea:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     eed:	8b 45 08             	mov    0x8(%ebp),%eax
}
     ef0:	c9                   	leave  
     ef1:	c3                   	ret    

00000ef2 <stat>:

int
stat(char *n, struct stat *st)
{
     ef2:	55                   	push   %ebp
     ef3:	89 e5                	mov    %esp,%ebp
     ef5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     ef8:	83 ec 08             	sub    $0x8,%esp
     efb:	6a 00                	push   $0x0
     efd:	ff 75 08             	pushl  0x8(%ebp)
     f00:	e8 0c 01 00 00       	call   1011 <open>
     f05:	83 c4 10             	add    $0x10,%esp
     f08:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     f0b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     f0f:	79 07                	jns    f18 <stat+0x26>
    return -1;
     f11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     f16:	eb 25                	jmp    f3d <stat+0x4b>
  r = fstat(fd, st);
     f18:	83 ec 08             	sub    $0x8,%esp
     f1b:	ff 75 0c             	pushl  0xc(%ebp)
     f1e:	ff 75 f4             	pushl  -0xc(%ebp)
     f21:	e8 03 01 00 00       	call   1029 <fstat>
     f26:	83 c4 10             	add    $0x10,%esp
     f29:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     f2c:	83 ec 0c             	sub    $0xc,%esp
     f2f:	ff 75 f4             	pushl  -0xc(%ebp)
     f32:	e8 c2 00 00 00       	call   ff9 <close>
     f37:	83 c4 10             	add    $0x10,%esp
  return r;
     f3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     f3d:	c9                   	leave  
     f3e:	c3                   	ret    

00000f3f <atoi>:

int
atoi(const char *s)
{
     f3f:	55                   	push   %ebp
     f40:	89 e5                	mov    %esp,%ebp
     f42:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     f45:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     f4c:	eb 25                	jmp    f73 <atoi+0x34>
    n = n*10 + *s++ - '0';
     f4e:	8b 55 fc             	mov    -0x4(%ebp),%edx
     f51:	89 d0                	mov    %edx,%eax
     f53:	c1 e0 02             	shl    $0x2,%eax
     f56:	01 d0                	add    %edx,%eax
     f58:	01 c0                	add    %eax,%eax
     f5a:	89 c1                	mov    %eax,%ecx
     f5c:	8b 45 08             	mov    0x8(%ebp),%eax
     f5f:	8d 50 01             	lea    0x1(%eax),%edx
     f62:	89 55 08             	mov    %edx,0x8(%ebp)
     f65:	0f b6 00             	movzbl (%eax),%eax
     f68:	0f be c0             	movsbl %al,%eax
     f6b:	01 c8                	add    %ecx,%eax
     f6d:	83 e8 30             	sub    $0x30,%eax
     f70:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     f73:	8b 45 08             	mov    0x8(%ebp),%eax
     f76:	0f b6 00             	movzbl (%eax),%eax
     f79:	3c 2f                	cmp    $0x2f,%al
     f7b:	7e 0a                	jle    f87 <atoi+0x48>
     f7d:	8b 45 08             	mov    0x8(%ebp),%eax
     f80:	0f b6 00             	movzbl (%eax),%eax
     f83:	3c 39                	cmp    $0x39,%al
     f85:	7e c7                	jle    f4e <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     f87:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     f8a:	c9                   	leave  
     f8b:	c3                   	ret    

00000f8c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     f8c:	55                   	push   %ebp
     f8d:	89 e5                	mov    %esp,%ebp
     f8f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     f92:	8b 45 08             	mov    0x8(%ebp),%eax
     f95:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     f98:	8b 45 0c             	mov    0xc(%ebp),%eax
     f9b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     f9e:	eb 17                	jmp    fb7 <memmove+0x2b>
    *dst++ = *src++;
     fa0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     fa3:	8d 50 01             	lea    0x1(%eax),%edx
     fa6:	89 55 fc             	mov    %edx,-0x4(%ebp)
     fa9:	8b 55 f8             	mov    -0x8(%ebp),%edx
     fac:	8d 4a 01             	lea    0x1(%edx),%ecx
     faf:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     fb2:	0f b6 12             	movzbl (%edx),%edx
     fb5:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     fb7:	8b 45 10             	mov    0x10(%ebp),%eax
     fba:	8d 50 ff             	lea    -0x1(%eax),%edx
     fbd:	89 55 10             	mov    %edx,0x10(%ebp)
     fc0:	85 c0                	test   %eax,%eax
     fc2:	7f dc                	jg     fa0 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     fc4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     fc7:	c9                   	leave  
     fc8:	c3                   	ret    

00000fc9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     fc9:	b8 01 00 00 00       	mov    $0x1,%eax
     fce:	cd 40                	int    $0x40
     fd0:	c3                   	ret    

00000fd1 <exit>:
SYSCALL(exit)
     fd1:	b8 02 00 00 00       	mov    $0x2,%eax
     fd6:	cd 40                	int    $0x40
     fd8:	c3                   	ret    

00000fd9 <wait>:
SYSCALL(wait)
     fd9:	b8 03 00 00 00       	mov    $0x3,%eax
     fde:	cd 40                	int    $0x40
     fe0:	c3                   	ret    

00000fe1 <pipe>:
SYSCALL(pipe)
     fe1:	b8 04 00 00 00       	mov    $0x4,%eax
     fe6:	cd 40                	int    $0x40
     fe8:	c3                   	ret    

00000fe9 <read>:
SYSCALL(read)
     fe9:	b8 05 00 00 00       	mov    $0x5,%eax
     fee:	cd 40                	int    $0x40
     ff0:	c3                   	ret    

00000ff1 <write>:
SYSCALL(write)
     ff1:	b8 10 00 00 00       	mov    $0x10,%eax
     ff6:	cd 40                	int    $0x40
     ff8:	c3                   	ret    

00000ff9 <close>:
SYSCALL(close)
     ff9:	b8 15 00 00 00       	mov    $0x15,%eax
     ffe:	cd 40                	int    $0x40
    1000:	c3                   	ret    

00001001 <kill>:
SYSCALL(kill)
    1001:	b8 06 00 00 00       	mov    $0x6,%eax
    1006:	cd 40                	int    $0x40
    1008:	c3                   	ret    

00001009 <exec>:
SYSCALL(exec)
    1009:	b8 07 00 00 00       	mov    $0x7,%eax
    100e:	cd 40                	int    $0x40
    1010:	c3                   	ret    

00001011 <open>:
SYSCALL(open)
    1011:	b8 0f 00 00 00       	mov    $0xf,%eax
    1016:	cd 40                	int    $0x40
    1018:	c3                   	ret    

00001019 <mknod>:
SYSCALL(mknod)
    1019:	b8 11 00 00 00       	mov    $0x11,%eax
    101e:	cd 40                	int    $0x40
    1020:	c3                   	ret    

00001021 <unlink>:
SYSCALL(unlink)
    1021:	b8 12 00 00 00       	mov    $0x12,%eax
    1026:	cd 40                	int    $0x40
    1028:	c3                   	ret    

00001029 <fstat>:
SYSCALL(fstat)
    1029:	b8 08 00 00 00       	mov    $0x8,%eax
    102e:	cd 40                	int    $0x40
    1030:	c3                   	ret    

00001031 <link>:
SYSCALL(link)
    1031:	b8 13 00 00 00       	mov    $0x13,%eax
    1036:	cd 40                	int    $0x40
    1038:	c3                   	ret    

00001039 <mkdir>:
SYSCALL(mkdir)
    1039:	b8 14 00 00 00       	mov    $0x14,%eax
    103e:	cd 40                	int    $0x40
    1040:	c3                   	ret    

00001041 <chdir>:
SYSCALL(chdir)
    1041:	b8 09 00 00 00       	mov    $0x9,%eax
    1046:	cd 40                	int    $0x40
    1048:	c3                   	ret    

00001049 <dup>:
SYSCALL(dup)
    1049:	b8 0a 00 00 00       	mov    $0xa,%eax
    104e:	cd 40                	int    $0x40
    1050:	c3                   	ret    

00001051 <getpid>:
SYSCALL(getpid)
    1051:	b8 0b 00 00 00       	mov    $0xb,%eax
    1056:	cd 40                	int    $0x40
    1058:	c3                   	ret    

00001059 <sbrk>:
SYSCALL(sbrk)
    1059:	b8 0c 00 00 00       	mov    $0xc,%eax
    105e:	cd 40                	int    $0x40
    1060:	c3                   	ret    

00001061 <sleep>:
SYSCALL(sleep)
    1061:	b8 0d 00 00 00       	mov    $0xd,%eax
    1066:	cd 40                	int    $0x40
    1068:	c3                   	ret    

00001069 <uptime>:
SYSCALL(uptime)
    1069:	b8 0e 00 00 00       	mov    $0xe,%eax
    106e:	cd 40                	int    $0x40
    1070:	c3                   	ret    

00001071 <paintWindow>:

SYSCALL(paintWindow)
    1071:	b8 16 00 00 00       	mov    $0x16,%eax
    1076:	cd 40                	int    $0x40
    1078:	c3                   	ret    

00001079 <sendMessage>:
SYSCALL(sendMessage)
    1079:	b8 17 00 00 00       	mov    $0x17,%eax
    107e:	cd 40                	int    $0x40
    1080:	c3                   	ret    

00001081 <getMessage>:
SYSCALL(getMessage)
    1081:	b8 19 00 00 00       	mov    $0x19,%eax
    1086:	cd 40                	int    $0x40
    1088:	c3                   	ret    

00001089 <registWindow>:
SYSCALL(registWindow)
    1089:	b8 18 00 00 00       	mov    $0x18,%eax
    108e:	cd 40                	int    $0x40
    1090:	c3                   	ret    

00001091 <changePosition>:
SYSCALL(changePosition)
    1091:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1096:	cd 40                	int    $0x40
    1098:	c3                   	ret    

00001099 <setupTimer>:
SYSCALL(setupTimer)
    1099:	b8 1b 00 00 00       	mov    $0x1b,%eax
    109e:	cd 40                	int    $0x40
    10a0:	c3                   	ret    

000010a1 <deleteTimer>:
SYSCALL(deleteTimer)
    10a1:	b8 1c 00 00 00       	mov    $0x1c,%eax
    10a6:	cd 40                	int    $0x40
    10a8:	c3                   	ret    

000010a9 <getCurrentTime>:
SYSCALL(getCurrentTime)
    10a9:	b8 1d 00 00 00       	mov    $0x1d,%eax
    10ae:	cd 40                	int    $0x40
    10b0:	c3                   	ret    

000010b1 <removeWindow>:
SYSCALL(removeWindow)
    10b1:	b8 1e 00 00 00       	mov    $0x1e,%eax
    10b6:	cd 40                	int    $0x40
    10b8:	c3                   	ret    

000010b9 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    10b9:	55                   	push   %ebp
    10ba:	89 e5                	mov    %esp,%ebp
    10bc:	83 ec 18             	sub    $0x18,%esp
    10bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    10c2:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    10c5:	83 ec 04             	sub    $0x4,%esp
    10c8:	6a 01                	push   $0x1
    10ca:	8d 45 f4             	lea    -0xc(%ebp),%eax
    10cd:	50                   	push   %eax
    10ce:	ff 75 08             	pushl  0x8(%ebp)
    10d1:	e8 1b ff ff ff       	call   ff1 <write>
    10d6:	83 c4 10             	add    $0x10,%esp
}
    10d9:	90                   	nop
    10da:	c9                   	leave  
    10db:	c3                   	ret    

000010dc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    10dc:	55                   	push   %ebp
    10dd:	89 e5                	mov    %esp,%ebp
    10df:	53                   	push   %ebx
    10e0:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    10e3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    10ea:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    10ee:	74 17                	je     1107 <printint+0x2b>
    10f0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10f4:	79 11                	jns    1107 <printint+0x2b>
    neg = 1;
    10f6:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    10fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    1100:	f7 d8                	neg    %eax
    1102:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1105:	eb 06                	jmp    110d <printint+0x31>
  } else {
    x = xx;
    1107:	8b 45 0c             	mov    0xc(%ebp),%eax
    110a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    110d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1114:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1117:	8d 41 01             	lea    0x1(%ecx),%eax
    111a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    111d:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1120:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1123:	ba 00 00 00 00       	mov    $0x0,%edx
    1128:	f7 f3                	div    %ebx
    112a:	89 d0                	mov    %edx,%eax
    112c:	0f b6 80 c0 3b 00 00 	movzbl 0x3bc0(%eax),%eax
    1133:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1137:	8b 5d 10             	mov    0x10(%ebp),%ebx
    113a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    113d:	ba 00 00 00 00       	mov    $0x0,%edx
    1142:	f7 f3                	div    %ebx
    1144:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1147:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    114b:	75 c7                	jne    1114 <printint+0x38>
  if(neg)
    114d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1151:	74 2d                	je     1180 <printint+0xa4>
    buf[i++] = '-';
    1153:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1156:	8d 50 01             	lea    0x1(%eax),%edx
    1159:	89 55 f4             	mov    %edx,-0xc(%ebp)
    115c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1161:	eb 1d                	jmp    1180 <printint+0xa4>
    putc(fd, buf[i]);
    1163:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1166:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1169:	01 d0                	add    %edx,%eax
    116b:	0f b6 00             	movzbl (%eax),%eax
    116e:	0f be c0             	movsbl %al,%eax
    1171:	83 ec 08             	sub    $0x8,%esp
    1174:	50                   	push   %eax
    1175:	ff 75 08             	pushl  0x8(%ebp)
    1178:	e8 3c ff ff ff       	call   10b9 <putc>
    117d:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1180:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1184:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1188:	79 d9                	jns    1163 <printint+0x87>
    putc(fd, buf[i]);
}
    118a:	90                   	nop
    118b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    118e:	c9                   	leave  
    118f:	c3                   	ret    

00001190 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1196:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    119d:	8d 45 0c             	lea    0xc(%ebp),%eax
    11a0:	83 c0 04             	add    $0x4,%eax
    11a3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    11a6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    11ad:	e9 59 01 00 00       	jmp    130b <printf+0x17b>
    c = fmt[i] & 0xff;
    11b2:	8b 55 0c             	mov    0xc(%ebp),%edx
    11b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11b8:	01 d0                	add    %edx,%eax
    11ba:	0f b6 00             	movzbl (%eax),%eax
    11bd:	0f be c0             	movsbl %al,%eax
    11c0:	25 ff 00 00 00       	and    $0xff,%eax
    11c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    11c8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11cc:	75 2c                	jne    11fa <printf+0x6a>
      if(c == '%'){
    11ce:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    11d2:	75 0c                	jne    11e0 <printf+0x50>
        state = '%';
    11d4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    11db:	e9 27 01 00 00       	jmp    1307 <printf+0x177>
      } else {
        putc(fd, c);
    11e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11e3:	0f be c0             	movsbl %al,%eax
    11e6:	83 ec 08             	sub    $0x8,%esp
    11e9:	50                   	push   %eax
    11ea:	ff 75 08             	pushl  0x8(%ebp)
    11ed:	e8 c7 fe ff ff       	call   10b9 <putc>
    11f2:	83 c4 10             	add    $0x10,%esp
    11f5:	e9 0d 01 00 00       	jmp    1307 <printf+0x177>
      }
    } else if(state == '%'){
    11fa:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    11fe:	0f 85 03 01 00 00    	jne    1307 <printf+0x177>
      if(c == 'd'){
    1204:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1208:	75 1e                	jne    1228 <printf+0x98>
        printint(fd, *ap, 10, 1);
    120a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    120d:	8b 00                	mov    (%eax),%eax
    120f:	6a 01                	push   $0x1
    1211:	6a 0a                	push   $0xa
    1213:	50                   	push   %eax
    1214:	ff 75 08             	pushl  0x8(%ebp)
    1217:	e8 c0 fe ff ff       	call   10dc <printint>
    121c:	83 c4 10             	add    $0x10,%esp
        ap++;
    121f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1223:	e9 d8 00 00 00       	jmp    1300 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1228:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    122c:	74 06                	je     1234 <printf+0xa4>
    122e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1232:	75 1e                	jne    1252 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    1234:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1237:	8b 00                	mov    (%eax),%eax
    1239:	6a 00                	push   $0x0
    123b:	6a 10                	push   $0x10
    123d:	50                   	push   %eax
    123e:	ff 75 08             	pushl  0x8(%ebp)
    1241:	e8 96 fe ff ff       	call   10dc <printint>
    1246:	83 c4 10             	add    $0x10,%esp
        ap++;
    1249:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    124d:	e9 ae 00 00 00       	jmp    1300 <printf+0x170>
      } else if(c == 's'){
    1252:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1256:	75 43                	jne    129b <printf+0x10b>
        s = (char*)*ap;
    1258:	8b 45 e8             	mov    -0x18(%ebp),%eax
    125b:	8b 00                	mov    (%eax),%eax
    125d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1260:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1264:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1268:	75 25                	jne    128f <printf+0xff>
          s = "(null)";
    126a:	c7 45 f4 8b 33 00 00 	movl   $0x338b,-0xc(%ebp)
        while(*s != 0){
    1271:	eb 1c                	jmp    128f <printf+0xff>
          putc(fd, *s);
    1273:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1276:	0f b6 00             	movzbl (%eax),%eax
    1279:	0f be c0             	movsbl %al,%eax
    127c:	83 ec 08             	sub    $0x8,%esp
    127f:	50                   	push   %eax
    1280:	ff 75 08             	pushl  0x8(%ebp)
    1283:	e8 31 fe ff ff       	call   10b9 <putc>
    1288:	83 c4 10             	add    $0x10,%esp
          s++;
    128b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    128f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1292:	0f b6 00             	movzbl (%eax),%eax
    1295:	84 c0                	test   %al,%al
    1297:	75 da                	jne    1273 <printf+0xe3>
    1299:	eb 65                	jmp    1300 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    129b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    129f:	75 1d                	jne    12be <printf+0x12e>
        putc(fd, *ap);
    12a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12a4:	8b 00                	mov    (%eax),%eax
    12a6:	0f be c0             	movsbl %al,%eax
    12a9:	83 ec 08             	sub    $0x8,%esp
    12ac:	50                   	push   %eax
    12ad:	ff 75 08             	pushl  0x8(%ebp)
    12b0:	e8 04 fe ff ff       	call   10b9 <putc>
    12b5:	83 c4 10             	add    $0x10,%esp
        ap++;
    12b8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    12bc:	eb 42                	jmp    1300 <printf+0x170>
      } else if(c == '%'){
    12be:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    12c2:	75 17                	jne    12db <printf+0x14b>
        putc(fd, c);
    12c4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12c7:	0f be c0             	movsbl %al,%eax
    12ca:	83 ec 08             	sub    $0x8,%esp
    12cd:	50                   	push   %eax
    12ce:	ff 75 08             	pushl  0x8(%ebp)
    12d1:	e8 e3 fd ff ff       	call   10b9 <putc>
    12d6:	83 c4 10             	add    $0x10,%esp
    12d9:	eb 25                	jmp    1300 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    12db:	83 ec 08             	sub    $0x8,%esp
    12de:	6a 25                	push   $0x25
    12e0:	ff 75 08             	pushl  0x8(%ebp)
    12e3:	e8 d1 fd ff ff       	call   10b9 <putc>
    12e8:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    12eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12ee:	0f be c0             	movsbl %al,%eax
    12f1:	83 ec 08             	sub    $0x8,%esp
    12f4:	50                   	push   %eax
    12f5:	ff 75 08             	pushl  0x8(%ebp)
    12f8:	e8 bc fd ff ff       	call   10b9 <putc>
    12fd:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1300:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1307:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    130b:	8b 55 0c             	mov    0xc(%ebp),%edx
    130e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1311:	01 d0                	add    %edx,%eax
    1313:	0f b6 00             	movzbl (%eax),%eax
    1316:	84 c0                	test   %al,%al
    1318:	0f 85 94 fe ff ff    	jne    11b2 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    131e:	90                   	nop
    131f:	c9                   	leave  
    1320:	c3                   	ret    

00001321 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1321:	55                   	push   %ebp
    1322:	89 e5                	mov    %esp,%ebp
    1324:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1327:	8b 45 08             	mov    0x8(%ebp),%eax
    132a:	83 e8 08             	sub    $0x8,%eax
    132d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1330:	a1 28 78 00 00       	mov    0x7828,%eax
    1335:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1338:	eb 24                	jmp    135e <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    133a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    133d:	8b 00                	mov    (%eax),%eax
    133f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1342:	77 12                	ja     1356 <free+0x35>
    1344:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1347:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    134a:	77 24                	ja     1370 <free+0x4f>
    134c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    134f:	8b 00                	mov    (%eax),%eax
    1351:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1354:	77 1a                	ja     1370 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1356:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1359:	8b 00                	mov    (%eax),%eax
    135b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    135e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1361:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1364:	76 d4                	jbe    133a <free+0x19>
    1366:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1369:	8b 00                	mov    (%eax),%eax
    136b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    136e:	76 ca                	jbe    133a <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1370:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1373:	8b 40 04             	mov    0x4(%eax),%eax
    1376:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    137d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1380:	01 c2                	add    %eax,%edx
    1382:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1385:	8b 00                	mov    (%eax),%eax
    1387:	39 c2                	cmp    %eax,%edx
    1389:	75 24                	jne    13af <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    138b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    138e:	8b 50 04             	mov    0x4(%eax),%edx
    1391:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1394:	8b 00                	mov    (%eax),%eax
    1396:	8b 40 04             	mov    0x4(%eax),%eax
    1399:	01 c2                	add    %eax,%edx
    139b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    139e:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    13a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13a4:	8b 00                	mov    (%eax),%eax
    13a6:	8b 10                	mov    (%eax),%edx
    13a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13ab:	89 10                	mov    %edx,(%eax)
    13ad:	eb 0a                	jmp    13b9 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    13af:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13b2:	8b 10                	mov    (%eax),%edx
    13b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13b7:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    13b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13bc:	8b 40 04             	mov    0x4(%eax),%eax
    13bf:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    13c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13c9:	01 d0                	add    %edx,%eax
    13cb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13ce:	75 20                	jne    13f0 <free+0xcf>
    p->s.size += bp->s.size;
    13d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13d3:	8b 50 04             	mov    0x4(%eax),%edx
    13d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13d9:	8b 40 04             	mov    0x4(%eax),%eax
    13dc:	01 c2                	add    %eax,%edx
    13de:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13e1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    13e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13e7:	8b 10                	mov    (%eax),%edx
    13e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13ec:	89 10                	mov    %edx,(%eax)
    13ee:	eb 08                	jmp    13f8 <free+0xd7>
  } else
    p->s.ptr = bp;
    13f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13f3:	8b 55 f8             	mov    -0x8(%ebp),%edx
    13f6:	89 10                	mov    %edx,(%eax)
  freep = p;
    13f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13fb:	a3 28 78 00 00       	mov    %eax,0x7828
}
    1400:	90                   	nop
    1401:	c9                   	leave  
    1402:	c3                   	ret    

00001403 <morecore>:

static Header*
morecore(uint nu)
{
    1403:	55                   	push   %ebp
    1404:	89 e5                	mov    %esp,%ebp
    1406:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1409:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1410:	77 07                	ja     1419 <morecore+0x16>
    nu = 4096;
    1412:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1419:	8b 45 08             	mov    0x8(%ebp),%eax
    141c:	c1 e0 03             	shl    $0x3,%eax
    141f:	83 ec 0c             	sub    $0xc,%esp
    1422:	50                   	push   %eax
    1423:	e8 31 fc ff ff       	call   1059 <sbrk>
    1428:	83 c4 10             	add    $0x10,%esp
    142b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    142e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1432:	75 07                	jne    143b <morecore+0x38>
    return 0;
    1434:	b8 00 00 00 00       	mov    $0x0,%eax
    1439:	eb 26                	jmp    1461 <morecore+0x5e>
  hp = (Header*)p;
    143b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1441:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1444:	8b 55 08             	mov    0x8(%ebp),%edx
    1447:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    144a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    144d:	83 c0 08             	add    $0x8,%eax
    1450:	83 ec 0c             	sub    $0xc,%esp
    1453:	50                   	push   %eax
    1454:	e8 c8 fe ff ff       	call   1321 <free>
    1459:	83 c4 10             	add    $0x10,%esp
  return freep;
    145c:	a1 28 78 00 00       	mov    0x7828,%eax
}
    1461:	c9                   	leave  
    1462:	c3                   	ret    

00001463 <malloc>:

void*
malloc(uint nbytes)
{
    1463:	55                   	push   %ebp
    1464:	89 e5                	mov    %esp,%ebp
    1466:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1469:	8b 45 08             	mov    0x8(%ebp),%eax
    146c:	83 c0 07             	add    $0x7,%eax
    146f:	c1 e8 03             	shr    $0x3,%eax
    1472:	83 c0 01             	add    $0x1,%eax
    1475:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1478:	a1 28 78 00 00       	mov    0x7828,%eax
    147d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1480:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1484:	75 23                	jne    14a9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1486:	c7 45 f0 20 78 00 00 	movl   $0x7820,-0x10(%ebp)
    148d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1490:	a3 28 78 00 00       	mov    %eax,0x7828
    1495:	a1 28 78 00 00       	mov    0x7828,%eax
    149a:	a3 20 78 00 00       	mov    %eax,0x7820
    base.s.size = 0;
    149f:	c7 05 24 78 00 00 00 	movl   $0x0,0x7824
    14a6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    14a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14ac:	8b 00                	mov    (%eax),%eax
    14ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    14b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b4:	8b 40 04             	mov    0x4(%eax),%eax
    14b7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    14ba:	72 4d                	jb     1509 <malloc+0xa6>
      if(p->s.size == nunits)
    14bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14bf:	8b 40 04             	mov    0x4(%eax),%eax
    14c2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    14c5:	75 0c                	jne    14d3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    14c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ca:	8b 10                	mov    (%eax),%edx
    14cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14cf:	89 10                	mov    %edx,(%eax)
    14d1:	eb 26                	jmp    14f9 <malloc+0x96>
      else {
        p->s.size -= nunits;
    14d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d6:	8b 40 04             	mov    0x4(%eax),%eax
    14d9:	2b 45 ec             	sub    -0x14(%ebp),%eax
    14dc:	89 c2                	mov    %eax,%edx
    14de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    14e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e7:	8b 40 04             	mov    0x4(%eax),%eax
    14ea:	c1 e0 03             	shl    $0x3,%eax
    14ed:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    14f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f3:	8b 55 ec             	mov    -0x14(%ebp),%edx
    14f6:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    14f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14fc:	a3 28 78 00 00       	mov    %eax,0x7828
      return (void*)(p + 1);
    1501:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1504:	83 c0 08             	add    $0x8,%eax
    1507:	eb 3b                	jmp    1544 <malloc+0xe1>
    }
    if(p == freep)
    1509:	a1 28 78 00 00       	mov    0x7828,%eax
    150e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1511:	75 1e                	jne    1531 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    1513:	83 ec 0c             	sub    $0xc,%esp
    1516:	ff 75 ec             	pushl  -0x14(%ebp)
    1519:	e8 e5 fe ff ff       	call   1403 <morecore>
    151e:	83 c4 10             	add    $0x10,%esp
    1521:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1524:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1528:	75 07                	jne    1531 <malloc+0xce>
        return 0;
    152a:	b8 00 00 00 00       	mov    $0x0,%eax
    152f:	eb 13                	jmp    1544 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1531:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1534:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1537:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153a:	8b 00                	mov    (%eax),%eax
    153c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    153f:	e9 6d ff ff ff       	jmp    14b1 <malloc+0x4e>
}
    1544:	c9                   	leave  
    1545:	c3                   	ret    

00001546 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1546:	55                   	push   %ebp
    1547:	89 e5                	mov    %esp,%ebp
    1549:	83 ec 1c             	sub    $0x1c,%esp
    154c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    154f:	8b 55 10             	mov    0x10(%ebp),%edx
    1552:	8b 45 14             	mov    0x14(%ebp),%eax
    1555:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1558:	88 55 e8             	mov    %dl,-0x18(%ebp)
    155b:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    155e:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1562:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1565:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1569:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    156c:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1570:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1573:	8b 45 08             	mov    0x8(%ebp),%eax
    1576:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    157a:	66 89 10             	mov    %dx,(%eax)
    157d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1581:	88 50 02             	mov    %dl,0x2(%eax)
}
    1584:	8b 45 08             	mov    0x8(%ebp),%eax
    1587:	c9                   	leave  
    1588:	c2 04 00             	ret    $0x4

0000158b <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    158b:	55                   	push   %ebp
    158c:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
    158e:	8b 45 08             	mov    0x8(%ebp),%eax
    1591:	2b 45 10             	sub    0x10(%ebp),%eax
    1594:	89 c2                	mov    %eax,%edx
    1596:	8b 45 08             	mov    0x8(%ebp),%eax
    1599:	2b 45 10             	sub    0x10(%ebp),%eax
    159c:	0f af d0             	imul   %eax,%edx
    159f:	8b 45 0c             	mov    0xc(%ebp),%eax
    15a2:	2b 45 14             	sub    0x14(%ebp),%eax
    15a5:	89 c1                	mov    %eax,%ecx
    15a7:	8b 45 0c             	mov    0xc(%ebp),%eax
    15aa:	2b 45 14             	sub    0x14(%ebp),%eax
    15ad:	0f af c1             	imul   %ecx,%eax
    15b0:	01 d0                	add    %edx,%eax
}
    15b2:	5d                   	pop    %ebp
    15b3:	c3                   	ret    

000015b4 <abs_int>:

static inline int abs_int(int x)
{
    15b4:	55                   	push   %ebp
    15b5:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
    15b7:	8b 45 08             	mov    0x8(%ebp),%eax
    15ba:	99                   	cltd   
    15bb:	89 d0                	mov    %edx,%eax
    15bd:	33 45 08             	xor    0x8(%ebp),%eax
    15c0:	29 d0                	sub    %edx,%eax
}
    15c2:	5d                   	pop    %ebp
    15c3:	c3                   	ret    

000015c4 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    15c4:	55                   	push   %ebp
    15c5:	89 e5                	mov    %esp,%ebp
    if (x < 0)
    15c7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    15cb:	79 07                	jns    15d4 <APGetIndex+0x10>
        return X_SMALLER;
    15cd:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    15d2:	eb 40                	jmp    1614 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
    15d4:	8b 45 08             	mov    0x8(%ebp),%eax
    15d7:	8b 00                	mov    (%eax),%eax
    15d9:	3b 45 0c             	cmp    0xc(%ebp),%eax
    15dc:	7f 07                	jg     15e5 <APGetIndex+0x21>
        return X_BIGGER;
    15de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    15e3:	eb 2f                	jmp    1614 <APGetIndex+0x50>
    if (y < 0)
    15e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    15e9:	79 07                	jns    15f2 <APGetIndex+0x2e>
        return Y_SMALLER;
    15eb:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
    15f0:	eb 22                	jmp    1614 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
    15f2:	8b 45 08             	mov    0x8(%ebp),%eax
    15f5:	8b 40 04             	mov    0x4(%eax),%eax
    15f8:	3b 45 10             	cmp    0x10(%ebp),%eax
    15fb:	7f 07                	jg     1604 <APGetIndex+0x40>
        return Y_BIGGER;
    15fd:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    1602:	eb 10                	jmp    1614 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
    1604:	8b 45 08             	mov    0x8(%ebp),%eax
    1607:	8b 00                	mov    (%eax),%eax
    1609:	0f af 45 10          	imul   0x10(%ebp),%eax
    160d:	89 c2                	mov    %eax,%edx
    160f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1612:	01 d0                	add    %edx,%eax
}
    1614:	5d                   	pop    %ebp
    1615:	c3                   	ret    

00001616 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    1616:	55                   	push   %ebp
    1617:	89 e5                	mov    %esp,%ebp
    1619:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    161c:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    1623:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1626:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    1629:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    1630:	83 ec 08             	sub    $0x8,%esp
    1633:	6a 00                	push   $0x0
    1635:	ff 75 0c             	pushl  0xc(%ebp)
    1638:	e8 d4 f9 ff ff       	call   1011 <open>
    163d:	83 c4 10             	add    $0x10,%esp
    1640:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    1643:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1647:	79 2e                	jns    1677 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
    1649:	83 ec 04             	sub    $0x4,%esp
    164c:	ff 75 0c             	pushl  0xc(%ebp)
    164f:	68 92 33 00 00       	push   $0x3392
    1654:	6a 01                	push   $0x1
    1656:	e8 35 fb ff ff       	call   1190 <printf>
    165b:	83 c4 10             	add    $0x10,%esp
        return bmp;
    165e:	8b 45 08             	mov    0x8(%ebp),%eax
    1661:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1664:	89 10                	mov    %edx,(%eax)
    1666:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1669:	89 50 04             	mov    %edx,0x4(%eax)
    166c:	8b 55 d0             	mov    -0x30(%ebp),%edx
    166f:	89 50 08             	mov    %edx,0x8(%eax)
    1672:	e9 d2 01 00 00       	jmp    1849 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    1677:	83 ec 04             	sub    $0x4,%esp
    167a:	6a 0e                	push   $0xe
    167c:	8d 45 ba             	lea    -0x46(%ebp),%eax
    167f:	50                   	push   %eax
    1680:	ff 75 ec             	pushl  -0x14(%ebp)
    1683:	e8 61 f9 ff ff       	call   fe9 <read>
    1688:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    168b:	83 ec 04             	sub    $0x4,%esp
    168e:	6a 28                	push   $0x28
    1690:	8d 45 92             	lea    -0x6e(%ebp),%eax
    1693:	50                   	push   %eax
    1694:	ff 75 ec             	pushl  -0x14(%ebp)
    1697:	e8 4d f9 ff ff       	call   fe9 <read>
    169c:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    169f:	8b 45 96             	mov    -0x6a(%ebp),%eax
    16a2:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    16a5:	8b 45 9a             	mov    -0x66(%ebp),%eax
    16a8:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    16ab:	8b 55 c8             	mov    -0x38(%ebp),%edx
    16ae:	8b 45 cc             	mov    -0x34(%ebp),%eax
    16b1:	0f af d0             	imul   %eax,%edx
    16b4:	89 d0                	mov    %edx,%eax
    16b6:	01 c0                	add    %eax,%eax
    16b8:	01 d0                	add    %edx,%eax
    16ba:	83 ec 0c             	sub    $0xc,%esp
    16bd:	50                   	push   %eax
    16be:	e8 a0 fd ff ff       	call   1463 <malloc>
    16c3:	83 c4 10             	add    $0x10,%esp
    16c6:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    16c9:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    16cd:	0f b7 c0             	movzwl %ax,%eax
    16d0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    16d3:	8b 55 c8             	mov    -0x38(%ebp),%edx
    16d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16d9:	0f af c2             	imul   %edx,%eax
    16dc:	83 c0 1f             	add    $0x1f,%eax
    16df:	c1 e8 05             	shr    $0x5,%eax
    16e2:	c1 e0 02             	shl    $0x2,%eax
    16e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    16e8:	8b 55 cc             	mov    -0x34(%ebp),%edx
    16eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16ee:	0f af c2             	imul   %edx,%eax
    16f1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    16f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    16f7:	83 ec 0c             	sub    $0xc,%esp
    16fa:	50                   	push   %eax
    16fb:	e8 63 fd ff ff       	call   1463 <malloc>
    1700:	83 c4 10             	add    $0x10,%esp
    1703:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    1706:	83 ec 04             	sub    $0x4,%esp
    1709:	ff 75 e0             	pushl  -0x20(%ebp)
    170c:	ff 75 dc             	pushl  -0x24(%ebp)
    170f:	ff 75 ec             	pushl  -0x14(%ebp)
    1712:	e8 d2 f8 ff ff       	call   fe9 <read>
    1717:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    171a:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    171e:	66 c1 e8 03          	shr    $0x3,%ax
    1722:	0f b7 c0             	movzwl %ax,%eax
    1725:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    1728:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    172f:	e9 e5 00 00 00       	jmp    1819 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    1734:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1737:	8b 45 f4             	mov    -0xc(%ebp),%eax
    173a:	29 c2                	sub    %eax,%edx
    173c:	89 d0                	mov    %edx,%eax
    173e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1741:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1744:	0f af c2             	imul   %edx,%eax
    1747:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    174a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1751:	e9 b1 00 00 00       	jmp    1807 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    1756:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1759:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    175c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    175f:	01 c8                	add    %ecx,%eax
    1761:	89 c1                	mov    %eax,%ecx
    1763:	89 c8                	mov    %ecx,%eax
    1765:	01 c0                	add    %eax,%eax
    1767:	01 c8                	add    %ecx,%eax
    1769:	01 c2                	add    %eax,%edx
    176b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176e:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1772:	89 c1                	mov    %eax,%ecx
    1774:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1777:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    177b:	01 c1                	add    %eax,%ecx
    177d:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1780:	01 c8                	add    %ecx,%eax
    1782:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1785:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1788:	01 c8                	add    %ecx,%eax
    178a:	0f b6 00             	movzbl (%eax),%eax
    178d:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    1790:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1793:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1796:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1799:	01 c8                	add    %ecx,%eax
    179b:	89 c1                	mov    %eax,%ecx
    179d:	89 c8                	mov    %ecx,%eax
    179f:	01 c0                	add    %eax,%eax
    17a1:	01 c8                	add    %ecx,%eax
    17a3:	01 c2                	add    %eax,%edx
    17a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a8:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    17ac:	89 c1                	mov    %eax,%ecx
    17ae:	8b 45 d8             	mov    -0x28(%ebp),%eax
    17b1:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    17b5:	01 c1                	add    %eax,%ecx
    17b7:	8b 45 d8             	mov    -0x28(%ebp),%eax
    17ba:	01 c8                	add    %ecx,%eax
    17bc:	8d 48 fe             	lea    -0x2(%eax),%ecx
    17bf:	8b 45 dc             	mov    -0x24(%ebp),%eax
    17c2:	01 c8                	add    %ecx,%eax
    17c4:	0f b6 00             	movzbl (%eax),%eax
    17c7:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    17ca:	8b 55 d0             	mov    -0x30(%ebp),%edx
    17cd:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    17d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d3:	01 c8                	add    %ecx,%eax
    17d5:	89 c1                	mov    %eax,%ecx
    17d7:	89 c8                	mov    %ecx,%eax
    17d9:	01 c0                	add    %eax,%eax
    17db:	01 c8                	add    %ecx,%eax
    17dd:	01 c2                	add    %eax,%edx
    17df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e2:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    17e6:	89 c1                	mov    %eax,%ecx
    17e8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    17eb:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    17ef:	01 c1                	add    %eax,%ecx
    17f1:	8b 45 d8             	mov    -0x28(%ebp),%eax
    17f4:	01 c8                	add    %ecx,%eax
    17f6:	8d 48 fd             	lea    -0x3(%eax),%ecx
    17f9:	8b 45 dc             	mov    -0x24(%ebp),%eax
    17fc:	01 c8                	add    %ecx,%eax
    17fe:	0f b6 00             	movzbl (%eax),%eax
    1801:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    1803:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1807:	8b 55 c8             	mov    -0x38(%ebp),%edx
    180a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    180d:	39 c2                	cmp    %eax,%edx
    180f:	0f 87 41 ff ff ff    	ja     1756 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    1815:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1819:	8b 55 cc             	mov    -0x34(%ebp),%edx
    181c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181f:	39 c2                	cmp    %eax,%edx
    1821:	0f 87 0d ff ff ff    	ja     1734 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    1827:	83 ec 0c             	sub    $0xc,%esp
    182a:	ff 75 ec             	pushl  -0x14(%ebp)
    182d:	e8 c7 f7 ff ff       	call   ff9 <close>
    1832:	83 c4 10             	add    $0x10,%esp
    return bmp;
    1835:	8b 45 08             	mov    0x8(%ebp),%eax
    1838:	8b 55 c8             	mov    -0x38(%ebp),%edx
    183b:	89 10                	mov    %edx,(%eax)
    183d:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1840:	89 50 04             	mov    %edx,0x4(%eax)
    1843:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1846:	89 50 08             	mov    %edx,0x8(%eax)
}
    1849:	8b 45 08             	mov    0x8(%ebp),%eax
    184c:	c9                   	leave  
    184d:	c2 04 00             	ret    $0x4

00001850 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    1850:	55                   	push   %ebp
    1851:	89 e5                	mov    %esp,%ebp
    1853:	53                   	push   %ebx
    1854:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    1857:	83 ec 0c             	sub    $0xc,%esp
    185a:	6a 1c                	push   $0x1c
    185c:	e8 02 fc ff ff       	call   1463 <malloc>
    1861:	83 c4 10             	add    $0x10,%esp
    1864:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    1867:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186a:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    1871:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    1874:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1877:	6a 0c                	push   $0xc
    1879:	6a 0c                	push   $0xc
    187b:	6a 0c                	push   $0xc
    187d:	50                   	push   %eax
    187e:	e8 c3 fc ff ff       	call   1546 <RGB>
    1883:	83 c4 0c             	add    $0xc,%esp
    1886:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    188a:	66 89 43 13          	mov    %ax,0x13(%ebx)
    188e:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    1892:	88 43 15             	mov    %al,0x15(%ebx)
    1895:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1898:	8b 55 f4             	mov    -0xc(%ebp),%edx
    189b:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    189f:	66 89 48 10          	mov    %cx,0x10(%eax)
    18a3:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    18a7:	88 50 12             	mov    %dl,0x12(%eax)
    18aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
    18b0:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    18b4:	66 89 48 08          	mov    %cx,0x8(%eax)
    18b8:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    18bc:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    18bf:	8b 45 08             	mov    0x8(%ebp),%eax
    18c2:	89 c2                	mov    %eax,%edx
    18c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c7:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    18c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    18cc:	89 c2                	mov    %eax,%edx
    18ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d1:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    18d4:	8b 55 10             	mov    0x10(%ebp),%edx
    18d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18da:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    18dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    18e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    18e3:	c9                   	leave  
    18e4:	c3                   	ret    

000018e5 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    18e5:	55                   	push   %ebp
    18e6:	89 e5                	mov    %esp,%ebp
    18e8:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    18eb:	8b 45 0c             	mov    0xc(%ebp),%eax
    18ee:	8b 50 08             	mov    0x8(%eax),%edx
    18f1:	89 55 f8             	mov    %edx,-0x8(%ebp)
    18f4:	8b 40 0c             	mov    0xc(%eax),%eax
    18f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    18fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    18fd:	8b 55 10             	mov    0x10(%ebp),%edx
    1900:	89 50 08             	mov    %edx,0x8(%eax)
    1903:	8b 55 14             	mov    0x14(%ebp),%edx
    1906:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    1909:	8b 45 08             	mov    0x8(%ebp),%eax
    190c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    190f:	89 10                	mov    %edx,(%eax)
    1911:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1914:	89 50 04             	mov    %edx,0x4(%eax)
}
    1917:	8b 45 08             	mov    0x8(%ebp),%eax
    191a:	c9                   	leave  
    191b:	c2 04 00             	ret    $0x4

0000191e <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    191e:	55                   	push   %ebp
    191f:	89 e5                	mov    %esp,%ebp
    1921:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    1924:	8b 45 0c             	mov    0xc(%ebp),%eax
    1927:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    192b:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    192f:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1933:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    1936:	8b 45 0c             	mov    0xc(%ebp),%eax
    1939:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    193d:	66 89 50 10          	mov    %dx,0x10(%eax)
    1941:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1945:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    1948:	8b 45 08             	mov    0x8(%ebp),%eax
    194b:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    194f:	66 89 10             	mov    %dx,(%eax)
    1952:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1956:	88 50 02             	mov    %dl,0x2(%eax)
}
    1959:	8b 45 08             	mov    0x8(%ebp),%eax
    195c:	c9                   	leave  
    195d:	c2 04 00             	ret    $0x4

00001960 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
    1960:	55                   	push   %ebp
    1961:	89 e5                	mov    %esp,%ebp
    1963:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
    1966:	8b 45 0c             	mov    0xc(%ebp),%eax
    1969:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    196d:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1971:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1975:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
    1978:	8b 45 0c             	mov    0xc(%ebp),%eax
    197b:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    197f:	66 89 50 13          	mov    %dx,0x13(%eax)
    1983:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1987:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
    198a:	8b 45 08             	mov    0x8(%ebp),%eax
    198d:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1991:	66 89 10             	mov    %dx,(%eax)
    1994:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1998:	88 50 02             	mov    %dl,0x2(%eax)
}
    199b:	8b 45 08             	mov    0x8(%ebp),%eax
    199e:	c9                   	leave  
    199f:	c2 04 00             	ret    $0x4

000019a2 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    19a2:	55                   	push   %ebp
    19a3:	89 e5                	mov    %esp,%ebp
    19a5:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    19a8:	8b 45 08             	mov    0x8(%ebp),%eax
    19ab:	8b 40 0c             	mov    0xc(%eax),%eax
    19ae:	89 c2                	mov    %eax,%edx
    19b0:	c1 ea 1f             	shr    $0x1f,%edx
    19b3:	01 d0                	add    %edx,%eax
    19b5:	d1 f8                	sar    %eax
    19b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    19ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19bd:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    19c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    19c4:	8b 45 10             	mov    0x10(%ebp),%eax
    19c7:	2b 45 f4             	sub    -0xc(%ebp),%eax
    19ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    19cd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    19d1:	0f 89 98 00 00 00    	jns    1a6f <APDrawPoint+0xcd>
        i = 0;
    19d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    19de:	e9 8c 00 00 00       	jmp    1a6f <APDrawPoint+0xcd>
    {
        j = x - off;
    19e3:	8b 45 0c             	mov    0xc(%ebp),%eax
    19e6:	2b 45 f4             	sub    -0xc(%ebp),%eax
    19e9:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    19ec:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    19f0:	79 69                	jns    1a5b <APDrawPoint+0xb9>
            j = 0;
    19f2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    19f9:	eb 60                	jmp    1a5b <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    19fb:	ff 75 fc             	pushl  -0x4(%ebp)
    19fe:	ff 75 f8             	pushl  -0x8(%ebp)
    1a01:	ff 75 08             	pushl  0x8(%ebp)
    1a04:	e8 bb fb ff ff       	call   15c4 <APGetIndex>
    1a09:	83 c4 0c             	add    $0xc,%esp
    1a0c:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    1a0f:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    1a13:	74 55                	je     1a6a <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    1a15:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    1a19:	74 67                	je     1a82 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    1a1b:	ff 75 10             	pushl  0x10(%ebp)
    1a1e:	ff 75 0c             	pushl  0xc(%ebp)
    1a21:	ff 75 fc             	pushl  -0x4(%ebp)
    1a24:	ff 75 f8             	pushl  -0x8(%ebp)
    1a27:	e8 5f fb ff ff       	call   158b <distance_2>
    1a2c:	83 c4 10             	add    $0x10,%esp
    1a2f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1a32:	7f 23                	jg     1a57 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    1a34:	8b 45 08             	mov    0x8(%ebp),%eax
    1a37:	8b 48 18             	mov    0x18(%eax),%ecx
    1a3a:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1a3d:	89 d0                	mov    %edx,%eax
    1a3f:	01 c0                	add    %eax,%eax
    1a41:	01 d0                	add    %edx,%eax
    1a43:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1a46:	8b 45 08             	mov    0x8(%ebp),%eax
    1a49:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1a4d:	66 89 0a             	mov    %cx,(%edx)
    1a50:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1a54:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1a57:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1a5b:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a61:	01 d0                	add    %edx,%eax
    1a63:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1a66:	7d 93                	jge    19fb <APDrawPoint+0x59>
    1a68:	eb 01                	jmp    1a6b <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1a6a:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1a6b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1a6f:	8b 55 10             	mov    0x10(%ebp),%edx
    1a72:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a75:	01 d0                	add    %edx,%eax
    1a77:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1a7a:	0f 8d 63 ff ff ff    	jge    19e3 <APDrawPoint+0x41>
    1a80:	eb 01                	jmp    1a83 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1a82:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    1a83:	c9                   	leave  
    1a84:	c3                   	ret    

00001a85 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1a85:	55                   	push   %ebp
    1a86:	89 e5                	mov    %esp,%ebp
    1a88:	53                   	push   %ebx
    1a89:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1a8c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a8f:	3b 45 14             	cmp    0x14(%ebp),%eax
    1a92:	0f 85 80 00 00 00    	jne    1b18 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1a98:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1a9c:	0f 88 9d 02 00 00    	js     1d3f <APDrawLine+0x2ba>
    1aa2:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa5:	8b 00                	mov    (%eax),%eax
    1aa7:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1aaa:	0f 8e 8f 02 00 00    	jle    1d3f <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    1ab0:	8b 45 10             	mov    0x10(%ebp),%eax
    1ab3:	3b 45 18             	cmp    0x18(%ebp),%eax
    1ab6:	7e 12                	jle    1aca <APDrawLine+0x45>
        {
            int tmp = y2;
    1ab8:	8b 45 18             	mov    0x18(%ebp),%eax
    1abb:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    1abe:	8b 45 10             	mov    0x10(%ebp),%eax
    1ac1:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1ac4:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1ac7:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1aca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1ace:	79 07                	jns    1ad7 <APDrawLine+0x52>
    1ad0:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1ad7:	8b 45 08             	mov    0x8(%ebp),%eax
    1ada:	8b 40 04             	mov    0x4(%eax),%eax
    1add:	3b 45 18             	cmp    0x18(%ebp),%eax
    1ae0:	7d 0c                	jge    1aee <APDrawLine+0x69>
    1ae2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae5:	8b 40 04             	mov    0x4(%eax),%eax
    1ae8:	83 e8 01             	sub    $0x1,%eax
    1aeb:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    1aee:	8b 45 10             	mov    0x10(%ebp),%eax
    1af1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1af4:	eb 15                	jmp    1b0b <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1af6:	ff 75 f4             	pushl  -0xc(%ebp)
    1af9:	ff 75 0c             	pushl  0xc(%ebp)
    1afc:	ff 75 08             	pushl  0x8(%ebp)
    1aff:	e8 9e fe ff ff       	call   19a2 <APDrawPoint>
    1b04:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1b07:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b0e:	3b 45 18             	cmp    0x18(%ebp),%eax
    1b11:	7e e3                	jle    1af6 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    1b13:	e9 2b 02 00 00       	jmp    1d43 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1b18:	8b 45 10             	mov    0x10(%ebp),%eax
    1b1b:	3b 45 18             	cmp    0x18(%ebp),%eax
    1b1e:	75 7f                	jne    1b9f <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    1b20:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1b24:	0f 88 18 02 00 00    	js     1d42 <APDrawLine+0x2bd>
    1b2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2d:	8b 40 04             	mov    0x4(%eax),%eax
    1b30:	3b 45 10             	cmp    0x10(%ebp),%eax
    1b33:	0f 8e 09 02 00 00    	jle    1d42 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1b39:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b3c:	3b 45 14             	cmp    0x14(%ebp),%eax
    1b3f:	7e 12                	jle    1b53 <APDrawLine+0xce>
        {
            int tmp = x2;
    1b41:	8b 45 14             	mov    0x14(%ebp),%eax
    1b44:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1b47:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b4a:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1b4d:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b50:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1b53:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1b57:	79 07                	jns    1b60 <APDrawLine+0xdb>
    1b59:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1b60:	8b 45 08             	mov    0x8(%ebp),%eax
    1b63:	8b 00                	mov    (%eax),%eax
    1b65:	3b 45 14             	cmp    0x14(%ebp),%eax
    1b68:	7d 0b                	jge    1b75 <APDrawLine+0xf0>
    1b6a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6d:	8b 00                	mov    (%eax),%eax
    1b6f:	83 e8 01             	sub    $0x1,%eax
    1b72:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1b75:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b78:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b7b:	eb 15                	jmp    1b92 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1b7d:	ff 75 10             	pushl  0x10(%ebp)
    1b80:	ff 75 f0             	pushl  -0x10(%ebp)
    1b83:	ff 75 08             	pushl  0x8(%ebp)
    1b86:	e8 17 fe ff ff       	call   19a2 <APDrawPoint>
    1b8b:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1b8e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1b92:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b95:	3b 45 14             	cmp    0x14(%ebp),%eax
    1b98:	7e e3                	jle    1b7d <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1b9a:	e9 a4 01 00 00       	jmp    1d43 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1b9f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1ba6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1bad:	8b 45 0c             	mov    0xc(%ebp),%eax
    1bb0:	2b 45 14             	sub    0x14(%ebp),%eax
    1bb3:	50                   	push   %eax
    1bb4:	e8 fb f9 ff ff       	call   15b4 <abs_int>
    1bb9:	83 c4 04             	add    $0x4,%esp
    1bbc:	89 c3                	mov    %eax,%ebx
    1bbe:	8b 45 10             	mov    0x10(%ebp),%eax
    1bc1:	2b 45 18             	sub    0x18(%ebp),%eax
    1bc4:	50                   	push   %eax
    1bc5:	e8 ea f9 ff ff       	call   15b4 <abs_int>
    1bca:	83 c4 04             	add    $0x4,%esp
    1bcd:	39 c3                	cmp    %eax,%ebx
    1bcf:	0f 8e b5 00 00 00    	jle    1c8a <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1bd5:	8b 45 10             	mov    0x10(%ebp),%eax
    1bd8:	2b 45 18             	sub    0x18(%ebp),%eax
    1bdb:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1bde:	db 45 b0             	fildl  -0x50(%ebp)
    1be1:	8b 45 0c             	mov    0xc(%ebp),%eax
    1be4:	2b 45 14             	sub    0x14(%ebp),%eax
    1be7:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1bea:	db 45 b0             	fildl  -0x50(%ebp)
    1bed:	de f9                	fdivrp %st,%st(1)
    1bef:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1bf2:	8b 45 14             	mov    0x14(%ebp),%eax
    1bf5:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1bf8:	7e 0e                	jle    1c08 <APDrawLine+0x183>
        {
            s = x1;
    1bfa:	8b 45 0c             	mov    0xc(%ebp),%eax
    1bfd:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1c00:	8b 45 14             	mov    0x14(%ebp),%eax
    1c03:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1c06:	eb 0c                	jmp    1c14 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1c08:	8b 45 14             	mov    0x14(%ebp),%eax
    1c0b:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1c0e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c11:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1c14:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c18:	79 07                	jns    1c21 <APDrawLine+0x19c>
    1c1a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1c21:	8b 45 08             	mov    0x8(%ebp),%eax
    1c24:	8b 00                	mov    (%eax),%eax
    1c26:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1c29:	7f 0b                	jg     1c36 <APDrawLine+0x1b1>
    1c2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c2e:	8b 00                	mov    (%eax),%eax
    1c30:	83 e8 01             	sub    $0x1,%eax
    1c33:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1c36:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c39:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1c3c:	eb 3f                	jmp    1c7d <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1c3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c41:	2b 45 0c             	sub    0xc(%ebp),%eax
    1c44:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1c47:	db 45 b0             	fildl  -0x50(%ebp)
    1c4a:	dc 4d d0             	fmull  -0x30(%ebp)
    1c4d:	db 45 10             	fildl  0x10(%ebp)
    1c50:	de c1                	faddp  %st,%st(1)
    1c52:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1c55:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1c59:	b4 0c                	mov    $0xc,%ah
    1c5b:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1c5f:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1c62:	db 5d cc             	fistpl -0x34(%ebp)
    1c65:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1c68:	ff 75 cc             	pushl  -0x34(%ebp)
    1c6b:	ff 75 e4             	pushl  -0x1c(%ebp)
    1c6e:	ff 75 08             	pushl  0x8(%ebp)
    1c71:	e8 2c fd ff ff       	call   19a2 <APDrawPoint>
    1c76:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1c79:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1c7d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c80:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1c83:	7e b9                	jle    1c3e <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1c85:	e9 b9 00 00 00       	jmp    1d43 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1c8a:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c8d:	2b 45 14             	sub    0x14(%ebp),%eax
    1c90:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1c93:	db 45 b0             	fildl  -0x50(%ebp)
    1c96:	8b 45 10             	mov    0x10(%ebp),%eax
    1c99:	2b 45 18             	sub    0x18(%ebp),%eax
    1c9c:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1c9f:	db 45 b0             	fildl  -0x50(%ebp)
    1ca2:	de f9                	fdivrp %st,%st(1)
    1ca4:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1ca7:	8b 45 10             	mov    0x10(%ebp),%eax
    1caa:	3b 45 18             	cmp    0x18(%ebp),%eax
    1cad:	7e 0e                	jle    1cbd <APDrawLine+0x238>
    {
        s = y2;
    1caf:	8b 45 18             	mov    0x18(%ebp),%eax
    1cb2:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1cb5:	8b 45 10             	mov    0x10(%ebp),%eax
    1cb8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1cbb:	eb 0c                	jmp    1cc9 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1cbd:	8b 45 10             	mov    0x10(%ebp),%eax
    1cc0:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1cc3:	8b 45 18             	mov    0x18(%ebp),%eax
    1cc6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1cc9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ccd:	79 07                	jns    1cd6 <APDrawLine+0x251>
    1ccf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1cd6:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd9:	8b 40 04             	mov    0x4(%eax),%eax
    1cdc:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1cdf:	7f 0c                	jg     1ced <APDrawLine+0x268>
    1ce1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce4:	8b 40 04             	mov    0x4(%eax),%eax
    1ce7:	83 e8 01             	sub    $0x1,%eax
    1cea:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1ced:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1cf0:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1cf3:	eb 3f                	jmp    1d34 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1cf5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cf8:	2b 45 10             	sub    0x10(%ebp),%eax
    1cfb:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1cfe:	db 45 b0             	fildl  -0x50(%ebp)
    1d01:	dc 4d c0             	fmull  -0x40(%ebp)
    1d04:	db 45 0c             	fildl  0xc(%ebp)
    1d07:	de c1                	faddp  %st,%st(1)
    1d09:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1d0c:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1d10:	b4 0c                	mov    $0xc,%ah
    1d12:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1d16:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1d19:	db 5d bc             	fistpl -0x44(%ebp)
    1d1c:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1d1f:	ff 75 e0             	pushl  -0x20(%ebp)
    1d22:	ff 75 bc             	pushl  -0x44(%ebp)
    1d25:	ff 75 08             	pushl  0x8(%ebp)
    1d28:	e8 75 fc ff ff       	call   19a2 <APDrawPoint>
    1d2d:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1d30:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1d34:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d37:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1d3a:	7e b9                	jle    1cf5 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1d3c:	90                   	nop
    1d3d:	eb 04                	jmp    1d43 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1d3f:	90                   	nop
    1d40:	eb 01                	jmp    1d43 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1d42:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1d43:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1d46:	c9                   	leave  
    1d47:	c3                   	ret    

00001d48 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1d48:	55                   	push   %ebp
    1d49:	89 e5                	mov    %esp,%ebp
    1d4b:	53                   	push   %ebx
    1d4c:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1d4f:	8b 55 10             	mov    0x10(%ebp),%edx
    1d52:	8b 45 18             	mov    0x18(%ebp),%eax
    1d55:	01 d0                	add    %edx,%eax
    1d57:	83 e8 01             	sub    $0x1,%eax
    1d5a:	83 ec 04             	sub    $0x4,%esp
    1d5d:	50                   	push   %eax
    1d5e:	ff 75 0c             	pushl  0xc(%ebp)
    1d61:	ff 75 10             	pushl  0x10(%ebp)
    1d64:	ff 75 0c             	pushl  0xc(%ebp)
    1d67:	ff 75 08             	pushl  0x8(%ebp)
    1d6a:	e8 16 fd ff ff       	call   1a85 <APDrawLine>
    1d6f:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1d72:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d75:	8b 45 14             	mov    0x14(%ebp),%eax
    1d78:	01 d0                	add    %edx,%eax
    1d7a:	83 e8 01             	sub    $0x1,%eax
    1d7d:	83 ec 04             	sub    $0x4,%esp
    1d80:	ff 75 10             	pushl  0x10(%ebp)
    1d83:	50                   	push   %eax
    1d84:	ff 75 10             	pushl  0x10(%ebp)
    1d87:	ff 75 0c             	pushl  0xc(%ebp)
    1d8a:	ff 75 08             	pushl  0x8(%ebp)
    1d8d:	e8 f3 fc ff ff       	call   1a85 <APDrawLine>
    1d92:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1d95:	8b 55 10             	mov    0x10(%ebp),%edx
    1d98:	8b 45 18             	mov    0x18(%ebp),%eax
    1d9b:	01 d0                	add    %edx,%eax
    1d9d:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1da0:	8b 55 0c             	mov    0xc(%ebp),%edx
    1da3:	8b 45 14             	mov    0x14(%ebp),%eax
    1da6:	01 d0                	add    %edx,%eax
    1da8:	8d 50 ff             	lea    -0x1(%eax),%edx
    1dab:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1dae:	8b 45 14             	mov    0x14(%ebp),%eax
    1db1:	01 d8                	add    %ebx,%eax
    1db3:	83 e8 01             	sub    $0x1,%eax
    1db6:	83 ec 04             	sub    $0x4,%esp
    1db9:	51                   	push   %ecx
    1dba:	52                   	push   %edx
    1dbb:	ff 75 10             	pushl  0x10(%ebp)
    1dbe:	50                   	push   %eax
    1dbf:	ff 75 08             	pushl  0x8(%ebp)
    1dc2:	e8 be fc ff ff       	call   1a85 <APDrawLine>
    1dc7:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1dca:	8b 55 10             	mov    0x10(%ebp),%edx
    1dcd:	8b 45 18             	mov    0x18(%ebp),%eax
    1dd0:	01 d0                	add    %edx,%eax
    1dd2:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1dd5:	8b 55 0c             	mov    0xc(%ebp),%edx
    1dd8:	8b 45 14             	mov    0x14(%ebp),%eax
    1ddb:	01 d0                	add    %edx,%eax
    1ddd:	8d 50 ff             	lea    -0x1(%eax),%edx
    1de0:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1de3:	8b 45 18             	mov    0x18(%ebp),%eax
    1de6:	01 d8                	add    %ebx,%eax
    1de8:	83 e8 01             	sub    $0x1,%eax
    1deb:	83 ec 04             	sub    $0x4,%esp
    1dee:	51                   	push   %ecx
    1def:	52                   	push   %edx
    1df0:	50                   	push   %eax
    1df1:	ff 75 0c             	pushl  0xc(%ebp)
    1df4:	ff 75 08             	pushl  0x8(%ebp)
    1df7:	e8 89 fc ff ff       	call   1a85 <APDrawLine>
    1dfc:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1dff:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e02:	8b 45 14             	mov    0x14(%ebp),%eax
    1e05:	01 d0                	add    %edx,%eax
    1e07:	8d 50 ff             	lea    -0x1(%eax),%edx
    1e0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e0d:	8b 40 0c             	mov    0xc(%eax),%eax
    1e10:	89 c1                	mov    %eax,%ecx
    1e12:	c1 e9 1f             	shr    $0x1f,%ecx
    1e15:	01 c8                	add    %ecx,%eax
    1e17:	d1 f8                	sar    %eax
    1e19:	29 c2                	sub    %eax,%edx
    1e1b:	89 d0                	mov    %edx,%eax
    1e1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1e20:	8b 55 10             	mov    0x10(%ebp),%edx
    1e23:	8b 45 18             	mov    0x18(%ebp),%eax
    1e26:	01 d0                	add    %edx,%eax
    1e28:	8d 50 ff             	lea    -0x1(%eax),%edx
    1e2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e2e:	8b 40 0c             	mov    0xc(%eax),%eax
    1e31:	89 c1                	mov    %eax,%ecx
    1e33:	c1 e9 1f             	shr    $0x1f,%ecx
    1e36:	01 c8                	add    %ecx,%eax
    1e38:	d1 f8                	sar    %eax
    1e3a:	29 c2                	sub    %eax,%edx
    1e3c:	89 d0                	mov    %edx,%eax
    1e3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1e41:	8b 45 08             	mov    0x8(%ebp),%eax
    1e44:	8b 40 0c             	mov    0xc(%eax),%eax
    1e47:	89 c2                	mov    %eax,%edx
    1e49:	c1 ea 1f             	shr    $0x1f,%edx
    1e4c:	01 d0                	add    %edx,%eax
    1e4e:	d1 f8                	sar    %eax
    1e50:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1e53:	8b 45 08             	mov    0x8(%ebp),%eax
    1e56:	8b 40 0c             	mov    0xc(%eax),%eax
    1e59:	89 c2                	mov    %eax,%edx
    1e5b:	c1 ea 1f             	shr    $0x1f,%edx
    1e5e:	01 d0                	add    %edx,%eax
    1e60:	d1 f8                	sar    %eax
    1e62:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1e65:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e69:	0f 88 d8 00 00 00    	js     1f47 <APDrawRect+0x1ff>
    1e6f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e73:	0f 88 ce 00 00 00    	js     1f47 <APDrawRect+0x1ff>
    1e79:	8b 45 08             	mov    0x8(%ebp),%eax
    1e7c:	8b 00                	mov    (%eax),%eax
    1e7e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1e81:	0f 8e c0 00 00 00    	jle    1f47 <APDrawRect+0x1ff>
    1e87:	8b 45 08             	mov    0x8(%ebp),%eax
    1e8a:	8b 40 04             	mov    0x4(%eax),%eax
    1e8d:	3b 45 10             	cmp    0x10(%ebp),%eax
    1e90:	0f 8e b1 00 00 00    	jle    1f47 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1e96:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1e9a:	79 07                	jns    1ea3 <APDrawRect+0x15b>
    1e9c:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1ea3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1ea7:	79 07                	jns    1eb0 <APDrawRect+0x168>
    1ea9:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1eb0:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb3:	8b 00                	mov    (%eax),%eax
    1eb5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1eb8:	7f 0b                	jg     1ec5 <APDrawRect+0x17d>
    1eba:	8b 45 08             	mov    0x8(%ebp),%eax
    1ebd:	8b 00                	mov    (%eax),%eax
    1ebf:	83 e8 01             	sub    $0x1,%eax
    1ec2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1ec5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec8:	8b 40 04             	mov    0x4(%eax),%eax
    1ecb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1ece:	7f 0c                	jg     1edc <APDrawRect+0x194>
    1ed0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ed3:	8b 40 04             	mov    0x4(%eax),%eax
    1ed6:	83 e8 01             	sub    $0x1,%eax
    1ed9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1edc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1ee3:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ee6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1ee9:	eb 52                	jmp    1f3d <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1eeb:	8b 45 10             	mov    0x10(%ebp),%eax
    1eee:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1ef1:	eb 3e                	jmp    1f31 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1ef3:	83 ec 04             	sub    $0x4,%esp
    1ef6:	ff 75 e8             	pushl  -0x18(%ebp)
    1ef9:	ff 75 ec             	pushl  -0x14(%ebp)
    1efc:	ff 75 08             	pushl  0x8(%ebp)
    1eff:	e8 c0 f6 ff ff       	call   15c4 <APGetIndex>
    1f04:	83 c4 10             	add    $0x10,%esp
    1f07:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1f0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1f0d:	8b 48 18             	mov    0x18(%eax),%ecx
    1f10:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1f13:	89 d0                	mov    %edx,%eax
    1f15:	01 c0                	add    %eax,%eax
    1f17:	01 d0                	add    %edx,%eax
    1f19:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1f1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f1f:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1f23:	66 89 0a             	mov    %cx,(%edx)
    1f26:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1f2a:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1f2d:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1f31:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1f34:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1f37:	7e ba                	jle    1ef3 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1f39:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1f3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f40:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1f43:	7e a6                	jle    1eeb <APDrawRect+0x1a3>
    1f45:	eb 01                	jmp    1f48 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1f47:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1f48:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1f4b:	c9                   	leave  
    1f4c:	c3                   	ret    

00001f4d <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1f4d:	55                   	push   %ebp
    1f4e:	89 e5                	mov    %esp,%ebp
    1f50:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    1f53:	83 ec 0c             	sub    $0xc,%esp
    1f56:	ff 75 0c             	pushl  0xc(%ebp)
    1f59:	e8 b1 ee ff ff       	call   e0f <strlen>
    1f5e:	83 c4 10             	add    $0x10,%esp
    1f61:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1f64:	8b 45 08             	mov    0x8(%ebp),%eax
    1f67:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1f6b:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1f6f:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1f73:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1f76:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1f7d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1f84:	e9 bc 00 00 00       	jmp    2045 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1f89:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1f8c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f8f:	01 d0                	add    %edx,%eax
    1f91:	0f b6 00             	movzbl (%eax),%eax
    1f94:	0f be c0             	movsbl %al,%eax
    1f97:	83 e8 20             	sub    $0x20,%eax
    1f9a:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1f9d:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1fa1:	0f 87 9a 00 00 00    	ja     2041 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1fa7:	8b 45 08             	mov    0x8(%ebp),%eax
    1faa:	8b 00                	mov    (%eax),%eax
    1fac:	0f af 45 14          	imul   0x14(%ebp),%eax
    1fb0:	89 c2                	mov    %eax,%edx
    1fb2:	8b 45 10             	mov    0x10(%ebp),%eax
    1fb5:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1fb8:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1fbb:	89 d0                	mov    %edx,%eax
    1fbd:	c1 e0 03             	shl    $0x3,%eax
    1fc0:	01 d0                	add    %edx,%eax
    1fc2:	01 c8                	add    %ecx,%eax
    1fc4:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1fc7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1fce:	eb 6b                	jmp    203b <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1fd0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1fd7:	eb 50                	jmp    2029 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    1fd9:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1fdc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1fdf:	89 d0                	mov    %edx,%eax
    1fe1:	c1 e0 03             	shl    $0x3,%eax
    1fe4:	01 d0                	add    %edx,%eax
    1fe6:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    1fec:	01 c2                	add    %eax,%edx
    1fee:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1ff1:	01 d0                	add    %edx,%eax
    1ff3:	05 e0 3b 00 00       	add    $0x3be0,%eax
    1ff8:	0f b6 00             	movzbl (%eax),%eax
    1ffb:	84 c0                	test   %al,%al
    1ffd:	74 26                	je     2025 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1fff:	8b 45 08             	mov    0x8(%ebp),%eax
    2002:	8b 50 18             	mov    0x18(%eax),%edx
    2005:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    2008:	8b 45 e8             	mov    -0x18(%ebp),%eax
    200b:	01 c8                	add    %ecx,%eax
    200d:	89 c1                	mov    %eax,%ecx
    200f:	89 c8                	mov    %ecx,%eax
    2011:	01 c0                	add    %eax,%eax
    2013:	01 c8                	add    %ecx,%eax
    2015:	01 d0                	add    %edx,%eax
    2017:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    201b:	66 89 10             	mov    %dx,(%eax)
    201e:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    2022:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    2025:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    2029:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    202d:	7e aa                	jle    1fd9 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    202f:	8b 45 08             	mov    0x8(%ebp),%eax
    2032:	8b 00                	mov    (%eax),%eax
    2034:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    2037:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    203b:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    203f:	7e 8f                	jle    1fd0 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    2041:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2045:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2048:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    204b:	0f 82 38 ff ff ff    	jb     1f89 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    2051:	90                   	nop
    2052:	c9                   	leave  
    2053:	c3                   	ret    

00002054 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    2054:	55                   	push   %ebp
    2055:	89 e5                	mov    %esp,%ebp
    2057:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    205a:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    205e:	0f 88 8e 01 00 00    	js     21f2 <APDcCopy+0x19e>
    2064:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    2068:	0f 88 84 01 00 00    	js     21f2 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    206e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2071:	8b 45 20             	mov    0x20(%ebp),%eax
    2074:	01 d0                	add    %edx,%eax
    2076:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2079:	8b 55 10             	mov    0x10(%ebp),%edx
    207c:	8b 45 24             	mov    0x24(%ebp),%eax
    207f:	01 d0                	add    %edx,%eax
    2081:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    2084:	8b 55 18             	mov    0x18(%ebp),%edx
    2087:	8b 45 20             	mov    0x20(%ebp),%eax
    208a:	01 d0                	add    %edx,%eax
    208c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    208f:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2092:	8b 45 24             	mov    0x24(%ebp),%eax
    2095:	01 d0                	add    %edx,%eax
    2097:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    209a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    209e:	0f 88 51 01 00 00    	js     21f5 <APDcCopy+0x1a1>
    20a4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    20a8:	0f 88 47 01 00 00    	js     21f5 <APDcCopy+0x1a1>
    20ae:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    20b2:	0f 88 3d 01 00 00    	js     21f5 <APDcCopy+0x1a1>
    20b8:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    20bc:	0f 88 33 01 00 00    	js     21f5 <APDcCopy+0x1a1>
    20c2:	8b 45 14             	mov    0x14(%ebp),%eax
    20c5:	8b 00                	mov    (%eax),%eax
    20c7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    20ca:	0f 8c 25 01 00 00    	jl     21f5 <APDcCopy+0x1a1>
    20d0:	8b 45 14             	mov    0x14(%ebp),%eax
    20d3:	8b 40 04             	mov    0x4(%eax),%eax
    20d6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    20d9:	0f 8c 16 01 00 00    	jl     21f5 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    20df:	8b 45 08             	mov    0x8(%ebp),%eax
    20e2:	8b 00                	mov    (%eax),%eax
    20e4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    20e7:	7f 0b                	jg     20f4 <APDcCopy+0xa0>
    20e9:	8b 45 08             	mov    0x8(%ebp),%eax
    20ec:	8b 00                	mov    (%eax),%eax
    20ee:	83 e8 01             	sub    $0x1,%eax
    20f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    20f4:	8b 45 08             	mov    0x8(%ebp),%eax
    20f7:	8b 40 04             	mov    0x4(%eax),%eax
    20fa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    20fd:	7f 0c                	jg     210b <APDcCopy+0xb7>
    20ff:	8b 45 08             	mov    0x8(%ebp),%eax
    2102:	8b 40 04             	mov    0x4(%eax),%eax
    2105:	83 e8 01             	sub    $0x1,%eax
    2108:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    210b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    2112:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    2119:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2120:	e9 bc 00 00 00       	jmp    21e1 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    2125:	8b 45 08             	mov    0x8(%ebp),%eax
    2128:	8b 00                	mov    (%eax),%eax
    212a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    212d:	8b 55 10             	mov    0x10(%ebp),%edx
    2130:	01 ca                	add    %ecx,%edx
    2132:	0f af d0             	imul   %eax,%edx
    2135:	8b 45 0c             	mov    0xc(%ebp),%eax
    2138:	01 d0                	add    %edx,%eax
    213a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    213d:	8b 45 14             	mov    0x14(%ebp),%eax
    2140:	8b 00                	mov    (%eax),%eax
    2142:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2145:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2148:	01 ca                	add    %ecx,%edx
    214a:	0f af d0             	imul   %eax,%edx
    214d:	8b 45 18             	mov    0x18(%ebp),%eax
    2150:	01 d0                	add    %edx,%eax
    2152:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    2155:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    215c:	eb 74                	jmp    21d2 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    215e:	8b 45 14             	mov    0x14(%ebp),%eax
    2161:	8b 50 18             	mov    0x18(%eax),%edx
    2164:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    2167:	8b 45 f0             	mov    -0x10(%ebp),%eax
    216a:	01 c8                	add    %ecx,%eax
    216c:	89 c1                	mov    %eax,%ecx
    216e:	89 c8                	mov    %ecx,%eax
    2170:	01 c0                	add    %eax,%eax
    2172:	01 c8                	add    %ecx,%eax
    2174:	01 d0                	add    %edx,%eax
    2176:	0f b7 10             	movzwl (%eax),%edx
    2179:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    217d:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    2181:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    2184:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    2188:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    218c:	38 c2                	cmp    %al,%dl
    218e:	75 18                	jne    21a8 <APDcCopy+0x154>
    2190:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    2194:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    2198:	38 c2                	cmp    %al,%dl
    219a:	75 0c                	jne    21a8 <APDcCopy+0x154>
    219c:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    21a0:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    21a4:	38 c2                	cmp    %al,%dl
    21a6:	74 26                	je     21ce <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    21a8:	8b 45 08             	mov    0x8(%ebp),%eax
    21ab:	8b 50 18             	mov    0x18(%eax),%edx
    21ae:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    21b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21b4:	01 c8                	add    %ecx,%eax
    21b6:	89 c1                	mov    %eax,%ecx
    21b8:	89 c8                	mov    %ecx,%eax
    21ba:	01 c0                	add    %eax,%eax
    21bc:	01 c8                	add    %ecx,%eax
    21be:	01 d0                	add    %edx,%eax
    21c0:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    21c4:	66 89 10             	mov    %dx,(%eax)
    21c7:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    21cb:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    21ce:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    21d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    21d5:	2b 45 0c             	sub    0xc(%ebp),%eax
    21d8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    21db:	7d 81                	jge    215e <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    21dd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    21e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21e4:	2b 45 10             	sub    0x10(%ebp),%eax
    21e7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    21ea:	0f 8d 35 ff ff ff    	jge    2125 <APDcCopy+0xd1>
    21f0:	eb 04                	jmp    21f6 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    21f2:	90                   	nop
    21f3:	eb 01                	jmp    21f6 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    21f5:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    21f6:	c9                   	leave  
    21f7:	c3                   	ret    

000021f8 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    21f8:	55                   	push   %ebp
    21f9:	89 e5                	mov    %esp,%ebp
    21fb:	83 ec 1c             	sub    $0x1c,%esp
    21fe:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    2201:	8b 55 10             	mov    0x10(%ebp),%edx
    2204:	8b 45 14             	mov    0x14(%ebp),%eax
    2207:	88 4d ec             	mov    %cl,-0x14(%ebp)
    220a:	88 55 e8             	mov    %dl,-0x18(%ebp)
    220d:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    2210:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    2214:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    2217:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    221b:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    221e:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    2222:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    2225:	8b 45 08             	mov    0x8(%ebp),%eax
    2228:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    222c:	66 89 10             	mov    %dx,(%eax)
    222f:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    2233:	88 50 02             	mov    %dl,0x2(%eax)
}
    2236:	8b 45 08             	mov    0x8(%ebp),%eax
    2239:	c9                   	leave  
    223a:	c2 04 00             	ret    $0x4

0000223d <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    223d:	55                   	push   %ebp
    223e:	89 e5                	mov    %esp,%ebp
    2240:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    2243:	8b 45 08             	mov    0x8(%ebp),%eax
    2246:	8b 00                	mov    (%eax),%eax
    2248:	83 ec 08             	sub    $0x8,%esp
    224b:	8d 55 0c             	lea    0xc(%ebp),%edx
    224e:	52                   	push   %edx
    224f:	50                   	push   %eax
    2250:	e8 24 ee ff ff       	call   1079 <sendMessage>
    2255:	83 c4 10             	add    $0x10,%esp
}
    2258:	90                   	nop
    2259:	c9                   	leave  
    225a:	c3                   	ret    

0000225b <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    225b:	55                   	push   %ebp
    225c:	89 e5                	mov    %esp,%ebp
    225e:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    2261:	83 ec 0c             	sub    $0xc,%esp
    2264:	68 98 00 00 00       	push   $0x98
    2269:	e8 f5 f1 ff ff       	call   1463 <malloc>
    226e:	83 c4 10             	add    $0x10,%esp
    2271:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    2274:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2278:	75 15                	jne    228f <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    227a:	83 ec 04             	sub    $0x4,%esp
    227d:	ff 75 08             	pushl  0x8(%ebp)
    2280:	68 a4 33 00 00       	push   $0x33a4
    2285:	6a 01                	push   $0x1
    2287:	e8 04 ef ff ff       	call   1190 <printf>
    228c:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    228f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2292:	05 84 00 00 00       	add    $0x84,%eax
    2297:	83 ec 08             	sub    $0x8,%esp
    229a:	ff 75 08             	pushl  0x8(%ebp)
    229d:	50                   	push   %eax
    229e:	e8 fd ea ff ff       	call   da0 <strcpy>
    22a3:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    22a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22a9:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    22b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22b3:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    22ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22bd:	8b 40 3c             	mov    0x3c(%eax),%eax
    22c0:	89 c2                	mov    %eax,%edx
    22c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22c5:	8b 40 40             	mov    0x40(%eax),%eax
    22c8:	0f af d0             	imul   %eax,%edx
    22cb:	89 d0                	mov    %edx,%eax
    22cd:	01 c0                	add    %eax,%eax
    22cf:	01 d0                	add    %edx,%eax
    22d1:	83 ec 0c             	sub    $0xc,%esp
    22d4:	50                   	push   %eax
    22d5:	e8 89 f1 ff ff       	call   1463 <malloc>
    22da:	83 c4 10             	add    $0x10,%esp
    22dd:	89 c2                	mov    %eax,%edx
    22df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22e2:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    22e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22e8:	8b 40 54             	mov    0x54(%eax),%eax
    22eb:	85 c0                	test   %eax,%eax
    22ed:	75 15                	jne    2304 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    22ef:	83 ec 04             	sub    $0x4,%esp
    22f2:	ff 75 08             	pushl  0x8(%ebp)
    22f5:	68 c4 33 00 00       	push   $0x33c4
    22fa:	6a 01                	push   $0x1
    22fc:	e8 8f ee ff ff       	call   1190 <printf>
    2301:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    2304:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2307:	8b 40 3c             	mov    0x3c(%eax),%eax
    230a:	89 c2                	mov    %eax,%edx
    230c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    230f:	8b 40 40             	mov    0x40(%eax),%eax
    2312:	0f af d0             	imul   %eax,%edx
    2315:	89 d0                	mov    %edx,%eax
    2317:	01 c0                	add    %eax,%eax
    2319:	01 c2                	add    %eax,%edx
    231b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    231e:	8b 40 54             	mov    0x54(%eax),%eax
    2321:	83 ec 04             	sub    $0x4,%esp
    2324:	52                   	push   %edx
    2325:	68 ff ff ff 00       	push   $0xffffff
    232a:	50                   	push   %eax
    232b:	e8 06 eb ff ff       	call   e36 <memset>
    2330:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    2333:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2336:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    233d:	e8 0f ed ff ff       	call   1051 <getpid>
    2342:	89 c2                	mov    %eax,%edx
    2344:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2347:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    234a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    234d:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    2354:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2357:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    235e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2361:	8b 40 58             	mov    0x58(%eax),%eax
    2364:	89 c2                	mov    %eax,%edx
    2366:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2369:	8b 40 5c             	mov    0x5c(%eax),%eax
    236c:	0f af d0             	imul   %eax,%edx
    236f:	89 d0                	mov    %edx,%eax
    2371:	01 c0                	add    %eax,%eax
    2373:	01 d0                	add    %edx,%eax
    2375:	83 ec 0c             	sub    $0xc,%esp
    2378:	50                   	push   %eax
    2379:	e8 e5 f0 ff ff       	call   1463 <malloc>
    237e:	83 c4 10             	add    $0x10,%esp
    2381:	89 c2                	mov    %eax,%edx
    2383:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2386:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    2389:	8b 45 f4             	mov    -0xc(%ebp),%eax
    238c:	8b 40 70             	mov    0x70(%eax),%eax
    238f:	85 c0                	test   %eax,%eax
    2391:	75 15                	jne    23a8 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    2393:	83 ec 04             	sub    $0x4,%esp
    2396:	ff 75 08             	pushl  0x8(%ebp)
    2399:	68 e8 33 00 00       	push   $0x33e8
    239e:	6a 01                	push   $0x1
    23a0:	e8 eb ed ff ff       	call   1190 <printf>
    23a5:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    23a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23ab:	8b 40 3c             	mov    0x3c(%eax),%eax
    23ae:	89 c2                	mov    %eax,%edx
    23b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23b3:	8b 40 40             	mov    0x40(%eax),%eax
    23b6:	0f af d0             	imul   %eax,%edx
    23b9:	89 d0                	mov    %edx,%eax
    23bb:	01 c0                	add    %eax,%eax
    23bd:	01 c2                	add    %eax,%edx
    23bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23c2:	8b 40 54             	mov    0x54(%eax),%eax
    23c5:	83 ec 04             	sub    $0x4,%esp
    23c8:	52                   	push   %edx
    23c9:	68 ff 00 00 00       	push   $0xff
    23ce:	50                   	push   %eax
    23cf:	e8 62 ea ff ff       	call   e36 <memset>
    23d4:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    23d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23da:	8b 55 0c             	mov    0xc(%ebp),%edx
    23dd:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    23e0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    23e4:	74 49                	je     242f <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    23e6:	8b 45 10             	mov    0x10(%ebp),%eax
    23e9:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    23ef:	83 ec 0c             	sub    $0xc,%esp
    23f2:	50                   	push   %eax
    23f3:	e8 6b f0 ff ff       	call   1463 <malloc>
    23f8:	83 c4 10             	add    $0x10,%esp
    23fb:	89 c2                	mov    %eax,%edx
    23fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2400:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    2403:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2406:	8b 55 10             	mov    0x10(%ebp),%edx
    2409:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    240c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    240f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    2416:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2419:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    2420:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2423:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    242a:	e9 8d 00 00 00       	jmp    24bc <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    242f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2432:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    2439:	8b 45 f4             	mov    -0xc(%ebp),%eax
    243c:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    2443:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2446:	8b 40 20             	mov    0x20(%eax),%eax
    2449:	89 c2                	mov    %eax,%edx
    244b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    244e:	8b 40 24             	mov    0x24(%eax),%eax
    2451:	0f af d0             	imul   %eax,%edx
    2454:	89 d0                	mov    %edx,%eax
    2456:	01 c0                	add    %eax,%eax
    2458:	01 d0                	add    %edx,%eax
    245a:	83 ec 0c             	sub    $0xc,%esp
    245d:	50                   	push   %eax
    245e:	e8 00 f0 ff ff       	call   1463 <malloc>
    2463:	83 c4 10             	add    $0x10,%esp
    2466:	89 c2                	mov    %eax,%edx
    2468:	8b 45 f4             	mov    -0xc(%ebp),%eax
    246b:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    246e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2471:	8b 40 38             	mov    0x38(%eax),%eax
    2474:	85 c0                	test   %eax,%eax
    2476:	75 15                	jne    248d <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    2478:	83 ec 04             	sub    $0x4,%esp
    247b:	ff 75 08             	pushl  0x8(%ebp)
    247e:	68 10 34 00 00       	push   $0x3410
    2483:	6a 01                	push   $0x1
    2485:	e8 06 ed ff ff       	call   1190 <printf>
    248a:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    248d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2490:	8b 40 20             	mov    0x20(%eax),%eax
    2493:	89 c2                	mov    %eax,%edx
    2495:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2498:	8b 40 24             	mov    0x24(%eax),%eax
    249b:	0f af d0             	imul   %eax,%edx
    249e:	89 d0                	mov    %edx,%eax
    24a0:	01 c0                	add    %eax,%eax
    24a2:	01 c2                	add    %eax,%edx
    24a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24a7:	8b 40 38             	mov    0x38(%eax),%eax
    24aa:	83 ec 04             	sub    $0x4,%esp
    24ad:	52                   	push   %edx
    24ae:	68 ff ff ff 00       	push   $0xffffff
    24b3:	50                   	push   %eax
    24b4:	e8 7d e9 ff ff       	call   e36 <memset>
    24b9:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    24bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    24bf:	c9                   	leave  
    24c0:	c3                   	ret    

000024c1 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    24c1:	55                   	push   %ebp
    24c2:	89 e5                	mov    %esp,%ebp
    24c4:	57                   	push   %edi
    24c5:	56                   	push   %esi
    24c6:	53                   	push   %ebx
    24c7:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    24ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    24cd:	83 f8 03             	cmp    $0x3,%eax
    24d0:	74 02                	je     24d4 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    24d2:	eb 7c                	jmp    2550 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    24d4:	8b 45 08             	mov    0x8(%ebp),%eax
    24d7:	8b 58 1c             	mov    0x1c(%eax),%ebx
    24da:	8b 45 08             	mov    0x8(%ebp),%eax
    24dd:	8b 48 18             	mov    0x18(%eax),%ecx
    24e0:	8b 45 08             	mov    0x8(%ebp),%eax
    24e3:	8b 50 5c             	mov    0x5c(%eax),%edx
    24e6:	8b 45 08             	mov    0x8(%ebp),%eax
    24e9:	8b 40 58             	mov    0x58(%eax),%eax
    24ec:	8b 75 08             	mov    0x8(%ebp),%esi
    24ef:	83 c6 58             	add    $0x58,%esi
    24f2:	83 ec 04             	sub    $0x4,%esp
    24f5:	53                   	push   %ebx
    24f6:	51                   	push   %ecx
    24f7:	6a 00                	push   $0x0
    24f9:	52                   	push   %edx
    24fa:	50                   	push   %eax
    24fb:	6a 00                	push   $0x0
    24fd:	6a 00                	push   $0x0
    24ff:	56                   	push   %esi
    2500:	6a 00                	push   $0x0
    2502:	6a 00                	push   $0x0
    2504:	ff 75 08             	pushl  0x8(%ebp)
    2507:	e8 65 eb ff ff       	call   1071 <paintWindow>
    250c:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    250f:	8b 45 08             	mov    0x8(%ebp),%eax
    2512:	8b 70 1c             	mov    0x1c(%eax),%esi
    2515:	8b 45 08             	mov    0x8(%ebp),%eax
    2518:	8b 58 18             	mov    0x18(%eax),%ebx
    251b:	8b 45 08             	mov    0x8(%ebp),%eax
    251e:	8b 48 08             	mov    0x8(%eax),%ecx
    2521:	8b 45 08             	mov    0x8(%ebp),%eax
    2524:	8b 50 40             	mov    0x40(%eax),%edx
    2527:	8b 45 08             	mov    0x8(%ebp),%eax
    252a:	8b 40 3c             	mov    0x3c(%eax),%eax
    252d:	8b 7d 08             	mov    0x8(%ebp),%edi
    2530:	83 c7 3c             	add    $0x3c,%edi
    2533:	83 ec 04             	sub    $0x4,%esp
    2536:	56                   	push   %esi
    2537:	53                   	push   %ebx
    2538:	51                   	push   %ecx
    2539:	52                   	push   %edx
    253a:	50                   	push   %eax
    253b:	6a 00                	push   $0x0
    253d:	6a 00                	push   $0x0
    253f:	57                   	push   %edi
    2540:	6a 32                	push   $0x32
    2542:	6a 00                	push   $0x0
    2544:	ff 75 08             	pushl  0x8(%ebp)
    2547:	e8 25 eb ff ff       	call   1071 <paintWindow>
    254c:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    254f:	90                   	nop
        default: break;
            
            
    }
    return False;
    2550:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2555:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2558:	5b                   	pop    %ebx
    2559:	5e                   	pop    %esi
    255a:	5f                   	pop    %edi
    255b:	5d                   	pop    %ebp
    255c:	c3                   	ret    

0000255d <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    255d:	55                   	push   %ebp
    255e:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    2560:	8b 45 0c             	mov    0xc(%ebp),%eax
    2563:	8b 50 08             	mov    0x8(%eax),%edx
    2566:	8b 45 08             	mov    0x8(%ebp),%eax
    2569:	8b 00                	mov    (%eax),%eax
    256b:	39 c2                	cmp    %eax,%edx
    256d:	74 07                	je     2576 <APPreJudge+0x19>
        return False;
    256f:	b8 00 00 00 00       	mov    $0x0,%eax
    2574:	eb 05                	jmp    257b <APPreJudge+0x1e>
    return True;
    2576:	b8 01 00 00 00       	mov    $0x1,%eax
}
    257b:	5d                   	pop    %ebp
    257c:	c3                   	ret    

0000257d <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    257d:	55                   	push   %ebp
    257e:	89 e5                	mov    %esp,%ebp
    2580:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    2583:	8b 45 08             	mov    0x8(%ebp),%eax
    2586:	8b 55 0c             	mov    0xc(%ebp),%edx
    2589:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    258f:	83 ec 0c             	sub    $0xc,%esp
    2592:	ff 75 08             	pushl  0x8(%ebp)
    2595:	e8 ef ea ff ff       	call   1089 <registWindow>
    259a:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    259d:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    25a4:	8b 45 08             	mov    0x8(%ebp),%eax
    25a7:	8b 00                	mov    (%eax),%eax
    25a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    25ac:	ff 75 f4             	pushl  -0xc(%ebp)
    25af:	ff 75 f0             	pushl  -0x10(%ebp)
    25b2:	ff 75 ec             	pushl  -0x14(%ebp)
    25b5:	ff 75 08             	pushl  0x8(%ebp)
    25b8:	e8 80 fc ff ff       	call   223d <APSendMessage>
    25bd:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    25c0:	83 ec 0c             	sub    $0xc,%esp
    25c3:	ff 75 08             	pushl  0x8(%ebp)
    25c6:	e8 b6 ea ff ff       	call   1081 <getMessage>
    25cb:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    25ce:	8b 45 08             	mov    0x8(%ebp),%eax
    25d1:	83 c0 74             	add    $0x74,%eax
    25d4:	83 ec 08             	sub    $0x8,%esp
    25d7:	50                   	push   %eax
    25d8:	ff 75 08             	pushl  0x8(%ebp)
    25db:	e8 7d ff ff ff       	call   255d <APPreJudge>
    25e0:	83 c4 10             	add    $0x10,%esp
    25e3:	84 c0                	test   %al,%al
    25e5:	74 1b                	je     2602 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    25e7:	8b 45 08             	mov    0x8(%ebp),%eax
    25ea:	ff 70 7c             	pushl  0x7c(%eax)
    25ed:	ff 70 78             	pushl  0x78(%eax)
    25f0:	ff 70 74             	pushl  0x74(%eax)
    25f3:	ff 75 08             	pushl  0x8(%ebp)
    25f6:	8b 45 0c             	mov    0xc(%ebp),%eax
    25f9:	ff d0                	call   *%eax
    25fb:	83 c4 10             	add    $0x10,%esp
    25fe:	84 c0                	test   %al,%al
    2600:	75 0c                	jne    260e <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    2602:	8b 45 08             	mov    0x8(%ebp),%eax
    2605:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    260c:	eb b2                	jmp    25c0 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    260e:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    260f:	90                   	nop
    2610:	c9                   	leave  
    2611:	c3                   	ret    

00002612 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    2612:	55                   	push   %ebp
    2613:	89 e5                	mov    %esp,%ebp
    2615:	57                   	push   %edi
    2616:	56                   	push   %esi
    2617:	53                   	push   %ebx
    2618:	83 ec 7c             	sub    $0x7c,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    261b:	8d 45 88             	lea    -0x78(%ebp),%eax
    261e:	6a 08                	push   $0x8
    2620:	6a 08                	push   $0x8
    2622:	6a 08                	push   $0x8
    2624:	50                   	push   %eax
    2625:	e8 ce fb ff ff       	call   21f8 <RGB>
    262a:	83 c4 0c             	add    $0xc,%esp
    262d:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2631:	66 89 45 bd          	mov    %ax,-0x43(%ebp)
    2635:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2639:	88 45 bf             	mov    %al,-0x41(%ebp)
    APSetFont(&wnd->TitleDc,font);
    263c:	8b 45 08             	mov    0x8(%ebp),%eax
    263f:	8d 58 58             	lea    0x58(%eax),%ebx
    2642:	8d 55 88             	lea    -0x78(%ebp),%edx
    2645:	83 ec 04             	sub    $0x4,%esp
    2648:	83 ec 04             	sub    $0x4,%esp
    264b:	89 e0                	mov    %esp,%eax
    264d:	0f b7 4d bd          	movzwl -0x43(%ebp),%ecx
    2651:	66 89 08             	mov    %cx,(%eax)
    2654:	0f b6 4d bf          	movzbl -0x41(%ebp),%ecx
    2658:	88 48 02             	mov    %cl,0x2(%eax)
    265b:	53                   	push   %ebx
    265c:	52                   	push   %edx
    265d:	e8 fe f2 ff ff       	call   1960 <APSetFont>
    2662:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    2665:	8b 45 08             	mov    0x8(%ebp),%eax
    2668:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    266e:	8b 45 08             	mov    0x8(%ebp),%eax
    2671:	83 c0 58             	add    $0x58,%eax
    2674:	6a 14                	push   $0x14
    2676:	6a 14                	push   $0x14
    2678:	52                   	push   %edx
    2679:	50                   	push   %eax
    267a:	e8 ce f8 ff ff       	call   1f4d <APDrawText>
    267f:	83 c4 10             	add    $0x10,%esp
    
    if (!iconReady)
    2682:	a1 2c 78 00 00       	mov    0x782c,%eax
    2687:	85 c0                	test   %eax,%eax
    2689:	0f 85 7a 02 00 00    	jne    2909 <APGridPaint+0x2f7>
    {
        iconReady = 1;
    268f:	c7 05 2c 78 00 00 01 	movl   $0x1,0x782c
    2696:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    2699:	8d 45 88             	lea    -0x78(%ebp),%eax
    269c:	83 ec 08             	sub    $0x8,%esp
    269f:	68 37 34 00 00       	push   $0x3437
    26a4:	50                   	push   %eax
    26a5:	e8 6c ef ff ff       	call   1616 <APLoadBitmap>
    26aa:	83 c4 0c             	add    $0xc,%esp
    26ad:	8b 45 88             	mov    -0x78(%ebp),%eax
    26b0:	a3 b4 78 00 00       	mov    %eax,0x78b4
    26b5:	8b 45 8c             	mov    -0x74(%ebp),%eax
    26b8:	a3 b8 78 00 00       	mov    %eax,0x78b8
    26bd:	8b 45 90             	mov    -0x70(%ebp),%eax
    26c0:	a3 bc 78 00 00       	mov    %eax,0x78bc
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    26c5:	83 ec 04             	sub    $0x4,%esp
    26c8:	ff 35 bc 78 00 00    	pushl  0x78bc
    26ce:	ff 35 b8 78 00 00    	pushl  0x78b8
    26d4:	ff 35 b4 78 00 00    	pushl  0x78b4
    26da:	e8 71 f1 ff ff       	call   1850 <APCreateCompatibleDCFromBitmap>
    26df:	83 c4 10             	add    $0x10,%esp
    26e2:	a3 c0 78 00 00       	mov    %eax,0x78c0
        grid_river = APLoadBitmap ("grid_river.bmp");
    26e7:	8d 45 88             	lea    -0x78(%ebp),%eax
    26ea:	83 ec 08             	sub    $0x8,%esp
    26ed:	68 45 34 00 00       	push   $0x3445
    26f2:	50                   	push   %eax
    26f3:	e8 1e ef ff ff       	call   1616 <APLoadBitmap>
    26f8:	83 c4 0c             	add    $0xc,%esp
    26fb:	8b 45 88             	mov    -0x78(%ebp),%eax
    26fe:	a3 fc 78 00 00       	mov    %eax,0x78fc
    2703:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2706:	a3 00 79 00 00       	mov    %eax,0x7900
    270b:	8b 45 90             	mov    -0x70(%ebp),%eax
    270e:	a3 04 79 00 00       	mov    %eax,0x7904
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    2713:	83 ec 04             	sub    $0x4,%esp
    2716:	ff 35 04 79 00 00    	pushl  0x7904
    271c:	ff 35 00 79 00 00    	pushl  0x7900
    2722:	ff 35 fc 78 00 00    	pushl  0x78fc
    2728:	e8 23 f1 ff ff       	call   1850 <APCreateCompatibleDCFromBitmap>
    272d:	83 c4 10             	add    $0x10,%esp
    2730:	a3 ec 78 00 00       	mov    %eax,0x78ec
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    2735:	8d 45 88             	lea    -0x78(%ebp),%eax
    2738:	83 ec 08             	sub    $0x8,%esp
    273b:	68 54 34 00 00       	push   $0x3454
    2740:	50                   	push   %eax
    2741:	e8 d0 ee ff ff       	call   1616 <APLoadBitmap>
    2746:	83 c4 0c             	add    $0xc,%esp
    2749:	8b 45 88             	mov    -0x78(%ebp),%eax
    274c:	a3 f0 78 00 00       	mov    %eax,0x78f0
    2751:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2754:	a3 f4 78 00 00       	mov    %eax,0x78f4
    2759:	8b 45 90             	mov    -0x70(%ebp),%eax
    275c:	a3 f8 78 00 00       	mov    %eax,0x78f8
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    2761:	83 ec 04             	sub    $0x4,%esp
    2764:	ff 35 f8 78 00 00    	pushl  0x78f8
    276a:	ff 35 f4 78 00 00    	pushl  0x78f4
    2770:	ff 35 f0 78 00 00    	pushl  0x78f0
    2776:	e8 d5 f0 ff ff       	call   1850 <APCreateCompatibleDCFromBitmap>
    277b:	83 c4 10             	add    $0x10,%esp
    277e:	a3 48 78 00 00       	mov    %eax,0x7848
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    2783:	8d 45 88             	lea    -0x78(%ebp),%eax
    2786:	83 ec 08             	sub    $0x8,%esp
    2789:	68 63 34 00 00       	push   $0x3463
    278e:	50                   	push   %eax
    278f:	e8 82 ee ff ff       	call   1616 <APLoadBitmap>
    2794:	83 c4 0c             	add    $0xc,%esp
    2797:	8b 45 88             	mov    -0x78(%ebp),%eax
    279a:	a3 c8 78 00 00       	mov    %eax,0x78c8
    279f:	8b 45 8c             	mov    -0x74(%ebp),%eax
    27a2:	a3 cc 78 00 00       	mov    %eax,0x78cc
    27a7:	8b 45 90             	mov    -0x70(%ebp),%eax
    27aa:	a3 d0 78 00 00       	mov    %eax,0x78d0
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    27af:	83 ec 04             	sub    $0x4,%esp
    27b2:	ff 35 d0 78 00 00    	pushl  0x78d0
    27b8:	ff 35 cc 78 00 00    	pushl  0x78cc
    27be:	ff 35 c8 78 00 00    	pushl  0x78c8
    27c4:	e8 87 f0 ff ff       	call   1850 <APCreateCompatibleDCFromBitmap>
    27c9:	83 c4 10             	add    $0x10,%esp
    27cc:	a3 0c 79 00 00       	mov    %eax,0x790c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    27d1:	8d 45 88             	lea    -0x78(%ebp),%eax
    27d4:	83 ec 08             	sub    $0x8,%esp
    27d7:	68 71 34 00 00       	push   $0x3471
    27dc:	50                   	push   %eax
    27dd:	e8 34 ee ff ff       	call   1616 <APLoadBitmap>
    27e2:	83 c4 0c             	add    $0xc,%esp
    27e5:	8b 45 88             	mov    -0x78(%ebp),%eax
    27e8:	a3 a4 78 00 00       	mov    %eax,0x78a4
    27ed:	8b 45 8c             	mov    -0x74(%ebp),%eax
    27f0:	a3 a8 78 00 00       	mov    %eax,0x78a8
    27f5:	8b 45 90             	mov    -0x70(%ebp),%eax
    27f8:	a3 ac 78 00 00       	mov    %eax,0x78ac
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    27fd:	83 ec 04             	sub    $0x4,%esp
    2800:	ff 35 ac 78 00 00    	pushl  0x78ac
    2806:	ff 35 a8 78 00 00    	pushl  0x78a8
    280c:	ff 35 a4 78 00 00    	pushl  0x78a4
    2812:	e8 39 f0 ff ff       	call   1850 <APCreateCompatibleDCFromBitmap>
    2817:	83 c4 10             	add    $0x10,%esp
    281a:	a3 c4 78 00 00       	mov    %eax,0x78c4
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    281f:	8d 45 88             	lea    -0x78(%ebp),%eax
    2822:	83 ec 08             	sub    $0x8,%esp
    2825:	68 81 34 00 00       	push   $0x3481
    282a:	50                   	push   %eax
    282b:	e8 e6 ed ff ff       	call   1616 <APLoadBitmap>
    2830:	83 c4 0c             	add    $0xc,%esp
    2833:	8b 45 88             	mov    -0x78(%ebp),%eax
    2836:	a3 50 78 00 00       	mov    %eax,0x7850
    283b:	8b 45 8c             	mov    -0x74(%ebp),%eax
    283e:	a3 54 78 00 00       	mov    %eax,0x7854
    2843:	8b 45 90             	mov    -0x70(%ebp),%eax
    2846:	a3 58 78 00 00       	mov    %eax,0x7858
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    284b:	83 ec 04             	sub    $0x4,%esp
    284e:	ff 35 58 78 00 00    	pushl  0x7858
    2854:	ff 35 54 78 00 00    	pushl  0x7854
    285a:	ff 35 50 78 00 00    	pushl  0x7850
    2860:	e8 eb ef ff ff       	call   1850 <APCreateCompatibleDCFromBitmap>
    2865:	83 c4 10             	add    $0x10,%esp
    2868:	a3 b0 78 00 00       	mov    %eax,0x78b0
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    286d:	8d 45 88             	lea    -0x78(%ebp),%eax
    2870:	83 ec 08             	sub    $0x8,%esp
    2873:	68 93 34 00 00       	push   $0x3493
    2878:	50                   	push   %eax
    2879:	e8 98 ed ff ff       	call   1616 <APLoadBitmap>
    287e:	83 c4 0c             	add    $0xc,%esp
    2881:	8b 45 88             	mov    -0x78(%ebp),%eax
    2884:	a3 e0 78 00 00       	mov    %eax,0x78e0
    2889:	8b 45 8c             	mov    -0x74(%ebp),%eax
    288c:	a3 e4 78 00 00       	mov    %eax,0x78e4
    2891:	8b 45 90             	mov    -0x70(%ebp),%eax
    2894:	a3 e8 78 00 00       	mov    %eax,0x78e8
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    2899:	83 ec 04             	sub    $0x4,%esp
    289c:	ff 35 e8 78 00 00    	pushl  0x78e8
    28a2:	ff 35 e4 78 00 00    	pushl  0x78e4
    28a8:	ff 35 e0 78 00 00    	pushl  0x78e0
    28ae:	e8 9d ef ff ff       	call   1850 <APCreateCompatibleDCFromBitmap>
    28b3:	83 c4 10             	add    $0x10,%esp
    28b6:	a3 dc 7d 00 00       	mov    %eax,0x7ddc
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    28bb:	8d 45 88             	lea    -0x78(%ebp),%eax
    28be:	83 ec 08             	sub    $0x8,%esp
    28c1:	68 a2 34 00 00       	push   $0x34a2
    28c6:	50                   	push   %eax
    28c7:	e8 4a ed ff ff       	call   1616 <APLoadBitmap>
    28cc:	83 c4 0c             	add    $0xc,%esp
    28cf:	8b 45 88             	mov    -0x78(%ebp),%eax
    28d2:	a3 d4 78 00 00       	mov    %eax,0x78d4
    28d7:	8b 45 8c             	mov    -0x74(%ebp),%eax
    28da:	a3 d8 78 00 00       	mov    %eax,0x78d8
    28df:	8b 45 90             	mov    -0x70(%ebp),%eax
    28e2:	a3 dc 78 00 00       	mov    %eax,0x78dc
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    28e7:	83 ec 04             	sub    $0x4,%esp
    28ea:	ff 35 dc 78 00 00    	pushl  0x78dc
    28f0:	ff 35 d8 78 00 00    	pushl  0x78d8
    28f6:	ff 35 d4 78 00 00    	pushl  0x78d4
    28fc:	e8 4f ef ff ff       	call   1850 <APCreateCompatibleDCFromBitmap>
    2901:	83 c4 10             	add    $0x10,%esp
    2904:	a3 08 79 00 00       	mov    %eax,0x7908
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    2909:	8b 45 08             	mov    0x8(%ebp),%eax
    290c:	8b 40 08             	mov    0x8(%eax),%eax
    290f:	85 c0                	test   %eax,%eax
    2911:	75 17                	jne    292a <APGridPaint+0x318>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    2913:	83 ec 08             	sub    $0x8,%esp
    2916:	68 b4 34 00 00       	push   $0x34b4
    291b:	6a 01                	push   $0x1
    291d:	e8 6e e8 ff ff       	call   1190 <printf>
    2922:	83 c4 10             	add    $0x10,%esp
        return;
    2925:	e9 fe 04 00 00       	jmp    2e28 <APGridPaint+0x816>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    292a:	8b 45 08             	mov    0x8(%ebp),%eax
    292d:	8b 40 10             	mov    0x10(%eax),%eax
    2930:	85 c0                	test   %eax,%eax
    2932:	7e 10                	jle    2944 <APGridPaint+0x332>
    2934:	8b 45 08             	mov    0x8(%ebp),%eax
    2937:	8b 50 14             	mov    0x14(%eax),%edx
    293a:	8b 45 08             	mov    0x8(%ebp),%eax
    293d:	8b 40 10             	mov    0x10(%eax),%eax
    2940:	39 c2                	cmp    %eax,%edx
    2942:	7c 17                	jl     295b <APGridPaint+0x349>
    {
        printf(1,"Grid mode page error!");
    2944:	83 ec 08             	sub    $0x8,%esp
    2947:	68 da 34 00 00       	push   $0x34da
    294c:	6a 01                	push   $0x1
    294e:	e8 3d e8 ff ff       	call   1190 <printf>
    2953:	83 c4 10             	add    $0x10,%esp
        return;
    2956:	e9 cd 04 00 00       	jmp    2e28 <APGridPaint+0x816>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    295b:	8b 45 08             	mov    0x8(%ebp),%eax
    295e:	8b 40 14             	mov    0x14(%eax),%eax
    2961:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    2967:	89 45 dc             	mov    %eax,-0x24(%ebp)
    296a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    296d:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2970:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    2977:	e9 f4 03 00 00       	jmp    2d70 <APGridPaint+0x75e>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    297c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    2983:	e9 da 03 00 00       	jmp    2d62 <APGridPaint+0x750>
        {
            index = start + GRID_W_NUMBER * j + i;
    2988:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    298b:	c1 e0 04             	shl    $0x4,%eax
    298e:	89 c2                	mov    %eax,%edx
    2990:	8b 45 d8             	mov    -0x28(%ebp),%eax
    2993:	01 c2                	add    %eax,%edx
    2995:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2998:	01 d0                	add    %edx,%eax
    299a:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    299d:	8b 45 08             	mov    0x8(%ebp),%eax
    29a0:	8b 40 0c             	mov    0xc(%eax),%eax
    29a3:	8b 55 dc             	mov    -0x24(%ebp),%edx
    29a6:	c1 e2 02             	shl    $0x2,%edx
    29a9:	01 d0                	add    %edx,%eax
    29ab:	8b 00                	mov    (%eax),%eax
    29ad:	83 f8 0a             	cmp    $0xa,%eax
    29b0:	0f 87 a7 03 00 00    	ja     2d5d <APGridPaint+0x74b>
    29b6:	8b 04 85 f0 34 00 00 	mov    0x34f0(,%eax,4),%eax
    29bd:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    29bf:	8d 45 c0             	lea    -0x40(%ebp),%eax
    29c2:	6a 0c                	push   $0xc
    29c4:	6a 0c                	push   $0xc
    29c6:	6a 0c                	push   $0xc
    29c8:	50                   	push   %eax
    29c9:	e8 2a f8 ff ff       	call   21f8 <RGB>
    29ce:	83 c4 0c             	add    $0xc,%esp
    29d1:	8b 1d c0 78 00 00    	mov    0x78c0,%ebx
    29d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    29da:	6b c8 32             	imul   $0x32,%eax,%ecx
    29dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    29e0:	6b c0 32             	imul   $0x32,%eax,%eax
    29e3:	89 45 84             	mov    %eax,-0x7c(%ebp)
    29e6:	8b 45 08             	mov    0x8(%ebp),%eax
    29e9:	8d 78 3c             	lea    0x3c(%eax),%edi
    29ec:	83 ec 0c             	sub    $0xc,%esp
    29ef:	83 ec 04             	sub    $0x4,%esp
    29f2:	89 e0                	mov    %esp,%eax
    29f4:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    29f8:	66 89 30             	mov    %si,(%eax)
    29fb:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    29ff:	88 50 02             	mov    %dl,0x2(%eax)
    2a02:	6a 32                	push   $0x32
    2a04:	6a 32                	push   $0x32
    2a06:	6a 00                	push   $0x0
    2a08:	6a 00                	push   $0x0
    2a0a:	53                   	push   %ebx
    2a0b:	51                   	push   %ecx
    2a0c:	ff 75 84             	pushl  -0x7c(%ebp)
    2a0f:	57                   	push   %edi
    2a10:	e8 3f f6 ff ff       	call   2054 <APDcCopy>
    2a15:	83 c4 30             	add    $0x30,%esp
                    break;
    2a18:	e9 41 03 00 00       	jmp    2d5e <APGridPaint+0x74c>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    2a1d:	8d 45 88             	lea    -0x78(%ebp),%eax
    2a20:	6a 69                	push   $0x69
    2a22:	6a 69                	push   $0x69
    2a24:	6a 69                	push   $0x69
    2a26:	50                   	push   %eax
    2a27:	e8 cc f7 ff ff       	call   21f8 <RGB>
    2a2c:	83 c4 0c             	add    $0xc,%esp
    2a2f:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2a33:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    2a37:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2a3b:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    2a3e:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    2a45:	8d 45 88             	lea    -0x78(%ebp),%eax
    2a48:	6a 69                	push   $0x69
    2a4a:	6a 69                	push   $0x69
    2a4c:	6a 69                	push   $0x69
    2a4e:	50                   	push   %eax
    2a4f:	e8 a4 f7 ff ff       	call   21f8 <RGB>
    2a54:	83 c4 0c             	add    $0xc,%esp
    2a57:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2a5b:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    2a5f:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2a63:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    2a66:	8b 45 08             	mov    0x8(%ebp),%eax
    2a69:	8d 50 3c             	lea    0x3c(%eax),%edx
    2a6c:	8d 45 88             	lea    -0x78(%ebp),%eax
    2a6f:	ff 75 ac             	pushl  -0x54(%ebp)
    2a72:	ff 75 a8             	pushl  -0x58(%ebp)
    2a75:	52                   	push   %edx
    2a76:	50                   	push   %eax
    2a77:	e8 69 ee ff ff       	call   18e5 <APSetPen>
    2a7c:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    2a7f:	8b 45 08             	mov    0x8(%ebp),%eax
    2a82:	8d 58 3c             	lea    0x3c(%eax),%ebx
    2a85:	8d 55 88             	lea    -0x78(%ebp),%edx
    2a88:	83 ec 04             	sub    $0x4,%esp
    2a8b:	83 ec 04             	sub    $0x4,%esp
    2a8e:	89 e0                	mov    %esp,%eax
    2a90:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    2a94:	66 89 08             	mov    %cx,(%eax)
    2a97:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    2a9b:	88 48 02             	mov    %cl,0x2(%eax)
    2a9e:	53                   	push   %ebx
    2a9f:	52                   	push   %edx
    2aa0:	e8 79 ee ff ff       	call   191e <APSetBrush>
    2aa5:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    2aa8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2aab:	6b d0 32             	imul   $0x32,%eax,%edx
    2aae:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2ab1:	6b c0 32             	imul   $0x32,%eax,%eax
    2ab4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2ab7:	83 c1 3c             	add    $0x3c,%ecx
    2aba:	83 ec 0c             	sub    $0xc,%esp
    2abd:	6a 32                	push   $0x32
    2abf:	6a 32                	push   $0x32
    2ac1:	52                   	push   %edx
    2ac2:	50                   	push   %eax
    2ac3:	51                   	push   %ecx
    2ac4:	e8 7f f2 ff ff       	call   1d48 <APDrawRect>
    2ac9:	83 c4 20             	add    $0x20,%esp
                    break;
    2acc:	e9 8d 02 00 00       	jmp    2d5e <APGridPaint+0x74c>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2ad1:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    2ad4:	6a 0c                	push   $0xc
    2ad6:	6a 0c                	push   $0xc
    2ad8:	6a 0c                	push   $0xc
    2ada:	50                   	push   %eax
    2adb:	e8 18 f7 ff ff       	call   21f8 <RGB>
    2ae0:	83 c4 0c             	add    $0xc,%esp
    2ae3:	8b 1d dc 7d 00 00    	mov    0x7ddc,%ebx
    2ae9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2aec:	6b c8 32             	imul   $0x32,%eax,%ecx
    2aef:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2af2:	6b c0 32             	imul   $0x32,%eax,%eax
    2af5:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2af8:	8b 45 08             	mov    0x8(%ebp),%eax
    2afb:	8d 78 3c             	lea    0x3c(%eax),%edi
    2afe:	83 ec 0c             	sub    $0xc,%esp
    2b01:	83 ec 04             	sub    $0x4,%esp
    2b04:	89 e0                	mov    %esp,%eax
    2b06:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    2b0a:	66 89 30             	mov    %si,(%eax)
    2b0d:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    2b11:	88 50 02             	mov    %dl,0x2(%eax)
    2b14:	6a 32                	push   $0x32
    2b16:	6a 32                	push   $0x32
    2b18:	6a 00                	push   $0x0
    2b1a:	6a 00                	push   $0x0
    2b1c:	53                   	push   %ebx
    2b1d:	51                   	push   %ecx
    2b1e:	ff 75 84             	pushl  -0x7c(%ebp)
    2b21:	57                   	push   %edi
    2b22:	e8 2d f5 ff ff       	call   2054 <APDcCopy>
    2b27:	83 c4 30             	add    $0x30,%esp
                    break;
    2b2a:	e9 2f 02 00 00       	jmp    2d5e <APGridPaint+0x74c>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2b2f:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    2b32:	6a 0c                	push   $0xc
    2b34:	6a 0c                	push   $0xc
    2b36:	6a 0c                	push   $0xc
    2b38:	50                   	push   %eax
    2b39:	e8 ba f6 ff ff       	call   21f8 <RGB>
    2b3e:	83 c4 0c             	add    $0xc,%esp
    2b41:	8b 1d ec 78 00 00    	mov    0x78ec,%ebx
    2b47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2b4a:	6b c8 32             	imul   $0x32,%eax,%ecx
    2b4d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2b50:	6b c0 32             	imul   $0x32,%eax,%eax
    2b53:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2b56:	8b 45 08             	mov    0x8(%ebp),%eax
    2b59:	8d 78 3c             	lea    0x3c(%eax),%edi
    2b5c:	83 ec 0c             	sub    $0xc,%esp
    2b5f:	83 ec 04             	sub    $0x4,%esp
    2b62:	89 e0                	mov    %esp,%eax
    2b64:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2b68:	66 89 30             	mov    %si,(%eax)
    2b6b:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    2b6f:	88 50 02             	mov    %dl,0x2(%eax)
    2b72:	6a 32                	push   $0x32
    2b74:	6a 32                	push   $0x32
    2b76:	6a 00                	push   $0x0
    2b78:	6a 00                	push   $0x0
    2b7a:	53                   	push   %ebx
    2b7b:	51                   	push   %ecx
    2b7c:	ff 75 84             	pushl  -0x7c(%ebp)
    2b7f:	57                   	push   %edi
    2b80:	e8 cf f4 ff ff       	call   2054 <APDcCopy>
    2b85:	83 c4 30             	add    $0x30,%esp
                    break;
    2b88:	e9 d1 01 00 00       	jmp    2d5e <APGridPaint+0x74c>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2b8d:	8d 45 c9             	lea    -0x37(%ebp),%eax
    2b90:	6a 0c                	push   $0xc
    2b92:	6a 0c                	push   $0xc
    2b94:	6a 0c                	push   $0xc
    2b96:	50                   	push   %eax
    2b97:	e8 5c f6 ff ff       	call   21f8 <RGB>
    2b9c:	83 c4 0c             	add    $0xc,%esp
    2b9f:	8b 1d c4 78 00 00    	mov    0x78c4,%ebx
    2ba5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2ba8:	6b c8 32             	imul   $0x32,%eax,%ecx
    2bab:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2bae:	6b c0 32             	imul   $0x32,%eax,%eax
    2bb1:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2bb4:	8b 45 08             	mov    0x8(%ebp),%eax
    2bb7:	8d 78 3c             	lea    0x3c(%eax),%edi
    2bba:	83 ec 0c             	sub    $0xc,%esp
    2bbd:	83 ec 04             	sub    $0x4,%esp
    2bc0:	89 e0                	mov    %esp,%eax
    2bc2:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    2bc6:	66 89 30             	mov    %si,(%eax)
    2bc9:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    2bcd:	88 50 02             	mov    %dl,0x2(%eax)
    2bd0:	6a 32                	push   $0x32
    2bd2:	6a 32                	push   $0x32
    2bd4:	6a 00                	push   $0x0
    2bd6:	6a 00                	push   $0x0
    2bd8:	53                   	push   %ebx
    2bd9:	51                   	push   %ecx
    2bda:	ff 75 84             	pushl  -0x7c(%ebp)
    2bdd:	57                   	push   %edi
    2bde:	e8 71 f4 ff ff       	call   2054 <APDcCopy>
    2be3:	83 c4 30             	add    $0x30,%esp
                    break;
    2be6:	e9 73 01 00 00       	jmp    2d5e <APGridPaint+0x74c>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2beb:	8d 45 cc             	lea    -0x34(%ebp),%eax
    2bee:	6a 0c                	push   $0xc
    2bf0:	6a 0c                	push   $0xc
    2bf2:	6a 0c                	push   $0xc
    2bf4:	50                   	push   %eax
    2bf5:	e8 fe f5 ff ff       	call   21f8 <RGB>
    2bfa:	83 c4 0c             	add    $0xc,%esp
    2bfd:	8b 1d 0c 79 00 00    	mov    0x790c,%ebx
    2c03:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2c06:	6b c8 32             	imul   $0x32,%eax,%ecx
    2c09:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2c0c:	6b c0 32             	imul   $0x32,%eax,%eax
    2c0f:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2c12:	8b 45 08             	mov    0x8(%ebp),%eax
    2c15:	8d 78 3c             	lea    0x3c(%eax),%edi
    2c18:	83 ec 0c             	sub    $0xc,%esp
    2c1b:	83 ec 04             	sub    $0x4,%esp
    2c1e:	89 e0                	mov    %esp,%eax
    2c20:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    2c24:	66 89 30             	mov    %si,(%eax)
    2c27:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    2c2b:	88 50 02             	mov    %dl,0x2(%eax)
    2c2e:	6a 32                	push   $0x32
    2c30:	6a 32                	push   $0x32
    2c32:	6a 00                	push   $0x0
    2c34:	6a 00                	push   $0x0
    2c36:	53                   	push   %ebx
    2c37:	51                   	push   %ecx
    2c38:	ff 75 84             	pushl  -0x7c(%ebp)
    2c3b:	57                   	push   %edi
    2c3c:	e8 13 f4 ff ff       	call   2054 <APDcCopy>
    2c41:	83 c4 30             	add    $0x30,%esp
                    break;
    2c44:	e9 15 01 00 00       	jmp    2d5e <APGridPaint+0x74c>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2c49:	8d 45 cf             	lea    -0x31(%ebp),%eax
    2c4c:	6a 0c                	push   $0xc
    2c4e:	6a 0c                	push   $0xc
    2c50:	6a 0c                	push   $0xc
    2c52:	50                   	push   %eax
    2c53:	e8 a0 f5 ff ff       	call   21f8 <RGB>
    2c58:	83 c4 0c             	add    $0xc,%esp
    2c5b:	8b 1d 48 78 00 00    	mov    0x7848,%ebx
    2c61:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2c64:	6b c8 32             	imul   $0x32,%eax,%ecx
    2c67:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2c6a:	6b c0 32             	imul   $0x32,%eax,%eax
    2c6d:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2c70:	8b 45 08             	mov    0x8(%ebp),%eax
    2c73:	8d 78 3c             	lea    0x3c(%eax),%edi
    2c76:	83 ec 0c             	sub    $0xc,%esp
    2c79:	83 ec 04             	sub    $0x4,%esp
    2c7c:	89 e0                	mov    %esp,%eax
    2c7e:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2c82:	66 89 30             	mov    %si,(%eax)
    2c85:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2c89:	88 50 02             	mov    %dl,0x2(%eax)
    2c8c:	6a 32                	push   $0x32
    2c8e:	6a 32                	push   $0x32
    2c90:	6a 00                	push   $0x0
    2c92:	6a 00                	push   $0x0
    2c94:	53                   	push   %ebx
    2c95:	51                   	push   %ecx
    2c96:	ff 75 84             	pushl  -0x7c(%ebp)
    2c99:	57                   	push   %edi
    2c9a:	e8 b5 f3 ff ff       	call   2054 <APDcCopy>
    2c9f:	83 c4 30             	add    $0x30,%esp
                    break;
    2ca2:	e9 b7 00 00 00       	jmp    2d5e <APGridPaint+0x74c>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2ca7:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2caa:	6a 0c                	push   $0xc
    2cac:	6a 0c                	push   $0xc
    2cae:	6a 0c                	push   $0xc
    2cb0:	50                   	push   %eax
    2cb1:	e8 42 f5 ff ff       	call   21f8 <RGB>
    2cb6:	83 c4 0c             	add    $0xc,%esp
    2cb9:	8b 1d b0 78 00 00    	mov    0x78b0,%ebx
    2cbf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2cc2:	6b c8 32             	imul   $0x32,%eax,%ecx
    2cc5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2cc8:	6b c0 32             	imul   $0x32,%eax,%eax
    2ccb:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2cce:	8b 45 08             	mov    0x8(%ebp),%eax
    2cd1:	8d 78 3c             	lea    0x3c(%eax),%edi
    2cd4:	83 ec 0c             	sub    $0xc,%esp
    2cd7:	83 ec 04             	sub    $0x4,%esp
    2cda:	89 e0                	mov    %esp,%eax
    2cdc:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2ce0:	66 89 30             	mov    %si,(%eax)
    2ce3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2ce7:	88 50 02             	mov    %dl,0x2(%eax)
    2cea:	6a 32                	push   $0x32
    2cec:	6a 32                	push   $0x32
    2cee:	6a 00                	push   $0x0
    2cf0:	6a 00                	push   $0x0
    2cf2:	53                   	push   %ebx
    2cf3:	51                   	push   %ecx
    2cf4:	ff 75 84             	pushl  -0x7c(%ebp)
    2cf7:	57                   	push   %edi
    2cf8:	e8 57 f3 ff ff       	call   2054 <APDcCopy>
    2cfd:	83 c4 30             	add    $0x30,%esp
                    break;
    2d00:	eb 5c                	jmp    2d5e <APGridPaint+0x74c>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2d02:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    2d05:	6a 0c                	push   $0xc
    2d07:	6a 0c                	push   $0xc
    2d09:	6a 0c                	push   $0xc
    2d0b:	50                   	push   %eax
    2d0c:	e8 e7 f4 ff ff       	call   21f8 <RGB>
    2d11:	83 c4 0c             	add    $0xc,%esp
    2d14:	8b 1d 08 79 00 00    	mov    0x7908,%ebx
    2d1a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2d1d:	6b c8 32             	imul   $0x32,%eax,%ecx
    2d20:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2d23:	6b c0 32             	imul   $0x32,%eax,%eax
    2d26:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2d29:	8b 45 08             	mov    0x8(%ebp),%eax
    2d2c:	8d 78 3c             	lea    0x3c(%eax),%edi
    2d2f:	83 ec 0c             	sub    $0xc,%esp
    2d32:	83 ec 04             	sub    $0x4,%esp
    2d35:	89 e0                	mov    %esp,%eax
    2d37:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2d3b:	66 89 30             	mov    %si,(%eax)
    2d3e:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2d42:	88 50 02             	mov    %dl,0x2(%eax)
    2d45:	6a 32                	push   $0x32
    2d47:	6a 32                	push   $0x32
    2d49:	6a 00                	push   $0x0
    2d4b:	6a 00                	push   $0x0
    2d4d:	53                   	push   %ebx
    2d4e:	51                   	push   %ecx
    2d4f:	ff 75 84             	pushl  -0x7c(%ebp)
    2d52:	57                   	push   %edi
    2d53:	e8 fc f2 ff ff       	call   2054 <APDcCopy>
    2d58:	83 c4 30             	add    $0x30,%esp
                    break;
    2d5b:	eb 01                	jmp    2d5e <APGridPaint+0x74c>
                default: break;
    2d5d:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2d5e:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2d62:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2d66:	0f 8e 1c fc ff ff    	jle    2988 <APGridPaint+0x376>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2d6c:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2d70:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2d74:	0f 8e 02 fc ff ff    	jle    297c <APGridPaint+0x36a>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2d7a:	8d 45 88             	lea    -0x78(%ebp),%eax
    2d7d:	68 cd 00 00 00       	push   $0xcd
    2d82:	6a 74                	push   $0x74
    2d84:	6a 18                	push   $0x18
    2d86:	50                   	push   %eax
    2d87:	e8 6c f4 ff ff       	call   21f8 <RGB>
    2d8c:	83 c4 0c             	add    $0xc,%esp
    2d8f:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2d93:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    2d97:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2d9b:	88 45 b6             	mov    %al,-0x4a(%ebp)
    pen.size = 1;
    2d9e:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2da5:	8d 45 88             	lea    -0x78(%ebp),%eax
    2da8:	68 cd 00 00 00       	push   $0xcd
    2dad:	6a 74                	push   $0x74
    2daf:	6a 18                	push   $0x18
    2db1:	50                   	push   %eax
    2db2:	e8 41 f4 ff ff       	call   21f8 <RGB>
    2db7:	83 c4 0c             	add    $0xc,%esp
    2dba:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2dbe:	66 89 45 b1          	mov    %ax,-0x4f(%ebp)
    2dc2:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2dc6:	88 45 b3             	mov    %al,-0x4d(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    2dc9:	8b 45 08             	mov    0x8(%ebp),%eax
    2dcc:	8d 50 58             	lea    0x58(%eax),%edx
    2dcf:	8d 45 88             	lea    -0x78(%ebp),%eax
    2dd2:	ff 75 b8             	pushl  -0x48(%ebp)
    2dd5:	ff 75 b4             	pushl  -0x4c(%ebp)
    2dd8:	52                   	push   %edx
    2dd9:	50                   	push   %eax
    2dda:	e8 06 eb ff ff       	call   18e5 <APSetPen>
    2ddf:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2de2:	8b 45 08             	mov    0x8(%ebp),%eax
    2de5:	8d 58 58             	lea    0x58(%eax),%ebx
    2de8:	8d 55 88             	lea    -0x78(%ebp),%edx
    2deb:	83 ec 04             	sub    $0x4,%esp
    2dee:	83 ec 04             	sub    $0x4,%esp
    2df1:	89 e0                	mov    %esp,%eax
    2df3:	0f b7 4d b1          	movzwl -0x4f(%ebp),%ecx
    2df7:	66 89 08             	mov    %cx,(%eax)
    2dfa:	0f b6 4d b3          	movzbl -0x4d(%ebp),%ecx
    2dfe:	88 48 02             	mov    %cl,0x2(%eax)
    2e01:	53                   	push   %ebx
    2e02:	52                   	push   %edx
    2e03:	e8 16 eb ff ff       	call   191e <APSetBrush>
    2e08:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2e0b:	8b 45 08             	mov    0x8(%ebp),%eax
    2e0e:	83 c0 58             	add    $0x58,%eax
    2e11:	83 ec 0c             	sub    $0xc,%esp
    2e14:	6a 32                	push   $0x32
    2e16:	68 20 03 00 00       	push   $0x320
    2e1b:	6a 00                	push   $0x0
    2e1d:	6a 00                	push   $0x0
    2e1f:	50                   	push   %eax
    2e20:	e8 23 ef ff ff       	call   1d48 <APDrawRect>
    2e25:	83 c4 20             	add    $0x20,%esp
    
    
}
    2e28:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2e2b:	5b                   	pop    %ebx
    2e2c:	5e                   	pop    %esi
    2e2d:	5f                   	pop    %edi
    2e2e:	5d                   	pop    %ebp
    2e2f:	c3                   	ret    

00002e30 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2e30:	55                   	push   %ebp
    2e31:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2e33:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2e37:	7e 08                	jle    2e41 <random+0x11>
{
rand_num = seed;
    2e39:	8b 45 08             	mov    0x8(%ebp),%eax
    2e3c:	a3 00 78 00 00       	mov    %eax,0x7800
}
rand_num *= 3;
    2e41:	8b 15 00 78 00 00    	mov    0x7800,%edx
    2e47:	89 d0                	mov    %edx,%eax
    2e49:	01 c0                	add    %eax,%eax
    2e4b:	01 d0                	add    %edx,%eax
    2e4d:	a3 00 78 00 00       	mov    %eax,0x7800
if (rand_num < 0)
    2e52:	a1 00 78 00 00       	mov    0x7800,%eax
    2e57:	85 c0                	test   %eax,%eax
    2e59:	79 0c                	jns    2e67 <random+0x37>
{
rand_num *= (-1);
    2e5b:	a1 00 78 00 00       	mov    0x7800,%eax
    2e60:	f7 d8                	neg    %eax
    2e62:	a3 00 78 00 00       	mov    %eax,0x7800
}
return rand_num % 997;
    2e67:	8b 0d 00 78 00 00    	mov    0x7800,%ecx
    2e6d:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2e72:	89 c8                	mov    %ecx,%eax
    2e74:	f7 ea                	imul   %edx
    2e76:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2e79:	c1 f8 09             	sar    $0x9,%eax
    2e7c:	89 c2                	mov    %eax,%edx
    2e7e:	89 c8                	mov    %ecx,%eax
    2e80:	c1 f8 1f             	sar    $0x1f,%eax
    2e83:	29 c2                	sub    %eax,%edx
    2e85:	89 d0                	mov    %edx,%eax
    2e87:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2e8d:	29 c1                	sub    %eax,%ecx
    2e8f:	89 c8                	mov    %ecx,%eax
}
    2e91:	5d                   	pop    %ebp
    2e92:	c3                   	ret    

00002e93 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2e93:	55                   	push   %ebp
    2e94:	89 e5                	mov    %esp,%ebp
    2e96:	53                   	push   %ebx
    2e97:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2e9a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2ea1:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2ea5:	74 17                	je     2ebe <sprintint+0x2b>
    2ea7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2eab:	79 11                	jns    2ebe <sprintint+0x2b>
        neg = 1;
    2ead:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2eb4:	8b 45 10             	mov    0x10(%ebp),%eax
    2eb7:	f7 d8                	neg    %eax
    2eb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2ebc:	eb 06                	jmp    2ec4 <sprintint+0x31>
    } else {
        x = xx;
    2ebe:	8b 45 10             	mov    0x10(%ebp),%eax
    2ec1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2ec4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2ecb:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2ece:	8d 41 01             	lea    0x1(%ecx),%eax
    2ed1:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2ed4:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2ed7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2eda:	ba 00 00 00 00       	mov    $0x0,%edx
    2edf:	f7 f3                	div    %ebx
    2ee1:	89 d0                	mov    %edx,%eax
    2ee3:	0f b6 80 04 78 00 00 	movzbl 0x7804(%eax),%eax
    2eea:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2eee:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2ef1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2ef4:	ba 00 00 00 00       	mov    $0x0,%edx
    2ef9:	f7 f3                	div    %ebx
    2efb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2efe:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2f02:	75 c7                	jne    2ecb <sprintint+0x38>
    if(neg)
    2f04:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2f08:	74 0e                	je     2f18 <sprintint+0x85>
        buf[i++] = '-';
    2f0a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2f0d:	8d 50 01             	lea    0x1(%eax),%edx
    2f10:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2f13:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2f18:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2f1b:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2f1e:	eb 1b                	jmp    2f3b <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2f20:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f23:	8b 00                	mov    (%eax),%eax
    2f25:	8d 48 01             	lea    0x1(%eax),%ecx
    2f28:	8b 55 0c             	mov    0xc(%ebp),%edx
    2f2b:	89 0a                	mov    %ecx,(%edx)
    2f2d:	89 c2                	mov    %eax,%edx
    2f2f:	8b 45 08             	mov    0x8(%ebp),%eax
    2f32:	01 d0                	add    %edx,%eax
    2f34:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2f37:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2f3b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2f3f:	7f df                	jg     2f20 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2f41:	eb 21                	jmp    2f64 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2f43:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f46:	8b 00                	mov    (%eax),%eax
    2f48:	8d 48 01             	lea    0x1(%eax),%ecx
    2f4b:	8b 55 0c             	mov    0xc(%ebp),%edx
    2f4e:	89 0a                	mov    %ecx,(%edx)
    2f50:	89 c2                	mov    %eax,%edx
    2f52:	8b 45 08             	mov    0x8(%ebp),%eax
    2f55:	01 c2                	add    %eax,%edx
    2f57:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2f5a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2f5d:	01 c8                	add    %ecx,%eax
    2f5f:	0f b6 00             	movzbl (%eax),%eax
    2f62:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2f64:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2f68:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2f6c:	79 d5                	jns    2f43 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2f6e:	90                   	nop
    2f6f:	83 c4 20             	add    $0x20,%esp
    2f72:	5b                   	pop    %ebx
    2f73:	5d                   	pop    %ebp
    2f74:	c3                   	ret    

00002f75 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2f75:	55                   	push   %ebp
    2f76:	89 e5                	mov    %esp,%ebp
    2f78:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2f7b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2f82:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2f89:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2f90:	8d 45 0c             	lea    0xc(%ebp),%eax
    2f93:	83 c0 04             	add    $0x4,%eax
    2f96:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2f99:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2fa0:	e9 d9 01 00 00       	jmp    317e <sprintf+0x209>
        c = fmt[i] & 0xff;
    2fa5:	8b 55 0c             	mov    0xc(%ebp),%edx
    2fa8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2fab:	01 d0                	add    %edx,%eax
    2fad:	0f b6 00             	movzbl (%eax),%eax
    2fb0:	0f be c0             	movsbl %al,%eax
    2fb3:	25 ff 00 00 00       	and    $0xff,%eax
    2fb8:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2fbb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2fbf:	75 2c                	jne    2fed <sprintf+0x78>
            if(c == '%'){
    2fc1:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2fc5:	75 0c                	jne    2fd3 <sprintf+0x5e>
                state = '%';
    2fc7:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2fce:	e9 a7 01 00 00       	jmp    317a <sprintf+0x205>
            } else {
                dst[j++] = c;
    2fd3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2fd6:	8d 50 01             	lea    0x1(%eax),%edx
    2fd9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2fdc:	89 c2                	mov    %eax,%edx
    2fde:	8b 45 08             	mov    0x8(%ebp),%eax
    2fe1:	01 d0                	add    %edx,%eax
    2fe3:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2fe6:	88 10                	mov    %dl,(%eax)
    2fe8:	e9 8d 01 00 00       	jmp    317a <sprintf+0x205>
            }
        } else if(state == '%'){
    2fed:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2ff1:	0f 85 83 01 00 00    	jne    317a <sprintf+0x205>
            if(c == 'd'){
    2ff7:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2ffb:	75 4c                	jne    3049 <sprintf+0xd4>
                buf[bi] = '\0';
    2ffd:	8d 55 ce             	lea    -0x32(%ebp),%edx
    3000:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3003:	01 d0                	add    %edx,%eax
    3005:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    3008:	83 ec 0c             	sub    $0xc,%esp
    300b:	8d 45 ce             	lea    -0x32(%ebp),%eax
    300e:	50                   	push   %eax
    300f:	e8 2b df ff ff       	call   f3f <atoi>
    3014:	83 c4 10             	add    $0x10,%esp
    3017:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    301a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    3021:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3024:	8b 00                	mov    (%eax),%eax
    3026:	83 ec 08             	sub    $0x8,%esp
    3029:	ff 75 d8             	pushl  -0x28(%ebp)
    302c:	6a 01                	push   $0x1
    302e:	6a 0a                	push   $0xa
    3030:	50                   	push   %eax
    3031:	8d 45 c8             	lea    -0x38(%ebp),%eax
    3034:	50                   	push   %eax
    3035:	ff 75 08             	pushl  0x8(%ebp)
    3038:	e8 56 fe ff ff       	call   2e93 <sprintint>
    303d:	83 c4 20             	add    $0x20,%esp
                ap++;
    3040:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    3044:	e9 2a 01 00 00       	jmp    3173 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    3049:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    304d:	74 06                	je     3055 <sprintf+0xe0>
    304f:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    3053:	75 4c                	jne    30a1 <sprintf+0x12c>
                buf[bi] = '\0';
    3055:	8d 55 ce             	lea    -0x32(%ebp),%edx
    3058:	8b 45 f0             	mov    -0x10(%ebp),%eax
    305b:	01 d0                	add    %edx,%eax
    305d:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    3060:	83 ec 0c             	sub    $0xc,%esp
    3063:	8d 45 ce             	lea    -0x32(%ebp),%eax
    3066:	50                   	push   %eax
    3067:	e8 d3 de ff ff       	call   f3f <atoi>
    306c:	83 c4 10             	add    $0x10,%esp
    306f:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    3072:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    3079:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    307c:	8b 00                	mov    (%eax),%eax
    307e:	83 ec 08             	sub    $0x8,%esp
    3081:	ff 75 dc             	pushl  -0x24(%ebp)
    3084:	6a 00                	push   $0x0
    3086:	6a 10                	push   $0x10
    3088:	50                   	push   %eax
    3089:	8d 45 c8             	lea    -0x38(%ebp),%eax
    308c:	50                   	push   %eax
    308d:	ff 75 08             	pushl  0x8(%ebp)
    3090:	e8 fe fd ff ff       	call   2e93 <sprintint>
    3095:	83 c4 20             	add    $0x20,%esp
                ap++;
    3098:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    309c:	e9 d2 00 00 00       	jmp    3173 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    30a1:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    30a5:	75 46                	jne    30ed <sprintf+0x178>
                s = (char*)*ap;
    30a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    30aa:	8b 00                	mov    (%eax),%eax
    30ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    30af:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    30b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    30b7:	75 25                	jne    30de <sprintf+0x169>
                    s = "(null)";
    30b9:	c7 45 f4 1c 35 00 00 	movl   $0x351c,-0xc(%ebp)
                while(*s != 0){
    30c0:	eb 1c                	jmp    30de <sprintf+0x169>
                    dst[j++] = *s;
    30c2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    30c5:	8d 50 01             	lea    0x1(%eax),%edx
    30c8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    30cb:	89 c2                	mov    %eax,%edx
    30cd:	8b 45 08             	mov    0x8(%ebp),%eax
    30d0:	01 c2                	add    %eax,%edx
    30d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    30d5:	0f b6 00             	movzbl (%eax),%eax
    30d8:	88 02                	mov    %al,(%edx)
                    s++;
    30da:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    30de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    30e1:	0f b6 00             	movzbl (%eax),%eax
    30e4:	84 c0                	test   %al,%al
    30e6:	75 da                	jne    30c2 <sprintf+0x14d>
    30e8:	e9 86 00 00 00       	jmp    3173 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    30ed:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    30f1:	75 1d                	jne    3110 <sprintf+0x19b>
                dst[j++] = *ap;
    30f3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    30f6:	8d 50 01             	lea    0x1(%eax),%edx
    30f9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    30fc:	89 c2                	mov    %eax,%edx
    30fe:	8b 45 08             	mov    0x8(%ebp),%eax
    3101:	01 c2                	add    %eax,%edx
    3103:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3106:	8b 00                	mov    (%eax),%eax
    3108:	88 02                	mov    %al,(%edx)
                ap++;
    310a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    310e:	eb 63                	jmp    3173 <sprintf+0x1fe>
            } else if(c == '%'){
    3110:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    3114:	75 17                	jne    312d <sprintf+0x1b8>
                dst[j++] = c;
    3116:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3119:	8d 50 01             	lea    0x1(%eax),%edx
    311c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    311f:	89 c2                	mov    %eax,%edx
    3121:	8b 45 08             	mov    0x8(%ebp),%eax
    3124:	01 d0                	add    %edx,%eax
    3126:	8b 55 e0             	mov    -0x20(%ebp),%edx
    3129:	88 10                	mov    %dl,(%eax)
    312b:	eb 46                	jmp    3173 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    312d:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    3131:	7e 18                	jle    314b <sprintf+0x1d6>
    3133:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    3137:	7f 12                	jg     314b <sprintf+0x1d6>
            {
                buf[bi++] = c;
    3139:	8b 45 f0             	mov    -0x10(%ebp),%eax
    313c:	8d 50 01             	lea    0x1(%eax),%edx
    313f:	89 55 f0             	mov    %edx,-0x10(%ebp)
    3142:	8b 55 e0             	mov    -0x20(%ebp),%edx
    3145:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    3149:	eb 2f                	jmp    317a <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    314b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    314e:	8d 50 01             	lea    0x1(%eax),%edx
    3151:	89 55 c8             	mov    %edx,-0x38(%ebp)
    3154:	89 c2                	mov    %eax,%edx
    3156:	8b 45 08             	mov    0x8(%ebp),%eax
    3159:	01 d0                	add    %edx,%eax
    315b:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    315e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3161:	8d 50 01             	lea    0x1(%eax),%edx
    3164:	89 55 c8             	mov    %edx,-0x38(%ebp)
    3167:	89 c2                	mov    %eax,%edx
    3169:	8b 45 08             	mov    0x8(%ebp),%eax
    316c:	01 d0                	add    %edx,%eax
    316e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    3171:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    3173:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    317a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    317e:	8b 55 0c             	mov    0xc(%ebp),%edx
    3181:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3184:	01 d0                	add    %edx,%eax
    3186:	0f b6 00             	movzbl (%eax),%eax
    3189:	84 c0                	test   %al,%al
    318b:	0f 85 14 fe ff ff    	jne    2fa5 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    3191:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3194:	8d 50 01             	lea    0x1(%eax),%edx
    3197:	89 55 c8             	mov    %edx,-0x38(%ebp)
    319a:	89 c2                	mov    %eax,%edx
    319c:	8b 45 08             	mov    0x8(%ebp),%eax
    319f:	01 d0                	add    %edx,%eax
    31a1:	c6 00 00             	movb   $0x0,(%eax)
}
    31a4:	90                   	nop
    31a5:	c9                   	leave  
    31a6:	c3                   	ret    
