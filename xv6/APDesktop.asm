
_APDesktop：     文件格式 elf32-i386


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

00000045 <runApp>:
#include "APDesktop.h"

void runApp(void * param)
{
      45:	55                   	push   %ebp
      46:	89 e5                	mov    %esp,%ebp
      48:	83 ec 38             	sub    $0x38,%esp
    int pid = fork();
      4b:	e8 97 07 00 00       	call   7e7 <fork>
      50:	89 45 f4             	mov    %eax,-0xc(%ebp)
    char temp[30];
    if (pid == 0)
      53:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      57:	75 37                	jne    90 <runApp+0x4b>
    {
        sprintf(temp, "AP%s", (char *)param);
      59:	83 ec 04             	sub    $0x4,%esp
      5c:	ff 75 08             	pushl  0x8(%ebp)
      5f:	68 e4 2a 00 00       	push   $0x2ae4
      64:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      67:	50                   	push   %eax
      68:	e8 42 28 00 00       	call   28af <sprintf>
      6d:	83 c4 10             	add    $0x10,%esp
        char *argv[] = { temp, 0 };
      70:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      73:	89 45 cc             	mov    %eax,-0x34(%ebp)
      76:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
        exec(temp, argv);
      7d:	83 ec 08             	sub    $0x8,%esp
      80:	8d 45 cc             	lea    -0x34(%ebp),%eax
      83:	50                   	push   %eax
      84:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      87:	50                   	push   %eax
      88:	e8 9a 07 00 00       	call   827 <exec>
      8d:	83 c4 10             	add    $0x10,%esp
    }
}
      90:	90                   	nop
      91:	c9                   	leave  
      92:	c3                   	ret    

00000093 <wndProc>:
};



bool wndProc(AHwnd hwnd, AMessage msg)
{
      93:	55                   	push   %ebp
      94:	89 e5                	mov    %esp,%ebp
      96:	53                   	push   %ebx
      97:	83 ec 44             	sub    $0x44,%esp
    //printf(1,"desktop processing!\n");
    switch(msg.type)
      9a:	8b 45 0c             	mov    0xc(%ebp),%eax
      9d:	83 f8 03             	cmp    $0x3,%eax
      a0:	0f 84 bf 01 00 00    	je     265 <wndProc+0x1d2>
      a6:	83 f8 06             	cmp    $0x6,%eax
      a9:	0f 84 f8 01 00 00    	je     2a7 <wndProc+0x214>
      af:	83 f8 02             	cmp    $0x2,%eax
      b2:	74 05                	je     b9 <wndProc+0x26>
                    runApp("MagicTower");
                break;
            default:break;
        }
            break;
        default: break;
      b4:	e9 e5 03 00 00       	jmp    49e <wndProc+0x40b>
    //printf(1,"desktop processing!\n");
    switch(msg.type)
    {
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
      b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      c0:	eb 49                	jmp    10b <wndProc+0x78>
            {
                int off = j * GRID_W_NUMBER;
      c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
      c5:	c1 e0 04             	shl    $0x4,%eax
      c8:	89 45 ec             	mov    %eax,-0x14(%ebp)
                for (int i = 0; i< GRID_W_NUMBER; i++)
      cb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
      d2:	eb 2d                	jmp    101 <wndProc+0x6e>
                    hwnd->Grid[off + i] = desktop_layout[j][i];
      d4:	8b 45 08             	mov    0x8(%ebp),%eax
      d7:	8b 40 0c             	mov    0xc(%eax),%eax
      da:	8b 4d ec             	mov    -0x14(%ebp),%ecx
      dd:	8b 55 f0             	mov    -0x10(%ebp),%edx
      e0:	01 ca                	add    %ecx,%edx
      e2:	c1 e2 02             	shl    $0x2,%edx
      e5:	01 c2                	add    %eax,%edx
      e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
      ea:	c1 e0 04             	shl    $0x4,%eax
      ed:	89 c1                	mov    %eax,%ecx
      ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
      f2:	01 c8                	add    %ecx,%eax
      f4:	8b 04 85 20 33 00 00 	mov    0x3320(,%eax,4),%eax
      fb:	89 02                	mov    %eax,(%edx)
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
            {
                int off = j * GRID_W_NUMBER;
                for (int i = 0; i< GRID_W_NUMBER; i++)
      fd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     101:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
     105:	7e cd                	jle    d4 <wndProc+0x41>
    //printf(1,"desktop processing!\n");
    switch(msg.type)
    {
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
     107:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     10b:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
     10f:	7e b1                	jle    c2 <wndProc+0x2f>
                    hwnd->Grid[off + i] = desktop_layout[j][i];
            }
            //init Title Part
            APen pen;
            ABrush brush;
            pen.color = RGB(0x18,0x74,0xcd);
     111:	8d 45 b8             	lea    -0x48(%ebp),%eax
     114:	68 cd 00 00 00       	push   $0xcd
     119:	6a 74                	push   $0x74
     11b:	6a 18                	push   $0x18
     11d:	50                   	push   %eax
     11e:	e8 dd fe ff ff       	call   0 <RGB>
     123:	83 c4 0c             	add    $0xc,%esp
     126:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     12a:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
     12e:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
     132:	88 45 e6             	mov    %al,-0x1a(%ebp)
            pen.size = 1;
     135:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
            brush.color = RGB(0x18,0x74,0xcd);
     13c:	8d 45 b8             	lea    -0x48(%ebp),%eax
     13f:	68 cd 00 00 00       	push   $0xcd
     144:	6a 74                	push   $0x74
     146:	6a 18                	push   $0x18
     148:	50                   	push   %eax
     149:	e8 b2 fe ff ff       	call   0 <RGB>
     14e:	83 c4 0c             	add    $0xc,%esp
     151:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     155:	66 89 45 e1          	mov    %ax,-0x1f(%ebp)
     159:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
     15d:	88 45 e3             	mov    %al,-0x1d(%ebp)
            APSetPen(&hwnd->TitleDc,pen);
     160:	8b 45 08             	mov    0x8(%ebp),%eax
     163:	8d 50 58             	lea    0x58(%eax),%edx
     166:	8d 45 b8             	lea    -0x48(%ebp),%eax
     169:	ff 75 e8             	pushl  -0x18(%ebp)
     16c:	ff 75 e4             	pushl  -0x1c(%ebp)
     16f:	52                   	push   %edx
     170:	50                   	push   %eax
     171:	e8 8d 0f 00 00       	call   1103 <APSetPen>
     176:	83 c4 0c             	add    $0xc,%esp
            APSetBrush(&hwnd->TitleDc,brush);
     179:	8b 45 08             	mov    0x8(%ebp),%eax
     17c:	8d 58 58             	lea    0x58(%eax),%ebx
     17f:	8d 55 b8             	lea    -0x48(%ebp),%edx
     182:	83 ec 04             	sub    $0x4,%esp
     185:	83 ec 04             	sub    $0x4,%esp
     188:	89 e0                	mov    %esp,%eax
     18a:	0f b7 4d e1          	movzwl -0x1f(%ebp),%ecx
     18e:	66 89 08             	mov    %cx,(%eax)
     191:	0f b6 4d e3          	movzbl -0x1d(%ebp),%ecx
     195:	88 48 02             	mov    %cl,0x2(%eax)
     198:	53                   	push   %ebx
     199:	52                   	push   %edx
     19a:	e8 9d 0f 00 00       	call   113c <APSetBrush>
     19f:	83 c4 0c             	add    $0xc,%esp
            APDrawRect(&hwnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
     1a2:	8b 45 08             	mov    0x8(%ebp),%eax
     1a5:	83 c0 58             	add    $0x58,%eax
     1a8:	83 ec 0c             	sub    $0xc,%esp
     1ab:	6a 32                	push   $0x32
     1ad:	68 20 03 00 00       	push   $0x320
     1b2:	6a 00                	push   $0x0
     1b4:	6a 00                	push   $0x0
     1b6:	50                   	push   %eax
     1b7:	e8 aa 13 00 00       	call   1566 <APDrawRect>
     1bc:	83 c4 20             	add    $0x20,%esp
            AFont font;
            font.color = RGB(0x08,0x08,0x08);
     1bf:	8d 45 b8             	lea    -0x48(%ebp),%eax
     1c2:	6a 08                	push   $0x8
     1c4:	6a 08                	push   $0x8
     1c6:	6a 08                	push   $0x8
     1c8:	50                   	push   %eax
     1c9:	e8 32 fe ff ff       	call   0 <RGB>
     1ce:	83 c4 0c             	add    $0xc,%esp
     1d1:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     1d5:	66 89 45 de          	mov    %ax,-0x22(%ebp)
     1d9:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
     1dd:	88 45 e0             	mov    %al,-0x20(%ebp)
            APSetFont(&hwnd->TitleDc,font);
     1e0:	8b 45 08             	mov    0x8(%ebp),%eax
     1e3:	8d 58 58             	lea    0x58(%eax),%ebx
     1e6:	8d 55 b8             	lea    -0x48(%ebp),%edx
     1e9:	83 ec 04             	sub    $0x4,%esp
     1ec:	83 ec 04             	sub    $0x4,%esp
     1ef:	89 e0                	mov    %esp,%eax
     1f1:	0f b7 4d de          	movzwl -0x22(%ebp),%ecx
     1f5:	66 89 08             	mov    %cx,(%eax)
     1f8:	0f b6 4d e0          	movzbl -0x20(%ebp),%ecx
     1fc:	88 48 02             	mov    %cl,0x2(%eax)
     1ff:	53                   	push   %ebx
     200:	52                   	push   %edx
     201:	e8 78 0f 00 00       	call   117e <APSetFont>
     206:	83 c4 0c             	add    $0xc,%esp
            APDrawText(&hwnd->TitleDc,hwnd->title,20,20);
     209:	8b 45 08             	mov    0x8(%ebp),%eax
     20c:	8d 90 88 00 00 00    	lea    0x88(%eax),%edx
     212:	8b 45 08             	mov    0x8(%ebp),%eax
     215:	83 c0 58             	add    $0x58,%eax
     218:	6a 14                	push   $0x14
     21a:	6a 14                	push   $0x14
     21c:	52                   	push   %edx
     21d:	50                   	push   %eax
     21e:	e8 48 15 00 00       	call   176b <APDrawText>
     223:	83 c4 10             	add    $0x10,%esp
            
            hwnd->pos_x = 3;
     226:	8b 45 08             	mov    0x8(%ebp),%eax
     229:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%eax)
            hwnd->pos_y = 3;
     230:	8b 45 08             	mov    0x8(%ebp),%eax
     233:	c7 40 1c 03 00 00 00 	movl   $0x3,0x1c(%eax)
            msg.type = MSG_PAINT;
     23a:	c7 45 0c 03 00 00 00 	movl   $0x3,0xc(%ebp)
            APSendMessage(hwnd,msg);
     241:	83 ec 0c             	sub    $0xc,%esp
     244:	ff 75 18             	pushl  0x18(%ebp)
     247:	ff 75 14             	pushl  0x14(%ebp)
     24a:	ff 75 10             	pushl  0x10(%ebp)
     24d:	ff 75 0c             	pushl  0xc(%ebp)
     250:	ff 75 08             	pushl  0x8(%ebp)
     253:	e8 03 18 00 00       	call   1a5b <APSendMessage>
     258:	83 c4 20             	add    $0x20,%esp
            //setupTimer(hwnd,0,1000);
            return False;
     25b:	b8 00 00 00 00       	mov    $0x0,%eax
     260:	e9 53 02 00 00       	jmp    4b8 <wndProc+0x425>
        case MSG_PAINT:
            APGridPaint(hwnd);
     265:	83 ec 0c             	sub    $0xc,%esp
     268:	ff 75 08             	pushl  0x8(%ebp)
     26b:	e8 2a 1c 00 00       	call   1e9a <APGridPaint>
     270:	83 c4 10             	add    $0x10,%esp
            AMessage ms;
            ms.type = MSG_WORD;
     273:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%ebp)
            ms.param = -1;
     27a:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%ebp)
            ms.word = "Welcome!";
     281:	c7 45 d8 e9 2a 00 00 	movl   $0x2ae9,-0x28(%ebp)
            APSendMessage(hwnd,ms);
     288:	83 ec 0c             	sub    $0xc,%esp
     28b:	ff 75 d8             	pushl  -0x28(%ebp)
     28e:	ff 75 d4             	pushl  -0x2c(%ebp)
     291:	ff 75 d0             	pushl  -0x30(%ebp)
     294:	ff 75 cc             	pushl  -0x34(%ebp)
     297:	ff 75 08             	pushl  0x8(%ebp)
     29a:	e8 bc 17 00 00       	call   1a5b <APSendMessage>
     29f:	83 c4 20             	add    $0x20,%esp
            break;
     2a2:	e9 f7 01 00 00       	jmp    49e <wndProc+0x40b>
        case MSG_KEY_DOWN:
            //printf(1,"kbd message received!\n");
            switch (msg.param)
     2a7:	8b 45 10             	mov    0x10(%ebp),%eax
     2aa:	83 f8 06             	cmp    $0x6,%eax
     2ad:	0f 87 e6 01 00 00    	ja     499 <wndProc+0x406>
     2b3:	8b 04 85 04 2b 00 00 	mov    0x2b04(,%eax,4),%eax
     2ba:	ff e0                	jmp    *%eax
        {
            case VK_RIGHT:
                if (hwnd->pos_x < GRID_W_NUMBER - 1 && judgeGridWalkable(hwnd->pos_x + 1,hwnd->pos_y,hwnd))
     2bc:	8b 45 08             	mov    0x8(%ebp),%eax
     2bf:	8b 40 18             	mov    0x18(%eax),%eax
     2c2:	83 f8 0e             	cmp    $0xe,%eax
     2c5:	7f 32                	jg     2f9 <wndProc+0x266>
     2c7:	8b 45 08             	mov    0x8(%ebp),%eax
     2ca:	8b 40 1c             	mov    0x1c(%eax),%eax
     2cd:	8b 55 08             	mov    0x8(%ebp),%edx
     2d0:	8b 52 18             	mov    0x18(%edx),%edx
     2d3:	83 c2 01             	add    $0x1,%edx
     2d6:	83 ec 04             	sub    $0x4,%esp
     2d9:	ff 75 08             	pushl  0x8(%ebp)
     2dc:	50                   	push   %eax
     2dd:	52                   	push   %edx
     2de:	e8 da 01 00 00       	call   4bd <judgeGridWalkable>
     2e3:	83 c4 10             	add    $0x10,%esp
     2e6:	85 c0                	test   %eax,%eax
     2e8:	74 0f                	je     2f9 <wndProc+0x266>
                    hwnd->pos_x++;
     2ea:	8b 45 08             	mov    0x8(%ebp),%eax
     2ed:	8b 40 18             	mov    0x18(%eax),%eax
     2f0:	8d 50 01             	lea    0x1(%eax),%edx
     2f3:	8b 45 08             	mov    0x8(%ebp),%eax
     2f6:	89 50 18             	mov    %edx,0x18(%eax)
                changePosition(hwnd->pos_x,hwnd->pos_y,1);
     2f9:	8b 45 08             	mov    0x8(%ebp),%eax
     2fc:	8b 50 1c             	mov    0x1c(%eax),%edx
     2ff:	8b 45 08             	mov    0x8(%ebp),%eax
     302:	8b 40 18             	mov    0x18(%eax),%eax
     305:	83 ec 04             	sub    $0x4,%esp
     308:	6a 01                	push   $0x1
     30a:	52                   	push   %edx
     30b:	50                   	push   %eax
     30c:	e8 9e 05 00 00       	call   8af <changePosition>
     311:	83 c4 10             	add    $0x10,%esp
                break;
     314:	e9 84 01 00 00       	jmp    49d <wndProc+0x40a>
            case VK_LEFT:
                if (hwnd->pos_x > 0 && judgeGridWalkable(hwnd->pos_x - 1 ,hwnd->pos_y,hwnd))
     319:	8b 45 08             	mov    0x8(%ebp),%eax
     31c:	8b 40 18             	mov    0x18(%eax),%eax
     31f:	85 c0                	test   %eax,%eax
     321:	7e 32                	jle    355 <wndProc+0x2c2>
     323:	8b 45 08             	mov    0x8(%ebp),%eax
     326:	8b 40 1c             	mov    0x1c(%eax),%eax
     329:	8b 55 08             	mov    0x8(%ebp),%edx
     32c:	8b 52 18             	mov    0x18(%edx),%edx
     32f:	83 ea 01             	sub    $0x1,%edx
     332:	83 ec 04             	sub    $0x4,%esp
     335:	ff 75 08             	pushl  0x8(%ebp)
     338:	50                   	push   %eax
     339:	52                   	push   %edx
     33a:	e8 7e 01 00 00       	call   4bd <judgeGridWalkable>
     33f:	83 c4 10             	add    $0x10,%esp
     342:	85 c0                	test   %eax,%eax
     344:	74 0f                	je     355 <wndProc+0x2c2>
                    hwnd->pos_x--;
     346:	8b 45 08             	mov    0x8(%ebp),%eax
     349:	8b 40 18             	mov    0x18(%eax),%eax
     34c:	8d 50 ff             	lea    -0x1(%eax),%edx
     34f:	8b 45 08             	mov    0x8(%ebp),%eax
     352:	89 50 18             	mov    %edx,0x18(%eax)
                changePosition(hwnd->pos_x,hwnd->pos_y,0);
     355:	8b 45 08             	mov    0x8(%ebp),%eax
     358:	8b 50 1c             	mov    0x1c(%eax),%edx
     35b:	8b 45 08             	mov    0x8(%ebp),%eax
     35e:	8b 40 18             	mov    0x18(%eax),%eax
     361:	83 ec 04             	sub    $0x4,%esp
     364:	6a 00                	push   $0x0
     366:	52                   	push   %edx
     367:	50                   	push   %eax
     368:	e8 42 05 00 00       	call   8af <changePosition>
     36d:	83 c4 10             	add    $0x10,%esp
                break;
     370:	e9 28 01 00 00       	jmp    49d <wndProc+0x40a>
            case VK_UP:
                if (hwnd->pos_y > 0 && judgeGridWalkable(hwnd->pos_x ,hwnd->pos_y - 1,hwnd))
     375:	8b 45 08             	mov    0x8(%ebp),%eax
     378:	8b 40 1c             	mov    0x1c(%eax),%eax
     37b:	85 c0                	test   %eax,%eax
     37d:	7e 32                	jle    3b1 <wndProc+0x31e>
     37f:	8b 45 08             	mov    0x8(%ebp),%eax
     382:	8b 40 1c             	mov    0x1c(%eax),%eax
     385:	8d 50 ff             	lea    -0x1(%eax),%edx
     388:	8b 45 08             	mov    0x8(%ebp),%eax
     38b:	8b 40 18             	mov    0x18(%eax),%eax
     38e:	83 ec 04             	sub    $0x4,%esp
     391:	ff 75 08             	pushl  0x8(%ebp)
     394:	52                   	push   %edx
     395:	50                   	push   %eax
     396:	e8 22 01 00 00       	call   4bd <judgeGridWalkable>
     39b:	83 c4 10             	add    $0x10,%esp
     39e:	85 c0                	test   %eax,%eax
     3a0:	74 0f                	je     3b1 <wndProc+0x31e>
                    hwnd->pos_y--;
     3a2:	8b 45 08             	mov    0x8(%ebp),%eax
     3a5:	8b 40 1c             	mov    0x1c(%eax),%eax
     3a8:	8d 50 ff             	lea    -0x1(%eax),%edx
     3ab:	8b 45 08             	mov    0x8(%ebp),%eax
     3ae:	89 50 1c             	mov    %edx,0x1c(%eax)
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
     3b1:	8b 45 08             	mov    0x8(%ebp),%eax
     3b4:	8b 50 1c             	mov    0x1c(%eax),%edx
     3b7:	8b 45 08             	mov    0x8(%ebp),%eax
     3ba:	8b 40 18             	mov    0x18(%eax),%eax
     3bd:	83 ec 04             	sub    $0x4,%esp
     3c0:	6a 02                	push   $0x2
     3c2:	52                   	push   %edx
     3c3:	50                   	push   %eax
     3c4:	e8 e6 04 00 00       	call   8af <changePosition>
     3c9:	83 c4 10             	add    $0x10,%esp
                break;
     3cc:	e9 cc 00 00 00       	jmp    49d <wndProc+0x40a>
            case VK_DOWN:
                if (hwnd->pos_y < GRID_H_NUMBER - 1 && judgeGridWalkable(hwnd->pos_x ,hwnd->pos_y + 1,hwnd))
     3d1:	8b 45 08             	mov    0x8(%ebp),%eax
     3d4:	8b 40 1c             	mov    0x1c(%eax),%eax
     3d7:	83 f8 09             	cmp    $0x9,%eax
     3da:	7f 32                	jg     40e <wndProc+0x37b>
     3dc:	8b 45 08             	mov    0x8(%ebp),%eax
     3df:	8b 40 1c             	mov    0x1c(%eax),%eax
     3e2:	8d 50 01             	lea    0x1(%eax),%edx
     3e5:	8b 45 08             	mov    0x8(%ebp),%eax
     3e8:	8b 40 18             	mov    0x18(%eax),%eax
     3eb:	83 ec 04             	sub    $0x4,%esp
     3ee:	ff 75 08             	pushl  0x8(%ebp)
     3f1:	52                   	push   %edx
     3f2:	50                   	push   %eax
     3f3:	e8 c5 00 00 00       	call   4bd <judgeGridWalkable>
     3f8:	83 c4 10             	add    $0x10,%esp
     3fb:	85 c0                	test   %eax,%eax
     3fd:	74 0f                	je     40e <wndProc+0x37b>
                    hwnd->pos_y++;
     3ff:	8b 45 08             	mov    0x8(%ebp),%eax
     402:	8b 40 1c             	mov    0x1c(%eax),%eax
     405:	8d 50 01             	lea    0x1(%eax),%edx
     408:	8b 45 08             	mov    0x8(%ebp),%eax
     40b:	89 50 1c             	mov    %edx,0x1c(%eax)
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
     40e:	8b 45 08             	mov    0x8(%ebp),%eax
     411:	8b 50 1c             	mov    0x1c(%eax),%edx
     414:	8b 45 08             	mov    0x8(%ebp),%eax
     417:	8b 40 18             	mov    0x18(%eax),%eax
     41a:	83 ec 04             	sub    $0x4,%esp
     41d:	6a 02                	push   $0x2
     41f:	52                   	push   %edx
     420:	50                   	push   %eax
     421:	e8 89 04 00 00       	call   8af <changePosition>
     426:	83 c4 10             	add    $0x10,%esp
                break;
     429:	eb 72                	jmp    49d <wndProc+0x40a>
            case VK_ENTER:
                if (hwnd->Grid[hwnd->pos_y * GRID_W_NUMBER + hwnd->pos_x] == GRID_PROGRAM_SNAKE)
     42b:	8b 45 08             	mov    0x8(%ebp),%eax
     42e:	8b 50 0c             	mov    0xc(%eax),%edx
     431:	8b 45 08             	mov    0x8(%ebp),%eax
     434:	8b 40 1c             	mov    0x1c(%eax),%eax
     437:	c1 e0 04             	shl    $0x4,%eax
     43a:	89 c1                	mov    %eax,%ecx
     43c:	8b 45 08             	mov    0x8(%ebp),%eax
     43f:	8b 40 18             	mov    0x18(%eax),%eax
     442:	01 c8                	add    %ecx,%eax
     444:	c1 e0 02             	shl    $0x2,%eax
     447:	01 d0                	add    %edx,%eax
     449:	8b 00                	mov    (%eax),%eax
     44b:	83 f8 0a             	cmp    $0xa,%eax
     44e:	75 12                	jne    462 <wndProc+0x3cf>
                    runApp("Snack");
     450:	83 ec 0c             	sub    $0xc,%esp
     453:	68 f2 2a 00 00       	push   $0x2af2
     458:	e8 e8 fb ff ff       	call   45 <runApp>
     45d:	83 c4 10             	add    $0x10,%esp
                else if (hwnd->Grid[hwnd->pos_y * GRID_W_NUMBER + hwnd->pos_x] == GRID_PROGRAM_TOWER)
                    runApp("MagicTower");
                break;
     460:	eb 3a                	jmp    49c <wndProc+0x409>
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
                break;
            case VK_ENTER:
                if (hwnd->Grid[hwnd->pos_y * GRID_W_NUMBER + hwnd->pos_x] == GRID_PROGRAM_SNAKE)
                    runApp("Snack");
                else if (hwnd->Grid[hwnd->pos_y * GRID_W_NUMBER + hwnd->pos_x] == GRID_PROGRAM_TOWER)
     462:	8b 45 08             	mov    0x8(%ebp),%eax
     465:	8b 50 0c             	mov    0xc(%eax),%edx
     468:	8b 45 08             	mov    0x8(%ebp),%eax
     46b:	8b 40 1c             	mov    0x1c(%eax),%eax
     46e:	c1 e0 04             	shl    $0x4,%eax
     471:	89 c1                	mov    %eax,%ecx
     473:	8b 45 08             	mov    0x8(%ebp),%eax
     476:	8b 40 18             	mov    0x18(%eax),%eax
     479:	01 c8                	add    %ecx,%eax
     47b:	c1 e0 02             	shl    $0x2,%eax
     47e:	01 d0                	add    %edx,%eax
     480:	8b 00                	mov    (%eax),%eax
     482:	83 f8 0b             	cmp    $0xb,%eax
     485:	75 15                	jne    49c <wndProc+0x409>
                    runApp("MagicTower");
     487:	83 ec 0c             	sub    $0xc,%esp
     48a:	68 f8 2a 00 00       	push   $0x2af8
     48f:	e8 b1 fb ff ff       	call   45 <runApp>
     494:	83 c4 10             	add    $0x10,%esp
                break;
     497:	eb 03                	jmp    49c <wndProc+0x409>
            default:break;
     499:	90                   	nop
     49a:	eb 01                	jmp    49d <wndProc+0x40a>
            case VK_ENTER:
                if (hwnd->Grid[hwnd->pos_y * GRID_W_NUMBER + hwnd->pos_x] == GRID_PROGRAM_SNAKE)
                    runApp("Snack");
                else if (hwnd->Grid[hwnd->pos_y * GRID_W_NUMBER + hwnd->pos_x] == GRID_PROGRAM_TOWER)
                    runApp("MagicTower");
                break;
     49c:	90                   	nop
            default:break;
        }
            break;
     49d:	90                   	nop
        default: break;
    }
    return APWndProc(hwnd, msg);
     49e:	83 ec 0c             	sub    $0xc,%esp
     4a1:	ff 75 18             	pushl  0x18(%ebp)
     4a4:	ff 75 14             	pushl  0x14(%ebp)
     4a7:	ff 75 10             	pushl  0x10(%ebp)
     4aa:	ff 75 0c             	pushl  0xc(%ebp)
     4ad:	ff 75 08             	pushl  0x8(%ebp)
     4b0:	e8 2a 18 00 00       	call   1cdf <APWndProc>
     4b5:	83 c4 20             	add    $0x20,%esp
}
     4b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4bb:	c9                   	leave  
     4bc:	c3                   	ret    

