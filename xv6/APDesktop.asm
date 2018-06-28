
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
       6:	e8 02 06 00 00       	call   60d <fork>
       b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    char temp[30];
    if (pid == 0)
       e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      12:	75 37                	jne    4b <runApp+0x4b>
    {
        sprintf(temp, "AP%s", (char *)param);
      14:	83 ec 04             	sub    $0x4,%esp
      17:	ff 75 08             	pushl  0x8(%ebp)
      1a:	68 78 25 00 00       	push   $0x2578
      1f:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      22:	50                   	push   %eax
      23:	e8 1b 23 00 00       	call   2343 <sprintf>
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
      43:	e8 05 06 00 00       	call   64d <exec>
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
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
                break;
            default:break;
        }
            break;
        default: break;
      6e:	e9 42 02 00 00       	jmp    2b5 <wndProc+0x267>
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
      ae:	8b 04 85 00 2d 00 00 	mov    0x2d00(,%eax,4),%eax
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
      f2:	e8 27 16 00 00       	call   171e <APSendMessage>
      f7:	83 c4 10             	add    $0x10,%esp
            return False;
      fa:	b8 00 00 00 00       	mov    $0x0,%eax
      ff:	e9 c5 01 00 00       	jmp    2c9 <wndProc+0x27b>
        case MSG_PAINT:
            APGridPaint(hwnd);
     104:	83 ec 0c             	sub    $0xc,%esp
     107:	ff 75 08             	pushl  0x8(%ebp)
     10a:	e8 e4 19 00 00       	call   1af3 <APGridPaint>
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
            case VK_DOWN:
                if (hwnd->pos_y < GRID_H_NUMBER - 1 && judgeGridWalkable(hwnd->pos_x ,hwnd->pos_y + 1,hwnd))
                    hwnd->pos_y++;
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
                break;
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
            case VK_DOWN:
                if (hwnd->pos_y < GRID_H_NUMBER - 1 && judgeGridWalkable(hwnd->pos_x ,hwnd->pos_y + 1,hwnd))
                    hwnd->pos_y++;
                changePosition(hwnd->pos_x,hwnd->pos_y,2);
                break;
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
     199:	e8 37 05 00 00       	call   6d5 <changePosition>
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
     1f5:	e8 db 04 00 00       	call   6d5 <changePosition>
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
     251:	e8 7f 04 00 00       	call   6d5 <changePosition>
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
     2ab:	e8 25 04 00 00       	call   6d5 <changePosition>
     2b0:	83 c4 10             	add    $0x10,%esp
                break;
     2b3:	90                   	nop
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
     2c1:	e8 dc 16 00 00       	call   19a2 <APWndProc>
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
     317:	8b 04 85 80 25 00 00 	mov    0x2580(,%eax,4),%eax
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
    AHwnd r = APCreateWindow("desktop",True,3);
     377:	83 ec 04             	sub    $0x4,%esp
     37a:	6a 03                	push   $0x3
     37c:	6a 01                	push   $0x1
     37e:	68 a0 25 00 00       	push   $0x25a0
     383:	e8 b4 13 00 00       	call   173c <APCreateWindow>
     388:	83 c4 10             	add    $0x10,%esp
     38b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    AHwnd hwnd = r;
     38e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     391:	89 45 f0             	mov    %eax,-0x10(%ebp)
    printf(1,"desktop initialized!\n");
     394:	83 ec 08             	sub    $0x8,%esp
     397:	68 a8 25 00 00       	push   $0x25a8
     39c:	6a 01                	push   $0x1
     39e:	e8 11 04 00 00       	call   7b4 <printf>
     3a3:	83 c4 10             	add    $0x10,%esp
    APWndExec(hwnd, wndProc);
     3a6:	83 ec 08             	sub    $0x8,%esp
     3a9:	68 4e 00 00 00       	push   $0x4e
     3ae:	ff 75 f0             	pushl  -0x10(%ebp)
     3b1:	e8 a8 16 00 00       	call   1a5e <APWndExec>
     3b6:	83 c4 10             	add    $0x10,%esp
    exit();
     3b9:	e8 57 02 00 00       	call   615 <exit>

000003be <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     3be:	55                   	push   %ebp
     3bf:	89 e5                	mov    %esp,%ebp
     3c1:	57                   	push   %edi
     3c2:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     3c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     3c6:	8b 55 10             	mov    0x10(%ebp),%edx
     3c9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3cc:	89 cb                	mov    %ecx,%ebx
     3ce:	89 df                	mov    %ebx,%edi
     3d0:	89 d1                	mov    %edx,%ecx
     3d2:	fc                   	cld    
     3d3:	f3 aa                	rep stos %al,%es:(%edi)
     3d5:	89 ca                	mov    %ecx,%edx
     3d7:	89 fb                	mov    %edi,%ebx
     3d9:	89 5d 08             	mov    %ebx,0x8(%ebp)
     3dc:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     3df:	90                   	nop
     3e0:	5b                   	pop    %ebx
     3e1:	5f                   	pop    %edi
     3e2:	5d                   	pop    %ebp
     3e3:	c3                   	ret    

000003e4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     3e4:	55                   	push   %ebp
     3e5:	89 e5                	mov    %esp,%ebp
     3e7:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     3ea:	8b 45 08             	mov    0x8(%ebp),%eax
     3ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     3f0:	90                   	nop
     3f1:	8b 45 08             	mov    0x8(%ebp),%eax
     3f4:	8d 50 01             	lea    0x1(%eax),%edx
     3f7:	89 55 08             	mov    %edx,0x8(%ebp)
     3fa:	8b 55 0c             	mov    0xc(%ebp),%edx
     3fd:	8d 4a 01             	lea    0x1(%edx),%ecx
     400:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     403:	0f b6 12             	movzbl (%edx),%edx
     406:	88 10                	mov    %dl,(%eax)
     408:	0f b6 00             	movzbl (%eax),%eax
     40b:	84 c0                	test   %al,%al
     40d:	75 e2                	jne    3f1 <strcpy+0xd>
    ;
  return os;
     40f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     412:	c9                   	leave  
     413:	c3                   	ret    

00000414 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     414:	55                   	push   %ebp
     415:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     417:	eb 08                	jmp    421 <strcmp+0xd>
    p++, q++;
     419:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     41d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     421:	8b 45 08             	mov    0x8(%ebp),%eax
     424:	0f b6 00             	movzbl (%eax),%eax
     427:	84 c0                	test   %al,%al
     429:	74 10                	je     43b <strcmp+0x27>
     42b:	8b 45 08             	mov    0x8(%ebp),%eax
     42e:	0f b6 10             	movzbl (%eax),%edx
     431:	8b 45 0c             	mov    0xc(%ebp),%eax
     434:	0f b6 00             	movzbl (%eax),%eax
     437:	38 c2                	cmp    %al,%dl
     439:	74 de                	je     419 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     43b:	8b 45 08             	mov    0x8(%ebp),%eax
     43e:	0f b6 00             	movzbl (%eax),%eax
     441:	0f b6 d0             	movzbl %al,%edx
     444:	8b 45 0c             	mov    0xc(%ebp),%eax
     447:	0f b6 00             	movzbl (%eax),%eax
     44a:	0f b6 c0             	movzbl %al,%eax
     44d:	29 c2                	sub    %eax,%edx
     44f:	89 d0                	mov    %edx,%eax
}
     451:	5d                   	pop    %ebp
     452:	c3                   	ret    

00000453 <strlen>:

