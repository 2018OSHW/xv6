
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
      4b:	e8 60 07 00 00       	call   7b0 <fork>
      50:	89 45 f4             	mov    %eax,-0xc(%ebp)
    char temp[30];
    if (pid == 0)
      53:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      57:	75 37                	jne    90 <runApp+0x4b>
    {
        sprintf(temp, "AP%s", (char *)param);
      59:	83 ec 04             	sub    $0x4,%esp
      5c:	ff 75 08             	pushl  0x8(%ebp)
      5f:	68 00 2a 00 00       	push   $0x2a00
      64:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      67:	50                   	push   %eax
      68:	e8 5f 27 00 00       	call   27cc <sprintf>
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
      88:	e8 63 07 00 00       	call   7f0 <exec>
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
                    runApp("Snack");
                break;
            default:break;
        }
            break;
        default: break;
      b4:	e9 ae 03 00 00       	jmp    467 <wndProc+0x3d4>
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
      f4:	8b 04 85 20 32 00 00 	mov    0x3220(,%eax,4),%eax
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
     171:	e8 56 0f 00 00       	call   10cc <APSetPen>
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
     19a:	e8 66 0f 00 00       	call   1105 <APSetBrush>
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
     1b7:	e8 73 13 00 00       	call   152f <APDrawRect>
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
     201:	e8 41 0f 00 00       	call   1147 <APSetFont>
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
     21e:	e8 11 15 00 00       	call   1734 <APDrawText>
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
     253:	e8 cc 17 00 00       	call   1a24 <APSendMessage>
     258:	83 c4 20             	add    $0x20,%esp
            //setupTimer(hwnd,0,1000);
            return False;
     25b:	b8 00 00 00 00       	mov    $0x0,%eax
     260:	e9 1c 02 00 00       	jmp    481 <wndProc+0x3ee>
        case MSG_PAINT:
            APGridPaint(hwnd);
     265:	83 ec 0c             	sub    $0xc,%esp
     268:	ff 75 08             	pushl  0x8(%ebp)
     26b:	e8 f3 1b 00 00       	call   1e63 <APGridPaint>
     270:	83 c4 10             	add    $0x10,%esp
            AMessage ms;
            ms.type = MSG_WORD;
     273:	c7 45 cc 0a 00 00 00 	movl   $0xa,-0x34(%ebp)
            ms.param = -1;
     27a:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%ebp)
            ms.word = "Welcome!";
     281:	c7 45 d8 05 2a 00 00 	movl   $0x2a05,-0x28(%ebp)
            APSendMessage(hwnd,ms);
     288:	83 ec 0c             	sub    $0xc,%esp
     28b:	ff 75 d8             	pushl  -0x28(%ebp)
     28e:	ff 75 d4             	pushl  -0x2c(%ebp)
     291:	ff 75 d0             	pushl  -0x30(%ebp)
     294:	ff 75 cc             	pushl  -0x34(%ebp)
     297:	ff 75 08             	pushl  0x8(%ebp)
     29a:	e8 85 17 00 00       	call   1a24 <APSendMessage>
     29f:	83 c4 20             	add    $0x20,%esp
            break;
     2a2:	e9 c0 01 00 00       	jmp    467 <wndProc+0x3d4>
        case MSG_KEY_DOWN:
            //printf(1,"kbd message received!\n");
            switch (msg.param)
     2a7:	8b 45 10             	mov    0x10(%ebp),%eax
     2aa:	83 f8 06             	cmp    $0x6,%eax
     2ad:	0f 87 af 01 00 00    	ja     462 <wndProc+0x3cf>
     2b3:	8b 04 85 14 2a 00 00 	mov    0x2a14(,%eax,4),%eax
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
     2de:	e8 a3 01 00 00       	call   486 <judgeGridWalkable>
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
     30c:	e8 67 05 00 00       	call   878 <changePosition>
     311:	83 c4 10             	add    $0x10,%esp
                break;
     314:	e9 4d 01 00 00       	jmp    466 <wndProc+0x3d3>
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
     33a:	e8 47 01 00 00       	call   486 <judgeGridWalkable>
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
     368:	e8 0b 05 00 00       	call   878 <changePosition>
     36d:	83 c4 10             	add    $0x10,%esp
                break;
     370:	e9 f1 00 00 00       	jmp    466 <wndProc+0x3d3>
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
     396:	e8 eb 00 00 00       	call   486 <judgeGridWalkable>
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
     3c4:	e8 af 04 00 00       	call   878 <changePosition>
     3c9:	83 c4 10             	add    $0x10,%esp
                break;
     3cc:	e9 95 00 00 00       	jmp    466 <wndProc+0x3d3>
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
     3f3:	e8 8e 00 00 00       	call   486 <judgeGridWalkable>
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
     421:	e8 52 04 00 00       	call   878 <changePosition>
     426:	83 c4 10             	add    $0x10,%esp
                break;
     429:	eb 3b                	jmp    466 <wndProc+0x3d3>
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
     44e:	75 15                	jne    465 <wndProc+0x3d2>
                    runApp("Snack");
     450:	83 ec 0c             	sub    $0xc,%esp
     453:	68 0e 2a 00 00       	push   $0x2a0e
     458:	e8 e8 fb ff ff       	call   45 <runApp>
     45d:	83 c4 10             	add    $0x10,%esp
                break;
     460:	eb 03                	jmp    465 <wndProc+0x3d2>
            default:break;
     462:	90                   	nop
     463:	eb 01                	jmp    466 <wndProc+0x3d3>
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
                break;
            case VK_ENTER:
                if (hwnd->Grid[hwnd->pos_y * GRID_W_NUMBER + hwnd->pos_x] == GRID_PROGRAM_SNAKE)
                    runApp("Snack");
                break;
     465:	90                   	nop
            default:break;
        }
            break;
     466:	90                   	nop
        default: break;
    }
    return APWndProc(hwnd, msg);
     467:	83 ec 0c             	sub    $0xc,%esp
     46a:	ff 75 18             	pushl  0x18(%ebp)
     46d:	ff 75 14             	pushl  0x14(%ebp)
     470:	ff 75 10             	pushl  0x10(%ebp)
     473:	ff 75 0c             	pushl  0xc(%ebp)
     476:	ff 75 08             	pushl  0x8(%ebp)
     479:	e8 2a 18 00 00       	call   1ca8 <APWndProc>
     47e:	83 c4 20             	add    $0x20,%esp
}
     481:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     484:	c9                   	leave  
     485:	c3                   	ret    

00000486 <judgeGridWalkable>:

int judgeGridWalkable(int x,int y, AHwnd hwnd)
{
     486:	55                   	push   %ebp
     487:	89 e5                	mov    %esp,%ebp
     489:	83 ec 10             	sub    $0x10,%esp
    if (hwnd->is_grid)
     48c:	8b 45 10             	mov    0x10(%ebp),%eax
     48f:	8b 40 08             	mov    0x8(%eax),%eax
     492:	85 c0                	test   %eax,%eax
     494:	0f 84 80 00 00 00    	je     51a <judgeGridWalkable+0x94>
    {
        int index = hwnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER + y * GRID_W_NUMBER + x;
     49a:	8b 45 10             	mov    0x10(%ebp),%eax
     49d:	8b 50 14             	mov    0x14(%eax),%edx
     4a0:	89 d0                	mov    %edx,%eax
     4a2:	c1 e0 02             	shl    $0x2,%eax
     4a5:	01 d0                	add    %edx,%eax
     4a7:	01 c0                	add    %eax,%eax
     4a9:	01 c2                	add    %eax,%edx
     4ab:	8b 45 0c             	mov    0xc(%ebp),%eax
     4ae:	01 d0                	add    %edx,%eax
     4b0:	c1 e0 04             	shl    $0x4,%eax
     4b3:	89 c2                	mov    %eax,%edx
     4b5:	8b 45 08             	mov    0x8(%ebp),%eax
     4b8:	01 d0                	add    %edx,%eax
     4ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
        switch(hwnd->Grid[index])
     4bd:	8b 45 10             	mov    0x10(%ebp),%eax
     4c0:	8b 40 0c             	mov    0xc(%eax),%eax
     4c3:	8b 55 fc             	mov    -0x4(%ebp),%edx
     4c6:	c1 e2 02             	shl    $0x2,%edx
     4c9:	01 d0                	add    %edx,%eax
     4cb:	8b 00                	mov    (%eax),%eax
     4cd:	83 f8 07             	cmp    $0x7,%eax
     4d0:	77 41                	ja     513 <judgeGridWalkable+0x8d>
     4d2:	8b 04 85 30 2a 00 00 	mov    0x2a30(,%eax,4),%eax
     4d9:	ff e0                	jmp    *%eax
        {
                
            case GRID_WALL : return 0;
     4db:	b8 00 00 00 00       	mov    $0x0,%eax
     4e0:	eb 3d                	jmp    51f <judgeGridWalkable+0x99>
            case GRID_ROAD : return 1;
     4e2:	b8 01 00 00 00       	mov    $0x1,%eax
     4e7:	eb 36                	jmp    51f <judgeGridWalkable+0x99>
            case GRID_GRASS : return 1;
     4e9:	b8 01 00 00 00       	mov    $0x1,%eax
     4ee:	eb 2f                	jmp    51f <judgeGridWalkable+0x99>
            case GRID_RIVER : return 0;
     4f0:	b8 00 00 00 00       	mov    $0x0,%eax
     4f5:	eb 28                	jmp    51f <judgeGridWalkable+0x99>
            case GRID_FOREST: return 0;
     4f7:	b8 00 00 00 00       	mov    $0x0,%eax
     4fc:	eb 21                	jmp    51f <judgeGridWalkable+0x99>
            case GRID_STONE: return 1;
     4fe:	b8 01 00 00 00       	mov    $0x1,%eax
     503:	eb 1a                	jmp    51f <judgeGridWalkable+0x99>
            case GRID_MOUNTAIN: return 0;
     505:	b8 00 00 00 00       	mov    $0x0,%eax
     50a:	eb 13                	jmp    51f <judgeGridWalkable+0x99>
            case GRID_LAKE: return 0;
     50c:	b8 00 00 00 00       	mov    $0x0,%eax
     511:	eb 0c                	jmp    51f <judgeGridWalkable+0x99>
            default: return 1;
     513:	b8 01 00 00 00       	mov    $0x1,%eax
     518:	eb 05                	jmp    51f <judgeGridWalkable+0x99>
        }
    }
    return 0;
     51a:	b8 00 00 00 00       	mov    $0x0,%eax
}
     51f:	c9                   	leave  
     520:	c3                   	ret    

00000521 <main>:


int main(void)
{
     521:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     525:	83 e4 f0             	and    $0xfffffff0,%esp
     528:	ff 71 fc             	pushl  -0x4(%ecx)
     52b:	55                   	push   %ebp
     52c:	89 e5                	mov    %esp,%ebp
     52e:	51                   	push   %ecx
     52f:	83 ec 14             	sub    $0x14,%esp
    //runApp("MagicTower");
    AHwnd hwnd = APCreateWindow("desktop",True,3);
     532:	83 ec 04             	sub    $0x4,%esp
     535:	6a 03                	push   $0x3
     537:	6a 01                	push   $0x1
     539:	68 50 2a 00 00       	push   $0x2a50
     53e:	e8 ff 14 00 00       	call   1a42 <APCreateWindow>
     543:	83 c4 10             	add    $0x10,%esp
     546:	89 45 f4             	mov    %eax,-0xc(%ebp)
   //printf(1,"desktop initialized!\n");
    APWndExec(hwnd, wndProc);
     549:	83 ec 08             	sub    $0x8,%esp
     54c:	68 93 00 00 00       	push   $0x93
     551:	ff 75 f4             	pushl  -0xc(%ebp)
     554:	e8 66 18 00 00       	call   1dbf <APWndExec>
     559:	83 c4 10             	add    $0x10,%esp
    exit();
     55c:	e8 57 02 00 00       	call   7b8 <exit>

00000561 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     561:	55                   	push   %ebp
     562:	89 e5                	mov    %esp,%ebp
     564:	57                   	push   %edi
     565:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     566:	8b 4d 08             	mov    0x8(%ebp),%ecx
     569:	8b 55 10             	mov    0x10(%ebp),%edx
     56c:	8b 45 0c             	mov    0xc(%ebp),%eax
     56f:	89 cb                	mov    %ecx,%ebx
     571:	89 df                	mov    %ebx,%edi
     573:	89 d1                	mov    %edx,%ecx
     575:	fc                   	cld    
     576:	f3 aa                	rep stos %al,%es:(%edi)
     578:	89 ca                	mov    %ecx,%edx
     57a:	89 fb                	mov    %edi,%ebx
     57c:	89 5d 08             	mov    %ebx,0x8(%ebp)
     57f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     582:	90                   	nop
     583:	5b                   	pop    %ebx
     584:	5f                   	pop    %edi
     585:	5d                   	pop    %ebp
     586:	c3                   	ret    

00000587 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     587:	55                   	push   %ebp
     588:	89 e5                	mov    %esp,%ebp
     58a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     58d:	8b 45 08             	mov    0x8(%ebp),%eax
     590:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     593:	90                   	nop
     594:	8b 45 08             	mov    0x8(%ebp),%eax
     597:	8d 50 01             	lea    0x1(%eax),%edx
     59a:	89 55 08             	mov    %edx,0x8(%ebp)
     59d:	8b 55 0c             	mov    0xc(%ebp),%edx
     5a0:	8d 4a 01             	lea    0x1(%edx),%ecx
     5a3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     5a6:	0f b6 12             	movzbl (%edx),%edx
     5a9:	88 10                	mov    %dl,(%eax)
     5ab:	0f b6 00             	movzbl (%eax),%eax
     5ae:	84 c0                	test   %al,%al
     5b0:	75 e2                	jne    594 <strcpy+0xd>
    ;
  return os;
     5b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     5b5:	c9                   	leave  
     5b6:	c3                   	ret    

000005b7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     5b7:	55                   	push   %ebp
     5b8:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     5ba:	eb 08                	jmp    5c4 <strcmp+0xd>
    p++, q++;
     5bc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     5c0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     5c4:	8b 45 08             	mov    0x8(%ebp),%eax
     5c7:	0f b6 00             	movzbl (%eax),%eax
     5ca:	84 c0                	test   %al,%al
     5cc:	74 10                	je     5de <strcmp+0x27>
     5ce:	8b 45 08             	mov    0x8(%ebp),%eax
     5d1:	0f b6 10             	movzbl (%eax),%edx
     5d4:	8b 45 0c             	mov    0xc(%ebp),%eax
     5d7:	0f b6 00             	movzbl (%eax),%eax
     5da:	38 c2                	cmp    %al,%dl
     5dc:	74 de                	je     5bc <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     5de:	8b 45 08             	mov    0x8(%ebp),%eax
     5e1:	0f b6 00             	movzbl (%eax),%eax
     5e4:	0f b6 d0             	movzbl %al,%edx
     5e7:	8b 45 0c             	mov    0xc(%ebp),%eax
     5ea:	0f b6 00             	movzbl (%eax),%eax
     5ed:	0f b6 c0             	movzbl %al,%eax
     5f0:	29 c2                	sub    %eax,%edx
     5f2:	89 d0                	mov    %edx,%eax
}
     5f4:	5d                   	pop    %ebp
     5f5:	c3                   	ret    

000005f6 <strlen>:

uint
strlen(char *s)
{
     5f6:	55                   	push   %ebp
     5f7:	89 e5                	mov    %esp,%ebp
     5f9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     5fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     603:	eb 04                	jmp    609 <strlen+0x13>
     605:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     609:	8b 55 fc             	mov    -0x4(%ebp),%edx
     60c:	8b 45 08             	mov    0x8(%ebp),%eax
     60f:	01 d0                	add    %edx,%eax
     611:	0f b6 00             	movzbl (%eax),%eax
     614:	84 c0                	test   %al,%al
     616:	75 ed                	jne    605 <strlen+0xf>
    ;
  return n;
     618:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     61b:	c9                   	leave  
     61c:	c3                   	ret    

0000061d <memset>:

void*
memset(void *dst, int c, uint n)
{
     61d:	55                   	push   %ebp
     61e:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     620:	8b 45 10             	mov    0x10(%ebp),%eax
     623:	50                   	push   %eax
     624:	ff 75 0c             	pushl  0xc(%ebp)
     627:	ff 75 08             	pushl  0x8(%ebp)
     62a:	e8 32 ff ff ff       	call   561 <stosb>
     62f:	83 c4 0c             	add    $0xc,%esp
  return dst;
     632:	8b 45 08             	mov    0x8(%ebp),%eax
}
     635:	c9                   	leave  
     636:	c3                   	ret    

00000637 <strchr>:

char*
strchr(const char *s, char c)
{
     637:	55                   	push   %ebp
     638:	89 e5                	mov    %esp,%ebp
     63a:	83 ec 04             	sub    $0x4,%esp
     63d:	8b 45 0c             	mov    0xc(%ebp),%eax
     640:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     643:	eb 14                	jmp    659 <strchr+0x22>
    if(*s == c)
     645:	8b 45 08             	mov    0x8(%ebp),%eax
     648:	0f b6 00             	movzbl (%eax),%eax
     64b:	3a 45 fc             	cmp    -0x4(%ebp),%al
     64e:	75 05                	jne    655 <strchr+0x1e>
      return (char*)s;
     650:	8b 45 08             	mov    0x8(%ebp),%eax
     653:	eb 13                	jmp    668 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     655:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     659:	8b 45 08             	mov    0x8(%ebp),%eax
     65c:	0f b6 00             	movzbl (%eax),%eax
     65f:	84 c0                	test   %al,%al
     661:	75 e2                	jne    645 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     663:	b8 00 00 00 00       	mov    $0x0,%eax
}
     668:	c9                   	leave  
     669:	c3                   	ret    

0000066a <gets>:

char*
gets(char *buf, int max)
{
     66a:	55                   	push   %ebp
     66b:	89 e5                	mov    %esp,%ebp
     66d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     670:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     677:	eb 42                	jmp    6bb <gets+0x51>
    cc = read(0, &c, 1);
     679:	83 ec 04             	sub    $0x4,%esp
     67c:	6a 01                	push   $0x1
     67e:	8d 45 ef             	lea    -0x11(%ebp),%eax
     681:	50                   	push   %eax
     682:	6a 00                	push   $0x0
     684:	e8 47 01 00 00       	call   7d0 <read>
     689:	83 c4 10             	add    $0x10,%esp
     68c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     68f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     693:	7e 33                	jle    6c8 <gets+0x5e>
      break;
    buf[i++] = c;
     695:	8b 45 f4             	mov    -0xc(%ebp),%eax
     698:	8d 50 01             	lea    0x1(%eax),%edx
     69b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     69e:	89 c2                	mov    %eax,%edx
     6a0:	8b 45 08             	mov    0x8(%ebp),%eax
     6a3:	01 c2                	add    %eax,%edx
     6a5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     6a9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     6ab:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     6af:	3c 0a                	cmp    $0xa,%al
     6b1:	74 16                	je     6c9 <gets+0x5f>
     6b3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     6b7:	3c 0d                	cmp    $0xd,%al
     6b9:	74 0e                	je     6c9 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     6bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6be:	83 c0 01             	add    $0x1,%eax
     6c1:	3b 45 0c             	cmp    0xc(%ebp),%eax
     6c4:	7c b3                	jl     679 <gets+0xf>
     6c6:	eb 01                	jmp    6c9 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     6c8:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     6c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     6cc:	8b 45 08             	mov    0x8(%ebp),%eax
     6cf:	01 d0                	add    %edx,%eax
     6d1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     6d4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     6d7:	c9                   	leave  
     6d8:	c3                   	ret    

000006d9 <stat>:

int
stat(char *n, struct stat *st)
{
     6d9:	55                   	push   %ebp
     6da:	89 e5                	mov    %esp,%ebp
     6dc:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     6df:	83 ec 08             	sub    $0x8,%esp
     6e2:	6a 00                	push   $0x0
     6e4:	ff 75 08             	pushl  0x8(%ebp)
     6e7:	e8 0c 01 00 00       	call   7f8 <open>
     6ec:	83 c4 10             	add    $0x10,%esp
     6ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     6f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     6f6:	79 07                	jns    6ff <stat+0x26>
    return -1;
     6f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     6fd:	eb 25                	jmp    724 <stat+0x4b>
  r = fstat(fd, st);
     6ff:	83 ec 08             	sub    $0x8,%esp
     702:	ff 75 0c             	pushl  0xc(%ebp)
     705:	ff 75 f4             	pushl  -0xc(%ebp)
     708:	e8 03 01 00 00       	call   810 <fstat>
     70d:	83 c4 10             	add    $0x10,%esp
     710:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     713:	83 ec 0c             	sub    $0xc,%esp
     716:	ff 75 f4             	pushl  -0xc(%ebp)
     719:	e8 c2 00 00 00       	call   7e0 <close>
     71e:	83 c4 10             	add    $0x10,%esp
  return r;
     721:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     724:	c9                   	leave  
     725:	c3                   	ret    

00000726 <atoi>:

int
atoi(const char *s)
{
     726:	55                   	push   %ebp
     727:	89 e5                	mov    %esp,%ebp
     729:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     72c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     733:	eb 25                	jmp    75a <atoi+0x34>
    n = n*10 + *s++ - '0';
     735:	8b 55 fc             	mov    -0x4(%ebp),%edx
     738:	89 d0                	mov    %edx,%eax
     73a:	c1 e0 02             	shl    $0x2,%eax
     73d:	01 d0                	add    %edx,%eax
     73f:	01 c0                	add    %eax,%eax
     741:	89 c1                	mov    %eax,%ecx
     743:	8b 45 08             	mov    0x8(%ebp),%eax
     746:	8d 50 01             	lea    0x1(%eax),%edx
     749:	89 55 08             	mov    %edx,0x8(%ebp)
     74c:	0f b6 00             	movzbl (%eax),%eax
     74f:	0f be c0             	movsbl %al,%eax
     752:	01 c8                	add    %ecx,%eax
     754:	83 e8 30             	sub    $0x30,%eax
     757:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     75a:	8b 45 08             	mov    0x8(%ebp),%eax
     75d:	0f b6 00             	movzbl (%eax),%eax
     760:	3c 2f                	cmp    $0x2f,%al
     762:	7e 0a                	jle    76e <atoi+0x48>
     764:	8b 45 08             	mov    0x8(%ebp),%eax
     767:	0f b6 00             	movzbl (%eax),%eax
     76a:	3c 39                	cmp    $0x39,%al
     76c:	7e c7                	jle    735 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     76e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     771:	c9                   	leave  
     772:	c3                   	ret    

00000773 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     773:	55                   	push   %ebp
     774:	89 e5                	mov    %esp,%ebp
     776:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     779:	8b 45 08             	mov    0x8(%ebp),%eax
     77c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     77f:	8b 45 0c             	mov    0xc(%ebp),%eax
     782:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     785:	eb 17                	jmp    79e <memmove+0x2b>
    *dst++ = *src++;
     787:	8b 45 fc             	mov    -0x4(%ebp),%eax
     78a:	8d 50 01             	lea    0x1(%eax),%edx
     78d:	89 55 fc             	mov    %edx,-0x4(%ebp)
     790:	8b 55 f8             	mov    -0x8(%ebp),%edx
     793:	8d 4a 01             	lea    0x1(%edx),%ecx
     796:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     799:	0f b6 12             	movzbl (%edx),%edx
     79c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     79e:	8b 45 10             	mov    0x10(%ebp),%eax
     7a1:	8d 50 ff             	lea    -0x1(%eax),%edx
     7a4:	89 55 10             	mov    %edx,0x10(%ebp)
     7a7:	85 c0                	test   %eax,%eax
     7a9:	7f dc                	jg     787 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     7ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
     7ae:	c9                   	leave  
     7af:	c3                   	ret    

000007b0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     7b0:	b8 01 00 00 00       	mov    $0x1,%eax
     7b5:	cd 40                	int    $0x40
     7b7:	c3                   	ret    

000007b8 <exit>:
SYSCALL(exit)
     7b8:	b8 02 00 00 00       	mov    $0x2,%eax
     7bd:	cd 40                	int    $0x40
     7bf:	c3                   	ret    

000007c0 <wait>:
SYSCALL(wait)
     7c0:	b8 03 00 00 00       	mov    $0x3,%eax
     7c5:	cd 40                	int    $0x40
     7c7:	c3                   	ret    

000007c8 <pipe>:
SYSCALL(pipe)
     7c8:	b8 04 00 00 00       	mov    $0x4,%eax
     7cd:	cd 40                	int    $0x40
     7cf:	c3                   	ret    

000007d0 <read>:
SYSCALL(read)
     7d0:	b8 05 00 00 00       	mov    $0x5,%eax
     7d5:	cd 40                	int    $0x40
     7d7:	c3                   	ret    

000007d8 <write>:
SYSCALL(write)
     7d8:	b8 10 00 00 00       	mov    $0x10,%eax
     7dd:	cd 40                	int    $0x40
     7df:	c3                   	ret    

000007e0 <close>:
SYSCALL(close)
     7e0:	b8 15 00 00 00       	mov    $0x15,%eax
     7e5:	cd 40                	int    $0x40
     7e7:	c3                   	ret    

000007e8 <kill>:
SYSCALL(kill)
     7e8:	b8 06 00 00 00       	mov    $0x6,%eax
     7ed:	cd 40                	int    $0x40
     7ef:	c3                   	ret    

000007f0 <exec>:
SYSCALL(exec)
     7f0:	b8 07 00 00 00       	mov    $0x7,%eax
     7f5:	cd 40                	int    $0x40
     7f7:	c3                   	ret    

000007f8 <open>:
SYSCALL(open)
     7f8:	b8 0f 00 00 00       	mov    $0xf,%eax
     7fd:	cd 40                	int    $0x40
     7ff:	c3                   	ret    

00000800 <mknod>:
SYSCALL(mknod)
     800:	b8 11 00 00 00       	mov    $0x11,%eax
     805:	cd 40                	int    $0x40
     807:	c3                   	ret    

00000808 <unlink>:
SYSCALL(unlink)
     808:	b8 12 00 00 00       	mov    $0x12,%eax
     80d:	cd 40                	int    $0x40
     80f:	c3                   	ret    

00000810 <fstat>:
SYSCALL(fstat)
     810:	b8 08 00 00 00       	mov    $0x8,%eax
     815:	cd 40                	int    $0x40
     817:	c3                   	ret    

00000818 <link>:
SYSCALL(link)
     818:	b8 13 00 00 00       	mov    $0x13,%eax
     81d:	cd 40                	int    $0x40
     81f:	c3                   	ret    

00000820 <mkdir>:
SYSCALL(mkdir)
     820:	b8 14 00 00 00       	mov    $0x14,%eax
     825:	cd 40                	int    $0x40
     827:	c3                   	ret    

00000828 <chdir>:
SYSCALL(chdir)
     828:	b8 09 00 00 00       	mov    $0x9,%eax
     82d:	cd 40                	int    $0x40
     82f:	c3                   	ret    

00000830 <dup>:
SYSCALL(dup)
     830:	b8 0a 00 00 00       	mov    $0xa,%eax
     835:	cd 40                	int    $0x40
     837:	c3                   	ret    

00000838 <getpid>:
SYSCALL(getpid)
     838:	b8 0b 00 00 00       	mov    $0xb,%eax
     83d:	cd 40                	int    $0x40
     83f:	c3                   	ret    

00000840 <sbrk>:
SYSCALL(sbrk)
     840:	b8 0c 00 00 00       	mov    $0xc,%eax
     845:	cd 40                	int    $0x40
     847:	c3                   	ret    

00000848 <sleep>:
SYSCALL(sleep)
     848:	b8 0d 00 00 00       	mov    $0xd,%eax
     84d:	cd 40                	int    $0x40
     84f:	c3                   	ret    

00000850 <uptime>:
SYSCALL(uptime)
     850:	b8 0e 00 00 00       	mov    $0xe,%eax
     855:	cd 40                	int    $0x40
     857:	c3                   	ret    

00000858 <paintWindow>:

SYSCALL(paintWindow)
     858:	b8 16 00 00 00       	mov    $0x16,%eax
     85d:	cd 40                	int    $0x40
     85f:	c3                   	ret    

00000860 <sendMessage>:
SYSCALL(sendMessage)
     860:	b8 17 00 00 00       	mov    $0x17,%eax
     865:	cd 40                	int    $0x40
     867:	c3                   	ret    

00000868 <getMessage>:
SYSCALL(getMessage)
     868:	b8 19 00 00 00       	mov    $0x19,%eax
     86d:	cd 40                	int    $0x40
     86f:	c3                   	ret    

00000870 <registWindow>:
SYSCALL(registWindow)
     870:	b8 18 00 00 00       	mov    $0x18,%eax
     875:	cd 40                	int    $0x40
     877:	c3                   	ret    

00000878 <changePosition>:
SYSCALL(changePosition)
     878:	b8 1a 00 00 00       	mov    $0x1a,%eax
     87d:	cd 40                	int    $0x40
     87f:	c3                   	ret    

00000880 <setupTimer>:
SYSCALL(setupTimer)
     880:	b8 1b 00 00 00       	mov    $0x1b,%eax
     885:	cd 40                	int    $0x40
     887:	c3                   	ret    

00000888 <deleteTimer>:
SYSCALL(deleteTimer)
     888:	b8 1c 00 00 00       	mov    $0x1c,%eax
     88d:	cd 40                	int    $0x40
     88f:	c3                   	ret    

00000890 <getCurrentTime>:
SYSCALL(getCurrentTime)
     890:	b8 1d 00 00 00       	mov    $0x1d,%eax
     895:	cd 40                	int    $0x40
     897:	c3                   	ret    

00000898 <removeWindow>:
SYSCALL(removeWindow)
     898:	b8 1e 00 00 00       	mov    $0x1e,%eax
     89d:	cd 40                	int    $0x40
     89f:	c3                   	ret    

000008a0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     8a0:	55                   	push   %ebp
     8a1:	89 e5                	mov    %esp,%ebp
     8a3:	83 ec 18             	sub    $0x18,%esp
     8a6:	8b 45 0c             	mov    0xc(%ebp),%eax
     8a9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     8ac:	83 ec 04             	sub    $0x4,%esp
     8af:	6a 01                	push   $0x1
     8b1:	8d 45 f4             	lea    -0xc(%ebp),%eax
     8b4:	50                   	push   %eax
     8b5:	ff 75 08             	pushl  0x8(%ebp)
     8b8:	e8 1b ff ff ff       	call   7d8 <write>
     8bd:	83 c4 10             	add    $0x10,%esp
}
     8c0:	90                   	nop
     8c1:	c9                   	leave  
     8c2:	c3                   	ret    

000008c3 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     8c3:	55                   	push   %ebp
     8c4:	89 e5                	mov    %esp,%ebp
     8c6:	53                   	push   %ebx
     8c7:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     8ca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     8d1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     8d5:	74 17                	je     8ee <printint+0x2b>
     8d7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8db:	79 11                	jns    8ee <printint+0x2b>
    neg = 1;
     8dd:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     8e4:	8b 45 0c             	mov    0xc(%ebp),%eax
     8e7:	f7 d8                	neg    %eax
     8e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
     8ec:	eb 06                	jmp    8f4 <printint+0x31>
  } else {
    x = xx;
     8ee:	8b 45 0c             	mov    0xc(%ebp),%eax
     8f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     8f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     8fb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     8fe:	8d 41 01             	lea    0x1(%ecx),%eax
     901:	89 45 f4             	mov    %eax,-0xc(%ebp)
     904:	8b 5d 10             	mov    0x10(%ebp),%ebx
     907:	8b 45 ec             	mov    -0x14(%ebp),%eax
     90a:	ba 00 00 00 00       	mov    $0x0,%edx
     90f:	f7 f3                	div    %ebx
     911:	89 d0                	mov    %edx,%eax
     913:	0f b6 80 e0 34 00 00 	movzbl 0x34e0(%eax),%eax
     91a:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     91e:	8b 5d 10             	mov    0x10(%ebp),%ebx
     921:	8b 45 ec             	mov    -0x14(%ebp),%eax
     924:	ba 00 00 00 00       	mov    $0x0,%edx
     929:	f7 f3                	div    %ebx
     92b:	89 45 ec             	mov    %eax,-0x14(%ebp)
     92e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     932:	75 c7                	jne    8fb <printint+0x38>
  if(neg)
     934:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     938:	74 2d                	je     967 <printint+0xa4>
    buf[i++] = '-';
     93a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     93d:	8d 50 01             	lea    0x1(%eax),%edx
     940:	89 55 f4             	mov    %edx,-0xc(%ebp)
     943:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     948:	eb 1d                	jmp    967 <printint+0xa4>
    putc(fd, buf[i]);
     94a:	8d 55 dc             	lea    -0x24(%ebp),%edx
     94d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     950:	01 d0                	add    %edx,%eax
     952:	0f b6 00             	movzbl (%eax),%eax
     955:	0f be c0             	movsbl %al,%eax
     958:	83 ec 08             	sub    $0x8,%esp
     95b:	50                   	push   %eax
     95c:	ff 75 08             	pushl  0x8(%ebp)
     95f:	e8 3c ff ff ff       	call   8a0 <putc>
     964:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     967:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     96b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     96f:	79 d9                	jns    94a <printint+0x87>
    putc(fd, buf[i]);
}
     971:	90                   	nop
     972:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     975:	c9                   	leave  
     976:	c3                   	ret    

00000977 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     977:	55                   	push   %ebp
     978:	89 e5                	mov    %esp,%ebp
     97a:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     97d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     984:	8d 45 0c             	lea    0xc(%ebp),%eax
     987:	83 c0 04             	add    $0x4,%eax
     98a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     98d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     994:	e9 59 01 00 00       	jmp    af2 <printf+0x17b>
    c = fmt[i] & 0xff;
     999:	8b 55 0c             	mov    0xc(%ebp),%edx
     99c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     99f:	01 d0                	add    %edx,%eax
     9a1:	0f b6 00             	movzbl (%eax),%eax
     9a4:	0f be c0             	movsbl %al,%eax
     9a7:	25 ff 00 00 00       	and    $0xff,%eax
     9ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     9af:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     9b3:	75 2c                	jne    9e1 <printf+0x6a>
      if(c == '%'){
     9b5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     9b9:	75 0c                	jne    9c7 <printf+0x50>
        state = '%';
     9bb:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     9c2:	e9 27 01 00 00       	jmp    aee <printf+0x177>
      } else {
        putc(fd, c);
     9c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9ca:	0f be c0             	movsbl %al,%eax
     9cd:	83 ec 08             	sub    $0x8,%esp
     9d0:	50                   	push   %eax
     9d1:	ff 75 08             	pushl  0x8(%ebp)
     9d4:	e8 c7 fe ff ff       	call   8a0 <putc>
     9d9:	83 c4 10             	add    $0x10,%esp
     9dc:	e9 0d 01 00 00       	jmp    aee <printf+0x177>
      }
    } else if(state == '%'){
     9e1:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     9e5:	0f 85 03 01 00 00    	jne    aee <printf+0x177>
      if(c == 'd'){
     9eb:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     9ef:	75 1e                	jne    a0f <printf+0x98>
        printint(fd, *ap, 10, 1);
     9f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9f4:	8b 00                	mov    (%eax),%eax
     9f6:	6a 01                	push   $0x1
     9f8:	6a 0a                	push   $0xa
     9fa:	50                   	push   %eax
     9fb:	ff 75 08             	pushl  0x8(%ebp)
     9fe:	e8 c0 fe ff ff       	call   8c3 <printint>
     a03:	83 c4 10             	add    $0x10,%esp
        ap++;
     a06:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     a0a:	e9 d8 00 00 00       	jmp    ae7 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     a0f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     a13:	74 06                	je     a1b <printf+0xa4>
     a15:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     a19:	75 1e                	jne    a39 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     a1b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a1e:	8b 00                	mov    (%eax),%eax
     a20:	6a 00                	push   $0x0
     a22:	6a 10                	push   $0x10
     a24:	50                   	push   %eax
     a25:	ff 75 08             	pushl  0x8(%ebp)
     a28:	e8 96 fe ff ff       	call   8c3 <printint>
     a2d:	83 c4 10             	add    $0x10,%esp
        ap++;
     a30:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     a34:	e9 ae 00 00 00       	jmp    ae7 <printf+0x170>
      } else if(c == 's'){
     a39:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     a3d:	75 43                	jne    a82 <printf+0x10b>
        s = (char*)*ap;
     a3f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a42:	8b 00                	mov    (%eax),%eax
     a44:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     a47:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     a4b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a4f:	75 25                	jne    a76 <printf+0xff>
          s = "(null)";
     a51:	c7 45 f4 58 2a 00 00 	movl   $0x2a58,-0xc(%ebp)
        while(*s != 0){
     a58:	eb 1c                	jmp    a76 <printf+0xff>
          putc(fd, *s);
     a5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a5d:	0f b6 00             	movzbl (%eax),%eax
     a60:	0f be c0             	movsbl %al,%eax
     a63:	83 ec 08             	sub    $0x8,%esp
     a66:	50                   	push   %eax
     a67:	ff 75 08             	pushl  0x8(%ebp)
     a6a:	e8 31 fe ff ff       	call   8a0 <putc>
     a6f:	83 c4 10             	add    $0x10,%esp
          s++;
     a72:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     a76:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a79:	0f b6 00             	movzbl (%eax),%eax
     a7c:	84 c0                	test   %al,%al
     a7e:	75 da                	jne    a5a <printf+0xe3>
     a80:	eb 65                	jmp    ae7 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     a82:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     a86:	75 1d                	jne    aa5 <printf+0x12e>
        putc(fd, *ap);
     a88:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a8b:	8b 00                	mov    (%eax),%eax
     a8d:	0f be c0             	movsbl %al,%eax
     a90:	83 ec 08             	sub    $0x8,%esp
     a93:	50                   	push   %eax
     a94:	ff 75 08             	pushl  0x8(%ebp)
     a97:	e8 04 fe ff ff       	call   8a0 <putc>
     a9c:	83 c4 10             	add    $0x10,%esp
        ap++;
     a9f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     aa3:	eb 42                	jmp    ae7 <printf+0x170>
      } else if(c == '%'){
     aa5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     aa9:	75 17                	jne    ac2 <printf+0x14b>
        putc(fd, c);
     aab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     aae:	0f be c0             	movsbl %al,%eax
     ab1:	83 ec 08             	sub    $0x8,%esp
     ab4:	50                   	push   %eax
     ab5:	ff 75 08             	pushl  0x8(%ebp)
     ab8:	e8 e3 fd ff ff       	call   8a0 <putc>
     abd:	83 c4 10             	add    $0x10,%esp
     ac0:	eb 25                	jmp    ae7 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     ac2:	83 ec 08             	sub    $0x8,%esp
     ac5:	6a 25                	push   $0x25
     ac7:	ff 75 08             	pushl  0x8(%ebp)
     aca:	e8 d1 fd ff ff       	call   8a0 <putc>
     acf:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     ad2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ad5:	0f be c0             	movsbl %al,%eax
     ad8:	83 ec 08             	sub    $0x8,%esp
     adb:	50                   	push   %eax
     adc:	ff 75 08             	pushl  0x8(%ebp)
     adf:	e8 bc fd ff ff       	call   8a0 <putc>
     ae4:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     ae7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     aee:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     af2:	8b 55 0c             	mov    0xc(%ebp),%edx
     af5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     af8:	01 d0                	add    %edx,%eax
     afa:	0f b6 00             	movzbl (%eax),%eax
     afd:	84 c0                	test   %al,%al
     aff:	0f 85 94 fe ff ff    	jne    999 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     b05:	90                   	nop
     b06:	c9                   	leave  
     b07:	c3                   	ret    

00000b08 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     b08:	55                   	push   %ebp
     b09:	89 e5                	mov    %esp,%ebp
     b0b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     b0e:	8b 45 08             	mov    0x8(%ebp),%eax
     b11:	83 e8 08             	sub    $0x8,%eax
     b14:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b17:	a1 40 71 00 00       	mov    0x7140,%eax
     b1c:	89 45 fc             	mov    %eax,-0x4(%ebp)
     b1f:	eb 24                	jmp    b45 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     b21:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b24:	8b 00                	mov    (%eax),%eax
     b26:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     b29:	77 12                	ja     b3d <free+0x35>
     b2b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b2e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     b31:	77 24                	ja     b57 <free+0x4f>
     b33:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b36:	8b 00                	mov    (%eax),%eax
     b38:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     b3b:	77 1a                	ja     b57 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b40:	8b 00                	mov    (%eax),%eax
     b42:	89 45 fc             	mov    %eax,-0x4(%ebp)
     b45:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b48:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     b4b:	76 d4                	jbe    b21 <free+0x19>
     b4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b50:	8b 00                	mov    (%eax),%eax
     b52:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     b55:	76 ca                	jbe    b21 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     b57:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b5a:	8b 40 04             	mov    0x4(%eax),%eax
     b5d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     b64:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b67:	01 c2                	add    %eax,%edx
     b69:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b6c:	8b 00                	mov    (%eax),%eax
     b6e:	39 c2                	cmp    %eax,%edx
     b70:	75 24                	jne    b96 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     b72:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b75:	8b 50 04             	mov    0x4(%eax),%edx
     b78:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b7b:	8b 00                	mov    (%eax),%eax
     b7d:	8b 40 04             	mov    0x4(%eax),%eax
     b80:	01 c2                	add    %eax,%edx
     b82:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b85:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     b88:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b8b:	8b 00                	mov    (%eax),%eax
     b8d:	8b 10                	mov    (%eax),%edx
     b8f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b92:	89 10                	mov    %edx,(%eax)
     b94:	eb 0a                	jmp    ba0 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     b96:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b99:	8b 10                	mov    (%eax),%edx
     b9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b9e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     ba0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ba3:	8b 40 04             	mov    0x4(%eax),%eax
     ba6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     bad:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bb0:	01 d0                	add    %edx,%eax
     bb2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     bb5:	75 20                	jne    bd7 <free+0xcf>
    p->s.size += bp->s.size;
     bb7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bba:	8b 50 04             	mov    0x4(%eax),%edx
     bbd:	8b 45 f8             	mov    -0x8(%ebp),%eax
     bc0:	8b 40 04             	mov    0x4(%eax),%eax
     bc3:	01 c2                	add    %eax,%edx
     bc5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bc8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     bcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     bce:	8b 10                	mov    (%eax),%edx
     bd0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bd3:	89 10                	mov    %edx,(%eax)
     bd5:	eb 08                	jmp    bdf <free+0xd7>
  } else
    p->s.ptr = bp;
     bd7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bda:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bdd:	89 10                	mov    %edx,(%eax)
  freep = p;
     bdf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     be2:	a3 40 71 00 00       	mov    %eax,0x7140
}
     be7:	90                   	nop
     be8:	c9                   	leave  
     be9:	c3                   	ret    

00000bea <morecore>:

static Header*
morecore(uint nu)
{
     bea:	55                   	push   %ebp
     beb:	89 e5                	mov    %esp,%ebp
     bed:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     bf0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     bf7:	77 07                	ja     c00 <morecore+0x16>
    nu = 4096;
     bf9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     c00:	8b 45 08             	mov    0x8(%ebp),%eax
     c03:	c1 e0 03             	shl    $0x3,%eax
     c06:	83 ec 0c             	sub    $0xc,%esp
     c09:	50                   	push   %eax
     c0a:	e8 31 fc ff ff       	call   840 <sbrk>
     c0f:	83 c4 10             	add    $0x10,%esp
     c12:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     c15:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     c19:	75 07                	jne    c22 <morecore+0x38>
    return 0;
     c1b:	b8 00 00 00 00       	mov    $0x0,%eax
     c20:	eb 26                	jmp    c48 <morecore+0x5e>
  hp = (Header*)p;
     c22:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     c28:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c2b:	8b 55 08             	mov    0x8(%ebp),%edx
     c2e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     c31:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c34:	83 c0 08             	add    $0x8,%eax
     c37:	83 ec 0c             	sub    $0xc,%esp
     c3a:	50                   	push   %eax
     c3b:	e8 c8 fe ff ff       	call   b08 <free>
     c40:	83 c4 10             	add    $0x10,%esp
  return freep;
     c43:	a1 40 71 00 00       	mov    0x7140,%eax
}
     c48:	c9                   	leave  
     c49:	c3                   	ret    

00000c4a <malloc>:

void*
malloc(uint nbytes)
{
     c4a:	55                   	push   %ebp
     c4b:	89 e5                	mov    %esp,%ebp
     c4d:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     c50:	8b 45 08             	mov    0x8(%ebp),%eax
     c53:	83 c0 07             	add    $0x7,%eax
     c56:	c1 e8 03             	shr    $0x3,%eax
     c59:	83 c0 01             	add    $0x1,%eax
     c5c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     c5f:	a1 40 71 00 00       	mov    0x7140,%eax
     c64:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c67:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     c6b:	75 23                	jne    c90 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     c6d:	c7 45 f0 38 71 00 00 	movl   $0x7138,-0x10(%ebp)
     c74:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c77:	a3 40 71 00 00       	mov    %eax,0x7140
     c7c:	a1 40 71 00 00       	mov    0x7140,%eax
     c81:	a3 38 71 00 00       	mov    %eax,0x7138
    base.s.size = 0;
     c86:	c7 05 3c 71 00 00 00 	movl   $0x0,0x713c
     c8d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     c90:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c93:	8b 00                	mov    (%eax),%eax
     c95:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     c98:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c9b:	8b 40 04             	mov    0x4(%eax),%eax
     c9e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     ca1:	72 4d                	jb     cf0 <malloc+0xa6>
      if(p->s.size == nunits)
     ca3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca6:	8b 40 04             	mov    0x4(%eax),%eax
     ca9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     cac:	75 0c                	jne    cba <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     cae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cb1:	8b 10                	mov    (%eax),%edx
     cb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cb6:	89 10                	mov    %edx,(%eax)
     cb8:	eb 26                	jmp    ce0 <malloc+0x96>
      else {
        p->s.size -= nunits;
     cba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cbd:	8b 40 04             	mov    0x4(%eax),%eax
     cc0:	2b 45 ec             	sub    -0x14(%ebp),%eax
     cc3:	89 c2                	mov    %eax,%edx
     cc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc8:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     ccb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cce:	8b 40 04             	mov    0x4(%eax),%eax
     cd1:	c1 e0 03             	shl    $0x3,%eax
     cd4:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     cd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cda:	8b 55 ec             	mov    -0x14(%ebp),%edx
     cdd:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     ce0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ce3:	a3 40 71 00 00       	mov    %eax,0x7140
      return (void*)(p + 1);
     ce8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ceb:	83 c0 08             	add    $0x8,%eax
     cee:	eb 3b                	jmp    d2b <malloc+0xe1>
    }
    if(p == freep)
     cf0:	a1 40 71 00 00       	mov    0x7140,%eax
     cf5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     cf8:	75 1e                	jne    d18 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     cfa:	83 ec 0c             	sub    $0xc,%esp
     cfd:	ff 75 ec             	pushl  -0x14(%ebp)
     d00:	e8 e5 fe ff ff       	call   bea <morecore>
     d05:	83 c4 10             	add    $0x10,%esp
     d08:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d0b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     d0f:	75 07                	jne    d18 <malloc+0xce>
        return 0;
     d11:	b8 00 00 00 00       	mov    $0x0,%eax
     d16:	eb 13                	jmp    d2b <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d18:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
     d1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d21:	8b 00                	mov    (%eax),%eax
     d23:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     d26:	e9 6d ff ff ff       	jmp    c98 <malloc+0x4e>
}
     d2b:	c9                   	leave  
     d2c:	c3                   	ret    

00000d2d <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     d2d:	55                   	push   %ebp
     d2e:	89 e5                	mov    %esp,%ebp
     d30:	83 ec 1c             	sub    $0x1c,%esp
     d33:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     d36:	8b 55 10             	mov    0x10(%ebp),%edx
     d39:	8b 45 14             	mov    0x14(%ebp),%eax
     d3c:	88 4d ec             	mov    %cl,-0x14(%ebp)
     d3f:	88 55 e8             	mov    %dl,-0x18(%ebp)
     d42:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     d45:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     d49:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     d4c:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     d50:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     d53:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     d57:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     d5a:	8b 45 08             	mov    0x8(%ebp),%eax
     d5d:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d61:	66 89 10             	mov    %dx,(%eax)
     d64:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d68:	88 50 02             	mov    %dl,0x2(%eax)
}
     d6b:	8b 45 08             	mov    0x8(%ebp),%eax
     d6e:	c9                   	leave  
     d6f:	c2 04 00             	ret    $0x4

00000d72 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     d72:	55                   	push   %ebp
     d73:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     d75:	8b 45 08             	mov    0x8(%ebp),%eax
     d78:	2b 45 10             	sub    0x10(%ebp),%eax
     d7b:	89 c2                	mov    %eax,%edx
     d7d:	8b 45 08             	mov    0x8(%ebp),%eax
     d80:	2b 45 10             	sub    0x10(%ebp),%eax
     d83:	0f af d0             	imul   %eax,%edx
     d86:	8b 45 0c             	mov    0xc(%ebp),%eax
     d89:	2b 45 14             	sub    0x14(%ebp),%eax
     d8c:	89 c1                	mov    %eax,%ecx
     d8e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d91:	2b 45 14             	sub    0x14(%ebp),%eax
     d94:	0f af c1             	imul   %ecx,%eax
     d97:	01 d0                	add    %edx,%eax
}
     d99:	5d                   	pop    %ebp
     d9a:	c3                   	ret    