000004bd <judgeGridWalkable>:

int judgeGridWalkable(int x,int y, AHwnd hwnd)
{
     4bd:	55                   	push   %ebp
     4be:	89 e5                	mov    %esp,%ebp
     4c0:	83 ec 10             	sub    $0x10,%esp
    if (hwnd->is_grid)
     4c3:	8b 45 10             	mov    0x10(%ebp),%eax
     4c6:	8b 40 08             	mov    0x8(%eax),%eax
     4c9:	85 c0                	test   %eax,%eax
     4cb:	0f 84 80 00 00 00    	je     551 <judgeGridWalkable+0x94>
    {
        int index = hwnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER + y * GRID_W_NUMBER + x;
     4d1:	8b 45 10             	mov    0x10(%ebp),%eax
     4d4:	8b 50 14             	mov    0x14(%eax),%edx
     4d7:	89 d0                	mov    %edx,%eax
     4d9:	c1 e0 02             	shl    $0x2,%eax
     4dc:	01 d0                	add    %edx,%eax
     4de:	01 c0                	add    %eax,%eax
     4e0:	01 c2                	add    %eax,%edx
     4e2:	8b 45 0c             	mov    0xc(%ebp),%eax
     4e5:	01 d0                	add    %edx,%eax
     4e7:	c1 e0 04             	shl    $0x4,%eax
     4ea:	89 c2                	mov    %eax,%edx
     4ec:	8b 45 08             	mov    0x8(%ebp),%eax
     4ef:	01 d0                	add    %edx,%eax
     4f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
        switch(hwnd->Grid[index])
     4f4:	8b 45 10             	mov    0x10(%ebp),%eax
     4f7:	8b 40 0c             	mov    0xc(%eax),%eax
     4fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
     4fd:	c1 e2 02             	shl    $0x2,%edx
     500:	01 d0                	add    %edx,%eax
     502:	8b 00                	mov    (%eax),%eax
     504:	83 f8 07             	cmp    $0x7,%eax
     507:	77 41                	ja     54a <judgeGridWalkable+0x8d>
     509:	8b 04 85 20 2b 00 00 	mov    0x2b20(,%eax,4),%eax
     510:	ff e0                	jmp    *%eax
        {
                
            case GRID_WALL : return 0;
     512:	b8 00 00 00 00       	mov    $0x0,%eax
     517:	eb 3d                	jmp    556 <judgeGridWalkable+0x99>
            case GRID_ROAD : return 1;
     519:	b8 01 00 00 00       	mov    $0x1,%eax
     51e:	eb 36                	jmp    556 <judgeGridWalkable+0x99>
            case GRID_GRASS : return 1;
     520:	b8 01 00 00 00       	mov    $0x1,%eax
     525:	eb 2f                	jmp    556 <judgeGridWalkable+0x99>
            case GRID_RIVER : return 0;
     527:	b8 00 00 00 00       	mov    $0x0,%eax
     52c:	eb 28                	jmp    556 <judgeGridWalkable+0x99>
            case GRID_FOREST: return 0;
     52e:	b8 00 00 00 00       	mov    $0x0,%eax
     533:	eb 21                	jmp    556 <judgeGridWalkable+0x99>
            case GRID_STONE: return 1;
     535:	b8 01 00 00 00       	mov    $0x1,%eax
     53a:	eb 1a                	jmp    556 <judgeGridWalkable+0x99>
            case GRID_MOUNTAIN: return 0;
     53c:	b8 00 00 00 00       	mov    $0x0,%eax
     541:	eb 13                	jmp    556 <judgeGridWalkable+0x99>
            case GRID_LAKE: return 0;
     543:	b8 00 00 00 00       	mov    $0x0,%eax
     548:	eb 0c                	jmp    556 <judgeGridWalkable+0x99>
            default: return 1;
     54a:	b8 01 00 00 00       	mov    $0x1,%eax
     54f:	eb 05                	jmp    556 <judgeGridWalkable+0x99>
        }
    }
    return 0;
     551:	b8 00 00 00 00       	mov    $0x0,%eax
}
     556:	c9                   	leave  
     557:	c3                   	ret    

00000558 <main>:


