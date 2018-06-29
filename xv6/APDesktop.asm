
_APDesktop：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <runApp>:
#include "APDesktop.h"

void runApp(void * param)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 38             	sub    $0x38,%esp
    int pid = fork();
       6:	e8 0c 06 00 00       	call   617 <fork>
       b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    char temp[30];
    if (pid == 0)
       e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      12:	75 37                	jne    4b <runApp+0x4b>
    {
        sprintf(temp, "AP%s", (char *)param);
      14:	83 ec 04             	sub    $0x4,%esp
      17:	ff 75 08             	pushl  0x8(%ebp)
      1a:	68 f8 27 00 00       	push   $0x27f8
      1f:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      22:	50                   	push   %eax
      23:	e8 9b 25 00 00       	call   25c3 <sprintf>
      28:	83 c4 10             	add    $0x10,%esp
        char *argv[] = { temp, 0 };
      2b:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      2e:	89 45 cc             	mov    %eax,-0x34(%ebp)
      31:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
        exec(temp, argv);
      38:	83 ec 08             	sub    $0x8,%esp
      3b:	8d 45 cc             	lea    -0x34(%ebp),%eax
      3e:	50                   	push   %eax
      3f:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      42:	50                   	push   %eax
      43:	e8 0f 06 00 00       	call   657 <exec>
      48:	83 c4 10             	add    $0x10,%esp
    }
}
      4b:	90                   	nop
      4c:	c9                   	leave  
      4d:	c3                   	ret    

0000004e <wndProc>:
};