00000d9b <abs_int>:

static inline int abs_int(int x)
{
     d9b:	55                   	push   %ebp
     d9c:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     d9e:	8b 45 08             	mov    0x8(%ebp),%eax
     da1:	99                   	cltd   
     da2:	89 d0                	mov    %edx,%eax
     da4:	33 45 08             	xor    0x8(%ebp),%eax
     da7:	29 d0                	sub    %edx,%eax
}
     da9:	5d                   	pop    %ebp
     daa:	c3                   	ret    

00000dab <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     dab:	55                   	push   %ebp
     dac:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     dae:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     db2:	79 07                	jns    dbb <APGetIndex+0x10>
        return X_SMALLER;
     db4:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     db9:	eb 40                	jmp    dfb <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     dbb:	8b 45 08             	mov    0x8(%ebp),%eax
     dbe:	8b 00                	mov    (%eax),%eax
     dc0:	3b 45 0c             	cmp    0xc(%ebp),%eax
     dc3:	7f 07                	jg     dcc <APGetIndex+0x21>
        return X_BIGGER;
     dc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     dca:	eb 2f                	jmp    dfb <APGetIndex+0x50>
    if (y < 0)
     dcc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dd0:	79 07                	jns    dd9 <APGetIndex+0x2e>
        return Y_SMALLER;
     dd2:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     dd7:	eb 22                	jmp    dfb <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     dd9:	8b 45 08             	mov    0x8(%ebp),%eax
     ddc:	8b 40 04             	mov    0x4(%eax),%eax
     ddf:	3b 45 10             	cmp    0x10(%ebp),%eax
     de2:	7f 07                	jg     deb <APGetIndex+0x40>
        return Y_BIGGER;
     de4:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     de9:	eb 10                	jmp    dfb <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     deb:	8b 45 08             	mov    0x8(%ebp),%eax
     dee:	8b 00                	mov    (%eax),%eax
     df0:	0f af 45 10          	imul   0x10(%ebp),%eax
     df4:	89 c2                	mov    %eax,%edx
     df6:	8b 45 0c             	mov    0xc(%ebp),%eax
     df9:	01 d0                	add    %edx,%eax
}
     dfb:	5d                   	pop    %ebp
     dfc:	c3                   	ret    

00000dfd <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     dfd:	55                   	push   %ebp
     dfe:	89 e5                	mov    %esp,%ebp
     e00:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     e03:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     e0a:	8b 45 cc             	mov    -0x34(%ebp),%eax
     e0d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     e10:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     e17:	83 ec 08             	sub    $0x8,%esp
     e1a:	6a 00                	push   $0x0
     e1c:	ff 75 0c             	pushl  0xc(%ebp)
     e1f:	e8 d4 f9 ff ff       	call   7f8 <open>
     e24:	83 c4 10             	add    $0x10,%esp
     e27:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     e2a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     e2e:	79 2e                	jns    e5e <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     e30:	83 ec 04             	sub    $0x4,%esp
     e33:	ff 75 0c             	pushl  0xc(%ebp)
     e36:	68 5f 2a 00 00       	push   $0x2a5f
     e3b:	6a 01                	push   $0x1
     e3d:	e8 35 fb ff ff       	call   977 <printf>
     e42:	83 c4 10             	add    $0x10,%esp
        return bmp;
     e45:	8b 45 08             	mov    0x8(%ebp),%eax
     e48:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e4b:	89 10                	mov    %edx,(%eax)
     e4d:	8b 55 cc             	mov    -0x34(%ebp),%edx
     e50:	89 50 04             	mov    %edx,0x4(%eax)
     e53:	8b 55 d0             	mov    -0x30(%ebp),%edx
     e56:	89 50 08             	mov    %edx,0x8(%eax)
     e59:	e9 d2 01 00 00       	jmp    1030 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     e5e:	83 ec 04             	sub    $0x4,%esp
     e61:	6a 0e                	push   $0xe
     e63:	8d 45 ba             	lea    -0x46(%ebp),%eax
     e66:	50                   	push   %eax
     e67:	ff 75 ec             	pushl  -0x14(%ebp)
     e6a:	e8 61 f9 ff ff       	call   7d0 <read>
     e6f:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     e72:	83 ec 04             	sub    $0x4,%esp
     e75:	6a 28                	push   $0x28
     e77:	8d 45 92             	lea    -0x6e(%ebp),%eax
     e7a:	50                   	push   %eax
     e7b:	ff 75 ec             	pushl  -0x14(%ebp)
     e7e:	e8 4d f9 ff ff       	call   7d0 <read>
     e83:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     e86:	8b 45 96             	mov    -0x6a(%ebp),%eax
     e89:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     e8c:	8b 45 9a             	mov    -0x66(%ebp),%eax
     e8f:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     e92:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e95:	8b 45 cc             	mov    -0x34(%ebp),%eax
     e98:	0f af d0             	imul   %eax,%edx
     e9b:	89 d0                	mov    %edx,%eax
     e9d:	01 c0                	add    %eax,%eax
     e9f:	01 d0                	add    %edx,%eax
     ea1:	83 ec 0c             	sub    $0xc,%esp
     ea4:	50                   	push   %eax
     ea5:	e8 a0 fd ff ff       	call   c4a <malloc>
     eaa:	83 c4 10             	add    $0x10,%esp
     ead:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     eb0:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     eb4:	0f b7 c0             	movzwl %ax,%eax
     eb7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     eba:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ebd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ec0:	0f af c2             	imul   %edx,%eax
     ec3:	83 c0 1f             	add    $0x1f,%eax
     ec6:	c1 e8 05             	shr    $0x5,%eax
     ec9:	c1 e0 02             	shl    $0x2,%eax
     ecc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     ecf:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ed2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ed5:	0f af c2             	imul   %edx,%eax
     ed8:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     edb:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ede:	83 ec 0c             	sub    $0xc,%esp
     ee1:	50                   	push   %eax
     ee2:	e8 63 fd ff ff       	call   c4a <malloc>
     ee7:	83 c4 10             	add    $0x10,%esp
     eea:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     eed:	83 ec 04             	sub    $0x4,%esp
     ef0:	ff 75 e0             	pushl  -0x20(%ebp)
     ef3:	ff 75 dc             	pushl  -0x24(%ebp)
     ef6:	ff 75 ec             	pushl  -0x14(%ebp)
     ef9:	e8 d2 f8 ff ff       	call   7d0 <read>
     efe:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     f01:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     f05:	66 c1 e8 03          	shr    $0x3,%ax
     f09:	0f b7 c0             	movzwl %ax,%eax
     f0c:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     f0f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     f16:	e9 e5 00 00 00       	jmp    1000 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     f1b:	8b 55 cc             	mov    -0x34(%ebp),%edx
     f1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f21:	29 c2                	sub    %eax,%edx
     f23:	89 d0                	mov    %edx,%eax
     f25:	8d 50 ff             	lea    -0x1(%eax),%edx
     f28:	8b 45 c8             	mov    -0x38(%ebp),%eax
     f2b:	0f af c2             	imul   %edx,%eax
     f2e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     f31:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     f38:	e9 b1 00 00 00       	jmp    fee <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     f3d:	8b 55 d0             	mov    -0x30(%ebp),%edx
     f40:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     f43:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f46:	01 c8                	add    %ecx,%eax
     f48:	89 c1                	mov    %eax,%ecx
     f4a:	89 c8                	mov    %ecx,%eax
     f4c:	01 c0                	add    %eax,%eax
     f4e:	01 c8                	add    %ecx,%eax
     f50:	01 c2                	add    %eax,%edx
     f52:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f55:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     f59:	89 c1                	mov    %eax,%ecx
     f5b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     f5e:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     f62:	01 c1                	add    %eax,%ecx
     f64:	8b 45 d8             	mov    -0x28(%ebp),%eax
     f67:	01 c8                	add    %ecx,%eax
     f69:	8d 48 ff             	lea    -0x1(%eax),%ecx
     f6c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     f6f:	01 c8                	add    %ecx,%eax
     f71:	0f b6 00             	movzbl (%eax),%eax
     f74:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     f77:	8b 55 d0             	mov    -0x30(%ebp),%edx
     f7a:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     f7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f80:	01 c8                	add    %ecx,%eax
     f82:	89 c1                	mov    %eax,%ecx
     f84:	89 c8                	mov    %ecx,%eax
     f86:	01 c0                	add    %eax,%eax
     f88:	01 c8                	add    %ecx,%eax
     f8a:	01 c2                	add    %eax,%edx
     f8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f8f:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     f93:	89 c1                	mov    %eax,%ecx
     f95:	8b 45 d8             	mov    -0x28(%ebp),%eax
     f98:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     f9c:	01 c1                	add    %eax,%ecx
     f9e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     fa1:	01 c8                	add    %ecx,%eax
     fa3:	8d 48 fe             	lea    -0x2(%eax),%ecx
     fa6:	8b 45 dc             	mov    -0x24(%ebp),%eax
     fa9:	01 c8                	add    %ecx,%eax
     fab:	0f b6 00             	movzbl (%eax),%eax
     fae:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     fb1:	8b 55 d0             	mov    -0x30(%ebp),%edx
     fb4:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     fb7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fba:	01 c8                	add    %ecx,%eax
     fbc:	89 c1                	mov    %eax,%ecx
     fbe:	89 c8                	mov    %ecx,%eax
     fc0:	01 c0                	add    %eax,%eax
     fc2:	01 c8                	add    %ecx,%eax
     fc4:	01 c2                	add    %eax,%edx
     fc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fc9:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     fcd:	89 c1                	mov    %eax,%ecx
     fcf:	8b 45 d8             	mov    -0x28(%ebp),%eax
     fd2:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     fd6:	01 c1                	add    %eax,%ecx
     fd8:	8b 45 d8             	mov    -0x28(%ebp),%eax
     fdb:	01 c8                	add    %ecx,%eax
     fdd:	8d 48 fd             	lea    -0x3(%eax),%ecx
     fe0:	8b 45 dc             	mov    -0x24(%ebp),%eax
     fe3:	01 c8                	add    %ecx,%eax
     fe5:	0f b6 00             	movzbl (%eax),%eax
     fe8:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     fea:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     fee:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ff1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ff4:	39 c2                	cmp    %eax,%edx
     ff6:	0f 87 41 ff ff ff    	ja     f3d <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     ffc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1000:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1003:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1006:	39 c2                	cmp    %eax,%edx
    1008:	0f 87 0d ff ff ff    	ja     f1b <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    100e:	83 ec 0c             	sub    $0xc,%esp
    1011:	ff 75 ec             	pushl  -0x14(%ebp)
    1014:	e8 c7 f7 ff ff       	call   7e0 <close>
    1019:	83 c4 10             	add    $0x10,%esp
    return bmp;
    101c:	8b 45 08             	mov    0x8(%ebp),%eax
    101f:	8b 55 c8             	mov    -0x38(%ebp),%edx
    1022:	89 10                	mov    %edx,(%eax)
    1024:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1027:	89 50 04             	mov    %edx,0x4(%eax)
    102a:	8b 55 d0             	mov    -0x30(%ebp),%edx
    102d:	89 50 08             	mov    %edx,0x8(%eax)
}
    1030:	8b 45 08             	mov    0x8(%ebp),%eax
    1033:	c9                   	leave  
    1034:	c2 04 00             	ret    $0x4

00001037 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    1037:	55                   	push   %ebp
    1038:	89 e5                	mov    %esp,%ebp
    103a:	53                   	push   %ebx
    103b:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    103e:	83 ec 0c             	sub    $0xc,%esp
    1041:	6a 1c                	push   $0x1c
    1043:	e8 02 fc ff ff       	call   c4a <malloc>
    1048:	83 c4 10             	add    $0x10,%esp
    104b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    104e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1051:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    1058:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    105b:	8d 45 d8             	lea    -0x28(%ebp),%eax
    105e:	6a 0c                	push   $0xc
    1060:	6a 0c                	push   $0xc
    1062:	6a 0c                	push   $0xc
    1064:	50                   	push   %eax
    1065:	e8 c3 fc ff ff       	call   d2d <RGB>
    106a:	83 c4 0c             	add    $0xc,%esp
    106d:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    1071:	66 89 43 13          	mov    %ax,0x13(%ebx)
    1075:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    1079:	88 43 15             	mov    %al,0x15(%ebx)
    107c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    107f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1082:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    1086:	66 89 48 10          	mov    %cx,0x10(%eax)
    108a:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    108e:	88 50 12             	mov    %dl,0x12(%eax)
    1091:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1094:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1097:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    109b:	66 89 48 08          	mov    %cx,0x8(%eax)
    109f:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    10a3:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    10a6:	8b 45 08             	mov    0x8(%ebp),%eax
    10a9:	89 c2                	mov    %eax,%edx
    10ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10ae:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    10b0:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b3:	89 c2                	mov    %eax,%edx
    10b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10b8:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    10bb:	8b 55 10             	mov    0x10(%ebp),%edx
    10be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10c1:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    10c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    10c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10ca:	c9                   	leave  
    10cb:	c3                   	ret    

000010cc <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    10cc:	55                   	push   %ebp
    10cd:	89 e5                	mov    %esp,%ebp
    10cf:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    10d2:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d5:	8b 50 08             	mov    0x8(%eax),%edx
    10d8:	89 55 f8             	mov    %edx,-0x8(%ebp)
    10db:	8b 40 0c             	mov    0xc(%eax),%eax
    10de:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    10e1:	8b 45 0c             	mov    0xc(%ebp),%eax
    10e4:	8b 55 10             	mov    0x10(%ebp),%edx
    10e7:	89 50 08             	mov    %edx,0x8(%eax)
    10ea:	8b 55 14             	mov    0x14(%ebp),%edx
    10ed:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    10f0:	8b 45 08             	mov    0x8(%ebp),%eax
    10f3:	8b 55 f8             	mov    -0x8(%ebp),%edx
    10f6:	89 10                	mov    %edx,(%eax)
    10f8:	8b 55 fc             	mov    -0x4(%ebp),%edx
    10fb:	89 50 04             	mov    %edx,0x4(%eax)
}
    10fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1101:	c9                   	leave  
    1102:	c2 04 00             	ret    $0x4

