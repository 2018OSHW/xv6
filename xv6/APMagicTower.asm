
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
      e3:	8b 04 85 b0 33 00 00 	mov    0x33b0(,%eax,4),%eax
      ea:	ff e0                	jmp    *%eax
{
	case VK_UP:
		temp = nextpoint(position,Up);
      ec:	8d 45 f0             	lea    -0x10(%ebp),%eax
      ef:	6a 00                	push   $0x0
      f1:	ff 35 a8 7a 00 00    	pushl  0x7aa8
      f7:	ff 35 a4 7a 00 00    	pushl  0x7aa4
      fd:	50                   	push   %eax
      fe:	e8 42 ff ff ff       	call   45 <nextpoint>
     103:	83 c4 0c             	add    $0xc,%esp
		break;
     106:	eb 79                	jmp    181 <keyDown+0xb1>
	case VK_DOWN:

		temp = nextpoint(position,Down);
     108:	8d 45 e0             	lea    -0x20(%ebp),%eax
     10b:	6a 01                	push   $0x1
     10d:	ff 35 a8 7a 00 00    	pushl  0x7aa8
     113:	ff 35 a4 7a 00 00    	pushl  0x7aa4
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
     135:	ff 35 a8 7a 00 00    	pushl  0x7aa8
     13b:	ff 35 a4 7a 00 00    	pushl  0x7aa4
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
     15d:	ff 35 a8 7a 00 00    	pushl  0x7aa8
     163:	ff 35 a4 7a 00 00    	pushl  0x7aa4
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
     181:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     187:	8b 15 a4 7a 00 00    	mov    0x7aa4,%edx
     18d:	8b 0d a8 7a 00 00    	mov    0x7aa8,%ecx
     193:	89 d0                	mov    %edx,%eax
     195:	c1 e0 02             	shl    $0x2,%eax
     198:	01 d0                	add    %edx,%eax
     19a:	01 c0                	add    %eax,%eax
     19c:	6b d3 64             	imul   $0x64,%ebx,%edx
     19f:	01 d0                	add    %edx,%eax
     1a1:	01 c8                	add    %ecx,%eax
     1a3:	c7 04 85 20 7b 00 00 	movl   $0x0,0x7b20(,%eax,4)
     1aa:	00 00 00 00 
position_old = position;
     1ae:	a1 a4 7a 00 00       	mov    0x7aa4,%eax
     1b3:	8b 15 a8 7a 00 00    	mov    0x7aa8,%edx
     1b9:	a3 9c 7a 00 00       	mov    %eax,0x7a9c
     1be:	89 15 a0 7a 00 00    	mov    %edx,0x7aa0
switch(my_tower[floor][temp.x][temp.y])
     1c4:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     1ca:	8b 55 f0             	mov    -0x10(%ebp),%edx
     1cd:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     1d0:	89 d0                	mov    %edx,%eax
     1d2:	c1 e0 02             	shl    $0x2,%eax
     1d5:	01 d0                	add    %edx,%eax
     1d7:	01 c0                	add    %eax,%eax
     1d9:	6b d3 64             	imul   $0x64,%ebx,%edx
     1dc:	01 d0                	add    %edx,%eax
     1de:	01 c8                	add    %ecx,%eax
     1e0:	8b 04 85 20 7b 00 00 	mov    0x7b20(,%eax,4),%eax
     1e7:	83 f8 11             	cmp    $0x11,%eax
     1ea:	0f 87 d4 03 00 00    	ja     5c4 <keyDown+0x4f4>
     1f0:	8b 04 85 c8 33 00 00 	mov    0x33c8(,%eax,4),%eax
     1f7:	ff e0                	jmp    *%eax
{
	case Background:

		position = temp;
     1f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     1fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1ff:	a3 a4 7a 00 00       	mov    %eax,0x7aa4
     204:	89 15 a8 7a 00 00    	mov    %edx,0x7aa8
		break;
     20a:	e9 b9 03 00 00       	jmp    5c8 <keyDown+0x4f8>
	case Wall:
		break;
	case Monster1:
	case Monster2:
	case Monster3:
		position = temp;
     20f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     212:	8b 55 f4             	mov    -0xc(%ebp),%edx
     215:	a3 a4 7a 00 00       	mov    %eax,0x7aa4
     21a:	89 15 a8 7a 00 00    	mov    %edx,0x7aa8
		if(!fight())
     220:	e8 7a 05 00 00       	call   79f <fight>
     225:	84 c0                	test   %al,%al
     227:	0f 85 9a 03 00 00    	jne    5c7 <keyDown+0x4f7>
		{
		printf(1,"Dead");
     22d:	83 ec 08             	sub    $0x8,%esp
     230:	68 84 33 00 00       	push   $0x3384
     235:	6a 01                	push   $0x1
     237:	e8 2f 11 00 00       	call   136b <printf>
     23c:	83 c4 10             	add    $0x10,%esp
		}
		break;
     23f:	e9 83 03 00 00       	jmp    5c7 <keyDown+0x4f7>
	case YellowDoor:
		if (my_key[0] > 0)
     244:	a1 d0 7f 00 00       	mov    0x7fd0,%eax
     249:	85 c0                	test   %eax,%eax
     24b:	7e 4a                	jle    297 <keyDown+0x1c7>
		{
		my_key[0]--;
     24d:	a1 d0 7f 00 00       	mov    0x7fd0,%eax
     252:	83 e8 01             	sub    $0x1,%eax
     255:	a3 d0 7f 00 00       	mov    %eax,0x7fd0
		position = temp;
     25a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     25d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     260:	a3 a4 7a 00 00       	mov    %eax,0x7aa4
     265:	89 15 a8 7a 00 00    	mov    %edx,0x7aa8
		my_tower[floor][temp.x][temp.y] = Background;
     26b:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     271:	8b 55 f0             	mov    -0x10(%ebp),%edx
     274:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     277:	89 d0                	mov    %edx,%eax
     279:	c1 e0 02             	shl    $0x2,%eax
     27c:	01 d0                	add    %edx,%eax
     27e:	01 c0                	add    %eax,%eax
     280:	6b d3 64             	imul   $0x64,%ebx,%edx
     283:	01 d0                	add    %edx,%eax
     285:	01 c8                	add    %ecx,%eax
     287:	c7 04 85 20 7b 00 00 	movl   $0x0,0x7b20(,%eax,4)
     28e:	00 00 00 00 
		}
		else
		{
		printf(1,"No Yellow Key");
		}
		break;
     292:	e9 31 03 00 00       	jmp    5c8 <keyDown+0x4f8>
		position = temp;
		my_tower[floor][temp.x][temp.y] = Background;
		}
		else
		{
		printf(1,"No Yellow Key");
     297:	83 ec 08             	sub    $0x8,%esp
     29a:	68 89 33 00 00       	push   $0x3389
     29f:	6a 01                	push   $0x1
     2a1:	e8 c5 10 00 00       	call   136b <printf>
     2a6:	83 c4 10             	add    $0x10,%esp
		}
		break;
     2a9:	e9 1a 03 00 00       	jmp    5c8 <keyDown+0x4f8>
	case BlueDoor:
		if (my_key[1] > 0)
     2ae:	a1 d4 7f 00 00       	mov    0x7fd4,%eax
     2b3:	85 c0                	test   %eax,%eax
     2b5:	7e 4a                	jle    301 <keyDown+0x231>
		{
		my_key[1]--;
     2b7:	a1 d4 7f 00 00       	mov    0x7fd4,%eax
     2bc:	83 e8 01             	sub    $0x1,%eax
     2bf:	a3 d4 7f 00 00       	mov    %eax,0x7fd4
		position = temp;
     2c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     2c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
     2ca:	a3 a4 7a 00 00       	mov    %eax,0x7aa4
     2cf:	89 15 a8 7a 00 00    	mov    %edx,0x7aa8
		my_tower[floor][temp.x][temp.y] = Background;
     2d5:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     2db:	8b 55 f0             	mov    -0x10(%ebp),%edx
     2de:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     2e1:	89 d0                	mov    %edx,%eax
     2e3:	c1 e0 02             	shl    $0x2,%eax
     2e6:	01 d0                	add    %edx,%eax
     2e8:	01 c0                	add    %eax,%eax
     2ea:	6b d3 64             	imul   $0x64,%ebx,%edx
     2ed:	01 d0                	add    %edx,%eax
     2ef:	01 c8                	add    %ecx,%eax
     2f1:	c7 04 85 20 7b 00 00 	movl   $0x0,0x7b20(,%eax,4)
     2f8:	00 00 00 00 
		}
		else
		{
		printf(1,"No Blue Key");
		}
		break;
     2fc:	e9 c7 02 00 00       	jmp    5c8 <keyDown+0x4f8>
		position = temp;
		my_tower[floor][temp.x][temp.y] = Background;
		}
		else
		{
		printf(1,"No Blue Key");
     301:	83 ec 08             	sub    $0x8,%esp
     304:	68 97 33 00 00       	push   $0x3397
     309:	6a 01                	push   $0x1
     30b:	e8 5b 10 00 00       	call   136b <printf>
     310:	83 c4 10             	add    $0x10,%esp
		}
		break;
     313:	e9 b0 02 00 00       	jmp    5c8 <keyDown+0x4f8>
	case RedDoor:
		if (my_key[1] > 0)
     318:	a1 d4 7f 00 00       	mov    0x7fd4,%eax
     31d:	85 c0                	test   %eax,%eax
     31f:	7e 4a                	jle    36b <keyDown+0x29b>
		{
		my_key[1]--;
     321:	a1 d4 7f 00 00       	mov    0x7fd4,%eax
     326:	83 e8 01             	sub    $0x1,%eax
     329:	a3 d4 7f 00 00       	mov    %eax,0x7fd4
		position = temp;
     32e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     331:	8b 55 f4             	mov    -0xc(%ebp),%edx
     334:	a3 a4 7a 00 00       	mov    %eax,0x7aa4
     339:	89 15 a8 7a 00 00    	mov    %edx,0x7aa8
		my_tower[floor][temp.x][temp.y] = Background;
     33f:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     345:	8b 55 f0             	mov    -0x10(%ebp),%edx
     348:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     34b:	89 d0                	mov    %edx,%eax
     34d:	c1 e0 02             	shl    $0x2,%eax
     350:	01 d0                	add    %edx,%eax
     352:	01 c0                	add    %eax,%eax
     354:	6b d3 64             	imul   $0x64,%ebx,%edx
     357:	01 d0                	add    %edx,%eax
     359:	01 c8                	add    %ecx,%eax
     35b:	c7 04 85 20 7b 00 00 	movl   $0x0,0x7b20(,%eax,4)
     362:	00 00 00 00 
		}
		else
		{
		printf(1,"No red Key");
		}
		break;
     366:	e9 5d 02 00 00       	jmp    5c8 <keyDown+0x4f8>
		position = temp;
		my_tower[floor][temp.x][temp.y] = Background;
		}
		else
		{
		printf(1,"No red Key");
     36b:	83 ec 08             	sub    $0x8,%esp
     36e:	68 a3 33 00 00       	push   $0x33a3
     373:	6a 01                	push   $0x1
     375:	e8 f1 0f 00 00       	call   136b <printf>
     37a:	83 c4 10             	add    $0x10,%esp
		}
		break;
     37d:	e9 46 02 00 00       	jmp    5c8 <keyDown+0x4f8>
	case UpStair:
		floor++;
     382:	a1 8c 7a 00 00       	mov    0x7a8c,%eax
     387:	83 c0 01             	add    $0x1,%eax
     38a:	a3 8c 7a 00 00       	mov    %eax,0x7a8c
		draw(hwnd);
     38f:	83 ec 0c             	sub    $0xc,%esp
     392:	ff 75 08             	pushl  0x8(%ebp)
     395:	e8 3d 05 00 00       	call   8d7 <draw>
     39a:	83 c4 10             	add    $0x10,%esp
		break;
     39d:	e9 26 02 00 00       	jmp    5c8 <keyDown+0x4f8>
	case DownStair:
		floor--;
     3a2:	a1 8c 7a 00 00       	mov    0x7a8c,%eax
     3a7:	83 e8 01             	sub    $0x1,%eax
     3aa:	a3 8c 7a 00 00       	mov    %eax,0x7a8c
		draw(hwnd);
     3af:	83 ec 0c             	sub    $0xc,%esp
     3b2:	ff 75 08             	pushl  0x8(%ebp)
     3b5:	e8 1d 05 00 00       	call   8d7 <draw>
     3ba:	83 c4 10             	add    $0x10,%esp
		break;
     3bd:	e9 06 02 00 00       	jmp    5c8 <keyDown+0x4f8>
	case YellowKey:
		my_key[0]++;
     3c2:	a1 d0 7f 00 00       	mov    0x7fd0,%eax
     3c7:	83 c0 01             	add    $0x1,%eax
     3ca:	a3 d0 7f 00 00       	mov    %eax,0x7fd0
		my_tower[floor][temp.x][temp.y] = Background;
     3cf:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     3d5:	8b 55 f0             	mov    -0x10(%ebp),%edx
     3d8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3db:	89 d0                	mov    %edx,%eax
     3dd:	c1 e0 02             	shl    $0x2,%eax
     3e0:	01 d0                	add    %edx,%eax
     3e2:	01 c0                	add    %eax,%eax
     3e4:	6b d3 64             	imul   $0x64,%ebx,%edx
     3e7:	01 d0                	add    %edx,%eax
     3e9:	01 c8                	add    %ecx,%eax
     3eb:	c7 04 85 20 7b 00 00 	movl   $0x0,0x7b20(,%eax,4)
     3f2:	00 00 00 00 
		position = temp;
     3f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     3f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     3fc:	a3 a4 7a 00 00       	mov    %eax,0x7aa4
     401:	89 15 a8 7a 00 00    	mov    %edx,0x7aa8
		break;
     407:	e9 bc 01 00 00       	jmp    5c8 <keyDown+0x4f8>
	case BlueKey:
		my_key[1]++;
     40c:	a1 d4 7f 00 00       	mov    0x7fd4,%eax
     411:	83 c0 01             	add    $0x1,%eax
     414:	a3 d4 7f 00 00       	mov    %eax,0x7fd4
		my_tower[floor][temp.x][temp.y] = Background;
     419:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     41f:	8b 55 f0             	mov    -0x10(%ebp),%edx
     422:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     425:	89 d0                	mov    %edx,%eax
     427:	c1 e0 02             	shl    $0x2,%eax
     42a:	01 d0                	add    %edx,%eax
     42c:	01 c0                	add    %eax,%eax
     42e:	6b d3 64             	imul   $0x64,%ebx,%edx
     431:	01 d0                	add    %edx,%eax
     433:	01 c8                	add    %ecx,%eax
     435:	c7 04 85 20 7b 00 00 	movl   $0x0,0x7b20(,%eax,4)
     43c:	00 00 00 00 
		position = temp;
     440:	8b 45 f0             	mov    -0x10(%ebp),%eax
     443:	8b 55 f4             	mov    -0xc(%ebp),%edx
     446:	a3 a4 7a 00 00       	mov    %eax,0x7aa4
     44b:	89 15 a8 7a 00 00    	mov    %edx,0x7aa8
		break;
     451:	e9 72 01 00 00       	jmp    5c8 <keyDown+0x4f8>
	case RedKey:
		my_key[2]++;
     456:	a1 d8 7f 00 00       	mov    0x7fd8,%eax
     45b:	83 c0 01             	add    $0x1,%eax
     45e:	a3 d8 7f 00 00       	mov    %eax,0x7fd8
		my_tower[floor][temp.x][temp.y] = Background;
     463:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     469:	8b 55 f0             	mov    -0x10(%ebp),%edx
     46c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     46f:	89 d0                	mov    %edx,%eax
     471:	c1 e0 02             	shl    $0x2,%eax
     474:	01 d0                	add    %edx,%eax
     476:	01 c0                	add    %eax,%eax
     478:	6b d3 64             	imul   $0x64,%ebx,%edx
     47b:	01 d0                	add    %edx,%eax
     47d:	01 c8                	add    %ecx,%eax
     47f:	c7 04 85 20 7b 00 00 	movl   $0x0,0x7b20(,%eax,4)
     486:	00 00 00 00 
		position = temp;
     48a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     48d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     490:	a3 a4 7a 00 00       	mov    %eax,0x7aa4
     495:	89 15 a8 7a 00 00    	mov    %edx,0x7aa8
		break;
     49b:	e9 28 01 00 00       	jmp    5c8 <keyDown+0x4f8>
	case SBlood:
		hp += 100;
     4a0:	a1 18 7b 00 00       	mov    0x7b18,%eax
     4a5:	83 c0 64             	add    $0x64,%eax
     4a8:	a3 18 7b 00 00       	mov    %eax,0x7b18
		my_tower[floor][temp.x][temp.y] = Background;
     4ad:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     4b3:	8b 55 f0             	mov    -0x10(%ebp),%edx
     4b6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     4b9:	89 d0                	mov    %edx,%eax
     4bb:	c1 e0 02             	shl    $0x2,%eax
     4be:	01 d0                	add    %edx,%eax
     4c0:	01 c0                	add    %eax,%eax
     4c2:	6b d3 64             	imul   $0x64,%ebx,%edx
     4c5:	01 d0                	add    %edx,%eax
     4c7:	01 c8                	add    %ecx,%eax
     4c9:	c7 04 85 20 7b 00 00 	movl   $0x0,0x7b20(,%eax,4)
     4d0:	00 00 00 00 
		position = temp;
     4d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
     4da:	a3 a4 7a 00 00       	mov    %eax,0x7aa4
     4df:	89 15 a8 7a 00 00    	mov    %edx,0x7aa8
		break;
     4e5:	e9 de 00 00 00       	jmp    5c8 <keyDown+0x4f8>
	case LBlood:
		hp += 500;
     4ea:	a1 18 7b 00 00       	mov    0x7b18,%eax
     4ef:	05 f4 01 00 00       	add    $0x1f4,%eax
     4f4:	a3 18 7b 00 00       	mov    %eax,0x7b18
		my_tower[floor][temp.x][temp.y] = Background;
     4f9:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     4ff:	8b 55 f0             	mov    -0x10(%ebp),%edx
     502:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     505:	89 d0                	mov    %edx,%eax
     507:	c1 e0 02             	shl    $0x2,%eax
     50a:	01 d0                	add    %edx,%eax
     50c:	01 c0                	add    %eax,%eax
     50e:	6b d3 64             	imul   $0x64,%ebx,%edx
     511:	01 d0                	add    %edx,%eax
     513:	01 c8                	add    %ecx,%eax
     515:	c7 04 85 20 7b 00 00 	movl   $0x0,0x7b20(,%eax,4)
     51c:	00 00 00 00 
		position = temp;
     520:	8b 45 f0             	mov    -0x10(%ebp),%eax
     523:	8b 55 f4             	mov    -0xc(%ebp),%edx
     526:	a3 a4 7a 00 00       	mov    %eax,0x7aa4
     52b:	89 15 a8 7a 00 00    	mov    %edx,0x7aa8
		break;
     531:	e9 92 00 00 00       	jmp    5c8 <keyDown+0x4f8>
	case Attack:
		atk += 1;
     536:	a1 80 7a 00 00       	mov    0x7a80,%eax
     53b:	83 c0 01             	add    $0x1,%eax
     53e:	a3 80 7a 00 00       	mov    %eax,0x7a80
		my_tower[floor][temp.x][temp.y] = Background;
     543:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     549:	8b 55 f0             	mov    -0x10(%ebp),%edx
     54c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     54f:	89 d0                	mov    %edx,%eax
     551:	c1 e0 02             	shl    $0x2,%eax
     554:	01 d0                	add    %edx,%eax
     556:	01 c0                	add    %eax,%eax
     558:	6b d3 64             	imul   $0x64,%ebx,%edx
     55b:	01 d0                	add    %edx,%eax
     55d:	01 c8                	add    %ecx,%eax
     55f:	c7 04 85 20 7b 00 00 	movl   $0x0,0x7b20(,%eax,4)
     566:	00 00 00 00 
		position = temp;
     56a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     56d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     570:	a3 a4 7a 00 00       	mov    %eax,0x7aa4
     575:	89 15 a8 7a 00 00    	mov    %edx,0x7aa8
		break;
     57b:	eb 4b                	jmp    5c8 <keyDown+0x4f8>
	case Defend:
		def += 1;
     57d:	a1 84 7a 00 00       	mov    0x7a84,%eax
     582:	83 c0 01             	add    $0x1,%eax
     585:	a3 84 7a 00 00       	mov    %eax,0x7a84
		my_tower[floor][temp.x][temp.y] = Background;
     58a:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     590:	8b 55 f0             	mov    -0x10(%ebp),%edx
     593:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     596:	89 d0                	mov    %edx,%eax
     598:	c1 e0 02             	shl    $0x2,%eax
     59b:	01 d0                	add    %edx,%eax
     59d:	01 c0                	add    %eax,%eax
     59f:	6b d3 64             	imul   $0x64,%ebx,%edx
     5a2:	01 d0                	add    %edx,%eax
     5a4:	01 c8                	add    %ecx,%eax
     5a6:	c7 04 85 20 7b 00 00 	movl   $0x0,0x7b20(,%eax,4)
     5ad:	00 00 00 00 
		position = temp;
     5b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
     5b7:	a3 a4 7a 00 00       	mov    %eax,0x7aa4
     5bc:	89 15 a8 7a 00 00    	mov    %edx,0x7aa8
		break;	
     5c2:	eb 04                	jmp    5c8 <keyDown+0x4f8>
	default:
		break;
     5c4:	90                   	nop
     5c5:	eb 01                	jmp    5c8 <keyDown+0x4f8>
		position = temp;
		if(!fight())
		{
		printf(1,"Dead");
		}
		break;
     5c7:	90                   	nop
		position = temp;
		break;	
	default:
		break;
}
my_tower[floor][position.x][position.y] = Valiant;
     5c8:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     5ce:	8b 15 a4 7a 00 00    	mov    0x7aa4,%edx
     5d4:	8b 0d a8 7a 00 00    	mov    0x7aa8,%ecx
     5da:	89 d0                	mov    %edx,%eax
     5dc:	c1 e0 02             	shl    $0x2,%eax
     5df:	01 d0                	add    %edx,%eax
     5e1:	01 c0                	add    %eax,%eax
     5e3:	6b d3 64             	imul   $0x64,%ebx,%edx
     5e6:	01 d0                	add    %edx,%eax
     5e8:	01 c8                	add    %ecx,%eax
     5ea:	c7 04 85 20 7b 00 00 	movl   $0x5,0x7b20(,%eax,4)
     5f1:	05 00 00 00 
     5f5:	eb 01                	jmp    5f8 <keyDown+0x528>

		temp = nextpoint(position,Right);
		break;
	case VK_ESC:

		return ;
     5f7:	90                   	nop
		break;	
	default:
		break;
}
my_tower[floor][position.x][position.y] = Valiant;
}
     5f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5fb:	c9                   	leave  
     5fc:	c3                   	ret    

000005fd <TowerInit>:

void TowerInit()
{
     5fd:	55                   	push   %ebp
     5fe:	89 e5                	mov    %esp,%ebp
     600:	83 ec 10             	sub    $0x10,%esp
for (int i = 0;i < BLOCK_NUM_X;i++)
     603:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     60a:	e9 aa 00 00 00       	jmp    6b9 <TowerInit+0xbc>
{
for (int j = 0;j < BLOCK_NUM_Y;j++)
     60f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
     616:	e9 90 00 00 00       	jmp    6ab <TowerInit+0xae>
{
my_tower[0][i][j] =my_tower[1][i][j] =my_tower[2][i][j] = Background;
     61b:	8b 55 fc             	mov    -0x4(%ebp),%edx
     61e:	89 d0                	mov    %edx,%eax
     620:	c1 e0 02             	shl    $0x2,%eax
     623:	01 d0                	add    %edx,%eax
     625:	01 c0                	add    %eax,%eax
     627:	8b 55 f8             	mov    -0x8(%ebp),%edx
     62a:	01 d0                	add    %edx,%eax
     62c:	05 c8 00 00 00       	add    $0xc8,%eax
     631:	c7 04 85 20 7b 00 00 	movl   $0x0,0x7b20(,%eax,4)
     638:	00 00 00 00 
     63c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     63f:	89 d0                	mov    %edx,%eax
     641:	c1 e0 02             	shl    $0x2,%eax
     644:	01 d0                	add    %edx,%eax
     646:	01 c0                	add    %eax,%eax
     648:	8b 55 f8             	mov    -0x8(%ebp),%edx
     64b:	01 d0                	add    %edx,%eax
     64d:	05 c8 00 00 00       	add    $0xc8,%eax
     652:	8b 0c 85 20 7b 00 00 	mov    0x7b20(,%eax,4),%ecx
     659:	8b 55 fc             	mov    -0x4(%ebp),%edx
     65c:	89 d0                	mov    %edx,%eax
     65e:	c1 e0 02             	shl    $0x2,%eax
     661:	01 d0                	add    %edx,%eax
     663:	01 c0                	add    %eax,%eax
     665:	8b 55 f8             	mov    -0x8(%ebp),%edx
     668:	01 d0                	add    %edx,%eax
     66a:	83 c0 64             	add    $0x64,%eax
     66d:	89 0c 85 20 7b 00 00 	mov    %ecx,0x7b20(,%eax,4)
     674:	8b 55 fc             	mov    -0x4(%ebp),%edx
     677:	89 d0                	mov    %edx,%eax
     679:	c1 e0 02             	shl    $0x2,%eax
     67c:	01 d0                	add    %edx,%eax
     67e:	01 c0                	add    %eax,%eax
     680:	8b 55 f8             	mov    -0x8(%ebp),%edx
     683:	01 d0                	add    %edx,%eax
     685:	83 c0 64             	add    $0x64,%eax
     688:	8b 0c 85 20 7b 00 00 	mov    0x7b20(,%eax,4),%ecx
     68f:	8b 55 fc             	mov    -0x4(%ebp),%edx
     692:	89 d0                	mov    %edx,%eax
     694:	c1 e0 02             	shl    $0x2,%eax
     697:	01 d0                	add    %edx,%eax
     699:	01 c0                	add    %eax,%eax
     69b:	8b 55 f8             	mov    -0x8(%ebp),%edx
     69e:	01 d0                	add    %edx,%eax
     6a0:	89 0c 85 20 7b 00 00 	mov    %ecx,0x7b20(,%eax,4)

void TowerInit()
{
for (int i = 0;i < BLOCK_NUM_X;i++)
{
for (int j = 0;j < BLOCK_NUM_Y;j++)
     6a7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     6ab:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
     6af:	0f 8e 66 ff ff ff    	jle    61b <TowerInit+0x1e>
my_tower[floor][position.x][position.y] = Valiant;
}

void TowerInit()
{
for (int i = 0;i < BLOCK_NUM_X;i++)
     6b5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     6b9:	83 7d fc 09          	cmpl   $0x9,-0x4(%ebp)
     6bd:	0f 8e 4c ff ff ff    	jle    60f <TowerInit+0x12>
{
my_tower[0][i][j] =my_tower[1][i][j] =my_tower[2][i][j] = Background;
}
}

my_tower[0][1][1] = Monster1; 
     6c3:	c7 05 4c 7b 00 00 02 	movl   $0x2,0x7b4c
     6ca:	00 00 00 
my_tower[0][2][2] = UpStair;
     6cd:	c7 05 78 7b 00 00 09 	movl   $0x9,0x7b78
     6d4:	00 00 00 
my_tower[1][2][2] = DownStair;
     6d7:	c7 05 08 7d 00 00 0a 	movl   $0xa,0x7d08
     6de:	00 00 00 
//init my_tower


}//init the tower
     6e1:	90                   	nop
     6e2:	c9                   	leave  
     6e3:	c3                   	ret    

000006e4 <init>:

void init(AHwnd hwnd)
{
     6e4:	55                   	push   %ebp
     6e5:	89 e5                	mov    %esp,%ebp
     6e7:	53                   	push   %ebx
     6e8:	83 ec 14             	sub    $0x14,%esp
	TowerInit();
     6eb:	e8 0d ff ff ff       	call   5fd <TowerInit>

	hp = START_HP;
     6f0:	c7 05 18 7b 00 00 f4 	movl   $0x1f4,0x7b18
     6f7:	01 00 00 
	atk = START_ATK;
     6fa:	c7 05 80 7a 00 00 0a 	movl   $0xa,0x7a80
     701:	00 00 00 
	def = START_DEF;
     704:	c7 05 84 7a 00 00 0a 	movl   $0xa,0x7a84
     70b:	00 00 00 
	//init the Viliant

	floor = 0;
     70e:	c7 05 8c 7a 00 00 00 	movl   $0x0,0x7a8c
     715:	00 00 00 
	position.x = position.y = 0;
     718:	c7 05 a8 7a 00 00 00 	movl   $0x0,0x7aa8
     71f:	00 00 00 
     722:	a1 a8 7a 00 00       	mov    0x7aa8,%eax
     727:	a3 a4 7a 00 00       	mov    %eax,0x7aa4
	my_tower[floor][position.x][position.y] = Valiant;
     72c:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     732:	8b 15 a4 7a 00 00    	mov    0x7aa4,%edx
     738:	8b 0d a8 7a 00 00    	mov    0x7aa8,%ecx
     73e:	89 d0                	mov    %edx,%eax
     740:	c1 e0 02             	shl    $0x2,%eax
     743:	01 d0                	add    %edx,%eax
     745:	01 c0                	add    %eax,%eax
     747:	6b d3 64             	imul   $0x64,%ebx,%edx
     74a:	01 d0                	add    %edx,%eax
     74c:	01 c8                	add    %ecx,%eax
     74e:	c7 04 85 20 7b 00 00 	movl   $0x5,0x7b20(,%eax,4)
     755:	05 00 00 00 
	my_key[0] = 3;
     759:	c7 05 d0 7f 00 00 03 	movl   $0x3,0x7fd0
     760:	00 00 00 
	my_key[1] = my_key[2] = 0;
     763:	c7 05 d8 7f 00 00 00 	movl   $0x0,0x7fd8
     76a:	00 00 00 
     76d:	a1 d8 7f 00 00       	mov    0x7fd8,%eax
     772:	a3 d4 7f 00 00       	mov    %eax,0x7fd4
 lblood = APLoadBitmap ("lblood.bmp");
 attack = APLoadBitmap ("attack1.bmp");
 defend = APLoadBitmap ("defend.bmp");*/
	//bitmap init	
	AMessage msg;
	msg.type = MSG_PAINT;
     777:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
	msg.param = 0;
     77e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	APSendMessage(hwnd,msg);
     785:	ff 75 f4             	pushl  -0xc(%ebp)
     788:	ff 75 f0             	pushl  -0x10(%ebp)
     78b:	ff 75 ec             	pushl  -0x14(%ebp)
     78e:	ff 75 08             	pushl  0x8(%ebp)
     791:	e8 82 1c 00 00       	call   2418 <APSendMessage>
     796:	83 c4 10             	add    $0x10,%esp

}
     799:	90                   	nop
     79a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     79d:	c9                   	leave  
     79e:	c3                   	ret    

0000079f <fight>:


bool fight()
{
     79f:	55                   	push   %ebp
     7a0:	89 e5                	mov    %esp,%ebp
     7a2:	53                   	push   %ebx
     7a3:	83 ec 14             	sub    $0x14,%esp
printf(1,"hp before:%d\n",hp);
     7a6:	a1 18 7b 00 00       	mov    0x7b18,%eax
     7ab:	83 ec 04             	sub    $0x4,%esp
     7ae:	50                   	push   %eax
     7af:	68 10 34 00 00       	push   $0x3410
     7b4:	6a 01                	push   $0x1
     7b6:	e8 b0 0b 00 00       	call   136b <printf>
     7bb:	83 c4 10             	add    $0x10,%esp
int mhp,matk,mdef,mid;
switch(my_tower[floor][position.x][position.y])
     7be:	8b 1d 8c 7a 00 00    	mov    0x7a8c,%ebx
     7c4:	8b 15 a4 7a 00 00    	mov    0x7aa4,%edx
     7ca:	8b 0d a8 7a 00 00    	mov    0x7aa8,%ecx
     7d0:	89 d0                	mov    %edx,%eax
     7d2:	c1 e0 02             	shl    $0x2,%eax
     7d5:	01 d0                	add    %edx,%eax
     7d7:	01 c0                	add    %eax,%eax
     7d9:	6b d3 64             	imul   $0x64,%ebx,%edx
     7dc:	01 d0                	add    %edx,%eax
     7de:	01 c8                	add    %ecx,%eax
     7e0:	8b 04 85 20 7b 00 00 	mov    0x7b20(,%eax,4),%eax
     7e7:	83 f8 03             	cmp    $0x3,%eax
     7ea:	74 13                	je     7ff <fight+0x60>
     7ec:	83 f8 04             	cmp    $0x4,%eax
     7ef:	74 17                	je     808 <fight+0x69>
     7f1:	83 f8 02             	cmp    $0x2,%eax
     7f4:	75 1b                	jne    811 <fight+0x72>
{
	case Monster1:
	mid = 0;
     7f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	break;
     7fd:	eb 1a                	jmp    819 <fight+0x7a>
	case Monster2:
	mid = 1;
     7ff:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
	break;
     806:	eb 11                	jmp    819 <fight+0x7a>
	case Monster3:
	mid = 2;
     808:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%ebp)
	break;
     80f:	eb 08                	jmp    819 <fight+0x7a>
	default:
	mid = 0;
     811:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	break;
     818:	90                   	nop
}
mhp = monster_info[mid][0];
     819:	8b 55 f0             	mov    -0x10(%ebp),%edx
     81c:	89 d0                	mov    %edx,%eax
     81e:	01 c0                	add    %eax,%eax
     820:	01 d0                	add    %edx,%eax
     822:	c1 e0 02             	shl    $0x2,%eax
     825:	05 e0 3d 00 00       	add    $0x3de0,%eax
     82a:	8b 00                	mov    (%eax),%eax
     82c:	89 45 f4             	mov    %eax,-0xc(%ebp)
matk = monster_info[mid][1];
     82f:	8b 55 f0             	mov    -0x10(%ebp),%edx
     832:	89 d0                	mov    %edx,%eax
     834:	01 c0                	add    %eax,%eax
     836:	01 d0                	add    %edx,%eax
     838:	c1 e0 02             	shl    $0x2,%eax
     83b:	05 e4 3d 00 00       	add    $0x3de4,%eax
     840:	8b 00                	mov    (%eax),%eax
     842:	89 45 ec             	mov    %eax,-0x14(%ebp)
mdef = monster_info[mid][2];//load monster info
     845:	8b 55 f0             	mov    -0x10(%ebp),%edx
     848:	89 d0                	mov    %edx,%eax
     84a:	01 c0                	add    %eax,%eax
     84c:	01 d0                	add    %edx,%eax
     84e:	c1 e0 02             	shl    $0x2,%eax
     851:	05 e8 3d 00 00       	add    $0x3de8,%eax
     856:	8b 00                	mov    (%eax),%eax
     858:	89 45 e8             	mov    %eax,-0x18(%ebp)
if (atk <= mdef)
     85b:	a1 80 7a 00 00       	mov    0x7a80,%eax
     860:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     863:	7f 07                	jg     86c <fight+0xcd>
{
	return false;
     865:	b8 00 00 00 00       	mov    $0x0,%eax
     86a:	eb 66                	jmp    8d2 <fight+0x133>
}//cannot win
while(true)
{
	mhp -= (atk - mdef);
     86c:	a1 80 7a 00 00       	mov    0x7a80,%eax
     871:	2b 45 e8             	sub    -0x18(%ebp),%eax
     874:	29 45 f4             	sub    %eax,-0xc(%ebp)
	if (mhp <= 0)
     877:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     87b:	7f 1f                	jg     89c <fight+0xfd>
	{
		
printf(1,"hp after:%d\n",hp);
     87d:	a1 18 7b 00 00       	mov    0x7b18,%eax
     882:	83 ec 04             	sub    $0x4,%esp
     885:	50                   	push   %eax
     886:	68 1e 34 00 00       	push   $0x341e
     88b:	6a 01                	push   $0x1
     88d:	e8 d9 0a 00 00       	call   136b <printf>
     892:	83 c4 10             	add    $0x10,%esp
		return true;
     895:	b8 01 00 00 00       	mov    $0x1,%eax
     89a:	eb 36                	jmp    8d2 <fight+0x133>
	}
	if (matk < def)
     89c:	a1 84 7a 00 00       	mov    0x7a84,%eax
     8a1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     8a4:	7c 29                	jl     8cf <fight+0x130>
	{
		continue;
	}
	hp -= (matk - def);
     8a6:	a1 18 7b 00 00       	mov    0x7b18,%eax
     8ab:	8b 15 84 7a 00 00    	mov    0x7a84,%edx
     8b1:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     8b4:	29 d1                	sub    %edx,%ecx
     8b6:	89 ca                	mov    %ecx,%edx
     8b8:	29 d0                	sub    %edx,%eax
     8ba:	a3 18 7b 00 00       	mov    %eax,0x7b18
	if (hp <= 0)
     8bf:	a1 18 7b 00 00       	mov    0x7b18,%eax
     8c4:	85 c0                	test   %eax,%eax
     8c6:	7f a4                	jg     86c <fight+0xcd>
	{
		return false;
     8c8:	b8 00 00 00 00       	mov    $0x0,%eax
     8cd:	eb 03                	jmp    8d2 <fight+0x133>
printf(1,"hp after:%d\n",hp);
		return true;
	}
	if (matk < def)
	{
		continue;
     8cf:	90                   	nop
	hp -= (matk - def);
	if (hp <= 0)
	{
		return false;
	}
}
     8d0:	eb 9a                	jmp    86c <fight+0xcd>

//
}
     8d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8d5:	c9                   	leave  
     8d6:	c3                   	ret    

000008d7 <draw>:

void draw(AHwnd hwnd)
{
     8d7:	55                   	push   %ebp
     8d8:	89 e5                	mov    %esp,%ebp
     8da:	83 ec 18             	sub    $0x18,%esp
for (int i = 0;i < BLOCK_NUM_X;i++)
     8dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     8e4:	eb 2b                	jmp    911 <draw+0x3a>
{
for (int j = 0;j < BLOCK_NUM_Y;j++)
     8e6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     8ed:	eb 18                	jmp    907 <draw+0x30>
{
drawone(hwnd,i,j);
     8ef:	83 ec 04             	sub    $0x4,%esp
     8f2:	ff 75 f0             	pushl  -0x10(%ebp)
     8f5:	ff 75 f4             	pushl  -0xc(%ebp)
     8f8:	ff 75 08             	pushl  0x8(%ebp)
     8fb:	e8 1a 00 00 00       	call   91a <drawone>
     900:	83 c4 10             	add    $0x10,%esp

void draw(AHwnd hwnd)
{
for (int i = 0;i < BLOCK_NUM_X;i++)
{
for (int j = 0;j < BLOCK_NUM_Y;j++)
     903:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     907:	83 7d f0 09          	cmpl   $0x9,-0x10(%ebp)
     90b:	7e e2                	jle    8ef <draw+0x18>
//
}

void draw(AHwnd hwnd)
{
for (int i = 0;i < BLOCK_NUM_X;i++)
     90d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     911:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     915:	7e cf                	jle    8e6 <draw+0xf>
{
drawone(hwnd,i,j);
}
}

}
     917:	90                   	nop
     918:	c9                   	leave  
     919:	c3                   	ret    

0000091a <drawone>:

void drawone(AHwnd hwnd,int i,int j)
{
     91a:	55                   	push   %ebp
     91b:	89 e5                	mov    %esp,%ebp
     91d:	57                   	push   %edi
     91e:	56                   	push   %esi
     91f:	53                   	push   %ebx
     920:	83 ec 3c             	sub    $0x3c,%esp
printf(1,"draw one:%d\n",++con);
     923:	a1 60 7a 00 00       	mov    0x7a60,%eax
     928:	83 c0 01             	add    $0x1,%eax
     92b:	a3 60 7a 00 00       	mov    %eax,0x7a60
     930:	a1 60 7a 00 00       	mov    0x7a60,%eax
     935:	83 ec 04             	sub    $0x4,%esp
     938:	50                   	push   %eax
     939:	68 2b 34 00 00       	push   $0x342b
     93e:	6a 01                	push   $0x1
     940:	e8 26 0a 00 00       	call   136b <printf>
     945:	83 c4 10             	add    $0x10,%esp
ABitmap temp;
switch(my_tower[floor][i][j])
     948:	8b 0d 8c 7a 00 00    	mov    0x7a8c,%ecx
     94e:	8b 55 0c             	mov    0xc(%ebp),%edx
     951:	89 d0                	mov    %edx,%eax
     953:	c1 e0 02             	shl    $0x2,%eax
     956:	01 d0                	add    %edx,%eax
     958:	01 c0                	add    %eax,%eax
     95a:	6b d1 64             	imul   $0x64,%ecx,%edx
     95d:	01 c2                	add    %eax,%edx
     95f:	8b 45 10             	mov    0x10(%ebp),%eax
     962:	01 d0                	add    %edx,%eax
     964:	8b 04 85 20 7b 00 00 	mov    0x7b20(,%eax,4),%eax
     96b:	83 f8 11             	cmp    $0x11,%eax
     96e:	0f 87 82 03 00 00    	ja     cf6 <drawone+0x3dc>
     974:	8b 04 85 18 35 00 00 	mov    0x3518(,%eax,4),%eax
     97b:	ff e0                	jmp    *%eax
{
case Background:
	//temp = background;
	temp = APLoadBitmap ("background.bmp");
     97d:	8d 45 d0             	lea    -0x30(%ebp),%eax
     980:	83 ec 08             	sub    $0x8,%esp
     983:	68 38 34 00 00       	push   $0x3438
     988:	50                   	push   %eax
     989:	e8 63 0e 00 00       	call   17f1 <APLoadBitmap>
     98e:	83 c4 0c             	add    $0xc,%esp
	break;
     991:	e9 87 03 00 00       	jmp    d1d <drawone+0x403>
case Wall:
	//temp = wall;
	temp = APLoadBitmap ("wall.bmp");
     996:	8d 45 b8             	lea    -0x48(%ebp),%eax
     999:	83 ec 08             	sub    $0x8,%esp
     99c:	68 47 34 00 00       	push   $0x3447
     9a1:	50                   	push   %eax
     9a2:	e8 4a 0e 00 00       	call   17f1 <APLoadBitmap>
     9a7:	83 c4 0c             	add    $0xc,%esp
     9aa:	8b 45 b8             	mov    -0x48(%ebp),%eax
     9ad:	89 45 d0             	mov    %eax,-0x30(%ebp)
     9b0:	8b 45 bc             	mov    -0x44(%ebp),%eax
     9b3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     9b6:	8b 45 c0             	mov    -0x40(%ebp),%eax
     9b9:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     9bc:	e9 5c 03 00 00       	jmp    d1d <drawone+0x403>
case Monster1:
	//temp = monster1;
	temp = APLoadBitmap ("monster1.bmp");
     9c1:	8d 45 b8             	lea    -0x48(%ebp),%eax
     9c4:	83 ec 08             	sub    $0x8,%esp
     9c7:	68 50 34 00 00       	push   $0x3450
     9cc:	50                   	push   %eax
     9cd:	e8 1f 0e 00 00       	call   17f1 <APLoadBitmap>
     9d2:	83 c4 0c             	add    $0xc,%esp
     9d5:	8b 45 b8             	mov    -0x48(%ebp),%eax
     9d8:	89 45 d0             	mov    %eax,-0x30(%ebp)
     9db:	8b 45 bc             	mov    -0x44(%ebp),%eax
     9de:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     9e1:	8b 45 c0             	mov    -0x40(%ebp),%eax
     9e4:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     9e7:	e9 31 03 00 00       	jmp    d1d <drawone+0x403>
case Monster2:
	//temp = monster2;	
	temp = APLoadBitmap ("monster2.bmp");
     9ec:	8d 45 b8             	lea    -0x48(%ebp),%eax
     9ef:	83 ec 08             	sub    $0x8,%esp
     9f2:	68 5d 34 00 00       	push   $0x345d
     9f7:	50                   	push   %eax
     9f8:	e8 f4 0d 00 00       	call   17f1 <APLoadBitmap>
     9fd:	83 c4 0c             	add    $0xc,%esp
     a00:	8b 45 b8             	mov    -0x48(%ebp),%eax
     a03:	89 45 d0             	mov    %eax,-0x30(%ebp)
     a06:	8b 45 bc             	mov    -0x44(%ebp),%eax
     a09:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     a0c:	8b 45 c0             	mov    -0x40(%ebp),%eax
     a0f:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     a12:	e9 06 03 00 00       	jmp    d1d <drawone+0x403>
case Monster3:
	//temp = monster3;
	temp = APLoadBitmap ("monster3.bmp");
     a17:	8d 45 b8             	lea    -0x48(%ebp),%eax
     a1a:	83 ec 08             	sub    $0x8,%esp
     a1d:	68 6a 34 00 00       	push   $0x346a
     a22:	50                   	push   %eax
     a23:	e8 c9 0d 00 00       	call   17f1 <APLoadBitmap>
     a28:	83 c4 0c             	add    $0xc,%esp
     a2b:	8b 45 b8             	mov    -0x48(%ebp),%eax
     a2e:	89 45 d0             	mov    %eax,-0x30(%ebp)
     a31:	8b 45 bc             	mov    -0x44(%ebp),%eax
     a34:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     a37:	8b 45 c0             	mov    -0x40(%ebp),%eax
     a3a:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     a3d:	e9 db 02 00 00       	jmp    d1d <drawone+0x403>
case Valiant:
	//temp = valiant;
	temp = APLoadBitmap ("background.bmp");
     a42:	8d 45 b8             	lea    -0x48(%ebp),%eax
     a45:	83 ec 08             	sub    $0x8,%esp
     a48:	68 38 34 00 00       	push   $0x3438
     a4d:	50                   	push   %eax
     a4e:	e8 9e 0d 00 00       	call   17f1 <APLoadBitmap>
     a53:	83 c4 0c             	add    $0xc,%esp
     a56:	8b 45 b8             	mov    -0x48(%ebp),%eax
     a59:	89 45 d0             	mov    %eax,-0x30(%ebp)
     a5c:	8b 45 bc             	mov    -0x44(%ebp),%eax
     a5f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     a62:	8b 45 c0             	mov    -0x40(%ebp),%eax
     a65:	89 45 d8             	mov    %eax,-0x28(%ebp)
	APDcCopy(&hwnd->Dc,i * BLOCK_WIDTH ,j * BLOCK_WIDTH,APCreateCompatibleDCFromBitmap(temp),0,0,BLOCK_WIDTH,BLOCK_WIDTH,COLOR_NULL);
     a68:	8d 45 df             	lea    -0x21(%ebp),%eax
     a6b:	6a 0c                	push   $0xc
     a6d:	6a 0c                	push   $0xc
     a6f:	6a 0c                	push   $0xc
     a71:	50                   	push   %eax
     a72:	e8 89 f5 ff ff       	call   0 <RGB>
     a77:	83 c4 0c             	add    $0xc,%esp
     a7a:	83 ec 04             	sub    $0x4,%esp
     a7d:	ff 75 d8             	pushl  -0x28(%ebp)
     a80:	ff 75 d4             	pushl  -0x2c(%ebp)
     a83:	ff 75 d0             	pushl  -0x30(%ebp)
     a86:	e8 a0 0f 00 00       	call   1a2b <APCreateCompatibleDCFromBitmap>
     a8b:	83 c4 10             	add    $0x10,%esp
     a8e:	89 c7                	mov    %eax,%edi
     a90:	8b 45 10             	mov    0x10(%ebp),%eax
     a93:	c1 e0 05             	shl    $0x5,%eax
     a96:	89 c6                	mov    %eax,%esi
     a98:	8b 45 0c             	mov    0xc(%ebp),%eax
     a9b:	c1 e0 05             	shl    $0x5,%eax
     a9e:	89 c3                	mov    %eax,%ebx
     aa0:	8b 45 08             	mov    0x8(%ebp),%eax
     aa3:	8d 48 3c             	lea    0x3c(%eax),%ecx
     aa6:	83 ec 0c             	sub    $0xc,%esp
     aa9:	83 ec 04             	sub    $0x4,%esp
     aac:	89 e0                	mov    %esp,%eax
     aae:	0f b7 55 df          	movzwl -0x21(%ebp),%edx
     ab2:	66 89 10             	mov    %dx,(%eax)
     ab5:	0f b6 55 e1          	movzbl -0x1f(%ebp),%edx
     ab9:	88 50 02             	mov    %dl,0x2(%eax)
     abc:	6a 20                	push   $0x20
     abe:	6a 20                	push   $0x20
     ac0:	6a 00                	push   $0x0
     ac2:	6a 00                	push   $0x0
     ac4:	57                   	push   %edi
     ac5:	56                   	push   %esi
     ac6:	53                   	push   %ebx
     ac7:	51                   	push   %ecx
     ac8:	e8 62 17 00 00       	call   222f <APDcCopy>
     acd:	83 c4 30             	add    $0x30,%esp
	temp = APLoadBitmap ("valiant.bmp");
     ad0:	8d 45 b8             	lea    -0x48(%ebp),%eax
     ad3:	83 ec 08             	sub    $0x8,%esp
     ad6:	68 77 34 00 00       	push   $0x3477
     adb:	50                   	push   %eax
     adc:	e8 10 0d 00 00       	call   17f1 <APLoadBitmap>
     ae1:	83 c4 0c             	add    $0xc,%esp
     ae4:	8b 45 b8             	mov    -0x48(%ebp),%eax
     ae7:	89 45 d0             	mov    %eax,-0x30(%ebp)
     aea:	8b 45 bc             	mov    -0x44(%ebp),%eax
     aed:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     af0:	8b 45 c0             	mov    -0x40(%ebp),%eax
     af3:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     af6:	e9 22 02 00 00       	jmp    d1d <drawone+0x403>
case YellowDoor:
	//temp = yellowdoor;
	temp = APLoadBitmap ("yellowdoor.bmp");
     afb:	8d 45 b8             	lea    -0x48(%ebp),%eax
     afe:	83 ec 08             	sub    $0x8,%esp
     b01:	68 83 34 00 00       	push   $0x3483
     b06:	50                   	push   %eax
     b07:	e8 e5 0c 00 00       	call   17f1 <APLoadBitmap>
     b0c:	83 c4 0c             	add    $0xc,%esp
     b0f:	8b 45 b8             	mov    -0x48(%ebp),%eax
     b12:	89 45 d0             	mov    %eax,-0x30(%ebp)
     b15:	8b 45 bc             	mov    -0x44(%ebp),%eax
     b18:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     b1b:	8b 45 c0             	mov    -0x40(%ebp),%eax
     b1e:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     b21:	e9 f7 01 00 00       	jmp    d1d <drawone+0x403>
case BlueDoor:
	//temp = bluedoor;
	temp = APLoadBitmap ("bluedoor.bmp");
     b26:	8d 45 b8             	lea    -0x48(%ebp),%eax
     b29:	83 ec 08             	sub    $0x8,%esp
     b2c:	68 92 34 00 00       	push   $0x3492
     b31:	50                   	push   %eax
     b32:	e8 ba 0c 00 00       	call   17f1 <APLoadBitmap>
     b37:	83 c4 0c             	add    $0xc,%esp
     b3a:	8b 45 b8             	mov    -0x48(%ebp),%eax
     b3d:	89 45 d0             	mov    %eax,-0x30(%ebp)
     b40:	8b 45 bc             	mov    -0x44(%ebp),%eax
     b43:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     b46:	8b 45 c0             	mov    -0x40(%ebp),%eax
     b49:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     b4c:	e9 cc 01 00 00       	jmp    d1d <drawone+0x403>
case RedDoor:
	//temp = reddoor;
	temp = APLoadBitmap ("reddoor.bmp");
     b51:	8d 45 b8             	lea    -0x48(%ebp),%eax
     b54:	83 ec 08             	sub    $0x8,%esp
     b57:	68 9f 34 00 00       	push   $0x349f
     b5c:	50                   	push   %eax
     b5d:	e8 8f 0c 00 00       	call   17f1 <APLoadBitmap>
     b62:	83 c4 0c             	add    $0xc,%esp
     b65:	8b 45 b8             	mov    -0x48(%ebp),%eax
     b68:	89 45 d0             	mov    %eax,-0x30(%ebp)
     b6b:	8b 45 bc             	mov    -0x44(%ebp),%eax
     b6e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     b71:	8b 45 c0             	mov    -0x40(%ebp),%eax
     b74:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     b77:	e9 a1 01 00 00       	jmp    d1d <drawone+0x403>
case UpStair:
	//temp = upstair;
	temp = APLoadBitmap ("upstair.bmp");
     b7c:	8d 45 b8             	lea    -0x48(%ebp),%eax
     b7f:	83 ec 08             	sub    $0x8,%esp
     b82:	68 ab 34 00 00       	push   $0x34ab
     b87:	50                   	push   %eax
     b88:	e8 64 0c 00 00       	call   17f1 <APLoadBitmap>
     b8d:	83 c4 0c             	add    $0xc,%esp
     b90:	8b 45 b8             	mov    -0x48(%ebp),%eax
     b93:	89 45 d0             	mov    %eax,-0x30(%ebp)
     b96:	8b 45 bc             	mov    -0x44(%ebp),%eax
     b99:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     b9c:	8b 45 c0             	mov    -0x40(%ebp),%eax
     b9f:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     ba2:	e9 76 01 00 00       	jmp    d1d <drawone+0x403>
case DownStair:
	//temp = downstair;
	temp = APLoadBitmap ("downstair.bmp");
     ba7:	8d 45 b8             	lea    -0x48(%ebp),%eax
     baa:	83 ec 08             	sub    $0x8,%esp
     bad:	68 b7 34 00 00       	push   $0x34b7
     bb2:	50                   	push   %eax
     bb3:	e8 39 0c 00 00       	call   17f1 <APLoadBitmap>
     bb8:	83 c4 0c             	add    $0xc,%esp
     bbb:	8b 45 b8             	mov    -0x48(%ebp),%eax
     bbe:	89 45 d0             	mov    %eax,-0x30(%ebp)
     bc1:	8b 45 bc             	mov    -0x44(%ebp),%eax
     bc4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     bc7:	8b 45 c0             	mov    -0x40(%ebp),%eax
     bca:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     bcd:	e9 4b 01 00 00       	jmp    d1d <drawone+0x403>
case YellowKey:
	//temp = yellowkey;
	temp = APLoadBitmap ("yellowkey.bmp");
     bd2:	8d 45 b8             	lea    -0x48(%ebp),%eax
     bd5:	83 ec 08             	sub    $0x8,%esp
     bd8:	68 c5 34 00 00       	push   $0x34c5
     bdd:	50                   	push   %eax
     bde:	e8 0e 0c 00 00       	call   17f1 <APLoadBitmap>
     be3:	83 c4 0c             	add    $0xc,%esp
     be6:	8b 45 b8             	mov    -0x48(%ebp),%eax
     be9:	89 45 d0             	mov    %eax,-0x30(%ebp)
     bec:	8b 45 bc             	mov    -0x44(%ebp),%eax
     bef:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     bf2:	8b 45 c0             	mov    -0x40(%ebp),%eax
     bf5:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     bf8:	e9 20 01 00 00       	jmp    d1d <drawone+0x403>
case BlueKey:
	//temp = bluekey;
	temp = APLoadBitmap ("bluekey.bmp");
     bfd:	8d 45 b8             	lea    -0x48(%ebp),%eax
     c00:	83 ec 08             	sub    $0x8,%esp
     c03:	68 d3 34 00 00       	push   $0x34d3
     c08:	50                   	push   %eax
     c09:	e8 e3 0b 00 00       	call   17f1 <APLoadBitmap>
     c0e:	83 c4 0c             	add    $0xc,%esp
     c11:	8b 45 b8             	mov    -0x48(%ebp),%eax
     c14:	89 45 d0             	mov    %eax,-0x30(%ebp)
     c17:	8b 45 bc             	mov    -0x44(%ebp),%eax
     c1a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     c1d:	8b 45 c0             	mov    -0x40(%ebp),%eax
     c20:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     c23:	e9 f5 00 00 00       	jmp    d1d <drawone+0x403>
case RedKey:
	//temp = redkey;
	temp = APLoadBitmap ("redkey.bmp");
     c28:	8d 45 b8             	lea    -0x48(%ebp),%eax
     c2b:	83 ec 08             	sub    $0x8,%esp
     c2e:	68 df 34 00 00       	push   $0x34df
     c33:	50                   	push   %eax
     c34:	e8 b8 0b 00 00       	call   17f1 <APLoadBitmap>
     c39:	83 c4 0c             	add    $0xc,%esp
     c3c:	8b 45 b8             	mov    -0x48(%ebp),%eax
     c3f:	89 45 d0             	mov    %eax,-0x30(%ebp)
     c42:	8b 45 bc             	mov    -0x44(%ebp),%eax
     c45:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     c48:	8b 45 c0             	mov    -0x40(%ebp),%eax
     c4b:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     c4e:	e9 ca 00 00 00       	jmp    d1d <drawone+0x403>
case SBlood:
	//temp = sblood;
	temp = APLoadBitmap ("sblood.bmp");
     c53:	8d 45 b8             	lea    -0x48(%ebp),%eax
     c56:	83 ec 08             	sub    $0x8,%esp
     c59:	68 ea 34 00 00       	push   $0x34ea
     c5e:	50                   	push   %eax
     c5f:	e8 8d 0b 00 00       	call   17f1 <APLoadBitmap>
     c64:	83 c4 0c             	add    $0xc,%esp
     c67:	8b 45 b8             	mov    -0x48(%ebp),%eax
     c6a:	89 45 d0             	mov    %eax,-0x30(%ebp)
     c6d:	8b 45 bc             	mov    -0x44(%ebp),%eax
     c70:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     c73:	8b 45 c0             	mov    -0x40(%ebp),%eax
     c76:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     c79:	e9 9f 00 00 00       	jmp    d1d <drawone+0x403>
case LBlood:
	//temp = lblood;
	temp = APLoadBitmap ("lblood.bmp");
     c7e:	8d 45 b8             	lea    -0x48(%ebp),%eax
     c81:	83 ec 08             	sub    $0x8,%esp
     c84:	68 f5 34 00 00       	push   $0x34f5
     c89:	50                   	push   %eax
     c8a:	e8 62 0b 00 00       	call   17f1 <APLoadBitmap>
     c8f:	83 c4 0c             	add    $0xc,%esp
     c92:	8b 45 b8             	mov    -0x48(%ebp),%eax
     c95:	89 45 d0             	mov    %eax,-0x30(%ebp)
     c98:	8b 45 bc             	mov    -0x44(%ebp),%eax
     c9b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     c9e:	8b 45 c0             	mov    -0x40(%ebp),%eax
     ca1:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     ca4:	eb 77                	jmp    d1d <drawone+0x403>
case Attack:
	//temp = attack;
	temp = APLoadBitmap ("attack1.bmp");
     ca6:	8d 45 b8             	lea    -0x48(%ebp),%eax
     ca9:	83 ec 08             	sub    $0x8,%esp
     cac:	68 00 35 00 00       	push   $0x3500
     cb1:	50                   	push   %eax
     cb2:	e8 3a 0b 00 00       	call   17f1 <APLoadBitmap>
     cb7:	83 c4 0c             	add    $0xc,%esp
     cba:	8b 45 b8             	mov    -0x48(%ebp),%eax
     cbd:	89 45 d0             	mov    %eax,-0x30(%ebp)
     cc0:	8b 45 bc             	mov    -0x44(%ebp),%eax
     cc3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     cc6:	8b 45 c0             	mov    -0x40(%ebp),%eax
     cc9:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     ccc:	eb 4f                	jmp    d1d <drawone+0x403>
case Defend:
	//temp = defend;
	temp = APLoadBitmap ("defend.bmp");
     cce:	8d 45 b8             	lea    -0x48(%ebp),%eax
     cd1:	83 ec 08             	sub    $0x8,%esp
     cd4:	68 0c 35 00 00       	push   $0x350c
     cd9:	50                   	push   %eax
     cda:	e8 12 0b 00 00       	call   17f1 <APLoadBitmap>
     cdf:	83 c4 0c             	add    $0xc,%esp
     ce2:	8b 45 b8             	mov    -0x48(%ebp),%eax
     ce5:	89 45 d0             	mov    %eax,-0x30(%ebp)
     ce8:	8b 45 bc             	mov    -0x44(%ebp),%eax
     ceb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     cee:	8b 45 c0             	mov    -0x40(%ebp),%eax
     cf1:	89 45 d8             	mov    %eax,-0x28(%ebp)
	break;
     cf4:	eb 27                	jmp    d1d <drawone+0x403>
default:
	//temp = background;
	temp = APLoadBitmap ("background.bmp");
     cf6:	8d 45 b8             	lea    -0x48(%ebp),%eax
     cf9:	83 ec 08             	sub    $0x8,%esp
     cfc:	68 38 34 00 00       	push   $0x3438
     d01:	50                   	push   %eax
     d02:	e8 ea 0a 00 00       	call   17f1 <APLoadBitmap>
     d07:	83 c4 0c             	add    $0xc,%esp
     d0a:	8b 45 b8             	mov    -0x48(%ebp),%eax
     d0d:	89 45 d0             	mov    %eax,-0x30(%ebp)
     d10:	8b 45 bc             	mov    -0x44(%ebp),%eax
     d13:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     d16:	8b 45 c0             	mov    -0x40(%ebp),%eax
     d19:	89 45 d8             	mov    %eax,-0x28(%ebp)
break;
     d1c:	90                   	nop
}
		if(my_tower[floor][i][j] == Valiant)
     d1d:	8b 0d 8c 7a 00 00    	mov    0x7a8c,%ecx
     d23:	8b 55 0c             	mov    0xc(%ebp),%edx
     d26:	89 d0                	mov    %edx,%eax
     d28:	c1 e0 02             	shl    $0x2,%eax
     d2b:	01 d0                	add    %edx,%eax
     d2d:	01 c0                	add    %eax,%eax
     d2f:	6b d1 64             	imul   $0x64,%ecx,%edx
     d32:	01 c2                	add    %eax,%edx
     d34:	8b 45 10             	mov    0x10(%ebp),%eax
     d37:	01 d0                	add    %edx,%eax
     d39:	8b 04 85 20 7b 00 00 	mov    0x7b20(,%eax,4),%eax
     d40:	83 f8 05             	cmp    $0x5,%eax
     d43:	75 6a                	jne    daf <drawone+0x495>
		{
			APDcCopy(&hwnd->Dc,i * BLOCK_WIDTH ,j * BLOCK_WIDTH,APCreateCompatibleDCFromBitmap(temp),0,0,BLOCK_WIDTH,BLOCK_WIDTH,RGB(0,0,0));
     d45:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     d48:	6a 00                	push   $0x0
     d4a:	6a 00                	push   $0x0
     d4c:	6a 00                	push   $0x0
     d4e:	50                   	push   %eax
     d4f:	e8 ac f2 ff ff       	call   0 <RGB>
     d54:	83 c4 0c             	add    $0xc,%esp
     d57:	83 ec 04             	sub    $0x4,%esp
     d5a:	ff 75 d8             	pushl  -0x28(%ebp)
     d5d:	ff 75 d4             	pushl  -0x2c(%ebp)
     d60:	ff 75 d0             	pushl  -0x30(%ebp)
     d63:	e8 c3 0c 00 00       	call   1a2b <APCreateCompatibleDCFromBitmap>
     d68:	83 c4 10             	add    $0x10,%esp
     d6b:	89 c7                	mov    %eax,%edi
     d6d:	8b 45 10             	mov    0x10(%ebp),%eax
     d70:	c1 e0 05             	shl    $0x5,%eax
     d73:	89 c6                	mov    %eax,%esi
     d75:	8b 45 0c             	mov    0xc(%ebp),%eax
     d78:	c1 e0 05             	shl    $0x5,%eax
     d7b:	89 c3                	mov    %eax,%ebx
     d7d:	8b 45 08             	mov    0x8(%ebp),%eax
     d80:	8d 48 3c             	lea    0x3c(%eax),%ecx
     d83:	83 ec 0c             	sub    $0xc,%esp
     d86:	83 ec 04             	sub    $0x4,%esp
     d89:	89 e0                	mov    %esp,%eax
     d8b:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
     d8f:	66 89 10             	mov    %dx,(%eax)
     d92:	0f b6 55 e4          	movzbl -0x1c(%ebp),%edx
     d96:	88 50 02             	mov    %dl,0x2(%eax)
     d99:	6a 20                	push   $0x20
     d9b:	6a 20                	push   $0x20
     d9d:	6a 00                	push   $0x0
     d9f:	6a 00                	push   $0x0
     da1:	57                   	push   %edi
     da2:	56                   	push   %esi
     da3:	53                   	push   %ebx
     da4:	51                   	push   %ecx
     da5:	e8 85 14 00 00       	call   222f <APDcCopy>
     daa:	83 c4 30             	add    $0x30,%esp
			APDcCopy(&hwnd->Dc,i * BLOCK_WIDTH ,j * BLOCK_WIDTH,APCreateCompatibleDCFromBitmap(temp),0,0,BLOCK_WIDTH,BLOCK_WIDTH,COLOR_NULL);
	
}//主体

//info
}
     dad:	eb 68                	jmp    e17 <drawone+0x4fd>
			APDcCopy(&hwnd->Dc,i * BLOCK_WIDTH ,j * BLOCK_WIDTH,APCreateCompatibleDCFromBitmap(temp),0,0,BLOCK_WIDTH,BLOCK_WIDTH,RGB(0,0,0));

		}
		else
		{
			APDcCopy(&hwnd->Dc,i * BLOCK_WIDTH ,j * BLOCK_WIDTH,APCreateCompatibleDCFromBitmap(temp),0,0,BLOCK_WIDTH,BLOCK_WIDTH,COLOR_NULL);
     daf:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     db2:	6a 0c                	push   $0xc
     db4:	6a 0c                	push   $0xc
     db6:	6a 0c                	push   $0xc
     db8:	50                   	push   %eax
     db9:	e8 42 f2 ff ff       	call   0 <RGB>
     dbe:	83 c4 0c             	add    $0xc,%esp
     dc1:	83 ec 04             	sub    $0x4,%esp
     dc4:	ff 75 d8             	pushl  -0x28(%ebp)
     dc7:	ff 75 d4             	pushl  -0x2c(%ebp)
     dca:	ff 75 d0             	pushl  -0x30(%ebp)
     dcd:	e8 59 0c 00 00       	call   1a2b <APCreateCompatibleDCFromBitmap>
     dd2:	83 c4 10             	add    $0x10,%esp
     dd5:	89 c7                	mov    %eax,%edi
     dd7:	8b 45 10             	mov    0x10(%ebp),%eax
     dda:	c1 e0 05             	shl    $0x5,%eax
     ddd:	89 c6                	mov    %eax,%esi
     ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
     de2:	c1 e0 05             	shl    $0x5,%eax
     de5:	89 c3                	mov    %eax,%ebx
     de7:	8b 45 08             	mov    0x8(%ebp),%eax
     dea:	8d 48 3c             	lea    0x3c(%eax),%ecx
     ded:	83 ec 0c             	sub    $0xc,%esp
     df0:	83 ec 04             	sub    $0x4,%esp
     df3:	89 e0                	mov    %esp,%eax
     df5:	0f b7 55 e5          	movzwl -0x1b(%ebp),%edx
     df9:	66 89 10             	mov    %dx,(%eax)
     dfc:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
     e00:	88 50 02             	mov    %dl,0x2(%eax)
     e03:	6a 20                	push   $0x20
     e05:	6a 20                	push   $0x20
     e07:	6a 00                	push   $0x0
     e09:	6a 00                	push   $0x0
     e0b:	57                   	push   %edi
     e0c:	56                   	push   %esi
     e0d:	53                   	push   %ebx
     e0e:	51                   	push   %ecx
     e0f:	e8 1b 14 00 00       	call   222f <APDcCopy>
     e14:	83 c4 30             	add    $0x30,%esp
	
}//主体

//info
}
     e17:	90                   	nop
     e18:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e1b:	5b                   	pop    %ebx
     e1c:	5e                   	pop    %esi
     e1d:	5f                   	pop    %edi
     e1e:	5d                   	pop    %ebp
     e1f:	c3                   	ret    

00000e20 <wndProc>:

bool wndProc(AHwnd hwnd,AMessage msg)
{
     e20:	55                   	push   %ebp
     e21:	89 e5                	mov    %esp,%ebp
     e23:	83 ec 18             	sub    $0x18,%esp
	switch(msg.type)
     e26:	8b 45 0c             	mov    0xc(%ebp),%eax
     e29:	83 f8 03             	cmp    $0x3,%eax
     e2c:	74 71                	je     e9f <wndProc+0x7f>
     e2e:	83 f8 06             	cmp    $0x6,%eax
     e31:	74 34                	je     e67 <wndProc+0x47>
     e33:	83 f8 02             	cmp    $0x2,%eax
     e36:	74 05                	je     e3d <wndProc+0x1d>
drawone(hwnd,position_old.x,position_old.y);
drawone(hwnd,position.x,position.y);
}
		break;
		default:
		break;
     e38:	e9 b0 00 00 00       	jmp    eed <wndProc+0xcd>
{
	switch(msg.type)
	{
		    case MSG_INIT:
			
		    init(hwnd);
     e3d:	83 ec 0c             	sub    $0xc,%esp
     e40:	ff 75 08             	pushl  0x8(%ebp)
     e43:	e8 9c f8 ff ff       	call   6e4 <init>
     e48:	83 c4 10             	add    $0x10,%esp
			printf(1,"init finished");
     e4b:	83 ec 08             	sub    $0x8,%esp
     e4e:	68 60 35 00 00       	push   $0x3560
     e53:	6a 01                	push   $0x1
     e55:	e8 11 05 00 00       	call   136b <printf>
     e5a:	83 c4 10             	add    $0x10,%esp
		
		    return False;
     e5d:	b8 00 00 00 00       	mov    $0x0,%eax
     e62:	e9 9a 00 00 00       	jmp    f01 <wndProc+0xe1>
		case MSG_KEY_DOWN:
		keyDown(hwnd,msg);
     e67:	ff 75 14             	pushl  0x14(%ebp)
     e6a:	ff 75 10             	pushl  0x10(%ebp)
     e6d:	ff 75 0c             	pushl  0xc(%ebp)
     e70:	ff 75 08             	pushl  0x8(%ebp)
     e73:	e8 58 f2 ff ff       	call   d0 <keyDown>
     e78:	83 c4 10             	add    $0x10,%esp
		AMessage msg1;
		   msg1.type = MSG_PAINT;
     e7b:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
			msg1.param = 1;
     e82:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
		    APSendMessage(hwnd,msg1);  
     e89:	ff 75 f4             	pushl  -0xc(%ebp)
     e8c:	ff 75 f0             	pushl  -0x10(%ebp)
     e8f:	ff 75 ec             	pushl  -0x14(%ebp)
     e92:	ff 75 08             	pushl  0x8(%ebp)
     e95:	e8 7e 15 00 00       	call   2418 <APSendMessage>
     e9a:	83 c4 10             	add    $0x10,%esp
		break;
     e9d:	eb 4e                	jmp    eed <wndProc+0xcd>
		case MSG_PAINT:
if (msg.param == 0)
     e9f:	8b 45 10             	mov    0x10(%ebp),%eax
     ea2:	85 c0                	test   %eax,%eax
     ea4:	75 10                	jne    eb6 <wndProc+0x96>
		draw(hwnd);
     ea6:	83 ec 0c             	sub    $0xc,%esp
     ea9:	ff 75 08             	pushl  0x8(%ebp)
     eac:	e8 26 fa ff ff       	call   8d7 <draw>
     eb1:	83 c4 10             	add    $0x10,%esp
else
{
drawone(hwnd,position_old.x,position_old.y);
drawone(hwnd,position.x,position.y);
}
		break;
     eb4:	eb 36                	jmp    eec <wndProc+0xcc>
		case MSG_PAINT:
if (msg.param == 0)
		draw(hwnd);
else
{
drawone(hwnd,position_old.x,position_old.y);
     eb6:	8b 15 a0 7a 00 00    	mov    0x7aa0,%edx
     ebc:	a1 9c 7a 00 00       	mov    0x7a9c,%eax
     ec1:	83 ec 04             	sub    $0x4,%esp
     ec4:	52                   	push   %edx
     ec5:	50                   	push   %eax
     ec6:	ff 75 08             	pushl  0x8(%ebp)
     ec9:	e8 4c fa ff ff       	call   91a <drawone>
     ece:	83 c4 10             	add    $0x10,%esp
drawone(hwnd,position.x,position.y);
     ed1:	8b 15 a8 7a 00 00    	mov    0x7aa8,%edx
     ed7:	a1 a4 7a 00 00       	mov    0x7aa4,%eax
     edc:	83 ec 04             	sub    $0x4,%esp
     edf:	52                   	push   %edx
     ee0:	50                   	push   %eax
     ee1:	ff 75 08             	pushl  0x8(%ebp)
     ee4:	e8 31 fa ff ff       	call   91a <drawone>
     ee9:	83 c4 10             	add    $0x10,%esp
}
		break;
     eec:	90                   	nop
		default:
		break;
	}
	return APWndProc(hwnd,msg);
     eed:	ff 75 14             	pushl  0x14(%ebp)
     ef0:	ff 75 10             	pushl  0x10(%ebp)
     ef3:	ff 75 0c             	pushl  0xc(%ebp)
     ef6:	ff 75 08             	pushl  0x8(%ebp)
     ef9:	e8 9e 17 00 00       	call   269c <APWndProc>
     efe:	83 c4 10             	add    $0x10,%esp

}
     f01:	c9                   	leave  
     f02:	c3                   	ret    

00000f03 <main>:


int main(void)
{
     f03:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     f07:	83 e4 f0             	and    $0xfffffff0,%esp
     f0a:	ff 71 fc             	pushl  -0x4(%ecx)
     f0d:	55                   	push   %ebp
     f0e:	89 e5                	mov    %esp,%ebp
     f10:	51                   	push   %ecx
     f11:	83 ec 14             	sub    $0x14,%esp
	
	AHwnd hwnd = APCreateWindow("magictower",False,0);
     f14:	83 ec 04             	sub    $0x4,%esp
     f17:	6a 00                	push   $0x0
     f19:	6a 00                	push   $0x0
     f1b:	68 6e 35 00 00       	push   $0x356e
     f20:	e8 11 15 00 00       	call   2436 <APCreateWindow>
     f25:	83 c4 10             	add    $0x10,%esp
     f28:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf(1,"magic tower created.\n");
     f2b:	83 ec 08             	sub    $0x8,%esp
     f2e:	68 79 35 00 00       	push   $0x3579
     f33:	6a 01                	push   $0x1
     f35:	e8 31 04 00 00       	call   136b <printf>
     f3a:	83 c4 10             	add    $0x10,%esp
	APWndExec(hwnd,wndProc);
     f3d:	83 ec 08             	sub    $0x8,%esp
     f40:	68 20 0e 00 00       	push   $0xe20
     f45:	ff 75 f4             	pushl  -0xc(%ebp)
     f48:	e8 0b 18 00 00       	call   2758 <APWndExec>
     f4d:	83 c4 10             	add    $0x10,%esp
	exit();
     f50:	e8 57 02 00 00       	call   11ac <exit>

00000f55 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     f55:	55                   	push   %ebp
     f56:	89 e5                	mov    %esp,%ebp
     f58:	57                   	push   %edi
     f59:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     f5a:	8b 4d 08             	mov    0x8(%ebp),%ecx
     f5d:	8b 55 10             	mov    0x10(%ebp),%edx
     f60:	8b 45 0c             	mov    0xc(%ebp),%eax
     f63:	89 cb                	mov    %ecx,%ebx
     f65:	89 df                	mov    %ebx,%edi
     f67:	89 d1                	mov    %edx,%ecx
     f69:	fc                   	cld    
     f6a:	f3 aa                	rep stos %al,%es:(%edi)
     f6c:	89 ca                	mov    %ecx,%edx
     f6e:	89 fb                	mov    %edi,%ebx
     f70:	89 5d 08             	mov    %ebx,0x8(%ebp)
     f73:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     f76:	90                   	nop
     f77:	5b                   	pop    %ebx
     f78:	5f                   	pop    %edi
     f79:	5d                   	pop    %ebp
     f7a:	c3                   	ret    

00000f7b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     f7b:	55                   	push   %ebp
     f7c:	89 e5                	mov    %esp,%ebp
     f7e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     f81:	8b 45 08             	mov    0x8(%ebp),%eax
     f84:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     f87:	90                   	nop
     f88:	8b 45 08             	mov    0x8(%ebp),%eax
     f8b:	8d 50 01             	lea    0x1(%eax),%edx
     f8e:	89 55 08             	mov    %edx,0x8(%ebp)
     f91:	8b 55 0c             	mov    0xc(%ebp),%edx
     f94:	8d 4a 01             	lea    0x1(%edx),%ecx
     f97:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     f9a:	0f b6 12             	movzbl (%edx),%edx
     f9d:	88 10                	mov    %dl,(%eax)
     f9f:	0f b6 00             	movzbl (%eax),%eax
     fa2:	84 c0                	test   %al,%al
     fa4:	75 e2                	jne    f88 <strcpy+0xd>
    ;
  return os;
     fa6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     fa9:	c9                   	leave  
     faa:	c3                   	ret    

00000fab <strcmp>:

int
strcmp(const char *p, const char *q)
{
     fab:	55                   	push   %ebp
     fac:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     fae:	eb 08                	jmp    fb8 <strcmp+0xd>
    p++, q++;
     fb0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     fb4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     fb8:	8b 45 08             	mov    0x8(%ebp),%eax
     fbb:	0f b6 00             	movzbl (%eax),%eax
     fbe:	84 c0                	test   %al,%al
     fc0:	74 10                	je     fd2 <strcmp+0x27>
     fc2:	8b 45 08             	mov    0x8(%ebp),%eax
     fc5:	0f b6 10             	movzbl (%eax),%edx
     fc8:	8b 45 0c             	mov    0xc(%ebp),%eax
     fcb:	0f b6 00             	movzbl (%eax),%eax
     fce:	38 c2                	cmp    %al,%dl
     fd0:	74 de                	je     fb0 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     fd2:	8b 45 08             	mov    0x8(%ebp),%eax
     fd5:	0f b6 00             	movzbl (%eax),%eax
     fd8:	0f b6 d0             	movzbl %al,%edx
     fdb:	8b 45 0c             	mov    0xc(%ebp),%eax
     fde:	0f b6 00             	movzbl (%eax),%eax
     fe1:	0f b6 c0             	movzbl %al,%eax
     fe4:	29 c2                	sub    %eax,%edx
     fe6:	89 d0                	mov    %edx,%eax
}
     fe8:	5d                   	pop    %ebp
     fe9:	c3                   	ret    

00000fea <strlen>:

uint
strlen(char *s)
{
     fea:	55                   	push   %ebp
     feb:	89 e5                	mov    %esp,%ebp
     fed:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     ff0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     ff7:	eb 04                	jmp    ffd <strlen+0x13>
     ff9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     ffd:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1000:	8b 45 08             	mov    0x8(%ebp),%eax
    1003:	01 d0                	add    %edx,%eax
    1005:	0f b6 00             	movzbl (%eax),%eax
    1008:	84 c0                	test   %al,%al
    100a:	75 ed                	jne    ff9 <strlen+0xf>
    ;
  return n;
    100c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    100f:	c9                   	leave  
    1010:	c3                   	ret    

00001011 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1011:	55                   	push   %ebp
    1012:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1014:	8b 45 10             	mov    0x10(%ebp),%eax
    1017:	50                   	push   %eax
    1018:	ff 75 0c             	pushl  0xc(%ebp)
    101b:	ff 75 08             	pushl  0x8(%ebp)
    101e:	e8 32 ff ff ff       	call   f55 <stosb>
    1023:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1026:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1029:	c9                   	leave  
    102a:	c3                   	ret    

0000102b <strchr>:

char*
strchr(const char *s, char c)
{
    102b:	55                   	push   %ebp
    102c:	89 e5                	mov    %esp,%ebp
    102e:	83 ec 04             	sub    $0x4,%esp
    1031:	8b 45 0c             	mov    0xc(%ebp),%eax
    1034:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1037:	eb 14                	jmp    104d <strchr+0x22>
    if(*s == c)
    1039:	8b 45 08             	mov    0x8(%ebp),%eax
    103c:	0f b6 00             	movzbl (%eax),%eax
    103f:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1042:	75 05                	jne    1049 <strchr+0x1e>
      return (char*)s;
    1044:	8b 45 08             	mov    0x8(%ebp),%eax
    1047:	eb 13                	jmp    105c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1049:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    104d:	8b 45 08             	mov    0x8(%ebp),%eax
    1050:	0f b6 00             	movzbl (%eax),%eax
    1053:	84 c0                	test   %al,%al
    1055:	75 e2                	jne    1039 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1057:	b8 00 00 00 00       	mov    $0x0,%eax
}
    105c:	c9                   	leave  
    105d:	c3                   	ret    

0000105e <gets>:

char*
gets(char *buf, int max)
{
    105e:	55                   	push   %ebp
    105f:	89 e5                	mov    %esp,%ebp
    1061:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1064:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    106b:	eb 42                	jmp    10af <gets+0x51>
    cc = read(0, &c, 1);
    106d:	83 ec 04             	sub    $0x4,%esp
    1070:	6a 01                	push   $0x1
    1072:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1075:	50                   	push   %eax
    1076:	6a 00                	push   $0x0
    1078:	e8 47 01 00 00       	call   11c4 <read>
    107d:	83 c4 10             	add    $0x10,%esp
    1080:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1083:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1087:	7e 33                	jle    10bc <gets+0x5e>
      break;
    buf[i++] = c;
    1089:	8b 45 f4             	mov    -0xc(%ebp),%eax
    108c:	8d 50 01             	lea    0x1(%eax),%edx
    108f:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1092:	89 c2                	mov    %eax,%edx
    1094:	8b 45 08             	mov    0x8(%ebp),%eax
    1097:	01 c2                	add    %eax,%edx
    1099:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    109d:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    109f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    10a3:	3c 0a                	cmp    $0xa,%al
    10a5:	74 16                	je     10bd <gets+0x5f>
    10a7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    10ab:	3c 0d                	cmp    $0xd,%al
    10ad:	74 0e                	je     10bd <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    10af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10b2:	83 c0 01             	add    $0x1,%eax
    10b5:	3b 45 0c             	cmp    0xc(%ebp),%eax
    10b8:	7c b3                	jl     106d <gets+0xf>
    10ba:	eb 01                	jmp    10bd <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    10bc:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    10bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
    10c0:	8b 45 08             	mov    0x8(%ebp),%eax
    10c3:	01 d0                	add    %edx,%eax
    10c5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    10c8:	8b 45 08             	mov    0x8(%ebp),%eax
}
    10cb:	c9                   	leave  
    10cc:	c3                   	ret    

000010cd <stat>:

int
stat(char *n, struct stat *st)
{
    10cd:	55                   	push   %ebp
    10ce:	89 e5                	mov    %esp,%ebp
    10d0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    10d3:	83 ec 08             	sub    $0x8,%esp
    10d6:	6a 00                	push   $0x0
    10d8:	ff 75 08             	pushl  0x8(%ebp)
    10db:	e8 0c 01 00 00       	call   11ec <open>
    10e0:	83 c4 10             	add    $0x10,%esp
    10e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    10e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10ea:	79 07                	jns    10f3 <stat+0x26>
    return -1;
    10ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    10f1:	eb 25                	jmp    1118 <stat+0x4b>
  r = fstat(fd, st);
    10f3:	83 ec 08             	sub    $0x8,%esp
    10f6:	ff 75 0c             	pushl  0xc(%ebp)
    10f9:	ff 75 f4             	pushl  -0xc(%ebp)
    10fc:	e8 03 01 00 00       	call   1204 <fstat>
    1101:	83 c4 10             	add    $0x10,%esp
    1104:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1107:	83 ec 0c             	sub    $0xc,%esp
    110a:	ff 75 f4             	pushl  -0xc(%ebp)
    110d:	e8 c2 00 00 00       	call   11d4 <close>
    1112:	83 c4 10             	add    $0x10,%esp
  return r;
    1115:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1118:	c9                   	leave  
    1119:	c3                   	ret    

0000111a <atoi>:

int
atoi(const char *s)
{
    111a:	55                   	push   %ebp
    111b:	89 e5                	mov    %esp,%ebp
    111d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1120:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1127:	eb 25                	jmp    114e <atoi+0x34>
    n = n*10 + *s++ - '0';
    1129:	8b 55 fc             	mov    -0x4(%ebp),%edx
    112c:	89 d0                	mov    %edx,%eax
    112e:	c1 e0 02             	shl    $0x2,%eax
    1131:	01 d0                	add    %edx,%eax
    1133:	01 c0                	add    %eax,%eax
    1135:	89 c1                	mov    %eax,%ecx
    1137:	8b 45 08             	mov    0x8(%ebp),%eax
    113a:	8d 50 01             	lea    0x1(%eax),%edx
    113d:	89 55 08             	mov    %edx,0x8(%ebp)
    1140:	0f b6 00             	movzbl (%eax),%eax
    1143:	0f be c0             	movsbl %al,%eax
    1146:	01 c8                	add    %ecx,%eax
    1148:	83 e8 30             	sub    $0x30,%eax
    114b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    114e:	8b 45 08             	mov    0x8(%ebp),%eax
    1151:	0f b6 00             	movzbl (%eax),%eax
    1154:	3c 2f                	cmp    $0x2f,%al
    1156:	7e 0a                	jle    1162 <atoi+0x48>
    1158:	8b 45 08             	mov    0x8(%ebp),%eax
    115b:	0f b6 00             	movzbl (%eax),%eax
    115e:	3c 39                	cmp    $0x39,%al
    1160:	7e c7                	jle    1129 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1162:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1165:	c9                   	leave  
    1166:	c3                   	ret    

00001167 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1167:	55                   	push   %ebp
    1168:	89 e5                	mov    %esp,%ebp
    116a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    116d:	8b 45 08             	mov    0x8(%ebp),%eax
    1170:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1173:	8b 45 0c             	mov    0xc(%ebp),%eax
    1176:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1179:	eb 17                	jmp    1192 <memmove+0x2b>
    *dst++ = *src++;
    117b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    117e:	8d 50 01             	lea    0x1(%eax),%edx
    1181:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1184:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1187:	8d 4a 01             	lea    0x1(%edx),%ecx
    118a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    118d:	0f b6 12             	movzbl (%edx),%edx
    1190:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1192:	8b 45 10             	mov    0x10(%ebp),%eax
    1195:	8d 50 ff             	lea    -0x1(%eax),%edx
    1198:	89 55 10             	mov    %edx,0x10(%ebp)
    119b:	85 c0                	test   %eax,%eax
    119d:	7f dc                	jg     117b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    119f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11a2:	c9                   	leave  
    11a3:	c3                   	ret    

000011a4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11a4:	b8 01 00 00 00       	mov    $0x1,%eax
    11a9:	cd 40                	int    $0x40
    11ab:	c3                   	ret    

000011ac <exit>:
SYSCALL(exit)
    11ac:	b8 02 00 00 00       	mov    $0x2,%eax
    11b1:	cd 40                	int    $0x40
    11b3:	c3                   	ret    

000011b4 <wait>:
SYSCALL(wait)
    11b4:	b8 03 00 00 00       	mov    $0x3,%eax
    11b9:	cd 40                	int    $0x40
    11bb:	c3                   	ret    

000011bc <pipe>:
SYSCALL(pipe)
    11bc:	b8 04 00 00 00       	mov    $0x4,%eax
    11c1:	cd 40                	int    $0x40
    11c3:	c3                   	ret    

000011c4 <read>:
SYSCALL(read)
    11c4:	b8 05 00 00 00       	mov    $0x5,%eax
    11c9:	cd 40                	int    $0x40
    11cb:	c3                   	ret    

000011cc <write>:
SYSCALL(write)
    11cc:	b8 10 00 00 00       	mov    $0x10,%eax
    11d1:	cd 40                	int    $0x40
    11d3:	c3                   	ret    

000011d4 <close>:
SYSCALL(close)
    11d4:	b8 15 00 00 00       	mov    $0x15,%eax
    11d9:	cd 40                	int    $0x40
    11db:	c3                   	ret    

000011dc <kill>:
SYSCALL(kill)
    11dc:	b8 06 00 00 00       	mov    $0x6,%eax
    11e1:	cd 40                	int    $0x40
    11e3:	c3                   	ret    

000011e4 <exec>:
SYSCALL(exec)
    11e4:	b8 07 00 00 00       	mov    $0x7,%eax
    11e9:	cd 40                	int    $0x40
    11eb:	c3                   	ret    

000011ec <open>:
SYSCALL(open)
    11ec:	b8 0f 00 00 00       	mov    $0xf,%eax
    11f1:	cd 40                	int    $0x40
    11f3:	c3                   	ret    

000011f4 <mknod>:
SYSCALL(mknod)
    11f4:	b8 11 00 00 00       	mov    $0x11,%eax
    11f9:	cd 40                	int    $0x40
    11fb:	c3                   	ret    

000011fc <unlink>:
SYSCALL(unlink)
    11fc:	b8 12 00 00 00       	mov    $0x12,%eax
    1201:	cd 40                	int    $0x40
    1203:	c3                   	ret    

00001204 <fstat>:
SYSCALL(fstat)
    1204:	b8 08 00 00 00       	mov    $0x8,%eax
    1209:	cd 40                	int    $0x40
    120b:	c3                   	ret    

0000120c <link>:
SYSCALL(link)
    120c:	b8 13 00 00 00       	mov    $0x13,%eax
    1211:	cd 40                	int    $0x40
    1213:	c3                   	ret    

00001214 <mkdir>:
SYSCALL(mkdir)
    1214:	b8 14 00 00 00       	mov    $0x14,%eax
    1219:	cd 40                	int    $0x40
    121b:	c3                   	ret    

0000121c <chdir>:
SYSCALL(chdir)
    121c:	b8 09 00 00 00       	mov    $0x9,%eax
    1221:	cd 40                	int    $0x40
    1223:	c3                   	ret    

00001224 <dup>:
SYSCALL(dup)
    1224:	b8 0a 00 00 00       	mov    $0xa,%eax
    1229:	cd 40                	int    $0x40
    122b:	c3                   	ret    

0000122c <getpid>:
SYSCALL(getpid)
    122c:	b8 0b 00 00 00       	mov    $0xb,%eax
    1231:	cd 40                	int    $0x40
    1233:	c3                   	ret    

00001234 <sbrk>:
SYSCALL(sbrk)
    1234:	b8 0c 00 00 00       	mov    $0xc,%eax
    1239:	cd 40                	int    $0x40
    123b:	c3                   	ret    

0000123c <sleep>:
SYSCALL(sleep)
    123c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1241:	cd 40                	int    $0x40
    1243:	c3                   	ret    

00001244 <uptime>:
SYSCALL(uptime)
    1244:	b8 0e 00 00 00       	mov    $0xe,%eax
    1249:	cd 40                	int    $0x40
    124b:	c3                   	ret    

0000124c <paintWindow>:

SYSCALL(paintWindow)
    124c:	b8 16 00 00 00       	mov    $0x16,%eax
    1251:	cd 40                	int    $0x40
    1253:	c3                   	ret    

00001254 <sendMessage>:
SYSCALL(sendMessage)
    1254:	b8 17 00 00 00       	mov    $0x17,%eax
    1259:	cd 40                	int    $0x40
    125b:	c3                   	ret    

0000125c <getMessage>:
SYSCALL(getMessage)
    125c:	b8 19 00 00 00       	mov    $0x19,%eax
    1261:	cd 40                	int    $0x40
    1263:	c3                   	ret    

00001264 <registWindow>:
SYSCALL(registWindow)
    1264:	b8 18 00 00 00       	mov    $0x18,%eax
    1269:	cd 40                	int    $0x40
    126b:	c3                   	ret    

0000126c <changePosition>:
SYSCALL(changePosition)
    126c:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1271:	cd 40                	int    $0x40
    1273:	c3                   	ret    

00001274 <setupTimer>:
SYSCALL(setupTimer)
    1274:	b8 1b 00 00 00       	mov    $0x1b,%eax
    1279:	cd 40                	int    $0x40
    127b:	c3                   	ret    

0000127c <deleteTimer>:
SYSCALL(deleteTimer)
    127c:	b8 1c 00 00 00       	mov    $0x1c,%eax
    1281:	cd 40                	int    $0x40
    1283:	c3                   	ret    

00001284 <getCurrentTime>:
SYSCALL(getCurrentTime)
    1284:	b8 1d 00 00 00       	mov    $0x1d,%eax
    1289:	cd 40                	int    $0x40
    128b:	c3                   	ret    

0000128c <removeWindow>:
SYSCALL(removeWindow)
    128c:	b8 1e 00 00 00       	mov    $0x1e,%eax
    1291:	cd 40                	int    $0x40
    1293:	c3                   	ret    

00001294 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1294:	55                   	push   %ebp
    1295:	89 e5                	mov    %esp,%ebp
    1297:	83 ec 18             	sub    $0x18,%esp
    129a:	8b 45 0c             	mov    0xc(%ebp),%eax
    129d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    12a0:	83 ec 04             	sub    $0x4,%esp
    12a3:	6a 01                	push   $0x1
    12a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
    12a8:	50                   	push   %eax
    12a9:	ff 75 08             	pushl  0x8(%ebp)
    12ac:	e8 1b ff ff ff       	call   11cc <write>
    12b1:	83 c4 10             	add    $0x10,%esp
}
    12b4:	90                   	nop
    12b5:	c9                   	leave  
    12b6:	c3                   	ret    

000012b7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    12b7:	55                   	push   %ebp
    12b8:	89 e5                	mov    %esp,%ebp
    12ba:	53                   	push   %ebx
    12bb:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    12be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    12c5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    12c9:	74 17                	je     12e2 <printint+0x2b>
    12cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12cf:	79 11                	jns    12e2 <printint+0x2b>
    neg = 1;
    12d1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    12d8:	8b 45 0c             	mov    0xc(%ebp),%eax
    12db:	f7 d8                	neg    %eax
    12dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12e0:	eb 06                	jmp    12e8 <printint+0x31>
  } else {
    x = xx;
    12e2:	8b 45 0c             	mov    0xc(%ebp),%eax
    12e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    12e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    12ef:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12f2:	8d 41 01             	lea    0x1(%ecx),%eax
    12f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    12f8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    12fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12fe:	ba 00 00 00 00       	mov    $0x0,%edx
    1303:	f7 f3                	div    %ebx
    1305:	89 d0                	mov    %edx,%eax
    1307:	0f b6 80 04 3e 00 00 	movzbl 0x3e04(%eax),%eax
    130e:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1312:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1315:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1318:	ba 00 00 00 00       	mov    $0x0,%edx
    131d:	f7 f3                	div    %ebx
    131f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1322:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1326:	75 c7                	jne    12ef <printint+0x38>
  if(neg)
    1328:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    132c:	74 2d                	je     135b <printint+0xa4>
    buf[i++] = '-';
    132e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1331:	8d 50 01             	lea    0x1(%eax),%edx
    1334:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1337:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    133c:	eb 1d                	jmp    135b <printint+0xa4>
    putc(fd, buf[i]);
    133e:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1341:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1344:	01 d0                	add    %edx,%eax
    1346:	0f b6 00             	movzbl (%eax),%eax
    1349:	0f be c0             	movsbl %al,%eax
    134c:	83 ec 08             	sub    $0x8,%esp
    134f:	50                   	push   %eax
    1350:	ff 75 08             	pushl  0x8(%ebp)
    1353:	e8 3c ff ff ff       	call   1294 <putc>
    1358:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    135b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    135f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1363:	79 d9                	jns    133e <printint+0x87>
    putc(fd, buf[i]);
}
    1365:	90                   	nop
    1366:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1369:	c9                   	leave  
    136a:	c3                   	ret    

0000136b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    136b:	55                   	push   %ebp
    136c:	89 e5                	mov    %esp,%ebp
    136e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1371:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1378:	8d 45 0c             	lea    0xc(%ebp),%eax
    137b:	83 c0 04             	add    $0x4,%eax
    137e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1381:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1388:	e9 59 01 00 00       	jmp    14e6 <printf+0x17b>
    c = fmt[i] & 0xff;
    138d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1390:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1393:	01 d0                	add    %edx,%eax
    1395:	0f b6 00             	movzbl (%eax),%eax
    1398:	0f be c0             	movsbl %al,%eax
    139b:	25 ff 00 00 00       	and    $0xff,%eax
    13a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    13a3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    13a7:	75 2c                	jne    13d5 <printf+0x6a>
      if(c == '%'){
    13a9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    13ad:	75 0c                	jne    13bb <printf+0x50>
        state = '%';
    13af:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    13b6:	e9 27 01 00 00       	jmp    14e2 <printf+0x177>
      } else {
        putc(fd, c);
    13bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    13be:	0f be c0             	movsbl %al,%eax
    13c1:	83 ec 08             	sub    $0x8,%esp
    13c4:	50                   	push   %eax
    13c5:	ff 75 08             	pushl  0x8(%ebp)
    13c8:	e8 c7 fe ff ff       	call   1294 <putc>
    13cd:	83 c4 10             	add    $0x10,%esp
    13d0:	e9 0d 01 00 00       	jmp    14e2 <printf+0x177>
      }
    } else if(state == '%'){
    13d5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    13d9:	0f 85 03 01 00 00    	jne    14e2 <printf+0x177>
      if(c == 'd'){
    13df:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    13e3:	75 1e                	jne    1403 <printf+0x98>
        printint(fd, *ap, 10, 1);
    13e5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13e8:	8b 00                	mov    (%eax),%eax
    13ea:	6a 01                	push   $0x1
    13ec:	6a 0a                	push   $0xa
    13ee:	50                   	push   %eax
    13ef:	ff 75 08             	pushl  0x8(%ebp)
    13f2:	e8 c0 fe ff ff       	call   12b7 <printint>
    13f7:	83 c4 10             	add    $0x10,%esp
        ap++;
    13fa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    13fe:	e9 d8 00 00 00       	jmp    14db <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1403:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1407:	74 06                	je     140f <printf+0xa4>
    1409:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    140d:	75 1e                	jne    142d <printf+0xc2>
        printint(fd, *ap, 16, 0);
    140f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1412:	8b 00                	mov    (%eax),%eax
    1414:	6a 00                	push   $0x0
    1416:	6a 10                	push   $0x10
    1418:	50                   	push   %eax
    1419:	ff 75 08             	pushl  0x8(%ebp)
    141c:	e8 96 fe ff ff       	call   12b7 <printint>
    1421:	83 c4 10             	add    $0x10,%esp
        ap++;
    1424:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1428:	e9 ae 00 00 00       	jmp    14db <printf+0x170>
      } else if(c == 's'){
    142d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1431:	75 43                	jne    1476 <printf+0x10b>
        s = (char*)*ap;
    1433:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1436:	8b 00                	mov    (%eax),%eax
    1438:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    143b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    143f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1443:	75 25                	jne    146a <printf+0xff>
          s = "(null)";
    1445:	c7 45 f4 8f 35 00 00 	movl   $0x358f,-0xc(%ebp)
        while(*s != 0){
    144c:	eb 1c                	jmp    146a <printf+0xff>
          putc(fd, *s);
    144e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1451:	0f b6 00             	movzbl (%eax),%eax
    1454:	0f be c0             	movsbl %al,%eax
    1457:	83 ec 08             	sub    $0x8,%esp
    145a:	50                   	push   %eax
    145b:	ff 75 08             	pushl  0x8(%ebp)
    145e:	e8 31 fe ff ff       	call   1294 <putc>
    1463:	83 c4 10             	add    $0x10,%esp
          s++;
    1466:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    146a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    146d:	0f b6 00             	movzbl (%eax),%eax
    1470:	84 c0                	test   %al,%al
    1472:	75 da                	jne    144e <printf+0xe3>
    1474:	eb 65                	jmp    14db <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1476:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    147a:	75 1d                	jne    1499 <printf+0x12e>
        putc(fd, *ap);
    147c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    147f:	8b 00                	mov    (%eax),%eax
    1481:	0f be c0             	movsbl %al,%eax
    1484:	83 ec 08             	sub    $0x8,%esp
    1487:	50                   	push   %eax
    1488:	ff 75 08             	pushl  0x8(%ebp)
    148b:	e8 04 fe ff ff       	call   1294 <putc>
    1490:	83 c4 10             	add    $0x10,%esp
        ap++;
    1493:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1497:	eb 42                	jmp    14db <printf+0x170>
      } else if(c == '%'){
    1499:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    149d:	75 17                	jne    14b6 <printf+0x14b>
        putc(fd, c);
    149f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14a2:	0f be c0             	movsbl %al,%eax
    14a5:	83 ec 08             	sub    $0x8,%esp
    14a8:	50                   	push   %eax
    14a9:	ff 75 08             	pushl  0x8(%ebp)
    14ac:	e8 e3 fd ff ff       	call   1294 <putc>
    14b1:	83 c4 10             	add    $0x10,%esp
    14b4:	eb 25                	jmp    14db <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    14b6:	83 ec 08             	sub    $0x8,%esp
    14b9:	6a 25                	push   $0x25
    14bb:	ff 75 08             	pushl  0x8(%ebp)
    14be:	e8 d1 fd ff ff       	call   1294 <putc>
    14c3:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    14c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14c9:	0f be c0             	movsbl %al,%eax
    14cc:	83 ec 08             	sub    $0x8,%esp
    14cf:	50                   	push   %eax
    14d0:	ff 75 08             	pushl  0x8(%ebp)
    14d3:	e8 bc fd ff ff       	call   1294 <putc>
    14d8:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    14db:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14e2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14e6:	8b 55 0c             	mov    0xc(%ebp),%edx
    14e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14ec:	01 d0                	add    %edx,%eax
    14ee:	0f b6 00             	movzbl (%eax),%eax
    14f1:	84 c0                	test   %al,%al
    14f3:	0f 85 94 fe ff ff    	jne    138d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    14f9:	90                   	nop
    14fa:	c9                   	leave  
    14fb:	c3                   	ret    

000014fc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14fc:	55                   	push   %ebp
    14fd:	89 e5                	mov    %esp,%ebp
    14ff:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1502:	8b 45 08             	mov    0x8(%ebp),%eax
    1505:	83 e8 08             	sub    $0x8,%eax
    1508:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    150b:	a1 6c 7a 00 00       	mov    0x7a6c,%eax
    1510:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1513:	eb 24                	jmp    1539 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1515:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1518:	8b 00                	mov    (%eax),%eax
    151a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    151d:	77 12                	ja     1531 <free+0x35>
    151f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1522:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1525:	77 24                	ja     154b <free+0x4f>
    1527:	8b 45 fc             	mov    -0x4(%ebp),%eax
    152a:	8b 00                	mov    (%eax),%eax
    152c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    152f:	77 1a                	ja     154b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1531:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1534:	8b 00                	mov    (%eax),%eax
    1536:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1539:	8b 45 f8             	mov    -0x8(%ebp),%eax
    153c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    153f:	76 d4                	jbe    1515 <free+0x19>
    1541:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1544:	8b 00                	mov    (%eax),%eax
    1546:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1549:	76 ca                	jbe    1515 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    154b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    154e:	8b 40 04             	mov    0x4(%eax),%eax
    1551:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1558:	8b 45 f8             	mov    -0x8(%ebp),%eax
    155b:	01 c2                	add    %eax,%edx
    155d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1560:	8b 00                	mov    (%eax),%eax
    1562:	39 c2                	cmp    %eax,%edx
    1564:	75 24                	jne    158a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1566:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1569:	8b 50 04             	mov    0x4(%eax),%edx
    156c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    156f:	8b 00                	mov    (%eax),%eax
    1571:	8b 40 04             	mov    0x4(%eax),%eax
    1574:	01 c2                	add    %eax,%edx
    1576:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1579:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    157c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    157f:	8b 00                	mov    (%eax),%eax
    1581:	8b 10                	mov    (%eax),%edx
    1583:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1586:	89 10                	mov    %edx,(%eax)
    1588:	eb 0a                	jmp    1594 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    158a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    158d:	8b 10                	mov    (%eax),%edx
    158f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1592:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1594:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1597:	8b 40 04             	mov    0x4(%eax),%eax
    159a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    15a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15a4:	01 d0                	add    %edx,%eax
    15a6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    15a9:	75 20                	jne    15cb <free+0xcf>
    p->s.size += bp->s.size;
    15ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15ae:	8b 50 04             	mov    0x4(%eax),%edx
    15b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    15b4:	8b 40 04             	mov    0x4(%eax),%eax
    15b7:	01 c2                	add    %eax,%edx
    15b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15bc:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    15bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    15c2:	8b 10                	mov    (%eax),%edx
    15c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15c7:	89 10                	mov    %edx,(%eax)
    15c9:	eb 08                	jmp    15d3 <free+0xd7>
  } else
    p->s.ptr = bp;
    15cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15ce:	8b 55 f8             	mov    -0x8(%ebp),%edx
    15d1:	89 10                	mov    %edx,(%eax)
  freep = p;
    15d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15d6:	a3 6c 7a 00 00       	mov    %eax,0x7a6c
}
    15db:	90                   	nop
    15dc:	c9                   	leave  
    15dd:	c3                   	ret    

000015de <morecore>:

static Header*
morecore(uint nu)
{
    15de:	55                   	push   %ebp
    15df:	89 e5                	mov    %esp,%ebp
    15e1:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    15e4:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    15eb:	77 07                	ja     15f4 <morecore+0x16>
    nu = 4096;
    15ed:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    15f4:	8b 45 08             	mov    0x8(%ebp),%eax
    15f7:	c1 e0 03             	shl    $0x3,%eax
    15fa:	83 ec 0c             	sub    $0xc,%esp
    15fd:	50                   	push   %eax
    15fe:	e8 31 fc ff ff       	call   1234 <sbrk>
    1603:	83 c4 10             	add    $0x10,%esp
    1606:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1609:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    160d:	75 07                	jne    1616 <morecore+0x38>
    return 0;
    160f:	b8 00 00 00 00       	mov    $0x0,%eax
    1614:	eb 26                	jmp    163c <morecore+0x5e>
  hp = (Header*)p;
    1616:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1619:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    161c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    161f:	8b 55 08             	mov    0x8(%ebp),%edx
    1622:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1625:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1628:	83 c0 08             	add    $0x8,%eax
    162b:	83 ec 0c             	sub    $0xc,%esp
    162e:	50                   	push   %eax
    162f:	e8 c8 fe ff ff       	call   14fc <free>
    1634:	83 c4 10             	add    $0x10,%esp
  return freep;
    1637:	a1 6c 7a 00 00       	mov    0x7a6c,%eax
}
    163c:	c9                   	leave  
    163d:	c3                   	ret    

0000163e <malloc>:

void*
malloc(uint nbytes)
{
    163e:	55                   	push   %ebp
    163f:	89 e5                	mov    %esp,%ebp
    1641:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1644:	8b 45 08             	mov    0x8(%ebp),%eax
    1647:	83 c0 07             	add    $0x7,%eax
    164a:	c1 e8 03             	shr    $0x3,%eax
    164d:	83 c0 01             	add    $0x1,%eax
    1650:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1653:	a1 6c 7a 00 00       	mov    0x7a6c,%eax
    1658:	89 45 f0             	mov    %eax,-0x10(%ebp)
    165b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    165f:	75 23                	jne    1684 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1661:	c7 45 f0 64 7a 00 00 	movl   $0x7a64,-0x10(%ebp)
    1668:	8b 45 f0             	mov    -0x10(%ebp),%eax
    166b:	a3 6c 7a 00 00       	mov    %eax,0x7a6c
    1670:	a1 6c 7a 00 00       	mov    0x7a6c,%eax
    1675:	a3 64 7a 00 00       	mov    %eax,0x7a64
    base.s.size = 0;
    167a:	c7 05 68 7a 00 00 00 	movl   $0x0,0x7a68
    1681:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1684:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1687:	8b 00                	mov    (%eax),%eax
    1689:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    168c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168f:	8b 40 04             	mov    0x4(%eax),%eax
    1692:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1695:	72 4d                	jb     16e4 <malloc+0xa6>
      if(p->s.size == nunits)
    1697:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169a:	8b 40 04             	mov    0x4(%eax),%eax
    169d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    16a0:	75 0c                	jne    16ae <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    16a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a5:	8b 10                	mov    (%eax),%edx
    16a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16aa:	89 10                	mov    %edx,(%eax)
    16ac:	eb 26                	jmp    16d4 <malloc+0x96>
      else {
        p->s.size -= nunits;
    16ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b1:	8b 40 04             	mov    0x4(%eax),%eax
    16b4:	2b 45 ec             	sub    -0x14(%ebp),%eax
    16b7:	89 c2                	mov    %eax,%edx
    16b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16bc:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    16bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c2:	8b 40 04             	mov    0x4(%eax),%eax
    16c5:	c1 e0 03             	shl    $0x3,%eax
    16c8:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    16cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ce:	8b 55 ec             	mov    -0x14(%ebp),%edx
    16d1:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    16d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16d7:	a3 6c 7a 00 00       	mov    %eax,0x7a6c
      return (void*)(p + 1);
    16dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16df:	83 c0 08             	add    $0x8,%eax
    16e2:	eb 3b                	jmp    171f <malloc+0xe1>
    }
    if(p == freep)
    16e4:	a1 6c 7a 00 00       	mov    0x7a6c,%eax
    16e9:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    16ec:	75 1e                	jne    170c <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    16ee:	83 ec 0c             	sub    $0xc,%esp
    16f1:	ff 75 ec             	pushl  -0x14(%ebp)
    16f4:	e8 e5 fe ff ff       	call   15de <morecore>
    16f9:	83 c4 10             	add    $0x10,%esp
    16fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    16ff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1703:	75 07                	jne    170c <malloc+0xce>
        return 0;
    1705:	b8 00 00 00 00       	mov    $0x0,%eax
    170a:	eb 13                	jmp    171f <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    170c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1712:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1715:	8b 00                	mov    (%eax),%eax
    1717:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    171a:	e9 6d ff ff ff       	jmp    168c <malloc+0x4e>
}
    171f:	c9                   	leave  
    1720:	c3                   	ret    

00001721 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1721:	55                   	push   %ebp
    1722:	89 e5                	mov    %esp,%ebp
    1724:	83 ec 1c             	sub    $0x1c,%esp
    1727:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    172a:	8b 55 10             	mov    0x10(%ebp),%edx
    172d:	8b 45 14             	mov    0x14(%ebp),%eax
    1730:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1733:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1736:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1739:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    173d:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1740:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1744:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1747:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    174b:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    174e:	8b 45 08             	mov    0x8(%ebp),%eax
    1751:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1755:	66 89 10             	mov    %dx,(%eax)
    1758:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    175c:	88 50 02             	mov    %dl,0x2(%eax)
}
    175f:	8b 45 08             	mov    0x8(%ebp),%eax
    1762:	c9                   	leave  
    1763:	c2 04 00             	ret    $0x4

00001766 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    1766:	55                   	push   %ebp
    1767:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
    1769:	8b 45 08             	mov    0x8(%ebp),%eax
    176c:	2b 45 10             	sub    0x10(%ebp),%eax
    176f:	89 c2                	mov    %eax,%edx
    1771:	8b 45 08             	mov    0x8(%ebp),%eax
    1774:	2b 45 10             	sub    0x10(%ebp),%eax
    1777:	0f af d0             	imul   %eax,%edx
    177a:	8b 45 0c             	mov    0xc(%ebp),%eax
    177d:	2b 45 14             	sub    0x14(%ebp),%eax
    1780:	89 c1                	mov    %eax,%ecx
    1782:	8b 45 0c             	mov    0xc(%ebp),%eax
    1785:	2b 45 14             	sub    0x14(%ebp),%eax
    1788:	0f af c1             	imul   %ecx,%eax
    178b:	01 d0                	add    %edx,%eax
}
    178d:	5d                   	pop    %ebp
    178e:	c3                   	ret    

0000178f <abs_int>:

static inline int abs_int(int x)
{
    178f:	55                   	push   %ebp
    1790:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
    1792:	8b 45 08             	mov    0x8(%ebp),%eax
    1795:	99                   	cltd   
    1796:	89 d0                	mov    %edx,%eax
    1798:	33 45 08             	xor    0x8(%ebp),%eax
    179b:	29 d0                	sub    %edx,%eax
}
    179d:	5d                   	pop    %ebp
    179e:	c3                   	ret    

0000179f <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    179f:	55                   	push   %ebp
    17a0:	89 e5                	mov    %esp,%ebp
    if (x < 0)
    17a2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    17a6:	79 07                	jns    17af <APGetIndex+0x10>
        return X_SMALLER;
    17a8:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    17ad:	eb 40                	jmp    17ef <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
    17af:	8b 45 08             	mov    0x8(%ebp),%eax
    17b2:	8b 00                	mov    (%eax),%eax
    17b4:	3b 45 0c             	cmp    0xc(%ebp),%eax
    17b7:	7f 07                	jg     17c0 <APGetIndex+0x21>
        return X_BIGGER;
    17b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    17be:	eb 2f                	jmp    17ef <APGetIndex+0x50>
    if (y < 0)
    17c0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    17c4:	79 07                	jns    17cd <APGetIndex+0x2e>
        return Y_SMALLER;
    17c6:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
    17cb:	eb 22                	jmp    17ef <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
    17cd:	8b 45 08             	mov    0x8(%ebp),%eax
    17d0:	8b 40 04             	mov    0x4(%eax),%eax
    17d3:	3b 45 10             	cmp    0x10(%ebp),%eax
    17d6:	7f 07                	jg     17df <APGetIndex+0x40>
        return Y_BIGGER;
    17d8:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    17dd:	eb 10                	jmp    17ef <APGetIndex+0x50>
    return y * hdc->size.cx + x;
    17df:	8b 45 08             	mov    0x8(%ebp),%eax
    17e2:	8b 00                	mov    (%eax),%eax
    17e4:	0f af 45 10          	imul   0x10(%ebp),%eax
    17e8:	89 c2                	mov    %eax,%edx
    17ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    17ed:	01 d0                	add    %edx,%eax
}
    17ef:	5d                   	pop    %ebp
    17f0:	c3                   	ret    

000017f1 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    17f1:	55                   	push   %ebp
    17f2:	89 e5                	mov    %esp,%ebp
    17f4:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    17f7:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    17fe:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1801:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    1804:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    180b:	83 ec 08             	sub    $0x8,%esp
    180e:	6a 00                	push   $0x0
    1810:	ff 75 0c             	pushl  0xc(%ebp)
    1813:	e8 d4 f9 ff ff       	call   11ec <open>
    1818:	83 c4 10             	add    $0x10,%esp
    181b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    181e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1822:	79 2e                	jns    1852 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
    1824:	83 ec 04             	sub    $0x4,%esp
    1827:	ff 75 0c             	pushl  0xc(%ebp)
    182a:	68 96 35 00 00       	push   $0x3596
    182f:	6a 01                	push   $0x1
    1831:	e8 35 fb ff ff       	call   136b <printf>
    1836:	83 c4 10             	add    $0x10,%esp
        return bmp;
    1839:	8b 45 08             	mov    0x8(%ebp),%eax
    183c:	8b 55 c8             	mov    -0x38(%ebp),%edx
    183f:	89 10                	mov    %edx,(%eax)
    1841:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1844:	89 50 04             	mov    %edx,0x4(%eax)
    1847:	8b 55 d0             	mov    -0x30(%ebp),%edx
    184a:	89 50 08             	mov    %edx,0x8(%eax)
    184d:	e9 d2 01 00 00       	jmp    1a24 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    1852:	83 ec 04             	sub    $0x4,%esp
    1855:	6a 0e                	push   $0xe
    1857:	8d 45 ba             	lea    -0x46(%ebp),%eax
    185a:	50                   	push   %eax
    185b:	ff 75 ec             	pushl  -0x14(%ebp)
    185e:	e8 61 f9 ff ff       	call   11c4 <read>
    1863:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    1866:	83 ec 04             	sub    $0x4,%esp
    1869:	6a 28                	push   $0x28
    186b:	8d 45 92             	lea    -0x6e(%ebp),%eax
    186e:	50                   	push   %eax
    186f:	ff 75 ec             	pushl  -0x14(%ebp)
    1872:	e8 4d f9 ff ff       	call   11c4 <read>
    1877:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    187a:	8b 45 96             	mov    -0x6a(%ebp),%eax
    187d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    1880:	8b 45 9a             	mov    -0x66(%ebp),%eax
    1883:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    1886:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1889:	8b 45 cc             	mov    -0x34(%ebp),%eax
    188c:	0f af d0             	imul   %eax,%edx
    188f:	89 d0                	mov    %edx,%eax
    1891:	01 c0                	add    %eax,%eax
    1893:	01 d0                	add    %edx,%eax
    1895:	83 ec 0c             	sub    $0xc,%esp
    1898:	50                   	push   %eax
    1899:	e8 a0 fd ff ff       	call   163e <malloc>
    189e:	83 c4 10             	add    $0x10,%esp
    18a1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    18a4:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    18a8:	0f b7 c0             	movzwl %ax,%eax
    18ab:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    18ae:	8b 55 c8             	mov    -0x38(%ebp),%edx
    18b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18b4:	0f af c2             	imul   %edx,%eax
    18b7:	83 c0 1f             	add    $0x1f,%eax
    18ba:	c1 e8 05             	shr    $0x5,%eax
    18bd:	c1 e0 02             	shl    $0x2,%eax
    18c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    18c3:	8b 55 cc             	mov    -0x34(%ebp),%edx
    18c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18c9:	0f af c2             	imul   %edx,%eax
    18cc:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    18cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    18d2:	83 ec 0c             	sub    $0xc,%esp
    18d5:	50                   	push   %eax
    18d6:	e8 63 fd ff ff       	call   163e <malloc>
    18db:	83 c4 10             	add    $0x10,%esp
    18de:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    18e1:	83 ec 04             	sub    $0x4,%esp
    18e4:	ff 75 e0             	pushl  -0x20(%ebp)
    18e7:	ff 75 dc             	pushl  -0x24(%ebp)
    18ea:	ff 75 ec             	pushl  -0x14(%ebp)
    18ed:	e8 d2 f8 ff ff       	call   11c4 <read>
    18f2:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    18f5:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    18f9:	66 c1 e8 03          	shr    $0x3,%ax
    18fd:	0f b7 c0             	movzwl %ax,%eax
    1900:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    1903:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    190a:	e9 e5 00 00 00       	jmp    19f4 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    190f:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1912:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1915:	29 c2                	sub    %eax,%edx
    1917:	89 d0                	mov    %edx,%eax
    1919:	8d 50 ff             	lea    -0x1(%eax),%edx
    191c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    191f:	0f af c2             	imul   %edx,%eax
    1922:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    1925:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    192c:	e9 b1 00 00 00       	jmp    19e2 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    1931:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1934:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1937:	8b 45 f0             	mov    -0x10(%ebp),%eax
    193a:	01 c8                	add    %ecx,%eax
    193c:	89 c1                	mov    %eax,%ecx
    193e:	89 c8                	mov    %ecx,%eax
    1940:	01 c0                	add    %eax,%eax
    1942:	01 c8                	add    %ecx,%eax
    1944:	01 c2                	add    %eax,%edx
    1946:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1949:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    194d:	89 c1                	mov    %eax,%ecx
    194f:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1952:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1956:	01 c1                	add    %eax,%ecx
    1958:	8b 45 d8             	mov    -0x28(%ebp),%eax
    195b:	01 c8                	add    %ecx,%eax
    195d:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1960:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1963:	01 c8                	add    %ecx,%eax
    1965:	0f b6 00             	movzbl (%eax),%eax
    1968:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    196b:	8b 55 d0             	mov    -0x30(%ebp),%edx
    196e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1971:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1974:	01 c8                	add    %ecx,%eax
    1976:	89 c1                	mov    %eax,%ecx
    1978:	89 c8                	mov    %ecx,%eax
    197a:	01 c0                	add    %eax,%eax
    197c:	01 c8                	add    %ecx,%eax
    197e:	01 c2                	add    %eax,%edx
    1980:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1983:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1987:	89 c1                	mov    %eax,%ecx
    1989:	8b 45 d8             	mov    -0x28(%ebp),%eax
    198c:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1990:	01 c1                	add    %eax,%ecx
    1992:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1995:	01 c8                	add    %ecx,%eax
    1997:	8d 48 fe             	lea    -0x2(%eax),%ecx
    199a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    199d:	01 c8                	add    %ecx,%eax
    199f:	0f b6 00             	movzbl (%eax),%eax
    19a2:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    19a5:	8b 55 d0             	mov    -0x30(%ebp),%edx
    19a8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    19ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19ae:	01 c8                	add    %ecx,%eax
    19b0:	89 c1                	mov    %eax,%ecx
    19b2:	89 c8                	mov    %ecx,%eax
    19b4:	01 c0                	add    %eax,%eax
    19b6:	01 c8                	add    %ecx,%eax
    19b8:	01 c2                	add    %eax,%edx
    19ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19bd:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    19c1:	89 c1                	mov    %eax,%ecx
    19c3:	8b 45 d8             	mov    -0x28(%ebp),%eax
    19c6:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    19ca:	01 c1                	add    %eax,%ecx
    19cc:	8b 45 d8             	mov    -0x28(%ebp),%eax
    19cf:	01 c8                	add    %ecx,%eax
    19d1:	8d 48 fd             	lea    -0x3(%eax),%ecx
    19d4:	8b 45 dc             	mov    -0x24(%ebp),%eax
    19d7:	01 c8                	add    %ecx,%eax
    19d9:	0f b6 00             	movzbl (%eax),%eax
    19dc:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    19de:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    19e2:	8b 55 c8             	mov    -0x38(%ebp),%edx
    19e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19e8:	39 c2                	cmp    %eax,%edx
    19ea:	0f 87 41 ff ff ff    	ja     1931 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    19f0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    19f4:	8b 55 cc             	mov    -0x34(%ebp),%edx
    19f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19fa:	39 c2                	cmp    %eax,%edx
    19fc:	0f 87 0d ff ff ff    	ja     190f <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    1a02:	83 ec 0c             	sub    $0xc,%esp
    1a05:	ff 75 ec             	pushl  -0x14(%ebp)
    1a08:	e8 c7 f7 ff ff       	call   11d4 <close>
    1a0d:	83 c4 10             	add    $0x10,%esp
    return bmp;
    1a10:	8b 45 08             	mov    0x8(%ebp),%eax
    1a13:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1a16:	89 10                	mov    %edx,(%eax)
    1a18:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1a1b:	89 50 04             	mov    %edx,0x4(%eax)
    1a1e:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1a21:	89 50 08             	mov    %edx,0x8(%eax)
}
    1a24:	8b 45 08             	mov    0x8(%ebp),%eax
    1a27:	c9                   	leave  
    1a28:	c2 04 00             	ret    $0x4

00001a2b <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    1a2b:	55                   	push   %ebp
    1a2c:	89 e5                	mov    %esp,%ebp
    1a2e:	53                   	push   %ebx
    1a2f:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    1a32:	83 ec 0c             	sub    $0xc,%esp
    1a35:	6a 1c                	push   $0x1c
    1a37:	e8 02 fc ff ff       	call   163e <malloc>
    1a3c:	83 c4 10             	add    $0x10,%esp
    1a3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    1a42:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a45:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    1a4c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    1a4f:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1a52:	6a 0c                	push   $0xc
    1a54:	6a 0c                	push   $0xc
    1a56:	6a 0c                	push   $0xc
    1a58:	50                   	push   %eax
    1a59:	e8 c3 fc ff ff       	call   1721 <RGB>
    1a5e:	83 c4 0c             	add    $0xc,%esp
    1a61:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    1a65:	66 89 43 13          	mov    %ax,0x13(%ebx)
    1a69:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    1a6d:	88 43 15             	mov    %al,0x15(%ebx)
    1a70:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a73:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a76:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    1a7a:	66 89 48 10          	mov    %cx,0x10(%eax)
    1a7e:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    1a82:	88 50 12             	mov    %dl,0x12(%eax)
    1a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a88:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a8b:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    1a8f:	66 89 48 08          	mov    %cx,0x8(%eax)
    1a93:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    1a97:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    1a9a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9d:	89 c2                	mov    %eax,%edx
    1a9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aa2:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    1aa4:	8b 45 0c             	mov    0xc(%ebp),%eax
    1aa7:	89 c2                	mov    %eax,%edx
    1aa9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aac:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    1aaf:	8b 55 10             	mov    0x10(%ebp),%edx
    1ab2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ab5:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    1ab8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1abb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1abe:	c9                   	leave  
    1abf:	c3                   	ret    

00001ac0 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    1ac0:	55                   	push   %ebp
    1ac1:	89 e5                	mov    %esp,%ebp
    1ac3:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    1ac6:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ac9:	8b 50 08             	mov    0x8(%eax),%edx
    1acc:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1acf:	8b 40 0c             	mov    0xc(%eax),%eax
    1ad2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    1ad5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ad8:	8b 55 10             	mov    0x10(%ebp),%edx
    1adb:	89 50 08             	mov    %edx,0x8(%eax)
    1ade:	8b 55 14             	mov    0x14(%ebp),%edx
    1ae1:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    1ae4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae7:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1aea:	89 10                	mov    %edx,(%eax)
    1aec:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1aef:	89 50 04             	mov    %edx,0x4(%eax)
}
    1af2:	8b 45 08             	mov    0x8(%ebp),%eax
    1af5:	c9                   	leave  
    1af6:	c2 04 00             	ret    $0x4

00001af9 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    1af9:	55                   	push   %ebp
    1afa:	89 e5                	mov    %esp,%ebp
    1afc:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    1aff:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b02:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    1b06:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1b0a:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1b0e:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    1b11:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b14:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1b18:	66 89 50 10          	mov    %dx,0x10(%eax)
    1b1c:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1b20:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    1b23:	8b 45 08             	mov    0x8(%ebp),%eax
    1b26:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1b2a:	66 89 10             	mov    %dx,(%eax)
    1b2d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1b31:	88 50 02             	mov    %dl,0x2(%eax)
}
    1b34:	8b 45 08             	mov    0x8(%ebp),%eax
    1b37:	c9                   	leave  
    1b38:	c2 04 00             	ret    $0x4

