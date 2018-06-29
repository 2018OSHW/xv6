
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
       6:	e8 ea 05 00 00       	call   5f5 <fork>
       b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    char temp[30];
    if (pid == 0)
       e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      12:	75 37                	jne    4b <runApp+0x4b>
    {
        sprintf(temp, "AP%s", (char *)param);
      14:	83 ec 04             	sub    $0x4,%esp
      17:	ff 75 08             	pushl  0x8(%ebp)
      1a:	68 18 27 00 00       	push   $0x2718
      1f:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      22:	50                   	push   %eax
      23:	e8 bd 24 00 00       	call   24e5 <sprintf>
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
      43:	e8 ed 05 00 00       	call   635 <exec>
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
            //    if (hwnd->grid[pos_x][pos_y] == GRID_PROGRAM_SNAKE)
            //    break;
            default:break;
        }
            break;
        default: break;
      6e:	e9 42 02 00 00       	jmp    2b5 <wndProc+0x267>
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
      ae:	8b 04 85 a0 2e 00 00 	mov    0x2ea0(,%eax,4),%eax
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
      f2:	e8 62 17 00 00       	call   1859 <APSendMessage>
      f7:	83 c4 10             	add    $0x10,%esp
            //setupTimer(hwnd,0,1000);
            return False;
      fa:	b8 00 00 00 00       	mov    $0x0,%eax
      ff:	e9 c5 01 00 00       	jmp    2c9 <wndProc+0x27b>
        case MSG_PAINT:
            APGridPaint(hwnd);
     104:	83 ec 0c             	sub    $0xc,%esp
     107:	ff 75 08             	pushl  0x8(%ebp)
     10a:	e8 1f 1b 00 00       	call   1c2e <APGridPaint>
     10f:	83 c4 10             	add    $0x10,%esp
            break;
     112:	e9 9e 01 00 00       	jmp    2b5 <wndProc+0x267>
        case MSG_KEY_DOWN:
            //printf(1,"kbd message received!\n");
            switch (msg.param)
     117:	8b 45 10             	mov    0x10(%ebp),%eax
     11a:	83 f8 02             	cmp    $0x2,%eax
     11d:	0f 84 83 00 00 00    	je     1a6 <wndProc+0x158>
     123:	83 f8 02             	cmp    $0x2,%eax
     126:	77 0e                	ja     136 <wndProc+0xe8>
     128:	83 f8 01             	cmp    $0x1,%eax
     12b:	0f 84 d1 00 00 00    	je     202 <wndProc+0x1b4>
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
                break;
           // case VK_ENTER:
            //    if (hwnd->grid[pos_x][pos_y] == GRID_PROGRAM_SNAKE)
            //    break;
            default:break;
     131:	e9 7e 01 00 00       	jmp    2b4 <wndProc+0x266>
        case MSG_PAINT:
            APGridPaint(hwnd);
            break;
        case MSG_KEY_DOWN:
            //printf(1,"kbd message received!\n");
            switch (msg.param)
     136:	83 f8 03             	cmp    $0x3,%eax
     139:	0f 84 1c 01 00 00    	je     25b <wndProc+0x20d>
     13f:	83 f8 04             	cmp    $0x4,%eax
     142:	74 05                	je     149 <wndProc+0xfb>
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
                break;
           // case VK_ENTER:
            //    if (hwnd->grid[pos_x][pos_y] == GRID_PROGRAM_SNAKE)
            //    break;
            default:break;
     144:	e9 6b 01 00 00       	jmp    2b4 <wndProc+0x266>
        case MSG_KEY_DOWN:
            //printf(1,"kbd message received!\n");
            switch (msg.param)
        {
            case VK_RIGHT:
                if (hwnd->pos_x < GRID_W_NUMBER - 1 && judgeGridWalkable(hwnd->pos_x + 1,hwnd->pos_y,hwnd))
     149:	8b 45 08             	mov    0x8(%ebp),%eax
     14c:	8b 40 18             	mov    0x18(%eax),%eax
     14f:	83 f8 0e             	cmp    $0xe,%eax
     152:	7f 32                	jg     186 <wndProc+0x138>
     154:	8b 45 08             	mov    0x8(%ebp),%eax
     157:	8b 40 1c             	mov    0x1c(%eax),%eax
     15a:	8b 55 08             	mov    0x8(%ebp),%edx
     15d:	8b 52 18             	mov    0x18(%edx),%edx
     160:	83 c2 01             	add    $0x1,%edx
     163:	83 ec 04             	sub    $0x4,%esp
     166:	ff 75 08             	pushl  0x8(%ebp)
     169:	50                   	push   %eax
     16a:	52                   	push   %edx
     16b:	e8 5b 01 00 00       	call   2cb <judgeGridWalkable>
     170:	83 c4 10             	add    $0x10,%esp
     173:	85 c0                	test   %eax,%eax
     175:	74 0f                	je     186 <wndProc+0x138>
                    hwnd->pos_x++;
     177:	8b 45 08             	mov    0x8(%ebp),%eax
     17a:	8b 40 18             	mov    0x18(%eax),%eax
     17d:	8d 50 01             	lea    0x1(%eax),%edx
     180:	8b 45 08             	mov    0x8(%ebp),%eax
     183:	89 50 18             	mov    %edx,0x18(%eax)
                changePosition(hwnd->pos_x,hwnd->pos_y,1);
     186:	8b 45 08             	mov    0x8(%ebp),%eax
     189:	8b 50 1c             	mov    0x1c(%eax),%edx
     18c:	8b 45 08             	mov    0x8(%ebp),%eax
     18f:	8b 40 18             	mov    0x18(%eax),%eax
     192:	83 ec 04             	sub    $0x4,%esp
     195:	6a 01                	push   $0x1
     197:	52                   	push   %edx
     198:	50                   	push   %eax
     199:	e8 1f 05 00 00       	call   6bd <changePosition>
     19e:	83 c4 10             	add    $0x10,%esp
                break;
     1a1:	e9 0e 01 00 00       	jmp    2b4 <wndProc+0x266>
            case VK_LEFT:
                if (hwnd->pos_x > 0 && judgeGridWalkable(hwnd->pos_x - 1 ,hwnd->pos_y,hwnd))
     1a6:	8b 45 08             	mov    0x8(%ebp),%eax
     1a9:	8b 40 18             	mov    0x18(%eax),%eax
     1ac:	85 c0                	test   %eax,%eax
     1ae:	7e 32                	jle    1e2 <wndProc+0x194>
     1b0:	8b 45 08             	mov    0x8(%ebp),%eax
     1b3:	8b 40 1c             	mov    0x1c(%eax),%eax
     1b6:	8b 55 08             	mov    0x8(%ebp),%edx
     1b9:	8b 52 18             	mov    0x18(%edx),%edx
     1bc:	83 ea 01             	sub    $0x1,%edx
     1bf:	83 ec 04             	sub    $0x4,%esp
     1c2:	ff 75 08             	pushl  0x8(%ebp)
     1c5:	50                   	push   %eax
     1c6:	52                   	push   %edx
     1c7:	e8 ff 00 00 00       	call   2cb <judgeGridWalkable>
     1cc:	83 c4 10             	add    $0x10,%esp
     1cf:	85 c0                	test   %eax,%eax
     1d1:	74 0f                	je     1e2 <wndProc+0x194>
                    hwnd->pos_x--;
     1d3:	8b 45 08             	mov    0x8(%ebp),%eax
     1d6:	8b 40 18             	mov    0x18(%eax),%eax
     1d9:	8d 50 ff             	lea    -0x1(%eax),%edx
     1dc:	8b 45 08             	mov    0x8(%ebp),%eax
     1df:	89 50 18             	mov    %edx,0x18(%eax)
                changePosition(hwnd->pos_x,hwnd->pos_y,0);
     1e2:	8b 45 08             	mov    0x8(%ebp),%eax
     1e5:	8b 50 1c             	mov    0x1c(%eax),%edx
     1e8:	8b 45 08             	mov    0x8(%ebp),%eax
     1eb:	8b 40 18             	mov    0x18(%eax),%eax
     1ee:	83 ec 04             	sub    $0x4,%esp
     1f1:	6a 00                	push   $0x0
     1f3:	52                   	push   %edx
     1f4:	50                   	push   %eax
     1f5:	e8 c3 04 00 00       	call   6bd <changePosition>
     1fa:	83 c4 10             	add    $0x10,%esp
                break;
     1fd:	e9 b2 00 00 00       	jmp    2b4 <wndProc+0x266>
            case VK_UP:
                if (hwnd->pos_y > 0 && judgeGridWalkable(hwnd->pos_x ,hwnd->pos_y - 1,hwnd))
     202:	8b 45 08             	mov    0x8(%ebp),%eax
     205:	8b 40 1c             	mov    0x1c(%eax),%eax
     208:	85 c0                	test   %eax,%eax
     20a:	7e 32                	jle    23e <wndProc+0x1f0>
     20c:	8b 45 08             	mov    0x8(%ebp),%eax
     20f:	8b 40 1c             	mov    0x1c(%eax),%eax
     212:	8d 50 ff             	lea    -0x1(%eax),%edx
     215:	8b 45 08             	mov    0x8(%ebp),%eax
     218:	8b 40 18             	mov    0x18(%eax),%eax
     21b:	83 ec 04             	sub    $0x4,%esp
     21e:	ff 75 08             	pushl  0x8(%ebp)
     221:	52                   	push   %edx
     222:	50                   	push   %eax
     223:	e8 a3 00 00 00       	call   2cb <judgeGridWalkable>
     228:	83 c4 10             	add    $0x10,%esp
     22b:	85 c0                	test   %eax,%eax
     22d:	74 0f                	je     23e <wndProc+0x1f0>
                    hwnd->pos_y--;
     22f:	8b 45 08             	mov    0x8(%ebp),%eax
     232:	8b 40 1c             	mov    0x1c(%eax),%eax
     235:	8d 50 ff             	lea    -0x1(%eax),%edx
     238:	8b 45 08             	mov    0x8(%ebp),%eax
     23b:	89 50 1c             	mov    %edx,0x1c(%eax)
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
     23e:	8b 45 08             	mov    0x8(%ebp),%eax
     241:	8b 50 1c             	mov    0x1c(%eax),%edx
     244:	8b 45 08             	mov    0x8(%ebp),%eax
     247:	8b 40 18             	mov    0x18(%eax),%eax
     24a:	83 ec 04             	sub    $0x4,%esp
     24d:	6a 02                	push   $0x2
     24f:	52                   	push   %edx
     250:	50                   	push   %eax
     251:	e8 67 04 00 00       	call   6bd <changePosition>
     256:	83 c4 10             	add    $0x10,%esp
                break;
     259:	eb 59                	jmp    2b4 <wndProc+0x266>
            case VK_DOWN:
                if (hwnd->pos_y < GRID_H_NUMBER - 1 && judgeGridWalkable(hwnd->pos_x ,hwnd->pos_y + 1,hwnd))
     25b:	8b 45 08             	mov    0x8(%ebp),%eax
     25e:	8b 40 1c             	mov    0x1c(%eax),%eax
     261:	83 f8 09             	cmp    $0x9,%eax
     264:	7f 32                	jg     298 <wndProc+0x24a>
     266:	8b 45 08             	mov    0x8(%ebp),%eax
     269:	8b 40 1c             	mov    0x1c(%eax),%eax
     26c:	8d 50 01             	lea    0x1(%eax),%edx
     26f:	8b 45 08             	mov    0x8(%ebp),%eax
     272:	8b 40 18             	mov    0x18(%eax),%eax
     275:	83 ec 04             	sub    $0x4,%esp
     278:	ff 75 08             	pushl  0x8(%ebp)
     27b:	52                   	push   %edx
     27c:	50                   	push   %eax
     27d:	e8 49 00 00 00       	call   2cb <judgeGridWalkable>
     282:	83 c4 10             	add    $0x10,%esp
     285:	85 c0                	test   %eax,%eax
     287:	74 0f                	je     298 <wndProc+0x24a>
                    hwnd->pos_y++;
     289:	8b 45 08             	mov    0x8(%ebp),%eax
     28c:	8b 40 1c             	mov    0x1c(%eax),%eax
     28f:	8d 50 01             	lea    0x1(%eax),%edx
     292:	8b 45 08             	mov    0x8(%ebp),%eax
     295:	89 50 1c             	mov    %edx,0x1c(%eax)
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
     298:	8b 45 08             	mov    0x8(%ebp),%eax
     29b:	8b 50 1c             	mov    0x1c(%eax),%edx
     29e:	8b 45 08             	mov    0x8(%ebp),%eax
     2a1:	8b 40 18             	mov    0x18(%eax),%eax
     2a4:	83 ec 04             	sub    $0x4,%esp
     2a7:	6a 02                	push   $0x2
     2a9:	52                   	push   %edx
     2aa:	50                   	push   %eax
     2ab:	e8 0d 04 00 00       	call   6bd <changePosition>
     2b0:	83 c4 10             	add    $0x10,%esp
                break;
     2b3:	90                   	nop
           // case VK_ENTER:
            //    if (hwnd->grid[pos_x][pos_y] == GRID_PROGRAM_SNAKE)
            //    break;
            default:break;
        }
            break;
     2b4:	90                   	nop
        default: break;
    }
    return APWndProc(hwnd, msg);
     2b5:	ff 75 14             	pushl  0x14(%ebp)
     2b8:	ff 75 10             	pushl  0x10(%ebp)
     2bb:	ff 75 0c             	pushl  0xc(%ebp)
     2be:	ff 75 08             	pushl  0x8(%ebp)
     2c1:	e8 17 18 00 00       	call   1add <APWndProc>
     2c6:	83 c4 10             	add    $0x10,%esp
}
     2c9:	c9                   	leave  
     2ca:	c3                   	ret    

000002cb <judgeGridWalkable>:

int judgeGridWalkable(int x,int y, AHwnd hwnd)
{
     2cb:	55                   	push   %ebp
     2cc:	89 e5                	mov    %esp,%ebp
     2ce:	83 ec 10             	sub    $0x10,%esp
    if (hwnd->is_grid)
     2d1:	8b 45 10             	mov    0x10(%ebp),%eax
     2d4:	8b 40 08             	mov    0x8(%eax),%eax
     2d7:	85 c0                	test   %eax,%eax
     2d9:	0f 84 80 00 00 00    	je     35f <judgeGridWalkable+0x94>
    {
        int index = hwnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER + y * GRID_W_NUMBER + x;
     2df:	8b 45 10             	mov    0x10(%ebp),%eax
     2e2:	8b 50 14             	mov    0x14(%eax),%edx
     2e5:	89 d0                	mov    %edx,%eax
     2e7:	c1 e0 02             	shl    $0x2,%eax
     2ea:	01 d0                	add    %edx,%eax
     2ec:	01 c0                	add    %eax,%eax
     2ee:	01 c2                	add    %eax,%edx
     2f0:	8b 45 0c             	mov    0xc(%ebp),%eax
     2f3:	01 d0                	add    %edx,%eax
     2f5:	c1 e0 04             	shl    $0x4,%eax
     2f8:	89 c2                	mov    %eax,%edx
     2fa:	8b 45 08             	mov    0x8(%ebp),%eax
     2fd:	01 d0                	add    %edx,%eax
     2ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
        switch(hwnd->Grid[index])
     302:	8b 45 10             	mov    0x10(%ebp),%eax
     305:	8b 40 0c             	mov    0xc(%eax),%eax
     308:	8b 55 fc             	mov    -0x4(%ebp),%edx
     30b:	c1 e2 02             	shl    $0x2,%edx
     30e:	01 d0                	add    %edx,%eax
     310:	8b 00                	mov    (%eax),%eax
     312:	83 f8 07             	cmp    $0x7,%eax
     315:	77 41                	ja     358 <judgeGridWalkable+0x8d>
     317:	8b 04 85 20 27 00 00 	mov    0x2720(,%eax,4),%eax
     31e:	ff e0                	jmp    *%eax
        {
                
            case GRID_WALL : return 0;
     320:	b8 00 00 00 00       	mov    $0x0,%eax
     325:	eb 3d                	jmp    364 <judgeGridWalkable+0x99>
            case GRID_ROAD : return 1;
     327:	b8 01 00 00 00       	mov    $0x1,%eax
     32c:	eb 36                	jmp    364 <judgeGridWalkable+0x99>
            case GRID_GRASS : return 1;
     32e:	b8 01 00 00 00       	mov    $0x1,%eax
     333:	eb 2f                	jmp    364 <judgeGridWalkable+0x99>
            case GRID_RIVER : return 0;
     335:	b8 00 00 00 00       	mov    $0x0,%eax
     33a:	eb 28                	jmp    364 <judgeGridWalkable+0x99>
            case GRID_FOREST: return 0;
     33c:	b8 00 00 00 00       	mov    $0x0,%eax
     341:	eb 21                	jmp    364 <judgeGridWalkable+0x99>
            case GRID_STONE: return 1;
     343:	b8 01 00 00 00       	mov    $0x1,%eax
     348:	eb 1a                	jmp    364 <judgeGridWalkable+0x99>
            case GRID_MOUNTAIN: return 0;
     34a:	b8 00 00 00 00       	mov    $0x0,%eax
     34f:	eb 13                	jmp    364 <judgeGridWalkable+0x99>
            case GRID_LAKE: return 0;
     351:	b8 00 00 00 00       	mov    $0x0,%eax
     356:	eb 0c                	jmp    364 <judgeGridWalkable+0x99>
            default: return 1;
     358:	b8 01 00 00 00       	mov    $0x1,%eax
     35d:	eb 05                	jmp    364 <judgeGridWalkable+0x99>
        }
    }
    return 0;
     35f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     364:	c9                   	leave  
     365:	c3                   	ret    

00000366 <main>:

int main(void)
{
     366:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     36a:	83 e4 f0             	and    $0xfffffff0,%esp
     36d:	ff 71 fc             	pushl  -0x4(%ecx)
     370:	55                   	push   %ebp
     371:	89 e5                	mov    %esp,%ebp
     373:	51                   	push   %ecx
     374:	83 ec 14             	sub    $0x14,%esp
   // runApp("Snack");
    AHwnd hwnd = APCreateWindow("desktop",True,3);
     377:	83 ec 04             	sub    $0x4,%esp
     37a:	6a 03                	push   $0x3
     37c:	6a 01                	push   $0x1
     37e:	68 40 27 00 00       	push   $0x2740
     383:	e8 ef 14 00 00       	call   1877 <APCreateWindow>
     388:	83 c4 10             	add    $0x10,%esp
     38b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  //  printf(1,"desktop initialized!\n");
    APWndExec(hwnd, wndProc);
     38e:	83 ec 08             	sub    $0x8,%esp
     391:	68 4e 00 00 00       	push   $0x4e
     396:	ff 75 f4             	pushl  -0xc(%ebp)
     399:	e8 fb 17 00 00       	call   1b99 <APWndExec>
     39e:	83 c4 10             	add    $0x10,%esp
    exit();
     3a1:	e8 57 02 00 00       	call   5fd <exit>

000003a6 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     3a6:	55                   	push   %ebp
     3a7:	89 e5                	mov    %esp,%ebp
     3a9:	57                   	push   %edi
     3aa:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     3ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
     3ae:	8b 55 10             	mov    0x10(%ebp),%edx
     3b1:	8b 45 0c             	mov    0xc(%ebp),%eax
     3b4:	89 cb                	mov    %ecx,%ebx
     3b6:	89 df                	mov    %ebx,%edi
     3b8:	89 d1                	mov    %edx,%ecx
     3ba:	fc                   	cld    
     3bb:	f3 aa                	rep stos %al,%es:(%edi)
     3bd:	89 ca                	mov    %ecx,%edx
     3bf:	89 fb                	mov    %edi,%ebx
     3c1:	89 5d 08             	mov    %ebx,0x8(%ebp)
     3c4:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     3c7:	90                   	nop
     3c8:	5b                   	pop    %ebx
     3c9:	5f                   	pop    %edi
     3ca:	5d                   	pop    %ebp
     3cb:	c3                   	ret    

000003cc <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     3cc:	55                   	push   %ebp
     3cd:	89 e5                	mov    %esp,%ebp
     3cf:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     3d2:	8b 45 08             	mov    0x8(%ebp),%eax
     3d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     3d8:	90                   	nop
     3d9:	8b 45 08             	mov    0x8(%ebp),%eax
     3dc:	8d 50 01             	lea    0x1(%eax),%edx
     3df:	89 55 08             	mov    %edx,0x8(%ebp)
     3e2:	8b 55 0c             	mov    0xc(%ebp),%edx
     3e5:	8d 4a 01             	lea    0x1(%edx),%ecx
     3e8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     3eb:	0f b6 12             	movzbl (%edx),%edx
     3ee:	88 10                	mov    %dl,(%eax)
     3f0:	0f b6 00             	movzbl (%eax),%eax
     3f3:	84 c0                	test   %al,%al
     3f5:	75 e2                	jne    3d9 <strcpy+0xd>
    ;
  return os;
     3f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     3fa:	c9                   	leave  
     3fb:	c3                   	ret    

000003fc <strcmp>:

int
strcmp(const char *p, const char *q)
{
     3fc:	55                   	push   %ebp
     3fd:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     3ff:	eb 08                	jmp    409 <strcmp+0xd>
    p++, q++;
     401:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     405:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     409:	8b 45 08             	mov    0x8(%ebp),%eax
     40c:	0f b6 00             	movzbl (%eax),%eax
     40f:	84 c0                	test   %al,%al
     411:	74 10                	je     423 <strcmp+0x27>
     413:	8b 45 08             	mov    0x8(%ebp),%eax
     416:	0f b6 10             	movzbl (%eax),%edx
     419:	8b 45 0c             	mov    0xc(%ebp),%eax
     41c:	0f b6 00             	movzbl (%eax),%eax
     41f:	38 c2                	cmp    %al,%dl
     421:	74 de                	je     401 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     423:	8b 45 08             	mov    0x8(%ebp),%eax
     426:	0f b6 00             	movzbl (%eax),%eax
     429:	0f b6 d0             	movzbl %al,%edx
     42c:	8b 45 0c             	mov    0xc(%ebp),%eax
     42f:	0f b6 00             	movzbl (%eax),%eax
     432:	0f b6 c0             	movzbl %al,%eax
     435:	29 c2                	sub    %eax,%edx
     437:	89 d0                	mov    %edx,%eax
}
     439:	5d                   	pop    %ebp
     43a:	c3                   	ret    

0000043b <strlen>:

uint
strlen(char *s)
{
     43b:	55                   	push   %ebp
     43c:	89 e5                	mov    %esp,%ebp
     43e:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     441:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     448:	eb 04                	jmp    44e <strlen+0x13>
     44a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     44e:	8b 55 fc             	mov    -0x4(%ebp),%edx
     451:	8b 45 08             	mov    0x8(%ebp),%eax
     454:	01 d0                	add    %edx,%eax
     456:	0f b6 00             	movzbl (%eax),%eax
     459:	84 c0                	test   %al,%al
     45b:	75 ed                	jne    44a <strlen+0xf>
    ;
  return n;
     45d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     460:	c9                   	leave  
     461:	c3                   	ret    

00000462 <memset>:

void*
memset(void *dst, int c, uint n)
{
     462:	55                   	push   %ebp
     463:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     465:	8b 45 10             	mov    0x10(%ebp),%eax
     468:	50                   	push   %eax
     469:	ff 75 0c             	pushl  0xc(%ebp)
     46c:	ff 75 08             	pushl  0x8(%ebp)
     46f:	e8 32 ff ff ff       	call   3a6 <stosb>
     474:	83 c4 0c             	add    $0xc,%esp
  return dst;
     477:	8b 45 08             	mov    0x8(%ebp),%eax
}
     47a:	c9                   	leave  
     47b:	c3                   	ret    

0000047c <strchr>:

char*
strchr(const char *s, char c)
{
     47c:	55                   	push   %ebp
     47d:	89 e5                	mov    %esp,%ebp
     47f:	83 ec 04             	sub    $0x4,%esp
     482:	8b 45 0c             	mov    0xc(%ebp),%eax
     485:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     488:	eb 14                	jmp    49e <strchr+0x22>
    if(*s == c)
     48a:	8b 45 08             	mov    0x8(%ebp),%eax
     48d:	0f b6 00             	movzbl (%eax),%eax
     490:	3a 45 fc             	cmp    -0x4(%ebp),%al
     493:	75 05                	jne    49a <strchr+0x1e>
      return (char*)s;
     495:	8b 45 08             	mov    0x8(%ebp),%eax
     498:	eb 13                	jmp    4ad <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     49a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     49e:	8b 45 08             	mov    0x8(%ebp),%eax
     4a1:	0f b6 00             	movzbl (%eax),%eax
     4a4:	84 c0                	test   %al,%al
     4a6:	75 e2                	jne    48a <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     4a8:	b8 00 00 00 00       	mov    $0x0,%eax
}
     4ad:	c9                   	leave  
     4ae:	c3                   	ret    

000004af <gets>:

char*
gets(char *buf, int max)
{
     4af:	55                   	push   %ebp
     4b0:	89 e5                	mov    %esp,%ebp
     4b2:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     4b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4bc:	eb 42                	jmp    500 <gets+0x51>
    cc = read(0, &c, 1);
     4be:	83 ec 04             	sub    $0x4,%esp
     4c1:	6a 01                	push   $0x1
     4c3:	8d 45 ef             	lea    -0x11(%ebp),%eax
     4c6:	50                   	push   %eax
     4c7:	6a 00                	push   $0x0
     4c9:	e8 47 01 00 00       	call   615 <read>
     4ce:	83 c4 10             	add    $0x10,%esp
     4d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     4d4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4d8:	7e 33                	jle    50d <gets+0x5e>
      break;
    buf[i++] = c;
     4da:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4dd:	8d 50 01             	lea    0x1(%eax),%edx
     4e0:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4e3:	89 c2                	mov    %eax,%edx
     4e5:	8b 45 08             	mov    0x8(%ebp),%eax
     4e8:	01 c2                	add    %eax,%edx
     4ea:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4ee:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     4f0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4f4:	3c 0a                	cmp    $0xa,%al
     4f6:	74 16                	je     50e <gets+0x5f>
     4f8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4fc:	3c 0d                	cmp    $0xd,%al
     4fe:	74 0e                	je     50e <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     500:	8b 45 f4             	mov    -0xc(%ebp),%eax
     503:	83 c0 01             	add    $0x1,%eax
     506:	3b 45 0c             	cmp    0xc(%ebp),%eax
     509:	7c b3                	jl     4be <gets+0xf>
     50b:	eb 01                	jmp    50e <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     50d:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     50e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     511:	8b 45 08             	mov    0x8(%ebp),%eax
     514:	01 d0                	add    %edx,%eax
     516:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     519:	8b 45 08             	mov    0x8(%ebp),%eax
}
     51c:	c9                   	leave  
     51d:	c3                   	ret    

0000051e <stat>:

int
stat(char *n, struct stat *st)
{
     51e:	55                   	push   %ebp
     51f:	89 e5                	mov    %esp,%ebp
     521:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     524:	83 ec 08             	sub    $0x8,%esp
     527:	6a 00                	push   $0x0
     529:	ff 75 08             	pushl  0x8(%ebp)
     52c:	e8 0c 01 00 00       	call   63d <open>
     531:	83 c4 10             	add    $0x10,%esp
     534:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     537:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     53b:	79 07                	jns    544 <stat+0x26>
    return -1;
     53d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     542:	eb 25                	jmp    569 <stat+0x4b>
  r = fstat(fd, st);
     544:	83 ec 08             	sub    $0x8,%esp
     547:	ff 75 0c             	pushl  0xc(%ebp)
     54a:	ff 75 f4             	pushl  -0xc(%ebp)
     54d:	e8 03 01 00 00       	call   655 <fstat>
     552:	83 c4 10             	add    $0x10,%esp
     555:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     558:	83 ec 0c             	sub    $0xc,%esp
     55b:	ff 75 f4             	pushl  -0xc(%ebp)
     55e:	e8 c2 00 00 00       	call   625 <close>
     563:	83 c4 10             	add    $0x10,%esp
  return r;
     566:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     569:	c9                   	leave  
     56a:	c3                   	ret    

0000056b <atoi>:

int
atoi(const char *s)
{
     56b:	55                   	push   %ebp
     56c:	89 e5                	mov    %esp,%ebp
     56e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     571:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     578:	eb 25                	jmp    59f <atoi+0x34>
    n = n*10 + *s++ - '0';
     57a:	8b 55 fc             	mov    -0x4(%ebp),%edx
     57d:	89 d0                	mov    %edx,%eax
     57f:	c1 e0 02             	shl    $0x2,%eax
     582:	01 d0                	add    %edx,%eax
     584:	01 c0                	add    %eax,%eax
     586:	89 c1                	mov    %eax,%ecx
     588:	8b 45 08             	mov    0x8(%ebp),%eax
     58b:	8d 50 01             	lea    0x1(%eax),%edx
     58e:	89 55 08             	mov    %edx,0x8(%ebp)
     591:	0f b6 00             	movzbl (%eax),%eax
     594:	0f be c0             	movsbl %al,%eax
     597:	01 c8                	add    %ecx,%eax
     599:	83 e8 30             	sub    $0x30,%eax
     59c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     59f:	8b 45 08             	mov    0x8(%ebp),%eax
     5a2:	0f b6 00             	movzbl (%eax),%eax
     5a5:	3c 2f                	cmp    $0x2f,%al
     5a7:	7e 0a                	jle    5b3 <atoi+0x48>
     5a9:	8b 45 08             	mov    0x8(%ebp),%eax
     5ac:	0f b6 00             	movzbl (%eax),%eax
     5af:	3c 39                	cmp    $0x39,%al
     5b1:	7e c7                	jle    57a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     5b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     5b6:	c9                   	leave  
     5b7:	c3                   	ret    

000005b8 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     5b8:	55                   	push   %ebp
     5b9:	89 e5                	mov    %esp,%ebp
     5bb:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     5be:	8b 45 08             	mov    0x8(%ebp),%eax
     5c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     5c4:	8b 45 0c             	mov    0xc(%ebp),%eax
     5c7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     5ca:	eb 17                	jmp    5e3 <memmove+0x2b>
    *dst++ = *src++;
     5cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5cf:	8d 50 01             	lea    0x1(%eax),%edx
     5d2:	89 55 fc             	mov    %edx,-0x4(%ebp)
     5d5:	8b 55 f8             	mov    -0x8(%ebp),%edx
     5d8:	8d 4a 01             	lea    0x1(%edx),%ecx
     5db:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     5de:	0f b6 12             	movzbl (%edx),%edx
     5e1:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     5e3:	8b 45 10             	mov    0x10(%ebp),%eax
     5e6:	8d 50 ff             	lea    -0x1(%eax),%edx
     5e9:	89 55 10             	mov    %edx,0x10(%ebp)
     5ec:	85 c0                	test   %eax,%eax
     5ee:	7f dc                	jg     5cc <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     5f0:	8b 45 08             	mov    0x8(%ebp),%eax
}
     5f3:	c9                   	leave  
     5f4:	c3                   	ret    

000005f5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     5f5:	b8 01 00 00 00       	mov    $0x1,%eax
     5fa:	cd 40                	int    $0x40
     5fc:	c3                   	ret    

000005fd <exit>:
SYSCALL(exit)
     5fd:	b8 02 00 00 00       	mov    $0x2,%eax
     602:	cd 40                	int    $0x40
     604:	c3                   	ret    

00000605 <wait>:
SYSCALL(wait)
     605:	b8 03 00 00 00       	mov    $0x3,%eax
     60a:	cd 40                	int    $0x40
     60c:	c3                   	ret    

0000060d <pipe>:
SYSCALL(pipe)
     60d:	b8 04 00 00 00       	mov    $0x4,%eax
     612:	cd 40                	int    $0x40
     614:	c3                   	ret    

00000615 <read>:
SYSCALL(read)
     615:	b8 05 00 00 00       	mov    $0x5,%eax
     61a:	cd 40                	int    $0x40
     61c:	c3                   	ret    

0000061d <write>:
SYSCALL(write)
     61d:	b8 10 00 00 00       	mov    $0x10,%eax
     622:	cd 40                	int    $0x40
     624:	c3                   	ret    

00000625 <close>:
SYSCALL(close)
     625:	b8 15 00 00 00       	mov    $0x15,%eax
     62a:	cd 40                	int    $0x40
     62c:	c3                   	ret    

0000062d <kill>:
SYSCALL(kill)
     62d:	b8 06 00 00 00       	mov    $0x6,%eax
     632:	cd 40                	int    $0x40
     634:	c3                   	ret    

00000635 <exec>:
SYSCALL(exec)
     635:	b8 07 00 00 00       	mov    $0x7,%eax
     63a:	cd 40                	int    $0x40
     63c:	c3                   	ret    

0000063d <open>:
SYSCALL(open)
     63d:	b8 0f 00 00 00       	mov    $0xf,%eax
     642:	cd 40                	int    $0x40
     644:	c3                   	ret    

00000645 <mknod>:
SYSCALL(mknod)
     645:	b8 11 00 00 00       	mov    $0x11,%eax
     64a:	cd 40                	int    $0x40
     64c:	c3                   	ret    

0000064d <unlink>:
SYSCALL(unlink)
     64d:	b8 12 00 00 00       	mov    $0x12,%eax
     652:	cd 40                	int    $0x40
     654:	c3                   	ret    

00000655 <fstat>:
SYSCALL(fstat)
     655:	b8 08 00 00 00       	mov    $0x8,%eax
     65a:	cd 40                	int    $0x40
     65c:	c3                   	ret    

0000065d <link>:
SYSCALL(link)
     65d:	b8 13 00 00 00       	mov    $0x13,%eax
     662:	cd 40                	int    $0x40
     664:	c3                   	ret    

00000665 <mkdir>:
SYSCALL(mkdir)
     665:	b8 14 00 00 00       	mov    $0x14,%eax
     66a:	cd 40                	int    $0x40
     66c:	c3                   	ret    

0000066d <chdir>:
SYSCALL(chdir)
     66d:	b8 09 00 00 00       	mov    $0x9,%eax
     672:	cd 40                	int    $0x40
     674:	c3                   	ret    

00000675 <dup>:
SYSCALL(dup)
     675:	b8 0a 00 00 00       	mov    $0xa,%eax
     67a:	cd 40                	int    $0x40
     67c:	c3                   	ret    

0000067d <getpid>:
SYSCALL(getpid)
     67d:	b8 0b 00 00 00       	mov    $0xb,%eax
     682:	cd 40                	int    $0x40
     684:	c3                   	ret    

00000685 <sbrk>:
SYSCALL(sbrk)
     685:	b8 0c 00 00 00       	mov    $0xc,%eax
     68a:	cd 40                	int    $0x40
     68c:	c3                   	ret    

0000068d <sleep>:
SYSCALL(sleep)
     68d:	b8 0d 00 00 00       	mov    $0xd,%eax
     692:	cd 40                	int    $0x40
     694:	c3                   	ret    

00000695 <uptime>:
SYSCALL(uptime)
     695:	b8 0e 00 00 00       	mov    $0xe,%eax
     69a:	cd 40                	int    $0x40
     69c:	c3                   	ret    

0000069d <paintWindow>:

SYSCALL(paintWindow)
     69d:	b8 16 00 00 00       	mov    $0x16,%eax
     6a2:	cd 40                	int    $0x40
     6a4:	c3                   	ret    

000006a5 <sendMessage>:
SYSCALL(sendMessage)
     6a5:	b8 17 00 00 00       	mov    $0x17,%eax
     6aa:	cd 40                	int    $0x40
     6ac:	c3                   	ret    

000006ad <getMessage>:
SYSCALL(getMessage)
     6ad:	b8 19 00 00 00       	mov    $0x19,%eax
     6b2:	cd 40                	int    $0x40
     6b4:	c3                   	ret    

000006b5 <registWindow>:
SYSCALL(registWindow)
     6b5:	b8 18 00 00 00       	mov    $0x18,%eax
     6ba:	cd 40                	int    $0x40
     6bc:	c3                   	ret    

000006bd <changePosition>:
SYSCALL(changePosition)
     6bd:	b8 1a 00 00 00       	mov    $0x1a,%eax
     6c2:	cd 40                	int    $0x40
     6c4:	c3                   	ret    

000006c5 <setupTimer>:
SYSCALL(setupTimer)
     6c5:	b8 1b 00 00 00       	mov    $0x1b,%eax
     6ca:	cd 40                	int    $0x40
     6cc:	c3                   	ret    

000006cd <deleteTimer>:
SYSCALL(deleteTimer)
     6cd:	b8 1c 00 00 00       	mov    $0x1c,%eax
     6d2:	cd 40                	int    $0x40
     6d4:	c3                   	ret    

000006d5 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     6d5:	55                   	push   %ebp
     6d6:	89 e5                	mov    %esp,%ebp
     6d8:	83 ec 18             	sub    $0x18,%esp
     6db:	8b 45 0c             	mov    0xc(%ebp),%eax
     6de:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     6e1:	83 ec 04             	sub    $0x4,%esp
     6e4:	6a 01                	push   $0x1
     6e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
     6e9:	50                   	push   %eax
     6ea:	ff 75 08             	pushl  0x8(%ebp)
     6ed:	e8 2b ff ff ff       	call   61d <write>
     6f2:	83 c4 10             	add    $0x10,%esp
}
     6f5:	90                   	nop
     6f6:	c9                   	leave  
     6f7:	c3                   	ret    

000006f8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     6f8:	55                   	push   %ebp
     6f9:	89 e5                	mov    %esp,%ebp
     6fb:	53                   	push   %ebx
     6fc:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     6ff:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     706:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     70a:	74 17                	je     723 <printint+0x2b>
     70c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     710:	79 11                	jns    723 <printint+0x2b>
    neg = 1;
     712:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     719:	8b 45 0c             	mov    0xc(%ebp),%eax
     71c:	f7 d8                	neg    %eax
     71e:	89 45 ec             	mov    %eax,-0x14(%ebp)
     721:	eb 06                	jmp    729 <printint+0x31>
  } else {
    x = xx;
     723:	8b 45 0c             	mov    0xc(%ebp),%eax
     726:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     729:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     730:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     733:	8d 41 01             	lea    0x1(%ecx),%eax
     736:	89 45 f4             	mov    %eax,-0xc(%ebp)
     739:	8b 5d 10             	mov    0x10(%ebp),%ebx
     73c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     73f:	ba 00 00 00 00       	mov    $0x0,%edx
     744:	f7 f3                	div    %ebx
     746:	89 d0                	mov    %edx,%eax
     748:	0f b6 80 60 31 00 00 	movzbl 0x3160(%eax),%eax
     74f:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     753:	8b 5d 10             	mov    0x10(%ebp),%ebx
     756:	8b 45 ec             	mov    -0x14(%ebp),%eax
     759:	ba 00 00 00 00       	mov    $0x0,%edx
     75e:	f7 f3                	div    %ebx
     760:	89 45 ec             	mov    %eax,-0x14(%ebp)
     763:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     767:	75 c7                	jne    730 <printint+0x38>
  if(neg)
     769:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     76d:	74 2d                	je     79c <printint+0xa4>
    buf[i++] = '-';
     76f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     772:	8d 50 01             	lea    0x1(%eax),%edx
     775:	89 55 f4             	mov    %edx,-0xc(%ebp)
     778:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     77d:	eb 1d                	jmp    79c <printint+0xa4>
    putc(fd, buf[i]);
     77f:	8d 55 dc             	lea    -0x24(%ebp),%edx
     782:	8b 45 f4             	mov    -0xc(%ebp),%eax
     785:	01 d0                	add    %edx,%eax
     787:	0f b6 00             	movzbl (%eax),%eax
     78a:	0f be c0             	movsbl %al,%eax
     78d:	83 ec 08             	sub    $0x8,%esp
     790:	50                   	push   %eax
     791:	ff 75 08             	pushl  0x8(%ebp)
     794:	e8 3c ff ff ff       	call   6d5 <putc>
     799:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     79c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     7a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7a4:	79 d9                	jns    77f <printint+0x87>
    putc(fd, buf[i]);
}
     7a6:	90                   	nop
     7a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7aa:	c9                   	leave  
     7ab:	c3                   	ret    

000007ac <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     7ac:	55                   	push   %ebp
     7ad:	89 e5                	mov    %esp,%ebp
     7af:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     7b2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     7b9:	8d 45 0c             	lea    0xc(%ebp),%eax
     7bc:	83 c0 04             	add    $0x4,%eax
     7bf:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     7c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     7c9:	e9 59 01 00 00       	jmp    927 <printf+0x17b>
    c = fmt[i] & 0xff;
     7ce:	8b 55 0c             	mov    0xc(%ebp),%edx
     7d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d4:	01 d0                	add    %edx,%eax
     7d6:	0f b6 00             	movzbl (%eax),%eax
     7d9:	0f be c0             	movsbl %al,%eax
     7dc:	25 ff 00 00 00       	and    $0xff,%eax
     7e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     7e4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     7e8:	75 2c                	jne    816 <printf+0x6a>
      if(c == '%'){
     7ea:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     7ee:	75 0c                	jne    7fc <printf+0x50>
        state = '%';
     7f0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     7f7:	e9 27 01 00 00       	jmp    923 <printf+0x177>
      } else {
        putc(fd, c);
     7fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7ff:	0f be c0             	movsbl %al,%eax
     802:	83 ec 08             	sub    $0x8,%esp
     805:	50                   	push   %eax
     806:	ff 75 08             	pushl  0x8(%ebp)
     809:	e8 c7 fe ff ff       	call   6d5 <putc>
     80e:	83 c4 10             	add    $0x10,%esp
     811:	e9 0d 01 00 00       	jmp    923 <printf+0x177>
      }
    } else if(state == '%'){
     816:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     81a:	0f 85 03 01 00 00    	jne    923 <printf+0x177>
      if(c == 'd'){
     820:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     824:	75 1e                	jne    844 <printf+0x98>
        printint(fd, *ap, 10, 1);
     826:	8b 45 e8             	mov    -0x18(%ebp),%eax
     829:	8b 00                	mov    (%eax),%eax
     82b:	6a 01                	push   $0x1
     82d:	6a 0a                	push   $0xa
     82f:	50                   	push   %eax
     830:	ff 75 08             	pushl  0x8(%ebp)
     833:	e8 c0 fe ff ff       	call   6f8 <printint>
     838:	83 c4 10             	add    $0x10,%esp
        ap++;
     83b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     83f:	e9 d8 00 00 00       	jmp    91c <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     844:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     848:	74 06                	je     850 <printf+0xa4>
     84a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     84e:	75 1e                	jne    86e <printf+0xc2>
        printint(fd, *ap, 16, 0);
     850:	8b 45 e8             	mov    -0x18(%ebp),%eax
     853:	8b 00                	mov    (%eax),%eax
     855:	6a 00                	push   $0x0
     857:	6a 10                	push   $0x10
     859:	50                   	push   %eax
     85a:	ff 75 08             	pushl  0x8(%ebp)
     85d:	e8 96 fe ff ff       	call   6f8 <printint>
     862:	83 c4 10             	add    $0x10,%esp
        ap++;
     865:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     869:	e9 ae 00 00 00       	jmp    91c <printf+0x170>
      } else if(c == 's'){
     86e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     872:	75 43                	jne    8b7 <printf+0x10b>
        s = (char*)*ap;
     874:	8b 45 e8             	mov    -0x18(%ebp),%eax
     877:	8b 00                	mov    (%eax),%eax
     879:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     87c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     880:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     884:	75 25                	jne    8ab <printf+0xff>
          s = "(null)";
     886:	c7 45 f4 48 27 00 00 	movl   $0x2748,-0xc(%ebp)
        while(*s != 0){
     88d:	eb 1c                	jmp    8ab <printf+0xff>
          putc(fd, *s);
     88f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     892:	0f b6 00             	movzbl (%eax),%eax
     895:	0f be c0             	movsbl %al,%eax
     898:	83 ec 08             	sub    $0x8,%esp
     89b:	50                   	push   %eax
     89c:	ff 75 08             	pushl  0x8(%ebp)
     89f:	e8 31 fe ff ff       	call   6d5 <putc>
     8a4:	83 c4 10             	add    $0x10,%esp
          s++;
     8a7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     8ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8ae:	0f b6 00             	movzbl (%eax),%eax
     8b1:	84 c0                	test   %al,%al
     8b3:	75 da                	jne    88f <printf+0xe3>
     8b5:	eb 65                	jmp    91c <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     8b7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     8bb:	75 1d                	jne    8da <printf+0x12e>
        putc(fd, *ap);
     8bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     8c0:	8b 00                	mov    (%eax),%eax
     8c2:	0f be c0             	movsbl %al,%eax
     8c5:	83 ec 08             	sub    $0x8,%esp
     8c8:	50                   	push   %eax
     8c9:	ff 75 08             	pushl  0x8(%ebp)
     8cc:	e8 04 fe ff ff       	call   6d5 <putc>
     8d1:	83 c4 10             	add    $0x10,%esp
        ap++;
     8d4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     8d8:	eb 42                	jmp    91c <printf+0x170>
      } else if(c == '%'){
     8da:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     8de:	75 17                	jne    8f7 <printf+0x14b>
        putc(fd, c);
     8e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8e3:	0f be c0             	movsbl %al,%eax
     8e6:	83 ec 08             	sub    $0x8,%esp
     8e9:	50                   	push   %eax
     8ea:	ff 75 08             	pushl  0x8(%ebp)
     8ed:	e8 e3 fd ff ff       	call   6d5 <putc>
     8f2:	83 c4 10             	add    $0x10,%esp
     8f5:	eb 25                	jmp    91c <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     8f7:	83 ec 08             	sub    $0x8,%esp
     8fa:	6a 25                	push   $0x25
     8fc:	ff 75 08             	pushl  0x8(%ebp)
     8ff:	e8 d1 fd ff ff       	call   6d5 <putc>
     904:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     907:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     90a:	0f be c0             	movsbl %al,%eax
     90d:	83 ec 08             	sub    $0x8,%esp
     910:	50                   	push   %eax
     911:	ff 75 08             	pushl  0x8(%ebp)
     914:	e8 bc fd ff ff       	call   6d5 <putc>
     919:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     91c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     923:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     927:	8b 55 0c             	mov    0xc(%ebp),%edx
     92a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     92d:	01 d0                	add    %edx,%eax
     92f:	0f b6 00             	movzbl (%eax),%eax
     932:	84 c0                	test   %al,%al
     934:	0f 85 94 fe ff ff    	jne    7ce <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     93a:	90                   	nop
     93b:	c9                   	leave  
     93c:	c3                   	ret    

0000093d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     93d:	55                   	push   %ebp
     93e:	89 e5                	mov    %esp,%ebp
     940:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     943:	8b 45 08             	mov    0x8(%ebp),%eax
     946:	83 e8 08             	sub    $0x8,%eax
     949:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     94c:	a1 c0 6d 00 00       	mov    0x6dc0,%eax
     951:	89 45 fc             	mov    %eax,-0x4(%ebp)
     954:	eb 24                	jmp    97a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     956:	8b 45 fc             	mov    -0x4(%ebp),%eax
     959:	8b 00                	mov    (%eax),%eax
     95b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     95e:	77 12                	ja     972 <free+0x35>
     960:	8b 45 f8             	mov    -0x8(%ebp),%eax
     963:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     966:	77 24                	ja     98c <free+0x4f>
     968:	8b 45 fc             	mov    -0x4(%ebp),%eax
     96b:	8b 00                	mov    (%eax),%eax
     96d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     970:	77 1a                	ja     98c <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     972:	8b 45 fc             	mov    -0x4(%ebp),%eax
     975:	8b 00                	mov    (%eax),%eax
     977:	89 45 fc             	mov    %eax,-0x4(%ebp)
     97a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     97d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     980:	76 d4                	jbe    956 <free+0x19>
     982:	8b 45 fc             	mov    -0x4(%ebp),%eax
     985:	8b 00                	mov    (%eax),%eax
     987:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     98a:	76 ca                	jbe    956 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     98c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     98f:	8b 40 04             	mov    0x4(%eax),%eax
     992:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     999:	8b 45 f8             	mov    -0x8(%ebp),%eax
     99c:	01 c2                	add    %eax,%edx
     99e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a1:	8b 00                	mov    (%eax),%eax
     9a3:	39 c2                	cmp    %eax,%edx
     9a5:	75 24                	jne    9cb <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     9a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9aa:	8b 50 04             	mov    0x4(%eax),%edx
     9ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9b0:	8b 00                	mov    (%eax),%eax
     9b2:	8b 40 04             	mov    0x4(%eax),%eax
     9b5:	01 c2                	add    %eax,%edx
     9b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9ba:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     9bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9c0:	8b 00                	mov    (%eax),%eax
     9c2:	8b 10                	mov    (%eax),%edx
     9c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9c7:	89 10                	mov    %edx,(%eax)
     9c9:	eb 0a                	jmp    9d5 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     9cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9ce:	8b 10                	mov    (%eax),%edx
     9d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9d3:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     9d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9d8:	8b 40 04             	mov    0x4(%eax),%eax
     9db:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     9e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9e5:	01 d0                	add    %edx,%eax
     9e7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     9ea:	75 20                	jne    a0c <free+0xcf>
    p->s.size += bp->s.size;
     9ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9ef:	8b 50 04             	mov    0x4(%eax),%edx
     9f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9f5:	8b 40 04             	mov    0x4(%eax),%eax
     9f8:	01 c2                	add    %eax,%edx
     9fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9fd:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     a00:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a03:	8b 10                	mov    (%eax),%edx
     a05:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a08:	89 10                	mov    %edx,(%eax)
     a0a:	eb 08                	jmp    a14 <free+0xd7>
  } else
    p->s.ptr = bp;
     a0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a0f:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a12:	89 10                	mov    %edx,(%eax)
  freep = p;
     a14:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a17:	a3 c0 6d 00 00       	mov    %eax,0x6dc0
}
     a1c:	90                   	nop
     a1d:	c9                   	leave  
     a1e:	c3                   	ret    

00000a1f <morecore>:

static Header*
morecore(uint nu)
{
     a1f:	55                   	push   %ebp
     a20:	89 e5                	mov    %esp,%ebp
     a22:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     a25:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     a2c:	77 07                	ja     a35 <morecore+0x16>
    nu = 4096;
     a2e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     a35:	8b 45 08             	mov    0x8(%ebp),%eax
     a38:	c1 e0 03             	shl    $0x3,%eax
     a3b:	83 ec 0c             	sub    $0xc,%esp
     a3e:	50                   	push   %eax
     a3f:	e8 41 fc ff ff       	call   685 <sbrk>
     a44:	83 c4 10             	add    $0x10,%esp
     a47:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     a4a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     a4e:	75 07                	jne    a57 <morecore+0x38>
    return 0;
     a50:	b8 00 00 00 00       	mov    $0x0,%eax
     a55:	eb 26                	jmp    a7d <morecore+0x5e>
  hp = (Header*)p;
     a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     a5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a60:	8b 55 08             	mov    0x8(%ebp),%edx
     a63:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     a66:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a69:	83 c0 08             	add    $0x8,%eax
     a6c:	83 ec 0c             	sub    $0xc,%esp
     a6f:	50                   	push   %eax
     a70:	e8 c8 fe ff ff       	call   93d <free>
     a75:	83 c4 10             	add    $0x10,%esp
  return freep;
     a78:	a1 c0 6d 00 00       	mov    0x6dc0,%eax
}
     a7d:	c9                   	leave  
     a7e:	c3                   	ret    

00000a7f <malloc>:

void*
malloc(uint nbytes)
{
     a7f:	55                   	push   %ebp
     a80:	89 e5                	mov    %esp,%ebp
     a82:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a85:	8b 45 08             	mov    0x8(%ebp),%eax
     a88:	83 c0 07             	add    $0x7,%eax
     a8b:	c1 e8 03             	shr    $0x3,%eax
     a8e:	83 c0 01             	add    $0x1,%eax
     a91:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a94:	a1 c0 6d 00 00       	mov    0x6dc0,%eax
     a99:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a9c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     aa0:	75 23                	jne    ac5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     aa2:	c7 45 f0 b8 6d 00 00 	movl   $0x6db8,-0x10(%ebp)
     aa9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aac:	a3 c0 6d 00 00       	mov    %eax,0x6dc0
     ab1:	a1 c0 6d 00 00       	mov    0x6dc0,%eax
     ab6:	a3 b8 6d 00 00       	mov    %eax,0x6db8
    base.s.size = 0;
     abb:	c7 05 bc 6d 00 00 00 	movl   $0x0,0x6dbc
     ac2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     ac5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ac8:	8b 00                	mov    (%eax),%eax
     aca:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad0:	8b 40 04             	mov    0x4(%eax),%eax
     ad3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     ad6:	72 4d                	jb     b25 <malloc+0xa6>
      if(p->s.size == nunits)
     ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     adb:	8b 40 04             	mov    0x4(%eax),%eax
     ade:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     ae1:	75 0c                	jne    aef <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae6:	8b 10                	mov    (%eax),%edx
     ae8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aeb:	89 10                	mov    %edx,(%eax)
     aed:	eb 26                	jmp    b15 <malloc+0x96>
      else {
        p->s.size -= nunits;
     aef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af2:	8b 40 04             	mov    0x4(%eax),%eax
     af5:	2b 45 ec             	sub    -0x14(%ebp),%eax
     af8:	89 c2                	mov    %eax,%edx
     afa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     afd:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     b00:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b03:	8b 40 04             	mov    0x4(%eax),%eax
     b06:	c1 e0 03             	shl    $0x3,%eax
     b09:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     b0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b0f:	8b 55 ec             	mov    -0x14(%ebp),%edx
     b12:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     b15:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b18:	a3 c0 6d 00 00       	mov    %eax,0x6dc0
      return (void*)(p + 1);
     b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b20:	83 c0 08             	add    $0x8,%eax
     b23:	eb 3b                	jmp    b60 <malloc+0xe1>
    }
    if(p == freep)
     b25:	a1 c0 6d 00 00       	mov    0x6dc0,%eax
     b2a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     b2d:	75 1e                	jne    b4d <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     b2f:	83 ec 0c             	sub    $0xc,%esp
     b32:	ff 75 ec             	pushl  -0x14(%ebp)
     b35:	e8 e5 fe ff ff       	call   a1f <morecore>
     b3a:	83 c4 10             	add    $0x10,%esp
     b3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
     b40:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b44:	75 07                	jne    b4d <malloc+0xce>
        return 0;
     b46:	b8 00 00 00 00       	mov    $0x0,%eax
     b4b:	eb 13                	jmp    b60 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     b4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b50:	89 45 f0             	mov    %eax,-0x10(%ebp)
     b53:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b56:	8b 00                	mov    (%eax),%eax
     b58:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     b5b:	e9 6d ff ff ff       	jmp    acd <malloc+0x4e>
}
     b60:	c9                   	leave  
     b61:	c3                   	ret    

00000b62 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     b62:	55                   	push   %ebp
     b63:	89 e5                	mov    %esp,%ebp
     b65:	83 ec 1c             	sub    $0x1c,%esp
     b68:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     b6b:	8b 55 10             	mov    0x10(%ebp),%edx
     b6e:	8b 45 14             	mov    0x14(%ebp),%eax
     b71:	88 4d ec             	mov    %cl,-0x14(%ebp)
     b74:	88 55 e8             	mov    %dl,-0x18(%ebp)
     b77:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     b7a:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     b7e:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     b81:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     b85:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     b88:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     b8c:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     b8f:	8b 45 08             	mov    0x8(%ebp),%eax
     b92:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     b96:	66 89 10             	mov    %dx,(%eax)
     b99:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     b9d:	88 50 02             	mov    %dl,0x2(%eax)
}
     ba0:	8b 45 08             	mov    0x8(%ebp),%eax
     ba3:	c9                   	leave  
     ba4:	c2 04 00             	ret    $0x4

00000ba7 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     ba7:	55                   	push   %ebp
     ba8:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     baa:	8b 45 08             	mov    0x8(%ebp),%eax
     bad:	2b 45 10             	sub    0x10(%ebp),%eax
     bb0:	89 c2                	mov    %eax,%edx
     bb2:	8b 45 08             	mov    0x8(%ebp),%eax
     bb5:	2b 45 10             	sub    0x10(%ebp),%eax
     bb8:	0f af d0             	imul   %eax,%edx
     bbb:	8b 45 0c             	mov    0xc(%ebp),%eax
     bbe:	2b 45 14             	sub    0x14(%ebp),%eax
     bc1:	89 c1                	mov    %eax,%ecx
     bc3:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc6:	2b 45 14             	sub    0x14(%ebp),%eax
     bc9:	0f af c1             	imul   %ecx,%eax
     bcc:	01 d0                	add    %edx,%eax
}
     bce:	5d                   	pop    %ebp
     bcf:	c3                   	ret    