00001105 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    1105:	55                   	push   %ebp
    1106:	89 e5                	mov    %esp,%ebp
    1108:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    110b:	8b 45 0c             	mov    0xc(%ebp),%eax
    110e:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    1112:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1116:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    111a:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    111d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1120:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1124:	66 89 50 10          	mov    %dx,0x10(%eax)
    1128:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    112c:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    112f:	8b 45 08             	mov    0x8(%ebp),%eax
    1132:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1136:	66 89 10             	mov    %dx,(%eax)
    1139:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    113d:	88 50 02             	mov    %dl,0x2(%eax)
}
    1140:	8b 45 08             	mov    0x8(%ebp),%eax
    1143:	c9                   	leave  
    1144:	c2 04 00             	ret    $0x4

00001147 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
    1147:	55                   	push   %ebp
    1148:	89 e5                	mov    %esp,%ebp
    114a:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
    114d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1150:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1154:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    1158:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    115c:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
    115f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1162:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    1166:	66 89 50 13          	mov    %dx,0x13(%eax)
    116a:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    116e:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
    1171:	8b 45 08             	mov    0x8(%ebp),%eax
    1174:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1178:	66 89 10             	mov    %dx,(%eax)
    117b:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    117f:	88 50 02             	mov    %dl,0x2(%eax)
}
    1182:	8b 45 08             	mov    0x8(%ebp),%eax
    1185:	c9                   	leave  
    1186:	c2 04 00             	ret    $0x4