int main(void)
{
     558:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     55c:	83 e4 f0             	and    $0xfffffff0,%esp
     55f:	ff 71 fc             	pushl  -0x4(%ecx)
     562:	55                   	push   %ebp
     563:	89 e5                	mov    %esp,%ebp
     565:	51                   	push   %ecx
     566:	83 ec 14             	sub    $0x14,%esp
    //runApp("MagicTower");
    AHwnd hwnd = APCreateWindow("desktop",True,3);
     569:	83 ec 04             	sub    $0x4,%esp
     56c:	6a 03                	push   $0x3
     56e:	6a 01                	push   $0x1
     570:	68 40 2b 00 00       	push   $0x2b40
     575:	e8 ff 14 00 00       	call   1a79 <APCreateWindow>
     57a:	83 c4 10             	add    $0x10,%esp
     57d:	89 45 f4             	mov    %eax,-0xc(%ebp)
   //printf(1,"desktop initialized!\n");
    APWndExec(hwnd, wndProc);
     580:	83 ec 08             	sub    $0x8,%esp
     583:	68 93 00 00 00       	push   $0x93
     588:	ff 75 f4             	pushl  -0xc(%ebp)
     58b:	e8 66 18 00 00       	call   1df6 <APWndExec>
     590:	83 c4 10             	add    $0x10,%esp
    exit();
     593:	e8 57 02 00 00       	call   7ef <exit>

00000598 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     598:	55                   	push   %ebp
     599:	89 e5                	mov    %esp,%ebp
     59b:	57                   	push   %edi
     59c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     59d:	8b 4d 08             	mov    0x8(%ebp),%ecx
     5a0:	8b 55 10             	mov    0x10(%ebp),%edx
     5a3:	8b 45 0c             	mov    0xc(%ebp),%eax
     5a6:	89 cb                	mov    %ecx,%ebx
     5a8:	89 df                	mov    %ebx,%edi
     5aa:	89 d1                	mov    %edx,%ecx
     5ac:	fc                   	cld    
     5ad:	f3 aa                	rep stos %al,%es:(%edi)
     5af:	89 ca                	mov    %ecx,%edx
     5b1:	89 fb                	mov    %edi,%ebx
     5b3:	89 5d 08             	mov    %ebx,0x8(%ebp)
     5b6:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     5b9:	90                   	nop
     5ba:	5b                   	pop    %ebx
     5bb:	5f                   	pop    %edi
     5bc:	5d                   	pop    %ebp
     5bd:	c3                   	ret    

000005be <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     5be:	55                   	push   %ebp
     5bf:	89 e5                	mov    %esp,%ebp
     5c1:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     5c4:	8b 45 08             	mov    0x8(%ebp),%eax
     5c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     5ca:	90                   	nop
     5cb:	8b 45 08             	mov    0x8(%ebp),%eax
     5ce:	8d 50 01             	lea    0x1(%eax),%edx
     5d1:	89 55 08             	mov    %edx,0x8(%ebp)
     5d4:	8b 55 0c             	mov    0xc(%ebp),%edx
     5d7:	8d 4a 01             	lea    0x1(%edx),%ecx
     5da:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     5dd:	0f b6 12             	movzbl (%edx),%edx
     5e0:	88 10                	mov    %dl,(%eax)
     5e2:	0f b6 00             	movzbl (%eax),%eax
     5e5:	84 c0                	test   %al,%al
     5e7:	75 e2                	jne    5cb <strcpy+0xd>
    ;
  return os;
     5e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     5ec:	c9                   	leave  
     5ed:	c3                   	ret    

000005ee <strcmp>:

int
strcmp(const char *p, const char *q)
{
     5ee:	55                   	push   %ebp
     5ef:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     5f1:	eb 08                	jmp    5fb <strcmp+0xd>
    p++, q++;
     5f3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     5f7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     5fb:	8b 45 08             	mov    0x8(%ebp),%eax
     5fe:	0f b6 00             	movzbl (%eax),%eax
     601:	84 c0                	test   %al,%al
     603:	74 10                	je     615 <strcmp+0x27>
     605:	8b 45 08             	mov    0x8(%ebp),%eax
     608:	0f b6 10             	movzbl (%eax),%edx
     60b:	8b 45 0c             	mov    0xc(%ebp),%eax
     60e:	0f b6 00             	movzbl (%eax),%eax
     611:	38 c2                	cmp    %al,%dl
     613:	74 de                	je     5f3 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     615:	8b 45 08             	mov    0x8(%ebp),%eax
     618:	0f b6 00             	movzbl (%eax),%eax
     61b:	0f b6 d0             	movzbl %al,%edx
     61e:	8b 45 0c             	mov    0xc(%ebp),%eax
     621:	0f b6 00             	movzbl (%eax),%eax
     624:	0f b6 c0             	movzbl %al,%eax
     627:	29 c2                	sub    %eax,%edx
     629:	89 d0                	mov    %edx,%eax
}
     62b:	5d                   	pop    %ebp
     62c:	c3                   	ret    

0000062d <strlen>:

uint
strlen(char *s)
{
     62d:	55                   	push   %ebp
     62e:	89 e5                	mov    %esp,%ebp
     630:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     633:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     63a:	eb 04                	jmp    640 <strlen+0x13>
     63c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     640:	8b 55 fc             	mov    -0x4(%ebp),%edx
     643:	8b 45 08             	mov    0x8(%ebp),%eax
     646:	01 d0                	add    %edx,%eax
     648:	0f b6 00             	movzbl (%eax),%eax
     64b:	84 c0                	test   %al,%al
     64d:	75 ed                	jne    63c <strlen+0xf>
    ;
  return n;
     64f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     652:	c9                   	leave  
     653:	c3                   	ret    

00000654 <memset>:

void*
memset(void *dst, int c, uint n)
{
     654:	55                   	push   %ebp
     655:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     657:	8b 45 10             	mov    0x10(%ebp),%eax
     65a:	50                   	push   %eax
     65b:	ff 75 0c             	pushl  0xc(%ebp)
     65e:	ff 75 08             	pushl  0x8(%ebp)
     661:	e8 32 ff ff ff       	call   598 <stosb>
     666:	83 c4 0c             	add    $0xc,%esp
  return dst;
     669:	8b 45 08             	mov    0x8(%ebp),%eax
}
     66c:	c9                   	leave  
     66d:	c3                   	ret    

0000066e <strchr>:

char*
strchr(const char *s, char c)
{
     66e:	55                   	push   %ebp
     66f:	89 e5                	mov    %esp,%ebp
     671:	83 ec 04             	sub    $0x4,%esp
     674:	8b 45 0c             	mov    0xc(%ebp),%eax
     677:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     67a:	eb 14                	jmp    690 <strchr+0x22>
    if(*s == c)
     67c:	8b 45 08             	mov    0x8(%ebp),%eax
     67f:	0f b6 00             	movzbl (%eax),%eax
     682:	3a 45 fc             	cmp    -0x4(%ebp),%al
     685:	75 05                	jne    68c <strchr+0x1e>
      return (char*)s;
     687:	8b 45 08             	mov    0x8(%ebp),%eax
     68a:	eb 13                	jmp    69f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     68c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     690:	8b 45 08             	mov    0x8(%ebp),%eax
     693:	0f b6 00             	movzbl (%eax),%eax
     696:	84 c0                	test   %al,%al
     698:	75 e2                	jne    67c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     69a:	b8 00 00 00 00       	mov    $0x0,%eax
}
     69f:	c9                   	leave  
     6a0:	c3                   	ret    

000006a1 <gets>:

char*
gets(char *buf, int max)
{
     6a1:	55                   	push   %ebp
     6a2:	89 e5                	mov    %esp,%ebp
     6a4:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     6a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     6ae:	eb 42                	jmp    6f2 <gets+0x51>
    cc = read(0, &c, 1);
     6b0:	83 ec 04             	sub    $0x4,%esp
     6b3:	6a 01                	push   $0x1
     6b5:	8d 45 ef             	lea    -0x11(%ebp),%eax
     6b8:	50                   	push   %eax
     6b9:	6a 00                	push   $0x0
     6bb:	e8 47 01 00 00       	call   807 <read>
     6c0:	83 c4 10             	add    $0x10,%esp
     6c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     6c6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     6ca:	7e 33                	jle    6ff <gets+0x5e>
      break;
    buf[i++] = c;
     6cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6cf:	8d 50 01             	lea    0x1(%eax),%edx
     6d2:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6d5:	89 c2                	mov    %eax,%edx
     6d7:	8b 45 08             	mov    0x8(%ebp),%eax
     6da:	01 c2                	add    %eax,%edx
     6dc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     6e0:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     6e2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     6e6:	3c 0a                	cmp    $0xa,%al
     6e8:	74 16                	je     700 <gets+0x5f>
     6ea:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     6ee:	3c 0d                	cmp    $0xd,%al
     6f0:	74 0e                	je     700 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     6f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6f5:	83 c0 01             	add    $0x1,%eax
     6f8:	3b 45 0c             	cmp    0xc(%ebp),%eax
     6fb:	7c b3                	jl     6b0 <gets+0xf>
     6fd:	eb 01                	jmp    700 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     6ff:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     700:	8b 55 f4             	mov    -0xc(%ebp),%edx
     703:	8b 45 08             	mov    0x8(%ebp),%eax
     706:	01 d0                	add    %edx,%eax
     708:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     70b:	8b 45 08             	mov    0x8(%ebp),%eax
}
     70e:	c9                   	leave  
     70f:	c3                   	ret    

00000710 <stat>:

int
stat(char *n, struct stat *st)
{
     710:	55                   	push   %ebp
     711:	89 e5                	mov    %esp,%ebp
     713:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     716:	83 ec 08             	sub    $0x8,%esp
     719:	6a 00                	push   $0x0
     71b:	ff 75 08             	pushl  0x8(%ebp)
     71e:	e8 0c 01 00 00       	call   82f <open>
     723:	83 c4 10             	add    $0x10,%esp
     726:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     729:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     72d:	79 07                	jns    736 <stat+0x26>
    return -1;
     72f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     734:	eb 25                	jmp    75b <stat+0x4b>
  r = fstat(fd, st);
     736:	83 ec 08             	sub    $0x8,%esp
     739:	ff 75 0c             	pushl  0xc(%ebp)
     73c:	ff 75 f4             	pushl  -0xc(%ebp)
     73f:	e8 03 01 00 00       	call   847 <fstat>
     744:	83 c4 10             	add    $0x10,%esp
     747:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     74a:	83 ec 0c             	sub    $0xc,%esp
     74d:	ff 75 f4             	pushl  -0xc(%ebp)
     750:	e8 c2 00 00 00       	call   817 <close>
     755:	83 c4 10             	add    $0x10,%esp
  return r;
     758:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     75b:	c9                   	leave  
     75c:	c3                   	ret    

0000075d <atoi>:

int
atoi(const char *s)
{
     75d:	55                   	push   %ebp
     75e:	89 e5                	mov    %esp,%ebp
     760:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     763:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     76a:	eb 25                	jmp    791 <atoi+0x34>
    n = n*10 + *s++ - '0';
     76c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     76f:	89 d0                	mov    %edx,%eax
     771:	c1 e0 02             	shl    $0x2,%eax
     774:	01 d0                	add    %edx,%eax
     776:	01 c0                	add    %eax,%eax
     778:	89 c1                	mov    %eax,%ecx
     77a:	8b 45 08             	mov    0x8(%ebp),%eax
     77d:	8d 50 01             	lea    0x1(%eax),%edx
     780:	89 55 08             	mov    %edx,0x8(%ebp)
     783:	0f b6 00             	movzbl (%eax),%eax
     786:	0f be c0             	movsbl %al,%eax
     789:	01 c8                	add    %ecx,%eax
     78b:	83 e8 30             	sub    $0x30,%eax
     78e:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     791:	8b 45 08             	mov    0x8(%ebp),%eax
     794:	0f b6 00             	movzbl (%eax),%eax
     797:	3c 2f                	cmp    $0x2f,%al
     799:	7e 0a                	jle    7a5 <atoi+0x48>
     79b:	8b 45 08             	mov    0x8(%ebp),%eax
     79e:	0f b6 00             	movzbl (%eax),%eax
     7a1:	3c 39                	cmp    $0x39,%al
     7a3:	7e c7                	jle    76c <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     7a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     7a8:	c9                   	leave  
     7a9:	c3                   	ret    

000007aa <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     7aa:	55                   	push   %ebp
     7ab:	89 e5                	mov    %esp,%ebp
     7ad:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     7b0:	8b 45 08             	mov    0x8(%ebp),%eax
     7b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     7b6:	8b 45 0c             	mov    0xc(%ebp),%eax
     7b9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     7bc:	eb 17                	jmp    7d5 <memmove+0x2b>
    *dst++ = *src++;
     7be:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7c1:	8d 50 01             	lea    0x1(%eax),%edx
     7c4:	89 55 fc             	mov    %edx,-0x4(%ebp)
     7c7:	8b 55 f8             	mov    -0x8(%ebp),%edx
     7ca:	8d 4a 01             	lea    0x1(%edx),%ecx
     7cd:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     7d0:	0f b6 12             	movzbl (%edx),%edx
     7d3:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     7d5:	8b 45 10             	mov    0x10(%ebp),%eax
     7d8:	8d 50 ff             	lea    -0x1(%eax),%edx
     7db:	89 55 10             	mov    %edx,0x10(%ebp)
     7de:	85 c0                	test   %eax,%eax
     7e0:	7f dc                	jg     7be <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     7e2:	8b 45 08             	mov    0x8(%ebp),%eax
}
     7e5:	c9                   	leave  
     7e6:	c3                   	ret    

000007e7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     7e7:	b8 01 00 00 00       	mov    $0x1,%eax
     7ec:	cd 40                	int    $0x40
     7ee:	c3                   	ret    

000007ef <exit>:
SYSCALL(exit)
     7ef:	b8 02 00 00 00       	mov    $0x2,%eax
     7f4:	cd 40                	int    $0x40
     7f6:	c3                   	ret    

000007f7 <wait>:
SYSCALL(wait)
     7f7:	b8 03 00 00 00       	mov    $0x3,%eax
     7fc:	cd 40                	int    $0x40
     7fe:	c3                   	ret    

000007ff <pipe>:
SYSCALL(pipe)
     7ff:	b8 04 00 00 00       	mov    $0x4,%eax
     804:	cd 40                	int    $0x40
     806:	c3                   	ret    

00000807 <read>:
SYSCALL(read)
     807:	b8 05 00 00 00       	mov    $0x5,%eax
     80c:	cd 40                	int    $0x40
     80e:	c3                   	ret    

0000080f <write>:
SYSCALL(write)
     80f:	b8 10 00 00 00       	mov    $0x10,%eax
     814:	cd 40                	int    $0x40
     816:	c3                   	ret    

00000817 <close>:
SYSCALL(close)
     817:	b8 15 00 00 00       	mov    $0x15,%eax
     81c:	cd 40                	int    $0x40
     81e:	c3                   	ret    

0000081f <kill>:
SYSCALL(kill)
     81f:	b8 06 00 00 00       	mov    $0x6,%eax
     824:	cd 40                	int    $0x40
     826:	c3                   	ret    

00000827 <exec>:
SYSCALL(exec)
     827:	b8 07 00 00 00       	mov    $0x7,%eax
     82c:	cd 40                	int    $0x40
     82e:	c3                   	ret    

0000082f <open>:
SYSCALL(open)
     82f:	b8 0f 00 00 00       	mov    $0xf,%eax
     834:	cd 40                	int    $0x40
     836:	c3                   	ret    

00000837 <mknod>:
SYSCALL(mknod)
     837:	b8 11 00 00 00       	mov    $0x11,%eax
     83c:	cd 40                	int    $0x40
     83e:	c3                   	ret    

0000083f <unlink>:
SYSCALL(unlink)
     83f:	b8 12 00 00 00       	mov    $0x12,%eax
     844:	cd 40                	int    $0x40
     846:	c3                   	ret    

00000847 <fstat>:
SYSCALL(fstat)
     847:	b8 08 00 00 00       	mov    $0x8,%eax
     84c:	cd 40                	int    $0x40
     84e:	c3                   	ret    

0000084f <link>:
SYSCALL(link)
     84f:	b8 13 00 00 00       	mov    $0x13,%eax
     854:	cd 40                	int    $0x40
     856:	c3                   	ret    

00000857 <mkdir>:
SYSCALL(mkdir)
     857:	b8 14 00 00 00       	mov    $0x14,%eax
     85c:	cd 40                	int    $0x40
     85e:	c3                   	ret    

0000085f <chdir>:
SYSCALL(chdir)
     85f:	b8 09 00 00 00       	mov    $0x9,%eax
     864:	cd 40                	int    $0x40
     866:	c3                   	ret    

00000867 <dup>:
SYSCALL(dup)
     867:	b8 0a 00 00 00       	mov    $0xa,%eax
     86c:	cd 40                	int    $0x40
     86e:	c3                   	ret    

0000086f <getpid>:
SYSCALL(getpid)
     86f:	b8 0b 00 00 00       	mov    $0xb,%eax
     874:	cd 40                	int    $0x40
     876:	c3                   	ret    

00000877 <sbrk>:
SYSCALL(sbrk)
     877:	b8 0c 00 00 00       	mov    $0xc,%eax
     87c:	cd 40                	int    $0x40
     87e:	c3                   	ret    

0000087f <sleep>:
SYSCALL(sleep)
     87f:	b8 0d 00 00 00       	mov    $0xd,%eax
     884:	cd 40                	int    $0x40
     886:	c3                   	ret    

00000887 <uptime>:
SYSCALL(uptime)
     887:	b8 0e 00 00 00       	mov    $0xe,%eax
     88c:	cd 40                	int    $0x40
     88e:	c3                   	ret    

0000088f <paintWindow>:

SYSCALL(paintWindow)
     88f:	b8 16 00 00 00       	mov    $0x16,%eax
     894:	cd 40                	int    $0x40
     896:	c3                   	ret    

00000897 <sendMessage>:
SYSCALL(sendMessage)
     897:	b8 17 00 00 00       	mov    $0x17,%eax
     89c:	cd 40                	int    $0x40
     89e:	c3                   	ret    

0000089f <getMessage>:
SYSCALL(getMessage)
     89f:	b8 19 00 00 00       	mov    $0x19,%eax
     8a4:	cd 40                	int    $0x40
     8a6:	c3                   	ret    

000008a7 <registWindow>:
SYSCALL(registWindow)
     8a7:	b8 18 00 00 00       	mov    $0x18,%eax
     8ac:	cd 40                	int    $0x40
     8ae:	c3                   	ret    

000008af <changePosition>:
SYSCALL(changePosition)
     8af:	b8 1a 00 00 00       	mov    $0x1a,%eax
     8b4:	cd 40                	int    $0x40
     8b6:	c3                   	ret    

000008b7 <setupTimer>:
SYSCALL(setupTimer)
     8b7:	b8 1b 00 00 00       	mov    $0x1b,%eax
     8bc:	cd 40                	int    $0x40
     8be:	c3                   	ret    

000008bf <deleteTimer>:
SYSCALL(deleteTimer)
     8bf:	b8 1c 00 00 00       	mov    $0x1c,%eax
     8c4:	cd 40                	int    $0x40
     8c6:	c3                   	ret    

000008c7 <getCurrentTime>:
SYSCALL(getCurrentTime)
     8c7:	b8 1d 00 00 00       	mov    $0x1d,%eax
     8cc:	cd 40                	int    $0x40
     8ce:	c3                   	ret    

000008cf <removeWindow>:
SYSCALL(removeWindow)
     8cf:	b8 1e 00 00 00       	mov    $0x1e,%eax
     8d4:	cd 40                	int    $0x40
     8d6:	c3                   	ret    

000008d7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     8d7:	55                   	push   %ebp
     8d8:	89 e5                	mov    %esp,%ebp
     8da:	83 ec 18             	sub    $0x18,%esp
     8dd:	8b 45 0c             	mov    0xc(%ebp),%eax
     8e0:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     8e3:	83 ec 04             	sub    $0x4,%esp
     8e6:	6a 01                	push   $0x1
     8e8:	8d 45 f4             	lea    -0xc(%ebp),%eax
     8eb:	50                   	push   %eax
     8ec:	ff 75 08             	pushl  0x8(%ebp)
     8ef:	e8 1b ff ff ff       	call   80f <write>
     8f4:	83 c4 10             	add    $0x10,%esp
}
     8f7:	90                   	nop
     8f8:	c9                   	leave  
     8f9:	c3                   	ret    

000008fa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     8fa:	55                   	push   %ebp
     8fb:	89 e5                	mov    %esp,%ebp
     8fd:	53                   	push   %ebx
     8fe:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     901:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     908:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     90c:	74 17                	je     925 <printint+0x2b>
     90e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     912:	79 11                	jns    925 <printint+0x2b>
    neg = 1;
     914:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     91b:	8b 45 0c             	mov    0xc(%ebp),%eax
     91e:	f7 d8                	neg    %eax
     920:	89 45 ec             	mov    %eax,-0x14(%ebp)
     923:	eb 06                	jmp    92b <printint+0x31>
  } else {
    x = xx;
     925:	8b 45 0c             	mov    0xc(%ebp),%eax
     928:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     92b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     932:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     935:	8d 41 01             	lea    0x1(%ecx),%eax
     938:	89 45 f4             	mov    %eax,-0xc(%ebp)
     93b:	8b 5d 10             	mov    0x10(%ebp),%ebx
     93e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     941:	ba 00 00 00 00       	mov    $0x0,%edx
     946:	f7 f3                	div    %ebx
     948:	89 d0                	mov    %edx,%eax
     94a:	0f b6 80 e0 35 00 00 	movzbl 0x35e0(%eax),%eax
     951:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     955:	8b 5d 10             	mov    0x10(%ebp),%ebx
     958:	8b 45 ec             	mov    -0x14(%ebp),%eax
     95b:	ba 00 00 00 00       	mov    $0x0,%edx
     960:	f7 f3                	div    %ebx
     962:	89 45 ec             	mov    %eax,-0x14(%ebp)
     965:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     969:	75 c7                	jne    932 <printint+0x38>
  if(neg)
     96b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     96f:	74 2d                	je     99e <printint+0xa4>
    buf[i++] = '-';
     971:	8b 45 f4             	mov    -0xc(%ebp),%eax
     974:	8d 50 01             	lea    0x1(%eax),%edx
     977:	89 55 f4             	mov    %edx,-0xc(%ebp)
     97a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     97f:	eb 1d                	jmp    99e <printint+0xa4>
    putc(fd, buf[i]);
     981:	8d 55 dc             	lea    -0x24(%ebp),%edx
     984:	8b 45 f4             	mov    -0xc(%ebp),%eax
     987:	01 d0                	add    %edx,%eax
     989:	0f b6 00             	movzbl (%eax),%eax
     98c:	0f be c0             	movsbl %al,%eax
     98f:	83 ec 08             	sub    $0x8,%esp
     992:	50                   	push   %eax
     993:	ff 75 08             	pushl  0x8(%ebp)
     996:	e8 3c ff ff ff       	call   8d7 <putc>
     99b:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     99e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     9a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     9a6:	79 d9                	jns    981 <printint+0x87>
    putc(fd, buf[i]);
}
     9a8:	90                   	nop
     9a9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9ac:	c9                   	leave  
     9ad:	c3                   	ret    

000009ae <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     9ae:	55                   	push   %ebp
     9af:	89 e5                	mov    %esp,%ebp
     9b1:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     9b4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     9bb:	8d 45 0c             	lea    0xc(%ebp),%eax
     9be:	83 c0 04             	add    $0x4,%eax
     9c1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     9c4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     9cb:	e9 59 01 00 00       	jmp    b29 <printf+0x17b>
    c = fmt[i] & 0xff;
     9d0:	8b 55 0c             	mov    0xc(%ebp),%edx
     9d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9d6:	01 d0                	add    %edx,%eax
     9d8:	0f b6 00             	movzbl (%eax),%eax
     9db:	0f be c0             	movsbl %al,%eax
     9de:	25 ff 00 00 00       	and    $0xff,%eax
     9e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     9e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     9ea:	75 2c                	jne    a18 <printf+0x6a>
      if(c == '%'){
     9ec:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     9f0:	75 0c                	jne    9fe <printf+0x50>
        state = '%';
     9f2:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     9f9:	e9 27 01 00 00       	jmp    b25 <printf+0x177>
      } else {
        putc(fd, c);
     9fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a01:	0f be c0             	movsbl %al,%eax
     a04:	83 ec 08             	sub    $0x8,%esp
     a07:	50                   	push   %eax
     a08:	ff 75 08             	pushl  0x8(%ebp)
     a0b:	e8 c7 fe ff ff       	call   8d7 <putc>
     a10:	83 c4 10             	add    $0x10,%esp
     a13:	e9 0d 01 00 00       	jmp    b25 <printf+0x177>
      }
    } else if(state == '%'){
     a18:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     a1c:	0f 85 03 01 00 00    	jne    b25 <printf+0x177>
      if(c == 'd'){
     a22:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     a26:	75 1e                	jne    a46 <printf+0x98>
        printint(fd, *ap, 10, 1);
     a28:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a2b:	8b 00                	mov    (%eax),%eax
     a2d:	6a 01                	push   $0x1
     a2f:	6a 0a                	push   $0xa
     a31:	50                   	push   %eax
     a32:	ff 75 08             	pushl  0x8(%ebp)
     a35:	e8 c0 fe ff ff       	call   8fa <printint>
     a3a:	83 c4 10             	add    $0x10,%esp
        ap++;
     a3d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     a41:	e9 d8 00 00 00       	jmp    b1e <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     a46:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     a4a:	74 06                	je     a52 <printf+0xa4>
     a4c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     a50:	75 1e                	jne    a70 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     a52:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a55:	8b 00                	mov    (%eax),%eax
     a57:	6a 00                	push   $0x0
     a59:	6a 10                	push   $0x10
     a5b:	50                   	push   %eax
     a5c:	ff 75 08             	pushl  0x8(%ebp)
     a5f:	e8 96 fe ff ff       	call   8fa <printint>
     a64:	83 c4 10             	add    $0x10,%esp
        ap++;
     a67:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     a6b:	e9 ae 00 00 00       	jmp    b1e <printf+0x170>
      } else if(c == 's'){
     a70:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     a74:	75 43                	jne    ab9 <printf+0x10b>
        s = (char*)*ap;
     a76:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a79:	8b 00                	mov    (%eax),%eax
     a7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     a7e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     a82:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a86:	75 25                	jne    aad <printf+0xff>
          s = "(null)";
     a88:	c7 45 f4 48 2b 00 00 	movl   $0x2b48,-0xc(%ebp)
        while(*s != 0){
     a8f:	eb 1c                	jmp    aad <printf+0xff>
          putc(fd, *s);
     a91:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a94:	0f b6 00             	movzbl (%eax),%eax
     a97:	0f be c0             	movsbl %al,%eax
     a9a:	83 ec 08             	sub    $0x8,%esp
     a9d:	50                   	push   %eax
     a9e:	ff 75 08             	pushl  0x8(%ebp)
     aa1:	e8 31 fe ff ff       	call   8d7 <putc>
     aa6:	83 c4 10             	add    $0x10,%esp
          s++;
     aa9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab0:	0f b6 00             	movzbl (%eax),%eax
     ab3:	84 c0                	test   %al,%al
     ab5:	75 da                	jne    a91 <printf+0xe3>
     ab7:	eb 65                	jmp    b1e <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     ab9:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     abd:	75 1d                	jne    adc <printf+0x12e>
        putc(fd, *ap);
     abf:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ac2:	8b 00                	mov    (%eax),%eax
     ac4:	0f be c0             	movsbl %al,%eax
     ac7:	83 ec 08             	sub    $0x8,%esp
     aca:	50                   	push   %eax
     acb:	ff 75 08             	pushl  0x8(%ebp)
     ace:	e8 04 fe ff ff       	call   8d7 <putc>
     ad3:	83 c4 10             	add    $0x10,%esp
        ap++;
     ad6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     ada:	eb 42                	jmp    b1e <printf+0x170>
      } else if(c == '%'){
     adc:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     ae0:	75 17                	jne    af9 <printf+0x14b>
        putc(fd, c);
     ae2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ae5:	0f be c0             	movsbl %al,%eax
     ae8:	83 ec 08             	sub    $0x8,%esp
     aeb:	50                   	push   %eax
     aec:	ff 75 08             	pushl  0x8(%ebp)
     aef:	e8 e3 fd ff ff       	call   8d7 <putc>
     af4:	83 c4 10             	add    $0x10,%esp
     af7:	eb 25                	jmp    b1e <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     af9:	83 ec 08             	sub    $0x8,%esp
     afc:	6a 25                	push   $0x25
     afe:	ff 75 08             	pushl  0x8(%ebp)
     b01:	e8 d1 fd ff ff       	call   8d7 <putc>
     b06:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     b09:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b0c:	0f be c0             	movsbl %al,%eax
     b0f:	83 ec 08             	sub    $0x8,%esp
     b12:	50                   	push   %eax
     b13:	ff 75 08             	pushl  0x8(%ebp)
     b16:	e8 bc fd ff ff       	call   8d7 <putc>
     b1b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     b1e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     b25:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b29:	8b 55 0c             	mov    0xc(%ebp),%edx
     b2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b2f:	01 d0                	add    %edx,%eax
     b31:	0f b6 00             	movzbl (%eax),%eax
     b34:	84 c0                	test   %al,%al
     b36:	0f 85 94 fe ff ff    	jne    9d0 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     b3c:	90                   	nop
     b3d:	c9                   	leave  
     b3e:	c3                   	ret    

00000b3f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     b3f:	55                   	push   %ebp
     b40:	89 e5                	mov    %esp,%ebp
     b42:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     b45:	8b 45 08             	mov    0x8(%ebp),%eax
     b48:	83 e8 08             	sub    $0x8,%eax
     b4b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b4e:	a1 40 72 00 00       	mov    0x7240,%eax
     b53:	89 45 fc             	mov    %eax,-0x4(%ebp)
     b56:	eb 24                	jmp    b7c <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     b58:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b5b:	8b 00                	mov    (%eax),%eax
     b5d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     b60:	77 12                	ja     b74 <free+0x35>
     b62:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b65:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     b68:	77 24                	ja     b8e <free+0x4f>
     b6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b6d:	8b 00                	mov    (%eax),%eax
     b6f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     b72:	77 1a                	ja     b8e <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b74:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b77:	8b 00                	mov    (%eax),%eax
     b79:	89 45 fc             	mov    %eax,-0x4(%ebp)
     b7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b7f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     b82:	76 d4                	jbe    b58 <free+0x19>
     b84:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b87:	8b 00                	mov    (%eax),%eax
     b89:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     b8c:	76 ca                	jbe    b58 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     b8e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b91:	8b 40 04             	mov    0x4(%eax),%eax
     b94:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     b9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b9e:	01 c2                	add    %eax,%edx
     ba0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ba3:	8b 00                	mov    (%eax),%eax
     ba5:	39 c2                	cmp    %eax,%edx
     ba7:	75 24                	jne    bcd <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     ba9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     bac:	8b 50 04             	mov    0x4(%eax),%edx
     baf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bb2:	8b 00                	mov    (%eax),%eax
     bb4:	8b 40 04             	mov    0x4(%eax),%eax
     bb7:	01 c2                	add    %eax,%edx
     bb9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     bbc:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     bbf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bc2:	8b 00                	mov    (%eax),%eax
     bc4:	8b 10                	mov    (%eax),%edx
     bc6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     bc9:	89 10                	mov    %edx,(%eax)
     bcb:	eb 0a                	jmp    bd7 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     bcd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bd0:	8b 10                	mov    (%eax),%edx
     bd2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     bd5:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     bd7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bda:	8b 40 04             	mov    0x4(%eax),%eax
     bdd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     be4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     be7:	01 d0                	add    %edx,%eax
     be9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     bec:	75 20                	jne    c0e <free+0xcf>
    p->s.size += bp->s.size;
     bee:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bf1:	8b 50 04             	mov    0x4(%eax),%edx
     bf4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     bf7:	8b 40 04             	mov    0x4(%eax),%eax
     bfa:	01 c2                	add    %eax,%edx
     bfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     c02:	8b 45 f8             	mov    -0x8(%ebp),%eax
     c05:	8b 10                	mov    (%eax),%edx
     c07:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c0a:	89 10                	mov    %edx,(%eax)
     c0c:	eb 08                	jmp    c16 <free+0xd7>
  } else
    p->s.ptr = bp;
     c0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c11:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c14:	89 10                	mov    %edx,(%eax)
  freep = p;
     c16:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c19:	a3 40 72 00 00       	mov    %eax,0x7240
}
     c1e:	90                   	nop
     c1f:	c9                   	leave  
     c20:	c3                   	ret    

00000c21 <morecore>:

static Header*
morecore(uint nu)
{
     c21:	55                   	push   %ebp
     c22:	89 e5                	mov    %esp,%ebp
     c24:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     c27:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     c2e:	77 07                	ja     c37 <morecore+0x16>
    nu = 4096;
     c30:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     c37:	8b 45 08             	mov    0x8(%ebp),%eax
     c3a:	c1 e0 03             	shl    $0x3,%eax
     c3d:	83 ec 0c             	sub    $0xc,%esp
     c40:	50                   	push   %eax
     c41:	e8 31 fc ff ff       	call   877 <sbrk>
     c46:	83 c4 10             	add    $0x10,%esp
     c49:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     c4c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     c50:	75 07                	jne    c59 <morecore+0x38>
    return 0;
     c52:	b8 00 00 00 00       	mov    $0x0,%eax
     c57:	eb 26                	jmp    c7f <morecore+0x5e>
  hp = (Header*)p;
     c59:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     c5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c62:	8b 55 08             	mov    0x8(%ebp),%edx
     c65:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     c68:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c6b:	83 c0 08             	add    $0x8,%eax
     c6e:	83 ec 0c             	sub    $0xc,%esp
     c71:	50                   	push   %eax
     c72:	e8 c8 fe ff ff       	call   b3f <free>
     c77:	83 c4 10             	add    $0x10,%esp
  return freep;
     c7a:	a1 40 72 00 00       	mov    0x7240,%eax
}
     c7f:	c9                   	leave  
     c80:	c3                   	ret    

00000c81 <malloc>:

void*
malloc(uint nbytes)
{
     c81:	55                   	push   %ebp
     c82:	89 e5                	mov    %esp,%ebp
     c84:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     c87:	8b 45 08             	mov    0x8(%ebp),%eax
     c8a:	83 c0 07             	add    $0x7,%eax
     c8d:	c1 e8 03             	shr    $0x3,%eax
     c90:	83 c0 01             	add    $0x1,%eax
     c93:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     c96:	a1 40 72 00 00       	mov    0x7240,%eax
     c9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c9e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     ca2:	75 23                	jne    cc7 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     ca4:	c7 45 f0 38 72 00 00 	movl   $0x7238,-0x10(%ebp)
     cab:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cae:	a3 40 72 00 00       	mov    %eax,0x7240
     cb3:	a1 40 72 00 00       	mov    0x7240,%eax
     cb8:	a3 38 72 00 00       	mov    %eax,0x7238
    base.s.size = 0;
     cbd:	c7 05 3c 72 00 00 00 	movl   $0x0,0x723c
     cc4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     cc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cca:	8b 00                	mov    (%eax),%eax
     ccc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     ccf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cd2:	8b 40 04             	mov    0x4(%eax),%eax
     cd5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     cd8:	72 4d                	jb     d27 <malloc+0xa6>
      if(p->s.size == nunits)
     cda:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cdd:	8b 40 04             	mov    0x4(%eax),%eax
     ce0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     ce3:	75 0c                	jne    cf1 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     ce5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce8:	8b 10                	mov    (%eax),%edx
     cea:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ced:	89 10                	mov    %edx,(%eax)
     cef:	eb 26                	jmp    d17 <malloc+0x96>
      else {
        p->s.size -= nunits;
     cf1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf4:	8b 40 04             	mov    0x4(%eax),%eax
     cf7:	2b 45 ec             	sub    -0x14(%ebp),%eax
     cfa:	89 c2                	mov    %eax,%edx
     cfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cff:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     d02:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d05:	8b 40 04             	mov    0x4(%eax),%eax
     d08:	c1 e0 03             	shl    $0x3,%eax
     d0b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     d0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d11:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d14:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     d17:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d1a:	a3 40 72 00 00       	mov    %eax,0x7240
      return (void*)(p + 1);
     d1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d22:	83 c0 08             	add    $0x8,%eax
     d25:	eb 3b                	jmp    d62 <malloc+0xe1>
    }
    if(p == freep)
     d27:	a1 40 72 00 00       	mov    0x7240,%eax
     d2c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     d2f:	75 1e                	jne    d4f <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     d31:	83 ec 0c             	sub    $0xc,%esp
     d34:	ff 75 ec             	pushl  -0x14(%ebp)
     d37:	e8 e5 fe ff ff       	call   c21 <morecore>
     d3c:	83 c4 10             	add    $0x10,%esp
     d3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d42:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     d46:	75 07                	jne    d4f <malloc+0xce>
        return 0;
     d48:	b8 00 00 00 00       	mov    $0x0,%eax
     d4d:	eb 13                	jmp    d62 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d52:	89 45 f0             	mov    %eax,-0x10(%ebp)
     d55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d58:	8b 00                	mov    (%eax),%eax
     d5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     d5d:	e9 6d ff ff ff       	jmp    ccf <malloc+0x4e>
}
     d62:	c9                   	leave  
     d63:	c3                   	ret    

00000d64 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     d64:	55                   	push   %ebp
     d65:	89 e5                	mov    %esp,%ebp
     d67:	83 ec 1c             	sub    $0x1c,%esp
     d6a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     d6d:	8b 55 10             	mov    0x10(%ebp),%edx
     d70:	8b 45 14             	mov    0x14(%ebp),%eax
     d73:	88 4d ec             	mov    %cl,-0x14(%ebp)
     d76:	88 55 e8             	mov    %dl,-0x18(%ebp)
     d79:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     d7c:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     d80:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     d83:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     d87:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     d8a:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     d8e:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     d91:	8b 45 08             	mov    0x8(%ebp),%eax
     d94:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d98:	66 89 10             	mov    %dx,(%eax)
     d9b:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d9f:	88 50 02             	mov    %dl,0x2(%eax)
}
     da2:	8b 45 08             	mov    0x8(%ebp),%eax
     da5:	c9                   	leave  
     da6:	c2 04 00             	ret    $0x4

00000da9 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     da9:	55                   	push   %ebp
     daa:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     dac:	8b 45 08             	mov    0x8(%ebp),%eax
     daf:	2b 45 10             	sub    0x10(%ebp),%eax
     db2:	89 c2                	mov    %eax,%edx
     db4:	8b 45 08             	mov    0x8(%ebp),%eax
     db7:	2b 45 10             	sub    0x10(%ebp),%eax
     dba:	0f af d0             	imul   %eax,%edx
     dbd:	8b 45 0c             	mov    0xc(%ebp),%eax
     dc0:	2b 45 14             	sub    0x14(%ebp),%eax
     dc3:	89 c1                	mov    %eax,%ecx
     dc5:	8b 45 0c             	mov    0xc(%ebp),%eax
     dc8:	2b 45 14             	sub    0x14(%ebp),%eax
     dcb:	0f af c1             	imul   %ecx,%eax
     dce:	01 d0                	add    %edx,%eax
}
     dd0:	5d                   	pop    %ebp
     dd1:	c3                   	ret    

00000dd2 <abs_int>:

static inline int abs_int(int x)
{
     dd2:	55                   	push   %ebp
     dd3:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     dd5:	8b 45 08             	mov    0x8(%ebp),%eax
     dd8:	99                   	cltd   
     dd9:	89 d0                	mov    %edx,%eax
     ddb:	33 45 08             	xor    0x8(%ebp),%eax
     dde:	29 d0                	sub    %edx,%eax
}
     de0:	5d                   	pop    %ebp
     de1:	c3                   	ret    

00000de2 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     de2:	55                   	push   %ebp
     de3:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     de5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     de9:	79 07                	jns    df2 <APGetIndex+0x10>
        return X_SMALLER;
     deb:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     df0:	eb 40                	jmp    e32 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     df2:	8b 45 08             	mov    0x8(%ebp),%eax
     df5:	8b 00                	mov    (%eax),%eax
     df7:	3b 45 0c             	cmp    0xc(%ebp),%eax
     dfa:	7f 07                	jg     e03 <APGetIndex+0x21>
        return X_BIGGER;
     dfc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     e01:	eb 2f                	jmp    e32 <APGetIndex+0x50>
    if (y < 0)
     e03:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e07:	79 07                	jns    e10 <APGetIndex+0x2e>
        return Y_SMALLER;
     e09:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     e0e:	eb 22                	jmp    e32 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     e10:	8b 45 08             	mov    0x8(%ebp),%eax
     e13:	8b 40 04             	mov    0x4(%eax),%eax
     e16:	3b 45 10             	cmp    0x10(%ebp),%eax
     e19:	7f 07                	jg     e22 <APGetIndex+0x40>
        return Y_BIGGER;
     e1b:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     e20:	eb 10                	jmp    e32 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     e22:	8b 45 08             	mov    0x8(%ebp),%eax
     e25:	8b 00                	mov    (%eax),%eax
     e27:	0f af 45 10          	imul   0x10(%ebp),%eax
     e2b:	89 c2                	mov    %eax,%edx
     e2d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e30:	01 d0                	add    %edx,%eax
}
     e32:	5d                   	pop    %ebp
     e33:	c3                   	ret    

