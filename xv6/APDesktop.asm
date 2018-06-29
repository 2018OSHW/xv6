
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
       6:	e8 d0 05 00 00       	call   5db <fork>
       b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    char temp[30];
    if (pid == 0)
       e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      12:	75 37                	jne    4b <runApp+0x4b>
    {
        sprintf(temp, "AP%s", (char *)param);
      14:	83 ec 04             	sub    $0x4,%esp
      17:	ff 75 08             	pushl  0x8(%ebp)
      1a:	68 54 25 00 00       	push   $0x2554
      1f:	8d 45 d6             	lea    -0x2a(%ebp),%eax
      22:	50                   	push   %eax
      23:	e8 f9 22 00 00       	call   2321 <sprintf>
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
      43:	e8 d3 05 00 00       	call   61b <exec>
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
      ae:	8b 04 85 c0 2c 00 00 	mov    0x2cc0(,%eax,4),%eax
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
      f2:	e8 05 16 00 00       	call   16fc <APSendMessage>
      f7:	83 c4 10             	add    $0x10,%esp
            return False;
      fa:	b8 00 00 00 00       	mov    $0x0,%eax
      ff:	e9 c5 01 00 00       	jmp    2c9 <wndProc+0x27b>
        case MSG_PAINT:
            APGridPaint(hwnd);
     104:	83 ec 0c             	sub    $0xc,%esp
     107:	ff 75 08             	pushl  0x8(%ebp)
     10a:	e8 c2 19 00 00       	call   1ad1 <APGridPaint>
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
     199:	e8 05 05 00 00       	call   6a3 <changePosition>
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
     1f5:	e8 a9 04 00 00       	call   6a3 <changePosition>
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
     251:	e8 4d 04 00 00       	call   6a3 <changePosition>
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
     2ab:	e8 f3 03 00 00       	call   6a3 <changePosition>
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
     2c1:	e8 ba 16 00 00       	call   1980 <APWndProc>
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
     317:	8b 04 85 5c 25 00 00 	mov    0x255c(,%eax,4),%eax
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
     374:	83 ec 04             	sub    $0x4,%esp
    runApp("Snack");
     377:	83 ec 0c             	sub    $0xc,%esp
     37a:	68 7c 25 00 00       	push   $0x257c
     37f:	e8 7c fc ff ff       	call   0 <runApp>
     384:	83 c4 10             	add    $0x10,%esp
   // AHwnd r = APCreateWindow("desktop",True,3);
  //  AHwnd hwnd = r;
  //  printf(1,"desktop initialized!\n");
  //  APWndExec(hwnd, wndProc);
    exit();
     387:	e8 57 02 00 00       	call   5e3 <exit>

0000038c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     38c:	55                   	push   %ebp
     38d:	89 e5                	mov    %esp,%ebp
     38f:	57                   	push   %edi
     390:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     391:	8b 4d 08             	mov    0x8(%ebp),%ecx
     394:	8b 55 10             	mov    0x10(%ebp),%edx
     397:	8b 45 0c             	mov    0xc(%ebp),%eax
     39a:	89 cb                	mov    %ecx,%ebx
     39c:	89 df                	mov    %ebx,%edi
     39e:	89 d1                	mov    %edx,%ecx
     3a0:	fc                   	cld    
     3a1:	f3 aa                	rep stos %al,%es:(%edi)
     3a3:	89 ca                	mov    %ecx,%edx
     3a5:	89 fb                	mov    %edi,%ebx
     3a7:	89 5d 08             	mov    %ebx,0x8(%ebp)
     3aa:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     3ad:	90                   	nop
     3ae:	5b                   	pop    %ebx
     3af:	5f                   	pop    %edi
     3b0:	5d                   	pop    %ebp
     3b1:	c3                   	ret    

000003b2 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     3b2:	55                   	push   %ebp
     3b3:	89 e5                	mov    %esp,%ebp
     3b5:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     3b8:	8b 45 08             	mov    0x8(%ebp),%eax
     3bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     3be:	90                   	nop
     3bf:	8b 45 08             	mov    0x8(%ebp),%eax
     3c2:	8d 50 01             	lea    0x1(%eax),%edx
     3c5:	89 55 08             	mov    %edx,0x8(%ebp)
     3c8:	8b 55 0c             	mov    0xc(%ebp),%edx
     3cb:	8d 4a 01             	lea    0x1(%edx),%ecx
     3ce:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     3d1:	0f b6 12             	movzbl (%edx),%edx
     3d4:	88 10                	mov    %dl,(%eax)
     3d6:	0f b6 00             	movzbl (%eax),%eax
     3d9:	84 c0                	test   %al,%al
     3db:	75 e2                	jne    3bf <strcpy+0xd>
    ;
  return os;
     3dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     3e0:	c9                   	leave  
     3e1:	c3                   	ret    

000003e2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     3e2:	55                   	push   %ebp
     3e3:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     3e5:	eb 08                	jmp    3ef <strcmp+0xd>
    p++, q++;
     3e7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     3eb:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     3ef:	8b 45 08             	mov    0x8(%ebp),%eax
     3f2:	0f b6 00             	movzbl (%eax),%eax
     3f5:	84 c0                	test   %al,%al
     3f7:	74 10                	je     409 <strcmp+0x27>
     3f9:	8b 45 08             	mov    0x8(%ebp),%eax
     3fc:	0f b6 10             	movzbl (%eax),%edx
     3ff:	8b 45 0c             	mov    0xc(%ebp),%eax
     402:	0f b6 00             	movzbl (%eax),%eax
     405:	38 c2                	cmp    %al,%dl
     407:	74 de                	je     3e7 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     409:	8b 45 08             	mov    0x8(%ebp),%eax
     40c:	0f b6 00             	movzbl (%eax),%eax
     40f:	0f b6 d0             	movzbl %al,%edx
     412:	8b 45 0c             	mov    0xc(%ebp),%eax
     415:	0f b6 00             	movzbl (%eax),%eax
     418:	0f b6 c0             	movzbl %al,%eax
     41b:	29 c2                	sub    %eax,%edx
     41d:	89 d0                	mov    %edx,%eax
}
     41f:	5d                   	pop    %ebp
     420:	c3                   	ret    

00000421 <strlen>:

uint
strlen(char *s)
{
     421:	55                   	push   %ebp
     422:	89 e5                	mov    %esp,%ebp
     424:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     427:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     42e:	eb 04                	jmp    434 <strlen+0x13>
     430:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     434:	8b 55 fc             	mov    -0x4(%ebp),%edx
     437:	8b 45 08             	mov    0x8(%ebp),%eax
     43a:	01 d0                	add    %edx,%eax
     43c:	0f b6 00             	movzbl (%eax),%eax
     43f:	84 c0                	test   %al,%al
     441:	75 ed                	jne    430 <strlen+0xf>
    ;
  return n;
     443:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     446:	c9                   	leave  
     447:	c3                   	ret    

00000448 <memset>:

void*
memset(void *dst, int c, uint n)
{
     448:	55                   	push   %ebp
     449:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     44b:	8b 45 10             	mov    0x10(%ebp),%eax
     44e:	50                   	push   %eax
     44f:	ff 75 0c             	pushl  0xc(%ebp)
     452:	ff 75 08             	pushl  0x8(%ebp)
     455:	e8 32 ff ff ff       	call   38c <stosb>
     45a:	83 c4 0c             	add    $0xc,%esp
  return dst;
     45d:	8b 45 08             	mov    0x8(%ebp),%eax
}
     460:	c9                   	leave  
     461:	c3                   	ret    

00000462 <strchr>:

char*
strchr(const char *s, char c)
{
     462:	55                   	push   %ebp
     463:	89 e5                	mov    %esp,%ebp
     465:	83 ec 04             	sub    $0x4,%esp
     468:	8b 45 0c             	mov    0xc(%ebp),%eax
     46b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     46e:	eb 14                	jmp    484 <strchr+0x22>
    if(*s == c)
     470:	8b 45 08             	mov    0x8(%ebp),%eax
     473:	0f b6 00             	movzbl (%eax),%eax
     476:	3a 45 fc             	cmp    -0x4(%ebp),%al
     479:	75 05                	jne    480 <strchr+0x1e>
      return (char*)s;
     47b:	8b 45 08             	mov    0x8(%ebp),%eax
     47e:	eb 13                	jmp    493 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     480:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     484:	8b 45 08             	mov    0x8(%ebp),%eax
     487:	0f b6 00             	movzbl (%eax),%eax
     48a:	84 c0                	test   %al,%al
     48c:	75 e2                	jne    470 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     48e:	b8 00 00 00 00       	mov    $0x0,%eax
}
     493:	c9                   	leave  
     494:	c3                   	ret    

00000495 <gets>:

char*
gets(char *buf, int max)
{
     495:	55                   	push   %ebp
     496:	89 e5                	mov    %esp,%ebp
     498:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     49b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4a2:	eb 42                	jmp    4e6 <gets+0x51>
    cc = read(0, &c, 1);
     4a4:	83 ec 04             	sub    $0x4,%esp
     4a7:	6a 01                	push   $0x1
     4a9:	8d 45 ef             	lea    -0x11(%ebp),%eax
     4ac:	50                   	push   %eax
     4ad:	6a 00                	push   $0x0
     4af:	e8 47 01 00 00       	call   5fb <read>
     4b4:	83 c4 10             	add    $0x10,%esp
     4b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     4ba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4be:	7e 33                	jle    4f3 <gets+0x5e>
      break;
    buf[i++] = c;
     4c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4c3:	8d 50 01             	lea    0x1(%eax),%edx
     4c6:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4c9:	89 c2                	mov    %eax,%edx
     4cb:	8b 45 08             	mov    0x8(%ebp),%eax
     4ce:	01 c2                	add    %eax,%edx
     4d0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4d4:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     4d6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4da:	3c 0a                	cmp    $0xa,%al
     4dc:	74 16                	je     4f4 <gets+0x5f>
     4de:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4e2:	3c 0d                	cmp    $0xd,%al
     4e4:	74 0e                	je     4f4 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     4e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4e9:	83 c0 01             	add    $0x1,%eax
     4ec:	3b 45 0c             	cmp    0xc(%ebp),%eax
     4ef:	7c b3                	jl     4a4 <gets+0xf>
     4f1:	eb 01                	jmp    4f4 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     4f3:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     4f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
     4f7:	8b 45 08             	mov    0x8(%ebp),%eax
     4fa:	01 d0                	add    %edx,%eax
     4fc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     4ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
     502:	c9                   	leave  
     503:	c3                   	ret    

00000504 <stat>:

int
stat(char *n, struct stat *st)
{
     504:	55                   	push   %ebp
     505:	89 e5                	mov    %esp,%ebp
     507:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     50a:	83 ec 08             	sub    $0x8,%esp
     50d:	6a 00                	push   $0x0
     50f:	ff 75 08             	pushl  0x8(%ebp)
     512:	e8 0c 01 00 00       	call   623 <open>
     517:	83 c4 10             	add    $0x10,%esp
     51a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     51d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     521:	79 07                	jns    52a <stat+0x26>
    return -1;
     523:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     528:	eb 25                	jmp    54f <stat+0x4b>
  r = fstat(fd, st);
     52a:	83 ec 08             	sub    $0x8,%esp
     52d:	ff 75 0c             	pushl  0xc(%ebp)
     530:	ff 75 f4             	pushl  -0xc(%ebp)
     533:	e8 03 01 00 00       	call   63b <fstat>
     538:	83 c4 10             	add    $0x10,%esp
     53b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     53e:	83 ec 0c             	sub    $0xc,%esp
     541:	ff 75 f4             	pushl  -0xc(%ebp)
     544:	e8 c2 00 00 00       	call   60b <close>
     549:	83 c4 10             	add    $0x10,%esp
  return r;
     54c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     54f:	c9                   	leave  
     550:	c3                   	ret    

00000551 <atoi>:

int
atoi(const char *s)
{
     551:	55                   	push   %ebp
     552:	89 e5                	mov    %esp,%ebp
     554:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     557:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     55e:	eb 25                	jmp    585 <atoi+0x34>
    n = n*10 + *s++ - '0';
     560:	8b 55 fc             	mov    -0x4(%ebp),%edx
     563:	89 d0                	mov    %edx,%eax
     565:	c1 e0 02             	shl    $0x2,%eax
     568:	01 d0                	add    %edx,%eax
     56a:	01 c0                	add    %eax,%eax
     56c:	89 c1                	mov    %eax,%ecx
     56e:	8b 45 08             	mov    0x8(%ebp),%eax
     571:	8d 50 01             	lea    0x1(%eax),%edx
     574:	89 55 08             	mov    %edx,0x8(%ebp)
     577:	0f b6 00             	movzbl (%eax),%eax
     57a:	0f be c0             	movsbl %al,%eax
     57d:	01 c8                	add    %ecx,%eax
     57f:	83 e8 30             	sub    $0x30,%eax
     582:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     585:	8b 45 08             	mov    0x8(%ebp),%eax
     588:	0f b6 00             	movzbl (%eax),%eax
     58b:	3c 2f                	cmp    $0x2f,%al
     58d:	7e 0a                	jle    599 <atoi+0x48>
     58f:	8b 45 08             	mov    0x8(%ebp),%eax
     592:	0f b6 00             	movzbl (%eax),%eax
     595:	3c 39                	cmp    $0x39,%al
     597:	7e c7                	jle    560 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     599:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     59c:	c9                   	leave  
     59d:	c3                   	ret    

0000059e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     59e:	55                   	push   %ebp
     59f:	89 e5                	mov    %esp,%ebp
     5a1:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     5a4:	8b 45 08             	mov    0x8(%ebp),%eax
     5a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     5aa:	8b 45 0c             	mov    0xc(%ebp),%eax
     5ad:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     5b0:	eb 17                	jmp    5c9 <memmove+0x2b>
    *dst++ = *src++;
     5b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5b5:	8d 50 01             	lea    0x1(%eax),%edx
     5b8:	89 55 fc             	mov    %edx,-0x4(%ebp)
     5bb:	8b 55 f8             	mov    -0x8(%ebp),%edx
     5be:	8d 4a 01             	lea    0x1(%edx),%ecx
     5c1:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     5c4:	0f b6 12             	movzbl (%edx),%edx
     5c7:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     5c9:	8b 45 10             	mov    0x10(%ebp),%eax
     5cc:	8d 50 ff             	lea    -0x1(%eax),%edx
     5cf:	89 55 10             	mov    %edx,0x10(%ebp)
     5d2:	85 c0                	test   %eax,%eax
     5d4:	7f dc                	jg     5b2 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     5d6:	8b 45 08             	mov    0x8(%ebp),%eax
}
     5d9:	c9                   	leave  
     5da:	c3                   	ret    

000005db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     5db:	b8 01 00 00 00       	mov    $0x1,%eax
     5e0:	cd 40                	int    $0x40
     5e2:	c3                   	ret    

000005e3 <exit>:
SYSCALL(exit)
     5e3:	b8 02 00 00 00       	mov    $0x2,%eax
     5e8:	cd 40                	int    $0x40
     5ea:	c3                   	ret    

000005eb <wait>:
SYSCALL(wait)
     5eb:	b8 03 00 00 00       	mov    $0x3,%eax
     5f0:	cd 40                	int    $0x40
     5f2:	c3                   	ret    

000005f3 <pipe>:
SYSCALL(pipe)
     5f3:	b8 04 00 00 00       	mov    $0x4,%eax
     5f8:	cd 40                	int    $0x40
     5fa:	c3                   	ret    

000005fb <read>:
SYSCALL(read)
     5fb:	b8 05 00 00 00       	mov    $0x5,%eax
     600:	cd 40                	int    $0x40
     602:	c3                   	ret    

00000603 <write>:
SYSCALL(write)
     603:	b8 10 00 00 00       	mov    $0x10,%eax
     608:	cd 40                	int    $0x40
     60a:	c3                   	ret    

0000060b <close>:
SYSCALL(close)
     60b:	b8 15 00 00 00       	mov    $0x15,%eax
     610:	cd 40                	int    $0x40
     612:	c3                   	ret    

00000613 <kill>:
SYSCALL(kill)
     613:	b8 06 00 00 00       	mov    $0x6,%eax
     618:	cd 40                	int    $0x40
     61a:	c3                   	ret    

0000061b <exec>:
SYSCALL(exec)
     61b:	b8 07 00 00 00       	mov    $0x7,%eax
     620:	cd 40                	int    $0x40
     622:	c3                   	ret    

00000623 <open>:
SYSCALL(open)
     623:	b8 0f 00 00 00       	mov    $0xf,%eax
     628:	cd 40                	int    $0x40
     62a:	c3                   	ret    

0000062b <mknod>:
SYSCALL(mknod)
     62b:	b8 11 00 00 00       	mov    $0x11,%eax
     630:	cd 40                	int    $0x40
     632:	c3                   	ret    

00000633 <unlink>:
SYSCALL(unlink)
     633:	b8 12 00 00 00       	mov    $0x12,%eax
     638:	cd 40                	int    $0x40
     63a:	c3                   	ret    

0000063b <fstat>:
SYSCALL(fstat)
     63b:	b8 08 00 00 00       	mov    $0x8,%eax
     640:	cd 40                	int    $0x40
     642:	c3                   	ret    

00000643 <link>:
SYSCALL(link)
     643:	b8 13 00 00 00       	mov    $0x13,%eax
     648:	cd 40                	int    $0x40
     64a:	c3                   	ret    

0000064b <mkdir>:
SYSCALL(mkdir)
     64b:	b8 14 00 00 00       	mov    $0x14,%eax
     650:	cd 40                	int    $0x40
     652:	c3                   	ret    

00000653 <chdir>:
SYSCALL(chdir)
     653:	b8 09 00 00 00       	mov    $0x9,%eax
     658:	cd 40                	int    $0x40
     65a:	c3                   	ret    

0000065b <dup>:
SYSCALL(dup)
     65b:	b8 0a 00 00 00       	mov    $0xa,%eax
     660:	cd 40                	int    $0x40
     662:	c3                   	ret    

00000663 <getpid>:
SYSCALL(getpid)
     663:	b8 0b 00 00 00       	mov    $0xb,%eax
     668:	cd 40                	int    $0x40
     66a:	c3                   	ret    

0000066b <sbrk>:
SYSCALL(sbrk)
     66b:	b8 0c 00 00 00       	mov    $0xc,%eax
     670:	cd 40                	int    $0x40
     672:	c3                   	ret    

00000673 <sleep>:
SYSCALL(sleep)
     673:	b8 0d 00 00 00       	mov    $0xd,%eax
     678:	cd 40                	int    $0x40
     67a:	c3                   	ret    

0000067b <uptime>:
SYSCALL(uptime)
     67b:	b8 0e 00 00 00       	mov    $0xe,%eax
     680:	cd 40                	int    $0x40
     682:	c3                   	ret    

00000683 <paintWindow>:

SYSCALL(paintWindow)
     683:	b8 16 00 00 00       	mov    $0x16,%eax
     688:	cd 40                	int    $0x40
     68a:	c3                   	ret    

0000068b <sendMessage>:
SYSCALL(sendMessage)
     68b:	b8 17 00 00 00       	mov    $0x17,%eax
     690:	cd 40                	int    $0x40
     692:	c3                   	ret    

00000693 <getMessage>:
SYSCALL(getMessage)
     693:	b8 19 00 00 00       	mov    $0x19,%eax
     698:	cd 40                	int    $0x40
     69a:	c3                   	ret    

0000069b <registWindow>:
SYSCALL(registWindow)
     69b:	b8 18 00 00 00       	mov    $0x18,%eax
     6a0:	cd 40                	int    $0x40
     6a2:	c3                   	ret    

000006a3 <changePosition>:
SYSCALL(changePosition)
     6a3:	b8 1a 00 00 00       	mov    $0x1a,%eax
     6a8:	cd 40                	int    $0x40
     6aa:	c3                   	ret    

000006ab <setupTimer>:
SYSCALL(setupTimer)
     6ab:	b8 1b 00 00 00       	mov    $0x1b,%eax
     6b0:	cd 40                	int    $0x40
     6b2:	c3                   	ret    

000006b3 <deleteTimer>:
SYSCALL(deleteTimer)
     6b3:	b8 1c 00 00 00       	mov    $0x1c,%eax
     6b8:	cd 40                	int    $0x40
     6ba:	c3                   	ret    

000006bb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     6bb:	55                   	push   %ebp
     6bc:	89 e5                	mov    %esp,%ebp
     6be:	83 ec 18             	sub    $0x18,%esp
     6c1:	8b 45 0c             	mov    0xc(%ebp),%eax
     6c4:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     6c7:	83 ec 04             	sub    $0x4,%esp
     6ca:	6a 01                	push   $0x1
     6cc:	8d 45 f4             	lea    -0xc(%ebp),%eax
     6cf:	50                   	push   %eax
     6d0:	ff 75 08             	pushl  0x8(%ebp)
     6d3:	e8 2b ff ff ff       	call   603 <write>
     6d8:	83 c4 10             	add    $0x10,%esp
}
     6db:	90                   	nop
     6dc:	c9                   	leave  
     6dd:	c3                   	ret    

000006de <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     6de:	55                   	push   %ebp
     6df:	89 e5                	mov    %esp,%ebp
     6e1:	53                   	push   %ebx
     6e2:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     6e5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     6ec:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     6f0:	74 17                	je     709 <printint+0x2b>
     6f2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6f6:	79 11                	jns    709 <printint+0x2b>
    neg = 1;
     6f8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     6ff:	8b 45 0c             	mov    0xc(%ebp),%eax
     702:	f7 d8                	neg    %eax
     704:	89 45 ec             	mov    %eax,-0x14(%ebp)
     707:	eb 06                	jmp    70f <printint+0x31>
  } else {
    x = xx;
     709:	8b 45 0c             	mov    0xc(%ebp),%eax
     70c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     70f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     716:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     719:	8d 41 01             	lea    0x1(%ecx),%eax
     71c:	89 45 f4             	mov    %eax,-0xc(%ebp)
     71f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     722:	8b 45 ec             	mov    -0x14(%ebp),%eax
     725:	ba 00 00 00 00       	mov    $0x0,%edx
     72a:	f7 f3                	div    %ebx
     72c:	89 d0                	mov    %edx,%eax
     72e:	0f b6 80 80 2f 00 00 	movzbl 0x2f80(%eax),%eax
     735:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     739:	8b 5d 10             	mov    0x10(%ebp),%ebx
     73c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     73f:	ba 00 00 00 00       	mov    $0x0,%edx
     744:	f7 f3                	div    %ebx
     746:	89 45 ec             	mov    %eax,-0x14(%ebp)
     749:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     74d:	75 c7                	jne    716 <printint+0x38>
  if(neg)
     74f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     753:	74 2d                	je     782 <printint+0xa4>
    buf[i++] = '-';
     755:	8b 45 f4             	mov    -0xc(%ebp),%eax
     758:	8d 50 01             	lea    0x1(%eax),%edx
     75b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     75e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     763:	eb 1d                	jmp    782 <printint+0xa4>
    putc(fd, buf[i]);
     765:	8d 55 dc             	lea    -0x24(%ebp),%edx
     768:	8b 45 f4             	mov    -0xc(%ebp),%eax
     76b:	01 d0                	add    %edx,%eax
     76d:	0f b6 00             	movzbl (%eax),%eax
     770:	0f be c0             	movsbl %al,%eax
     773:	83 ec 08             	sub    $0x8,%esp
     776:	50                   	push   %eax
     777:	ff 75 08             	pushl  0x8(%ebp)
     77a:	e8 3c ff ff ff       	call   6bb <putc>
     77f:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     782:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     786:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     78a:	79 d9                	jns    765 <printint+0x87>
    putc(fd, buf[i]);
}
     78c:	90                   	nop
     78d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     790:	c9                   	leave  
     791:	c3                   	ret    

00000792 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     792:	55                   	push   %ebp
     793:	89 e5                	mov    %esp,%ebp
     795:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     798:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     79f:	8d 45 0c             	lea    0xc(%ebp),%eax
     7a2:	83 c0 04             	add    $0x4,%eax
     7a5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     7a8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     7af:	e9 59 01 00 00       	jmp    90d <printf+0x17b>
    c = fmt[i] & 0xff;
     7b4:	8b 55 0c             	mov    0xc(%ebp),%edx
     7b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7ba:	01 d0                	add    %edx,%eax
     7bc:	0f b6 00             	movzbl (%eax),%eax
     7bf:	0f be c0             	movsbl %al,%eax
     7c2:	25 ff 00 00 00       	and    $0xff,%eax
     7c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     7ca:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     7ce:	75 2c                	jne    7fc <printf+0x6a>
      if(c == '%'){
     7d0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     7d4:	75 0c                	jne    7e2 <printf+0x50>
        state = '%';
     7d6:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     7dd:	e9 27 01 00 00       	jmp    909 <printf+0x177>
      } else {
        putc(fd, c);
     7e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7e5:	0f be c0             	movsbl %al,%eax
     7e8:	83 ec 08             	sub    $0x8,%esp
     7eb:	50                   	push   %eax
     7ec:	ff 75 08             	pushl  0x8(%ebp)
     7ef:	e8 c7 fe ff ff       	call   6bb <putc>
     7f4:	83 c4 10             	add    $0x10,%esp
     7f7:	e9 0d 01 00 00       	jmp    909 <printf+0x177>
      }
    } else if(state == '%'){
     7fc:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     800:	0f 85 03 01 00 00    	jne    909 <printf+0x177>
      if(c == 'd'){
     806:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     80a:	75 1e                	jne    82a <printf+0x98>
        printint(fd, *ap, 10, 1);
     80c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     80f:	8b 00                	mov    (%eax),%eax
     811:	6a 01                	push   $0x1
     813:	6a 0a                	push   $0xa
     815:	50                   	push   %eax
     816:	ff 75 08             	pushl  0x8(%ebp)
     819:	e8 c0 fe ff ff       	call   6de <printint>
     81e:	83 c4 10             	add    $0x10,%esp
        ap++;
     821:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     825:	e9 d8 00 00 00       	jmp    902 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     82a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     82e:	74 06                	je     836 <printf+0xa4>
     830:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     834:	75 1e                	jne    854 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     836:	8b 45 e8             	mov    -0x18(%ebp),%eax
     839:	8b 00                	mov    (%eax),%eax
     83b:	6a 00                	push   $0x0
     83d:	6a 10                	push   $0x10
     83f:	50                   	push   %eax
     840:	ff 75 08             	pushl  0x8(%ebp)
     843:	e8 96 fe ff ff       	call   6de <printint>
     848:	83 c4 10             	add    $0x10,%esp
        ap++;
     84b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     84f:	e9 ae 00 00 00       	jmp    902 <printf+0x170>
      } else if(c == 's'){
     854:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     858:	75 43                	jne    89d <printf+0x10b>
        s = (char*)*ap;
     85a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     85d:	8b 00                	mov    (%eax),%eax
     85f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     862:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     866:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     86a:	75 25                	jne    891 <printf+0xff>
          s = "(null)";
     86c:	c7 45 f4 82 25 00 00 	movl   $0x2582,-0xc(%ebp)
        while(*s != 0){
     873:	eb 1c                	jmp    891 <printf+0xff>
          putc(fd, *s);
     875:	8b 45 f4             	mov    -0xc(%ebp),%eax
     878:	0f b6 00             	movzbl (%eax),%eax
     87b:	0f be c0             	movsbl %al,%eax
     87e:	83 ec 08             	sub    $0x8,%esp
     881:	50                   	push   %eax
     882:	ff 75 08             	pushl  0x8(%ebp)
     885:	e8 31 fe ff ff       	call   6bb <putc>
     88a:	83 c4 10             	add    $0x10,%esp
          s++;
     88d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     891:	8b 45 f4             	mov    -0xc(%ebp),%eax
     894:	0f b6 00             	movzbl (%eax),%eax
     897:	84 c0                	test   %al,%al
     899:	75 da                	jne    875 <printf+0xe3>
     89b:	eb 65                	jmp    902 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     89d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     8a1:	75 1d                	jne    8c0 <printf+0x12e>
        putc(fd, *ap);
     8a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     8a6:	8b 00                	mov    (%eax),%eax
     8a8:	0f be c0             	movsbl %al,%eax
     8ab:	83 ec 08             	sub    $0x8,%esp
     8ae:	50                   	push   %eax
     8af:	ff 75 08             	pushl  0x8(%ebp)
     8b2:	e8 04 fe ff ff       	call   6bb <putc>
     8b7:	83 c4 10             	add    $0x10,%esp
        ap++;
     8ba:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     8be:	eb 42                	jmp    902 <printf+0x170>
      } else if(c == '%'){
     8c0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     8c4:	75 17                	jne    8dd <printf+0x14b>
        putc(fd, c);
     8c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8c9:	0f be c0             	movsbl %al,%eax
     8cc:	83 ec 08             	sub    $0x8,%esp
     8cf:	50                   	push   %eax
     8d0:	ff 75 08             	pushl  0x8(%ebp)
     8d3:	e8 e3 fd ff ff       	call   6bb <putc>
     8d8:	83 c4 10             	add    $0x10,%esp
     8db:	eb 25                	jmp    902 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     8dd:	83 ec 08             	sub    $0x8,%esp
     8e0:	6a 25                	push   $0x25
     8e2:	ff 75 08             	pushl  0x8(%ebp)
     8e5:	e8 d1 fd ff ff       	call   6bb <putc>
     8ea:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     8ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8f0:	0f be c0             	movsbl %al,%eax
     8f3:	83 ec 08             	sub    $0x8,%esp
     8f6:	50                   	push   %eax
     8f7:	ff 75 08             	pushl  0x8(%ebp)
     8fa:	e8 bc fd ff ff       	call   6bb <putc>
     8ff:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     902:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     909:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     90d:	8b 55 0c             	mov    0xc(%ebp),%edx
     910:	8b 45 f0             	mov    -0x10(%ebp),%eax
     913:	01 d0                	add    %edx,%eax
     915:	0f b6 00             	movzbl (%eax),%eax
     918:	84 c0                	test   %al,%al
     91a:	0f 85 94 fe ff ff    	jne    7b4 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     920:	90                   	nop
     921:	c9                   	leave  
     922:	c3                   	ret    

00000923 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     923:	55                   	push   %ebp
     924:	89 e5                	mov    %esp,%ebp
     926:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     929:	8b 45 08             	mov    0x8(%ebp),%eax
     92c:	83 e8 08             	sub    $0x8,%eax
     92f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     932:	a1 b4 2f 00 00       	mov    0x2fb4,%eax
     937:	89 45 fc             	mov    %eax,-0x4(%ebp)
     93a:	eb 24                	jmp    960 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     93c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     93f:	8b 00                	mov    (%eax),%eax
     941:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     944:	77 12                	ja     958 <free+0x35>
     946:	8b 45 f8             	mov    -0x8(%ebp),%eax
     949:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     94c:	77 24                	ja     972 <free+0x4f>
     94e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     951:	8b 00                	mov    (%eax),%eax
     953:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     956:	77 1a                	ja     972 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     958:	8b 45 fc             	mov    -0x4(%ebp),%eax
     95b:	8b 00                	mov    (%eax),%eax
     95d:	89 45 fc             	mov    %eax,-0x4(%ebp)
     960:	8b 45 f8             	mov    -0x8(%ebp),%eax
     963:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     966:	76 d4                	jbe    93c <free+0x19>
     968:	8b 45 fc             	mov    -0x4(%ebp),%eax
     96b:	8b 00                	mov    (%eax),%eax
     96d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     970:	76 ca                	jbe    93c <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     972:	8b 45 f8             	mov    -0x8(%ebp),%eax
     975:	8b 40 04             	mov    0x4(%eax),%eax
     978:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     97f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     982:	01 c2                	add    %eax,%edx
     984:	8b 45 fc             	mov    -0x4(%ebp),%eax
     987:	8b 00                	mov    (%eax),%eax
     989:	39 c2                	cmp    %eax,%edx
     98b:	75 24                	jne    9b1 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     98d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     990:	8b 50 04             	mov    0x4(%eax),%edx
     993:	8b 45 fc             	mov    -0x4(%ebp),%eax
     996:	8b 00                	mov    (%eax),%eax
     998:	8b 40 04             	mov    0x4(%eax),%eax
     99b:	01 c2                	add    %eax,%edx
     99d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9a0:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     9a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a6:	8b 00                	mov    (%eax),%eax
     9a8:	8b 10                	mov    (%eax),%edx
     9aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9ad:	89 10                	mov    %edx,(%eax)
     9af:	eb 0a                	jmp    9bb <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     9b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9b4:	8b 10                	mov    (%eax),%edx
     9b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9b9:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     9bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9be:	8b 40 04             	mov    0x4(%eax),%eax
     9c1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     9c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9cb:	01 d0                	add    %edx,%eax
     9cd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     9d0:	75 20                	jne    9f2 <free+0xcf>
    p->s.size += bp->s.size;
     9d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9d5:	8b 50 04             	mov    0x4(%eax),%edx
     9d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9db:	8b 40 04             	mov    0x4(%eax),%eax
     9de:	01 c2                	add    %eax,%edx
     9e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9e3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     9e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9e9:	8b 10                	mov    (%eax),%edx
     9eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9ee:	89 10                	mov    %edx,(%eax)
     9f0:	eb 08                	jmp    9fa <free+0xd7>
  } else
    p->s.ptr = bp;
     9f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9f5:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9f8:	89 10                	mov    %edx,(%eax)
  freep = p;
     9fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9fd:	a3 b4 2f 00 00       	mov    %eax,0x2fb4
}
     a02:	90                   	nop
     a03:	c9                   	leave  
     a04:	c3                   	ret    

00000a05 <morecore>:

static Header*
morecore(uint nu)
{
     a05:	55                   	push   %ebp
     a06:	89 e5                	mov    %esp,%ebp
     a08:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     a0b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     a12:	77 07                	ja     a1b <morecore+0x16>
    nu = 4096;
     a14:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     a1b:	8b 45 08             	mov    0x8(%ebp),%eax
     a1e:	c1 e0 03             	shl    $0x3,%eax
     a21:	83 ec 0c             	sub    $0xc,%esp
     a24:	50                   	push   %eax
     a25:	e8 41 fc ff ff       	call   66b <sbrk>
     a2a:	83 c4 10             	add    $0x10,%esp
     a2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     a30:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     a34:	75 07                	jne    a3d <morecore+0x38>
    return 0;
     a36:	b8 00 00 00 00       	mov    $0x0,%eax
     a3b:	eb 26                	jmp    a63 <morecore+0x5e>
  hp = (Header*)p;
     a3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a40:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     a43:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a46:	8b 55 08             	mov    0x8(%ebp),%edx
     a49:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     a4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a4f:	83 c0 08             	add    $0x8,%eax
     a52:	83 ec 0c             	sub    $0xc,%esp
     a55:	50                   	push   %eax
     a56:	e8 c8 fe ff ff       	call   923 <free>
     a5b:	83 c4 10             	add    $0x10,%esp
  return freep;
     a5e:	a1 b4 2f 00 00       	mov    0x2fb4,%eax
}
     a63:	c9                   	leave  
     a64:	c3                   	ret    

00000a65 <malloc>:

void*
malloc(uint nbytes)
{
     a65:	55                   	push   %ebp
     a66:	89 e5                	mov    %esp,%ebp
     a68:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a6b:	8b 45 08             	mov    0x8(%ebp),%eax
     a6e:	83 c0 07             	add    $0x7,%eax
     a71:	c1 e8 03             	shr    $0x3,%eax
     a74:	83 c0 01             	add    $0x1,%eax
     a77:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a7a:	a1 b4 2f 00 00       	mov    0x2fb4,%eax
     a7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a82:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a86:	75 23                	jne    aab <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a88:	c7 45 f0 ac 2f 00 00 	movl   $0x2fac,-0x10(%ebp)
     a8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a92:	a3 b4 2f 00 00       	mov    %eax,0x2fb4
     a97:	a1 b4 2f 00 00       	mov    0x2fb4,%eax
     a9c:	a3 ac 2f 00 00       	mov    %eax,0x2fac
    base.s.size = 0;
     aa1:	c7 05 b0 2f 00 00 00 	movl   $0x0,0x2fb0
     aa8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     aab:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aae:	8b 00                	mov    (%eax),%eax
     ab0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     ab3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab6:	8b 40 04             	mov    0x4(%eax),%eax
     ab9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     abc:	72 4d                	jb     b0b <malloc+0xa6>
      if(p->s.size == nunits)
     abe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac1:	8b 40 04             	mov    0x4(%eax),%eax
     ac4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     ac7:	75 0c                	jne    ad5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     ac9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acc:	8b 10                	mov    (%eax),%edx
     ace:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ad1:	89 10                	mov    %edx,(%eax)
     ad3:	eb 26                	jmp    afb <malloc+0x96>
      else {
        p->s.size -= nunits;
     ad5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad8:	8b 40 04             	mov    0x4(%eax),%eax
     adb:	2b 45 ec             	sub    -0x14(%ebp),%eax
     ade:	89 c2                	mov    %eax,%edx
     ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     ae6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae9:	8b 40 04             	mov    0x4(%eax),%eax
     aec:	c1 e0 03             	shl    $0x3,%eax
     aef:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     af2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af5:	8b 55 ec             	mov    -0x14(%ebp),%edx
     af8:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     afb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     afe:	a3 b4 2f 00 00       	mov    %eax,0x2fb4
      return (void*)(p + 1);
     b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b06:	83 c0 08             	add    $0x8,%eax
     b09:	eb 3b                	jmp    b46 <malloc+0xe1>
    }
    if(p == freep)
     b0b:	a1 b4 2f 00 00       	mov    0x2fb4,%eax
     b10:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     b13:	75 1e                	jne    b33 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     b15:	83 ec 0c             	sub    $0xc,%esp
     b18:	ff 75 ec             	pushl  -0x14(%ebp)
     b1b:	e8 e5 fe ff ff       	call   a05 <morecore>
     b20:	83 c4 10             	add    $0x10,%esp
     b23:	89 45 f4             	mov    %eax,-0xc(%ebp)
     b26:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b2a:	75 07                	jne    b33 <malloc+0xce>
        return 0;
     b2c:	b8 00 00 00 00       	mov    $0x0,%eax
     b31:	eb 13                	jmp    b46 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     b33:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b36:	89 45 f0             	mov    %eax,-0x10(%ebp)
     b39:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b3c:	8b 00                	mov    (%eax),%eax
     b3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     b41:	e9 6d ff ff ff       	jmp    ab3 <malloc+0x4e>
}
     b46:	c9                   	leave  
     b47:	c3                   	ret    

00000b48 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     b48:	55                   	push   %ebp
     b49:	89 e5                	mov    %esp,%ebp
     b4b:	83 ec 1c             	sub    $0x1c,%esp
     b4e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     b51:	8b 55 10             	mov    0x10(%ebp),%edx
     b54:	8b 45 14             	mov    0x14(%ebp),%eax
     b57:	88 4d ec             	mov    %cl,-0x14(%ebp)
     b5a:	88 55 e8             	mov    %dl,-0x18(%ebp)
     b5d:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     b60:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     b64:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     b67:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     b6b:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     b6e:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     b72:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     b75:	8b 45 08             	mov    0x8(%ebp),%eax
     b78:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     b7c:	66 89 10             	mov    %dx,(%eax)
     b7f:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     b83:	88 50 02             	mov    %dl,0x2(%eax)
}
     b86:	8b 45 08             	mov    0x8(%ebp),%eax
     b89:	c9                   	leave  
     b8a:	c2 04 00             	ret    $0x4