00001189 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    1189:	55                   	push   %ebp
    118a:	89 e5                	mov    %esp,%ebp
    118c:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    118f:	8b 45 08             	mov    0x8(%ebp),%eax
    1192:	8b 40 0c             	mov    0xc(%eax),%eax
    1195:	89 c2                	mov    %eax,%edx
    1197:	c1 ea 1f             	shr    $0x1f,%edx
    119a:	01 d0                	add    %edx,%eax
    119c:	d1 f8                	sar    %eax
    119e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    11a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11a4:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    11a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    11ab:	8b 45 10             	mov    0x10(%ebp),%eax
    11ae:	2b 45 f4             	sub    -0xc(%ebp),%eax
    11b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    11b4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    11b8:	0f 89 98 00 00 00    	jns    1256 <APDrawPoint+0xcd>
        i = 0;
    11be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    11c5:	e9 8c 00 00 00       	jmp    1256 <APDrawPoint+0xcd>
    {
        j = x - off;
    11ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    11cd:	2b 45 f4             	sub    -0xc(%ebp),%eax
    11d0:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    11d3:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    11d7:	79 69                	jns    1242 <APDrawPoint+0xb9>
            j = 0;
    11d9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    11e0:	eb 60                	jmp    1242 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    11e2:	ff 75 fc             	pushl  -0x4(%ebp)
    11e5:	ff 75 f8             	pushl  -0x8(%ebp)
    11e8:	ff 75 08             	pushl  0x8(%ebp)
    11eb:	e8 bb fb ff ff       	call   dab <APGetIndex>
    11f0:	83 c4 0c             	add    $0xc,%esp
    11f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    11f6:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    11fa:	74 55                	je     1251 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    11fc:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    1200:	74 67                	je     1269 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    1202:	ff 75 10             	pushl  0x10(%ebp)
    1205:	ff 75 0c             	pushl  0xc(%ebp)
    1208:	ff 75 fc             	pushl  -0x4(%ebp)
    120b:	ff 75 f8             	pushl  -0x8(%ebp)
    120e:	e8 5f fb ff ff       	call   d72 <distance_2>
    1213:	83 c4 10             	add    $0x10,%esp
    1216:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1219:	7f 23                	jg     123e <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    121b:	8b 45 08             	mov    0x8(%ebp),%eax
    121e:	8b 48 18             	mov    0x18(%eax),%ecx
    1221:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1224:	89 d0                	mov    %edx,%eax
    1226:	01 c0                	add    %eax,%eax
    1228:	01 d0                	add    %edx,%eax
    122a:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    122d:	8b 45 08             	mov    0x8(%ebp),%eax
    1230:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1234:	66 89 0a             	mov    %cx,(%edx)
    1237:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    123b:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    123e:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1242:	8b 55 0c             	mov    0xc(%ebp),%edx
    1245:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1248:	01 d0                	add    %edx,%eax
    124a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    124d:	7d 93                	jge    11e2 <APDrawPoint+0x59>
    124f:	eb 01                	jmp    1252 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1251:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1252:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1256:	8b 55 10             	mov    0x10(%ebp),%edx
    1259:	8b 45 f4             	mov    -0xc(%ebp),%eax
    125c:	01 d0                	add    %edx,%eax
    125e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1261:	0f 8d 63 ff ff ff    	jge    11ca <APDrawPoint+0x41>
    1267:	eb 01                	jmp    126a <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1269:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    126a:	c9                   	leave  
    126b:	c3                   	ret    

0000126c <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    126c:	55                   	push   %ebp
    126d:	89 e5                	mov    %esp,%ebp
    126f:	53                   	push   %ebx
    1270:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1273:	8b 45 0c             	mov    0xc(%ebp),%eax
    1276:	3b 45 14             	cmp    0x14(%ebp),%eax
    1279:	0f 85 80 00 00 00    	jne    12ff <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    127f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1283:	0f 88 9d 02 00 00    	js     1526 <APDrawLine+0x2ba>
    1289:	8b 45 08             	mov    0x8(%ebp),%eax
    128c:	8b 00                	mov    (%eax),%eax
    128e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1291:	0f 8e 8f 02 00 00    	jle    1526 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    1297:	8b 45 10             	mov    0x10(%ebp),%eax
    129a:	3b 45 18             	cmp    0x18(%ebp),%eax
    129d:	7e 12                	jle    12b1 <APDrawLine+0x45>
        {
            int tmp = y2;
    129f:	8b 45 18             	mov    0x18(%ebp),%eax
    12a2:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    12a5:	8b 45 10             	mov    0x10(%ebp),%eax
    12a8:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    12ab:	8b 45 dc             	mov    -0x24(%ebp),%eax
    12ae:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    12b1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12b5:	79 07                	jns    12be <APDrawLine+0x52>
    12b7:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    12be:	8b 45 08             	mov    0x8(%ebp),%eax
    12c1:	8b 40 04             	mov    0x4(%eax),%eax
    12c4:	3b 45 18             	cmp    0x18(%ebp),%eax
    12c7:	7d 0c                	jge    12d5 <APDrawLine+0x69>
    12c9:	8b 45 08             	mov    0x8(%ebp),%eax
    12cc:	8b 40 04             	mov    0x4(%eax),%eax
    12cf:	83 e8 01             	sub    $0x1,%eax
    12d2:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    12d5:	8b 45 10             	mov    0x10(%ebp),%eax
    12d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    12db:	eb 15                	jmp    12f2 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    12dd:	ff 75 f4             	pushl  -0xc(%ebp)
    12e0:	ff 75 0c             	pushl  0xc(%ebp)
    12e3:	ff 75 08             	pushl  0x8(%ebp)
    12e6:	e8 9e fe ff ff       	call   1189 <APDrawPoint>
    12eb:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    12ee:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    12f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12f5:	3b 45 18             	cmp    0x18(%ebp),%eax
    12f8:	7e e3                	jle    12dd <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    12fa:	e9 2b 02 00 00       	jmp    152a <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    12ff:	8b 45 10             	mov    0x10(%ebp),%eax
    1302:	3b 45 18             	cmp    0x18(%ebp),%eax
    1305:	75 7f                	jne    1386 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    1307:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    130b:	0f 88 18 02 00 00    	js     1529 <APDrawLine+0x2bd>
    1311:	8b 45 08             	mov    0x8(%ebp),%eax
    1314:	8b 40 04             	mov    0x4(%eax),%eax
    1317:	3b 45 10             	cmp    0x10(%ebp),%eax
    131a:	0f 8e 09 02 00 00    	jle    1529 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1320:	8b 45 0c             	mov    0xc(%ebp),%eax
    1323:	3b 45 14             	cmp    0x14(%ebp),%eax
    1326:	7e 12                	jle    133a <APDrawLine+0xce>
        {
            int tmp = x2;
    1328:	8b 45 14             	mov    0x14(%ebp),%eax
    132b:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    132e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1331:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1334:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1337:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    133a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    133e:	79 07                	jns    1347 <APDrawLine+0xdb>
    1340:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1347:	8b 45 08             	mov    0x8(%ebp),%eax
    134a:	8b 00                	mov    (%eax),%eax
    134c:	3b 45 14             	cmp    0x14(%ebp),%eax
    134f:	7d 0b                	jge    135c <APDrawLine+0xf0>
    1351:	8b 45 08             	mov    0x8(%ebp),%eax
    1354:	8b 00                	mov    (%eax),%eax
    1356:	83 e8 01             	sub    $0x1,%eax
    1359:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    135c:	8b 45 0c             	mov    0xc(%ebp),%eax
    135f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1362:	eb 15                	jmp    1379 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1364:	ff 75 10             	pushl  0x10(%ebp)
    1367:	ff 75 f0             	pushl  -0x10(%ebp)
    136a:	ff 75 08             	pushl  0x8(%ebp)
    136d:	e8 17 fe ff ff       	call   1189 <APDrawPoint>
    1372:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1375:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1379:	8b 45 f0             	mov    -0x10(%ebp),%eax
    137c:	3b 45 14             	cmp    0x14(%ebp),%eax
    137f:	7e e3                	jle    1364 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1381:	e9 a4 01 00 00       	jmp    152a <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1386:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    138d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1394:	8b 45 0c             	mov    0xc(%ebp),%eax
    1397:	2b 45 14             	sub    0x14(%ebp),%eax
    139a:	50                   	push   %eax
    139b:	e8 fb f9 ff ff       	call   d9b <abs_int>
    13a0:	83 c4 04             	add    $0x4,%esp
    13a3:	89 c3                	mov    %eax,%ebx
    13a5:	8b 45 10             	mov    0x10(%ebp),%eax
    13a8:	2b 45 18             	sub    0x18(%ebp),%eax
    13ab:	50                   	push   %eax
    13ac:	e8 ea f9 ff ff       	call   d9b <abs_int>
    13b1:	83 c4 04             	add    $0x4,%esp
    13b4:	39 c3                	cmp    %eax,%ebx
    13b6:	0f 8e b5 00 00 00    	jle    1471 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    13bc:	8b 45 10             	mov    0x10(%ebp),%eax
    13bf:	2b 45 18             	sub    0x18(%ebp),%eax
    13c2:	89 45 b0             	mov    %eax,-0x50(%ebp)
    13c5:	db 45 b0             	fildl  -0x50(%ebp)
    13c8:	8b 45 0c             	mov    0xc(%ebp),%eax
    13cb:	2b 45 14             	sub    0x14(%ebp),%eax
    13ce:	89 45 b0             	mov    %eax,-0x50(%ebp)
    13d1:	db 45 b0             	fildl  -0x50(%ebp)
    13d4:	de f9                	fdivrp %st,%st(1)
    13d6:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    13d9:	8b 45 14             	mov    0x14(%ebp),%eax
    13dc:	3b 45 0c             	cmp    0xc(%ebp),%eax
    13df:	7e 0e                	jle    13ef <APDrawLine+0x183>
        {
            s = x1;
    13e1:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    13e7:	8b 45 14             	mov    0x14(%ebp),%eax
    13ea:	89 45 e8             	mov    %eax,-0x18(%ebp)
    13ed:	eb 0c                	jmp    13fb <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    13ef:	8b 45 14             	mov    0x14(%ebp),%eax
    13f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    13f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    13f8:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    13fb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    13ff:	79 07                	jns    1408 <APDrawLine+0x19c>
    1401:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1408:	8b 45 08             	mov    0x8(%ebp),%eax
    140b:	8b 00                	mov    (%eax),%eax
    140d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1410:	7f 0b                	jg     141d <APDrawLine+0x1b1>
    1412:	8b 45 08             	mov    0x8(%ebp),%eax
    1415:	8b 00                	mov    (%eax),%eax
    1417:	83 e8 01             	sub    $0x1,%eax
    141a:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    141d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1420:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1423:	eb 3f                	jmp    1464 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1425:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1428:	2b 45 0c             	sub    0xc(%ebp),%eax
    142b:	89 45 b0             	mov    %eax,-0x50(%ebp)
    142e:	db 45 b0             	fildl  -0x50(%ebp)
    1431:	dc 4d d0             	fmull  -0x30(%ebp)
    1434:	db 45 10             	fildl  0x10(%ebp)
    1437:	de c1                	faddp  %st,%st(1)
    1439:	d9 7d b6             	fnstcw -0x4a(%ebp)
    143c:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1440:	b4 0c                	mov    $0xc,%ah
    1442:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1446:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1449:	db 5d cc             	fistpl -0x34(%ebp)
    144c:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    144f:	ff 75 cc             	pushl  -0x34(%ebp)
    1452:	ff 75 e4             	pushl  -0x1c(%ebp)
    1455:	ff 75 08             	pushl  0x8(%ebp)
    1458:	e8 2c fd ff ff       	call   1189 <APDrawPoint>
    145d:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1460:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1464:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1467:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    146a:	7e b9                	jle    1425 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    146c:	e9 b9 00 00 00       	jmp    152a <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1471:	8b 45 0c             	mov    0xc(%ebp),%eax
    1474:	2b 45 14             	sub    0x14(%ebp),%eax
    1477:	89 45 b0             	mov    %eax,-0x50(%ebp)
    147a:	db 45 b0             	fildl  -0x50(%ebp)
    147d:	8b 45 10             	mov    0x10(%ebp),%eax
    1480:	2b 45 18             	sub    0x18(%ebp),%eax
    1483:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1486:	db 45 b0             	fildl  -0x50(%ebp)
    1489:	de f9                	fdivrp %st,%st(1)
    148b:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    148e:	8b 45 10             	mov    0x10(%ebp),%eax
    1491:	3b 45 18             	cmp    0x18(%ebp),%eax
    1494:	7e 0e                	jle    14a4 <APDrawLine+0x238>
    {
        s = y2;
    1496:	8b 45 18             	mov    0x18(%ebp),%eax
    1499:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    149c:	8b 45 10             	mov    0x10(%ebp),%eax
    149f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    14a2:	eb 0c                	jmp    14b0 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    14a4:	8b 45 10             	mov    0x10(%ebp),%eax
    14a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    14aa:	8b 45 18             	mov    0x18(%ebp),%eax
    14ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    14b0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14b4:	79 07                	jns    14bd <APDrawLine+0x251>
    14b6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    14bd:	8b 45 08             	mov    0x8(%ebp),%eax
    14c0:	8b 40 04             	mov    0x4(%eax),%eax
    14c3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    14c6:	7f 0c                	jg     14d4 <APDrawLine+0x268>
    14c8:	8b 45 08             	mov    0x8(%ebp),%eax
    14cb:	8b 40 04             	mov    0x4(%eax),%eax
    14ce:	83 e8 01             	sub    $0x1,%eax
    14d1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    14d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14d7:	89 45 e0             	mov    %eax,-0x20(%ebp)
    14da:	eb 3f                	jmp    151b <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    14dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    14df:	2b 45 10             	sub    0x10(%ebp),%eax
    14e2:	89 45 b0             	mov    %eax,-0x50(%ebp)
    14e5:	db 45 b0             	fildl  -0x50(%ebp)
    14e8:	dc 4d c0             	fmull  -0x40(%ebp)
    14eb:	db 45 0c             	fildl  0xc(%ebp)
    14ee:	de c1                	faddp  %st,%st(1)
    14f0:	d9 7d b6             	fnstcw -0x4a(%ebp)
    14f3:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    14f7:	b4 0c                	mov    $0xc,%ah
    14f9:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    14fd:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1500:	db 5d bc             	fistpl -0x44(%ebp)
    1503:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1506:	ff 75 e0             	pushl  -0x20(%ebp)
    1509:	ff 75 bc             	pushl  -0x44(%ebp)
    150c:	ff 75 08             	pushl  0x8(%ebp)
    150f:	e8 75 fc ff ff       	call   1189 <APDrawPoint>
    1514:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1517:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    151b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    151e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1521:	7e b9                	jle    14dc <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1523:	90                   	nop
    1524:	eb 04                	jmp    152a <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1526:	90                   	nop
    1527:	eb 01                	jmp    152a <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1529:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    152a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    152d:	c9                   	leave  
    152e:	c3                   	ret    

0000152f <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    152f:	55                   	push   %ebp
    1530:	89 e5                	mov    %esp,%ebp
    1532:	53                   	push   %ebx
    1533:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1536:	8b 55 10             	mov    0x10(%ebp),%edx
    1539:	8b 45 18             	mov    0x18(%ebp),%eax
    153c:	01 d0                	add    %edx,%eax
    153e:	83 e8 01             	sub    $0x1,%eax
    1541:	83 ec 04             	sub    $0x4,%esp
    1544:	50                   	push   %eax
    1545:	ff 75 0c             	pushl  0xc(%ebp)
    1548:	ff 75 10             	pushl  0x10(%ebp)
    154b:	ff 75 0c             	pushl  0xc(%ebp)
    154e:	ff 75 08             	pushl  0x8(%ebp)
    1551:	e8 16 fd ff ff       	call   126c <APDrawLine>
    1556:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1559:	8b 55 0c             	mov    0xc(%ebp),%edx
    155c:	8b 45 14             	mov    0x14(%ebp),%eax
    155f:	01 d0                	add    %edx,%eax
    1561:	83 e8 01             	sub    $0x1,%eax
    1564:	83 ec 04             	sub    $0x4,%esp
    1567:	ff 75 10             	pushl  0x10(%ebp)
    156a:	50                   	push   %eax
    156b:	ff 75 10             	pushl  0x10(%ebp)
    156e:	ff 75 0c             	pushl  0xc(%ebp)
    1571:	ff 75 08             	pushl  0x8(%ebp)
    1574:	e8 f3 fc ff ff       	call   126c <APDrawLine>
    1579:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    157c:	8b 55 10             	mov    0x10(%ebp),%edx
    157f:	8b 45 18             	mov    0x18(%ebp),%eax
    1582:	01 d0                	add    %edx,%eax
    1584:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1587:	8b 55 0c             	mov    0xc(%ebp),%edx
    158a:	8b 45 14             	mov    0x14(%ebp),%eax
    158d:	01 d0                	add    %edx,%eax
    158f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1592:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1595:	8b 45 14             	mov    0x14(%ebp),%eax
    1598:	01 d8                	add    %ebx,%eax
    159a:	83 e8 01             	sub    $0x1,%eax
    159d:	83 ec 04             	sub    $0x4,%esp
    15a0:	51                   	push   %ecx
    15a1:	52                   	push   %edx
    15a2:	ff 75 10             	pushl  0x10(%ebp)
    15a5:	50                   	push   %eax
    15a6:	ff 75 08             	pushl  0x8(%ebp)
    15a9:	e8 be fc ff ff       	call   126c <APDrawLine>
    15ae:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    15b1:	8b 55 10             	mov    0x10(%ebp),%edx
    15b4:	8b 45 18             	mov    0x18(%ebp),%eax
    15b7:	01 d0                	add    %edx,%eax
    15b9:	8d 48 ff             	lea    -0x1(%eax),%ecx
    15bc:	8b 55 0c             	mov    0xc(%ebp),%edx
    15bf:	8b 45 14             	mov    0x14(%ebp),%eax
    15c2:	01 d0                	add    %edx,%eax
    15c4:	8d 50 ff             	lea    -0x1(%eax),%edx
    15c7:	8b 5d 10             	mov    0x10(%ebp),%ebx
    15ca:	8b 45 18             	mov    0x18(%ebp),%eax
    15cd:	01 d8                	add    %ebx,%eax
    15cf:	83 e8 01             	sub    $0x1,%eax
    15d2:	83 ec 04             	sub    $0x4,%esp
    15d5:	51                   	push   %ecx
    15d6:	52                   	push   %edx
    15d7:	50                   	push   %eax
    15d8:	ff 75 0c             	pushl  0xc(%ebp)
    15db:	ff 75 08             	pushl  0x8(%ebp)
    15de:	e8 89 fc ff ff       	call   126c <APDrawLine>
    15e3:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    15e6:	8b 55 0c             	mov    0xc(%ebp),%edx
    15e9:	8b 45 14             	mov    0x14(%ebp),%eax
    15ec:	01 d0                	add    %edx,%eax
    15ee:	8d 50 ff             	lea    -0x1(%eax),%edx
    15f1:	8b 45 08             	mov    0x8(%ebp),%eax
    15f4:	8b 40 0c             	mov    0xc(%eax),%eax
    15f7:	89 c1                	mov    %eax,%ecx
    15f9:	c1 e9 1f             	shr    $0x1f,%ecx
    15fc:	01 c8                	add    %ecx,%eax
    15fe:	d1 f8                	sar    %eax
    1600:	29 c2                	sub    %eax,%edx
    1602:	89 d0                	mov    %edx,%eax
    1604:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1607:	8b 55 10             	mov    0x10(%ebp),%edx
    160a:	8b 45 18             	mov    0x18(%ebp),%eax
    160d:	01 d0                	add    %edx,%eax
    160f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1612:	8b 45 08             	mov    0x8(%ebp),%eax
    1615:	8b 40 0c             	mov    0xc(%eax),%eax
    1618:	89 c1                	mov    %eax,%ecx
    161a:	c1 e9 1f             	shr    $0x1f,%ecx
    161d:	01 c8                	add    %ecx,%eax
    161f:	d1 f8                	sar    %eax
    1621:	29 c2                	sub    %eax,%edx
    1623:	89 d0                	mov    %edx,%eax
    1625:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1628:	8b 45 08             	mov    0x8(%ebp),%eax
    162b:	8b 40 0c             	mov    0xc(%eax),%eax
    162e:	89 c2                	mov    %eax,%edx
    1630:	c1 ea 1f             	shr    $0x1f,%edx
    1633:	01 d0                	add    %edx,%eax
    1635:	d1 f8                	sar    %eax
    1637:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    163a:	8b 45 08             	mov    0x8(%ebp),%eax
    163d:	8b 40 0c             	mov    0xc(%eax),%eax
    1640:	89 c2                	mov    %eax,%edx
    1642:	c1 ea 1f             	shr    $0x1f,%edx
    1645:	01 d0                	add    %edx,%eax
    1647:	d1 f8                	sar    %eax
    1649:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    164c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1650:	0f 88 d8 00 00 00    	js     172e <APDrawRect+0x1ff>
    1656:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    165a:	0f 88 ce 00 00 00    	js     172e <APDrawRect+0x1ff>
    1660:	8b 45 08             	mov    0x8(%ebp),%eax
    1663:	8b 00                	mov    (%eax),%eax
    1665:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1668:	0f 8e c0 00 00 00    	jle    172e <APDrawRect+0x1ff>
    166e:	8b 45 08             	mov    0x8(%ebp),%eax
    1671:	8b 40 04             	mov    0x4(%eax),%eax
    1674:	3b 45 10             	cmp    0x10(%ebp),%eax
    1677:	0f 8e b1 00 00 00    	jle    172e <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    167d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1681:	79 07                	jns    168a <APDrawRect+0x15b>
    1683:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    168a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    168e:	79 07                	jns    1697 <APDrawRect+0x168>
    1690:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1697:	8b 45 08             	mov    0x8(%ebp),%eax
    169a:	8b 00                	mov    (%eax),%eax
    169c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    169f:	7f 0b                	jg     16ac <APDrawRect+0x17d>
    16a1:	8b 45 08             	mov    0x8(%ebp),%eax
    16a4:	8b 00                	mov    (%eax),%eax
    16a6:	83 e8 01             	sub    $0x1,%eax
    16a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    16ac:	8b 45 08             	mov    0x8(%ebp),%eax
    16af:	8b 40 04             	mov    0x4(%eax),%eax
    16b2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    16b5:	7f 0c                	jg     16c3 <APDrawRect+0x194>
    16b7:	8b 45 08             	mov    0x8(%ebp),%eax
    16ba:	8b 40 04             	mov    0x4(%eax),%eax
    16bd:	83 e8 01             	sub    $0x1,%eax
    16c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    16c3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    16ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    16cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    16d0:	eb 52                	jmp    1724 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    16d2:	8b 45 10             	mov    0x10(%ebp),%eax
    16d5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    16d8:	eb 3e                	jmp    1718 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    16da:	83 ec 04             	sub    $0x4,%esp
    16dd:	ff 75 e8             	pushl  -0x18(%ebp)
    16e0:	ff 75 ec             	pushl  -0x14(%ebp)
    16e3:	ff 75 08             	pushl  0x8(%ebp)
    16e6:	e8 c0 f6 ff ff       	call   dab <APGetIndex>
    16eb:	83 c4 10             	add    $0x10,%esp
    16ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    16f1:	8b 45 08             	mov    0x8(%ebp),%eax
    16f4:	8b 48 18             	mov    0x18(%eax),%ecx
    16f7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    16fa:	89 d0                	mov    %edx,%eax
    16fc:	01 c0                	add    %eax,%eax
    16fe:	01 d0                	add    %edx,%eax
    1700:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1703:	8b 45 08             	mov    0x8(%ebp),%eax
    1706:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    170a:	66 89 0a             	mov    %cx,(%edx)
    170d:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1711:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1714:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1718:	8b 45 e8             	mov    -0x18(%ebp),%eax
    171b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    171e:	7e ba                	jle    16da <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1720:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1724:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1727:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    172a:	7e a6                	jle    16d2 <APDrawRect+0x1a3>
    172c:	eb 01                	jmp    172f <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    172e:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    172f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1732:	c9                   	leave  
    1733:	c3                   	ret    

00001734 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1734:	55                   	push   %ebp
    1735:	89 e5                	mov    %esp,%ebp
    1737:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    173a:	83 ec 0c             	sub    $0xc,%esp
    173d:	ff 75 0c             	pushl  0xc(%ebp)
    1740:	e8 b1 ee ff ff       	call   5f6 <strlen>
    1745:	83 c4 10             	add    $0x10,%esp
    1748:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    174b:	8b 45 08             	mov    0x8(%ebp),%eax
    174e:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1752:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1756:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    175a:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    175d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1764:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    176b:	e9 bc 00 00 00       	jmp    182c <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1770:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1773:	8b 45 0c             	mov    0xc(%ebp),%eax
    1776:	01 d0                	add    %edx,%eax
    1778:	0f b6 00             	movzbl (%eax),%eax
    177b:	0f be c0             	movsbl %al,%eax
    177e:	83 e8 20             	sub    $0x20,%eax
    1781:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1784:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1788:	0f 87 9a 00 00 00    	ja     1828 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    178e:	8b 45 08             	mov    0x8(%ebp),%eax
    1791:	8b 00                	mov    (%eax),%eax
    1793:	0f af 45 14          	imul   0x14(%ebp),%eax
    1797:	89 c2                	mov    %eax,%edx
    1799:	8b 45 10             	mov    0x10(%ebp),%eax
    179c:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    179f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17a2:	89 d0                	mov    %edx,%eax
    17a4:	c1 e0 03             	shl    $0x3,%eax
    17a7:	01 d0                	add    %edx,%eax
    17a9:	01 c8                	add    %ecx,%eax
    17ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    17ae:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    17b5:	eb 6b                	jmp    1822 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    17b7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    17be:	eb 50                	jmp    1810 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    17c0:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17c3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    17c6:	89 d0                	mov    %edx,%eax
    17c8:	c1 e0 03             	shl    $0x3,%eax
    17cb:	01 d0                	add    %edx,%eax
    17cd:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    17d3:	01 c2                	add    %eax,%edx
    17d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17d8:	01 d0                	add    %edx,%eax
    17da:	05 00 35 00 00       	add    $0x3500,%eax
    17df:	0f b6 00             	movzbl (%eax),%eax
    17e2:	84 c0                	test   %al,%al
    17e4:	74 26                	je     180c <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    17e6:	8b 45 08             	mov    0x8(%ebp),%eax
    17e9:	8b 50 18             	mov    0x18(%eax),%edx
    17ec:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    17ef:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17f2:	01 c8                	add    %ecx,%eax
    17f4:	89 c1                	mov    %eax,%ecx
    17f6:	89 c8                	mov    %ecx,%eax
    17f8:	01 c0                	add    %eax,%eax
    17fa:	01 c8                	add    %ecx,%eax
    17fc:	01 d0                	add    %edx,%eax
    17fe:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1802:	66 89 10             	mov    %dx,(%eax)
    1805:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1809:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    180c:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1810:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1814:	7e aa                	jle    17c0 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1816:	8b 45 08             	mov    0x8(%ebp),%eax
    1819:	8b 00                	mov    (%eax),%eax
    181b:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    181e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1822:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1826:	7e 8f                	jle    17b7 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1828:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    182c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1832:	0f 82 38 ff ff ff    	jb     1770 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1838:	90                   	nop
    1839:	c9                   	leave  
    183a:	c3                   	ret    

0000183b <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    183b:	55                   	push   %ebp
    183c:	89 e5                	mov    %esp,%ebp
    183e:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1841:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1845:	0f 88 8e 01 00 00    	js     19d9 <APDcCopy+0x19e>
    184b:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    184f:	0f 88 84 01 00 00    	js     19d9 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1855:	8b 55 0c             	mov    0xc(%ebp),%edx
    1858:	8b 45 20             	mov    0x20(%ebp),%eax
    185b:	01 d0                	add    %edx,%eax
    185d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1860:	8b 55 10             	mov    0x10(%ebp),%edx
    1863:	8b 45 24             	mov    0x24(%ebp),%eax
    1866:	01 d0                	add    %edx,%eax
    1868:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    186b:	8b 55 18             	mov    0x18(%ebp),%edx
    186e:	8b 45 20             	mov    0x20(%ebp),%eax
    1871:	01 d0                	add    %edx,%eax
    1873:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1876:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1879:	8b 45 24             	mov    0x24(%ebp),%eax
    187c:	01 d0                	add    %edx,%eax
    187e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1881:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1885:	0f 88 51 01 00 00    	js     19dc <APDcCopy+0x1a1>
    188b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    188f:	0f 88 47 01 00 00    	js     19dc <APDcCopy+0x1a1>
    1895:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1899:	0f 88 3d 01 00 00    	js     19dc <APDcCopy+0x1a1>
    189f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    18a3:	0f 88 33 01 00 00    	js     19dc <APDcCopy+0x1a1>
    18a9:	8b 45 14             	mov    0x14(%ebp),%eax
    18ac:	8b 00                	mov    (%eax),%eax
    18ae:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    18b1:	0f 8c 25 01 00 00    	jl     19dc <APDcCopy+0x1a1>
    18b7:	8b 45 14             	mov    0x14(%ebp),%eax
    18ba:	8b 40 04             	mov    0x4(%eax),%eax
    18bd:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    18c0:	0f 8c 16 01 00 00    	jl     19dc <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    18c6:	8b 45 08             	mov    0x8(%ebp),%eax
    18c9:	8b 00                	mov    (%eax),%eax
    18cb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    18ce:	7f 0b                	jg     18db <APDcCopy+0xa0>
    18d0:	8b 45 08             	mov    0x8(%ebp),%eax
    18d3:	8b 00                	mov    (%eax),%eax
    18d5:	83 e8 01             	sub    $0x1,%eax
    18d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    18db:	8b 45 08             	mov    0x8(%ebp),%eax
    18de:	8b 40 04             	mov    0x4(%eax),%eax
    18e1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    18e4:	7f 0c                	jg     18f2 <APDcCopy+0xb7>
    18e6:	8b 45 08             	mov    0x8(%ebp),%eax
    18e9:	8b 40 04             	mov    0x4(%eax),%eax
    18ec:	83 e8 01             	sub    $0x1,%eax
    18ef:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    18f2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    18f9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1900:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1907:	e9 bc 00 00 00       	jmp    19c8 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    190c:	8b 45 08             	mov    0x8(%ebp),%eax
    190f:	8b 00                	mov    (%eax),%eax
    1911:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1914:	8b 55 10             	mov    0x10(%ebp),%edx
    1917:	01 ca                	add    %ecx,%edx
    1919:	0f af d0             	imul   %eax,%edx
    191c:	8b 45 0c             	mov    0xc(%ebp),%eax
    191f:	01 d0                	add    %edx,%eax
    1921:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1924:	8b 45 14             	mov    0x14(%ebp),%eax
    1927:	8b 00                	mov    (%eax),%eax
    1929:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    192c:	8b 55 1c             	mov    0x1c(%ebp),%edx
    192f:	01 ca                	add    %ecx,%edx
    1931:	0f af d0             	imul   %eax,%edx
    1934:	8b 45 18             	mov    0x18(%ebp),%eax
    1937:	01 d0                	add    %edx,%eax
    1939:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    193c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1943:	eb 74                	jmp    19b9 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1945:	8b 45 14             	mov    0x14(%ebp),%eax
    1948:	8b 50 18             	mov    0x18(%eax),%edx
    194b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    194e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1951:	01 c8                	add    %ecx,%eax
    1953:	89 c1                	mov    %eax,%ecx
    1955:	89 c8                	mov    %ecx,%eax
    1957:	01 c0                	add    %eax,%eax
    1959:	01 c8                	add    %ecx,%eax
    195b:	01 d0                	add    %edx,%eax
    195d:	0f b7 10             	movzwl (%eax),%edx
    1960:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1964:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1968:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    196b:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    196f:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1973:	38 c2                	cmp    %al,%dl
    1975:	75 18                	jne    198f <APDcCopy+0x154>
    1977:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    197b:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    197f:	38 c2                	cmp    %al,%dl
    1981:	75 0c                	jne    198f <APDcCopy+0x154>
    1983:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1987:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    198b:	38 c2                	cmp    %al,%dl
    198d:	74 26                	je     19b5 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    198f:	8b 45 08             	mov    0x8(%ebp),%eax
    1992:	8b 50 18             	mov    0x18(%eax),%edx
    1995:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1998:	8b 45 f0             	mov    -0x10(%ebp),%eax
    199b:	01 c8                	add    %ecx,%eax
    199d:	89 c1                	mov    %eax,%ecx
    199f:	89 c8                	mov    %ecx,%eax
    19a1:	01 c0                	add    %eax,%eax
    19a3:	01 c8                	add    %ecx,%eax
    19a5:	01 d0                	add    %edx,%eax
    19a7:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    19ab:	66 89 10             	mov    %dx,(%eax)
    19ae:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    19b2:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    19b5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    19b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19bc:	2b 45 0c             	sub    0xc(%ebp),%eax
    19bf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    19c2:	7d 81                	jge    1945 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    19c4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    19c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19cb:	2b 45 10             	sub    0x10(%ebp),%eax
    19ce:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    19d1:	0f 8d 35 ff ff ff    	jge    190c <APDcCopy+0xd1>
    19d7:	eb 04                	jmp    19dd <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    19d9:	90                   	nop
    19da:	eb 01                	jmp    19dd <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    19dc:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    19dd:	c9                   	leave  
    19de:	c3                   	ret    

000019df <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    19df:	55                   	push   %ebp
    19e0:	89 e5                	mov    %esp,%ebp
    19e2:	83 ec 1c             	sub    $0x1c,%esp
    19e5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    19e8:	8b 55 10             	mov    0x10(%ebp),%edx
    19eb:	8b 45 14             	mov    0x14(%ebp),%eax
    19ee:	88 4d ec             	mov    %cl,-0x14(%ebp)
    19f1:	88 55 e8             	mov    %dl,-0x18(%ebp)
    19f4:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    19f7:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    19fb:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    19fe:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1a02:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1a05:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1a09:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1a0c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0f:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1a13:	66 89 10             	mov    %dx,(%eax)
    1a16:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1a1a:	88 50 02             	mov    %dl,0x2(%eax)
}
    1a1d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a20:	c9                   	leave  
    1a21:	c2 04 00             	ret    $0x4

00001a24 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1a24:	55                   	push   %ebp
    1a25:	89 e5                	mov    %esp,%ebp
    1a27:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1a2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2d:	8b 00                	mov    (%eax),%eax
    1a2f:	83 ec 08             	sub    $0x8,%esp
    1a32:	8d 55 0c             	lea    0xc(%ebp),%edx
    1a35:	52                   	push   %edx
    1a36:	50                   	push   %eax
    1a37:	e8 24 ee ff ff       	call   860 <sendMessage>
    1a3c:	83 c4 10             	add    $0x10,%esp
}
    1a3f:	90                   	nop
    1a40:	c9                   	leave  
    1a41:	c3                   	ret    

00001a42 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1a42:	55                   	push   %ebp
    1a43:	89 e5                	mov    %esp,%ebp
    1a45:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1a48:	83 ec 0c             	sub    $0xc,%esp
    1a4b:	68 9c 00 00 00       	push   $0x9c
    1a50:	e8 f5 f1 ff ff       	call   c4a <malloc>
    1a55:	83 c4 10             	add    $0x10,%esp
    1a58:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1a5b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a5f:	75 15                	jne    1a76 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1a61:	83 ec 04             	sub    $0x4,%esp
    1a64:	ff 75 08             	pushl  0x8(%ebp)
    1a67:	68 70 2a 00 00       	push   $0x2a70
    1a6c:	6a 01                	push   $0x1
    1a6e:	e8 04 ef ff ff       	call   977 <printf>
    1a73:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1a76:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a79:	05 88 00 00 00       	add    $0x88,%eax
    1a7e:	83 ec 08             	sub    $0x8,%esp
    1a81:	ff 75 08             	pushl  0x8(%ebp)
    1a84:	50                   	push   %eax
    1a85:	e8 fd ea ff ff       	call   587 <strcpy>
    1a8a:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1a8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a90:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1a97:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a9a:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1aa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aa4:	8b 40 3c             	mov    0x3c(%eax),%eax
    1aa7:	89 c2                	mov    %eax,%edx
    1aa9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aac:	8b 40 40             	mov    0x40(%eax),%eax
    1aaf:	0f af d0             	imul   %eax,%edx
    1ab2:	89 d0                	mov    %edx,%eax
    1ab4:	01 c0                	add    %eax,%eax
    1ab6:	01 d0                	add    %edx,%eax
    1ab8:	83 ec 0c             	sub    $0xc,%esp
    1abb:	50                   	push   %eax
    1abc:	e8 89 f1 ff ff       	call   c4a <malloc>
    1ac1:	83 c4 10             	add    $0x10,%esp
    1ac4:	89 c2                	mov    %eax,%edx
    1ac6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ac9:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1acc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1acf:	8b 40 54             	mov    0x54(%eax),%eax
    1ad2:	85 c0                	test   %eax,%eax
    1ad4:	75 15                	jne    1aeb <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1ad6:	83 ec 04             	sub    $0x4,%esp
    1ad9:	ff 75 08             	pushl  0x8(%ebp)
    1adc:	68 90 2a 00 00       	push   $0x2a90
    1ae1:	6a 01                	push   $0x1
    1ae3:	e8 8f ee ff ff       	call   977 <printf>
    1ae8:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aee:	8b 40 3c             	mov    0x3c(%eax),%eax
    1af1:	89 c2                	mov    %eax,%edx
    1af3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1af6:	8b 40 40             	mov    0x40(%eax),%eax
    1af9:	0f af d0             	imul   %eax,%edx
    1afc:	89 d0                	mov    %edx,%eax
    1afe:	01 c0                	add    %eax,%eax
    1b00:	01 c2                	add    %eax,%edx
    1b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b05:	8b 40 54             	mov    0x54(%eax),%eax
    1b08:	83 ec 04             	sub    $0x4,%esp
    1b0b:	52                   	push   %edx
    1b0c:	68 ff ff ff 00       	push   $0xffffff
    1b11:	50                   	push   %eax
    1b12:	e8 06 eb ff ff       	call   61d <memset>
    1b17:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1b1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b1d:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1b24:	e8 0f ed ff ff       	call   838 <getpid>
    1b29:	89 c2                	mov    %eax,%edx
    1b2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b2e:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1b31:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b34:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1b3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b3e:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1b45:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b48:	8b 40 58             	mov    0x58(%eax),%eax
    1b4b:	89 c2                	mov    %eax,%edx
    1b4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b50:	8b 40 5c             	mov    0x5c(%eax),%eax
    1b53:	0f af d0             	imul   %eax,%edx
    1b56:	89 d0                	mov    %edx,%eax
    1b58:	01 c0                	add    %eax,%eax
    1b5a:	01 d0                	add    %edx,%eax
    1b5c:	83 ec 0c             	sub    $0xc,%esp
    1b5f:	50                   	push   %eax
    1b60:	e8 e5 f0 ff ff       	call   c4a <malloc>
    1b65:	83 c4 10             	add    $0x10,%esp
    1b68:	89 c2                	mov    %eax,%edx
    1b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b6d:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1b70:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b73:	8b 40 70             	mov    0x70(%eax),%eax
    1b76:	85 c0                	test   %eax,%eax
    1b78:	75 15                	jne    1b8f <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1b7a:	83 ec 04             	sub    $0x4,%esp
    1b7d:	ff 75 08             	pushl  0x8(%ebp)
    1b80:	68 b4 2a 00 00       	push   $0x2ab4
    1b85:	6a 01                	push   $0x1
    1b87:	e8 eb ed ff ff       	call   977 <printf>
    1b8c:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1b8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b92:	8b 40 3c             	mov    0x3c(%eax),%eax
    1b95:	89 c2                	mov    %eax,%edx
    1b97:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b9a:	8b 40 40             	mov    0x40(%eax),%eax
    1b9d:	0f af d0             	imul   %eax,%edx
    1ba0:	89 d0                	mov    %edx,%eax
    1ba2:	01 c0                	add    %eax,%eax
    1ba4:	01 c2                	add    %eax,%edx
    1ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ba9:	8b 40 54             	mov    0x54(%eax),%eax
    1bac:	83 ec 04             	sub    $0x4,%esp
    1baf:	52                   	push   %edx
    1bb0:	68 ff 00 00 00       	push   $0xff
    1bb5:	50                   	push   %eax
    1bb6:	e8 62 ea ff ff       	call   61d <memset>
    1bbb:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1bbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bc1:	8b 55 0c             	mov    0xc(%ebp),%edx
    1bc4:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1bc7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1bcb:	74 49                	je     1c16 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1bcd:	8b 45 10             	mov    0x10(%ebp),%eax
    1bd0:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1bd6:	83 ec 0c             	sub    $0xc,%esp
    1bd9:	50                   	push   %eax
    1bda:	e8 6b f0 ff ff       	call   c4a <malloc>
    1bdf:	83 c4 10             	add    $0x10,%esp
    1be2:	89 c2                	mov    %eax,%edx
    1be4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1be7:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1bea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bed:	8b 55 10             	mov    0x10(%ebp),%edx
    1bf0:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1bf3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bf6:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1bfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c00:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1c07:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c0a:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1c11:	e9 8d 00 00 00       	jmp    1ca3 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1c16:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c19:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1c20:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c23:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1c2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c2d:	8b 40 20             	mov    0x20(%eax),%eax
    1c30:	89 c2                	mov    %eax,%edx
    1c32:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c35:	8b 40 24             	mov    0x24(%eax),%eax
    1c38:	0f af d0             	imul   %eax,%edx
    1c3b:	89 d0                	mov    %edx,%eax
    1c3d:	01 c0                	add    %eax,%eax
    1c3f:	01 d0                	add    %edx,%eax
    1c41:	83 ec 0c             	sub    $0xc,%esp
    1c44:	50                   	push   %eax
    1c45:	e8 00 f0 ff ff       	call   c4a <malloc>
    1c4a:	83 c4 10             	add    $0x10,%esp
    1c4d:	89 c2                	mov    %eax,%edx
    1c4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c52:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1c55:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c58:	8b 40 38             	mov    0x38(%eax),%eax
    1c5b:	85 c0                	test   %eax,%eax
    1c5d:	75 15                	jne    1c74 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1c5f:	83 ec 04             	sub    $0x4,%esp
    1c62:	ff 75 08             	pushl  0x8(%ebp)
    1c65:	68 dc 2a 00 00       	push   $0x2adc
    1c6a:	6a 01                	push   $0x1
    1c6c:	e8 06 ed ff ff       	call   977 <printf>
    1c71:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1c74:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c77:	8b 40 20             	mov    0x20(%eax),%eax
    1c7a:	89 c2                	mov    %eax,%edx
    1c7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c7f:	8b 40 24             	mov    0x24(%eax),%eax
    1c82:	0f af d0             	imul   %eax,%edx
    1c85:	89 d0                	mov    %edx,%eax
    1c87:	01 c0                	add    %eax,%eax
    1c89:	01 c2                	add    %eax,%edx
    1c8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c8e:	8b 40 38             	mov    0x38(%eax),%eax
    1c91:	83 ec 04             	sub    $0x4,%esp
    1c94:	52                   	push   %edx
    1c95:	68 ff ff ff 00       	push   $0xffffff
    1c9a:	50                   	push   %eax
    1c9b:	e8 7d e9 ff ff       	call   61d <memset>
    1ca0:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1ca3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1ca6:	c9                   	leave  
    1ca7:	c3                   	ret    

00001ca8 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1ca8:	55                   	push   %ebp
    1ca9:	89 e5                	mov    %esp,%ebp
    1cab:	57                   	push   %edi
    1cac:	56                   	push   %esi
    1cad:	53                   	push   %ebx
    1cae:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1cb1:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cb4:	83 f8 03             	cmp    $0x3,%eax
    1cb7:	74 0e                	je     1cc7 <APWndProc+0x1f>
    1cb9:	83 f8 0a             	cmp    $0xa,%eax
    1cbc:	0f 84 82 00 00 00    	je     1d44 <APWndProc+0x9c>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            break;
        default: break;
    1cc2:	e9 cb 00 00 00       	jmp    1d92 <APWndProc+0xea>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1cc7:	8b 45 08             	mov    0x8(%ebp),%eax
    1cca:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1ccd:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd0:	8b 48 18             	mov    0x18(%eax),%ecx
    1cd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd6:	8b 50 5c             	mov    0x5c(%eax),%edx
    1cd9:	8b 45 08             	mov    0x8(%ebp),%eax
    1cdc:	8b 40 58             	mov    0x58(%eax),%eax
    1cdf:	8b 75 08             	mov    0x8(%ebp),%esi
    1ce2:	83 c6 58             	add    $0x58,%esi
    1ce5:	83 ec 04             	sub    $0x4,%esp
    1ce8:	53                   	push   %ebx
    1ce9:	51                   	push   %ecx
    1cea:	6a 00                	push   $0x0
    1cec:	52                   	push   %edx
    1ced:	50                   	push   %eax
    1cee:	6a 00                	push   $0x0
    1cf0:	6a 00                	push   $0x0
    1cf2:	56                   	push   %esi
    1cf3:	6a 00                	push   $0x0
    1cf5:	6a 00                	push   $0x0
    1cf7:	ff 75 08             	pushl  0x8(%ebp)
    1cfa:	e8 59 eb ff ff       	call   858 <paintWindow>
    1cff:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1d02:	8b 45 08             	mov    0x8(%ebp),%eax
    1d05:	8b 70 1c             	mov    0x1c(%eax),%esi
    1d08:	8b 45 08             	mov    0x8(%ebp),%eax
    1d0b:	8b 58 18             	mov    0x18(%eax),%ebx
    1d0e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d11:	8b 48 08             	mov    0x8(%eax),%ecx
    1d14:	8b 45 08             	mov    0x8(%ebp),%eax
    1d17:	8b 50 40             	mov    0x40(%eax),%edx
    1d1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d1d:	8b 40 3c             	mov    0x3c(%eax),%eax
    1d20:	8b 7d 08             	mov    0x8(%ebp),%edi
    1d23:	83 c7 3c             	add    $0x3c,%edi
    1d26:	83 ec 04             	sub    $0x4,%esp
    1d29:	56                   	push   %esi
    1d2a:	53                   	push   %ebx
    1d2b:	51                   	push   %ecx
    1d2c:	52                   	push   %edx
    1d2d:	50                   	push   %eax
    1d2e:	6a 00                	push   $0x0
    1d30:	6a 00                	push   $0x0
    1d32:	57                   	push   %edi
    1d33:	6a 32                	push   $0x32
    1d35:	6a 00                	push   $0x0
    1d37:	ff 75 08             	pushl  0x8(%ebp)
    1d3a:	e8 19 eb ff ff       	call   858 <paintWindow>
    1d3f:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1d42:	eb 4e                	jmp    1d92 <APWndProc+0xea>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
    1d44:	8b 45 18             	mov    0x18(%ebp),%eax
    1d47:	83 ec 08             	sub    $0x8,%esp
    1d4a:	50                   	push   %eax
    1d4b:	ff 75 08             	pushl  0x8(%ebp)
    1d4e:	e8 19 08 00 00       	call   256c <updateword>
    1d53:	83 c4 10             	add    $0x10,%esp
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1d56:	8b 45 08             	mov    0x8(%ebp),%eax
    1d59:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1d5c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d5f:	8b 48 18             	mov    0x18(%eax),%ecx
    1d62:	8b 45 08             	mov    0x8(%ebp),%eax
    1d65:	8b 50 5c             	mov    0x5c(%eax),%edx
    1d68:	8b 45 08             	mov    0x8(%ebp),%eax
    1d6b:	8b 40 58             	mov    0x58(%eax),%eax
    1d6e:	8b 75 08             	mov    0x8(%ebp),%esi
    1d71:	83 c6 58             	add    $0x58,%esi
    1d74:	83 ec 04             	sub    $0x4,%esp
    1d77:	53                   	push   %ebx
    1d78:	51                   	push   %ecx
    1d79:	6a 00                	push   $0x0
    1d7b:	52                   	push   %edx
    1d7c:	50                   	push   %eax
    1d7d:	6a 00                	push   $0x0
    1d7f:	6a 00                	push   $0x0
    1d81:	56                   	push   %esi
    1d82:	6a 00                	push   $0x0
    1d84:	6a 00                	push   $0x0
    1d86:	ff 75 08             	pushl  0x8(%ebp)
    1d89:	e8 ca ea ff ff       	call   858 <paintWindow>
    1d8e:	83 c4 30             	add    $0x30,%esp
            break;
    1d91:	90                   	nop
        default: break;
            
            
    }
    return False;
    1d92:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1d97:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1d9a:	5b                   	pop    %ebx
    1d9b:	5e                   	pop    %esi
    1d9c:	5f                   	pop    %edi
    1d9d:	5d                   	pop    %ebp
    1d9e:	c3                   	ret    

00001d9f <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1d9f:	55                   	push   %ebp
    1da0:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1da2:	8b 45 0c             	mov    0xc(%ebp),%eax
    1da5:	8b 50 08             	mov    0x8(%eax),%edx
    1da8:	8b 45 08             	mov    0x8(%ebp),%eax
    1dab:	8b 00                	mov    (%eax),%eax
    1dad:	39 c2                	cmp    %eax,%edx
    1daf:	74 07                	je     1db8 <APPreJudge+0x19>
        return False;
    1db1:	b8 00 00 00 00       	mov    $0x0,%eax
    1db6:	eb 05                	jmp    1dbd <APPreJudge+0x1e>
    return True;
    1db8:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1dbd:	5d                   	pop    %ebp
    1dbe:	c3                   	ret    

00001dbf <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1dbf:	55                   	push   %ebp
    1dc0:	89 e5                	mov    %esp,%ebp
    1dc2:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1dc5:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc8:	8b 55 0c             	mov    0xc(%ebp),%edx
    1dcb:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
    //--------add window to list
    registWindow(hwnd);
    1dd1:	83 ec 0c             	sub    $0xc,%esp
    1dd4:	ff 75 08             	pushl  0x8(%ebp)
    1dd7:	e8 94 ea ff ff       	call   870 <registWindow>
    1ddc:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1ddf:	c7 45 e8 02 00 00 00 	movl   $0x2,-0x18(%ebp)
    msg.wndID = hwnd->id;
    1de6:	8b 45 08             	mov    0x8(%ebp),%eax
    1de9:	8b 00                	mov    (%eax),%eax
    1deb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    APSendMessage(hwnd,msg);
    1dee:	83 ec 0c             	sub    $0xc,%esp
    1df1:	ff 75 f4             	pushl  -0xc(%ebp)
    1df4:	ff 75 f0             	pushl  -0x10(%ebp)
    1df7:	ff 75 ec             	pushl  -0x14(%ebp)
    1dfa:	ff 75 e8             	pushl  -0x18(%ebp)
    1dfd:	ff 75 08             	pushl  0x8(%ebp)
    1e00:	e8 1f fc ff ff       	call   1a24 <APSendMessage>
    1e05:	83 c4 20             	add    $0x20,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1e08:	83 ec 0c             	sub    $0xc,%esp
    1e0b:	ff 75 08             	pushl  0x8(%ebp)
    1e0e:	e8 55 ea ff ff       	call   868 <getMessage>
    1e13:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1e16:	8b 45 08             	mov    0x8(%ebp),%eax
    1e19:	83 c0 74             	add    $0x74,%eax
    1e1c:	83 ec 08             	sub    $0x8,%esp
    1e1f:	50                   	push   %eax
    1e20:	ff 75 08             	pushl  0x8(%ebp)
    1e23:	e8 77 ff ff ff       	call   1d9f <APPreJudge>
    1e28:	83 c4 10             	add    $0x10,%esp
    1e2b:	84 c0                	test   %al,%al
    1e2d:	74 24                	je     1e53 <APWndExec+0x94>
            if (wndProc(hwnd, hwnd->msg))
    1e2f:	83 ec 0c             	sub    $0xc,%esp
    1e32:	8b 45 08             	mov    0x8(%ebp),%eax
    1e35:	ff b0 80 00 00 00    	pushl  0x80(%eax)
    1e3b:	ff 70 7c             	pushl  0x7c(%eax)
    1e3e:	ff 70 78             	pushl  0x78(%eax)
    1e41:	ff 70 74             	pushl  0x74(%eax)
    1e44:	ff 75 08             	pushl  0x8(%ebp)
    1e47:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e4a:	ff d0                	call   *%eax
    1e4c:	83 c4 20             	add    $0x20,%esp
    1e4f:	84 c0                	test   %al,%al
    1e51:	75 0c                	jne    1e5f <APWndExec+0xa0>
                break;
        hwnd->msg.type = MSG_NULL;
    1e53:	8b 45 08             	mov    0x8(%ebp),%eax
    1e56:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1e5d:	eb a9                	jmp    1e08 <APWndExec+0x49>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1e5f:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1e60:	90                   	nop
    1e61:	c9                   	leave  
    1e62:	c3                   	ret    

00001e63 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1e63:	55                   	push   %ebp
    1e64:	89 e5                	mov    %esp,%ebp
    1e66:	57                   	push   %edi
    1e67:	56                   	push   %esi
    1e68:	53                   	push   %ebx
    1e69:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1e6c:	a1 44 71 00 00       	mov    0x7144,%eax
    1e71:	85 c0                	test   %eax,%eax
    1e73:	0f 85 7a 02 00 00    	jne    20f3 <APGridPaint+0x290>
    {
        iconReady = 1;
    1e79:	c7 05 44 71 00 00 01 	movl   $0x1,0x7144
    1e80:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1e83:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e86:	83 ec 08             	sub    $0x8,%esp
    1e89:	68 03 2b 00 00       	push   $0x2b03
    1e8e:	50                   	push   %eax
    1e8f:	e8 69 ef ff ff       	call   dfd <APLoadBitmap>
    1e94:	83 c4 0c             	add    $0xc,%esp
    1e97:	8b 45 98             	mov    -0x68(%ebp),%eax
    1e9a:	a3 68 71 00 00       	mov    %eax,0x7168
    1e9f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ea2:	a3 6c 71 00 00       	mov    %eax,0x716c
    1ea7:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1eaa:	a3 70 71 00 00       	mov    %eax,0x7170
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1eaf:	83 ec 04             	sub    $0x4,%esp
    1eb2:	ff 35 70 71 00 00    	pushl  0x7170
    1eb8:	ff 35 6c 71 00 00    	pushl  0x716c
    1ebe:	ff 35 68 71 00 00    	pushl  0x7168
    1ec4:	e8 6e f1 ff ff       	call   1037 <APCreateCompatibleDCFromBitmap>
    1ec9:	83 c4 10             	add    $0x10,%esp
    1ecc:	a3 74 71 00 00       	mov    %eax,0x7174
        grid_river = APLoadBitmap ("grid_river.bmp");
    1ed1:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ed4:	83 ec 08             	sub    $0x8,%esp
    1ed7:	68 11 2b 00 00       	push   $0x2b11
    1edc:	50                   	push   %eax
    1edd:	e8 1b ef ff ff       	call   dfd <APLoadBitmap>
    1ee2:	83 c4 0c             	add    $0xc,%esp
    1ee5:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ee8:	a3 b0 71 00 00       	mov    %eax,0x71b0
    1eed:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ef0:	a3 b4 71 00 00       	mov    %eax,0x71b4
    1ef5:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ef8:	a3 b8 71 00 00       	mov    %eax,0x71b8
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1efd:	83 ec 04             	sub    $0x4,%esp
    1f00:	ff 35 b8 71 00 00    	pushl  0x71b8
    1f06:	ff 35 b4 71 00 00    	pushl  0x71b4
    1f0c:	ff 35 b0 71 00 00    	pushl  0x71b0
    1f12:	e8 20 f1 ff ff       	call   1037 <APCreateCompatibleDCFromBitmap>
    1f17:	83 c4 10             	add    $0x10,%esp
    1f1a:	a3 a0 71 00 00       	mov    %eax,0x71a0
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1f1f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1f22:	83 ec 08             	sub    $0x8,%esp
    1f25:	68 20 2b 00 00       	push   $0x2b20
    1f2a:	50                   	push   %eax
    1f2b:	e8 cd ee ff ff       	call   dfd <APLoadBitmap>
    1f30:	83 c4 0c             	add    $0xc,%esp
    1f33:	8b 45 98             	mov    -0x68(%ebp),%eax
    1f36:	a3 a4 71 00 00       	mov    %eax,0x71a4
    1f3b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1f3e:	a3 a8 71 00 00       	mov    %eax,0x71a8
    1f43:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1f46:	a3 ac 71 00 00       	mov    %eax,0x71ac
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1f4b:	83 ec 04             	sub    $0x4,%esp
    1f4e:	ff 35 ac 71 00 00    	pushl  0x71ac
    1f54:	ff 35 a8 71 00 00    	pushl  0x71a8
    1f5a:	ff 35 a4 71 00 00    	pushl  0x71a4
    1f60:	e8 d2 f0 ff ff       	call   1037 <APCreateCompatibleDCFromBitmap>
    1f65:	83 c4 10             	add    $0x10,%esp
    1f68:	a3 48 71 00 00       	mov    %eax,0x7148
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1f6d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1f70:	83 ec 08             	sub    $0x8,%esp
    1f73:	68 2f 2b 00 00       	push   $0x2b2f
    1f78:	50                   	push   %eax
    1f79:	e8 7f ee ff ff       	call   dfd <APLoadBitmap>
    1f7e:	83 c4 0c             	add    $0xc,%esp
    1f81:	8b 45 98             	mov    -0x68(%ebp),%eax
    1f84:	a3 7c 71 00 00       	mov    %eax,0x717c
    1f89:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1f8c:	a3 80 71 00 00       	mov    %eax,0x7180
    1f91:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1f94:	a3 84 71 00 00       	mov    %eax,0x7184
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1f99:	83 ec 04             	sub    $0x4,%esp
    1f9c:	ff 35 84 71 00 00    	pushl  0x7184
    1fa2:	ff 35 80 71 00 00    	pushl  0x7180
    1fa8:	ff 35 7c 71 00 00    	pushl  0x717c
    1fae:	e8 84 f0 ff ff       	call   1037 <APCreateCompatibleDCFromBitmap>
    1fb3:	83 c4 10             	add    $0x10,%esp
    1fb6:	a3 c0 71 00 00       	mov    %eax,0x71c0
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1fbb:	8d 45 98             	lea    -0x68(%ebp),%eax
    1fbe:	83 ec 08             	sub    $0x8,%esp
    1fc1:	68 3d 2b 00 00       	push   $0x2b3d
    1fc6:	50                   	push   %eax
    1fc7:	e8 31 ee ff ff       	call   dfd <APLoadBitmap>
    1fcc:	83 c4 0c             	add    $0xc,%esp
    1fcf:	8b 45 98             	mov    -0x68(%ebp),%eax
    1fd2:	a3 58 71 00 00       	mov    %eax,0x7158
    1fd7:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1fda:	a3 5c 71 00 00       	mov    %eax,0x715c
    1fdf:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1fe2:	a3 60 71 00 00       	mov    %eax,0x7160
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1fe7:	83 ec 04             	sub    $0x4,%esp
    1fea:	ff 35 60 71 00 00    	pushl  0x7160
    1ff0:	ff 35 5c 71 00 00    	pushl  0x715c
    1ff6:	ff 35 58 71 00 00    	pushl  0x7158
    1ffc:	e8 36 f0 ff ff       	call   1037 <APCreateCompatibleDCFromBitmap>
    2001:	83 c4 10             	add    $0x10,%esp
    2004:	a3 78 71 00 00       	mov    %eax,0x7178
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    2009:	8d 45 98             	lea    -0x68(%ebp),%eax
    200c:	83 ec 08             	sub    $0x8,%esp
    200f:	68 4d 2b 00 00       	push   $0x2b4d
    2014:	50                   	push   %eax
    2015:	e8 e3 ed ff ff       	call   dfd <APLoadBitmap>
    201a:	83 c4 0c             	add    $0xc,%esp
    201d:	8b 45 98             	mov    -0x68(%ebp),%eax
    2020:	a3 4c 71 00 00       	mov    %eax,0x714c
    2025:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2028:	a3 50 71 00 00       	mov    %eax,0x7150
    202d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2030:	a3 54 71 00 00       	mov    %eax,0x7154
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    2035:	83 ec 04             	sub    $0x4,%esp
    2038:	ff 35 54 71 00 00    	pushl  0x7154
    203e:	ff 35 50 71 00 00    	pushl  0x7150
    2044:	ff 35 4c 71 00 00    	pushl  0x714c
    204a:	e8 e8 ef ff ff       	call   1037 <APCreateCompatibleDCFromBitmap>
    204f:	83 c4 10             	add    $0x10,%esp
    2052:	a3 64 71 00 00       	mov    %eax,0x7164
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    2057:	8d 45 98             	lea    -0x68(%ebp),%eax
    205a:	83 ec 08             	sub    $0x8,%esp
    205d:	68 5f 2b 00 00       	push   $0x2b5f
    2062:	50                   	push   %eax
    2063:	e8 95 ed ff ff       	call   dfd <APLoadBitmap>
    2068:	83 c4 0c             	add    $0xc,%esp
    206b:	8b 45 98             	mov    -0x68(%ebp),%eax
    206e:	a3 94 71 00 00       	mov    %eax,0x7194
    2073:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2076:	a3 98 71 00 00       	mov    %eax,0x7198
    207b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    207e:	a3 9c 71 00 00       	mov    %eax,0x719c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    2083:	83 ec 04             	sub    $0x4,%esp
    2086:	ff 35 9c 71 00 00    	pushl  0x719c
    208c:	ff 35 98 71 00 00    	pushl  0x7198
    2092:	ff 35 94 71 00 00    	pushl  0x7194
    2098:	e8 9a ef ff ff       	call   1037 <APCreateCompatibleDCFromBitmap>
    209d:	83 c4 10             	add    $0x10,%esp
    20a0:	a3 c4 71 00 00       	mov    %eax,0x71c4
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    20a5:	8d 45 98             	lea    -0x68(%ebp),%eax
    20a8:	83 ec 08             	sub    $0x8,%esp
    20ab:	68 6e 2b 00 00       	push   $0x2b6e
    20b0:	50                   	push   %eax
    20b1:	e8 47 ed ff ff       	call   dfd <APLoadBitmap>
    20b6:	83 c4 0c             	add    $0xc,%esp
    20b9:	8b 45 98             	mov    -0x68(%ebp),%eax
    20bc:	a3 88 71 00 00       	mov    %eax,0x7188
    20c1:	8b 45 9c             	mov    -0x64(%ebp),%eax
    20c4:	a3 8c 71 00 00       	mov    %eax,0x718c
    20c9:	8b 45 a0             	mov    -0x60(%ebp),%eax
    20cc:	a3 90 71 00 00       	mov    %eax,0x7190
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    20d1:	83 ec 04             	sub    $0x4,%esp
    20d4:	ff 35 90 71 00 00    	pushl  0x7190
    20da:	ff 35 8c 71 00 00    	pushl  0x718c
    20e0:	ff 35 88 71 00 00    	pushl  0x7188
    20e6:	e8 4c ef ff ff       	call   1037 <APCreateCompatibleDCFromBitmap>
    20eb:	83 c4 10             	add    $0x10,%esp
    20ee:	a3 bc 71 00 00       	mov    %eax,0x71bc
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    20f3:	8b 45 08             	mov    0x8(%ebp),%eax
    20f6:	8b 40 08             	mov    0x8(%eax),%eax
    20f9:	85 c0                	test   %eax,%eax
    20fb:	75 17                	jne    2114 <APGridPaint+0x2b1>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    20fd:	83 ec 08             	sub    $0x8,%esp
    2100:	68 80 2b 00 00       	push   $0x2b80
    2105:	6a 01                	push   $0x1
    2107:	e8 6b e8 ff ff       	call   977 <printf>
    210c:	83 c4 10             	add    $0x10,%esp
        return;
    210f:	e9 50 04 00 00       	jmp    2564 <APGridPaint+0x701>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    2114:	8b 45 08             	mov    0x8(%ebp),%eax
    2117:	8b 40 10             	mov    0x10(%eax),%eax
    211a:	85 c0                	test   %eax,%eax
    211c:	7e 10                	jle    212e <APGridPaint+0x2cb>
    211e:	8b 45 08             	mov    0x8(%ebp),%eax
    2121:	8b 50 14             	mov    0x14(%eax),%edx
    2124:	8b 45 08             	mov    0x8(%ebp),%eax
    2127:	8b 40 10             	mov    0x10(%eax),%eax
    212a:	39 c2                	cmp    %eax,%edx
    212c:	7c 17                	jl     2145 <APGridPaint+0x2e2>
    {
        printf(1,"Grid mode page error!");
    212e:	83 ec 08             	sub    $0x8,%esp
    2131:	68 a6 2b 00 00       	push   $0x2ba6
    2136:	6a 01                	push   $0x1
    2138:	e8 3a e8 ff ff       	call   977 <printf>
    213d:	83 c4 10             	add    $0x10,%esp
        return;
    2140:	e9 1f 04 00 00       	jmp    2564 <APGridPaint+0x701>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    2145:	8b 45 08             	mov    0x8(%ebp),%eax
    2148:	8b 40 14             	mov    0x14(%eax),%eax
    214b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    2151:	89 45 dc             	mov    %eax,-0x24(%ebp)
    2154:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2157:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    215a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    2161:	e9 f4 03 00 00       	jmp    255a <APGridPaint+0x6f7>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2166:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    216d:	e9 da 03 00 00       	jmp    254c <APGridPaint+0x6e9>
        {
            index = start + GRID_W_NUMBER * j + i;
    2172:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2175:	c1 e0 04             	shl    $0x4,%eax
    2178:	89 c2                	mov    %eax,%edx
    217a:	8b 45 d8             	mov    -0x28(%ebp),%eax
    217d:	01 c2                	add    %eax,%edx
    217f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2182:	01 d0                	add    %edx,%eax
    2184:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    2187:	8b 45 08             	mov    0x8(%ebp),%eax
    218a:	8b 40 0c             	mov    0xc(%eax),%eax
    218d:	8b 55 dc             	mov    -0x24(%ebp),%edx
    2190:	c1 e2 02             	shl    $0x2,%edx
    2193:	01 d0                	add    %edx,%eax
    2195:	8b 00                	mov    (%eax),%eax
    2197:	83 f8 0a             	cmp    $0xa,%eax
    219a:	0f 87 a7 03 00 00    	ja     2547 <APGridPaint+0x6e4>
    21a0:	8b 04 85 bc 2b 00 00 	mov    0x2bbc(,%eax,4),%eax
    21a7:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    21a9:	8d 45 c0             	lea    -0x40(%ebp),%eax
    21ac:	6a 0c                	push   $0xc
    21ae:	6a 0c                	push   $0xc
    21b0:	6a 0c                	push   $0xc
    21b2:	50                   	push   %eax
    21b3:	e8 27 f8 ff ff       	call   19df <RGB>
    21b8:	83 c4 0c             	add    $0xc,%esp
    21bb:	8b 1d 74 71 00 00    	mov    0x7174,%ebx
    21c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21c4:	6b c8 32             	imul   $0x32,%eax,%ecx
    21c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    21ca:	6b c0 32             	imul   $0x32,%eax,%eax
    21cd:	89 45 94             	mov    %eax,-0x6c(%ebp)
    21d0:	8b 45 08             	mov    0x8(%ebp),%eax
    21d3:	8d 78 3c             	lea    0x3c(%eax),%edi
    21d6:	83 ec 0c             	sub    $0xc,%esp
    21d9:	83 ec 04             	sub    $0x4,%esp
    21dc:	89 e0                	mov    %esp,%eax
    21de:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    21e2:	66 89 30             	mov    %si,(%eax)
    21e5:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    21e9:	88 50 02             	mov    %dl,0x2(%eax)
    21ec:	6a 32                	push   $0x32
    21ee:	6a 32                	push   $0x32
    21f0:	6a 00                	push   $0x0
    21f2:	6a 00                	push   $0x0
    21f4:	53                   	push   %ebx
    21f5:	51                   	push   %ecx
    21f6:	ff 75 94             	pushl  -0x6c(%ebp)
    21f9:	57                   	push   %edi
    21fa:	e8 3c f6 ff ff       	call   183b <APDcCopy>
    21ff:	83 c4 30             	add    $0x30,%esp
                    break;
    2202:	e9 41 03 00 00       	jmp    2548 <APGridPaint+0x6e5>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    2207:	8d 45 98             	lea    -0x68(%ebp),%eax
    220a:	6a 69                	push   $0x69
    220c:	6a 69                	push   $0x69
    220e:	6a 69                	push   $0x69
    2210:	50                   	push   %eax
    2211:	e8 c9 f7 ff ff       	call   19df <RGB>
    2216:	83 c4 0c             	add    $0xc,%esp
    2219:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    221d:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    2221:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2225:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    2228:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    222f:	8d 45 98             	lea    -0x68(%ebp),%eax
    2232:	6a 69                	push   $0x69
    2234:	6a 69                	push   $0x69
    2236:	6a 69                	push   $0x69
    2238:	50                   	push   %eax
    2239:	e8 a1 f7 ff ff       	call   19df <RGB>
    223e:	83 c4 0c             	add    $0xc,%esp
    2241:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2245:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    2249:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    224d:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    2250:	8b 45 08             	mov    0x8(%ebp),%eax
    2253:	8d 50 3c             	lea    0x3c(%eax),%edx
    2256:	8d 45 98             	lea    -0x68(%ebp),%eax
    2259:	ff 75 bc             	pushl  -0x44(%ebp)
    225c:	ff 75 b8             	pushl  -0x48(%ebp)
    225f:	52                   	push   %edx
    2260:	50                   	push   %eax
    2261:	e8 66 ee ff ff       	call   10cc <APSetPen>
    2266:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    2269:	8b 45 08             	mov    0x8(%ebp),%eax
    226c:	8d 58 3c             	lea    0x3c(%eax),%ebx
    226f:	8d 55 98             	lea    -0x68(%ebp),%edx
    2272:	83 ec 04             	sub    $0x4,%esp
    2275:	83 ec 04             	sub    $0x4,%esp
    2278:	89 e0                	mov    %esp,%eax
    227a:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    227e:	66 89 08             	mov    %cx,(%eax)
    2281:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2285:	88 48 02             	mov    %cl,0x2(%eax)
    2288:	53                   	push   %ebx
    2289:	52                   	push   %edx
    228a:	e8 76 ee ff ff       	call   1105 <APSetBrush>
    228f:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    2292:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2295:	6b d0 32             	imul   $0x32,%eax,%edx
    2298:	8b 45 e0             	mov    -0x20(%ebp),%eax
    229b:	6b c0 32             	imul   $0x32,%eax,%eax
    229e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    22a1:	83 c1 3c             	add    $0x3c,%ecx
    22a4:	83 ec 0c             	sub    $0xc,%esp
    22a7:	6a 32                	push   $0x32
    22a9:	6a 32                	push   $0x32
    22ab:	52                   	push   %edx
    22ac:	50                   	push   %eax
    22ad:	51                   	push   %ecx
    22ae:	e8 7c f2 ff ff       	call   152f <APDrawRect>
    22b3:	83 c4 20             	add    $0x20,%esp
                    break;
    22b6:	e9 8d 02 00 00       	jmp    2548 <APGridPaint+0x6e5>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    22bb:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    22be:	6a 0c                	push   $0xc
    22c0:	6a 0c                	push   $0xc
    22c2:	6a 0c                	push   $0xc
    22c4:	50                   	push   %eax
    22c5:	e8 15 f7 ff ff       	call   19df <RGB>
    22ca:	83 c4 0c             	add    $0xc,%esp
    22cd:	8b 1d c4 71 00 00    	mov    0x71c4,%ebx
    22d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22d6:	6b c8 32             	imul   $0x32,%eax,%ecx
    22d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    22dc:	6b c0 32             	imul   $0x32,%eax,%eax
    22df:	89 45 94             	mov    %eax,-0x6c(%ebp)
    22e2:	8b 45 08             	mov    0x8(%ebp),%eax
    22e5:	8d 78 3c             	lea    0x3c(%eax),%edi
    22e8:	83 ec 0c             	sub    $0xc,%esp
    22eb:	83 ec 04             	sub    $0x4,%esp
    22ee:	89 e0                	mov    %esp,%eax
    22f0:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    22f4:	66 89 30             	mov    %si,(%eax)
    22f7:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    22fb:	88 50 02             	mov    %dl,0x2(%eax)
    22fe:	6a 32                	push   $0x32
    2300:	6a 32                	push   $0x32
    2302:	6a 00                	push   $0x0
    2304:	6a 00                	push   $0x0
    2306:	53                   	push   %ebx
    2307:	51                   	push   %ecx
    2308:	ff 75 94             	pushl  -0x6c(%ebp)
    230b:	57                   	push   %edi
    230c:	e8 2a f5 ff ff       	call   183b <APDcCopy>
    2311:	83 c4 30             	add    $0x30,%esp
                    break;
    2314:	e9 2f 02 00 00       	jmp    2548 <APGridPaint+0x6e5>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2319:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    231c:	6a 0c                	push   $0xc
    231e:	6a 0c                	push   $0xc
    2320:	6a 0c                	push   $0xc
    2322:	50                   	push   %eax
    2323:	e8 b7 f6 ff ff       	call   19df <RGB>
    2328:	83 c4 0c             	add    $0xc,%esp
    232b:	8b 1d a0 71 00 00    	mov    0x71a0,%ebx
    2331:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2334:	6b c8 32             	imul   $0x32,%eax,%ecx
    2337:	8b 45 e0             	mov    -0x20(%ebp),%eax
    233a:	6b c0 32             	imul   $0x32,%eax,%eax
    233d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2340:	8b 45 08             	mov    0x8(%ebp),%eax
    2343:	8d 78 3c             	lea    0x3c(%eax),%edi
    2346:	83 ec 0c             	sub    $0xc,%esp
    2349:	83 ec 04             	sub    $0x4,%esp
    234c:	89 e0                	mov    %esp,%eax
    234e:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2352:	66 89 30             	mov    %si,(%eax)
    2355:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    2359:	88 50 02             	mov    %dl,0x2(%eax)
    235c:	6a 32                	push   $0x32
    235e:	6a 32                	push   $0x32
    2360:	6a 00                	push   $0x0
    2362:	6a 00                	push   $0x0
    2364:	53                   	push   %ebx
    2365:	51                   	push   %ecx
    2366:	ff 75 94             	pushl  -0x6c(%ebp)
    2369:	57                   	push   %edi
    236a:	e8 cc f4 ff ff       	call   183b <APDcCopy>
    236f:	83 c4 30             	add    $0x30,%esp
                    break;
    2372:	e9 d1 01 00 00       	jmp    2548 <APGridPaint+0x6e5>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2377:	8d 45 c9             	lea    -0x37(%ebp),%eax
    237a:	6a 0c                	push   $0xc
    237c:	6a 0c                	push   $0xc
    237e:	6a 0c                	push   $0xc
    2380:	50                   	push   %eax
    2381:	e8 59 f6 ff ff       	call   19df <RGB>
    2386:	83 c4 0c             	add    $0xc,%esp
    2389:	8b 1d 78 71 00 00    	mov    0x7178,%ebx
    238f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2392:	6b c8 32             	imul   $0x32,%eax,%ecx
    2395:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2398:	6b c0 32             	imul   $0x32,%eax,%eax
    239b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    239e:	8b 45 08             	mov    0x8(%ebp),%eax
    23a1:	8d 78 3c             	lea    0x3c(%eax),%edi
    23a4:	83 ec 0c             	sub    $0xc,%esp
    23a7:	83 ec 04             	sub    $0x4,%esp
    23aa:	89 e0                	mov    %esp,%eax
    23ac:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    23b0:	66 89 30             	mov    %si,(%eax)
    23b3:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    23b7:	88 50 02             	mov    %dl,0x2(%eax)
    23ba:	6a 32                	push   $0x32
    23bc:	6a 32                	push   $0x32
    23be:	6a 00                	push   $0x0
    23c0:	6a 00                	push   $0x0
    23c2:	53                   	push   %ebx
    23c3:	51                   	push   %ecx
    23c4:	ff 75 94             	pushl  -0x6c(%ebp)
    23c7:	57                   	push   %edi
    23c8:	e8 6e f4 ff ff       	call   183b <APDcCopy>
    23cd:	83 c4 30             	add    $0x30,%esp
                    break;
    23d0:	e9 73 01 00 00       	jmp    2548 <APGridPaint+0x6e5>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    23d5:	8d 45 cc             	lea    -0x34(%ebp),%eax
    23d8:	6a 0c                	push   $0xc
    23da:	6a 0c                	push   $0xc
    23dc:	6a 0c                	push   $0xc
    23de:	50                   	push   %eax
    23df:	e8 fb f5 ff ff       	call   19df <RGB>
    23e4:	83 c4 0c             	add    $0xc,%esp
    23e7:	8b 1d c0 71 00 00    	mov    0x71c0,%ebx
    23ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23f0:	6b c8 32             	imul   $0x32,%eax,%ecx
    23f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    23f6:	6b c0 32             	imul   $0x32,%eax,%eax
    23f9:	89 45 94             	mov    %eax,-0x6c(%ebp)
    23fc:	8b 45 08             	mov    0x8(%ebp),%eax
    23ff:	8d 78 3c             	lea    0x3c(%eax),%edi
    2402:	83 ec 0c             	sub    $0xc,%esp
    2405:	83 ec 04             	sub    $0x4,%esp
    2408:	89 e0                	mov    %esp,%eax
    240a:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    240e:	66 89 30             	mov    %si,(%eax)
    2411:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    2415:	88 50 02             	mov    %dl,0x2(%eax)
    2418:	6a 32                	push   $0x32
    241a:	6a 32                	push   $0x32
    241c:	6a 00                	push   $0x0
    241e:	6a 00                	push   $0x0
    2420:	53                   	push   %ebx
    2421:	51                   	push   %ecx
    2422:	ff 75 94             	pushl  -0x6c(%ebp)
    2425:	57                   	push   %edi
    2426:	e8 10 f4 ff ff       	call   183b <APDcCopy>
    242b:	83 c4 30             	add    $0x30,%esp
                    break;
    242e:	e9 15 01 00 00       	jmp    2548 <APGridPaint+0x6e5>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2433:	8d 45 cf             	lea    -0x31(%ebp),%eax
    2436:	6a 0c                	push   $0xc
    2438:	6a 0c                	push   $0xc
    243a:	6a 0c                	push   $0xc
    243c:	50                   	push   %eax
    243d:	e8 9d f5 ff ff       	call   19df <RGB>
    2442:	83 c4 0c             	add    $0xc,%esp
    2445:	8b 1d 48 71 00 00    	mov    0x7148,%ebx
    244b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    244e:	6b c8 32             	imul   $0x32,%eax,%ecx
    2451:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2454:	6b c0 32             	imul   $0x32,%eax,%eax
    2457:	89 45 94             	mov    %eax,-0x6c(%ebp)
    245a:	8b 45 08             	mov    0x8(%ebp),%eax
    245d:	8d 78 3c             	lea    0x3c(%eax),%edi
    2460:	83 ec 0c             	sub    $0xc,%esp
    2463:	83 ec 04             	sub    $0x4,%esp
    2466:	89 e0                	mov    %esp,%eax
    2468:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    246c:	66 89 30             	mov    %si,(%eax)
    246f:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2473:	88 50 02             	mov    %dl,0x2(%eax)
    2476:	6a 32                	push   $0x32
    2478:	6a 32                	push   $0x32
    247a:	6a 00                	push   $0x0
    247c:	6a 00                	push   $0x0
    247e:	53                   	push   %ebx
    247f:	51                   	push   %ecx
    2480:	ff 75 94             	pushl  -0x6c(%ebp)
    2483:	57                   	push   %edi
    2484:	e8 b2 f3 ff ff       	call   183b <APDcCopy>
    2489:	83 c4 30             	add    $0x30,%esp
                    break;
    248c:	e9 b7 00 00 00       	jmp    2548 <APGridPaint+0x6e5>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2491:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2494:	6a 0c                	push   $0xc
    2496:	6a 0c                	push   $0xc
    2498:	6a 0c                	push   $0xc
    249a:	50                   	push   %eax
    249b:	e8 3f f5 ff ff       	call   19df <RGB>
    24a0:	83 c4 0c             	add    $0xc,%esp
    24a3:	8b 1d 64 71 00 00    	mov    0x7164,%ebx
    24a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24ac:	6b c8 32             	imul   $0x32,%eax,%ecx
    24af:	8b 45 e0             	mov    -0x20(%ebp),%eax
    24b2:	6b c0 32             	imul   $0x32,%eax,%eax
    24b5:	89 45 94             	mov    %eax,-0x6c(%ebp)
    24b8:	8b 45 08             	mov    0x8(%ebp),%eax
    24bb:	8d 78 3c             	lea    0x3c(%eax),%edi
    24be:	83 ec 0c             	sub    $0xc,%esp
    24c1:	83 ec 04             	sub    $0x4,%esp
    24c4:	89 e0                	mov    %esp,%eax
    24c6:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    24ca:	66 89 30             	mov    %si,(%eax)
    24cd:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    24d1:	88 50 02             	mov    %dl,0x2(%eax)
    24d4:	6a 32                	push   $0x32
    24d6:	6a 32                	push   $0x32
    24d8:	6a 00                	push   $0x0
    24da:	6a 00                	push   $0x0
    24dc:	53                   	push   %ebx
    24dd:	51                   	push   %ecx
    24de:	ff 75 94             	pushl  -0x6c(%ebp)
    24e1:	57                   	push   %edi
    24e2:	e8 54 f3 ff ff       	call   183b <APDcCopy>
    24e7:	83 c4 30             	add    $0x30,%esp
                    break;
    24ea:	eb 5c                	jmp    2548 <APGridPaint+0x6e5>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    24ec:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    24ef:	6a 0c                	push   $0xc
    24f1:	6a 0c                	push   $0xc
    24f3:	6a 0c                	push   $0xc
    24f5:	50                   	push   %eax
    24f6:	e8 e4 f4 ff ff       	call   19df <RGB>
    24fb:	83 c4 0c             	add    $0xc,%esp
    24fe:	8b 1d bc 71 00 00    	mov    0x71bc,%ebx
    2504:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2507:	6b c8 32             	imul   $0x32,%eax,%ecx
    250a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    250d:	6b c0 32             	imul   $0x32,%eax,%eax
    2510:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2513:	8b 45 08             	mov    0x8(%ebp),%eax
    2516:	8d 78 3c             	lea    0x3c(%eax),%edi
    2519:	83 ec 0c             	sub    $0xc,%esp
    251c:	83 ec 04             	sub    $0x4,%esp
    251f:	89 e0                	mov    %esp,%eax
    2521:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2525:	66 89 30             	mov    %si,(%eax)
    2528:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    252c:	88 50 02             	mov    %dl,0x2(%eax)
    252f:	6a 32                	push   $0x32
    2531:	6a 32                	push   $0x32
    2533:	6a 00                	push   $0x0
    2535:	6a 00                	push   $0x0
    2537:	53                   	push   %ebx
    2538:	51                   	push   %ecx
    2539:	ff 75 94             	pushl  -0x6c(%ebp)
    253c:	57                   	push   %edi
    253d:	e8 f9 f2 ff ff       	call   183b <APDcCopy>
    2542:	83 c4 30             	add    $0x30,%esp
                    break;
    2545:	eb 01                	jmp    2548 <APGridPaint+0x6e5>
                default: break;
    2547:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2548:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    254c:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2550:	0f 8e 1c fc ff ff    	jle    2172 <APGridPaint+0x30f>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2556:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    255a:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    255e:	0f 8e 02 fc ff ff    	jle    2166 <APGridPaint+0x303>
                default: break;
            }
        }
    }
    
}
    2564:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2567:	5b                   	pop    %ebx
    2568:	5e                   	pop    %esi
    2569:	5f                   	pop    %edi
    256a:	5d                   	pop    %ebp
    256b:	c3                   	ret    

0000256c <updateword>:


void updateword(AHwnd hwnd,char* str)
{
    256c:	55                   	push   %ebp
    256d:	89 e5                	mov    %esp,%ebp
    256f:	53                   	push   %ebx
    2570:	83 ec 24             	sub    $0x24,%esp
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2573:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2576:	68 cd 00 00 00       	push   $0xcd
    257b:	6a 74                	push   $0x74
    257d:	6a 18                	push   $0x18
    257f:	50                   	push   %eax
    2580:	e8 5a f4 ff ff       	call   19df <RGB>
    2585:	83 c4 0c             	add    $0xc,%esp
    2588:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    258c:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
    2590:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    2594:	88 45 f2             	mov    %al,-0xe(%ebp)
    pen.size = 1;
    2597:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    259e:	8d 45 d8             	lea    -0x28(%ebp),%eax
    25a1:	68 cd 00 00 00       	push   $0xcd
    25a6:	6a 74                	push   $0x74
    25a8:	6a 18                	push   $0x18
    25aa:	50                   	push   %eax
    25ab:	e8 2f f4 ff ff       	call   19df <RGB>
    25b0:	83 c4 0c             	add    $0xc,%esp
    25b3:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    25b7:	66 89 45 ed          	mov    %ax,-0x13(%ebp)
    25bb:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    25bf:	88 45 ef             	mov    %al,-0x11(%ebp)
    APSetPen(&hwnd->TitleDc,pen);
    25c2:	8b 45 08             	mov    0x8(%ebp),%eax
    25c5:	8d 50 58             	lea    0x58(%eax),%edx
    25c8:	8d 45 d8             	lea    -0x28(%ebp),%eax
    25cb:	ff 75 f4             	pushl  -0xc(%ebp)
    25ce:	ff 75 f0             	pushl  -0x10(%ebp)
    25d1:	52                   	push   %edx
    25d2:	50                   	push   %eax
    25d3:	e8 f4 ea ff ff       	call   10cc <APSetPen>
    25d8:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&hwnd->TitleDc,brush);
    25db:	8b 45 08             	mov    0x8(%ebp),%eax
    25de:	8d 58 58             	lea    0x58(%eax),%ebx
    25e1:	8d 55 d8             	lea    -0x28(%ebp),%edx
    25e4:	83 ec 04             	sub    $0x4,%esp
    25e7:	83 ec 04             	sub    $0x4,%esp
    25ea:	89 e0                	mov    %esp,%eax
    25ec:	0f b7 4d ed          	movzwl -0x13(%ebp),%ecx
    25f0:	66 89 08             	mov    %cx,(%eax)
    25f3:	0f b6 4d ef          	movzbl -0x11(%ebp),%ecx
    25f7:	88 48 02             	mov    %cl,0x2(%eax)
    25fa:	53                   	push   %ebx
    25fb:	52                   	push   %edx
    25fc:	e8 04 eb ff ff       	call   1105 <APSetBrush>
    2601:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&hwnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2604:	8b 45 08             	mov    0x8(%ebp),%eax
    2607:	83 c0 58             	add    $0x58,%eax
    260a:	83 ec 0c             	sub    $0xc,%esp
    260d:	6a 32                	push   $0x32
    260f:	68 20 03 00 00       	push   $0x320
    2614:	6a 00                	push   $0x0
    2616:	6a 00                	push   $0x0
    2618:	50                   	push   %eax
    2619:	e8 11 ef ff ff       	call   152f <APDrawRect>
    261e:	83 c4 20             	add    $0x20,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    2621:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2624:	6a 08                	push   $0x8
    2626:	6a 08                	push   $0x8
    2628:	6a 08                	push   $0x8
    262a:	50                   	push   %eax
    262b:	e8 af f3 ff ff       	call   19df <RGB>
    2630:	83 c4 0c             	add    $0xc,%esp
    2633:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2637:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    263b:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    263f:	88 45 ec             	mov    %al,-0x14(%ebp)
    APSetFont(&hwnd->TitleDc,font);
    2642:	8b 45 08             	mov    0x8(%ebp),%eax
    2645:	8d 58 58             	lea    0x58(%eax),%ebx
    2648:	8d 55 d8             	lea    -0x28(%ebp),%edx
    264b:	83 ec 04             	sub    $0x4,%esp
    264e:	83 ec 04             	sub    $0x4,%esp
    2651:	89 e0                	mov    %esp,%eax
    2653:	0f b7 4d ea          	movzwl -0x16(%ebp),%ecx
    2657:	66 89 08             	mov    %cx,(%eax)
    265a:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
    265e:	88 48 02             	mov    %cl,0x2(%eax)
    2661:	53                   	push   %ebx
    2662:	52                   	push   %edx
    2663:	e8 df ea ff ff       	call   1147 <APSetFont>
    2668:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&hwnd->TitleDc,str,10,20);
    266b:	8b 45 08             	mov    0x8(%ebp),%eax
    266e:	83 c0 58             	add    $0x58,%eax
    2671:	6a 14                	push   $0x14
    2673:	6a 0a                	push   $0xa
    2675:	ff 75 0c             	pushl  0xc(%ebp)
    2678:	50                   	push   %eax
    2679:	e8 b6 f0 ff ff       	call   1734 <APDrawText>
    267e:	83 c4 10             	add    $0x10,%esp
}
    2681:	90                   	nop
    2682:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2685:	c9                   	leave  
    2686:	c3                   	ret    