uint
strlen(char *s)
{
     453:	55                   	push   %ebp
     454:	89 e5                	mov    %esp,%ebp
     456:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     459:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     460:	eb 04                	jmp    466 <strlen+0x13>
     462:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     466:	8b 55 fc             	mov    -0x4(%ebp),%edx
     469:	8b 45 08             	mov    0x8(%ebp),%eax
     46c:	01 d0                	add    %edx,%eax
     46e:	0f b6 00             	movzbl (%eax),%eax
     471:	84 c0                	test   %al,%al
     473:	75 ed                	jne    462 <strlen+0xf>
    ;
  return n;
     475:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     478:	c9                   	leave  
     479:	c3                   	ret    

0000047a <memset>:

void*
memset(void *dst, int c, uint n)
{
     47a:	55                   	push   %ebp
     47b:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     47d:	8b 45 10             	mov    0x10(%ebp),%eax
     480:	50                   	push   %eax
     481:	ff 75 0c             	pushl  0xc(%ebp)
     484:	ff 75 08             	pushl  0x8(%ebp)
     487:	e8 32 ff ff ff       	call   3be <stosb>
     48c:	83 c4 0c             	add    $0xc,%esp
  return dst;
     48f:	8b 45 08             	mov    0x8(%ebp),%eax
}
     492:	c9                   	leave  
     493:	c3                   	ret    

00000494 <strchr>:

char*
strchr(const char *s, char c)
{
     494:	55                   	push   %ebp
     495:	89 e5                	mov    %esp,%ebp
     497:	83 ec 04             	sub    $0x4,%esp
     49a:	8b 45 0c             	mov    0xc(%ebp),%eax
     49d:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     4a0:	eb 14                	jmp    4b6 <strchr+0x22>
    if(*s == c)
     4a2:	8b 45 08             	mov    0x8(%ebp),%eax
     4a5:	0f b6 00             	movzbl (%eax),%eax
     4a8:	3a 45 fc             	cmp    -0x4(%ebp),%al
     4ab:	75 05                	jne    4b2 <strchr+0x1e>
      return (char*)s;
     4ad:	8b 45 08             	mov    0x8(%ebp),%eax
     4b0:	eb 13                	jmp    4c5 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     4b2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     4b6:	8b 45 08             	mov    0x8(%ebp),%eax
     4b9:	0f b6 00             	movzbl (%eax),%eax
     4bc:	84 c0                	test   %al,%al
     4be:	75 e2                	jne    4a2 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     4c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
     4c5:	c9                   	leave  
     4c6:	c3                   	ret    

000004c7 <gets>:

char*
gets(char *buf, int max)
{
     4c7:	55                   	push   %ebp
     4c8:	89 e5                	mov    %esp,%ebp
     4ca:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     4cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4d4:	eb 42                	jmp    518 <gets+0x51>
    cc = read(0, &c, 1);
     4d6:	83 ec 04             	sub    $0x4,%esp
     4d9:	6a 01                	push   $0x1
     4db:	8d 45 ef             	lea    -0x11(%ebp),%eax
     4de:	50                   	push   %eax
     4df:	6a 00                	push   $0x0
     4e1:	e8 47 01 00 00       	call   62d <read>
     4e6:	83 c4 10             	add    $0x10,%esp
     4e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     4ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4f0:	7e 33                	jle    525 <gets+0x5e>
      break;
    buf[i++] = c;
     4f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f5:	8d 50 01             	lea    0x1(%eax),%edx
     4f8:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4fb:	89 c2                	mov    %eax,%edx
     4fd:	8b 45 08             	mov    0x8(%ebp),%eax
     500:	01 c2                	add    %eax,%edx
     502:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     506:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     508:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     50c:	3c 0a                	cmp    $0xa,%al
     50e:	74 16                	je     526 <gets+0x5f>
     510:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     514:	3c 0d                	cmp    $0xd,%al
     516:	74 0e                	je     526 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     518:	8b 45 f4             	mov    -0xc(%ebp),%eax
     51b:	83 c0 01             	add    $0x1,%eax
     51e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     521:	7c b3                	jl     4d6 <gets+0xf>
     523:	eb 01                	jmp    526 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     525:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     526:	8b 55 f4             	mov    -0xc(%ebp),%edx
     529:	8b 45 08             	mov    0x8(%ebp),%eax
     52c:	01 d0                	add    %edx,%eax
     52e:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     531:	8b 45 08             	mov    0x8(%ebp),%eax
}
     534:	c9                   	leave  
     535:	c3                   	ret    

00000536 <stat>:

int
stat(char *n, struct stat *st)
{
     536:	55                   	push   %ebp
     537:	89 e5                	mov    %esp,%ebp
     539:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     53c:	83 ec 08             	sub    $0x8,%esp
     53f:	6a 00                	push   $0x0
     541:	ff 75 08             	pushl  0x8(%ebp)
     544:	e8 0c 01 00 00       	call   655 <open>
     549:	83 c4 10             	add    $0x10,%esp
     54c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     54f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     553:	79 07                	jns    55c <stat+0x26>
    return -1;
     555:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     55a:	eb 25                	jmp    581 <stat+0x4b>
  r = fstat(fd, st);
     55c:	83 ec 08             	sub    $0x8,%esp
     55f:	ff 75 0c             	pushl  0xc(%ebp)
     562:	ff 75 f4             	pushl  -0xc(%ebp)
     565:	e8 03 01 00 00       	call   66d <fstat>
     56a:	83 c4 10             	add    $0x10,%esp
     56d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     570:	83 ec 0c             	sub    $0xc,%esp
     573:	ff 75 f4             	pushl  -0xc(%ebp)
     576:	e8 c2 00 00 00       	call   63d <close>
     57b:	83 c4 10             	add    $0x10,%esp
  return r;
     57e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     581:	c9                   	leave  
     582:	c3                   	ret    

00000583 <atoi>:

int
atoi(const char *s)
{
     583:	55                   	push   %ebp
     584:	89 e5                	mov    %esp,%ebp
     586:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     589:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     590:	eb 25                	jmp    5b7 <atoi+0x34>
    n = n*10 + *s++ - '0';
     592:	8b 55 fc             	mov    -0x4(%ebp),%edx
     595:	89 d0                	mov    %edx,%eax
     597:	c1 e0 02             	shl    $0x2,%eax
     59a:	01 d0                	add    %edx,%eax
     59c:	01 c0                	add    %eax,%eax
     59e:	89 c1                	mov    %eax,%ecx
     5a0:	8b 45 08             	mov    0x8(%ebp),%eax
     5a3:	8d 50 01             	lea    0x1(%eax),%edx
     5a6:	89 55 08             	mov    %edx,0x8(%ebp)
     5a9:	0f b6 00             	movzbl (%eax),%eax
     5ac:	0f be c0             	movsbl %al,%eax
     5af:	01 c8                	add    %ecx,%eax
     5b1:	83 e8 30             	sub    $0x30,%eax
     5b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     5b7:	8b 45 08             	mov    0x8(%ebp),%eax
     5ba:	0f b6 00             	movzbl (%eax),%eax
     5bd:	3c 2f                	cmp    $0x2f,%al
     5bf:	7e 0a                	jle    5cb <atoi+0x48>
     5c1:	8b 45 08             	mov    0x8(%ebp),%eax
     5c4:	0f b6 00             	movzbl (%eax),%eax
     5c7:	3c 39                	cmp    $0x39,%al
     5c9:	7e c7                	jle    592 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     5cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     5ce:	c9                   	leave  
     5cf:	c3                   	ret    

000005d0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     5d0:	55                   	push   %ebp
     5d1:	89 e5                	mov    %esp,%ebp
     5d3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     5d6:	8b 45 08             	mov    0x8(%ebp),%eax
     5d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     5dc:	8b 45 0c             	mov    0xc(%ebp),%eax
     5df:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     5e2:	eb 17                	jmp    5fb <memmove+0x2b>
    *dst++ = *src++;
     5e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5e7:	8d 50 01             	lea    0x1(%eax),%edx
     5ea:	89 55 fc             	mov    %edx,-0x4(%ebp)
     5ed:	8b 55 f8             	mov    -0x8(%ebp),%edx
     5f0:	8d 4a 01             	lea    0x1(%edx),%ecx
     5f3:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     5f6:	0f b6 12             	movzbl (%edx),%edx
     5f9:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     5fb:	8b 45 10             	mov    0x10(%ebp),%eax
     5fe:	8d 50 ff             	lea    -0x1(%eax),%edx
     601:	89 55 10             	mov    %edx,0x10(%ebp)
     604:	85 c0                	test   %eax,%eax
     606:	7f dc                	jg     5e4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     608:	8b 45 08             	mov    0x8(%ebp),%eax
}
     60b:	c9                   	leave  
     60c:	c3                   	ret    

0000060d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     60d:	b8 01 00 00 00       	mov    $0x1,%eax
     612:	cd 40                	int    $0x40
     614:	c3                   	ret    

00000615 <exit>:
SYSCALL(exit)
     615:	b8 02 00 00 00       	mov    $0x2,%eax
     61a:	cd 40                	int    $0x40
     61c:	c3                   	ret    

0000061d <wait>:
SYSCALL(wait)
     61d:	b8 03 00 00 00       	mov    $0x3,%eax
     622:	cd 40                	int    $0x40
     624:	c3                   	ret    

00000625 <pipe>:
SYSCALL(pipe)
     625:	b8 04 00 00 00       	mov    $0x4,%eax
     62a:	cd 40                	int    $0x40
     62c:	c3                   	ret    

0000062d <read>:
SYSCALL(read)
     62d:	b8 05 00 00 00       	mov    $0x5,%eax
     632:	cd 40                	int    $0x40
     634:	c3                   	ret    

00000635 <write>:
SYSCALL(write)
     635:	b8 10 00 00 00       	mov    $0x10,%eax
     63a:	cd 40                	int    $0x40
     63c:	c3                   	ret    

0000063d <close>:
SYSCALL(close)
     63d:	b8 15 00 00 00       	mov    $0x15,%eax
     642:	cd 40                	int    $0x40
     644:	c3                   	ret    

00000645 <kill>:
SYSCALL(kill)
     645:	b8 06 00 00 00       	mov    $0x6,%eax
     64a:	cd 40                	int    $0x40
     64c:	c3                   	ret    

0000064d <exec>:
SYSCALL(exec)
     64d:	b8 07 00 00 00       	mov    $0x7,%eax
     652:	cd 40                	int    $0x40
     654:	c3                   	ret    

00000655 <open>:
SYSCALL(open)
     655:	b8 0f 00 00 00       	mov    $0xf,%eax
     65a:	cd 40                	int    $0x40
     65c:	c3                   	ret    

0000065d <mknod>:
SYSCALL(mknod)
     65d:	b8 11 00 00 00       	mov    $0x11,%eax
     662:	cd 40                	int    $0x40
     664:	c3                   	ret    

00000665 <unlink>:
SYSCALL(unlink)
     665:	b8 12 00 00 00       	mov    $0x12,%eax
     66a:	cd 40                	int    $0x40
     66c:	c3                   	ret    

0000066d <fstat>:
SYSCALL(fstat)
     66d:	b8 08 00 00 00       	mov    $0x8,%eax
     672:	cd 40                	int    $0x40
     674:	c3                   	ret    

00000675 <link>:
SYSCALL(link)
     675:	b8 13 00 00 00       	mov    $0x13,%eax
     67a:	cd 40                	int    $0x40
     67c:	c3                   	ret    

0000067d <mkdir>:
SYSCALL(mkdir)
     67d:	b8 14 00 00 00       	mov    $0x14,%eax
     682:	cd 40                	int    $0x40
     684:	c3                   	ret    

00000685 <chdir>:
SYSCALL(chdir)
     685:	b8 09 00 00 00       	mov    $0x9,%eax
     68a:	cd 40                	int    $0x40
     68c:	c3                   	ret    

0000068d <dup>:
SYSCALL(dup)
     68d:	b8 0a 00 00 00       	mov    $0xa,%eax
     692:	cd 40                	int    $0x40
     694:	c3                   	ret    

00000695 <getpid>:
SYSCALL(getpid)
     695:	b8 0b 00 00 00       	mov    $0xb,%eax
     69a:	cd 40                	int    $0x40
     69c:	c3                   	ret    

0000069d <sbrk>:
SYSCALL(sbrk)
     69d:	b8 0c 00 00 00       	mov    $0xc,%eax
     6a2:	cd 40                	int    $0x40
     6a4:	c3                   	ret    

000006a5 <sleep>:
SYSCALL(sleep)
     6a5:	b8 0d 00 00 00       	mov    $0xd,%eax
     6aa:	cd 40                	int    $0x40
     6ac:	c3                   	ret    

000006ad <uptime>:
SYSCALL(uptime)
     6ad:	b8 0e 00 00 00       	mov    $0xe,%eax
     6b2:	cd 40                	int    $0x40
     6b4:	c3                   	ret    

000006b5 <paintWindow>:

SYSCALL(paintWindow)
     6b5:	b8 16 00 00 00       	mov    $0x16,%eax
     6ba:	cd 40                	int    $0x40
     6bc:	c3                   	ret    

000006bd <sendMessage>:
SYSCALL(sendMessage)
     6bd:	b8 17 00 00 00       	mov    $0x17,%eax
     6c2:	cd 40                	int    $0x40
     6c4:	c3                   	ret    

000006c5 <getMessage>:
SYSCALL(getMessage)
     6c5:	b8 19 00 00 00       	mov    $0x19,%eax
     6ca:	cd 40                	int    $0x40
     6cc:	c3                   	ret    

000006cd <registWindow>:
SYSCALL(registWindow)
     6cd:	b8 18 00 00 00       	mov    $0x18,%eax
     6d2:	cd 40                	int    $0x40
     6d4:	c3                   	ret    

000006d5 <changePosition>:
SYSCALL(changePosition)
     6d5:	b8 1a 00 00 00       	mov    $0x1a,%eax
     6da:	cd 40                	int    $0x40
     6dc:	c3                   	ret    

000006dd <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     6dd:	55                   	push   %ebp
     6de:	89 e5                	mov    %esp,%ebp
     6e0:	83 ec 18             	sub    $0x18,%esp
     6e3:	8b 45 0c             	mov    0xc(%ebp),%eax
     6e6:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     6e9:	83 ec 04             	sub    $0x4,%esp
     6ec:	6a 01                	push   $0x1
     6ee:	8d 45 f4             	lea    -0xc(%ebp),%eax
     6f1:	50                   	push   %eax
     6f2:	ff 75 08             	pushl  0x8(%ebp)
     6f5:	e8 3b ff ff ff       	call   635 <write>
     6fa:	83 c4 10             	add    $0x10,%esp
}
     6fd:	90                   	nop
     6fe:	c9                   	leave  
     6ff:	c3                   	ret    

00000700 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	53                   	push   %ebx
     704:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     707:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     70e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     712:	74 17                	je     72b <printint+0x2b>
     714:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     718:	79 11                	jns    72b <printint+0x2b>
    neg = 1;
     71a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     721:	8b 45 0c             	mov    0xc(%ebp),%eax
     724:	f7 d8                	neg    %eax
     726:	89 45 ec             	mov    %eax,-0x14(%ebp)
     729:	eb 06                	jmp    731 <printint+0x31>
  } else {
    x = xx;
     72b:	8b 45 0c             	mov    0xc(%ebp),%eax
     72e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     731:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     738:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     73b:	8d 41 01             	lea    0x1(%ecx),%eax
     73e:	89 45 f4             	mov    %eax,-0xc(%ebp)
     741:	8b 5d 10             	mov    0x10(%ebp),%ebx
     744:	8b 45 ec             	mov    -0x14(%ebp),%eax
     747:	ba 00 00 00 00       	mov    $0x0,%edx
     74c:	f7 f3                	div    %ebx
     74e:	89 d0                	mov    %edx,%eax
     750:	0f b6 80 c0 2f 00 00 	movzbl 0x2fc0(%eax),%eax
     757:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     75b:	8b 5d 10             	mov    0x10(%ebp),%ebx
     75e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     761:	ba 00 00 00 00       	mov    $0x0,%edx
     766:	f7 f3                	div    %ebx
     768:	89 45 ec             	mov    %eax,-0x14(%ebp)
     76b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     76f:	75 c7                	jne    738 <printint+0x38>
  if(neg)
     771:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     775:	74 2d                	je     7a4 <printint+0xa4>
    buf[i++] = '-';
     777:	8b 45 f4             	mov    -0xc(%ebp),%eax
     77a:	8d 50 01             	lea    0x1(%eax),%edx
     77d:	89 55 f4             	mov    %edx,-0xc(%ebp)
     780:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     785:	eb 1d                	jmp    7a4 <printint+0xa4>
    putc(fd, buf[i]);
     787:	8d 55 dc             	lea    -0x24(%ebp),%edx
     78a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     78d:	01 d0                	add    %edx,%eax
     78f:	0f b6 00             	movzbl (%eax),%eax
     792:	0f be c0             	movsbl %al,%eax
     795:	83 ec 08             	sub    $0x8,%esp
     798:	50                   	push   %eax
     799:	ff 75 08             	pushl  0x8(%ebp)
     79c:	e8 3c ff ff ff       	call   6dd <putc>
     7a1:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     7a4:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     7a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7ac:	79 d9                	jns    787 <printint+0x87>
    putc(fd, buf[i]);
}
     7ae:	90                   	nop
     7af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7b2:	c9                   	leave  
     7b3:	c3                   	ret    

000007b4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     7b4:	55                   	push   %ebp
     7b5:	89 e5                	mov    %esp,%ebp
     7b7:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     7ba:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     7c1:	8d 45 0c             	lea    0xc(%ebp),%eax
     7c4:	83 c0 04             	add    $0x4,%eax
     7c7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     7ca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     7d1:	e9 59 01 00 00       	jmp    92f <printf+0x17b>
    c = fmt[i] & 0xff;
     7d6:	8b 55 0c             	mov    0xc(%ebp),%edx
     7d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7dc:	01 d0                	add    %edx,%eax
     7de:	0f b6 00             	movzbl (%eax),%eax
     7e1:	0f be c0             	movsbl %al,%eax
     7e4:	25 ff 00 00 00       	and    $0xff,%eax
     7e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     7ec:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     7f0:	75 2c                	jne    81e <printf+0x6a>
      if(c == '%'){
     7f2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     7f6:	75 0c                	jne    804 <printf+0x50>
        state = '%';
     7f8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     7ff:	e9 27 01 00 00       	jmp    92b <printf+0x177>
      } else {
        putc(fd, c);
     804:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     807:	0f be c0             	movsbl %al,%eax
     80a:	83 ec 08             	sub    $0x8,%esp
     80d:	50                   	push   %eax
     80e:	ff 75 08             	pushl  0x8(%ebp)
     811:	e8 c7 fe ff ff       	call   6dd <putc>
     816:	83 c4 10             	add    $0x10,%esp
     819:	e9 0d 01 00 00       	jmp    92b <printf+0x177>
      }
    } else if(state == '%'){
     81e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     822:	0f 85 03 01 00 00    	jne    92b <printf+0x177>
      if(c == 'd'){
     828:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     82c:	75 1e                	jne    84c <printf+0x98>
        printint(fd, *ap, 10, 1);
     82e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     831:	8b 00                	mov    (%eax),%eax
     833:	6a 01                	push   $0x1
     835:	6a 0a                	push   $0xa
     837:	50                   	push   %eax
     838:	ff 75 08             	pushl  0x8(%ebp)
     83b:	e8 c0 fe ff ff       	call   700 <printint>
     840:	83 c4 10             	add    $0x10,%esp
        ap++;
     843:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     847:	e9 d8 00 00 00       	jmp    924 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     84c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     850:	74 06                	je     858 <printf+0xa4>
     852:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     856:	75 1e                	jne    876 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     858:	8b 45 e8             	mov    -0x18(%ebp),%eax
     85b:	8b 00                	mov    (%eax),%eax
     85d:	6a 00                	push   $0x0
     85f:	6a 10                	push   $0x10
     861:	50                   	push   %eax
     862:	ff 75 08             	pushl  0x8(%ebp)
     865:	e8 96 fe ff ff       	call   700 <printint>
     86a:	83 c4 10             	add    $0x10,%esp
        ap++;
     86d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     871:	e9 ae 00 00 00       	jmp    924 <printf+0x170>
      } else if(c == 's'){
     876:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     87a:	75 43                	jne    8bf <printf+0x10b>
        s = (char*)*ap;
     87c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     87f:	8b 00                	mov    (%eax),%eax
     881:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     884:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     888:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     88c:	75 25                	jne    8b3 <printf+0xff>
          s = "(null)";
     88e:	c7 45 f4 be 25 00 00 	movl   $0x25be,-0xc(%ebp)
        while(*s != 0){
     895:	eb 1c                	jmp    8b3 <printf+0xff>
          putc(fd, *s);
     897:	8b 45 f4             	mov    -0xc(%ebp),%eax
     89a:	0f b6 00             	movzbl (%eax),%eax
     89d:	0f be c0             	movsbl %al,%eax
     8a0:	83 ec 08             	sub    $0x8,%esp
     8a3:	50                   	push   %eax
     8a4:	ff 75 08             	pushl  0x8(%ebp)
     8a7:	e8 31 fe ff ff       	call   6dd <putc>
     8ac:	83 c4 10             	add    $0x10,%esp
          s++;
     8af:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     8b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8b6:	0f b6 00             	movzbl (%eax),%eax
     8b9:	84 c0                	test   %al,%al
     8bb:	75 da                	jne    897 <printf+0xe3>
     8bd:	eb 65                	jmp    924 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     8bf:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     8c3:	75 1d                	jne    8e2 <printf+0x12e>
        putc(fd, *ap);
     8c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     8c8:	8b 00                	mov    (%eax),%eax
     8ca:	0f be c0             	movsbl %al,%eax
     8cd:	83 ec 08             	sub    $0x8,%esp
     8d0:	50                   	push   %eax
     8d1:	ff 75 08             	pushl  0x8(%ebp)
     8d4:	e8 04 fe ff ff       	call   6dd <putc>
     8d9:	83 c4 10             	add    $0x10,%esp
        ap++;
     8dc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     8e0:	eb 42                	jmp    924 <printf+0x170>
      } else if(c == '%'){
     8e2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     8e6:	75 17                	jne    8ff <printf+0x14b>
        putc(fd, c);
     8e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8eb:	0f be c0             	movsbl %al,%eax
     8ee:	83 ec 08             	sub    $0x8,%esp
     8f1:	50                   	push   %eax
     8f2:	ff 75 08             	pushl  0x8(%ebp)
     8f5:	e8 e3 fd ff ff       	call   6dd <putc>
     8fa:	83 c4 10             	add    $0x10,%esp
     8fd:	eb 25                	jmp    924 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     8ff:	83 ec 08             	sub    $0x8,%esp
     902:	6a 25                	push   $0x25
     904:	ff 75 08             	pushl  0x8(%ebp)
     907:	e8 d1 fd ff ff       	call   6dd <putc>
     90c:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     90f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     912:	0f be c0             	movsbl %al,%eax
     915:	83 ec 08             	sub    $0x8,%esp
     918:	50                   	push   %eax
     919:	ff 75 08             	pushl  0x8(%ebp)
     91c:	e8 bc fd ff ff       	call   6dd <putc>
     921:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     924:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     92b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     92f:	8b 55 0c             	mov    0xc(%ebp),%edx
     932:	8b 45 f0             	mov    -0x10(%ebp),%eax
     935:	01 d0                	add    %edx,%eax
     937:	0f b6 00             	movzbl (%eax),%eax
     93a:	84 c0                	test   %al,%al
     93c:	0f 85 94 fe ff ff    	jne    7d6 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     942:	90                   	nop
     943:	c9                   	leave  
     944:	c3                   	ret    

00000945 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     945:	55                   	push   %ebp
     946:	89 e5                	mov    %esp,%ebp
     948:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     94b:	8b 45 08             	mov    0x8(%ebp),%eax
     94e:	83 e8 08             	sub    $0x8,%eax
     951:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     954:	a1 f4 2f 00 00       	mov    0x2ff4,%eax
     959:	89 45 fc             	mov    %eax,-0x4(%ebp)
     95c:	eb 24                	jmp    982 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     95e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     961:	8b 00                	mov    (%eax),%eax
     963:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     966:	77 12                	ja     97a <free+0x35>
     968:	8b 45 f8             	mov    -0x8(%ebp),%eax
     96b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     96e:	77 24                	ja     994 <free+0x4f>
     970:	8b 45 fc             	mov    -0x4(%ebp),%eax
     973:	8b 00                	mov    (%eax),%eax
     975:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     978:	77 1a                	ja     994 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     97a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     97d:	8b 00                	mov    (%eax),%eax
     97f:	89 45 fc             	mov    %eax,-0x4(%ebp)
     982:	8b 45 f8             	mov    -0x8(%ebp),%eax
     985:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     988:	76 d4                	jbe    95e <free+0x19>
     98a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     98d:	8b 00                	mov    (%eax),%eax
     98f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     992:	76 ca                	jbe    95e <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     994:	8b 45 f8             	mov    -0x8(%ebp),%eax
     997:	8b 40 04             	mov    0x4(%eax),%eax
     99a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     9a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9a4:	01 c2                	add    %eax,%edx
     9a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a9:	8b 00                	mov    (%eax),%eax
     9ab:	39 c2                	cmp    %eax,%edx
     9ad:	75 24                	jne    9d3 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     9af:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9b2:	8b 50 04             	mov    0x4(%eax),%edx
     9b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9b8:	8b 00                	mov    (%eax),%eax
     9ba:	8b 40 04             	mov    0x4(%eax),%eax
     9bd:	01 c2                	add    %eax,%edx
     9bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9c2:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     9c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9c8:	8b 00                	mov    (%eax),%eax
     9ca:	8b 10                	mov    (%eax),%edx
     9cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9cf:	89 10                	mov    %edx,(%eax)
     9d1:	eb 0a                	jmp    9dd <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     9d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9d6:	8b 10                	mov    (%eax),%edx
     9d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9db:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     9dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9e0:	8b 40 04             	mov    0x4(%eax),%eax
     9e3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     9ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9ed:	01 d0                	add    %edx,%eax
     9ef:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     9f2:	75 20                	jne    a14 <free+0xcf>
    p->s.size += bp->s.size;
     9f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9f7:	8b 50 04             	mov    0x4(%eax),%edx
     9fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9fd:	8b 40 04             	mov    0x4(%eax),%eax
     a00:	01 c2                	add    %eax,%edx
     a02:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a05:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     a08:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a0b:	8b 10                	mov    (%eax),%edx
     a0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a10:	89 10                	mov    %edx,(%eax)
     a12:	eb 08                	jmp    a1c <free+0xd7>
  } else
    p->s.ptr = bp;
     a14:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a17:	8b 55 f8             	mov    -0x8(%ebp),%edx
     a1a:	89 10                	mov    %edx,(%eax)
  freep = p;
     a1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a1f:	a3 f4 2f 00 00       	mov    %eax,0x2ff4
}
     a24:	90                   	nop
     a25:	c9                   	leave  
     a26:	c3                   	ret    

00000a27 <morecore>:

static Header*
morecore(uint nu)
{
     a27:	55                   	push   %ebp
     a28:	89 e5                	mov    %esp,%ebp
     a2a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     a2d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     a34:	77 07                	ja     a3d <morecore+0x16>
    nu = 4096;
     a36:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     a3d:	8b 45 08             	mov    0x8(%ebp),%eax
     a40:	c1 e0 03             	shl    $0x3,%eax
     a43:	83 ec 0c             	sub    $0xc,%esp
     a46:	50                   	push   %eax
     a47:	e8 51 fc ff ff       	call   69d <sbrk>
     a4c:	83 c4 10             	add    $0x10,%esp
     a4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     a52:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     a56:	75 07                	jne    a5f <morecore+0x38>
    return 0;
     a58:	b8 00 00 00 00       	mov    $0x0,%eax
     a5d:	eb 26                	jmp    a85 <morecore+0x5e>
  hp = (Header*)p;
     a5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a62:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     a65:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a68:	8b 55 08             	mov    0x8(%ebp),%edx
     a6b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     a6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a71:	83 c0 08             	add    $0x8,%eax
     a74:	83 ec 0c             	sub    $0xc,%esp
     a77:	50                   	push   %eax
     a78:	e8 c8 fe ff ff       	call   945 <free>
     a7d:	83 c4 10             	add    $0x10,%esp
  return freep;
     a80:	a1 f4 2f 00 00       	mov    0x2ff4,%eax
}
     a85:	c9                   	leave  
     a86:	c3                   	ret    

00000a87 <malloc>:

void*
malloc(uint nbytes)
{
     a87:	55                   	push   %ebp
     a88:	89 e5                	mov    %esp,%ebp
     a8a:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a8d:	8b 45 08             	mov    0x8(%ebp),%eax
     a90:	83 c0 07             	add    $0x7,%eax
     a93:	c1 e8 03             	shr    $0x3,%eax
     a96:	83 c0 01             	add    $0x1,%eax
     a99:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a9c:	a1 f4 2f 00 00       	mov    0x2ff4,%eax
     aa1:	89 45 f0             	mov    %eax,-0x10(%ebp)
     aa4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     aa8:	75 23                	jne    acd <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     aaa:	c7 45 f0 ec 2f 00 00 	movl   $0x2fec,-0x10(%ebp)
     ab1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ab4:	a3 f4 2f 00 00       	mov    %eax,0x2ff4
     ab9:	a1 f4 2f 00 00       	mov    0x2ff4,%eax
     abe:	a3 ec 2f 00 00       	mov    %eax,0x2fec
    base.s.size = 0;
     ac3:	c7 05 f0 2f 00 00 00 	movl   $0x0,0x2ff0
     aca:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     acd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ad0:	8b 00                	mov    (%eax),%eax
     ad2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     ad5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad8:	8b 40 04             	mov    0x4(%eax),%eax
     adb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     ade:	72 4d                	jb     b2d <malloc+0xa6>
      if(p->s.size == nunits)
     ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae3:	8b 40 04             	mov    0x4(%eax),%eax
     ae6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     ae9:	75 0c                	jne    af7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aee:	8b 10                	mov    (%eax),%edx
     af0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     af3:	89 10                	mov    %edx,(%eax)
     af5:	eb 26                	jmp    b1d <malloc+0x96>
      else {
        p->s.size -= nunits;
     af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     afa:	8b 40 04             	mov    0x4(%eax),%eax
     afd:	2b 45 ec             	sub    -0x14(%ebp),%eax
     b00:	89 c2                	mov    %eax,%edx
     b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b05:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     b08:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b0b:	8b 40 04             	mov    0x4(%eax),%eax
     b0e:	c1 e0 03             	shl    $0x3,%eax
     b11:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     b14:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b17:	8b 55 ec             	mov    -0x14(%ebp),%edx
     b1a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     b1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b20:	a3 f4 2f 00 00       	mov    %eax,0x2ff4
      return (void*)(p + 1);
     b25:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b28:	83 c0 08             	add    $0x8,%eax
     b2b:	eb 3b                	jmp    b68 <malloc+0xe1>
    }
    if(p == freep)
     b2d:	a1 f4 2f 00 00       	mov    0x2ff4,%eax
     b32:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     b35:	75 1e                	jne    b55 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     b37:	83 ec 0c             	sub    $0xc,%esp
     b3a:	ff 75 ec             	pushl  -0x14(%ebp)
     b3d:	e8 e5 fe ff ff       	call   a27 <morecore>
     b42:	83 c4 10             	add    $0x10,%esp
     b45:	89 45 f4             	mov    %eax,-0xc(%ebp)
     b48:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b4c:	75 07                	jne    b55 <malloc+0xce>
        return 0;
     b4e:	b8 00 00 00 00       	mov    $0x0,%eax
     b53:	eb 13                	jmp    b68 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b58:	89 45 f0             	mov    %eax,-0x10(%ebp)
     b5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b5e:	8b 00                	mov    (%eax),%eax
     b60:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     b63:	e9 6d ff ff ff       	jmp    ad5 <malloc+0x4e>
}
     b68:	c9                   	leave  
     b69:	c3                   	ret    

00000b6a <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     b6a:	55                   	push   %ebp
     b6b:	89 e5                	mov    %esp,%ebp
     b6d:	83 ec 1c             	sub    $0x1c,%esp
     b70:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     b73:	8b 55 10             	mov    0x10(%ebp),%edx
     b76:	8b 45 14             	mov    0x14(%ebp),%eax
     b79:	88 4d ec             	mov    %cl,-0x14(%ebp)
     b7c:	88 55 e8             	mov    %dl,-0x18(%ebp)
     b7f:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     b82:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     b86:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     b89:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     b8d:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     b90:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     b94:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     b97:	8b 45 08             	mov    0x8(%ebp),%eax
     b9a:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     b9e:	66 89 10             	mov    %dx,(%eax)
     ba1:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     ba5:	88 50 02             	mov    %dl,0x2(%eax)
}
     ba8:	8b 45 08             	mov    0x8(%ebp),%eax
     bab:	c9                   	leave  
     bac:	c2 04 00             	ret    $0x4