bool wndProc(AHwnd hwnd, AMessage msg)
{
      4e:	55                   	push   %ebp
      4f:	89 e5                	mov    %esp,%ebp
      51:	83 ec 18             	sub    $0x18,%esp
    //printf(1,"desktop processing!\n");
    switch(msg.type)
      54:	8b 45 0c             	mov    0xc(%ebp),%eax
      57:	83 f8 03             	cmp    $0x3,%eax
      5a:	0f 84 a4 00 00 00    	je     104 <wndProc+0xb6>
      60:	83 f8 06             	cmp    $0x6,%eax
      63:	0f 84 ae 00 00 00    	je     117 <wndProc+0xc9>
      69:	83 f8 02             	cmp    $0x2,%eax
      6c:	74 05                	je     73 <wndProc+0x25>
                    runApp("Snack");
                break;
            default:break;
        }
            break;
        default: break;
      6e:	e9 64 02 00 00       	jmp    2d7 <wndProc+0x289>
    //printf(1,"desktop processing!\n");
    switch(msg.type)
    {
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
      73:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      7a:	eb 49                	jmp    c5 <wndProc+0x77>
            {
                int off = j * GRID_W_NUMBER;
      7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
      7f:	c1 e0 04             	shl    $0x4,%eax
      82:	89 45 ec             	mov    %eax,-0x14(%ebp)
                for (int i = 0; i< GRID_W_NUMBER; i++)
      85:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
      8c:	eb 2d                	jmp    bb <wndProc+0x6d>
                    hwnd->Grid[off + i] = desktop_layout[j][i];
      8e:	8b 45 08             	mov    0x8(%ebp),%eax
      91:	8b 40 0c             	mov    0xc(%eax),%eax
      94:	8b 4d ec             	mov    -0x14(%ebp),%ecx
      97:	8b 55 f0             	mov    -0x10(%ebp),%edx
      9a:	01 ca                	add    %ecx,%edx
      9c:	c1 e2 02             	shl    $0x2,%edx
      9f:	01 c2                	add    %eax,%edx
      a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
      a4:	c1 e0 04             	shl    $0x4,%eax
      a7:	89 c1                	mov    %eax,%ecx
      a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
      ac:	01 c8                	add    %ecx,%eax
      ae:	8b 04 85 c0 2f 00 00 	mov    0x2fc0(,%eax,4),%eax
      b5:	89 02                	mov    %eax,(%edx)
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
            {
                int off = j * GRID_W_NUMBER;
                for (int i = 0; i< GRID_W_NUMBER; i++)
      b7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      bb:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
      bf:	7e cd                	jle    8e <wndProc+0x40>
    //printf(1,"desktop processing!\n");
    switch(msg.type)
    {
        case MSG_INIT:
            //init
            for (int j = 0; j < GRID_H_NUMBER; j++)
      c1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      c5:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
      c9:	7e b1                	jle    7c <wndProc+0x2e>
            {
                int off = j * GRID_W_NUMBER;
                for (int i = 0; i< GRID_W_NUMBER; i++)
                    hwnd->Grid[off + i] = desktop_layout[j][i];
            }
            hwnd->pos_x = 3;
      cb:	8b 45 08             	mov    0x8(%ebp),%eax
      ce:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%eax)
            hwnd->pos_y = 3;
      d5:	8b 45 08             	mov    0x8(%ebp),%eax
      d8:	c7 40 1c 03 00 00 00 	movl   $0x3,0x1c(%eax)
            msg.type = MSG_PAINT;
      df:	c7 45 0c 03 00 00 00 	movl   $0x3,0xc(%ebp)
            APSendMessage(hwnd,msg);
      e6:	ff 75 14             	pushl  0x14(%ebp)
      e9:	ff 75 10             	pushl  0x10(%ebp)
      ec:	ff 75 0c             	pushl  0xc(%ebp)
      ef:	ff 75 08             	pushl  0x8(%ebp)
      f2:	e8 94 17 00 00       	call   188b <APSendMessage>
      f7:	83 c4 10             	add    $0x10,%esp
            //setupTimer(hwnd,0,1000);
            return False;
      fa:	b8 00 00 00 00       	mov    $0x0,%eax
      ff:	e9 e7 01 00 00       	jmp    2eb <wndProc+0x29d>
        case MSG_PAINT:
            APGridPaint(hwnd);
     104:	83 ec 0c             	sub    $0xc,%esp
     107:	ff 75 08             	pushl  0x8(%ebp)
     10a:	e8 51 1b 00 00       	call   1c60 <APGridPaint>
     10f:	83 c4 10             	add    $0x10,%esp
            break;
     112:	e9 c0 01 00 00       	jmp    2d7 <wndProc+0x289>
        case MSG_KEY_DOWN:
            //printf(1,"kbd message received!\n");
            switch (msg.param)
     117:	8b 45 10             	mov    0x10(%ebp),%eax
     11a:	83 f8 06             	cmp    $0x6,%eax
     11d:	0f 87 af 01 00 00    	ja     2d2 <wndProc+0x284>
     123:	8b 04 85 04 28 00 00 	mov    0x2804(,%eax,4),%eax
     12a:	ff e0                	jmp    *%eax
        {
            case VK_RIGHT:
                if (hwnd->pos_x < GRID_W_NUMBER - 1 && judgeGridWalkable(hwnd->pos_x + 1,hwnd->pos_y,hwnd))
     12c:	8b 45 08             	mov    0x8(%ebp),%eax
     12f:	8b 40 18             	mov    0x18(%eax),%eax
     132:	83 f8 0e             	cmp    $0xe,%eax
     135:	7f 32                	jg     169 <wndProc+0x11b>
     137:	8b 45 08             	mov    0x8(%ebp),%eax
     13a:	8b 40 1c             	mov    0x1c(%eax),%eax
     13d:	8b 55 08             	mov    0x8(%ebp),%edx
     140:	8b 52 18             	mov    0x18(%edx),%edx
     143:	83 c2 01             	add    $0x1,%edx
     146:	83 ec 04             	sub    $0x4,%esp
     149:	ff 75 08             	pushl  0x8(%ebp)
     14c:	50                   	push   %eax
     14d:	52                   	push   %edx
     14e:	e8 9a 01 00 00       	call   2ed <judgeGridWalkable>
     153:	83 c4 10             	add    $0x10,%esp
     156:	85 c0                	test   %eax,%eax
     158:	74 0f                	je     169 <wndProc+0x11b>
                    hwnd->pos_x++;
     15a:	8b 45 08             	mov    0x8(%ebp),%eax
     15d:	8b 40 18             	mov    0x18(%eax),%eax
     160:	8d 50 01             	lea    0x1(%eax),%edx
     163:	8b 45 08             	mov    0x8(%ebp),%eax
     166:	89 50 18             	mov    %edx,0x18(%eax)
                changePosition(hwnd->pos_x,hwnd->pos_y,1);
     169:	8b 45 08             	mov    0x8(%ebp),%eax
     16c:	8b 50 1c             	mov    0x1c(%eax),%edx
     16f:	8b 45 08             	mov    0x8(%ebp),%eax
     172:	8b 40 18             	mov    0x18(%eax),%eax
     175:	83 ec 04             	sub    $0x4,%esp
     178:	6a 01                	push   $0x1
     17a:	52                   	push   %edx
     17b:	50                   	push   %eax
     17c:	e8 5e 05 00 00       	call   6df <changePosition>
     181:	83 c4 10             	add    $0x10,%esp
                break;
     184:	e9 4d 01 00 00       	jmp    2d6 <wndProc+0x288>
            case VK_LEFT:
                if (hwnd->pos_x > 0 && judgeGridWalkable(hwnd->pos_x - 1 ,hwnd->pos_y,hwnd))
     189:	8b 45 08             	mov    0x8(%ebp),%eax
     18c:	8b 40 18             	mov    0x18(%eax),%eax
     18f:	85 c0                	test   %eax,%eax
     191:	7e 32                	jle    1c5 <wndProc+0x177>
     193:	8b 45 08             	mov    0x8(%ebp),%eax
     196:	8b 40 1c             	mov    0x1c(%eax),%eax
     199:	8b 55 08             	mov    0x8(%ebp),%edx
     19c:	8b 52 18             	mov    0x18(%edx),%edx
     19f:	83 ea 01             	sub    $0x1,%edx
     1a2:	83 ec 04             	sub    $0x4,%esp
     1a5:	ff 75 08             	pushl  0x8(%ebp)
     1a8:	50                   	push   %eax
     1a9:	52                   	push   %edx
     1aa:	e8 3e 01 00 00       	call   2ed <judgeGridWalkable>
     1af:	83 c4 10             	add    $0x10,%esp
     1b2:	85 c0                	test   %eax,%eax
     1b4:	74 0f                	je     1c5 <wndProc+0x177>
                    hwnd->pos_x--;
     1b6:	8b 45 08             	mov    0x8(%ebp),%eax
     1b9:	8b 40 18             	mov    0x18(%eax),%eax
     1bc:	8d 50 ff             	lea    -0x1(%eax),%edx
     1bf:	8b 45 08             	mov    0x8(%ebp),%eax
     1c2:	89 50 18             	mov    %edx,0x18(%eax)
                changePosition(hwnd->pos_x,hwnd->pos_y,0);
     1c5:	8b 45 08             	mov    0x8(%ebp),%eax
     1c8:	8b 50 1c             	mov    0x1c(%eax),%edx
     1cb:	8b 45 08             	mov    0x8(%ebp),%eax
     1ce:	8b 40 18             	mov    0x18(%eax),%eax
     1d1:	83 ec 04             	sub    $0x4,%esp
     1d4:	6a 00                	push   $0x0
     1d6:	52                   	push   %edx
     1d7:	50                   	push   %eax
     1d8:	e8 02 05 00 00       	call   6df <changePosition>
     1dd:	83 c4 10             	add    $0x10,%esp
                break;
     1e0:	e9 f1 00 00 00       	jmp    2d6 <wndProc+0x288>
            case VK_UP:
                if (hwnd->pos_y > 0 && judgeGridWalkable(hwnd->pos_x ,hwnd->pos_y - 1,hwnd))
     1e5:	8b 45 08             	mov    0x8(%ebp),%eax
     1e8:	8b 40 1c             	mov    0x1c(%eax),%eax
     1eb:	85 c0                	test   %eax,%eax
     1ed:	7e 32                	jle    221 <wndProc+0x1d3>
     1ef:	8b 45 08             	mov    0x8(%ebp),%eax
     1f2:	8b 40 1c             	mov    0x1c(%eax),%eax
     1f5:	8d 50 ff             	lea    -0x1(%eax),%edx
     1f8:	8b 45 08             	mov    0x8(%ebp),%eax
     1fb:	8b 40 18             	mov    0x18(%eax),%eax
     1fe:	83 ec 04             	sub    $0x4,%esp
     201:	ff 75 08             	pushl  0x8(%ebp)
     204:	52                   	push   %edx
     205:	50                   	push   %eax
     206:	e8 e2 00 00 00       	call   2ed <judgeGridWalkable>
     20b:	83 c4 10             	add    $0x10,%esp
     20e:	85 c0                	test   %eax,%eax
     210:	74 0f                	je     221 <wndProc+0x1d3>
                    hwnd->pos_y--;
     212:	8b 45 08             	mov    0x8(%ebp),%eax
     215:	8b 40 1c             	mov    0x1c(%eax),%eax
     218:	8d 50 ff             	lea    -0x1(%eax),%edx
     21b:	8b 45 08             	mov    0x8(%ebp),%eax
     21e:	89 50 1c             	mov    %edx,0x1c(%eax)
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
     221:	8b 45 08             	mov    0x8(%ebp),%eax
     224:	8b 50 1c             	mov    0x1c(%eax),%edx
     227:	8b 45 08             	mov    0x8(%ebp),%eax
     22a:	8b 40 18             	mov    0x18(%eax),%eax
     22d:	83 ec 04             	sub    $0x4,%esp
     230:	6a 02                	push   $0x2
     232:	52                   	push   %edx
     233:	50                   	push   %eax
     234:	e8 a6 04 00 00       	call   6df <changePosition>
     239:	83 c4 10             	add    $0x10,%esp
                break;
     23c:	e9 95 00 00 00       	jmp    2d6 <wndProc+0x288>
            case VK_DOWN:
                if (hwnd->pos_y < GRID_H_NUMBER - 1 && judgeGridWalkable(hwnd->pos_x ,hwnd->pos_y + 1,hwnd))
     241:	8b 45 08             	mov    0x8(%ebp),%eax
     244:	8b 40 1c             	mov    0x1c(%eax),%eax
     247:	83 f8 09             	cmp    $0x9,%eax
     24a:	7f 32                	jg     27e <wndProc+0x230>
     24c:	8b 45 08             	mov    0x8(%ebp),%eax
     24f:	8b 40 1c             	mov    0x1c(%eax),%eax
     252:	8d 50 01             	lea    0x1(%eax),%edx
     255:	8b 45 08             	mov    0x8(%ebp),%eax
     258:	8b 40 18             	mov    0x18(%eax),%eax
     25b:	83 ec 04             	sub    $0x4,%esp
     25e:	ff 75 08             	pushl  0x8(%ebp)
     261:	52                   	push   %edx
     262:	50                   	push   %eax
     263:	e8 85 00 00 00       	call   2ed <judgeGridWalkable>
     268:	83 c4 10             	add    $0x10,%esp
     26b:	85 c0                	test   %eax,%eax
     26d:	74 0f                	je     27e <wndProc+0x230>
                    hwnd->pos_y++;
     26f:	8b 45 08             	mov    0x8(%ebp),%eax
     272:	8b 40 1c             	mov    0x1c(%eax),%eax
     275:	8d 50 01             	lea    0x1(%eax),%edx
     278:	8b 45 08             	mov    0x8(%ebp),%eax
     27b:	89 50 1c             	mov    %edx,0x1c(%eax)
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
     27e:	8b 45 08             	mov    0x8(%ebp),%eax
     281:	8b 50 1c             	mov    0x1c(%eax),%edx
     284:	8b 45 08             	mov    0x8(%ebp),%eax
     287:	8b 40 18             	mov    0x18(%eax),%eax
     28a:	83 ec 04             	sub    $0x4,%esp
     28d:	6a 02                	push   $0x2
     28f:	52                   	push   %edx
     290:	50                   	push   %eax
     291:	e8 49 04 00 00       	call   6df <changePosition>
     296:	83 c4 10             	add    $0x10,%esp
                break;
     299:	eb 3b                	jmp    2d6 <wndProc+0x288>
            case VK_ENTER:
                if (hwnd->Grid[hwnd->pos_y * GRID_W_NUMBER + hwnd->pos_x] == GRID_PROGRAM_SNAKE)
     29b:	8b 45 08             	mov    0x8(%ebp),%eax
     29e:	8b 50 0c             	mov    0xc(%eax),%edx
     2a1:	8b 45 08             	mov    0x8(%ebp),%eax
     2a4:	8b 40 1c             	mov    0x1c(%eax),%eax
     2a7:	c1 e0 04             	shl    $0x4,%eax
     2aa:	89 c1                	mov    %eax,%ecx
     2ac:	8b 45 08             	mov    0x8(%ebp),%eax
     2af:	8b 40 18             	mov    0x18(%eax),%eax
     2b2:	01 c8                	add    %ecx,%eax
     2b4:	c1 e0 02             	shl    $0x2,%eax
     2b7:	01 d0                	add    %edx,%eax
     2b9:	8b 00                	mov    (%eax),%eax
     2bb:	83 f8 0a             	cmp    $0xa,%eax
     2be:	75 15                	jne    2d5 <wndProc+0x287>
                    runApp("Snack");
     2c0:	83 ec 0c             	sub    $0xc,%esp
     2c3:	68 fd 27 00 00       	push   $0x27fd
     2c8:	e8 33 fd ff ff       	call   0 <runApp>
     2cd:	83 c4 10             	add    $0x10,%esp
                break;
     2d0:	eb 03                	jmp    2d5 <wndProc+0x287>
            default:break;
     2d2:	90                   	nop
     2d3:	eb 01                	jmp    2d6 <wndProc+0x288>
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
                break;
            case VK_ENTER:
                if (hwnd->Grid[hwnd->pos_y * GRID_W_NUMBER + hwnd->pos_x] == GRID_PROGRAM_SNAKE)
                    runApp("Snack");
                break;
     2d5:	90                   	nop
            default:break;
        }
            break;
     2d6:	90                   	nop
        default: break;
    }
    return APWndProc(hwnd, msg);
     2d7:	ff 75 14             	pushl  0x14(%ebp)
     2da:	ff 75 10             	pushl  0x10(%ebp)
     2dd:	ff 75 0c             	pushl  0xc(%ebp)
     2e0:	ff 75 08             	pushl  0x8(%ebp)
     2e3:	e8 27 18 00 00       	call   1b0f <APWndProc>
     2e8:	83 c4 10             	add    $0x10,%esp
}
     2eb:	c9                   	leave  
     2ec:	c3                   	ret    

000002ed <judgeGridWalkable>:

int judgeGridWalkable(int x,int y, AHwnd hwnd)
{
     2ed:	55                   	push   %ebp
     2ee:	89 e5                	mov    %esp,%ebp
     2f0:	83 ec 10             	sub    $0x10,%esp
    if (hwnd->is_grid)
     2f3:	8b 45 10             	mov    0x10(%ebp),%eax
     2f6:	8b 40 08             	mov    0x8(%eax),%eax
     2f9:	85 c0                	test   %eax,%eax
     2fb:	0f 84 80 00 00 00    	je     381 <judgeGridWalkable+0x94>
    {
        int index = hwnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER + y * GRID_W_NUMBER + x;
     301:	8b 45 10             	mov    0x10(%ebp),%eax
     304:	8b 50 14             	mov    0x14(%eax),%edx
     307:	89 d0                	mov    %edx,%eax
     309:	c1 e0 02             	shl    $0x2,%eax
     30c:	01 d0                	add    %edx,%eax
     30e:	01 c0                	add    %eax,%eax
     310:	01 c2                	add    %eax,%edx
     312:	8b 45 0c             	mov    0xc(%ebp),%eax
     315:	01 d0                	add    %edx,%eax
     317:	c1 e0 04             	shl    $0x4,%eax
     31a:	89 c2                	mov    %eax,%edx
     31c:	8b 45 08             	mov    0x8(%ebp),%eax
     31f:	01 d0                	add    %edx,%eax
     321:	89 45 fc             	mov    %eax,-0x4(%ebp)
        switch(hwnd->Grid[index])
     324:	8b 45 10             	mov    0x10(%ebp),%eax
     327:	8b 40 0c             	mov    0xc(%eax),%eax
     32a:	8b 55 fc             	mov    -0x4(%ebp),%edx
     32d:	c1 e2 02             	shl    $0x2,%edx
     330:	01 d0                	add    %edx,%eax
     332:	8b 00                	mov    (%eax),%eax
     334:	83 f8 07             	cmp    $0x7,%eax
     337:	77 41                	ja     37a <judgeGridWalkable+0x8d>
     339:	8b 04 85 20 28 00 00 	mov    0x2820(,%eax,4),%eax
     340:	ff e0                	jmp    *%eax
        {
                
            case GRID_WALL : return 0;
     342:	b8 00 00 00 00       	mov    $0x0,%eax
     347:	eb 3d                	jmp    386 <judgeGridWalkable+0x99>
            case GRID_ROAD : return 1;
     349:	b8 01 00 00 00       	mov    $0x1,%eax
     34e:	eb 36                	jmp    386 <judgeGridWalkable+0x99>
            case GRID_GRASS : return 1;
     350:	b8 01 00 00 00       	mov    $0x1,%eax
     355:	eb 2f                	jmp    386 <judgeGridWalkable+0x99>
            case GRID_RIVER : return 0;
     357:	b8 00 00 00 00       	mov    $0x0,%eax
     35c:	eb 28                	jmp    386 <judgeGridWalkable+0x99>
            case GRID_FOREST: return 0;
     35e:	b8 00 00 00 00       	mov    $0x0,%eax
     363:	eb 21                	jmp    386 <judgeGridWalkable+0x99>
            case GRID_STONE: return 1;
     365:	b8 01 00 00 00       	mov    $0x1,%eax
     36a:	eb 1a                	jmp    386 <judgeGridWalkable+0x99>
            case GRID_MOUNTAIN: return 0;
     36c:	b8 00 00 00 00       	mov    $0x0,%eax
     371:	eb 13                	jmp    386 <judgeGridWalkable+0x99>
            case GRID_LAKE: return 0;
     373:	b8 00 00 00 00       	mov    $0x0,%eax
     378:	eb 0c                	jmp    386 <judgeGridWalkable+0x99>
            default: return 1;
     37a:	b8 01 00 00 00       	mov    $0x1,%eax
     37f:	eb 05                	jmp    386 <judgeGridWalkable+0x99>
        }
    }
    return 0;
     381:	b8 00 00 00 00       	mov    $0x0,%eax
}
     386:	c9                   	leave  
     387:	c3                   	ret    

00000388 <main>:

int main(void)
{
     388:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     38c:	83 e4 f0             	and    $0xfffffff0,%esp
     38f:	ff 71 fc             	pushl  -0x4(%ecx)
     392:	55                   	push   %ebp
     393:	89 e5                	mov    %esp,%ebp
     395:	51                   	push   %ecx
     396:	83 ec 14             	sub    $0x14,%esp
    //runApp("MagicTower");
    AHwnd hwnd = APCreateWindow("desktop",True,3);
     399:	83 ec 04             	sub    $0x4,%esp
     39c:	6a 03                	push   $0x3
     39e:	6a 01                	push   $0x1
     3a0:	68 40 28 00 00       	push   $0x2840
     3a5:	e8 ff 14 00 00       	call   18a9 <APCreateWindow>
     3aa:	83 c4 10             	add    $0x10,%esp
     3ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
   //printf(1,"desktop initialized!\n");
    APWndExec(hwnd, wndProc);
     3b0:	83 ec 08             	sub    $0x8,%esp
     3b3:	68 4e 00 00 00       	push   $0x4e
     3b8:	ff 75 f4             	pushl  -0xc(%ebp)
     3bb:	e8 0b 18 00 00       	call   1bcb <APWndExec>
     3c0:	83 c4 10             	add    $0x10,%esp
    exit();
     3c3:	e8 57 02 00 00       	call   61f <exit>

000003c8 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     3c8:	55                   	push   %ebp
     3c9:	89 e5                	mov    %esp,%ebp
     3cb:	57                   	push   %edi
     3cc:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     3cd:	8b 4d 08             	mov    0x8(%ebp),%ecx
     3d0:	8b 55 10             	mov    0x10(%ebp),%edx
     3d3:	8b 45 0c             	mov    0xc(%ebp),%eax
     3d6:	89 cb                	mov    %ecx,%ebx
     3d8:	89 df                	mov    %ebx,%edi
     3da:	89 d1                	mov    %edx,%ecx
     3dc:	fc                   	cld    
     3dd:	f3 aa                	rep stos %al,%es:(%edi)
     3df:	89 ca                	mov    %ecx,%edx
     3e1:	89 fb                	mov    %edi,%ebx
     3e3:	89 5d 08             	mov    %ebx,0x8(%ebp)
     3e6:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     3e9:	90                   	nop
     3ea:	5b                   	pop    %ebx
     3eb:	5f                   	pop    %edi
     3ec:	5d                   	pop    %ebp
     3ed:	c3                   	ret    

000003ee <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     3ee:	55                   	push   %ebp
     3ef:	89 e5                	mov    %esp,%ebp
     3f1:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     3f4:	8b 45 08             	mov    0x8(%ebp),%eax
     3f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     3fa:	90                   	nop
     3fb:	8b 45 08             	mov    0x8(%ebp),%eax
     3fe:	8d 50 01             	lea    0x1(%eax),%edx
     401:	89 55 08             	mov    %edx,0x8(%ebp)
     404:	8b 55 0c             	mov    0xc(%ebp),%edx
     407:	8d 4a 01             	lea    0x1(%edx),%ecx
     40a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     40d:	0f b6 12             	movzbl (%edx),%edx
     410:	88 10                	mov    %dl,(%eax)
     412:	0f b6 00             	movzbl (%eax),%eax
     415:	84 c0                	test   %al,%al
     417:	75 e2                	jne    3fb <strcpy+0xd>
    ;
  return os;
     419:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     41c:	c9                   	leave  
     41d:	c3                   	ret    

0000041e <strcmp>:

int
strcmp(const char *p, const char *q)
{
     41e:	55                   	push   %ebp
     41f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     421:	eb 08                	jmp    42b <strcmp+0xd>
    p++, q++;
     423:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     427:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     42b:	8b 45 08             	mov    0x8(%ebp),%eax
     42e:	0f b6 00             	movzbl (%eax),%eax
     431:	84 c0                	test   %al,%al
     433:	74 10                	je     445 <strcmp+0x27>
     435:	8b 45 08             	mov    0x8(%ebp),%eax
     438:	0f b6 10             	movzbl (%eax),%edx
     43b:	8b 45 0c             	mov    0xc(%ebp),%eax
     43e:	0f b6 00             	movzbl (%eax),%eax
     441:	38 c2                	cmp    %al,%dl
     443:	74 de                	je     423 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     445:	8b 45 08             	mov    0x8(%ebp),%eax
     448:	0f b6 00             	movzbl (%eax),%eax
     44b:	0f b6 d0             	movzbl %al,%edx
     44e:	8b 45 0c             	mov    0xc(%ebp),%eax
     451:	0f b6 00             	movzbl (%eax),%eax
     454:	0f b6 c0             	movzbl %al,%eax
     457:	29 c2                	sub    %eax,%edx
     459:	89 d0                	mov    %edx,%eax
}
     45b:	5d                   	pop    %ebp
     45c:	c3                   	ret    

0000045d <strlen>:

uint
strlen(char *s)
{
     45d:	55                   	push   %ebp
     45e:	89 e5                	mov    %esp,%ebp
     460:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     463:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     46a:	eb 04                	jmp    470 <strlen+0x13>
     46c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     470:	8b 55 fc             	mov    -0x4(%ebp),%edx
     473:	8b 45 08             	mov    0x8(%ebp),%eax
     476:	01 d0                	add    %edx,%eax
     478:	0f b6 00             	movzbl (%eax),%eax
     47b:	84 c0                	test   %al,%al
     47d:	75 ed                	jne    46c <strlen+0xf>
    ;
  return n;
     47f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     482:	c9                   	leave  
     483:	c3                   	ret    

00000484 <memset>:

void*
memset(void *dst, int c, uint n)
{
     484:	55                   	push   %ebp
     485:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     487:	8b 45 10             	mov    0x10(%ebp),%eax
     48a:	50                   	push   %eax
     48b:	ff 75 0c             	pushl  0xc(%ebp)
     48e:	ff 75 08             	pushl  0x8(%ebp)
     491:	e8 32 ff ff ff       	call   3c8 <stosb>
     496:	83 c4 0c             	add    $0xc,%esp
  return dst;
     499:	8b 45 08             	mov    0x8(%ebp),%eax
}
     49c:	c9                   	leave  
     49d:	c3                   	ret    

0000049e <strchr>:

char*
strchr(const char *s, char c)
{
     49e:	55                   	push   %ebp
     49f:	89 e5                	mov    %esp,%ebp
     4a1:	83 ec 04             	sub    $0x4,%esp
     4a4:	8b 45 0c             	mov    0xc(%ebp),%eax
     4a7:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     4aa:	eb 14                	jmp    4c0 <strchr+0x22>
    if(*s == c)
     4ac:	8b 45 08             	mov    0x8(%ebp),%eax
     4af:	0f b6 00             	movzbl (%eax),%eax
     4b2:	3a 45 fc             	cmp    -0x4(%ebp),%al
     4b5:	75 05                	jne    4bc <strchr+0x1e>
      return (char*)s;
     4b7:	8b 45 08             	mov    0x8(%ebp),%eax
     4ba:	eb 13                	jmp    4cf <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     4bc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     4c0:	8b 45 08             	mov    0x8(%ebp),%eax
     4c3:	0f b6 00             	movzbl (%eax),%eax
     4c6:	84 c0                	test   %al,%al
     4c8:	75 e2                	jne    4ac <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     4ca:	b8 00 00 00 00       	mov    $0x0,%eax
}
     4cf:	c9                   	leave  
     4d0:	c3                   	ret    

000004d1 <gets>:

char*
gets(char *buf, int max)
{
     4d1:	55                   	push   %ebp
     4d2:	89 e5                	mov    %esp,%ebp
     4d4:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     4d7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4de:	eb 42                	jmp    522 <gets+0x51>
    cc = read(0, &c, 1);
     4e0:	83 ec 04             	sub    $0x4,%esp
     4e3:	6a 01                	push   $0x1
     4e5:	8d 45 ef             	lea    -0x11(%ebp),%eax
     4e8:	50                   	push   %eax
     4e9:	6a 00                	push   $0x0
     4eb:	e8 47 01 00 00       	call   637 <read>
     4f0:	83 c4 10             	add    $0x10,%esp
     4f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     4f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4fa:	7e 33                	jle    52f <gets+0x5e>
      break;
    buf[i++] = c;
     4fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4ff:	8d 50 01             	lea    0x1(%eax),%edx
     502:	89 55 f4             	mov    %edx,-0xc(%ebp)
     505:	89 c2                	mov    %eax,%edx
     507:	8b 45 08             	mov    0x8(%ebp),%eax
     50a:	01 c2                	add    %eax,%edx
     50c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     510:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     512:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     516:	3c 0a                	cmp    $0xa,%al
     518:	74 16                	je     530 <gets+0x5f>
     51a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     51e:	3c 0d                	cmp    $0xd,%al
     520:	74 0e                	je     530 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     522:	8b 45 f4             	mov    -0xc(%ebp),%eax
     525:	83 c0 01             	add    $0x1,%eax
     528:	3b 45 0c             	cmp    0xc(%ebp),%eax
     52b:	7c b3                	jl     4e0 <gets+0xf>
     52d:	eb 01                	jmp    530 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     52f:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     530:	8b 55 f4             	mov    -0xc(%ebp),%edx
     533:	8b 45 08             	mov    0x8(%ebp),%eax
     536:	01 d0                	add    %edx,%eax
     538:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     53b:	8b 45 08             	mov    0x8(%ebp),%eax
}
     53e:	c9                   	leave  
     53f:	c3                   	ret    

00000540 <stat>:

int
stat(char *n, struct stat *st)
{
     540:	55                   	push   %ebp
     541:	89 e5                	mov    %esp,%ebp
     543:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     546:	83 ec 08             	sub    $0x8,%esp
     549:	6a 00                	push   $0x0
     54b:	ff 75 08             	pushl  0x8(%ebp)
     54e:	e8 0c 01 00 00       	call   65f <open>
     553:	83 c4 10             	add    $0x10,%esp
     556:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     559:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     55d:	79 07                	jns    566 <stat+0x26>
    return -1;
     55f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     564:	eb 25                	jmp    58b <stat+0x4b>
  r = fstat(fd, st);
     566:	83 ec 08             	sub    $0x8,%esp
     569:	ff 75 0c             	pushl  0xc(%ebp)
     56c:	ff 75 f4             	pushl  -0xc(%ebp)
     56f:	e8 03 01 00 00       	call   677 <fstat>
     574:	83 c4 10             	add    $0x10,%esp
     577:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     57a:	83 ec 0c             	sub    $0xc,%esp
     57d:	ff 75 f4             	pushl  -0xc(%ebp)
     580:	e8 c2 00 00 00       	call   647 <close>
     585:	83 c4 10             	add    $0x10,%esp
  return r;
     588:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     58b:	c9                   	leave  
     58c:	c3                   	ret    

0000058d <atoi>:

int
atoi(const char *s)
{
     58d:	55                   	push   %ebp
     58e:	89 e5                	mov    %esp,%ebp
     590:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     593:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     59a:	eb 25                	jmp    5c1 <atoi+0x34>
    n = n*10 + *s++ - '0';
     59c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     59f:	89 d0                	mov    %edx,%eax
     5a1:	c1 e0 02             	shl    $0x2,%eax
     5a4:	01 d0                	add    %edx,%eax
     5a6:	01 c0                	add    %eax,%eax
     5a8:	89 c1                	mov    %eax,%ecx
     5aa:	8b 45 08             	mov    0x8(%ebp),%eax
     5ad:	8d 50 01             	lea    0x1(%eax),%edx
     5b0:	89 55 08             	mov    %edx,0x8(%ebp)
     5b3:	0f b6 00             	movzbl (%eax),%eax
     5b6:	0f be c0             	movsbl %al,%eax
     5b9:	01 c8                	add    %ecx,%eax
     5bb:	83 e8 30             	sub    $0x30,%eax
     5be:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     5c1:	8b 45 08             	mov    0x8(%ebp),%eax
     5c4:	0f b6 00             	movzbl (%eax),%eax
     5c7:	3c 2f                	cmp    $0x2f,%al
     5c9:	7e 0a                	jle    5d5 <atoi+0x48>
     5cb:	8b 45 08             	mov    0x8(%ebp),%eax
     5ce:	0f b6 00             	movzbl (%eax),%eax
     5d1:	3c 39                	cmp    $0x39,%al
     5d3:	7e c7                	jle    59c <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     5d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     5d8:	c9                   	leave  
     5d9:	c3                   	ret    

000005da <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     5da:	55                   	push   %ebp
     5db:	89 e5                	mov    %esp,%ebp
     5dd:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     5e0:	8b 45 08             	mov    0x8(%ebp),%eax
     5e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     5e6:	8b 45 0c             	mov    0xc(%ebp),%eax
     5e9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     5ec:	eb 17                	jmp    605 <memmove+0x2b>
    *dst++ = *src++;
     5ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5f1:	8d 50 01             	lea    0x1(%eax),%edx
     5f4:	89 55 fc             	mov    %edx,-0x4(%ebp)
     5f7:	8b 55 f8             	mov    -0x8(%ebp),%edx
     5fa:	8d 4a 01             	lea    0x1(%edx),%ecx
     5fd:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     600:	0f b6 12             	movzbl (%edx),%edx
     603:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     605:	8b 45 10             	mov    0x10(%ebp),%eax
     608:	8d 50 ff             	lea    -0x1(%eax),%edx
     60b:	89 55 10             	mov    %edx,0x10(%ebp)
     60e:	85 c0                	test   %eax,%eax
     610:	7f dc                	jg     5ee <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     612:	8b 45 08             	mov    0x8(%ebp),%eax
}
     615:	c9                   	leave  
     616:	c3                   	ret    

00000617 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     617:	b8 01 00 00 00       	mov    $0x1,%eax
     61c:	cd 40                	int    $0x40
     61e:	c3                   	ret    

0000061f <exit>:
SYSCALL(exit)
     61f:	b8 02 00 00 00       	mov    $0x2,%eax
     624:	cd 40                	int    $0x40
     626:	c3                   	ret    

00000627 <wait>:
SYSCALL(wait)
     627:	b8 03 00 00 00       	mov    $0x3,%eax
     62c:	cd 40                	int    $0x40
     62e:	c3                   	ret    

0000062f <pipe>:
SYSCALL(pipe)
     62f:	b8 04 00 00 00       	mov    $0x4,%eax
     634:	cd 40                	int    $0x40
     636:	c3                   	ret    

00000637 <read>:
SYSCALL(read)
     637:	b8 05 00 00 00       	mov    $0x5,%eax
     63c:	cd 40                	int    $0x40
     63e:	c3                   	ret    

0000063f <write>:
SYSCALL(write)
     63f:	b8 10 00 00 00       	mov    $0x10,%eax
     644:	cd 40                	int    $0x40
     646:	c3                   	ret    

00000647 <close>:
SYSCALL(close)
     647:	b8 15 00 00 00       	mov    $0x15,%eax
     64c:	cd 40                	int    $0x40
     64e:	c3                   	ret    

0000064f <kill>:
SYSCALL(kill)
     64f:	b8 06 00 00 00       	mov    $0x6,%eax
     654:	cd 40                	int    $0x40
     656:	c3                   	ret    

00000657 <exec>:
SYSCALL(exec)
     657:	b8 07 00 00 00       	mov    $0x7,%eax
     65c:	cd 40                	int    $0x40
     65e:	c3                   	ret    

0000065f <open>:
SYSCALL(open)
     65f:	b8 0f 00 00 00       	mov    $0xf,%eax
     664:	cd 40                	int    $0x40
     666:	c3                   	ret    

00000667 <mknod>:
SYSCALL(mknod)
     667:	b8 11 00 00 00       	mov    $0x11,%eax
     66c:	cd 40                	int    $0x40
     66e:	c3                   	ret    

0000066f <unlink>:
SYSCALL(unlink)
     66f:	b8 12 00 00 00       	mov    $0x12,%eax
     674:	cd 40                	int    $0x40
     676:	c3                   	ret    

00000677 <fstat>:
SYSCALL(fstat)
     677:	b8 08 00 00 00       	mov    $0x8,%eax
     67c:	cd 40                	int    $0x40
     67e:	c3                   	ret    

0000067f <link>:
SYSCALL(link)
     67f:	b8 13 00 00 00       	mov    $0x13,%eax
     684:	cd 40                	int    $0x40
     686:	c3                   	ret    

00000687 <mkdir>:
SYSCALL(mkdir)
     687:	b8 14 00 00 00       	mov    $0x14,%eax
     68c:	cd 40                	int    $0x40
     68e:	c3                   	ret    

0000068f <chdir>:
SYSCALL(chdir)
     68f:	b8 09 00 00 00       	mov    $0x9,%eax
     694:	cd 40                	int    $0x40
     696:	c3                   	ret    

00000697 <dup>:
SYSCALL(dup)
     697:	b8 0a 00 00 00       	mov    $0xa,%eax
     69c:	cd 40                	int    $0x40
     69e:	c3                   	ret    

0000069f <getpid>:
SYSCALL(getpid)
     69f:	b8 0b 00 00 00       	mov    $0xb,%eax
     6a4:	cd 40                	int    $0x40
     6a6:	c3                   	ret    

000006a7 <sbrk>:
SYSCALL(sbrk)
     6a7:	b8 0c 00 00 00       	mov    $0xc,%eax
     6ac:	cd 40                	int    $0x40
     6ae:	c3                   	ret    

000006af <sleep>:
SYSCALL(sleep)
     6af:	b8 0d 00 00 00       	mov    $0xd,%eax
     6b4:	cd 40                	int    $0x40
     6b6:	c3                   	ret    

000006b7 <uptime>:
SYSCALL(uptime)
     6b7:	b8 0e 00 00 00       	mov    $0xe,%eax
     6bc:	cd 40                	int    $0x40
     6be:	c3                   	ret    

000006bf <paintWindow>:

SYSCALL(paintWindow)
     6bf:	b8 16 00 00 00       	mov    $0x16,%eax
     6c4:	cd 40                	int    $0x40
     6c6:	c3                   	ret    

000006c7 <sendMessage>:
SYSCALL(sendMessage)
     6c7:	b8 17 00 00 00       	mov    $0x17,%eax
     6cc:	cd 40                	int    $0x40
     6ce:	c3                   	ret    

000006cf <getMessage>:
SYSCALL(getMessage)
     6cf:	b8 19 00 00 00       	mov    $0x19,%eax
     6d4:	cd 40                	int    $0x40
     6d6:	c3                   	ret    

000006d7 <registWindow>:
SYSCALL(registWindow)
     6d7:	b8 18 00 00 00       	mov    $0x18,%eax
     6dc:	cd 40                	int    $0x40
     6de:	c3                   	ret    

000006df <changePosition>:
SYSCALL(changePosition)
     6df:	b8 1a 00 00 00       	mov    $0x1a,%eax
     6e4:	cd 40                	int    $0x40
     6e6:	c3                   	ret    

000006e7 <setupTimer>:
SYSCALL(setupTimer)
     6e7:	b8 1b 00 00 00       	mov    $0x1b,%eax
     6ec:	cd 40                	int    $0x40
     6ee:	c3                   	ret    

000006ef <deleteTimer>:
SYSCALL(deleteTimer)
     6ef:	b8 1c 00 00 00       	mov    $0x1c,%eax
     6f4:	cd 40                	int    $0x40
     6f6:	c3                   	ret    

000006f7 <getCurrentTime>:
SYSCALL(getCurrentTime)
     6f7:	b8 1d 00 00 00       	mov    $0x1d,%eax
     6fc:	cd 40                	int    $0x40
     6fe:	c3                   	ret    

000006ff <removeWindow>:
SYSCALL(removeWindow)
     6ff:	b8 1e 00 00 00       	mov    $0x1e,%eax
     704:	cd 40                	int    $0x40
     706:	c3                   	ret    

00000707 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     707:	55                   	push   %ebp
     708:	89 e5                	mov    %esp,%ebp
     70a:	83 ec 18             	sub    $0x18,%esp
     70d:	8b 45 0c             	mov    0xc(%ebp),%eax
     710:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     713:	83 ec 04             	sub    $0x4,%esp
     716:	6a 01                	push   $0x1
     718:	8d 45 f4             	lea    -0xc(%ebp),%eax
     71b:	50                   	push   %eax
     71c:	ff 75 08             	pushl  0x8(%ebp)
     71f:	e8 1b ff ff ff       	call   63f <write>
     724:	83 c4 10             	add    $0x10,%esp
}
     727:	90                   	nop
     728:	c9                   	leave  
     729:	c3                   	ret    

0000072a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     72a:	55                   	push   %ebp
     72b:	89 e5                	mov    %esp,%ebp
     72d:	53                   	push   %ebx
     72e:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     731:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     738:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     73c:	74 17                	je     755 <printint+0x2b>
     73e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     742:	79 11                	jns    755 <printint+0x2b>
    neg = 1;
     744:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     74b:	8b 45 0c             	mov    0xc(%ebp),%eax
     74e:	f7 d8                	neg    %eax
     750:	89 45 ec             	mov    %eax,-0x14(%ebp)
     753:	eb 06                	jmp    75b <printint+0x31>
  } else {
    x = xx;
     755:	8b 45 0c             	mov    0xc(%ebp),%eax
     758:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     75b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     762:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     765:	8d 41 01             	lea    0x1(%ecx),%eax
     768:	89 45 f4             	mov    %eax,-0xc(%ebp)
     76b:	8b 5d 10             	mov    0x10(%ebp),%ebx
     76e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     771:	ba 00 00 00 00       	mov    $0x0,%edx
     776:	f7 f3                	div    %ebx
     778:	89 d0                	mov    %edx,%eax
     77a:	0f b6 80 80 32 00 00 	movzbl 0x3280(%eax),%eax
     781:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     785:	8b 5d 10             	mov    0x10(%ebp),%ebx
     788:	8b 45 ec             	mov    -0x14(%ebp),%eax
     78b:	ba 00 00 00 00       	mov    $0x0,%edx
     790:	f7 f3                	div    %ebx
     792:	89 45 ec             	mov    %eax,-0x14(%ebp)
     795:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     799:	75 c7                	jne    762 <printint+0x38>
  if(neg)
     79b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     79f:	74 2d                	je     7ce <printint+0xa4>
    buf[i++] = '-';
     7a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a4:	8d 50 01             	lea    0x1(%eax),%edx
     7a7:	89 55 f4             	mov    %edx,-0xc(%ebp)
     7aa:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     7af:	eb 1d                	jmp    7ce <printint+0xa4>
    putc(fd, buf[i]);
     7b1:	8d 55 dc             	lea    -0x24(%ebp),%edx
     7b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b7:	01 d0                	add    %edx,%eax
     7b9:	0f b6 00             	movzbl (%eax),%eax
     7bc:	0f be c0             	movsbl %al,%eax
     7bf:	83 ec 08             	sub    $0x8,%esp
     7c2:	50                   	push   %eax
     7c3:	ff 75 08             	pushl  0x8(%ebp)
     7c6:	e8 3c ff ff ff       	call   707 <putc>
     7cb:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     7ce:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     7d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7d6:	79 d9                	jns    7b1 <printint+0x87>
    putc(fd, buf[i]);
}
     7d8:	90                   	nop
     7d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7dc:	c9                   	leave  
     7dd:	c3                   	ret    

000007de <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     7de:	55                   	push   %ebp
     7df:	89 e5                	mov    %esp,%ebp
     7e1:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     7e4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     7eb:	8d 45 0c             	lea    0xc(%ebp),%eax
     7ee:	83 c0 04             	add    $0x4,%eax
     7f1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     7f4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     7fb:	e9 59 01 00 00       	jmp    959 <printf+0x17b>
    c = fmt[i] & 0xff;
     800:	8b 55 0c             	mov    0xc(%ebp),%edx
     803:	8b 45 f0             	mov    -0x10(%ebp),%eax
     806:	01 d0                	add    %edx,%eax
     808:	0f b6 00             	movzbl (%eax),%eax
     80b:	0f be c0             	movsbl %al,%eax
     80e:	25 ff 00 00 00       	and    $0xff,%eax
     813:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     816:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     81a:	75 2c                	jne    848 <printf+0x6a>
      if(c == '%'){
     81c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     820:	75 0c                	jne    82e <printf+0x50>
        state = '%';
     822:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     829:	e9 27 01 00 00       	jmp    955 <printf+0x177>
      } else {
        putc(fd, c);
     82e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     831:	0f be c0             	movsbl %al,%eax
     834:	83 ec 08             	sub    $0x8,%esp
     837:	50                   	push   %eax
     838:	ff 75 08             	pushl  0x8(%ebp)
     83b:	e8 c7 fe ff ff       	call   707 <putc>
     840:	83 c4 10             	add    $0x10,%esp
     843:	e9 0d 01 00 00       	jmp    955 <printf+0x177>
      }
    } else if(state == '%'){
     848:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     84c:	0f 85 03 01 00 00    	jne    955 <printf+0x177>
      if(c == 'd'){
     852:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     856:	75 1e                	jne    876 <printf+0x98>
        printint(fd, *ap, 10, 1);
     858:	8b 45 e8             	mov    -0x18(%ebp),%eax
     85b:	8b 00                	mov    (%eax),%eax
     85d:	6a 01                	push   $0x1
     85f:	6a 0a                	push   $0xa
     861:	50                   	push   %eax
     862:	ff 75 08             	pushl  0x8(%ebp)
     865:	e8 c0 fe ff ff       	call   72a <printint>
     86a:	83 c4 10             	add    $0x10,%esp
        ap++;
     86d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     871:	e9 d8 00 00 00       	jmp    94e <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     876:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     87a:	74 06                	je     882 <printf+0xa4>
     87c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     880:	75 1e                	jne    8a0 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     882:	8b 45 e8             	mov    -0x18(%ebp),%eax
     885:	8b 00                	mov    (%eax),%eax
     887:	6a 00                	push   $0x0
     889:	6a 10                	push   $0x10
     88b:	50                   	push   %eax
     88c:	ff 75 08             	pushl  0x8(%ebp)
     88f:	e8 96 fe ff ff       	call   72a <printint>
     894:	83 c4 10             	add    $0x10,%esp
        ap++;
     897:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     89b:	e9 ae 00 00 00       	jmp    94e <printf+0x170>
      } else if(c == 's'){
     8a0:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     8a4:	75 43                	jne    8e9 <printf+0x10b>
        s = (char*)*ap;
     8a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     8a9:	8b 00                	mov    (%eax),%eax
     8ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     8ae:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     8b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8b6:	75 25                	jne    8dd <printf+0xff>
          s = "(null)";
     8b8:	c7 45 f4 48 28 00 00 	movl   $0x2848,-0xc(%ebp)
        while(*s != 0){
     8bf:	eb 1c                	jmp    8dd <printf+0xff>
          putc(fd, *s);
     8c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8c4:	0f b6 00             	movzbl (%eax),%eax
     8c7:	0f be c0             	movsbl %al,%eax
     8ca:	83 ec 08             	sub    $0x8,%esp
     8cd:	50                   	push   %eax
     8ce:	ff 75 08             	pushl  0x8(%ebp)
     8d1:	e8 31 fe ff ff       	call   707 <putc>
     8d6:	83 c4 10             	add    $0x10,%esp
          s++;
     8d9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     8dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8e0:	0f b6 00             	movzbl (%eax),%eax
     8e3:	84 c0                	test   %al,%al
     8e5:	75 da                	jne    8c1 <printf+0xe3>
     8e7:	eb 65                	jmp    94e <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     8e9:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     8ed:	75 1d                	jne    90c <printf+0x12e>
        putc(fd, *ap);
     8ef:	8b 45 e8             	mov    -0x18(%ebp),%eax
     8f2:	8b 00                	mov    (%eax),%eax
     8f4:	0f be c0             	movsbl %al,%eax
     8f7:	83 ec 08             	sub    $0x8,%esp
     8fa:	50                   	push   %eax
     8fb:	ff 75 08             	pushl  0x8(%ebp)
     8fe:	e8 04 fe ff ff       	call   707 <putc>
     903:	83 c4 10             	add    $0x10,%esp
        ap++;
     906:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     90a:	eb 42                	jmp    94e <printf+0x170>
      } else if(c == '%'){
     90c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     910:	75 17                	jne    929 <printf+0x14b>
        putc(fd, c);
     912:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     915:	0f be c0             	movsbl %al,%eax
     918:	83 ec 08             	sub    $0x8,%esp
     91b:	50                   	push   %eax
     91c:	ff 75 08             	pushl  0x8(%ebp)
     91f:	e8 e3 fd ff ff       	call   707 <putc>
     924:	83 c4 10             	add    $0x10,%esp
     927:	eb 25                	jmp    94e <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     929:	83 ec 08             	sub    $0x8,%esp
     92c:	6a 25                	push   $0x25
     92e:	ff 75 08             	pushl  0x8(%ebp)
     931:	e8 d1 fd ff ff       	call   707 <putc>
     936:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     939:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     93c:	0f be c0             	movsbl %al,%eax
     93f:	83 ec 08             	sub    $0x8,%esp
     942:	50                   	push   %eax
     943:	ff 75 08             	pushl  0x8(%ebp)
     946:	e8 bc fd ff ff       	call   707 <putc>
     94b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     94e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     955:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     959:	8b 55 0c             	mov    0xc(%ebp),%edx
     95c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     95f:	01 d0                	add    %edx,%eax
     961:	0f b6 00             	movzbl (%eax),%eax
     964:	84 c0                	test   %al,%al
     966:	0f 85 94 fe ff ff    	jne    800 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     96c:	90                   	nop
     96d:	c9                   	leave  
     96e:	c3                   	ret    

0000096f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     96f:	55                   	push   %ebp
     970:	89 e5                	mov    %esp,%ebp
     972:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     975:	8b 45 08             	mov    0x8(%ebp),%eax
     978:	83 e8 08             	sub    $0x8,%eax
     97b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     97e:	a1 e0 6e 00 00       	mov    0x6ee0,%eax
     983:	89 45 fc             	mov    %eax,-0x4(%ebp)
     986:	eb 24                	jmp    9ac <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     988:	8b 45 fc             	mov    -0x4(%ebp),%eax
     98b:	8b 00                	mov    (%eax),%eax
     98d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     990:	77 12                	ja     9a4 <free+0x35>
     992:	8b 45 f8             	mov    -0x8(%ebp),%eax
     995:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     998:	77 24                	ja     9be <free+0x4f>
     99a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     99d:	8b 00                	mov    (%eax),%eax
     99f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     9a2:	77 1a                	ja     9be <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     9a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a7:	8b 00                	mov    (%eax),%eax
     9a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
     9ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9af:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     9b2:	76 d4                	jbe    988 <free+0x19>
     9b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9b7:	8b 00                	mov    (%eax),%eax
     9b9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     9bc:	76 ca                	jbe    988 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     9be:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9c1:	8b 40 04             	mov    0x4(%eax),%eax
     9c4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     9cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9ce:	01 c2                	add    %eax,%edx
     9d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9d3:	8b 00                	mov    (%eax),%eax
     9d5:	39 c2                	cmp    %eax,%edx
     9d7:	75 24                	jne    9fd <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     9d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9dc:	8b 50 04             	mov    0x4(%eax),%edx
     9df:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9e2:	8b 00                	mov    (%eax),%eax
     9e4:	8b 40 04             	mov    0x4(%eax),%eax
     9e7:	01 c2                	add    %eax,%edx
     9e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9ec:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     9ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9f2:	8b 00                	mov    (%eax),%eax
     9f4:	8b 10                	mov    (%eax),%edx
     9f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9f9:	89 10                	mov    %edx,(%eax)
     9fb:	eb 0a                	jmp    a07 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     9fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a00:	8b 10                	mov    (%eax),%edx
     a02:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a05:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     a07:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a0a:	8b 40 04             	mov    0x4(%eax),%eax
     a0d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     a14:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a17:	01 d0                	add    %edx,%eax
     a19:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     a1c:	75 20                	jne    a3e <free+0xcf>
    p->s.size += bp->s.size;
     a1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a21:	8b 50 04             	mov    0x4(%eax),%edx
     a24:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a27:	8b 40 04             	mov    0x4(%eax),%eax
     a2a:	01 c2                	add    %eax,%edx
     a2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a2f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     a32:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a35:	8b 10                	mov    (%eax),%edx
     a37:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a3a:	89 10                	mov    %edx,(%eax)
     a3c:	eb 08                	jmp    a46 <free+0xd7>
  } else
    p->s.ptr = bp;
     a3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a41:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a44:	89 10                	mov    %edx,(%eax)
  freep = p;
     a46:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a49:	a3 e0 6e 00 00       	mov    %eax,0x6ee0
}
     a4e:	90                   	nop
     a4f:	c9                   	leave  
     a50:	c3                   	ret    

00000a51 <morecore>:

static Header*
morecore(uint nu)
{
     a51:	55                   	push   %ebp
     a52:	89 e5                	mov    %esp,%ebp
     a54:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     a57:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     a5e:	77 07                	ja     a67 <morecore+0x16>
    nu = 4096;
     a60:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     a67:	8b 45 08             	mov    0x8(%ebp),%eax
     a6a:	c1 e0 03             	shl    $0x3,%eax
     a6d:	83 ec 0c             	sub    $0xc,%esp
     a70:	50                   	push   %eax
     a71:	e8 31 fc ff ff       	call   6a7 <sbrk>
     a76:	83 c4 10             	add    $0x10,%esp
     a79:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     a7c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     a80:	75 07                	jne    a89 <morecore+0x38>
    return 0;
     a82:	b8 00 00 00 00       	mov    $0x0,%eax
     a87:	eb 26                	jmp    aaf <morecore+0x5e>
  hp = (Header*)p;
     a89:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     a8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a92:	8b 55 08             	mov    0x8(%ebp),%edx
     a95:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     a98:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a9b:	83 c0 08             	add    $0x8,%eax
     a9e:	83 ec 0c             	sub    $0xc,%esp
     aa1:	50                   	push   %eax
     aa2:	e8 c8 fe ff ff       	call   96f <free>
     aa7:	83 c4 10             	add    $0x10,%esp
  return freep;
     aaa:	a1 e0 6e 00 00       	mov    0x6ee0,%eax
}
     aaf:	c9                   	leave  
     ab0:	c3                   	ret    

00000ab1 <malloc>:

void*
malloc(uint nbytes)
{
     ab1:	55                   	push   %ebp
     ab2:	89 e5                	mov    %esp,%ebp
     ab4:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     ab7:	8b 45 08             	mov    0x8(%ebp),%eax
     aba:	83 c0 07             	add    $0x7,%eax
     abd:	c1 e8 03             	shr    $0x3,%eax
     ac0:	83 c0 01             	add    $0x1,%eax
     ac3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     ac6:	a1 e0 6e 00 00       	mov    0x6ee0,%eax
     acb:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ace:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     ad2:	75 23                	jne    af7 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     ad4:	c7 45 f0 d8 6e 00 00 	movl   $0x6ed8,-0x10(%ebp)
     adb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ade:	a3 e0 6e 00 00       	mov    %eax,0x6ee0
     ae3:	a1 e0 6e 00 00       	mov    0x6ee0,%eax
     ae8:	a3 d8 6e 00 00       	mov    %eax,0x6ed8
    base.s.size = 0;
     aed:	c7 05 dc 6e 00 00 00 	movl   $0x0,0x6edc
     af4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     af7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     afa:	8b 00                	mov    (%eax),%eax
     afc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     aff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b02:	8b 40 04             	mov    0x4(%eax),%eax
     b05:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     b08:	72 4d                	jb     b57 <malloc+0xa6>
      if(p->s.size == nunits)
     b0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b0d:	8b 40 04             	mov    0x4(%eax),%eax
     b10:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     b13:	75 0c                	jne    b21 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     b15:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b18:	8b 10                	mov    (%eax),%edx
     b1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b1d:	89 10                	mov    %edx,(%eax)
     b1f:	eb 26                	jmp    b47 <malloc+0x96>
      else {
        p->s.size -= nunits;
     b21:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b24:	8b 40 04             	mov    0x4(%eax),%eax
     b27:	2b 45 ec             	sub    -0x14(%ebp),%eax
     b2a:	89 c2                	mov    %eax,%edx
     b2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b2f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     b32:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b35:	8b 40 04             	mov    0x4(%eax),%eax
     b38:	c1 e0 03             	shl    $0x3,%eax
     b3b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     b3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b41:	8b 55 ec             	mov    -0x14(%ebp),%edx
     b44:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     b47:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b4a:	a3 e0 6e 00 00       	mov    %eax,0x6ee0
      return (void*)(p + 1);
     b4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b52:	83 c0 08             	add    $0x8,%eax
     b55:	eb 3b                	jmp    b92 <malloc+0xe1>
    }
    if(p == freep)
     b57:	a1 e0 6e 00 00       	mov    0x6ee0,%eax
     b5c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     b5f:	75 1e                	jne    b7f <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     b61:	83 ec 0c             	sub    $0xc,%esp
     b64:	ff 75 ec             	pushl  -0x14(%ebp)
     b67:	e8 e5 fe ff ff       	call   a51 <morecore>
     b6c:	83 c4 10             	add    $0x10,%esp
     b6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
     b72:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b76:	75 07                	jne    b7f <malloc+0xce>
        return 0;
     b78:	b8 00 00 00 00       	mov    $0x0,%eax
     b7d:	eb 13                	jmp    b92 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     b7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b82:	89 45 f0             	mov    %eax,-0x10(%ebp)
     b85:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b88:	8b 00                	mov    (%eax),%eax
     b8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     b8d:	e9 6d ff ff ff       	jmp    aff <malloc+0x4e>
}
     b92:	c9                   	leave  
     b93:	c3                   	ret    

00000b94 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     b94:	55                   	push   %ebp
     b95:	89 e5                	mov    %esp,%ebp
     b97:	83 ec 1c             	sub    $0x1c,%esp
     b9a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     b9d:	8b 55 10             	mov    0x10(%ebp),%edx
     ba0:	8b 45 14             	mov    0x14(%ebp),%eax
     ba3:	88 4d ec             	mov    %cl,-0x14(%ebp)
     ba6:	88 55 e8             	mov    %dl,-0x18(%ebp)
     ba9:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     bac:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     bb0:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     bb3:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     bb7:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     bba:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     bbe:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     bc1:	8b 45 08             	mov    0x8(%ebp),%eax
     bc4:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     bc8:	66 89 10             	mov    %dx,(%eax)
     bcb:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     bcf:	88 50 02             	mov    %dl,0x2(%eax)
}
     bd2:	8b 45 08             	mov    0x8(%ebp),%eax
     bd5:	c9                   	leave  
     bd6:	c2 04 00             	ret    $0x4

00000bd9 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     bd9:	55                   	push   %ebp
     bda:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     bdc:	8b 45 08             	mov    0x8(%ebp),%eax
     bdf:	2b 45 10             	sub    0x10(%ebp),%eax
     be2:	89 c2                	mov    %eax,%edx
     be4:	8b 45 08             	mov    0x8(%ebp),%eax
     be7:	2b 45 10             	sub    0x10(%ebp),%eax
     bea:	0f af d0             	imul   %eax,%edx
     bed:	8b 45 0c             	mov    0xc(%ebp),%eax
     bf0:	2b 45 14             	sub    0x14(%ebp),%eax
     bf3:	89 c1                	mov    %eax,%ecx
     bf5:	8b 45 0c             	mov    0xc(%ebp),%eax
     bf8:	2b 45 14             	sub    0x14(%ebp),%eax
     bfb:	0f af c1             	imul   %ecx,%eax
     bfe:	01 d0                	add    %edx,%eax
}
     c00:	5d                   	pop    %ebp
     c01:	c3                   	ret    