00002687 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2687:	55                   	push   %ebp
    2688:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    268a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    268e:	7e 08                	jle    2698 <random+0x11>
{
rand_num = seed;
    2690:	8b 45 08             	mov    0x8(%ebp),%eax
    2693:	a3 20 71 00 00       	mov    %eax,0x7120
}
rand_num *= 3;
    2698:	8b 15 20 71 00 00    	mov    0x7120,%edx
    269e:	89 d0                	mov    %edx,%eax
    26a0:	01 c0                	add    %eax,%eax
    26a2:	01 d0                	add    %edx,%eax
    26a4:	a3 20 71 00 00       	mov    %eax,0x7120
if (rand_num < 0)
    26a9:	a1 20 71 00 00       	mov    0x7120,%eax
    26ae:	85 c0                	test   %eax,%eax
    26b0:	79 0c                	jns    26be <random+0x37>
{
rand_num *= (-1);
    26b2:	a1 20 71 00 00       	mov    0x7120,%eax
    26b7:	f7 d8                	neg    %eax
    26b9:	a3 20 71 00 00       	mov    %eax,0x7120
}
return rand_num % 997;
    26be:	8b 0d 20 71 00 00    	mov    0x7120,%ecx
    26c4:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    26c9:	89 c8                	mov    %ecx,%eax
    26cb:	f7 ea                	imul   %edx
    26cd:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    26d0:	c1 f8 09             	sar    $0x9,%eax
    26d3:	89 c2                	mov    %eax,%edx
    26d5:	89 c8                	mov    %ecx,%eax
    26d7:	c1 f8 1f             	sar    $0x1f,%eax
    26da:	29 c2                	sub    %eax,%edx
    26dc:	89 d0                	mov    %edx,%eax
    26de:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    26e4:	29 c1                	sub    %eax,%ecx
    26e6:	89 c8                	mov    %ecx,%eax
}
    26e8:	5d                   	pop    %ebp
    26e9:	c3                   	ret    