00000bd0 <abs_int>:

static inline int abs_int(int x)
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     bd3:	8b 45 08             	mov    0x8(%ebp),%eax
     bd6:	99                   	cltd   
     bd7:	89 d0                	mov    %edx,%eax
     bd9:	33 45 08             	xor    0x8(%ebp),%eax
     bdc:	29 d0                	sub    %edx,%eax
}
     bde:	5d                   	pop    %ebp
     bdf:	c3                   	ret    

00000be0 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     be0:	55                   	push   %ebp
     be1:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     be3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     be7:	79 07                	jns    bf0 <APGetIndex+0x10>
        return X_SMALLER;
     be9:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     bee:	eb 40                	jmp    c30 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     bf0:	8b 45 08             	mov    0x8(%ebp),%eax
     bf3:	8b 00                	mov    (%eax),%eax
     bf5:	3b 45 0c             	cmp    0xc(%ebp),%eax
     bf8:	7f 07                	jg     c01 <APGetIndex+0x21>
        return X_BIGGER;
     bfa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     bff:	eb 2f                	jmp    c30 <APGetIndex+0x50>
    if (y < 0)
     c01:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     c05:	79 07                	jns    c0e <APGetIndex+0x2e>
        return Y_SMALLER;
     c07:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     c0c:	eb 22                	jmp    c30 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     c0e:	8b 45 08             	mov    0x8(%ebp),%eax
     c11:	8b 40 04             	mov    0x4(%eax),%eax
     c14:	3b 45 10             	cmp    0x10(%ebp),%eax
     c17:	7f 07                	jg     c20 <APGetIndex+0x40>
        return Y_BIGGER;
     c19:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     c1e:	eb 10                	jmp    c30 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     c20:	8b 45 08             	mov    0x8(%ebp),%eax
     c23:	8b 00                	mov    (%eax),%eax
     c25:	0f af 45 10          	imul   0x10(%ebp),%eax
     c29:	89 c2                	mov    %eax,%edx
     c2b:	8b 45 0c             	mov    0xc(%ebp),%eax
     c2e:	01 d0                	add    %edx,%eax
}
     c30:	5d                   	pop    %ebp
     c31:	c3                   	ret    

00000c32 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     c32:	55                   	push   %ebp
     c33:	89 e5                	mov    %esp,%ebp
     c35:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     c38:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     c3f:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c42:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     c45:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     c4c:	83 ec 08             	sub    $0x8,%esp
     c4f:	6a 00                	push   $0x0
     c51:	ff 75 0c             	pushl  0xc(%ebp)
     c54:	e8 e4 f9 ff ff       	call   63d <open>
     c59:	83 c4 10             	add    $0x10,%esp
     c5c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     c5f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     c63:	79 2e                	jns    c93 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     c65:	83 ec 04             	sub    $0x4,%esp
     c68:	ff 75 0c             	pushl  0xc(%ebp)
     c6b:	68 4f 27 00 00       	push   $0x274f
     c70:	6a 01                	push   $0x1
     c72:	e8 35 fb ff ff       	call   7ac <printf>
     c77:	83 c4 10             	add    $0x10,%esp
        return bmp;
     c7a:	8b 45 08             	mov    0x8(%ebp),%eax
     c7d:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c80:	89 10                	mov    %edx,(%eax)
     c82:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c85:	89 50 04             	mov    %edx,0x4(%eax)
     c88:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c8b:	89 50 08             	mov    %edx,0x8(%eax)
     c8e:	e9 d2 01 00 00       	jmp    e65 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     c93:	83 ec 04             	sub    $0x4,%esp
     c96:	6a 0e                	push   $0xe
     c98:	8d 45 ba             	lea    -0x46(%ebp),%eax
     c9b:	50                   	push   %eax
     c9c:	ff 75 ec             	pushl  -0x14(%ebp)
     c9f:	e8 71 f9 ff ff       	call   615 <read>
     ca4:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     ca7:	83 ec 04             	sub    $0x4,%esp
     caa:	6a 28                	push   $0x28
     cac:	8d 45 92             	lea    -0x6e(%ebp),%eax
     caf:	50                   	push   %eax
     cb0:	ff 75 ec             	pushl  -0x14(%ebp)
     cb3:	e8 5d f9 ff ff       	call   615 <read>
     cb8:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     cbb:	8b 45 96             	mov    -0x6a(%ebp),%eax
     cbe:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     cc1:	8b 45 9a             	mov    -0x66(%ebp),%eax
     cc4:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     cc7:	8b 55 c8             	mov    -0x38(%ebp),%edx
     cca:	8b 45 cc             	mov    -0x34(%ebp),%eax
     ccd:	0f af d0             	imul   %eax,%edx
     cd0:	89 d0                	mov    %edx,%eax
     cd2:	01 c0                	add    %eax,%eax
     cd4:	01 d0                	add    %edx,%eax
     cd6:	83 ec 0c             	sub    $0xc,%esp
     cd9:	50                   	push   %eax
     cda:	e8 a0 fd ff ff       	call   a7f <malloc>
     cdf:	83 c4 10             	add    $0x10,%esp
     ce2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     ce5:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     ce9:	0f b7 c0             	movzwl %ax,%eax
     cec:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     cef:	8b 55 c8             	mov    -0x38(%ebp),%edx
     cf2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cf5:	0f af c2             	imul   %edx,%eax
     cf8:	83 c0 1f             	add    $0x1f,%eax
     cfb:	c1 e8 05             	shr    $0x5,%eax
     cfe:	c1 e0 02             	shl    $0x2,%eax
     d01:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     d04:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d07:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d0a:	0f af c2             	imul   %edx,%eax
     d0d:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     d10:	8b 45 e0             	mov    -0x20(%ebp),%eax
     d13:	83 ec 0c             	sub    $0xc,%esp
     d16:	50                   	push   %eax
     d17:	e8 63 fd ff ff       	call   a7f <malloc>
     d1c:	83 c4 10             	add    $0x10,%esp
     d1f:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     d22:	83 ec 04             	sub    $0x4,%esp
     d25:	ff 75 e0             	pushl  -0x20(%ebp)
     d28:	ff 75 dc             	pushl  -0x24(%ebp)
     d2b:	ff 75 ec             	pushl  -0x14(%ebp)
     d2e:	e8 e2 f8 ff ff       	call   615 <read>
     d33:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     d36:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     d3a:	66 c1 e8 03          	shr    $0x3,%ax
     d3e:	0f b7 c0             	movzwl %ax,%eax
     d41:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     d44:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d4b:	e9 e5 00 00 00       	jmp    e35 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     d50:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d53:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d56:	29 c2                	sub    %eax,%edx
     d58:	89 d0                	mov    %edx,%eax
     d5a:	8d 50 ff             	lea    -0x1(%eax),%edx
     d5d:	8b 45 c8             	mov    -0x38(%ebp),%eax
     d60:	0f af c2             	imul   %edx,%eax
     d63:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     d66:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     d6d:	e9 b1 00 00 00       	jmp    e23 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     d72:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d75:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d78:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d7b:	01 c8                	add    %ecx,%eax
     d7d:	89 c1                	mov    %eax,%ecx
     d7f:	89 c8                	mov    %ecx,%eax
     d81:	01 c0                	add    %eax,%eax
     d83:	01 c8                	add    %ecx,%eax
     d85:	01 c2                	add    %eax,%edx
     d87:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d8a:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d8e:	89 c1                	mov    %eax,%ecx
     d90:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d93:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d97:	01 c1                	add    %eax,%ecx
     d99:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d9c:	01 c8                	add    %ecx,%eax
     d9e:	8d 48 ff             	lea    -0x1(%eax),%ecx
     da1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     da4:	01 c8                	add    %ecx,%eax
     da6:	0f b6 00             	movzbl (%eax),%eax
     da9:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     dac:	8b 55 d0             	mov    -0x30(%ebp),%edx
     daf:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     db2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     db5:	01 c8                	add    %ecx,%eax
     db7:	89 c1                	mov    %eax,%ecx
     db9:	89 c8                	mov    %ecx,%eax
     dbb:	01 c0                	add    %eax,%eax
     dbd:	01 c8                	add    %ecx,%eax
     dbf:	01 c2                	add    %eax,%edx
     dc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dc4:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     dc8:	89 c1                	mov    %eax,%ecx
     dca:	8b 45 d8             	mov    -0x28(%ebp),%eax
     dcd:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     dd1:	01 c1                	add    %eax,%ecx
     dd3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     dd6:	01 c8                	add    %ecx,%eax
     dd8:	8d 48 fe             	lea    -0x2(%eax),%ecx
     ddb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dde:	01 c8                	add    %ecx,%eax
     de0:	0f b6 00             	movzbl (%eax),%eax
     de3:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     de6:	8b 55 d0             	mov    -0x30(%ebp),%edx
     de9:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     dec:	8b 45 f0             	mov    -0x10(%ebp),%eax
     def:	01 c8                	add    %ecx,%eax
     df1:	89 c1                	mov    %eax,%ecx
     df3:	89 c8                	mov    %ecx,%eax
     df5:	01 c0                	add    %eax,%eax
     df7:	01 c8                	add    %ecx,%eax
     df9:	01 c2                	add    %eax,%edx
     dfb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dfe:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     e02:	89 c1                	mov    %eax,%ecx
     e04:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e07:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     e0b:	01 c1                	add    %eax,%ecx
     e0d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e10:	01 c8                	add    %ecx,%eax
     e12:	8d 48 fd             	lea    -0x3(%eax),%ecx
     e15:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e18:	01 c8                	add    %ecx,%eax
     e1a:	0f b6 00             	movzbl (%eax),%eax
     e1d:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     e1f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e23:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e26:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e29:	39 c2                	cmp    %eax,%edx
     e2b:	0f 87 41 ff ff ff    	ja     d72 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     e31:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e35:	8b 55 cc             	mov    -0x34(%ebp),%edx
     e38:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e3b:	39 c2                	cmp    %eax,%edx
     e3d:	0f 87 0d ff ff ff    	ja     d50 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     e43:	83 ec 0c             	sub    $0xc,%esp
     e46:	ff 75 ec             	pushl  -0x14(%ebp)
     e49:	e8 d7 f7 ff ff       	call   625 <close>
     e4e:	83 c4 10             	add    $0x10,%esp
    return bmp;
     e51:	8b 45 08             	mov    0x8(%ebp),%eax
     e54:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e57:	89 10                	mov    %edx,(%eax)
     e59:	8b 55 cc             	mov    -0x34(%ebp),%edx
     e5c:	89 50 04             	mov    %edx,0x4(%eax)
     e5f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     e62:	89 50 08             	mov    %edx,0x8(%eax)
}
     e65:	8b 45 08             	mov    0x8(%ebp),%eax
     e68:	c9                   	leave  
     e69:	c2 04 00             	ret    $0x4