00000c02 <abs_int>:

static inline int abs_int(int x)
{
     c02:	55                   	push   %ebp
     c03:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     c05:	8b 45 08             	mov    0x8(%ebp),%eax
     c08:	99                   	cltd   
     c09:	89 d0                	mov    %edx,%eax
     c0b:	33 45 08             	xor    0x8(%ebp),%eax
     c0e:	29 d0                	sub    %edx,%eax
}
     c10:	5d                   	pop    %ebp
     c11:	c3                   	ret    

00000c12 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     c12:	55                   	push   %ebp
     c13:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     c15:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     c19:	79 07                	jns    c22 <APGetIndex+0x10>
        return X_SMALLER;
     c1b:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     c20:	eb 40                	jmp    c62 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     c22:	8b 45 08             	mov    0x8(%ebp),%eax
     c25:	8b 00                	mov    (%eax),%eax
     c27:	3b 45 0c             	cmp    0xc(%ebp),%eax
     c2a:	7f 07                	jg     c33 <APGetIndex+0x21>
        return X_BIGGER;
     c2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c31:	eb 2f                	jmp    c62 <APGetIndex+0x50>
    if (y < 0)
     c33:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     c37:	79 07                	jns    c40 <APGetIndex+0x2e>
        return Y_SMALLER;
     c39:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     c3e:	eb 22                	jmp    c62 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     c40:	8b 45 08             	mov    0x8(%ebp),%eax
     c43:	8b 40 04             	mov    0x4(%eax),%eax
     c46:	3b 45 10             	cmp    0x10(%ebp),%eax
     c49:	7f 07                	jg     c52 <APGetIndex+0x40>
        return Y_BIGGER;
     c4b:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     c50:	eb 10                	jmp    c62 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     c52:	8b 45 08             	mov    0x8(%ebp),%eax
     c55:	8b 00                	mov    (%eax),%eax
     c57:	0f af 45 10          	imul   0x10(%ebp),%eax
     c5b:	89 c2                	mov    %eax,%edx
     c5d:	8b 45 0c             	mov    0xc(%ebp),%eax
     c60:	01 d0                	add    %edx,%eax
}
     c62:	5d                   	pop    %ebp
     c63:	c3                   	ret    