00000baf <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     baf:	55                   	push   %ebp
     bb0:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     bb2:	8b 45 08             	mov    0x8(%ebp),%eax
     bb5:	2b 45 10             	sub    0x10(%ebp),%eax
     bb8:	89 c2                	mov    %eax,%edx
     bba:	8b 45 08             	mov    0x8(%ebp),%eax
     bbd:	2b 45 10             	sub    0x10(%ebp),%eax
     bc0:	0f af d0             	imul   %eax,%edx
     bc3:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc6:	2b 45 14             	sub    0x14(%ebp),%eax
     bc9:	89 c1                	mov    %eax,%ecx
     bcb:	8b 45 0c             	mov    0xc(%ebp),%eax
     bce:	2b 45 14             	sub    0x14(%ebp),%eax
     bd1:	0f af c1             	imul   %ecx,%eax
     bd4:	01 d0                	add    %edx,%eax
}
     bd6:	5d                   	pop    %ebp
     bd7:	c3                   	ret    

00000bd8 <abs_int>:

static inline int abs_int(int x)
{
     bd8:	55                   	push   %ebp
     bd9:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     bdb:	8b 45 08             	mov    0x8(%ebp),%eax
     bde:	99                   	cltd   
     bdf:	89 d0                	mov    %edx,%eax
     be1:	33 45 08             	xor    0x8(%ebp),%eax
     be4:	29 d0                	sub    %edx,%eax
}
     be6:	5d                   	pop    %ebp
     be7:	c3                   	ret    

00000be8 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     be8:	55                   	push   %ebp
     be9:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     beb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     bef:	79 07                	jns    bf8 <APGetIndex+0x10>
        return X_SMALLER;
     bf1:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     bf6:	eb 40                	jmp    c38 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     bf8:	8b 45 08             	mov    0x8(%ebp),%eax
     bfb:	8b 00                	mov    (%eax),%eax
     bfd:	3b 45 0c             	cmp    0xc(%ebp),%eax
     c00:	7f 07                	jg     c09 <APGetIndex+0x21>
        return X_BIGGER;
     c02:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c07:	eb 2f                	jmp    c38 <APGetIndex+0x50>
    if (y < 0)
     c09:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     c0d:	79 07                	jns    c16 <APGetIndex+0x2e>
        return Y_SMALLER;
     c0f:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     c14:	eb 22                	jmp    c38 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     c16:	8b 45 08             	mov    0x8(%ebp),%eax
     c19:	8b 40 04             	mov    0x4(%eax),%eax
     c1c:	3b 45 10             	cmp    0x10(%ebp),%eax
     c1f:	7f 07                	jg     c28 <APGetIndex+0x40>
        return Y_BIGGER;
     c21:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     c26:	eb 10                	jmp    c38 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     c28:	8b 45 08             	mov    0x8(%ebp),%eax
     c2b:	8b 00                	mov    (%eax),%eax
     c2d:	0f af 45 10          	imul   0x10(%ebp),%eax
     c31:	89 c2                	mov    %eax,%edx
     c33:	8b 45 0c             	mov    0xc(%ebp),%eax
     c36:	01 d0                	add    %edx,%eax
}
     c38:	5d                   	pop    %ebp
     c39:	c3                   	ret    

00000c3a <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     c3a:	55                   	push   %ebp
     c3b:	89 e5                	mov    %esp,%ebp
     c3d:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     c40:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     c47:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c4a:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     c4d:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     c54:	83 ec 08             	sub    $0x8,%esp
     c57:	6a 00                	push   $0x0
     c59:	ff 75 0c             	pushl  0xc(%ebp)
     c5c:	e8 f4 f9 ff ff       	call   655 <open>
     c61:	83 c4 10             	add    $0x10,%esp
     c64:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     c67:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     c6b:	79 2e                	jns    c9b <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     c6d:	83 ec 04             	sub    $0x4,%esp
     c70:	ff 75 0c             	pushl  0xc(%ebp)
     c73:	68 c5 25 00 00       	push   $0x25c5
     c78:	6a 01                	push   $0x1
     c7a:	e8 35 fb ff ff       	call   7b4 <printf>
     c7f:	83 c4 10             	add    $0x10,%esp
        return bmp;
     c82:	8b 45 08             	mov    0x8(%ebp),%eax
     c85:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c88:	89 10                	mov    %edx,(%eax)
     c8a:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c8d:	89 50 04             	mov    %edx,0x4(%eax)
     c90:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c93:	89 50 08             	mov    %edx,0x8(%eax)
     c96:	e9 d2 01 00 00       	jmp    e6d <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     c9b:	83 ec 04             	sub    $0x4,%esp
     c9e:	6a 0e                	push   $0xe
     ca0:	8d 45 ba             	lea    -0x46(%ebp),%eax
     ca3:	50                   	push   %eax
     ca4:	ff 75 ec             	pushl  -0x14(%ebp)
     ca7:	e8 81 f9 ff ff       	call   62d <read>
     cac:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     caf:	83 ec 04             	sub    $0x4,%esp
     cb2:	6a 28                	push   $0x28
     cb4:	8d 45 92             	lea    -0x6e(%ebp),%eax
     cb7:	50                   	push   %eax
     cb8:	ff 75 ec             	pushl  -0x14(%ebp)
     cbb:	e8 6d f9 ff ff       	call   62d <read>
     cc0:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     cc3:	8b 45 96             	mov    -0x6a(%ebp),%eax
     cc6:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     cc9:	8b 45 9a             	mov    -0x66(%ebp),%eax
     ccc:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     ccf:	8b 55 c8             	mov    -0x38(%ebp),%edx
     cd2:	8b 45 cc             	mov    -0x34(%ebp),%eax
     cd5:	0f af d0             	imul   %eax,%edx
     cd8:	89 d0                	mov    %edx,%eax
     cda:	01 c0                	add    %eax,%eax
     cdc:	01 d0                	add    %edx,%eax
     cde:	83 ec 0c             	sub    $0xc,%esp
     ce1:	50                   	push   %eax
     ce2:	e8 a0 fd ff ff       	call   a87 <malloc>
     ce7:	83 c4 10             	add    $0x10,%esp
     cea:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     ced:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     cf1:	0f b7 c0             	movzwl %ax,%eax
     cf4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     cf7:	8b 55 c8             	mov    -0x38(%ebp),%edx
     cfa:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cfd:	0f af c2             	imul   %edx,%eax
     d00:	83 c0 1f             	add    $0x1f,%eax
     d03:	c1 e8 05             	shr    $0x5,%eax
     d06:	c1 e0 02             	shl    $0x2,%eax
     d09:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     d0c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d0f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d12:	0f af c2             	imul   %edx,%eax
     d15:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     d18:	8b 45 e0             	mov    -0x20(%ebp),%eax
     d1b:	83 ec 0c             	sub    $0xc,%esp
     d1e:	50                   	push   %eax
     d1f:	e8 63 fd ff ff       	call   a87 <malloc>
     d24:	83 c4 10             	add    $0x10,%esp
     d27:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     d2a:	83 ec 04             	sub    $0x4,%esp
     d2d:	ff 75 e0             	pushl  -0x20(%ebp)
     d30:	ff 75 dc             	pushl  -0x24(%ebp)
     d33:	ff 75 ec             	pushl  -0x14(%ebp)
     d36:	e8 f2 f8 ff ff       	call   62d <read>
     d3b:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     d3e:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     d42:	66 c1 e8 03          	shr    $0x3,%ax
     d46:	0f b7 c0             	movzwl %ax,%eax
     d49:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     d4c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d53:	e9 e5 00 00 00       	jmp    e3d <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     d58:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5e:	29 c2                	sub    %eax,%edx
     d60:	89 d0                	mov    %edx,%eax
     d62:	8d 50 ff             	lea    -0x1(%eax),%edx
     d65:	8b 45 c8             	mov    -0x38(%ebp),%eax
     d68:	0f af c2             	imul   %edx,%eax
     d6b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     d6e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     d75:	e9 b1 00 00 00       	jmp    e2b <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     d7a:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d7d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d80:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d83:	01 c8                	add    %ecx,%eax
     d85:	89 c1                	mov    %eax,%ecx
     d87:	89 c8                	mov    %ecx,%eax
     d89:	01 c0                	add    %eax,%eax
     d8b:	01 c8                	add    %ecx,%eax
     d8d:	01 c2                	add    %eax,%edx
     d8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d92:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d96:	89 c1                	mov    %eax,%ecx
     d98:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d9b:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d9f:	01 c1                	add    %eax,%ecx
     da1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     da4:	01 c8                	add    %ecx,%eax
     da6:	8d 48 ff             	lea    -0x1(%eax),%ecx
     da9:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dac:	01 c8                	add    %ecx,%eax
     dae:	0f b6 00             	movzbl (%eax),%eax
     db1:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     db4:	8b 55 d0             	mov    -0x30(%ebp),%edx
     db7:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     dba:	8b 45 f0             	mov    -0x10(%ebp),%eax
     dbd:	01 c8                	add    %ecx,%eax
     dbf:	89 c1                	mov    %eax,%ecx
     dc1:	89 c8                	mov    %ecx,%eax
     dc3:	01 c0                	add    %eax,%eax
     dc5:	01 c8                	add    %ecx,%eax
     dc7:	01 c2                	add    %eax,%edx
     dc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dcc:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     dd0:	89 c1                	mov    %eax,%ecx
     dd2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     dd5:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     dd9:	01 c1                	add    %eax,%ecx
     ddb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     dde:	01 c8                	add    %ecx,%eax
     de0:	8d 48 fe             	lea    -0x2(%eax),%ecx
     de3:	8b 45 dc             	mov    -0x24(%ebp),%eax
     de6:	01 c8                	add    %ecx,%eax
     de8:	0f b6 00             	movzbl (%eax),%eax
     deb:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     dee:	8b 55 d0             	mov    -0x30(%ebp),%edx
     df1:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     df4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     df7:	01 c8                	add    %ecx,%eax
     df9:	89 c1                	mov    %eax,%ecx
     dfb:	89 c8                	mov    %ecx,%eax
     dfd:	01 c0                	add    %eax,%eax
     dff:	01 c8                	add    %ecx,%eax
     e01:	01 c2                	add    %eax,%edx
     e03:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e06:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     e0a:	89 c1                	mov    %eax,%ecx
     e0c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e0f:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     e13:	01 c1                	add    %eax,%ecx
     e15:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e18:	01 c8                	add    %ecx,%eax
     e1a:	8d 48 fd             	lea    -0x3(%eax),%ecx
     e1d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e20:	01 c8                	add    %ecx,%eax
     e22:	0f b6 00             	movzbl (%eax),%eax
     e25:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     e27:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e2b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e31:	39 c2                	cmp    %eax,%edx
     e33:	0f 87 41 ff ff ff    	ja     d7a <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     e39:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e3d:	8b 55 cc             	mov    -0x34(%ebp),%edx
     e40:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e43:	39 c2                	cmp    %eax,%edx
     e45:	0f 87 0d ff ff ff    	ja     d58 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     e4b:	83 ec 0c             	sub    $0xc,%esp
     e4e:	ff 75 ec             	pushl  -0x14(%ebp)
     e51:	e8 e7 f7 ff ff       	call   63d <close>
     e56:	83 c4 10             	add    $0x10,%esp
    return bmp;
     e59:	8b 45 08             	mov    0x8(%ebp),%eax
     e5c:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e5f:	89 10                	mov    %edx,(%eax)
     e61:	8b 55 cc             	mov    -0x34(%ebp),%edx
     e64:	89 50 04             	mov    %edx,0x4(%eax)
     e67:	8b 55 d0             	mov    -0x30(%ebp),%edx
     e6a:	89 50 08             	mov    %edx,0x8(%eax)
}
     e6d:	8b 45 08             	mov    0x8(%ebp),%eax
     e70:	c9                   	leave  
     e71:	c2 04 00             	ret    $0x4

00000e74 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     e74:	55                   	push   %ebp
     e75:	89 e5                	mov    %esp,%ebp
     e77:	53                   	push   %ebx
     e78:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     e7b:	83 ec 0c             	sub    $0xc,%esp
     e7e:	6a 1c                	push   $0x1c
     e80:	e8 02 fc ff ff       	call   a87 <malloc>
     e85:	83 c4 10             	add    $0x10,%esp
     e88:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     e8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e8e:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     e95:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     e98:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e9b:	6a 0c                	push   $0xc
     e9d:	6a 0c                	push   $0xc
     e9f:	6a 0c                	push   $0xc
     ea1:	50                   	push   %eax
     ea2:	e8 c3 fc ff ff       	call   b6a <RGB>
     ea7:	83 c4 0c             	add    $0xc,%esp
     eaa:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     eae:	66 89 43 13          	mov    %ax,0x13(%ebx)
     eb2:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     eb6:	88 43 15             	mov    %al,0x15(%ebx)
     eb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ebc:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ebf:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     ec3:	66 89 48 10          	mov    %cx,0x10(%eax)
     ec7:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     ecb:	88 50 12             	mov    %dl,0x12(%eax)
     ece:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ed1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ed4:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     ed8:	66 89 48 08          	mov    %cx,0x8(%eax)
     edc:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     ee0:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     ee3:	8b 45 08             	mov    0x8(%ebp),%eax
     ee6:	89 c2                	mov    %eax,%edx
     ee8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eeb:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     eed:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef0:	89 c2                	mov    %eax,%edx
     ef2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ef5:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     ef8:	8b 55 10             	mov    0x10(%ebp),%edx
     efb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     efe:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     f01:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     f04:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     f07:	c9                   	leave  
     f08:	c3                   	ret    