00000e6c <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     e6c:	55                   	push   %ebp
     e6d:	89 e5                	mov    %esp,%ebp
     e6f:	53                   	push   %ebx
     e70:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     e73:	83 ec 0c             	sub    $0xc,%esp
     e76:	6a 1c                	push   $0x1c
     e78:	e8 02 fc ff ff       	call   a7f <malloc>
     e7d:	83 c4 10             	add    $0x10,%esp
     e80:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     e83:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e86:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     e8d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     e90:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e93:	6a 0c                	push   $0xc
     e95:	6a 0c                	push   $0xc
     e97:	6a 0c                	push   $0xc
     e99:	50                   	push   %eax
     e9a:	e8 c3 fc ff ff       	call   b62 <RGB>
     e9f:	83 c4 0c             	add    $0xc,%esp
     ea2:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     ea6:	66 89 43 13          	mov    %ax,0x13(%ebx)
     eaa:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     eae:	88 43 15             	mov    %al,0x15(%ebx)
     eb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eb4:	8b 55 f4             	mov    -0xc(%ebp),%edx
     eb7:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     ebb:	66 89 48 10          	mov    %cx,0x10(%eax)
     ebf:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     ec3:	88 50 12             	mov    %dl,0x12(%eax)
     ec6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ec9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ecc:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     ed0:	66 89 48 08          	mov    %cx,0x8(%eax)
     ed4:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     ed8:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     edb:	8b 45 08             	mov    0x8(%ebp),%eax
     ede:	89 c2                	mov    %eax,%edx
     ee0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ee3:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     ee5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ee8:	89 c2                	mov    %eax,%edx
     eea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eed:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     ef0:	8b 55 10             	mov    0x10(%ebp),%edx
     ef3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ef6:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     ef9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     efc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     eff:	c9                   	leave  
     f00:	c3                   	ret    

00000f01 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     f01:	55                   	push   %ebp
     f02:	89 e5                	mov    %esp,%ebp
     f04:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     f07:	8b 45 0c             	mov    0xc(%ebp),%eax
     f0a:	8b 50 08             	mov    0x8(%eax),%edx
     f0d:	89 55 f8             	mov    %edx,-0x8(%ebp)
     f10:	8b 40 0c             	mov    0xc(%eax),%eax
     f13:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     f16:	8b 45 0c             	mov    0xc(%ebp),%eax
     f19:	8b 55 10             	mov    0x10(%ebp),%edx
     f1c:	89 50 08             	mov    %edx,0x8(%eax)
     f1f:	8b 55 14             	mov    0x14(%ebp),%edx
     f22:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     f25:	8b 45 08             	mov    0x8(%ebp),%eax
     f28:	8b 55 f8             	mov    -0x8(%ebp),%edx
     f2b:	89 10                	mov    %edx,(%eax)
     f2d:	8b 55 fc             	mov    -0x4(%ebp),%edx
     f30:	89 50 04             	mov    %edx,0x4(%eax)
}
     f33:	8b 45 08             	mov    0x8(%ebp),%eax
     f36:	c9                   	leave  
     f37:	c2 04 00             	ret    $0x4

00000f3a <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     f3a:	55                   	push   %ebp
     f3b:	89 e5                	mov    %esp,%ebp
     f3d:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     f40:	8b 45 0c             	mov    0xc(%ebp),%eax
     f43:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     f47:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     f4b:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     f4f:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     f52:	8b 45 0c             	mov    0xc(%ebp),%eax
     f55:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     f59:	66 89 50 10          	mov    %dx,0x10(%eax)
     f5d:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     f61:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     f64:	8b 45 08             	mov    0x8(%ebp),%eax
     f67:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     f6b:	66 89 10             	mov    %dx,(%eax)
     f6e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     f72:	88 50 02             	mov    %dl,0x2(%eax)
}
     f75:	8b 45 08             	mov    0x8(%ebp),%eax
     f78:	c9                   	leave  
     f79:	c2 04 00             	ret    $0x4

00000f7c <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     f7c:	55                   	push   %ebp
     f7d:	89 e5                	mov    %esp,%ebp
     f7f:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     f82:	8b 45 0c             	mov    0xc(%ebp),%eax
     f85:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     f89:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     f8d:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     f91:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     f94:	8b 45 0c             	mov    0xc(%ebp),%eax
     f97:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     f9b:	66 89 50 13          	mov    %dx,0x13(%eax)
     f9f:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     fa3:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     fa6:	8b 45 08             	mov    0x8(%ebp),%eax
     fa9:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     fad:	66 89 10             	mov    %dx,(%eax)
     fb0:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     fb4:	88 50 02             	mov    %dl,0x2(%eax)
}
     fb7:	8b 45 08             	mov    0x8(%ebp),%eax
     fba:	c9                   	leave  
     fbb:	c2 04 00             	ret    $0x4