00000c64 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     c64:	55                   	push   %ebp
     c65:	89 e5                	mov    %esp,%ebp
     c67:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     c6a:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     c71:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c74:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     c77:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     c7e:	83 ec 08             	sub    $0x8,%esp
     c81:	6a 00                	push   $0x0
     c83:	ff 75 0c             	pushl  0xc(%ebp)
     c86:	e8 d4 f9 ff ff       	call   65f <open>
     c8b:	83 c4 10             	add    $0x10,%esp
     c8e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     c91:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     c95:	79 2e                	jns    cc5 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     c97:	83 ec 04             	sub    $0x4,%esp
     c9a:	ff 75 0c             	pushl  0xc(%ebp)
     c9d:	68 4f 28 00 00       	push   $0x284f
     ca2:	6a 01                	push   $0x1
     ca4:	e8 35 fb ff ff       	call   7de <printf>
     ca9:	83 c4 10             	add    $0x10,%esp
        return bmp;
     cac:	8b 45 08             	mov    0x8(%ebp),%eax
     caf:	8b 55 c8             	mov    -0x38(%ebp),%edx
     cb2:	89 10                	mov    %edx,(%eax)
     cb4:	8b 55 cc             	mov    -0x34(%ebp),%edx
     cb7:	89 50 04             	mov    %edx,0x4(%eax)
     cba:	8b 55 d0             	mov    -0x30(%ebp),%edx
     cbd:	89 50 08             	mov    %edx,0x8(%eax)
     cc0:	e9 d2 01 00 00       	jmp    e97 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     cc5:	83 ec 04             	sub    $0x4,%esp
     cc8:	6a 0e                	push   $0xe
     cca:	8d 45 ba             	lea    -0x46(%ebp),%eax
     ccd:	50                   	push   %eax
     cce:	ff 75 ec             	pushl  -0x14(%ebp)
     cd1:	e8 61 f9 ff ff       	call   637 <read>
     cd6:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     cd9:	83 ec 04             	sub    $0x4,%esp
     cdc:	6a 28                	push   $0x28
     cde:	8d 45 92             	lea    -0x6e(%ebp),%eax
     ce1:	50                   	push   %eax
     ce2:	ff 75 ec             	pushl  -0x14(%ebp)
     ce5:	e8 4d f9 ff ff       	call   637 <read>
     cea:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     ced:	8b 45 96             	mov    -0x6a(%ebp),%eax
     cf0:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     cf3:	8b 45 9a             	mov    -0x66(%ebp),%eax
     cf6:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     cf9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     cfc:	8b 45 cc             	mov    -0x34(%ebp),%eax
     cff:	0f af d0             	imul   %eax,%edx
     d02:	89 d0                	mov    %edx,%eax
     d04:	01 c0                	add    %eax,%eax
     d06:	01 d0                	add    %edx,%eax
     d08:	83 ec 0c             	sub    $0xc,%esp
     d0b:	50                   	push   %eax
     d0c:	e8 a0 fd ff ff       	call   ab1 <malloc>
     d11:	83 c4 10             	add    $0x10,%esp
     d14:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     d17:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     d1b:	0f b7 c0             	movzwl %ax,%eax
     d1e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     d21:	8b 55 c8             	mov    -0x38(%ebp),%edx
     d24:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d27:	0f af c2             	imul   %edx,%eax
     d2a:	83 c0 1f             	add    $0x1f,%eax
     d2d:	c1 e8 05             	shr    $0x5,%eax
     d30:	c1 e0 02             	shl    $0x2,%eax
     d33:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     d36:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d39:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d3c:	0f af c2             	imul   %edx,%eax
     d3f:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     d42:	8b 45 e0             	mov    -0x20(%ebp),%eax
     d45:	83 ec 0c             	sub    $0xc,%esp
     d48:	50                   	push   %eax
     d49:	e8 63 fd ff ff       	call   ab1 <malloc>
     d4e:	83 c4 10             	add    $0x10,%esp
     d51:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     d54:	83 ec 04             	sub    $0x4,%esp
     d57:	ff 75 e0             	pushl  -0x20(%ebp)
     d5a:	ff 75 dc             	pushl  -0x24(%ebp)
     d5d:	ff 75 ec             	pushl  -0x14(%ebp)
     d60:	e8 d2 f8 ff ff       	call   637 <read>
     d65:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     d68:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     d6c:	66 c1 e8 03          	shr    $0x3,%ax
     d70:	0f b7 c0             	movzwl %ax,%eax
     d73:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     d76:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d7d:	e9 e5 00 00 00       	jmp    e67 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     d82:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d85:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d88:	29 c2                	sub    %eax,%edx
     d8a:	89 d0                	mov    %edx,%eax
     d8c:	8d 50 ff             	lea    -0x1(%eax),%edx
     d8f:	8b 45 c8             	mov    -0x38(%ebp),%eax
     d92:	0f af c2             	imul   %edx,%eax
     d95:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     d98:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     d9f:	e9 b1 00 00 00       	jmp    e55 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     da4:	8b 55 d0             	mov    -0x30(%ebp),%edx
     da7:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     daa:	8b 45 f0             	mov    -0x10(%ebp),%eax
     dad:	01 c8                	add    %ecx,%eax
     daf:	89 c1                	mov    %eax,%ecx
     db1:	89 c8                	mov    %ecx,%eax
     db3:	01 c0                	add    %eax,%eax
     db5:	01 c8                	add    %ecx,%eax
     db7:	01 c2                	add    %eax,%edx
     db9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dbc:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     dc0:	89 c1                	mov    %eax,%ecx
     dc2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     dc5:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     dc9:	01 c1                	add    %eax,%ecx
     dcb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     dce:	01 c8                	add    %ecx,%eax
     dd0:	8d 48 ff             	lea    -0x1(%eax),%ecx
     dd3:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dd6:	01 c8                	add    %ecx,%eax
     dd8:	0f b6 00             	movzbl (%eax),%eax
     ddb:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     dde:	8b 55 d0             	mov    -0x30(%ebp),%edx
     de1:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     de4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     de7:	01 c8                	add    %ecx,%eax
     de9:	89 c1                	mov    %eax,%ecx
     deb:	89 c8                	mov    %ecx,%eax
     ded:	01 c0                	add    %eax,%eax
     def:	01 c8                	add    %ecx,%eax
     df1:	01 c2                	add    %eax,%edx
     df3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df6:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     dfa:	89 c1                	mov    %eax,%ecx
     dfc:	8b 45 d8             	mov    -0x28(%ebp),%eax
     dff:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     e03:	01 c1                	add    %eax,%ecx
     e05:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e08:	01 c8                	add    %ecx,%eax
     e0a:	8d 48 fe             	lea    -0x2(%eax),%ecx
     e0d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e10:	01 c8                	add    %ecx,%eax
     e12:	0f b6 00             	movzbl (%eax),%eax
     e15:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     e18:	8b 55 d0             	mov    -0x30(%ebp),%edx
     e1b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     e1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e21:	01 c8                	add    %ecx,%eax
     e23:	89 c1                	mov    %eax,%ecx
     e25:	89 c8                	mov    %ecx,%eax
     e27:	01 c0                	add    %eax,%eax
     e29:	01 c8                	add    %ecx,%eax
     e2b:	01 c2                	add    %eax,%edx
     e2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e30:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     e34:	89 c1                	mov    %eax,%ecx
     e36:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e39:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     e3d:	01 c1                	add    %eax,%ecx
     e3f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e42:	01 c8                	add    %ecx,%eax
     e44:	8d 48 fd             	lea    -0x3(%eax),%ecx
     e47:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e4a:	01 c8                	add    %ecx,%eax
     e4c:	0f b6 00             	movzbl (%eax),%eax
     e4f:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     e51:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e55:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e58:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e5b:	39 c2                	cmp    %eax,%edx
     e5d:	0f 87 41 ff ff ff    	ja     da4 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     e63:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e67:	8b 55 cc             	mov    -0x34(%ebp),%edx
     e6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e6d:	39 c2                	cmp    %eax,%edx
     e6f:	0f 87 0d ff ff ff    	ja     d82 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     e75:	83 ec 0c             	sub    $0xc,%esp
     e78:	ff 75 ec             	pushl  -0x14(%ebp)
     e7b:	e8 c7 f7 ff ff       	call   647 <close>
     e80:	83 c4 10             	add    $0x10,%esp
    return bmp;
     e83:	8b 45 08             	mov    0x8(%ebp),%eax
     e86:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e89:	89 10                	mov    %edx,(%eax)
     e8b:	8b 55 cc             	mov    -0x34(%ebp),%edx
     e8e:	89 50 04             	mov    %edx,0x4(%eax)
     e91:	8b 55 d0             	mov    -0x30(%ebp),%edx
     e94:	89 50 08             	mov    %edx,0x8(%eax)
}
     e97:	8b 45 08             	mov    0x8(%ebp),%eax
     e9a:	c9                   	leave  
     e9b:	c2 04 00             	ret    $0x4

00000e9e <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     e9e:	55                   	push   %ebp
     e9f:	89 e5                	mov    %esp,%ebp
     ea1:	53                   	push   %ebx
     ea2:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     ea5:	83 ec 0c             	sub    $0xc,%esp
     ea8:	6a 1c                	push   $0x1c
     eaa:	e8 02 fc ff ff       	call   ab1 <malloc>
     eaf:	83 c4 10             	add    $0x10,%esp
     eb2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     eb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eb8:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     ebf:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     ec2:	8d 45 d8             	lea    -0x28(%ebp),%eax
     ec5:	6a 0c                	push   $0xc
     ec7:	6a 0c                	push   $0xc
     ec9:	6a 0c                	push   $0xc
     ecb:	50                   	push   %eax
     ecc:	e8 c3 fc ff ff       	call   b94 <RGB>
     ed1:	83 c4 0c             	add    $0xc,%esp
     ed4:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     ed8:	66 89 43 13          	mov    %ax,0x13(%ebx)
     edc:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     ee0:	88 43 15             	mov    %al,0x15(%ebx)
     ee3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ee6:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ee9:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     eed:	66 89 48 10          	mov    %cx,0x10(%eax)
     ef1:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     ef5:	88 50 12             	mov    %dl,0x12(%eax)
     ef8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     efb:	8b 55 f4             	mov    -0xc(%ebp),%edx
     efe:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     f02:	66 89 48 08          	mov    %cx,0x8(%eax)
     f06:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     f0a:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     f0d:	8b 45 08             	mov    0x8(%ebp),%eax
     f10:	89 c2                	mov    %eax,%edx
     f12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f15:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     f17:	8b 45 0c             	mov    0xc(%ebp),%eax
     f1a:	89 c2                	mov    %eax,%edx
     f1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f1f:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     f22:	8b 55 10             	mov    0x10(%ebp),%edx
     f25:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f28:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     f2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     f2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     f31:	c9                   	leave  
     f32:	c3                   	ret    

00000f33 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     f33:	55                   	push   %ebp
     f34:	89 e5                	mov    %esp,%ebp
     f36:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     f39:	8b 45 0c             	mov    0xc(%ebp),%eax
     f3c:	8b 50 08             	mov    0x8(%eax),%edx
     f3f:	89 55 f8             	mov    %edx,-0x8(%ebp)
     f42:	8b 40 0c             	mov    0xc(%eax),%eax
     f45:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     f48:	8b 45 0c             	mov    0xc(%ebp),%eax
     f4b:	8b 55 10             	mov    0x10(%ebp),%edx
     f4e:	89 50 08             	mov    %edx,0x8(%eax)
     f51:	8b 55 14             	mov    0x14(%ebp),%edx
     f54:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     f57:	8b 45 08             	mov    0x8(%ebp),%eax
     f5a:	8b 55 f8             	mov    -0x8(%ebp),%edx
     f5d:	89 10                	mov    %edx,(%eax)
     f5f:	8b 55 fc             	mov    -0x4(%ebp),%edx
     f62:	89 50 04             	mov    %edx,0x4(%eax)
}
     f65:	8b 45 08             	mov    0x8(%ebp),%eax
     f68:	c9                   	leave  
     f69:	c2 04 00             	ret    $0x4

00000f6c <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     f6c:	55                   	push   %ebp
     f6d:	89 e5                	mov    %esp,%ebp
     f6f:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     f72:	8b 45 0c             	mov    0xc(%ebp),%eax
     f75:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     f79:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     f7d:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     f81:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     f84:	8b 45 0c             	mov    0xc(%ebp),%eax
     f87:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     f8b:	66 89 50 10          	mov    %dx,0x10(%eax)
     f8f:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     f93:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     f96:	8b 45 08             	mov    0x8(%ebp),%eax
     f99:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     f9d:	66 89 10             	mov    %dx,(%eax)
     fa0:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     fa4:	88 50 02             	mov    %dl,0x2(%eax)
}
     fa7:	8b 45 08             	mov    0x8(%ebp),%eax
     faa:	c9                   	leave  
     fab:	c2 04 00             	ret    $0x4

00000fae <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     fae:	55                   	push   %ebp
     faf:	89 e5                	mov    %esp,%ebp
     fb1:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     fb4:	8b 45 0c             	mov    0xc(%ebp),%eax
     fb7:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     fbb:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     fbf:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     fc3:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     fc6:	8b 45 0c             	mov    0xc(%ebp),%eax
     fc9:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     fcd:	66 89 50 13          	mov    %dx,0x13(%eax)
     fd1:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     fd5:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     fd8:	8b 45 08             	mov    0x8(%ebp),%eax
     fdb:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     fdf:	66 89 10             	mov    %dx,(%eax)
     fe2:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     fe6:	88 50 02             	mov    %dl,0x2(%eax)
}
     fe9:	8b 45 08             	mov    0x8(%ebp),%eax
     fec:	c9                   	leave  
     fed:	c2 04 00             	ret    $0x4