00000f09 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     f09:	55                   	push   %ebp
     f0a:	89 e5                	mov    %esp,%ebp
     f0c:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     f0f:	8b 45 0c             	mov    0xc(%ebp),%eax
     f12:	8b 50 08             	mov    0x8(%eax),%edx
     f15:	89 55 f8             	mov    %edx,-0x8(%ebp)
     f18:	8b 40 0c             	mov    0xc(%eax),%eax
     f1b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     f1e:	8b 45 0c             	mov    0xc(%ebp),%eax
     f21:	8b 55 10             	mov    0x10(%ebp),%edx
     f24:	89 50 08             	mov    %edx,0x8(%eax)
     f27:	8b 55 14             	mov    0x14(%ebp),%edx
     f2a:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     f2d:	8b 45 08             	mov    0x8(%ebp),%eax
     f30:	8b 55 f8             	mov    -0x8(%ebp),%edx
     f33:	89 10                	mov    %edx,(%eax)
     f35:	8b 55 fc             	mov    -0x4(%ebp),%edx
     f38:	89 50 04             	mov    %edx,0x4(%eax)
}
     f3b:	8b 45 08             	mov    0x8(%ebp),%eax
     f3e:	c9                   	leave  
     f3f:	c2 04 00             	ret    $0x4

00000f42 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     f42:	55                   	push   %ebp
     f43:	89 e5                	mov    %esp,%ebp
     f45:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     f48:	8b 45 0c             	mov    0xc(%ebp),%eax
     f4b:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     f4f:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     f53:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     f57:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     f5a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f5d:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     f61:	66 89 50 10          	mov    %dx,0x10(%eax)
     f65:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     f69:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     f6c:	8b 45 08             	mov    0x8(%ebp),%eax
     f6f:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     f73:	66 89 10             	mov    %dx,(%eax)
     f76:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     f7a:	88 50 02             	mov    %dl,0x2(%eax)
}
     f7d:	8b 45 08             	mov    0x8(%ebp),%eax
     f80:	c9                   	leave  
     f81:	c2 04 00             	ret    $0x4