00001b3b <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
    1b3b:	55                   	push   %ebp
    1b3c:	89 e5                	mov    %esp,%ebp
    1b3e:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
    1b41:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b44:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1b48:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1b4c:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1b50:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
    1b53:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b56:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1b5a:	66 89 50 13          	mov    %dx,0x13(%eax)
    1b5e:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1b62:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
    1b65:	8b 45 08             	mov    0x8(%ebp),%eax
    1b68:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1b6c:	66 89 10             	mov    %dx,(%eax)
    1b6f:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1b73:	88 50 02             	mov    %dl,0x2(%eax)
}
    1b76:	8b 45 08             	mov    0x8(%ebp),%eax
    1b79:	c9                   	leave  
    1b7a:	c2 04 00             	ret    $0x4

00001b7d <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    1b7d:	55                   	push   %ebp
    1b7e:	89 e5                	mov    %esp,%ebp
    1b80:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    1b83:	8b 45 08             	mov    0x8(%ebp),%eax
    1b86:	8b 40 0c             	mov    0xc(%eax),%eax
    1b89:	89 c2                	mov    %eax,%edx
    1b8b:	c1 ea 1f             	shr    $0x1f,%edx
    1b8e:	01 d0                	add    %edx,%eax
    1b90:	d1 f8                	sar    %eax
    1b92:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    1b95:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b98:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    1b9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    1b9f:	8b 45 10             	mov    0x10(%ebp),%eax
    1ba2:	2b 45 f4             	sub    -0xc(%ebp),%eax
    1ba5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    1ba8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    1bac:	0f 89 98 00 00 00    	jns    1c4a <APDrawPoint+0xcd>
        i = 0;
    1bb2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    1bb9:	e9 8c 00 00 00       	jmp    1c4a <APDrawPoint+0xcd>
    {
        j = x - off;
    1bbe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1bc1:	2b 45 f4             	sub    -0xc(%ebp),%eax
    1bc4:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    1bc7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1bcb:	79 69                	jns    1c36 <APDrawPoint+0xb9>
            j = 0;
    1bcd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    1bd4:	eb 60                	jmp    1c36 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    1bd6:	ff 75 fc             	pushl  -0x4(%ebp)
    1bd9:	ff 75 f8             	pushl  -0x8(%ebp)
    1bdc:	ff 75 08             	pushl  0x8(%ebp)
    1bdf:	e8 bb fb ff ff       	call   179f <APGetIndex>
    1be4:	83 c4 0c             	add    $0xc,%esp
    1be7:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    1bea:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    1bee:	74 55                	je     1c45 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    1bf0:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    1bf4:	74 67                	je     1c5d <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    1bf6:	ff 75 10             	pushl  0x10(%ebp)
    1bf9:	ff 75 0c             	pushl  0xc(%ebp)
    1bfc:	ff 75 fc             	pushl  -0x4(%ebp)
    1bff:	ff 75 f8             	pushl  -0x8(%ebp)
    1c02:	e8 5f fb ff ff       	call   1766 <distance_2>
    1c07:	83 c4 10             	add    $0x10,%esp
    1c0a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1c0d:	7f 23                	jg     1c32 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    1c0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c12:	8b 48 18             	mov    0x18(%eax),%ecx
    1c15:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1c18:	89 d0                	mov    %edx,%eax
    1c1a:	01 c0                	add    %eax,%eax
    1c1c:	01 d0                	add    %edx,%eax
    1c1e:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1c21:	8b 45 08             	mov    0x8(%ebp),%eax
    1c24:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1c28:	66 89 0a             	mov    %cx,(%edx)
    1c2b:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1c2f:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1c32:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1c36:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c39:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c3c:	01 d0                	add    %edx,%eax
    1c3e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1c41:	7d 93                	jge    1bd6 <APDrawPoint+0x59>
    1c43:	eb 01                	jmp    1c46 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1c45:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1c46:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1c4a:	8b 55 10             	mov    0x10(%ebp),%edx
    1c4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c50:	01 d0                	add    %edx,%eax
    1c52:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1c55:	0f 8d 63 ff ff ff    	jge    1bbe <APDrawPoint+0x41>
    1c5b:	eb 01                	jmp    1c5e <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1c5d:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    1c5e:	c9                   	leave  
    1c5f:	c3                   	ret    

00001c60 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1c60:	55                   	push   %ebp
    1c61:	89 e5                	mov    %esp,%ebp
    1c63:	53                   	push   %ebx
    1c64:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1c67:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c6a:	3b 45 14             	cmp    0x14(%ebp),%eax
    1c6d:	0f 85 80 00 00 00    	jne    1cf3 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1c73:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1c77:	0f 88 9d 02 00 00    	js     1f1a <APDrawLine+0x2ba>
    1c7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c80:	8b 00                	mov    (%eax),%eax
    1c82:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1c85:	0f 8e 8f 02 00 00    	jle    1f1a <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    1c8b:	8b 45 10             	mov    0x10(%ebp),%eax
    1c8e:	3b 45 18             	cmp    0x18(%ebp),%eax
    1c91:	7e 12                	jle    1ca5 <APDrawLine+0x45>
        {
            int tmp = y2;
    1c93:	8b 45 18             	mov    0x18(%ebp),%eax
    1c96:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    1c99:	8b 45 10             	mov    0x10(%ebp),%eax
    1c9c:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1c9f:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1ca2:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1ca5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1ca9:	79 07                	jns    1cb2 <APDrawLine+0x52>
    1cab:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1cb2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb5:	8b 40 04             	mov    0x4(%eax),%eax
    1cb8:	3b 45 18             	cmp    0x18(%ebp),%eax
    1cbb:	7d 0c                	jge    1cc9 <APDrawLine+0x69>
    1cbd:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc0:	8b 40 04             	mov    0x4(%eax),%eax
    1cc3:	83 e8 01             	sub    $0x1,%eax
    1cc6:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    1cc9:	8b 45 10             	mov    0x10(%ebp),%eax
    1ccc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1ccf:	eb 15                	jmp    1ce6 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1cd1:	ff 75 f4             	pushl  -0xc(%ebp)
    1cd4:	ff 75 0c             	pushl  0xc(%ebp)
    1cd7:	ff 75 08             	pushl  0x8(%ebp)
    1cda:	e8 9e fe ff ff       	call   1b7d <APDrawPoint>
    1cdf:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1ce2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ce6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ce9:	3b 45 18             	cmp    0x18(%ebp),%eax
    1cec:	7e e3                	jle    1cd1 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    1cee:	e9 2b 02 00 00       	jmp    1f1e <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1cf3:	8b 45 10             	mov    0x10(%ebp),%eax
    1cf6:	3b 45 18             	cmp    0x18(%ebp),%eax
    1cf9:	75 7f                	jne    1d7a <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    1cfb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1cff:	0f 88 18 02 00 00    	js     1f1d <APDrawLine+0x2bd>
    1d05:	8b 45 08             	mov    0x8(%ebp),%eax
    1d08:	8b 40 04             	mov    0x4(%eax),%eax
    1d0b:	3b 45 10             	cmp    0x10(%ebp),%eax
    1d0e:	0f 8e 09 02 00 00    	jle    1f1d <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1d14:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d17:	3b 45 14             	cmp    0x14(%ebp),%eax
    1d1a:	7e 12                	jle    1d2e <APDrawLine+0xce>
        {
            int tmp = x2;
    1d1c:	8b 45 14             	mov    0x14(%ebp),%eax
    1d1f:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1d22:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d25:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1d28:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1d2b:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1d2e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1d32:	79 07                	jns    1d3b <APDrawLine+0xdb>
    1d34:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1d3b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d3e:	8b 00                	mov    (%eax),%eax
    1d40:	3b 45 14             	cmp    0x14(%ebp),%eax
    1d43:	7d 0b                	jge    1d50 <APDrawLine+0xf0>
    1d45:	8b 45 08             	mov    0x8(%ebp),%eax
    1d48:	8b 00                	mov    (%eax),%eax
    1d4a:	83 e8 01             	sub    $0x1,%eax
    1d4d:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1d50:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d53:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1d56:	eb 15                	jmp    1d6d <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1d58:	ff 75 10             	pushl  0x10(%ebp)
    1d5b:	ff 75 f0             	pushl  -0x10(%ebp)
    1d5e:	ff 75 08             	pushl  0x8(%ebp)
    1d61:	e8 17 fe ff ff       	call   1b7d <APDrawPoint>
    1d66:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1d69:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1d6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d70:	3b 45 14             	cmp    0x14(%ebp),%eax
    1d73:	7e e3                	jle    1d58 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1d75:	e9 a4 01 00 00       	jmp    1f1e <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1d7a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1d81:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1d88:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d8b:	2b 45 14             	sub    0x14(%ebp),%eax
    1d8e:	50                   	push   %eax
    1d8f:	e8 fb f9 ff ff       	call   178f <abs_int>
    1d94:	83 c4 04             	add    $0x4,%esp
    1d97:	89 c3                	mov    %eax,%ebx
    1d99:	8b 45 10             	mov    0x10(%ebp),%eax
    1d9c:	2b 45 18             	sub    0x18(%ebp),%eax
    1d9f:	50                   	push   %eax
    1da0:	e8 ea f9 ff ff       	call   178f <abs_int>
    1da5:	83 c4 04             	add    $0x4,%esp
    1da8:	39 c3                	cmp    %eax,%ebx
    1daa:	0f 8e b5 00 00 00    	jle    1e65 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1db0:	8b 45 10             	mov    0x10(%ebp),%eax
    1db3:	2b 45 18             	sub    0x18(%ebp),%eax
    1db6:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1db9:	db 45 b0             	fildl  -0x50(%ebp)
    1dbc:	8b 45 0c             	mov    0xc(%ebp),%eax
    1dbf:	2b 45 14             	sub    0x14(%ebp),%eax
    1dc2:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1dc5:	db 45 b0             	fildl  -0x50(%ebp)
    1dc8:	de f9                	fdivrp %st,%st(1)
    1dca:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1dcd:	8b 45 14             	mov    0x14(%ebp),%eax
    1dd0:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1dd3:	7e 0e                	jle    1de3 <APDrawLine+0x183>
        {
            s = x1;
    1dd5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1dd8:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1ddb:	8b 45 14             	mov    0x14(%ebp),%eax
    1dde:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1de1:	eb 0c                	jmp    1def <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1de3:	8b 45 14             	mov    0x14(%ebp),%eax
    1de6:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1de9:	8b 45 0c             	mov    0xc(%ebp),%eax
    1dec:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1def:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1df3:	79 07                	jns    1dfc <APDrawLine+0x19c>
    1df5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1dfc:	8b 45 08             	mov    0x8(%ebp),%eax
    1dff:	8b 00                	mov    (%eax),%eax
    1e01:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1e04:	7f 0b                	jg     1e11 <APDrawLine+0x1b1>
    1e06:	8b 45 08             	mov    0x8(%ebp),%eax
    1e09:	8b 00                	mov    (%eax),%eax
    1e0b:	83 e8 01             	sub    $0x1,%eax
    1e0e:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1e11:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e14:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1e17:	eb 3f                	jmp    1e58 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1e19:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e1c:	2b 45 0c             	sub    0xc(%ebp),%eax
    1e1f:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1e22:	db 45 b0             	fildl  -0x50(%ebp)
    1e25:	dc 4d d0             	fmull  -0x30(%ebp)
    1e28:	db 45 10             	fildl  0x10(%ebp)
    1e2b:	de c1                	faddp  %st,%st(1)
    1e2d:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1e30:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1e34:	b4 0c                	mov    $0xc,%ah
    1e36:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1e3a:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1e3d:	db 5d cc             	fistpl -0x34(%ebp)
    1e40:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1e43:	ff 75 cc             	pushl  -0x34(%ebp)
    1e46:	ff 75 e4             	pushl  -0x1c(%ebp)
    1e49:	ff 75 08             	pushl  0x8(%ebp)
    1e4c:	e8 2c fd ff ff       	call   1b7d <APDrawPoint>
    1e51:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1e54:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e58:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e5b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1e5e:	7e b9                	jle    1e19 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1e60:	e9 b9 00 00 00       	jmp    1f1e <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1e65:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e68:	2b 45 14             	sub    0x14(%ebp),%eax
    1e6b:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1e6e:	db 45 b0             	fildl  -0x50(%ebp)
    1e71:	8b 45 10             	mov    0x10(%ebp),%eax
    1e74:	2b 45 18             	sub    0x18(%ebp),%eax
    1e77:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1e7a:	db 45 b0             	fildl  -0x50(%ebp)
    1e7d:	de f9                	fdivrp %st,%st(1)
    1e7f:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1e82:	8b 45 10             	mov    0x10(%ebp),%eax
    1e85:	3b 45 18             	cmp    0x18(%ebp),%eax
    1e88:	7e 0e                	jle    1e98 <APDrawLine+0x238>
    {
        s = y2;
    1e8a:	8b 45 18             	mov    0x18(%ebp),%eax
    1e8d:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1e90:	8b 45 10             	mov    0x10(%ebp),%eax
    1e93:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1e96:	eb 0c                	jmp    1ea4 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1e98:	8b 45 10             	mov    0x10(%ebp),%eax
    1e9b:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1e9e:	8b 45 18             	mov    0x18(%ebp),%eax
    1ea1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1ea4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ea8:	79 07                	jns    1eb1 <APDrawLine+0x251>
    1eaa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1eb1:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb4:	8b 40 04             	mov    0x4(%eax),%eax
    1eb7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1eba:	7f 0c                	jg     1ec8 <APDrawLine+0x268>
    1ebc:	8b 45 08             	mov    0x8(%ebp),%eax
    1ebf:	8b 40 04             	mov    0x4(%eax),%eax
    1ec2:	83 e8 01             	sub    $0x1,%eax
    1ec5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1ec8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ecb:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1ece:	eb 3f                	jmp    1f0f <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1ed0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ed3:	2b 45 10             	sub    0x10(%ebp),%eax
    1ed6:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1ed9:	db 45 b0             	fildl  -0x50(%ebp)
    1edc:	dc 4d c0             	fmull  -0x40(%ebp)
    1edf:	db 45 0c             	fildl  0xc(%ebp)
    1ee2:	de c1                	faddp  %st,%st(1)
    1ee4:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1ee7:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1eeb:	b4 0c                	mov    $0xc,%ah
    1eed:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1ef1:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1ef4:	db 5d bc             	fistpl -0x44(%ebp)
    1ef7:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1efa:	ff 75 e0             	pushl  -0x20(%ebp)
    1efd:	ff 75 bc             	pushl  -0x44(%ebp)
    1f00:	ff 75 08             	pushl  0x8(%ebp)
    1f03:	e8 75 fc ff ff       	call   1b7d <APDrawPoint>
    1f08:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1f0b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1f0f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f12:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1f15:	7e b9                	jle    1ed0 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1f17:	90                   	nop
    1f18:	eb 04                	jmp    1f1e <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1f1a:	90                   	nop
    1f1b:	eb 01                	jmp    1f1e <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1f1d:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1f1e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1f21:	c9                   	leave  
    1f22:	c3                   	ret    

00001f23 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1f23:	55                   	push   %ebp
    1f24:	89 e5                	mov    %esp,%ebp
    1f26:	53                   	push   %ebx
    1f27:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1f2a:	8b 55 10             	mov    0x10(%ebp),%edx
    1f2d:	8b 45 18             	mov    0x18(%ebp),%eax
    1f30:	01 d0                	add    %edx,%eax
    1f32:	83 e8 01             	sub    $0x1,%eax
    1f35:	83 ec 04             	sub    $0x4,%esp
    1f38:	50                   	push   %eax
    1f39:	ff 75 0c             	pushl  0xc(%ebp)
    1f3c:	ff 75 10             	pushl  0x10(%ebp)
    1f3f:	ff 75 0c             	pushl  0xc(%ebp)
    1f42:	ff 75 08             	pushl  0x8(%ebp)
    1f45:	e8 16 fd ff ff       	call   1c60 <APDrawLine>
    1f4a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1f4d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f50:	8b 45 14             	mov    0x14(%ebp),%eax
    1f53:	01 d0                	add    %edx,%eax
    1f55:	83 e8 01             	sub    $0x1,%eax
    1f58:	83 ec 04             	sub    $0x4,%esp
    1f5b:	ff 75 10             	pushl  0x10(%ebp)
    1f5e:	50                   	push   %eax
    1f5f:	ff 75 10             	pushl  0x10(%ebp)
    1f62:	ff 75 0c             	pushl  0xc(%ebp)
    1f65:	ff 75 08             	pushl  0x8(%ebp)
    1f68:	e8 f3 fc ff ff       	call   1c60 <APDrawLine>
    1f6d:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1f70:	8b 55 10             	mov    0x10(%ebp),%edx
    1f73:	8b 45 18             	mov    0x18(%ebp),%eax
    1f76:	01 d0                	add    %edx,%eax
    1f78:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1f7b:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f7e:	8b 45 14             	mov    0x14(%ebp),%eax
    1f81:	01 d0                	add    %edx,%eax
    1f83:	8d 50 ff             	lea    -0x1(%eax),%edx
    1f86:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1f89:	8b 45 14             	mov    0x14(%ebp),%eax
    1f8c:	01 d8                	add    %ebx,%eax
    1f8e:	83 e8 01             	sub    $0x1,%eax
    1f91:	83 ec 04             	sub    $0x4,%esp
    1f94:	51                   	push   %ecx
    1f95:	52                   	push   %edx
    1f96:	ff 75 10             	pushl  0x10(%ebp)
    1f99:	50                   	push   %eax
    1f9a:	ff 75 08             	pushl  0x8(%ebp)
    1f9d:	e8 be fc ff ff       	call   1c60 <APDrawLine>
    1fa2:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1fa5:	8b 55 10             	mov    0x10(%ebp),%edx
    1fa8:	8b 45 18             	mov    0x18(%ebp),%eax
    1fab:	01 d0                	add    %edx,%eax
    1fad:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1fb0:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fb3:	8b 45 14             	mov    0x14(%ebp),%eax
    1fb6:	01 d0                	add    %edx,%eax
    1fb8:	8d 50 ff             	lea    -0x1(%eax),%edx
    1fbb:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1fbe:	8b 45 18             	mov    0x18(%ebp),%eax
    1fc1:	01 d8                	add    %ebx,%eax
    1fc3:	83 e8 01             	sub    $0x1,%eax
    1fc6:	83 ec 04             	sub    $0x4,%esp
    1fc9:	51                   	push   %ecx
    1fca:	52                   	push   %edx
    1fcb:	50                   	push   %eax
    1fcc:	ff 75 0c             	pushl  0xc(%ebp)
    1fcf:	ff 75 08             	pushl  0x8(%ebp)
    1fd2:	e8 89 fc ff ff       	call   1c60 <APDrawLine>
    1fd7:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1fda:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fdd:	8b 45 14             	mov    0x14(%ebp),%eax
    1fe0:	01 d0                	add    %edx,%eax
    1fe2:	8d 50 ff             	lea    -0x1(%eax),%edx
    1fe5:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe8:	8b 40 0c             	mov    0xc(%eax),%eax
    1feb:	89 c1                	mov    %eax,%ecx
    1fed:	c1 e9 1f             	shr    $0x1f,%ecx
    1ff0:	01 c8                	add    %ecx,%eax
    1ff2:	d1 f8                	sar    %eax
    1ff4:	29 c2                	sub    %eax,%edx
    1ff6:	89 d0                	mov    %edx,%eax
    1ff8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1ffb:	8b 55 10             	mov    0x10(%ebp),%edx
    1ffe:	8b 45 18             	mov    0x18(%ebp),%eax
    2001:	01 d0                	add    %edx,%eax
    2003:	8d 50 ff             	lea    -0x1(%eax),%edx
    2006:	8b 45 08             	mov    0x8(%ebp),%eax
    2009:	8b 40 0c             	mov    0xc(%eax),%eax
    200c:	89 c1                	mov    %eax,%ecx
    200e:	c1 e9 1f             	shr    $0x1f,%ecx
    2011:	01 c8                	add    %ecx,%eax
    2013:	d1 f8                	sar    %eax
    2015:	29 c2                	sub    %eax,%edx
    2017:	89 d0                	mov    %edx,%eax
    2019:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    201c:	8b 45 08             	mov    0x8(%ebp),%eax
    201f:	8b 40 0c             	mov    0xc(%eax),%eax
    2022:	89 c2                	mov    %eax,%edx
    2024:	c1 ea 1f             	shr    $0x1f,%edx
    2027:	01 d0                	add    %edx,%eax
    2029:	d1 f8                	sar    %eax
    202b:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    202e:	8b 45 08             	mov    0x8(%ebp),%eax
    2031:	8b 40 0c             	mov    0xc(%eax),%eax
    2034:	89 c2                	mov    %eax,%edx
    2036:	c1 ea 1f             	shr    $0x1f,%edx
    2039:	01 d0                	add    %edx,%eax
    203b:	d1 f8                	sar    %eax
    203d:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    2040:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2044:	0f 88 d8 00 00 00    	js     2122 <APDrawRect+0x1ff>
    204a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    204e:	0f 88 ce 00 00 00    	js     2122 <APDrawRect+0x1ff>
    2054:	8b 45 08             	mov    0x8(%ebp),%eax
    2057:	8b 00                	mov    (%eax),%eax
    2059:	3b 45 0c             	cmp    0xc(%ebp),%eax
    205c:	0f 8e c0 00 00 00    	jle    2122 <APDrawRect+0x1ff>
    2062:	8b 45 08             	mov    0x8(%ebp),%eax
    2065:	8b 40 04             	mov    0x4(%eax),%eax
    2068:	3b 45 10             	cmp    0x10(%ebp),%eax
    206b:	0f 8e b1 00 00 00    	jle    2122 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    2071:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    2075:	79 07                	jns    207e <APDrawRect+0x15b>
    2077:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    207e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2082:	79 07                	jns    208b <APDrawRect+0x168>
    2084:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    208b:	8b 45 08             	mov    0x8(%ebp),%eax
    208e:	8b 00                	mov    (%eax),%eax
    2090:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2093:	7f 0b                	jg     20a0 <APDrawRect+0x17d>
    2095:	8b 45 08             	mov    0x8(%ebp),%eax
    2098:	8b 00                	mov    (%eax),%eax
    209a:	83 e8 01             	sub    $0x1,%eax
    209d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    20a0:	8b 45 08             	mov    0x8(%ebp),%eax
    20a3:	8b 40 04             	mov    0x4(%eax),%eax
    20a6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    20a9:	7f 0c                	jg     20b7 <APDrawRect+0x194>
    20ab:	8b 45 08             	mov    0x8(%ebp),%eax
    20ae:	8b 40 04             	mov    0x4(%eax),%eax
    20b1:	83 e8 01             	sub    $0x1,%eax
    20b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    20b7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    20be:	8b 45 0c             	mov    0xc(%ebp),%eax
    20c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    20c4:	eb 52                	jmp    2118 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    20c6:	8b 45 10             	mov    0x10(%ebp),%eax
    20c9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    20cc:	eb 3e                	jmp    210c <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    20ce:	83 ec 04             	sub    $0x4,%esp
    20d1:	ff 75 e8             	pushl  -0x18(%ebp)
    20d4:	ff 75 ec             	pushl  -0x14(%ebp)
    20d7:	ff 75 08             	pushl  0x8(%ebp)
    20da:	e8 c0 f6 ff ff       	call   179f <APGetIndex>
    20df:	83 c4 10             	add    $0x10,%esp
    20e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    20e5:	8b 45 08             	mov    0x8(%ebp),%eax
    20e8:	8b 48 18             	mov    0x18(%eax),%ecx
    20eb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    20ee:	89 d0                	mov    %edx,%eax
    20f0:	01 c0                	add    %eax,%eax
    20f2:	01 d0                	add    %edx,%eax
    20f4:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    20f7:	8b 45 08             	mov    0x8(%ebp),%eax
    20fa:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    20fe:	66 89 0a             	mov    %cx,(%edx)
    2101:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    2105:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    2108:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    210c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    210f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    2112:	7e ba                	jle    20ce <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    2114:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2118:	8b 45 ec             	mov    -0x14(%ebp),%eax
    211b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    211e:	7e a6                	jle    20c6 <APDrawRect+0x1a3>
    2120:	eb 01                	jmp    2123 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    2122:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    2123:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2126:	c9                   	leave  
    2127:	c3                   	ret    

00002128 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    2128:	55                   	push   %ebp
    2129:	89 e5                	mov    %esp,%ebp
    212b:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    212e:	83 ec 0c             	sub    $0xc,%esp
    2131:	ff 75 0c             	pushl  0xc(%ebp)
    2134:	e8 b1 ee ff ff       	call   fea <strlen>
    2139:	83 c4 10             	add    $0x10,%esp
    213c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    213f:	8b 45 08             	mov    0x8(%ebp),%eax
    2142:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    2146:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    214a:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    214e:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    2151:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    2158:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    215f:	e9 bc 00 00 00       	jmp    2220 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    2164:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2167:	8b 45 0c             	mov    0xc(%ebp),%eax
    216a:	01 d0                	add    %edx,%eax
    216c:	0f b6 00             	movzbl (%eax),%eax
    216f:	0f be c0             	movsbl %al,%eax
    2172:	83 e8 20             	sub    $0x20,%eax
    2175:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    2178:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    217c:	0f 87 9a 00 00 00    	ja     221c <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    2182:	8b 45 08             	mov    0x8(%ebp),%eax
    2185:	8b 00                	mov    (%eax),%eax
    2187:	0f af 45 14          	imul   0x14(%ebp),%eax
    218b:	89 c2                	mov    %eax,%edx
    218d:	8b 45 10             	mov    0x10(%ebp),%eax
    2190:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    2193:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2196:	89 d0                	mov    %edx,%eax
    2198:	c1 e0 03             	shl    $0x3,%eax
    219b:	01 d0                	add    %edx,%eax
    219d:	01 c8                	add    %ecx,%eax
    219f:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    21a2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    21a9:	eb 6b                	jmp    2216 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    21ab:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    21b2:	eb 50                	jmp    2204 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    21b4:	8b 55 ec             	mov    -0x14(%ebp),%edx
    21b7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    21ba:	89 d0                	mov    %edx,%eax
    21bc:	c1 e0 03             	shl    $0x3,%eax
    21bf:	01 d0                	add    %edx,%eax
    21c1:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    21c7:	01 c2                	add    %eax,%edx
    21c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    21cc:	01 d0                	add    %edx,%eax
    21ce:	05 20 3e 00 00       	add    $0x3e20,%eax
    21d3:	0f b6 00             	movzbl (%eax),%eax
    21d6:	84 c0                	test   %al,%al
    21d8:	74 26                	je     2200 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    21da:	8b 45 08             	mov    0x8(%ebp),%eax
    21dd:	8b 50 18             	mov    0x18(%eax),%edx
    21e0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    21e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    21e6:	01 c8                	add    %ecx,%eax
    21e8:	89 c1                	mov    %eax,%ecx
    21ea:	89 c8                	mov    %ecx,%eax
    21ec:	01 c0                	add    %eax,%eax
    21ee:	01 c8                	add    %ecx,%eax
    21f0:	01 d0                	add    %edx,%eax
    21f2:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    21f6:	66 89 10             	mov    %dx,(%eax)
    21f9:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    21fd:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    2200:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    2204:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    2208:	7e aa                	jle    21b4 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    220a:	8b 45 08             	mov    0x8(%ebp),%eax
    220d:	8b 00                	mov    (%eax),%eax
    220f:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    2212:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2216:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    221a:	7e 8f                	jle    21ab <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    221c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2220:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2223:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    2226:	0f 82 38 ff ff ff    	jb     2164 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    222c:	90                   	nop
    222d:	c9                   	leave  
    222e:	c3                   	ret    

0000222f <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    222f:	55                   	push   %ebp
    2230:	89 e5                	mov    %esp,%ebp
    2232:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    2235:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    2239:	0f 88 8e 01 00 00    	js     23cd <APDcCopy+0x19e>
    223f:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    2243:	0f 88 84 01 00 00    	js     23cd <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    2249:	8b 55 0c             	mov    0xc(%ebp),%edx
    224c:	8b 45 20             	mov    0x20(%ebp),%eax
    224f:	01 d0                	add    %edx,%eax
    2251:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2254:	8b 55 10             	mov    0x10(%ebp),%edx
    2257:	8b 45 24             	mov    0x24(%ebp),%eax
    225a:	01 d0                	add    %edx,%eax
    225c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    225f:	8b 55 18             	mov    0x18(%ebp),%edx
    2262:	8b 45 20             	mov    0x20(%ebp),%eax
    2265:	01 d0                	add    %edx,%eax
    2267:	89 45 ec             	mov    %eax,-0x14(%ebp)
    226a:	8b 55 1c             	mov    0x1c(%ebp),%edx
    226d:	8b 45 24             	mov    0x24(%ebp),%eax
    2270:	01 d0                	add    %edx,%eax
    2272:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    2275:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    2279:	0f 88 51 01 00 00    	js     23d0 <APDcCopy+0x1a1>
    227f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2283:	0f 88 47 01 00 00    	js     23d0 <APDcCopy+0x1a1>
    2289:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    228d:	0f 88 3d 01 00 00    	js     23d0 <APDcCopy+0x1a1>
    2293:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2297:	0f 88 33 01 00 00    	js     23d0 <APDcCopy+0x1a1>
    229d:	8b 45 14             	mov    0x14(%ebp),%eax
    22a0:	8b 00                	mov    (%eax),%eax
    22a2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    22a5:	0f 8c 25 01 00 00    	jl     23d0 <APDcCopy+0x1a1>
    22ab:	8b 45 14             	mov    0x14(%ebp),%eax
    22ae:	8b 40 04             	mov    0x4(%eax),%eax
    22b1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    22b4:	0f 8c 16 01 00 00    	jl     23d0 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    22ba:	8b 45 08             	mov    0x8(%ebp),%eax
    22bd:	8b 00                	mov    (%eax),%eax
    22bf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    22c2:	7f 0b                	jg     22cf <APDcCopy+0xa0>
    22c4:	8b 45 08             	mov    0x8(%ebp),%eax
    22c7:	8b 00                	mov    (%eax),%eax
    22c9:	83 e8 01             	sub    $0x1,%eax
    22cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    22cf:	8b 45 08             	mov    0x8(%ebp),%eax
    22d2:	8b 40 04             	mov    0x4(%eax),%eax
    22d5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    22d8:	7f 0c                	jg     22e6 <APDcCopy+0xb7>
    22da:	8b 45 08             	mov    0x8(%ebp),%eax
    22dd:	8b 40 04             	mov    0x4(%eax),%eax
    22e0:	83 e8 01             	sub    $0x1,%eax
    22e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    22e6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    22ed:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    22f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    22fb:	e9 bc 00 00 00       	jmp    23bc <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    2300:	8b 45 08             	mov    0x8(%ebp),%eax
    2303:	8b 00                	mov    (%eax),%eax
    2305:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2308:	8b 55 10             	mov    0x10(%ebp),%edx
    230b:	01 ca                	add    %ecx,%edx
    230d:	0f af d0             	imul   %eax,%edx
    2310:	8b 45 0c             	mov    0xc(%ebp),%eax
    2313:	01 d0                	add    %edx,%eax
    2315:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    2318:	8b 45 14             	mov    0x14(%ebp),%eax
    231b:	8b 00                	mov    (%eax),%eax
    231d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2320:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2323:	01 ca                	add    %ecx,%edx
    2325:	0f af d0             	imul   %eax,%edx
    2328:	8b 45 18             	mov    0x18(%ebp),%eax
    232b:	01 d0                	add    %edx,%eax
    232d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    2330:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2337:	eb 74                	jmp    23ad <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    2339:	8b 45 14             	mov    0x14(%ebp),%eax
    233c:	8b 50 18             	mov    0x18(%eax),%edx
    233f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    2342:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2345:	01 c8                	add    %ecx,%eax
    2347:	89 c1                	mov    %eax,%ecx
    2349:	89 c8                	mov    %ecx,%eax
    234b:	01 c0                	add    %eax,%eax
    234d:	01 c8                	add    %ecx,%eax
    234f:	01 d0                	add    %edx,%eax
    2351:	0f b7 10             	movzwl (%eax),%edx
    2354:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    2358:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    235c:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    235f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    2363:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    2367:	38 c2                	cmp    %al,%dl
    2369:	75 18                	jne    2383 <APDcCopy+0x154>
    236b:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    236f:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    2373:	38 c2                	cmp    %al,%dl
    2375:	75 0c                	jne    2383 <APDcCopy+0x154>
    2377:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    237b:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    237f:	38 c2                	cmp    %al,%dl
    2381:	74 26                	je     23a9 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    2383:	8b 45 08             	mov    0x8(%ebp),%eax
    2386:	8b 50 18             	mov    0x18(%eax),%edx
    2389:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    238c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    238f:	01 c8                	add    %ecx,%eax
    2391:	89 c1                	mov    %eax,%ecx
    2393:	89 c8                	mov    %ecx,%eax
    2395:	01 c0                	add    %eax,%eax
    2397:	01 c8                	add    %ecx,%eax
    2399:	01 d0                	add    %edx,%eax
    239b:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    239f:	66 89 10             	mov    %dx,(%eax)
    23a2:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    23a6:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    23a9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    23ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    23b0:	2b 45 0c             	sub    0xc(%ebp),%eax
    23b3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    23b6:	7d 81                	jge    2339 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    23b8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    23bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    23bf:	2b 45 10             	sub    0x10(%ebp),%eax
    23c2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    23c5:	0f 8d 35 ff ff ff    	jge    2300 <APDcCopy+0xd1>
    23cb:	eb 04                	jmp    23d1 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    23cd:	90                   	nop
    23ce:	eb 01                	jmp    23d1 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    23d0:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    23d1:	c9                   	leave  
    23d2:	c3                   	ret    

000023d3 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    23d3:	55                   	push   %ebp
    23d4:	89 e5                	mov    %esp,%ebp
    23d6:	83 ec 1c             	sub    $0x1c,%esp
    23d9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    23dc:	8b 55 10             	mov    0x10(%ebp),%edx
    23df:	8b 45 14             	mov    0x14(%ebp),%eax
    23e2:	88 4d ec             	mov    %cl,-0x14(%ebp)
    23e5:	88 55 e8             	mov    %dl,-0x18(%ebp)
    23e8:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    23eb:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    23ef:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    23f2:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    23f6:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    23f9:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    23fd:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    2400:	8b 45 08             	mov    0x8(%ebp),%eax
    2403:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    2407:	66 89 10             	mov    %dx,(%eax)
    240a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    240e:	88 50 02             	mov    %dl,0x2(%eax)
}
    2411:	8b 45 08             	mov    0x8(%ebp),%eax
    2414:	c9                   	leave  
    2415:	c2 04 00             	ret    $0x4

00002418 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    2418:	55                   	push   %ebp
    2419:	89 e5                	mov    %esp,%ebp
    241b:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    241e:	8b 45 08             	mov    0x8(%ebp),%eax
    2421:	8b 00                	mov    (%eax),%eax
    2423:	83 ec 08             	sub    $0x8,%esp
    2426:	8d 55 0c             	lea    0xc(%ebp),%edx
    2429:	52                   	push   %edx
    242a:	50                   	push   %eax
    242b:	e8 24 ee ff ff       	call   1254 <sendMessage>
    2430:	83 c4 10             	add    $0x10,%esp
}
    2433:	90                   	nop
    2434:	c9                   	leave  
    2435:	c3                   	ret    

00002436 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    2436:	55                   	push   %ebp
    2437:	89 e5                	mov    %esp,%ebp
    2439:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    243c:	83 ec 0c             	sub    $0xc,%esp
    243f:	68 98 00 00 00       	push   $0x98
    2444:	e8 f5 f1 ff ff       	call   163e <malloc>
    2449:	83 c4 10             	add    $0x10,%esp
    244c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    244f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2453:	75 15                	jne    246a <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    2455:	83 ec 04             	sub    $0x4,%esp
    2458:	ff 75 08             	pushl  0x8(%ebp)
    245b:	68 a8 35 00 00       	push   $0x35a8
    2460:	6a 01                	push   $0x1
    2462:	e8 04 ef ff ff       	call   136b <printf>
    2467:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    246a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    246d:	05 84 00 00 00       	add    $0x84,%eax
    2472:	83 ec 08             	sub    $0x8,%esp
    2475:	ff 75 08             	pushl  0x8(%ebp)
    2478:	50                   	push   %eax
    2479:	e8 fd ea ff ff       	call   f7b <strcpy>
    247e:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    2481:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2484:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    248b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    248e:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    2495:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2498:	8b 40 3c             	mov    0x3c(%eax),%eax
    249b:	89 c2                	mov    %eax,%edx
    249d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24a0:	8b 40 40             	mov    0x40(%eax),%eax
    24a3:	0f af d0             	imul   %eax,%edx
    24a6:	89 d0                	mov    %edx,%eax
    24a8:	01 c0                	add    %eax,%eax
    24aa:	01 d0                	add    %edx,%eax
    24ac:	83 ec 0c             	sub    $0xc,%esp
    24af:	50                   	push   %eax
    24b0:	e8 89 f1 ff ff       	call   163e <malloc>
    24b5:	83 c4 10             	add    $0x10,%esp
    24b8:	89 c2                	mov    %eax,%edx
    24ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24bd:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    24c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24c3:	8b 40 54             	mov    0x54(%eax),%eax
    24c6:	85 c0                	test   %eax,%eax
    24c8:	75 15                	jne    24df <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    24ca:	83 ec 04             	sub    $0x4,%esp
    24cd:	ff 75 08             	pushl  0x8(%ebp)
    24d0:	68 c8 35 00 00       	push   $0x35c8
    24d5:	6a 01                	push   $0x1
    24d7:	e8 8f ee ff ff       	call   136b <printf>
    24dc:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    24df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24e2:	8b 40 3c             	mov    0x3c(%eax),%eax
    24e5:	89 c2                	mov    %eax,%edx
    24e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24ea:	8b 40 40             	mov    0x40(%eax),%eax
    24ed:	0f af d0             	imul   %eax,%edx
    24f0:	89 d0                	mov    %edx,%eax
    24f2:	01 c0                	add    %eax,%eax
    24f4:	01 c2                	add    %eax,%edx
    24f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24f9:	8b 40 54             	mov    0x54(%eax),%eax
    24fc:	83 ec 04             	sub    $0x4,%esp
    24ff:	52                   	push   %edx
    2500:	68 ff ff ff 00       	push   $0xffffff
    2505:	50                   	push   %eax
    2506:	e8 06 eb ff ff       	call   1011 <memset>
    250b:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    250e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2511:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    2518:	e8 0f ed ff ff       	call   122c <getpid>
    251d:	89 c2                	mov    %eax,%edx
    251f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2522:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    2525:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2528:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    252f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2532:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    2539:	8b 45 f4             	mov    -0xc(%ebp),%eax
    253c:	8b 40 58             	mov    0x58(%eax),%eax
    253f:	89 c2                	mov    %eax,%edx
    2541:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2544:	8b 40 5c             	mov    0x5c(%eax),%eax
    2547:	0f af d0             	imul   %eax,%edx
    254a:	89 d0                	mov    %edx,%eax
    254c:	01 c0                	add    %eax,%eax
    254e:	01 d0                	add    %edx,%eax
    2550:	83 ec 0c             	sub    $0xc,%esp
    2553:	50                   	push   %eax
    2554:	e8 e5 f0 ff ff       	call   163e <malloc>
    2559:	83 c4 10             	add    $0x10,%esp
    255c:	89 c2                	mov    %eax,%edx
    255e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2561:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    2564:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2567:	8b 40 70             	mov    0x70(%eax),%eax
    256a:	85 c0                	test   %eax,%eax
    256c:	75 15                	jne    2583 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    256e:	83 ec 04             	sub    $0x4,%esp
    2571:	ff 75 08             	pushl  0x8(%ebp)
    2574:	68 ec 35 00 00       	push   $0x35ec
    2579:	6a 01                	push   $0x1
    257b:	e8 eb ed ff ff       	call   136b <printf>
    2580:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    2583:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2586:	8b 40 3c             	mov    0x3c(%eax),%eax
    2589:	89 c2                	mov    %eax,%edx
    258b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    258e:	8b 40 40             	mov    0x40(%eax),%eax
    2591:	0f af d0             	imul   %eax,%edx
    2594:	89 d0                	mov    %edx,%eax
    2596:	01 c0                	add    %eax,%eax
    2598:	01 c2                	add    %eax,%edx
    259a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    259d:	8b 40 54             	mov    0x54(%eax),%eax
    25a0:	83 ec 04             	sub    $0x4,%esp
    25a3:	52                   	push   %edx
    25a4:	68 ff 00 00 00       	push   $0xff
    25a9:	50                   	push   %eax
    25aa:	e8 62 ea ff ff       	call   1011 <memset>
    25af:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    25b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25b5:	8b 55 0c             	mov    0xc(%ebp),%edx
    25b8:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    25bb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    25bf:	74 49                	je     260a <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    25c1:	8b 45 10             	mov    0x10(%ebp),%eax
    25c4:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    25ca:	83 ec 0c             	sub    $0xc,%esp
    25cd:	50                   	push   %eax
    25ce:	e8 6b f0 ff ff       	call   163e <malloc>
    25d3:	83 c4 10             	add    $0x10,%esp
    25d6:	89 c2                	mov    %eax,%edx
    25d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25db:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    25de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25e1:	8b 55 10             	mov    0x10(%ebp),%edx
    25e4:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    25e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25ea:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    25f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25f4:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    25fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25fe:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    2605:	e9 8d 00 00 00       	jmp    2697 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    260a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    260d:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    2614:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2617:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    261e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2621:	8b 40 20             	mov    0x20(%eax),%eax
    2624:	89 c2                	mov    %eax,%edx
    2626:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2629:	8b 40 24             	mov    0x24(%eax),%eax
    262c:	0f af d0             	imul   %eax,%edx
    262f:	89 d0                	mov    %edx,%eax
    2631:	01 c0                	add    %eax,%eax
    2633:	01 d0                	add    %edx,%eax
    2635:	83 ec 0c             	sub    $0xc,%esp
    2638:	50                   	push   %eax
    2639:	e8 00 f0 ff ff       	call   163e <malloc>
    263e:	83 c4 10             	add    $0x10,%esp
    2641:	89 c2                	mov    %eax,%edx
    2643:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2646:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    2649:	8b 45 f4             	mov    -0xc(%ebp),%eax
    264c:	8b 40 38             	mov    0x38(%eax),%eax
    264f:	85 c0                	test   %eax,%eax
    2651:	75 15                	jne    2668 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    2653:	83 ec 04             	sub    $0x4,%esp
    2656:	ff 75 08             	pushl  0x8(%ebp)
    2659:	68 14 36 00 00       	push   $0x3614
    265e:	6a 01                	push   $0x1
    2660:	e8 06 ed ff ff       	call   136b <printf>
    2665:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    2668:	8b 45 f4             	mov    -0xc(%ebp),%eax
    266b:	8b 40 20             	mov    0x20(%eax),%eax
    266e:	89 c2                	mov    %eax,%edx
    2670:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2673:	8b 40 24             	mov    0x24(%eax),%eax
    2676:	0f af d0             	imul   %eax,%edx
    2679:	89 d0                	mov    %edx,%eax
    267b:	01 c0                	add    %eax,%eax
    267d:	01 c2                	add    %eax,%edx
    267f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2682:	8b 40 38             	mov    0x38(%eax),%eax
    2685:	83 ec 04             	sub    $0x4,%esp
    2688:	52                   	push   %edx
    2689:	68 ff ff ff 00       	push   $0xffffff
    268e:	50                   	push   %eax
    268f:	e8 7d e9 ff ff       	call   1011 <memset>
    2694:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    2697:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    269a:	c9                   	leave  
    269b:	c3                   	ret    

0000269c <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    269c:	55                   	push   %ebp
    269d:	89 e5                	mov    %esp,%ebp
    269f:	57                   	push   %edi
    26a0:	56                   	push   %esi
    26a1:	53                   	push   %ebx
    26a2:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    26a5:	8b 45 0c             	mov    0xc(%ebp),%eax
    26a8:	83 f8 03             	cmp    $0x3,%eax
    26ab:	74 02                	je     26af <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    26ad:	eb 7c                	jmp    272b <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    26af:	8b 45 08             	mov    0x8(%ebp),%eax
    26b2:	8b 58 1c             	mov    0x1c(%eax),%ebx
    26b5:	8b 45 08             	mov    0x8(%ebp),%eax
    26b8:	8b 48 18             	mov    0x18(%eax),%ecx
    26bb:	8b 45 08             	mov    0x8(%ebp),%eax
    26be:	8b 50 5c             	mov    0x5c(%eax),%edx
    26c1:	8b 45 08             	mov    0x8(%ebp),%eax
    26c4:	8b 40 58             	mov    0x58(%eax),%eax
    26c7:	8b 75 08             	mov    0x8(%ebp),%esi
    26ca:	83 c6 58             	add    $0x58,%esi
    26cd:	83 ec 04             	sub    $0x4,%esp
    26d0:	53                   	push   %ebx
    26d1:	51                   	push   %ecx
    26d2:	6a 00                	push   $0x0
    26d4:	52                   	push   %edx
    26d5:	50                   	push   %eax
    26d6:	6a 00                	push   $0x0
    26d8:	6a 00                	push   $0x0
    26da:	56                   	push   %esi
    26db:	6a 00                	push   $0x0
    26dd:	6a 00                	push   $0x0
    26df:	ff 75 08             	pushl  0x8(%ebp)
    26e2:	e8 65 eb ff ff       	call   124c <paintWindow>
    26e7:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    26ea:	8b 45 08             	mov    0x8(%ebp),%eax
    26ed:	8b 70 1c             	mov    0x1c(%eax),%esi
    26f0:	8b 45 08             	mov    0x8(%ebp),%eax
    26f3:	8b 58 18             	mov    0x18(%eax),%ebx
    26f6:	8b 45 08             	mov    0x8(%ebp),%eax
    26f9:	8b 48 08             	mov    0x8(%eax),%ecx
    26fc:	8b 45 08             	mov    0x8(%ebp),%eax
    26ff:	8b 50 40             	mov    0x40(%eax),%edx
    2702:	8b 45 08             	mov    0x8(%ebp),%eax
    2705:	8b 40 3c             	mov    0x3c(%eax),%eax
    2708:	8b 7d 08             	mov    0x8(%ebp),%edi
    270b:	83 c7 3c             	add    $0x3c,%edi
    270e:	83 ec 04             	sub    $0x4,%esp
    2711:	56                   	push   %esi
    2712:	53                   	push   %ebx
    2713:	51                   	push   %ecx
    2714:	52                   	push   %edx
    2715:	50                   	push   %eax
    2716:	6a 00                	push   $0x0
    2718:	6a 00                	push   $0x0
    271a:	57                   	push   %edi
    271b:	6a 32                	push   $0x32
    271d:	6a 00                	push   $0x0
    271f:	ff 75 08             	pushl  0x8(%ebp)
    2722:	e8 25 eb ff ff       	call   124c <paintWindow>
    2727:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    272a:	90                   	nop
        default: break;
            
            
    }
    return False;
    272b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2730:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2733:	5b                   	pop    %ebx
    2734:	5e                   	pop    %esi
    2735:	5f                   	pop    %edi
    2736:	5d                   	pop    %ebp
    2737:	c3                   	ret    

00002738 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    2738:	55                   	push   %ebp
    2739:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    273b:	8b 45 0c             	mov    0xc(%ebp),%eax
    273e:	8b 50 08             	mov    0x8(%eax),%edx
    2741:	8b 45 08             	mov    0x8(%ebp),%eax
    2744:	8b 00                	mov    (%eax),%eax
    2746:	39 c2                	cmp    %eax,%edx
    2748:	74 07                	je     2751 <APPreJudge+0x19>
        return False;
    274a:	b8 00 00 00 00       	mov    $0x0,%eax
    274f:	eb 05                	jmp    2756 <APPreJudge+0x1e>
    return True;
    2751:	b8 01 00 00 00       	mov    $0x1,%eax
}
    2756:	5d                   	pop    %ebp
    2757:	c3                   	ret    

00002758 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    2758:	55                   	push   %ebp
    2759:	89 e5                	mov    %esp,%ebp
    275b:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    275e:	8b 45 08             	mov    0x8(%ebp),%eax
    2761:	8b 55 0c             	mov    0xc(%ebp),%edx
    2764:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    276a:	83 ec 0c             	sub    $0xc,%esp
    276d:	ff 75 08             	pushl  0x8(%ebp)
    2770:	e8 ef ea ff ff       	call   1264 <registWindow>
    2775:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    2778:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    277f:	8b 45 08             	mov    0x8(%ebp),%eax
    2782:	8b 00                	mov    (%eax),%eax
    2784:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    2787:	ff 75 f4             	pushl  -0xc(%ebp)
    278a:	ff 75 f0             	pushl  -0x10(%ebp)
    278d:	ff 75 ec             	pushl  -0x14(%ebp)
    2790:	ff 75 08             	pushl  0x8(%ebp)
    2793:	e8 80 fc ff ff       	call   2418 <APSendMessage>
    2798:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    279b:	83 ec 0c             	sub    $0xc,%esp
    279e:	ff 75 08             	pushl  0x8(%ebp)
    27a1:	e8 b6 ea ff ff       	call   125c <getMessage>
    27a6:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    27a9:	8b 45 08             	mov    0x8(%ebp),%eax
    27ac:	83 c0 74             	add    $0x74,%eax
    27af:	83 ec 08             	sub    $0x8,%esp
    27b2:	50                   	push   %eax
    27b3:	ff 75 08             	pushl  0x8(%ebp)
    27b6:	e8 7d ff ff ff       	call   2738 <APPreJudge>
    27bb:	83 c4 10             	add    $0x10,%esp
    27be:	84 c0                	test   %al,%al
    27c0:	74 1b                	je     27dd <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    27c2:	8b 45 08             	mov    0x8(%ebp),%eax
    27c5:	ff 70 7c             	pushl  0x7c(%eax)
    27c8:	ff 70 78             	pushl  0x78(%eax)
    27cb:	ff 70 74             	pushl  0x74(%eax)
    27ce:	ff 75 08             	pushl  0x8(%ebp)
    27d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    27d4:	ff d0                	call   *%eax
    27d6:	83 c4 10             	add    $0x10,%esp
    27d9:	84 c0                	test   %al,%al
    27db:	75 0c                	jne    27e9 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    27dd:	8b 45 08             	mov    0x8(%ebp),%eax
    27e0:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    27e7:	eb b2                	jmp    279b <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    27e9:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    27ea:	90                   	nop
    27eb:	c9                   	leave  
    27ec:	c3                   	ret    

000027ed <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    27ed:	55                   	push   %ebp
    27ee:	89 e5                	mov    %esp,%ebp
    27f0:	57                   	push   %edi
    27f1:	56                   	push   %esi
    27f2:	53                   	push   %ebx
    27f3:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    27f6:	a1 70 7a 00 00       	mov    0x7a70,%eax
    27fb:	85 c0                	test   %eax,%eax
    27fd:	0f 85 7a 02 00 00    	jne    2a7d <APGridPaint+0x290>
    {
        iconReady = 1;
    2803:	c7 05 70 7a 00 00 01 	movl   $0x1,0x7a70
    280a:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    280d:	8d 45 88             	lea    -0x78(%ebp),%eax
    2810:	83 ec 08             	sub    $0x8,%esp
    2813:	68 3b 36 00 00       	push   $0x363b
    2818:	50                   	push   %eax
    2819:	e8 d3 ef ff ff       	call   17f1 <APLoadBitmap>
    281e:	83 c4 0c             	add    $0xc,%esp
    2821:	8b 45 88             	mov    -0x78(%ebp),%eax
    2824:	a3 bc 7a 00 00       	mov    %eax,0x7abc
    2829:	8b 45 8c             	mov    -0x74(%ebp),%eax
    282c:	a3 c0 7a 00 00       	mov    %eax,0x7ac0
    2831:	8b 45 90             	mov    -0x70(%ebp),%eax
    2834:	a3 c4 7a 00 00       	mov    %eax,0x7ac4
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    2839:	83 ec 04             	sub    $0x4,%esp
    283c:	ff 35 c4 7a 00 00    	pushl  0x7ac4
    2842:	ff 35 c0 7a 00 00    	pushl  0x7ac0
    2848:	ff 35 bc 7a 00 00    	pushl  0x7abc
    284e:	e8 d8 f1 ff ff       	call   1a2b <APCreateCompatibleDCFromBitmap>
    2853:	83 c4 10             	add    $0x10,%esp
    2856:	a3 c8 7a 00 00       	mov    %eax,0x7ac8
        grid_river = APLoadBitmap ("grid_river.bmp");
    285b:	8d 45 88             	lea    -0x78(%ebp),%eax
    285e:	83 ec 08             	sub    $0x8,%esp
    2861:	68 49 36 00 00       	push   $0x3649
    2866:	50                   	push   %eax
    2867:	e8 85 ef ff ff       	call   17f1 <APLoadBitmap>
    286c:	83 c4 0c             	add    $0xc,%esp
    286f:	8b 45 88             	mov    -0x78(%ebp),%eax
    2872:	a3 04 7b 00 00       	mov    %eax,0x7b04
    2877:	8b 45 8c             	mov    -0x74(%ebp),%eax
    287a:	a3 08 7b 00 00       	mov    %eax,0x7b08
    287f:	8b 45 90             	mov    -0x70(%ebp),%eax
    2882:	a3 0c 7b 00 00       	mov    %eax,0x7b0c
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    2887:	83 ec 04             	sub    $0x4,%esp
    288a:	ff 35 0c 7b 00 00    	pushl  0x7b0c
    2890:	ff 35 08 7b 00 00    	pushl  0x7b08
    2896:	ff 35 04 7b 00 00    	pushl  0x7b04
    289c:	e8 8a f1 ff ff       	call   1a2b <APCreateCompatibleDCFromBitmap>
    28a1:	83 c4 10             	add    $0x10,%esp
    28a4:	a3 f4 7a 00 00       	mov    %eax,0x7af4
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    28a9:	8d 45 88             	lea    -0x78(%ebp),%eax
    28ac:	83 ec 08             	sub    $0x8,%esp
    28af:	68 58 36 00 00       	push   $0x3658
    28b4:	50                   	push   %eax
    28b5:	e8 37 ef ff ff       	call   17f1 <APLoadBitmap>
    28ba:	83 c4 0c             	add    $0xc,%esp
    28bd:	8b 45 88             	mov    -0x78(%ebp),%eax
    28c0:	a3 f8 7a 00 00       	mov    %eax,0x7af8
    28c5:	8b 45 8c             	mov    -0x74(%ebp),%eax
    28c8:	a3 fc 7a 00 00       	mov    %eax,0x7afc
    28cd:	8b 45 90             	mov    -0x70(%ebp),%eax
    28d0:	a3 00 7b 00 00       	mov    %eax,0x7b00
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    28d5:	83 ec 04             	sub    $0x4,%esp
    28d8:	ff 35 00 7b 00 00    	pushl  0x7b00
    28de:	ff 35 fc 7a 00 00    	pushl  0x7afc
    28e4:	ff 35 f8 7a 00 00    	pushl  0x7af8
    28ea:	e8 3c f1 ff ff       	call   1a2b <APCreateCompatibleDCFromBitmap>
    28ef:	83 c4 10             	add    $0x10,%esp
    28f2:	a3 88 7a 00 00       	mov    %eax,0x7a88
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    28f7:	8d 45 88             	lea    -0x78(%ebp),%eax
    28fa:	83 ec 08             	sub    $0x8,%esp
    28fd:	68 67 36 00 00       	push   $0x3667
    2902:	50                   	push   %eax
    2903:	e8 e9 ee ff ff       	call   17f1 <APLoadBitmap>
    2908:	83 c4 0c             	add    $0xc,%esp
    290b:	8b 45 88             	mov    -0x78(%ebp),%eax
    290e:	a3 d0 7a 00 00       	mov    %eax,0x7ad0
    2913:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2916:	a3 d4 7a 00 00       	mov    %eax,0x7ad4
    291b:	8b 45 90             	mov    -0x70(%ebp),%eax
    291e:	a3 d8 7a 00 00       	mov    %eax,0x7ad8
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    2923:	83 ec 04             	sub    $0x4,%esp
    2926:	ff 35 d8 7a 00 00    	pushl  0x7ad8
    292c:	ff 35 d4 7a 00 00    	pushl  0x7ad4
    2932:	ff 35 d0 7a 00 00    	pushl  0x7ad0
    2938:	e8 ee f0 ff ff       	call   1a2b <APCreateCompatibleDCFromBitmap>
    293d:	83 c4 10             	add    $0x10,%esp
    2940:	a3 14 7b 00 00       	mov    %eax,0x7b14
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    2945:	8d 45 88             	lea    -0x78(%ebp),%eax
    2948:	83 ec 08             	sub    $0x8,%esp
    294b:	68 75 36 00 00       	push   $0x3675
    2950:	50                   	push   %eax
    2951:	e8 9b ee ff ff       	call   17f1 <APLoadBitmap>
    2956:	83 c4 0c             	add    $0xc,%esp
    2959:	8b 45 88             	mov    -0x78(%ebp),%eax
    295c:	a3 ac 7a 00 00       	mov    %eax,0x7aac
    2961:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2964:	a3 b0 7a 00 00       	mov    %eax,0x7ab0
    2969:	8b 45 90             	mov    -0x70(%ebp),%eax
    296c:	a3 b4 7a 00 00       	mov    %eax,0x7ab4
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    2971:	83 ec 04             	sub    $0x4,%esp
    2974:	ff 35 b4 7a 00 00    	pushl  0x7ab4
    297a:	ff 35 b0 7a 00 00    	pushl  0x7ab0
    2980:	ff 35 ac 7a 00 00    	pushl  0x7aac
    2986:	e8 a0 f0 ff ff       	call   1a2b <APCreateCompatibleDCFromBitmap>
    298b:	83 c4 10             	add    $0x10,%esp
    298e:	a3 cc 7a 00 00       	mov    %eax,0x7acc
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    2993:	8d 45 88             	lea    -0x78(%ebp),%eax
    2996:	83 ec 08             	sub    $0x8,%esp
    2999:	68 85 36 00 00       	push   $0x3685
    299e:	50                   	push   %eax
    299f:	e8 4d ee ff ff       	call   17f1 <APLoadBitmap>
    29a4:	83 c4 0c             	add    $0xc,%esp
    29a7:	8b 45 88             	mov    -0x78(%ebp),%eax
    29aa:	a3 90 7a 00 00       	mov    %eax,0x7a90
    29af:	8b 45 8c             	mov    -0x74(%ebp),%eax
    29b2:	a3 94 7a 00 00       	mov    %eax,0x7a94
    29b7:	8b 45 90             	mov    -0x70(%ebp),%eax
    29ba:	a3 98 7a 00 00       	mov    %eax,0x7a98
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    29bf:	83 ec 04             	sub    $0x4,%esp
    29c2:	ff 35 98 7a 00 00    	pushl  0x7a98
    29c8:	ff 35 94 7a 00 00    	pushl  0x7a94
    29ce:	ff 35 90 7a 00 00    	pushl  0x7a90
    29d4:	e8 52 f0 ff ff       	call   1a2b <APCreateCompatibleDCFromBitmap>
    29d9:	83 c4 10             	add    $0x10,%esp
    29dc:	a3 b8 7a 00 00       	mov    %eax,0x7ab8
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    29e1:	8d 45 88             	lea    -0x78(%ebp),%eax
    29e4:	83 ec 08             	sub    $0x8,%esp
    29e7:	68 97 36 00 00       	push   $0x3697
    29ec:	50                   	push   %eax
    29ed:	e8 ff ed ff ff       	call   17f1 <APLoadBitmap>
    29f2:	83 c4 0c             	add    $0xc,%esp
    29f5:	8b 45 88             	mov    -0x78(%ebp),%eax
    29f8:	a3 e8 7a 00 00       	mov    %eax,0x7ae8
    29fd:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2a00:	a3 ec 7a 00 00       	mov    %eax,0x7aec
    2a05:	8b 45 90             	mov    -0x70(%ebp),%eax
    2a08:	a3 f0 7a 00 00       	mov    %eax,0x7af0
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    2a0d:	83 ec 04             	sub    $0x4,%esp
    2a10:	ff 35 f0 7a 00 00    	pushl  0x7af0
    2a16:	ff 35 ec 7a 00 00    	pushl  0x7aec
    2a1c:	ff 35 e8 7a 00 00    	pushl  0x7ae8
    2a22:	e8 04 f0 ff ff       	call   1a2b <APCreateCompatibleDCFromBitmap>
    2a27:	83 c4 10             	add    $0x10,%esp
    2a2a:	a3 dc 7f 00 00       	mov    %eax,0x7fdc
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    2a2f:	8d 45 88             	lea    -0x78(%ebp),%eax
    2a32:	83 ec 08             	sub    $0x8,%esp
    2a35:	68 a6 36 00 00       	push   $0x36a6
    2a3a:	50                   	push   %eax
    2a3b:	e8 b1 ed ff ff       	call   17f1 <APLoadBitmap>
    2a40:	83 c4 0c             	add    $0xc,%esp
    2a43:	8b 45 88             	mov    -0x78(%ebp),%eax
    2a46:	a3 dc 7a 00 00       	mov    %eax,0x7adc
    2a4b:	8b 45 8c             	mov    -0x74(%ebp),%eax
    2a4e:	a3 e0 7a 00 00       	mov    %eax,0x7ae0
    2a53:	8b 45 90             	mov    -0x70(%ebp),%eax
    2a56:	a3 e4 7a 00 00       	mov    %eax,0x7ae4
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    2a5b:	83 ec 04             	sub    $0x4,%esp
    2a5e:	ff 35 e4 7a 00 00    	pushl  0x7ae4
    2a64:	ff 35 e0 7a 00 00    	pushl  0x7ae0
    2a6a:	ff 35 dc 7a 00 00    	pushl  0x7adc
    2a70:	e8 b6 ef ff ff       	call   1a2b <APCreateCompatibleDCFromBitmap>
    2a75:	83 c4 10             	add    $0x10,%esp
    2a78:	a3 10 7b 00 00       	mov    %eax,0x7b10
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    2a7d:	8b 45 08             	mov    0x8(%ebp),%eax
    2a80:	8b 40 08             	mov    0x8(%eax),%eax
    2a83:	85 c0                	test   %eax,%eax
    2a85:	75 17                	jne    2a9e <APGridPaint+0x2b1>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    2a87:	83 ec 08             	sub    $0x8,%esp
    2a8a:	68 b8 36 00 00       	push   $0x36b8
    2a8f:	6a 01                	push   $0x1
    2a91:	e8 d5 e8 ff ff       	call   136b <printf>
    2a96:	83 c4 10             	add    $0x10,%esp
        return;
    2a99:	e9 65 05 00 00       	jmp    3003 <APGridPaint+0x816>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    2a9e:	8b 45 08             	mov    0x8(%ebp),%eax
    2aa1:	8b 40 10             	mov    0x10(%eax),%eax
    2aa4:	85 c0                	test   %eax,%eax
    2aa6:	7e 10                	jle    2ab8 <APGridPaint+0x2cb>
    2aa8:	8b 45 08             	mov    0x8(%ebp),%eax
    2aab:	8b 50 14             	mov    0x14(%eax),%edx
    2aae:	8b 45 08             	mov    0x8(%ebp),%eax
    2ab1:	8b 40 10             	mov    0x10(%eax),%eax
    2ab4:	39 c2                	cmp    %eax,%edx
    2ab6:	7c 17                	jl     2acf <APGridPaint+0x2e2>
    {
        printf(1,"Grid mode page error!");
    2ab8:	83 ec 08             	sub    $0x8,%esp
    2abb:	68 de 36 00 00       	push   $0x36de
    2ac0:	6a 01                	push   $0x1
    2ac2:	e8 a4 e8 ff ff       	call   136b <printf>
    2ac7:	83 c4 10             	add    $0x10,%esp
        return;
    2aca:	e9 34 05 00 00       	jmp    3003 <APGridPaint+0x816>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    2acf:	8b 45 08             	mov    0x8(%ebp),%eax
    2ad2:	8b 40 14             	mov    0x14(%eax),%eax
    2ad5:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    2adb:	89 45 dc             	mov    %eax,-0x24(%ebp)
    2ade:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2ae1:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2ae4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    2aeb:	e9 f4 03 00 00       	jmp    2ee4 <APGridPaint+0x6f7>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2af0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    2af7:	e9 da 03 00 00       	jmp    2ed6 <APGridPaint+0x6e9>
        {
            index = start + GRID_W_NUMBER * j + i;
    2afc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2aff:	c1 e0 04             	shl    $0x4,%eax
    2b02:	89 c2                	mov    %eax,%edx
    2b04:	8b 45 d8             	mov    -0x28(%ebp),%eax
    2b07:	01 c2                	add    %eax,%edx
    2b09:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2b0c:	01 d0                	add    %edx,%eax
    2b0e:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    2b11:	8b 45 08             	mov    0x8(%ebp),%eax
    2b14:	8b 40 0c             	mov    0xc(%eax),%eax
    2b17:	8b 55 dc             	mov    -0x24(%ebp),%edx
    2b1a:	c1 e2 02             	shl    $0x2,%edx
    2b1d:	01 d0                	add    %edx,%eax
    2b1f:	8b 00                	mov    (%eax),%eax
    2b21:	83 f8 0a             	cmp    $0xa,%eax
    2b24:	0f 87 a7 03 00 00    	ja     2ed1 <APGridPaint+0x6e4>
    2b2a:	8b 04 85 f4 36 00 00 	mov    0x36f4(,%eax,4),%eax
    2b31:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2b33:	8d 45 c0             	lea    -0x40(%ebp),%eax
    2b36:	6a 0c                	push   $0xc
    2b38:	6a 0c                	push   $0xc
    2b3a:	6a 0c                	push   $0xc
    2b3c:	50                   	push   %eax
    2b3d:	e8 91 f8 ff ff       	call   23d3 <RGB>
    2b42:	83 c4 0c             	add    $0xc,%esp
    2b45:	8b 1d c8 7a 00 00    	mov    0x7ac8,%ebx
    2b4b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2b4e:	6b c8 32             	imul   $0x32,%eax,%ecx
    2b51:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2b54:	6b c0 32             	imul   $0x32,%eax,%eax
    2b57:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2b5a:	8b 45 08             	mov    0x8(%ebp),%eax
    2b5d:	8d 78 3c             	lea    0x3c(%eax),%edi
    2b60:	83 ec 0c             	sub    $0xc,%esp
    2b63:	83 ec 04             	sub    $0x4,%esp
    2b66:	89 e0                	mov    %esp,%eax
    2b68:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    2b6c:	66 89 30             	mov    %si,(%eax)
    2b6f:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    2b73:	88 50 02             	mov    %dl,0x2(%eax)
    2b76:	6a 32                	push   $0x32
    2b78:	6a 32                	push   $0x32
    2b7a:	6a 00                	push   $0x0
    2b7c:	6a 00                	push   $0x0
    2b7e:	53                   	push   %ebx
    2b7f:	51                   	push   %ecx
    2b80:	ff 75 84             	pushl  -0x7c(%ebp)
    2b83:	57                   	push   %edi
    2b84:	e8 a6 f6 ff ff       	call   222f <APDcCopy>
    2b89:	83 c4 30             	add    $0x30,%esp
                    break;
    2b8c:	e9 41 03 00 00       	jmp    2ed2 <APGridPaint+0x6e5>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    2b91:	8d 45 88             	lea    -0x78(%ebp),%eax
    2b94:	6a 69                	push   $0x69
    2b96:	6a 69                	push   $0x69
    2b98:	6a 69                	push   $0x69
    2b9a:	50                   	push   %eax
    2b9b:	e8 33 f8 ff ff       	call   23d3 <RGB>
    2ba0:	83 c4 0c             	add    $0xc,%esp
    2ba3:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2ba7:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    2bab:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2baf:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    2bb2:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    2bb9:	8d 45 88             	lea    -0x78(%ebp),%eax
    2bbc:	6a 69                	push   $0x69
    2bbe:	6a 69                	push   $0x69
    2bc0:	6a 69                	push   $0x69
    2bc2:	50                   	push   %eax
    2bc3:	e8 0b f8 ff ff       	call   23d3 <RGB>
    2bc8:	83 c4 0c             	add    $0xc,%esp
    2bcb:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2bcf:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    2bd3:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2bd7:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    2bda:	8b 45 08             	mov    0x8(%ebp),%eax
    2bdd:	8d 50 3c             	lea    0x3c(%eax),%edx
    2be0:	8d 45 88             	lea    -0x78(%ebp),%eax
    2be3:	ff 75 ac             	pushl  -0x54(%ebp)
    2be6:	ff 75 a8             	pushl  -0x58(%ebp)
    2be9:	52                   	push   %edx
    2bea:	50                   	push   %eax
    2beb:	e8 d0 ee ff ff       	call   1ac0 <APSetPen>
    2bf0:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    2bf3:	8b 45 08             	mov    0x8(%ebp),%eax
    2bf6:	8d 58 3c             	lea    0x3c(%eax),%ebx
    2bf9:	8d 55 88             	lea    -0x78(%ebp),%edx
    2bfc:	83 ec 04             	sub    $0x4,%esp
    2bff:	83 ec 04             	sub    $0x4,%esp
    2c02:	89 e0                	mov    %esp,%eax
    2c04:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    2c08:	66 89 08             	mov    %cx,(%eax)
    2c0b:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    2c0f:	88 48 02             	mov    %cl,0x2(%eax)
    2c12:	53                   	push   %ebx
    2c13:	52                   	push   %edx
    2c14:	e8 e0 ee ff ff       	call   1af9 <APSetBrush>
    2c19:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    2c1c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2c1f:	6b d0 32             	imul   $0x32,%eax,%edx
    2c22:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2c25:	6b c0 32             	imul   $0x32,%eax,%eax
    2c28:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2c2b:	83 c1 3c             	add    $0x3c,%ecx
    2c2e:	83 ec 0c             	sub    $0xc,%esp
    2c31:	6a 32                	push   $0x32
    2c33:	6a 32                	push   $0x32
    2c35:	52                   	push   %edx
    2c36:	50                   	push   %eax
    2c37:	51                   	push   %ecx
    2c38:	e8 e6 f2 ff ff       	call   1f23 <APDrawRect>
    2c3d:	83 c4 20             	add    $0x20,%esp
                    break;
    2c40:	e9 8d 02 00 00       	jmp    2ed2 <APGridPaint+0x6e5>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2c45:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    2c48:	6a 0c                	push   $0xc
    2c4a:	6a 0c                	push   $0xc
    2c4c:	6a 0c                	push   $0xc
    2c4e:	50                   	push   %eax
    2c4f:	e8 7f f7 ff ff       	call   23d3 <RGB>
    2c54:	83 c4 0c             	add    $0xc,%esp
    2c57:	8b 1d dc 7f 00 00    	mov    0x7fdc,%ebx
    2c5d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2c60:	6b c8 32             	imul   $0x32,%eax,%ecx
    2c63:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2c66:	6b c0 32             	imul   $0x32,%eax,%eax
    2c69:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2c6c:	8b 45 08             	mov    0x8(%ebp),%eax
    2c6f:	8d 78 3c             	lea    0x3c(%eax),%edi
    2c72:	83 ec 0c             	sub    $0xc,%esp
    2c75:	83 ec 04             	sub    $0x4,%esp
    2c78:	89 e0                	mov    %esp,%eax
    2c7a:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    2c7e:	66 89 30             	mov    %si,(%eax)
    2c81:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    2c85:	88 50 02             	mov    %dl,0x2(%eax)
    2c88:	6a 32                	push   $0x32
    2c8a:	6a 32                	push   $0x32
    2c8c:	6a 00                	push   $0x0
    2c8e:	6a 00                	push   $0x0
    2c90:	53                   	push   %ebx
    2c91:	51                   	push   %ecx
    2c92:	ff 75 84             	pushl  -0x7c(%ebp)
    2c95:	57                   	push   %edi
    2c96:	e8 94 f5 ff ff       	call   222f <APDcCopy>
    2c9b:	83 c4 30             	add    $0x30,%esp
                    break;
    2c9e:	e9 2f 02 00 00       	jmp    2ed2 <APGridPaint+0x6e5>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2ca3:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    2ca6:	6a 0c                	push   $0xc
    2ca8:	6a 0c                	push   $0xc
    2caa:	6a 0c                	push   $0xc
    2cac:	50                   	push   %eax
    2cad:	e8 21 f7 ff ff       	call   23d3 <RGB>
    2cb2:	83 c4 0c             	add    $0xc,%esp
    2cb5:	8b 1d f4 7a 00 00    	mov    0x7af4,%ebx
    2cbb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2cbe:	6b c8 32             	imul   $0x32,%eax,%ecx
    2cc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2cc4:	6b c0 32             	imul   $0x32,%eax,%eax
    2cc7:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2cca:	8b 45 08             	mov    0x8(%ebp),%eax
    2ccd:	8d 78 3c             	lea    0x3c(%eax),%edi
    2cd0:	83 ec 0c             	sub    $0xc,%esp
    2cd3:	83 ec 04             	sub    $0x4,%esp
    2cd6:	89 e0                	mov    %esp,%eax
    2cd8:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2cdc:	66 89 30             	mov    %si,(%eax)
    2cdf:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    2ce3:	88 50 02             	mov    %dl,0x2(%eax)
    2ce6:	6a 32                	push   $0x32
    2ce8:	6a 32                	push   $0x32
    2cea:	6a 00                	push   $0x0
    2cec:	6a 00                	push   $0x0
    2cee:	53                   	push   %ebx
    2cef:	51                   	push   %ecx
    2cf0:	ff 75 84             	pushl  -0x7c(%ebp)
    2cf3:	57                   	push   %edi
    2cf4:	e8 36 f5 ff ff       	call   222f <APDcCopy>
    2cf9:	83 c4 30             	add    $0x30,%esp
                    break;
    2cfc:	e9 d1 01 00 00       	jmp    2ed2 <APGridPaint+0x6e5>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2d01:	8d 45 c9             	lea    -0x37(%ebp),%eax
    2d04:	6a 0c                	push   $0xc
    2d06:	6a 0c                	push   $0xc
    2d08:	6a 0c                	push   $0xc
    2d0a:	50                   	push   %eax
    2d0b:	e8 c3 f6 ff ff       	call   23d3 <RGB>
    2d10:	83 c4 0c             	add    $0xc,%esp
    2d13:	8b 1d cc 7a 00 00    	mov    0x7acc,%ebx
    2d19:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2d1c:	6b c8 32             	imul   $0x32,%eax,%ecx
    2d1f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2d22:	6b c0 32             	imul   $0x32,%eax,%eax
    2d25:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2d28:	8b 45 08             	mov    0x8(%ebp),%eax
    2d2b:	8d 78 3c             	lea    0x3c(%eax),%edi
    2d2e:	83 ec 0c             	sub    $0xc,%esp
    2d31:	83 ec 04             	sub    $0x4,%esp
    2d34:	89 e0                	mov    %esp,%eax
    2d36:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    2d3a:	66 89 30             	mov    %si,(%eax)
    2d3d:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    2d41:	88 50 02             	mov    %dl,0x2(%eax)
    2d44:	6a 32                	push   $0x32
    2d46:	6a 32                	push   $0x32
    2d48:	6a 00                	push   $0x0
    2d4a:	6a 00                	push   $0x0
    2d4c:	53                   	push   %ebx
    2d4d:	51                   	push   %ecx
    2d4e:	ff 75 84             	pushl  -0x7c(%ebp)
    2d51:	57                   	push   %edi
    2d52:	e8 d8 f4 ff ff       	call   222f <APDcCopy>
    2d57:	83 c4 30             	add    $0x30,%esp
                    break;
    2d5a:	e9 73 01 00 00       	jmp    2ed2 <APGridPaint+0x6e5>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2d5f:	8d 45 cc             	lea    -0x34(%ebp),%eax
    2d62:	6a 0c                	push   $0xc
    2d64:	6a 0c                	push   $0xc
    2d66:	6a 0c                	push   $0xc
    2d68:	50                   	push   %eax
    2d69:	e8 65 f6 ff ff       	call   23d3 <RGB>
    2d6e:	83 c4 0c             	add    $0xc,%esp
    2d71:	8b 1d 14 7b 00 00    	mov    0x7b14,%ebx
    2d77:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2d7a:	6b c8 32             	imul   $0x32,%eax,%ecx
    2d7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2d80:	6b c0 32             	imul   $0x32,%eax,%eax
    2d83:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2d86:	8b 45 08             	mov    0x8(%ebp),%eax
    2d89:	8d 78 3c             	lea    0x3c(%eax),%edi
    2d8c:	83 ec 0c             	sub    $0xc,%esp
    2d8f:	83 ec 04             	sub    $0x4,%esp
    2d92:	89 e0                	mov    %esp,%eax
    2d94:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    2d98:	66 89 30             	mov    %si,(%eax)
    2d9b:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    2d9f:	88 50 02             	mov    %dl,0x2(%eax)
    2da2:	6a 32                	push   $0x32
    2da4:	6a 32                	push   $0x32
    2da6:	6a 00                	push   $0x0
    2da8:	6a 00                	push   $0x0
    2daa:	53                   	push   %ebx
    2dab:	51                   	push   %ecx
    2dac:	ff 75 84             	pushl  -0x7c(%ebp)
    2daf:	57                   	push   %edi
    2db0:	e8 7a f4 ff ff       	call   222f <APDcCopy>
    2db5:	83 c4 30             	add    $0x30,%esp
                    break;
    2db8:	e9 15 01 00 00       	jmp    2ed2 <APGridPaint+0x6e5>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2dbd:	8d 45 cf             	lea    -0x31(%ebp),%eax
    2dc0:	6a 0c                	push   $0xc
    2dc2:	6a 0c                	push   $0xc
    2dc4:	6a 0c                	push   $0xc
    2dc6:	50                   	push   %eax
    2dc7:	e8 07 f6 ff ff       	call   23d3 <RGB>
    2dcc:	83 c4 0c             	add    $0xc,%esp
    2dcf:	8b 1d 88 7a 00 00    	mov    0x7a88,%ebx
    2dd5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2dd8:	6b c8 32             	imul   $0x32,%eax,%ecx
    2ddb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2dde:	6b c0 32             	imul   $0x32,%eax,%eax
    2de1:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2de4:	8b 45 08             	mov    0x8(%ebp),%eax
    2de7:	8d 78 3c             	lea    0x3c(%eax),%edi
    2dea:	83 ec 0c             	sub    $0xc,%esp
    2ded:	83 ec 04             	sub    $0x4,%esp
    2df0:	89 e0                	mov    %esp,%eax
    2df2:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2df6:	66 89 30             	mov    %si,(%eax)
    2df9:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2dfd:	88 50 02             	mov    %dl,0x2(%eax)
    2e00:	6a 32                	push   $0x32
    2e02:	6a 32                	push   $0x32
    2e04:	6a 00                	push   $0x0
    2e06:	6a 00                	push   $0x0
    2e08:	53                   	push   %ebx
    2e09:	51                   	push   %ecx
    2e0a:	ff 75 84             	pushl  -0x7c(%ebp)
    2e0d:	57                   	push   %edi
    2e0e:	e8 1c f4 ff ff       	call   222f <APDcCopy>
    2e13:	83 c4 30             	add    $0x30,%esp
                    break;
    2e16:	e9 b7 00 00 00       	jmp    2ed2 <APGridPaint+0x6e5>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2e1b:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2e1e:	6a 0c                	push   $0xc
    2e20:	6a 0c                	push   $0xc
    2e22:	6a 0c                	push   $0xc
    2e24:	50                   	push   %eax
    2e25:	e8 a9 f5 ff ff       	call   23d3 <RGB>
    2e2a:	83 c4 0c             	add    $0xc,%esp
    2e2d:	8b 1d b8 7a 00 00    	mov    0x7ab8,%ebx
    2e33:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2e36:	6b c8 32             	imul   $0x32,%eax,%ecx
    2e39:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2e3c:	6b c0 32             	imul   $0x32,%eax,%eax
    2e3f:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2e42:	8b 45 08             	mov    0x8(%ebp),%eax
    2e45:	8d 78 3c             	lea    0x3c(%eax),%edi
    2e48:	83 ec 0c             	sub    $0xc,%esp
    2e4b:	83 ec 04             	sub    $0x4,%esp
    2e4e:	89 e0                	mov    %esp,%eax
    2e50:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2e54:	66 89 30             	mov    %si,(%eax)
    2e57:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2e5b:	88 50 02             	mov    %dl,0x2(%eax)
    2e5e:	6a 32                	push   $0x32
    2e60:	6a 32                	push   $0x32
    2e62:	6a 00                	push   $0x0
    2e64:	6a 00                	push   $0x0
    2e66:	53                   	push   %ebx
    2e67:	51                   	push   %ecx
    2e68:	ff 75 84             	pushl  -0x7c(%ebp)
    2e6b:	57                   	push   %edi
    2e6c:	e8 be f3 ff ff       	call   222f <APDcCopy>
    2e71:	83 c4 30             	add    $0x30,%esp
                    break;
    2e74:	eb 5c                	jmp    2ed2 <APGridPaint+0x6e5>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2e76:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    2e79:	6a 0c                	push   $0xc
    2e7b:	6a 0c                	push   $0xc
    2e7d:	6a 0c                	push   $0xc
    2e7f:	50                   	push   %eax
    2e80:	e8 4e f5 ff ff       	call   23d3 <RGB>
    2e85:	83 c4 0c             	add    $0xc,%esp
    2e88:	8b 1d 10 7b 00 00    	mov    0x7b10,%ebx
    2e8e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2e91:	6b c8 32             	imul   $0x32,%eax,%ecx
    2e94:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2e97:	6b c0 32             	imul   $0x32,%eax,%eax
    2e9a:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2e9d:	8b 45 08             	mov    0x8(%ebp),%eax
    2ea0:	8d 78 3c             	lea    0x3c(%eax),%edi
    2ea3:	83 ec 0c             	sub    $0xc,%esp
    2ea6:	83 ec 04             	sub    $0x4,%esp
    2ea9:	89 e0                	mov    %esp,%eax
    2eab:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2eaf:	66 89 30             	mov    %si,(%eax)
    2eb2:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2eb6:	88 50 02             	mov    %dl,0x2(%eax)
    2eb9:	6a 32                	push   $0x32
    2ebb:	6a 32                	push   $0x32
    2ebd:	6a 00                	push   $0x0
    2ebf:	6a 00                	push   $0x0
    2ec1:	53                   	push   %ebx
    2ec2:	51                   	push   %ecx
    2ec3:	ff 75 84             	pushl  -0x7c(%ebp)
    2ec6:	57                   	push   %edi
    2ec7:	e8 63 f3 ff ff       	call   222f <APDcCopy>
    2ecc:	83 c4 30             	add    $0x30,%esp
                    break;
    2ecf:	eb 01                	jmp    2ed2 <APGridPaint+0x6e5>
                default: break;
    2ed1:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2ed2:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2ed6:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2eda:	0f 8e 1c fc ff ff    	jle    2afc <APGridPaint+0x30f>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2ee0:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2ee4:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2ee8:	0f 8e 02 fc ff ff    	jle    2af0 <APGridPaint+0x303>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2eee:	8d 45 88             	lea    -0x78(%ebp),%eax
    2ef1:	68 cd 00 00 00       	push   $0xcd
    2ef6:	6a 74                	push   $0x74
    2ef8:	6a 18                	push   $0x18
    2efa:	50                   	push   %eax
    2efb:	e8 d3 f4 ff ff       	call   23d3 <RGB>
    2f00:	83 c4 0c             	add    $0xc,%esp
    2f03:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2f07:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    2f0b:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2f0f:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    2f12:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2f19:	8d 45 88             	lea    -0x78(%ebp),%eax
    2f1c:	68 cd 00 00 00       	push   $0xcd
    2f21:	6a 74                	push   $0x74
    2f23:	6a 18                	push   $0x18
    2f25:	50                   	push   %eax
    2f26:	e8 a8 f4 ff ff       	call   23d3 <RGB>
    2f2b:	83 c4 0c             	add    $0xc,%esp
    2f2e:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2f32:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    2f36:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2f3a:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    2f3d:	8b 45 08             	mov    0x8(%ebp),%eax
    2f40:	8d 50 58             	lea    0x58(%eax),%edx
    2f43:	8d 45 88             	lea    -0x78(%ebp),%eax
    2f46:	ff 75 bc             	pushl  -0x44(%ebp)
    2f49:	ff 75 b8             	pushl  -0x48(%ebp)
    2f4c:	52                   	push   %edx
    2f4d:	50                   	push   %eax
    2f4e:	e8 6d eb ff ff       	call   1ac0 <APSetPen>
    2f53:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2f56:	8b 45 08             	mov    0x8(%ebp),%eax
    2f59:	8d 58 58             	lea    0x58(%eax),%ebx
    2f5c:	8d 55 88             	lea    -0x78(%ebp),%edx
    2f5f:	83 ec 04             	sub    $0x4,%esp
    2f62:	83 ec 04             	sub    $0x4,%esp
    2f65:	89 e0                	mov    %esp,%eax
    2f67:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    2f6b:	66 89 08             	mov    %cx,(%eax)
    2f6e:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2f72:	88 48 02             	mov    %cl,0x2(%eax)
    2f75:	53                   	push   %ebx
    2f76:	52                   	push   %edx
    2f77:	e8 7d eb ff ff       	call   1af9 <APSetBrush>
    2f7c:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2f7f:	8b 45 08             	mov    0x8(%ebp),%eax
    2f82:	83 c0 58             	add    $0x58,%eax
    2f85:	83 ec 0c             	sub    $0xc,%esp
    2f88:	6a 32                	push   $0x32
    2f8a:	68 20 03 00 00       	push   $0x320
    2f8f:	6a 00                	push   $0x0
    2f91:	6a 00                	push   $0x0
    2f93:	50                   	push   %eax
    2f94:	e8 8a ef ff ff       	call   1f23 <APDrawRect>
    2f99:	83 c4 20             	add    $0x20,%esp


    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    2f9c:	8d 45 88             	lea    -0x78(%ebp),%eax
    2f9f:	6a 08                	push   $0x8
    2fa1:	6a 08                	push   $0x8
    2fa3:	6a 08                	push   $0x8
    2fa5:	50                   	push   %eax
    2fa6:	e8 28 f4 ff ff       	call   23d3 <RGB>
    2fab:	83 c4 0c             	add    $0xc,%esp
    2fae:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2fb2:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    2fb6:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2fba:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    2fbd:	8b 45 08             	mov    0x8(%ebp),%eax
    2fc0:	8d 58 58             	lea    0x58(%eax),%ebx
    2fc3:	8d 55 88             	lea    -0x78(%ebp),%edx
    2fc6:	83 ec 04             	sub    $0x4,%esp
    2fc9:	83 ec 04             	sub    $0x4,%esp
    2fcc:	89 e0                	mov    %esp,%eax
    2fce:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    2fd2:	66 89 08             	mov    %cx,(%eax)
    2fd5:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    2fd9:	88 48 02             	mov    %cl,0x2(%eax)
    2fdc:	53                   	push   %ebx
    2fdd:	52                   	push   %edx
    2fde:	e8 58 eb ff ff       	call   1b3b <APSetFont>
    2fe3:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    2fe6:	8b 45 08             	mov    0x8(%ebp),%eax
    2fe9:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    2fef:	8b 45 08             	mov    0x8(%ebp),%eax
    2ff2:	83 c0 58             	add    $0x58,%eax
    2ff5:	6a 14                	push   $0x14
    2ff7:	6a 14                	push   $0x14
    2ff9:	52                   	push   %edx
    2ffa:	50                   	push   %eax
    2ffb:	e8 28 f1 ff ff       	call   2128 <APDrawText>
    3000:	83 c4 10             	add    $0x10,%esp
    
}
    3003:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3006:	5b                   	pop    %ebx
    3007:	5e                   	pop    %esi
    3008:	5f                   	pop    %edi
    3009:	5d                   	pop    %ebp
    300a:	c3                   	ret    

0000300b <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    300b:	55                   	push   %ebp
    300c:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    300e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    3012:	7e 08                	jle    301c <random+0x11>
{
rand_num = seed;
    3014:	8b 45 08             	mov    0x8(%ebp),%eax
    3017:	a3 40 7a 00 00       	mov    %eax,0x7a40
}
rand_num *= 3;
    301c:	8b 15 40 7a 00 00    	mov    0x7a40,%edx
    3022:	89 d0                	mov    %edx,%eax
    3024:	01 c0                	add    %eax,%eax
    3026:	01 d0                	add    %edx,%eax
    3028:	a3 40 7a 00 00       	mov    %eax,0x7a40
if (rand_num < 0)
    302d:	a1 40 7a 00 00       	mov    0x7a40,%eax
    3032:	85 c0                	test   %eax,%eax
    3034:	79 0c                	jns    3042 <random+0x37>
{
rand_num *= (-1);
    3036:	a1 40 7a 00 00       	mov    0x7a40,%eax
    303b:	f7 d8                	neg    %eax
    303d:	a3 40 7a 00 00       	mov    %eax,0x7a40
}
return rand_num % 997;
    3042:	8b 0d 40 7a 00 00    	mov    0x7a40,%ecx
    3048:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    304d:	89 c8                	mov    %ecx,%eax
    304f:	f7 ea                	imul   %edx
    3051:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    3054:	c1 f8 09             	sar    $0x9,%eax
    3057:	89 c2                	mov    %eax,%edx
    3059:	89 c8                	mov    %ecx,%eax
    305b:	c1 f8 1f             	sar    $0x1f,%eax
    305e:	29 c2                	sub    %eax,%edx
    3060:	89 d0                	mov    %edx,%eax
    3062:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    3068:	29 c1                	sub    %eax,%ecx
    306a:	89 c8                	mov    %ecx,%eax
}
    306c:	5d                   	pop    %ebp
    306d:	c3                   	ret    

0000306e <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    306e:	55                   	push   %ebp
    306f:	89 e5                	mov    %esp,%ebp
    3071:	53                   	push   %ebx
    3072:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    3075:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    307c:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    3080:	74 17                	je     3099 <sprintint+0x2b>
    3082:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    3086:	79 11                	jns    3099 <sprintint+0x2b>
        neg = 1;
    3088:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    308f:	8b 45 10             	mov    0x10(%ebp),%eax
    3092:	f7 d8                	neg    %eax
    3094:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3097:	eb 06                	jmp    309f <sprintint+0x31>
    } else {
        x = xx;
    3099:	8b 45 10             	mov    0x10(%ebp),%eax
    309c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    309f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    30a6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    30a9:	8d 41 01             	lea    0x1(%ecx),%eax
    30ac:	89 45 f8             	mov    %eax,-0x8(%ebp)
    30af:	8b 5d 14             	mov    0x14(%ebp),%ebx
    30b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    30b5:	ba 00 00 00 00       	mov    $0x0,%edx
    30ba:	f7 f3                	div    %ebx
    30bc:	89 d0                	mov    %edx,%eax
    30be:	0f b6 80 44 7a 00 00 	movzbl 0x7a44(%eax),%eax
    30c5:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    30c9:	8b 5d 14             	mov    0x14(%ebp),%ebx
    30cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    30cf:	ba 00 00 00 00       	mov    $0x0,%edx
    30d4:	f7 f3                	div    %ebx
    30d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    30d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    30dd:	75 c7                	jne    30a6 <sprintint+0x38>
    if(neg)
    30df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    30e3:	74 0e                	je     30f3 <sprintint+0x85>
        buf[i++] = '-';
    30e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    30e8:	8d 50 01             	lea    0x1(%eax),%edx
    30eb:	89 55 f8             	mov    %edx,-0x8(%ebp)
    30ee:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    30f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    30f6:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    30f9:	eb 1b                	jmp    3116 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    30fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    30fe:	8b 00                	mov    (%eax),%eax
    3100:	8d 48 01             	lea    0x1(%eax),%ecx
    3103:	8b 55 0c             	mov    0xc(%ebp),%edx
    3106:	89 0a                	mov    %ecx,(%edx)
    3108:	89 c2                	mov    %eax,%edx
    310a:	8b 45 08             	mov    0x8(%ebp),%eax
    310d:	01 d0                	add    %edx,%eax
    310f:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    3112:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    3116:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    311a:	7f df                	jg     30fb <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    311c:	eb 21                	jmp    313f <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    311e:	8b 45 0c             	mov    0xc(%ebp),%eax
    3121:	8b 00                	mov    (%eax),%eax
    3123:	8d 48 01             	lea    0x1(%eax),%ecx
    3126:	8b 55 0c             	mov    0xc(%ebp),%edx
    3129:	89 0a                	mov    %ecx,(%edx)
    312b:	89 c2                	mov    %eax,%edx
    312d:	8b 45 08             	mov    0x8(%ebp),%eax
    3130:	01 c2                	add    %eax,%edx
    3132:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    3135:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3138:	01 c8                	add    %ecx,%eax
    313a:	0f b6 00             	movzbl (%eax),%eax
    313d:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    313f:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    3143:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    3147:	79 d5                	jns    311e <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    3149:	90                   	nop
    314a:	83 c4 20             	add    $0x20,%esp
    314d:	5b                   	pop    %ebx
    314e:	5d                   	pop    %ebp
    314f:	c3                   	ret    

00003150 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    3150:	55                   	push   %ebp
    3151:	89 e5                	mov    %esp,%ebp
    3153:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    3156:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    315d:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    3164:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    316b:	8d 45 0c             	lea    0xc(%ebp),%eax
    316e:	83 c0 04             	add    $0x4,%eax
    3171:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    3174:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    317b:	e9 d9 01 00 00       	jmp    3359 <sprintf+0x209>
        c = fmt[i] & 0xff;
    3180:	8b 55 0c             	mov    0xc(%ebp),%edx
    3183:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3186:	01 d0                	add    %edx,%eax
    3188:	0f b6 00             	movzbl (%eax),%eax
    318b:	0f be c0             	movsbl %al,%eax
    318e:	25 ff 00 00 00       	and    $0xff,%eax
    3193:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    3196:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    319a:	75 2c                	jne    31c8 <sprintf+0x78>
            if(c == '%'){
    319c:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    31a0:	75 0c                	jne    31ae <sprintf+0x5e>
                state = '%';
    31a2:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    31a9:	e9 a7 01 00 00       	jmp    3355 <sprintf+0x205>
            } else {
                dst[j++] = c;
    31ae:	8b 45 c8             	mov    -0x38(%ebp),%eax
    31b1:	8d 50 01             	lea    0x1(%eax),%edx
    31b4:	89 55 c8             	mov    %edx,-0x38(%ebp)
    31b7:	89 c2                	mov    %eax,%edx
    31b9:	8b 45 08             	mov    0x8(%ebp),%eax
    31bc:	01 d0                	add    %edx,%eax
    31be:	8b 55 e0             	mov    -0x20(%ebp),%edx
    31c1:	88 10                	mov    %dl,(%eax)
    31c3:	e9 8d 01 00 00       	jmp    3355 <sprintf+0x205>
            }
        } else if(state == '%'){
    31c8:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    31cc:	0f 85 83 01 00 00    	jne    3355 <sprintf+0x205>
            if(c == 'd'){
    31d2:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    31d6:	75 4c                	jne    3224 <sprintf+0xd4>
                buf[bi] = '\0';
    31d8:	8d 55 ce             	lea    -0x32(%ebp),%edx
    31db:	8b 45 f0             	mov    -0x10(%ebp),%eax
    31de:	01 d0                	add    %edx,%eax
    31e0:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    31e3:	83 ec 0c             	sub    $0xc,%esp
    31e6:	8d 45 ce             	lea    -0x32(%ebp),%eax
    31e9:	50                   	push   %eax
    31ea:	e8 2b df ff ff       	call   111a <atoi>
    31ef:	83 c4 10             	add    $0x10,%esp
    31f2:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    31f5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    31fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    31ff:	8b 00                	mov    (%eax),%eax
    3201:	83 ec 08             	sub    $0x8,%esp
    3204:	ff 75 d8             	pushl  -0x28(%ebp)
    3207:	6a 01                	push   $0x1
    3209:	6a 0a                	push   $0xa
    320b:	50                   	push   %eax
    320c:	8d 45 c8             	lea    -0x38(%ebp),%eax
    320f:	50                   	push   %eax
    3210:	ff 75 08             	pushl  0x8(%ebp)
    3213:	e8 56 fe ff ff       	call   306e <sprintint>
    3218:	83 c4 20             	add    $0x20,%esp
                ap++;
    321b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    321f:	e9 2a 01 00 00       	jmp    334e <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    3224:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    3228:	74 06                	je     3230 <sprintf+0xe0>
    322a:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    322e:	75 4c                	jne    327c <sprintf+0x12c>
                buf[bi] = '\0';
    3230:	8d 55 ce             	lea    -0x32(%ebp),%edx
    3233:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3236:	01 d0                	add    %edx,%eax
    3238:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    323b:	83 ec 0c             	sub    $0xc,%esp
    323e:	8d 45 ce             	lea    -0x32(%ebp),%eax
    3241:	50                   	push   %eax
    3242:	e8 d3 de ff ff       	call   111a <atoi>
    3247:	83 c4 10             	add    $0x10,%esp
    324a:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    324d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    3254:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3257:	8b 00                	mov    (%eax),%eax
    3259:	83 ec 08             	sub    $0x8,%esp
    325c:	ff 75 dc             	pushl  -0x24(%ebp)
    325f:	6a 00                	push   $0x0
    3261:	6a 10                	push   $0x10
    3263:	50                   	push   %eax
    3264:	8d 45 c8             	lea    -0x38(%ebp),%eax
    3267:	50                   	push   %eax
    3268:	ff 75 08             	pushl  0x8(%ebp)
    326b:	e8 fe fd ff ff       	call   306e <sprintint>
    3270:	83 c4 20             	add    $0x20,%esp
                ap++;
    3273:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    3277:	e9 d2 00 00 00       	jmp    334e <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    327c:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    3280:	75 46                	jne    32c8 <sprintf+0x178>
                s = (char*)*ap;
    3282:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3285:	8b 00                	mov    (%eax),%eax
    3287:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    328a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    328e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3292:	75 25                	jne    32b9 <sprintf+0x169>
                    s = "(null)";
    3294:	c7 45 f4 20 37 00 00 	movl   $0x3720,-0xc(%ebp)
                while(*s != 0){
    329b:	eb 1c                	jmp    32b9 <sprintf+0x169>
                    dst[j++] = *s;
    329d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    32a0:	8d 50 01             	lea    0x1(%eax),%edx
    32a3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    32a6:	89 c2                	mov    %eax,%edx
    32a8:	8b 45 08             	mov    0x8(%ebp),%eax
    32ab:	01 c2                	add    %eax,%edx
    32ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    32b0:	0f b6 00             	movzbl (%eax),%eax
    32b3:	88 02                	mov    %al,(%edx)
                    s++;
    32b5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    32b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    32bc:	0f b6 00             	movzbl (%eax),%eax
    32bf:	84 c0                	test   %al,%al
    32c1:	75 da                	jne    329d <sprintf+0x14d>
    32c3:	e9 86 00 00 00       	jmp    334e <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    32c8:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    32cc:	75 1d                	jne    32eb <sprintf+0x19b>
                dst[j++] = *ap;
    32ce:	8b 45 c8             	mov    -0x38(%ebp),%eax
    32d1:	8d 50 01             	lea    0x1(%eax),%edx
    32d4:	89 55 c8             	mov    %edx,-0x38(%ebp)
    32d7:	89 c2                	mov    %eax,%edx
    32d9:	8b 45 08             	mov    0x8(%ebp),%eax
    32dc:	01 c2                	add    %eax,%edx
    32de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    32e1:	8b 00                	mov    (%eax),%eax
    32e3:	88 02                	mov    %al,(%edx)
                ap++;
    32e5:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    32e9:	eb 63                	jmp    334e <sprintf+0x1fe>
            } else if(c == '%'){
    32eb:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    32ef:	75 17                	jne    3308 <sprintf+0x1b8>
                dst[j++] = c;
    32f1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    32f4:	8d 50 01             	lea    0x1(%eax),%edx
    32f7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    32fa:	89 c2                	mov    %eax,%edx
    32fc:	8b 45 08             	mov    0x8(%ebp),%eax
    32ff:	01 d0                	add    %edx,%eax
    3301:	8b 55 e0             	mov    -0x20(%ebp),%edx
    3304:	88 10                	mov    %dl,(%eax)
    3306:	eb 46                	jmp    334e <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    3308:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    330c:	7e 18                	jle    3326 <sprintf+0x1d6>
    330e:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    3312:	7f 12                	jg     3326 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    3314:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3317:	8d 50 01             	lea    0x1(%eax),%edx
    331a:	89 55 f0             	mov    %edx,-0x10(%ebp)
    331d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    3320:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    3324:	eb 2f                	jmp    3355 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    3326:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3329:	8d 50 01             	lea    0x1(%eax),%edx
    332c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    332f:	89 c2                	mov    %eax,%edx
    3331:	8b 45 08             	mov    0x8(%ebp),%eax
    3334:	01 d0                	add    %edx,%eax
    3336:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    3339:	8b 45 c8             	mov    -0x38(%ebp),%eax
    333c:	8d 50 01             	lea    0x1(%eax),%edx
    333f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    3342:	89 c2                	mov    %eax,%edx
    3344:	8b 45 08             	mov    0x8(%ebp),%eax
    3347:	01 d0                	add    %edx,%eax
    3349:	8b 55 e0             	mov    -0x20(%ebp),%edx
    334c:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    334e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    3355:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    3359:	8b 55 0c             	mov    0xc(%ebp),%edx
    335c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    335f:	01 d0                	add    %edx,%eax
    3361:	0f b6 00             	movzbl (%eax),%eax
    3364:	84 c0                	test   %al,%al
    3366:	0f 85 14 fe ff ff    	jne    3180 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    336c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    336f:	8d 50 01             	lea    0x1(%eax),%edx
    3372:	89 55 c8             	mov    %edx,-0x38(%ebp)
    3375:	89 c2                	mov    %eax,%edx
    3377:	8b 45 08             	mov    0x8(%ebp),%eax
    337a:	01 d0                	add    %edx,%eax
    337c:	c6 00 00             	movb   $0x0,(%eax)
}
    337f:	90                   	nop
    3380:	c9                   	leave  
    3381:	c3                   	ret    