00000b8d <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     b8d:	55                   	push   %ebp
     b8e:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     b90:	8b 45 08             	mov    0x8(%ebp),%eax
     b93:	2b 45 10             	sub    0x10(%ebp),%eax
     b96:	89 c2                	mov    %eax,%edx
     b98:	8b 45 08             	mov    0x8(%ebp),%eax
     b9b:	2b 45 10             	sub    0x10(%ebp),%eax
     b9e:	0f af d0             	imul   %eax,%edx
     ba1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ba4:	2b 45 14             	sub    0x14(%ebp),%eax
     ba7:	89 c1                	mov    %eax,%ecx
     ba9:	8b 45 0c             	mov    0xc(%ebp),%eax
     bac:	2b 45 14             	sub    0x14(%ebp),%eax
     baf:	0f af c1             	imul   %ecx,%eax
     bb2:	01 d0                	add    %edx,%eax
}
     bb4:	5d                   	pop    %ebp
     bb5:	c3                   	ret    

00000bb6 <abs_int>:

static inline int abs_int(int x)
{
     bb6:	55                   	push   %ebp
     bb7:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     bb9:	8b 45 08             	mov    0x8(%ebp),%eax
     bbc:	99                   	cltd   
     bbd:	89 d0                	mov    %edx,%eax
     bbf:	33 45 08             	xor    0x8(%ebp),%eax
     bc2:	29 d0                	sub    %edx,%eax
}
     bc4:	5d                   	pop    %ebp
     bc5:	c3                   	ret    

00000bc6 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     bc6:	55                   	push   %ebp
     bc7:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     bc9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     bcd:	79 07                	jns    bd6 <APGetIndex+0x10>
        return X_SMALLER;
     bcf:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     bd4:	eb 40                	jmp    c16 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     bd6:	8b 45 08             	mov    0x8(%ebp),%eax
     bd9:	8b 00                	mov    (%eax),%eax
     bdb:	3b 45 0c             	cmp    0xc(%ebp),%eax
     bde:	7f 07                	jg     be7 <APGetIndex+0x21>
        return X_BIGGER;
     be0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     be5:	eb 2f                	jmp    c16 <APGetIndex+0x50>
    if (y < 0)
     be7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     beb:	79 07                	jns    bf4 <APGetIndex+0x2e>
        return Y_SMALLER;
     bed:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     bf2:	eb 22                	jmp    c16 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     bf4:	8b 45 08             	mov    0x8(%ebp),%eax
     bf7:	8b 40 04             	mov    0x4(%eax),%eax
     bfa:	3b 45 10             	cmp    0x10(%ebp),%eax
     bfd:	7f 07                	jg     c06 <APGetIndex+0x40>
        return Y_BIGGER;
     bff:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     c04:	eb 10                	jmp    c16 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     c06:	8b 45 08             	mov    0x8(%ebp),%eax
     c09:	8b 00                	mov    (%eax),%eax
     c0b:	0f af 45 10          	imul   0x10(%ebp),%eax
     c0f:	89 c2                	mov    %eax,%edx
     c11:	8b 45 0c             	mov    0xc(%ebp),%eax
     c14:	01 d0                	add    %edx,%eax
}
     c16:	5d                   	pop    %ebp
     c17:	c3                   	ret    

00000c18 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     c18:	55                   	push   %ebp
     c19:	89 e5                	mov    %esp,%ebp
     c1b:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     c1e:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     c25:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c28:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     c2b:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     c32:	83 ec 08             	sub    $0x8,%esp
     c35:	6a 00                	push   $0x0
     c37:	ff 75 0c             	pushl  0xc(%ebp)
     c3a:	e8 e4 f9 ff ff       	call   623 <open>
     c3f:	83 c4 10             	add    $0x10,%esp
     c42:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     c45:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     c49:	79 2e                	jns    c79 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     c4b:	83 ec 04             	sub    $0x4,%esp
     c4e:	ff 75 0c             	pushl  0xc(%ebp)
     c51:	68 89 25 00 00       	push   $0x2589
     c56:	6a 01                	push   $0x1
     c58:	e8 35 fb ff ff       	call   792 <printf>
     c5d:	83 c4 10             	add    $0x10,%esp
        return bmp;
     c60:	8b 45 08             	mov    0x8(%ebp),%eax
     c63:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c66:	89 10                	mov    %edx,(%eax)
     c68:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c6b:	89 50 04             	mov    %edx,0x4(%eax)
     c6e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c71:	89 50 08             	mov    %edx,0x8(%eax)
     c74:	e9 d2 01 00 00       	jmp    e4b <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     c79:	83 ec 04             	sub    $0x4,%esp
     c7c:	6a 0e                	push   $0xe
     c7e:	8d 45 ba             	lea    -0x46(%ebp),%eax
     c81:	50                   	push   %eax
     c82:	ff 75 ec             	pushl  -0x14(%ebp)
     c85:	e8 71 f9 ff ff       	call   5fb <read>
     c8a:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     c8d:	83 ec 04             	sub    $0x4,%esp
     c90:	6a 28                	push   $0x28
     c92:	8d 45 92             	lea    -0x6e(%ebp),%eax
     c95:	50                   	push   %eax
     c96:	ff 75 ec             	pushl  -0x14(%ebp)
     c99:	e8 5d f9 ff ff       	call   5fb <read>
     c9e:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     ca1:	8b 45 96             	mov    -0x6a(%ebp),%eax
     ca4:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     ca7:	8b 45 9a             	mov    -0x66(%ebp),%eax
     caa:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     cad:	8b 55 c8             	mov    -0x38(%ebp),%edx
     cb0:	8b 45 cc             	mov    -0x34(%ebp),%eax
     cb3:	0f af d0             	imul   %eax,%edx
     cb6:	89 d0                	mov    %edx,%eax
     cb8:	01 c0                	add    %eax,%eax
     cba:	01 d0                	add    %edx,%eax
     cbc:	83 ec 0c             	sub    $0xc,%esp
     cbf:	50                   	push   %eax
     cc0:	e8 a0 fd ff ff       	call   a65 <malloc>
     cc5:	83 c4 10             	add    $0x10,%esp
     cc8:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     ccb:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     ccf:	0f b7 c0             	movzwl %ax,%eax
     cd2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     cd5:	8b 55 c8             	mov    -0x38(%ebp),%edx
     cd8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cdb:	0f af c2             	imul   %edx,%eax
     cde:	83 c0 1f             	add    $0x1f,%eax
     ce1:	c1 e8 05             	shr    $0x5,%eax
     ce4:	c1 e0 02             	shl    $0x2,%eax
     ce7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     cea:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ced:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cf0:	0f af c2             	imul   %edx,%eax
     cf3:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     cf6:	8b 45 e0             	mov    -0x20(%ebp),%eax
     cf9:	83 ec 0c             	sub    $0xc,%esp
     cfc:	50                   	push   %eax
     cfd:	e8 63 fd ff ff       	call   a65 <malloc>
     d02:	83 c4 10             	add    $0x10,%esp
     d05:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     d08:	83 ec 04             	sub    $0x4,%esp
     d0b:	ff 75 e0             	pushl  -0x20(%ebp)
     d0e:	ff 75 dc             	pushl  -0x24(%ebp)
     d11:	ff 75 ec             	pushl  -0x14(%ebp)
     d14:	e8 e2 f8 ff ff       	call   5fb <read>
     d19:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     d1c:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     d20:	66 c1 e8 03          	shr    $0x3,%ax
     d24:	0f b7 c0             	movzwl %ax,%eax
     d27:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     d2a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d31:	e9 e5 00 00 00       	jmp    e1b <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     d36:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d39:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d3c:	29 c2                	sub    %eax,%edx
     d3e:	89 d0                	mov    %edx,%eax
     d40:	8d 50 ff             	lea    -0x1(%eax),%edx
     d43:	8b 45 c8             	mov    -0x38(%ebp),%eax
     d46:	0f af c2             	imul   %edx,%eax
     d49:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     d4c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     d53:	e9 b1 00 00 00       	jmp    e09 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     d58:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d5b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d61:	01 c8                	add    %ecx,%eax
     d63:	89 c1                	mov    %eax,%ecx
     d65:	89 c8                	mov    %ecx,%eax
     d67:	01 c0                	add    %eax,%eax
     d69:	01 c8                	add    %ecx,%eax
     d6b:	01 c2                	add    %eax,%edx
     d6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d70:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d74:	89 c1                	mov    %eax,%ecx
     d76:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d79:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d7d:	01 c1                	add    %eax,%ecx
     d7f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d82:	01 c8                	add    %ecx,%eax
     d84:	8d 48 ff             	lea    -0x1(%eax),%ecx
     d87:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d8a:	01 c8                	add    %ecx,%eax
     d8c:	0f b6 00             	movzbl (%eax),%eax
     d8f:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     d92:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d95:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d98:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d9b:	01 c8                	add    %ecx,%eax
     d9d:	89 c1                	mov    %eax,%ecx
     d9f:	89 c8                	mov    %ecx,%eax
     da1:	01 c0                	add    %eax,%eax
     da3:	01 c8                	add    %ecx,%eax
     da5:	01 c2                	add    %eax,%edx
     da7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     daa:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     dae:	89 c1                	mov    %eax,%ecx
     db0:	8b 45 d8             	mov    -0x28(%ebp),%eax
     db3:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     db7:	01 c1                	add    %eax,%ecx
     db9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     dbc:	01 c8                	add    %ecx,%eax
     dbe:	8d 48 fe             	lea    -0x2(%eax),%ecx
     dc1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dc4:	01 c8                	add    %ecx,%eax
     dc6:	0f b6 00             	movzbl (%eax),%eax
     dc9:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     dcc:	8b 55 d0             	mov    -0x30(%ebp),%edx
     dcf:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     dd2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     dd5:	01 c8                	add    %ecx,%eax
     dd7:	89 c1                	mov    %eax,%ecx
     dd9:	89 c8                	mov    %ecx,%eax
     ddb:	01 c0                	add    %eax,%eax
     ddd:	01 c8                	add    %ecx,%eax
     ddf:	01 c2                	add    %eax,%edx
     de1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     de4:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     de8:	89 c1                	mov    %eax,%ecx
     dea:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ded:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     df1:	01 c1                	add    %eax,%ecx
     df3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     df6:	01 c8                	add    %ecx,%eax
     df8:	8d 48 fd             	lea    -0x3(%eax),%ecx
     dfb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dfe:	01 c8                	add    %ecx,%eax
     e00:	0f b6 00             	movzbl (%eax),%eax
     e03:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     e05:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e09:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e0f:	39 c2                	cmp    %eax,%edx
     e11:	0f 87 41 ff ff ff    	ja     d58 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     e17:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e1b:	8b 55 cc             	mov    -0x34(%ebp),%edx
     e1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e21:	39 c2                	cmp    %eax,%edx
     e23:	0f 87 0d ff ff ff    	ja     d36 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     e29:	83 ec 0c             	sub    $0xc,%esp
     e2c:	ff 75 ec             	pushl  -0x14(%ebp)
     e2f:	e8 d7 f7 ff ff       	call   60b <close>
     e34:	83 c4 10             	add    $0x10,%esp
    return bmp;
     e37:	8b 45 08             	mov    0x8(%ebp),%eax
     e3a:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e3d:	89 10                	mov    %edx,(%eax)
     e3f:	8b 55 cc             	mov    -0x34(%ebp),%edx
     e42:	89 50 04             	mov    %edx,0x4(%eax)
     e45:	8b 55 d0             	mov    -0x30(%ebp),%edx
     e48:	89 50 08             	mov    %edx,0x8(%eax)
}
     e4b:	8b 45 08             	mov    0x8(%ebp),%eax
     e4e:	c9                   	leave  
     e4f:	c2 04 00             	ret    $0x4

00000e52 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     e52:	55                   	push   %ebp
     e53:	89 e5                	mov    %esp,%ebp
     e55:	53                   	push   %ebx
     e56:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     e59:	83 ec 0c             	sub    $0xc,%esp
     e5c:	6a 1c                	push   $0x1c
     e5e:	e8 02 fc ff ff       	call   a65 <malloc>
     e63:	83 c4 10             	add    $0x10,%esp
     e66:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     e69:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e6c:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     e73:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     e76:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e79:	6a 0c                	push   $0xc
     e7b:	6a 0c                	push   $0xc
     e7d:	6a 0c                	push   $0xc
     e7f:	50                   	push   %eax
     e80:	e8 c3 fc ff ff       	call   b48 <RGB>
     e85:	83 c4 0c             	add    $0xc,%esp
     e88:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     e8c:	66 89 43 13          	mov    %ax,0x13(%ebx)
     e90:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     e94:	88 43 15             	mov    %al,0x15(%ebx)
     e97:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e9a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e9d:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     ea1:	66 89 48 10          	mov    %cx,0x10(%eax)
     ea5:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     ea9:	88 50 12             	mov    %dl,0x12(%eax)
     eac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eaf:	8b 55 f4             	mov    -0xc(%ebp),%edx
     eb2:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     eb6:	66 89 48 08          	mov    %cx,0x8(%eax)
     eba:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     ebe:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     ec1:	8b 45 08             	mov    0x8(%ebp),%eax
     ec4:	89 c2                	mov    %eax,%edx
     ec6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ec9:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     ecb:	8b 45 0c             	mov    0xc(%ebp),%eax
     ece:	89 c2                	mov    %eax,%edx
     ed0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ed3:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     ed6:	8b 55 10             	mov    0x10(%ebp),%edx
     ed9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     edc:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     edf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     ee2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ee5:	c9                   	leave  
     ee6:	c3                   	ret    

00000ee7 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     ee7:	55                   	push   %ebp
     ee8:	89 e5                	mov    %esp,%ebp
     eea:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     eed:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef0:	8b 50 08             	mov    0x8(%eax),%edx
     ef3:	89 55 f8             	mov    %edx,-0x8(%ebp)
     ef6:	8b 40 0c             	mov    0xc(%eax),%eax
     ef9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     efc:	8b 45 0c             	mov    0xc(%ebp),%eax
     eff:	8b 55 10             	mov    0x10(%ebp),%edx
     f02:	89 50 08             	mov    %edx,0x8(%eax)
     f05:	8b 55 14             	mov    0x14(%ebp),%edx
     f08:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     f0b:	8b 45 08             	mov    0x8(%ebp),%eax
     f0e:	8b 55 f8             	mov    -0x8(%ebp),%edx
     f11:	89 10                	mov    %edx,(%eax)
     f13:	8b 55 fc             	mov    -0x4(%ebp),%edx
     f16:	89 50 04             	mov    %edx,0x4(%eax)
}
     f19:	8b 45 08             	mov    0x8(%ebp),%eax
     f1c:	c9                   	leave  
     f1d:	c2 04 00             	ret    $0x4