00000fbe <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     fbe:	55                   	push   %ebp
     fbf:	89 e5                	mov    %esp,%ebp
     fc1:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     fc4:	8b 45 08             	mov    0x8(%ebp),%eax
     fc7:	8b 40 0c             	mov    0xc(%eax),%eax
     fca:	89 c2                	mov    %eax,%edx
     fcc:	c1 ea 1f             	shr    $0x1f,%edx
     fcf:	01 d0                	add    %edx,%eax
     fd1:	d1 f8                	sar    %eax
     fd3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     fd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fd9:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     fdd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     fe0:	8b 45 10             	mov    0x10(%ebp),%eax
     fe3:	2b 45 f4             	sub    -0xc(%ebp),%eax
     fe6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     fe9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     fed:	0f 89 98 00 00 00    	jns    108b <APDrawPoint+0xcd>
        i = 0;
     ff3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     ffa:	e9 8c 00 00 00       	jmp    108b <APDrawPoint+0xcd>
    {
        j = x - off;
     fff:	8b 45 0c             	mov    0xc(%ebp),%eax
    1002:	2b 45 f4             	sub    -0xc(%ebp),%eax
    1005:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    1008:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    100c:	79 69                	jns    1077 <APDrawPoint+0xb9>
            j = 0;
    100e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    1015:	eb 60                	jmp    1077 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    1017:	ff 75 fc             	pushl  -0x4(%ebp)
    101a:	ff 75 f8             	pushl  -0x8(%ebp)
    101d:	ff 75 08             	pushl  0x8(%ebp)
    1020:	e8 bb fb ff ff       	call   be0 <APGetIndex>
    1025:	83 c4 0c             	add    $0xc,%esp
    1028:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    102b:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    102f:	74 55                	je     1086 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    1031:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    1035:	74 67                	je     109e <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    1037:	ff 75 10             	pushl  0x10(%ebp)
    103a:	ff 75 0c             	pushl  0xc(%ebp)
    103d:	ff 75 fc             	pushl  -0x4(%ebp)
    1040:	ff 75 f8             	pushl  -0x8(%ebp)
    1043:	e8 5f fb ff ff       	call   ba7 <distance_2>
    1048:	83 c4 10             	add    $0x10,%esp
    104b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    104e:	7f 23                	jg     1073 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    1050:	8b 45 08             	mov    0x8(%ebp),%eax
    1053:	8b 48 18             	mov    0x18(%eax),%ecx
    1056:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1059:	89 d0                	mov    %edx,%eax
    105b:	01 c0                	add    %eax,%eax
    105d:	01 d0                	add    %edx,%eax
    105f:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1062:	8b 45 08             	mov    0x8(%ebp),%eax
    1065:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1069:	66 89 0a             	mov    %cx,(%edx)
    106c:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1070:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1073:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1077:	8b 55 0c             	mov    0xc(%ebp),%edx
    107a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    107d:	01 d0                	add    %edx,%eax
    107f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1082:	7d 93                	jge    1017 <APDrawPoint+0x59>
    1084:	eb 01                	jmp    1087 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1086:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1087:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    108b:	8b 55 10             	mov    0x10(%ebp),%edx
    108e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1091:	01 d0                	add    %edx,%eax
    1093:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1096:	0f 8d 63 ff ff ff    	jge    fff <APDrawPoint+0x41>
    109c:	eb 01                	jmp    109f <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    109e:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    109f:	c9                   	leave  
    10a0:	c3                   	ret    

000010a1 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    10a1:	55                   	push   %ebp
    10a2:	89 e5                	mov    %esp,%ebp
    10a4:	53                   	push   %ebx
    10a5:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    10a8:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ab:	3b 45 14             	cmp    0x14(%ebp),%eax
    10ae:	0f 85 80 00 00 00    	jne    1134 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    10b4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10b8:	0f 88 9d 02 00 00    	js     135b <APDrawLine+0x2ba>
    10be:	8b 45 08             	mov    0x8(%ebp),%eax
    10c1:	8b 00                	mov    (%eax),%eax
    10c3:	3b 45 0c             	cmp    0xc(%ebp),%eax
    10c6:	0f 8e 8f 02 00 00    	jle    135b <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    10cc:	8b 45 10             	mov    0x10(%ebp),%eax
    10cf:	3b 45 18             	cmp    0x18(%ebp),%eax
    10d2:	7e 12                	jle    10e6 <APDrawLine+0x45>
        {
            int tmp = y2;
    10d4:	8b 45 18             	mov    0x18(%ebp),%eax
    10d7:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    10da:	8b 45 10             	mov    0x10(%ebp),%eax
    10dd:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    10e0:	8b 45 dc             	mov    -0x24(%ebp),%eax
    10e3:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    10e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    10ea:	79 07                	jns    10f3 <APDrawLine+0x52>
    10ec:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    10f3:	8b 45 08             	mov    0x8(%ebp),%eax
    10f6:	8b 40 04             	mov    0x4(%eax),%eax
    10f9:	3b 45 18             	cmp    0x18(%ebp),%eax
    10fc:	7d 0c                	jge    110a <APDrawLine+0x69>
    10fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1101:	8b 40 04             	mov    0x4(%eax),%eax
    1104:	83 e8 01             	sub    $0x1,%eax
    1107:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    110a:	8b 45 10             	mov    0x10(%ebp),%eax
    110d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1110:	eb 15                	jmp    1127 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1112:	ff 75 f4             	pushl  -0xc(%ebp)
    1115:	ff 75 0c             	pushl  0xc(%ebp)
    1118:	ff 75 08             	pushl  0x8(%ebp)
    111b:	e8 9e fe ff ff       	call   fbe <APDrawPoint>
    1120:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1123:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1127:	8b 45 f4             	mov    -0xc(%ebp),%eax
    112a:	3b 45 18             	cmp    0x18(%ebp),%eax
    112d:	7e e3                	jle    1112 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    112f:	e9 2b 02 00 00       	jmp    135f <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1134:	8b 45 10             	mov    0x10(%ebp),%eax
    1137:	3b 45 18             	cmp    0x18(%ebp),%eax
    113a:	75 7f                	jne    11bb <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    113c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1140:	0f 88 18 02 00 00    	js     135e <APDrawLine+0x2bd>
    1146:	8b 45 08             	mov    0x8(%ebp),%eax
    1149:	8b 40 04             	mov    0x4(%eax),%eax
    114c:	3b 45 10             	cmp    0x10(%ebp),%eax
    114f:	0f 8e 09 02 00 00    	jle    135e <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1155:	8b 45 0c             	mov    0xc(%ebp),%eax
    1158:	3b 45 14             	cmp    0x14(%ebp),%eax
    115b:	7e 12                	jle    116f <APDrawLine+0xce>
        {
            int tmp = x2;
    115d:	8b 45 14             	mov    0x14(%ebp),%eax
    1160:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1163:	8b 45 0c             	mov    0xc(%ebp),%eax
    1166:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1169:	8b 45 d8             	mov    -0x28(%ebp),%eax
    116c:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    116f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1173:	79 07                	jns    117c <APDrawLine+0xdb>
    1175:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    117c:	8b 45 08             	mov    0x8(%ebp),%eax
    117f:	8b 00                	mov    (%eax),%eax
    1181:	3b 45 14             	cmp    0x14(%ebp),%eax
    1184:	7d 0b                	jge    1191 <APDrawLine+0xf0>
    1186:	8b 45 08             	mov    0x8(%ebp),%eax
    1189:	8b 00                	mov    (%eax),%eax
    118b:	83 e8 01             	sub    $0x1,%eax
    118e:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1191:	8b 45 0c             	mov    0xc(%ebp),%eax
    1194:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1197:	eb 15                	jmp    11ae <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1199:	ff 75 10             	pushl  0x10(%ebp)
    119c:	ff 75 f0             	pushl  -0x10(%ebp)
    119f:	ff 75 08             	pushl  0x8(%ebp)
    11a2:	e8 17 fe ff ff       	call   fbe <APDrawPoint>
    11a7:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    11aa:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11b1:	3b 45 14             	cmp    0x14(%ebp),%eax
    11b4:	7e e3                	jle    1199 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    11b6:	e9 a4 01 00 00       	jmp    135f <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    11bb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    11c2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    11c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    11cc:	2b 45 14             	sub    0x14(%ebp),%eax
    11cf:	50                   	push   %eax
    11d0:	e8 fb f9 ff ff       	call   bd0 <abs_int>
    11d5:	83 c4 04             	add    $0x4,%esp
    11d8:	89 c3                	mov    %eax,%ebx
    11da:	8b 45 10             	mov    0x10(%ebp),%eax
    11dd:	2b 45 18             	sub    0x18(%ebp),%eax
    11e0:	50                   	push   %eax
    11e1:	e8 ea f9 ff ff       	call   bd0 <abs_int>
    11e6:	83 c4 04             	add    $0x4,%esp
    11e9:	39 c3                	cmp    %eax,%ebx
    11eb:	0f 8e b5 00 00 00    	jle    12a6 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    11f1:	8b 45 10             	mov    0x10(%ebp),%eax
    11f4:	2b 45 18             	sub    0x18(%ebp),%eax
    11f7:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11fa:	db 45 b0             	fildl  -0x50(%ebp)
    11fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    1200:	2b 45 14             	sub    0x14(%ebp),%eax
    1203:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1206:	db 45 b0             	fildl  -0x50(%ebp)
    1209:	de f9                	fdivrp %st,%st(1)
    120b:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    120e:	8b 45 14             	mov    0x14(%ebp),%eax
    1211:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1214:	7e 0e                	jle    1224 <APDrawLine+0x183>
        {
            s = x1;
    1216:	8b 45 0c             	mov    0xc(%ebp),%eax
    1219:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    121c:	8b 45 14             	mov    0x14(%ebp),%eax
    121f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1222:	eb 0c                	jmp    1230 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1224:	8b 45 14             	mov    0x14(%ebp),%eax
    1227:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    122a:	8b 45 0c             	mov    0xc(%ebp),%eax
    122d:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1230:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1234:	79 07                	jns    123d <APDrawLine+0x19c>
    1236:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    123d:	8b 45 08             	mov    0x8(%ebp),%eax
    1240:	8b 00                	mov    (%eax),%eax
    1242:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1245:	7f 0b                	jg     1252 <APDrawLine+0x1b1>
    1247:	8b 45 08             	mov    0x8(%ebp),%eax
    124a:	8b 00                	mov    (%eax),%eax
    124c:	83 e8 01             	sub    $0x1,%eax
    124f:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1252:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1255:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1258:	eb 3f                	jmp    1299 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    125a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    125d:	2b 45 0c             	sub    0xc(%ebp),%eax
    1260:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1263:	db 45 b0             	fildl  -0x50(%ebp)
    1266:	dc 4d d0             	fmull  -0x30(%ebp)
    1269:	db 45 10             	fildl  0x10(%ebp)
    126c:	de c1                	faddp  %st,%st(1)
    126e:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1271:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1275:	b4 0c                	mov    $0xc,%ah
    1277:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    127b:	d9 6d b4             	fldcw  -0x4c(%ebp)
    127e:	db 5d cc             	fistpl -0x34(%ebp)
    1281:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1284:	ff 75 cc             	pushl  -0x34(%ebp)
    1287:	ff 75 e4             	pushl  -0x1c(%ebp)
    128a:	ff 75 08             	pushl  0x8(%ebp)
    128d:	e8 2c fd ff ff       	call   fbe <APDrawPoint>
    1292:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1295:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1299:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    129c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    129f:	7e b9                	jle    125a <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    12a1:	e9 b9 00 00 00       	jmp    135f <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    12a6:	8b 45 0c             	mov    0xc(%ebp),%eax
    12a9:	2b 45 14             	sub    0x14(%ebp),%eax
    12ac:	89 45 b0             	mov    %eax,-0x50(%ebp)
    12af:	db 45 b0             	fildl  -0x50(%ebp)
    12b2:	8b 45 10             	mov    0x10(%ebp),%eax
    12b5:	2b 45 18             	sub    0x18(%ebp),%eax
    12b8:	89 45 b0             	mov    %eax,-0x50(%ebp)
    12bb:	db 45 b0             	fildl  -0x50(%ebp)
    12be:	de f9                	fdivrp %st,%st(1)
    12c0:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    12c3:	8b 45 10             	mov    0x10(%ebp),%eax
    12c6:	3b 45 18             	cmp    0x18(%ebp),%eax
    12c9:	7e 0e                	jle    12d9 <APDrawLine+0x238>
    {
        s = y2;
    12cb:	8b 45 18             	mov    0x18(%ebp),%eax
    12ce:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    12d1:	8b 45 10             	mov    0x10(%ebp),%eax
    12d4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    12d7:	eb 0c                	jmp    12e5 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    12d9:	8b 45 10             	mov    0x10(%ebp),%eax
    12dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    12df:	8b 45 18             	mov    0x18(%ebp),%eax
    12e2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    12e5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    12e9:	79 07                	jns    12f2 <APDrawLine+0x251>
    12eb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    12f2:	8b 45 08             	mov    0x8(%ebp),%eax
    12f5:	8b 40 04             	mov    0x4(%eax),%eax
    12f8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12fb:	7f 0c                	jg     1309 <APDrawLine+0x268>
    12fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1300:	8b 40 04             	mov    0x4(%eax),%eax
    1303:	83 e8 01             	sub    $0x1,%eax
    1306:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1309:	8b 45 ec             	mov    -0x14(%ebp),%eax
    130c:	89 45 e0             	mov    %eax,-0x20(%ebp)
    130f:	eb 3f                	jmp    1350 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1311:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1314:	2b 45 10             	sub    0x10(%ebp),%eax
    1317:	89 45 b0             	mov    %eax,-0x50(%ebp)
    131a:	db 45 b0             	fildl  -0x50(%ebp)
    131d:	dc 4d c0             	fmull  -0x40(%ebp)
    1320:	db 45 0c             	fildl  0xc(%ebp)
    1323:	de c1                	faddp  %st,%st(1)
    1325:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1328:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    132c:	b4 0c                	mov    $0xc,%ah
    132e:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1332:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1335:	db 5d bc             	fistpl -0x44(%ebp)
    1338:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    133b:	ff 75 e0             	pushl  -0x20(%ebp)
    133e:	ff 75 bc             	pushl  -0x44(%ebp)
    1341:	ff 75 08             	pushl  0x8(%ebp)
    1344:	e8 75 fc ff ff       	call   fbe <APDrawPoint>
    1349:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    134c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1350:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1353:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1356:	7e b9                	jle    1311 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1358:	90                   	nop
    1359:	eb 04                	jmp    135f <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    135b:	90                   	nop
    135c:	eb 01                	jmp    135f <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    135e:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    135f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1362:	c9                   	leave  
    1363:	c3                   	ret    

00001364 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1364:	55                   	push   %ebp
    1365:	89 e5                	mov    %esp,%ebp
    1367:	53                   	push   %ebx
    1368:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    136b:	8b 55 10             	mov    0x10(%ebp),%edx
    136e:	8b 45 18             	mov    0x18(%ebp),%eax
    1371:	01 d0                	add    %edx,%eax
    1373:	83 e8 01             	sub    $0x1,%eax
    1376:	83 ec 04             	sub    $0x4,%esp
    1379:	50                   	push   %eax
    137a:	ff 75 0c             	pushl  0xc(%ebp)
    137d:	ff 75 10             	pushl  0x10(%ebp)
    1380:	ff 75 0c             	pushl  0xc(%ebp)
    1383:	ff 75 08             	pushl  0x8(%ebp)
    1386:	e8 16 fd ff ff       	call   10a1 <APDrawLine>
    138b:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    138e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1391:	8b 45 14             	mov    0x14(%ebp),%eax
    1394:	01 d0                	add    %edx,%eax
    1396:	83 e8 01             	sub    $0x1,%eax
    1399:	83 ec 04             	sub    $0x4,%esp
    139c:	ff 75 10             	pushl  0x10(%ebp)
    139f:	50                   	push   %eax
    13a0:	ff 75 10             	pushl  0x10(%ebp)
    13a3:	ff 75 0c             	pushl  0xc(%ebp)
    13a6:	ff 75 08             	pushl  0x8(%ebp)
    13a9:	e8 f3 fc ff ff       	call   10a1 <APDrawLine>
    13ae:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    13b1:	8b 55 10             	mov    0x10(%ebp),%edx
    13b4:	8b 45 18             	mov    0x18(%ebp),%eax
    13b7:	01 d0                	add    %edx,%eax
    13b9:	8d 48 ff             	lea    -0x1(%eax),%ecx
    13bc:	8b 55 0c             	mov    0xc(%ebp),%edx
    13bf:	8b 45 14             	mov    0x14(%ebp),%eax
    13c2:	01 d0                	add    %edx,%eax
    13c4:	8d 50 ff             	lea    -0x1(%eax),%edx
    13c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    13ca:	8b 45 14             	mov    0x14(%ebp),%eax
    13cd:	01 d8                	add    %ebx,%eax
    13cf:	83 e8 01             	sub    $0x1,%eax
    13d2:	83 ec 04             	sub    $0x4,%esp
    13d5:	51                   	push   %ecx
    13d6:	52                   	push   %edx
    13d7:	ff 75 10             	pushl  0x10(%ebp)
    13da:	50                   	push   %eax
    13db:	ff 75 08             	pushl  0x8(%ebp)
    13de:	e8 be fc ff ff       	call   10a1 <APDrawLine>
    13e3:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    13e6:	8b 55 10             	mov    0x10(%ebp),%edx
    13e9:	8b 45 18             	mov    0x18(%ebp),%eax
    13ec:	01 d0                	add    %edx,%eax
    13ee:	8d 48 ff             	lea    -0x1(%eax),%ecx
    13f1:	8b 55 0c             	mov    0xc(%ebp),%edx
    13f4:	8b 45 14             	mov    0x14(%ebp),%eax
    13f7:	01 d0                	add    %edx,%eax
    13f9:	8d 50 ff             	lea    -0x1(%eax),%edx
    13fc:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13ff:	8b 45 18             	mov    0x18(%ebp),%eax
    1402:	01 d8                	add    %ebx,%eax
    1404:	83 e8 01             	sub    $0x1,%eax
    1407:	83 ec 04             	sub    $0x4,%esp
    140a:	51                   	push   %ecx
    140b:	52                   	push   %edx
    140c:	50                   	push   %eax
    140d:	ff 75 0c             	pushl  0xc(%ebp)
    1410:	ff 75 08             	pushl  0x8(%ebp)
    1413:	e8 89 fc ff ff       	call   10a1 <APDrawLine>
    1418:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    141b:	8b 55 0c             	mov    0xc(%ebp),%edx
    141e:	8b 45 14             	mov    0x14(%ebp),%eax
    1421:	01 d0                	add    %edx,%eax
    1423:	8d 50 ff             	lea    -0x1(%eax),%edx
    1426:	8b 45 08             	mov    0x8(%ebp),%eax
    1429:	8b 40 0c             	mov    0xc(%eax),%eax
    142c:	89 c1                	mov    %eax,%ecx
    142e:	c1 e9 1f             	shr    $0x1f,%ecx
    1431:	01 c8                	add    %ecx,%eax
    1433:	d1 f8                	sar    %eax
    1435:	29 c2                	sub    %eax,%edx
    1437:	89 d0                	mov    %edx,%eax
    1439:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    143c:	8b 55 10             	mov    0x10(%ebp),%edx
    143f:	8b 45 18             	mov    0x18(%ebp),%eax
    1442:	01 d0                	add    %edx,%eax
    1444:	8d 50 ff             	lea    -0x1(%eax),%edx
    1447:	8b 45 08             	mov    0x8(%ebp),%eax
    144a:	8b 40 0c             	mov    0xc(%eax),%eax
    144d:	89 c1                	mov    %eax,%ecx
    144f:	c1 e9 1f             	shr    $0x1f,%ecx
    1452:	01 c8                	add    %ecx,%eax
    1454:	d1 f8                	sar    %eax
    1456:	29 c2                	sub    %eax,%edx
    1458:	89 d0                	mov    %edx,%eax
    145a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    145d:	8b 45 08             	mov    0x8(%ebp),%eax
    1460:	8b 40 0c             	mov    0xc(%eax),%eax
    1463:	89 c2                	mov    %eax,%edx
    1465:	c1 ea 1f             	shr    $0x1f,%edx
    1468:	01 d0                	add    %edx,%eax
    146a:	d1 f8                	sar    %eax
    146c:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    146f:	8b 45 08             	mov    0x8(%ebp),%eax
    1472:	8b 40 0c             	mov    0xc(%eax),%eax
    1475:	89 c2                	mov    %eax,%edx
    1477:	c1 ea 1f             	shr    $0x1f,%edx
    147a:	01 d0                	add    %edx,%eax
    147c:	d1 f8                	sar    %eax
    147e:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1481:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1485:	0f 88 d8 00 00 00    	js     1563 <APDrawRect+0x1ff>
    148b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    148f:	0f 88 ce 00 00 00    	js     1563 <APDrawRect+0x1ff>
    1495:	8b 45 08             	mov    0x8(%ebp),%eax
    1498:	8b 00                	mov    (%eax),%eax
    149a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    149d:	0f 8e c0 00 00 00    	jle    1563 <APDrawRect+0x1ff>
    14a3:	8b 45 08             	mov    0x8(%ebp),%eax
    14a6:	8b 40 04             	mov    0x4(%eax),%eax
    14a9:	3b 45 10             	cmp    0x10(%ebp),%eax
    14ac:	0f 8e b1 00 00 00    	jle    1563 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    14b2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14b6:	79 07                	jns    14bf <APDrawRect+0x15b>
    14b8:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    14bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    14c3:	79 07                	jns    14cc <APDrawRect+0x168>
    14c5:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    14cc:	8b 45 08             	mov    0x8(%ebp),%eax
    14cf:	8b 00                	mov    (%eax),%eax
    14d1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14d4:	7f 0b                	jg     14e1 <APDrawRect+0x17d>
    14d6:	8b 45 08             	mov    0x8(%ebp),%eax
    14d9:	8b 00                	mov    (%eax),%eax
    14db:	83 e8 01             	sub    $0x1,%eax
    14de:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    14e1:	8b 45 08             	mov    0x8(%ebp),%eax
    14e4:	8b 40 04             	mov    0x4(%eax),%eax
    14e7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14ea:	7f 0c                	jg     14f8 <APDrawRect+0x194>
    14ec:	8b 45 08             	mov    0x8(%ebp),%eax
    14ef:	8b 40 04             	mov    0x4(%eax),%eax
    14f2:	83 e8 01             	sub    $0x1,%eax
    14f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    14f8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    14ff:	8b 45 0c             	mov    0xc(%ebp),%eax
    1502:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1505:	eb 52                	jmp    1559 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1507:	8b 45 10             	mov    0x10(%ebp),%eax
    150a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    150d:	eb 3e                	jmp    154d <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    150f:	83 ec 04             	sub    $0x4,%esp
    1512:	ff 75 e8             	pushl  -0x18(%ebp)
    1515:	ff 75 ec             	pushl  -0x14(%ebp)
    1518:	ff 75 08             	pushl  0x8(%ebp)
    151b:	e8 c0 f6 ff ff       	call   be0 <APGetIndex>
    1520:	83 c4 10             	add    $0x10,%esp
    1523:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1526:	8b 45 08             	mov    0x8(%ebp),%eax
    1529:	8b 48 18             	mov    0x18(%eax),%ecx
    152c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    152f:	89 d0                	mov    %edx,%eax
    1531:	01 c0                	add    %eax,%eax
    1533:	01 d0                	add    %edx,%eax
    1535:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1538:	8b 45 08             	mov    0x8(%ebp),%eax
    153b:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    153f:	66 89 0a             	mov    %cx,(%edx)
    1542:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1546:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1549:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    154d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1550:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1553:	7e ba                	jle    150f <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1555:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1559:	8b 45 ec             	mov    -0x14(%ebp),%eax
    155c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    155f:	7e a6                	jle    1507 <APDrawRect+0x1a3>
    1561:	eb 01                	jmp    1564 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1563:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1564:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1567:	c9                   	leave  
    1568:	c3                   	ret    

00001569 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1569:	55                   	push   %ebp
    156a:	89 e5                	mov    %esp,%ebp
    156c:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    156f:	83 ec 0c             	sub    $0xc,%esp
    1572:	ff 75 0c             	pushl  0xc(%ebp)
    1575:	e8 c1 ee ff ff       	call   43b <strlen>
    157a:	83 c4 10             	add    $0x10,%esp
    157d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1580:	8b 45 08             	mov    0x8(%ebp),%eax
    1583:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1587:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    158b:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    158f:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1592:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1599:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    15a0:	e9 bc 00 00 00       	jmp    1661 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    15a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
    15a8:	8b 45 0c             	mov    0xc(%ebp),%eax
    15ab:	01 d0                	add    %edx,%eax
    15ad:	0f b6 00             	movzbl (%eax),%eax
    15b0:	0f be c0             	movsbl %al,%eax
    15b3:	83 e8 20             	sub    $0x20,%eax
    15b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    15b9:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    15bd:	0f 87 9a 00 00 00    	ja     165d <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    15c3:	8b 45 08             	mov    0x8(%ebp),%eax
    15c6:	8b 00                	mov    (%eax),%eax
    15c8:	0f af 45 14          	imul   0x14(%ebp),%eax
    15cc:	89 c2                	mov    %eax,%edx
    15ce:	8b 45 10             	mov    0x10(%ebp),%eax
    15d1:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    15d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    15d7:	89 d0                	mov    %edx,%eax
    15d9:	c1 e0 03             	shl    $0x3,%eax
    15dc:	01 d0                	add    %edx,%eax
    15de:	01 c8                	add    %ecx,%eax
    15e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    15e3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    15ea:	eb 6b                	jmp    1657 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    15ec:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    15f3:	eb 50                	jmp    1645 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    15f5:	8b 55 ec             	mov    -0x14(%ebp),%edx
    15f8:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    15fb:	89 d0                	mov    %edx,%eax
    15fd:	c1 e0 03             	shl    $0x3,%eax
    1600:	01 d0                	add    %edx,%eax
    1602:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    1608:	01 c2                	add    %eax,%edx
    160a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    160d:	01 d0                	add    %edx,%eax
    160f:	05 80 31 00 00       	add    $0x3180,%eax
    1614:	0f b6 00             	movzbl (%eax),%eax
    1617:	84 c0                	test   %al,%al
    1619:	74 26                	je     1641 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    161b:	8b 45 08             	mov    0x8(%ebp),%eax
    161e:	8b 50 18             	mov    0x18(%eax),%edx
    1621:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1624:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1627:	01 c8                	add    %ecx,%eax
    1629:	89 c1                	mov    %eax,%ecx
    162b:	89 c8                	mov    %ecx,%eax
    162d:	01 c0                	add    %eax,%eax
    162f:	01 c8                	add    %ecx,%eax
    1631:	01 d0                	add    %edx,%eax
    1633:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1637:	66 89 10             	mov    %dx,(%eax)
    163a:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    163e:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1641:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1645:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1649:	7e aa                	jle    15f5 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    164b:	8b 45 08             	mov    0x8(%ebp),%eax
    164e:	8b 00                	mov    (%eax),%eax
    1650:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1653:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1657:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    165b:	7e 8f                	jle    15ec <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    165d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1661:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1664:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1667:	0f 82 38 ff ff ff    	jb     15a5 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    166d:	90                   	nop
    166e:	c9                   	leave  
    166f:	c3                   	ret    

00001670 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1670:	55                   	push   %ebp
    1671:	89 e5                	mov    %esp,%ebp
    1673:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1676:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    167a:	0f 88 8e 01 00 00    	js     180e <APDcCopy+0x19e>
    1680:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1684:	0f 88 84 01 00 00    	js     180e <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    168a:	8b 55 0c             	mov    0xc(%ebp),%edx
    168d:	8b 45 20             	mov    0x20(%ebp),%eax
    1690:	01 d0                	add    %edx,%eax
    1692:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1695:	8b 55 10             	mov    0x10(%ebp),%edx
    1698:	8b 45 24             	mov    0x24(%ebp),%eax
    169b:	01 d0                	add    %edx,%eax
    169d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    16a0:	8b 55 18             	mov    0x18(%ebp),%edx
    16a3:	8b 45 20             	mov    0x20(%ebp),%eax
    16a6:	01 d0                	add    %edx,%eax
    16a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    16ab:	8b 55 1c             	mov    0x1c(%ebp),%edx
    16ae:	8b 45 24             	mov    0x24(%ebp),%eax
    16b1:	01 d0                	add    %edx,%eax
    16b3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    16b6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16ba:	0f 88 51 01 00 00    	js     1811 <APDcCopy+0x1a1>
    16c0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    16c4:	0f 88 47 01 00 00    	js     1811 <APDcCopy+0x1a1>
    16ca:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    16ce:	0f 88 3d 01 00 00    	js     1811 <APDcCopy+0x1a1>
    16d4:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    16d8:	0f 88 33 01 00 00    	js     1811 <APDcCopy+0x1a1>
    16de:	8b 45 14             	mov    0x14(%ebp),%eax
    16e1:	8b 00                	mov    (%eax),%eax
    16e3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    16e6:	0f 8c 25 01 00 00    	jl     1811 <APDcCopy+0x1a1>
    16ec:	8b 45 14             	mov    0x14(%ebp),%eax
    16ef:	8b 40 04             	mov    0x4(%eax),%eax
    16f2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    16f5:	0f 8c 16 01 00 00    	jl     1811 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    16fb:	8b 45 08             	mov    0x8(%ebp),%eax
    16fe:	8b 00                	mov    (%eax),%eax
    1700:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1703:	7f 0b                	jg     1710 <APDcCopy+0xa0>
    1705:	8b 45 08             	mov    0x8(%ebp),%eax
    1708:	8b 00                	mov    (%eax),%eax
    170a:	83 e8 01             	sub    $0x1,%eax
    170d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1710:	8b 45 08             	mov    0x8(%ebp),%eax
    1713:	8b 40 04             	mov    0x4(%eax),%eax
    1716:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1719:	7f 0c                	jg     1727 <APDcCopy+0xb7>
    171b:	8b 45 08             	mov    0x8(%ebp),%eax
    171e:	8b 40 04             	mov    0x4(%eax),%eax
    1721:	83 e8 01             	sub    $0x1,%eax
    1724:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1727:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    172e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1735:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    173c:	e9 bc 00 00 00       	jmp    17fd <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1741:	8b 45 08             	mov    0x8(%ebp),%eax
    1744:	8b 00                	mov    (%eax),%eax
    1746:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1749:	8b 55 10             	mov    0x10(%ebp),%edx
    174c:	01 ca                	add    %ecx,%edx
    174e:	0f af d0             	imul   %eax,%edx
    1751:	8b 45 0c             	mov    0xc(%ebp),%eax
    1754:	01 d0                	add    %edx,%eax
    1756:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1759:	8b 45 14             	mov    0x14(%ebp),%eax
    175c:	8b 00                	mov    (%eax),%eax
    175e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1761:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1764:	01 ca                	add    %ecx,%edx
    1766:	0f af d0             	imul   %eax,%edx
    1769:	8b 45 18             	mov    0x18(%ebp),%eax
    176c:	01 d0                	add    %edx,%eax
    176e:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1771:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1778:	eb 74                	jmp    17ee <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    177a:	8b 45 14             	mov    0x14(%ebp),%eax
    177d:	8b 50 18             	mov    0x18(%eax),%edx
    1780:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1783:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1786:	01 c8                	add    %ecx,%eax
    1788:	89 c1                	mov    %eax,%ecx
    178a:	89 c8                	mov    %ecx,%eax
    178c:	01 c0                	add    %eax,%eax
    178e:	01 c8                	add    %ecx,%eax
    1790:	01 d0                	add    %edx,%eax
    1792:	0f b7 10             	movzwl (%eax),%edx
    1795:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1799:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    179d:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    17a0:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    17a4:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    17a8:	38 c2                	cmp    %al,%dl
    17aa:	75 18                	jne    17c4 <APDcCopy+0x154>
    17ac:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    17b0:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    17b4:	38 c2                	cmp    %al,%dl
    17b6:	75 0c                	jne    17c4 <APDcCopy+0x154>
    17b8:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    17bc:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    17c0:	38 c2                	cmp    %al,%dl
    17c2:	74 26                	je     17ea <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    17c4:	8b 45 08             	mov    0x8(%ebp),%eax
    17c7:	8b 50 18             	mov    0x18(%eax),%edx
    17ca:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    17cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d0:	01 c8                	add    %ecx,%eax
    17d2:	89 c1                	mov    %eax,%ecx
    17d4:	89 c8                	mov    %ecx,%eax
    17d6:	01 c0                	add    %eax,%eax
    17d8:	01 c8                	add    %ecx,%eax
    17da:	01 d0                	add    %edx,%eax
    17dc:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    17e0:	66 89 10             	mov    %dx,(%eax)
    17e3:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    17e7:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    17ea:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    17ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17f1:	2b 45 0c             	sub    0xc(%ebp),%eax
    17f4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    17f7:	7d 81                	jge    177a <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    17f9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    17fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1800:	2b 45 10             	sub    0x10(%ebp),%eax
    1803:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1806:	0f 8d 35 ff ff ff    	jge    1741 <APDcCopy+0xd1>
    180c:	eb 04                	jmp    1812 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    180e:	90                   	nop
    180f:	eb 01                	jmp    1812 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1811:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1812:	c9                   	leave  
    1813:	c3                   	ret    

00001814 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1814:	55                   	push   %ebp
    1815:	89 e5                	mov    %esp,%ebp
    1817:	83 ec 1c             	sub    $0x1c,%esp
    181a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    181d:	8b 55 10             	mov    0x10(%ebp),%edx
    1820:	8b 45 14             	mov    0x14(%ebp),%eax
    1823:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1826:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1829:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    182c:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1830:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1833:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1837:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    183a:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    183e:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1841:	8b 45 08             	mov    0x8(%ebp),%eax
    1844:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1848:	66 89 10             	mov    %dx,(%eax)
    184b:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    184f:	88 50 02             	mov    %dl,0x2(%eax)
}
    1852:	8b 45 08             	mov    0x8(%ebp),%eax
    1855:	c9                   	leave  
    1856:	c2 04 00             	ret    $0x4

00001859 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1859:	55                   	push   %ebp
    185a:	89 e5                	mov    %esp,%ebp
    185c:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    185f:	8b 45 08             	mov    0x8(%ebp),%eax
    1862:	8b 00                	mov    (%eax),%eax
    1864:	83 ec 08             	sub    $0x8,%esp
    1867:	8d 55 0c             	lea    0xc(%ebp),%edx
    186a:	52                   	push   %edx
    186b:	50                   	push   %eax
    186c:	e8 34 ee ff ff       	call   6a5 <sendMessage>
    1871:	83 c4 10             	add    $0x10,%esp
}
    1874:	90                   	nop
    1875:	c9                   	leave  
    1876:	c3                   	ret    

00001877 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1877:	55                   	push   %ebp
    1878:	89 e5                	mov    %esp,%ebp
    187a:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    187d:	83 ec 0c             	sub    $0xc,%esp
    1880:	68 98 00 00 00       	push   $0x98
    1885:	e8 f5 f1 ff ff       	call   a7f <malloc>
    188a:	83 c4 10             	add    $0x10,%esp
    188d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1890:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1894:	75 15                	jne    18ab <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1896:	83 ec 04             	sub    $0x4,%esp
    1899:	ff 75 08             	pushl  0x8(%ebp)
    189c:	68 60 27 00 00       	push   $0x2760
    18a1:	6a 01                	push   $0x1
    18a3:	e8 04 ef ff ff       	call   7ac <printf>
    18a8:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    18ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ae:	05 84 00 00 00       	add    $0x84,%eax
    18b3:	83 ec 08             	sub    $0x8,%esp
    18b6:	ff 75 08             	pushl  0x8(%ebp)
    18b9:	50                   	push   %eax
    18ba:	e8 0d eb ff ff       	call   3cc <strcpy>
    18bf:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    18c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c5:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    18cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18cf:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    18d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d9:	8b 40 3c             	mov    0x3c(%eax),%eax
    18dc:	89 c2                	mov    %eax,%edx
    18de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e1:	8b 40 40             	mov    0x40(%eax),%eax
    18e4:	0f af d0             	imul   %eax,%edx
    18e7:	89 d0                	mov    %edx,%eax
    18e9:	01 c0                	add    %eax,%eax
    18eb:	01 d0                	add    %edx,%eax
    18ed:	83 ec 0c             	sub    $0xc,%esp
    18f0:	50                   	push   %eax
    18f1:	e8 89 f1 ff ff       	call   a7f <malloc>
    18f6:	83 c4 10             	add    $0x10,%esp
    18f9:	89 c2                	mov    %eax,%edx
    18fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18fe:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1901:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1904:	8b 40 54             	mov    0x54(%eax),%eax
    1907:	85 c0                	test   %eax,%eax
    1909:	75 15                	jne    1920 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    190b:	83 ec 04             	sub    $0x4,%esp
    190e:	ff 75 08             	pushl  0x8(%ebp)
    1911:	68 80 27 00 00       	push   $0x2780
    1916:	6a 01                	push   $0x1
    1918:	e8 8f ee ff ff       	call   7ac <printf>
    191d:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1920:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1923:	8b 40 3c             	mov    0x3c(%eax),%eax
    1926:	89 c2                	mov    %eax,%edx
    1928:	8b 45 f4             	mov    -0xc(%ebp),%eax
    192b:	8b 40 40             	mov    0x40(%eax),%eax
    192e:	0f af d0             	imul   %eax,%edx
    1931:	89 d0                	mov    %edx,%eax
    1933:	01 c0                	add    %eax,%eax
    1935:	01 c2                	add    %eax,%edx
    1937:	8b 45 f4             	mov    -0xc(%ebp),%eax
    193a:	8b 40 54             	mov    0x54(%eax),%eax
    193d:	83 ec 04             	sub    $0x4,%esp
    1940:	52                   	push   %edx
    1941:	68 ff ff ff 00       	push   $0xffffff
    1946:	50                   	push   %eax
    1947:	e8 16 eb ff ff       	call   462 <memset>
    194c:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    194f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1952:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1959:	e8 1f ed ff ff       	call   67d <getpid>
    195e:	89 c2                	mov    %eax,%edx
    1960:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1963:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1966:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1969:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1970:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1973:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    197a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    197d:	8b 40 58             	mov    0x58(%eax),%eax
    1980:	89 c2                	mov    %eax,%edx
    1982:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1985:	8b 40 5c             	mov    0x5c(%eax),%eax
    1988:	0f af d0             	imul   %eax,%edx
    198b:	89 d0                	mov    %edx,%eax
    198d:	01 c0                	add    %eax,%eax
    198f:	01 d0                	add    %edx,%eax
    1991:	83 ec 0c             	sub    $0xc,%esp
    1994:	50                   	push   %eax
    1995:	e8 e5 f0 ff ff       	call   a7f <malloc>
    199a:	83 c4 10             	add    $0x10,%esp
    199d:	89 c2                	mov    %eax,%edx
    199f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a2:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    19a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a8:	8b 40 70             	mov    0x70(%eax),%eax
    19ab:	85 c0                	test   %eax,%eax
    19ad:	75 15                	jne    19c4 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    19af:	83 ec 04             	sub    $0x4,%esp
    19b2:	ff 75 08             	pushl  0x8(%ebp)
    19b5:	68 a4 27 00 00       	push   $0x27a4
    19ba:	6a 01                	push   $0x1
    19bc:	e8 eb ed ff ff       	call   7ac <printf>
    19c1:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    19c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19c7:	8b 40 3c             	mov    0x3c(%eax),%eax
    19ca:	89 c2                	mov    %eax,%edx
    19cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19cf:	8b 40 40             	mov    0x40(%eax),%eax
    19d2:	0f af d0             	imul   %eax,%edx
    19d5:	89 d0                	mov    %edx,%eax
    19d7:	01 c0                	add    %eax,%eax
    19d9:	01 c2                	add    %eax,%edx
    19db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19de:	8b 40 54             	mov    0x54(%eax),%eax
    19e1:	83 ec 04             	sub    $0x4,%esp
    19e4:	52                   	push   %edx
    19e5:	68 ff 00 00 00       	push   $0xff
    19ea:	50                   	push   %eax
    19eb:	e8 72 ea ff ff       	call   462 <memset>
    19f0:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    19f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19f6:	8b 55 0c             	mov    0xc(%ebp),%edx
    19f9:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    19fc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1a00:	74 49                	je     1a4b <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1a02:	8b 45 10             	mov    0x10(%ebp),%eax
    1a05:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1a0b:	83 ec 0c             	sub    $0xc,%esp
    1a0e:	50                   	push   %eax
    1a0f:	e8 6b f0 ff ff       	call   a7f <malloc>
    1a14:	83 c4 10             	add    $0x10,%esp
    1a17:	89 c2                	mov    %eax,%edx
    1a19:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a1c:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1a1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a22:	8b 55 10             	mov    0x10(%ebp),%edx
    1a25:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1a28:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a2b:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1a32:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a35:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1a3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a3f:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1a46:	e9 8d 00 00 00       	jmp    1ad8 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1a4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a4e:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a58:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1a5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a62:	8b 40 20             	mov    0x20(%eax),%eax
    1a65:	89 c2                	mov    %eax,%edx
    1a67:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a6a:	8b 40 24             	mov    0x24(%eax),%eax
    1a6d:	0f af d0             	imul   %eax,%edx
    1a70:	89 d0                	mov    %edx,%eax
    1a72:	01 c0                	add    %eax,%eax
    1a74:	01 d0                	add    %edx,%eax
    1a76:	83 ec 0c             	sub    $0xc,%esp
    1a79:	50                   	push   %eax
    1a7a:	e8 00 f0 ff ff       	call   a7f <malloc>
    1a7f:	83 c4 10             	add    $0x10,%esp
    1a82:	89 c2                	mov    %eax,%edx
    1a84:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a87:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1a8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a8d:	8b 40 38             	mov    0x38(%eax),%eax
    1a90:	85 c0                	test   %eax,%eax
    1a92:	75 15                	jne    1aa9 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1a94:	83 ec 04             	sub    $0x4,%esp
    1a97:	ff 75 08             	pushl  0x8(%ebp)
    1a9a:	68 cc 27 00 00       	push   $0x27cc
    1a9f:	6a 01                	push   $0x1
    1aa1:	e8 06 ed ff ff       	call   7ac <printf>
    1aa6:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1aa9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aac:	8b 40 20             	mov    0x20(%eax),%eax
    1aaf:	89 c2                	mov    %eax,%edx
    1ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ab4:	8b 40 24             	mov    0x24(%eax),%eax
    1ab7:	0f af d0             	imul   %eax,%edx
    1aba:	89 d0                	mov    %edx,%eax
    1abc:	01 c0                	add    %eax,%eax
    1abe:	01 c2                	add    %eax,%edx
    1ac0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ac3:	8b 40 38             	mov    0x38(%eax),%eax
    1ac6:	83 ec 04             	sub    $0x4,%esp
    1ac9:	52                   	push   %edx
    1aca:	68 ff ff ff 00       	push   $0xffffff
    1acf:	50                   	push   %eax
    1ad0:	e8 8d e9 ff ff       	call   462 <memset>
    1ad5:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1adb:	c9                   	leave  
    1adc:	c3                   	ret    

00001add <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1add:	55                   	push   %ebp
    1ade:	89 e5                	mov    %esp,%ebp
    1ae0:	57                   	push   %edi
    1ae1:	56                   	push   %esi
    1ae2:	53                   	push   %ebx
    1ae3:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1ae6:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ae9:	83 f8 03             	cmp    $0x3,%eax
    1aec:	74 02                	je     1af0 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1aee:	eb 7c                	jmp    1b6c <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1af0:	8b 45 08             	mov    0x8(%ebp),%eax
    1af3:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1af6:	8b 45 08             	mov    0x8(%ebp),%eax
    1af9:	8b 48 18             	mov    0x18(%eax),%ecx
    1afc:	8b 45 08             	mov    0x8(%ebp),%eax
    1aff:	8b 50 5c             	mov    0x5c(%eax),%edx
    1b02:	8b 45 08             	mov    0x8(%ebp),%eax
    1b05:	8b 40 58             	mov    0x58(%eax),%eax
    1b08:	8b 75 08             	mov    0x8(%ebp),%esi
    1b0b:	83 c6 58             	add    $0x58,%esi
    1b0e:	83 ec 04             	sub    $0x4,%esp
    1b11:	53                   	push   %ebx
    1b12:	51                   	push   %ecx
    1b13:	6a 00                	push   $0x0
    1b15:	52                   	push   %edx
    1b16:	50                   	push   %eax
    1b17:	6a 00                	push   $0x0
    1b19:	6a 00                	push   $0x0
    1b1b:	56                   	push   %esi
    1b1c:	6a 00                	push   $0x0
    1b1e:	6a 00                	push   $0x0
    1b20:	ff 75 08             	pushl  0x8(%ebp)
    1b23:	e8 75 eb ff ff       	call   69d <paintWindow>
    1b28:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1b2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2e:	8b 70 1c             	mov    0x1c(%eax),%esi
    1b31:	8b 45 08             	mov    0x8(%ebp),%eax
    1b34:	8b 58 18             	mov    0x18(%eax),%ebx
    1b37:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3a:	8b 48 08             	mov    0x8(%eax),%ecx
    1b3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b40:	8b 50 40             	mov    0x40(%eax),%edx
    1b43:	8b 45 08             	mov    0x8(%ebp),%eax
    1b46:	8b 40 3c             	mov    0x3c(%eax),%eax
    1b49:	8b 7d 08             	mov    0x8(%ebp),%edi
    1b4c:	83 c7 3c             	add    $0x3c,%edi
    1b4f:	83 ec 04             	sub    $0x4,%esp
    1b52:	56                   	push   %esi
    1b53:	53                   	push   %ebx
    1b54:	51                   	push   %ecx
    1b55:	52                   	push   %edx
    1b56:	50                   	push   %eax
    1b57:	6a 00                	push   $0x0
    1b59:	6a 00                	push   $0x0
    1b5b:	57                   	push   %edi
    1b5c:	6a 32                	push   $0x32
    1b5e:	6a 00                	push   $0x0
    1b60:	ff 75 08             	pushl  0x8(%ebp)
    1b63:	e8 35 eb ff ff       	call   69d <paintWindow>
    1b68:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1b6b:	90                   	nop
        default: break;
            
            
    }
    return False;
    1b6c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1b71:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b74:	5b                   	pop    %ebx
    1b75:	5e                   	pop    %esi
    1b76:	5f                   	pop    %edi
    1b77:	5d                   	pop    %ebp
    1b78:	c3                   	ret    

00001b79 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1b79:	55                   	push   %ebp
    1b7a:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1b7c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b7f:	8b 50 08             	mov    0x8(%eax),%edx
    1b82:	8b 45 08             	mov    0x8(%ebp),%eax
    1b85:	8b 00                	mov    (%eax),%eax
    1b87:	39 c2                	cmp    %eax,%edx
    1b89:	74 07                	je     1b92 <APPreJudge+0x19>
        return False;
    1b8b:	b8 00 00 00 00       	mov    $0x0,%eax
    1b90:	eb 05                	jmp    1b97 <APPreJudge+0x1e>
    return True;
    1b92:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1b97:	5d                   	pop    %ebp
    1b98:	c3                   	ret    

00001b99 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1b99:	55                   	push   %ebp
    1b9a:	89 e5                	mov    %esp,%ebp
    1b9c:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1b9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba2:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ba5:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1bab:	83 ec 0c             	sub    $0xc,%esp
    1bae:	ff 75 08             	pushl  0x8(%ebp)
    1bb1:	e8 ff ea ff ff       	call   6b5 <registWindow>
    1bb6:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1bb9:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1bc0:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc3:	8b 00                	mov    (%eax),%eax
    1bc5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1bc8:	ff 75 f4             	pushl  -0xc(%ebp)
    1bcb:	ff 75 f0             	pushl  -0x10(%ebp)
    1bce:	ff 75 ec             	pushl  -0x14(%ebp)
    1bd1:	ff 75 08             	pushl  0x8(%ebp)
    1bd4:	e8 80 fc ff ff       	call   1859 <APSendMessage>
    1bd9:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1bdc:	83 ec 0c             	sub    $0xc,%esp
    1bdf:	ff 75 08             	pushl  0x8(%ebp)
    1be2:	e8 c6 ea ff ff       	call   6ad <getMessage>
    1be7:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1bea:	8b 45 08             	mov    0x8(%ebp),%eax
    1bed:	83 c0 74             	add    $0x74,%eax
    1bf0:	83 ec 08             	sub    $0x8,%esp
    1bf3:	50                   	push   %eax
    1bf4:	ff 75 08             	pushl  0x8(%ebp)
    1bf7:	e8 7d ff ff ff       	call   1b79 <APPreJudge>
    1bfc:	83 c4 10             	add    $0x10,%esp
    1bff:	84 c0                	test   %al,%al
    1c01:	74 1b                	je     1c1e <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1c03:	8b 45 08             	mov    0x8(%ebp),%eax
    1c06:	ff 70 7c             	pushl  0x7c(%eax)
    1c09:	ff 70 78             	pushl  0x78(%eax)
    1c0c:	ff 70 74             	pushl  0x74(%eax)
    1c0f:	ff 75 08             	pushl  0x8(%ebp)
    1c12:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c15:	ff d0                	call   *%eax
    1c17:	83 c4 10             	add    $0x10,%esp
    1c1a:	84 c0                	test   %al,%al
    1c1c:	75 0c                	jne    1c2a <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1c1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c21:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1c28:	eb b2                	jmp    1bdc <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1c2a:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1c2b:	90                   	nop
    1c2c:	c9                   	leave  
    1c2d:	c3                   	ret    

00001c2e <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1c2e:	55                   	push   %ebp
    1c2f:	89 e5                	mov    %esp,%ebp
    1c31:	57                   	push   %edi
    1c32:	56                   	push   %esi
    1c33:	53                   	push   %ebx
    1c34:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    1c37:	a1 c4 6d 00 00       	mov    0x6dc4,%eax
    1c3c:	85 c0                	test   %eax,%eax
    1c3e:	0f 85 2c 02 00 00    	jne    1e70 <APGridPaint+0x242>
    {
        iconReady = 1;
    1c44:	c7 05 c4 6d 00 00 01 	movl   $0x1,0x6dc4
    1c4b:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1c4e:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c51:	83 ec 08             	sub    $0x8,%esp
    1c54:	68 f3 27 00 00       	push   $0x27f3
    1c59:	50                   	push   %eax
    1c5a:	e8 d3 ef ff ff       	call   c32 <APLoadBitmap>
    1c5f:	83 c4 0c             	add    $0xc,%esp
    1c62:	8b 45 88             	mov    -0x78(%ebp),%eax
    1c65:	a3 e8 6d 00 00       	mov    %eax,0x6de8
    1c6a:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1c6d:	a3 ec 6d 00 00       	mov    %eax,0x6dec
    1c72:	8b 45 90             	mov    -0x70(%ebp),%eax
    1c75:	a3 f0 6d 00 00       	mov    %eax,0x6df0
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1c7a:	83 ec 04             	sub    $0x4,%esp
    1c7d:	ff 35 f0 6d 00 00    	pushl  0x6df0
    1c83:	ff 35 ec 6d 00 00    	pushl  0x6dec
    1c89:	ff 35 e8 6d 00 00    	pushl  0x6de8
    1c8f:	e8 d8 f1 ff ff       	call   e6c <APCreateCompatibleDCFromBitmap>
    1c94:	83 c4 10             	add    $0x10,%esp
    1c97:	a3 f4 6d 00 00       	mov    %eax,0x6df4
        grid_river = APLoadBitmap ("grid_river.bmp");
    1c9c:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c9f:	83 ec 08             	sub    $0x8,%esp
    1ca2:	68 01 28 00 00       	push   $0x2801
    1ca7:	50                   	push   %eax
    1ca8:	e8 85 ef ff ff       	call   c32 <APLoadBitmap>
    1cad:	83 c4 0c             	add    $0xc,%esp
    1cb0:	8b 45 88             	mov    -0x78(%ebp),%eax
    1cb3:	a3 24 6e 00 00       	mov    %eax,0x6e24
    1cb8:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1cbb:	a3 28 6e 00 00       	mov    %eax,0x6e28
    1cc0:	8b 45 90             	mov    -0x70(%ebp),%eax
    1cc3:	a3 2c 6e 00 00       	mov    %eax,0x6e2c
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1cc8:	83 ec 04             	sub    $0x4,%esp
    1ccb:	ff 35 2c 6e 00 00    	pushl  0x6e2c
    1cd1:	ff 35 28 6e 00 00    	pushl  0x6e28
    1cd7:	ff 35 24 6e 00 00    	pushl  0x6e24
    1cdd:	e8 8a f1 ff ff       	call   e6c <APCreateCompatibleDCFromBitmap>
    1ce2:	83 c4 10             	add    $0x10,%esp
    1ce5:	a3 14 6e 00 00       	mov    %eax,0x6e14
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1cea:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ced:	83 ec 08             	sub    $0x8,%esp
    1cf0:	68 10 28 00 00       	push   $0x2810
    1cf5:	50                   	push   %eax
    1cf6:	e8 37 ef ff ff       	call   c32 <APLoadBitmap>
    1cfb:	83 c4 0c             	add    $0xc,%esp
    1cfe:	8b 45 88             	mov    -0x78(%ebp),%eax
    1d01:	a3 18 6e 00 00       	mov    %eax,0x6e18
    1d06:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1d09:	a3 1c 6e 00 00       	mov    %eax,0x6e1c
    1d0e:	8b 45 90             	mov    -0x70(%ebp),%eax
    1d11:	a3 20 6e 00 00       	mov    %eax,0x6e20
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1d16:	83 ec 04             	sub    $0x4,%esp
    1d19:	ff 35 20 6e 00 00    	pushl  0x6e20
    1d1f:	ff 35 1c 6e 00 00    	pushl  0x6e1c
    1d25:	ff 35 18 6e 00 00    	pushl  0x6e18
    1d2b:	e8 3c f1 ff ff       	call   e6c <APCreateCompatibleDCFromBitmap>
    1d30:	83 c4 10             	add    $0x10,%esp
    1d33:	a3 c8 6d 00 00       	mov    %eax,0x6dc8
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1d38:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d3b:	83 ec 08             	sub    $0x8,%esp
    1d3e:	68 1f 28 00 00       	push   $0x281f
    1d43:	50                   	push   %eax
    1d44:	e8 e9 ee ff ff       	call   c32 <APLoadBitmap>
    1d49:	83 c4 0c             	add    $0xc,%esp
    1d4c:	8b 45 88             	mov    -0x78(%ebp),%eax
    1d4f:	a3 fc 6d 00 00       	mov    %eax,0x6dfc
    1d54:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1d57:	a3 00 6e 00 00       	mov    %eax,0x6e00
    1d5c:	8b 45 90             	mov    -0x70(%ebp),%eax
    1d5f:	a3 04 6e 00 00       	mov    %eax,0x6e04
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1d64:	83 ec 04             	sub    $0x4,%esp
    1d67:	ff 35 04 6e 00 00    	pushl  0x6e04
    1d6d:	ff 35 00 6e 00 00    	pushl  0x6e00
    1d73:	ff 35 fc 6d 00 00    	pushl  0x6dfc
    1d79:	e8 ee f0 ff ff       	call   e6c <APCreateCompatibleDCFromBitmap>
    1d7e:	83 c4 10             	add    $0x10,%esp
    1d81:	a3 30 6e 00 00       	mov    %eax,0x6e30
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1d86:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d89:	83 ec 08             	sub    $0x8,%esp
    1d8c:	68 2d 28 00 00       	push   $0x282d
    1d91:	50                   	push   %eax
    1d92:	e8 9b ee ff ff       	call   c32 <APLoadBitmap>
    1d97:	83 c4 0c             	add    $0xc,%esp
    1d9a:	8b 45 88             	mov    -0x78(%ebp),%eax
    1d9d:	a3 d8 6d 00 00       	mov    %eax,0x6dd8
    1da2:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1da5:	a3 dc 6d 00 00       	mov    %eax,0x6ddc
    1daa:	8b 45 90             	mov    -0x70(%ebp),%eax
    1dad:	a3 e0 6d 00 00       	mov    %eax,0x6de0
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1db2:	83 ec 04             	sub    $0x4,%esp
    1db5:	ff 35 e0 6d 00 00    	pushl  0x6de0
    1dbb:	ff 35 dc 6d 00 00    	pushl  0x6ddc
    1dc1:	ff 35 d8 6d 00 00    	pushl  0x6dd8
    1dc7:	e8 a0 f0 ff ff       	call   e6c <APCreateCompatibleDCFromBitmap>
    1dcc:	83 c4 10             	add    $0x10,%esp
    1dcf:	a3 f8 6d 00 00       	mov    %eax,0x6df8
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1dd4:	8d 45 88             	lea    -0x78(%ebp),%eax
    1dd7:	83 ec 08             	sub    $0x8,%esp
    1dda:	68 3d 28 00 00       	push   $0x283d
    1ddf:	50                   	push   %eax
    1de0:	e8 4d ee ff ff       	call   c32 <APLoadBitmap>
    1de5:	83 c4 0c             	add    $0xc,%esp
    1de8:	8b 45 88             	mov    -0x78(%ebp),%eax
    1deb:	a3 cc 6d 00 00       	mov    %eax,0x6dcc
    1df0:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1df3:	a3 d0 6d 00 00       	mov    %eax,0x6dd0
    1df8:	8b 45 90             	mov    -0x70(%ebp),%eax
    1dfb:	a3 d4 6d 00 00       	mov    %eax,0x6dd4
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1e00:	83 ec 04             	sub    $0x4,%esp
    1e03:	ff 35 d4 6d 00 00    	pushl  0x6dd4
    1e09:	ff 35 d0 6d 00 00    	pushl  0x6dd0
    1e0f:	ff 35 cc 6d 00 00    	pushl  0x6dcc
    1e15:	e8 52 f0 ff ff       	call   e6c <APCreateCompatibleDCFromBitmap>
    1e1a:	83 c4 10             	add    $0x10,%esp
    1e1d:	a3 e4 6d 00 00       	mov    %eax,0x6de4
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1e22:	8d 45 88             	lea    -0x78(%ebp),%eax
    1e25:	83 ec 08             	sub    $0x8,%esp
    1e28:	68 4f 28 00 00       	push   $0x284f
    1e2d:	50                   	push   %eax
    1e2e:	e8 ff ed ff ff       	call   c32 <APLoadBitmap>
    1e33:	83 c4 0c             	add    $0xc,%esp
    1e36:	8b 45 88             	mov    -0x78(%ebp),%eax
    1e39:	a3 08 6e 00 00       	mov    %eax,0x6e08
    1e3e:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1e41:	a3 0c 6e 00 00       	mov    %eax,0x6e0c
    1e46:	8b 45 90             	mov    -0x70(%ebp),%eax
    1e49:	a3 10 6e 00 00       	mov    %eax,0x6e10
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1e4e:	83 ec 04             	sub    $0x4,%esp
    1e51:	ff 35 10 6e 00 00    	pushl  0x6e10
    1e57:	ff 35 0c 6e 00 00    	pushl  0x6e0c
    1e5d:	ff 35 08 6e 00 00    	pushl  0x6e08
    1e63:	e8 04 f0 ff ff       	call   e6c <APCreateCompatibleDCFromBitmap>
    1e68:	83 c4 10             	add    $0x10,%esp
    1e6b:	a3 34 6e 00 00       	mov    %eax,0x6e34
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1e70:	8b 45 08             	mov    0x8(%ebp),%eax
    1e73:	8b 40 08             	mov    0x8(%eax),%eax
    1e76:	85 c0                	test   %eax,%eax
    1e78:	75 17                	jne    1e91 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1e7a:	83 ec 08             	sub    $0x8,%esp
    1e7d:	68 60 28 00 00       	push   $0x2860
    1e82:	6a 01                	push   $0x1
    1e84:	e8 23 e9 ff ff       	call   7ac <printf>
    1e89:	83 c4 10             	add    $0x10,%esp
        return;
    1e8c:	e9 07 05 00 00       	jmp    2398 <APGridPaint+0x76a>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1e91:	8b 45 08             	mov    0x8(%ebp),%eax
    1e94:	8b 40 10             	mov    0x10(%eax),%eax
    1e97:	85 c0                	test   %eax,%eax
    1e99:	7e 10                	jle    1eab <APGridPaint+0x27d>
    1e9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e9e:	8b 50 14             	mov    0x14(%eax),%edx
    1ea1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea4:	8b 40 10             	mov    0x10(%eax),%eax
    1ea7:	39 c2                	cmp    %eax,%edx
    1ea9:	7c 17                	jl     1ec2 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1eab:	83 ec 08             	sub    $0x8,%esp
    1eae:	68 86 28 00 00       	push   $0x2886
    1eb3:	6a 01                	push   $0x1
    1eb5:	e8 f2 e8 ff ff       	call   7ac <printf>
    1eba:	83 c4 10             	add    $0x10,%esp
        return;
    1ebd:	e9 d6 04 00 00       	jmp    2398 <APGridPaint+0x76a>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1ec2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec5:	8b 40 14             	mov    0x14(%eax),%eax
    1ec8:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1ece:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1ed1:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1ed4:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1ed7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1ede:	e9 96 03 00 00       	jmp    2279 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1ee3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1eea:	e9 7c 03 00 00       	jmp    226b <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1eef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ef2:	c1 e0 04             	shl    $0x4,%eax
    1ef5:	89 c2                	mov    %eax,%edx
    1ef7:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1efa:	01 c2                	add    %eax,%edx
    1efc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1eff:	01 d0                	add    %edx,%eax
    1f01:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1f04:	8b 45 08             	mov    0x8(%ebp),%eax
    1f07:	8b 40 0c             	mov    0xc(%eax),%eax
    1f0a:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1f0d:	c1 e2 02             	shl    $0x2,%edx
    1f10:	01 d0                	add    %edx,%eax
    1f12:	8b 00                	mov    (%eax),%eax
    1f14:	83 f8 07             	cmp    $0x7,%eax
    1f17:	0f 87 49 03 00 00    	ja     2266 <APGridPaint+0x638>
    1f1d:	8b 04 85 9c 28 00 00 	mov    0x289c(,%eax,4),%eax
    1f24:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f26:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1f29:	6a 0c                	push   $0xc
    1f2b:	6a 0c                	push   $0xc
    1f2d:	6a 0c                	push   $0xc
    1f2f:	50                   	push   %eax
    1f30:	e8 df f8 ff ff       	call   1814 <RGB>
    1f35:	83 c4 0c             	add    $0xc,%esp
    1f38:	8b 1d f4 6d 00 00    	mov    0x6df4,%ebx
    1f3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f41:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f44:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f47:	6b c0 32             	imul   $0x32,%eax,%eax
    1f4a:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f4d:	8b 45 08             	mov    0x8(%ebp),%eax
    1f50:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f53:	83 ec 0c             	sub    $0xc,%esp
    1f56:	83 ec 04             	sub    $0x4,%esp
    1f59:	89 e0                	mov    %esp,%eax
    1f5b:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1f5f:	66 89 30             	mov    %si,(%eax)
    1f62:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1f66:	88 50 02             	mov    %dl,0x2(%eax)
    1f69:	6a 32                	push   $0x32
    1f6b:	6a 32                	push   $0x32
    1f6d:	6a 00                	push   $0x0
    1f6f:	6a 00                	push   $0x0
    1f71:	53                   	push   %ebx
    1f72:	51                   	push   %ecx
    1f73:	ff 75 84             	pushl  -0x7c(%ebp)
    1f76:	57                   	push   %edi
    1f77:	e8 f4 f6 ff ff       	call   1670 <APDcCopy>
    1f7c:	83 c4 30             	add    $0x30,%esp
                    break;
    1f7f:	e9 e3 02 00 00       	jmp    2267 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1f84:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f87:	6a 69                	push   $0x69
    1f89:	6a 69                	push   $0x69
    1f8b:	6a 69                	push   $0x69
    1f8d:	50                   	push   %eax
    1f8e:	e8 81 f8 ff ff       	call   1814 <RGB>
    1f93:	83 c4 0c             	add    $0xc,%esp
    1f96:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1f9a:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1f9e:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1fa2:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1fa5:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1fac:	8d 45 88             	lea    -0x78(%ebp),%eax
    1faf:	6a 69                	push   $0x69
    1fb1:	6a 69                	push   $0x69
    1fb3:	6a 69                	push   $0x69
    1fb5:	50                   	push   %eax
    1fb6:	e8 59 f8 ff ff       	call   1814 <RGB>
    1fbb:	83 c4 0c             	add    $0xc,%esp
    1fbe:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1fc2:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1fc6:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1fca:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1fcd:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd0:	8d 50 3c             	lea    0x3c(%eax),%edx
    1fd3:	8d 45 88             	lea    -0x78(%ebp),%eax
    1fd6:	ff 75 ac             	pushl  -0x54(%ebp)
    1fd9:	ff 75 a8             	pushl  -0x58(%ebp)
    1fdc:	52                   	push   %edx
    1fdd:	50                   	push   %eax
    1fde:	e8 1e ef ff ff       	call   f01 <APSetPen>
    1fe3:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1fe6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe9:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1fec:	8d 55 88             	lea    -0x78(%ebp),%edx
    1fef:	83 ec 04             	sub    $0x4,%esp
    1ff2:	83 ec 04             	sub    $0x4,%esp
    1ff5:	89 e0                	mov    %esp,%eax
    1ff7:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1ffb:	66 89 08             	mov    %cx,(%eax)
    1ffe:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    2002:	88 48 02             	mov    %cl,0x2(%eax)
    2005:	53                   	push   %ebx
    2006:	52                   	push   %edx
    2007:	e8 2e ef ff ff       	call   f3a <APSetBrush>
    200c:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    200f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2012:	6b d0 32             	imul   $0x32,%eax,%edx
    2015:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2018:	6b c0 32             	imul   $0x32,%eax,%eax
    201b:	8b 4d 08             	mov    0x8(%ebp),%ecx
    201e:	83 c1 3c             	add    $0x3c,%ecx
    2021:	83 ec 0c             	sub    $0xc,%esp
    2024:	6a 32                	push   $0x32
    2026:	6a 32                	push   $0x32
    2028:	52                   	push   %edx
    2029:	50                   	push   %eax
    202a:	51                   	push   %ecx
    202b:	e8 34 f3 ff ff       	call   1364 <APDrawRect>
    2030:	83 c4 20             	add    $0x20,%esp
                    break;
    2033:	e9 2f 02 00 00       	jmp    2267 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2038:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    203b:	6a 0c                	push   $0xc
    203d:	6a 0c                	push   $0xc
    203f:	6a 0c                	push   $0xc
    2041:	50                   	push   %eax
    2042:	e8 cd f7 ff ff       	call   1814 <RGB>
    2047:	83 c4 0c             	add    $0xc,%esp
    204a:	8b 1d 34 6e 00 00    	mov    0x6e34,%ebx
    2050:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2053:	6b c8 32             	imul   $0x32,%eax,%ecx
    2056:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2059:	6b c0 32             	imul   $0x32,%eax,%eax
    205c:	89 45 84             	mov    %eax,-0x7c(%ebp)
    205f:	8b 45 08             	mov    0x8(%ebp),%eax
    2062:	8d 78 3c             	lea    0x3c(%eax),%edi
    2065:	83 ec 0c             	sub    $0xc,%esp
    2068:	83 ec 04             	sub    $0x4,%esp
    206b:	89 e0                	mov    %esp,%eax
    206d:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2071:	66 89 30             	mov    %si,(%eax)
    2074:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    2078:	88 50 02             	mov    %dl,0x2(%eax)
    207b:	6a 32                	push   $0x32
    207d:	6a 32                	push   $0x32
    207f:	6a 00                	push   $0x0
    2081:	6a 00                	push   $0x0
    2083:	53                   	push   %ebx
    2084:	51                   	push   %ecx
    2085:	ff 75 84             	pushl  -0x7c(%ebp)
    2088:	57                   	push   %edi
    2089:	e8 e2 f5 ff ff       	call   1670 <APDcCopy>
    208e:	83 c4 30             	add    $0x30,%esp
                    break;
    2091:	e9 d1 01 00 00       	jmp    2267 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2096:	8d 45 c9             	lea    -0x37(%ebp),%eax
    2099:	6a 0c                	push   $0xc
    209b:	6a 0c                	push   $0xc
    209d:	6a 0c                	push   $0xc
    209f:	50                   	push   %eax
    20a0:	e8 6f f7 ff ff       	call   1814 <RGB>
    20a5:	83 c4 0c             	add    $0xc,%esp
    20a8:	8b 1d 14 6e 00 00    	mov    0x6e14,%ebx
    20ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20b1:	6b c8 32             	imul   $0x32,%eax,%ecx
    20b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20b7:	6b c0 32             	imul   $0x32,%eax,%eax
    20ba:	89 45 84             	mov    %eax,-0x7c(%ebp)
    20bd:	8b 45 08             	mov    0x8(%ebp),%eax
    20c0:	8d 78 3c             	lea    0x3c(%eax),%edi
    20c3:	83 ec 0c             	sub    $0xc,%esp
    20c6:	83 ec 04             	sub    $0x4,%esp
    20c9:	89 e0                	mov    %esp,%eax
    20cb:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    20cf:	66 89 30             	mov    %si,(%eax)
    20d2:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    20d6:	88 50 02             	mov    %dl,0x2(%eax)
    20d9:	6a 32                	push   $0x32
    20db:	6a 32                	push   $0x32
    20dd:	6a 00                	push   $0x0
    20df:	6a 00                	push   $0x0
    20e1:	53                   	push   %ebx
    20e2:	51                   	push   %ecx
    20e3:	ff 75 84             	pushl  -0x7c(%ebp)
    20e6:	57                   	push   %edi
    20e7:	e8 84 f5 ff ff       	call   1670 <APDcCopy>
    20ec:	83 c4 30             	add    $0x30,%esp
                    break;
    20ef:	e9 73 01 00 00       	jmp    2267 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    20f4:	8d 45 cc             	lea    -0x34(%ebp),%eax
    20f7:	6a 0c                	push   $0xc
    20f9:	6a 0c                	push   $0xc
    20fb:	6a 0c                	push   $0xc
    20fd:	50                   	push   %eax
    20fe:	e8 11 f7 ff ff       	call   1814 <RGB>
    2103:	83 c4 0c             	add    $0xc,%esp
    2106:	8b 1d f8 6d 00 00    	mov    0x6df8,%ebx
    210c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    210f:	6b c8 32             	imul   $0x32,%eax,%ecx
    2112:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2115:	6b c0 32             	imul   $0x32,%eax,%eax
    2118:	89 45 84             	mov    %eax,-0x7c(%ebp)
    211b:	8b 45 08             	mov    0x8(%ebp),%eax
    211e:	8d 78 3c             	lea    0x3c(%eax),%edi
    2121:	83 ec 0c             	sub    $0xc,%esp
    2124:	83 ec 04             	sub    $0x4,%esp
    2127:	89 e0                	mov    %esp,%eax
    2129:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    212d:	66 89 30             	mov    %si,(%eax)
    2130:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    2134:	88 50 02             	mov    %dl,0x2(%eax)
    2137:	6a 32                	push   $0x32
    2139:	6a 32                	push   $0x32
    213b:	6a 00                	push   $0x0
    213d:	6a 00                	push   $0x0
    213f:	53                   	push   %ebx
    2140:	51                   	push   %ecx
    2141:	ff 75 84             	pushl  -0x7c(%ebp)
    2144:	57                   	push   %edi
    2145:	e8 26 f5 ff ff       	call   1670 <APDcCopy>
    214a:	83 c4 30             	add    $0x30,%esp
                    break;
    214d:	e9 15 01 00 00       	jmp    2267 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2152:	8d 45 cf             	lea    -0x31(%ebp),%eax
    2155:	6a 0c                	push   $0xc
    2157:	6a 0c                	push   $0xc
    2159:	6a 0c                	push   $0xc
    215b:	50                   	push   %eax
    215c:	e8 b3 f6 ff ff       	call   1814 <RGB>
    2161:	83 c4 0c             	add    $0xc,%esp
    2164:	8b 1d 30 6e 00 00    	mov    0x6e30,%ebx
    216a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    216d:	6b c8 32             	imul   $0x32,%eax,%ecx
    2170:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2173:	6b c0 32             	imul   $0x32,%eax,%eax
    2176:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2179:	8b 45 08             	mov    0x8(%ebp),%eax
    217c:	8d 78 3c             	lea    0x3c(%eax),%edi
    217f:	83 ec 0c             	sub    $0xc,%esp
    2182:	83 ec 04             	sub    $0x4,%esp
    2185:	89 e0                	mov    %esp,%eax
    2187:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    218b:	66 89 30             	mov    %si,(%eax)
    218e:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2192:	88 50 02             	mov    %dl,0x2(%eax)
    2195:	6a 32                	push   $0x32
    2197:	6a 32                	push   $0x32
    2199:	6a 00                	push   $0x0
    219b:	6a 00                	push   $0x0
    219d:	53                   	push   %ebx
    219e:	51                   	push   %ecx
    219f:	ff 75 84             	pushl  -0x7c(%ebp)
    21a2:	57                   	push   %edi
    21a3:	e8 c8 f4 ff ff       	call   1670 <APDcCopy>
    21a8:	83 c4 30             	add    $0x30,%esp
                    break;
    21ab:	e9 b7 00 00 00       	jmp    2267 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    21b0:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    21b3:	6a 0c                	push   $0xc
    21b5:	6a 0c                	push   $0xc
    21b7:	6a 0c                	push   $0xc
    21b9:	50                   	push   %eax
    21ba:	e8 55 f6 ff ff       	call   1814 <RGB>
    21bf:	83 c4 0c             	add    $0xc,%esp
    21c2:	8b 1d c8 6d 00 00    	mov    0x6dc8,%ebx
    21c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21cb:	6b c8 32             	imul   $0x32,%eax,%ecx
    21ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
    21d1:	6b c0 32             	imul   $0x32,%eax,%eax
    21d4:	89 45 84             	mov    %eax,-0x7c(%ebp)
    21d7:	8b 45 08             	mov    0x8(%ebp),%eax
    21da:	8d 78 3c             	lea    0x3c(%eax),%edi
    21dd:	83 ec 0c             	sub    $0xc,%esp
    21e0:	83 ec 04             	sub    $0x4,%esp
    21e3:	89 e0                	mov    %esp,%eax
    21e5:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    21e9:	66 89 30             	mov    %si,(%eax)
    21ec:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    21f0:	88 50 02             	mov    %dl,0x2(%eax)
    21f3:	6a 32                	push   $0x32
    21f5:	6a 32                	push   $0x32
    21f7:	6a 00                	push   $0x0
    21f9:	6a 00                	push   $0x0
    21fb:	53                   	push   %ebx
    21fc:	51                   	push   %ecx
    21fd:	ff 75 84             	pushl  -0x7c(%ebp)
    2200:	57                   	push   %edi
    2201:	e8 6a f4 ff ff       	call   1670 <APDcCopy>
    2206:	83 c4 30             	add    $0x30,%esp
                    break;
    2209:	eb 5c                	jmp    2267 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    220b:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    220e:	6a 0c                	push   $0xc
    2210:	6a 0c                	push   $0xc
    2212:	6a 0c                	push   $0xc
    2214:	50                   	push   %eax
    2215:	e8 fa f5 ff ff       	call   1814 <RGB>
    221a:	83 c4 0c             	add    $0xc,%esp
    221d:	8b 1d e4 6d 00 00    	mov    0x6de4,%ebx
    2223:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2226:	6b c8 32             	imul   $0x32,%eax,%ecx
    2229:	8b 45 e0             	mov    -0x20(%ebp),%eax
    222c:	6b c0 32             	imul   $0x32,%eax,%eax
    222f:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2232:	8b 45 08             	mov    0x8(%ebp),%eax
    2235:	8d 78 3c             	lea    0x3c(%eax),%edi
    2238:	83 ec 0c             	sub    $0xc,%esp
    223b:	83 ec 04             	sub    $0x4,%esp
    223e:	89 e0                	mov    %esp,%eax
    2240:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2244:	66 89 30             	mov    %si,(%eax)
    2247:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    224b:	88 50 02             	mov    %dl,0x2(%eax)
    224e:	6a 32                	push   $0x32
    2250:	6a 32                	push   $0x32
    2252:	6a 00                	push   $0x0
    2254:	6a 00                	push   $0x0
    2256:	53                   	push   %ebx
    2257:	51                   	push   %ecx
    2258:	ff 75 84             	pushl  -0x7c(%ebp)
    225b:	57                   	push   %edi
    225c:	e8 0f f4 ff ff       	call   1670 <APDcCopy>
    2261:	83 c4 30             	add    $0x30,%esp
                    break;
    2264:	eb 01                	jmp    2267 <APGridPaint+0x639>
                default: break;
    2266:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2267:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    226b:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    226f:	0f 8e 7a fc ff ff    	jle    1eef <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2275:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2279:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    227d:	0f 8e 60 fc ff ff    	jle    1ee3 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2283:	8d 45 88             	lea    -0x78(%ebp),%eax
    2286:	68 cd 00 00 00       	push   $0xcd
    228b:	6a 74                	push   $0x74
    228d:	6a 18                	push   $0x18
    228f:	50                   	push   %eax
    2290:	e8 7f f5 ff ff       	call   1814 <RGB>
    2295:	83 c4 0c             	add    $0xc,%esp
    2298:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    229c:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    22a0:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    22a4:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    22a7:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    22ae:	8d 45 88             	lea    -0x78(%ebp),%eax
    22b1:	68 cd 00 00 00       	push   $0xcd
    22b6:	6a 74                	push   $0x74
    22b8:	6a 18                	push   $0x18
    22ba:	50                   	push   %eax
    22bb:	e8 54 f5 ff ff       	call   1814 <RGB>
    22c0:	83 c4 0c             	add    $0xc,%esp
    22c3:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    22c7:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    22cb:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    22cf:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    22d2:	8b 45 08             	mov    0x8(%ebp),%eax
    22d5:	8d 50 58             	lea    0x58(%eax),%edx
    22d8:	8d 45 88             	lea    -0x78(%ebp),%eax
    22db:	ff 75 bc             	pushl  -0x44(%ebp)
    22de:	ff 75 b8             	pushl  -0x48(%ebp)
    22e1:	52                   	push   %edx
    22e2:	50                   	push   %eax
    22e3:	e8 19 ec ff ff       	call   f01 <APSetPen>
    22e8:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    22eb:	8b 45 08             	mov    0x8(%ebp),%eax
    22ee:	8d 58 58             	lea    0x58(%eax),%ebx
    22f1:	8d 55 88             	lea    -0x78(%ebp),%edx
    22f4:	83 ec 04             	sub    $0x4,%esp
    22f7:	83 ec 04             	sub    $0x4,%esp
    22fa:	89 e0                	mov    %esp,%eax
    22fc:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    2300:	66 89 08             	mov    %cx,(%eax)
    2303:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2307:	88 48 02             	mov    %cl,0x2(%eax)
    230a:	53                   	push   %ebx
    230b:	52                   	push   %edx
    230c:	e8 29 ec ff ff       	call   f3a <APSetBrush>
    2311:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2314:	8b 45 08             	mov    0x8(%ebp),%eax
    2317:	83 c0 58             	add    $0x58,%eax
    231a:	83 ec 0c             	sub    $0xc,%esp
    231d:	6a 32                	push   $0x32
    231f:	68 20 03 00 00       	push   $0x320
    2324:	6a 00                	push   $0x0
    2326:	6a 00                	push   $0x0
    2328:	50                   	push   %eax
    2329:	e8 36 f0 ff ff       	call   1364 <APDrawRect>
    232e:	83 c4 20             	add    $0x20,%esp
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    2331:	8d 45 88             	lea    -0x78(%ebp),%eax
    2334:	6a 08                	push   $0x8
    2336:	6a 08                	push   $0x8
    2338:	6a 08                	push   $0x8
    233a:	50                   	push   %eax
    233b:	e8 d4 f4 ff ff       	call   1814 <RGB>
    2340:	83 c4 0c             	add    $0xc,%esp
    2343:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2347:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    234b:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    234f:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    2352:	8b 45 08             	mov    0x8(%ebp),%eax
    2355:	8d 58 58             	lea    0x58(%eax),%ebx
    2358:	8d 55 88             	lea    -0x78(%ebp),%edx
    235b:	83 ec 04             	sub    $0x4,%esp
    235e:	83 ec 04             	sub    $0x4,%esp
    2361:	89 e0                	mov    %esp,%eax
    2363:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    2367:	66 89 08             	mov    %cx,(%eax)
    236a:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    236e:	88 48 02             	mov    %cl,0x2(%eax)
    2371:	53                   	push   %ebx
    2372:	52                   	push   %edx
    2373:	e8 04 ec ff ff       	call   f7c <APSetFont>
    2378:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    237b:	8b 45 08             	mov    0x8(%ebp),%eax
    237e:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    2384:	8b 45 08             	mov    0x8(%ebp),%eax
    2387:	83 c0 58             	add    $0x58,%eax
    238a:	6a 14                	push   $0x14
    238c:	6a 14                	push   $0x14
    238e:	52                   	push   %edx
    238f:	50                   	push   %eax
    2390:	e8 d4 f1 ff ff       	call   1569 <APDrawText>
    2395:	83 c4 10             	add    $0x10,%esp
}
    2398:	8d 65 f4             	lea    -0xc(%ebp),%esp
    239b:	5b                   	pop    %ebx
    239c:	5e                   	pop    %esi
    239d:	5f                   	pop    %edi
    239e:	5d                   	pop    %ebp
    239f:	c3                   	ret    

000023a0 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    23a0:	55                   	push   %ebp
    23a1:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    23a3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    23a7:	7e 08                	jle    23b1 <random+0x11>
{
rand_num = seed;
    23a9:	8b 45 08             	mov    0x8(%ebp),%eax
    23ac:	a3 a0 6d 00 00       	mov    %eax,0x6da0
}
rand_num *= 3;
    23b1:	8b 15 a0 6d 00 00    	mov    0x6da0,%edx
    23b7:	89 d0                	mov    %edx,%eax
    23b9:	01 c0                	add    %eax,%eax
    23bb:	01 d0                	add    %edx,%eax
    23bd:	a3 a0 6d 00 00       	mov    %eax,0x6da0
if (rand_num < 0)
    23c2:	a1 a0 6d 00 00       	mov    0x6da0,%eax
    23c7:	85 c0                	test   %eax,%eax
    23c9:	79 0c                	jns    23d7 <random+0x37>
{
rand_num *= (-1);
    23cb:	a1 a0 6d 00 00       	mov    0x6da0,%eax
    23d0:	f7 d8                	neg    %eax
    23d2:	a3 a0 6d 00 00       	mov    %eax,0x6da0
}
return rand_num % 997;
    23d7:	8b 0d a0 6d 00 00    	mov    0x6da0,%ecx
    23dd:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    23e2:	89 c8                	mov    %ecx,%eax
    23e4:	f7 ea                	imul   %edx
    23e6:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    23e9:	c1 f8 09             	sar    $0x9,%eax
    23ec:	89 c2                	mov    %eax,%edx
    23ee:	89 c8                	mov    %ecx,%eax
    23f0:	c1 f8 1f             	sar    $0x1f,%eax
    23f3:	29 c2                	sub    %eax,%edx
    23f5:	89 d0                	mov    %edx,%eax
    23f7:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    23fd:	29 c1                	sub    %eax,%ecx
    23ff:	89 c8                	mov    %ecx,%eax
}
    2401:	5d                   	pop    %ebp
    2402:	c3                   	ret    

00002403 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2403:	55                   	push   %ebp
    2404:	89 e5                	mov    %esp,%ebp
    2406:	53                   	push   %ebx
    2407:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    240a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2411:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2415:	74 17                	je     242e <sprintint+0x2b>
    2417:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    241b:	79 11                	jns    242e <sprintint+0x2b>
        neg = 1;
    241d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2424:	8b 45 10             	mov    0x10(%ebp),%eax
    2427:	f7 d8                	neg    %eax
    2429:	89 45 f0             	mov    %eax,-0x10(%ebp)
    242c:	eb 06                	jmp    2434 <sprintint+0x31>
    } else {
        x = xx;
    242e:	8b 45 10             	mov    0x10(%ebp),%eax
    2431:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2434:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    243b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    243e:	8d 41 01             	lea    0x1(%ecx),%eax
    2441:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2444:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2447:	8b 45 f0             	mov    -0x10(%ebp),%eax
    244a:	ba 00 00 00 00       	mov    $0x0,%edx
    244f:	f7 f3                	div    %ebx
    2451:	89 d0                	mov    %edx,%eax
    2453:	0f b6 80 a4 6d 00 00 	movzbl 0x6da4(%eax),%eax
    245a:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    245e:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2461:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2464:	ba 00 00 00 00       	mov    $0x0,%edx
    2469:	f7 f3                	div    %ebx
    246b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    246e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2472:	75 c7                	jne    243b <sprintint+0x38>
    if(neg)
    2474:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2478:	74 0e                	je     2488 <sprintint+0x85>
        buf[i++] = '-';
    247a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    247d:	8d 50 01             	lea    0x1(%eax),%edx
    2480:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2483:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2488:	8b 45 f8             	mov    -0x8(%ebp),%eax
    248b:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    248e:	eb 1b                	jmp    24ab <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2490:	8b 45 0c             	mov    0xc(%ebp),%eax
    2493:	8b 00                	mov    (%eax),%eax
    2495:	8d 48 01             	lea    0x1(%eax),%ecx
    2498:	8b 55 0c             	mov    0xc(%ebp),%edx
    249b:	89 0a                	mov    %ecx,(%edx)
    249d:	89 c2                	mov    %eax,%edx
    249f:	8b 45 08             	mov    0x8(%ebp),%eax
    24a2:	01 d0                	add    %edx,%eax
    24a4:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    24a7:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    24ab:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    24af:	7f df                	jg     2490 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    24b1:	eb 21                	jmp    24d4 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    24b3:	8b 45 0c             	mov    0xc(%ebp),%eax
    24b6:	8b 00                	mov    (%eax),%eax
    24b8:	8d 48 01             	lea    0x1(%eax),%ecx
    24bb:	8b 55 0c             	mov    0xc(%ebp),%edx
    24be:	89 0a                	mov    %ecx,(%edx)
    24c0:	89 c2                	mov    %eax,%edx
    24c2:	8b 45 08             	mov    0x8(%ebp),%eax
    24c5:	01 c2                	add    %eax,%edx
    24c7:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    24ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
    24cd:	01 c8                	add    %ecx,%eax
    24cf:	0f b6 00             	movzbl (%eax),%eax
    24d2:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    24d4:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    24d8:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    24dc:	79 d5                	jns    24b3 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    24de:	90                   	nop
    24df:	83 c4 20             	add    $0x20,%esp
    24e2:	5b                   	pop    %ebx
    24e3:	5d                   	pop    %ebp
    24e4:	c3                   	ret    

000024e5 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    24e5:	55                   	push   %ebp
    24e6:	89 e5                	mov    %esp,%ebp
    24e8:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    24eb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    24f2:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    24f9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2500:	8d 45 0c             	lea    0xc(%ebp),%eax
    2503:	83 c0 04             	add    $0x4,%eax
    2506:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2509:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2510:	e9 d9 01 00 00       	jmp    26ee <sprintf+0x209>
        c = fmt[i] & 0xff;
    2515:	8b 55 0c             	mov    0xc(%ebp),%edx
    2518:	8b 45 ec             	mov    -0x14(%ebp),%eax
    251b:	01 d0                	add    %edx,%eax
    251d:	0f b6 00             	movzbl (%eax),%eax
    2520:	0f be c0             	movsbl %al,%eax
    2523:	25 ff 00 00 00       	and    $0xff,%eax
    2528:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    252b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    252f:	75 2c                	jne    255d <sprintf+0x78>
            if(c == '%'){
    2531:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2535:	75 0c                	jne    2543 <sprintf+0x5e>
                state = '%';
    2537:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    253e:	e9 a7 01 00 00       	jmp    26ea <sprintf+0x205>
            } else {
                dst[j++] = c;
    2543:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2546:	8d 50 01             	lea    0x1(%eax),%edx
    2549:	89 55 c8             	mov    %edx,-0x38(%ebp)
    254c:	89 c2                	mov    %eax,%edx
    254e:	8b 45 08             	mov    0x8(%ebp),%eax
    2551:	01 d0                	add    %edx,%eax
    2553:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2556:	88 10                	mov    %dl,(%eax)
    2558:	e9 8d 01 00 00       	jmp    26ea <sprintf+0x205>
            }
        } else if(state == '%'){
    255d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2561:	0f 85 83 01 00 00    	jne    26ea <sprintf+0x205>
            if(c == 'd'){
    2567:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    256b:	75 4c                	jne    25b9 <sprintf+0xd4>
                buf[bi] = '\0';
    256d:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2570:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2573:	01 d0                	add    %edx,%eax
    2575:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2578:	83 ec 0c             	sub    $0xc,%esp
    257b:	8d 45 ce             	lea    -0x32(%ebp),%eax
    257e:	50                   	push   %eax
    257f:	e8 e7 df ff ff       	call   56b <atoi>
    2584:	83 c4 10             	add    $0x10,%esp
    2587:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    258a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2591:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2594:	8b 00                	mov    (%eax),%eax
    2596:	83 ec 08             	sub    $0x8,%esp
    2599:	ff 75 d8             	pushl  -0x28(%ebp)
    259c:	6a 01                	push   $0x1
    259e:	6a 0a                	push   $0xa
    25a0:	50                   	push   %eax
    25a1:	8d 45 c8             	lea    -0x38(%ebp),%eax
    25a4:	50                   	push   %eax
    25a5:	ff 75 08             	pushl  0x8(%ebp)
    25a8:	e8 56 fe ff ff       	call   2403 <sprintint>
    25ad:	83 c4 20             	add    $0x20,%esp
                ap++;
    25b0:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    25b4:	e9 2a 01 00 00       	jmp    26e3 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    25b9:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    25bd:	74 06                	je     25c5 <sprintf+0xe0>
    25bf:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    25c3:	75 4c                	jne    2611 <sprintf+0x12c>
                buf[bi] = '\0';
    25c5:	8d 55 ce             	lea    -0x32(%ebp),%edx
    25c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    25cb:	01 d0                	add    %edx,%eax
    25cd:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    25d0:	83 ec 0c             	sub    $0xc,%esp
    25d3:	8d 45 ce             	lea    -0x32(%ebp),%eax
    25d6:	50                   	push   %eax
    25d7:	e8 8f df ff ff       	call   56b <atoi>
    25dc:	83 c4 10             	add    $0x10,%esp
    25df:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    25e2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    25e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    25ec:	8b 00                	mov    (%eax),%eax
    25ee:	83 ec 08             	sub    $0x8,%esp
    25f1:	ff 75 dc             	pushl  -0x24(%ebp)
    25f4:	6a 00                	push   $0x0
    25f6:	6a 10                	push   $0x10
    25f8:	50                   	push   %eax
    25f9:	8d 45 c8             	lea    -0x38(%ebp),%eax
    25fc:	50                   	push   %eax
    25fd:	ff 75 08             	pushl  0x8(%ebp)
    2600:	e8 fe fd ff ff       	call   2403 <sprintint>
    2605:	83 c4 20             	add    $0x20,%esp
                ap++;
    2608:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    260c:	e9 d2 00 00 00       	jmp    26e3 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2611:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2615:	75 46                	jne    265d <sprintf+0x178>
                s = (char*)*ap;
    2617:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    261a:	8b 00                	mov    (%eax),%eax
    261c:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    261f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2623:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2627:	75 25                	jne    264e <sprintf+0x169>
                    s = "(null)";
    2629:	c7 45 f4 bc 28 00 00 	movl   $0x28bc,-0xc(%ebp)
                while(*s != 0){
    2630:	eb 1c                	jmp    264e <sprintf+0x169>
                    dst[j++] = *s;
    2632:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2635:	8d 50 01             	lea    0x1(%eax),%edx
    2638:	89 55 c8             	mov    %edx,-0x38(%ebp)
    263b:	89 c2                	mov    %eax,%edx
    263d:	8b 45 08             	mov    0x8(%ebp),%eax
    2640:	01 c2                	add    %eax,%edx
    2642:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2645:	0f b6 00             	movzbl (%eax),%eax
    2648:	88 02                	mov    %al,(%edx)
                    s++;
    264a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    264e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2651:	0f b6 00             	movzbl (%eax),%eax
    2654:	84 c0                	test   %al,%al
    2656:	75 da                	jne    2632 <sprintf+0x14d>
    2658:	e9 86 00 00 00       	jmp    26e3 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    265d:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2661:	75 1d                	jne    2680 <sprintf+0x19b>
                dst[j++] = *ap;
    2663:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2666:	8d 50 01             	lea    0x1(%eax),%edx
    2669:	89 55 c8             	mov    %edx,-0x38(%ebp)
    266c:	89 c2                	mov    %eax,%edx
    266e:	8b 45 08             	mov    0x8(%ebp),%eax
    2671:	01 c2                	add    %eax,%edx
    2673:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2676:	8b 00                	mov    (%eax),%eax
    2678:	88 02                	mov    %al,(%edx)
                ap++;
    267a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    267e:	eb 63                	jmp    26e3 <sprintf+0x1fe>
            } else if(c == '%'){
    2680:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2684:	75 17                	jne    269d <sprintf+0x1b8>
                dst[j++] = c;
    2686:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2689:	8d 50 01             	lea    0x1(%eax),%edx
    268c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    268f:	89 c2                	mov    %eax,%edx
    2691:	8b 45 08             	mov    0x8(%ebp),%eax
    2694:	01 d0                	add    %edx,%eax
    2696:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2699:	88 10                	mov    %dl,(%eax)
    269b:	eb 46                	jmp    26e3 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    269d:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    26a1:	7e 18                	jle    26bb <sprintf+0x1d6>
    26a3:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    26a7:	7f 12                	jg     26bb <sprintf+0x1d6>
            {
                buf[bi++] = c;
    26a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    26ac:	8d 50 01             	lea    0x1(%eax),%edx
    26af:	89 55 f0             	mov    %edx,-0x10(%ebp)
    26b2:	8b 55 e0             	mov    -0x20(%ebp),%edx
    26b5:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    26b9:	eb 2f                	jmp    26ea <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    26bb:	8b 45 c8             	mov    -0x38(%ebp),%eax
    26be:	8d 50 01             	lea    0x1(%eax),%edx
    26c1:	89 55 c8             	mov    %edx,-0x38(%ebp)
    26c4:	89 c2                	mov    %eax,%edx
    26c6:	8b 45 08             	mov    0x8(%ebp),%eax
    26c9:	01 d0                	add    %edx,%eax
    26cb:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    26ce:	8b 45 c8             	mov    -0x38(%ebp),%eax
    26d1:	8d 50 01             	lea    0x1(%eax),%edx
    26d4:	89 55 c8             	mov    %edx,-0x38(%ebp)
    26d7:	89 c2                	mov    %eax,%edx
    26d9:	8b 45 08             	mov    0x8(%ebp),%eax
    26dc:	01 d0                	add    %edx,%eax
    26de:	8b 55 e0             	mov    -0x20(%ebp),%edx
    26e1:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    26e3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    26ea:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    26ee:	8b 55 0c             	mov    0xc(%ebp),%edx
    26f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    26f4:	01 d0                	add    %edx,%eax
    26f6:	0f b6 00             	movzbl (%eax),%eax
    26f9:	84 c0                	test   %al,%al
    26fb:	0f 85 14 fe ff ff    	jne    2515 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2701:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2704:	8d 50 01             	lea    0x1(%eax),%edx
    2707:	89 55 c8             	mov    %edx,-0x38(%ebp)
    270a:	89 c2                	mov    %eax,%edx
    270c:	8b 45 08             	mov    0x8(%ebp),%eax
    270f:	01 d0                	add    %edx,%eax
    2711:	c6 00 00             	movb   $0x0,(%eax)
}
    2714:	90                   	nop
    2715:	c9                   	leave  
    2716:	c3                   	ret    