000026ea <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    26ea:	55                   	push   %ebp
    26eb:	89 e5                	mov    %esp,%ebp
    26ed:	53                   	push   %ebx
    26ee:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    26f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    26f8:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    26fc:	74 17                	je     2715 <sprintint+0x2b>
    26fe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2702:	79 11                	jns    2715 <sprintint+0x2b>
        neg = 1;
    2704:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    270b:	8b 45 10             	mov    0x10(%ebp),%eax
    270e:	f7 d8                	neg    %eax
    2710:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2713:	eb 06                	jmp    271b <sprintint+0x31>
    } else {
        x = xx;
    2715:	8b 45 10             	mov    0x10(%ebp),%eax
    2718:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    271b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2722:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2725:	8d 41 01             	lea    0x1(%ecx),%eax
    2728:	89 45 f8             	mov    %eax,-0x8(%ebp)
    272b:	8b 5d 14             	mov    0x14(%ebp),%ebx
    272e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2731:	ba 00 00 00 00       	mov    $0x0,%edx
    2736:	f7 f3                	div    %ebx
    2738:	89 d0                	mov    %edx,%eax
    273a:	0f b6 80 24 71 00 00 	movzbl 0x7124(%eax),%eax
    2741:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2745:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2748:	8b 45 f0             	mov    -0x10(%ebp),%eax
    274b:	ba 00 00 00 00       	mov    $0x0,%edx
    2750:	f7 f3                	div    %ebx
    2752:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2755:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2759:	75 c7                	jne    2722 <sprintint+0x38>
    if(neg)
    275b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    275f:	74 0e                	je     276f <sprintint+0x85>
        buf[i++] = '-';
    2761:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2764:	8d 50 01             	lea    0x1(%eax),%edx
    2767:	89 55 f8             	mov    %edx,-0x8(%ebp)
    276a:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    276f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2772:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2775:	eb 1b                	jmp    2792 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2777:	8b 45 0c             	mov    0xc(%ebp),%eax
    277a:	8b 00                	mov    (%eax),%eax
    277c:	8d 48 01             	lea    0x1(%eax),%ecx
    277f:	8b 55 0c             	mov    0xc(%ebp),%edx
    2782:	89 0a                	mov    %ecx,(%edx)
    2784:	89 c2                	mov    %eax,%edx
    2786:	8b 45 08             	mov    0x8(%ebp),%eax
    2789:	01 d0                	add    %edx,%eax
    278b:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    278e:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2792:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2796:	7f df                	jg     2777 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2798:	eb 21                	jmp    27bb <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    279a:	8b 45 0c             	mov    0xc(%ebp),%eax
    279d:	8b 00                	mov    (%eax),%eax
    279f:	8d 48 01             	lea    0x1(%eax),%ecx
    27a2:	8b 55 0c             	mov    0xc(%ebp),%edx
    27a5:	89 0a                	mov    %ecx,(%edx)
    27a7:	89 c2                	mov    %eax,%edx
    27a9:	8b 45 08             	mov    0x8(%ebp),%eax
    27ac:	01 c2                	add    %eax,%edx
    27ae:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    27b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    27b4:	01 c8                	add    %ecx,%eax
    27b6:	0f b6 00             	movzbl (%eax),%eax
    27b9:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    27bb:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    27bf:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    27c3:	79 d5                	jns    279a <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    27c5:	90                   	nop
    27c6:	83 c4 20             	add    $0x20,%esp
    27c9:	5b                   	pop    %ebx
    27ca:	5d                   	pop    %ebp
    27cb:	c3                   	ret    

000027cc <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    27cc:	55                   	push   %ebp
    27cd:	89 e5                	mov    %esp,%ebp
    27cf:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    27d2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    27d9:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    27e0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    27e7:	8d 45 0c             	lea    0xc(%ebp),%eax
    27ea:	83 c0 04             	add    $0x4,%eax
    27ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    27f0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    27f7:	e9 d9 01 00 00       	jmp    29d5 <sprintf+0x209>
        c = fmt[i] & 0xff;
    27fc:	8b 55 0c             	mov    0xc(%ebp),%edx
    27ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2802:	01 d0                	add    %edx,%eax
    2804:	0f b6 00             	movzbl (%eax),%eax
    2807:	0f be c0             	movsbl %al,%eax
    280a:	25 ff 00 00 00       	and    $0xff,%eax
    280f:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2812:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2816:	75 2c                	jne    2844 <sprintf+0x78>
            if(c == '%'){
    2818:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    281c:	75 0c                	jne    282a <sprintf+0x5e>
                state = '%';
    281e:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2825:	e9 a7 01 00 00       	jmp    29d1 <sprintf+0x205>
            } else {
                dst[j++] = c;
    282a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    282d:	8d 50 01             	lea    0x1(%eax),%edx
    2830:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2833:	89 c2                	mov    %eax,%edx
    2835:	8b 45 08             	mov    0x8(%ebp),%eax
    2838:	01 d0                	add    %edx,%eax
    283a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    283d:	88 10                	mov    %dl,(%eax)
    283f:	e9 8d 01 00 00       	jmp    29d1 <sprintf+0x205>
            }
        } else if(state == '%'){
    2844:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2848:	0f 85 83 01 00 00    	jne    29d1 <sprintf+0x205>
            if(c == 'd'){
    284e:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2852:	75 4c                	jne    28a0 <sprintf+0xd4>
                buf[bi] = '\0';
    2854:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2857:	8b 45 f0             	mov    -0x10(%ebp),%eax
    285a:	01 d0                	add    %edx,%eax
    285c:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    285f:	83 ec 0c             	sub    $0xc,%esp
    2862:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2865:	50                   	push   %eax
    2866:	e8 bb de ff ff       	call   726 <atoi>
    286b:	83 c4 10             	add    $0x10,%esp
    286e:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2871:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2878:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    287b:	8b 00                	mov    (%eax),%eax
    287d:	83 ec 08             	sub    $0x8,%esp
    2880:	ff 75 d8             	pushl  -0x28(%ebp)
    2883:	6a 01                	push   $0x1
    2885:	6a 0a                	push   $0xa
    2887:	50                   	push   %eax
    2888:	8d 45 c8             	lea    -0x38(%ebp),%eax
    288b:	50                   	push   %eax
    288c:	ff 75 08             	pushl  0x8(%ebp)
    288f:	e8 56 fe ff ff       	call   26ea <sprintint>
    2894:	83 c4 20             	add    $0x20,%esp
                ap++;
    2897:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    289b:	e9 2a 01 00 00       	jmp    29ca <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    28a0:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    28a4:	74 06                	je     28ac <sprintf+0xe0>
    28a6:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    28aa:	75 4c                	jne    28f8 <sprintf+0x12c>
                buf[bi] = '\0';
    28ac:	8d 55 ce             	lea    -0x32(%ebp),%edx
    28af:	8b 45 f0             	mov    -0x10(%ebp),%eax
    28b2:	01 d0                	add    %edx,%eax
    28b4:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    28b7:	83 ec 0c             	sub    $0xc,%esp
    28ba:	8d 45 ce             	lea    -0x32(%ebp),%eax
    28bd:	50                   	push   %eax
    28be:	e8 63 de ff ff       	call   726 <atoi>
    28c3:	83 c4 10             	add    $0x10,%esp
    28c6:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    28c9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    28d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    28d3:	8b 00                	mov    (%eax),%eax
    28d5:	83 ec 08             	sub    $0x8,%esp
    28d8:	ff 75 dc             	pushl  -0x24(%ebp)
    28db:	6a 00                	push   $0x0
    28dd:	6a 10                	push   $0x10
    28df:	50                   	push   %eax
    28e0:	8d 45 c8             	lea    -0x38(%ebp),%eax
    28e3:	50                   	push   %eax
    28e4:	ff 75 08             	pushl  0x8(%ebp)
    28e7:	e8 fe fd ff ff       	call   26ea <sprintint>
    28ec:	83 c4 20             	add    $0x20,%esp
                ap++;
    28ef:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    28f3:	e9 d2 00 00 00       	jmp    29ca <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    28f8:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    28fc:	75 46                	jne    2944 <sprintf+0x178>
                s = (char*)*ap;
    28fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2901:	8b 00                	mov    (%eax),%eax
    2903:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2906:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    290a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    290e:	75 25                	jne    2935 <sprintf+0x169>
                    s = "(null)";
    2910:	c7 45 f4 e8 2b 00 00 	movl   $0x2be8,-0xc(%ebp)
                while(*s != 0){
    2917:	eb 1c                	jmp    2935 <sprintf+0x169>
                    dst[j++] = *s;
    2919:	8b 45 c8             	mov    -0x38(%ebp),%eax
    291c:	8d 50 01             	lea    0x1(%eax),%edx
    291f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2922:	89 c2                	mov    %eax,%edx
    2924:	8b 45 08             	mov    0x8(%ebp),%eax
    2927:	01 c2                	add    %eax,%edx
    2929:	8b 45 f4             	mov    -0xc(%ebp),%eax
    292c:	0f b6 00             	movzbl (%eax),%eax
    292f:	88 02                	mov    %al,(%edx)
                    s++;
    2931:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2935:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2938:	0f b6 00             	movzbl (%eax),%eax
    293b:	84 c0                	test   %al,%al
    293d:	75 da                	jne    2919 <sprintf+0x14d>
    293f:	e9 86 00 00 00       	jmp    29ca <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2944:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2948:	75 1d                	jne    2967 <sprintf+0x19b>
                dst[j++] = *ap;
    294a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    294d:	8d 50 01             	lea    0x1(%eax),%edx
    2950:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2953:	89 c2                	mov    %eax,%edx
    2955:	8b 45 08             	mov    0x8(%ebp),%eax
    2958:	01 c2                	add    %eax,%edx
    295a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    295d:	8b 00                	mov    (%eax),%eax
    295f:	88 02                	mov    %al,(%edx)
                ap++;
    2961:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2965:	eb 63                	jmp    29ca <sprintf+0x1fe>
            } else if(c == '%'){
    2967:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    296b:	75 17                	jne    2984 <sprintf+0x1b8>
                dst[j++] = c;
    296d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2970:	8d 50 01             	lea    0x1(%eax),%edx
    2973:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2976:	89 c2                	mov    %eax,%edx
    2978:	8b 45 08             	mov    0x8(%ebp),%eax
    297b:	01 d0                	add    %edx,%eax
    297d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2980:	88 10                	mov    %dl,(%eax)
    2982:	eb 46                	jmp    29ca <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2984:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2988:	7e 18                	jle    29a2 <sprintf+0x1d6>
    298a:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    298e:	7f 12                	jg     29a2 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2990:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2993:	8d 50 01             	lea    0x1(%eax),%edx
    2996:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2999:	8b 55 e0             	mov    -0x20(%ebp),%edx
    299c:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    29a0:	eb 2f                	jmp    29d1 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    29a2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    29a5:	8d 50 01             	lea    0x1(%eax),%edx
    29a8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    29ab:	89 c2                	mov    %eax,%edx
    29ad:	8b 45 08             	mov    0x8(%ebp),%eax
    29b0:	01 d0                	add    %edx,%eax
    29b2:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    29b5:	8b 45 c8             	mov    -0x38(%ebp),%eax
    29b8:	8d 50 01             	lea    0x1(%eax),%edx
    29bb:	89 55 c8             	mov    %edx,-0x38(%ebp)
    29be:	89 c2                	mov    %eax,%edx
    29c0:	8b 45 08             	mov    0x8(%ebp),%eax
    29c3:	01 d0                	add    %edx,%eax
    29c5:	8b 55 e0             	mov    -0x20(%ebp),%edx
    29c8:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    29ca:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    29d1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    29d5:	8b 55 0c             	mov    0xc(%ebp),%edx
    29d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    29db:	01 d0                	add    %edx,%eax
    29dd:	0f b6 00             	movzbl (%eax),%eax
    29e0:	84 c0                	test   %al,%al
    29e2:	0f 85 14 fe ff ff    	jne    27fc <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    29e8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    29eb:	8d 50 01             	lea    0x1(%eax),%edx
    29ee:	89 55 c8             	mov    %edx,-0x38(%ebp)
    29f1:	89 c2                	mov    %eax,%edx
    29f3:	8b 45 08             	mov    0x8(%ebp),%eax
    29f6:	01 d0                	add    %edx,%eax
    29f8:	c6 00 00             	movb   $0x0,(%eax)
}
    29fb:	90                   	nop
    29fc:	c9                   	leave  
    29fd:	c3                   	ret    