00000f20 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     f20:	55                   	push   %ebp
     f21:	89 e5                	mov    %esp,%ebp
     f23:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     f26:	8b 45 0c             	mov    0xc(%ebp),%eax
     f29:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     f2d:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     f31:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     f35:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     f38:	8b 45 0c             	mov    0xc(%ebp),%eax
     f3b:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     f3f:	66 89 50 10          	mov    %dx,0x10(%eax)
     f43:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     f47:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     f4a:	8b 45 08             	mov    0x8(%ebp),%eax
     f4d:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     f51:	66 89 10             	mov    %dx,(%eax)
     f54:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     f58:	88 50 02             	mov    %dl,0x2(%eax)
}
     f5b:	8b 45 08             	mov    0x8(%ebp),%eax
     f5e:	c9                   	leave  
     f5f:	c2 04 00             	ret    $0x4

00000f62 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     f62:	55                   	push   %ebp
     f63:	89 e5                	mov    %esp,%ebp
     f65:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     f68:	8b 45 08             	mov    0x8(%ebp),%eax
     f6b:	8b 40 0c             	mov    0xc(%eax),%eax
     f6e:	89 c2                	mov    %eax,%edx
     f70:	c1 ea 1f             	shr    $0x1f,%edx
     f73:	01 d0                	add    %edx,%eax
     f75:	d1 f8                	sar    %eax
     f77:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     f7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f7d:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     f81:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     f84:	8b 45 10             	mov    0x10(%ebp),%eax
     f87:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     f8d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     f91:	0f 89 98 00 00 00    	jns    102f <APDrawPoint+0xcd>
        i = 0;
     f97:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     f9e:	e9 8c 00 00 00       	jmp    102f <APDrawPoint+0xcd>
    {
        j = x - off;
     fa3:	8b 45 0c             	mov    0xc(%ebp),%eax
     fa6:	2b 45 f4             	sub    -0xc(%ebp),%eax
     fa9:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     fac:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     fb0:	79 69                	jns    101b <APDrawPoint+0xb9>
            j = 0;
     fb2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     fb9:	eb 60                	jmp    101b <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     fbb:	ff 75 fc             	pushl  -0x4(%ebp)
     fbe:	ff 75 f8             	pushl  -0x8(%ebp)
     fc1:	ff 75 08             	pushl  0x8(%ebp)
     fc4:	e8 fd fb ff ff       	call   bc6 <APGetIndex>
     fc9:	83 c4 0c             	add    $0xc,%esp
     fcc:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     fcf:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     fd3:	74 55                	je     102a <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     fd5:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     fd9:	74 67                	je     1042 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     fdb:	ff 75 10             	pushl  0x10(%ebp)
     fde:	ff 75 0c             	pushl  0xc(%ebp)
     fe1:	ff 75 fc             	pushl  -0x4(%ebp)
     fe4:	ff 75 f8             	pushl  -0x8(%ebp)
     fe7:	e8 a1 fb ff ff       	call   b8d <distance_2>
     fec:	83 c4 10             	add    $0x10,%esp
     fef:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     ff2:	7f 23                	jg     1017 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     ff4:	8b 45 08             	mov    0x8(%ebp),%eax
     ff7:	8b 48 18             	mov    0x18(%eax),%ecx
     ffa:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ffd:	89 d0                	mov    %edx,%eax
     fff:	01 c0                	add    %eax,%eax
    1001:	01 d0                	add    %edx,%eax
    1003:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1006:	8b 45 08             	mov    0x8(%ebp),%eax
    1009:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    100d:	66 89 0a             	mov    %cx,(%edx)
    1010:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1014:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1017:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    101b:	8b 55 0c             	mov    0xc(%ebp),%edx
    101e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1021:	01 d0                	add    %edx,%eax
    1023:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1026:	7d 93                	jge    fbb <APDrawPoint+0x59>
    1028:	eb 01                	jmp    102b <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    102a:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    102b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    102f:	8b 55 10             	mov    0x10(%ebp),%edx
    1032:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1035:	01 d0                	add    %edx,%eax
    1037:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    103a:	0f 8d 63 ff ff ff    	jge    fa3 <APDrawPoint+0x41>
    1040:	eb 01                	jmp    1043 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1042:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    1043:	c9                   	leave  
    1044:	c3                   	ret    

00001045 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1045:	55                   	push   %ebp
    1046:	89 e5                	mov    %esp,%ebp
    1048:	53                   	push   %ebx
    1049:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    104c:	8b 45 0c             	mov    0xc(%ebp),%eax
    104f:	3b 45 14             	cmp    0x14(%ebp),%eax
    1052:	0f 85 80 00 00 00    	jne    10d8 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1058:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    105c:	0f 88 9d 02 00 00    	js     12ff <APDrawLine+0x2ba>
    1062:	8b 45 08             	mov    0x8(%ebp),%eax
    1065:	8b 00                	mov    (%eax),%eax
    1067:	3b 45 0c             	cmp    0xc(%ebp),%eax
    106a:	0f 8e 8f 02 00 00    	jle    12ff <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    1070:	8b 45 10             	mov    0x10(%ebp),%eax
    1073:	3b 45 18             	cmp    0x18(%ebp),%eax
    1076:	7e 12                	jle    108a <APDrawLine+0x45>
        {
            int tmp = y2;
    1078:	8b 45 18             	mov    0x18(%ebp),%eax
    107b:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    107e:	8b 45 10             	mov    0x10(%ebp),%eax
    1081:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1084:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1087:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    108a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    108e:	79 07                	jns    1097 <APDrawLine+0x52>
    1090:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1097:	8b 45 08             	mov    0x8(%ebp),%eax
    109a:	8b 40 04             	mov    0x4(%eax),%eax
    109d:	3b 45 18             	cmp    0x18(%ebp),%eax
    10a0:	7d 0c                	jge    10ae <APDrawLine+0x69>
    10a2:	8b 45 08             	mov    0x8(%ebp),%eax
    10a5:	8b 40 04             	mov    0x4(%eax),%eax
    10a8:	83 e8 01             	sub    $0x1,%eax
    10ab:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    10ae:	8b 45 10             	mov    0x10(%ebp),%eax
    10b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    10b4:	eb 15                	jmp    10cb <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    10b6:	ff 75 f4             	pushl  -0xc(%ebp)
    10b9:	ff 75 0c             	pushl  0xc(%ebp)
    10bc:	ff 75 08             	pushl  0x8(%ebp)
    10bf:	e8 9e fe ff ff       	call   f62 <APDrawPoint>
    10c4:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    10c7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10ce:	3b 45 18             	cmp    0x18(%ebp),%eax
    10d1:	7e e3                	jle    10b6 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    10d3:	e9 2b 02 00 00       	jmp    1303 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    10d8:	8b 45 10             	mov    0x10(%ebp),%eax
    10db:	3b 45 18             	cmp    0x18(%ebp),%eax
    10de:	75 7f                	jne    115f <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    10e0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    10e4:	0f 88 18 02 00 00    	js     1302 <APDrawLine+0x2bd>
    10ea:	8b 45 08             	mov    0x8(%ebp),%eax
    10ed:	8b 40 04             	mov    0x4(%eax),%eax
    10f0:	3b 45 10             	cmp    0x10(%ebp),%eax
    10f3:	0f 8e 09 02 00 00    	jle    1302 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    10f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    10fc:	3b 45 14             	cmp    0x14(%ebp),%eax
    10ff:	7e 12                	jle    1113 <APDrawLine+0xce>
        {
            int tmp = x2;
    1101:	8b 45 14             	mov    0x14(%ebp),%eax
    1104:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1107:	8b 45 0c             	mov    0xc(%ebp),%eax
    110a:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    110d:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1110:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1113:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1117:	79 07                	jns    1120 <APDrawLine+0xdb>
    1119:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1120:	8b 45 08             	mov    0x8(%ebp),%eax
    1123:	8b 00                	mov    (%eax),%eax
    1125:	3b 45 14             	cmp    0x14(%ebp),%eax
    1128:	7d 0b                	jge    1135 <APDrawLine+0xf0>
    112a:	8b 45 08             	mov    0x8(%ebp),%eax
    112d:	8b 00                	mov    (%eax),%eax
    112f:	83 e8 01             	sub    $0x1,%eax
    1132:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1135:	8b 45 0c             	mov    0xc(%ebp),%eax
    1138:	89 45 f0             	mov    %eax,-0x10(%ebp)
    113b:	eb 15                	jmp    1152 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    113d:	ff 75 10             	pushl  0x10(%ebp)
    1140:	ff 75 f0             	pushl  -0x10(%ebp)
    1143:	ff 75 08             	pushl  0x8(%ebp)
    1146:	e8 17 fe ff ff       	call   f62 <APDrawPoint>
    114b:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    114e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1152:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1155:	3b 45 14             	cmp    0x14(%ebp),%eax
    1158:	7e e3                	jle    113d <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    115a:	e9 a4 01 00 00       	jmp    1303 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    115f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1166:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    116d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1170:	2b 45 14             	sub    0x14(%ebp),%eax
    1173:	50                   	push   %eax
    1174:	e8 3d fa ff ff       	call   bb6 <abs_int>
    1179:	83 c4 04             	add    $0x4,%esp
    117c:	89 c3                	mov    %eax,%ebx
    117e:	8b 45 10             	mov    0x10(%ebp),%eax
    1181:	2b 45 18             	sub    0x18(%ebp),%eax
    1184:	50                   	push   %eax
    1185:	e8 2c fa ff ff       	call   bb6 <abs_int>
    118a:	83 c4 04             	add    $0x4,%esp
    118d:	39 c3                	cmp    %eax,%ebx
    118f:	0f 8e b5 00 00 00    	jle    124a <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1195:	8b 45 10             	mov    0x10(%ebp),%eax
    1198:	2b 45 18             	sub    0x18(%ebp),%eax
    119b:	89 45 b0             	mov    %eax,-0x50(%ebp)
    119e:	db 45 b0             	fildl  -0x50(%ebp)
    11a1:	8b 45 0c             	mov    0xc(%ebp),%eax
    11a4:	2b 45 14             	sub    0x14(%ebp),%eax
    11a7:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11aa:	db 45 b0             	fildl  -0x50(%ebp)
    11ad:	de f9                	fdivrp %st,%st(1)
    11af:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    11b2:	8b 45 14             	mov    0x14(%ebp),%eax
    11b5:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11b8:	7e 0e                	jle    11c8 <APDrawLine+0x183>
        {
            s = x1;
    11ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    11bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    11c0:	8b 45 14             	mov    0x14(%ebp),%eax
    11c3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11c6:	eb 0c                	jmp    11d4 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    11c8:	8b 45 14             	mov    0x14(%ebp),%eax
    11cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    11ce:	8b 45 0c             	mov    0xc(%ebp),%eax
    11d1:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    11d4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11d8:	79 07                	jns    11e1 <APDrawLine+0x19c>
    11da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    11e1:	8b 45 08             	mov    0x8(%ebp),%eax
    11e4:	8b 00                	mov    (%eax),%eax
    11e6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11e9:	7f 0b                	jg     11f6 <APDrawLine+0x1b1>
    11eb:	8b 45 08             	mov    0x8(%ebp),%eax
    11ee:	8b 00                	mov    (%eax),%eax
    11f0:	83 e8 01             	sub    $0x1,%eax
    11f3:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    11f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    11fc:	eb 3f                	jmp    123d <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    11fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1201:	2b 45 0c             	sub    0xc(%ebp),%eax
    1204:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1207:	db 45 b0             	fildl  -0x50(%ebp)
    120a:	dc 4d d0             	fmull  -0x30(%ebp)
    120d:	db 45 10             	fildl  0x10(%ebp)
    1210:	de c1                	faddp  %st,%st(1)
    1212:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1215:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1219:	b4 0c                	mov    $0xc,%ah
    121b:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    121f:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1222:	db 5d cc             	fistpl -0x34(%ebp)
    1225:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1228:	ff 75 cc             	pushl  -0x34(%ebp)
    122b:	ff 75 e4             	pushl  -0x1c(%ebp)
    122e:	ff 75 08             	pushl  0x8(%ebp)
    1231:	e8 2c fd ff ff       	call   f62 <APDrawPoint>
    1236:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1239:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    123d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1240:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1243:	7e b9                	jle    11fe <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1245:	e9 b9 00 00 00       	jmp    1303 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    124a:	8b 45 0c             	mov    0xc(%ebp),%eax
    124d:	2b 45 14             	sub    0x14(%ebp),%eax
    1250:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1253:	db 45 b0             	fildl  -0x50(%ebp)
    1256:	8b 45 10             	mov    0x10(%ebp),%eax
    1259:	2b 45 18             	sub    0x18(%ebp),%eax
    125c:	89 45 b0             	mov    %eax,-0x50(%ebp)
    125f:	db 45 b0             	fildl  -0x50(%ebp)
    1262:	de f9                	fdivrp %st,%st(1)
    1264:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1267:	8b 45 10             	mov    0x10(%ebp),%eax
    126a:	3b 45 18             	cmp    0x18(%ebp),%eax
    126d:	7e 0e                	jle    127d <APDrawLine+0x238>
    {
        s = y2;
    126f:	8b 45 18             	mov    0x18(%ebp),%eax
    1272:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1275:	8b 45 10             	mov    0x10(%ebp),%eax
    1278:	89 45 e8             	mov    %eax,-0x18(%ebp)
    127b:	eb 0c                	jmp    1289 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    127d:	8b 45 10             	mov    0x10(%ebp),%eax
    1280:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1283:	8b 45 18             	mov    0x18(%ebp),%eax
    1286:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1289:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    128d:	79 07                	jns    1296 <APDrawLine+0x251>
    128f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1296:	8b 45 08             	mov    0x8(%ebp),%eax
    1299:	8b 40 04             	mov    0x4(%eax),%eax
    129c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    129f:	7f 0c                	jg     12ad <APDrawLine+0x268>
    12a1:	8b 45 08             	mov    0x8(%ebp),%eax
    12a4:	8b 40 04             	mov    0x4(%eax),%eax
    12a7:	83 e8 01             	sub    $0x1,%eax
    12aa:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    12ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
    12b3:	eb 3f                	jmp    12f4 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    12b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12b8:	2b 45 10             	sub    0x10(%ebp),%eax
    12bb:	89 45 b0             	mov    %eax,-0x50(%ebp)
    12be:	db 45 b0             	fildl  -0x50(%ebp)
    12c1:	dc 4d c0             	fmull  -0x40(%ebp)
    12c4:	db 45 0c             	fildl  0xc(%ebp)
    12c7:	de c1                	faddp  %st,%st(1)
    12c9:	d9 7d b6             	fnstcw -0x4a(%ebp)
    12cc:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    12d0:	b4 0c                	mov    $0xc,%ah
    12d2:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    12d6:	d9 6d b4             	fldcw  -0x4c(%ebp)
    12d9:	db 5d bc             	fistpl -0x44(%ebp)
    12dc:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    12df:	ff 75 e0             	pushl  -0x20(%ebp)
    12e2:	ff 75 bc             	pushl  -0x44(%ebp)
    12e5:	ff 75 08             	pushl  0x8(%ebp)
    12e8:	e8 75 fc ff ff       	call   f62 <APDrawPoint>
    12ed:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    12f0:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    12f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12f7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12fa:	7e b9                	jle    12b5 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    12fc:	90                   	nop
    12fd:	eb 04                	jmp    1303 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    12ff:	90                   	nop
    1300:	eb 01                	jmp    1303 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1302:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1303:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1306:	c9                   	leave  
    1307:	c3                   	ret    

00001308 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1308:	55                   	push   %ebp
    1309:	89 e5                	mov    %esp,%ebp
    130b:	53                   	push   %ebx
    130c:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    130f:	8b 55 10             	mov    0x10(%ebp),%edx
    1312:	8b 45 18             	mov    0x18(%ebp),%eax
    1315:	01 d0                	add    %edx,%eax
    1317:	83 e8 01             	sub    $0x1,%eax
    131a:	83 ec 04             	sub    $0x4,%esp
    131d:	50                   	push   %eax
    131e:	ff 75 0c             	pushl  0xc(%ebp)
    1321:	ff 75 10             	pushl  0x10(%ebp)
    1324:	ff 75 0c             	pushl  0xc(%ebp)
    1327:	ff 75 08             	pushl  0x8(%ebp)
    132a:	e8 16 fd ff ff       	call   1045 <APDrawLine>
    132f:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1332:	8b 55 0c             	mov    0xc(%ebp),%edx
    1335:	8b 45 14             	mov    0x14(%ebp),%eax
    1338:	01 d0                	add    %edx,%eax
    133a:	83 e8 01             	sub    $0x1,%eax
    133d:	83 ec 04             	sub    $0x4,%esp
    1340:	ff 75 10             	pushl  0x10(%ebp)
    1343:	50                   	push   %eax
    1344:	ff 75 10             	pushl  0x10(%ebp)
    1347:	ff 75 0c             	pushl  0xc(%ebp)
    134a:	ff 75 08             	pushl  0x8(%ebp)
    134d:	e8 f3 fc ff ff       	call   1045 <APDrawLine>
    1352:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1355:	8b 55 10             	mov    0x10(%ebp),%edx
    1358:	8b 45 18             	mov    0x18(%ebp),%eax
    135b:	01 d0                	add    %edx,%eax
    135d:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1360:	8b 55 0c             	mov    0xc(%ebp),%edx
    1363:	8b 45 14             	mov    0x14(%ebp),%eax
    1366:	01 d0                	add    %edx,%eax
    1368:	8d 50 ff             	lea    -0x1(%eax),%edx
    136b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    136e:	8b 45 14             	mov    0x14(%ebp),%eax
    1371:	01 d8                	add    %ebx,%eax
    1373:	83 e8 01             	sub    $0x1,%eax
    1376:	83 ec 04             	sub    $0x4,%esp
    1379:	51                   	push   %ecx
    137a:	52                   	push   %edx
    137b:	ff 75 10             	pushl  0x10(%ebp)
    137e:	50                   	push   %eax
    137f:	ff 75 08             	pushl  0x8(%ebp)
    1382:	e8 be fc ff ff       	call   1045 <APDrawLine>
    1387:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    138a:	8b 55 10             	mov    0x10(%ebp),%edx
    138d:	8b 45 18             	mov    0x18(%ebp),%eax
    1390:	01 d0                	add    %edx,%eax
    1392:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1395:	8b 55 0c             	mov    0xc(%ebp),%edx
    1398:	8b 45 14             	mov    0x14(%ebp),%eax
    139b:	01 d0                	add    %edx,%eax
    139d:	8d 50 ff             	lea    -0x1(%eax),%edx
    13a0:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13a3:	8b 45 18             	mov    0x18(%ebp),%eax
    13a6:	01 d8                	add    %ebx,%eax
    13a8:	83 e8 01             	sub    $0x1,%eax
    13ab:	83 ec 04             	sub    $0x4,%esp
    13ae:	51                   	push   %ecx
    13af:	52                   	push   %edx
    13b0:	50                   	push   %eax
    13b1:	ff 75 0c             	pushl  0xc(%ebp)
    13b4:	ff 75 08             	pushl  0x8(%ebp)
    13b7:	e8 89 fc ff ff       	call   1045 <APDrawLine>
    13bc:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    13bf:	8b 55 0c             	mov    0xc(%ebp),%edx
    13c2:	8b 45 14             	mov    0x14(%ebp),%eax
    13c5:	01 d0                	add    %edx,%eax
    13c7:	8d 50 ff             	lea    -0x1(%eax),%edx
    13ca:	8b 45 08             	mov    0x8(%ebp),%eax
    13cd:	8b 40 0c             	mov    0xc(%eax),%eax
    13d0:	89 c1                	mov    %eax,%ecx
    13d2:	c1 e9 1f             	shr    $0x1f,%ecx
    13d5:	01 c8                	add    %ecx,%eax
    13d7:	d1 f8                	sar    %eax
    13d9:	29 c2                	sub    %eax,%edx
    13db:	89 d0                	mov    %edx,%eax
    13dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    13e0:	8b 55 10             	mov    0x10(%ebp),%edx
    13e3:	8b 45 18             	mov    0x18(%ebp),%eax
    13e6:	01 d0                	add    %edx,%eax
    13e8:	8d 50 ff             	lea    -0x1(%eax),%edx
    13eb:	8b 45 08             	mov    0x8(%ebp),%eax
    13ee:	8b 40 0c             	mov    0xc(%eax),%eax
    13f1:	89 c1                	mov    %eax,%ecx
    13f3:	c1 e9 1f             	shr    $0x1f,%ecx
    13f6:	01 c8                	add    %ecx,%eax
    13f8:	d1 f8                	sar    %eax
    13fa:	29 c2                	sub    %eax,%edx
    13fc:	89 d0                	mov    %edx,%eax
    13fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1401:	8b 45 08             	mov    0x8(%ebp),%eax
    1404:	8b 40 0c             	mov    0xc(%eax),%eax
    1407:	89 c2                	mov    %eax,%edx
    1409:	c1 ea 1f             	shr    $0x1f,%edx
    140c:	01 d0                	add    %edx,%eax
    140e:	d1 f8                	sar    %eax
    1410:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1413:	8b 45 08             	mov    0x8(%ebp),%eax
    1416:	8b 40 0c             	mov    0xc(%eax),%eax
    1419:	89 c2                	mov    %eax,%edx
    141b:	c1 ea 1f             	shr    $0x1f,%edx
    141e:	01 d0                	add    %edx,%eax
    1420:	d1 f8                	sar    %eax
    1422:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1425:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1429:	0f 88 d8 00 00 00    	js     1507 <APDrawRect+0x1ff>
    142f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1433:	0f 88 ce 00 00 00    	js     1507 <APDrawRect+0x1ff>
    1439:	8b 45 08             	mov    0x8(%ebp),%eax
    143c:	8b 00                	mov    (%eax),%eax
    143e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1441:	0f 8e c0 00 00 00    	jle    1507 <APDrawRect+0x1ff>
    1447:	8b 45 08             	mov    0x8(%ebp),%eax
    144a:	8b 40 04             	mov    0x4(%eax),%eax
    144d:	3b 45 10             	cmp    0x10(%ebp),%eax
    1450:	0f 8e b1 00 00 00    	jle    1507 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1456:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    145a:	79 07                	jns    1463 <APDrawRect+0x15b>
    145c:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1463:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1467:	79 07                	jns    1470 <APDrawRect+0x168>
    1469:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1470:	8b 45 08             	mov    0x8(%ebp),%eax
    1473:	8b 00                	mov    (%eax),%eax
    1475:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1478:	7f 0b                	jg     1485 <APDrawRect+0x17d>
    147a:	8b 45 08             	mov    0x8(%ebp),%eax
    147d:	8b 00                	mov    (%eax),%eax
    147f:	83 e8 01             	sub    $0x1,%eax
    1482:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1485:	8b 45 08             	mov    0x8(%ebp),%eax
    1488:	8b 40 04             	mov    0x4(%eax),%eax
    148b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    148e:	7f 0c                	jg     149c <APDrawRect+0x194>
    1490:	8b 45 08             	mov    0x8(%ebp),%eax
    1493:	8b 40 04             	mov    0x4(%eax),%eax
    1496:	83 e8 01             	sub    $0x1,%eax
    1499:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    149c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    14a3:	8b 45 0c             	mov    0xc(%ebp),%eax
    14a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14a9:	eb 52                	jmp    14fd <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    14ab:	8b 45 10             	mov    0x10(%ebp),%eax
    14ae:	89 45 e8             	mov    %eax,-0x18(%ebp)
    14b1:	eb 3e                	jmp    14f1 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    14b3:	83 ec 04             	sub    $0x4,%esp
    14b6:	ff 75 e8             	pushl  -0x18(%ebp)
    14b9:	ff 75 ec             	pushl  -0x14(%ebp)
    14bc:	ff 75 08             	pushl  0x8(%ebp)
    14bf:	e8 02 f7 ff ff       	call   bc6 <APGetIndex>
    14c4:	83 c4 10             	add    $0x10,%esp
    14c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    14ca:	8b 45 08             	mov    0x8(%ebp),%eax
    14cd:	8b 48 18             	mov    0x18(%eax),%ecx
    14d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    14d3:	89 d0                	mov    %edx,%eax
    14d5:	01 c0                	add    %eax,%eax
    14d7:	01 d0                	add    %edx,%eax
    14d9:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    14dc:	8b 45 08             	mov    0x8(%ebp),%eax
    14df:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    14e3:	66 89 0a             	mov    %cx,(%edx)
    14e6:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    14ea:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    14ed:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    14f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14f4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14f7:	7e ba                	jle    14b3 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    14f9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    14fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1500:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1503:	7e a6                	jle    14ab <APDrawRect+0x1a3>
    1505:	eb 01                	jmp    1508 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1507:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1508:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    150b:	c9                   	leave  
    150c:	c3                   	ret    

0000150d <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    150d:	55                   	push   %ebp
    150e:	89 e5                	mov    %esp,%ebp
}
    1510:	90                   	nop
    1511:	5d                   	pop    %ebp
    1512:	c3                   	ret    

00001513 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1513:	55                   	push   %ebp
    1514:	89 e5                	mov    %esp,%ebp
    1516:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1519:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    151d:	0f 88 8e 01 00 00    	js     16b1 <APDcCopy+0x19e>
    1523:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1527:	0f 88 84 01 00 00    	js     16b1 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    152d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1530:	8b 45 20             	mov    0x20(%ebp),%eax
    1533:	01 d0                	add    %edx,%eax
    1535:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1538:	8b 55 10             	mov    0x10(%ebp),%edx
    153b:	8b 45 24             	mov    0x24(%ebp),%eax
    153e:	01 d0                	add    %edx,%eax
    1540:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1543:	8b 55 18             	mov    0x18(%ebp),%edx
    1546:	8b 45 20             	mov    0x20(%ebp),%eax
    1549:	01 d0                	add    %edx,%eax
    154b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    154e:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1551:	8b 45 24             	mov    0x24(%ebp),%eax
    1554:	01 d0                	add    %edx,%eax
    1556:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1559:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    155d:	0f 88 51 01 00 00    	js     16b4 <APDcCopy+0x1a1>
    1563:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1567:	0f 88 47 01 00 00    	js     16b4 <APDcCopy+0x1a1>
    156d:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1571:	0f 88 3d 01 00 00    	js     16b4 <APDcCopy+0x1a1>
    1577:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    157b:	0f 88 33 01 00 00    	js     16b4 <APDcCopy+0x1a1>
    1581:	8b 45 14             	mov    0x14(%ebp),%eax
    1584:	8b 00                	mov    (%eax),%eax
    1586:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1589:	0f 8c 25 01 00 00    	jl     16b4 <APDcCopy+0x1a1>
    158f:	8b 45 14             	mov    0x14(%ebp),%eax
    1592:	8b 40 04             	mov    0x4(%eax),%eax
    1595:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1598:	0f 8c 16 01 00 00    	jl     16b4 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    159e:	8b 45 08             	mov    0x8(%ebp),%eax
    15a1:	8b 00                	mov    (%eax),%eax
    15a3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    15a6:	7f 0b                	jg     15b3 <APDcCopy+0xa0>
    15a8:	8b 45 08             	mov    0x8(%ebp),%eax
    15ab:	8b 00                	mov    (%eax),%eax
    15ad:	83 e8 01             	sub    $0x1,%eax
    15b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    15b3:	8b 45 08             	mov    0x8(%ebp),%eax
    15b6:	8b 40 04             	mov    0x4(%eax),%eax
    15b9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    15bc:	7f 0c                	jg     15ca <APDcCopy+0xb7>
    15be:	8b 45 08             	mov    0x8(%ebp),%eax
    15c1:	8b 40 04             	mov    0x4(%eax),%eax
    15c4:	83 e8 01             	sub    $0x1,%eax
    15c7:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    15ca:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    15d1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    15d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    15df:	e9 bc 00 00 00       	jmp    16a0 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    15e4:	8b 45 08             	mov    0x8(%ebp),%eax
    15e7:	8b 00                	mov    (%eax),%eax
    15e9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    15ec:	8b 55 10             	mov    0x10(%ebp),%edx
    15ef:	01 ca                	add    %ecx,%edx
    15f1:	0f af d0             	imul   %eax,%edx
    15f4:	8b 45 0c             	mov    0xc(%ebp),%eax
    15f7:	01 d0                	add    %edx,%eax
    15f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    15fc:	8b 45 14             	mov    0x14(%ebp),%eax
    15ff:	8b 00                	mov    (%eax),%eax
    1601:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1604:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1607:	01 ca                	add    %ecx,%edx
    1609:	0f af d0             	imul   %eax,%edx
    160c:	8b 45 18             	mov    0x18(%ebp),%eax
    160f:	01 d0                	add    %edx,%eax
    1611:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1614:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    161b:	eb 74                	jmp    1691 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    161d:	8b 45 14             	mov    0x14(%ebp),%eax
    1620:	8b 50 18             	mov    0x18(%eax),%edx
    1623:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1626:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1629:	01 c8                	add    %ecx,%eax
    162b:	89 c1                	mov    %eax,%ecx
    162d:	89 c8                	mov    %ecx,%eax
    162f:	01 c0                	add    %eax,%eax
    1631:	01 c8                	add    %ecx,%eax
    1633:	01 d0                	add    %edx,%eax
    1635:	0f b7 10             	movzwl (%eax),%edx
    1638:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    163c:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1640:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1643:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1647:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    164b:	38 c2                	cmp    %al,%dl
    164d:	75 18                	jne    1667 <APDcCopy+0x154>
    164f:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1653:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1657:	38 c2                	cmp    %al,%dl
    1659:	75 0c                	jne    1667 <APDcCopy+0x154>
    165b:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    165f:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1663:	38 c2                	cmp    %al,%dl
    1665:	74 26                	je     168d <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1667:	8b 45 08             	mov    0x8(%ebp),%eax
    166a:	8b 50 18             	mov    0x18(%eax),%edx
    166d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1670:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1673:	01 c8                	add    %ecx,%eax
    1675:	89 c1                	mov    %eax,%ecx
    1677:	89 c8                	mov    %ecx,%eax
    1679:	01 c0                	add    %eax,%eax
    167b:	01 c8                	add    %ecx,%eax
    167d:	01 d0                	add    %edx,%eax
    167f:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1683:	66 89 10             	mov    %dx,(%eax)
    1686:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    168a:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    168d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1691:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1694:	2b 45 0c             	sub    0xc(%ebp),%eax
    1697:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    169a:	7d 81                	jge    161d <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    169c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    16a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a3:	2b 45 10             	sub    0x10(%ebp),%eax
    16a6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    16a9:	0f 8d 35 ff ff ff    	jge    15e4 <APDcCopy+0xd1>
    16af:	eb 04                	jmp    16b5 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    16b1:	90                   	nop
    16b2:	eb 01                	jmp    16b5 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    16b4:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    16b5:	c9                   	leave  
    16b6:	c3                   	ret    

000016b7 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    16b7:	55                   	push   %ebp
    16b8:	89 e5                	mov    %esp,%ebp
    16ba:	83 ec 1c             	sub    $0x1c,%esp
    16bd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    16c0:	8b 55 10             	mov    0x10(%ebp),%edx
    16c3:	8b 45 14             	mov    0x14(%ebp),%eax
    16c6:	88 4d ec             	mov    %cl,-0x14(%ebp)
    16c9:	88 55 e8             	mov    %dl,-0x18(%ebp)
    16cc:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    16cf:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    16d3:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    16d6:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    16da:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    16dd:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    16e1:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    16e4:	8b 45 08             	mov    0x8(%ebp),%eax
    16e7:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    16eb:	66 89 10             	mov    %dx,(%eax)
    16ee:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    16f2:	88 50 02             	mov    %dl,0x2(%eax)
}
    16f5:	8b 45 08             	mov    0x8(%ebp),%eax
    16f8:	c9                   	leave  
    16f9:	c2 04 00             	ret    $0x4

000016fc <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    16fc:	55                   	push   %ebp
    16fd:	89 e5                	mov    %esp,%ebp
    16ff:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1702:	8b 45 08             	mov    0x8(%ebp),%eax
    1705:	8b 00                	mov    (%eax),%eax
    1707:	83 ec 08             	sub    $0x8,%esp
    170a:	8d 55 0c             	lea    0xc(%ebp),%edx
    170d:	52                   	push   %edx
    170e:	50                   	push   %eax
    170f:	e8 77 ef ff ff       	call   68b <sendMessage>
    1714:	83 c4 10             	add    $0x10,%esp
}
    1717:	90                   	nop
    1718:	c9                   	leave  
    1719:	c3                   	ret    

0000171a <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    171a:	55                   	push   %ebp
    171b:	89 e5                	mov    %esp,%ebp
    171d:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1720:	83 ec 0c             	sub    $0xc,%esp
    1723:	68 98 00 00 00       	push   $0x98
    1728:	e8 38 f3 ff ff       	call   a65 <malloc>
    172d:	83 c4 10             	add    $0x10,%esp
    1730:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1733:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1737:	75 15                	jne    174e <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1739:	83 ec 04             	sub    $0x4,%esp
    173c:	ff 75 08             	pushl  0x8(%ebp)
    173f:	68 9c 25 00 00       	push   $0x259c
    1744:	6a 01                	push   $0x1
    1746:	e8 47 f0 ff ff       	call   792 <printf>
    174b:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    174e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1751:	05 84 00 00 00       	add    $0x84,%eax
    1756:	83 ec 08             	sub    $0x8,%esp
    1759:	ff 75 08             	pushl  0x8(%ebp)
    175c:	50                   	push   %eax
    175d:	e8 50 ec ff ff       	call   3b2 <strcpy>
    1762:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1765:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1768:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    176f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1772:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1779:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177c:	8b 40 3c             	mov    0x3c(%eax),%eax
    177f:	89 c2                	mov    %eax,%edx
    1781:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1784:	8b 40 40             	mov    0x40(%eax),%eax
    1787:	0f af d0             	imul   %eax,%edx
    178a:	89 d0                	mov    %edx,%eax
    178c:	01 c0                	add    %eax,%eax
    178e:	01 d0                	add    %edx,%eax
    1790:	83 ec 0c             	sub    $0xc,%esp
    1793:	50                   	push   %eax
    1794:	e8 cc f2 ff ff       	call   a65 <malloc>
    1799:	83 c4 10             	add    $0x10,%esp
    179c:	89 c2                	mov    %eax,%edx
    179e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a1:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    17a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a7:	8b 40 54             	mov    0x54(%eax),%eax
    17aa:	85 c0                	test   %eax,%eax
    17ac:	75 15                	jne    17c3 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    17ae:	83 ec 04             	sub    $0x4,%esp
    17b1:	ff 75 08             	pushl  0x8(%ebp)
    17b4:	68 bc 25 00 00       	push   $0x25bc
    17b9:	6a 01                	push   $0x1
    17bb:	e8 d2 ef ff ff       	call   792 <printf>
    17c0:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    17c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c6:	8b 40 3c             	mov    0x3c(%eax),%eax
    17c9:	89 c2                	mov    %eax,%edx
    17cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ce:	8b 40 40             	mov    0x40(%eax),%eax
    17d1:	0f af d0             	imul   %eax,%edx
    17d4:	89 d0                	mov    %edx,%eax
    17d6:	01 c0                	add    %eax,%eax
    17d8:	01 c2                	add    %eax,%edx
    17da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17dd:	8b 40 54             	mov    0x54(%eax),%eax
    17e0:	83 ec 04             	sub    $0x4,%esp
    17e3:	52                   	push   %edx
    17e4:	68 ff ff ff 00       	push   $0xffffff
    17e9:	50                   	push   %eax
    17ea:	e8 59 ec ff ff       	call   448 <memset>
    17ef:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    17f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f5:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    17fc:	e8 62 ee ff ff       	call   663 <getpid>
    1801:	89 c2                	mov    %eax,%edx
    1803:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1806:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1809:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180c:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1813:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1816:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    181d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1820:	8b 40 58             	mov    0x58(%eax),%eax
    1823:	89 c2                	mov    %eax,%edx
    1825:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1828:	8b 40 5c             	mov    0x5c(%eax),%eax
    182b:	0f af d0             	imul   %eax,%edx
    182e:	89 d0                	mov    %edx,%eax
    1830:	01 c0                	add    %eax,%eax
    1832:	01 d0                	add    %edx,%eax
    1834:	83 ec 0c             	sub    $0xc,%esp
    1837:	50                   	push   %eax
    1838:	e8 28 f2 ff ff       	call   a65 <malloc>
    183d:	83 c4 10             	add    $0x10,%esp
    1840:	89 c2                	mov    %eax,%edx
    1842:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1845:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1848:	8b 45 f4             	mov    -0xc(%ebp),%eax
    184b:	8b 40 70             	mov    0x70(%eax),%eax
    184e:	85 c0                	test   %eax,%eax
    1850:	75 15                	jne    1867 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1852:	83 ec 04             	sub    $0x4,%esp
    1855:	ff 75 08             	pushl  0x8(%ebp)
    1858:	68 e0 25 00 00       	push   $0x25e0
    185d:	6a 01                	push   $0x1
    185f:	e8 2e ef ff ff       	call   792 <printf>
    1864:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1867:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186a:	8b 40 3c             	mov    0x3c(%eax),%eax
    186d:	89 c2                	mov    %eax,%edx
    186f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1872:	8b 40 40             	mov    0x40(%eax),%eax
    1875:	0f af d0             	imul   %eax,%edx
    1878:	89 d0                	mov    %edx,%eax
    187a:	01 c0                	add    %eax,%eax
    187c:	01 c2                	add    %eax,%edx
    187e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1881:	8b 40 54             	mov    0x54(%eax),%eax
    1884:	83 ec 04             	sub    $0x4,%esp
    1887:	52                   	push   %edx
    1888:	68 ff 00 00 00       	push   $0xff
    188d:	50                   	push   %eax
    188e:	e8 b5 eb ff ff       	call   448 <memset>
    1893:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1896:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1899:	8b 55 0c             	mov    0xc(%ebp),%edx
    189c:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    189f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    18a3:	74 49                	je     18ee <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    18a5:	8b 45 10             	mov    0x10(%ebp),%eax
    18a8:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    18ae:	83 ec 0c             	sub    $0xc,%esp
    18b1:	50                   	push   %eax
    18b2:	e8 ae f1 ff ff       	call   a65 <malloc>
    18b7:	83 c4 10             	add    $0x10,%esp
    18ba:	89 c2                	mov    %eax,%edx
    18bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18bf:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    18c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c5:	8b 55 10             	mov    0x10(%ebp),%edx
    18c8:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    18cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ce:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    18d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d8:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    18df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e2:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    18e9:	e9 8d 00 00 00       	jmp    197b <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    18ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f1:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    18f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18fb:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1902:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1905:	8b 40 20             	mov    0x20(%eax),%eax
    1908:	89 c2                	mov    %eax,%edx
    190a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    190d:	8b 40 24             	mov    0x24(%eax),%eax
    1910:	0f af d0             	imul   %eax,%edx
    1913:	89 d0                	mov    %edx,%eax
    1915:	01 c0                	add    %eax,%eax
    1917:	01 d0                	add    %edx,%eax
    1919:	83 ec 0c             	sub    $0xc,%esp
    191c:	50                   	push   %eax
    191d:	e8 43 f1 ff ff       	call   a65 <malloc>
    1922:	83 c4 10             	add    $0x10,%esp
    1925:	89 c2                	mov    %eax,%edx
    1927:	8b 45 f4             	mov    -0xc(%ebp),%eax
    192a:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    192d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1930:	8b 40 38             	mov    0x38(%eax),%eax
    1933:	85 c0                	test   %eax,%eax
    1935:	75 15                	jne    194c <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1937:	83 ec 04             	sub    $0x4,%esp
    193a:	ff 75 08             	pushl  0x8(%ebp)
    193d:	68 08 26 00 00       	push   $0x2608
    1942:	6a 01                	push   $0x1
    1944:	e8 49 ee ff ff       	call   792 <printf>
    1949:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    194c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    194f:	8b 40 20             	mov    0x20(%eax),%eax
    1952:	89 c2                	mov    %eax,%edx
    1954:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1957:	8b 40 24             	mov    0x24(%eax),%eax
    195a:	0f af d0             	imul   %eax,%edx
    195d:	89 d0                	mov    %edx,%eax
    195f:	01 c0                	add    %eax,%eax
    1961:	01 c2                	add    %eax,%edx
    1963:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1966:	8b 40 38             	mov    0x38(%eax),%eax
    1969:	83 ec 04             	sub    $0x4,%esp
    196c:	52                   	push   %edx
    196d:	68 ff ff ff 00       	push   $0xffffff
    1972:	50                   	push   %eax
    1973:	e8 d0 ea ff ff       	call   448 <memset>
    1978:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    197b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    197e:	c9                   	leave  
    197f:	c3                   	ret    

00001980 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1980:	55                   	push   %ebp
    1981:	89 e5                	mov    %esp,%ebp
    1983:	57                   	push   %edi
    1984:	56                   	push   %esi
    1985:	53                   	push   %ebx
    1986:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1989:	8b 45 0c             	mov    0xc(%ebp),%eax
    198c:	83 f8 03             	cmp    $0x3,%eax
    198f:	74 02                	je     1993 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1991:	eb 7c                	jmp    1a0f <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1993:	8b 45 08             	mov    0x8(%ebp),%eax
    1996:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1999:	8b 45 08             	mov    0x8(%ebp),%eax
    199c:	8b 48 18             	mov    0x18(%eax),%ecx
    199f:	8b 45 08             	mov    0x8(%ebp),%eax
    19a2:	8b 50 5c             	mov    0x5c(%eax),%edx
    19a5:	8b 45 08             	mov    0x8(%ebp),%eax
    19a8:	8b 40 58             	mov    0x58(%eax),%eax
    19ab:	8b 75 08             	mov    0x8(%ebp),%esi
    19ae:	83 c6 58             	add    $0x58,%esi
    19b1:	83 ec 04             	sub    $0x4,%esp
    19b4:	53                   	push   %ebx
    19b5:	51                   	push   %ecx
    19b6:	6a 00                	push   $0x0
    19b8:	52                   	push   %edx
    19b9:	50                   	push   %eax
    19ba:	6a 00                	push   $0x0
    19bc:	6a 00                	push   $0x0
    19be:	56                   	push   %esi
    19bf:	6a 00                	push   $0x0
    19c1:	6a 00                	push   $0x0
    19c3:	ff 75 08             	pushl  0x8(%ebp)
    19c6:	e8 b8 ec ff ff       	call   683 <paintWindow>
    19cb:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    19ce:	8b 45 08             	mov    0x8(%ebp),%eax
    19d1:	8b 70 1c             	mov    0x1c(%eax),%esi
    19d4:	8b 45 08             	mov    0x8(%ebp),%eax
    19d7:	8b 58 18             	mov    0x18(%eax),%ebx
    19da:	8b 45 08             	mov    0x8(%ebp),%eax
    19dd:	8b 48 08             	mov    0x8(%eax),%ecx
    19e0:	8b 45 08             	mov    0x8(%ebp),%eax
    19e3:	8b 50 40             	mov    0x40(%eax),%edx
    19e6:	8b 45 08             	mov    0x8(%ebp),%eax
    19e9:	8b 40 3c             	mov    0x3c(%eax),%eax
    19ec:	8b 7d 08             	mov    0x8(%ebp),%edi
    19ef:	83 c7 3c             	add    $0x3c,%edi
    19f2:	83 ec 04             	sub    $0x4,%esp
    19f5:	56                   	push   %esi
    19f6:	53                   	push   %ebx
    19f7:	51                   	push   %ecx
    19f8:	52                   	push   %edx
    19f9:	50                   	push   %eax
    19fa:	6a 00                	push   $0x0
    19fc:	6a 00                	push   $0x0
    19fe:	57                   	push   %edi
    19ff:	6a 32                	push   $0x32
    1a01:	6a 00                	push   $0x0
    1a03:	ff 75 08             	pushl  0x8(%ebp)
    1a06:	e8 78 ec ff ff       	call   683 <paintWindow>
    1a0b:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1a0e:	90                   	nop
        default: break;
            
            
    }
    return False;
    1a0f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1a14:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a17:	5b                   	pop    %ebx
    1a18:	5e                   	pop    %esi
    1a19:	5f                   	pop    %edi
    1a1a:	5d                   	pop    %ebp
    1a1b:	c3                   	ret    

00001a1c <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1a1c:	55                   	push   %ebp
    1a1d:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a22:	8b 50 08             	mov    0x8(%eax),%edx
    1a25:	8b 45 08             	mov    0x8(%ebp),%eax
    1a28:	8b 00                	mov    (%eax),%eax
    1a2a:	39 c2                	cmp    %eax,%edx
    1a2c:	74 07                	je     1a35 <APPreJudge+0x19>
        return False;
    1a2e:	b8 00 00 00 00       	mov    $0x0,%eax
    1a33:	eb 05                	jmp    1a3a <APPreJudge+0x1e>
    return True;
    1a35:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1a3a:	5d                   	pop    %ebp
    1a3b:	c3                   	ret    

00001a3c <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1a3c:	55                   	push   %ebp
    1a3d:	89 e5                	mov    %esp,%ebp
    1a3f:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1a42:	8b 45 08             	mov    0x8(%ebp),%eax
    1a45:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a48:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1a4e:	83 ec 0c             	sub    $0xc,%esp
    1a51:	ff 75 08             	pushl  0x8(%ebp)
    1a54:	e8 42 ec ff ff       	call   69b <registWindow>
    1a59:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1a5c:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1a63:	8b 45 08             	mov    0x8(%ebp),%eax
    1a66:	8b 00                	mov    (%eax),%eax
    1a68:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1a6b:	ff 75 f4             	pushl  -0xc(%ebp)
    1a6e:	ff 75 f0             	pushl  -0x10(%ebp)
    1a71:	ff 75 ec             	pushl  -0x14(%ebp)
    1a74:	ff 75 08             	pushl  0x8(%ebp)
    1a77:	e8 80 fc ff ff       	call   16fc <APSendMessage>
    1a7c:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1a7f:	83 ec 0c             	sub    $0xc,%esp
    1a82:	ff 75 08             	pushl  0x8(%ebp)
    1a85:	e8 09 ec ff ff       	call   693 <getMessage>
    1a8a:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1a8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a90:	83 c0 74             	add    $0x74,%eax
    1a93:	83 ec 08             	sub    $0x8,%esp
    1a96:	50                   	push   %eax
    1a97:	ff 75 08             	pushl  0x8(%ebp)
    1a9a:	e8 7d ff ff ff       	call   1a1c <APPreJudge>
    1a9f:	83 c4 10             	add    $0x10,%esp
    1aa2:	84 c0                	test   %al,%al
    1aa4:	74 1b                	je     1ac1 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1aa6:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa9:	ff 70 7c             	pushl  0x7c(%eax)
    1aac:	ff 70 78             	pushl  0x78(%eax)
    1aaf:	ff 70 74             	pushl  0x74(%eax)
    1ab2:	ff 75 08             	pushl  0x8(%ebp)
    1ab5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ab8:	ff d0                	call   *%eax
    1aba:	83 c4 10             	add    $0x10,%esp
    1abd:	84 c0                	test   %al,%al
    1abf:	75 0c                	jne    1acd <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1ac1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac4:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1acb:	eb b2                	jmp    1a7f <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1acd:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1ace:	90                   	nop
    1acf:	c9                   	leave  
    1ad0:	c3                   	ret    

00001ad1 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1ad1:	55                   	push   %ebp
    1ad2:	89 e5                	mov    %esp,%ebp
    1ad4:	57                   	push   %edi
    1ad5:	56                   	push   %esi
    1ad6:	53                   	push   %ebx
    1ad7:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1ada:	a1 b8 2f 00 00       	mov    0x2fb8,%eax
    1adf:	85 c0                	test   %eax,%eax
    1ae1:	0f 85 2c 02 00 00    	jne    1d13 <APGridPaint+0x242>
    {
        iconReady = 1;
    1ae7:	c7 05 b8 2f 00 00 01 	movl   $0x1,0x2fb8
    1aee:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1af1:	8d 45 98             	lea    -0x68(%ebp),%eax
    1af4:	83 ec 08             	sub    $0x8,%esp
    1af7:	68 2f 26 00 00       	push   $0x262f
    1afc:	50                   	push   %eax
    1afd:	e8 16 f1 ff ff       	call   c18 <APLoadBitmap>
    1b02:	83 c4 0c             	add    $0xc,%esp
    1b05:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b08:	a3 dc 2f 00 00       	mov    %eax,0x2fdc
    1b0d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b10:	a3 e0 2f 00 00       	mov    %eax,0x2fe0
    1b15:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b18:	a3 e4 2f 00 00       	mov    %eax,0x2fe4
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1b1d:	83 ec 04             	sub    $0x4,%esp
    1b20:	ff 35 e4 2f 00 00    	pushl  0x2fe4
    1b26:	ff 35 e0 2f 00 00    	pushl  0x2fe0
    1b2c:	ff 35 dc 2f 00 00    	pushl  0x2fdc
    1b32:	e8 1b f3 ff ff       	call   e52 <APCreateCompatibleDCFromBitmap>
    1b37:	83 c4 10             	add    $0x10,%esp
    1b3a:	a3 e8 2f 00 00       	mov    %eax,0x2fe8
        grid_river = APLoadBitmap ("grid_river.bmp");
    1b3f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b42:	83 ec 08             	sub    $0x8,%esp
    1b45:	68 3d 26 00 00       	push   $0x263d
    1b4a:	50                   	push   %eax
    1b4b:	e8 c8 f0 ff ff       	call   c18 <APLoadBitmap>
    1b50:	83 c4 0c             	add    $0xc,%esp
    1b53:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b56:	a3 18 30 00 00       	mov    %eax,0x3018
    1b5b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b5e:	a3 1c 30 00 00       	mov    %eax,0x301c
    1b63:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b66:	a3 20 30 00 00       	mov    %eax,0x3020
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1b6b:	83 ec 04             	sub    $0x4,%esp
    1b6e:	ff 35 20 30 00 00    	pushl  0x3020
    1b74:	ff 35 1c 30 00 00    	pushl  0x301c
    1b7a:	ff 35 18 30 00 00    	pushl  0x3018
    1b80:	e8 cd f2 ff ff       	call   e52 <APCreateCompatibleDCFromBitmap>
    1b85:	83 c4 10             	add    $0x10,%esp
    1b88:	a3 08 30 00 00       	mov    %eax,0x3008
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1b8d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b90:	83 ec 08             	sub    $0x8,%esp
    1b93:	68 4c 26 00 00       	push   $0x264c
    1b98:	50                   	push   %eax
    1b99:	e8 7a f0 ff ff       	call   c18 <APLoadBitmap>
    1b9e:	83 c4 0c             	add    $0xc,%esp
    1ba1:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ba4:	a3 0c 30 00 00       	mov    %eax,0x300c
    1ba9:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bac:	a3 10 30 00 00       	mov    %eax,0x3010
    1bb1:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bb4:	a3 14 30 00 00       	mov    %eax,0x3014
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1bb9:	83 ec 04             	sub    $0x4,%esp
    1bbc:	ff 35 14 30 00 00    	pushl  0x3014
    1bc2:	ff 35 10 30 00 00    	pushl  0x3010
    1bc8:	ff 35 0c 30 00 00    	pushl  0x300c
    1bce:	e8 7f f2 ff ff       	call   e52 <APCreateCompatibleDCFromBitmap>
    1bd3:	83 c4 10             	add    $0x10,%esp
    1bd6:	a3 bc 2f 00 00       	mov    %eax,0x2fbc
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1bdb:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bde:	83 ec 08             	sub    $0x8,%esp
    1be1:	68 5b 26 00 00       	push   $0x265b
    1be6:	50                   	push   %eax
    1be7:	e8 2c f0 ff ff       	call   c18 <APLoadBitmap>
    1bec:	83 c4 0c             	add    $0xc,%esp
    1bef:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bf2:	a3 f0 2f 00 00       	mov    %eax,0x2ff0
    1bf7:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bfa:	a3 f4 2f 00 00       	mov    %eax,0x2ff4
    1bff:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c02:	a3 f8 2f 00 00       	mov    %eax,0x2ff8
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1c07:	83 ec 04             	sub    $0x4,%esp
    1c0a:	ff 35 f8 2f 00 00    	pushl  0x2ff8
    1c10:	ff 35 f4 2f 00 00    	pushl  0x2ff4
    1c16:	ff 35 f0 2f 00 00    	pushl  0x2ff0
    1c1c:	e8 31 f2 ff ff       	call   e52 <APCreateCompatibleDCFromBitmap>
    1c21:	83 c4 10             	add    $0x10,%esp
    1c24:	a3 24 30 00 00       	mov    %eax,0x3024
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1c29:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c2c:	83 ec 08             	sub    $0x8,%esp
    1c2f:	68 69 26 00 00       	push   $0x2669
    1c34:	50                   	push   %eax
    1c35:	e8 de ef ff ff       	call   c18 <APLoadBitmap>
    1c3a:	83 c4 0c             	add    $0xc,%esp
    1c3d:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c40:	a3 cc 2f 00 00       	mov    %eax,0x2fcc
    1c45:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c48:	a3 d0 2f 00 00       	mov    %eax,0x2fd0
    1c4d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c50:	a3 d4 2f 00 00       	mov    %eax,0x2fd4
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1c55:	83 ec 04             	sub    $0x4,%esp
    1c58:	ff 35 d4 2f 00 00    	pushl  0x2fd4
    1c5e:	ff 35 d0 2f 00 00    	pushl  0x2fd0
    1c64:	ff 35 cc 2f 00 00    	pushl  0x2fcc
    1c6a:	e8 e3 f1 ff ff       	call   e52 <APCreateCompatibleDCFromBitmap>
    1c6f:	83 c4 10             	add    $0x10,%esp
    1c72:	a3 ec 2f 00 00       	mov    %eax,0x2fec
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1c77:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c7a:	83 ec 08             	sub    $0x8,%esp
    1c7d:	68 79 26 00 00       	push   $0x2679
    1c82:	50                   	push   %eax
    1c83:	e8 90 ef ff ff       	call   c18 <APLoadBitmap>
    1c88:	83 c4 0c             	add    $0xc,%esp
    1c8b:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c8e:	a3 c0 2f 00 00       	mov    %eax,0x2fc0
    1c93:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c96:	a3 c4 2f 00 00       	mov    %eax,0x2fc4
    1c9b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c9e:	a3 c8 2f 00 00       	mov    %eax,0x2fc8
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1ca3:	83 ec 04             	sub    $0x4,%esp
    1ca6:	ff 35 c8 2f 00 00    	pushl  0x2fc8
    1cac:	ff 35 c4 2f 00 00    	pushl  0x2fc4
    1cb2:	ff 35 c0 2f 00 00    	pushl  0x2fc0
    1cb8:	e8 95 f1 ff ff       	call   e52 <APCreateCompatibleDCFromBitmap>
    1cbd:	83 c4 10             	add    $0x10,%esp
    1cc0:	a3 d8 2f 00 00       	mov    %eax,0x2fd8
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1cc5:	8d 45 98             	lea    -0x68(%ebp),%eax
    1cc8:	83 ec 08             	sub    $0x8,%esp
    1ccb:	68 8b 26 00 00       	push   $0x268b
    1cd0:	50                   	push   %eax
    1cd1:	e8 42 ef ff ff       	call   c18 <APLoadBitmap>
    1cd6:	83 c4 0c             	add    $0xc,%esp
    1cd9:	8b 45 98             	mov    -0x68(%ebp),%eax
    1cdc:	a3 fc 2f 00 00       	mov    %eax,0x2ffc
    1ce1:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ce4:	a3 00 30 00 00       	mov    %eax,0x3000
    1ce9:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1cec:	a3 04 30 00 00       	mov    %eax,0x3004
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1cf1:	83 ec 04             	sub    $0x4,%esp
    1cf4:	ff 35 04 30 00 00    	pushl  0x3004
    1cfa:	ff 35 00 30 00 00    	pushl  0x3000
    1d00:	ff 35 fc 2f 00 00    	pushl  0x2ffc
    1d06:	e8 47 f1 ff ff       	call   e52 <APCreateCompatibleDCFromBitmap>
    1d0b:	83 c4 10             	add    $0x10,%esp
    1d0e:	a3 28 30 00 00       	mov    %eax,0x3028
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1d13:	8b 45 08             	mov    0x8(%ebp),%eax
    1d16:	8b 40 08             	mov    0x8(%eax),%eax
    1d19:	85 c0                	test   %eax,%eax
    1d1b:	75 17                	jne    1d34 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1d1d:	83 ec 08             	sub    $0x8,%esp
    1d20:	68 9c 26 00 00       	push   $0x269c
    1d25:	6a 01                	push   $0x1
    1d27:	e8 66 ea ff ff       	call   792 <printf>
    1d2c:	83 c4 10             	add    $0x10,%esp
        return;
    1d2f:	e9 a0 04 00 00       	jmp    21d4 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1d34:	8b 45 08             	mov    0x8(%ebp),%eax
    1d37:	8b 40 10             	mov    0x10(%eax),%eax
    1d3a:	85 c0                	test   %eax,%eax
    1d3c:	7e 10                	jle    1d4e <APGridPaint+0x27d>
    1d3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d41:	8b 50 14             	mov    0x14(%eax),%edx
    1d44:	8b 45 08             	mov    0x8(%ebp),%eax
    1d47:	8b 40 10             	mov    0x10(%eax),%eax
    1d4a:	39 c2                	cmp    %eax,%edx
    1d4c:	7c 17                	jl     1d65 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1d4e:	83 ec 08             	sub    $0x8,%esp
    1d51:	68 c2 26 00 00       	push   $0x26c2
    1d56:	6a 01                	push   $0x1
    1d58:	e8 35 ea ff ff       	call   792 <printf>
    1d5d:	83 c4 10             	add    $0x10,%esp
        return;
    1d60:	e9 6f 04 00 00       	jmp    21d4 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1d65:	8b 45 08             	mov    0x8(%ebp),%eax
    1d68:	8b 40 14             	mov    0x14(%eax),%eax
    1d6b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1d71:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1d74:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1d77:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d7a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1d81:	e9 96 03 00 00       	jmp    211c <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d86:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1d8d:	e9 7c 03 00 00       	jmp    210e <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1d92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d95:	c1 e0 04             	shl    $0x4,%eax
    1d98:	89 c2                	mov    %eax,%edx
    1d9a:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1d9d:	01 c2                	add    %eax,%edx
    1d9f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1da2:	01 d0                	add    %edx,%eax
    1da4:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1da7:	8b 45 08             	mov    0x8(%ebp),%eax
    1daa:	8b 40 0c             	mov    0xc(%eax),%eax
    1dad:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1db0:	c1 e2 02             	shl    $0x2,%edx
    1db3:	01 d0                	add    %edx,%eax
    1db5:	8b 00                	mov    (%eax),%eax
    1db7:	83 f8 07             	cmp    $0x7,%eax
    1dba:	0f 87 49 03 00 00    	ja     2109 <APGridPaint+0x638>
    1dc0:	8b 04 85 d8 26 00 00 	mov    0x26d8(,%eax,4),%eax
    1dc7:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dc9:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1dcc:	6a 0c                	push   $0xc
    1dce:	6a 0c                	push   $0xc
    1dd0:	6a 0c                	push   $0xc
    1dd2:	50                   	push   %eax
    1dd3:	e8 df f8 ff ff       	call   16b7 <RGB>
    1dd8:	83 c4 0c             	add    $0xc,%esp
    1ddb:	8b 1d e8 2f 00 00    	mov    0x2fe8,%ebx
    1de1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1de4:	6b c8 32             	imul   $0x32,%eax,%ecx
    1de7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dea:	6b c0 32             	imul   $0x32,%eax,%eax
    1ded:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1df0:	8b 45 08             	mov    0x8(%ebp),%eax
    1df3:	8d 78 3c             	lea    0x3c(%eax),%edi
    1df6:	83 ec 0c             	sub    $0xc,%esp
    1df9:	83 ec 04             	sub    $0x4,%esp
    1dfc:	89 e0                	mov    %esp,%eax
    1dfe:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1e02:	66 89 30             	mov    %si,(%eax)
    1e05:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1e09:	88 50 02             	mov    %dl,0x2(%eax)
    1e0c:	6a 32                	push   $0x32
    1e0e:	6a 32                	push   $0x32
    1e10:	6a 00                	push   $0x0
    1e12:	6a 00                	push   $0x0
    1e14:	53                   	push   %ebx
    1e15:	51                   	push   %ecx
    1e16:	ff 75 94             	pushl  -0x6c(%ebp)
    1e19:	57                   	push   %edi
    1e1a:	e8 f4 f6 ff ff       	call   1513 <APDcCopy>
    1e1f:	83 c4 30             	add    $0x30,%esp
                    break;
    1e22:	e9 e3 02 00 00       	jmp    210a <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1e27:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e2a:	6a 69                	push   $0x69
    1e2c:	6a 69                	push   $0x69
    1e2e:	6a 69                	push   $0x69
    1e30:	50                   	push   %eax
    1e31:	e8 81 f8 ff ff       	call   16b7 <RGB>
    1e36:	83 c4 0c             	add    $0xc,%esp
    1e39:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e3d:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1e41:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e45:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1e48:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1e4f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e52:	6a 69                	push   $0x69
    1e54:	6a 69                	push   $0x69
    1e56:	6a 69                	push   $0x69
    1e58:	50                   	push   %eax
    1e59:	e8 59 f8 ff ff       	call   16b7 <RGB>
    1e5e:	83 c4 0c             	add    $0xc,%esp
    1e61:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e65:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1e69:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e6d:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1e70:	8b 45 08             	mov    0x8(%ebp),%eax
    1e73:	8d 50 3c             	lea    0x3c(%eax),%edx
    1e76:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e79:	ff 75 b0             	pushl  -0x50(%ebp)
    1e7c:	ff 75 ac             	pushl  -0x54(%ebp)
    1e7f:	52                   	push   %edx
    1e80:	50                   	push   %eax
    1e81:	e8 61 f0 ff ff       	call   ee7 <APSetPen>
    1e86:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1e89:	8b 45 08             	mov    0x8(%ebp),%eax
    1e8c:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1e8f:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e92:	83 ec 04             	sub    $0x4,%esp
    1e95:	83 ec 04             	sub    $0x4,%esp
    1e98:	89 e0                	mov    %esp,%eax
    1e9a:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1e9e:	66 89 08             	mov    %cx,(%eax)
    1ea1:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1ea5:	88 48 02             	mov    %cl,0x2(%eax)
    1ea8:	53                   	push   %ebx
    1ea9:	52                   	push   %edx
    1eaa:	e8 71 f0 ff ff       	call   f20 <APSetBrush>
    1eaf:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1eb2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1eb5:	6b d0 32             	imul   $0x32,%eax,%edx
    1eb8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ebb:	6b c0 32             	imul   $0x32,%eax,%eax
    1ebe:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ec1:	83 c1 3c             	add    $0x3c,%ecx
    1ec4:	83 ec 0c             	sub    $0xc,%esp
    1ec7:	6a 32                	push   $0x32
    1ec9:	6a 32                	push   $0x32
    1ecb:	52                   	push   %edx
    1ecc:	50                   	push   %eax
    1ecd:	51                   	push   %ecx
    1ece:	e8 35 f4 ff ff       	call   1308 <APDrawRect>
    1ed3:	83 c4 20             	add    $0x20,%esp
                    break;
    1ed6:	e9 2f 02 00 00       	jmp    210a <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1edb:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1ede:	6a 0c                	push   $0xc
    1ee0:	6a 0c                	push   $0xc
    1ee2:	6a 0c                	push   $0xc
    1ee4:	50                   	push   %eax
    1ee5:	e8 cd f7 ff ff       	call   16b7 <RGB>
    1eea:	83 c4 0c             	add    $0xc,%esp
    1eed:	8b 1d 28 30 00 00    	mov    0x3028,%ebx
    1ef3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ef6:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ef9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1efc:	6b c0 32             	imul   $0x32,%eax,%eax
    1eff:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f02:	8b 45 08             	mov    0x8(%ebp),%eax
    1f05:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f08:	83 ec 0c             	sub    $0xc,%esp
    1f0b:	83 ec 04             	sub    $0x4,%esp
    1f0e:	89 e0                	mov    %esp,%eax
    1f10:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1f14:	66 89 30             	mov    %si,(%eax)
    1f17:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1f1b:	88 50 02             	mov    %dl,0x2(%eax)
    1f1e:	6a 32                	push   $0x32
    1f20:	6a 32                	push   $0x32
    1f22:	6a 00                	push   $0x0
    1f24:	6a 00                	push   $0x0
    1f26:	53                   	push   %ebx
    1f27:	51                   	push   %ecx
    1f28:	ff 75 94             	pushl  -0x6c(%ebp)
    1f2b:	57                   	push   %edi
    1f2c:	e8 e2 f5 ff ff       	call   1513 <APDcCopy>
    1f31:	83 c4 30             	add    $0x30,%esp
                    break;
    1f34:	e9 d1 01 00 00       	jmp    210a <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f39:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1f3c:	6a 0c                	push   $0xc
    1f3e:	6a 0c                	push   $0xc
    1f40:	6a 0c                	push   $0xc
    1f42:	50                   	push   %eax
    1f43:	e8 6f f7 ff ff       	call   16b7 <RGB>
    1f48:	83 c4 0c             	add    $0xc,%esp
    1f4b:	8b 1d 08 30 00 00    	mov    0x3008,%ebx
    1f51:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f54:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f57:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f5a:	6b c0 32             	imul   $0x32,%eax,%eax
    1f5d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f60:	8b 45 08             	mov    0x8(%ebp),%eax
    1f63:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f66:	83 ec 0c             	sub    $0xc,%esp
    1f69:	83 ec 04             	sub    $0x4,%esp
    1f6c:	89 e0                	mov    %esp,%eax
    1f6e:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1f72:	66 89 30             	mov    %si,(%eax)
    1f75:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1f79:	88 50 02             	mov    %dl,0x2(%eax)
    1f7c:	6a 32                	push   $0x32
    1f7e:	6a 32                	push   $0x32
    1f80:	6a 00                	push   $0x0
    1f82:	6a 00                	push   $0x0
    1f84:	53                   	push   %ebx
    1f85:	51                   	push   %ecx
    1f86:	ff 75 94             	pushl  -0x6c(%ebp)
    1f89:	57                   	push   %edi
    1f8a:	e8 84 f5 ff ff       	call   1513 <APDcCopy>
    1f8f:	83 c4 30             	add    $0x30,%esp
                    break;
    1f92:	e9 73 01 00 00       	jmp    210a <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f97:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1f9a:	6a 0c                	push   $0xc
    1f9c:	6a 0c                	push   $0xc
    1f9e:	6a 0c                	push   $0xc
    1fa0:	50                   	push   %eax
    1fa1:	e8 11 f7 ff ff       	call   16b7 <RGB>
    1fa6:	83 c4 0c             	add    $0xc,%esp
    1fa9:	8b 1d ec 2f 00 00    	mov    0x2fec,%ebx
    1faf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fb2:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fb5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fb8:	6b c0 32             	imul   $0x32,%eax,%eax
    1fbb:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1fbe:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc1:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fc4:	83 ec 0c             	sub    $0xc,%esp
    1fc7:	83 ec 04             	sub    $0x4,%esp
    1fca:	89 e0                	mov    %esp,%eax
    1fcc:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1fd0:	66 89 30             	mov    %si,(%eax)
    1fd3:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1fd7:	88 50 02             	mov    %dl,0x2(%eax)
    1fda:	6a 32                	push   $0x32
    1fdc:	6a 32                	push   $0x32
    1fde:	6a 00                	push   $0x0
    1fe0:	6a 00                	push   $0x0
    1fe2:	53                   	push   %ebx
    1fe3:	51                   	push   %ecx
    1fe4:	ff 75 94             	pushl  -0x6c(%ebp)
    1fe7:	57                   	push   %edi
    1fe8:	e8 26 f5 ff ff       	call   1513 <APDcCopy>
    1fed:	83 c4 30             	add    $0x30,%esp
                    break;
    1ff0:	e9 15 01 00 00       	jmp    210a <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ff5:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1ff8:	6a 0c                	push   $0xc
    1ffa:	6a 0c                	push   $0xc
    1ffc:	6a 0c                	push   $0xc
    1ffe:	50                   	push   %eax
    1fff:	e8 b3 f6 ff ff       	call   16b7 <RGB>
    2004:	83 c4 0c             	add    $0xc,%esp
    2007:	8b 1d 24 30 00 00    	mov    0x3024,%ebx
    200d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2010:	6b c8 32             	imul   $0x32,%eax,%ecx
    2013:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2016:	6b c0 32             	imul   $0x32,%eax,%eax
    2019:	89 45 94             	mov    %eax,-0x6c(%ebp)
    201c:	8b 45 08             	mov    0x8(%ebp),%eax
    201f:	8d 78 3c             	lea    0x3c(%eax),%edi
    2022:	83 ec 0c             	sub    $0xc,%esp
    2025:	83 ec 04             	sub    $0x4,%esp
    2028:	89 e0                	mov    %esp,%eax
    202a:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    202e:	66 89 30             	mov    %si,(%eax)
    2031:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2035:	88 50 02             	mov    %dl,0x2(%eax)
    2038:	6a 32                	push   $0x32
    203a:	6a 32                	push   $0x32
    203c:	6a 00                	push   $0x0
    203e:	6a 00                	push   $0x0
    2040:	53                   	push   %ebx
    2041:	51                   	push   %ecx
    2042:	ff 75 94             	pushl  -0x6c(%ebp)
    2045:	57                   	push   %edi
    2046:	e8 c8 f4 ff ff       	call   1513 <APDcCopy>
    204b:	83 c4 30             	add    $0x30,%esp
                    break;
    204e:	e9 b7 00 00 00       	jmp    210a <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2053:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2056:	6a 0c                	push   $0xc
    2058:	6a 0c                	push   $0xc
    205a:	6a 0c                	push   $0xc
    205c:	50                   	push   %eax
    205d:	e8 55 f6 ff ff       	call   16b7 <RGB>
    2062:	83 c4 0c             	add    $0xc,%esp
    2065:	8b 1d bc 2f 00 00    	mov    0x2fbc,%ebx
    206b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    206e:	6b c8 32             	imul   $0x32,%eax,%ecx
    2071:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2074:	6b c0 32             	imul   $0x32,%eax,%eax
    2077:	89 45 94             	mov    %eax,-0x6c(%ebp)
    207a:	8b 45 08             	mov    0x8(%ebp),%eax
    207d:	8d 78 3c             	lea    0x3c(%eax),%edi
    2080:	83 ec 0c             	sub    $0xc,%esp
    2083:	83 ec 04             	sub    $0x4,%esp
    2086:	89 e0                	mov    %esp,%eax
    2088:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    208c:	66 89 30             	mov    %si,(%eax)
    208f:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2093:	88 50 02             	mov    %dl,0x2(%eax)
    2096:	6a 32                	push   $0x32
    2098:	6a 32                	push   $0x32
    209a:	6a 00                	push   $0x0
    209c:	6a 00                	push   $0x0
    209e:	53                   	push   %ebx
    209f:	51                   	push   %ecx
    20a0:	ff 75 94             	pushl  -0x6c(%ebp)
    20a3:	57                   	push   %edi
    20a4:	e8 6a f4 ff ff       	call   1513 <APDcCopy>
    20a9:	83 c4 30             	add    $0x30,%esp
                    break;
    20ac:	eb 5c                	jmp    210a <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    20ae:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    20b1:	6a 0c                	push   $0xc
    20b3:	6a 0c                	push   $0xc
    20b5:	6a 0c                	push   $0xc
    20b7:	50                   	push   %eax
    20b8:	e8 fa f5 ff ff       	call   16b7 <RGB>
    20bd:	83 c4 0c             	add    $0xc,%esp
    20c0:	8b 1d d8 2f 00 00    	mov    0x2fd8,%ebx
    20c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20c9:	6b c8 32             	imul   $0x32,%eax,%ecx
    20cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20cf:	6b c0 32             	imul   $0x32,%eax,%eax
    20d2:	89 45 94             	mov    %eax,-0x6c(%ebp)
    20d5:	8b 45 08             	mov    0x8(%ebp),%eax
    20d8:	8d 78 3c             	lea    0x3c(%eax),%edi
    20db:	83 ec 0c             	sub    $0xc,%esp
    20de:	83 ec 04             	sub    $0x4,%esp
    20e1:	89 e0                	mov    %esp,%eax
    20e3:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    20e7:	66 89 30             	mov    %si,(%eax)
    20ea:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    20ee:	88 50 02             	mov    %dl,0x2(%eax)
    20f1:	6a 32                	push   $0x32
    20f3:	6a 32                	push   $0x32
    20f5:	6a 00                	push   $0x0
    20f7:	6a 00                	push   $0x0
    20f9:	53                   	push   %ebx
    20fa:	51                   	push   %ecx
    20fb:	ff 75 94             	pushl  -0x6c(%ebp)
    20fe:	57                   	push   %edi
    20ff:	e8 0f f4 ff ff       	call   1513 <APDcCopy>
    2104:	83 c4 30             	add    $0x30,%esp
                    break;
    2107:	eb 01                	jmp    210a <APGridPaint+0x639>
                default: break;
    2109:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    210a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    210e:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2112:	0f 8e 7a fc ff ff    	jle    1d92 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2118:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    211c:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2120:	0f 8e 60 fc ff ff    	jle    1d86 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2126:	8d 45 98             	lea    -0x68(%ebp),%eax
    2129:	68 cd 00 00 00       	push   $0xcd
    212e:	6a 74                	push   $0x74
    2130:	6a 18                	push   $0x18
    2132:	50                   	push   %eax
    2133:	e8 7f f5 ff ff       	call   16b7 <RGB>
    2138:	83 c4 0c             	add    $0xc,%esp
    213b:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    213f:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    2143:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2147:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    214a:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2151:	8d 45 98             	lea    -0x68(%ebp),%eax
    2154:	68 cd 00 00 00       	push   $0xcd
    2159:	6a 74                	push   $0x74
    215b:	6a 18                	push   $0x18
    215d:	50                   	push   %eax
    215e:	e8 54 f5 ff ff       	call   16b7 <RGB>
    2163:	83 c4 0c             	add    $0xc,%esp
    2166:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    216a:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    216e:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2172:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    2175:	8b 45 08             	mov    0x8(%ebp),%eax
    2178:	8d 50 58             	lea    0x58(%eax),%edx
    217b:	8d 45 98             	lea    -0x68(%ebp),%eax
    217e:	ff 75 bc             	pushl  -0x44(%ebp)
    2181:	ff 75 b8             	pushl  -0x48(%ebp)
    2184:	52                   	push   %edx
    2185:	50                   	push   %eax
    2186:	e8 5c ed ff ff       	call   ee7 <APSetPen>
    218b:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    218e:	8b 45 08             	mov    0x8(%ebp),%eax
    2191:	8d 58 58             	lea    0x58(%eax),%ebx
    2194:	8d 55 98             	lea    -0x68(%ebp),%edx
    2197:	83 ec 04             	sub    $0x4,%esp
    219a:	83 ec 04             	sub    $0x4,%esp
    219d:	89 e0                	mov    %esp,%eax
    219f:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    21a3:	66 89 08             	mov    %cx,(%eax)
    21a6:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    21aa:	88 48 02             	mov    %cl,0x2(%eax)
    21ad:	53                   	push   %ebx
    21ae:	52                   	push   %edx
    21af:	e8 6c ed ff ff       	call   f20 <APSetBrush>
    21b4:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    21b7:	8b 45 08             	mov    0x8(%ebp),%eax
    21ba:	83 c0 58             	add    $0x58,%eax
    21bd:	83 ec 0c             	sub    $0xc,%esp
    21c0:	6a 32                	push   $0x32
    21c2:	68 20 03 00 00       	push   $0x320
    21c7:	6a 00                	push   $0x0
    21c9:	6a 00                	push   $0x0
    21cb:	50                   	push   %eax
    21cc:	e8 37 f1 ff ff       	call   1308 <APDrawRect>
    21d1:	83 c4 20             	add    $0x20,%esp
}
    21d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    21d7:	5b                   	pop    %ebx
    21d8:	5e                   	pop    %esi
    21d9:	5f                   	pop    %edi
    21da:	5d                   	pop    %ebp
    21db:	c3                   	ret    

000021dc <random>:
//

#include "APLib.h"

int random(int seed)
{
    21dc:	55                   	push   %ebp
    21dd:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    21df:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    21e3:	7e 08                	jle    21ed <random+0x11>
{
rand_num = seed;
    21e5:	8b 45 08             	mov    0x8(%ebp),%eax
    21e8:	a3 94 2f 00 00       	mov    %eax,0x2f94
}
rand_num *= 3;
    21ed:	8b 15 94 2f 00 00    	mov    0x2f94,%edx
    21f3:	89 d0                	mov    %edx,%eax
    21f5:	01 c0                	add    %eax,%eax
    21f7:	01 d0                	add    %edx,%eax
    21f9:	a3 94 2f 00 00       	mov    %eax,0x2f94
if (rand_num < 0)
    21fe:	a1 94 2f 00 00       	mov    0x2f94,%eax
    2203:	85 c0                	test   %eax,%eax
    2205:	79 0c                	jns    2213 <random+0x37>
{
rand_num *= (-1);
    2207:	a1 94 2f 00 00       	mov    0x2f94,%eax
    220c:	f7 d8                	neg    %eax
    220e:	a3 94 2f 00 00       	mov    %eax,0x2f94
}
return rand_num % 997;
    2213:	8b 0d 94 2f 00 00    	mov    0x2f94,%ecx
    2219:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    221e:	89 c8                	mov    %ecx,%eax
    2220:	f7 ea                	imul   %edx
    2222:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2225:	c1 f8 09             	sar    $0x9,%eax
    2228:	89 c2                	mov    %eax,%edx
    222a:	89 c8                	mov    %ecx,%eax
    222c:	c1 f8 1f             	sar    $0x1f,%eax
    222f:	29 c2                	sub    %eax,%edx
    2231:	89 d0                	mov    %edx,%eax
    2233:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2239:	29 c1                	sub    %eax,%ecx
    223b:	89 c8                	mov    %ecx,%eax
}
    223d:	5d                   	pop    %ebp
    223e:	c3                   	ret    

0000223f <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    223f:	55                   	push   %ebp
    2240:	89 e5                	mov    %esp,%ebp
    2242:	53                   	push   %ebx
    2243:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2246:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    224d:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2251:	74 17                	je     226a <sprintint+0x2b>
    2253:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2257:	79 11                	jns    226a <sprintint+0x2b>
        neg = 1;
    2259:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2260:	8b 45 10             	mov    0x10(%ebp),%eax
    2263:	f7 d8                	neg    %eax
    2265:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2268:	eb 06                	jmp    2270 <sprintint+0x31>
    } else {
        x = xx;
    226a:	8b 45 10             	mov    0x10(%ebp),%eax
    226d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2270:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2277:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    227a:	8d 41 01             	lea    0x1(%ecx),%eax
    227d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2280:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2283:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2286:	ba 00 00 00 00       	mov    $0x0,%edx
    228b:	f7 f3                	div    %ebx
    228d:	89 d0                	mov    %edx,%eax
    228f:	0f b6 80 98 2f 00 00 	movzbl 0x2f98(%eax),%eax
    2296:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    229a:	8b 5d 14             	mov    0x14(%ebp),%ebx
    229d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22a0:	ba 00 00 00 00       	mov    $0x0,%edx
    22a5:	f7 f3                	div    %ebx
    22a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    22aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    22ae:	75 c7                	jne    2277 <sprintint+0x38>
    if(neg)
    22b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    22b4:	74 0e                	je     22c4 <sprintint+0x85>
        buf[i++] = '-';
    22b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22b9:	8d 50 01             	lea    0x1(%eax),%edx
    22bc:	89 55 f8             	mov    %edx,-0x8(%ebp)
    22bf:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    22c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22c7:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    22ca:	eb 1b                	jmp    22e7 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    22cc:	8b 45 0c             	mov    0xc(%ebp),%eax
    22cf:	8b 00                	mov    (%eax),%eax
    22d1:	8d 48 01             	lea    0x1(%eax),%ecx
    22d4:	8b 55 0c             	mov    0xc(%ebp),%edx
    22d7:	89 0a                	mov    %ecx,(%edx)
    22d9:	89 c2                	mov    %eax,%edx
    22db:	8b 45 08             	mov    0x8(%ebp),%eax
    22de:	01 d0                	add    %edx,%eax
    22e0:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    22e3:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    22e7:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    22eb:	7f df                	jg     22cc <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    22ed:	eb 21                	jmp    2310 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    22ef:	8b 45 0c             	mov    0xc(%ebp),%eax
    22f2:	8b 00                	mov    (%eax),%eax
    22f4:	8d 48 01             	lea    0x1(%eax),%ecx
    22f7:	8b 55 0c             	mov    0xc(%ebp),%edx
    22fa:	89 0a                	mov    %ecx,(%edx)
    22fc:	89 c2                	mov    %eax,%edx
    22fe:	8b 45 08             	mov    0x8(%ebp),%eax
    2301:	01 c2                	add    %eax,%edx
    2303:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2306:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2309:	01 c8                	add    %ecx,%eax
    230b:	0f b6 00             	movzbl (%eax),%eax
    230e:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2310:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2314:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2318:	79 d5                	jns    22ef <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    231a:	90                   	nop
    231b:	83 c4 20             	add    $0x20,%esp
    231e:	5b                   	pop    %ebx
    231f:	5d                   	pop    %ebp
    2320:	c3                   	ret    

00002321 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2321:	55                   	push   %ebp
    2322:	89 e5                	mov    %esp,%ebp
    2324:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2327:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    232e:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2335:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    233c:	8d 45 0c             	lea    0xc(%ebp),%eax
    233f:	83 c0 04             	add    $0x4,%eax
    2342:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2345:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    234c:	e9 d9 01 00 00       	jmp    252a <sprintf+0x209>
        c = fmt[i] & 0xff;
    2351:	8b 55 0c             	mov    0xc(%ebp),%edx
    2354:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2357:	01 d0                	add    %edx,%eax
    2359:	0f b6 00             	movzbl (%eax),%eax
    235c:	0f be c0             	movsbl %al,%eax
    235f:	25 ff 00 00 00       	and    $0xff,%eax
    2364:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2367:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    236b:	75 2c                	jne    2399 <sprintf+0x78>
            if(c == '%'){
    236d:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2371:	75 0c                	jne    237f <sprintf+0x5e>
                state = '%';
    2373:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    237a:	e9 a7 01 00 00       	jmp    2526 <sprintf+0x205>
            } else {
                dst[j++] = c;
    237f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2382:	8d 50 01             	lea    0x1(%eax),%edx
    2385:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2388:	89 c2                	mov    %eax,%edx
    238a:	8b 45 08             	mov    0x8(%ebp),%eax
    238d:	01 d0                	add    %edx,%eax
    238f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2392:	88 10                	mov    %dl,(%eax)
    2394:	e9 8d 01 00 00       	jmp    2526 <sprintf+0x205>
            }
        } else if(state == '%'){
    2399:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    239d:	0f 85 83 01 00 00    	jne    2526 <sprintf+0x205>
            if(c == 'd'){
    23a3:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    23a7:	75 4c                	jne    23f5 <sprintf+0xd4>
                buf[bi] = '\0';
    23a9:	8d 55 ce             	lea    -0x32(%ebp),%edx
    23ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23af:	01 d0                	add    %edx,%eax
    23b1:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    23b4:	83 ec 0c             	sub    $0xc,%esp
    23b7:	8d 45 ce             	lea    -0x32(%ebp),%eax
    23ba:	50                   	push   %eax
    23bb:	e8 91 e1 ff ff       	call   551 <atoi>
    23c0:	83 c4 10             	add    $0x10,%esp
    23c3:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    23c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    23cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23d0:	8b 00                	mov    (%eax),%eax
    23d2:	83 ec 08             	sub    $0x8,%esp
    23d5:	ff 75 d8             	pushl  -0x28(%ebp)
    23d8:	6a 01                	push   $0x1
    23da:	6a 0a                	push   $0xa
    23dc:	50                   	push   %eax
    23dd:	8d 45 c8             	lea    -0x38(%ebp),%eax
    23e0:	50                   	push   %eax
    23e1:	ff 75 08             	pushl  0x8(%ebp)
    23e4:	e8 56 fe ff ff       	call   223f <sprintint>
    23e9:	83 c4 20             	add    $0x20,%esp
                ap++;
    23ec:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    23f0:	e9 2a 01 00 00       	jmp    251f <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    23f5:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    23f9:	74 06                	je     2401 <sprintf+0xe0>
    23fb:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    23ff:	75 4c                	jne    244d <sprintf+0x12c>
                buf[bi] = '\0';
    2401:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2404:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2407:	01 d0                	add    %edx,%eax
    2409:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    240c:	83 ec 0c             	sub    $0xc,%esp
    240f:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2412:	50                   	push   %eax
    2413:	e8 39 e1 ff ff       	call   551 <atoi>
    2418:	83 c4 10             	add    $0x10,%esp
    241b:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    241e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2425:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2428:	8b 00                	mov    (%eax),%eax
    242a:	83 ec 08             	sub    $0x8,%esp
    242d:	ff 75 dc             	pushl  -0x24(%ebp)
    2430:	6a 00                	push   $0x0
    2432:	6a 10                	push   $0x10
    2434:	50                   	push   %eax
    2435:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2438:	50                   	push   %eax
    2439:	ff 75 08             	pushl  0x8(%ebp)
    243c:	e8 fe fd ff ff       	call   223f <sprintint>
    2441:	83 c4 20             	add    $0x20,%esp
                ap++;
    2444:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2448:	e9 d2 00 00 00       	jmp    251f <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    244d:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2451:	75 46                	jne    2499 <sprintf+0x178>
                s = (char*)*ap;
    2453:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2456:	8b 00                	mov    (%eax),%eax
    2458:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    245b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    245f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2463:	75 25                	jne    248a <sprintf+0x169>
                    s = "(null)";
    2465:	c7 45 f4 f8 26 00 00 	movl   $0x26f8,-0xc(%ebp)
                while(*s != 0){
    246c:	eb 1c                	jmp    248a <sprintf+0x169>
                    dst[j++] = *s;
    246e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2471:	8d 50 01             	lea    0x1(%eax),%edx
    2474:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2477:	89 c2                	mov    %eax,%edx
    2479:	8b 45 08             	mov    0x8(%ebp),%eax
    247c:	01 c2                	add    %eax,%edx
    247e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2481:	0f b6 00             	movzbl (%eax),%eax
    2484:	88 02                	mov    %al,(%edx)
                    s++;
    2486:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    248a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    248d:	0f b6 00             	movzbl (%eax),%eax
    2490:	84 c0                	test   %al,%al
    2492:	75 da                	jne    246e <sprintf+0x14d>
    2494:	e9 86 00 00 00       	jmp    251f <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2499:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    249d:	75 1d                	jne    24bc <sprintf+0x19b>
                dst[j++] = *ap;
    249f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24a2:	8d 50 01             	lea    0x1(%eax),%edx
    24a5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24a8:	89 c2                	mov    %eax,%edx
    24aa:	8b 45 08             	mov    0x8(%ebp),%eax
    24ad:	01 c2                	add    %eax,%edx
    24af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24b2:	8b 00                	mov    (%eax),%eax
    24b4:	88 02                	mov    %al,(%edx)
                ap++;
    24b6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    24ba:	eb 63                	jmp    251f <sprintf+0x1fe>
            } else if(c == '%'){
    24bc:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    24c0:	75 17                	jne    24d9 <sprintf+0x1b8>
                dst[j++] = c;
    24c2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24c5:	8d 50 01             	lea    0x1(%eax),%edx
    24c8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24cb:	89 c2                	mov    %eax,%edx
    24cd:	8b 45 08             	mov    0x8(%ebp),%eax
    24d0:	01 d0                	add    %edx,%eax
    24d2:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24d5:	88 10                	mov    %dl,(%eax)
    24d7:	eb 46                	jmp    251f <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    24d9:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    24dd:	7e 18                	jle    24f7 <sprintf+0x1d6>
    24df:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    24e3:	7f 12                	jg     24f7 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    24e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24e8:	8d 50 01             	lea    0x1(%eax),%edx
    24eb:	89 55 f0             	mov    %edx,-0x10(%ebp)
    24ee:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24f1:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    24f5:	eb 2f                	jmp    2526 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    24f7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24fa:	8d 50 01             	lea    0x1(%eax),%edx
    24fd:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2500:	89 c2                	mov    %eax,%edx
    2502:	8b 45 08             	mov    0x8(%ebp),%eax
    2505:	01 d0                	add    %edx,%eax
    2507:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    250a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    250d:	8d 50 01             	lea    0x1(%eax),%edx
    2510:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2513:	89 c2                	mov    %eax,%edx
    2515:	8b 45 08             	mov    0x8(%ebp),%eax
    2518:	01 d0                	add    %edx,%eax
    251a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    251d:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    251f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2526:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    252a:	8b 55 0c             	mov    0xc(%ebp),%edx
    252d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2530:	01 d0                	add    %edx,%eax
    2532:	0f b6 00             	movzbl (%eax),%eax
    2535:	84 c0                	test   %al,%al
    2537:	0f 85 14 fe ff ff    	jne    2351 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    253d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2540:	8d 50 01             	lea    0x1(%eax),%edx
    2543:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2546:	89 c2                	mov    %eax,%edx
    2548:	8b 45 08             	mov    0x8(%ebp),%eax
    254b:	01 d0                	add    %edx,%eax
    254d:	c6 00 00             	movb   $0x0,(%eax)
}
    2550:	90                   	nop
    2551:	c9                   	leave  
    2552:	c3                   	ret    