00000f84 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     f84:	55                   	push   %ebp
     f85:	89 e5                	mov    %esp,%ebp
     f87:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     f8a:	8b 45 08             	mov    0x8(%ebp),%eax
     f8d:	8b 40 0c             	mov    0xc(%eax),%eax
     f90:	89 c2                	mov    %eax,%edx
     f92:	c1 ea 1f             	shr    $0x1f,%edx
     f95:	01 d0                	add    %edx,%eax
     f97:	d1 f8                	sar    %eax
     f99:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     f9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f9f:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     fa3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     fa6:	8b 45 10             	mov    0x10(%ebp),%eax
     fa9:	2b 45 f4             	sub    -0xc(%ebp),%eax
     fac:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     faf:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     fb3:	0f 89 98 00 00 00    	jns    1051 <APDrawPoint+0xcd>
        i = 0;
     fb9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     fc0:	e9 8c 00 00 00       	jmp    1051 <APDrawPoint+0xcd>
    {
        j = x - off;
     fc5:	8b 45 0c             	mov    0xc(%ebp),%eax
     fc8:	2b 45 f4             	sub    -0xc(%ebp),%eax
     fcb:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     fce:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     fd2:	79 69                	jns    103d <APDrawPoint+0xb9>
            j = 0;
     fd4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     fdb:	eb 60                	jmp    103d <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     fdd:	ff 75 fc             	pushl  -0x4(%ebp)
     fe0:	ff 75 f8             	pushl  -0x8(%ebp)
     fe3:	ff 75 08             	pushl  0x8(%ebp)
     fe6:	e8 fd fb ff ff       	call   be8 <APGetIndex>
     feb:	83 c4 0c             	add    $0xc,%esp
     fee:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     ff1:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     ff5:	74 55                	je     104c <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     ff7:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     ffb:	74 67                	je     1064 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     ffd:	ff 75 10             	pushl  0x10(%ebp)
    1000:	ff 75 0c             	pushl  0xc(%ebp)
    1003:	ff 75 fc             	pushl  -0x4(%ebp)
    1006:	ff 75 f8             	pushl  -0x8(%ebp)
    1009:	e8 a1 fb ff ff       	call   baf <distance_2>
    100e:	83 c4 10             	add    $0x10,%esp
    1011:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1014:	7f 23                	jg     1039 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    1016:	8b 45 08             	mov    0x8(%ebp),%eax
    1019:	8b 48 18             	mov    0x18(%eax),%ecx
    101c:	8b 55 ec             	mov    -0x14(%ebp),%edx
    101f:	89 d0                	mov    %edx,%eax
    1021:	01 c0                	add    %eax,%eax
    1023:	01 d0                	add    %edx,%eax
    1025:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1028:	8b 45 08             	mov    0x8(%ebp),%eax
    102b:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    102f:	66 89 0a             	mov    %cx,(%edx)
    1032:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1036:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1039:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    103d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1040:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1043:	01 d0                	add    %edx,%eax
    1045:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1048:	7d 93                	jge    fdd <APDrawPoint+0x59>
    104a:	eb 01                	jmp    104d <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    104c:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    104d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1051:	8b 55 10             	mov    0x10(%ebp),%edx
    1054:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1057:	01 d0                	add    %edx,%eax
    1059:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    105c:	0f 8d 63 ff ff ff    	jge    fc5 <APDrawPoint+0x41>
    1062:	eb 01                	jmp    1065 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1064:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    1065:	c9                   	leave  
    1066:	c3                   	ret    

00001067 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1067:	55                   	push   %ebp
    1068:	89 e5                	mov    %esp,%ebp
    106a:	53                   	push   %ebx
    106b:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    106e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1071:	3b 45 14             	cmp    0x14(%ebp),%eax
    1074:	0f 85 80 00 00 00    	jne    10fa <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    107a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    107e:	0f 88 9d 02 00 00    	js     1321 <APDrawLine+0x2ba>
    1084:	8b 45 08             	mov    0x8(%ebp),%eax
    1087:	8b 00                	mov    (%eax),%eax
    1089:	3b 45 0c             	cmp    0xc(%ebp),%eax
    108c:	0f 8e 8f 02 00 00    	jle    1321 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    1092:	8b 45 10             	mov    0x10(%ebp),%eax
    1095:	3b 45 18             	cmp    0x18(%ebp),%eax
    1098:	7e 12                	jle    10ac <APDrawLine+0x45>
        {
            int tmp = y2;
    109a:	8b 45 18             	mov    0x18(%ebp),%eax
    109d:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    10a0:	8b 45 10             	mov    0x10(%ebp),%eax
    10a3:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    10a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
    10a9:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    10ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    10b0:	79 07                	jns    10b9 <APDrawLine+0x52>
    10b2:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    10b9:	8b 45 08             	mov    0x8(%ebp),%eax
    10bc:	8b 40 04             	mov    0x4(%eax),%eax
    10bf:	3b 45 18             	cmp    0x18(%ebp),%eax
    10c2:	7d 0c                	jge    10d0 <APDrawLine+0x69>
    10c4:	8b 45 08             	mov    0x8(%ebp),%eax
    10c7:	8b 40 04             	mov    0x4(%eax),%eax
    10ca:	83 e8 01             	sub    $0x1,%eax
    10cd:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    10d0:	8b 45 10             	mov    0x10(%ebp),%eax
    10d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    10d6:	eb 15                	jmp    10ed <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    10d8:	ff 75 f4             	pushl  -0xc(%ebp)
    10db:	ff 75 0c             	pushl  0xc(%ebp)
    10de:	ff 75 08             	pushl  0x8(%ebp)
    10e1:	e8 9e fe ff ff       	call   f84 <APDrawPoint>
    10e6:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    10e9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10f0:	3b 45 18             	cmp    0x18(%ebp),%eax
    10f3:	7e e3                	jle    10d8 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    10f5:	e9 2b 02 00 00       	jmp    1325 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    10fa:	8b 45 10             	mov    0x10(%ebp),%eax
    10fd:	3b 45 18             	cmp    0x18(%ebp),%eax
    1100:	75 7f                	jne    1181 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    1102:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1106:	0f 88 18 02 00 00    	js     1324 <APDrawLine+0x2bd>
    110c:	8b 45 08             	mov    0x8(%ebp),%eax
    110f:	8b 40 04             	mov    0x4(%eax),%eax
    1112:	3b 45 10             	cmp    0x10(%ebp),%eax
    1115:	0f 8e 09 02 00 00    	jle    1324 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    111b:	8b 45 0c             	mov    0xc(%ebp),%eax
    111e:	3b 45 14             	cmp    0x14(%ebp),%eax
    1121:	7e 12                	jle    1135 <APDrawLine+0xce>
        {
            int tmp = x2;
    1123:	8b 45 14             	mov    0x14(%ebp),%eax
    1126:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1129:	8b 45 0c             	mov    0xc(%ebp),%eax
    112c:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    112f:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1132:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1135:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1139:	79 07                	jns    1142 <APDrawLine+0xdb>
    113b:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1142:	8b 45 08             	mov    0x8(%ebp),%eax
    1145:	8b 00                	mov    (%eax),%eax
    1147:	3b 45 14             	cmp    0x14(%ebp),%eax
    114a:	7d 0b                	jge    1157 <APDrawLine+0xf0>
    114c:	8b 45 08             	mov    0x8(%ebp),%eax
    114f:	8b 00                	mov    (%eax),%eax
    1151:	83 e8 01             	sub    $0x1,%eax
    1154:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1157:	8b 45 0c             	mov    0xc(%ebp),%eax
    115a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    115d:	eb 15                	jmp    1174 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    115f:	ff 75 10             	pushl  0x10(%ebp)
    1162:	ff 75 f0             	pushl  -0x10(%ebp)
    1165:	ff 75 08             	pushl  0x8(%ebp)
    1168:	e8 17 fe ff ff       	call   f84 <APDrawPoint>
    116d:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1170:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1174:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1177:	3b 45 14             	cmp    0x14(%ebp),%eax
    117a:	7e e3                	jle    115f <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    117c:	e9 a4 01 00 00       	jmp    1325 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1181:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1188:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    118f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1192:	2b 45 14             	sub    0x14(%ebp),%eax
    1195:	50                   	push   %eax
    1196:	e8 3d fa ff ff       	call   bd8 <abs_int>
    119b:	83 c4 04             	add    $0x4,%esp
    119e:	89 c3                	mov    %eax,%ebx
    11a0:	8b 45 10             	mov    0x10(%ebp),%eax
    11a3:	2b 45 18             	sub    0x18(%ebp),%eax
    11a6:	50                   	push   %eax
    11a7:	e8 2c fa ff ff       	call   bd8 <abs_int>
    11ac:	83 c4 04             	add    $0x4,%esp
    11af:	39 c3                	cmp    %eax,%ebx
    11b1:	0f 8e b5 00 00 00    	jle    126c <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    11b7:	8b 45 10             	mov    0x10(%ebp),%eax
    11ba:	2b 45 18             	sub    0x18(%ebp),%eax
    11bd:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11c0:	db 45 b0             	fildl  -0x50(%ebp)
    11c3:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c6:	2b 45 14             	sub    0x14(%ebp),%eax
    11c9:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11cc:	db 45 b0             	fildl  -0x50(%ebp)
    11cf:	de f9                	fdivrp %st,%st(1)
    11d1:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    11d4:	8b 45 14             	mov    0x14(%ebp),%eax
    11d7:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11da:	7e 0e                	jle    11ea <APDrawLine+0x183>
        {
            s = x1;
    11dc:	8b 45 0c             	mov    0xc(%ebp),%eax
    11df:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    11e2:	8b 45 14             	mov    0x14(%ebp),%eax
    11e5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11e8:	eb 0c                	jmp    11f6 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    11ea:	8b 45 14             	mov    0x14(%ebp),%eax
    11ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    11f0:	8b 45 0c             	mov    0xc(%ebp),%eax
    11f3:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    11f6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11fa:	79 07                	jns    1203 <APDrawLine+0x19c>
    11fc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1203:	8b 45 08             	mov    0x8(%ebp),%eax
    1206:	8b 00                	mov    (%eax),%eax
    1208:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    120b:	7f 0b                	jg     1218 <APDrawLine+0x1b1>
    120d:	8b 45 08             	mov    0x8(%ebp),%eax
    1210:	8b 00                	mov    (%eax),%eax
    1212:	83 e8 01             	sub    $0x1,%eax
    1215:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1218:	8b 45 ec             	mov    -0x14(%ebp),%eax
    121b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    121e:	eb 3f                	jmp    125f <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1220:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1223:	2b 45 0c             	sub    0xc(%ebp),%eax
    1226:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1229:	db 45 b0             	fildl  -0x50(%ebp)
    122c:	dc 4d d0             	fmull  -0x30(%ebp)
    122f:	db 45 10             	fildl  0x10(%ebp)
    1232:	de c1                	faddp  %st,%st(1)
    1234:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1237:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    123b:	b4 0c                	mov    $0xc,%ah
    123d:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1241:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1244:	db 5d cc             	fistpl -0x34(%ebp)
    1247:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    124a:	ff 75 cc             	pushl  -0x34(%ebp)
    124d:	ff 75 e4             	pushl  -0x1c(%ebp)
    1250:	ff 75 08             	pushl  0x8(%ebp)
    1253:	e8 2c fd ff ff       	call   f84 <APDrawPoint>
    1258:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    125b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    125f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1262:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1265:	7e b9                	jle    1220 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1267:	e9 b9 00 00 00       	jmp    1325 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    126c:	8b 45 0c             	mov    0xc(%ebp),%eax
    126f:	2b 45 14             	sub    0x14(%ebp),%eax
    1272:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1275:	db 45 b0             	fildl  -0x50(%ebp)
    1278:	8b 45 10             	mov    0x10(%ebp),%eax
    127b:	2b 45 18             	sub    0x18(%ebp),%eax
    127e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1281:	db 45 b0             	fildl  -0x50(%ebp)
    1284:	de f9                	fdivrp %st,%st(1)
    1286:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1289:	8b 45 10             	mov    0x10(%ebp),%eax
    128c:	3b 45 18             	cmp    0x18(%ebp),%eax
    128f:	7e 0e                	jle    129f <APDrawLine+0x238>
    {
        s = y2;
    1291:	8b 45 18             	mov    0x18(%ebp),%eax
    1294:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1297:	8b 45 10             	mov    0x10(%ebp),%eax
    129a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    129d:	eb 0c                	jmp    12ab <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    129f:	8b 45 10             	mov    0x10(%ebp),%eax
    12a2:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    12a5:	8b 45 18             	mov    0x18(%ebp),%eax
    12a8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    12ab:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    12af:	79 07                	jns    12b8 <APDrawLine+0x251>
    12b1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    12b8:	8b 45 08             	mov    0x8(%ebp),%eax
    12bb:	8b 40 04             	mov    0x4(%eax),%eax
    12be:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12c1:	7f 0c                	jg     12cf <APDrawLine+0x268>
    12c3:	8b 45 08             	mov    0x8(%ebp),%eax
    12c6:	8b 40 04             	mov    0x4(%eax),%eax
    12c9:	83 e8 01             	sub    $0x1,%eax
    12cc:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    12cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    12d5:	eb 3f                	jmp    1316 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    12d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12da:	2b 45 10             	sub    0x10(%ebp),%eax
    12dd:	89 45 b0             	mov    %eax,-0x50(%ebp)
    12e0:	db 45 b0             	fildl  -0x50(%ebp)
    12e3:	dc 4d c0             	fmull  -0x40(%ebp)
    12e6:	db 45 0c             	fildl  0xc(%ebp)
    12e9:	de c1                	faddp  %st,%st(1)
    12eb:	d9 7d b6             	fnstcw -0x4a(%ebp)
    12ee:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    12f2:	b4 0c                	mov    $0xc,%ah
    12f4:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    12f8:	d9 6d b4             	fldcw  -0x4c(%ebp)
    12fb:	db 5d bc             	fistpl -0x44(%ebp)
    12fe:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1301:	ff 75 e0             	pushl  -0x20(%ebp)
    1304:	ff 75 bc             	pushl  -0x44(%ebp)
    1307:	ff 75 08             	pushl  0x8(%ebp)
    130a:	e8 75 fc ff ff       	call   f84 <APDrawPoint>
    130f:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1312:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1316:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1319:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    131c:	7e b9                	jle    12d7 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    131e:	90                   	nop
    131f:	eb 04                	jmp    1325 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1321:	90                   	nop
    1322:	eb 01                	jmp    1325 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1324:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1325:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1328:	c9                   	leave  
    1329:	c3                   	ret    

0000132a <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    132a:	55                   	push   %ebp
    132b:	89 e5                	mov    %esp,%ebp
    132d:	53                   	push   %ebx
    132e:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1331:	8b 55 10             	mov    0x10(%ebp),%edx
    1334:	8b 45 18             	mov    0x18(%ebp),%eax
    1337:	01 d0                	add    %edx,%eax
    1339:	83 e8 01             	sub    $0x1,%eax
    133c:	83 ec 04             	sub    $0x4,%esp
    133f:	50                   	push   %eax
    1340:	ff 75 0c             	pushl  0xc(%ebp)
    1343:	ff 75 10             	pushl  0x10(%ebp)
    1346:	ff 75 0c             	pushl  0xc(%ebp)
    1349:	ff 75 08             	pushl  0x8(%ebp)
    134c:	e8 16 fd ff ff       	call   1067 <APDrawLine>
    1351:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1354:	8b 55 0c             	mov    0xc(%ebp),%edx
    1357:	8b 45 14             	mov    0x14(%ebp),%eax
    135a:	01 d0                	add    %edx,%eax
    135c:	83 e8 01             	sub    $0x1,%eax
    135f:	83 ec 04             	sub    $0x4,%esp
    1362:	ff 75 10             	pushl  0x10(%ebp)
    1365:	50                   	push   %eax
    1366:	ff 75 10             	pushl  0x10(%ebp)
    1369:	ff 75 0c             	pushl  0xc(%ebp)
    136c:	ff 75 08             	pushl  0x8(%ebp)
    136f:	e8 f3 fc ff ff       	call   1067 <APDrawLine>
    1374:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1377:	8b 55 10             	mov    0x10(%ebp),%edx
    137a:	8b 45 18             	mov    0x18(%ebp),%eax
    137d:	01 d0                	add    %edx,%eax
    137f:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1382:	8b 55 0c             	mov    0xc(%ebp),%edx
    1385:	8b 45 14             	mov    0x14(%ebp),%eax
    1388:	01 d0                	add    %edx,%eax
    138a:	8d 50 ff             	lea    -0x1(%eax),%edx
    138d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1390:	8b 45 14             	mov    0x14(%ebp),%eax
    1393:	01 d8                	add    %ebx,%eax
    1395:	83 e8 01             	sub    $0x1,%eax
    1398:	83 ec 04             	sub    $0x4,%esp
    139b:	51                   	push   %ecx
    139c:	52                   	push   %edx
    139d:	ff 75 10             	pushl  0x10(%ebp)
    13a0:	50                   	push   %eax
    13a1:	ff 75 08             	pushl  0x8(%ebp)
    13a4:	e8 be fc ff ff       	call   1067 <APDrawLine>
    13a9:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    13ac:	8b 55 10             	mov    0x10(%ebp),%edx
    13af:	8b 45 18             	mov    0x18(%ebp),%eax
    13b2:	01 d0                	add    %edx,%eax
    13b4:	8d 48 ff             	lea    -0x1(%eax),%ecx
    13b7:	8b 55 0c             	mov    0xc(%ebp),%edx
    13ba:	8b 45 14             	mov    0x14(%ebp),%eax
    13bd:	01 d0                	add    %edx,%eax
    13bf:	8d 50 ff             	lea    -0x1(%eax),%edx
    13c2:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13c5:	8b 45 18             	mov    0x18(%ebp),%eax
    13c8:	01 d8                	add    %ebx,%eax
    13ca:	83 e8 01             	sub    $0x1,%eax
    13cd:	83 ec 04             	sub    $0x4,%esp
    13d0:	51                   	push   %ecx
    13d1:	52                   	push   %edx
    13d2:	50                   	push   %eax
    13d3:	ff 75 0c             	pushl  0xc(%ebp)
    13d6:	ff 75 08             	pushl  0x8(%ebp)
    13d9:	e8 89 fc ff ff       	call   1067 <APDrawLine>
    13de:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    13e1:	8b 55 0c             	mov    0xc(%ebp),%edx
    13e4:	8b 45 14             	mov    0x14(%ebp),%eax
    13e7:	01 d0                	add    %edx,%eax
    13e9:	8d 50 ff             	lea    -0x1(%eax),%edx
    13ec:	8b 45 08             	mov    0x8(%ebp),%eax
    13ef:	8b 40 0c             	mov    0xc(%eax),%eax
    13f2:	89 c1                	mov    %eax,%ecx
    13f4:	c1 e9 1f             	shr    $0x1f,%ecx
    13f7:	01 c8                	add    %ecx,%eax
    13f9:	d1 f8                	sar    %eax
    13fb:	29 c2                	sub    %eax,%edx
    13fd:	89 d0                	mov    %edx,%eax
    13ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1402:	8b 55 10             	mov    0x10(%ebp),%edx
    1405:	8b 45 18             	mov    0x18(%ebp),%eax
    1408:	01 d0                	add    %edx,%eax
    140a:	8d 50 ff             	lea    -0x1(%eax),%edx
    140d:	8b 45 08             	mov    0x8(%ebp),%eax
    1410:	8b 40 0c             	mov    0xc(%eax),%eax
    1413:	89 c1                	mov    %eax,%ecx
    1415:	c1 e9 1f             	shr    $0x1f,%ecx
    1418:	01 c8                	add    %ecx,%eax
    141a:	d1 f8                	sar    %eax
    141c:	29 c2                	sub    %eax,%edx
    141e:	89 d0                	mov    %edx,%eax
    1420:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1423:	8b 45 08             	mov    0x8(%ebp),%eax
    1426:	8b 40 0c             	mov    0xc(%eax),%eax
    1429:	89 c2                	mov    %eax,%edx
    142b:	c1 ea 1f             	shr    $0x1f,%edx
    142e:	01 d0                	add    %edx,%eax
    1430:	d1 f8                	sar    %eax
    1432:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1435:	8b 45 08             	mov    0x8(%ebp),%eax
    1438:	8b 40 0c             	mov    0xc(%eax),%eax
    143b:	89 c2                	mov    %eax,%edx
    143d:	c1 ea 1f             	shr    $0x1f,%edx
    1440:	01 d0                	add    %edx,%eax
    1442:	d1 f8                	sar    %eax
    1444:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1447:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    144b:	0f 88 d8 00 00 00    	js     1529 <APDrawRect+0x1ff>
    1451:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1455:	0f 88 ce 00 00 00    	js     1529 <APDrawRect+0x1ff>
    145b:	8b 45 08             	mov    0x8(%ebp),%eax
    145e:	8b 00                	mov    (%eax),%eax
    1460:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1463:	0f 8e c0 00 00 00    	jle    1529 <APDrawRect+0x1ff>
    1469:	8b 45 08             	mov    0x8(%ebp),%eax
    146c:	8b 40 04             	mov    0x4(%eax),%eax
    146f:	3b 45 10             	cmp    0x10(%ebp),%eax
    1472:	0f 8e b1 00 00 00    	jle    1529 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1478:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    147c:	79 07                	jns    1485 <APDrawRect+0x15b>
    147e:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1485:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1489:	79 07                	jns    1492 <APDrawRect+0x168>
    148b:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1492:	8b 45 08             	mov    0x8(%ebp),%eax
    1495:	8b 00                	mov    (%eax),%eax
    1497:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    149a:	7f 0b                	jg     14a7 <APDrawRect+0x17d>
    149c:	8b 45 08             	mov    0x8(%ebp),%eax
    149f:	8b 00                	mov    (%eax),%eax
    14a1:	83 e8 01             	sub    $0x1,%eax
    14a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    14a7:	8b 45 08             	mov    0x8(%ebp),%eax
    14aa:	8b 40 04             	mov    0x4(%eax),%eax
    14ad:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14b0:	7f 0c                	jg     14be <APDrawRect+0x194>
    14b2:	8b 45 08             	mov    0x8(%ebp),%eax
    14b5:	8b 40 04             	mov    0x4(%eax),%eax
    14b8:	83 e8 01             	sub    $0x1,%eax
    14bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    14be:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    14c5:	8b 45 0c             	mov    0xc(%ebp),%eax
    14c8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14cb:	eb 52                	jmp    151f <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    14cd:	8b 45 10             	mov    0x10(%ebp),%eax
    14d0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    14d3:	eb 3e                	jmp    1513 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    14d5:	83 ec 04             	sub    $0x4,%esp
    14d8:	ff 75 e8             	pushl  -0x18(%ebp)
    14db:	ff 75 ec             	pushl  -0x14(%ebp)
    14de:	ff 75 08             	pushl  0x8(%ebp)
    14e1:	e8 02 f7 ff ff       	call   be8 <APGetIndex>
    14e6:	83 c4 10             	add    $0x10,%esp
    14e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    14ec:	8b 45 08             	mov    0x8(%ebp),%eax
    14ef:	8b 48 18             	mov    0x18(%eax),%ecx
    14f2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    14f5:	89 d0                	mov    %edx,%eax
    14f7:	01 c0                	add    %eax,%eax
    14f9:	01 d0                	add    %edx,%eax
    14fb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    14fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1501:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1505:	66 89 0a             	mov    %cx,(%edx)
    1508:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    150c:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    150f:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1513:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1516:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1519:	7e ba                	jle    14d5 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    151b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    151f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1522:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1525:	7e a6                	jle    14cd <APDrawRect+0x1a3>
    1527:	eb 01                	jmp    152a <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1529:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    152a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    152d:	c9                   	leave  
    152e:	c3                   	ret    

0000152f <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    152f:	55                   	push   %ebp
    1530:	89 e5                	mov    %esp,%ebp
}
    1532:	90                   	nop
    1533:	5d                   	pop    %ebp
    1534:	c3                   	ret    

00001535 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1535:	55                   	push   %ebp
    1536:	89 e5                	mov    %esp,%ebp
    1538:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    153b:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    153f:	0f 88 8e 01 00 00    	js     16d3 <APDcCopy+0x19e>
    1545:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1549:	0f 88 84 01 00 00    	js     16d3 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    154f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1552:	8b 45 20             	mov    0x20(%ebp),%eax
    1555:	01 d0                	add    %edx,%eax
    1557:	89 45 fc             	mov    %eax,-0x4(%ebp)
    155a:	8b 55 10             	mov    0x10(%ebp),%edx
    155d:	8b 45 24             	mov    0x24(%ebp),%eax
    1560:	01 d0                	add    %edx,%eax
    1562:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1565:	8b 55 18             	mov    0x18(%ebp),%edx
    1568:	8b 45 20             	mov    0x20(%ebp),%eax
    156b:	01 d0                	add    %edx,%eax
    156d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1570:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1573:	8b 45 24             	mov    0x24(%ebp),%eax
    1576:	01 d0                	add    %edx,%eax
    1578:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    157b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    157f:	0f 88 51 01 00 00    	js     16d6 <APDcCopy+0x1a1>
    1585:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1589:	0f 88 47 01 00 00    	js     16d6 <APDcCopy+0x1a1>
    158f:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1593:	0f 88 3d 01 00 00    	js     16d6 <APDcCopy+0x1a1>
    1599:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    159d:	0f 88 33 01 00 00    	js     16d6 <APDcCopy+0x1a1>
    15a3:	8b 45 14             	mov    0x14(%ebp),%eax
    15a6:	8b 00                	mov    (%eax),%eax
    15a8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    15ab:	0f 8c 25 01 00 00    	jl     16d6 <APDcCopy+0x1a1>
    15b1:	8b 45 14             	mov    0x14(%ebp),%eax
    15b4:	8b 40 04             	mov    0x4(%eax),%eax
    15b7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    15ba:	0f 8c 16 01 00 00    	jl     16d6 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    15c0:	8b 45 08             	mov    0x8(%ebp),%eax
    15c3:	8b 00                	mov    (%eax),%eax
    15c5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    15c8:	7f 0b                	jg     15d5 <APDcCopy+0xa0>
    15ca:	8b 45 08             	mov    0x8(%ebp),%eax
    15cd:	8b 00                	mov    (%eax),%eax
    15cf:	83 e8 01             	sub    $0x1,%eax
    15d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    15d5:	8b 45 08             	mov    0x8(%ebp),%eax
    15d8:	8b 40 04             	mov    0x4(%eax),%eax
    15db:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    15de:	7f 0c                	jg     15ec <APDcCopy+0xb7>
    15e0:	8b 45 08             	mov    0x8(%ebp),%eax
    15e3:	8b 40 04             	mov    0x4(%eax),%eax
    15e6:	83 e8 01             	sub    $0x1,%eax
    15e9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    15ec:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    15f3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    15fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1601:	e9 bc 00 00 00       	jmp    16c2 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1606:	8b 45 08             	mov    0x8(%ebp),%eax
    1609:	8b 00                	mov    (%eax),%eax
    160b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    160e:	8b 55 10             	mov    0x10(%ebp),%edx
    1611:	01 ca                	add    %ecx,%edx
    1613:	0f af d0             	imul   %eax,%edx
    1616:	8b 45 0c             	mov    0xc(%ebp),%eax
    1619:	01 d0                	add    %edx,%eax
    161b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    161e:	8b 45 14             	mov    0x14(%ebp),%eax
    1621:	8b 00                	mov    (%eax),%eax
    1623:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1626:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1629:	01 ca                	add    %ecx,%edx
    162b:	0f af d0             	imul   %eax,%edx
    162e:	8b 45 18             	mov    0x18(%ebp),%eax
    1631:	01 d0                	add    %edx,%eax
    1633:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1636:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    163d:	eb 74                	jmp    16b3 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    163f:	8b 45 14             	mov    0x14(%ebp),%eax
    1642:	8b 50 18             	mov    0x18(%eax),%edx
    1645:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1648:	8b 45 f0             	mov    -0x10(%ebp),%eax
    164b:	01 c8                	add    %ecx,%eax
    164d:	89 c1                	mov    %eax,%ecx
    164f:	89 c8                	mov    %ecx,%eax
    1651:	01 c0                	add    %eax,%eax
    1653:	01 c8                	add    %ecx,%eax
    1655:	01 d0                	add    %edx,%eax
    1657:	0f b7 10             	movzwl (%eax),%edx
    165a:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    165e:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1662:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1665:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1669:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    166d:	38 c2                	cmp    %al,%dl
    166f:	75 18                	jne    1689 <APDcCopy+0x154>
    1671:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1675:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1679:	38 c2                	cmp    %al,%dl
    167b:	75 0c                	jne    1689 <APDcCopy+0x154>
    167d:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1681:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1685:	38 c2                	cmp    %al,%dl
    1687:	74 26                	je     16af <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1689:	8b 45 08             	mov    0x8(%ebp),%eax
    168c:	8b 50 18             	mov    0x18(%eax),%edx
    168f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1692:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1695:	01 c8                	add    %ecx,%eax
    1697:	89 c1                	mov    %eax,%ecx
    1699:	89 c8                	mov    %ecx,%eax
    169b:	01 c0                	add    %eax,%eax
    169d:	01 c8                	add    %ecx,%eax
    169f:	01 d0                	add    %edx,%eax
    16a1:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    16a5:	66 89 10             	mov    %dx,(%eax)
    16a8:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    16ac:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    16af:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    16b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b6:	2b 45 0c             	sub    0xc(%ebp),%eax
    16b9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    16bc:	7d 81                	jge    163f <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    16be:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    16c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c5:	2b 45 10             	sub    0x10(%ebp),%eax
    16c8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    16cb:	0f 8d 35 ff ff ff    	jge    1606 <APDcCopy+0xd1>
    16d1:	eb 04                	jmp    16d7 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    16d3:	90                   	nop
    16d4:	eb 01                	jmp    16d7 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    16d6:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    16d7:	c9                   	leave  
    16d8:	c3                   	ret    

000016d9 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    16d9:	55                   	push   %ebp
    16da:	89 e5                	mov    %esp,%ebp
    16dc:	83 ec 1c             	sub    $0x1c,%esp
    16df:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    16e2:	8b 55 10             	mov    0x10(%ebp),%edx
    16e5:	8b 45 14             	mov    0x14(%ebp),%eax
    16e8:	88 4d ec             	mov    %cl,-0x14(%ebp)
    16eb:	88 55 e8             	mov    %dl,-0x18(%ebp)
    16ee:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    16f1:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    16f5:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    16f8:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    16fc:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    16ff:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1703:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1706:	8b 45 08             	mov    0x8(%ebp),%eax
    1709:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    170d:	66 89 10             	mov    %dx,(%eax)
    1710:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1714:	88 50 02             	mov    %dl,0x2(%eax)
}
    1717:	8b 45 08             	mov    0x8(%ebp),%eax
    171a:	c9                   	leave  
    171b:	c2 04 00             	ret    $0x4

0000171e <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    171e:	55                   	push   %ebp
    171f:	89 e5                	mov    %esp,%ebp
    1721:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1724:	8b 45 08             	mov    0x8(%ebp),%eax
    1727:	8b 00                	mov    (%eax),%eax
    1729:	83 ec 08             	sub    $0x8,%esp
    172c:	8d 55 0c             	lea    0xc(%ebp),%edx
    172f:	52                   	push   %edx
    1730:	50                   	push   %eax
    1731:	e8 87 ef ff ff       	call   6bd <sendMessage>
    1736:	83 c4 10             	add    $0x10,%esp
}
    1739:	90                   	nop
    173a:	c9                   	leave  
    173b:	c3                   	ret    

0000173c <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    173c:	55                   	push   %ebp
    173d:	89 e5                	mov    %esp,%ebp
    173f:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1742:	83 ec 0c             	sub    $0xc,%esp
    1745:	68 98 00 00 00       	push   $0x98
    174a:	e8 38 f3 ff ff       	call   a87 <malloc>
    174f:	83 c4 10             	add    $0x10,%esp
    1752:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1755:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1759:	75 15                	jne    1770 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    175b:	83 ec 04             	sub    $0x4,%esp
    175e:	ff 75 08             	pushl  0x8(%ebp)
    1761:	68 d8 25 00 00       	push   $0x25d8
    1766:	6a 01                	push   $0x1
    1768:	e8 47 f0 ff ff       	call   7b4 <printf>
    176d:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1770:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1773:	05 84 00 00 00       	add    $0x84,%eax
    1778:	83 ec 08             	sub    $0x8,%esp
    177b:	ff 75 08             	pushl  0x8(%ebp)
    177e:	50                   	push   %eax
    177f:	e8 60 ec ff ff       	call   3e4 <strcpy>
    1784:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1787:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178a:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1791:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1794:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    179b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179e:	8b 40 3c             	mov    0x3c(%eax),%eax
    17a1:	89 c2                	mov    %eax,%edx
    17a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a6:	8b 40 40             	mov    0x40(%eax),%eax
    17a9:	0f af d0             	imul   %eax,%edx
    17ac:	89 d0                	mov    %edx,%eax
    17ae:	01 c0                	add    %eax,%eax
    17b0:	01 d0                	add    %edx,%eax
    17b2:	83 ec 0c             	sub    $0xc,%esp
    17b5:	50                   	push   %eax
    17b6:	e8 cc f2 ff ff       	call   a87 <malloc>
    17bb:	83 c4 10             	add    $0x10,%esp
    17be:	89 c2                	mov    %eax,%edx
    17c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c3:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    17c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c9:	8b 40 54             	mov    0x54(%eax),%eax
    17cc:	85 c0                	test   %eax,%eax
    17ce:	75 15                	jne    17e5 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    17d0:	83 ec 04             	sub    $0x4,%esp
    17d3:	ff 75 08             	pushl  0x8(%ebp)
    17d6:	68 f8 25 00 00       	push   $0x25f8
    17db:	6a 01                	push   $0x1
    17dd:	e8 d2 ef ff ff       	call   7b4 <printf>
    17e2:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    17e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e8:	8b 40 3c             	mov    0x3c(%eax),%eax
    17eb:	89 c2                	mov    %eax,%edx
    17ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f0:	8b 40 40             	mov    0x40(%eax),%eax
    17f3:	0f af d0             	imul   %eax,%edx
    17f6:	89 d0                	mov    %edx,%eax
    17f8:	01 c0                	add    %eax,%eax
    17fa:	01 c2                	add    %eax,%edx
    17fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ff:	8b 40 54             	mov    0x54(%eax),%eax
    1802:	83 ec 04             	sub    $0x4,%esp
    1805:	52                   	push   %edx
    1806:	68 ff ff ff 00       	push   $0xffffff
    180b:	50                   	push   %eax
    180c:	e8 69 ec ff ff       	call   47a <memset>
    1811:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1814:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1817:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    181e:	e8 72 ee ff ff       	call   695 <getpid>
    1823:	89 c2                	mov    %eax,%edx
    1825:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1828:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    182b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182e:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1835:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1838:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    183f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1842:	8b 40 58             	mov    0x58(%eax),%eax
    1845:	89 c2                	mov    %eax,%edx
    1847:	8b 45 f4             	mov    -0xc(%ebp),%eax
    184a:	8b 40 5c             	mov    0x5c(%eax),%eax
    184d:	0f af d0             	imul   %eax,%edx
    1850:	89 d0                	mov    %edx,%eax
    1852:	01 c0                	add    %eax,%eax
    1854:	01 d0                	add    %edx,%eax
    1856:	83 ec 0c             	sub    $0xc,%esp
    1859:	50                   	push   %eax
    185a:	e8 28 f2 ff ff       	call   a87 <malloc>
    185f:	83 c4 10             	add    $0x10,%esp
    1862:	89 c2                	mov    %eax,%edx
    1864:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1867:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    186a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186d:	8b 40 70             	mov    0x70(%eax),%eax
    1870:	85 c0                	test   %eax,%eax
    1872:	75 15                	jne    1889 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1874:	83 ec 04             	sub    $0x4,%esp
    1877:	ff 75 08             	pushl  0x8(%ebp)
    187a:	68 1c 26 00 00       	push   $0x261c
    187f:	6a 01                	push   $0x1
    1881:	e8 2e ef ff ff       	call   7b4 <printf>
    1886:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1889:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188c:	8b 40 3c             	mov    0x3c(%eax),%eax
    188f:	89 c2                	mov    %eax,%edx
    1891:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1894:	8b 40 40             	mov    0x40(%eax),%eax
    1897:	0f af d0             	imul   %eax,%edx
    189a:	89 d0                	mov    %edx,%eax
    189c:	01 c0                	add    %eax,%eax
    189e:	01 c2                	add    %eax,%edx
    18a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a3:	8b 40 54             	mov    0x54(%eax),%eax
    18a6:	83 ec 04             	sub    $0x4,%esp
    18a9:	52                   	push   %edx
    18aa:	68 ff 00 00 00       	push   $0xff
    18af:	50                   	push   %eax
    18b0:	e8 c5 eb ff ff       	call   47a <memset>
    18b5:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    18b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18bb:	8b 55 0c             	mov    0xc(%ebp),%edx
    18be:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    18c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    18c5:	74 49                	je     1910 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    18c7:	8b 45 10             	mov    0x10(%ebp),%eax
    18ca:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    18d0:	83 ec 0c             	sub    $0xc,%esp
    18d3:	50                   	push   %eax
    18d4:	e8 ae f1 ff ff       	call   a87 <malloc>
    18d9:	83 c4 10             	add    $0x10,%esp
    18dc:	89 c2                	mov    %eax,%edx
    18de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e1:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    18e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e7:	8b 55 10             	mov    0x10(%ebp),%edx
    18ea:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    18ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f0:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    18f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18fa:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1901:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1904:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    190b:	e9 8d 00 00 00       	jmp    199d <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1910:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1913:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    191a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    191d:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1924:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1927:	8b 40 20             	mov    0x20(%eax),%eax
    192a:	89 c2                	mov    %eax,%edx
    192c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    192f:	8b 40 24             	mov    0x24(%eax),%eax
    1932:	0f af d0             	imul   %eax,%edx
    1935:	89 d0                	mov    %edx,%eax
    1937:	01 c0                	add    %eax,%eax
    1939:	01 d0                	add    %edx,%eax
    193b:	83 ec 0c             	sub    $0xc,%esp
    193e:	50                   	push   %eax
    193f:	e8 43 f1 ff ff       	call   a87 <malloc>
    1944:	83 c4 10             	add    $0x10,%esp
    1947:	89 c2                	mov    %eax,%edx
    1949:	8b 45 f4             	mov    -0xc(%ebp),%eax
    194c:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    194f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1952:	8b 40 38             	mov    0x38(%eax),%eax
    1955:	85 c0                	test   %eax,%eax
    1957:	75 15                	jne    196e <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1959:	83 ec 04             	sub    $0x4,%esp
    195c:	ff 75 08             	pushl  0x8(%ebp)
    195f:	68 44 26 00 00       	push   $0x2644
    1964:	6a 01                	push   $0x1
    1966:	e8 49 ee ff ff       	call   7b4 <printf>
    196b:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    196e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1971:	8b 40 20             	mov    0x20(%eax),%eax
    1974:	89 c2                	mov    %eax,%edx
    1976:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1979:	8b 40 24             	mov    0x24(%eax),%eax
    197c:	0f af d0             	imul   %eax,%edx
    197f:	89 d0                	mov    %edx,%eax
    1981:	01 c0                	add    %eax,%eax
    1983:	01 c2                	add    %eax,%edx
    1985:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1988:	8b 40 38             	mov    0x38(%eax),%eax
    198b:	83 ec 04             	sub    $0x4,%esp
    198e:	52                   	push   %edx
    198f:	68 ff ff ff 00       	push   $0xffffff
    1994:	50                   	push   %eax
    1995:	e8 e0 ea ff ff       	call   47a <memset>
    199a:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    199d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    19a0:	c9                   	leave  
    19a1:	c3                   	ret    

000019a2 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    19a2:	55                   	push   %ebp
    19a3:	89 e5                	mov    %esp,%ebp
    19a5:	57                   	push   %edi
    19a6:	56                   	push   %esi
    19a7:	53                   	push   %ebx
    19a8:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    19ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    19ae:	83 f8 03             	cmp    $0x3,%eax
    19b1:	74 02                	je     19b5 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    19b3:	eb 7c                	jmp    1a31 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    19b5:	8b 45 08             	mov    0x8(%ebp),%eax
    19b8:	8b 58 1c             	mov    0x1c(%eax),%ebx
    19bb:	8b 45 08             	mov    0x8(%ebp),%eax
    19be:	8b 48 18             	mov    0x18(%eax),%ecx
    19c1:	8b 45 08             	mov    0x8(%ebp),%eax
    19c4:	8b 50 5c             	mov    0x5c(%eax),%edx
    19c7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ca:	8b 40 58             	mov    0x58(%eax),%eax
    19cd:	8b 75 08             	mov    0x8(%ebp),%esi
    19d0:	83 c6 58             	add    $0x58,%esi
    19d3:	83 ec 04             	sub    $0x4,%esp
    19d6:	53                   	push   %ebx
    19d7:	51                   	push   %ecx
    19d8:	6a 00                	push   $0x0
    19da:	52                   	push   %edx
    19db:	50                   	push   %eax
    19dc:	6a 00                	push   $0x0
    19de:	6a 00                	push   $0x0
    19e0:	56                   	push   %esi
    19e1:	6a 00                	push   $0x0
    19e3:	6a 00                	push   $0x0
    19e5:	ff 75 08             	pushl  0x8(%ebp)
    19e8:	e8 c8 ec ff ff       	call   6b5 <paintWindow>
    19ed:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    19f0:	8b 45 08             	mov    0x8(%ebp),%eax
    19f3:	8b 70 1c             	mov    0x1c(%eax),%esi
    19f6:	8b 45 08             	mov    0x8(%ebp),%eax
    19f9:	8b 58 18             	mov    0x18(%eax),%ebx
    19fc:	8b 45 08             	mov    0x8(%ebp),%eax
    19ff:	8b 48 08             	mov    0x8(%eax),%ecx
    1a02:	8b 45 08             	mov    0x8(%ebp),%eax
    1a05:	8b 50 40             	mov    0x40(%eax),%edx
    1a08:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0b:	8b 40 3c             	mov    0x3c(%eax),%eax
    1a0e:	8b 7d 08             	mov    0x8(%ebp),%edi
    1a11:	83 c7 3c             	add    $0x3c,%edi
    1a14:	83 ec 04             	sub    $0x4,%esp
    1a17:	56                   	push   %esi
    1a18:	53                   	push   %ebx
    1a19:	51                   	push   %ecx
    1a1a:	52                   	push   %edx
    1a1b:	50                   	push   %eax
    1a1c:	6a 00                	push   $0x0
    1a1e:	6a 00                	push   $0x0
    1a20:	57                   	push   %edi
    1a21:	6a 32                	push   $0x32
    1a23:	6a 00                	push   $0x0
    1a25:	ff 75 08             	pushl  0x8(%ebp)
    1a28:	e8 88 ec ff ff       	call   6b5 <paintWindow>
    1a2d:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1a30:	90                   	nop
        default: break;
            
            
    }
    return False;
    1a31:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1a36:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a39:	5b                   	pop    %ebx
    1a3a:	5e                   	pop    %esi
    1a3b:	5f                   	pop    %edi
    1a3c:	5d                   	pop    %ebp
    1a3d:	c3                   	ret    

00001a3e <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1a3e:	55                   	push   %ebp
    1a3f:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1a41:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a44:	8b 50 08             	mov    0x8(%eax),%edx
    1a47:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4a:	8b 00                	mov    (%eax),%eax
    1a4c:	39 c2                	cmp    %eax,%edx
    1a4e:	74 07                	je     1a57 <APPreJudge+0x19>
        return False;
    1a50:	b8 00 00 00 00       	mov    $0x0,%eax
    1a55:	eb 05                	jmp    1a5c <APPreJudge+0x1e>
    return True;
    1a57:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1a5c:	5d                   	pop    %ebp
    1a5d:	c3                   	ret    

00001a5e <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1a5e:	55                   	push   %ebp
    1a5f:	89 e5                	mov    %esp,%ebp
    1a61:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1a64:	8b 45 08             	mov    0x8(%ebp),%eax
    1a67:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a6a:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1a70:	83 ec 0c             	sub    $0xc,%esp
    1a73:	ff 75 08             	pushl  0x8(%ebp)
    1a76:	e8 52 ec ff ff       	call   6cd <registWindow>
    1a7b:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1a7e:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1a85:	8b 45 08             	mov    0x8(%ebp),%eax
    1a88:	8b 00                	mov    (%eax),%eax
    1a8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1a8d:	ff 75 f4             	pushl  -0xc(%ebp)
    1a90:	ff 75 f0             	pushl  -0x10(%ebp)
    1a93:	ff 75 ec             	pushl  -0x14(%ebp)
    1a96:	ff 75 08             	pushl  0x8(%ebp)
    1a99:	e8 80 fc ff ff       	call   171e <APSendMessage>
    1a9e:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1aa1:	83 ec 0c             	sub    $0xc,%esp
    1aa4:	ff 75 08             	pushl  0x8(%ebp)
    1aa7:	e8 19 ec ff ff       	call   6c5 <getMessage>
    1aac:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1aaf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab2:	83 c0 74             	add    $0x74,%eax
    1ab5:	83 ec 08             	sub    $0x8,%esp
    1ab8:	50                   	push   %eax
    1ab9:	ff 75 08             	pushl  0x8(%ebp)
    1abc:	e8 7d ff ff ff       	call   1a3e <APPreJudge>
    1ac1:	83 c4 10             	add    $0x10,%esp
    1ac4:	84 c0                	test   %al,%al
    1ac6:	74 1b                	je     1ae3 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1ac8:	8b 45 08             	mov    0x8(%ebp),%eax
    1acb:	ff 70 7c             	pushl  0x7c(%eax)
    1ace:	ff 70 78             	pushl  0x78(%eax)
    1ad1:	ff 70 74             	pushl  0x74(%eax)
    1ad4:	ff 75 08             	pushl  0x8(%ebp)
    1ad7:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ada:	ff d0                	call   *%eax
    1adc:	83 c4 10             	add    $0x10,%esp
    1adf:	84 c0                	test   %al,%al
    1ae1:	75 0c                	jne    1aef <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1ae3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae6:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1aed:	eb b2                	jmp    1aa1 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1aef:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1af0:	90                   	nop
    1af1:	c9                   	leave  
    1af2:	c3                   	ret    

00001af3 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1af3:	55                   	push   %ebp
    1af4:	89 e5                	mov    %esp,%ebp
    1af6:	57                   	push   %edi
    1af7:	56                   	push   %esi
    1af8:	53                   	push   %ebx
    1af9:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1afc:	a1 f8 2f 00 00       	mov    0x2ff8,%eax
    1b01:	85 c0                	test   %eax,%eax
    1b03:	0f 85 2c 02 00 00    	jne    1d35 <APGridPaint+0x242>
    {
        iconReady = 1;
    1b09:	c7 05 f8 2f 00 00 01 	movl   $0x1,0x2ff8
    1b10:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1b13:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b16:	83 ec 08             	sub    $0x8,%esp
    1b19:	68 6b 26 00 00       	push   $0x266b
    1b1e:	50                   	push   %eax
    1b1f:	e8 16 f1 ff ff       	call   c3a <APLoadBitmap>
    1b24:	83 c4 0c             	add    $0xc,%esp
    1b27:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b2a:	a3 1c 30 00 00       	mov    %eax,0x301c
    1b2f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b32:	a3 20 30 00 00       	mov    %eax,0x3020
    1b37:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b3a:	a3 24 30 00 00       	mov    %eax,0x3024
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1b3f:	83 ec 04             	sub    $0x4,%esp
    1b42:	ff 35 24 30 00 00    	pushl  0x3024
    1b48:	ff 35 20 30 00 00    	pushl  0x3020
    1b4e:	ff 35 1c 30 00 00    	pushl  0x301c
    1b54:	e8 1b f3 ff ff       	call   e74 <APCreateCompatibleDCFromBitmap>
    1b59:	83 c4 10             	add    $0x10,%esp
    1b5c:	a3 28 30 00 00       	mov    %eax,0x3028
        grid_river = APLoadBitmap ("grid_river.bmp");
    1b61:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b64:	83 ec 08             	sub    $0x8,%esp
    1b67:	68 79 26 00 00       	push   $0x2679
    1b6c:	50                   	push   %eax
    1b6d:	e8 c8 f0 ff ff       	call   c3a <APLoadBitmap>
    1b72:	83 c4 0c             	add    $0xc,%esp
    1b75:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b78:	a3 58 30 00 00       	mov    %eax,0x3058
    1b7d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b80:	a3 5c 30 00 00       	mov    %eax,0x305c
    1b85:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b88:	a3 60 30 00 00       	mov    %eax,0x3060
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1b8d:	83 ec 04             	sub    $0x4,%esp
    1b90:	ff 35 60 30 00 00    	pushl  0x3060
    1b96:	ff 35 5c 30 00 00    	pushl  0x305c
    1b9c:	ff 35 58 30 00 00    	pushl  0x3058
    1ba2:	e8 cd f2 ff ff       	call   e74 <APCreateCompatibleDCFromBitmap>
    1ba7:	83 c4 10             	add    $0x10,%esp
    1baa:	a3 48 30 00 00       	mov    %eax,0x3048
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1baf:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bb2:	83 ec 08             	sub    $0x8,%esp
    1bb5:	68 88 26 00 00       	push   $0x2688
    1bba:	50                   	push   %eax
    1bbb:	e8 7a f0 ff ff       	call   c3a <APLoadBitmap>
    1bc0:	83 c4 0c             	add    $0xc,%esp
    1bc3:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bc6:	a3 4c 30 00 00       	mov    %eax,0x304c
    1bcb:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bce:	a3 50 30 00 00       	mov    %eax,0x3050
    1bd3:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bd6:	a3 54 30 00 00       	mov    %eax,0x3054
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1bdb:	83 ec 04             	sub    $0x4,%esp
    1bde:	ff 35 54 30 00 00    	pushl  0x3054
    1be4:	ff 35 50 30 00 00    	pushl  0x3050
    1bea:	ff 35 4c 30 00 00    	pushl  0x304c
    1bf0:	e8 7f f2 ff ff       	call   e74 <APCreateCompatibleDCFromBitmap>
    1bf5:	83 c4 10             	add    $0x10,%esp
    1bf8:	a3 fc 2f 00 00       	mov    %eax,0x2ffc
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1bfd:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c00:	83 ec 08             	sub    $0x8,%esp
    1c03:	68 97 26 00 00       	push   $0x2697
    1c08:	50                   	push   %eax
    1c09:	e8 2c f0 ff ff       	call   c3a <APLoadBitmap>
    1c0e:	83 c4 0c             	add    $0xc,%esp
    1c11:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c14:	a3 30 30 00 00       	mov    %eax,0x3030
    1c19:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c1c:	a3 34 30 00 00       	mov    %eax,0x3034
    1c21:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c24:	a3 38 30 00 00       	mov    %eax,0x3038
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1c29:	83 ec 04             	sub    $0x4,%esp
    1c2c:	ff 35 38 30 00 00    	pushl  0x3038
    1c32:	ff 35 34 30 00 00    	pushl  0x3034
    1c38:	ff 35 30 30 00 00    	pushl  0x3030
    1c3e:	e8 31 f2 ff ff       	call   e74 <APCreateCompatibleDCFromBitmap>
    1c43:	83 c4 10             	add    $0x10,%esp
    1c46:	a3 64 30 00 00       	mov    %eax,0x3064
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1c4b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c4e:	83 ec 08             	sub    $0x8,%esp
    1c51:	68 a5 26 00 00       	push   $0x26a5
    1c56:	50                   	push   %eax
    1c57:	e8 de ef ff ff       	call   c3a <APLoadBitmap>
    1c5c:	83 c4 0c             	add    $0xc,%esp
    1c5f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c62:	a3 0c 30 00 00       	mov    %eax,0x300c
    1c67:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c6a:	a3 10 30 00 00       	mov    %eax,0x3010
    1c6f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c72:	a3 14 30 00 00       	mov    %eax,0x3014
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1c77:	83 ec 04             	sub    $0x4,%esp
    1c7a:	ff 35 14 30 00 00    	pushl  0x3014
    1c80:	ff 35 10 30 00 00    	pushl  0x3010
    1c86:	ff 35 0c 30 00 00    	pushl  0x300c
    1c8c:	e8 e3 f1 ff ff       	call   e74 <APCreateCompatibleDCFromBitmap>
    1c91:	83 c4 10             	add    $0x10,%esp
    1c94:	a3 2c 30 00 00       	mov    %eax,0x302c
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1c99:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c9c:	83 ec 08             	sub    $0x8,%esp
    1c9f:	68 b5 26 00 00       	push   $0x26b5
    1ca4:	50                   	push   %eax
    1ca5:	e8 90 ef ff ff       	call   c3a <APLoadBitmap>
    1caa:	83 c4 0c             	add    $0xc,%esp
    1cad:	8b 45 98             	mov    -0x68(%ebp),%eax
    1cb0:	a3 00 30 00 00       	mov    %eax,0x3000
    1cb5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1cb8:	a3 04 30 00 00       	mov    %eax,0x3004
    1cbd:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1cc0:	a3 08 30 00 00       	mov    %eax,0x3008
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1cc5:	83 ec 04             	sub    $0x4,%esp
    1cc8:	ff 35 08 30 00 00    	pushl  0x3008
    1cce:	ff 35 04 30 00 00    	pushl  0x3004
    1cd4:	ff 35 00 30 00 00    	pushl  0x3000
    1cda:	e8 95 f1 ff ff       	call   e74 <APCreateCompatibleDCFromBitmap>
    1cdf:	83 c4 10             	add    $0x10,%esp
    1ce2:	a3 18 30 00 00       	mov    %eax,0x3018
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1ce7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1cea:	83 ec 08             	sub    $0x8,%esp
    1ced:	68 c7 26 00 00       	push   $0x26c7
    1cf2:	50                   	push   %eax
    1cf3:	e8 42 ef ff ff       	call   c3a <APLoadBitmap>
    1cf8:	83 c4 0c             	add    $0xc,%esp
    1cfb:	8b 45 98             	mov    -0x68(%ebp),%eax
    1cfe:	a3 3c 30 00 00       	mov    %eax,0x303c
    1d03:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1d06:	a3 40 30 00 00       	mov    %eax,0x3040
    1d0b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1d0e:	a3 44 30 00 00       	mov    %eax,0x3044
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1d13:	83 ec 04             	sub    $0x4,%esp
    1d16:	ff 35 44 30 00 00    	pushl  0x3044
    1d1c:	ff 35 40 30 00 00    	pushl  0x3040
    1d22:	ff 35 3c 30 00 00    	pushl  0x303c
    1d28:	e8 47 f1 ff ff       	call   e74 <APCreateCompatibleDCFromBitmap>
    1d2d:	83 c4 10             	add    $0x10,%esp
    1d30:	a3 68 30 00 00       	mov    %eax,0x3068
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1d35:	8b 45 08             	mov    0x8(%ebp),%eax
    1d38:	8b 40 08             	mov    0x8(%eax),%eax
    1d3b:	85 c0                	test   %eax,%eax
    1d3d:	75 17                	jne    1d56 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1d3f:	83 ec 08             	sub    $0x8,%esp
    1d42:	68 d8 26 00 00       	push   $0x26d8
    1d47:	6a 01                	push   $0x1
    1d49:	e8 66 ea ff ff       	call   7b4 <printf>
    1d4e:	83 c4 10             	add    $0x10,%esp
        return;
    1d51:	e9 a0 04 00 00       	jmp    21f6 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1d56:	8b 45 08             	mov    0x8(%ebp),%eax
    1d59:	8b 40 10             	mov    0x10(%eax),%eax
    1d5c:	85 c0                	test   %eax,%eax
    1d5e:	7e 10                	jle    1d70 <APGridPaint+0x27d>
    1d60:	8b 45 08             	mov    0x8(%ebp),%eax
    1d63:	8b 50 14             	mov    0x14(%eax),%edx
    1d66:	8b 45 08             	mov    0x8(%ebp),%eax
    1d69:	8b 40 10             	mov    0x10(%eax),%eax
    1d6c:	39 c2                	cmp    %eax,%edx
    1d6e:	7c 17                	jl     1d87 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1d70:	83 ec 08             	sub    $0x8,%esp
    1d73:	68 fe 26 00 00       	push   $0x26fe
    1d78:	6a 01                	push   $0x1
    1d7a:	e8 35 ea ff ff       	call   7b4 <printf>
    1d7f:	83 c4 10             	add    $0x10,%esp
        return;
    1d82:	e9 6f 04 00 00       	jmp    21f6 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1d87:	8b 45 08             	mov    0x8(%ebp),%eax
    1d8a:	8b 40 14             	mov    0x14(%eax),%eax
    1d8d:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1d93:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1d96:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1d99:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d9c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1da3:	e9 96 03 00 00       	jmp    213e <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1da8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1daf:	e9 7c 03 00 00       	jmp    2130 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1db4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1db7:	c1 e0 04             	shl    $0x4,%eax
    1dba:	89 c2                	mov    %eax,%edx
    1dbc:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1dbf:	01 c2                	add    %eax,%edx
    1dc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dc4:	01 d0                	add    %edx,%eax
    1dc6:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1dc9:	8b 45 08             	mov    0x8(%ebp),%eax
    1dcc:	8b 40 0c             	mov    0xc(%eax),%eax
    1dcf:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1dd2:	c1 e2 02             	shl    $0x2,%edx
    1dd5:	01 d0                	add    %edx,%eax
    1dd7:	8b 00                	mov    (%eax),%eax
    1dd9:	83 f8 07             	cmp    $0x7,%eax
    1ddc:	0f 87 49 03 00 00    	ja     212b <APGridPaint+0x638>
    1de2:	8b 04 85 14 27 00 00 	mov    0x2714(,%eax,4),%eax
    1de9:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1deb:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1dee:	6a 0c                	push   $0xc
    1df0:	6a 0c                	push   $0xc
    1df2:	6a 0c                	push   $0xc
    1df4:	50                   	push   %eax
    1df5:	e8 df f8 ff ff       	call   16d9 <RGB>
    1dfa:	83 c4 0c             	add    $0xc,%esp
    1dfd:	8b 1d 28 30 00 00    	mov    0x3028,%ebx
    1e03:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e06:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e09:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e0c:	6b c0 32             	imul   $0x32,%eax,%eax
    1e0f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e12:	8b 45 08             	mov    0x8(%ebp),%eax
    1e15:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e18:	83 ec 0c             	sub    $0xc,%esp
    1e1b:	83 ec 04             	sub    $0x4,%esp
    1e1e:	89 e0                	mov    %esp,%eax
    1e20:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1e24:	66 89 30             	mov    %si,(%eax)
    1e27:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1e2b:	88 50 02             	mov    %dl,0x2(%eax)
    1e2e:	6a 32                	push   $0x32
    1e30:	6a 32                	push   $0x32
    1e32:	6a 00                	push   $0x0
    1e34:	6a 00                	push   $0x0
    1e36:	53                   	push   %ebx
    1e37:	51                   	push   %ecx
    1e38:	ff 75 94             	pushl  -0x6c(%ebp)
    1e3b:	57                   	push   %edi
    1e3c:	e8 f4 f6 ff ff       	call   1535 <APDcCopy>
    1e41:	83 c4 30             	add    $0x30,%esp
                    break;
    1e44:	e9 e3 02 00 00       	jmp    212c <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1e49:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e4c:	6a 69                	push   $0x69
    1e4e:	6a 69                	push   $0x69
    1e50:	6a 69                	push   $0x69
    1e52:	50                   	push   %eax
    1e53:	e8 81 f8 ff ff       	call   16d9 <RGB>
    1e58:	83 c4 0c             	add    $0xc,%esp
    1e5b:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e5f:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1e63:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e67:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1e6a:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1e71:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e74:	6a 69                	push   $0x69
    1e76:	6a 69                	push   $0x69
    1e78:	6a 69                	push   $0x69
    1e7a:	50                   	push   %eax
    1e7b:	e8 59 f8 ff ff       	call   16d9 <RGB>
    1e80:	83 c4 0c             	add    $0xc,%esp
    1e83:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e87:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1e8b:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e8f:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1e92:	8b 45 08             	mov    0x8(%ebp),%eax
    1e95:	8d 50 3c             	lea    0x3c(%eax),%edx
    1e98:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e9b:	ff 75 b0             	pushl  -0x50(%ebp)
    1e9e:	ff 75 ac             	pushl  -0x54(%ebp)
    1ea1:	52                   	push   %edx
    1ea2:	50                   	push   %eax
    1ea3:	e8 61 f0 ff ff       	call   f09 <APSetPen>
    1ea8:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1eab:	8b 45 08             	mov    0x8(%ebp),%eax
    1eae:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1eb1:	8d 55 98             	lea    -0x68(%ebp),%edx
    1eb4:	83 ec 04             	sub    $0x4,%esp
    1eb7:	83 ec 04             	sub    $0x4,%esp
    1eba:	89 e0                	mov    %esp,%eax
    1ebc:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1ec0:	66 89 08             	mov    %cx,(%eax)
    1ec3:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1ec7:	88 48 02             	mov    %cl,0x2(%eax)
    1eca:	53                   	push   %ebx
    1ecb:	52                   	push   %edx
    1ecc:	e8 71 f0 ff ff       	call   f42 <APSetBrush>
    1ed1:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1ed4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ed7:	6b d0 32             	imul   $0x32,%eax,%edx
    1eda:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1edd:	6b c0 32             	imul   $0x32,%eax,%eax
    1ee0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ee3:	83 c1 3c             	add    $0x3c,%ecx
    1ee6:	83 ec 0c             	sub    $0xc,%esp
    1ee9:	6a 32                	push   $0x32
    1eeb:	6a 32                	push   $0x32
    1eed:	52                   	push   %edx
    1eee:	50                   	push   %eax
    1eef:	51                   	push   %ecx
    1ef0:	e8 35 f4 ff ff       	call   132a <APDrawRect>
    1ef5:	83 c4 20             	add    $0x20,%esp
                    break;
    1ef8:	e9 2f 02 00 00       	jmp    212c <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1efd:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1f00:	6a 0c                	push   $0xc
    1f02:	6a 0c                	push   $0xc
    1f04:	6a 0c                	push   $0xc
    1f06:	50                   	push   %eax
    1f07:	e8 cd f7 ff ff       	call   16d9 <RGB>
    1f0c:	83 c4 0c             	add    $0xc,%esp
    1f0f:	8b 1d 68 30 00 00    	mov    0x3068,%ebx
    1f15:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f18:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f1b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f1e:	6b c0 32             	imul   $0x32,%eax,%eax
    1f21:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f24:	8b 45 08             	mov    0x8(%ebp),%eax
    1f27:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f2a:	83 ec 0c             	sub    $0xc,%esp
    1f2d:	83 ec 04             	sub    $0x4,%esp
    1f30:	89 e0                	mov    %esp,%eax
    1f32:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1f36:	66 89 30             	mov    %si,(%eax)
    1f39:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1f3d:	88 50 02             	mov    %dl,0x2(%eax)
    1f40:	6a 32                	push   $0x32
    1f42:	6a 32                	push   $0x32
    1f44:	6a 00                	push   $0x0
    1f46:	6a 00                	push   $0x0
    1f48:	53                   	push   %ebx
    1f49:	51                   	push   %ecx
    1f4a:	ff 75 94             	pushl  -0x6c(%ebp)
    1f4d:	57                   	push   %edi
    1f4e:	e8 e2 f5 ff ff       	call   1535 <APDcCopy>
    1f53:	83 c4 30             	add    $0x30,%esp
                    break;
    1f56:	e9 d1 01 00 00       	jmp    212c <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f5b:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1f5e:	6a 0c                	push   $0xc
    1f60:	6a 0c                	push   $0xc
    1f62:	6a 0c                	push   $0xc
    1f64:	50                   	push   %eax
    1f65:	e8 6f f7 ff ff       	call   16d9 <RGB>
    1f6a:	83 c4 0c             	add    $0xc,%esp
    1f6d:	8b 1d 48 30 00 00    	mov    0x3048,%ebx
    1f73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f76:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f79:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f7c:	6b c0 32             	imul   $0x32,%eax,%eax
    1f7f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f82:	8b 45 08             	mov    0x8(%ebp),%eax
    1f85:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f88:	83 ec 0c             	sub    $0xc,%esp
    1f8b:	83 ec 04             	sub    $0x4,%esp
    1f8e:	89 e0                	mov    %esp,%eax
    1f90:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1f94:	66 89 30             	mov    %si,(%eax)
    1f97:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1f9b:	88 50 02             	mov    %dl,0x2(%eax)
    1f9e:	6a 32                	push   $0x32
    1fa0:	6a 32                	push   $0x32
    1fa2:	6a 00                	push   $0x0
    1fa4:	6a 00                	push   $0x0
    1fa6:	53                   	push   %ebx
    1fa7:	51                   	push   %ecx
    1fa8:	ff 75 94             	pushl  -0x6c(%ebp)
    1fab:	57                   	push   %edi
    1fac:	e8 84 f5 ff ff       	call   1535 <APDcCopy>
    1fb1:	83 c4 30             	add    $0x30,%esp
                    break;
    1fb4:	e9 73 01 00 00       	jmp    212c <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fb9:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1fbc:	6a 0c                	push   $0xc
    1fbe:	6a 0c                	push   $0xc
    1fc0:	6a 0c                	push   $0xc
    1fc2:	50                   	push   %eax
    1fc3:	e8 11 f7 ff ff       	call   16d9 <RGB>
    1fc8:	83 c4 0c             	add    $0xc,%esp
    1fcb:	8b 1d 2c 30 00 00    	mov    0x302c,%ebx
    1fd1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fd4:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fd7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fda:	6b c0 32             	imul   $0x32,%eax,%eax
    1fdd:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1fe0:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe3:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fe6:	83 ec 0c             	sub    $0xc,%esp
    1fe9:	83 ec 04             	sub    $0x4,%esp
    1fec:	89 e0                	mov    %esp,%eax
    1fee:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1ff2:	66 89 30             	mov    %si,(%eax)
    1ff5:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1ff9:	88 50 02             	mov    %dl,0x2(%eax)
    1ffc:	6a 32                	push   $0x32
    1ffe:	6a 32                	push   $0x32
    2000:	6a 00                	push   $0x0
    2002:	6a 00                	push   $0x0
    2004:	53                   	push   %ebx
    2005:	51                   	push   %ecx
    2006:	ff 75 94             	pushl  -0x6c(%ebp)
    2009:	57                   	push   %edi
    200a:	e8 26 f5 ff ff       	call   1535 <APDcCopy>
    200f:	83 c4 30             	add    $0x30,%esp
                    break;
    2012:	e9 15 01 00 00       	jmp    212c <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2017:	8d 45 cf             	lea    -0x31(%ebp),%eax
    201a:	6a 0c                	push   $0xc
    201c:	6a 0c                	push   $0xc
    201e:	6a 0c                	push   $0xc
    2020:	50                   	push   %eax
    2021:	e8 b3 f6 ff ff       	call   16d9 <RGB>
    2026:	83 c4 0c             	add    $0xc,%esp
    2029:	8b 1d 64 30 00 00    	mov    0x3064,%ebx
    202f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2032:	6b c8 32             	imul   $0x32,%eax,%ecx
    2035:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2038:	6b c0 32             	imul   $0x32,%eax,%eax
    203b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    203e:	8b 45 08             	mov    0x8(%ebp),%eax
    2041:	8d 78 3c             	lea    0x3c(%eax),%edi
    2044:	83 ec 0c             	sub    $0xc,%esp
    2047:	83 ec 04             	sub    $0x4,%esp
    204a:	89 e0                	mov    %esp,%eax
    204c:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2050:	66 89 30             	mov    %si,(%eax)
    2053:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2057:	88 50 02             	mov    %dl,0x2(%eax)
    205a:	6a 32                	push   $0x32
    205c:	6a 32                	push   $0x32
    205e:	6a 00                	push   $0x0
    2060:	6a 00                	push   $0x0
    2062:	53                   	push   %ebx
    2063:	51                   	push   %ecx
    2064:	ff 75 94             	pushl  -0x6c(%ebp)
    2067:	57                   	push   %edi
    2068:	e8 c8 f4 ff ff       	call   1535 <APDcCopy>
    206d:	83 c4 30             	add    $0x30,%esp
                    break;
    2070:	e9 b7 00 00 00       	jmp    212c <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2075:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2078:	6a 0c                	push   $0xc
    207a:	6a 0c                	push   $0xc
    207c:	6a 0c                	push   $0xc
    207e:	50                   	push   %eax
    207f:	e8 55 f6 ff ff       	call   16d9 <RGB>
    2084:	83 c4 0c             	add    $0xc,%esp
    2087:	8b 1d fc 2f 00 00    	mov    0x2ffc,%ebx
    208d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2090:	6b c8 32             	imul   $0x32,%eax,%ecx
    2093:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2096:	6b c0 32             	imul   $0x32,%eax,%eax
    2099:	89 45 94             	mov    %eax,-0x6c(%ebp)
    209c:	8b 45 08             	mov    0x8(%ebp),%eax
    209f:	8d 78 3c             	lea    0x3c(%eax),%edi
    20a2:	83 ec 0c             	sub    $0xc,%esp
    20a5:	83 ec 04             	sub    $0x4,%esp
    20a8:	89 e0                	mov    %esp,%eax
    20aa:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    20ae:	66 89 30             	mov    %si,(%eax)
    20b1:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    20b5:	88 50 02             	mov    %dl,0x2(%eax)
    20b8:	6a 32                	push   $0x32
    20ba:	6a 32                	push   $0x32
    20bc:	6a 00                	push   $0x0
    20be:	6a 00                	push   $0x0
    20c0:	53                   	push   %ebx
    20c1:	51                   	push   %ecx
    20c2:	ff 75 94             	pushl  -0x6c(%ebp)
    20c5:	57                   	push   %edi
    20c6:	e8 6a f4 ff ff       	call   1535 <APDcCopy>
    20cb:	83 c4 30             	add    $0x30,%esp
                    break;
    20ce:	eb 5c                	jmp    212c <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    20d0:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    20d3:	6a 0c                	push   $0xc
    20d5:	6a 0c                	push   $0xc
    20d7:	6a 0c                	push   $0xc
    20d9:	50                   	push   %eax
    20da:	e8 fa f5 ff ff       	call   16d9 <RGB>
    20df:	83 c4 0c             	add    $0xc,%esp
    20e2:	8b 1d 18 30 00 00    	mov    0x3018,%ebx
    20e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20eb:	6b c8 32             	imul   $0x32,%eax,%ecx
    20ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20f1:	6b c0 32             	imul   $0x32,%eax,%eax
    20f4:	89 45 94             	mov    %eax,-0x6c(%ebp)
    20f7:	8b 45 08             	mov    0x8(%ebp),%eax
    20fa:	8d 78 3c             	lea    0x3c(%eax),%edi
    20fd:	83 ec 0c             	sub    $0xc,%esp
    2100:	83 ec 04             	sub    $0x4,%esp
    2103:	89 e0                	mov    %esp,%eax
    2105:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2109:	66 89 30             	mov    %si,(%eax)
    210c:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2110:	88 50 02             	mov    %dl,0x2(%eax)
    2113:	6a 32                	push   $0x32
    2115:	6a 32                	push   $0x32
    2117:	6a 00                	push   $0x0
    2119:	6a 00                	push   $0x0
    211b:	53                   	push   %ebx
    211c:	51                   	push   %ecx
    211d:	ff 75 94             	pushl  -0x6c(%ebp)
    2120:	57                   	push   %edi
    2121:	e8 0f f4 ff ff       	call   1535 <APDcCopy>
    2126:	83 c4 30             	add    $0x30,%esp
                    break;
    2129:	eb 01                	jmp    212c <APGridPaint+0x639>
                default: break;
    212b:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    212c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2130:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2134:	0f 8e 7a fc ff ff    	jle    1db4 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    213a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    213e:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2142:	0f 8e 60 fc ff ff    	jle    1da8 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2148:	8d 45 98             	lea    -0x68(%ebp),%eax
    214b:	68 cd 00 00 00       	push   $0xcd
    2150:	6a 74                	push   $0x74
    2152:	6a 18                	push   $0x18
    2154:	50                   	push   %eax
    2155:	e8 7f f5 ff ff       	call   16d9 <RGB>
    215a:	83 c4 0c             	add    $0xc,%esp
    215d:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2161:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    2165:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2169:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    216c:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2173:	8d 45 98             	lea    -0x68(%ebp),%eax
    2176:	68 cd 00 00 00       	push   $0xcd
    217b:	6a 74                	push   $0x74
    217d:	6a 18                	push   $0x18
    217f:	50                   	push   %eax
    2180:	e8 54 f5 ff ff       	call   16d9 <RGB>
    2185:	83 c4 0c             	add    $0xc,%esp
    2188:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    218c:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    2190:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2194:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    2197:	8b 45 08             	mov    0x8(%ebp),%eax
    219a:	8d 50 58             	lea    0x58(%eax),%edx
    219d:	8d 45 98             	lea    -0x68(%ebp),%eax
    21a0:	ff 75 bc             	pushl  -0x44(%ebp)
    21a3:	ff 75 b8             	pushl  -0x48(%ebp)
    21a6:	52                   	push   %edx
    21a7:	50                   	push   %eax
    21a8:	e8 5c ed ff ff       	call   f09 <APSetPen>
    21ad:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    21b0:	8b 45 08             	mov    0x8(%ebp),%eax
    21b3:	8d 58 58             	lea    0x58(%eax),%ebx
    21b6:	8d 55 98             	lea    -0x68(%ebp),%edx
    21b9:	83 ec 04             	sub    $0x4,%esp
    21bc:	83 ec 04             	sub    $0x4,%esp
    21bf:	89 e0                	mov    %esp,%eax
    21c1:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    21c5:	66 89 08             	mov    %cx,(%eax)
    21c8:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    21cc:	88 48 02             	mov    %cl,0x2(%eax)
    21cf:	53                   	push   %ebx
    21d0:	52                   	push   %edx
    21d1:	e8 6c ed ff ff       	call   f42 <APSetBrush>
    21d6:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    21d9:	8b 45 08             	mov    0x8(%ebp),%eax
    21dc:	83 c0 58             	add    $0x58,%eax
    21df:	83 ec 0c             	sub    $0xc,%esp
    21e2:	6a 32                	push   $0x32
    21e4:	68 20 03 00 00       	push   $0x320
    21e9:	6a 00                	push   $0x0
    21eb:	6a 00                	push   $0x0
    21ed:	50                   	push   %eax
    21ee:	e8 37 f1 ff ff       	call   132a <APDrawRect>
    21f3:	83 c4 20             	add    $0x20,%esp
}
    21f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    21f9:	5b                   	pop    %ebx
    21fa:	5e                   	pop    %esi
    21fb:	5f                   	pop    %edi
    21fc:	5d                   	pop    %ebp
    21fd:	c3                   	ret    

000021fe <random>:
//

#include "APLib.h"

int random(int seed)
{
    21fe:	55                   	push   %ebp
    21ff:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2201:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2205:	7e 08                	jle    220f <random+0x11>
{
rand_num = seed;
    2207:	8b 45 08             	mov    0x8(%ebp),%eax
    220a:	a3 d4 2f 00 00       	mov    %eax,0x2fd4
}
rand_num *= 3;
    220f:	8b 15 d4 2f 00 00    	mov    0x2fd4,%edx
    2215:	89 d0                	mov    %edx,%eax
    2217:	01 c0                	add    %eax,%eax
    2219:	01 d0                	add    %edx,%eax
    221b:	a3 d4 2f 00 00       	mov    %eax,0x2fd4
if (rand_num < 0)
    2220:	a1 d4 2f 00 00       	mov    0x2fd4,%eax
    2225:	85 c0                	test   %eax,%eax
    2227:	79 0c                	jns    2235 <random+0x37>
{
rand_num *= (-1);
    2229:	a1 d4 2f 00 00       	mov    0x2fd4,%eax
    222e:	f7 d8                	neg    %eax
    2230:	a3 d4 2f 00 00       	mov    %eax,0x2fd4
}
return rand_num % 997;
    2235:	8b 0d d4 2f 00 00    	mov    0x2fd4,%ecx
    223b:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2240:	89 c8                	mov    %ecx,%eax
    2242:	f7 ea                	imul   %edx
    2244:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2247:	c1 f8 09             	sar    $0x9,%eax
    224a:	89 c2                	mov    %eax,%edx
    224c:	89 c8                	mov    %ecx,%eax
    224e:	c1 f8 1f             	sar    $0x1f,%eax
    2251:	29 c2                	sub    %eax,%edx
    2253:	89 d0                	mov    %edx,%eax
    2255:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    225b:	29 c1                	sub    %eax,%ecx
    225d:	89 c8                	mov    %ecx,%eax
}
    225f:	5d                   	pop    %ebp
    2260:	c3                   	ret    

00002261 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2261:	55                   	push   %ebp
    2262:	89 e5                	mov    %esp,%ebp
    2264:	53                   	push   %ebx
    2265:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2268:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    226f:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2273:	74 17                	je     228c <sprintint+0x2b>
    2275:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2279:	79 11                	jns    228c <sprintint+0x2b>
        neg = 1;
    227b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2282:	8b 45 10             	mov    0x10(%ebp),%eax
    2285:	f7 d8                	neg    %eax
    2287:	89 45 f0             	mov    %eax,-0x10(%ebp)
    228a:	eb 06                	jmp    2292 <sprintint+0x31>
    } else {
        x = xx;
    228c:	8b 45 10             	mov    0x10(%ebp),%eax
    228f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2292:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2299:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    229c:	8d 41 01             	lea    0x1(%ecx),%eax
    229f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    22a2:	8b 5d 14             	mov    0x14(%ebp),%ebx
    22a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22a8:	ba 00 00 00 00       	mov    $0x0,%edx
    22ad:	f7 f3                	div    %ebx
    22af:	89 d0                	mov    %edx,%eax
    22b1:	0f b6 80 d8 2f 00 00 	movzbl 0x2fd8(%eax),%eax
    22b8:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    22bc:	8b 5d 14             	mov    0x14(%ebp),%ebx
    22bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22c2:	ba 00 00 00 00       	mov    $0x0,%edx
    22c7:	f7 f3                	div    %ebx
    22c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    22cc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    22d0:	75 c7                	jne    2299 <sprintint+0x38>
    if(neg)
    22d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    22d6:	74 0e                	je     22e6 <sprintint+0x85>
        buf[i++] = '-';
    22d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22db:	8d 50 01             	lea    0x1(%eax),%edx
    22de:	89 55 f8             	mov    %edx,-0x8(%ebp)
    22e1:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    22e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22e9:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    22ec:	eb 1b                	jmp    2309 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    22ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    22f1:	8b 00                	mov    (%eax),%eax
    22f3:	8d 48 01             	lea    0x1(%eax),%ecx
    22f6:	8b 55 0c             	mov    0xc(%ebp),%edx
    22f9:	89 0a                	mov    %ecx,(%edx)
    22fb:	89 c2                	mov    %eax,%edx
    22fd:	8b 45 08             	mov    0x8(%ebp),%eax
    2300:	01 d0                	add    %edx,%eax
    2302:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2305:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2309:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    230d:	7f df                	jg     22ee <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    230f:	eb 21                	jmp    2332 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2311:	8b 45 0c             	mov    0xc(%ebp),%eax
    2314:	8b 00                	mov    (%eax),%eax
    2316:	8d 48 01             	lea    0x1(%eax),%ecx
    2319:	8b 55 0c             	mov    0xc(%ebp),%edx
    231c:	89 0a                	mov    %ecx,(%edx)
    231e:	89 c2                	mov    %eax,%edx
    2320:	8b 45 08             	mov    0x8(%ebp),%eax
    2323:	01 c2                	add    %eax,%edx
    2325:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2328:	8b 45 f8             	mov    -0x8(%ebp),%eax
    232b:	01 c8                	add    %ecx,%eax
    232d:	0f b6 00             	movzbl (%eax),%eax
    2330:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2332:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2336:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    233a:	79 d5                	jns    2311 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    233c:	90                   	nop
    233d:	83 c4 20             	add    $0x20,%esp
    2340:	5b                   	pop    %ebx
    2341:	5d                   	pop    %ebp
    2342:	c3                   	ret    

00002343 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2343:	55                   	push   %ebp
    2344:	89 e5                	mov    %esp,%ebp
    2346:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2349:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2350:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2357:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    235e:	8d 45 0c             	lea    0xc(%ebp),%eax
    2361:	83 c0 04             	add    $0x4,%eax
    2364:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2367:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    236e:	e9 d9 01 00 00       	jmp    254c <sprintf+0x209>
        c = fmt[i] & 0xff;
    2373:	8b 55 0c             	mov    0xc(%ebp),%edx
    2376:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2379:	01 d0                	add    %edx,%eax
    237b:	0f b6 00             	movzbl (%eax),%eax
    237e:	0f be c0             	movsbl %al,%eax
    2381:	25 ff 00 00 00       	and    $0xff,%eax
    2386:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2389:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    238d:	75 2c                	jne    23bb <sprintf+0x78>
            if(c == '%'){
    238f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2393:	75 0c                	jne    23a1 <sprintf+0x5e>
                state = '%';
    2395:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    239c:	e9 a7 01 00 00       	jmp    2548 <sprintf+0x205>
            } else {
                dst[j++] = c;
    23a1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23a4:	8d 50 01             	lea    0x1(%eax),%edx
    23a7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23aa:	89 c2                	mov    %eax,%edx
    23ac:	8b 45 08             	mov    0x8(%ebp),%eax
    23af:	01 d0                	add    %edx,%eax
    23b1:	8b 55 e0             	mov    -0x20(%ebp),%edx
    23b4:	88 10                	mov    %dl,(%eax)
    23b6:	e9 8d 01 00 00       	jmp    2548 <sprintf+0x205>
            }
        } else if(state == '%'){
    23bb:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    23bf:	0f 85 83 01 00 00    	jne    2548 <sprintf+0x205>
            if(c == 'd'){
    23c5:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    23c9:	75 4c                	jne    2417 <sprintf+0xd4>
                buf[bi] = '\0';
    23cb:	8d 55 ce             	lea    -0x32(%ebp),%edx
    23ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23d1:	01 d0                	add    %edx,%eax
    23d3:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    23d6:	83 ec 0c             	sub    $0xc,%esp
    23d9:	8d 45 ce             	lea    -0x32(%ebp),%eax
    23dc:	50                   	push   %eax
    23dd:	e8 a1 e1 ff ff       	call   583 <atoi>
    23e2:	83 c4 10             	add    $0x10,%esp
    23e5:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    23e8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    23ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23f2:	8b 00                	mov    (%eax),%eax
    23f4:	83 ec 08             	sub    $0x8,%esp
    23f7:	ff 75 d8             	pushl  -0x28(%ebp)
    23fa:	6a 01                	push   $0x1
    23fc:	6a 0a                	push   $0xa
    23fe:	50                   	push   %eax
    23ff:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2402:	50                   	push   %eax
    2403:	ff 75 08             	pushl  0x8(%ebp)
    2406:	e8 56 fe ff ff       	call   2261 <sprintint>
    240b:	83 c4 20             	add    $0x20,%esp
                ap++;
    240e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2412:	e9 2a 01 00 00       	jmp    2541 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2417:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    241b:	74 06                	je     2423 <sprintf+0xe0>
    241d:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2421:	75 4c                	jne    246f <sprintf+0x12c>
                buf[bi] = '\0';
    2423:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2426:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2429:	01 d0                	add    %edx,%eax
    242b:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    242e:	83 ec 0c             	sub    $0xc,%esp
    2431:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2434:	50                   	push   %eax
    2435:	e8 49 e1 ff ff       	call   583 <atoi>
    243a:	83 c4 10             	add    $0x10,%esp
    243d:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2440:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2447:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    244a:	8b 00                	mov    (%eax),%eax
    244c:	83 ec 08             	sub    $0x8,%esp
    244f:	ff 75 dc             	pushl  -0x24(%ebp)
    2452:	6a 00                	push   $0x0
    2454:	6a 10                	push   $0x10
    2456:	50                   	push   %eax
    2457:	8d 45 c8             	lea    -0x38(%ebp),%eax
    245a:	50                   	push   %eax
    245b:	ff 75 08             	pushl  0x8(%ebp)
    245e:	e8 fe fd ff ff       	call   2261 <sprintint>
    2463:	83 c4 20             	add    $0x20,%esp
                ap++;
    2466:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    246a:	e9 d2 00 00 00       	jmp    2541 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    246f:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2473:	75 46                	jne    24bb <sprintf+0x178>
                s = (char*)*ap;
    2475:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2478:	8b 00                	mov    (%eax),%eax
    247a:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    247d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2481:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2485:	75 25                	jne    24ac <sprintf+0x169>
                    s = "(null)";
    2487:	c7 45 f4 34 27 00 00 	movl   $0x2734,-0xc(%ebp)
                while(*s != 0){
    248e:	eb 1c                	jmp    24ac <sprintf+0x169>
                    dst[j++] = *s;
    2490:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2493:	8d 50 01             	lea    0x1(%eax),%edx
    2496:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2499:	89 c2                	mov    %eax,%edx
    249b:	8b 45 08             	mov    0x8(%ebp),%eax
    249e:	01 c2                	add    %eax,%edx
    24a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24a3:	0f b6 00             	movzbl (%eax),%eax
    24a6:	88 02                	mov    %al,(%edx)
                    s++;
    24a8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    24ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24af:	0f b6 00             	movzbl (%eax),%eax
    24b2:	84 c0                	test   %al,%al
    24b4:	75 da                	jne    2490 <sprintf+0x14d>
    24b6:	e9 86 00 00 00       	jmp    2541 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    24bb:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    24bf:	75 1d                	jne    24de <sprintf+0x19b>
                dst[j++] = *ap;
    24c1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24c4:	8d 50 01             	lea    0x1(%eax),%edx
    24c7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24ca:	89 c2                	mov    %eax,%edx
    24cc:	8b 45 08             	mov    0x8(%ebp),%eax
    24cf:	01 c2                	add    %eax,%edx
    24d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24d4:	8b 00                	mov    (%eax),%eax
    24d6:	88 02                	mov    %al,(%edx)
                ap++;
    24d8:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    24dc:	eb 63                	jmp    2541 <sprintf+0x1fe>
            } else if(c == '%'){
    24de:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    24e2:	75 17                	jne    24fb <sprintf+0x1b8>
                dst[j++] = c;
    24e4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24e7:	8d 50 01             	lea    0x1(%eax),%edx
    24ea:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24ed:	89 c2                	mov    %eax,%edx
    24ef:	8b 45 08             	mov    0x8(%ebp),%eax
    24f2:	01 d0                	add    %edx,%eax
    24f4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24f7:	88 10                	mov    %dl,(%eax)
    24f9:	eb 46                	jmp    2541 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    24fb:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    24ff:	7e 18                	jle    2519 <sprintf+0x1d6>
    2501:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2505:	7f 12                	jg     2519 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2507:	8b 45 f0             	mov    -0x10(%ebp),%eax
    250a:	8d 50 01             	lea    0x1(%eax),%edx
    250d:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2510:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2513:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2517:	eb 2f                	jmp    2548 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2519:	8b 45 c8             	mov    -0x38(%ebp),%eax
    251c:	8d 50 01             	lea    0x1(%eax),%edx
    251f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2522:	89 c2                	mov    %eax,%edx
    2524:	8b 45 08             	mov    0x8(%ebp),%eax
    2527:	01 d0                	add    %edx,%eax
    2529:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    252c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    252f:	8d 50 01             	lea    0x1(%eax),%edx
    2532:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2535:	89 c2                	mov    %eax,%edx
    2537:	8b 45 08             	mov    0x8(%ebp),%eax
    253a:	01 d0                	add    %edx,%eax
    253c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    253f:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2541:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2548:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    254c:	8b 55 0c             	mov    0xc(%ebp),%edx
    254f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2552:	01 d0                	add    %edx,%eax
    2554:	0f b6 00             	movzbl (%eax),%eax
    2557:	84 c0                	test   %al,%al
    2559:	0f 85 14 fe ff ff    	jne    2373 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    255f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2562:	8d 50 01             	lea    0x1(%eax),%edx
    2565:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2568:	89 c2                	mov    %eax,%edx
    256a:	8b 45 08             	mov    0x8(%ebp),%eax
    256d:	01 d0                	add    %edx,%eax
    256f:	c6 00 00             	movb   $0x0,(%eax)
}
    2572:	90                   	nop
    2573:	c9                   	leave  
    2574:	c3                   	ret    