00000e34 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     e34:	55                   	push   %ebp
     e35:	89 e5                	mov    %esp,%ebp
     e37:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     e3a:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     e41:	8b 45 cc             	mov    -0x34(%ebp),%eax
     e44:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     e47:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     e4e:	83 ec 08             	sub    $0x8,%esp
     e51:	6a 00                	push   $0x0
     e53:	ff 75 0c             	pushl  0xc(%ebp)
     e56:	e8 d4 f9 ff ff       	call   82f <open>
     e5b:	83 c4 10             	add    $0x10,%esp
     e5e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     e61:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     e65:	79 2e                	jns    e95 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     e67:	83 ec 04             	sub    $0x4,%esp
     e6a:	ff 75 0c             	pushl  0xc(%ebp)
     e6d:	68 4f 2b 00 00       	push   $0x2b4f
     e72:	6a 01                	push   $0x1
     e74:	e8 35 fb ff ff       	call   9ae <printf>
     e79:	83 c4 10             	add    $0x10,%esp
        return bmp;
     e7c:	8b 45 08             	mov    0x8(%ebp),%eax
     e7f:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e82:	89 10                	mov    %edx,(%eax)
     e84:	8b 55 cc             	mov    -0x34(%ebp),%edx
     e87:	89 50 04             	mov    %edx,0x4(%eax)
     e8a:	8b 55 d0             	mov    -0x30(%ebp),%edx
     e8d:	89 50 08             	mov    %edx,0x8(%eax)
     e90:	e9 d2 01 00 00       	jmp    1067 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     e95:	83 ec 04             	sub    $0x4,%esp
     e98:	6a 0e                	push   $0xe
     e9a:	8d 45 ba             	lea    -0x46(%ebp),%eax
     e9d:	50                   	push   %eax
     e9e:	ff 75 ec             	pushl  -0x14(%ebp)
     ea1:	e8 61 f9 ff ff       	call   807 <read>
     ea6:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     ea9:	83 ec 04             	sub    $0x4,%esp
     eac:	6a 28                	push   $0x28
     eae:	8d 45 92             	lea    -0x6e(%ebp),%eax
     eb1:	50                   	push   %eax
     eb2:	ff 75 ec             	pushl  -0x14(%ebp)
     eb5:	e8 4d f9 ff ff       	call   807 <read>
     eba:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     ebd:	8b 45 96             	mov    -0x6a(%ebp),%eax
     ec0:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     ec3:	8b 45 9a             	mov    -0x66(%ebp),%eax
     ec6:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     ec9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ecc:	8b 45 cc             	mov    -0x34(%ebp),%eax
     ecf:	0f af d0             	imul   %eax,%edx
     ed2:	89 d0                	mov    %edx,%eax
     ed4:	01 c0                	add    %eax,%eax
     ed6:	01 d0                	add    %edx,%eax
     ed8:	83 ec 0c             	sub    $0xc,%esp
     edb:	50                   	push   %eax
     edc:	e8 a0 fd ff ff       	call   c81 <malloc>
     ee1:	83 c4 10             	add    $0x10,%esp
     ee4:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     ee7:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     eeb:	0f b7 c0             	movzwl %ax,%eax
     eee:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     ef1:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ef4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ef7:	0f af c2             	imul   %edx,%eax
     efa:	83 c0 1f             	add    $0x1f,%eax
     efd:	c1 e8 05             	shr    $0x5,%eax
     f00:	c1 e0 02             	shl    $0x2,%eax
     f03:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     f06:	8b 55 cc             	mov    -0x34(%ebp),%edx
     f09:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f0c:	0f af c2             	imul   %edx,%eax
     f0f:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     f12:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f15:	83 ec 0c             	sub    $0xc,%esp
     f18:	50                   	push   %eax
     f19:	e8 63 fd ff ff       	call   c81 <malloc>
     f1e:	83 c4 10             	add    $0x10,%esp
     f21:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     f24:	83 ec 04             	sub    $0x4,%esp
     f27:	ff 75 e0             	pushl  -0x20(%ebp)
     f2a:	ff 75 dc             	pushl  -0x24(%ebp)
     f2d:	ff 75 ec             	pushl  -0x14(%ebp)
     f30:	e8 d2 f8 ff ff       	call   807 <read>
     f35:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     f38:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     f3c:	66 c1 e8 03          	shr    $0x3,%ax
     f40:	0f b7 c0             	movzwl %ax,%eax
     f43:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     f46:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     f4d:	e9 e5 00 00 00       	jmp    1037 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     f52:	8b 55 cc             	mov    -0x34(%ebp),%edx
     f55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f58:	29 c2                	sub    %eax,%edx
     f5a:	89 d0                	mov    %edx,%eax
     f5c:	8d 50 ff             	lea    -0x1(%eax),%edx
     f5f:	8b 45 c8             	mov    -0x38(%ebp),%eax
     f62:	0f af c2             	imul   %edx,%eax
     f65:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     f68:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     f6f:	e9 b1 00 00 00       	jmp    1025 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     f74:	8b 55 d0             	mov    -0x30(%ebp),%edx
     f77:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     f7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f7d:	01 c8                	add    %ecx,%eax
     f7f:	89 c1                	mov    %eax,%ecx
     f81:	89 c8                	mov    %ecx,%eax
     f83:	01 c0                	add    %eax,%eax
     f85:	01 c8                	add    %ecx,%eax
     f87:	01 c2                	add    %eax,%edx
     f89:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f8c:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     f90:	89 c1                	mov    %eax,%ecx
     f92:	8b 45 d8             	mov    -0x28(%ebp),%eax
     f95:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     f99:	01 c1                	add    %eax,%ecx
     f9b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     f9e:	01 c8                	add    %ecx,%eax
     fa0:	8d 48 ff             	lea    -0x1(%eax),%ecx
     fa3:	8b 45 dc             	mov    -0x24(%ebp),%eax
     fa6:	01 c8                	add    %ecx,%eax
     fa8:	0f b6 00             	movzbl (%eax),%eax
     fab:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     fae:	8b 55 d0             	mov    -0x30(%ebp),%edx
     fb1:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     fb4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fb7:	01 c8                	add    %ecx,%eax
     fb9:	89 c1                	mov    %eax,%ecx
     fbb:	89 c8                	mov    %ecx,%eax
     fbd:	01 c0                	add    %eax,%eax
     fbf:	01 c8                	add    %ecx,%eax
     fc1:	01 c2                	add    %eax,%edx
     fc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fc6:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     fca:	89 c1                	mov    %eax,%ecx
     fcc:	8b 45 d8             	mov    -0x28(%ebp),%eax
     fcf:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     fd3:	01 c1                	add    %eax,%ecx
     fd5:	8b 45 d8             	mov    -0x28(%ebp),%eax
     fd8:	01 c8                	add    %ecx,%eax
     fda:	8d 48 fe             	lea    -0x2(%eax),%ecx
     fdd:	8b 45 dc             	mov    -0x24(%ebp),%eax
     fe0:	01 c8                	add    %ecx,%eax
     fe2:	0f b6 00             	movzbl (%eax),%eax
     fe5:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     fe8:	8b 55 d0             	mov    -0x30(%ebp),%edx
     feb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     fee:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ff1:	01 c8                	add    %ecx,%eax
     ff3:	89 c1                	mov    %eax,%ecx
     ff5:	89 c8                	mov    %ecx,%eax
     ff7:	01 c0                	add    %eax,%eax
     ff9:	01 c8                	add    %ecx,%eax
     ffb:	01 c2                	add    %eax,%edx
     ffd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1000:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    1004:	89 c1                	mov    %eax,%ecx
    1006:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1009:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    100d:	01 c1                	add    %eax,%ecx
    100f:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1012:	01 c8                	add    %ecx,%eax
    1014:	8d 48 fd             	lea    -0x3(%eax),%ecx
    1017:	8b 45 dc             	mov    -0x24(%ebp),%eax
    101a:	01 c8                	add    %ecx,%eax
    101c:	0f b6 00             	movzbl (%eax),%eax
    101f:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    1021:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1025:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1028:	8b 45 f0             	mov    -0x10(%ebp),%eax
    102b:	39 c2                	cmp    %eax,%edx
    102d:	0f 87 41 ff ff ff    	ja     f74 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    1033:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1037:	8b 55 cc             	mov    -0x34(%ebp),%edx
    103a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    103d:	39 c2                	cmp    %eax,%edx
    103f:	0f 87 0d ff ff ff    	ja     f52 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    1045:	83 ec 0c             	sub    $0xc,%esp
    1048:	ff 75 ec             	pushl  -0x14(%ebp)
    104b:	e8 c7 f7 ff ff       	call   817 <close>
    1050:	83 c4 10             	add    $0x10,%esp
    return bmp;
    1053:	8b 45 08             	mov    0x8(%ebp),%eax
    1056:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1059:	89 10                	mov    %edx,(%eax)
    105b:	8b 55 cc             	mov    -0x34(%ebp),%edx
    105e:	89 50 04             	mov    %edx,0x4(%eax)
    1061:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1064:	89 50 08             	mov    %edx,0x8(%eax)
}
    1067:	8b 45 08             	mov    0x8(%ebp),%eax
    106a:	c9                   	leave  
    106b:	c2 04 00             	ret    $0x4

0000106e <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    106e:	55                   	push   %ebp
    106f:	89 e5                	mov    %esp,%ebp
    1071:	53                   	push   %ebx
    1072:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    1075:	83 ec 0c             	sub    $0xc,%esp
    1078:	6a 1c                	push   $0x1c
    107a:	e8 02 fc ff ff       	call   c81 <malloc>
    107f:	83 c4 10             	add    $0x10,%esp
    1082:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    1085:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1088:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    108f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    1092:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1095:	6a 0c                	push   $0xc
    1097:	6a 0c                	push   $0xc
    1099:	6a 0c                	push   $0xc
    109b:	50                   	push   %eax
    109c:	e8 c3 fc ff ff       	call   d64 <RGB>
    10a1:	83 c4 0c             	add    $0xc,%esp
    10a4:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    10a8:	66 89 43 13          	mov    %ax,0x13(%ebx)
    10ac:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    10b0:	88 43 15             	mov    %al,0x15(%ebx)
    10b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    10b9:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    10bd:	66 89 48 10          	mov    %cx,0x10(%eax)
    10c1:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    10c5:	88 50 12             	mov    %dl,0x12(%eax)
    10c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
    10ce:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    10d2:	66 89 48 08          	mov    %cx,0x8(%eax)
    10d6:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    10da:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    10dd:	8b 45 08             	mov    0x8(%ebp),%eax
    10e0:	89 c2                	mov    %eax,%edx
    10e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10e5:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    10e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ea:	89 c2                	mov    %eax,%edx
    10ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10ef:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    10f2:	8b 55 10             	mov    0x10(%ebp),%edx
    10f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10f8:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    10fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    10fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1101:	c9                   	leave  
    1102:	c3                   	ret    

00001103 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    1103:	55                   	push   %ebp
    1104:	89 e5                	mov    %esp,%ebp
    1106:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    1109:	8b 45 0c             	mov    0xc(%ebp),%eax
    110c:	8b 50 08             	mov    0x8(%eax),%edx
    110f:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1112:	8b 40 0c             	mov    0xc(%eax),%eax
    1115:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    1118:	8b 45 0c             	mov    0xc(%ebp),%eax
    111b:	8b 55 10             	mov    0x10(%ebp),%edx
    111e:	89 50 08             	mov    %edx,0x8(%eax)
    1121:	8b 55 14             	mov    0x14(%ebp),%edx
    1124:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    1127:	8b 45 08             	mov    0x8(%ebp),%eax
    112a:	8b 55 f8             	mov    -0x8(%ebp),%edx
    112d:	89 10                	mov    %edx,(%eax)
    112f:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1132:	89 50 04             	mov    %edx,0x4(%eax)
}
    1135:	8b 45 08             	mov    0x8(%ebp),%eax
    1138:	c9                   	leave  
    1139:	c2 04 00             	ret    $0x4

0000113c <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    113c:	55                   	push   %ebp
    113d:	89 e5                	mov    %esp,%ebp
    113f:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    1142:	8b 45 0c             	mov    0xc(%ebp),%eax
    1145:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    1149:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    114d:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1151:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    1154:	8b 45 0c             	mov    0xc(%ebp),%eax
    1157:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    115b:	66 89 50 10          	mov    %dx,0x10(%eax)
    115f:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    1163:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    1166:	8b 45 08             	mov    0x8(%ebp),%eax
    1169:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    116d:	66 89 10             	mov    %dx,(%eax)
    1170:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1174:	88 50 02             	mov    %dl,0x2(%eax)
}
    1177:	8b 45 08             	mov    0x8(%ebp),%eax
    117a:	c9                   	leave  
    117b:	c2 04 00             	ret    $0x4

0000117e <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
    117e:	55                   	push   %ebp
    117f:	89 e5                	mov    %esp,%ebp
    1181:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
    1184:	8b 45 0c             	mov    0xc(%ebp),%eax
    1187:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    118b:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    118f:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1193:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
    1196:	8b 45 0c             	mov    0xc(%ebp),%eax
    1199:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    119d:	66 89 50 13          	mov    %dx,0x13(%eax)
    11a1:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    11a5:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
    11a8:	8b 45 08             	mov    0x8(%ebp),%eax
    11ab:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    11af:	66 89 10             	mov    %dx,(%eax)
    11b2:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    11b6:	88 50 02             	mov    %dl,0x2(%eax)
}
    11b9:	8b 45 08             	mov    0x8(%ebp),%eax
    11bc:	c9                   	leave  
    11bd:	c2 04 00             	ret    $0x4