00000ff0 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     ff0:	55                   	push   %ebp
     ff1:	89 e5                	mov    %esp,%ebp
     ff3:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     ff6:	8b 45 08             	mov    0x8(%ebp),%eax
     ff9:	8b 40 0c             	mov    0xc(%eax),%eax
     ffc:	89 c2                	mov    %eax,%edx
     ffe:	c1 ea 1f             	shr    $0x1f,%edx
    1001:	01 d0                	add    %edx,%eax
    1003:	d1 f8                	sar    %eax
    1005:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    1008:	8b 45 f4             	mov    -0xc(%ebp),%eax
    100b:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    100f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    1012:	8b 45 10             	mov    0x10(%ebp),%eax
    1015:	2b 45 f4             	sub    -0xc(%ebp),%eax
    1018:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    101b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    101f:	0f 89 98 00 00 00    	jns    10bd <APDrawPoint+0xcd>
        i = 0;
    1025:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    102c:	e9 8c 00 00 00       	jmp    10bd <APDrawPoint+0xcd>
    {
        j = x - off;
    1031:	8b 45 0c             	mov    0xc(%ebp),%eax
    1034:	2b 45 f4             	sub    -0xc(%ebp),%eax
    1037:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    103a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    103e:	79 69                	jns    10a9 <APDrawPoint+0xb9>
            j = 0;
    1040:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    1047:	eb 60                	jmp    10a9 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    1049:	ff 75 fc             	pushl  -0x4(%ebp)
    104c:	ff 75 f8             	pushl  -0x8(%ebp)
    104f:	ff 75 08             	pushl  0x8(%ebp)
    1052:	e8 bb fb ff ff       	call   c12 <APGetIndex>
    1057:	83 c4 0c             	add    $0xc,%esp
    105a:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    105d:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    1061:	74 55                	je     10b8 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    1063:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    1067:	74 67                	je     10d0 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    1069:	ff 75 10             	pushl  0x10(%ebp)
    106c:	ff 75 0c             	pushl  0xc(%ebp)
    106f:	ff 75 fc             	pushl  -0x4(%ebp)
    1072:	ff 75 f8             	pushl  -0x8(%ebp)
    1075:	e8 5f fb ff ff       	call   bd9 <distance_2>
    107a:	83 c4 10             	add    $0x10,%esp
    107d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1080:	7f 23                	jg     10a5 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    1082:	8b 45 08             	mov    0x8(%ebp),%eax
    1085:	8b 48 18             	mov    0x18(%eax),%ecx
    1088:	8b 55 ec             	mov    -0x14(%ebp),%edx
    108b:	89 d0                	mov    %edx,%eax
    108d:	01 c0                	add    %eax,%eax
    108f:	01 d0                	add    %edx,%eax
    1091:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1094:	8b 45 08             	mov    0x8(%ebp),%eax
    1097:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    109b:	66 89 0a             	mov    %cx,(%edx)
    109e:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    10a2:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    10a5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    10a9:	8b 55 0c             	mov    0xc(%ebp),%edx
    10ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10af:	01 d0                	add    %edx,%eax
    10b1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    10b4:	7d 93                	jge    1049 <APDrawPoint+0x59>
    10b6:	eb 01                	jmp    10b9 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    10b8:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    10b9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    10bd:	8b 55 10             	mov    0x10(%ebp),%edx
    10c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10c3:	01 d0                	add    %edx,%eax
    10c5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    10c8:	0f 8d 63 ff ff ff    	jge    1031 <APDrawPoint+0x41>
    10ce:	eb 01                	jmp    10d1 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    10d0:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    10d1:	c9                   	leave  
    10d2:	c3                   	ret    

000010d3 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    10d3:	55                   	push   %ebp
    10d4:	89 e5                	mov    %esp,%ebp
    10d6:	53                   	push   %ebx
    10d7:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    10da:	8b 45 0c             	mov    0xc(%ebp),%eax
    10dd:	3b 45 14             	cmp    0x14(%ebp),%eax
    10e0:	0f 85 80 00 00 00    	jne    1166 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    10e6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10ea:	0f 88 9d 02 00 00    	js     138d <APDrawLine+0x2ba>
    10f0:	8b 45 08             	mov    0x8(%ebp),%eax
    10f3:	8b 00                	mov    (%eax),%eax
    10f5:	3b 45 0c             	cmp    0xc(%ebp),%eax
    10f8:	0f 8e 8f 02 00 00    	jle    138d <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    10fe:	8b 45 10             	mov    0x10(%ebp),%eax
    1101:	3b 45 18             	cmp    0x18(%ebp),%eax
    1104:	7e 12                	jle    1118 <APDrawLine+0x45>
        {
            int tmp = y2;
    1106:	8b 45 18             	mov    0x18(%ebp),%eax
    1109:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    110c:	8b 45 10             	mov    0x10(%ebp),%eax
    110f:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1112:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1115:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1118:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    111c:	79 07                	jns    1125 <APDrawLine+0x52>
    111e:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1125:	8b 45 08             	mov    0x8(%ebp),%eax
    1128:	8b 40 04             	mov    0x4(%eax),%eax
    112b:	3b 45 18             	cmp    0x18(%ebp),%eax
    112e:	7d 0c                	jge    113c <APDrawLine+0x69>
    1130:	8b 45 08             	mov    0x8(%ebp),%eax
    1133:	8b 40 04             	mov    0x4(%eax),%eax
    1136:	83 e8 01             	sub    $0x1,%eax
    1139:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    113c:	8b 45 10             	mov    0x10(%ebp),%eax
    113f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1142:	eb 15                	jmp    1159 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1144:	ff 75 f4             	pushl  -0xc(%ebp)
    1147:	ff 75 0c             	pushl  0xc(%ebp)
    114a:	ff 75 08             	pushl  0x8(%ebp)
    114d:	e8 9e fe ff ff       	call   ff0 <APDrawPoint>
    1152:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1155:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1159:	8b 45 f4             	mov    -0xc(%ebp),%eax
    115c:	3b 45 18             	cmp    0x18(%ebp),%eax
    115f:	7e e3                	jle    1144 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    1161:	e9 2b 02 00 00       	jmp    1391 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1166:	8b 45 10             	mov    0x10(%ebp),%eax
    1169:	3b 45 18             	cmp    0x18(%ebp),%eax
    116c:	75 7f                	jne    11ed <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    116e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1172:	0f 88 18 02 00 00    	js     1390 <APDrawLine+0x2bd>
    1178:	8b 45 08             	mov    0x8(%ebp),%eax
    117b:	8b 40 04             	mov    0x4(%eax),%eax
    117e:	3b 45 10             	cmp    0x10(%ebp),%eax
    1181:	0f 8e 09 02 00 00    	jle    1390 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1187:	8b 45 0c             	mov    0xc(%ebp),%eax
    118a:	3b 45 14             	cmp    0x14(%ebp),%eax
    118d:	7e 12                	jle    11a1 <APDrawLine+0xce>
        {
            int tmp = x2;
    118f:	8b 45 14             	mov    0x14(%ebp),%eax
    1192:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1195:	8b 45 0c             	mov    0xc(%ebp),%eax
    1198:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    119b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    119e:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    11a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11a5:	79 07                	jns    11ae <APDrawLine+0xdb>
    11a7:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    11ae:	8b 45 08             	mov    0x8(%ebp),%eax
    11b1:	8b 00                	mov    (%eax),%eax
    11b3:	3b 45 14             	cmp    0x14(%ebp),%eax
    11b6:	7d 0b                	jge    11c3 <APDrawLine+0xf0>
    11b8:	8b 45 08             	mov    0x8(%ebp),%eax
    11bb:	8b 00                	mov    (%eax),%eax
    11bd:	83 e8 01             	sub    $0x1,%eax
    11c0:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    11c3:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    11c9:	eb 15                	jmp    11e0 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    11cb:	ff 75 10             	pushl  0x10(%ebp)
    11ce:	ff 75 f0             	pushl  -0x10(%ebp)
    11d1:	ff 75 08             	pushl  0x8(%ebp)
    11d4:	e8 17 fe ff ff       	call   ff0 <APDrawPoint>
    11d9:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    11dc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11e3:	3b 45 14             	cmp    0x14(%ebp),%eax
    11e6:	7e e3                	jle    11cb <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    11e8:	e9 a4 01 00 00       	jmp    1391 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    11ed:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    11f4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    11fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    11fe:	2b 45 14             	sub    0x14(%ebp),%eax
    1201:	50                   	push   %eax
    1202:	e8 fb f9 ff ff       	call   c02 <abs_int>
    1207:	83 c4 04             	add    $0x4,%esp
    120a:	89 c3                	mov    %eax,%ebx
    120c:	8b 45 10             	mov    0x10(%ebp),%eax
    120f:	2b 45 18             	sub    0x18(%ebp),%eax
    1212:	50                   	push   %eax
    1213:	e8 ea f9 ff ff       	call   c02 <abs_int>
    1218:	83 c4 04             	add    $0x4,%esp
    121b:	39 c3                	cmp    %eax,%ebx
    121d:	0f 8e b5 00 00 00    	jle    12d8 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1223:	8b 45 10             	mov    0x10(%ebp),%eax
    1226:	2b 45 18             	sub    0x18(%ebp),%eax
    1229:	89 45 b0             	mov    %eax,-0x50(%ebp)
    122c:	db 45 b0             	fildl  -0x50(%ebp)
    122f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1232:	2b 45 14             	sub    0x14(%ebp),%eax
    1235:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1238:	db 45 b0             	fildl  -0x50(%ebp)
    123b:	de f9                	fdivrp %st,%st(1)
    123d:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1240:	8b 45 14             	mov    0x14(%ebp),%eax
    1243:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1246:	7e 0e                	jle    1256 <APDrawLine+0x183>
        {
            s = x1;
    1248:	8b 45 0c             	mov    0xc(%ebp),%eax
    124b:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    124e:	8b 45 14             	mov    0x14(%ebp),%eax
    1251:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1254:	eb 0c                	jmp    1262 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1256:	8b 45 14             	mov    0x14(%ebp),%eax
    1259:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    125c:	8b 45 0c             	mov    0xc(%ebp),%eax
    125f:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1262:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1266:	79 07                	jns    126f <APDrawLine+0x19c>
    1268:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    126f:	8b 45 08             	mov    0x8(%ebp),%eax
    1272:	8b 00                	mov    (%eax),%eax
    1274:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1277:	7f 0b                	jg     1284 <APDrawLine+0x1b1>
    1279:	8b 45 08             	mov    0x8(%ebp),%eax
    127c:	8b 00                	mov    (%eax),%eax
    127e:	83 e8 01             	sub    $0x1,%eax
    1281:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1284:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1287:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    128a:	eb 3f                	jmp    12cb <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    128c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    128f:	2b 45 0c             	sub    0xc(%ebp),%eax
    1292:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1295:	db 45 b0             	fildl  -0x50(%ebp)
    1298:	dc 4d d0             	fmull  -0x30(%ebp)
    129b:	db 45 10             	fildl  0x10(%ebp)
    129e:	de c1                	faddp  %st,%st(1)
    12a0:	d9 7d b6             	fnstcw -0x4a(%ebp)
    12a3:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    12a7:	b4 0c                	mov    $0xc,%ah
    12a9:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    12ad:	d9 6d b4             	fldcw  -0x4c(%ebp)
    12b0:	db 5d cc             	fistpl -0x34(%ebp)
    12b3:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    12b6:	ff 75 cc             	pushl  -0x34(%ebp)
    12b9:	ff 75 e4             	pushl  -0x1c(%ebp)
    12bc:	ff 75 08             	pushl  0x8(%ebp)
    12bf:	e8 2c fd ff ff       	call   ff0 <APDrawPoint>
    12c4:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    12c7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    12cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12ce:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12d1:	7e b9                	jle    128c <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    12d3:	e9 b9 00 00 00       	jmp    1391 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    12d8:	8b 45 0c             	mov    0xc(%ebp),%eax
    12db:	2b 45 14             	sub    0x14(%ebp),%eax
    12de:	89 45 b0             	mov    %eax,-0x50(%ebp)
    12e1:	db 45 b0             	fildl  -0x50(%ebp)
    12e4:	8b 45 10             	mov    0x10(%ebp),%eax
    12e7:	2b 45 18             	sub    0x18(%ebp),%eax
    12ea:	89 45 b0             	mov    %eax,-0x50(%ebp)
    12ed:	db 45 b0             	fildl  -0x50(%ebp)
    12f0:	de f9                	fdivrp %st,%st(1)
    12f2:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    12f5:	8b 45 10             	mov    0x10(%ebp),%eax
    12f8:	3b 45 18             	cmp    0x18(%ebp),%eax
    12fb:	7e 0e                	jle    130b <APDrawLine+0x238>
    {
        s = y2;
    12fd:	8b 45 18             	mov    0x18(%ebp),%eax
    1300:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1303:	8b 45 10             	mov    0x10(%ebp),%eax
    1306:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1309:	eb 0c                	jmp    1317 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    130b:	8b 45 10             	mov    0x10(%ebp),%eax
    130e:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1311:	8b 45 18             	mov    0x18(%ebp),%eax
    1314:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1317:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    131b:	79 07                	jns    1324 <APDrawLine+0x251>
    131d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1324:	8b 45 08             	mov    0x8(%ebp),%eax
    1327:	8b 40 04             	mov    0x4(%eax),%eax
    132a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    132d:	7f 0c                	jg     133b <APDrawLine+0x268>
    132f:	8b 45 08             	mov    0x8(%ebp),%eax
    1332:	8b 40 04             	mov    0x4(%eax),%eax
    1335:	83 e8 01             	sub    $0x1,%eax
    1338:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    133b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    133e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1341:	eb 3f                	jmp    1382 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1343:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1346:	2b 45 10             	sub    0x10(%ebp),%eax
    1349:	89 45 b0             	mov    %eax,-0x50(%ebp)
    134c:	db 45 b0             	fildl  -0x50(%ebp)
    134f:	dc 4d c0             	fmull  -0x40(%ebp)
    1352:	db 45 0c             	fildl  0xc(%ebp)
    1355:	de c1                	faddp  %st,%st(1)
    1357:	d9 7d b6             	fnstcw -0x4a(%ebp)
    135a:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    135e:	b4 0c                	mov    $0xc,%ah
    1360:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1364:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1367:	db 5d bc             	fistpl -0x44(%ebp)
    136a:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    136d:	ff 75 e0             	pushl  -0x20(%ebp)
    1370:	ff 75 bc             	pushl  -0x44(%ebp)
    1373:	ff 75 08             	pushl  0x8(%ebp)
    1376:	e8 75 fc ff ff       	call   ff0 <APDrawPoint>
    137b:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    137e:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1382:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1385:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1388:	7e b9                	jle    1343 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    138a:	90                   	nop
    138b:	eb 04                	jmp    1391 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    138d:	90                   	nop
    138e:	eb 01                	jmp    1391 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1390:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1391:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1394:	c9                   	leave  
    1395:	c3                   	ret    

00001396 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1396:	55                   	push   %ebp
    1397:	89 e5                	mov    %esp,%ebp
    1399:	53                   	push   %ebx
    139a:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    139d:	8b 55 10             	mov    0x10(%ebp),%edx
    13a0:	8b 45 18             	mov    0x18(%ebp),%eax
    13a3:	01 d0                	add    %edx,%eax
    13a5:	83 e8 01             	sub    $0x1,%eax
    13a8:	83 ec 04             	sub    $0x4,%esp
    13ab:	50                   	push   %eax
    13ac:	ff 75 0c             	pushl  0xc(%ebp)
    13af:	ff 75 10             	pushl  0x10(%ebp)
    13b2:	ff 75 0c             	pushl  0xc(%ebp)
    13b5:	ff 75 08             	pushl  0x8(%ebp)
    13b8:	e8 16 fd ff ff       	call   10d3 <APDrawLine>
    13bd:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    13c0:	8b 55 0c             	mov    0xc(%ebp),%edx
    13c3:	8b 45 14             	mov    0x14(%ebp),%eax
    13c6:	01 d0                	add    %edx,%eax
    13c8:	83 e8 01             	sub    $0x1,%eax
    13cb:	83 ec 04             	sub    $0x4,%esp
    13ce:	ff 75 10             	pushl  0x10(%ebp)
    13d1:	50                   	push   %eax
    13d2:	ff 75 10             	pushl  0x10(%ebp)
    13d5:	ff 75 0c             	pushl  0xc(%ebp)
    13d8:	ff 75 08             	pushl  0x8(%ebp)
    13db:	e8 f3 fc ff ff       	call   10d3 <APDrawLine>
    13e0:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    13e3:	8b 55 10             	mov    0x10(%ebp),%edx
    13e6:	8b 45 18             	mov    0x18(%ebp),%eax
    13e9:	01 d0                	add    %edx,%eax
    13eb:	8d 48 ff             	lea    -0x1(%eax),%ecx
    13ee:	8b 55 0c             	mov    0xc(%ebp),%edx
    13f1:	8b 45 14             	mov    0x14(%ebp),%eax
    13f4:	01 d0                	add    %edx,%eax
    13f6:	8d 50 ff             	lea    -0x1(%eax),%edx
    13f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    13fc:	8b 45 14             	mov    0x14(%ebp),%eax
    13ff:	01 d8                	add    %ebx,%eax
    1401:	83 e8 01             	sub    $0x1,%eax
    1404:	83 ec 04             	sub    $0x4,%esp
    1407:	51                   	push   %ecx
    1408:	52                   	push   %edx
    1409:	ff 75 10             	pushl  0x10(%ebp)
    140c:	50                   	push   %eax
    140d:	ff 75 08             	pushl  0x8(%ebp)
    1410:	e8 be fc ff ff       	call   10d3 <APDrawLine>
    1415:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1418:	8b 55 10             	mov    0x10(%ebp),%edx
    141b:	8b 45 18             	mov    0x18(%ebp),%eax
    141e:	01 d0                	add    %edx,%eax
    1420:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1423:	8b 55 0c             	mov    0xc(%ebp),%edx
    1426:	8b 45 14             	mov    0x14(%ebp),%eax
    1429:	01 d0                	add    %edx,%eax
    142b:	8d 50 ff             	lea    -0x1(%eax),%edx
    142e:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1431:	8b 45 18             	mov    0x18(%ebp),%eax
    1434:	01 d8                	add    %ebx,%eax
    1436:	83 e8 01             	sub    $0x1,%eax
    1439:	83 ec 04             	sub    $0x4,%esp
    143c:	51                   	push   %ecx
    143d:	52                   	push   %edx
    143e:	50                   	push   %eax
    143f:	ff 75 0c             	pushl  0xc(%ebp)
    1442:	ff 75 08             	pushl  0x8(%ebp)
    1445:	e8 89 fc ff ff       	call   10d3 <APDrawLine>
    144a:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    144d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1450:	8b 45 14             	mov    0x14(%ebp),%eax
    1453:	01 d0                	add    %edx,%eax
    1455:	8d 50 ff             	lea    -0x1(%eax),%edx
    1458:	8b 45 08             	mov    0x8(%ebp),%eax
    145b:	8b 40 0c             	mov    0xc(%eax),%eax
    145e:	89 c1                	mov    %eax,%ecx
    1460:	c1 e9 1f             	shr    $0x1f,%ecx
    1463:	01 c8                	add    %ecx,%eax
    1465:	d1 f8                	sar    %eax
    1467:	29 c2                	sub    %eax,%edx
    1469:	89 d0                	mov    %edx,%eax
    146b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    146e:	8b 55 10             	mov    0x10(%ebp),%edx
    1471:	8b 45 18             	mov    0x18(%ebp),%eax
    1474:	01 d0                	add    %edx,%eax
    1476:	8d 50 ff             	lea    -0x1(%eax),%edx
    1479:	8b 45 08             	mov    0x8(%ebp),%eax
    147c:	8b 40 0c             	mov    0xc(%eax),%eax
    147f:	89 c1                	mov    %eax,%ecx
    1481:	c1 e9 1f             	shr    $0x1f,%ecx
    1484:	01 c8                	add    %ecx,%eax
    1486:	d1 f8                	sar    %eax
    1488:	29 c2                	sub    %eax,%edx
    148a:	89 d0                	mov    %edx,%eax
    148c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    148f:	8b 45 08             	mov    0x8(%ebp),%eax
    1492:	8b 40 0c             	mov    0xc(%eax),%eax
    1495:	89 c2                	mov    %eax,%edx
    1497:	c1 ea 1f             	shr    $0x1f,%edx
    149a:	01 d0                	add    %edx,%eax
    149c:	d1 f8                	sar    %eax
    149e:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    14a1:	8b 45 08             	mov    0x8(%ebp),%eax
    14a4:	8b 40 0c             	mov    0xc(%eax),%eax
    14a7:	89 c2                	mov    %eax,%edx
    14a9:	c1 ea 1f             	shr    $0x1f,%edx
    14ac:	01 d0                	add    %edx,%eax
    14ae:	d1 f8                	sar    %eax
    14b0:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    14b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14b7:	0f 88 d8 00 00 00    	js     1595 <APDrawRect+0x1ff>
    14bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14c1:	0f 88 ce 00 00 00    	js     1595 <APDrawRect+0x1ff>
    14c7:	8b 45 08             	mov    0x8(%ebp),%eax
    14ca:	8b 00                	mov    (%eax),%eax
    14cc:	3b 45 0c             	cmp    0xc(%ebp),%eax
    14cf:	0f 8e c0 00 00 00    	jle    1595 <APDrawRect+0x1ff>
    14d5:	8b 45 08             	mov    0x8(%ebp),%eax
    14d8:	8b 40 04             	mov    0x4(%eax),%eax
    14db:	3b 45 10             	cmp    0x10(%ebp),%eax
    14de:	0f 8e b1 00 00 00    	jle    1595 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    14e4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14e8:	79 07                	jns    14f1 <APDrawRect+0x15b>
    14ea:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    14f1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    14f5:	79 07                	jns    14fe <APDrawRect+0x168>
    14f7:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    14fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1501:	8b 00                	mov    (%eax),%eax
    1503:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1506:	7f 0b                	jg     1513 <APDrawRect+0x17d>
    1508:	8b 45 08             	mov    0x8(%ebp),%eax
    150b:	8b 00                	mov    (%eax),%eax
    150d:	83 e8 01             	sub    $0x1,%eax
    1510:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1513:	8b 45 08             	mov    0x8(%ebp),%eax
    1516:	8b 40 04             	mov    0x4(%eax),%eax
    1519:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    151c:	7f 0c                	jg     152a <APDrawRect+0x194>
    151e:	8b 45 08             	mov    0x8(%ebp),%eax
    1521:	8b 40 04             	mov    0x4(%eax),%eax
    1524:	83 e8 01             	sub    $0x1,%eax
    1527:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    152a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1531:	8b 45 0c             	mov    0xc(%ebp),%eax
    1534:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1537:	eb 52                	jmp    158b <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1539:	8b 45 10             	mov    0x10(%ebp),%eax
    153c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    153f:	eb 3e                	jmp    157f <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1541:	83 ec 04             	sub    $0x4,%esp
    1544:	ff 75 e8             	pushl  -0x18(%ebp)
    1547:	ff 75 ec             	pushl  -0x14(%ebp)
    154a:	ff 75 08             	pushl  0x8(%ebp)
    154d:	e8 c0 f6 ff ff       	call   c12 <APGetIndex>
    1552:	83 c4 10             	add    $0x10,%esp
    1555:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1558:	8b 45 08             	mov    0x8(%ebp),%eax
    155b:	8b 48 18             	mov    0x18(%eax),%ecx
    155e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1561:	89 d0                	mov    %edx,%eax
    1563:	01 c0                	add    %eax,%eax
    1565:	01 d0                	add    %edx,%eax
    1567:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    156a:	8b 45 08             	mov    0x8(%ebp),%eax
    156d:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1571:	66 89 0a             	mov    %cx,(%edx)
    1574:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1578:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    157b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    157f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1582:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1585:	7e ba                	jle    1541 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1587:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    158b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    158e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1591:	7e a6                	jle    1539 <APDrawRect+0x1a3>
    1593:	eb 01                	jmp    1596 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1595:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1596:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1599:	c9                   	leave  
    159a:	c3                   	ret    

0000159b <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    159b:	55                   	push   %ebp
    159c:	89 e5                	mov    %esp,%ebp
    159e:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    15a1:	83 ec 0c             	sub    $0xc,%esp
    15a4:	ff 75 0c             	pushl  0xc(%ebp)
    15a7:	e8 b1 ee ff ff       	call   45d <strlen>
    15ac:	83 c4 10             	add    $0x10,%esp
    15af:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    15b2:	8b 45 08             	mov    0x8(%ebp),%eax
    15b5:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    15b9:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    15bd:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    15c1:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    15c4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    15cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    15d2:	e9 bc 00 00 00       	jmp    1693 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    15d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    15da:	8b 45 0c             	mov    0xc(%ebp),%eax
    15dd:	01 d0                	add    %edx,%eax
    15df:	0f b6 00             	movzbl (%eax),%eax
    15e2:	0f be c0             	movsbl %al,%eax
    15e5:	83 e8 20             	sub    $0x20,%eax
    15e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    15eb:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    15ef:	0f 87 9a 00 00 00    	ja     168f <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    15f5:	8b 45 08             	mov    0x8(%ebp),%eax
    15f8:	8b 00                	mov    (%eax),%eax
    15fa:	0f af 45 14          	imul   0x14(%ebp),%eax
    15fe:	89 c2                	mov    %eax,%edx
    1600:	8b 45 10             	mov    0x10(%ebp),%eax
    1603:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1606:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1609:	89 d0                	mov    %edx,%eax
    160b:	c1 e0 03             	shl    $0x3,%eax
    160e:	01 d0                	add    %edx,%eax
    1610:	01 c8                	add    %ecx,%eax
    1612:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1615:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    161c:	eb 6b                	jmp    1689 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    161e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1625:	eb 50                	jmp    1677 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    1627:	8b 55 ec             	mov    -0x14(%ebp),%edx
    162a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    162d:	89 d0                	mov    %edx,%eax
    162f:	c1 e0 03             	shl    $0x3,%eax
    1632:	01 d0                	add    %edx,%eax
    1634:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    163a:	01 c2                	add    %eax,%edx
    163c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    163f:	01 d0                	add    %edx,%eax
    1641:	05 a0 32 00 00       	add    $0x32a0,%eax
    1646:	0f b6 00             	movzbl (%eax),%eax
    1649:	84 c0                	test   %al,%al
    164b:	74 26                	je     1673 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    164d:	8b 45 08             	mov    0x8(%ebp),%eax
    1650:	8b 50 18             	mov    0x18(%eax),%edx
    1653:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1656:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1659:	01 c8                	add    %ecx,%eax
    165b:	89 c1                	mov    %eax,%ecx
    165d:	89 c8                	mov    %ecx,%eax
    165f:	01 c0                	add    %eax,%eax
    1661:	01 c8                	add    %ecx,%eax
    1663:	01 d0                	add    %edx,%eax
    1665:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1669:	66 89 10             	mov    %dx,(%eax)
    166c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1670:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1673:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1677:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    167b:	7e aa                	jle    1627 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    167d:	8b 45 08             	mov    0x8(%ebp),%eax
    1680:	8b 00                	mov    (%eax),%eax
    1682:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1685:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1689:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    168d:	7e 8f                	jle    161e <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    168f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1693:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1696:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1699:	0f 82 38 ff ff ff    	jb     15d7 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    169f:	90                   	nop
    16a0:	c9                   	leave  
    16a1:	c3                   	ret    

000016a2 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    16a2:	55                   	push   %ebp
    16a3:	89 e5                	mov    %esp,%ebp
    16a5:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    16a8:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    16ac:	0f 88 8e 01 00 00    	js     1840 <APDcCopy+0x19e>
    16b2:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    16b6:	0f 88 84 01 00 00    	js     1840 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    16bc:	8b 55 0c             	mov    0xc(%ebp),%edx
    16bf:	8b 45 20             	mov    0x20(%ebp),%eax
    16c2:	01 d0                	add    %edx,%eax
    16c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16c7:	8b 55 10             	mov    0x10(%ebp),%edx
    16ca:	8b 45 24             	mov    0x24(%ebp),%eax
    16cd:	01 d0                	add    %edx,%eax
    16cf:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    16d2:	8b 55 18             	mov    0x18(%ebp),%edx
    16d5:	8b 45 20             	mov    0x20(%ebp),%eax
    16d8:	01 d0                	add    %edx,%eax
    16da:	89 45 ec             	mov    %eax,-0x14(%ebp)
    16dd:	8b 55 1c             	mov    0x1c(%ebp),%edx
    16e0:	8b 45 24             	mov    0x24(%ebp),%eax
    16e3:	01 d0                	add    %edx,%eax
    16e5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    16e8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16ec:	0f 88 51 01 00 00    	js     1843 <APDcCopy+0x1a1>
    16f2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    16f6:	0f 88 47 01 00 00    	js     1843 <APDcCopy+0x1a1>
    16fc:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1700:	0f 88 3d 01 00 00    	js     1843 <APDcCopy+0x1a1>
    1706:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    170a:	0f 88 33 01 00 00    	js     1843 <APDcCopy+0x1a1>
    1710:	8b 45 14             	mov    0x14(%ebp),%eax
    1713:	8b 00                	mov    (%eax),%eax
    1715:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1718:	0f 8c 25 01 00 00    	jl     1843 <APDcCopy+0x1a1>
    171e:	8b 45 14             	mov    0x14(%ebp),%eax
    1721:	8b 40 04             	mov    0x4(%eax),%eax
    1724:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1727:	0f 8c 16 01 00 00    	jl     1843 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    172d:	8b 45 08             	mov    0x8(%ebp),%eax
    1730:	8b 00                	mov    (%eax),%eax
    1732:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1735:	7f 0b                	jg     1742 <APDcCopy+0xa0>
    1737:	8b 45 08             	mov    0x8(%ebp),%eax
    173a:	8b 00                	mov    (%eax),%eax
    173c:	83 e8 01             	sub    $0x1,%eax
    173f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1742:	8b 45 08             	mov    0x8(%ebp),%eax
    1745:	8b 40 04             	mov    0x4(%eax),%eax
    1748:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    174b:	7f 0c                	jg     1759 <APDcCopy+0xb7>
    174d:	8b 45 08             	mov    0x8(%ebp),%eax
    1750:	8b 40 04             	mov    0x4(%eax),%eax
    1753:	83 e8 01             	sub    $0x1,%eax
    1756:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1759:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1760:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1767:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    176e:	e9 bc 00 00 00       	jmp    182f <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1773:	8b 45 08             	mov    0x8(%ebp),%eax
    1776:	8b 00                	mov    (%eax),%eax
    1778:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    177b:	8b 55 10             	mov    0x10(%ebp),%edx
    177e:	01 ca                	add    %ecx,%edx
    1780:	0f af d0             	imul   %eax,%edx
    1783:	8b 45 0c             	mov    0xc(%ebp),%eax
    1786:	01 d0                	add    %edx,%eax
    1788:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    178b:	8b 45 14             	mov    0x14(%ebp),%eax
    178e:	8b 00                	mov    (%eax),%eax
    1790:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1793:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1796:	01 ca                	add    %ecx,%edx
    1798:	0f af d0             	imul   %eax,%edx
    179b:	8b 45 18             	mov    0x18(%ebp),%eax
    179e:	01 d0                	add    %edx,%eax
    17a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    17a3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    17aa:	eb 74                	jmp    1820 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    17ac:	8b 45 14             	mov    0x14(%ebp),%eax
    17af:	8b 50 18             	mov    0x18(%eax),%edx
    17b2:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    17b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17b8:	01 c8                	add    %ecx,%eax
    17ba:	89 c1                	mov    %eax,%ecx
    17bc:	89 c8                	mov    %ecx,%eax
    17be:	01 c0                	add    %eax,%eax
    17c0:	01 c8                	add    %ecx,%eax
    17c2:	01 d0                	add    %edx,%eax
    17c4:	0f b7 10             	movzwl (%eax),%edx
    17c7:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    17cb:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    17cf:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    17d2:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    17d6:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    17da:	38 c2                	cmp    %al,%dl
    17dc:	75 18                	jne    17f6 <APDcCopy+0x154>
    17de:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    17e2:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    17e6:	38 c2                	cmp    %al,%dl
    17e8:	75 0c                	jne    17f6 <APDcCopy+0x154>
    17ea:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    17ee:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    17f2:	38 c2                	cmp    %al,%dl
    17f4:	74 26                	je     181c <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    17f6:	8b 45 08             	mov    0x8(%ebp),%eax
    17f9:	8b 50 18             	mov    0x18(%eax),%edx
    17fc:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    17ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1802:	01 c8                	add    %ecx,%eax
    1804:	89 c1                	mov    %eax,%ecx
    1806:	89 c8                	mov    %ecx,%eax
    1808:	01 c0                	add    %eax,%eax
    180a:	01 c8                	add    %ecx,%eax
    180c:	01 d0                	add    %edx,%eax
    180e:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1812:	66 89 10             	mov    %dx,(%eax)
    1815:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1819:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    181c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1820:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1823:	2b 45 0c             	sub    0xc(%ebp),%eax
    1826:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1829:	7d 81                	jge    17ac <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    182b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    182f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1832:	2b 45 10             	sub    0x10(%ebp),%eax
    1835:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1838:	0f 8d 35 ff ff ff    	jge    1773 <APDcCopy+0xd1>
    183e:	eb 04                	jmp    1844 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1840:	90                   	nop
    1841:	eb 01                	jmp    1844 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1843:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1844:	c9                   	leave  
    1845:	c3                   	ret    

00001846 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1846:	55                   	push   %ebp
    1847:	89 e5                	mov    %esp,%ebp
    1849:	83 ec 1c             	sub    $0x1c,%esp
    184c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    184f:	8b 55 10             	mov    0x10(%ebp),%edx
    1852:	8b 45 14             	mov    0x14(%ebp),%eax
    1855:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1858:	88 55 e8             	mov    %dl,-0x18(%ebp)
    185b:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    185e:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1862:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1865:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1869:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    186c:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1870:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1873:	8b 45 08             	mov    0x8(%ebp),%eax
    1876:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    187a:	66 89 10             	mov    %dx,(%eax)
    187d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1881:	88 50 02             	mov    %dl,0x2(%eax)
}
    1884:	8b 45 08             	mov    0x8(%ebp),%eax
    1887:	c9                   	leave  
    1888:	c2 04 00             	ret    $0x4

0000188b <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    188b:	55                   	push   %ebp
    188c:	89 e5                	mov    %esp,%ebp
    188e:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1891:	8b 45 08             	mov    0x8(%ebp),%eax
    1894:	8b 00                	mov    (%eax),%eax
    1896:	83 ec 08             	sub    $0x8,%esp
    1899:	8d 55 0c             	lea    0xc(%ebp),%edx
    189c:	52                   	push   %edx
    189d:	50                   	push   %eax
    189e:	e8 24 ee ff ff       	call   6c7 <sendMessage>
    18a3:	83 c4 10             	add    $0x10,%esp
}
    18a6:	90                   	nop
    18a7:	c9                   	leave  
    18a8:	c3                   	ret    

000018a9 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    18a9:	55                   	push   %ebp
    18aa:	89 e5                	mov    %esp,%ebp
    18ac:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    18af:	83 ec 0c             	sub    $0xc,%esp
    18b2:	68 98 00 00 00       	push   $0x98
    18b7:	e8 f5 f1 ff ff       	call   ab1 <malloc>
    18bc:	83 c4 10             	add    $0x10,%esp
    18bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    18c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18c6:	75 15                	jne    18dd <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    18c8:	83 ec 04             	sub    $0x4,%esp
    18cb:	ff 75 08             	pushl  0x8(%ebp)
    18ce:	68 60 28 00 00       	push   $0x2860
    18d3:	6a 01                	push   $0x1
    18d5:	e8 04 ef ff ff       	call   7de <printf>
    18da:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    18dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e0:	05 84 00 00 00       	add    $0x84,%eax
    18e5:	83 ec 08             	sub    $0x8,%esp
    18e8:	ff 75 08             	pushl  0x8(%ebp)
    18eb:	50                   	push   %eax
    18ec:	e8 fd ea ff ff       	call   3ee <strcpy>
    18f1:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    18f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f7:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    18fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1901:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1908:	8b 45 f4             	mov    -0xc(%ebp),%eax
    190b:	8b 40 3c             	mov    0x3c(%eax),%eax
    190e:	89 c2                	mov    %eax,%edx
    1910:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1913:	8b 40 40             	mov    0x40(%eax),%eax
    1916:	0f af d0             	imul   %eax,%edx
    1919:	89 d0                	mov    %edx,%eax
    191b:	01 c0                	add    %eax,%eax
    191d:	01 d0                	add    %edx,%eax
    191f:	83 ec 0c             	sub    $0xc,%esp
    1922:	50                   	push   %eax
    1923:	e8 89 f1 ff ff       	call   ab1 <malloc>
    1928:	83 c4 10             	add    $0x10,%esp
    192b:	89 c2                	mov    %eax,%edx
    192d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1930:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1933:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1936:	8b 40 54             	mov    0x54(%eax),%eax
    1939:	85 c0                	test   %eax,%eax
    193b:	75 15                	jne    1952 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    193d:	83 ec 04             	sub    $0x4,%esp
    1940:	ff 75 08             	pushl  0x8(%ebp)
    1943:	68 80 28 00 00       	push   $0x2880
    1948:	6a 01                	push   $0x1
    194a:	e8 8f ee ff ff       	call   7de <printf>
    194f:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1952:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1955:	8b 40 3c             	mov    0x3c(%eax),%eax
    1958:	89 c2                	mov    %eax,%edx
    195a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    195d:	8b 40 40             	mov    0x40(%eax),%eax
    1960:	0f af d0             	imul   %eax,%edx
    1963:	89 d0                	mov    %edx,%eax
    1965:	01 c0                	add    %eax,%eax
    1967:	01 c2                	add    %eax,%edx
    1969:	8b 45 f4             	mov    -0xc(%ebp),%eax
    196c:	8b 40 54             	mov    0x54(%eax),%eax
    196f:	83 ec 04             	sub    $0x4,%esp
    1972:	52                   	push   %edx
    1973:	68 ff ff ff 00       	push   $0xffffff
    1978:	50                   	push   %eax
    1979:	e8 06 eb ff ff       	call   484 <memset>
    197e:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1981:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1984:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    198b:	e8 0f ed ff ff       	call   69f <getpid>
    1990:	89 c2                	mov    %eax,%edx
    1992:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1995:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1998:	8b 45 f4             	mov    -0xc(%ebp),%eax
    199b:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    19a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a5:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    19ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19af:	8b 40 58             	mov    0x58(%eax),%eax
    19b2:	89 c2                	mov    %eax,%edx
    19b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19b7:	8b 40 5c             	mov    0x5c(%eax),%eax
    19ba:	0f af d0             	imul   %eax,%edx
    19bd:	89 d0                	mov    %edx,%eax
    19bf:	01 c0                	add    %eax,%eax
    19c1:	01 d0                	add    %edx,%eax
    19c3:	83 ec 0c             	sub    $0xc,%esp
    19c6:	50                   	push   %eax
    19c7:	e8 e5 f0 ff ff       	call   ab1 <malloc>
    19cc:	83 c4 10             	add    $0x10,%esp
    19cf:	89 c2                	mov    %eax,%edx
    19d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d4:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    19d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19da:	8b 40 70             	mov    0x70(%eax),%eax
    19dd:	85 c0                	test   %eax,%eax
    19df:	75 15                	jne    19f6 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    19e1:	83 ec 04             	sub    $0x4,%esp
    19e4:	ff 75 08             	pushl  0x8(%ebp)
    19e7:	68 a4 28 00 00       	push   $0x28a4
    19ec:	6a 01                	push   $0x1
    19ee:	e8 eb ed ff ff       	call   7de <printf>
    19f3:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    19f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19f9:	8b 40 3c             	mov    0x3c(%eax),%eax
    19fc:	89 c2                	mov    %eax,%edx
    19fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a01:	8b 40 40             	mov    0x40(%eax),%eax
    1a04:	0f af d0             	imul   %eax,%edx
    1a07:	89 d0                	mov    %edx,%eax
    1a09:	01 c0                	add    %eax,%eax
    1a0b:	01 c2                	add    %eax,%edx
    1a0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a10:	8b 40 54             	mov    0x54(%eax),%eax
    1a13:	83 ec 04             	sub    $0x4,%esp
    1a16:	52                   	push   %edx
    1a17:	68 ff 00 00 00       	push   $0xff
    1a1c:	50                   	push   %eax
    1a1d:	e8 62 ea ff ff       	call   484 <memset>
    1a22:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1a25:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a28:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a2b:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1a2e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1a32:	74 49                	je     1a7d <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1a34:	8b 45 10             	mov    0x10(%ebp),%eax
    1a37:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1a3d:	83 ec 0c             	sub    $0xc,%esp
    1a40:	50                   	push   %eax
    1a41:	e8 6b f0 ff ff       	call   ab1 <malloc>
    1a46:	83 c4 10             	add    $0x10,%esp
    1a49:	89 c2                	mov    %eax,%edx
    1a4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a4e:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1a51:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a54:	8b 55 10             	mov    0x10(%ebp),%edx
    1a57:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1a5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a5d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1a64:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a67:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1a6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a71:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1a78:	e9 8d 00 00 00       	jmp    1b0a <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1a7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a80:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1a87:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a8a:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1a91:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a94:	8b 40 20             	mov    0x20(%eax),%eax
    1a97:	89 c2                	mov    %eax,%edx
    1a99:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a9c:	8b 40 24             	mov    0x24(%eax),%eax
    1a9f:	0f af d0             	imul   %eax,%edx
    1aa2:	89 d0                	mov    %edx,%eax
    1aa4:	01 c0                	add    %eax,%eax
    1aa6:	01 d0                	add    %edx,%eax
    1aa8:	83 ec 0c             	sub    $0xc,%esp
    1aab:	50                   	push   %eax
    1aac:	e8 00 f0 ff ff       	call   ab1 <malloc>
    1ab1:	83 c4 10             	add    $0x10,%esp
    1ab4:	89 c2                	mov    %eax,%edx
    1ab6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ab9:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1abc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1abf:	8b 40 38             	mov    0x38(%eax),%eax
    1ac2:	85 c0                	test   %eax,%eax
    1ac4:	75 15                	jne    1adb <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1ac6:	83 ec 04             	sub    $0x4,%esp
    1ac9:	ff 75 08             	pushl  0x8(%ebp)
    1acc:	68 cc 28 00 00       	push   $0x28cc
    1ad1:	6a 01                	push   $0x1
    1ad3:	e8 06 ed ff ff       	call   7de <printf>
    1ad8:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1adb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ade:	8b 40 20             	mov    0x20(%eax),%eax
    1ae1:	89 c2                	mov    %eax,%edx
    1ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ae6:	8b 40 24             	mov    0x24(%eax),%eax
    1ae9:	0f af d0             	imul   %eax,%edx
    1aec:	89 d0                	mov    %edx,%eax
    1aee:	01 c0                	add    %eax,%eax
    1af0:	01 c2                	add    %eax,%edx
    1af2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1af5:	8b 40 38             	mov    0x38(%eax),%eax
    1af8:	83 ec 04             	sub    $0x4,%esp
    1afb:	52                   	push   %edx
    1afc:	68 ff ff ff 00       	push   $0xffffff
    1b01:	50                   	push   %eax
    1b02:	e8 7d e9 ff ff       	call   484 <memset>
    1b07:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1b0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1b0d:	c9                   	leave  
    1b0e:	c3                   	ret    

00001b0f <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1b0f:	55                   	push   %ebp
    1b10:	89 e5                	mov    %esp,%ebp
    1b12:	57                   	push   %edi
    1b13:	56                   	push   %esi
    1b14:	53                   	push   %ebx
    1b15:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1b18:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b1b:	83 f8 03             	cmp    $0x3,%eax
    1b1e:	74 02                	je     1b22 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1b20:	eb 7c                	jmp    1b9e <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1b22:	8b 45 08             	mov    0x8(%ebp),%eax
    1b25:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1b28:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2b:	8b 48 18             	mov    0x18(%eax),%ecx
    1b2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b31:	8b 50 5c             	mov    0x5c(%eax),%edx
    1b34:	8b 45 08             	mov    0x8(%ebp),%eax
    1b37:	8b 40 58             	mov    0x58(%eax),%eax
    1b3a:	8b 75 08             	mov    0x8(%ebp),%esi
    1b3d:	83 c6 58             	add    $0x58,%esi
    1b40:	83 ec 04             	sub    $0x4,%esp
    1b43:	53                   	push   %ebx
    1b44:	51                   	push   %ecx
    1b45:	6a 00                	push   $0x0
    1b47:	52                   	push   %edx
    1b48:	50                   	push   %eax
    1b49:	6a 00                	push   $0x0
    1b4b:	6a 00                	push   $0x0
    1b4d:	56                   	push   %esi
    1b4e:	6a 00                	push   $0x0
    1b50:	6a 00                	push   $0x0
    1b52:	ff 75 08             	pushl  0x8(%ebp)
    1b55:	e8 65 eb ff ff       	call   6bf <paintWindow>
    1b5a:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1b5d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b60:	8b 70 1c             	mov    0x1c(%eax),%esi
    1b63:	8b 45 08             	mov    0x8(%ebp),%eax
    1b66:	8b 58 18             	mov    0x18(%eax),%ebx
    1b69:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6c:	8b 48 08             	mov    0x8(%eax),%ecx
    1b6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b72:	8b 50 40             	mov    0x40(%eax),%edx
    1b75:	8b 45 08             	mov    0x8(%ebp),%eax
    1b78:	8b 40 3c             	mov    0x3c(%eax),%eax
    1b7b:	8b 7d 08             	mov    0x8(%ebp),%edi
    1b7e:	83 c7 3c             	add    $0x3c,%edi
    1b81:	83 ec 04             	sub    $0x4,%esp
    1b84:	56                   	push   %esi
    1b85:	53                   	push   %ebx
    1b86:	51                   	push   %ecx
    1b87:	52                   	push   %edx
    1b88:	50                   	push   %eax
    1b89:	6a 00                	push   $0x0
    1b8b:	6a 00                	push   $0x0
    1b8d:	57                   	push   %edi
    1b8e:	6a 32                	push   $0x32
    1b90:	6a 00                	push   $0x0
    1b92:	ff 75 08             	pushl  0x8(%ebp)
    1b95:	e8 25 eb ff ff       	call   6bf <paintWindow>
    1b9a:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1b9d:	90                   	nop
        default: break;
            
            
    }
    return False;
    1b9e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1ba3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1ba6:	5b                   	pop    %ebx
    1ba7:	5e                   	pop    %esi
    1ba8:	5f                   	pop    %edi
    1ba9:	5d                   	pop    %ebp
    1baa:	c3                   	ret    

00001bab <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1bab:	55                   	push   %ebp
    1bac:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1bae:	8b 45 0c             	mov    0xc(%ebp),%eax
    1bb1:	8b 50 08             	mov    0x8(%eax),%edx
    1bb4:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb7:	8b 00                	mov    (%eax),%eax
    1bb9:	39 c2                	cmp    %eax,%edx
    1bbb:	74 07                	je     1bc4 <APPreJudge+0x19>
        return False;
    1bbd:	b8 00 00 00 00       	mov    $0x0,%eax
    1bc2:	eb 05                	jmp    1bc9 <APPreJudge+0x1e>
    return True;
    1bc4:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1bc9:	5d                   	pop    %ebp
    1bca:	c3                   	ret    

00001bcb <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1bcb:	55                   	push   %ebp
    1bcc:	89 e5                	mov    %esp,%ebp
    1bce:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1bd1:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd4:	8b 55 0c             	mov    0xc(%ebp),%edx
    1bd7:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1bdd:	83 ec 0c             	sub    $0xc,%esp
    1be0:	ff 75 08             	pushl  0x8(%ebp)
    1be3:	e8 ef ea ff ff       	call   6d7 <registWindow>
    1be8:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1beb:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1bf2:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf5:	8b 00                	mov    (%eax),%eax
    1bf7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1bfa:	ff 75 f4             	pushl  -0xc(%ebp)
    1bfd:	ff 75 f0             	pushl  -0x10(%ebp)
    1c00:	ff 75 ec             	pushl  -0x14(%ebp)
    1c03:	ff 75 08             	pushl  0x8(%ebp)
    1c06:	e8 80 fc ff ff       	call   188b <APSendMessage>
    1c0b:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1c0e:	83 ec 0c             	sub    $0xc,%esp
    1c11:	ff 75 08             	pushl  0x8(%ebp)
    1c14:	e8 b6 ea ff ff       	call   6cf <getMessage>
    1c19:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1c1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c1f:	83 c0 74             	add    $0x74,%eax
    1c22:	83 ec 08             	sub    $0x8,%esp
    1c25:	50                   	push   %eax
    1c26:	ff 75 08             	pushl  0x8(%ebp)
    1c29:	e8 7d ff ff ff       	call   1bab <APPreJudge>
    1c2e:	83 c4 10             	add    $0x10,%esp
    1c31:	84 c0                	test   %al,%al
    1c33:	74 1b                	je     1c50 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1c35:	8b 45 08             	mov    0x8(%ebp),%eax
    1c38:	ff 70 7c             	pushl  0x7c(%eax)
    1c3b:	ff 70 78             	pushl  0x78(%eax)
    1c3e:	ff 70 74             	pushl  0x74(%eax)
    1c41:	ff 75 08             	pushl  0x8(%ebp)
    1c44:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c47:	ff d0                	call   *%eax
    1c49:	83 c4 10             	add    $0x10,%esp
    1c4c:	84 c0                	test   %al,%al
    1c4e:	75 0c                	jne    1c5c <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1c50:	8b 45 08             	mov    0x8(%ebp),%eax
    1c53:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1c5a:	eb b2                	jmp    1c0e <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1c5c:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1c5d:	90                   	nop
    1c5e:	c9                   	leave  
    1c5f:	c3                   	ret    

00001c60 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1c60:	55                   	push   %ebp
    1c61:	89 e5                	mov    %esp,%ebp
    1c63:	57                   	push   %edi
    1c64:	56                   	push   %esi
    1c65:	53                   	push   %ebx
    1c66:	83 ec 7c             	sub    $0x7c,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    1c69:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c6c:	6a 08                	push   $0x8
    1c6e:	6a 08                	push   $0x8
    1c70:	6a 08                	push   $0x8
    1c72:	50                   	push   %eax
    1c73:	e8 ce fb ff ff       	call   1846 <RGB>
    1c78:	83 c4 0c             	add    $0xc,%esp
    1c7b:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1c7f:	66 89 45 bd          	mov    %ax,-0x43(%ebp)
    1c83:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1c87:	88 45 bf             	mov    %al,-0x41(%ebp)
    APSetFont(&wnd->TitleDc,font);
    1c8a:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8d:	8d 58 58             	lea    0x58(%eax),%ebx
    1c90:	8d 55 88             	lea    -0x78(%ebp),%edx
    1c93:	83 ec 04             	sub    $0x4,%esp
    1c96:	83 ec 04             	sub    $0x4,%esp
    1c99:	89 e0                	mov    %esp,%eax
    1c9b:	0f b7 4d bd          	movzwl -0x43(%ebp),%ecx
    1c9f:	66 89 08             	mov    %cx,(%eax)
    1ca2:	0f b6 4d bf          	movzbl -0x41(%ebp),%ecx
    1ca6:	88 48 02             	mov    %cl,0x2(%eax)
    1ca9:	53                   	push   %ebx
    1caa:	52                   	push   %edx
    1cab:	e8 fe f2 ff ff       	call   fae <APSetFont>
    1cb0:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    1cb3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb6:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    1cbc:	8b 45 08             	mov    0x8(%ebp),%eax
    1cbf:	83 c0 58             	add    $0x58,%eax
    1cc2:	6a 14                	push   $0x14
    1cc4:	6a 14                	push   $0x14
    1cc6:	52                   	push   %edx
    1cc7:	50                   	push   %eax
    1cc8:	e8 ce f8 ff ff       	call   159b <APDrawText>
    1ccd:	83 c4 10             	add    $0x10,%esp
    
    if (!iconReady)
    1cd0:	a1 e4 6e 00 00       	mov    0x6ee4,%eax
    1cd5:	85 c0                	test   %eax,%eax
    1cd7:	0f 85 7a 02 00 00    	jne    1f57 <APGridPaint+0x2f7>
    {
        iconReady = 1;
    1cdd:	c7 05 e4 6e 00 00 01 	movl   $0x1,0x6ee4
    1ce4:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1ce7:	8d 45 88             	lea    -0x78(%ebp),%eax
    1cea:	83 ec 08             	sub    $0x8,%esp
    1ced:	68 f3 28 00 00       	push   $0x28f3
    1cf2:	50                   	push   %eax
    1cf3:	e8 6c ef ff ff       	call   c64 <APLoadBitmap>
    1cf8:	83 c4 0c             	add    $0xc,%esp
    1cfb:	8b 45 88             	mov    -0x78(%ebp),%eax
    1cfe:	a3 08 6f 00 00       	mov    %eax,0x6f08
    1d03:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1d06:	a3 0c 6f 00 00       	mov    %eax,0x6f0c
    1d0b:	8b 45 90             	mov    -0x70(%ebp),%eax
    1d0e:	a3 10 6f 00 00       	mov    %eax,0x6f10
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1d13:	83 ec 04             	sub    $0x4,%esp
    1d16:	ff 35 10 6f 00 00    	pushl  0x6f10
    1d1c:	ff 35 0c 6f 00 00    	pushl  0x6f0c
    1d22:	ff 35 08 6f 00 00    	pushl  0x6f08
    1d28:	e8 71 f1 ff ff       	call   e9e <APCreateCompatibleDCFromBitmap>
    1d2d:	83 c4 10             	add    $0x10,%esp
    1d30:	a3 14 6f 00 00       	mov    %eax,0x6f14
        grid_river = APLoadBitmap ("grid_river.bmp");
    1d35:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d38:	83 ec 08             	sub    $0x8,%esp
    1d3b:	68 01 29 00 00       	push   $0x2901
    1d40:	50                   	push   %eax
    1d41:	e8 1e ef ff ff       	call   c64 <APLoadBitmap>
    1d46:	83 c4 0c             	add    $0xc,%esp
    1d49:	8b 45 88             	mov    -0x78(%ebp),%eax
    1d4c:	a3 50 6f 00 00       	mov    %eax,0x6f50
    1d51:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1d54:	a3 54 6f 00 00       	mov    %eax,0x6f54
    1d59:	8b 45 90             	mov    -0x70(%ebp),%eax
    1d5c:	a3 58 6f 00 00       	mov    %eax,0x6f58
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1d61:	83 ec 04             	sub    $0x4,%esp
    1d64:	ff 35 58 6f 00 00    	pushl  0x6f58
    1d6a:	ff 35 54 6f 00 00    	pushl  0x6f54
    1d70:	ff 35 50 6f 00 00    	pushl  0x6f50
    1d76:	e8 23 f1 ff ff       	call   e9e <APCreateCompatibleDCFromBitmap>
    1d7b:	83 c4 10             	add    $0x10,%esp
    1d7e:	a3 40 6f 00 00       	mov    %eax,0x6f40
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1d83:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d86:	83 ec 08             	sub    $0x8,%esp
    1d89:	68 10 29 00 00       	push   $0x2910
    1d8e:	50                   	push   %eax
    1d8f:	e8 d0 ee ff ff       	call   c64 <APLoadBitmap>
    1d94:	83 c4 0c             	add    $0xc,%esp
    1d97:	8b 45 88             	mov    -0x78(%ebp),%eax
    1d9a:	a3 44 6f 00 00       	mov    %eax,0x6f44
    1d9f:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1da2:	a3 48 6f 00 00       	mov    %eax,0x6f48
    1da7:	8b 45 90             	mov    -0x70(%ebp),%eax
    1daa:	a3 4c 6f 00 00       	mov    %eax,0x6f4c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1daf:	83 ec 04             	sub    $0x4,%esp
    1db2:	ff 35 4c 6f 00 00    	pushl  0x6f4c
    1db8:	ff 35 48 6f 00 00    	pushl  0x6f48
    1dbe:	ff 35 44 6f 00 00    	pushl  0x6f44
    1dc4:	e8 d5 f0 ff ff       	call   e9e <APCreateCompatibleDCFromBitmap>
    1dc9:	83 c4 10             	add    $0x10,%esp
    1dcc:	a3 e8 6e 00 00       	mov    %eax,0x6ee8
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1dd1:	8d 45 88             	lea    -0x78(%ebp),%eax
    1dd4:	83 ec 08             	sub    $0x8,%esp
    1dd7:	68 1f 29 00 00       	push   $0x291f
    1ddc:	50                   	push   %eax
    1ddd:	e8 82 ee ff ff       	call   c64 <APLoadBitmap>
    1de2:	83 c4 0c             	add    $0xc,%esp
    1de5:	8b 45 88             	mov    -0x78(%ebp),%eax
    1de8:	a3 1c 6f 00 00       	mov    %eax,0x6f1c
    1ded:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1df0:	a3 20 6f 00 00       	mov    %eax,0x6f20
    1df5:	8b 45 90             	mov    -0x70(%ebp),%eax
    1df8:	a3 24 6f 00 00       	mov    %eax,0x6f24
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1dfd:	83 ec 04             	sub    $0x4,%esp
    1e00:	ff 35 24 6f 00 00    	pushl  0x6f24
    1e06:	ff 35 20 6f 00 00    	pushl  0x6f20
    1e0c:	ff 35 1c 6f 00 00    	pushl  0x6f1c
    1e12:	e8 87 f0 ff ff       	call   e9e <APCreateCompatibleDCFromBitmap>
    1e17:	83 c4 10             	add    $0x10,%esp
    1e1a:	a3 60 6f 00 00       	mov    %eax,0x6f60
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1e1f:	8d 45 88             	lea    -0x78(%ebp),%eax
    1e22:	83 ec 08             	sub    $0x8,%esp
    1e25:	68 2d 29 00 00       	push   $0x292d
    1e2a:	50                   	push   %eax
    1e2b:	e8 34 ee ff ff       	call   c64 <APLoadBitmap>
    1e30:	83 c4 0c             	add    $0xc,%esp
    1e33:	8b 45 88             	mov    -0x78(%ebp),%eax
    1e36:	a3 f8 6e 00 00       	mov    %eax,0x6ef8
    1e3b:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1e3e:	a3 fc 6e 00 00       	mov    %eax,0x6efc
    1e43:	8b 45 90             	mov    -0x70(%ebp),%eax
    1e46:	a3 00 6f 00 00       	mov    %eax,0x6f00
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1e4b:	83 ec 04             	sub    $0x4,%esp
    1e4e:	ff 35 00 6f 00 00    	pushl  0x6f00
    1e54:	ff 35 fc 6e 00 00    	pushl  0x6efc
    1e5a:	ff 35 f8 6e 00 00    	pushl  0x6ef8
    1e60:	e8 39 f0 ff ff       	call   e9e <APCreateCompatibleDCFromBitmap>
    1e65:	83 c4 10             	add    $0x10,%esp
    1e68:	a3 18 6f 00 00       	mov    %eax,0x6f18
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1e6d:	8d 45 88             	lea    -0x78(%ebp),%eax
    1e70:	83 ec 08             	sub    $0x8,%esp
    1e73:	68 3d 29 00 00       	push   $0x293d
    1e78:	50                   	push   %eax
    1e79:	e8 e6 ed ff ff       	call   c64 <APLoadBitmap>
    1e7e:	83 c4 0c             	add    $0xc,%esp
    1e81:	8b 45 88             	mov    -0x78(%ebp),%eax
    1e84:	a3 ec 6e 00 00       	mov    %eax,0x6eec
    1e89:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1e8c:	a3 f0 6e 00 00       	mov    %eax,0x6ef0
    1e91:	8b 45 90             	mov    -0x70(%ebp),%eax
    1e94:	a3 f4 6e 00 00       	mov    %eax,0x6ef4
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1e99:	83 ec 04             	sub    $0x4,%esp
    1e9c:	ff 35 f4 6e 00 00    	pushl  0x6ef4
    1ea2:	ff 35 f0 6e 00 00    	pushl  0x6ef0
    1ea8:	ff 35 ec 6e 00 00    	pushl  0x6eec
    1eae:	e8 eb ef ff ff       	call   e9e <APCreateCompatibleDCFromBitmap>
    1eb3:	83 c4 10             	add    $0x10,%esp
    1eb6:	a3 04 6f 00 00       	mov    %eax,0x6f04
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1ebb:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ebe:	83 ec 08             	sub    $0x8,%esp
    1ec1:	68 4f 29 00 00       	push   $0x294f
    1ec6:	50                   	push   %eax
    1ec7:	e8 98 ed ff ff       	call   c64 <APLoadBitmap>
    1ecc:	83 c4 0c             	add    $0xc,%esp
    1ecf:	8b 45 88             	mov    -0x78(%ebp),%eax
    1ed2:	a3 34 6f 00 00       	mov    %eax,0x6f34
    1ed7:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1eda:	a3 38 6f 00 00       	mov    %eax,0x6f38
    1edf:	8b 45 90             	mov    -0x70(%ebp),%eax
    1ee2:	a3 3c 6f 00 00       	mov    %eax,0x6f3c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1ee7:	83 ec 04             	sub    $0x4,%esp
    1eea:	ff 35 3c 6f 00 00    	pushl  0x6f3c
    1ef0:	ff 35 38 6f 00 00    	pushl  0x6f38
    1ef6:	ff 35 34 6f 00 00    	pushl  0x6f34
    1efc:	e8 9d ef ff ff       	call   e9e <APCreateCompatibleDCFromBitmap>
    1f01:	83 c4 10             	add    $0x10,%esp
    1f04:	a3 64 6f 00 00       	mov    %eax,0x6f64
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    1f09:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f0c:	83 ec 08             	sub    $0x8,%esp
    1f0f:	68 5e 29 00 00       	push   $0x295e
    1f14:	50                   	push   %eax
    1f15:	e8 4a ed ff ff       	call   c64 <APLoadBitmap>
    1f1a:	83 c4 0c             	add    $0xc,%esp
    1f1d:	8b 45 88             	mov    -0x78(%ebp),%eax
    1f20:	a3 28 6f 00 00       	mov    %eax,0x6f28
    1f25:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1f28:	a3 2c 6f 00 00       	mov    %eax,0x6f2c
    1f2d:	8b 45 90             	mov    -0x70(%ebp),%eax
    1f30:	a3 30 6f 00 00       	mov    %eax,0x6f30
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    1f35:	83 ec 04             	sub    $0x4,%esp
    1f38:	ff 35 30 6f 00 00    	pushl  0x6f30
    1f3e:	ff 35 2c 6f 00 00    	pushl  0x6f2c
    1f44:	ff 35 28 6f 00 00    	pushl  0x6f28
    1f4a:	e8 4f ef ff ff       	call   e9e <APCreateCompatibleDCFromBitmap>
    1f4f:	83 c4 10             	add    $0x10,%esp
    1f52:	a3 5c 6f 00 00       	mov    %eax,0x6f5c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1f57:	8b 45 08             	mov    0x8(%ebp),%eax
    1f5a:	8b 40 08             	mov    0x8(%eax),%eax
    1f5d:	85 c0                	test   %eax,%eax
    1f5f:	75 17                	jne    1f78 <APGridPaint+0x318>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1f61:	83 ec 08             	sub    $0x8,%esp
    1f64:	68 70 29 00 00       	push   $0x2970
    1f69:	6a 01                	push   $0x1
    1f6b:	e8 6e e8 ff ff       	call   7de <printf>
    1f70:	83 c4 10             	add    $0x10,%esp
        return;
    1f73:	e9 fe 04 00 00       	jmp    2476 <APGridPaint+0x816>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1f78:	8b 45 08             	mov    0x8(%ebp),%eax
    1f7b:	8b 40 10             	mov    0x10(%eax),%eax
    1f7e:	85 c0                	test   %eax,%eax
    1f80:	7e 10                	jle    1f92 <APGridPaint+0x332>
    1f82:	8b 45 08             	mov    0x8(%ebp),%eax
    1f85:	8b 50 14             	mov    0x14(%eax),%edx
    1f88:	8b 45 08             	mov    0x8(%ebp),%eax
    1f8b:	8b 40 10             	mov    0x10(%eax),%eax
    1f8e:	39 c2                	cmp    %eax,%edx
    1f90:	7c 17                	jl     1fa9 <APGridPaint+0x349>
    {
        printf(1,"Grid mode page error!");
    1f92:	83 ec 08             	sub    $0x8,%esp
    1f95:	68 96 29 00 00       	push   $0x2996
    1f9a:	6a 01                	push   $0x1
    1f9c:	e8 3d e8 ff ff       	call   7de <printf>
    1fa1:	83 c4 10             	add    $0x10,%esp
        return;
    1fa4:	e9 cd 04 00 00       	jmp    2476 <APGridPaint+0x816>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1fa9:	8b 45 08             	mov    0x8(%ebp),%eax
    1fac:	8b 40 14             	mov    0x14(%eax),%eax
    1faf:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1fb5:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1fb8:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1fbb:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1fbe:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1fc5:	e9 f4 03 00 00       	jmp    23be <APGridPaint+0x75e>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1fca:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1fd1:	e9 da 03 00 00       	jmp    23b0 <APGridPaint+0x750>
        {
            index = start + GRID_W_NUMBER * j + i;
    1fd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fd9:	c1 e0 04             	shl    $0x4,%eax
    1fdc:	89 c2                	mov    %eax,%edx
    1fde:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1fe1:	01 c2                	add    %eax,%edx
    1fe3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fe6:	01 d0                	add    %edx,%eax
    1fe8:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1feb:	8b 45 08             	mov    0x8(%ebp),%eax
    1fee:	8b 40 0c             	mov    0xc(%eax),%eax
    1ff1:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1ff4:	c1 e2 02             	shl    $0x2,%edx
    1ff7:	01 d0                	add    %edx,%eax
    1ff9:	8b 00                	mov    (%eax),%eax
    1ffb:	83 f8 0a             	cmp    $0xa,%eax
    1ffe:	0f 87 a7 03 00 00    	ja     23ab <APGridPaint+0x74b>
    2004:	8b 04 85 ac 29 00 00 	mov    0x29ac(,%eax,4),%eax
    200b:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    200d:	8d 45 c0             	lea    -0x40(%ebp),%eax
    2010:	6a 0c                	push   $0xc
    2012:	6a 0c                	push   $0xc
    2014:	6a 0c                	push   $0xc
    2016:	50                   	push   %eax
    2017:	e8 2a f8 ff ff       	call   1846 <RGB>
    201c:	83 c4 0c             	add    $0xc,%esp
    201f:	8b 1d 14 6f 00 00    	mov    0x6f14,%ebx
    2025:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2028:	6b c8 32             	imul   $0x32,%eax,%ecx
    202b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    202e:	6b c0 32             	imul   $0x32,%eax,%eax
    2031:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2034:	8b 45 08             	mov    0x8(%ebp),%eax
    2037:	8d 78 3c             	lea    0x3c(%eax),%edi
    203a:	83 ec 0c             	sub    $0xc,%esp
    203d:	83 ec 04             	sub    $0x4,%esp
    2040:	89 e0                	mov    %esp,%eax
    2042:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    2046:	66 89 30             	mov    %si,(%eax)
    2049:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    204d:	88 50 02             	mov    %dl,0x2(%eax)
    2050:	6a 32                	push   $0x32
    2052:	6a 32                	push   $0x32
    2054:	6a 00                	push   $0x0
    2056:	6a 00                	push   $0x0
    2058:	53                   	push   %ebx
    2059:	51                   	push   %ecx
    205a:	ff 75 84             	pushl  -0x7c(%ebp)
    205d:	57                   	push   %edi
    205e:	e8 3f f6 ff ff       	call   16a2 <APDcCopy>
    2063:	83 c4 30             	add    $0x30,%esp
                    break;
    2066:	e9 41 03 00 00       	jmp    23ac <APGridPaint+0x74c>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    206b:	8d 45 88             	lea    -0x78(%ebp),%eax
    206e:	6a 69                	push   $0x69
    2070:	6a 69                	push   $0x69
    2072:	6a 69                	push   $0x69
    2074:	50                   	push   %eax
    2075:	e8 cc f7 ff ff       	call   1846 <RGB>
    207a:	83 c4 0c             	add    $0xc,%esp
    207d:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2081:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    2085:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2089:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    208c:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    2093:	8d 45 88             	lea    -0x78(%ebp),%eax
    2096:	6a 69                	push   $0x69
    2098:	6a 69                	push   $0x69
    209a:	6a 69                	push   $0x69
    209c:	50                   	push   %eax
    209d:	e8 a4 f7 ff ff       	call   1846 <RGB>
    20a2:	83 c4 0c             	add    $0xc,%esp
    20a5:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    20a9:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    20ad:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    20b1:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    20b4:	8b 45 08             	mov    0x8(%ebp),%eax
    20b7:	8d 50 3c             	lea    0x3c(%eax),%edx
    20ba:	8d 45 88             	lea    -0x78(%ebp),%eax
    20bd:	ff 75 ac             	pushl  -0x54(%ebp)
    20c0:	ff 75 a8             	pushl  -0x58(%ebp)
    20c3:	52                   	push   %edx
    20c4:	50                   	push   %eax
    20c5:	e8 69 ee ff ff       	call   f33 <APSetPen>
    20ca:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    20cd:	8b 45 08             	mov    0x8(%ebp),%eax
    20d0:	8d 58 3c             	lea    0x3c(%eax),%ebx
    20d3:	8d 55 88             	lea    -0x78(%ebp),%edx
    20d6:	83 ec 04             	sub    $0x4,%esp
    20d9:	83 ec 04             	sub    $0x4,%esp
    20dc:	89 e0                	mov    %esp,%eax
    20de:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    20e2:	66 89 08             	mov    %cx,(%eax)
    20e5:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    20e9:	88 48 02             	mov    %cl,0x2(%eax)
    20ec:	53                   	push   %ebx
    20ed:	52                   	push   %edx
    20ee:	e8 79 ee ff ff       	call   f6c <APSetBrush>
    20f3:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    20f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20f9:	6b d0 32             	imul   $0x32,%eax,%edx
    20fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20ff:	6b c0 32             	imul   $0x32,%eax,%eax
    2102:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2105:	83 c1 3c             	add    $0x3c,%ecx
    2108:	83 ec 0c             	sub    $0xc,%esp
    210b:	6a 32                	push   $0x32
    210d:	6a 32                	push   $0x32
    210f:	52                   	push   %edx
    2110:	50                   	push   %eax
    2111:	51                   	push   %ecx
    2112:	e8 7f f2 ff ff       	call   1396 <APDrawRect>
    2117:	83 c4 20             	add    $0x20,%esp
                    break;
    211a:	e9 8d 02 00 00       	jmp    23ac <APGridPaint+0x74c>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    211f:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    2122:	6a 0c                	push   $0xc
    2124:	6a 0c                	push   $0xc
    2126:	6a 0c                	push   $0xc
    2128:	50                   	push   %eax
    2129:	e8 18 f7 ff ff       	call   1846 <RGB>
    212e:	83 c4 0c             	add    $0xc,%esp
    2131:	8b 1d 64 6f 00 00    	mov    0x6f64,%ebx
    2137:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    213a:	6b c8 32             	imul   $0x32,%eax,%ecx
    213d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2140:	6b c0 32             	imul   $0x32,%eax,%eax
    2143:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2146:	8b 45 08             	mov    0x8(%ebp),%eax
    2149:	8d 78 3c             	lea    0x3c(%eax),%edi
    214c:	83 ec 0c             	sub    $0xc,%esp
    214f:	83 ec 04             	sub    $0x4,%esp
    2152:	89 e0                	mov    %esp,%eax
    2154:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    2158:	66 89 30             	mov    %si,(%eax)
    215b:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    215f:	88 50 02             	mov    %dl,0x2(%eax)
    2162:	6a 32                	push   $0x32
    2164:	6a 32                	push   $0x32
    2166:	6a 00                	push   $0x0
    2168:	6a 00                	push   $0x0
    216a:	53                   	push   %ebx
    216b:	51                   	push   %ecx
    216c:	ff 75 84             	pushl  -0x7c(%ebp)
    216f:	57                   	push   %edi
    2170:	e8 2d f5 ff ff       	call   16a2 <APDcCopy>
    2175:	83 c4 30             	add    $0x30,%esp
                    break;
    2178:	e9 2f 02 00 00       	jmp    23ac <APGridPaint+0x74c>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    217d:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    2180:	6a 0c                	push   $0xc
    2182:	6a 0c                	push   $0xc
    2184:	6a 0c                	push   $0xc
    2186:	50                   	push   %eax
    2187:	e8 ba f6 ff ff       	call   1846 <RGB>
    218c:	83 c4 0c             	add    $0xc,%esp
    218f:	8b 1d 40 6f 00 00    	mov    0x6f40,%ebx
    2195:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2198:	6b c8 32             	imul   $0x32,%eax,%ecx
    219b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    219e:	6b c0 32             	imul   $0x32,%eax,%eax
    21a1:	89 45 84             	mov    %eax,-0x7c(%ebp)
    21a4:	8b 45 08             	mov    0x8(%ebp),%eax
    21a7:	8d 78 3c             	lea    0x3c(%eax),%edi
    21aa:	83 ec 0c             	sub    $0xc,%esp
    21ad:	83 ec 04             	sub    $0x4,%esp
    21b0:	89 e0                	mov    %esp,%eax
    21b2:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    21b6:	66 89 30             	mov    %si,(%eax)
    21b9:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    21bd:	88 50 02             	mov    %dl,0x2(%eax)
    21c0:	6a 32                	push   $0x32
    21c2:	6a 32                	push   $0x32
    21c4:	6a 00                	push   $0x0
    21c6:	6a 00                	push   $0x0
    21c8:	53                   	push   %ebx
    21c9:	51                   	push   %ecx
    21ca:	ff 75 84             	pushl  -0x7c(%ebp)
    21cd:	57                   	push   %edi
    21ce:	e8 cf f4 ff ff       	call   16a2 <APDcCopy>
    21d3:	83 c4 30             	add    $0x30,%esp
                    break;
    21d6:	e9 d1 01 00 00       	jmp    23ac <APGridPaint+0x74c>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    21db:	8d 45 c9             	lea    -0x37(%ebp),%eax
    21de:	6a 0c                	push   $0xc
    21e0:	6a 0c                	push   $0xc
    21e2:	6a 0c                	push   $0xc
    21e4:	50                   	push   %eax
    21e5:	e8 5c f6 ff ff       	call   1846 <RGB>
    21ea:	83 c4 0c             	add    $0xc,%esp
    21ed:	8b 1d 18 6f 00 00    	mov    0x6f18,%ebx
    21f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21f6:	6b c8 32             	imul   $0x32,%eax,%ecx
    21f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    21fc:	6b c0 32             	imul   $0x32,%eax,%eax
    21ff:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2202:	8b 45 08             	mov    0x8(%ebp),%eax
    2205:	8d 78 3c             	lea    0x3c(%eax),%edi
    2208:	83 ec 0c             	sub    $0xc,%esp
    220b:	83 ec 04             	sub    $0x4,%esp
    220e:	89 e0                	mov    %esp,%eax
    2210:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    2214:	66 89 30             	mov    %si,(%eax)
    2217:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    221b:	88 50 02             	mov    %dl,0x2(%eax)
    221e:	6a 32                	push   $0x32
    2220:	6a 32                	push   $0x32
    2222:	6a 00                	push   $0x0
    2224:	6a 00                	push   $0x0
    2226:	53                   	push   %ebx
    2227:	51                   	push   %ecx
    2228:	ff 75 84             	pushl  -0x7c(%ebp)
    222b:	57                   	push   %edi
    222c:	e8 71 f4 ff ff       	call   16a2 <APDcCopy>
    2231:	83 c4 30             	add    $0x30,%esp
                    break;
    2234:	e9 73 01 00 00       	jmp    23ac <APGridPaint+0x74c>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2239:	8d 45 cc             	lea    -0x34(%ebp),%eax
    223c:	6a 0c                	push   $0xc
    223e:	6a 0c                	push   $0xc
    2240:	6a 0c                	push   $0xc
    2242:	50                   	push   %eax
    2243:	e8 fe f5 ff ff       	call   1846 <RGB>
    2248:	83 c4 0c             	add    $0xc,%esp
    224b:	8b 1d 60 6f 00 00    	mov    0x6f60,%ebx
    2251:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2254:	6b c8 32             	imul   $0x32,%eax,%ecx
    2257:	8b 45 e0             	mov    -0x20(%ebp),%eax
    225a:	6b c0 32             	imul   $0x32,%eax,%eax
    225d:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2260:	8b 45 08             	mov    0x8(%ebp),%eax
    2263:	8d 78 3c             	lea    0x3c(%eax),%edi
    2266:	83 ec 0c             	sub    $0xc,%esp
    2269:	83 ec 04             	sub    $0x4,%esp
    226c:	89 e0                	mov    %esp,%eax
    226e:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    2272:	66 89 30             	mov    %si,(%eax)
    2275:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    2279:	88 50 02             	mov    %dl,0x2(%eax)
    227c:	6a 32                	push   $0x32
    227e:	6a 32                	push   $0x32
    2280:	6a 00                	push   $0x0
    2282:	6a 00                	push   $0x0
    2284:	53                   	push   %ebx
    2285:	51                   	push   %ecx
    2286:	ff 75 84             	pushl  -0x7c(%ebp)
    2289:	57                   	push   %edi
    228a:	e8 13 f4 ff ff       	call   16a2 <APDcCopy>
    228f:	83 c4 30             	add    $0x30,%esp
                    break;
    2292:	e9 15 01 00 00       	jmp    23ac <APGridPaint+0x74c>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2297:	8d 45 cf             	lea    -0x31(%ebp),%eax
    229a:	6a 0c                	push   $0xc
    229c:	6a 0c                	push   $0xc
    229e:	6a 0c                	push   $0xc
    22a0:	50                   	push   %eax
    22a1:	e8 a0 f5 ff ff       	call   1846 <RGB>
    22a6:	83 c4 0c             	add    $0xc,%esp
    22a9:	8b 1d e8 6e 00 00    	mov    0x6ee8,%ebx
    22af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22b2:	6b c8 32             	imul   $0x32,%eax,%ecx
    22b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    22b8:	6b c0 32             	imul   $0x32,%eax,%eax
    22bb:	89 45 84             	mov    %eax,-0x7c(%ebp)
    22be:	8b 45 08             	mov    0x8(%ebp),%eax
    22c1:	8d 78 3c             	lea    0x3c(%eax),%edi
    22c4:	83 ec 0c             	sub    $0xc,%esp
    22c7:	83 ec 04             	sub    $0x4,%esp
    22ca:	89 e0                	mov    %esp,%eax
    22cc:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    22d0:	66 89 30             	mov    %si,(%eax)
    22d3:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    22d7:	88 50 02             	mov    %dl,0x2(%eax)
    22da:	6a 32                	push   $0x32
    22dc:	6a 32                	push   $0x32
    22de:	6a 00                	push   $0x0
    22e0:	6a 00                	push   $0x0
    22e2:	53                   	push   %ebx
    22e3:	51                   	push   %ecx
    22e4:	ff 75 84             	pushl  -0x7c(%ebp)
    22e7:	57                   	push   %edi
    22e8:	e8 b5 f3 ff ff       	call   16a2 <APDcCopy>
    22ed:	83 c4 30             	add    $0x30,%esp
                    break;
    22f0:	e9 b7 00 00 00       	jmp    23ac <APGridPaint+0x74c>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    22f5:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    22f8:	6a 0c                	push   $0xc
    22fa:	6a 0c                	push   $0xc
    22fc:	6a 0c                	push   $0xc
    22fe:	50                   	push   %eax
    22ff:	e8 42 f5 ff ff       	call   1846 <RGB>
    2304:	83 c4 0c             	add    $0xc,%esp
    2307:	8b 1d 04 6f 00 00    	mov    0x6f04,%ebx
    230d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2310:	6b c8 32             	imul   $0x32,%eax,%ecx
    2313:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2316:	6b c0 32             	imul   $0x32,%eax,%eax
    2319:	89 45 84             	mov    %eax,-0x7c(%ebp)
    231c:	8b 45 08             	mov    0x8(%ebp),%eax
    231f:	8d 78 3c             	lea    0x3c(%eax),%edi
    2322:	83 ec 0c             	sub    $0xc,%esp
    2325:	83 ec 04             	sub    $0x4,%esp
    2328:	89 e0                	mov    %esp,%eax
    232a:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    232e:	66 89 30             	mov    %si,(%eax)
    2331:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2335:	88 50 02             	mov    %dl,0x2(%eax)
    2338:	6a 32                	push   $0x32
    233a:	6a 32                	push   $0x32
    233c:	6a 00                	push   $0x0
    233e:	6a 00                	push   $0x0
    2340:	53                   	push   %ebx
    2341:	51                   	push   %ecx
    2342:	ff 75 84             	pushl  -0x7c(%ebp)
    2345:	57                   	push   %edi
    2346:	e8 57 f3 ff ff       	call   16a2 <APDcCopy>
    234b:	83 c4 30             	add    $0x30,%esp
                    break;
    234e:	eb 5c                	jmp    23ac <APGridPaint+0x74c>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2350:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    2353:	6a 0c                	push   $0xc
    2355:	6a 0c                	push   $0xc
    2357:	6a 0c                	push   $0xc
    2359:	50                   	push   %eax
    235a:	e8 e7 f4 ff ff       	call   1846 <RGB>
    235f:	83 c4 0c             	add    $0xc,%esp
    2362:	8b 1d 5c 6f 00 00    	mov    0x6f5c,%ebx
    2368:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    236b:	6b c8 32             	imul   $0x32,%eax,%ecx
    236e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2371:	6b c0 32             	imul   $0x32,%eax,%eax
    2374:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2377:	8b 45 08             	mov    0x8(%ebp),%eax
    237a:	8d 78 3c             	lea    0x3c(%eax),%edi
    237d:	83 ec 0c             	sub    $0xc,%esp
    2380:	83 ec 04             	sub    $0x4,%esp
    2383:	89 e0                	mov    %esp,%eax
    2385:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2389:	66 89 30             	mov    %si,(%eax)
    238c:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2390:	88 50 02             	mov    %dl,0x2(%eax)
    2393:	6a 32                	push   $0x32
    2395:	6a 32                	push   $0x32
    2397:	6a 00                	push   $0x0
    2399:	6a 00                	push   $0x0
    239b:	53                   	push   %ebx
    239c:	51                   	push   %ecx
    239d:	ff 75 84             	pushl  -0x7c(%ebp)
    23a0:	57                   	push   %edi
    23a1:	e8 fc f2 ff ff       	call   16a2 <APDcCopy>
    23a6:	83 c4 30             	add    $0x30,%esp
                    break;
    23a9:	eb 01                	jmp    23ac <APGridPaint+0x74c>
                default: break;
    23ab:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    23ac:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    23b0:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    23b4:	0f 8e 1c fc ff ff    	jle    1fd6 <APGridPaint+0x376>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    23ba:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    23be:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    23c2:	0f 8e 02 fc ff ff    	jle    1fca <APGridPaint+0x36a>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    23c8:	8d 45 88             	lea    -0x78(%ebp),%eax
    23cb:	68 cd 00 00 00       	push   $0xcd
    23d0:	6a 74                	push   $0x74
    23d2:	6a 18                	push   $0x18
    23d4:	50                   	push   %eax
    23d5:	e8 6c f4 ff ff       	call   1846 <RGB>
    23da:	83 c4 0c             	add    $0xc,%esp
    23dd:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    23e1:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    23e5:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    23e9:	88 45 b6             	mov    %al,-0x4a(%ebp)
    pen.size = 1;
    23ec:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    23f3:	8d 45 88             	lea    -0x78(%ebp),%eax
    23f6:	68 cd 00 00 00       	push   $0xcd
    23fb:	6a 74                	push   $0x74
    23fd:	6a 18                	push   $0x18
    23ff:	50                   	push   %eax
    2400:	e8 41 f4 ff ff       	call   1846 <RGB>
    2405:	83 c4 0c             	add    $0xc,%esp
    2408:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    240c:	66 89 45 b1          	mov    %ax,-0x4f(%ebp)
    2410:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2414:	88 45 b3             	mov    %al,-0x4d(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    2417:	8b 45 08             	mov    0x8(%ebp),%eax
    241a:	8d 50 58             	lea    0x58(%eax),%edx
    241d:	8d 45 88             	lea    -0x78(%ebp),%eax
    2420:	ff 75 b8             	pushl  -0x48(%ebp)
    2423:	ff 75 b4             	pushl  -0x4c(%ebp)
    2426:	52                   	push   %edx
    2427:	50                   	push   %eax
    2428:	e8 06 eb ff ff       	call   f33 <APSetPen>
    242d:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2430:	8b 45 08             	mov    0x8(%ebp),%eax
    2433:	8d 58 58             	lea    0x58(%eax),%ebx
    2436:	8d 55 88             	lea    -0x78(%ebp),%edx
    2439:	83 ec 04             	sub    $0x4,%esp
    243c:	83 ec 04             	sub    $0x4,%esp
    243f:	89 e0                	mov    %esp,%eax
    2441:	0f b7 4d b1          	movzwl -0x4f(%ebp),%ecx
    2445:	66 89 08             	mov    %cx,(%eax)
    2448:	0f b6 4d b3          	movzbl -0x4d(%ebp),%ecx
    244c:	88 48 02             	mov    %cl,0x2(%eax)
    244f:	53                   	push   %ebx
    2450:	52                   	push   %edx
    2451:	e8 16 eb ff ff       	call   f6c <APSetBrush>
    2456:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2459:	8b 45 08             	mov    0x8(%ebp),%eax
    245c:	83 c0 58             	add    $0x58,%eax
    245f:	83 ec 0c             	sub    $0xc,%esp
    2462:	6a 32                	push   $0x32
    2464:	68 20 03 00 00       	push   $0x320
    2469:	6a 00                	push   $0x0
    246b:	6a 00                	push   $0x0
    246d:	50                   	push   %eax
    246e:	e8 23 ef ff ff       	call   1396 <APDrawRect>
    2473:	83 c4 20             	add    $0x20,%esp
    
    
}
    2476:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2479:	5b                   	pop    %ebx
    247a:	5e                   	pop    %esi
    247b:	5f                   	pop    %edi
    247c:	5d                   	pop    %ebp
    247d:	c3                   	ret    

0000247e <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    247e:	55                   	push   %ebp
    247f:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2481:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2485:	7e 08                	jle    248f <random+0x11>
{
rand_num = seed;
    2487:	8b 45 08             	mov    0x8(%ebp),%eax
    248a:	a3 c0 6e 00 00       	mov    %eax,0x6ec0
}
rand_num *= 3;
    248f:	8b 15 c0 6e 00 00    	mov    0x6ec0,%edx
    2495:	89 d0                	mov    %edx,%eax
    2497:	01 c0                	add    %eax,%eax
    2499:	01 d0                	add    %edx,%eax
    249b:	a3 c0 6e 00 00       	mov    %eax,0x6ec0
if (rand_num < 0)
    24a0:	a1 c0 6e 00 00       	mov    0x6ec0,%eax
    24a5:	85 c0                	test   %eax,%eax
    24a7:	79 0c                	jns    24b5 <random+0x37>
{
rand_num *= (-1);
    24a9:	a1 c0 6e 00 00       	mov    0x6ec0,%eax
    24ae:	f7 d8                	neg    %eax
    24b0:	a3 c0 6e 00 00       	mov    %eax,0x6ec0
}
return rand_num % 997;
    24b5:	8b 0d c0 6e 00 00    	mov    0x6ec0,%ecx
    24bb:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    24c0:	89 c8                	mov    %ecx,%eax
    24c2:	f7 ea                	imul   %edx
    24c4:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    24c7:	c1 f8 09             	sar    $0x9,%eax
    24ca:	89 c2                	mov    %eax,%edx
    24cc:	89 c8                	mov    %ecx,%eax
    24ce:	c1 f8 1f             	sar    $0x1f,%eax
    24d1:	29 c2                	sub    %eax,%edx
    24d3:	89 d0                	mov    %edx,%eax
    24d5:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    24db:	29 c1                	sub    %eax,%ecx
    24dd:	89 c8                	mov    %ecx,%eax
}
    24df:	5d                   	pop    %ebp
    24e0:	c3                   	ret    

000024e1 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    24e1:	55                   	push   %ebp
    24e2:	89 e5                	mov    %esp,%ebp
    24e4:	53                   	push   %ebx
    24e5:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    24e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    24ef:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    24f3:	74 17                	je     250c <sprintint+0x2b>
    24f5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    24f9:	79 11                	jns    250c <sprintint+0x2b>
        neg = 1;
    24fb:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2502:	8b 45 10             	mov    0x10(%ebp),%eax
    2505:	f7 d8                	neg    %eax
    2507:	89 45 f0             	mov    %eax,-0x10(%ebp)
    250a:	eb 06                	jmp    2512 <sprintint+0x31>
    } else {
        x = xx;
    250c:	8b 45 10             	mov    0x10(%ebp),%eax
    250f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2512:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2519:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    251c:	8d 41 01             	lea    0x1(%ecx),%eax
    251f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2522:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2525:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2528:	ba 00 00 00 00       	mov    $0x0,%edx
    252d:	f7 f3                	div    %ebx
    252f:	89 d0                	mov    %edx,%eax
    2531:	0f b6 80 c4 6e 00 00 	movzbl 0x6ec4(%eax),%eax
    2538:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    253c:	8b 5d 14             	mov    0x14(%ebp),%ebx
    253f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2542:	ba 00 00 00 00       	mov    $0x0,%edx
    2547:	f7 f3                	div    %ebx
    2549:	89 45 f0             	mov    %eax,-0x10(%ebp)
    254c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2550:	75 c7                	jne    2519 <sprintint+0x38>
    if(neg)
    2552:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2556:	74 0e                	je     2566 <sprintint+0x85>
        buf[i++] = '-';
    2558:	8b 45 f8             	mov    -0x8(%ebp),%eax
    255b:	8d 50 01             	lea    0x1(%eax),%edx
    255e:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2561:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2566:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2569:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    256c:	eb 1b                	jmp    2589 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    256e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2571:	8b 00                	mov    (%eax),%eax
    2573:	8d 48 01             	lea    0x1(%eax),%ecx
    2576:	8b 55 0c             	mov    0xc(%ebp),%edx
    2579:	89 0a                	mov    %ecx,(%edx)
    257b:	89 c2                	mov    %eax,%edx
    257d:	8b 45 08             	mov    0x8(%ebp),%eax
    2580:	01 d0                	add    %edx,%eax
    2582:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2585:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2589:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    258d:	7f df                	jg     256e <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    258f:	eb 21                	jmp    25b2 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2591:	8b 45 0c             	mov    0xc(%ebp),%eax
    2594:	8b 00                	mov    (%eax),%eax
    2596:	8d 48 01             	lea    0x1(%eax),%ecx
    2599:	8b 55 0c             	mov    0xc(%ebp),%edx
    259c:	89 0a                	mov    %ecx,(%edx)
    259e:	89 c2                	mov    %eax,%edx
    25a0:	8b 45 08             	mov    0x8(%ebp),%eax
    25a3:	01 c2                	add    %eax,%edx
    25a5:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    25a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    25ab:	01 c8                	add    %ecx,%eax
    25ad:	0f b6 00             	movzbl (%eax),%eax
    25b0:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    25b2:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    25b6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    25ba:	79 d5                	jns    2591 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    25bc:	90                   	nop
    25bd:	83 c4 20             	add    $0x20,%esp
    25c0:	5b                   	pop    %ebx
    25c1:	5d                   	pop    %ebp
    25c2:	c3                   	ret    

000025c3 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    25c3:	55                   	push   %ebp
    25c4:	89 e5                	mov    %esp,%ebp
    25c6:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    25c9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    25d0:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    25d7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    25de:	8d 45 0c             	lea    0xc(%ebp),%eax
    25e1:	83 c0 04             	add    $0x4,%eax
    25e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    25e7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    25ee:	e9 d9 01 00 00       	jmp    27cc <sprintf+0x209>
        c = fmt[i] & 0xff;
    25f3:	8b 55 0c             	mov    0xc(%ebp),%edx
    25f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    25f9:	01 d0                	add    %edx,%eax
    25fb:	0f b6 00             	movzbl (%eax),%eax
    25fe:	0f be c0             	movsbl %al,%eax
    2601:	25 ff 00 00 00       	and    $0xff,%eax
    2606:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2609:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    260d:	75 2c                	jne    263b <sprintf+0x78>
            if(c == '%'){
    260f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2613:	75 0c                	jne    2621 <sprintf+0x5e>
                state = '%';
    2615:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    261c:	e9 a7 01 00 00       	jmp    27c8 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2621:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2624:	8d 50 01             	lea    0x1(%eax),%edx
    2627:	89 55 c8             	mov    %edx,-0x38(%ebp)
    262a:	89 c2                	mov    %eax,%edx
    262c:	8b 45 08             	mov    0x8(%ebp),%eax
    262f:	01 d0                	add    %edx,%eax
    2631:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2634:	88 10                	mov    %dl,(%eax)
    2636:	e9 8d 01 00 00       	jmp    27c8 <sprintf+0x205>
            }
        } else if(state == '%'){
    263b:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    263f:	0f 85 83 01 00 00    	jne    27c8 <sprintf+0x205>
            if(c == 'd'){
    2645:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2649:	75 4c                	jne    2697 <sprintf+0xd4>
                buf[bi] = '\0';
    264b:	8d 55 ce             	lea    -0x32(%ebp),%edx
    264e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2651:	01 d0                	add    %edx,%eax
    2653:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2656:	83 ec 0c             	sub    $0xc,%esp
    2659:	8d 45 ce             	lea    -0x32(%ebp),%eax
    265c:	50                   	push   %eax
    265d:	e8 2b df ff ff       	call   58d <atoi>
    2662:	83 c4 10             	add    $0x10,%esp
    2665:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2668:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    266f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2672:	8b 00                	mov    (%eax),%eax
    2674:	83 ec 08             	sub    $0x8,%esp
    2677:	ff 75 d8             	pushl  -0x28(%ebp)
    267a:	6a 01                	push   $0x1
    267c:	6a 0a                	push   $0xa
    267e:	50                   	push   %eax
    267f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2682:	50                   	push   %eax
    2683:	ff 75 08             	pushl  0x8(%ebp)
    2686:	e8 56 fe ff ff       	call   24e1 <sprintint>
    268b:	83 c4 20             	add    $0x20,%esp
                ap++;
    268e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2692:	e9 2a 01 00 00       	jmp    27c1 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2697:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    269b:	74 06                	je     26a3 <sprintf+0xe0>
    269d:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    26a1:	75 4c                	jne    26ef <sprintf+0x12c>
                buf[bi] = '\0';
    26a3:	8d 55 ce             	lea    -0x32(%ebp),%edx
    26a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    26a9:	01 d0                	add    %edx,%eax
    26ab:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    26ae:	83 ec 0c             	sub    $0xc,%esp
    26b1:	8d 45 ce             	lea    -0x32(%ebp),%eax
    26b4:	50                   	push   %eax
    26b5:	e8 d3 de ff ff       	call   58d <atoi>
    26ba:	83 c4 10             	add    $0x10,%esp
    26bd:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    26c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    26c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    26ca:	8b 00                	mov    (%eax),%eax
    26cc:	83 ec 08             	sub    $0x8,%esp
    26cf:	ff 75 dc             	pushl  -0x24(%ebp)
    26d2:	6a 00                	push   $0x0
    26d4:	6a 10                	push   $0x10
    26d6:	50                   	push   %eax
    26d7:	8d 45 c8             	lea    -0x38(%ebp),%eax
    26da:	50                   	push   %eax
    26db:	ff 75 08             	pushl  0x8(%ebp)
    26de:	e8 fe fd ff ff       	call   24e1 <sprintint>
    26e3:	83 c4 20             	add    $0x20,%esp
                ap++;
    26e6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    26ea:	e9 d2 00 00 00       	jmp    27c1 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    26ef:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    26f3:	75 46                	jne    273b <sprintf+0x178>
                s = (char*)*ap;
    26f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    26f8:	8b 00                	mov    (%eax),%eax
    26fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    26fd:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2701:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2705:	75 25                	jne    272c <sprintf+0x169>
                    s = "(null)";
    2707:	c7 45 f4 d8 29 00 00 	movl   $0x29d8,-0xc(%ebp)
                while(*s != 0){
    270e:	eb 1c                	jmp    272c <sprintf+0x169>
                    dst[j++] = *s;
    2710:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2713:	8d 50 01             	lea    0x1(%eax),%edx
    2716:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2719:	89 c2                	mov    %eax,%edx
    271b:	8b 45 08             	mov    0x8(%ebp),%eax
    271e:	01 c2                	add    %eax,%edx
    2720:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2723:	0f b6 00             	movzbl (%eax),%eax
    2726:	88 02                	mov    %al,(%edx)
                    s++;
    2728:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    272c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    272f:	0f b6 00             	movzbl (%eax),%eax
    2732:	84 c0                	test   %al,%al
    2734:	75 da                	jne    2710 <sprintf+0x14d>
    2736:	e9 86 00 00 00       	jmp    27c1 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    273b:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    273f:	75 1d                	jne    275e <sprintf+0x19b>
                dst[j++] = *ap;
    2741:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2744:	8d 50 01             	lea    0x1(%eax),%edx
    2747:	89 55 c8             	mov    %edx,-0x38(%ebp)
    274a:	89 c2                	mov    %eax,%edx
    274c:	8b 45 08             	mov    0x8(%ebp),%eax
    274f:	01 c2                	add    %eax,%edx
    2751:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2754:	8b 00                	mov    (%eax),%eax
    2756:	88 02                	mov    %al,(%edx)
                ap++;
    2758:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    275c:	eb 63                	jmp    27c1 <sprintf+0x1fe>
            } else if(c == '%'){
    275e:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2762:	75 17                	jne    277b <sprintf+0x1b8>
                dst[j++] = c;
    2764:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2767:	8d 50 01             	lea    0x1(%eax),%edx
    276a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    276d:	89 c2                	mov    %eax,%edx
    276f:	8b 45 08             	mov    0x8(%ebp),%eax
    2772:	01 d0                	add    %edx,%eax
    2774:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2777:	88 10                	mov    %dl,(%eax)
    2779:	eb 46                	jmp    27c1 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    277b:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    277f:	7e 18                	jle    2799 <sprintf+0x1d6>
    2781:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2785:	7f 12                	jg     2799 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2787:	8b 45 f0             	mov    -0x10(%ebp),%eax
    278a:	8d 50 01             	lea    0x1(%eax),%edx
    278d:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2790:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2793:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2797:	eb 2f                	jmp    27c8 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2799:	8b 45 c8             	mov    -0x38(%ebp),%eax
    279c:	8d 50 01             	lea    0x1(%eax),%edx
    279f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    27a2:	89 c2                	mov    %eax,%edx
    27a4:	8b 45 08             	mov    0x8(%ebp),%eax
    27a7:	01 d0                	add    %edx,%eax
    27a9:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    27ac:	8b 45 c8             	mov    -0x38(%ebp),%eax
    27af:	8d 50 01             	lea    0x1(%eax),%edx
    27b2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    27b5:	89 c2                	mov    %eax,%edx
    27b7:	8b 45 08             	mov    0x8(%ebp),%eax
    27ba:	01 d0                	add    %edx,%eax
    27bc:	8b 55 e0             	mov    -0x20(%ebp),%edx
    27bf:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    27c1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    27c8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    27cc:	8b 55 0c             	mov    0xc(%ebp),%edx
    27cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    27d2:	01 d0                	add    %edx,%eax
    27d4:	0f b6 00             	movzbl (%eax),%eax
    27d7:	84 c0                	test   %al,%al
    27d9:	0f 85 14 fe ff ff    	jne    25f3 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    27df:	8b 45 c8             	mov    -0x38(%ebp),%eax
    27e2:	8d 50 01             	lea    0x1(%eax),%edx
    27e5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    27e8:	89 c2                	mov    %eax,%edx
    27ea:	8b 45 08             	mov    0x8(%ebp),%eax
    27ed:	01 d0                	add    %edx,%eax
    27ef:	c6 00 00             	movb   $0x0,(%eax)
}
    27f2:	90                   	nop
    27f3:	c9                   	leave  
    27f4:	c3                   	ret    