000011c0 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    11c6:	8b 45 08             	mov    0x8(%ebp),%eax
    11c9:	8b 40 0c             	mov    0xc(%eax),%eax
    11cc:	89 c2                	mov    %eax,%edx
    11ce:	c1 ea 1f             	shr    $0x1f,%edx
    11d1:	01 d0                	add    %edx,%eax
    11d3:	d1 f8                	sar    %eax
    11d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    11d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11db:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    11df:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    11e2:	8b 45 10             	mov    0x10(%ebp),%eax
    11e5:	2b 45 f4             	sub    -0xc(%ebp),%eax
    11e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    11eb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    11ef:	0f 89 98 00 00 00    	jns    128d <APDrawPoint+0xcd>
        i = 0;
    11f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    11fc:	e9 8c 00 00 00       	jmp    128d <APDrawPoint+0xcd>
    {
        j = x - off;
    1201:	8b 45 0c             	mov    0xc(%ebp),%eax
    1204:	2b 45 f4             	sub    -0xc(%ebp),%eax
    1207:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    120a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    120e:	79 69                	jns    1279 <APDrawPoint+0xb9>
            j = 0;
    1210:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    1217:	eb 60                	jmp    1279 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    1219:	ff 75 fc             	pushl  -0x4(%ebp)
    121c:	ff 75 f8             	pushl  -0x8(%ebp)
    121f:	ff 75 08             	pushl  0x8(%ebp)
    1222:	e8 bb fb ff ff       	call   de2 <APGetIndex>
    1227:	83 c4 0c             	add    $0xc,%esp
    122a:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    122d:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    1231:	74 55                	je     1288 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    1233:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    1237:	74 67                	je     12a0 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    1239:	ff 75 10             	pushl  0x10(%ebp)
    123c:	ff 75 0c             	pushl  0xc(%ebp)
    123f:	ff 75 fc             	pushl  -0x4(%ebp)
    1242:	ff 75 f8             	pushl  -0x8(%ebp)
    1245:	e8 5f fb ff ff       	call   da9 <distance_2>
    124a:	83 c4 10             	add    $0x10,%esp
    124d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1250:	7f 23                	jg     1275 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    1252:	8b 45 08             	mov    0x8(%ebp),%eax
    1255:	8b 48 18             	mov    0x18(%eax),%ecx
    1258:	8b 55 ec             	mov    -0x14(%ebp),%edx
    125b:	89 d0                	mov    %edx,%eax
    125d:	01 c0                	add    %eax,%eax
    125f:	01 d0                	add    %edx,%eax
    1261:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1264:	8b 45 08             	mov    0x8(%ebp),%eax
    1267:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    126b:	66 89 0a             	mov    %cx,(%edx)
    126e:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1272:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1275:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1279:	8b 55 0c             	mov    0xc(%ebp),%edx
    127c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    127f:	01 d0                	add    %edx,%eax
    1281:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1284:	7d 93                	jge    1219 <APDrawPoint+0x59>
    1286:	eb 01                	jmp    1289 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1288:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1289:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    128d:	8b 55 10             	mov    0x10(%ebp),%edx
    1290:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1293:	01 d0                	add    %edx,%eax
    1295:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1298:	0f 8d 63 ff ff ff    	jge    1201 <APDrawPoint+0x41>
    129e:	eb 01                	jmp    12a1 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    12a0:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    12a1:	c9                   	leave  
    12a2:	c3                   	ret    

000012a3 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    12a3:	55                   	push   %ebp
    12a4:	89 e5                	mov    %esp,%ebp
    12a6:	53                   	push   %ebx
    12a7:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    12aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ad:	3b 45 14             	cmp    0x14(%ebp),%eax
    12b0:	0f 85 80 00 00 00    	jne    1336 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    12b6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12ba:	0f 88 9d 02 00 00    	js     155d <APDrawLine+0x2ba>
    12c0:	8b 45 08             	mov    0x8(%ebp),%eax
    12c3:	8b 00                	mov    (%eax),%eax
    12c5:	3b 45 0c             	cmp    0xc(%ebp),%eax
    12c8:	0f 8e 8f 02 00 00    	jle    155d <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    12ce:	8b 45 10             	mov    0x10(%ebp),%eax
    12d1:	3b 45 18             	cmp    0x18(%ebp),%eax
    12d4:	7e 12                	jle    12e8 <APDrawLine+0x45>
        {
            int tmp = y2;
    12d6:	8b 45 18             	mov    0x18(%ebp),%eax
    12d9:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    12dc:	8b 45 10             	mov    0x10(%ebp),%eax
    12df:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    12e2:	8b 45 dc             	mov    -0x24(%ebp),%eax
    12e5:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    12e8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12ec:	79 07                	jns    12f5 <APDrawLine+0x52>
    12ee:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    12f5:	8b 45 08             	mov    0x8(%ebp),%eax
    12f8:	8b 40 04             	mov    0x4(%eax),%eax
    12fb:	3b 45 18             	cmp    0x18(%ebp),%eax
    12fe:	7d 0c                	jge    130c <APDrawLine+0x69>
    1300:	8b 45 08             	mov    0x8(%ebp),%eax
    1303:	8b 40 04             	mov    0x4(%eax),%eax
    1306:	83 e8 01             	sub    $0x1,%eax
    1309:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    130c:	8b 45 10             	mov    0x10(%ebp),%eax
    130f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1312:	eb 15                	jmp    1329 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1314:	ff 75 f4             	pushl  -0xc(%ebp)
    1317:	ff 75 0c             	pushl  0xc(%ebp)
    131a:	ff 75 08             	pushl  0x8(%ebp)
    131d:	e8 9e fe ff ff       	call   11c0 <APDrawPoint>
    1322:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1325:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1329:	8b 45 f4             	mov    -0xc(%ebp),%eax
    132c:	3b 45 18             	cmp    0x18(%ebp),%eax
    132f:	7e e3                	jle    1314 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    1331:	e9 2b 02 00 00       	jmp    1561 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1336:	8b 45 10             	mov    0x10(%ebp),%eax
    1339:	3b 45 18             	cmp    0x18(%ebp),%eax
    133c:	75 7f                	jne    13bd <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    133e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1342:	0f 88 18 02 00 00    	js     1560 <APDrawLine+0x2bd>
    1348:	8b 45 08             	mov    0x8(%ebp),%eax
    134b:	8b 40 04             	mov    0x4(%eax),%eax
    134e:	3b 45 10             	cmp    0x10(%ebp),%eax
    1351:	0f 8e 09 02 00 00    	jle    1560 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1357:	8b 45 0c             	mov    0xc(%ebp),%eax
    135a:	3b 45 14             	cmp    0x14(%ebp),%eax
    135d:	7e 12                	jle    1371 <APDrawLine+0xce>
        {
            int tmp = x2;
    135f:	8b 45 14             	mov    0x14(%ebp),%eax
    1362:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1365:	8b 45 0c             	mov    0xc(%ebp),%eax
    1368:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    136b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    136e:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1371:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1375:	79 07                	jns    137e <APDrawLine+0xdb>
    1377:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    137e:	8b 45 08             	mov    0x8(%ebp),%eax
    1381:	8b 00                	mov    (%eax),%eax
    1383:	3b 45 14             	cmp    0x14(%ebp),%eax
    1386:	7d 0b                	jge    1393 <APDrawLine+0xf0>
    1388:	8b 45 08             	mov    0x8(%ebp),%eax
    138b:	8b 00                	mov    (%eax),%eax
    138d:	83 e8 01             	sub    $0x1,%eax
    1390:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1393:	8b 45 0c             	mov    0xc(%ebp),%eax
    1396:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1399:	eb 15                	jmp    13b0 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    139b:	ff 75 10             	pushl  0x10(%ebp)
    139e:	ff 75 f0             	pushl  -0x10(%ebp)
    13a1:	ff 75 08             	pushl  0x8(%ebp)
    13a4:	e8 17 fe ff ff       	call   11c0 <APDrawPoint>
    13a9:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    13ac:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13b3:	3b 45 14             	cmp    0x14(%ebp),%eax
    13b6:	7e e3                	jle    139b <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    13b8:	e9 a4 01 00 00       	jmp    1561 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    13bd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    13c4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    13cb:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ce:	2b 45 14             	sub    0x14(%ebp),%eax
    13d1:	50                   	push   %eax
    13d2:	e8 fb f9 ff ff       	call   dd2 <abs_int>
    13d7:	83 c4 04             	add    $0x4,%esp
    13da:	89 c3                	mov    %eax,%ebx
    13dc:	8b 45 10             	mov    0x10(%ebp),%eax
    13df:	2b 45 18             	sub    0x18(%ebp),%eax
    13e2:	50                   	push   %eax
    13e3:	e8 ea f9 ff ff       	call   dd2 <abs_int>
    13e8:	83 c4 04             	add    $0x4,%esp
    13eb:	39 c3                	cmp    %eax,%ebx
    13ed:	0f 8e b5 00 00 00    	jle    14a8 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    13f3:	8b 45 10             	mov    0x10(%ebp),%eax
    13f6:	2b 45 18             	sub    0x18(%ebp),%eax
    13f9:	89 45 b0             	mov    %eax,-0x50(%ebp)
    13fc:	db 45 b0             	fildl  -0x50(%ebp)
    13ff:	8b 45 0c             	mov    0xc(%ebp),%eax
    1402:	2b 45 14             	sub    0x14(%ebp),%eax
    1405:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1408:	db 45 b0             	fildl  -0x50(%ebp)
    140b:	de f9                	fdivrp %st,%st(1)
    140d:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1410:	8b 45 14             	mov    0x14(%ebp),%eax
    1413:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1416:	7e 0e                	jle    1426 <APDrawLine+0x183>
        {
            s = x1;
    1418:	8b 45 0c             	mov    0xc(%ebp),%eax
    141b:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    141e:	8b 45 14             	mov    0x14(%ebp),%eax
    1421:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1424:	eb 0c                	jmp    1432 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1426:	8b 45 14             	mov    0x14(%ebp),%eax
    1429:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    142c:	8b 45 0c             	mov    0xc(%ebp),%eax
    142f:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1432:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1436:	79 07                	jns    143f <APDrawLine+0x19c>
    1438:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    143f:	8b 45 08             	mov    0x8(%ebp),%eax
    1442:	8b 00                	mov    (%eax),%eax
    1444:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1447:	7f 0b                	jg     1454 <APDrawLine+0x1b1>
    1449:	8b 45 08             	mov    0x8(%ebp),%eax
    144c:	8b 00                	mov    (%eax),%eax
    144e:	83 e8 01             	sub    $0x1,%eax
    1451:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1454:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1457:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    145a:	eb 3f                	jmp    149b <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    145c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    145f:	2b 45 0c             	sub    0xc(%ebp),%eax
    1462:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1465:	db 45 b0             	fildl  -0x50(%ebp)
    1468:	dc 4d d0             	fmull  -0x30(%ebp)
    146b:	db 45 10             	fildl  0x10(%ebp)
    146e:	de c1                	faddp  %st,%st(1)
    1470:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1473:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1477:	b4 0c                	mov    $0xc,%ah
    1479:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    147d:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1480:	db 5d cc             	fistpl -0x34(%ebp)
    1483:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1486:	ff 75 cc             	pushl  -0x34(%ebp)
    1489:	ff 75 e4             	pushl  -0x1c(%ebp)
    148c:	ff 75 08             	pushl  0x8(%ebp)
    148f:	e8 2c fd ff ff       	call   11c0 <APDrawPoint>
    1494:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1497:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    149b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    149e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    14a1:	7e b9                	jle    145c <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    14a3:	e9 b9 00 00 00       	jmp    1561 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    14a8:	8b 45 0c             	mov    0xc(%ebp),%eax
    14ab:	2b 45 14             	sub    0x14(%ebp),%eax
    14ae:	89 45 b0             	mov    %eax,-0x50(%ebp)
    14b1:	db 45 b0             	fildl  -0x50(%ebp)
    14b4:	8b 45 10             	mov    0x10(%ebp),%eax
    14b7:	2b 45 18             	sub    0x18(%ebp),%eax
    14ba:	89 45 b0             	mov    %eax,-0x50(%ebp)
    14bd:	db 45 b0             	fildl  -0x50(%ebp)
    14c0:	de f9                	fdivrp %st,%st(1)
    14c2:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    14c5:	8b 45 10             	mov    0x10(%ebp),%eax
    14c8:	3b 45 18             	cmp    0x18(%ebp),%eax
    14cb:	7e 0e                	jle    14db <APDrawLine+0x238>
    {
        s = y2;
    14cd:	8b 45 18             	mov    0x18(%ebp),%eax
    14d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    14d3:	8b 45 10             	mov    0x10(%ebp),%eax
    14d6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    14d9:	eb 0c                	jmp    14e7 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    14db:	8b 45 10             	mov    0x10(%ebp),%eax
    14de:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    14e1:	8b 45 18             	mov    0x18(%ebp),%eax
    14e4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    14e7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14eb:	79 07                	jns    14f4 <APDrawLine+0x251>
    14ed:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    14f4:	8b 45 08             	mov    0x8(%ebp),%eax
    14f7:	8b 40 04             	mov    0x4(%eax),%eax
    14fa:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    14fd:	7f 0c                	jg     150b <APDrawLine+0x268>
    14ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1502:	8b 40 04             	mov    0x4(%eax),%eax
    1505:	83 e8 01             	sub    $0x1,%eax
    1508:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    150b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    150e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1511:	eb 3f                	jmp    1552 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1513:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1516:	2b 45 10             	sub    0x10(%ebp),%eax
    1519:	89 45 b0             	mov    %eax,-0x50(%ebp)
    151c:	db 45 b0             	fildl  -0x50(%ebp)
    151f:	dc 4d c0             	fmull  -0x40(%ebp)
    1522:	db 45 0c             	fildl  0xc(%ebp)
    1525:	de c1                	faddp  %st,%st(1)
    1527:	d9 7d b6             	fnstcw -0x4a(%ebp)
    152a:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    152e:	b4 0c                	mov    $0xc,%ah
    1530:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1534:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1537:	db 5d bc             	fistpl -0x44(%ebp)
    153a:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    153d:	ff 75 e0             	pushl  -0x20(%ebp)
    1540:	ff 75 bc             	pushl  -0x44(%ebp)
    1543:	ff 75 08             	pushl  0x8(%ebp)
    1546:	e8 75 fc ff ff       	call   11c0 <APDrawPoint>
    154b:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    154e:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1552:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1555:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1558:	7e b9                	jle    1513 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    155a:	90                   	nop
    155b:	eb 04                	jmp    1561 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    155d:	90                   	nop
    155e:	eb 01                	jmp    1561 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1560:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1561:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1564:	c9                   	leave  
    1565:	c3                   	ret    

00001566 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1566:	55                   	push   %ebp
    1567:	89 e5                	mov    %esp,%ebp
    1569:	53                   	push   %ebx
    156a:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    156d:	8b 55 10             	mov    0x10(%ebp),%edx
    1570:	8b 45 18             	mov    0x18(%ebp),%eax
    1573:	01 d0                	add    %edx,%eax
    1575:	83 e8 01             	sub    $0x1,%eax
    1578:	83 ec 04             	sub    $0x4,%esp
    157b:	50                   	push   %eax
    157c:	ff 75 0c             	pushl  0xc(%ebp)
    157f:	ff 75 10             	pushl  0x10(%ebp)
    1582:	ff 75 0c             	pushl  0xc(%ebp)
    1585:	ff 75 08             	pushl  0x8(%ebp)
    1588:	e8 16 fd ff ff       	call   12a3 <APDrawLine>
    158d:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1590:	8b 55 0c             	mov    0xc(%ebp),%edx
    1593:	8b 45 14             	mov    0x14(%ebp),%eax
    1596:	01 d0                	add    %edx,%eax
    1598:	83 e8 01             	sub    $0x1,%eax
    159b:	83 ec 04             	sub    $0x4,%esp
    159e:	ff 75 10             	pushl  0x10(%ebp)
    15a1:	50                   	push   %eax
    15a2:	ff 75 10             	pushl  0x10(%ebp)
    15a5:	ff 75 0c             	pushl  0xc(%ebp)
    15a8:	ff 75 08             	pushl  0x8(%ebp)
    15ab:	e8 f3 fc ff ff       	call   12a3 <APDrawLine>
    15b0:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    15b3:	8b 55 10             	mov    0x10(%ebp),%edx
    15b6:	8b 45 18             	mov    0x18(%ebp),%eax
    15b9:	01 d0                	add    %edx,%eax
    15bb:	8d 48 ff             	lea    -0x1(%eax),%ecx
    15be:	8b 55 0c             	mov    0xc(%ebp),%edx
    15c1:	8b 45 14             	mov    0x14(%ebp),%eax
    15c4:	01 d0                	add    %edx,%eax
    15c6:	8d 50 ff             	lea    -0x1(%eax),%edx
    15c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    15cc:	8b 45 14             	mov    0x14(%ebp),%eax
    15cf:	01 d8                	add    %ebx,%eax
    15d1:	83 e8 01             	sub    $0x1,%eax
    15d4:	83 ec 04             	sub    $0x4,%esp
    15d7:	51                   	push   %ecx
    15d8:	52                   	push   %edx
    15d9:	ff 75 10             	pushl  0x10(%ebp)
    15dc:	50                   	push   %eax
    15dd:	ff 75 08             	pushl  0x8(%ebp)
    15e0:	e8 be fc ff ff       	call   12a3 <APDrawLine>
    15e5:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    15e8:	8b 55 10             	mov    0x10(%ebp),%edx
    15eb:	8b 45 18             	mov    0x18(%ebp),%eax
    15ee:	01 d0                	add    %edx,%eax
    15f0:	8d 48 ff             	lea    -0x1(%eax),%ecx
    15f3:	8b 55 0c             	mov    0xc(%ebp),%edx
    15f6:	8b 45 14             	mov    0x14(%ebp),%eax
    15f9:	01 d0                	add    %edx,%eax
    15fb:	8d 50 ff             	lea    -0x1(%eax),%edx
    15fe:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1601:	8b 45 18             	mov    0x18(%ebp),%eax
    1604:	01 d8                	add    %ebx,%eax
    1606:	83 e8 01             	sub    $0x1,%eax
    1609:	83 ec 04             	sub    $0x4,%esp
    160c:	51                   	push   %ecx
    160d:	52                   	push   %edx
    160e:	50                   	push   %eax
    160f:	ff 75 0c             	pushl  0xc(%ebp)
    1612:	ff 75 08             	pushl  0x8(%ebp)
    1615:	e8 89 fc ff ff       	call   12a3 <APDrawLine>
    161a:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    161d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1620:	8b 45 14             	mov    0x14(%ebp),%eax
    1623:	01 d0                	add    %edx,%eax
    1625:	8d 50 ff             	lea    -0x1(%eax),%edx
    1628:	8b 45 08             	mov    0x8(%ebp),%eax
    162b:	8b 40 0c             	mov    0xc(%eax),%eax
    162e:	89 c1                	mov    %eax,%ecx
    1630:	c1 e9 1f             	shr    $0x1f,%ecx
    1633:	01 c8                	add    %ecx,%eax
    1635:	d1 f8                	sar    %eax
    1637:	29 c2                	sub    %eax,%edx
    1639:	89 d0                	mov    %edx,%eax
    163b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    163e:	8b 55 10             	mov    0x10(%ebp),%edx
    1641:	8b 45 18             	mov    0x18(%ebp),%eax
    1644:	01 d0                	add    %edx,%eax
    1646:	8d 50 ff             	lea    -0x1(%eax),%edx
    1649:	8b 45 08             	mov    0x8(%ebp),%eax
    164c:	8b 40 0c             	mov    0xc(%eax),%eax
    164f:	89 c1                	mov    %eax,%ecx
    1651:	c1 e9 1f             	shr    $0x1f,%ecx
    1654:	01 c8                	add    %ecx,%eax
    1656:	d1 f8                	sar    %eax
    1658:	29 c2                	sub    %eax,%edx
    165a:	89 d0                	mov    %edx,%eax
    165c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    165f:	8b 45 08             	mov    0x8(%ebp),%eax
    1662:	8b 40 0c             	mov    0xc(%eax),%eax
    1665:	89 c2                	mov    %eax,%edx
    1667:	c1 ea 1f             	shr    $0x1f,%edx
    166a:	01 d0                	add    %edx,%eax
    166c:	d1 f8                	sar    %eax
    166e:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1671:	8b 45 08             	mov    0x8(%ebp),%eax
    1674:	8b 40 0c             	mov    0xc(%eax),%eax
    1677:	89 c2                	mov    %eax,%edx
    1679:	c1 ea 1f             	shr    $0x1f,%edx
    167c:	01 d0                	add    %edx,%eax
    167e:	d1 f8                	sar    %eax
    1680:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1683:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1687:	0f 88 d8 00 00 00    	js     1765 <APDrawRect+0x1ff>
    168d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1691:	0f 88 ce 00 00 00    	js     1765 <APDrawRect+0x1ff>
    1697:	8b 45 08             	mov    0x8(%ebp),%eax
    169a:	8b 00                	mov    (%eax),%eax
    169c:	3b 45 0c             	cmp    0xc(%ebp),%eax
    169f:	0f 8e c0 00 00 00    	jle    1765 <APDrawRect+0x1ff>
    16a5:	8b 45 08             	mov    0x8(%ebp),%eax
    16a8:	8b 40 04             	mov    0x4(%eax),%eax
    16ab:	3b 45 10             	cmp    0x10(%ebp),%eax
    16ae:	0f 8e b1 00 00 00    	jle    1765 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    16b4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16b8:	79 07                	jns    16c1 <APDrawRect+0x15b>
    16ba:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    16c1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    16c5:	79 07                	jns    16ce <APDrawRect+0x168>
    16c7:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    16ce:	8b 45 08             	mov    0x8(%ebp),%eax
    16d1:	8b 00                	mov    (%eax),%eax
    16d3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    16d6:	7f 0b                	jg     16e3 <APDrawRect+0x17d>
    16d8:	8b 45 08             	mov    0x8(%ebp),%eax
    16db:	8b 00                	mov    (%eax),%eax
    16dd:	83 e8 01             	sub    $0x1,%eax
    16e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    16e3:	8b 45 08             	mov    0x8(%ebp),%eax
    16e6:	8b 40 04             	mov    0x4(%eax),%eax
    16e9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    16ec:	7f 0c                	jg     16fa <APDrawRect+0x194>
    16ee:	8b 45 08             	mov    0x8(%ebp),%eax
    16f1:	8b 40 04             	mov    0x4(%eax),%eax
    16f4:	83 e8 01             	sub    $0x1,%eax
    16f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    16fa:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1701:	8b 45 0c             	mov    0xc(%ebp),%eax
    1704:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1707:	eb 52                	jmp    175b <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1709:	8b 45 10             	mov    0x10(%ebp),%eax
    170c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    170f:	eb 3e                	jmp    174f <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1711:	83 ec 04             	sub    $0x4,%esp
    1714:	ff 75 e8             	pushl  -0x18(%ebp)
    1717:	ff 75 ec             	pushl  -0x14(%ebp)
    171a:	ff 75 08             	pushl  0x8(%ebp)
    171d:	e8 c0 f6 ff ff       	call   de2 <APGetIndex>
    1722:	83 c4 10             	add    $0x10,%esp
    1725:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1728:	8b 45 08             	mov    0x8(%ebp),%eax
    172b:	8b 48 18             	mov    0x18(%eax),%ecx
    172e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1731:	89 d0                	mov    %edx,%eax
    1733:	01 c0                	add    %eax,%eax
    1735:	01 d0                	add    %edx,%eax
    1737:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    173a:	8b 45 08             	mov    0x8(%ebp),%eax
    173d:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1741:	66 89 0a             	mov    %cx,(%edx)
    1744:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1748:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    174b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    174f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1752:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1755:	7e ba                	jle    1711 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1757:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    175b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    175e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1761:	7e a6                	jle    1709 <APDrawRect+0x1a3>
    1763:	eb 01                	jmp    1766 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1765:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1766:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1769:	c9                   	leave  
    176a:	c3                   	ret    

0000176b <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    176b:	55                   	push   %ebp
    176c:	89 e5                	mov    %esp,%ebp
    176e:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    1771:	83 ec 0c             	sub    $0xc,%esp
    1774:	ff 75 0c             	pushl  0xc(%ebp)
    1777:	e8 b1 ee ff ff       	call   62d <strlen>
    177c:	83 c4 10             	add    $0x10,%esp
    177f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1782:	8b 45 08             	mov    0x8(%ebp),%eax
    1785:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1789:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    178d:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1791:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1794:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    179b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    17a2:	e9 bc 00 00 00       	jmp    1863 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    17a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    17ad:	01 d0                	add    %edx,%eax
    17af:	0f b6 00             	movzbl (%eax),%eax
    17b2:	0f be c0             	movsbl %al,%eax
    17b5:	83 e8 20             	sub    $0x20,%eax
    17b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    17bb:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    17bf:	0f 87 9a 00 00 00    	ja     185f <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    17c5:	8b 45 08             	mov    0x8(%ebp),%eax
    17c8:	8b 00                	mov    (%eax),%eax
    17ca:	0f af 45 14          	imul   0x14(%ebp),%eax
    17ce:	89 c2                	mov    %eax,%edx
    17d0:	8b 45 10             	mov    0x10(%ebp),%eax
    17d3:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    17d6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17d9:	89 d0                	mov    %edx,%eax
    17db:	c1 e0 03             	shl    $0x3,%eax
    17de:	01 d0                	add    %edx,%eax
    17e0:	01 c8                	add    %ecx,%eax
    17e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    17e5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    17ec:	eb 6b                	jmp    1859 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    17ee:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    17f5:	eb 50                	jmp    1847 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    17f7:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17fa:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    17fd:	89 d0                	mov    %edx,%eax
    17ff:	c1 e0 03             	shl    $0x3,%eax
    1802:	01 d0                	add    %edx,%eax
    1804:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    180a:	01 c2                	add    %eax,%edx
    180c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    180f:	01 d0                	add    %edx,%eax
    1811:	05 00 36 00 00       	add    $0x3600,%eax
    1816:	0f b6 00             	movzbl (%eax),%eax
    1819:	84 c0                	test   %al,%al
    181b:	74 26                	je     1843 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    181d:	8b 45 08             	mov    0x8(%ebp),%eax
    1820:	8b 50 18             	mov    0x18(%eax),%edx
    1823:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1826:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1829:	01 c8                	add    %ecx,%eax
    182b:	89 c1                	mov    %eax,%ecx
    182d:	89 c8                	mov    %ecx,%eax
    182f:	01 c0                	add    %eax,%eax
    1831:	01 c8                	add    %ecx,%eax
    1833:	01 d0                	add    %edx,%eax
    1835:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1839:	66 89 10             	mov    %dx,(%eax)
    183c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1840:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1843:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1847:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    184b:	7e aa                	jle    17f7 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    184d:	8b 45 08             	mov    0x8(%ebp),%eax
    1850:	8b 00                	mov    (%eax),%eax
    1852:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1855:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1859:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    185d:	7e 8f                	jle    17ee <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    185f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1863:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1866:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1869:	0f 82 38 ff ff ff    	jb     17a7 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    186f:	90                   	nop
    1870:	c9                   	leave  
    1871:	c3                   	ret    

00001872 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1872:	55                   	push   %ebp
    1873:	89 e5                	mov    %esp,%ebp
    1875:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1878:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    187c:	0f 88 8e 01 00 00    	js     1a10 <APDcCopy+0x19e>
    1882:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1886:	0f 88 84 01 00 00    	js     1a10 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    188c:	8b 55 0c             	mov    0xc(%ebp),%edx
    188f:	8b 45 20             	mov    0x20(%ebp),%eax
    1892:	01 d0                	add    %edx,%eax
    1894:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1897:	8b 55 10             	mov    0x10(%ebp),%edx
    189a:	8b 45 24             	mov    0x24(%ebp),%eax
    189d:	01 d0                	add    %edx,%eax
    189f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    18a2:	8b 55 18             	mov    0x18(%ebp),%edx
    18a5:	8b 45 20             	mov    0x20(%ebp),%eax
    18a8:	01 d0                	add    %edx,%eax
    18aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18ad:	8b 55 1c             	mov    0x1c(%ebp),%edx
    18b0:	8b 45 24             	mov    0x24(%ebp),%eax
    18b3:	01 d0                	add    %edx,%eax
    18b5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    18b8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    18bc:	0f 88 51 01 00 00    	js     1a13 <APDcCopy+0x1a1>
    18c2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    18c6:	0f 88 47 01 00 00    	js     1a13 <APDcCopy+0x1a1>
    18cc:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    18d0:	0f 88 3d 01 00 00    	js     1a13 <APDcCopy+0x1a1>
    18d6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    18da:	0f 88 33 01 00 00    	js     1a13 <APDcCopy+0x1a1>
    18e0:	8b 45 14             	mov    0x14(%ebp),%eax
    18e3:	8b 00                	mov    (%eax),%eax
    18e5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    18e8:	0f 8c 25 01 00 00    	jl     1a13 <APDcCopy+0x1a1>
    18ee:	8b 45 14             	mov    0x14(%ebp),%eax
    18f1:	8b 40 04             	mov    0x4(%eax),%eax
    18f4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    18f7:	0f 8c 16 01 00 00    	jl     1a13 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    18fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1900:	8b 00                	mov    (%eax),%eax
    1902:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1905:	7f 0b                	jg     1912 <APDcCopy+0xa0>
    1907:	8b 45 08             	mov    0x8(%ebp),%eax
    190a:	8b 00                	mov    (%eax),%eax
    190c:	83 e8 01             	sub    $0x1,%eax
    190f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1912:	8b 45 08             	mov    0x8(%ebp),%eax
    1915:	8b 40 04             	mov    0x4(%eax),%eax
    1918:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    191b:	7f 0c                	jg     1929 <APDcCopy+0xb7>
    191d:	8b 45 08             	mov    0x8(%ebp),%eax
    1920:	8b 40 04             	mov    0x4(%eax),%eax
    1923:	83 e8 01             	sub    $0x1,%eax
    1926:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1929:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1930:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1937:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    193e:	e9 bc 00 00 00       	jmp    19ff <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1943:	8b 45 08             	mov    0x8(%ebp),%eax
    1946:	8b 00                	mov    (%eax),%eax
    1948:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    194b:	8b 55 10             	mov    0x10(%ebp),%edx
    194e:	01 ca                	add    %ecx,%edx
    1950:	0f af d0             	imul   %eax,%edx
    1953:	8b 45 0c             	mov    0xc(%ebp),%eax
    1956:	01 d0                	add    %edx,%eax
    1958:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    195b:	8b 45 14             	mov    0x14(%ebp),%eax
    195e:	8b 00                	mov    (%eax),%eax
    1960:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1963:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1966:	01 ca                	add    %ecx,%edx
    1968:	0f af d0             	imul   %eax,%edx
    196b:	8b 45 18             	mov    0x18(%ebp),%eax
    196e:	01 d0                	add    %edx,%eax
    1970:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1973:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    197a:	eb 74                	jmp    19f0 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    197c:	8b 45 14             	mov    0x14(%ebp),%eax
    197f:	8b 50 18             	mov    0x18(%eax),%edx
    1982:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1985:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1988:	01 c8                	add    %ecx,%eax
    198a:	89 c1                	mov    %eax,%ecx
    198c:	89 c8                	mov    %ecx,%eax
    198e:	01 c0                	add    %eax,%eax
    1990:	01 c8                	add    %ecx,%eax
    1992:	01 d0                	add    %edx,%eax
    1994:	0f b7 10             	movzwl (%eax),%edx
    1997:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    199b:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    199f:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    19a2:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    19a6:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    19aa:	38 c2                	cmp    %al,%dl
    19ac:	75 18                	jne    19c6 <APDcCopy+0x154>
    19ae:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    19b2:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    19b6:	38 c2                	cmp    %al,%dl
    19b8:	75 0c                	jne    19c6 <APDcCopy+0x154>
    19ba:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    19be:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    19c2:	38 c2                	cmp    %al,%dl
    19c4:	74 26                	je     19ec <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    19c6:	8b 45 08             	mov    0x8(%ebp),%eax
    19c9:	8b 50 18             	mov    0x18(%eax),%edx
    19cc:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    19cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19d2:	01 c8                	add    %ecx,%eax
    19d4:	89 c1                	mov    %eax,%ecx
    19d6:	89 c8                	mov    %ecx,%eax
    19d8:	01 c0                	add    %eax,%eax
    19da:	01 c8                	add    %ecx,%eax
    19dc:	01 d0                	add    %edx,%eax
    19de:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    19e2:	66 89 10             	mov    %dx,(%eax)
    19e5:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    19e9:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    19ec:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    19f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19f3:	2b 45 0c             	sub    0xc(%ebp),%eax
    19f6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    19f9:	7d 81                	jge    197c <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    19fb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    19ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a02:	2b 45 10             	sub    0x10(%ebp),%eax
    1a05:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1a08:	0f 8d 35 ff ff ff    	jge    1943 <APDcCopy+0xd1>
    1a0e:	eb 04                	jmp    1a14 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1a10:	90                   	nop
    1a11:	eb 01                	jmp    1a14 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1a13:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1a14:	c9                   	leave  
    1a15:	c3                   	ret    

00001a16 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1a16:	55                   	push   %ebp
    1a17:	89 e5                	mov    %esp,%ebp
    1a19:	83 ec 1c             	sub    $0x1c,%esp
    1a1c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1a1f:	8b 55 10             	mov    0x10(%ebp),%edx
    1a22:	8b 45 14             	mov    0x14(%ebp),%eax
    1a25:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1a28:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1a2b:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1a2e:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1a32:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1a35:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1a39:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1a3c:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1a40:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1a43:	8b 45 08             	mov    0x8(%ebp),%eax
    1a46:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1a4a:	66 89 10             	mov    %dx,(%eax)
    1a4d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1a51:	88 50 02             	mov    %dl,0x2(%eax)
}
    1a54:	8b 45 08             	mov    0x8(%ebp),%eax
    1a57:	c9                   	leave  
    1a58:	c2 04 00             	ret    $0x4

00001a5b <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1a5b:	55                   	push   %ebp
    1a5c:	89 e5                	mov    %esp,%ebp
    1a5e:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1a61:	8b 45 08             	mov    0x8(%ebp),%eax
    1a64:	8b 00                	mov    (%eax),%eax
    1a66:	83 ec 08             	sub    $0x8,%esp
    1a69:	8d 55 0c             	lea    0xc(%ebp),%edx
    1a6c:	52                   	push   %edx
    1a6d:	50                   	push   %eax
    1a6e:	e8 24 ee ff ff       	call   897 <sendMessage>
    1a73:	83 c4 10             	add    $0x10,%esp
}
    1a76:	90                   	nop
    1a77:	c9                   	leave  
    1a78:	c3                   	ret    

00001a79 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1a79:	55                   	push   %ebp
    1a7a:	89 e5                	mov    %esp,%ebp
    1a7c:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1a7f:	83 ec 0c             	sub    $0xc,%esp
    1a82:	68 9c 00 00 00       	push   $0x9c
    1a87:	e8 f5 f1 ff ff       	call   c81 <malloc>
    1a8c:	83 c4 10             	add    $0x10,%esp
    1a8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1a92:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a96:	75 15                	jne    1aad <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1a98:	83 ec 04             	sub    $0x4,%esp
    1a9b:	ff 75 08             	pushl  0x8(%ebp)
    1a9e:	68 60 2b 00 00       	push   $0x2b60
    1aa3:	6a 01                	push   $0x1
    1aa5:	e8 04 ef ff ff       	call   9ae <printf>
    1aaa:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ab0:	05 88 00 00 00       	add    $0x88,%eax
    1ab5:	83 ec 08             	sub    $0x8,%esp
    1ab8:	ff 75 08             	pushl  0x8(%ebp)
    1abb:	50                   	push   %eax
    1abc:	e8 fd ea ff ff       	call   5be <strcpy>
    1ac1:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1ac4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ac7:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1ace:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ad1:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1adb:	8b 40 3c             	mov    0x3c(%eax),%eax
    1ade:	89 c2                	mov    %eax,%edx
    1ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ae3:	8b 40 40             	mov    0x40(%eax),%eax
    1ae6:	0f af d0             	imul   %eax,%edx
    1ae9:	89 d0                	mov    %edx,%eax
    1aeb:	01 c0                	add    %eax,%eax
    1aed:	01 d0                	add    %edx,%eax
    1aef:	83 ec 0c             	sub    $0xc,%esp
    1af2:	50                   	push   %eax
    1af3:	e8 89 f1 ff ff       	call   c81 <malloc>
    1af8:	83 c4 10             	add    $0x10,%esp
    1afb:	89 c2                	mov    %eax,%edx
    1afd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b00:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b06:	8b 40 54             	mov    0x54(%eax),%eax
    1b09:	85 c0                	test   %eax,%eax
    1b0b:	75 15                	jne    1b22 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1b0d:	83 ec 04             	sub    $0x4,%esp
    1b10:	ff 75 08             	pushl  0x8(%ebp)
    1b13:	68 80 2b 00 00       	push   $0x2b80
    1b18:	6a 01                	push   $0x1
    1b1a:	e8 8f ee ff ff       	call   9ae <printf>
    1b1f:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1b22:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b25:	8b 40 3c             	mov    0x3c(%eax),%eax
    1b28:	89 c2                	mov    %eax,%edx
    1b2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b2d:	8b 40 40             	mov    0x40(%eax),%eax
    1b30:	0f af d0             	imul   %eax,%edx
    1b33:	89 d0                	mov    %edx,%eax
    1b35:	01 c0                	add    %eax,%eax
    1b37:	01 c2                	add    %eax,%edx
    1b39:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b3c:	8b 40 54             	mov    0x54(%eax),%eax
    1b3f:	83 ec 04             	sub    $0x4,%esp
    1b42:	52                   	push   %edx
    1b43:	68 ff ff ff 00       	push   $0xffffff
    1b48:	50                   	push   %eax
    1b49:	e8 06 eb ff ff       	call   654 <memset>
    1b4e:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1b51:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b54:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1b5b:	e8 0f ed ff ff       	call   86f <getpid>
    1b60:	89 c2                	mov    %eax,%edx
    1b62:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b65:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1b68:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b6b:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1b72:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b75:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1b7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b7f:	8b 40 58             	mov    0x58(%eax),%eax
    1b82:	89 c2                	mov    %eax,%edx
    1b84:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b87:	8b 40 5c             	mov    0x5c(%eax),%eax
    1b8a:	0f af d0             	imul   %eax,%edx
    1b8d:	89 d0                	mov    %edx,%eax
    1b8f:	01 c0                	add    %eax,%eax
    1b91:	01 d0                	add    %edx,%eax
    1b93:	83 ec 0c             	sub    $0xc,%esp
    1b96:	50                   	push   %eax
    1b97:	e8 e5 f0 ff ff       	call   c81 <malloc>
    1b9c:	83 c4 10             	add    $0x10,%esp
    1b9f:	89 c2                	mov    %eax,%edx
    1ba1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ba4:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1ba7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1baa:	8b 40 70             	mov    0x70(%eax),%eax
    1bad:	85 c0                	test   %eax,%eax
    1baf:	75 15                	jne    1bc6 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1bb1:	83 ec 04             	sub    $0x4,%esp
    1bb4:	ff 75 08             	pushl  0x8(%ebp)
    1bb7:	68 a4 2b 00 00       	push   $0x2ba4
    1bbc:	6a 01                	push   $0x1
    1bbe:	e8 eb ed ff ff       	call   9ae <printf>
    1bc3:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1bc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bc9:	8b 40 3c             	mov    0x3c(%eax),%eax
    1bcc:	89 c2                	mov    %eax,%edx
    1bce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bd1:	8b 40 40             	mov    0x40(%eax),%eax
    1bd4:	0f af d0             	imul   %eax,%edx
    1bd7:	89 d0                	mov    %edx,%eax
    1bd9:	01 c0                	add    %eax,%eax
    1bdb:	01 c2                	add    %eax,%edx
    1bdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1be0:	8b 40 54             	mov    0x54(%eax),%eax
    1be3:	83 ec 04             	sub    $0x4,%esp
    1be6:	52                   	push   %edx
    1be7:	68 ff 00 00 00       	push   $0xff
    1bec:	50                   	push   %eax
    1bed:	e8 62 ea ff ff       	call   654 <memset>
    1bf2:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1bf5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bf8:	8b 55 0c             	mov    0xc(%ebp),%edx
    1bfb:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1bfe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1c02:	74 49                	je     1c4d <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1c04:	8b 45 10             	mov    0x10(%ebp),%eax
    1c07:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1c0d:	83 ec 0c             	sub    $0xc,%esp
    1c10:	50                   	push   %eax
    1c11:	e8 6b f0 ff ff       	call   c81 <malloc>
    1c16:	83 c4 10             	add    $0x10,%esp
    1c19:	89 c2                	mov    %eax,%edx
    1c1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c1e:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1c21:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c24:	8b 55 10             	mov    0x10(%ebp),%edx
    1c27:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1c2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c2d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1c34:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c37:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1c3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c41:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1c48:	e9 8d 00 00 00       	jmp    1cda <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1c4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c50:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1c57:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c5a:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1c61:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c64:	8b 40 20             	mov    0x20(%eax),%eax
    1c67:	89 c2                	mov    %eax,%edx
    1c69:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c6c:	8b 40 24             	mov    0x24(%eax),%eax
    1c6f:	0f af d0             	imul   %eax,%edx
    1c72:	89 d0                	mov    %edx,%eax
    1c74:	01 c0                	add    %eax,%eax
    1c76:	01 d0                	add    %edx,%eax
    1c78:	83 ec 0c             	sub    $0xc,%esp
    1c7b:	50                   	push   %eax
    1c7c:	e8 00 f0 ff ff       	call   c81 <malloc>
    1c81:	83 c4 10             	add    $0x10,%esp
    1c84:	89 c2                	mov    %eax,%edx
    1c86:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c89:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1c8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c8f:	8b 40 38             	mov    0x38(%eax),%eax
    1c92:	85 c0                	test   %eax,%eax
    1c94:	75 15                	jne    1cab <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1c96:	83 ec 04             	sub    $0x4,%esp
    1c99:	ff 75 08             	pushl  0x8(%ebp)
    1c9c:	68 cc 2b 00 00       	push   $0x2bcc
    1ca1:	6a 01                	push   $0x1
    1ca3:	e8 06 ed ff ff       	call   9ae <printf>
    1ca8:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1cab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cae:	8b 40 20             	mov    0x20(%eax),%eax
    1cb1:	89 c2                	mov    %eax,%edx
    1cb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cb6:	8b 40 24             	mov    0x24(%eax),%eax
    1cb9:	0f af d0             	imul   %eax,%edx
    1cbc:	89 d0                	mov    %edx,%eax
    1cbe:	01 c0                	add    %eax,%eax
    1cc0:	01 c2                	add    %eax,%edx
    1cc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cc5:	8b 40 38             	mov    0x38(%eax),%eax
    1cc8:	83 ec 04             	sub    $0x4,%esp
    1ccb:	52                   	push   %edx
    1ccc:	68 ff ff ff 00       	push   $0xffffff
    1cd1:	50                   	push   %eax
    1cd2:	e8 7d e9 ff ff       	call   654 <memset>
    1cd7:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1cda:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1cdd:	c9                   	leave  
    1cde:	c3                   	ret    

00001cdf <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1cdf:	55                   	push   %ebp
    1ce0:	89 e5                	mov    %esp,%ebp
    1ce2:	57                   	push   %edi
    1ce3:	56                   	push   %esi
    1ce4:	53                   	push   %ebx
    1ce5:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1ce8:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ceb:	83 f8 03             	cmp    $0x3,%eax
    1cee:	74 0e                	je     1cfe <APWndProc+0x1f>
    1cf0:	83 f8 0a             	cmp    $0xa,%eax
    1cf3:	0f 84 82 00 00 00    	je     1d7b <APWndProc+0x9c>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            break;
        default: break;
    1cf9:	e9 cb 00 00 00       	jmp    1dc9 <APWndProc+0xea>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1cfe:	8b 45 08             	mov    0x8(%ebp),%eax
    1d01:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1d04:	8b 45 08             	mov    0x8(%ebp),%eax
    1d07:	8b 48 18             	mov    0x18(%eax),%ecx
    1d0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d0d:	8b 50 5c             	mov    0x5c(%eax),%edx
    1d10:	8b 45 08             	mov    0x8(%ebp),%eax
    1d13:	8b 40 58             	mov    0x58(%eax),%eax
    1d16:	8b 75 08             	mov    0x8(%ebp),%esi
    1d19:	83 c6 58             	add    $0x58,%esi
    1d1c:	83 ec 04             	sub    $0x4,%esp
    1d1f:	53                   	push   %ebx
    1d20:	51                   	push   %ecx
    1d21:	6a 00                	push   $0x0
    1d23:	52                   	push   %edx
    1d24:	50                   	push   %eax
    1d25:	6a 00                	push   $0x0
    1d27:	6a 00                	push   $0x0
    1d29:	56                   	push   %esi
    1d2a:	6a 00                	push   $0x0
    1d2c:	6a 00                	push   $0x0
    1d2e:	ff 75 08             	pushl  0x8(%ebp)
    1d31:	e8 59 eb ff ff       	call   88f <paintWindow>
    1d36:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1d39:	8b 45 08             	mov    0x8(%ebp),%eax
    1d3c:	8b 70 1c             	mov    0x1c(%eax),%esi
    1d3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d42:	8b 58 18             	mov    0x18(%eax),%ebx
    1d45:	8b 45 08             	mov    0x8(%ebp),%eax
    1d48:	8b 48 08             	mov    0x8(%eax),%ecx
    1d4b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d4e:	8b 50 40             	mov    0x40(%eax),%edx
    1d51:	8b 45 08             	mov    0x8(%ebp),%eax
    1d54:	8b 40 3c             	mov    0x3c(%eax),%eax
    1d57:	8b 7d 08             	mov    0x8(%ebp),%edi
    1d5a:	83 c7 3c             	add    $0x3c,%edi
    1d5d:	83 ec 04             	sub    $0x4,%esp
    1d60:	56                   	push   %esi
    1d61:	53                   	push   %ebx
    1d62:	51                   	push   %ecx
    1d63:	52                   	push   %edx
    1d64:	50                   	push   %eax
    1d65:	6a 00                	push   $0x0
    1d67:	6a 00                	push   $0x0
    1d69:	57                   	push   %edi
    1d6a:	6a 32                	push   $0x32
    1d6c:	6a 00                	push   $0x0
    1d6e:	ff 75 08             	pushl  0x8(%ebp)
    1d71:	e8 19 eb ff ff       	call   88f <paintWindow>
    1d76:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1d79:	eb 4e                	jmp    1dc9 <APWndProc+0xea>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
    1d7b:	8b 45 18             	mov    0x18(%ebp),%eax
    1d7e:	83 ec 08             	sub    $0x8,%esp
    1d81:	50                   	push   %eax
    1d82:	ff 75 08             	pushl  0x8(%ebp)
    1d85:	e8 c5 08 00 00       	call   264f <updateword>
    1d8a:	83 c4 10             	add    $0x10,%esp
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1d8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d90:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1d93:	8b 45 08             	mov    0x8(%ebp),%eax
    1d96:	8b 48 18             	mov    0x18(%eax),%ecx
    1d99:	8b 45 08             	mov    0x8(%ebp),%eax
    1d9c:	8b 50 5c             	mov    0x5c(%eax),%edx
    1d9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1da2:	8b 40 58             	mov    0x58(%eax),%eax
    1da5:	8b 75 08             	mov    0x8(%ebp),%esi
    1da8:	83 c6 58             	add    $0x58,%esi
    1dab:	83 ec 04             	sub    $0x4,%esp
    1dae:	53                   	push   %ebx
    1daf:	51                   	push   %ecx
    1db0:	6a 00                	push   $0x0
    1db2:	52                   	push   %edx
    1db3:	50                   	push   %eax
    1db4:	6a 00                	push   $0x0
    1db6:	6a 00                	push   $0x0
    1db8:	56                   	push   %esi
    1db9:	6a 00                	push   $0x0
    1dbb:	6a 00                	push   $0x0
    1dbd:	ff 75 08             	pushl  0x8(%ebp)
    1dc0:	e8 ca ea ff ff       	call   88f <paintWindow>
    1dc5:	83 c4 30             	add    $0x30,%esp
            break;
    1dc8:	90                   	nop
        default: break;
            
            
    }
    return False;
    1dc9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1dce:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1dd1:	5b                   	pop    %ebx
    1dd2:	5e                   	pop    %esi
    1dd3:	5f                   	pop    %edi
    1dd4:	5d                   	pop    %ebp
    1dd5:	c3                   	ret    

00001dd6 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1dd6:	55                   	push   %ebp
    1dd7:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1dd9:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ddc:	8b 50 08             	mov    0x8(%eax),%edx
    1ddf:	8b 45 08             	mov    0x8(%ebp),%eax
    1de2:	8b 00                	mov    (%eax),%eax
    1de4:	39 c2                	cmp    %eax,%edx
    1de6:	74 07                	je     1def <APPreJudge+0x19>
        return False;
    1de8:	b8 00 00 00 00       	mov    $0x0,%eax
    1ded:	eb 05                	jmp    1df4 <APPreJudge+0x1e>
    return True;
    1def:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1df4:	5d                   	pop    %ebp
    1df5:	c3                   	ret    

00001df6 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1df6:	55                   	push   %ebp
    1df7:	89 e5                	mov    %esp,%ebp
    1df9:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1dfc:	8b 45 08             	mov    0x8(%ebp),%eax
    1dff:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e02:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
    //--------add window to list
    registWindow(hwnd);
    1e08:	83 ec 0c             	sub    $0xc,%esp
    1e0b:	ff 75 08             	pushl  0x8(%ebp)
    1e0e:	e8 94 ea ff ff       	call   8a7 <registWindow>
    1e13:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1e16:	c7 45 e8 02 00 00 00 	movl   $0x2,-0x18(%ebp)
    msg.wndID = hwnd->id;
    1e1d:	8b 45 08             	mov    0x8(%ebp),%eax
    1e20:	8b 00                	mov    (%eax),%eax
    1e22:	89 45 f0             	mov    %eax,-0x10(%ebp)
    APSendMessage(hwnd,msg);
    1e25:	83 ec 0c             	sub    $0xc,%esp
    1e28:	ff 75 f4             	pushl  -0xc(%ebp)
    1e2b:	ff 75 f0             	pushl  -0x10(%ebp)
    1e2e:	ff 75 ec             	pushl  -0x14(%ebp)
    1e31:	ff 75 e8             	pushl  -0x18(%ebp)
    1e34:	ff 75 08             	pushl  0x8(%ebp)
    1e37:	e8 1f fc ff ff       	call   1a5b <APSendMessage>
    1e3c:	83 c4 20             	add    $0x20,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1e3f:	83 ec 0c             	sub    $0xc,%esp
    1e42:	ff 75 08             	pushl  0x8(%ebp)
    1e45:	e8 55 ea ff ff       	call   89f <getMessage>
    1e4a:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1e4d:	8b 45 08             	mov    0x8(%ebp),%eax
    1e50:	83 c0 74             	add    $0x74,%eax
    1e53:	83 ec 08             	sub    $0x8,%esp
    1e56:	50                   	push   %eax
    1e57:	ff 75 08             	pushl  0x8(%ebp)
    1e5a:	e8 77 ff ff ff       	call   1dd6 <APPreJudge>
    1e5f:	83 c4 10             	add    $0x10,%esp
    1e62:	84 c0                	test   %al,%al
    1e64:	74 24                	je     1e8a <APWndExec+0x94>
            if (wndProc(hwnd, hwnd->msg))
    1e66:	83 ec 0c             	sub    $0xc,%esp
    1e69:	8b 45 08             	mov    0x8(%ebp),%eax
    1e6c:	ff b0 80 00 00 00    	pushl  0x80(%eax)
    1e72:	ff 70 7c             	pushl  0x7c(%eax)
    1e75:	ff 70 78             	pushl  0x78(%eax)
    1e78:	ff 70 74             	pushl  0x74(%eax)
    1e7b:	ff 75 08             	pushl  0x8(%ebp)
    1e7e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e81:	ff d0                	call   *%eax
    1e83:	83 c4 20             	add    $0x20,%esp
    1e86:	84 c0                	test   %al,%al
    1e88:	75 0c                	jne    1e96 <APWndExec+0xa0>
                break;
        hwnd->msg.type = MSG_NULL;
    1e8a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e8d:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1e94:	eb a9                	jmp    1e3f <APWndExec+0x49>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1e96:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1e97:	90                   	nop
    1e98:	c9                   	leave  
    1e99:	c3                   	ret    

00001e9a <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1e9a:	55                   	push   %ebp
    1e9b:	89 e5                	mov    %esp,%ebp
    1e9d:	57                   	push   %edi
    1e9e:	56                   	push   %esi
    1e9f:	53                   	push   %ebx
    1ea0:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1ea3:	a1 44 72 00 00       	mov    0x7244,%eax
    1ea8:	85 c0                	test   %eax,%eax
    1eaa:	0f 85 c8 02 00 00    	jne    2178 <APGridPaint+0x2de>
    {
        iconReady = 1;
    1eb0:	c7 05 44 72 00 00 01 	movl   $0x1,0x7244
    1eb7:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1eba:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ebd:	83 ec 08             	sub    $0x8,%esp
    1ec0:	68 f3 2b 00 00       	push   $0x2bf3
    1ec5:	50                   	push   %eax
    1ec6:	e8 69 ef ff ff       	call   e34 <APLoadBitmap>
    1ecb:	83 c4 0c             	add    $0xc,%esp
    1ece:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ed1:	a3 74 72 00 00       	mov    %eax,0x7274
    1ed6:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ed9:	a3 78 72 00 00       	mov    %eax,0x7278
    1ede:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ee1:	a3 7c 72 00 00       	mov    %eax,0x727c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1ee6:	83 ec 04             	sub    $0x4,%esp
    1ee9:	ff 35 7c 72 00 00    	pushl  0x727c
    1eef:	ff 35 78 72 00 00    	pushl  0x7278
    1ef5:	ff 35 74 72 00 00    	pushl  0x7274
    1efb:	e8 6e f1 ff ff       	call   106e <APCreateCompatibleDCFromBitmap>
    1f00:	83 c4 10             	add    $0x10,%esp
    1f03:	a3 80 72 00 00       	mov    %eax,0x7280
        grid_river = APLoadBitmap ("grid_river.bmp");
    1f08:	8d 45 98             	lea    -0x68(%ebp),%eax
    1f0b:	83 ec 08             	sub    $0x8,%esp
    1f0e:	68 01 2c 00 00       	push   $0x2c01
    1f13:	50                   	push   %eax
    1f14:	e8 1b ef ff ff       	call   e34 <APLoadBitmap>
    1f19:	83 c4 0c             	add    $0xc,%esp
    1f1c:	8b 45 98             	mov    -0x68(%ebp),%eax
    1f1f:	a3 c0 72 00 00       	mov    %eax,0x72c0
    1f24:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1f27:	a3 c4 72 00 00       	mov    %eax,0x72c4
    1f2c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1f2f:	a3 c8 72 00 00       	mov    %eax,0x72c8
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1f34:	83 ec 04             	sub    $0x4,%esp
    1f37:	ff 35 c8 72 00 00    	pushl  0x72c8
    1f3d:	ff 35 c4 72 00 00    	pushl  0x72c4
    1f43:	ff 35 c0 72 00 00    	pushl  0x72c0
    1f49:	e8 20 f1 ff ff       	call   106e <APCreateCompatibleDCFromBitmap>
    1f4e:	83 c4 10             	add    $0x10,%esp
    1f51:	a3 b0 72 00 00       	mov    %eax,0x72b0
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1f56:	8d 45 98             	lea    -0x68(%ebp),%eax
    1f59:	83 ec 08             	sub    $0x8,%esp
    1f5c:	68 10 2c 00 00       	push   $0x2c10
    1f61:	50                   	push   %eax
    1f62:	e8 cd ee ff ff       	call   e34 <APLoadBitmap>
    1f67:	83 c4 0c             	add    $0xc,%esp
    1f6a:	8b 45 98             	mov    -0x68(%ebp),%eax
    1f6d:	a3 b4 72 00 00       	mov    %eax,0x72b4
    1f72:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1f75:	a3 b8 72 00 00       	mov    %eax,0x72b8
    1f7a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1f7d:	a3 bc 72 00 00       	mov    %eax,0x72bc
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1f82:	83 ec 04             	sub    $0x4,%esp
    1f85:	ff 35 bc 72 00 00    	pushl  0x72bc
    1f8b:	ff 35 b8 72 00 00    	pushl  0x72b8
    1f91:	ff 35 b4 72 00 00    	pushl  0x72b4
    1f97:	e8 d2 f0 ff ff       	call   106e <APCreateCompatibleDCFromBitmap>
    1f9c:	83 c4 10             	add    $0x10,%esp
    1f9f:	a3 48 72 00 00       	mov    %eax,0x7248
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1fa4:	8d 45 98             	lea    -0x68(%ebp),%eax
    1fa7:	83 ec 08             	sub    $0x8,%esp
    1faa:	68 1f 2c 00 00       	push   $0x2c1f
    1faf:	50                   	push   %eax
    1fb0:	e8 7f ee ff ff       	call   e34 <APLoadBitmap>
    1fb5:	83 c4 0c             	add    $0xc,%esp
    1fb8:	8b 45 98             	mov    -0x68(%ebp),%eax
    1fbb:	a3 4c 72 00 00       	mov    %eax,0x724c
    1fc0:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1fc3:	a3 50 72 00 00       	mov    %eax,0x7250
    1fc8:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1fcb:	a3 54 72 00 00       	mov    %eax,0x7254
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1fd0:	83 ec 04             	sub    $0x4,%esp
    1fd3:	ff 35 54 72 00 00    	pushl  0x7254
    1fd9:	ff 35 50 72 00 00    	pushl  0x7250
    1fdf:	ff 35 4c 72 00 00    	pushl  0x724c
    1fe5:	e8 84 f0 ff ff       	call   106e <APCreateCompatibleDCFromBitmap>
    1fea:	83 c4 10             	add    $0x10,%esp
    1fed:	a3 70 72 00 00       	mov    %eax,0x7270
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1ff2:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ff5:	83 ec 08             	sub    $0x8,%esp
    1ff8:	68 31 2c 00 00       	push   $0x2c31
    1ffd:	50                   	push   %eax
    1ffe:	e8 31 ee ff ff       	call   e34 <APLoadBitmap>
    2003:	83 c4 0c             	add    $0xc,%esp
    2006:	8b 45 98             	mov    -0x68(%ebp),%eax
    2009:	a3 8c 72 00 00       	mov    %eax,0x728c
    200e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2011:	a3 90 72 00 00       	mov    %eax,0x7290
    2016:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2019:	a3 94 72 00 00       	mov    %eax,0x7294
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    201e:	83 ec 04             	sub    $0x4,%esp
    2021:	ff 35 94 72 00 00    	pushl  0x7294
    2027:	ff 35 90 72 00 00    	pushl  0x7290
    202d:	ff 35 8c 72 00 00    	pushl  0x728c
    2033:	e8 36 f0 ff ff       	call   106e <APCreateCompatibleDCFromBitmap>
    2038:	83 c4 10             	add    $0x10,%esp
    203b:	a3 d0 72 00 00       	mov    %eax,0x72d0
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    2040:	8d 45 98             	lea    -0x68(%ebp),%eax
    2043:	83 ec 08             	sub    $0x8,%esp
    2046:	68 3f 2c 00 00       	push   $0x2c3f
    204b:	50                   	push   %eax
    204c:	e8 e3 ed ff ff       	call   e34 <APLoadBitmap>
    2051:	83 c4 0c             	add    $0xc,%esp
    2054:	8b 45 98             	mov    -0x68(%ebp),%eax
    2057:	a3 64 72 00 00       	mov    %eax,0x7264
    205c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    205f:	a3 68 72 00 00       	mov    %eax,0x7268
    2064:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2067:	a3 6c 72 00 00       	mov    %eax,0x726c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    206c:	83 ec 04             	sub    $0x4,%esp
    206f:	ff 35 6c 72 00 00    	pushl  0x726c
    2075:	ff 35 68 72 00 00    	pushl  0x7268
    207b:	ff 35 64 72 00 00    	pushl  0x7264
    2081:	e8 e8 ef ff ff       	call   106e <APCreateCompatibleDCFromBitmap>
    2086:	83 c4 10             	add    $0x10,%esp
    2089:	a3 84 72 00 00       	mov    %eax,0x7284
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    208e:	8d 45 98             	lea    -0x68(%ebp),%eax
    2091:	83 ec 08             	sub    $0x8,%esp
    2094:	68 4f 2c 00 00       	push   $0x2c4f
    2099:	50                   	push   %eax
    209a:	e8 95 ed ff ff       	call   e34 <APLoadBitmap>
    209f:	83 c4 0c             	add    $0xc,%esp
    20a2:	8b 45 98             	mov    -0x68(%ebp),%eax
    20a5:	a3 a4 72 00 00       	mov    %eax,0x72a4
    20aa:	8b 45 9c             	mov    -0x64(%ebp),%eax
    20ad:	a3 a8 72 00 00       	mov    %eax,0x72a8
    20b2:	8b 45 a0             	mov    -0x60(%ebp),%eax
    20b5:	a3 ac 72 00 00       	mov    %eax,0x72ac
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    20ba:	83 ec 04             	sub    $0x4,%esp
    20bd:	ff 35 ac 72 00 00    	pushl  0x72ac
    20c3:	ff 35 a8 72 00 00    	pushl  0x72a8
    20c9:	ff 35 a4 72 00 00    	pushl  0x72a4
    20cf:	e8 9a ef ff ff       	call   106e <APCreateCompatibleDCFromBitmap>
    20d4:	83 c4 10             	add    $0x10,%esp
    20d7:	a3 d4 72 00 00       	mov    %eax,0x72d4
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    20dc:	8d 45 98             	lea    -0x68(%ebp),%eax
    20df:	83 ec 08             	sub    $0x8,%esp
    20e2:	68 5e 2c 00 00       	push   $0x2c5e
    20e7:	50                   	push   %eax
    20e8:	e8 47 ed ff ff       	call   e34 <APLoadBitmap>
    20ed:	83 c4 0c             	add    $0xc,%esp
    20f0:	8b 45 98             	mov    -0x68(%ebp),%eax
    20f3:	a3 98 72 00 00       	mov    %eax,0x7298
    20f8:	8b 45 9c             	mov    -0x64(%ebp),%eax
    20fb:	a3 9c 72 00 00       	mov    %eax,0x729c
    2100:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2103:	a3 a0 72 00 00       	mov    %eax,0x72a0
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    2108:	83 ec 04             	sub    $0x4,%esp
    210b:	ff 35 a0 72 00 00    	pushl  0x72a0
    2111:	ff 35 9c 72 00 00    	pushl  0x729c
    2117:	ff 35 98 72 00 00    	pushl  0x7298
    211d:	e8 4c ef ff ff       	call   106e <APCreateCompatibleDCFromBitmap>
    2122:	83 c4 10             	add    $0x10,%esp
    2125:	a3 cc 72 00 00       	mov    %eax,0x72cc
        grid_tower = APLoadBitmap ("grid_tower.bmp");
    212a:	8d 45 98             	lea    -0x68(%ebp),%eax
    212d:	83 ec 08             	sub    $0x8,%esp
    2130:	68 6d 2c 00 00       	push   $0x2c6d
    2135:	50                   	push   %eax
    2136:	e8 f9 ec ff ff       	call   e34 <APLoadBitmap>
    213b:	83 c4 0c             	add    $0xc,%esp
    213e:	8b 45 98             	mov    -0x68(%ebp),%eax
    2141:	a3 58 72 00 00       	mov    %eax,0x7258
    2146:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2149:	a3 5c 72 00 00       	mov    %eax,0x725c
    214e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2151:	a3 60 72 00 00       	mov    %eax,0x7260
        g_tower = APCreateCompatibleDCFromBitmap(grid_tower);
    2156:	83 ec 04             	sub    $0x4,%esp
    2159:	ff 35 60 72 00 00    	pushl  0x7260
    215f:	ff 35 5c 72 00 00    	pushl  0x725c
    2165:	ff 35 58 72 00 00    	pushl  0x7258
    216b:	e8 fe ee ff ff       	call   106e <APCreateCompatibleDCFromBitmap>
    2170:	83 c4 10             	add    $0x10,%esp
    2173:	a3 88 72 00 00       	mov    %eax,0x7288
   
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    2178:	8b 45 08             	mov    0x8(%ebp),%eax
    217b:	8b 40 08             	mov    0x8(%eax),%eax
    217e:	85 c0                	test   %eax,%eax
    2180:	75 17                	jne    2199 <APGridPaint+0x2ff>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    2182:	83 ec 08             	sub    $0x8,%esp
    2185:	68 7c 2c 00 00       	push   $0x2c7c
    218a:	6a 01                	push   $0x1
    218c:	e8 1d e8 ff ff       	call   9ae <printf>
    2191:	83 c4 10             	add    $0x10,%esp
        return;
    2194:	e9 ae 04 00 00       	jmp    2647 <APGridPaint+0x7ad>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    2199:	8b 45 08             	mov    0x8(%ebp),%eax
    219c:	8b 40 10             	mov    0x10(%eax),%eax
    219f:	85 c0                	test   %eax,%eax
    21a1:	7e 10                	jle    21b3 <APGridPaint+0x319>
    21a3:	8b 45 08             	mov    0x8(%ebp),%eax
    21a6:	8b 50 14             	mov    0x14(%eax),%edx
    21a9:	8b 45 08             	mov    0x8(%ebp),%eax
    21ac:	8b 40 10             	mov    0x10(%eax),%eax
    21af:	39 c2                	cmp    %eax,%edx
    21b1:	7c 17                	jl     21ca <APGridPaint+0x330>
    {
        printf(1,"Grid mode page error!");
    21b3:	83 ec 08             	sub    $0x8,%esp
    21b6:	68 a2 2c 00 00       	push   $0x2ca2
    21bb:	6a 01                	push   $0x1
    21bd:	e8 ec e7 ff ff       	call   9ae <printf>
    21c2:	83 c4 10             	add    $0x10,%esp
        return;
    21c5:	e9 7d 04 00 00       	jmp    2647 <APGridPaint+0x7ad>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    21ca:	8b 45 08             	mov    0x8(%ebp),%eax
    21cd:	8b 40 14             	mov    0x14(%eax),%eax
    21d0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    21d6:	89 45 dc             	mov    %eax,-0x24(%ebp)
    21d9:	8b 45 dc             	mov    -0x24(%ebp),%eax
    21dc:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    21df:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    21e6:	e9 52 04 00 00       	jmp    263d <APGridPaint+0x7a3>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    21eb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    21f2:	e9 38 04 00 00       	jmp    262f <APGridPaint+0x795>
        {
            index = start + GRID_W_NUMBER * j + i;
    21f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21fa:	c1 e0 04             	shl    $0x4,%eax
    21fd:	89 c2                	mov    %eax,%edx
    21ff:	8b 45 d8             	mov    -0x28(%ebp),%eax
    2202:	01 c2                	add    %eax,%edx
    2204:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2207:	01 d0                	add    %edx,%eax
    2209:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    220c:	8b 45 08             	mov    0x8(%ebp),%eax
    220f:	8b 40 0c             	mov    0xc(%eax),%eax
    2212:	8b 55 dc             	mov    -0x24(%ebp),%edx
    2215:	c1 e2 02             	shl    $0x2,%edx
    2218:	01 d0                	add    %edx,%eax
    221a:	8b 00                	mov    (%eax),%eax
    221c:	83 f8 0b             	cmp    $0xb,%eax
    221f:	0f 87 05 04 00 00    	ja     262a <APGridPaint+0x790>
    2225:	8b 04 85 b8 2c 00 00 	mov    0x2cb8(,%eax,4),%eax
    222c:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    222e:	8d 45 bd             	lea    -0x43(%ebp),%eax
    2231:	6a 0c                	push   $0xc
    2233:	6a 0c                	push   $0xc
    2235:	6a 0c                	push   $0xc
    2237:	50                   	push   %eax
    2238:	e8 d9 f7 ff ff       	call   1a16 <RGB>
    223d:	83 c4 0c             	add    $0xc,%esp
    2240:	8b 1d 80 72 00 00    	mov    0x7280,%ebx
    2246:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2249:	6b c8 32             	imul   $0x32,%eax,%ecx
    224c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    224f:	6b c0 32             	imul   $0x32,%eax,%eax
    2252:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2255:	8b 45 08             	mov    0x8(%ebp),%eax
    2258:	8d 78 3c             	lea    0x3c(%eax),%edi
    225b:	83 ec 0c             	sub    $0xc,%esp
    225e:	83 ec 04             	sub    $0x4,%esp
    2261:	89 e0                	mov    %esp,%eax
    2263:	0f b7 75 bd          	movzwl -0x43(%ebp),%esi
    2267:	66 89 30             	mov    %si,(%eax)
    226a:	0f b6 55 bf          	movzbl -0x41(%ebp),%edx
    226e:	88 50 02             	mov    %dl,0x2(%eax)
    2271:	6a 32                	push   $0x32
    2273:	6a 32                	push   $0x32
    2275:	6a 00                	push   $0x0
    2277:	6a 00                	push   $0x0
    2279:	53                   	push   %ebx
    227a:	51                   	push   %ecx
    227b:	ff 75 94             	pushl  -0x6c(%ebp)
    227e:	57                   	push   %edi
    227f:	e8 ee f5 ff ff       	call   1872 <APDcCopy>
    2284:	83 c4 30             	add    $0x30,%esp
                    break;
    2287:	e9 9f 03 00 00       	jmp    262b <APGridPaint+0x791>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    228c:	8d 45 98             	lea    -0x68(%ebp),%eax
    228f:	6a 69                	push   $0x69
    2291:	6a 69                	push   $0x69
    2293:	6a 69                	push   $0x69
    2295:	50                   	push   %eax
    2296:	e8 7b f7 ff ff       	call   1a16 <RGB>
    229b:	83 c4 0c             	add    $0xc,%esp
    229e:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    22a2:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    22a6:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    22aa:	88 45 b6             	mov    %al,-0x4a(%ebp)
                    pen.size = 1;
    22ad:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    22b4:	8d 45 98             	lea    -0x68(%ebp),%eax
    22b7:	6a 69                	push   $0x69
    22b9:	6a 69                	push   $0x69
    22bb:	6a 69                	push   $0x69
    22bd:	50                   	push   %eax
    22be:	e8 53 f7 ff ff       	call   1a16 <RGB>
    22c3:	83 c4 0c             	add    $0xc,%esp
    22c6:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    22ca:	66 89 45 b1          	mov    %ax,-0x4f(%ebp)
    22ce:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    22d2:	88 45 b3             	mov    %al,-0x4d(%ebp)
                    APSetPen(&wnd->Dc,pen);
    22d5:	8b 45 08             	mov    0x8(%ebp),%eax
    22d8:	8d 50 3c             	lea    0x3c(%eax),%edx
    22db:	8d 45 98             	lea    -0x68(%ebp),%eax
    22de:	ff 75 b8             	pushl  -0x48(%ebp)
    22e1:	ff 75 b4             	pushl  -0x4c(%ebp)
    22e4:	52                   	push   %edx
    22e5:	50                   	push   %eax
    22e6:	e8 18 ee ff ff       	call   1103 <APSetPen>
    22eb:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    22ee:	8b 45 08             	mov    0x8(%ebp),%eax
    22f1:	8d 58 3c             	lea    0x3c(%eax),%ebx
    22f4:	8d 55 98             	lea    -0x68(%ebp),%edx
    22f7:	83 ec 04             	sub    $0x4,%esp
    22fa:	83 ec 04             	sub    $0x4,%esp
    22fd:	89 e0                	mov    %esp,%eax
    22ff:	0f b7 4d b1          	movzwl -0x4f(%ebp),%ecx
    2303:	66 89 08             	mov    %cx,(%eax)
    2306:	0f b6 4d b3          	movzbl -0x4d(%ebp),%ecx
    230a:	88 48 02             	mov    %cl,0x2(%eax)
    230d:	53                   	push   %ebx
    230e:	52                   	push   %edx
    230f:	e8 28 ee ff ff       	call   113c <APSetBrush>
    2314:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    2317:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    231a:	6b d0 32             	imul   $0x32,%eax,%edx
    231d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2320:	6b c0 32             	imul   $0x32,%eax,%eax
    2323:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2326:	83 c1 3c             	add    $0x3c,%ecx
    2329:	83 ec 0c             	sub    $0xc,%esp
    232c:	6a 32                	push   $0x32
    232e:	6a 32                	push   $0x32
    2330:	52                   	push   %edx
    2331:	50                   	push   %eax
    2332:	51                   	push   %ecx
    2333:	e8 2e f2 ff ff       	call   1566 <APDrawRect>
    2338:	83 c4 20             	add    $0x20,%esp
                    break;
    233b:	e9 eb 02 00 00       	jmp    262b <APGridPaint+0x791>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2340:	8d 45 c0             	lea    -0x40(%ebp),%eax
    2343:	6a 0c                	push   $0xc
    2345:	6a 0c                	push   $0xc
    2347:	6a 0c                	push   $0xc
    2349:	50                   	push   %eax
    234a:	e8 c7 f6 ff ff       	call   1a16 <RGB>
    234f:	83 c4 0c             	add    $0xc,%esp
    2352:	8b 1d d4 72 00 00    	mov    0x72d4,%ebx
    2358:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    235b:	6b c8 32             	imul   $0x32,%eax,%ecx
    235e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2361:	6b c0 32             	imul   $0x32,%eax,%eax
    2364:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2367:	8b 45 08             	mov    0x8(%ebp),%eax
    236a:	8d 78 3c             	lea    0x3c(%eax),%edi
    236d:	83 ec 0c             	sub    $0xc,%esp
    2370:	83 ec 04             	sub    $0x4,%esp
    2373:	89 e0                	mov    %esp,%eax
    2375:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    2379:	66 89 30             	mov    %si,(%eax)
    237c:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    2380:	88 50 02             	mov    %dl,0x2(%eax)
    2383:	6a 32                	push   $0x32
    2385:	6a 32                	push   $0x32
    2387:	6a 00                	push   $0x0
    2389:	6a 00                	push   $0x0
    238b:	53                   	push   %ebx
    238c:	51                   	push   %ecx
    238d:	ff 75 94             	pushl  -0x6c(%ebp)
    2390:	57                   	push   %edi
    2391:	e8 dc f4 ff ff       	call   1872 <APDcCopy>
    2396:	83 c4 30             	add    $0x30,%esp
                    break;
    2399:	e9 8d 02 00 00       	jmp    262b <APGridPaint+0x791>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    239e:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    23a1:	6a 0c                	push   $0xc
    23a3:	6a 0c                	push   $0xc
    23a5:	6a 0c                	push   $0xc
    23a7:	50                   	push   %eax
    23a8:	e8 69 f6 ff ff       	call   1a16 <RGB>
    23ad:	83 c4 0c             	add    $0xc,%esp
    23b0:	8b 1d b0 72 00 00    	mov    0x72b0,%ebx
    23b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23b9:	6b c8 32             	imul   $0x32,%eax,%ecx
    23bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    23bf:	6b c0 32             	imul   $0x32,%eax,%eax
    23c2:	89 45 94             	mov    %eax,-0x6c(%ebp)
    23c5:	8b 45 08             	mov    0x8(%ebp),%eax
    23c8:	8d 78 3c             	lea    0x3c(%eax),%edi
    23cb:	83 ec 0c             	sub    $0xc,%esp
    23ce:	83 ec 04             	sub    $0x4,%esp
    23d1:	89 e0                	mov    %esp,%eax
    23d3:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    23d7:	66 89 30             	mov    %si,(%eax)
    23da:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    23de:	88 50 02             	mov    %dl,0x2(%eax)
    23e1:	6a 32                	push   $0x32
    23e3:	6a 32                	push   $0x32
    23e5:	6a 00                	push   $0x0
    23e7:	6a 00                	push   $0x0
    23e9:	53                   	push   %ebx
    23ea:	51                   	push   %ecx
    23eb:	ff 75 94             	pushl  -0x6c(%ebp)
    23ee:	57                   	push   %edi
    23ef:	e8 7e f4 ff ff       	call   1872 <APDcCopy>
    23f4:	83 c4 30             	add    $0x30,%esp
                    break;
    23f7:	e9 2f 02 00 00       	jmp    262b <APGridPaint+0x791>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    23fc:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    23ff:	6a 0c                	push   $0xc
    2401:	6a 0c                	push   $0xc
    2403:	6a 0c                	push   $0xc
    2405:	50                   	push   %eax
    2406:	e8 0b f6 ff ff       	call   1a16 <RGB>
    240b:	83 c4 0c             	add    $0xc,%esp
    240e:	8b 1d 84 72 00 00    	mov    0x7284,%ebx
    2414:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2417:	6b c8 32             	imul   $0x32,%eax,%ecx
    241a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    241d:	6b c0 32             	imul   $0x32,%eax,%eax
    2420:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2423:	8b 45 08             	mov    0x8(%ebp),%eax
    2426:	8d 78 3c             	lea    0x3c(%eax),%edi
    2429:	83 ec 0c             	sub    $0xc,%esp
    242c:	83 ec 04             	sub    $0x4,%esp
    242f:	89 e0                	mov    %esp,%eax
    2431:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2435:	66 89 30             	mov    %si,(%eax)
    2438:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    243c:	88 50 02             	mov    %dl,0x2(%eax)
    243f:	6a 32                	push   $0x32
    2441:	6a 32                	push   $0x32
    2443:	6a 00                	push   $0x0
    2445:	6a 00                	push   $0x0
    2447:	53                   	push   %ebx
    2448:	51                   	push   %ecx
    2449:	ff 75 94             	pushl  -0x6c(%ebp)
    244c:	57                   	push   %edi
    244d:	e8 20 f4 ff ff       	call   1872 <APDcCopy>
    2452:	83 c4 30             	add    $0x30,%esp
                    break;
    2455:	e9 d1 01 00 00       	jmp    262b <APGridPaint+0x791>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    245a:	8d 45 c9             	lea    -0x37(%ebp),%eax
    245d:	6a 0c                	push   $0xc
    245f:	6a 0c                	push   $0xc
    2461:	6a 0c                	push   $0xc
    2463:	50                   	push   %eax
    2464:	e8 ad f5 ff ff       	call   1a16 <RGB>
    2469:	83 c4 0c             	add    $0xc,%esp
    246c:	8b 1d d0 72 00 00    	mov    0x72d0,%ebx
    2472:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2475:	6b c8 32             	imul   $0x32,%eax,%ecx
    2478:	8b 45 e0             	mov    -0x20(%ebp),%eax
    247b:	6b c0 32             	imul   $0x32,%eax,%eax
    247e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2481:	8b 45 08             	mov    0x8(%ebp),%eax
    2484:	8d 78 3c             	lea    0x3c(%eax),%edi
    2487:	83 ec 0c             	sub    $0xc,%esp
    248a:	83 ec 04             	sub    $0x4,%esp
    248d:	89 e0                	mov    %esp,%eax
    248f:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    2493:	66 89 30             	mov    %si,(%eax)
    2496:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    249a:	88 50 02             	mov    %dl,0x2(%eax)
    249d:	6a 32                	push   $0x32
    249f:	6a 32                	push   $0x32
    24a1:	6a 00                	push   $0x0
    24a3:	6a 00                	push   $0x0
    24a5:	53                   	push   %ebx
    24a6:	51                   	push   %ecx
    24a7:	ff 75 94             	pushl  -0x6c(%ebp)
    24aa:	57                   	push   %edi
    24ab:	e8 c2 f3 ff ff       	call   1872 <APDcCopy>
    24b0:	83 c4 30             	add    $0x30,%esp
                    break;
    24b3:	e9 73 01 00 00       	jmp    262b <APGridPaint+0x791>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    24b8:	8d 45 cc             	lea    -0x34(%ebp),%eax
    24bb:	6a 0c                	push   $0xc
    24bd:	6a 0c                	push   $0xc
    24bf:	6a 0c                	push   $0xc
    24c1:	50                   	push   %eax
    24c2:	e8 4f f5 ff ff       	call   1a16 <RGB>
    24c7:	83 c4 0c             	add    $0xc,%esp
    24ca:	8b 1d 48 72 00 00    	mov    0x7248,%ebx
    24d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24d3:	6b c8 32             	imul   $0x32,%eax,%ecx
    24d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    24d9:	6b c0 32             	imul   $0x32,%eax,%eax
    24dc:	89 45 94             	mov    %eax,-0x6c(%ebp)
    24df:	8b 45 08             	mov    0x8(%ebp),%eax
    24e2:	8d 78 3c             	lea    0x3c(%eax),%edi
    24e5:	83 ec 0c             	sub    $0xc,%esp
    24e8:	83 ec 04             	sub    $0x4,%esp
    24eb:	89 e0                	mov    %esp,%eax
    24ed:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    24f1:	66 89 30             	mov    %si,(%eax)
    24f4:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    24f8:	88 50 02             	mov    %dl,0x2(%eax)
    24fb:	6a 32                	push   $0x32
    24fd:	6a 32                	push   $0x32
    24ff:	6a 00                	push   $0x0
    2501:	6a 00                	push   $0x0
    2503:	53                   	push   %ebx
    2504:	51                   	push   %ecx
    2505:	ff 75 94             	pushl  -0x6c(%ebp)
    2508:	57                   	push   %edi
    2509:	e8 64 f3 ff ff       	call   1872 <APDcCopy>
    250e:	83 c4 30             	add    $0x30,%esp
                    break;
    2511:	e9 15 01 00 00       	jmp    262b <APGridPaint+0x791>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2516:	8d 45 cf             	lea    -0x31(%ebp),%eax
    2519:	6a 0c                	push   $0xc
    251b:	6a 0c                	push   $0xc
    251d:	6a 0c                	push   $0xc
    251f:	50                   	push   %eax
    2520:	e8 f1 f4 ff ff       	call   1a16 <RGB>
    2525:	83 c4 0c             	add    $0xc,%esp
    2528:	8b 1d 70 72 00 00    	mov    0x7270,%ebx
    252e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2531:	6b c8 32             	imul   $0x32,%eax,%ecx
    2534:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2537:	6b c0 32             	imul   $0x32,%eax,%eax
    253a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    253d:	8b 45 08             	mov    0x8(%ebp),%eax
    2540:	8d 78 3c             	lea    0x3c(%eax),%edi
    2543:	83 ec 0c             	sub    $0xc,%esp
    2546:	83 ec 04             	sub    $0x4,%esp
    2549:	89 e0                	mov    %esp,%eax
    254b:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    254f:	66 89 30             	mov    %si,(%eax)
    2552:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2556:	88 50 02             	mov    %dl,0x2(%eax)
    2559:	6a 32                	push   $0x32
    255b:	6a 32                	push   $0x32
    255d:	6a 00                	push   $0x0
    255f:	6a 00                	push   $0x0
    2561:	53                   	push   %ebx
    2562:	51                   	push   %ecx
    2563:	ff 75 94             	pushl  -0x6c(%ebp)
    2566:	57                   	push   %edi
    2567:	e8 06 f3 ff ff       	call   1872 <APDcCopy>
    256c:	83 c4 30             	add    $0x30,%esp
                    break;
    256f:	e9 b7 00 00 00       	jmp    262b <APGridPaint+0x791>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2574:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2577:	6a 0c                	push   $0xc
    2579:	6a 0c                	push   $0xc
    257b:	6a 0c                	push   $0xc
    257d:	50                   	push   %eax
    257e:	e8 93 f4 ff ff       	call   1a16 <RGB>
    2583:	83 c4 0c             	add    $0xc,%esp
    2586:	8b 1d cc 72 00 00    	mov    0x72cc,%ebx
    258c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    258f:	6b c8 32             	imul   $0x32,%eax,%ecx
    2592:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2595:	6b c0 32             	imul   $0x32,%eax,%eax
    2598:	89 45 94             	mov    %eax,-0x6c(%ebp)
    259b:	8b 45 08             	mov    0x8(%ebp),%eax
    259e:	8d 78 3c             	lea    0x3c(%eax),%edi
    25a1:	83 ec 0c             	sub    $0xc,%esp
    25a4:	83 ec 04             	sub    $0x4,%esp
    25a7:	89 e0                	mov    %esp,%eax
    25a9:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    25ad:	66 89 30             	mov    %si,(%eax)
    25b0:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    25b4:	88 50 02             	mov    %dl,0x2(%eax)
    25b7:	6a 32                	push   $0x32
    25b9:	6a 32                	push   $0x32
    25bb:	6a 00                	push   $0x0
    25bd:	6a 00                	push   $0x0
    25bf:	53                   	push   %ebx
    25c0:	51                   	push   %ecx
    25c1:	ff 75 94             	pushl  -0x6c(%ebp)
    25c4:	57                   	push   %edi
    25c5:	e8 a8 f2 ff ff       	call   1872 <APDcCopy>
    25ca:	83 c4 30             	add    $0x30,%esp
                    break;
    25cd:	eb 5c                	jmp    262b <APGridPaint+0x791>
                case GRID_PROGRAM_TOWER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_tower,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    25cf:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    25d2:	6a 0c                	push   $0xc
    25d4:	6a 0c                	push   $0xc
    25d6:	6a 0c                	push   $0xc
    25d8:	50                   	push   %eax
    25d9:	e8 38 f4 ff ff       	call   1a16 <RGB>
    25de:	83 c4 0c             	add    $0xc,%esp
    25e1:	8b 1d 88 72 00 00    	mov    0x7288,%ebx
    25e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    25ea:	6b c8 32             	imul   $0x32,%eax,%ecx
    25ed:	8b 45 e0             	mov    -0x20(%ebp),%eax
    25f0:	6b c0 32             	imul   $0x32,%eax,%eax
    25f3:	89 45 94             	mov    %eax,-0x6c(%ebp)
    25f6:	8b 45 08             	mov    0x8(%ebp),%eax
    25f9:	8d 78 3c             	lea    0x3c(%eax),%edi
    25fc:	83 ec 0c             	sub    $0xc,%esp
    25ff:	83 ec 04             	sub    $0x4,%esp
    2602:	89 e0                	mov    %esp,%eax
    2604:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2608:	66 89 30             	mov    %si,(%eax)
    260b:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    260f:	88 50 02             	mov    %dl,0x2(%eax)
    2612:	6a 32                	push   $0x32
    2614:	6a 32                	push   $0x32
    2616:	6a 00                	push   $0x0
    2618:	6a 00                	push   $0x0
    261a:	53                   	push   %ebx
    261b:	51                   	push   %ecx
    261c:	ff 75 94             	pushl  -0x6c(%ebp)
    261f:	57                   	push   %edi
    2620:	e8 4d f2 ff ff       	call   1872 <APDcCopy>
    2625:	83 c4 30             	add    $0x30,%esp
                    break;
    2628:	eb 01                	jmp    262b <APGridPaint+0x791>
                default: break;
    262a:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    262b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    262f:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2633:	0f 8e be fb ff ff    	jle    21f7 <APGridPaint+0x35d>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2639:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    263d:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2641:	0f 8e a4 fb ff ff    	jle    21eb <APGridPaint+0x351>
                    break;
                default: break;
            }
        }
    }
}
    2647:	8d 65 f4             	lea    -0xc(%ebp),%esp
    264a:	5b                   	pop    %ebx
    264b:	5e                   	pop    %esi
    264c:	5f                   	pop    %edi
    264d:	5d                   	pop    %ebp
    264e:	c3                   	ret    

0000264f <updateword>:


void updateword(AHwnd hwnd,char* str)
{
    264f:	55                   	push   %ebp
    2650:	89 e5                	mov    %esp,%ebp
    2652:	53                   	push   %ebx
    2653:	83 ec 24             	sub    $0x24,%esp
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2656:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2659:	68 cd 00 00 00       	push   $0xcd
    265e:	6a 74                	push   $0x74
    2660:	6a 18                	push   $0x18
    2662:	50                   	push   %eax
    2663:	e8 ae f3 ff ff       	call   1a16 <RGB>
    2668:	83 c4 0c             	add    $0xc,%esp
    266b:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    266f:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
    2673:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    2677:	88 45 f2             	mov    %al,-0xe(%ebp)
    pen.size = 1;
    267a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2681:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2684:	68 cd 00 00 00       	push   $0xcd
    2689:	6a 74                	push   $0x74
    268b:	6a 18                	push   $0x18
    268d:	50                   	push   %eax
    268e:	e8 83 f3 ff ff       	call   1a16 <RGB>
    2693:	83 c4 0c             	add    $0xc,%esp
    2696:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    269a:	66 89 45 ed          	mov    %ax,-0x13(%ebp)
    269e:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    26a2:	88 45 ef             	mov    %al,-0x11(%ebp)
    APSetPen(&hwnd->TitleDc,pen);
    26a5:	8b 45 08             	mov    0x8(%ebp),%eax
    26a8:	8d 50 58             	lea    0x58(%eax),%edx
    26ab:	8d 45 d8             	lea    -0x28(%ebp),%eax
    26ae:	ff 75 f4             	pushl  -0xc(%ebp)
    26b1:	ff 75 f0             	pushl  -0x10(%ebp)
    26b4:	52                   	push   %edx
    26b5:	50                   	push   %eax
    26b6:	e8 48 ea ff ff       	call   1103 <APSetPen>
    26bb:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&hwnd->TitleDc,brush);
    26be:	8b 45 08             	mov    0x8(%ebp),%eax
    26c1:	8d 58 58             	lea    0x58(%eax),%ebx
    26c4:	8d 55 d8             	lea    -0x28(%ebp),%edx
    26c7:	83 ec 04             	sub    $0x4,%esp
    26ca:	83 ec 04             	sub    $0x4,%esp
    26cd:	89 e0                	mov    %esp,%eax
    26cf:	0f b7 4d ed          	movzwl -0x13(%ebp),%ecx
    26d3:	66 89 08             	mov    %cx,(%eax)
    26d6:	0f b6 4d ef          	movzbl -0x11(%ebp),%ecx
    26da:	88 48 02             	mov    %cl,0x2(%eax)
    26dd:	53                   	push   %ebx
    26de:	52                   	push   %edx
    26df:	e8 58 ea ff ff       	call   113c <APSetBrush>
    26e4:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&hwnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    26e7:	8b 45 08             	mov    0x8(%ebp),%eax
    26ea:	83 c0 58             	add    $0x58,%eax
    26ed:	83 ec 0c             	sub    $0xc,%esp
    26f0:	6a 32                	push   $0x32
    26f2:	68 20 03 00 00       	push   $0x320
    26f7:	6a 00                	push   $0x0
    26f9:	6a 00                	push   $0x0
    26fb:	50                   	push   %eax
    26fc:	e8 65 ee ff ff       	call   1566 <APDrawRect>
    2701:	83 c4 20             	add    $0x20,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    2704:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2707:	6a 08                	push   $0x8
    2709:	6a 08                	push   $0x8
    270b:	6a 08                	push   $0x8
    270d:	50                   	push   %eax
    270e:	e8 03 f3 ff ff       	call   1a16 <RGB>
    2713:	83 c4 0c             	add    $0xc,%esp
    2716:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    271a:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    271e:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    2722:	88 45 ec             	mov    %al,-0x14(%ebp)
    APSetFont(&hwnd->TitleDc,font);
    2725:	8b 45 08             	mov    0x8(%ebp),%eax
    2728:	8d 58 58             	lea    0x58(%eax),%ebx
    272b:	8d 55 d8             	lea    -0x28(%ebp),%edx
    272e:	83 ec 04             	sub    $0x4,%esp
    2731:	83 ec 04             	sub    $0x4,%esp
    2734:	89 e0                	mov    %esp,%eax
    2736:	0f b7 4d ea          	movzwl -0x16(%ebp),%ecx
    273a:	66 89 08             	mov    %cx,(%eax)
    273d:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
    2741:	88 48 02             	mov    %cl,0x2(%eax)
    2744:	53                   	push   %ebx
    2745:	52                   	push   %edx
    2746:	e8 33 ea ff ff       	call   117e <APSetFont>
    274b:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&hwnd->TitleDc,str,10,20);
    274e:	8b 45 08             	mov    0x8(%ebp),%eax
    2751:	83 c0 58             	add    $0x58,%eax
    2754:	6a 14                	push   $0x14
    2756:	6a 0a                	push   $0xa
    2758:	ff 75 0c             	pushl  0xc(%ebp)
    275b:	50                   	push   %eax
    275c:	e8 0a f0 ff ff       	call   176b <APDrawText>
    2761:	83 c4 10             	add    $0x10,%esp
}
    2764:	90                   	nop
    2765:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2768:	c9                   	leave  
    2769:	c3                   	ret    

0000276a <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    276a:	55                   	push   %ebp
    276b:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    276d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2771:	7e 08                	jle    277b <random+0x11>
{
rand_num = seed;
    2773:	8b 45 08             	mov    0x8(%ebp),%eax
    2776:	a3 20 72 00 00       	mov    %eax,0x7220
}
rand_num *= 3;
    277b:	8b 15 20 72 00 00    	mov    0x7220,%edx
    2781:	89 d0                	mov    %edx,%eax
    2783:	01 c0                	add    %eax,%eax
    2785:	01 d0                	add    %edx,%eax
    2787:	a3 20 72 00 00       	mov    %eax,0x7220
if (rand_num < 0)
    278c:	a1 20 72 00 00       	mov    0x7220,%eax
    2791:	85 c0                	test   %eax,%eax
    2793:	79 0c                	jns    27a1 <random+0x37>
{
rand_num *= (-1);
    2795:	a1 20 72 00 00       	mov    0x7220,%eax
    279a:	f7 d8                	neg    %eax
    279c:	a3 20 72 00 00       	mov    %eax,0x7220
}
return rand_num % 997;
    27a1:	8b 0d 20 72 00 00    	mov    0x7220,%ecx
    27a7:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    27ac:	89 c8                	mov    %ecx,%eax
    27ae:	f7 ea                	imul   %edx
    27b0:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    27b3:	c1 f8 09             	sar    $0x9,%eax
    27b6:	89 c2                	mov    %eax,%edx
    27b8:	89 c8                	mov    %ecx,%eax
    27ba:	c1 f8 1f             	sar    $0x1f,%eax
    27bd:	29 c2                	sub    %eax,%edx
    27bf:	89 d0                	mov    %edx,%eax
    27c1:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    27c7:	29 c1                	sub    %eax,%ecx
    27c9:	89 c8                	mov    %ecx,%eax
}
    27cb:	5d                   	pop    %ebp
    27cc:	c3                   	ret    

000027cd <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    27cd:	55                   	push   %ebp
    27ce:	89 e5                	mov    %esp,%ebp
    27d0:	53                   	push   %ebx
    27d1:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    27d4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    27db:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    27df:	74 17                	je     27f8 <sprintint+0x2b>
    27e1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    27e5:	79 11                	jns    27f8 <sprintint+0x2b>
        neg = 1;
    27e7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    27ee:	8b 45 10             	mov    0x10(%ebp),%eax
    27f1:	f7 d8                	neg    %eax
    27f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    27f6:	eb 06                	jmp    27fe <sprintint+0x31>
    } else {
        x = xx;
    27f8:	8b 45 10             	mov    0x10(%ebp),%eax
    27fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    27fe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2805:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2808:	8d 41 01             	lea    0x1(%ecx),%eax
    280b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    280e:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2811:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2814:	ba 00 00 00 00       	mov    $0x0,%edx
    2819:	f7 f3                	div    %ebx
    281b:	89 d0                	mov    %edx,%eax
    281d:	0f b6 80 24 72 00 00 	movzbl 0x7224(%eax),%eax
    2824:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2828:	8b 5d 14             	mov    0x14(%ebp),%ebx
    282b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    282e:	ba 00 00 00 00       	mov    $0x0,%edx
    2833:	f7 f3                	div    %ebx
    2835:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2838:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    283c:	75 c7                	jne    2805 <sprintint+0x38>
    if(neg)
    283e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2842:	74 0e                	je     2852 <sprintint+0x85>
        buf[i++] = '-';
    2844:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2847:	8d 50 01             	lea    0x1(%eax),%edx
    284a:	89 55 f8             	mov    %edx,-0x8(%ebp)
    284d:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2852:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2855:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2858:	eb 1b                	jmp    2875 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    285a:	8b 45 0c             	mov    0xc(%ebp),%eax
    285d:	8b 00                	mov    (%eax),%eax
    285f:	8d 48 01             	lea    0x1(%eax),%ecx
    2862:	8b 55 0c             	mov    0xc(%ebp),%edx
    2865:	89 0a                	mov    %ecx,(%edx)
    2867:	89 c2                	mov    %eax,%edx
    2869:	8b 45 08             	mov    0x8(%ebp),%eax
    286c:	01 d0                	add    %edx,%eax
    286e:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2871:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2875:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2879:	7f df                	jg     285a <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    287b:	eb 21                	jmp    289e <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    287d:	8b 45 0c             	mov    0xc(%ebp),%eax
    2880:	8b 00                	mov    (%eax),%eax
    2882:	8d 48 01             	lea    0x1(%eax),%ecx
    2885:	8b 55 0c             	mov    0xc(%ebp),%edx
    2888:	89 0a                	mov    %ecx,(%edx)
    288a:	89 c2                	mov    %eax,%edx
    288c:	8b 45 08             	mov    0x8(%ebp),%eax
    288f:	01 c2                	add    %eax,%edx
    2891:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2894:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2897:	01 c8                	add    %ecx,%eax
    2899:	0f b6 00             	movzbl (%eax),%eax
    289c:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    289e:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    28a2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    28a6:	79 d5                	jns    287d <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    28a8:	90                   	nop
    28a9:	83 c4 20             	add    $0x20,%esp
    28ac:	5b                   	pop    %ebx
    28ad:	5d                   	pop    %ebp
    28ae:	c3                   	ret    

000028af <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    28af:	55                   	push   %ebp
    28b0:	89 e5                	mov    %esp,%ebp
    28b2:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    28b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    28bc:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    28c3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    28ca:	8d 45 0c             	lea    0xc(%ebp),%eax
    28cd:	83 c0 04             	add    $0x4,%eax
    28d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    28d3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    28da:	e9 d9 01 00 00       	jmp    2ab8 <sprintf+0x209>
        c = fmt[i] & 0xff;
    28df:	8b 55 0c             	mov    0xc(%ebp),%edx
    28e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    28e5:	01 d0                	add    %edx,%eax
    28e7:	0f b6 00             	movzbl (%eax),%eax
    28ea:	0f be c0             	movsbl %al,%eax
    28ed:	25 ff 00 00 00       	and    $0xff,%eax
    28f2:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    28f5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    28f9:	75 2c                	jne    2927 <sprintf+0x78>
            if(c == '%'){
    28fb:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    28ff:	75 0c                	jne    290d <sprintf+0x5e>
                state = '%';
    2901:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2908:	e9 a7 01 00 00       	jmp    2ab4 <sprintf+0x205>
            } else {
                dst[j++] = c;
    290d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2910:	8d 50 01             	lea    0x1(%eax),%edx
    2913:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2916:	89 c2                	mov    %eax,%edx
    2918:	8b 45 08             	mov    0x8(%ebp),%eax
    291b:	01 d0                	add    %edx,%eax
    291d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2920:	88 10                	mov    %dl,(%eax)
    2922:	e9 8d 01 00 00       	jmp    2ab4 <sprintf+0x205>
            }
        } else if(state == '%'){
    2927:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    292b:	0f 85 83 01 00 00    	jne    2ab4 <sprintf+0x205>
            if(c == 'd'){
    2931:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2935:	75 4c                	jne    2983 <sprintf+0xd4>
                buf[bi] = '\0';
    2937:	8d 55 ce             	lea    -0x32(%ebp),%edx
    293a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    293d:	01 d0                	add    %edx,%eax
    293f:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2942:	83 ec 0c             	sub    $0xc,%esp
    2945:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2948:	50                   	push   %eax
    2949:	e8 0f de ff ff       	call   75d <atoi>
    294e:	83 c4 10             	add    $0x10,%esp
    2951:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2954:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    295b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    295e:	8b 00                	mov    (%eax),%eax
    2960:	83 ec 08             	sub    $0x8,%esp
    2963:	ff 75 d8             	pushl  -0x28(%ebp)
    2966:	6a 01                	push   $0x1
    2968:	6a 0a                	push   $0xa
    296a:	50                   	push   %eax
    296b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    296e:	50                   	push   %eax
    296f:	ff 75 08             	pushl  0x8(%ebp)
    2972:	e8 56 fe ff ff       	call   27cd <sprintint>
    2977:	83 c4 20             	add    $0x20,%esp
                ap++;
    297a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    297e:	e9 2a 01 00 00       	jmp    2aad <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2983:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2987:	74 06                	je     298f <sprintf+0xe0>
    2989:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    298d:	75 4c                	jne    29db <sprintf+0x12c>
                buf[bi] = '\0';
    298f:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2992:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2995:	01 d0                	add    %edx,%eax
    2997:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    299a:	83 ec 0c             	sub    $0xc,%esp
    299d:	8d 45 ce             	lea    -0x32(%ebp),%eax
    29a0:	50                   	push   %eax
    29a1:	e8 b7 dd ff ff       	call   75d <atoi>
    29a6:	83 c4 10             	add    $0x10,%esp
    29a9:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    29ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    29b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    29b6:	8b 00                	mov    (%eax),%eax
    29b8:	83 ec 08             	sub    $0x8,%esp
    29bb:	ff 75 dc             	pushl  -0x24(%ebp)
    29be:	6a 00                	push   $0x0
    29c0:	6a 10                	push   $0x10
    29c2:	50                   	push   %eax
    29c3:	8d 45 c8             	lea    -0x38(%ebp),%eax
    29c6:	50                   	push   %eax
    29c7:	ff 75 08             	pushl  0x8(%ebp)
    29ca:	e8 fe fd ff ff       	call   27cd <sprintint>
    29cf:	83 c4 20             	add    $0x20,%esp
                ap++;
    29d2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    29d6:	e9 d2 00 00 00       	jmp    2aad <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    29db:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    29df:	75 46                	jne    2a27 <sprintf+0x178>
                s = (char*)*ap;
    29e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    29e4:	8b 00                	mov    (%eax),%eax
    29e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    29e9:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    29ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    29f1:	75 25                	jne    2a18 <sprintf+0x169>
                    s = "(null)";
    29f3:	c7 45 f4 e8 2c 00 00 	movl   $0x2ce8,-0xc(%ebp)
                while(*s != 0){
    29fa:	eb 1c                	jmp    2a18 <sprintf+0x169>
                    dst[j++] = *s;
    29fc:	8b 45 c8             	mov    -0x38(%ebp),%eax
    29ff:	8d 50 01             	lea    0x1(%eax),%edx
    2a02:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2a05:	89 c2                	mov    %eax,%edx
    2a07:	8b 45 08             	mov    0x8(%ebp),%eax
    2a0a:	01 c2                	add    %eax,%edx
    2a0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2a0f:	0f b6 00             	movzbl (%eax),%eax
    2a12:	88 02                	mov    %al,(%edx)
                    s++;
    2a14:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2a18:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2a1b:	0f b6 00             	movzbl (%eax),%eax
    2a1e:	84 c0                	test   %al,%al
    2a20:	75 da                	jne    29fc <sprintf+0x14d>
    2a22:	e9 86 00 00 00       	jmp    2aad <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2a27:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2a2b:	75 1d                	jne    2a4a <sprintf+0x19b>
                dst[j++] = *ap;
    2a2d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2a30:	8d 50 01             	lea    0x1(%eax),%edx
    2a33:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2a36:	89 c2                	mov    %eax,%edx
    2a38:	8b 45 08             	mov    0x8(%ebp),%eax
    2a3b:	01 c2                	add    %eax,%edx
    2a3d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2a40:	8b 00                	mov    (%eax),%eax
    2a42:	88 02                	mov    %al,(%edx)
                ap++;
    2a44:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2a48:	eb 63                	jmp    2aad <sprintf+0x1fe>
            } else if(c == '%'){
    2a4a:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2a4e:	75 17                	jne    2a67 <sprintf+0x1b8>
                dst[j++] = c;
    2a50:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2a53:	8d 50 01             	lea    0x1(%eax),%edx
    2a56:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2a59:	89 c2                	mov    %eax,%edx
    2a5b:	8b 45 08             	mov    0x8(%ebp),%eax
    2a5e:	01 d0                	add    %edx,%eax
    2a60:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2a63:	88 10                	mov    %dl,(%eax)
    2a65:	eb 46                	jmp    2aad <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2a67:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2a6b:	7e 18                	jle    2a85 <sprintf+0x1d6>
    2a6d:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2a71:	7f 12                	jg     2a85 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2a73:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2a76:	8d 50 01             	lea    0x1(%eax),%edx
    2a79:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2a7c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2a7f:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2a83:	eb 2f                	jmp    2ab4 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2a85:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2a88:	8d 50 01             	lea    0x1(%eax),%edx
    2a8b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2a8e:	89 c2                	mov    %eax,%edx
    2a90:	8b 45 08             	mov    0x8(%ebp),%eax
    2a93:	01 d0                	add    %edx,%eax
    2a95:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2a98:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2a9b:	8d 50 01             	lea    0x1(%eax),%edx
    2a9e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2aa1:	89 c2                	mov    %eax,%edx
    2aa3:	8b 45 08             	mov    0x8(%ebp),%eax
    2aa6:	01 d0                	add    %edx,%eax
    2aa8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2aab:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2aad:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2ab4:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2ab8:	8b 55 0c             	mov    0xc(%ebp),%edx
    2abb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2abe:	01 d0                	add    %edx,%eax
    2ac0:	0f b6 00             	movzbl (%eax),%eax
    2ac3:	84 c0                	test   %al,%al
    2ac5:	0f 85 14 fe ff ff    	jne    28df <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2acb:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2ace:	8d 50 01             	lea    0x1(%eax),%edx
    2ad1:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2ad4:	89 c2                	mov    %eax,%edx
    2ad6:	8b 45 08             	mov    0x8(%ebp),%eax
    2ad9:	01 d0                	add    %edx,%eax
    2adb:	c6 00 00             	movb   $0x0,(%eax)
}
    2ade:	90                   	nop
    2adf:	c9                   	leave  
    2ae0:	c3                   	ret    
